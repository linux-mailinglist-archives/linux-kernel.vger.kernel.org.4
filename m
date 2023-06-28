Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7646741341
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjF1OCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjF1OBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:01:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2812733
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8775126d3so8344536e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960853; x=1690552853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSoFxDpo8ueVy/vAg4zKAz0XPpEp/jM8wg58zEJk7RM=;
        b=wJOMn5FOzl+s7DSJXudsTrbTQrYOqAs++X6eRDBdCL/y/gKBsbMyege0j/nBmbC+sb
         OsrzEb7aOO4W7nMS/J0maT3X4MO866pqEwT6F0LmAx7fx5g7/fXRRrYOGv0c3ge0qGe3
         sSntrd1wAq+/1yUm/I9ESUntcEO/xJBEuh1nKipw5nxsbpsj/iuJzxUcuFIyZC8gu/kN
         j0fTXQytuWcYXO9/VJZ9GKiuZ7mKJICmmCOZxmbj9xH4ENHpFQT8FtoXclKlmu6bFhtD
         KYRQvGVYCiTbK1KfmAsp3CfWCeHZd29c1+xX4X5ojRcExfB/fttfSdka+iRhMi9sEsI9
         oOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960853; x=1690552853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSoFxDpo8ueVy/vAg4zKAz0XPpEp/jM8wg58zEJk7RM=;
        b=HgoE0sgSIQS8tYiKrHmc21QghiezMw8Lw4jfq2zRGlf461U4KdElHjSoRkpdcxuXbL
         lvDN4Oj7w4IVMTTIT4GDNYibQzSEbhXpLhEWhV8LN6+ruJEacgNGSXUO3oa89s+8Anch
         ts8HdK4hnv6tCSc7jdwfOOHD4yk/sHxUeOVTb+jfWCKM0R71l74YAqu/q+YjowJzSj+z
         yjPeAy14RcpZR2ZcmoJiDe9qyz2QpDqAMPj1tpZZxL6sh9Wng8owttB66JDEfjAlgqW0
         lg2yexGL3SEGfhPHFnlAZshlet2M9ASepJFJ4ZAnoTo1vwXiZaXAQM1y6afKwox0FjR0
         hfyw==
X-Gm-Message-State: AC+VfDwbDp3Y9Y4vJ9AFVJZFPpuNYkmHWkbVdGENUGDQWiSr7Fe1yTHS
        q+rxyziXPBuubzMRp/T0joAwgezUo/U6zFZVHDw=
X-Google-Smtp-Source: ACHHUZ45znYkAK2vYJZAoqYxlWVtmayFWGAdk8KhlovgZPwusaA2CmYqVz86smNhpU+8IuvXfUCb/w==
X-Received: by 2002:a05:6512:32d3:b0:4f9:6528:fb1e with SMTP id f19-20020a05651232d300b004f96528fb1emr15446675lfg.51.1687960853525;
        Wed, 28 Jun 2023 07:00:53 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:44 +0200
Subject: [PATCH v12 05/10] soc: qcom: cpr: Move common functions to new
 file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-5-1a4d050e1e67@linaro.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960842; l=27820;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=S/XhvP0zPz3smdIa7pQn2z1eb+cDi1RTa9d2k7I5tVo=;
 b=a6jI903qmjkBBZ8Sl0sgFQIZoMWnMS2BvN+IdHAA3PXAihgNyZdiTPemf3CyW5Kf+AJetZNif
 IuNJnLkZcsiBkRgQBuxBUfRgl6Df9uXUalGB1GrMinieTQWFp6lQYHH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

In preparation for implementing a new driver that will be handling
CPRv3, CPRv4 and CPR-Hardened, format out common functions to a new
file.

Update cpr_get_fuses in preparation for CPR3 implementation, change
parameters where necessary to not take cpr.c private data structures.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, apply review comments, improve msg, split]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/Makefile     |   2 +-
 drivers/soc/qcom/cpr-common.c | 350 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/cpr-common.h | 103 +++++++++++
 drivers/soc/qcom/cpr.c        | 384 +++---------------------------------------
 4 files changed, 475 insertions(+), 364 deletions(-)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..82b23743371b 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -3,7 +3,7 @@ CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
-obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_CPR)		+= cpr-common.o cpr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
new file mode 100644
index 000000000000..ea85f6b4bef8
--- /dev/null
+++ b/drivers/soc/qcom/cpr-common.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, Linaro Limited
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cpr-common.h"
+
+int cpr_populate_ring_osc_idx(struct device *dev,
+			      struct fuse_corner *fuse_corner,
+			      const struct cpr_fuse *cpr_fuse,
+			      int num_fuse_corners)
+{
+	struct fuse_corner *end = fuse_corner + num_fuse_corners;
+	u32 data;
+	int ret;
+
+	for (; fuse_corner < end; fuse_corner++, cpr_fuse++) {
+		ret = nvmem_cell_read_variable_le_u32(dev, cpr_fuse->ring_osc, &data);
+		if (ret)
+			return ret;
+		fuse_corner->ring_osc_idx = data;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
+
+static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
+			    int step_volt, const char *init_v_efuse,
+			    struct device *dev)
+{
+	int steps, uV;
+	u32 bits = 0;
+	int ret;
+
+	ret = nvmem_cell_read_variable_le_u32(dev, init_v_efuse, &bits);
+	if (ret)
+		return ret;
+
+	steps = bits & ~BIT(init_v_width - 1);
+	/* Not two's complement.. instead highest bit is sign bit */
+	if (bits & BIT(init_v_width - 1))
+		steps = -steps;
+
+	uV = ref_uV + steps * step_size_uV;
+
+	return DIV_ROUND_UP(uV, step_volt) * step_volt;
+}
+
+const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+				     unsigned int num_fuse_corners)
+{
+	struct cpr_fuse *fuses;
+	int i;
+
+	fuses = devm_kcalloc(dev, num_fuse_corners, sizeof(*fuses), GFP_KERNEL);
+	if (!fuses)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num_fuse_corners; i++) {
+		char tbuf[32];
+
+		snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
+		fuses[i].ring_osc = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].ring_osc)
+			return ERR_PTR(-ENOMEM);
+
+		snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
+		fuses[i].init_voltage = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].init_voltage)
+			return ERR_PTR(-ENOMEM);
+
+		snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
+		fuses[i].quotient = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].quotient)
+			return ERR_PTR(-ENOMEM);
+
+		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
+		fuses[i].quotient_offset = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].quotient_offset)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return fuses;
+}
+EXPORT_SYMBOL_GPL(cpr_get_fuses);
+
+int cpr_populate_fuse_common(struct device *dev,
+			     struct fuse_corner_data *fdata,
+			     const struct cpr_fuse *cpr_fuse,
+			     struct fuse_corner *fuse_corner,
+			     int step_volt, int init_v_width,
+			     int init_v_step)
+{
+	int uV, ret;
+
+	/* Populate uV */
+	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
+			      fdata->ref_uV, step_volt,
+			      cpr_fuse->init_voltage, dev);
+	if (uV < 0)
+		return uV;
+
+	/*
+	 * Update SoC voltages: platforms might choose a different
+	 * regulators than the one used to characterize the algorithms
+	 * (ie, init_voltage_step).
+	 */
+	fdata->min_uV = roundup(fdata->min_uV, step_volt);
+	fdata->max_uV = roundup(fdata->max_uV, step_volt);
+
+	fuse_corner->min_uV = fdata->min_uV;
+	fuse_corner->max_uV = fdata->max_uV;
+	fuse_corner->uV = clamp(uV, fuse_corner->min_uV, fuse_corner->max_uV);
+
+	/* Populate target quotient by scaling */
+	ret = nvmem_cell_read_variable_le_u32(dev, cpr_fuse->quotient, &fuse_corner->quot);
+	if (ret)
+		return ret;
+
+	fuse_corner->quot *= fdata->quot_scale;
+	fuse_corner->quot += fdata->quot_offset;
+	fuse_corner->quot += fdata->quot_adjust;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_populate_fuse_common);
+
+int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
+			    struct corner *corners, int num_corners)
+{
+	unsigned long rate;
+	struct corner *iter, *corner;
+	const struct corner *end;
+	unsigned int i = 0;
+
+	if (!cpu_clk) {
+		dev_err(dev, "cannot get rate from NULL clk\n");
+		return -EINVAL;
+	}
+
+	end = &corners[num_corners - 1];
+	rate = clk_get_rate(cpu_clk);
+
+	/*
+	 * Some bootloaders set a CPU clock frequency that is not defined
+	 * in the OPP table. When running at an unlisted frequency,
+	 * cpufreq_online() will change to the OPP which has the lowest
+	 * frequency, at or above the unlisted frequency.
+	 * Since cpufreq_online() always "rounds up" in the case of an
+	 * unlisted frequency, this function always "rounds down" in case
+	 * of an unlisted frequency. That way, when cpufreq_online()
+	 * triggers the first ever call to cpr_set_performance_state(),
+	 * it will correctly determine the direction as UP.
+	 */
+	for (iter = corners; iter <= end; iter++) {
+		if (iter->freq > rate)
+			break;
+		i++;
+		if (iter->freq == rate) {
+			corner = iter;
+			break;
+		}
+		if (iter->freq < rate)
+			corner = iter;
+	}
+
+	if (!corner) {
+		dev_err(dev, "boot up corner not found\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "boot up perf state: %u\n", i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_find_initial_corner);
+
+unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
+{
+	struct device_node *np;
+	unsigned int fuse_corner = 0;
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner))
+		pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
+		       __func__);
+
+	of_node_put(np);
+
+	return fuse_corner;
+}
+EXPORT_SYMBOL_GPL(cpr_get_fuse_corner);
+
+unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+				     struct device *cpu_dev)
+{
+	u64 rate = 0;
+	struct device_node *ref_np;
+	struct device_node *desc_np;
+	struct device_node *child_np = NULL;
+	struct device_node *child_req_np = NULL;
+
+	desc_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	if (!desc_np)
+		return 0;
+
+	ref_np = dev_pm_opp_get_of_node(ref);
+	if (!ref_np)
+		goto out_ref;
+
+	do {
+		of_node_put(child_req_np);
+		child_np = of_get_next_available_child(desc_np, child_np);
+		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
+	} while (child_np && child_req_np != ref_np);
+
+	if (child_np && child_req_np == ref_np)
+		of_property_read_u64(child_np, "opp-hz", &rate);
+
+	of_node_put(child_req_np);
+	of_node_put(child_np);
+	of_node_put(ref_np);
+out_ref:
+	of_node_put(desc_np);
+
+	return (unsigned long) rate;
+}
+EXPORT_SYMBOL_GPL(cpr_get_opp_hz_for_req);
+
+int cpr_calculate_scaling(struct device *dev,
+			  const char *quot_offset,
+			  const struct fuse_corner_data *fdata,
+			  const struct corner *corner)
+{
+	u32 quot_diff = 0;
+	unsigned long freq_diff;
+	int scaling;
+	const struct fuse_corner *fuse, *prev_fuse;
+	int ret;
+
+	fuse = corner->fuse_corner;
+	prev_fuse = fuse - 1;
+
+	if (quot_offset) {
+		ret = nvmem_cell_read_variable_le_u32(dev, quot_offset, &quot_diff);
+		if (ret)
+			return ret;
+
+		quot_diff *= fdata->quot_offset_scale;
+		quot_diff += fdata->quot_offset_adjust;
+	} else {
+		quot_diff = fuse->quot - prev_fuse->quot;
+	}
+
+	freq_diff = fuse->max_freq - prev_fuse->max_freq;
+	freq_diff /= 1000000; /* Convert to MHz */
+	scaling = 1000 * quot_diff / freq_diff;
+	return min(scaling, fdata->max_quot_scale);
+}
+EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
+
+int cpr_interpolate(const struct corner *corner, int step_volt,
+		    const struct fuse_corner_data *fdata)
+{
+	unsigned long f_high, f_low, f_diff;
+	int uV_high, uV_low, uV;
+	u64 temp, temp_limit;
+	const struct fuse_corner *fuse, *prev_fuse;
+
+	fuse = corner->fuse_corner;
+	prev_fuse = fuse - 1;
+
+	f_high = fuse->max_freq;
+	f_low = prev_fuse->max_freq;
+	uV_high = fuse->uV;
+	uV_low = prev_fuse->uV;
+	f_diff = fuse->max_freq - corner->freq;
+
+	/*
+	 * Don't interpolate in the wrong direction. This could happen
+	 * if the adjusted fuse voltage overlaps with the previous fuse's
+	 * adjusted voltage.
+	 */
+	if (f_high <= f_low || uV_high <= uV_low || f_high <= corner->freq)
+		return corner->uV;
+
+	temp = f_diff * (uV_high - uV_low);
+	temp = div64_ul(temp, f_high - f_low);
+
+	/*
+	 * max_volt_scale has units of uV/MHz while freq values
+	 * have units of Hz.  Divide by 1000000 to convert to.
+	 */
+	temp_limit = f_diff * fdata->max_volt_scale;
+	do_div(temp_limit, 1000000);
+
+	uV = uV_high - min(temp, temp_limit);
+	return roundup(uV, step_volt);
+}
+EXPORT_SYMBOL_GPL(cpr_interpolate);
+
+int cpr_check_vreg_constraints(struct device *dev, struct regulator *vreg,
+			       struct fuse_corner *f)
+{
+	int ret;
+
+	ret = regulator_is_supported_voltage(vreg, f->min_uV, f->min_uV);
+	if (!ret) {
+		dev_err(dev, "min uV: %d not supported by regulator\n",
+			f->min_uV);
+		return -EINVAL;
+	}
+
+	ret = regulator_is_supported_voltage(vreg, f->max_uV, f->max_uV);
+	if (!ret) {
+		dev_err(dev, "max uV: %d not supported by regulator\n",
+			f->max_uV);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_check_vreg_constraints);
+
+MODULE_DESCRIPTION("Core Power Reduction (CPR) common");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
new file mode 100644
index 000000000000..1f2ebf9394cf
--- /dev/null
+++ b/drivers/soc/qcom/cpr-common.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+
+enum voltage_change_dir {
+	NO_CHANGE,
+	DOWN,
+	UP,
+};
+
+struct cpr_fuse {
+	char *ring_osc;
+	char *init_voltage;
+	char *quotient;
+	char *quotient_offset;
+};
+
+struct fuse_corner_data {
+	int ref_uV;
+	int max_uV;
+	int min_uV;
+	int max_volt_scale;
+	int max_quot_scale;
+	/* fuse quot */
+	int quot_offset;
+	int quot_scale;
+	int quot_adjust;
+	/* fuse quot_offset */
+	int quot_offset_scale;
+	int quot_offset_adjust;
+};
+
+struct fuse_corner {
+	int min_uV;
+	int max_uV;
+	int uV;
+	int quot;
+	int step_quot;
+	const struct reg_sequence *accs;
+	int num_accs;
+	unsigned long max_freq;
+	u8 ring_osc_idx;
+};
+
+struct corner {
+	int min_uV;
+	int max_uV;
+	int uV;
+	int last_uV;
+	int quot_adjust;
+	u32 save_ctl;
+	u32 save_irq;
+	unsigned long freq;
+	struct fuse_corner *fuse_corner;
+};
+
+struct corner_data {
+	unsigned int fuse_corner;
+	unsigned long freq;
+};
+
+struct acc_desc {
+	unsigned int	enable_reg;
+	u32		enable_mask;
+
+	struct reg_sequence	*config;
+	struct reg_sequence	*settings;
+	int			num_regs_per_fuse;
+};
+
+struct cpr_acc_desc {
+	const struct cpr_desc *cpr_desc;
+	const struct acc_desc *acc_desc;
+};
+
+int cpr_populate_ring_osc_idx(struct device *dev,
+			      struct fuse_corner *fuse_corner,
+			      const struct cpr_fuse *cpr_fuse,
+			      int num_fuse_corners);
+const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+				     unsigned int num_fuse_corners);
+int cpr_populate_fuse_common(struct device *dev,
+			     struct fuse_corner_data *fdata,
+			     const struct cpr_fuse *cpr_fuse,
+			     struct fuse_corner *fuse_corner,
+			     int step_volt, int init_v_width,
+			     int init_v_step);
+int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
+			    struct corner *corners, int num_corners);
+u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
+unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+				     struct device *cpu_dev);
+int cpr_calculate_scaling(struct device *dev,
+			  const char *quot_offset,
+			  const struct fuse_corner_data *fdata,
+			  const struct corner *corner);
+int cpr_interpolate(const struct corner *corner, int step_volt,
+		    const struct fuse_corner_data *fdata);
+int cpr_check_vreg_constraints(struct device *dev, struct regulator *vreg,
+			       struct fuse_corner *f);
diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 144ea68e0920..cc1e4c462d1f 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -26,6 +26,8 @@
 #include <linux/clk.h>
 #include <linux/nvmem-consumer.h>
 
