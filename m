Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947CF65B39E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjABOzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:55:13 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A264C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:55:12 -0800 (PST)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 302EsvxN094457;
        Mon, 2 Jan 2023 23:54:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 02 Jan 2023 23:54:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 302Erfpe094241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jan 2023 23:53:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7b10c1aa-0b3a-da0d-ea0e-b135cffc3491@I-love.SAKURA.ne.jp>
Date:   Mon, 2 Jan 2023 23:53:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH] fs/ntfs3: Use __GFP_NOWARN allocation at
 ntfs_load_attr_list()
Content-Language: en-US
To:     almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev
References: <00000000000027524405f1452ea8@google.com>
Cc:     syzbot <syzbot+89dbb3a789a5b9711793@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000027524405f1452ea8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting too large allocation at ntfs_load_attr_list() [1], for
a crafted filesystem can have huge data_size.

Link: https://syzkaller.appspot.com/bug?extid=89dbb3a789a5b9711793 [1]
Reported-by: syzbot <syzbot+89dbb3a789a5b9711793@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/ntfs3/attrlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index c0c6bcbc8c05..81c22df27c72 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -52,7 +52,7 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
-		le = kmalloc(al_aligned(lsize), GFP_NOFS);
+		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
@@ -80,7 +80,7 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		if (err < 0)
 			goto out;
 
-		le = kmalloc(al_aligned(lsize), GFP_NOFS);
+		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
-- 
2.34.1


