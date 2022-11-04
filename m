Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC69619C40
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiKDPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKDPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:55:24 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D82FFD2;
        Fri,  4 Nov 2022 08:55:23 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id v81so5592731oie.5;
        Fri, 04 Nov 2022 08:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LuRWZ+uGAhH28zFK+adTPuM2Aq0aZSCcYB6eJqAff0=;
        b=n6JwNr1494B1IS3yVuRf9KG/Gicq7BlI2jCdg1HlM3CNAiLRNMUsbTqIXucZ+0tQ4P
         Hn1gfJkrwoc4mw/xLX9kZdRv7wHqa94hP/mby+u2V27v7yWzrc8dH/9y3C8YsE1dXQXC
         Q9y37wvVU32FSRiwAK4GnZVjnmq0VuY+FJhP/N8jB3Jrf9g/358303jo0Gxf5qOn7QMC
         0XWfrCYDJbmiKzUjBFwDzC8gHdlsJ6ZIRIiqR9Wpr8C7OIDSmT9A0Vn83QEaq6zuRHmd
         iQSO4xSg/L6CCLuKC8Td+JEPSAMvxcrqYh7RoeYCgAjNlekk6i69q9mSnHqOMmUU7+Eg
         BAsQ==
X-Gm-Message-State: ACrzQf3UZLjzu/PHBZnFVM/MaLD0kFUlMIRKJX2O1yZy5TwpNfYgM98y
        T7y94+GVpRI4nWt7RNnJqg==
X-Google-Smtp-Source: AMsMyM4d6TDw2T7GbRam3QWG/Wa4RT72PM5DQk1E8uYmT91uYVnx3slmlmbYjUyO46tJ6RiQPcimSQ==
X-Received: by 2002:a05:6808:1492:b0:353:f28f:6fb with SMTP id e18-20020a056808149200b00353f28f06fbmr258038oiw.246.1667577322632;
        Fri, 04 Nov 2022 08:55:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z15-20020a056870e30f00b00136a0143de8sm1876818oad.40.2022.11.04.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:55:22 -0700 (PDT)
Received: (nullmailer pid 1880420 invoked by uid 1000);
        Fri, 04 Nov 2022 15:55:18 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Nov 2022 10:55:06 -0500
Subject: [PATCH v3 6/8] perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v3-6-87682f78caac@kernel.org>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 (Armv8.7/v9.2) adds a new event, 'not taken', in bit 6 of
the PMSEVFR_EL1 register. Update arm_spe_pmsevfr_res0() to support the
additional event.

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - No change
v2:
 - Update for v6.1 sysreg generated header changes
---
 arch/arm64/include/asm/sysreg.h | 2 ++
 drivers/perf/arm_spe_pmu.c      | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d002dd00e53e..06231e896832 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -242,6 +242,8 @@
 	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
 #define PMSEVFR_EL1_RES0_V1P1	\
 	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
+#define PMSEVFR_EL1_RES0_V1P2	\
+	(PMSEVFR_EL1_RES0_V1P1 & ~BIT_ULL(6))
 
 /* Buffer error reporting */
 #define PMBSR_EL1_FAULT_FSC_SHIFT	PMBSR_EL1_MSS_SHIFT
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index af6d3867c3e7..82f67e941bc4 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -677,9 +677,11 @@ static u64 arm_spe_pmsevfr_res0(u16 pmsver)
 	case ID_AA64DFR0_EL1_PMSVer_IMP:
 		return PMSEVFR_EL1_RES0_IMP;
 	case ID_AA64DFR0_EL1_PMSVer_V1P1:
+		return PMSEVFR_EL1_RES0_V1P1;
+	case ID_AA64DFR0_EL1_PMSVer_V1P2:
 	/* Return the highest version we support in default */
 	default:
-		return PMSEVFR_EL1_RES0_V1P1;
+		return PMSEVFR_EL1_RES0_V1P2;
 	}
 }
 

-- 
b4 0.11.0-dev
