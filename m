Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A72740360
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjF0Sb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjF0SbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:31:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949AF2136
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so2340885e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687890656; x=1690482656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkQQqQJBkigffDmhtNIm3YBnBUMc7A/gmcyMZwyz77Q=;
        b=QrpuhZInzQZAGUoABFBFuXGaSmongDUALk++ZbvkaGC8HreMw9VxiomW6yNRokoiLi
         jNa3f/J89XbSpm0MhiLHL2T+BsIC3YSpx2byT0Dp6w0sVi7FwqObAzPDIWnnXvKnA4H4
         u3Hnrw2rsLAeUACcYUT7Y9/VnZfqmRUGwZFp84gj7+KI6ojNcskZOAqPPuvrv7KC4vxR
         GShAmAr/tRYmZapVm188K6lhjLRO1vF8tzsdvltKfpugdHGwRB6XFOFtkCX2eBH6ydFh
         zauPbbyiInn96M2IXMNCKu6M5rRG974j50O6MgQph2RdTjpe+vzPOMcbUvjRSbVqTzv4
         eQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890656; x=1690482656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkQQqQJBkigffDmhtNIm3YBnBUMc7A/gmcyMZwyz77Q=;
        b=YXox/go06vGbhR7EWC+OgfvYxQbGu7oaarah8dtA91XGqbE81x+Bko1m7Un7RQHJTy
         izEXYKgOB0d+6WRmG6Pbox38Vgr9Czj0371Gi/JedauGBsB2BG722IeCpTT/CI2J2c7f
         QE/X8htxUX8sr4/WUCIyeL4+jxlBh/8kCUOY+EMXX9qVhZw6LtUnLSaCnMZUMmUMVYyE
         6nJDqt5OyrZby7KRy/7j9aKbsTXhyZ2QwArqN3LYjcLSrKdzCRKgetPjaRNNB1E2DXsp
         QFApOGHNRE0jAbwbUJP0gOp50L0ZnBhCy/SgUqxsj4MR4LKH9KJJnahQbBelkaUiyeEA
         X3ow==
X-Gm-Message-State: AC+VfDwR6XNsTPDG1IEN00w2bY/QRyG6HN043NEq0ToWuxNaPncej4ml
        beGs/z+DSb57mp7sGvw8LGs2Fg==
X-Google-Smtp-Source: ACHHUZ5gyR7DTNsVwAmGBMl8zbrNKKPOeSPoqf9qDCqSKi/2cUWTAbBrbMvKFHO9Fkqkth2td0ZBEA==
X-Received: by 2002:a19:6451:0:b0:4f8:752f:df48 with SMTP id b17-20020a196451000000b004f8752fdf48mr14372841lfj.29.1687890656699;
        Tue, 27 Jun 2023 11:30:56 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f640b0fb04sm1605205lfm.212.2023.06.27.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:30:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 20:30:42 +0200
Subject: [PATCH v11 6/9] soc: qcom: cpr: Use u64 for frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v11-6-ba22b4daa5d6@linaro.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
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
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687890646; l=4255;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5lISyMajI0QuaPVCewELDdheNorBf2jroUKbuMI7CmE=;
 b=ogpADc5PtEaeSWDST+wiyRXnOKos29zchdRuuOh1JXCFIW3Oo4IKrJEOVll3M2bAm+jYo4nCp
 baMHk6HnViOAICgduuR9kKHilrKdCd8Db9qR4FqZDkl2hfK7mgzRVMG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 bits is not enough for over-2.changeGHz frequencies. Move all variables
that operate on Hz to u64 to avoid overflows.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/cpr-common.c | 13 +++++++------
 drivers/soc/qcom/cpr-common.h |  9 ++++-----
 drivers/soc/qcom/cpr.c        |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
index 44c681bbbf13..3e3a4a61cfde 100644
--- a/drivers/soc/qcom/cpr-common.c
+++ b/drivers/soc/qcom/cpr-common.c
@@ -218,7 +218,7 @@ unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(cpr_get_fuse_corner);
 
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 				     struct device *cpu_dev)
 {
 	u64 rate = 0;
@@ -250,7 +250,7 @@ unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 out_ref:
 	of_node_put(desc_np);
 
-	return (unsigned long) rate;
+	return rate;
 }
 EXPORT_SYMBOL_GPL(cpr_get_opp_hz_for_req);
 
@@ -260,7 +260,7 @@ int cpr_calculate_scaling(struct device *dev,
 			  const struct corner *corner)
 {
 	u32 quot_diff = 0;
-	unsigned long freq_diff;
+	u64 freq_diff;
 	int scaling;
 	const struct fuse_corner *fuse, *prev_fuse;
 	int ret;
@@ -280,8 +280,9 @@ int cpr_calculate_scaling(struct device *dev,
 	}
 
 	freq_diff = fuse->max_freq - prev_fuse->max_freq;
-	freq_diff /= 1000000; /* Convert to MHz */
-	scaling = 1000 * quot_diff / freq_diff;
+	freq_diff = div_u64(freq_diff, 1000000); /* Convert to MHz */
+	scaling = 1000 * quot_diff;
+	do_div(scaling, freq_diff);
 	return min(scaling, fdata->max_quot_scale);
 }
 EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
@@ -289,7 +290,7 @@ EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
 int cpr_interpolate(const struct corner *corner, int step_volt,
 		    const struct fuse_corner_data *fdata)
 {
-	unsigned long f_high, f_low, f_diff;
+	u64 f_high, f_low, f_diff;
 	int uV_high, uV_low, uV;
 	u64 temp, temp_limit;
 	const struct fuse_corner *fuse, *prev_fuse;
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
index 0aa227617d2f..1b2fa344eb09 100644
--- a/drivers/soc/qcom/cpr-common.h
+++ b/drivers/soc/qcom/cpr-common.h
@@ -42,7 +42,7 @@ struct fuse_corner {
 	int step_quot;
 	const struct reg_sequence *accs;
 	int num_accs;
-	unsigned long max_freq;
+	u64 max_freq;
 	u8 ring_osc_idx;
 };
 
@@ -54,13 +54,13 @@ struct corner {
 	int quot_adjust;
 	u32 save_ctl;
 	u32 save_irq;
-	unsigned long freq;
+	u64 freq;
 	struct fuse_corner *fuse_corner;
 };
 
 struct corner_data {
 	unsigned int fuse_corner;
-	unsigned long freq;
+	u64 freq;
 };
 
 struct acc_desc {
@@ -92,8 +92,7 @@ int cpr_populate_fuse_common(struct device *dev,
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
 u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev);
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
 			  const struct fuse_corner_data *fdata,
diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index cc1e4c462d1f..33066b8b2811 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -827,8 +827,8 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	struct corner_data *cdata;
 	const struct fuse_corner_data *fdata;
 	bool apply_scaling;
-	unsigned long freq_diff, freq_diff_mhz;
-	unsigned long freq;
+	unsigned long freq_diff_mhz;
+	u64 freq, freq_diff;
 	int step_volt = regulator_get_linear_step(drv->vdd_apc);
 	struct dev_pm_opp *opp;
 
@@ -941,7 +941,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 
 		if (apply_scaling) {
 			freq_diff = fuse->max_freq - corner->freq;
-			freq_diff_mhz = freq_diff / 1000000;
+			freq_diff_mhz = (u32)div_u64(freq_diff, 1000000);
 			corner->quot_adjust = scaling * freq_diff_mhz / 1000;
 
 			corner->uV = cpr_interpolate(corner, step_volt, fdata);

-- 
2.41.0

