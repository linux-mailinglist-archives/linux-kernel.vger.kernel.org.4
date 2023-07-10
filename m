Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3D74D884
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjGJOGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGJOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D72FA;
        Mon, 10 Jul 2023 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997982; x=1720533982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57Gu8G5CpvTuhK8fKzNWXi+IqIyEa64a/3l1784yYc0=;
  b=TRzw2F6FHQnrkj1YouO9vyirg8mXTVQXfuCoFrbaSMzErdCbWGMdKkol
   F64ljfFl6DafIv41fkM9OV4SEe1hs6bByJuGCh7eU+v2sx1Dgzoz2nwv3
   aZHmAzkZTe6w8st+5i6WoMuRp3sdDaNaNKk2FGICHRPe2ZtanV30k2Ity
   U5QS3LpDudgfiqeNLrGcYa3aVQtKDLYBjIsA4/MlwtuekWQlqDJUmTsLY
   FuLlPNiq2YEf3lRjE/TFJkVXexaMOGGSBQjbYEsLW8PelrAj1VRpU01GG
   1rvgHtevM8Iw23PWjis3xKfA5mF0a9TcwfU3BYN4Xd1uIX4/bSXS1Zc/1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361815018"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361815018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822935"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822935"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:30 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 6/9] acpi: Move setting CAP_SMP_T_SWCOORD to arch_acpi_set_proc_cap_bits()
Date:   Mon, 10 Jul 2023 17:03:34 +0300
Message-ID: <20230710140337.1434060-7-michal.wilczynski@intel.com>
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

Currently ACPI_PROC_CAP_SMP_T_SWCOORD is set in acpi_set_pdc_bits().
This doesn't make any sense, as it isn't _PDC specific. It should be
moved to arch code for coherency.

Move setting of ACPI_PROC_CAP_SMP_T_SWCOORD to
arch_acpi_set_proc_cap_bits().

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 arch/x86/include/asm/acpi.h  | 3 +++
 drivers/acpi/processor_pdc.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index d615238bcd78..6f6752a2ea36 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -106,6 +106,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 
 	*cap |= ACPI_PROC_CAP_C_CAPABILITY_SMP;
 
+	/* Enable coordination with firmware's _TSD info */
+	*cap |= ACPI_PROC_CAP_SMP_T_SWCOORD;
+
 	if (cpu_has(c, X86_FEATURE_EST))
 		*cap |= ACPI_PROC_CAP_EST_CAPABILITY_SWSMP;
 
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index b4b906b70a0b..116b5abb60b3 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -20,9 +20,6 @@ static void acpi_set_pdc_bits(u32 *buf)
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
 
-	/* Enable coordination with firmware's _TSD info */
-	buf[2] = ACPI_PROC_CAP_SMP_T_SWCOORD;
-
 	/* Twiddle arch-specific bits needed for _PDC */
 	arch_acpi_set_proc_cap_bits(&buf[2]);
 }
-- 
2.41.0

