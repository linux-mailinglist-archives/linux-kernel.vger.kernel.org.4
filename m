Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EE74134E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjF1ODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjF1OBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:01:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE430D8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:01:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so4929057e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960859; x=1690552859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqEu13zU8yL/k2MIrt/7DelQ5S48Y7ED1AMrbjwM43Y=;
        b=nJAIiKuBS93A+kvHakGLMPDVP8j1gnHcuI+Xk1F1DhSvsHjTRgeF/oTMGQtZpHE38y
         5s5e85igrMv71jxvnDWxIHfMrPXjAOoU8nFT6/aA8YajJFxZdNIHDySdSQ3GWqhJO8wi
         2NlpmI85/gm2uU+9i1JJbQkCvTHmI1dvyo5qYdaol9FOKOD+EIuv5AT+fMU7KUkD6bow
         ADd1fvEMhmEW09b2jEDFetJwxeNVB0iXWO6iHJvwvyE26qfkQieGF/bXkIX7uW+r2rtS
         b9dLEvh8kCkcKob7aH8Uvvo1XPXIVe9EoBQfzLsip/4GBWwOHBGrvlo/JEdCQnweTtQH
         5DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960859; x=1690552859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqEu13zU8yL/k2MIrt/7DelQ5S48Y7ED1AMrbjwM43Y=;
        b=K4jaw2EKtqvRjYZ1CNAhQw4h/lXxNk5kWCqfD2YOB+RsP4Vr/oCrDUsGZ16cWJthIY
         rabjZUPaDiZRoA4dC1h3rQ8TN6fBDNsFWsbUz9+X0apiRlto/f96FEV9BlhHxawLmow5
         +oFV7ymQVaT6wv+Jy436W6JGbh/KU1Z2a8fr8B0nOej2oJBoGV2X5c2f2OPiWS5XLQ1L
         nIlBhwclsIR+lU40P789WVSqqOH7E61ikwto5Qd6N/LP4zmcBeSF4MOdBsFKOYp9Af1I
         2JPTR/3AKGRKBdvCLlruGqRALkxJz/JlIKrjuuf1UcdXPIlbGD38Sdrc6Ys7TiNsRYR9
         EsbA==
X-Gm-Message-State: AC+VfDwX3YvvnVynyipHKUtE3jRrl+rQJjIe08X+jFG576jPu8xbnn78
        3BQENqjD7kAhwwMNBtjmaQ9phQ==
X-Google-Smtp-Source: ACHHUZ5BhriSAHojjwk3P2cJXs2qF0Efo/9jFLbw7JcXEo8bsSSdsqklP91mxTS5BFIaiDhIMh6Rzg==
X-Received: by 2002:a05:6512:ace:b0:4fb:8bad:1cdf with SMTP id n14-20020a0565120ace00b004fb8bad1cdfmr2863659lfu.42.1687960859575;
        Wed, 28 Jun 2023 07:00:59 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:47 +0200
Subject: [PATCH v12 08/10] soc: qcom: cpr-common: Add threads support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-8-1a4d050e1e67@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960842; l=6300;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AmdIHRQt1IfT1bayaE8b01VCVDroKAlvOlp4kw5cvQM=;
 b=FYKp7AAyjoGqHhecfuZyCDgIFWf0NWf6sV5qWWbi6BzZzhB6dc8ZgA5hLLINtqNzF/AKW3QU+
 eqwpvTK239gDzxinCj3AuG4uVyQhp61m8yU0PPq9UPmEByfDf/zZZqO
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

