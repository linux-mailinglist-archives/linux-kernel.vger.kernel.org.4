Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B35619C47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiKDPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiKDPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:55:28 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD053121A;
        Fri,  4 Nov 2022 08:55:27 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13bd2aea61bso6025220fac.0;
        Fri, 04 Nov 2022 08:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubE2AAZXlCuiNyL1KuoZrNEXriWN5pZWIN4cSFgHZnA=;
        b=a4O7YS/6RX0oYSVl8ccdjpdKbmp4Evp9HCmRKyaFxlMzkzuu9kH4bH4GQ4GWIVeVw3
         iZlcoQ/oVjJKaI+Gb9f93uImSfV5xJsGvD7kZSFJtD5dqxoYSqBsG/nWOl/o/Ze/wpos
         9DuYVWcDrJumVEDnffA8YidiD2ti5finW7jpe52tIapeeGHqMZIorOq681DhY39qB9Zu
         KXeLfnhxr3q2MLt5K6f1ZOxiaF4tqU6eawFbkkKz5w3HZdzpGdGfNqYobfD6OoKPCWZl
         AQuTUclMDxe7G0ujB0wv2SB3NzTfpS5qzQmVC4Spzlv5JiL40ZAQhyVWJPDiJoafElqY
         N1Ew==
X-Gm-Message-State: ACrzQf14SbUtJ3VB8jFBrapv+6bwFZ7m0x/cbCpQaVC8uEc75KqvsoAp
        LXMRisQNWY2yzz3QYgyrCg==
X-Google-Smtp-Source: AMsMyM5i6RcuCkLATEdqES8PyM2eEeChV16kftf4iuKKCEnn8hY58tD8/bZ9w+Cv8IMCuJDpXPQTQA==
X-Received: by 2002:a05:6870:a70a:b0:13c:19bc:12ae with SMTP id g10-20020a056870a70a00b0013c19bc12aemr21300865oam.240.1667577326358;
        Fri, 04 Nov 2022 08:55:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v20-20020a4ac014000000b0049052c66126sm1278110oop.2.2022.11.04.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:55:25 -0700 (PDT)
Received: (nullmailer pid 1880416 invoked by uid 1000);
        Fri, 04 Nov 2022 15:55:18 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Nov 2022 10:55:04 -0500
Subject: [PATCH v3 4/8] perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v3-4-87682f78caac@kernel.org>
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
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that generated sysregs are in place, update the register field
accesses. The use of BIT() is no longer needed with the new defines. Use
FIELD_GET and FIELD_PREP instead of open coding masking and shifting.

No functional change.

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - no change
---
 drivers/perf/arm_spe_pmu.c | 70 ++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 814ed18346b6..9b4bd72087ea 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -283,18 +283,18 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	u64 reg = 0;
 
-	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << PMSCR_EL1_TS_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, pa_enable) << PMSCR_EL1_PA_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, pct_enable) << PMSCR_EL1_PCT_SHIFT;
+	reg |= FIELD_PREP(PMSCR_EL1_TS, ATTR_CFG_GET_FLD(attr, ts_enable));
+	reg |= FIELD_PREP(PMSCR_EL1_PA, ATTR_CFG_GET_FLD(attr, pa_enable));
+	reg |= FIELD_PREP(PMSCR_EL1_PCT, ATTR_CFG_GET_FLD(attr, pct_enable));
 
 	if (!attr->exclude_user)
-		reg |= BIT(PMSCR_EL1_E0SPE_SHIFT);
+		reg |= PMSCR_EL1_E0SPE;
 
 	if (!attr->exclude_kernel)
-		reg |= BIT(PMSCR_EL1_E1SPE_SHIFT);
+		reg |= PMSCR_EL1_E1SPE;
 
 	if (get_spe_event_has_cx(event))
-		reg |= BIT(PMSCR_EL1_CX_SHIFT);
+		reg |= PMSCR_EL1_CX;
 
 	return reg;
 }
