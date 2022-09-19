Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7D5BD1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiISQJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiISQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E320BCD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 641C861E2F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697DDC433C1;
        Mon, 19 Sep 2022 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603792;
        bh=POIMB+nqoM7z7wupteJgqXF+8ITOYlsp/bsRlVVYuVI=;
        h=From:To:Cc:Subject:Date:From;
        b=F92kR416Aq5i7xs/x7oEk1BKSkpRvMUXi19Hog7EuZ5v9iQkF1DenQ12mc3cV9RhX
         l5epIGTajkrKEjQTfn4HkdBAddA30H2e/5uHjSroEFq5lux+vtQam01N09hsHukSqn
         JIbQ3Dgexwj/9KhKPxge8M6oRNKHm5tU10tr6WZdJDG379lh5sFV3xVI0yVDQFmgtE
         WDf22ihoPamuqcsBDpJ0G9HxNmbXz0d8JCsKkW416I27QrxD8c2cw3ehW6KeedadXO
         uUCk8EAbJbMX+0OjU3KHggE3qCYcZU4NQFXtPXCFdhujw4woNd5PiHxYTn87FeJjJo
         HitUD6No1TsrQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] arm64/sysreg: Fix a few missed conversions
Date:   Mon, 19 Sep 2022 09:09:28 -0700
Message-Id: <20220919160928.3905780-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the conversion to automatically generating the ID_AA64DFR0_EL1
definition names, the build fails in a few different places because some
of the definitions were not changed to their new names along the way.
Update the names to resolve the build errors.

Fixes: c0357a73fa4a ("arm64/sysreg: Align field names in ID_AA64DFR0_EL1 with architecture")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
 drivers/hwtracing/coresight/coresight-trbe.h       | 3 ++-
 drivers/perf/arm_spe_pmu.c                         | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d39660a3e50c..80fefaba58ee 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -966,7 +966,7 @@ static inline bool cpu_supports_sysreg_trace(void)
 {
 	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
 
-	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
+	return ((dfr0 >> ID_AA64DFR0_EL1_TraceVer_SHIFT) & 0xfUL) > 0;
 }
 
 static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
@@ -1054,7 +1054,7 @@ static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
 	u64 trfcr;
 
 	drvdata->trfcr = 0;
-	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
+	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT))
 		return;
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 30e4d7db4f8e..98ff1b17ad07 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -20,7 +20,8 @@
 static inline bool is_trbe_available(void)
 {
 	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
-	unsigned int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_TRBE_SHIFT);
+	unsigned int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0,
+								 ID_AA64DFR0_EL1_TraceBuffer_SHIFT);
 
 	return trbe >= 0b0001;
 }
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b65a7d9640e1..6ce05ef4844d 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -674,9 +674,9 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 static u64 arm_spe_pmsevfr_res0(u16 pmsver)
 {
 	switch (pmsver) {
-	case ID_AA64DFR0_PMSVER_8_2:
+	case ID_AA64DFR0_EL1_PMSVer_IMP:
 		return SYS_PMSEVFR_EL1_RES0_8_2;
-	case ID_AA64DFR0_PMSVER_8_3:
+	case ID_AA64DFR0_EL1_PMSVer_V1P1:
 	/* Return the highest version we support in default */
 	default:
 		return SYS_PMSEVFR_EL1_RES0_8_3;
@@ -958,7 +958,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	struct device *dev = &spe_pmu->pdev->dev;
 
 	fld = cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64DFR0_EL1),
-						   ID_AA64DFR0_PMSVER_SHIFT);
+						   ID_AA64DFR0_EL1_PMSVer_SHIFT);
 	if (!fld) {
 		dev_err(dev,
 			"unsupported ID_AA64DFR0_EL1.PMSVer [%d] on CPU %d\n",

base-commit: 10453bf149c9539c446574932f00ea50438cede5
-- 
2.37.3

