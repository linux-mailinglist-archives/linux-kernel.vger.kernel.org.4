Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C4619C48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiKDP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiKDPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:55:32 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AF3054E;
        Fri,  4 Nov 2022 08:55:30 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13c2cfd1126so5952937fac.10;
        Fri, 04 Nov 2022 08:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY5WLVvBtjin9otYHyxvqw7D/OBaUkyJnRUdtIxFHiA=;
        b=uKl75G2/ALgUHuuVauw34T6B26XDrA4Hc4ffk66G9mvUPagq94KuCiTTnRBUVUwboG
         JAkgmMSzFBMNZ1Jk1TL2QHw8WGkb0V3YM41Y/gP1tYgLnO1xHsVxwXJMe/QkjFf4LqOQ
         /AYteq5oLMm4BcaHRBfkSan/OIvV2b/sX/ZGiPPxrpbknoqx52t0q7uw2HoWbucTIcxt
         zy3PXDK5thX2w+83wTIKbcOvF6I7iVnr5jB2jwVZMzkFQGNbxwk8tB9YFgrugs4eN5kf
         9qXYvS1CfYrYCh3e2i/6itx0rTOc9Iw2YnizV0+ADvlQkbHNM69FcujavvLI1FE8Rsdo
         UNrg==
X-Gm-Message-State: ACrzQf04ts7cAa9vUii4OlnXJe+PiHlvZ9Jooer0hYRd6sECYRkLdwYC
        It87WKN7H6kj/8pb9lM0ww==
X-Google-Smtp-Source: AMsMyM4hNP3YtD1AjfgdVy7Wwt0avfUZHLw8qObIfSKL9fYTqIcOZIAAguh8sEaoNEPCMLo5eWKqXA==
X-Received: by 2002:a05:6871:20c:b0:13c:12cf:1fee with SMTP id t12-20020a056871020c00b0013c12cf1feemr22484223oad.120.1667577329944;
        Fri, 04 Nov 2022 08:55:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p36-20020a05687056a400b0013b1301ce42sm1871096oao.47.2022.11.04.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:55:29 -0700 (PDT)
Received: (nullmailer pid 1880424 invoked by uid 1000);
        Fri, 04 Nov 2022 15:55:18 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Nov 2022 10:55:08 -0500
Subject: [PATCH v3 8/8] perf: arm_spe: Add support for SPEv1.2 inverted event
 filtering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v3-8-87682f78caac@kernel.org>
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

Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
Filter which excludes samples matching the event filter. The feature
mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
PMSNEVFR_EL1, which has the same event bit assignments.

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - No change
v2:
 - Update for auto generated register defines
 - Avoid accessing SYS_PMSNEVFR_EL1 on < v8.7
---
 drivers/perf/arm_spe_pmu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 82f67e941bc4..573db4211acd 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -85,6 +85,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_ARCH_INST			(1UL << 3)
 #define SPE_PMU_FEAT_LDS			(1UL << 4)
 #define SPE_PMU_FEAT_ERND			(1UL << 5)
+#define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -202,6 +203,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_min_latency_LO		0
 #define ATTR_CFG_FLD_min_latency_HI		11
 
+#define ATTR_CFG_FLD_inv_event_filter_CFG	config3	/* PMSNEVFR_EL1 */
+#define ATTR_CFG_FLD_inv_event_filter_LO	0
+#define ATTR_CFG_FLD_inv_event_filter_HI	63
+
 /* Why does everything I do descend into this? */
 #define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
 	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
@@ -232,6 +237,7 @@ GEN_PMU_FORMAT_ATTR(branch_filter);
 GEN_PMU_FORMAT_ATTR(load_filter);
 GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
+GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
@@ -243,12 +249,27 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_load_filter.attr,
 	&format_attr_store_filter.attr,
 	&format_attr_event_filter.attr,
+	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
 	NULL,
 };
 
+static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
+						  struct attribute *attr,
+						  int unused)
+	{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+
+	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group arm_spe_pmu_format_group = {
 	.name	= "format",
+	.is_visible = arm_spe_pmu_format_attr_is_visible,
 	.attrs	= arm_spe_pmu_formats_attr,
 };
 
@@ -343,6 +364,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, event_filter))
 		reg |= PMSFCR_EL1_FE;
 
+	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
+		reg |= PMSFCR_EL1_FnE;
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= PMSFCR_EL1_FL;
 
@@ -355,6 +379,12 @@ static u64 arm_spe_event_to_pmsevfr(struct perf_event *event)
 	return ATTR_CFG_GET_FLD(attr, event_filter);
 }
 
+static u64 arm_spe_event_to_pmsnevfr(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	return ATTR_CFG_GET_FLD(attr, inv_event_filter);
+}
+
 static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
@@ -703,6 +733,9 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -721,6 +754,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
 		return -EOPNOTSUPP;
 
+	if ((FIELD_GET(PMSFCR_EL1_FnE, reg)) &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
+		return -EOPNOTSUPP;
+
 	if ((FIELD_GET(PMSFCR_EL1_FT, reg)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
 		return -EOPNOTSUPP;
@@ -756,6 +793,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 	reg = arm_spe_event_to_pmsevfr(event);
 	write_sysreg_s(reg, SYS_PMSEVFR_EL1);
 
+	if (spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT) {
+		reg = arm_spe_event_to_pmsnevfr(event);
+		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
+	}
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -990,6 +1032,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (FIELD_GET(PMSIDR_EL1_FE, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_EVT;
 
+	if (FIELD_GET(PMSIDR_EL1_FnE, reg))
+		spe_pmu->features |= SPE_PMU_FEAT_INV_FILT_EVT;
+
 	if (FIELD_GET(PMSIDR_EL1_FT, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_TYP;
 

-- 
b4 0.11.0-dev
