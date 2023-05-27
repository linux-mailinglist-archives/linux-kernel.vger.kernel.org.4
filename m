Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB171342B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjE0LEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjE0LEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:04:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32882D3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:04:36 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34RB4HO3022407;
        Sat, 27 May 2023 20:04:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sat, 27 May 2023 20:04:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34RB4DsP022399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 27 May 2023 20:04:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5fa8dfeb-8eb6-0de0-a335-e0b4336c29e0@I-love.SAKURA.ne.jp>
Date:   Sat, 27 May 2023 20:04:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] ref_tracker: add stack_depot_save() failure handling to
 ref_tracker_alloc()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stack_depot_save() cannot accept __GFP_NOFAIL flag because
__stack_depot_save() drops gfp flags which are not in
GFP_KERNEL | GFP_ATOMIC | __GFP_NOWARN. Also, changing
__stack_depot_save() to accept __GFP_NOFAIL is not possible
because rmqueue() does not want __GFP_NOFAIL flag for
order == DEPOT_POOL_ORDER allocation request.

Therefore, assume that stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) from
ref_tracker_alloc() can silently fail, and emit "unreliable refcount
tracker." message.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 lib/ref_tracker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index dc7b14aa3431..ad48ff19adb2 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -84,12 +84,18 @@ int ref_tracker_alloc(struct ref_tracker_dir *dir,
 		gfp_mask |= __GFP_NOFAIL;
 	*trackerp = tracker = kzalloc(sizeof(*tracker), gfp_mask);
 	if (unlikely(!tracker)) {
+nomem:
 		pr_err_once("memory allocation failure, unreliable refcount tracker.\n");
 		refcount_inc(&dir->untracked);
 		return -ENOMEM;
 	}
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
 	tracker->alloc_stack_handle = stack_depot_save(entries, nr_entries, gfp);
+	if (!tracker->alloc_stack_handle) {
+		*trackerp = NULL;
+		kfree(tracker);
+		goto nomem;
+	}
 
 	spin_lock_irqsave(&dir->lock, flags);
 	list_add(&tracker->head, &dir->list);
-- 
2.18.4

