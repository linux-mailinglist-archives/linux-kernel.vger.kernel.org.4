Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A8A74D88C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGJOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjGJOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:07:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17425FA;
        Mon, 10 Jul 2023 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997998; x=1720533998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQEetOzC4Z2Ba5ffUz25ea7vrZ/NFCzVXTrNcSKbBBw=;
  b=bN/ezJybdl1NBm5aDj5uJ8hsFXks67MPlD4KMdamLTprbdhhsWa3oUgS
   MP+Fz/V841D1CV+MRlP03a4GitLlfwr/djmFdC+/3SHM9H0c81Gjpb22P
   qxj+j8pHH1I7yj2/bn0vC+uT0xD1+N2+X5MXBKlGd5uPunkfH0Dq/VpIT
   LMftR6BzGIyTGERrvHg7dBPnBU8l5hFG6ZEHAAnNn08DN93un8uB7YZgL
   EMoyul/+4mvpt1diDf2o6NY2s1svuEnXig+nIuSpcv3WQdvUViO+oJcl9
   3Zuwg8DC77V532excj3EiXUocwo4lTxOvPZkHyZ7vnwlIbAti4rl/JaqU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361815128"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361815128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714823062"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714823062"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:43 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 9/9] acpi: Remove acpi_hwp_native_thermal_lvt_osc()
Date:   Mon, 10 Jul 2023 17:03:37 +0300
Message-ID: <20230710140337.1434060-10-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710140337.1434060-1-michal.wilczynski@intel.com>
References: <20230710140337.1434060-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround for buggy skylake BIOS is implemented in acpi_processor_osc()
and acpi_hwp_native_thermal_lvt_osc() function is not called anywhere.
Remove it.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_processor.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 50c456dbecea..a1815155543a 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -561,7 +561,6 @@ bool __init processor_physically_present(acpi_handle handle)
 
 /* vendor specific UUID indicating an Intel platform */
 static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
-static bool acpi_hwp_native_thermal_lvt_set;
 static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
 					     void *context, void **rv)
 {
@@ -588,41 +587,6 @@ static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
-							  u32 lvl,
-							  void *context,
-							  void **rv)
-{
-	u32 capbuf[2];
-	struct acpi_osc_context osc_context = {
-		.uuid_str = sb_uuid_str,
-		.rev = 1,
-		.cap.length = 8,
-		.cap.pointer = capbuf,
-	};
-
-	if (acpi_hwp_native_thermal_lvt_set)
-		return AE_CTRL_TERMINATE;
-
-	capbuf[0] = 0x0000;
-	capbuf[1] = 0x1000; /* set bit 12 */
-
-	if (ACPI_SUCCESS(acpi_run_osc(handle, &osc_context))) {
-		if (osc_context.ret.pointer && osc_context.ret.length > 1) {
-			u32 *capbuf_ret = osc_context.ret.pointer;
-
-			if (capbuf_ret[1] & 0x1000) {
-				acpi_handle_info(handle,
-					"_OSC native thermal LVT Acked\n");
-				acpi_hwp_native_thermal_lvt_set = true;
-			}
-		}
-		kfree(osc_context.ret.pointer);
-	}
-
-	return AE_OK;
-}
-
 acpi_status __init acpi_early_processor_osc(void)
 {
 	acpi_status status;
-- 
2.41.0