@@ -322,7 +322,7 @@ static u64 arm_spe_event_to_pmsirr(struct perf_event *event)
 
 	arm_spe_event_sanitise_period(event);
 
-	reg |= ATTR_CFG_GET_FLD(attr, jitter) << PMSIRR_EL1_RND_SHIFT;
+	reg |= FIELD_PREP(PMSIRR_EL1_RND, ATTR_CFG_GET_FLD(attr, jitter));
 	reg |= event->hw.sample_period;
 
 	return reg;
@@ -333,18 +333,18 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	u64 reg = 0;
 
-	reg |= ATTR_CFG_GET_FLD(attr, load_filter) << PMSFCR_EL1_LD_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, store_filter) << PMSFCR_EL1_ST_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, branch_filter) << PMSFCR_EL1_B_SHIFT;
+	reg |= FIELD_PREP(PMSFCR_EL1_LD, ATTR_CFG_GET_FLD(attr, load_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_ST, ATTR_CFG_GET_FLD(attr, store_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_B, ATTR_CFG_GET_FLD(attr, branch_filter));
 
 	if (reg)
-		reg |= BIT(PMSFCR_EL1_FT_SHIFT);
+		reg |= PMSFCR_EL1_FT;
 
 	if (ATTR_CFG_GET_FLD(attr, event_filter))
-		reg |= BIT(PMSFCR_EL1_FE_SHIFT);
+		reg |= PMSFCR_EL1_FE;
 
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
-		reg |= BIT(PMSFCR_EL1_FL_SHIFT);
+		reg |= PMSFCR_EL1_FL;
 
 	return reg;
 }
@@ -358,8 +358,7 @@ static u64 arm_spe_event_to_pmsevfr(struct perf_event *event)
 static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
-	return ATTR_CFG_GET_FLD(attr, min_latency)
-	       << PMSLATFR_EL1_MINLAT_SHIFT;
+	return FIELD_PREP(PMSLATFR_EL1_MINLAT, ATTR_CFG_GET_FLD(attr, min_latency));
 }
 
 static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
@@ -511,7 +510,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
 			      : arm_spe_pmu_next_off(handle);
 	if (limit)
-		limit |= BIT(PMBLIMITR_EL1_E_SHIFT);
+		limit |= PMBLIMITR_EL1_E;
 
 	limit += (u64)buf->base;
 	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
@@ -570,23 +569,23 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 
 	/* Service required? */
 	pmbsr = read_sysreg_s(SYS_PMBSR_EL1);
-	if (!(pmbsr & BIT(PMBSR_EL1_S_SHIFT)))
+	if (!FIELD_GET(PMBSR_EL1_S, pmbsr))
 		return SPE_PMU_BUF_FAULT_ACT_SPURIOUS;
 
 	/*
 	 * If we've lost data, disable profiling and also set the PARTIAL
 	 * flag to indicate that the last record is corrupted.
 	 */
-	if (pmbsr & BIT(PMBSR_EL1_DL_SHIFT))
+	if (FIELD_GET(PMBSR_EL1_DL, pmbsr))
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED |
 					     PERF_AUX_FLAG_PARTIAL);
 
 	/* Report collisions to userspace so that it can up the period */
-	if (pmbsr & BIT(PMBSR_EL1_COLL_SHIFT))
+	if (FIELD_GET(PMBSR_EL1_COLL, pmbsr))
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
 
 	/* We only expect buffer management events */
