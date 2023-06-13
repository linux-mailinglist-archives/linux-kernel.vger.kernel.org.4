Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64772E7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbjFMQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbjFMQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:12:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA9192;
        Tue, 13 Jun 2023 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672763; x=1718208763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTecCM+k9j5k4i5fadJJCcv3OfhWVg6cMETfD49tMUg=;
  b=NX3NEwOb/4+LeuIDecrMHHDggW1BHm63satLgoNMExKWLT48Mfyn/me2
   K6K29jw+YPxqU+V81E2AUbvc3YSCFiNuZya2Ss1GtaZqhlJl/qAanzCHp
   PtY5LSDXUOjnlujg44nwLGXqFMNqn3FBfABP6XR3mMA7X2cvksCDY6YFp
   zxa5pr/v3BKVuQcTmdmSlz+vv2cvStbuLVAlmBqEaAxL+gPftPDEklVDW
   QdaDxyqFMUfygMV6OM+++YqBle5+RHkRRi9tazB050/0j1tnN2Sx+KhT5
   s+pxLIpIcvN/mfro3ou0tB3ogeay4kSz58QBxP53dSmwJzZr81ZdywEI5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348038818"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348038818"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714863531"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714863531"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 09:10:57 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 2/5] acpi: Refactor arch_acpi_set_pdc_bits()
Date:   Tue, 13 Jun 2023 19:10:31 +0300
Message-Id: <20230613161034.3496047-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613161034.3496047-1-michal.wilczynski@intel.com>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capabilities buffer modified by the arch_acpi_set_pdc_bits() is not
_PDC specific, as it is used by _OSC method as well. Change function
name to better reflect it's independence from PDC. Change function
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
index 5596862e6fea..ce3acd86dd12 100644
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

