Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAEF605033
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJSTMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJSTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:11:37 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB11C2F20;
        Wed, 19 Oct 2022 12:11:34 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so10070618otu.1;
        Wed, 19 Oct 2022 12:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxlkIVs552Ejp+aX9wrJgo7YCeTd9sG0ZHnn6ZfglP4=;
        b=uWT3wBwWtuLmr4ZFpImtSCFfr1YxpJey1dB3KFW3NOUuly34N42oSSmh1I7UNcCj39
         laiWiBt2t4prnwhmhwAdEXkq9LgQKviX/1lNX0II98mBkFzE1r8zkHQjRhxGv/l5S+QZ
         UXcEdFaftsd7nrN+n+cpo4PTlmYPHPJQXNQ8TbuCWWvs5+RAmmPHf1eXn9xyt5vAgBAF
         EFc6jpOYJlTyHZyIf9ajHMqQJDYtTKE8sKH4ZrntllecgkKe7YfkiDv3pqESVMIAGF6Q
         gYAeWH4b8vADJ+eHTcc+Kj8zMZ4w100p5PgwF+8nCpsWi8Ln0Bo8fsgAw4AOzbtewADb
         XQBQ==
X-Gm-Message-State: ACrzQf2qyPswqBV2SuoZzSHKNcUSTO5KiNRdWAkw53/Dc/MB8+fmc5h0
        AXLjna2eRJcckxBAqK4SFQ==
X-Google-Smtp-Source: AMsMyM4c6mVzFUrkq81v9/CA7Mnv6GIXWQ7zeNYDSSDTWnk1r6iqqax4wHful0HevpS2dD/tJHkWSg==
X-Received: by 2002:a05:6830:25c3:b0:661:c7e4:e785 with SMTP id d3-20020a05683025c300b00661c7e4e785mr4817162otu.134.1666206692965;
        Wed, 19 Oct 2022 12:11:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a4ae611000000b00480b7efd5d9sm5922591oot.6.2022.10.19.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:11:32 -0700 (PDT)
Received: (nullmailer pid 3420898 invoked by uid 1000);
        Wed, 19 Oct 2022 19:11:25 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Oct 2022 14:11:24 -0500
Subject: [PATCH v2 1/7] perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v2-1-e37322d68ac0@kernel.org>
References: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 121a8fc088f1 ("arm64/sysreg: Use feature numbering for
PMU and SPE revisions") use feature numbering instead of architecture
versions for the PMSEVFR_EL1 Res0 defines.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - New patch
---
 arch/arm64/include/asm/sysreg.h | 6 +++---
 drivers/perf/arm_spe_pmu.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7d301700d1a9..9a4cf12e3e16 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -294,11 +294,11 @@
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
b4 0.11.0-dev