-	switch (FIELD_GET(PMBSR_EL1_EC_MASK, pmbsr)) {
+	switch (FIELD_GET(PMBSR_EL1_EC, pmbsr)) {
 	case PMBSR_EL1_EC_BUF:
 		/* Handled below */
 		break;
@@ -716,23 +715,22 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	reg = arm_spe_event_to_pmsfcr(event);
-	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
+	if ((FIELD_GET(PMSFCR_EL1_FE, reg)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
 		return -EOPNOTSUPP;
 
-	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
+	if ((FIELD_GET(PMSFCR_EL1_FT, reg)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
 		return -EOPNOTSUPP;
 
-	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
+	if ((FIELD_GET(PMSFCR_EL1_FL, reg)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (!perfmon_capable() &&
-	    (reg & (BIT(PMSCR_EL1_PA_SHIFT) |
-		    BIT(PMSCR_EL1_PCT_SHIFT))))
+	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
 		return -EACCES;
 
 	return 0;
@@ -970,14 +968,14 @@ static void __arm_spe_pmu_dev_probe(void *info)
 
 	/* Read PMBIDR first to determine whether or not we have access */
 	reg = read_sysreg_s(SYS_PMBIDR_EL1);
-	if (reg & BIT(PMBIDR_EL1_P_SHIFT)) {
+	if (FIELD_GET(PMBIDR_EL1_P, reg)) {
 		dev_err(dev,
 			"profiling buffer owned by higher exception level\n");
 		return;
 	}
 
 	/* Minimum alignment. If it's out-of-range, then fail the probe */
-	fld = (reg & PMBIDR_EL1_ALIGN_MASK) >> PMBIDR_EL1_ALIGN_SHIFT;
+	fld = FIELD_GET(PMBIDR_EL1_ALIGN, reg);
 	spe_pmu->align = 1 << fld;
 	if (spe_pmu->align > SZ_2K) {
 		dev_err(dev, "unsupported PMBIDR.Align [%d] on CPU %d\n",
@@ -987,26 +985,26 @@ static void __arm_spe_pmu_dev_probe(void *info)
 
 	/* It's now safe to read PMSIDR and figure out what we've got */
 	reg = read_sysreg_s(SYS_PMSIDR_EL1);
-	if (reg & BIT(PMSIDR_EL1_FE_SHIFT))
+	if (FIELD_GET(PMSIDR_EL1_FE, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_EVT;
 
-	if (reg & BIT(PMSIDR_EL1_FT_SHIFT))
+	if (FIELD_GET(PMSIDR_EL1_FT, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_TYP;
 
-	if (reg & BIT(PMSIDR_EL1_FL_SHIFT))
+	if (FIELD_GET(PMSIDR_EL1_FL, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_LAT;
 
-	if (reg & BIT(PMSIDR_EL1_ARCHINST_SHIFT))
+	if (FIELD_GET(PMSIDR_EL1_ARCHINST, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_ARCH_INST;
 
-	if (reg & BIT(PMSIDR_EL1_LDS_SHIFT))
+	if (FIELD_GET(PMSIDR_EL1_LDS, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_LDS;
 
-	if (reg & BIT(PMSIDR_EL1_ERND_SHIFT))
+	if (FIELD_GET(PMSIDR_EL1_ERND, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_ERND;
 
 	/* This field has a spaced out encoding, so just use a look-up */
-	fld = (reg & PMSIDR_EL1_INTERVAL_MASK) >> PMSIDR_EL1_INTERVAL_SHIFT;
+	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {
 	case 0:
 		spe_pmu->min_period = 256;
@@ -1038,7 +1036,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	}
 
 	/* Maximum record size. If it's out-of-range, then fail the probe */
-	fld = (reg & PMSIDR_EL1_MAXSIZE_MASK) >> PMSIDR_EL1_MAXSIZE_SHIFT;
+	fld = FIELD_GET(PMSIDR_EL1_MAXSIZE, reg);
 	spe_pmu->max_record_sz = 1 << fld;
 	if (spe_pmu->max_record_sz > SZ_2K || spe_pmu->max_record_sz < 16) {
 		dev_err(dev, "unsupported PMSIDR_EL1.MaxSize [%d] on CPU %d\n",
@@ -1046,7 +1044,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		return;
 	}
 
-	fld = (reg & PMSIDR_EL1_COUNTSIZE_MASK) >> PMSIDR_EL1_COUNTSIZE_SHIFT;
+	fld = FIELD_GET(PMSIDR_EL1_COUNTSIZE, reg);
 	switch (fld) {
 	default:
 		dev_warn(dev, "unknown PMSIDR_EL1.CountSize [%d]; assuming 2\n",

-- 
b4 0.11.0-dev
