Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26E642C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiLEPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiLEPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C2A1B9;
        Mon,  5 Dec 2022 07:43:33 -0800 (PST)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQnqk5ZDrzRpmX;
        Mon,  5 Dec 2022 23:42:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 23:43:30 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
        <robert.moore@intel.com>, <bp@alien8.de>, <devel@acpica.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <lvying6@huawei.com>, <naoya.horiguchi@nec.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 4/4] arm64: ghes: pass MF_ACTION_REQUIRED to memory_failure when sea
Date:   Tue, 6 Dec 2022 00:00:43 +0800
Message-ID: <20221205160043.57465-5-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221205160043.57465-1-xiexiuqi@huawei.com>
References: <20221205160043.57465-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For synchronous external data abort case, pass MF_ACTION_REQUIRED to
memory_failure, ensure that error recovery is performed before
return to the user space.

Synchronous external data abort happened in current execution context,
so as the description for 'action required', MF_ACTION_REQUIRED flag
is needed.

  ``action optional'' if they are not immediately affected by the error
  ``action required'' if error happened in current execution context

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/acpi/apei/ghes.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ddc4da603215..043a91a7dd17 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -463,7 +463,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, int notify_type)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -472,6 +472,9 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return false;
 
+	if (notify_type == ACPI_HEST_NOTIFY_SEA)
+		flags |= MF_ACTION_REQUIRED;
+
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
@@ -513,7 +516,12 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			int flags = 0;
+
+			if (notify_type == ACPI_HEST_NOTIFY_SEA)
+				flags |= MF_ACTION_REQUIRED;
+
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -657,7 +665,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			queued = ghes_handle_memory_failure(gdata, sev, notify_type);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-- 
2.20.1

