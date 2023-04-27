Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21D46F0F75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjD1AUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbjD1AUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:20:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B8A2D40;
        Thu, 27 Apr 2023 17:20:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f315712406so42066125e9.0;
        Thu, 27 Apr 2023 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682641199; x=1685233199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjgmSphlr8wzT6GzicESPhoyem6K6zPb+7Q5cbMxQ78=;
        b=TINn2R3TwHNp31OxMCMnk5mSwDYByDg18LvqG2LkjNfPk6PscJtHhZ34t8foNU4g+m
         EVQPsjaQpPI32O8YybtjbGs3zXHU98FnVxiy/dJUWVIhMkj1YLkJDK29s23bziIt21wI
         AQ77VIBVsxcAVOvW+k3QK9in0cg2TcQJwMEp0n26vyoS65NFbb9dkHSdCD+/kZAz07X/
         2arTUjEwMOoGk1f5vUUITyeZAv0oFvAbz+84S6aRrxrTQMa6XzwM919rXxWITznD3X7H
         mNWzkz69y6CijUbT3fAwTAXwUWYxyFNmZ//tcFeSzZZ4raRxGiRVIcH36vUaCnF5s0hP
         nWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641199; x=1685233199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjgmSphlr8wzT6GzicESPhoyem6K6zPb+7Q5cbMxQ78=;
        b=dIkyxZGgM7+zoxVFJL1H+aJbJED8HzY/y0+c7QwrjVG0j6mNbYNaWw3ZG9rv6ZvBQS
         VYsEVzs2NgOXMurasDoBYkEyHBvlN+t/pJO+qzsn/TAdfGs0NYk1Zc2DwWBt2w4hHSx+
         Po74m8742NP7uvnRZez9l9lDiVOSw0QWDOum6OOQClaLaygI+F4Dui4WzNJJIZqemz7N
         cAS2ytwCuTris0y5TeOwJasxnVdfisMYMApe0TLvb+YgcRuyxDaAg0ffoqZJGgcD+k3q
         6bgpXg9+NVfgYr5ErA5CwFBp6/uWwjMVWboxtUYtMOuIgNwvjOT6dv7Dow/DfFt66A/+
         WrLw==
X-Gm-Message-State: AC+VfDy+u7+8+jz9AXR6+r9ve+OdsGcJV8ZSSolnjmzCRa0IP/w6X3pI
        ceYjIYgQRaXFQhjLbMUYaao=
X-Google-Smtp-Source: ACHHUZ7G4YZdncJM7U+/Tr4/8Oqe45czbkI8CGysn1uSA+HNHQLHABcwYD9rHzZ266KfuCyT5HhmIw==
X-Received: by 2002:a5d:6a43:0:b0:2f8:33bd:a170 with SMTP id t3-20020a5d6a43000000b002f833bda170mr5416047wrw.32.1682641199442;
        Thu, 27 Apr 2023 17:19:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id d3-20020a05600c3ac300b003f19b3d89e9sm16362095wms.33.2023.04.27.17.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 17:19:59 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
Date:   Thu, 27 Apr 2023 17:07:16 +0200
Message-Id: <20230427150717.20860-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427150717.20860-1-ansuelsmth@gmail.com>
References: <20230427150717.20860-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RCG frequency can be reached by multiple configuration.

Add clk_rcg2_fm_ops ops to support these special RCG configurations.

These alternative ops will select the frequency using a CEIL policy.

When the correct frequency is found, the correct config is selected by
calculating the final rate (by checking the defined parent and values
in the config that is being checked) and deciding based on the one that
is less different than the requested one.

These check are skipped if there is just on config for the requested
freq.

qcom_find_freq_multi is added to search the freq with the new struct
freq_multi_tbl.
__clk_rcg2_select_conf is used to select the correct conf by simulating
the final clock.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  |   1 +
 drivers/clk/qcom/clk-rcg2.c | 152 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  18 +++++
 drivers/clk/qcom/common.h   |   2 +
 4 files changed, 173 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index dc85b46b0d79..f8ec989ed3d9 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -188,6 +188,7 @@ struct clk_rcg2_gfx3d {
 
 extern const struct clk_ops clk_rcg2_ops;
 extern const struct clk_ops clk_rcg2_floor_ops;
+extern const struct clk_ops clk_rcg2_fm_ops;
 extern const struct clk_ops clk_rcg2_mux_closest_ops;
 extern const struct clk_ops clk_edp_pixel_ops;
 extern const struct clk_ops clk_byte_ops;
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 76551534f10d..4f2fe012ef5f 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -266,6 +266,104 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	return 0;
 }
 
