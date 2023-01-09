Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44466304B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbjAIT0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAIT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:26:38 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70841664;
        Mon,  9 Jan 2023 11:26:38 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id e205so8030312oif.11;
        Mon, 09 Jan 2023 11:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qlUF9HNd4rhwHYMQ5xuQk0FhH5s2r6XHjIaKh5J7pM=;
        b=Y7ZeWBzfHVQB9ojmTyJ08dCvViHssmEGq7sHa5BUc4exp4/9lJ5/rHA6gLFWUpgnsO
         o+GjusTJEivniZ0q20zzoi8f8tI/IJPDCgqtIf3lQn0pHI8dApCoAb0dd6JLIZc5BrTV
         0aRCQGW4APt80KAeoY8LikGLV0Q+32TdFt2K+F8ESdPU5nX0nNkFf1Q3mHtzUZpkSvfF
         M0xMQrA6Vz9LhHPpBIBCNxiJqbjz5AlIbP1wmnf7rFCEaZ/zMJ457vJMX9OsnJNu9Ld3
         ZYPoBsigoAqviB6OKsVAwzKaANccXjxNHcy4LfhqEJwu8IKl3Ifqma2Qui+oWgHSTEby
         P0Jg==
X-Gm-Message-State: AFqh2krmLVdtgnMe59cwMQQzmd4mvyXFbfaQ2x9l4G65RkZXAZDj8dtB
        ckVSEBxxGvWr/WJn1A0KQh+or/UV7w==
X-Google-Smtp-Source: AMrXdXs5GwdD14a9+D9T5fmo0XFg0RejaVwU/Uj/3zWCM5OroBS74qT4+WmW1Th8L5E5KwxUfeiRRg==
X-Received: by 2002:a05:6808:19a8:b0:363:1cc8:566e with SMTP id bj40-20020a05680819a800b003631cc8566emr35846673oib.3.1673292397060;
        Mon, 09 Jan 2023 11:26:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 21-20020aca2115000000b00354d8589a15sm4280594oiz.45.2023.01.09.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:26:36 -0800 (PST)
Received: (nullmailer pid 1483606 invoked by uid 1000);
        Mon, 09 Jan 2023 19:26:31 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 09 Jan 2023 13:26:17 -0600
Subject: [PATCH v4 1/8] perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220825-arm-spe-v8-7-v4-1-327f860daf28@kernel.org>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 121a8fc088f1 ("arm64/sysreg: Use feature numbering for
PMU and SPE revisions") use feature numbering instead of architecture
versions for the PMSEVFR_EL1 Res0 defines.

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Rebase on v6.2-rc1
v3:
 - No change
v2:
 - New patch
---
 arch/arm64/include/asm/sysreg.h | 6 +++---
 drivers/perf/arm_spe_pmu.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1312fb48f18b..c4ce16333750 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -273,11 +273,11 @@
 #define SYS_PMSFCR_EL1_ST_SHIFT		18
 
 #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
-#define SYS_PMSEVFR_EL1_RES0_8_2	\
+#define PMSEVFR_EL1_RES0_IMP	\
 	(GENMASK_ULL(47, 32) | GENMASK_ULL(23, 16) | GENMASK_ULL(11, 8) |\
 	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
-#define SYS_PMSEVFR_EL1_RES0_8_3	\
-	(SYS_PMSEVFR_EL1_RES0_8_2 & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
+#define PMSEVFR_EL1_RES0_V1P1	\
+	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
 #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 00e3a637f7b6..65cf93dcc8ee 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -677,11 +677,11 @@ static u64 arm_spe_pmsevfr_res0(u16 pmsver)
 {
 	switch (pmsver) {
 	case ID_AA64DFR0_EL1_PMSVer_IMP:
-		return SYS_PMSEVFR_EL1_RES0_8_2;
+		return PMSEVFR_EL1_RES0_IMP;
 	case ID_AA64DFR0_EL1_PMSVer_V1P1:
 	/* Return the highest version we support in default */
 	default:
-		return SYS_PMSEVFR_EL1_RES0_8_3;
+		return PMSEVFR_EL1_RES0_V1P1;
 	}
 }
 

-- 
2.39.0
