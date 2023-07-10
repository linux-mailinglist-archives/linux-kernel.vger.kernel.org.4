Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B541774D881
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGJOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjGJOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB73106;
        Mon, 10 Jul 2023 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997968; x=1720533968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zvF0j2M9B1BUhzbABbr+1jFZh1ePQjGp/ib8cl72g98=;
  b=ZOO1F8VWojMmehBRG6vu5AQqQbN1wugh+tt/Z9z94JGo/9bHbdC8YLRe
   lFEWllmEuf5C6kpYHe1ufJv0pexdhDVdhsY9NjYE/m307SalYesUwIrR8
   irEqtPgegS/c3Dc4ZXdev3YgTQmp8INUMBHg5TUo1Kg9cfJFallf5Kian
   oZgs6jWw1Ne7JzeLjP1/UHlfzYH3LwVeeD3OWDZeFotxvl+wbVo31SViv
   xCNtfqmnuDHs9jPx0++IpAuApVM2NBGxYvsghlVsIQiyfEmuWbbB/wYUs
   0uS57s7d4EQAwz5Y83cQsC4XAfjMiYMcje+gG5PKCaQA0C8w+jExWYULZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361814918"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361814918"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822784"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822784"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:18 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/9] acpi: Refactor arch_acpi_set_pdc_bits()
Date:   Mon, 10 Jul 2023 17:03:31 +0300
Message-ID: <20230710140337.1434060-4-michal.wilczynski@intel.com>
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

Capabilities buffer modified by the arch_acpi_set_pdc_bits() is not
_PDC specific, as it is used by _OSC method as well. Change function
name to better reflect it's independence from _PDC. Change function
expected argument to pass capability buffer directly without any
offset, as the offset differ among _OSC and _PDC methods.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/ia64/include/asm/acpi.h |  4 ++--
 arch/x86/include/asm/acpi.h  | 10 +++++-----
 drivers/acpi/processor_pdc.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 87927eb824cc..43797cb44383 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -69,9 +69,9 @@ extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
 static inline bool arch_has_acpi_pdc(void) { return true; }
-static inline void arch_acpi_set_pdc_bits(u32 *buf)
+static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 {
-	buf[2] |= ACPI_PDC_EST_CAPABILITY_SMP;
+	*cap |= ACPI_PDC_EST_CAPABILITY_SMP;
 }
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 8eb74cf386db..6a498d1781e7 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -100,23 +100,23 @@ static inline bool arch_has_acpi_pdc(void)
 		c->x86_vendor == X86_VENDOR_CENTAUR);
 }
 
-static inline void arch_acpi_set_pdc_bits(u32 *buf)
+static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-	buf[2] |= ACPI_PDC_C_CAPABILITY_SMP;
+	*cap |= ACPI_PDC_C_CAPABILITY_SMP;
 
 	if (cpu_has(c, X86_FEATURE_EST))
-		buf[2] |= ACPI_PDC_EST_CAPABILITY_SWSMP;
+		*cap |= ACPI_PDC_EST_CAPABILITY_SWSMP;
 
 	if (cpu_has(c, X86_FEATURE_ACPI))
-		buf[2] |= ACPI_PDC_T_FFH;
+		*cap |= ACPI_PDC_T_FFH;
 
 	/*
 	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
 	 */
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
+		*cap &= ~(ACPI_PDC_C_C2C3_FFH);
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 6d2d521a068d..b2c6f17fc87c 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -24,7 +24,7 @@ static void acpi_set_pdc_bits(u32 *buf)
 	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
 
 	/* Twiddle arch-specific bits needed for _PDC */
-	arch_acpi_set_pdc_bits(buf);
+	arch_acpi_set_proc_cap_bits(&buf[2]);
 }
 
 static struct acpi_object_list *acpi_processor_alloc_pdc(void)
-- 
2.41.0