+static const struct freq_conf *
+__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
+		       unsigned long req_rate)
+{
+	unsigned long best_rate = 0, parent_rate, rate;
+	const struct freq_conf *conf, *best_conf;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *p;
+	int index, i;
+
+	/* Exit early if only one config is defined */
+	if (f->num_confs == 1)
+		return f->confs;
+
+	/* Search in each provided config the one that is near the wanted rate */
+	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
+		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+		if (index < 0)
+			continue;
+
+		p = clk_hw_get_parent_by_index(hw, index);
+		if (!p)
+			continue;
+
+		parent_rate =  clk_hw_get_rate(p);
+		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
+
+		if (rate == req_rate) {
+			best_conf = conf;
+			break;
+		}
+
+		if (abs(req_rate - rate) < abs(best_rate - rate)) {
+			best_rate = rate;
+			best_conf = conf;
+		}
+	}
+
+	/*
+	 * Very unlikely.
+	 * Force the first conf if we can't find a correct config.
+	 */
+	if (unlikely(i == f->num_confs))
+		best_conf = f->confs;
+
+	return best_conf;
+}
+
+static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
+				       struct clk_rate_request *req)
+{
+	unsigned long clk_flags, rate = req->rate;
+	const struct freq_conf *conf;
+	struct clk_hw *p;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int index;
+
+	f = qcom_find_freq_multi(f, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+	if (index < 0)
+		return index;
+
+	clk_flags = clk_hw_get_flags(hw);
+	p = clk_hw_get_parent_by_index(hw, index);
+	if (!p)
+		return -EINVAL;
+
+	if (clk_flags & CLK_SET_RATE_PARENT) {
+		rate = f->freq;
+		if (conf->pre_div) {
+			if (!rate)
+				rate = req->rate;
+			rate /= 2;
+			rate *= conf->pre_div + 1;
+		}
+
+		if (conf->n) {
+			u64 tmp = rate;
+
+			tmp = tmp * conf->n;
+			do_div(tmp, conf->m);
+			rate = tmp;
+		}
+	} else {
+		rate =  clk_hw_get_rate(p);
+	}
+
+	req->best_parent_hw = p;
+	req->best_parent_rate = rate;
+	req->rate = f->freq;
+
+	return 0;
+}
+
 static int clk_rcg2_determine_rate(struct clk_hw *hw,
 				   struct clk_rate_request *req)
 {
@@ -282,6 +380,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
 	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
 }
 
+static int clk_rcg2_fm_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return _freq_tbl_fm_determine_rate(hw, rcg->freq_multi_tbl, req);
+}
+
 static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
 				u32 *_cfg)
 {
@@ -375,6 +481,27 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	return clk_rcg2_configure(rcg, f);
 }
 
+static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_multi_tbl *f;
+	const struct freq_conf *conf;
+	struct freq_tbl f_tbl;
+
+	f = qcom_find_freq_multi(rcg->freq_multi_tbl, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	f_tbl.freq = f->freq;
+	f_tbl.src = conf->src;
+	f_tbl.pre_div = conf->pre_div;
+	f_tbl.m = conf->m;
+	f_tbl.n = conf->n;
+
+	return clk_rcg2_configure(rcg, &f_tbl);
+}
+
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
@@ -387,6 +514,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
+static int clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	return __clk_rcg2_fm_set_rate(hw, rate);
+}
+
 static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
@@ -399,6 +532,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
+static int clk_rcg2_fm_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_fm_set_rate(hw, rate);
+}
+
 static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -509,6 +648,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
 
+const struct clk_ops clk_rcg2_fm_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_fm_determine_rate,
+	.set_rate = clk_rcg2_fm_set_rate,
+	.set_rate_and_parent = clk_rcg2_fm_set_rate_and_parent,
+	.get_duty_cycle = clk_rcg2_get_duty_cycle,
+	.set_duty_cycle = clk_rcg2_set_duty_cycle,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_fm_ops);
+
 const struct clk_ops clk_rcg2_mux_closest_ops = {
 	.determine_rate = __clk_mux_determine_rate_closest,
 	.get_parent = clk_rcg2_get_parent,
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..48f81e3a5e80 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -41,6 +41,24 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(qcom_find_freq);
 
+const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
+						  unsigned long rate)
+{
+	if (!f)
+		return NULL;
+
+	if (!f->freq)
+		return f;
+
+	for (; f->freq; f++)
+		if (rate <= f->freq)
+			return f;
+
+	/* Default to our fastest rate */
+	return f - 1;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq_multi);
+
 const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
 					    unsigned long rate)
 {
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..2d4a8a837e6c 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -45,6 +45,8 @@ extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
 					     unsigned long rate);
 extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
 						   unsigned long rate);
+extern const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
+							 unsigned long rate);
 extern void
 qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
 extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
-- 
2.39.2

