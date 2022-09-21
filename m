Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7015BF4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiIUD3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIUD2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:28:10 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C37EFE2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:28:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VQM6ATB_1663730881;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VQM6ATB_1663730881)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 11:28:03 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de, axboe@kernel.dk,
        peterz@infradead.org, arnd@arndb.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] mm/khugepaged: Improve awareness for exiting processes
Date:   Wed, 21 Sep 2022 11:27:59 +0800
Message-Id: <20220921032759.41473-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In khugepaged, the khugepaged_test_exit() always be called
after mmap_read_lock(mm), and the scanning for mm would be
stopped when mm_users is 0. That indicates the handling
process is exiting. But it's not enough or timely to check
the exiting process only by mm_users (mmput() called after
mmap_read_unlock()).

The patch mainly to improve awareness for the exiting process.
And in addition, this patch seems be helpful for the purpose
of debugging, e.g. avoiding owner is NULL if we want to get
the handling task name.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 kernel/exit.c   | 2 ++
 mm/khugepaged.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 84021b24f79e..5668bb9971d9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -505,6 +505,8 @@ static void exit_mm(void)
 	enter_lazy_tlb(mm, current);
 	local_irq_enable();
 	task_unlock(current);
+	if (atomic_read(&mm->mm_users) <= 1)
+		WRITE_ONCE(mm->owner, NULL); /* Update before mmap_unlock */
 	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
 	mmput(mm);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 01f71786d530..8a0f97e5efc0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -427,7 +427,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
 
 static inline int khugepaged_test_exit(struct mm_struct *mm)
 {
-	return atomic_read(&mm->mm_users) == 0;
+	return atomic_read(&mm->mm_users) == 0 || !READ_ONCE(mm->owner);
 }
 
 void __khugepaged_enter(struct mm_struct *mm)
-- 
2.27.0

