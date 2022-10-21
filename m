Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7349607E15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJUSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJUSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:07:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212545074;
        Fri, 21 Oct 2022 11:07:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so5639982wmc.4;
        Fri, 21 Oct 2022 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyBu08uMqErM+zzJyPRDJRWX5ryfOT/RoKB9om6pnjA=;
        b=A/BU/jZiRtB32rNRZ3uk42wlCkZ0q5PYCdjXNM5anDN7uP4ZkMc+gHIYVpSLGiJujW
         +AgImTmEJnNvDv1Jpx8EZ/FhjCSNge/11n3AJFH/izDKCZq18pYny4VBmWNqv/y+gLhD
         vrqAoskm8yozPhHQwjqkv3GoMUFNYOUoS16Ezwe8z1V/VRI6pExhvduSLI8uqoeYCK9a
         WgcqCMSlOK/OtG5twSUk7+tVoAwU4W4EntifuFzEnL9cbU4K2oR2YwokH1gFAb9RCDQH
         XhG8edIbwb4dz0pStwGxHzbNC9bf4ZqExq1f/k9u5dYcvJfmf8TGogKvPMzCs0AvBH5u
         6H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyBu08uMqErM+zzJyPRDJRWX5ryfOT/RoKB9om6pnjA=;
        b=XmwEsjkGy4vHGxotgOw/c+/NC6iBZcMYsZv4+SZkNHXoovYmGaESM9j1tWfqUy7tZH
         fDmnecmFMlZFvuYp7IZdVtxhj1FLdRZ9HzjAFNnhkWD74FOPl7hroyZtQSd9BjRQaAjg
         6AjiIPIhWjsYxWcpVyKs91MYXhQRgb6qb1sJ6eveVTtqJoWMxH+dc/rJlepA48iaFXn3
         ntPQOZWOaYdAbtlls1ArLlq+sqQmriHHzCsFsEafiKEdkJ1uoqqGcjvAk1g8LkDJxt0x
         nD/qNWaal+daGCzrwJiAd99Yc4vuaMv6mU4pRhUdIibQ86/vw+M/d+ipVDf1cjeHsbr4
         FptQ==
X-Gm-Message-State: ACrzQf1sHJ5b7OKZowmVJZ6j/0H74VYgcnIXJFaoOjiHj+PiIkYxmA6t
        Gisi+dtZ6dkujt7ab/D61y5MtA5p8us=
X-Google-Smtp-Source: AMsMyM5WhLtocC+yqXsOASdbkJzn/8S+bFisKIB4l0D32Ur31PZ/gg5U5fyjHf8YDgMdeLIkEPu+wA==
X-Received: by 2002:a05:600c:4449:b0:3c6:fb65:2463 with SMTP id v9-20020a05600c444900b003c6fb652463mr14122585wmn.128.1666375631691;
        Fri, 21 Oct 2022 11:07:11 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id n4-20020a1ca404000000b003c41144b3cfsm280348wme.20.2022.10.21.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:07:11 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [RFC PATCH 1/2] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Fri, 21 Oct 2022 20:06:56 +0200
Message-Id: <20221021180657.13474-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RCG frequency can be reached by multiple configuration.

We currently declare multiple configuration for the same frequency but
that is not supported and always the first configuration will be taken.

These multiple configuration are needed as based on the current parent
configuration, it may be needed to use a different configuration to
reach the same frequency.

To handle this introduce 2 new macro, FM and C.

- FM is used to declare an empty freq_tbl with just the frequency and an
  array of confs to insert all the config for the provided frequency.

- C is used to declare a fre_conf where src, pre_div, m and n are
  provided.

The driver is changed to handle this special freq_tbl and select the
correct config by calculating the final rate and deciding based on the
one that is less different than the requested one.

Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  | 14 ++++++-
 drivers/clk/qcom/clk-rcg2.c | 84 +++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 01581f4d2c39..18f4f7b59f36 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -7,7 +7,17 @@
 #include <linux/clk-provider.h>
 #include "clk-regmap.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n), 0, NULL }
+
+#define FM(_f, _confs) { .freq = (_f), .confs_num = ARRAY_SIZE(_confs), .confs = (_confs) }
+#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
+
+struct freq_conf {
+	u8 src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
 
 struct freq_tbl {
 	unsigned long freq;
@@ -15,6 +25,8 @@ struct freq_tbl {
 	u8 pre_div;
 	u16 m;
 	u16 n;
+	int confs_num;
+	const struct freq_conf *confs;
 };
 
 /**
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 76551534f10d..7d3b59ec2b50 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -209,11 +209,60 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
 }
 
+static void
+clk_rcg2_select_conf(struct clk_hw *hw, struct freq_tbl *f_tbl,
+		     const struct freq_tbl *f, unsigned long req_rate)
+{
+	unsigned long best_rate = 0, parent_rate, rate;
+	const struct freq_conf *conf, *best_conf;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *p;
+	int index, i;
+
+	/* Search in each provided config the one that is near the wanted rate */
+	for (i = 0, conf = f->confs; i < f->confs_num; i++, conf++) {
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
+	if (unlikely(i == f->confs_num))
+		best_conf = f->confs;
+
+	/* Apply the config */
+	f_tbl->src = best_conf->src;
+	f_tbl->pre_div = best_conf->pre_div;
+	f_tbl->m = best_conf->m;
+	f_tbl->n = best_conf->n;
+}
+
 static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 				    struct clk_rate_request *req,
 				    enum freq_policy policy)
 {
 	unsigned long clk_flags, rate = req->rate;
+	struct freq_tbl f_tbl;
 	struct clk_hw *p;
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int index;
@@ -232,7 +281,15 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	if (!f)
 		return -EINVAL;
 
-	index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+	f_tbl = *f;
+	/*
+	 * A single freq may be reached by multiple configuration.
+	 * Try to find the bast one if we have this kind of freq_table.
+	 */
+	if (f->confs)
+		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
+
+	index = qcom_find_src_index(hw, rcg->parent_map, f_tbl.src);
 	if (index < 0)
 		return index;
 
@@ -242,18 +299,18 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 		return -EINVAL;
 
 	if (clk_flags & CLK_SET_RATE_PARENT) {
-		rate = f->freq;
-		if (f->pre_div) {
+		rate = f_tbl.freq;
+		if (f_tbl.pre_div) {
 			if (!rate)
 				rate = req->rate;
 			rate /= 2;
-			rate *= f->pre_div + 1;
+			rate *= f_tbl.pre_div + 1;
 		}
 
-		if (f->n) {
+		if (f_tbl.n) {
 			u64 tmp = rate;
-			tmp = tmp * f->n;
-			do_div(tmp, f->m);
+			tmp = tmp * f_tbl.n;
+			do_div(tmp, f_tbl.m);
 			rate = tmp;
 		}
 	} else {
@@ -261,7 +318,7 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	}
 	req->best_parent_hw = p;
 	req->best_parent_rate = rate;
-	req->rate = f->freq;
+	req->rate = f_tbl.freq;
 
 	return 0;
 }
@@ -357,6 +414,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
+	struct freq_tbl f_tbl;
 
 	switch (policy) {
 	case FLOOR:
@@ -372,7 +430,15 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!f)
 		return -EINVAL;
 
-	return clk_rcg2_configure(rcg, f);
+	f_tbl = *f;
+	/*
+	 * A single freq may be reached by multiple configuration.
+	 * Try to find the best one if we have this kind of freq_table.
+	 */
+	if (f->confs)
+		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
+
+	return clk_rcg2_configure(rcg, &f_tbl);
 }
 
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.37.2

