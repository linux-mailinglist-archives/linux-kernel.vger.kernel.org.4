Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BAA644817
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiLFPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiLFPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:34:09 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521E2AD4;
        Tue,  6 Dec 2022 07:34:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=0;PH=DS;RN=16;SR=0;TI=SMTPD_---0VWhZY-6_1670340839;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VWhZY-6_1670340839)
          by smtp.aliyun-inc.com;
          Tue, 06 Dec 2022 23:34:00 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [RFC PATCH 1/2] ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events
Date:   Tue,  6 Dec 2022 23:33:53 +0800
Message-Id: <20221206153354.92394-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two major types of uncorrected error (UC) :

- Action Required: The error is detected and the processor already consumes
  the memory. OS requires to take action (for example, offline failure
  page/kill failure thread) to recover this uncorrectable error.

- Action Optional: The error is detected out of processor execution
  context. Some data in the memory are corrupted. But the data have not
  been consumed. OS is optional to take action to recover this
  uncorrectable error.

For X86 platforms, we can easily distinguish between these two types based
on the MCA Bank. While for arm64 platform, the memory failure flags for all
UCs which severity are GHES_SEV_RECOVERABLE are set as 0, a.k.a, Action
Optional now. Set memory failure flags as MF_ACTION_REQUIRED on synchronous
events.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c |  2 +-
 include/linux/cper.h     | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9952f3a792ba..a420759fce2d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -475,7 +475,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = (gdata->flags & CPER_SEC_SYNC) ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index eacb7dd7b3af..a3571fa8a73d 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -144,6 +144,28 @@ enum {
  * corrective action before the data is consumed
  */
 #define CPER_SEC_LATENT_ERROR			0x0020
+/*
+ * If set, the section is to be associated with an error that has been
+ * propagated due to hardware poisoning. This implies the error is a symptom of
+ * another error. It is not always possible to ascertain whether this is the
+ * case for an error, therefore if the flag is not set, it is unknown whether
+ * the error was propagated. this helps determining FRU when dealing with HW
+ * failures
+ */
+#define CPER_SEC_PROPAGATED                    0x0040
+/*
+ * If set this flag indicates the firmware has detected an overflow of
+ * buffers/queues that are used to accumulate, collect, or report errors (e.g.
+ * the error status control block exposed to the OS). When this occurs, some
+ * error records may be lost.
+ */
+#define CPER_SEC_OVERFLOW                      0x0080
+/*
+ * If set, it indicates that this event record is synchronous(e.g. cpu core
+ * consumes poison data, then cause instruction/data abort); if not set,
+ * this event record is asynchronous.
+ */
+#define CPER_SEC_SYNC                          0x00100
 
 /*
  * Section type definitions, used in section_type field in struct
-- 
2.20.1.12.g72788fdb