+#include "cpr-common.h"
+
 /* Register Offsets for RB-CPR and Bit Definitions */
 
 /* RBCPR Version Register */
@@ -124,45 +126,12 @@
 
 #define FUSE_REVISION_UNKNOWN		(-1)
 
-enum voltage_change_dir {
-	NO_CHANGE,
-	DOWN,
-	UP,
-};
-
-struct cpr_fuse {
-	char *ring_osc;
-	char *init_voltage;
-	char *quotient;
-	char *quotient_offset;
-};
-
-struct fuse_corner_data {
-	int ref_uV;
-	int max_uV;
-	int min_uV;
-	int max_volt_scale;
-	int max_quot_scale;
-	/* fuse quot */
-	int quot_offset;
-	int quot_scale;
-	int quot_adjust;
-	/* fuse quot_offset */
-	int quot_offset_scale;
-	int quot_offset_adjust;
-};
-
 struct cpr_fuses {
 	int init_voltage_step;
 	int init_voltage_width;
 	struct fuse_corner_data *fuse_corner_data;
 };
 
-struct corner_data {
-	unsigned int fuse_corner;
-	unsigned long freq;
-};
-
 struct cpr_desc {
 	unsigned int num_fuse_corners;
 	int min_diff_quot;
@@ -184,44 +153,6 @@ struct cpr_desc {
 	bool reduce_to_corner_uV;
 };
 
-struct acc_desc {
-	unsigned int	enable_reg;
-	u32		enable_mask;
-
-	struct reg_sequence	*config;
-	struct reg_sequence	*settings;
-	int			num_regs_per_fuse;
-};
-
-struct cpr_acc_desc {
-	const struct cpr_desc *cpr_desc;
-	const struct acc_desc *acc_desc;
-};
-
-struct fuse_corner {
-	int min_uV;
-	int max_uV;
-	int uV;
-	int quot;
-	int step_quot;
-	const struct reg_sequence *accs;
-	int num_accs;
-	unsigned long max_freq;
-	u8 ring_osc_idx;
-};
-
-struct corner {
-	int min_uV;
-	int max_uV;
-	int uV;
-	int last_uV;
-	int quot_adjust;
-	u32 save_ctl;
-	u32 save_irq;
-	unsigned long freq;
-	struct fuse_corner *fuse_corner;
-};
-
 struct cpr_drv {
 	unsigned int		num_corners;
 	unsigned int		ref_clk_khz;
@@ -801,50 +732,6 @@ static int cpr_set_performance_state(struct generic_pm_domain *domain,
 	return ret;
 }
 
-static int
-cpr_populate_ring_osc_idx(struct cpr_drv *drv)
-{
-	struct fuse_corner *fuse = drv->fuse_corners;
-	struct fuse_corner *end = fuse + drv->desc->num_fuse_corners;
-	const struct cpr_fuse *fuses = drv->cpr_fuses;
-	u32 data;
-	int ret;
-
-	for (; fuse < end; fuse++, fuses++) {
-		ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->ring_osc, &data);
-		if (ret)
-			return ret;
-		fuse->ring_osc_idx = data;
-	}
-
-	return 0;
-}
-
-static int cpr_read_fuse_uV(const struct cpr_desc *desc,
-			    const struct fuse_corner_data *fdata,
-			    const char *init_v_efuse,
-			    int step_volt,
-			    struct cpr_drv *drv)
-{
-	int step_size_uV, steps, uV;
-	u32 bits = 0;
-	int ret;
-
-	ret = nvmem_cell_read_variable_le_u32(drv->dev, init_v_efuse, &bits);
-	if (ret)
-		return ret;
-
-	steps = bits & ~BIT(desc->cpr_fuses.init_voltage_width - 1);
-	/* Not two's complement.. instead highest bit is sign bit */
-	if (bits & BIT(desc->cpr_fuses.init_voltage_width - 1))
-		steps = -steps;
-
-	step_size_uV = desc->cpr_fuses.init_voltage_step;
-
-	uV = fdata->ref_uV + steps * step_size_uV;
-	return DIV_ROUND_UP(uV, step_volt) * step_volt;
-}
-
 static int cpr_fuse_corner_init(struct cpr_drv *drv)
 {
 	const struct cpr_desc *desc = drv->desc;
@@ -854,7 +741,6 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	unsigned int step_volt;
 	struct fuse_corner_data *fdata;
 	struct fuse_corner *fuse, *end;
-	int uV;
 	const struct reg_sequence *accs;
 	int ret;
 
@@ -870,23 +756,15 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	fdata = desc->cpr_fuses.fuse_corner_data;
 
 	for (i = 0; fuse <= end; fuse++, fuses++, i++, fdata++) {
-		/*
-		 * Update SoC voltages: platforms might choose a different
-		 * regulators than the one used to characterize the algorithms
-		 * (ie, init_voltage_step).
-		 */
-		fdata->min_uV = roundup(fdata->min_uV, step_volt);
-		fdata->max_uV = roundup(fdata->max_uV, step_volt);
+		ret = cpr_populate_fuse_common(drv->dev, fdata, fuses,
+					       fuse, step_volt,
+					       desc->cpr_fuses.init_voltage_width,
+					       desc->cpr_fuses.init_voltage_step);
+		if (ret)
+			return ret;
 
-		/* Populate uV */
-		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
-				      step_volt, drv);
-		if (uV < 0)
-			return uV;
 
-		fuse->min_uV = fdata->min_uV;
-		fuse->max_uV = fdata->max_uV;
-		fuse->uV = clamp(uV, fuse->min_uV, fuse->max_uV);
+		fuse->step_quot = desc->step_quot[fuse->ring_osc_idx];
 
 		if (fuse == end) {
 			/*
@@ -924,25 +802,9 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		else if (fuse->uV < fuse->min_uV)
 			fuse->uV = fuse->min_uV;
 
-		ret = regulator_is_supported_voltage(drv->vdd_apc,
-						     fuse->min_uV,
-						     fuse->min_uV);
-		if (!ret) {
-			dev_err(drv->dev,
-				"min uV: %d (fuse corner: %d) not supported by regulator\n",
-				fuse->min_uV, i);
-			return -EINVAL;
-		}
-
-		ret = regulator_is_supported_voltage(drv->vdd_apc,
-						     fuse->max_uV,
-						     fuse->max_uV);
-		if (!ret) {
-			dev_err(drv->dev,
-				"max uV: %d (fuse corner: %d) not supported by regulator\n",
-				fuse->max_uV, i);
-			return -EINVAL;
-		}
+		ret = cpr_check_vreg_constraints(drv->dev, drv->vdd_apc, fuse);
+		if (ret)
+			return ret;
 
 		dev_dbg(drv->dev,
 			"fuse corner %d: [%d %d %d] RO%hhu quot %d squot %d\n",
@@ -953,126 +815,6 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	return 0;
 }
 
-static int cpr_calculate_scaling(const char *quot_offset,
-				 struct cpr_drv *drv,
-				 const struct fuse_corner_data *fdata,
-				 const struct corner *corner)
-{
-	u32 quot_diff = 0;
-	unsigned long freq_diff;
-	int scaling;
-	const struct fuse_corner *fuse, *prev_fuse;
-	int ret;
-
-	fuse = corner->fuse_corner;
-	prev_fuse = fuse - 1;
-
-	if (quot_offset) {
-		ret = nvmem_cell_read_variable_le_u32(drv->dev, quot_offset, &quot_diff);
-		if (ret)
-			return ret;
-
-		quot_diff *= fdata->quot_offset_scale;
-		quot_diff += fdata->quot_offset_adjust;
-	} else {
-		quot_diff = fuse->quot - prev_fuse->quot;
-	}
-
-	freq_diff = fuse->max_freq - prev_fuse->max_freq;
-	freq_diff /= 1000000; /* Convert to MHz */
-	scaling = 1000 * quot_diff / freq_diff;
-	return min(scaling, fdata->max_quot_scale);
-}
-
-static int cpr_interpolate(const struct corner *corner, int step_volt,
-			   const struct fuse_corner_data *fdata)
-{
-	unsigned long f_high, f_low, f_diff;
-	int uV_high, uV_low, uV;
-	u64 temp, temp_limit;
-	const struct fuse_corner *fuse, *prev_fuse;
-
-	fuse = corner->fuse_corner;
-	prev_fuse = fuse - 1;
-
-	f_high = fuse->max_freq;
-	f_low = prev_fuse->max_freq;
-	uV_high = fuse->uV;
-	uV_low = prev_fuse->uV;
-	f_diff = fuse->max_freq - corner->freq;
-
-	/*
-	 * Don't interpolate in the wrong direction. This could happen
-	 * if the adjusted fuse voltage overlaps with the previous fuse's
-	 * adjusted voltage.
-	 */
-	if (f_high <= f_low || uV_high <= uV_low || f_high <= corner->freq)
-		return corner->uV;
-
-	temp = f_diff * (uV_high - uV_low);
-	temp = div64_ul(temp, f_high - f_low);
-
-	/*
-	 * max_volt_scale has units of uV/MHz while freq values
-	 * have units of Hz.  Divide by 1000000 to convert to.
-	 */
-	temp_limit = f_diff * fdata->max_volt_scale;
-	do_div(temp_limit, 1000000);
-
-	uV = uV_high - min(temp, temp_limit);
-	return roundup(uV, step_volt);
-}
-
-static unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
-{
-	struct device_node *np;
-	unsigned int fuse_corner = 0;
-
-	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner))
-		pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
-		       __func__);
-
-	of_node_put(np);
-
-	return fuse_corner;
-}
-
-static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-					    struct device *cpu_dev)
-{
-	u64 rate = 0;
-	struct device_node *ref_np;
-	struct device_node *desc_np;
-	struct device_node *child_np = NULL;
-	struct device_node *child_req_np = NULL;
-
-	desc_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
-	if (!desc_np)
-		return 0;
-
-	ref_np = dev_pm_opp_get_of_node(ref);
-	if (!ref_np)
-		goto out_ref;
-
-	do {
-		of_node_put(child_req_np);
-		child_np = of_get_next_available_child(desc_np, child_np);
-		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
-	} while (child_np && child_req_np != ref_np);
-
-	if (child_np && child_req_np == ref_np)
-		of_property_read_u64(child_np, "opp-hz", &rate);
-
-	of_node_put(child_req_np);
-	of_node_put(child_np);
-	of_node_put(ref_np);
-out_ref:
-	of_node_put(desc_np);
-
-	return (unsigned long) rate;
-}
-
 static int cpr_corner_init(struct cpr_drv *drv)
 {
 	const struct cpr_desc *desc = drv->desc;
@@ -1186,7 +928,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		corner->uV = fuse->uV;
 
 		if (prev_fuse && cdata[i - 1].freq == prev_fuse->max_freq) {
-			scaling = cpr_calculate_scaling(quot_offset, drv,
+			scaling = cpr_calculate_scaling(drv->dev, quot_offset,
 							fdata, corner);
 			if (scaling < 0)
 				return scaling;
@@ -1224,47 +966,6 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	return 0;
 }
 
-static const struct cpr_fuse *cpr_get_fuses(struct cpr_drv *drv)
-{
-	const struct cpr_desc *desc = drv->desc;
-	struct cpr_fuse *fuses;
-	int i;
-
-	fuses = devm_kcalloc(drv->dev, desc->num_fuse_corners,
-			     sizeof(struct cpr_fuse),
-			     GFP_KERNEL);
-	if (!fuses)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < desc->num_fuse_corners; i++) {
-		char tbuf[32];
-
-		snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
-		fuses[i].ring_osc = devm_kstrdup(drv->dev, tbuf, GFP_KERNEL);
-		if (!fuses[i].ring_osc)
-			return ERR_PTR(-ENOMEM);
-
-		snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
-		fuses[i].init_voltage = devm_kstrdup(drv->dev, tbuf,
-						     GFP_KERNEL);
-		if (!fuses[i].init_voltage)
-			return ERR_PTR(-ENOMEM);
-
-		snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
-		fuses[i].quotient = devm_kstrdup(drv->dev, tbuf, GFP_KERNEL);
-		if (!fuses[i].quotient)
-			return ERR_PTR(-ENOMEM);
-
-		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
-		fuses[i].quotient_offset = devm_kstrdup(drv->dev, tbuf,
-							GFP_KERNEL);
-		if (!fuses[i].quotient_offset)
-			return ERR_PTR(-ENOMEM);
-	}
-
-	return fuses;
-}
-
 static void cpr_set_loop_allowed(struct cpr_drv *drv)
 {
 	drv->loop_disabled = false;
@@ -1296,54 +997,6 @@ static int cpr_init_parameters(struct cpr_drv *drv)
 	return 0;
 }
 
-static int cpr_find_initial_corner(struct cpr_drv *drv)
-{
-	unsigned long rate;
-	const struct corner *end;
-	struct corner *iter;
-	unsigned int i = 0;
-
-	if (!drv->cpu_clk) {
-		dev_err(drv->dev, "cannot get rate from NULL clk\n");
-		return -EINVAL;
-	}
-
-	end = &drv->corners[drv->num_corners - 1];
-	rate = clk_get_rate(drv->cpu_clk);
-
-	/*
-	 * Some bootloaders set a CPU clock frequency that is not defined
-	 * in the OPP table. When running at an unlisted frequency,
-	 * cpufreq_online() will change to the OPP which has the lowest
-	 * frequency, at or above the unlisted frequency.
-	 * Since cpufreq_online() always "rounds up" in the case of an
-	 * unlisted frequency, this function always "rounds down" in case
-	 * of an unlisted frequency. That way, when cpufreq_online()
-	 * triggers the first ever call to cpr_set_performance_state(),
-	 * it will correctly determine the direction as UP.
-	 */
-	for (iter = drv->corners; iter <= end; iter++) {
-		if (iter->freq > rate)
-			break;
-		i++;
-		if (iter->freq == rate) {
-			drv->corner = iter;
-			break;
-		}
-		if (iter->freq < rate)
-			drv->corner = iter;
-	}
-
-	if (!drv->corner) {
-		dev_err(drv->dev, "boot up corner not found\n");
-		return -EINVAL;
-	}
-
-	dev_dbg(drv->dev, "boot up perf state: %u\n", i);
-
-	return 0;
-}
-
 static const struct cpr_desc qcs404_cpr_desc = {
 	.num_fuse_corners = 3,
 	.min_diff_quot = CPR_FUSE_MIN_QUOT_DIFF,
@@ -1531,7 +1184,8 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 	if (ret)
 		goto unlock;
 
-	ret = cpr_find_initial_corner(drv);
+	ret = cpr_find_initial_corner(drv->dev, drv->cpu_clk, drv->corners,
+				      drv->num_corners);
 	if (ret)
 		goto unlock;
 
@@ -1616,6 +1270,7 @@ static int cpr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cpr_drv *drv;
+	const struct cpr_desc *desc;
 	int irq, ret;
 	const struct cpr_acc_desc *data;
 	struct device_node *np;
@@ -1631,6 +1286,7 @@ static int cpr_probe(struct platform_device *pdev)
 	drv->dev = dev;
 	drv->desc = data->cpr_desc;
 	drv->acc_desc = data->acc_desc;
+	desc = drv->desc;
 
 	drv->fuse_corners = devm_kcalloc(dev, drv->desc->num_fuse_corners,
 					 sizeof(*drv->fuse_corners),
@@ -1670,11 +1326,13 @@ static int cpr_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drv->cpr_fuses = cpr_get_fuses(drv);
+	drv->cpr_fuses = cpr_get_fuses(drv->dev, desc->num_fuse_corners);
 	if (IS_ERR(drv->cpr_fuses))
 		return PTR_ERR(drv->cpr_fuses);
 
-	ret = cpr_populate_ring_osc_idx(drv);
+	ret = cpr_populate_ring_osc_idx(drv->dev, drv->fuse_corners,
+					drv->cpr_fuses,
+					desc->num_fuse_corners);
 	if (ret)
 		return ret;
 

-- 
2.41.0

