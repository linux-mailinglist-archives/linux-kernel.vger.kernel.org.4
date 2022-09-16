Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF75BA63B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 07:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIPFFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIPFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:05:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F34DF15;
        Thu, 15 Sep 2022 22:05:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VPvZJaU_1663304738;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VPvZJaU_1663304738)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 13:05:41 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [PATCH] ACPI: APEI: do not add task_work for outside context error
Date:   Fri, 16 Sep 2022 13:05:35 +0800
Message-Id: <20220916050535.26625-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error is detected as a result of user-space process accessing a
corrupt memory location, the CPU may take an abort. Then the platform
firmware reports kernel via NMI like notifications, e.g. NOTIFY_SEA,
NOTIFY_SOFTWARE_DELEGATED, etc.

For NMI like notifications, commit 7f17b4a121d0 ("ACPI: APEI: Kick the
memory_failure() queue for synchronous errors") keep track of whether
memory_failure() work was queued, and make task_work pending to flush out
the queue so that the work is processed before return to user-space.

The code use init_mm to check whether the error occurs in user space:

    if (current->mm != &init_mm)

The condition is always true, becase _nobody_ ever has "init_mm" as a real
VM any more and should generally just do

    if (current->mm)

as described in active_mm.rst documentation.

Then if an error is detected outside of the current execution context (e.g.
when detected by a background scrubber), do not add task_work as the
original patch intends to do.

Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..80ad530583c9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -985,7 +985,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 				ghes_estatus_cache_add(generic, estatus);
 		}
 
-		if (task_work_pending && current->mm != &init_mm) {
+		if (task_work_pending && current->mm) {
 			estatus_node->task_work.func = ghes_kick_task_work;
 			estatus_node->task_work_cpu = smp_processor_id();
 			ret = task_work_add(current, &estatus_node->task_work,
-- 
2.20.1.12.g72788fdb

