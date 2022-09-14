Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859085B81A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiINGt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:49:55 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BFB240AB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:49:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPm6Tzt_1663138188;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VPm6Tzt_1663138188)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 14:49:50 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [PATCH] mm,hwpoison: check mm when killing accessing process
Date:   Wed, 14 Sep 2022 14:49:35 +0800
Message-Id: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GHES code calls memory_failure_queue() from IRQ context to queue work
into workqueue and schedule it on the current CPU. Then the work is
processed in memory_failure_work_func() by kworker and calls
memory_failure().

When a page is already poisoned, commit a3f5d80ea401 ("mm,hwpoison: send
SIGBUS with error virutal address") make memory_failure() call
kill_accessing_process() that:

    - holds mmap locking of current->mm
    - does pagetable walk to find the error virtual address
    - and sends SIGBUS to the current process with error info.

However, the mm of kworker is not valid. Therefore, check mm when killing
accessing process.

Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 mm/memory-failure.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14439806b5ef..7553917ce820 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -743,6 +743,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	};
 	priv.tk.tsk = p;
 
+	if (!p->mm)
+		return -EFAULT;
+
 	mmap_read_lock(p->mm);
 	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
 			      (void *)&priv);
@@ -751,6 +754,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	else
 		ret = 0;
 	mmap_read_unlock(p->mm);
+
 	return ret > 0 ? -EHWPOISON : -EFAULT;
 }
 
-- 
2.20.1.12.g72788fdb

