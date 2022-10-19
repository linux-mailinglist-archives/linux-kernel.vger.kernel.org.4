Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F6605032
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJSTL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJSTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:11:35 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1411C712E;
        Wed, 19 Oct 2022 12:11:31 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso10067435oto.9;
        Wed, 19 Oct 2022 12:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43IaqXn32YycCBd3/SGJ6Da4qva/kGDXqjobO4DMXeA=;
        b=wu01KFcU8n49Dijx+qpwD9N7YQGuwsLIRvHnDfNyuZe+3Z384rV/UQ+8F/SotO7i6e
         DrxY20Cvg4cfQ4QkYaOq5ey1WjyJwueLPpdiUT08K4/jB2LqmV4yKsJqjKITH8rZ6exq
         li4pLr+4rg74fump5v1f8O0Ell/EXLlCtha+PHVTifq7frUUHH/LEYWyBt33ql9GozQO
         7tlPMQ5dwn0ry56KjEdFJUuBqJfdfflST7FMgiQ9nK+TStFpvYcc4AjLdopQQ3zmN1cI
         PLulEbEEdT3vf/RzLQhOLbUcXSrT7x7hv189NYQWDJGcsmy1pnvLVA+nqblzyu+pp315
         ERdA==
X-Gm-Message-State: ACrzQf0A8K1UsN4mXHliL9212jwitNKN6eH3xBrfrn518Zpgv6wjr/26
        mjj/Azxmelp/J1kE3qMFlw==
X-Google-Smtp-Source: AMsMyM52ccM2SuB4fJVuNR6xyd3GwViwYeYnmewRYJ6qofqTylHkTtpXjuHE/sY2iyCkl53jTYlNfw==
X-Received: by 2002:a9d:6948:0:b0:661:a43c:77a3 with SMTP id p8-20020a9d6948000000b00661a43c77a3mr4934314oto.222.1666206690183;
        Wed, 19 Oct 2022 12:11:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b0047f8ceca22bsm6816526oon.15.2022.10.19.12.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:11:29 -0700 (PDT)
Received: (nullmailer pid 3420910 invoked by uid 1000);
        Wed, 19 Oct 2022 19:11:25 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Oct 2022 14:11:30 -0500
Subject: [PATCH v2 7/7] perf: arm_spe: Add support for SPEv1.2 inverted event
 filtering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v2-7-e37322d68ac0@kernel.org>
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

Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
Filter which excludes samples matching the event filter. The feature
mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
PMSNEVFR_EL1, which has the same event bit assignments.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Update for auto generated register defines
 - Avoid accessing SYS_PMSNEVFR_EL1 on < v8.7
---
 drivers/perf/arm_spe_pmu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 0b9b847919d0..ab5fcf02a4ca 100644
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