Add support for parsing per-CPR-thread data in preparation for introducing
CPR3+ support.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/cpr-common.c | 42 +++++++++++++++++++++++++-----------------
 drivers/soc/qcom/cpr-common.h |  8 ++++++--
 drivers/soc/qcom/cpr.c        |  4 ++--
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
index 3e3a4a61cfde..9001dccd4d95 100644
--- a/drivers/soc/qcom/cpr-common.c
+++ b/drivers/soc/qcom/cpr-common.c
@@ -73,35 +73,42 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
-const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
 				     unsigned int num_fuse_corners)
 {
 	struct cpr_fuse *fuses;
-	int i;
+	char cpr_name[11]; /* length of "cpr" + length of UINT_MAX (7) + \0 */
+	unsigned int i;
 
 	fuses = devm_kcalloc(dev, num_fuse_corners, sizeof(*fuses), GFP_KERNEL);
 	if (!fuses)
 		return ERR_PTR(-ENOMEM);
 
+	/* Support legacy bindings */
+	if (tid == UINT_MAX)
+		snprintf(cpr_name, sizeof(cpr_name), "cpr");
+	else
+		snprintf(cpr_name, sizeof(cpr_name), "cpr%d", tid);
+
 	for (i = 0; i < num_fuse_corners; i++) {
-		char tbuf[32];
+		char tbuf[50];
 
-		snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_ring_osc%d", cpr_name, i + 1);
 		fuses[i].ring_osc = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].ring_osc)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_init_voltage%d", cpr_name, i + 1);
 		fuses[i].init_voltage = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].init_voltage)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient%d", cpr_name, i + 1);
 		fuses[i].quotient = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].quotient)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient_offset%d", cpr_name, i + 1);
 		fuses[i].quotient_offset = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].quotient_offset)
 			return ERR_PTR(-ENOMEM);
@@ -202,15 +209,15 @@ int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 }
 EXPORT_SYMBOL_GPL(cpr_find_initial_corner);
 
-unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
+unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid)
 {
 	struct device_node *np;
 	unsigned int fuse_corner = 0;
 
 	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner))
-		pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
-		       __func__);
+	if (of_property_read_u32_index(np, "qcom,opp-fuse-level", tid, &fuse_corner))
+		pr_err("%s: missing 'qcom,opp-fuse-level[%u]' property\n",
+		       __func__, tid);
 
 	of_node_put(np);
 
@@ -235,15 +242,16 @@ u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 	if (!ref_np)
 		goto out_ref;
 
-	do {
-		of_node_put(child_req_np);
-		child_np = of_get_next_available_child(desc_np, child_np);
+	for_each_available_child_of_node(desc_np, child_np) {
 		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
-	} while (child_np && child_req_np != ref_np);
 
-	if (child_np && child_req_np == ref_np)
-		of_property_read_u64(child_np, "opp-hz", &rate);
+		if (child_np && child_req_np == ref_np) {
+			of_property_read_u64(child_np, "opp-hz", &rate);
+			goto out;
+		}
+	}
 
+out:
 	of_node_put(child_req_np);
 	of_node_put(child_np);
 	of_node_put(ref_np);
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
index 1b2fa344eb09..2c5bb81ab713 100644
--- a/drivers/soc/qcom/cpr-common.h
+++ b/drivers/soc/qcom/cpr-common.h
@@ -22,6 +22,9 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int range_uV;
+	/* fuse volt: closed/open loop */
+	int volt_cloop_adjust;
 	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
@@ -55,6 +58,7 @@ struct corner {
 	u32 save_ctl;
 	u32 save_irq;
 	u64 freq;
+	bool is_open_loop;
 	struct fuse_corner *fuse_corner;
 };
 
@@ -81,7 +85,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 			      struct fuse_corner *fuse_corner,
 			      const struct cpr_fuse *cpr_fuse,
 			      int num_fuse_corners);
-const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
 				     unsigned int num_fuse_corners);
 int cpr_populate_fuse_common(struct device *dev,
 			     struct fuse_corner_data *fdata,
@@ -91,7 +95,7 @@ int cpr_populate_fuse_common(struct device *dev,
 			     int init_v_step);
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
-u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
+u32 cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid);
 u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 49c33b13b82b..bd94e19fc0fb 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -852,7 +852,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		opp = dev_pm_opp_find_level_exact(&drv->pd.dev, level);
 		if (IS_ERR(opp))
 			return -EINVAL;
-		fc = cpr_get_fuse_corner(opp);
+		fc = cpr_get_fuse_corner(opp, 0);
 		if (!fc) {
 			dev_pm_opp_put(opp);
 			return -EINVAL;
@@ -1326,7 +1326,7 @@ static int cpr_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drv->cpr_fuses = cpr_get_fuses(drv->dev, desc->num_fuse_corners);
+	drv->cpr_fuses = cpr_get_fuses(drv->dev, UINT_MAX, desc->num_fuse_corners);
 	if (IS_ERR(drv->cpr_fuses))
 		return PTR_ERR(drv->cpr_fuses);
 

-- 
2.41.0

