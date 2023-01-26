Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015F67D6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjAZUpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjAZUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:44:58 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAAC126D2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:44:57 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l17-20020a17090a409100b0022c0ba4b754so2873922pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc5TcYpRDFD/GaxSdX4EpKqW7yOnqCnFySLcXs5p0NE=;
        b=XG/5RPIOY2xbpHWiZxLnjhSxlO2Lo/RmpmNDlnnM9SEq8+RevL/W4QoiizuPnqWhfy
         zj3x8N3DHPDVKTm8sv0RNFXAYhexNhLAEJsooNK5dTdMKW+TDX6meEp79ls8tqv4VVpF
         uhN37iG6WgVhJYK9KJkmka9EKycN5ez8ZHpxgiWwMBEQOay66JmNaYFm5SG2ArlE2AuM
         FhDTr4dr5yEcNMV7Pomy1P9Y8/6IgSEr1qlrsKhqcRsxObWavTTLL7WxpSEq7FVMGuid
         bVz8p5nPA56iEgtJ8M5AQ46OwX2z9EOMCct6jR0hWAXrDHqjBeXh4UaCHD21gPMkh/0n
         HCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc5TcYpRDFD/GaxSdX4EpKqW7yOnqCnFySLcXs5p0NE=;
        b=3sT0ha5wN41wecAUjEHygm53VkzY8dLPFB/Plbha6KaLzuyU52mUqAiRarTdzs5S4X
         bLfL1ADbWzxuXNW1t/b59BkXk8d4sUmtL682APDLIoSdPlwx5lj94tnhYPvF8oO+J/Tm
         XibFKuvPEY1YemNjS0iIfQrH0PxgRhjJSxlG1z/fCGIBM62jsOl2DLD1Q8/WNgVMwqGB
         WnIzC6WCRyTF4aBqQdLKlclQbAJfUZ5VsiOHOjvuScUG1HBU6mhsKFDYe58WJaSXtNIq
         HfRIfrhXsa7L1pg3gz5RnzwLCEj2GocVDy4CJ97MFY4JxIsE0tAUHkU0rwK+KtVXYZkv
         pBdQ==
X-Gm-Message-State: AFqh2kq6C2CGdC4XEKXix4VsdMJ+AqOqVPl2vPsQ+fVQUMcomrYToUXl
        i6wj8Q9bFm2r2ugStT4nUlZB8Q7cClh6nlw=
X-Google-Smtp-Source: AMrXdXtNVs+moL/C/rg64NpGxn6FuIRzJANIZDss/dvz6sXSl/S/nyoLU+SxIFVuRzEA+DcjK28wODOWXS1A/rk=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:b111:b0:189:a50d:2a23 with SMTP
 id q17-20020a170902b11100b00189a50d2a23mr4276826plr.32.1674765897138; Thu, 26
 Jan 2023 12:44:57 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:39 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-4-zalbassam@google.com>
Subject: [PATCH 3/8] perf: pmuv3: Add common defines for the PMU version
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

The current PMU version defines are available for arm64 only,
As we want to add PMUv3 support to arm (32-bit), this patch makes
these defines available for both arm/arm64 by defining them in
the common arm_pmuv3.h header.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
---
 drivers/perf/arm_pmuv3.c       | 8 ++++----
 include/linux/perf/arm_pmuv3.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 94e4098b662d..505f0758260c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -392,7 +392,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 {
-	return (cpu_pmu->pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5);
+	return (cpu_pmu->pmuver >= ARMV8_PMU_DFR_VER_V3P5);
 }
 
 static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
@@ -1082,8 +1082,8 @@ static void __armv8pmu_probe_pmu(void *info)
 	int pmuver;
 
 	pmuver = read_pmuver();
-	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
-	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
+	if (pmuver == ARMV8_PMU_DFR_VER_IMP_DEF ||
+	    pmuver == ARMV8_PMU_DFR_VER_NI)
 		return;
 
 	cpu_pmu->pmuver = pmuver;
@@ -1109,7 +1109,7 @@ static void __armv8pmu_probe_pmu(void *info)
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* store PMMIR register for sysfs */
-	if (pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4 && (pmceid_raw[1] & BIT(31)))
+	if (pmuver >= ARMV8_PMU_DFR_VER_V3P4 && (pmceid_raw[1] & BIT(31)))
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 5bc9cd6826ea..18b29fde27fa 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -267,4 +267,10 @@
 #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
 #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
 
+/* PMU Version in DFR Register */
+#define ARMV8_PMU_DFR_VER_NI        0
+#define ARMV8_PMU_DFR_VER_V3P4      0x5
+#define ARMV8_PMU_DFR_VER_V3P5      0x6
+#define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
+
 #endif
-- 
2.39.0.246.g2a6d74b583-goog

