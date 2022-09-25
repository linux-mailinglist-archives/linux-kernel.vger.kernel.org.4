Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5305E9317
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIYM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIYM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:29:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE0D5F42
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:29:35 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28PCTXIL012665;
        Sun, 25 Sep 2022 21:29:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sun, 25 Sep 2022 21:29:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28PCTWSJ012662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Sep 2022 21:29:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp>
Date:   Sun, 25 Sep 2022 21:29:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: [PATCH] kernfs: fix UAF race condition in __kernfs_remove()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
References: <000000000000646c9605e714ec6e@google.com>
Cc:     syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000646c9605e714ec6e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting use-after-free read at __kernfs_remove() [1], for
commit 35beab0635f3cdd4 ("kernfs: restructure removal path to fix possible
premature return") missed that we need to keep a ref on "kn" as well as
"pos".

This race condition happens when two concurrent removers "T1" and "T2"
interfere due to kernfs_drain() temporarily dropping kernfs_rwsem.

  T1:                     T2:
  down_write(&root->kernfs_rwsem);
  do {
    pos = kernfs_leftmost_descendant(kn);
    kernfs_get(pos);
    kernfs_drain(pos) {
      up_write(&root->kernfs_rwsem);
                          down_write(&root->kernfs_rwsem);
                          do {
                            // Removes all children and "kn", but won't
                            // free T1's "pos" and "kn", for T1 has a ref
                            // on T1's "pos", and T1's "pos" in turn keeps
                            // a ref on "kn".
                            pos = kernfs_leftmost_descendant(kn);
                            kernfs_put(pos);
                          } while (pos != kn) // Will break.
                          up_write(&root->kernfs_rwsem);
      down_write(&root->kernfs_rwsem);
    }
    // Frees "pos" because this was the last ref, and also frees "kn"
    // because a ref by "pos" was gone (i.e. "kn" no longer has ref)
    // via "goto repeat;" inside kernfs_put().
    kernfs_put(pos);
  } while (pos != kn) // Will continue, despite "kn" already freed.

Link: https://syzkaller.appspot.com/bug?extid=8bee3285b9e190f1509e [1]
Reported-by: syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com
Fixes: 35beab0635f3cdd4 ("kernfs: restructure removal path to fix possible premature return")
Tested-by: syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com
Co-developed-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/kernfs/dir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1cc88ba6de90..effb461d34fa 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1365,6 +1365,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 
 	/* deactivate and unlink the subtree node-by-node */
+	/*
+	 * kernfs_put(pos) will invoke kernfs_put(kn) if @pos was the last
+	 * reference to @kn. Make sure @kn doesn't go away underneath us.
+	 */
+	kernfs_get(kn);
 	do {
 		pos = kernfs_leftmost_descendant(kn);
 
@@ -1406,6 +1411,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 		kernfs_put(pos);
 	} while (pos != kn);
+	kernfs_put(kn);
 }
 
 /**
-- 
2.34.1

