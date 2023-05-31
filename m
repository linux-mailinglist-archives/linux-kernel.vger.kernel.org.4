Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC6718E87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEaW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjEaW2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:28:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDCE40;
        Wed, 31 May 2023 15:28:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so36467e87.3;
        Wed, 31 May 2023 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685572093; x=1688164093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70rKVpOd5wJ3gBObsOuE50d5h49q/cRV9IOkJxvD4f0=;
        b=FNurri+x8xi17/7oHhHUw3Kt6VJx87UgXVgwEmAcmGDK4p60HAeOYOqDrAWEaL0xhT
         H1Iu+gTJLDA5y+JBsGkmewDxBux106wP2O+DWq1hdeS4ce+hs6iC74krSk/T3HEGuTPq
         IjmOYj692HbBg1cjMQ9dkWKL/IyuwlJRQQiEXFPNp9xk8XwRaOjX3HDATLp6/rlYL4y4
         bicp9Let1nXPSej584nXhu43wD3nFhn8a3XayLBLwiaqWn/5+GRzgVb8mJc4v27tOLe4
         qAjHjdD+IN5LuMkhnhfJ3Mk3Tdj2O5xBmLx6xzR34uoJtr20q2xAzOQvwhWZVHRh7gxM
         omGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572093; x=1688164093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70rKVpOd5wJ3gBObsOuE50d5h49q/cRV9IOkJxvD4f0=;
        b=ehQdX1ifo3GkCL6zFvPXR0tmM+kyHoge85hIycsbusxZNdbQaOH1hMQS+fgT0XyEWN
         +OZpDvd9vwVWPIW/+po8b3wYW2i2jL7Kx5+4BHx4tWegoA5Ebr1Z4ohHGYghDU395o+n
         PAcbFeY+jBGai0+UZOVoJGjCQa5LPNWWZOXnTdflhJBUlQ7e7/USGDKb+yeTCneGYmoP
         D2EJm97bnSSR8JrU/IMAP5I/0PIaY51NnNG/IsSSbOIGk9L2mQ3GYTMCNeUp/Wjs+HzM
         y6jk50U2oI//hFW+tgZ5jf1ARgykBW9C12eQFu//pYTzITllqQMCy/rk8Lg2LhBuV8ho
         fRSQ==
X-Gm-Message-State: AC+VfDz0Fiqre+7Wjd7ddmf8iL1QCxqkNL5J+oZOV2bwbo4tiG3yCO94
        vF1CSpCbQ/qIY7T6CpxSCrhGI6K1CdY=
X-Google-Smtp-Source: ACHHUZ4C3xtfKqlv5GcUGqROnl6/se6nIKa97hzQo4+3AcfexBgCvpnYiHmOSq+IfHOF+fElmb3CHQ==
X-Received: by 2002:ac2:430f:0:b0:4f4:b28d:73eb with SMTP id l15-20020ac2430f000000b004f4b28d73ebmr185558lfh.12.1685572092464;
        Wed, 31 May 2023 15:28:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c028900b003f6132f95e6sm70020wmk.35.2023.05.31.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:28:03 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v5 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
Date:   Thu,  1 Jun 2023 00:26:53 +0200
Message-Id: <20230531222654.25475-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531222654.25475-1-ansuelsmth@gmail.com>
References: <20230531222654.25475-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
If a conf can't be found due to parent not reachable, a WARN is printed
and -EINVAL is returned.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  |   1 +
 drivers/clk/qcom/clk-rcg2.c | 163 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  18 ++++
 drivers/clk/qcom/common.h   |   2 +
 4 files changed, 184 insertions(+)

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
index 76551534f10d..9a139fc8bbfa 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -266,6 +266,112 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	return 0;
 }
 
+static const struct freq_conf *
+__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
+		       unsigned long req_rate)
+{
+	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
+	const struct freq_conf *conf, *best_conf;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const char *name = clk_hw_get_name(hw);
+	unsigned long parent_rate, rate;
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
+		rate_diff = abs(req_rate - rate);
+		if (rate_diff < best_rate_diff) {
+			best_rate_diff = rate_diff;
+			best_conf = conf;
+		}
+	}
+
+	/*
+	 * Very unlikely. Warn if we couldn't find a correct config
+	 * due to parent not present.
+	 */
+	if (unlikely(i == f->num_confs)) {
+		WARN(1, "%s: can't find a configuration for rate %lu.",
+		     name, req_rate);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return best_conf;
+}
+
+static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
+				       struct clk_rate_request *req)
+{
+	unsigned long clk_flags, rate = req->rate;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_conf *conf;
+	struct clk_hw *p;
+	int index;
+
+	f = qcom_find_freq_multi(f, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
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
@@ -282,6 +388,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
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
@@ -375,6 +489,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
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
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
+
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
@@ -387,6 +525,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -399,6 +543,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
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
@@ -509,6 +659,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
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

