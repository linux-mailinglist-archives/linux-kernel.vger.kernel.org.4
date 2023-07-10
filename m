Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82974D883
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjGJOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjGJOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B5115;
        Mon, 10 Jul 2023 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997979; x=1720533979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YmkdVAkZMP9+AjEtNPW0xLo8oLdEWPzve3ONnUqtVNA=;
  b=DeLfxvEbqgPfon9vjjyYnLQpOkbsqieaTKtolKVWJZELhnbFI6tD9mIT
   1aZSsHLEecQvutpLxTQkipSrb/UAjQWuwLb+1QI7LB8MxW3E3+WOQ3BY1
   TLmS/nFXO8eUe2Du0ZrL3jTOoEPqD4oTfZCeWgvrdTAf57+zm7Y+Di7wR
   H8fHFAeRM42USXbZd6f7z2zlRmtfqqng2jVIyxxzgsVAP3eA9gcVRmryZ
   +08uwk7UbHiOcowApl6E4B9gRA6dpKv1f5cAlYUh92aFUq60rTUYLLuuC
   Pw/vBQJQl1p2M76g3JlRd1EZvQhPiNEG2aFU+NltzFsDAD33aa6CY672u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361814985"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361814985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822899"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822899"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:26 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 5/9] acpi: Clear C_C2C3_FFH and C_C1_FFH in arch_acpi_set_proc_cap_bits()
Date:   Mon, 10 Jul 2023 17:03:33 +0300
Message-ID: <20230710140337.1434060-6-michal.wilczynski@intel.com>
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

Currently arch_acpi_set_proc_cap_bits() clears ACPI_PDC_C_C2C3_FFH bit in
case MWAIT instruction is not supported. It should also clear
ACPI_PDC_C_C1_FFH, as when MWAIT is not supported C1 is accomplished
with HALT instruction. Quote from documentation describing C_C1_FFH:
"If set, OSPM is capable of performing native C State instructions (beyond
halt) for the C1 handler in multi-processor configurations". As without
MWAIT there is no native C-state instructions beyond HALT, this bit
should be toggled off.

Clear ACPI_PDC_C_C1_FFH and ACPI_PDC_C_C2C3_FFH in
arch_acpi_set_proc_cap_bits() in case MWAIT is not supported or overridden.
Remove setting those bits in processor_pdc.c code.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 arch/x86/include/asm/acpi.h  |  9 +++++----
 drivers/acpi/processor_pdc.c | 14 --------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index ce5ad6a496e6..d615238bcd78 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -113,11 +113,12 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 		*cap |= ACPI_PROC_CAP_T_FFH;
 
 	/*
-	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
+	 * If mwait/monitor is unsupported, C_C1_FFH and
+	 * C2/C3_FFH will be disabled.
 	 */
-	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		*cap &= ~(ACPI_PROC_CAP_C_C2C3_FFH);
-
+	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
+	    boot_option_idle_override == IDLE_NOMWAIT)
+		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 77d3fe73047c..b4b906b70a0b 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -74,20 +74,6 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
 
-	if (boot_option_idle_override == IDLE_NOMWAIT) {
-		/*
-		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
-		 * mode will be disabled in the parameter of _PDC object.
-		 * Of course C1_FFH access mode will also be disabled.
-		 */
-		union acpi_object *obj;
-		u32 *buffer = NULL;
-
-		obj = pdc_in->pointer;
-		buffer = (u32 *)(obj->buffer.pointer);
-		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
-
-	}
 	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
-- 
2.41.0

