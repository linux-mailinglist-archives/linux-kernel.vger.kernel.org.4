Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8308E69529C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBMVDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBMVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0DB1A95E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n20-20020a25da14000000b008fa1d22bd55so9281725ybf.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QRvkNAqRlC8vCnYC5k8SmscXii8SM8zZbUiZfpD4Uw=;
        b=KfyDqKfsL7r42nRQLpzQV1GYksH821jPRFGCi1SILRO7HWEXf0tdwC5KZ31Fi8F81z
         sxwXaMIwI6H3C6aLHUNN1VLHmD+uUc/KxIIBjIgZ9Ah090um85pE0uVCRjt/gRnqqTig
         a3KO6Ttp3oRXcr5pPd5OhdbGin+XJmHxjNmkFiD5Imo3VFCVe1DgDUKx4I45JRpw7AYx
         8lO9W8vrwZesLubbD0RgXAmOVzOpapJl+PdZ4vbHCuhRzuplgcRSq7KZNMmPvjyLk4ei
         PFXmjkqNJGGaYH2OYrBRgmpm9SLqwY+S3bHZDTaRQoTo0l22blfFJypkchAFFgGZsX6y
         Oaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QRvkNAqRlC8vCnYC5k8SmscXii8SM8zZbUiZfpD4Uw=;
        b=PxuLDdWmF2vI+rgcdPAnMx3D1g4hXAv3T9xVzU0nSaE6Z0vYy7ztU9cdkZrapafKA6
         3+nKdyjeEkrXJ9TAXpRcm4x2lm5vyyj0iwkg/D98gs/kEZsrPjuLlWTmV57Z7MAJ3NV+
         z+kwgj1NdeW74u057sj1n9gHdTRVF/fhNvk4lmotpXZPvZEx2QApvK/n3sZpYeR/1/Ur
         TZfRTKxganwNbfQ/B4NL/thMyNOHqbAlDnITzu7K0/rFQ4BnP6YWKneH+u+3u+y4fKbs
         Bxa8CYN0EFEZB/13ciz8idphvmex4oSN5lHiULJipMCeqdMk+0/OtPkhrDQwvikvo0pM
         QKHw==
X-Gm-Message-State: AO0yUKXHuKDDJBV55rKjHSZjREhbGslcI4dDexf46fZD2IoIaiANOM8P
        NQSocHLbeNY0gBlhrc/B3eEqylh5tnZqrNc=
X-Google-Smtp-Source: AK7set+s5imQJVWpYZbaDe3mjO06YJ/mv+OkRk+b4v7NT+xKh0Dm62xRVXCDXKCjICJ9iumn31EeVF4lCvXb3cs=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a25:9109:0:b0:8ff:245d:da8c with SMTP id
 v9-20020a259109000000b008ff245dda8cmr16553ybl.577.1676322217499; Mon, 13 Feb
 2023 13:03:37 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:14 -0500
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230213210319.1075872-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-4-zalbassam@google.com>
Subject: [PATCH v3 3/8] perf: pmuv3: Abstract PMU version checks
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current PMU version definitions are available for arm64 only,
As we want to add PMUv3 support to arm (32-bit), abstracts
these definitions by using arch-specific helpers.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arm_pmuv3.h | 16 ++++++++++++++++
 drivers/perf/arm_pmuv3.c           |  7 +++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index c444cbfb3acd4..80cdfa4c3e88b 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -134,4 +134,20 @@ static inline u32 read_pmceid1(void)
 	return read_sysreg(pmceid1_el0);
 }
 
+static inline bool pmuv3_implemented(int pmuver)
+{
+	return !(pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
+		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
+}
+
+static inline bool is_pmuv3p4(int pmuver)
+{
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
+}
+
+static inline bool is_pmuv3p5(int pmuver)
+{
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5;
+}
+
 #endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 94e4098b662d3..46e89e92f8236 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -392,7 +392,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 {
-	return (cpu_pmu->pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5);
+	return (is_pmuv3p5(cpu_pmu->pmuver));
 }
 
 static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
@@ -1082,8 +1082,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	int pmuver;
 
 	pmuver = read_pmuver();
-	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
-	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
+	if (!pmuv3_implemented(pmuver))
 		return;
 
 	cpu_pmu->pmuver = pmuver;
@@ -1109,7 +1108,7 @@ static void __armv8pmu_probe_pmu(void *info)
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* store PMMIR register for sysfs */
-	if (pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4 && (pmceid_raw[1] & BIT(31)))
+	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
-- 
2.39.1.581.gbfd45094c4-goog

