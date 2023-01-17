Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7458866DFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjAQNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjAQNz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110846B0;
        Tue, 17 Jan 2023 05:55:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so22302719wmo.1;
        Tue, 17 Jan 2023 05:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhP2Z3yR2g3hqw76duqiBKeqsfWvBoTj0uC4C1GeBLg=;
        b=UsKMQ9fod7JZTu7NuyHtS7gJZKPuu1OPsXPKImDikndp9qUpsPgMNMtk5nDBJuWgdd
         LB+yNd1XQFeml/ASr2RqOc7b0UuLz9xIMO0ehNdNqQXe/DbSbnZXnNrjNAXh2V58cdKg
         UddBLjUwFy+6QidN7kRgzQPeQGNUVSwWQ70RePZdDfziRzOLCFBRhbJZ/mPpXhAQfgiO
         /ihJQ52vG1K1/ih6g613rnRT/XywRxQc1X5CSO/2pegQAUeXE4ZIEsKg58AO+R62qDRd
         XWPDB+EQVZeQON2cQA8c0T8CfzTM4WIVTbMzPOwK41kP6N2XP2D4aM0paU5HRj2wzxvs
         Ay2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhP2Z3yR2g3hqw76duqiBKeqsfWvBoTj0uC4C1GeBLg=;
        b=QEKcNoCIzU4AcIMZlUBaCpXr1kcWQZhAbPkEfd1rX43gv/a5D+LMq8LKifnEjSQfS4
         x4OY7Ax/xW7djTWSwjjv33NXPW3UUQnDHJ+IHMWZlIEe6aP9Ok34MwC/GZ+nYXG79Pqe
         ty6LsknjT8OUJbR/rUnfFhhcjqXjxUvcqeDWbZtyuHTwthJCSKykCORhpsTs192wLDmJ
         ccEh3x25QU9qf1NV3+6LWURxO0E6BnDoNh6Zv80s86zZ0tUEmQJNXNuCHLQv47IUCRcx
         z+1BYfYiAkPIx5edTFWB4ZDmWJBt3Wa1wOGfqBgHg1n/V9HQMcpM3Tkqg8d6kwuuvdbp
         XJww==
X-Gm-Message-State: AFqh2ko6Rzs8pFS2/Vv5g/KqNZCieoSaWeXcvz62X5bfEi8oMPqPHsrZ
        cxBNeaKa6NgCXZUZuvJhyLQ=
X-Google-Smtp-Source: AMrXdXs12ZNcX23fFpd/XDrzWfgrI5hwYBcRzdNSif+Ayc8ml79oxxhLSuCxCRkmAf99TMob9QVyEg==
X-Received: by 2002:a05:600c:34d1:b0:3da:faf6:54d1 with SMTP id d17-20020a05600c34d100b003dafaf654d1mr3088821wmq.35.1673963724921;
        Tue, 17 Jan 2023 05:55:24 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:24 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 5/6] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Tue, 17 Jan 2023 14:54:58 +0100
Message-Id: <20230117135459.16868-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117135459.16868-1-ansuelsmth@gmail.com>
References: <20230117135459.16868-1-ansuelsmth@gmail.com>
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

- C is used to declare a freq_conf where src, pre_div, m and n are
  provided.

The driver is changed to handle this special freq_tbl and select the
correct config by calculating the final rate and deciding based on the
one that is less different than the requested one.
Function set_rate(_and_parent) will then select the config based on the
current or the requested parent for the set_rate_and_parent variant.

Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  |  14 +++-
 drivers/clk/qcom/clk-rcg2.c | 129 ++++++++++++++++++++++++++++++++----
 2 files changed, 129 insertions(+), 14 deletions(-)

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
index 3f15e993dc04..dfc2ab1cd59a 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -209,11 +209,60 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
 }
 
+static void
+_freq_tbl_determine_parent(struct clk_hw *hw, struct freq_tbl *f_tbl,
+			   const struct freq_tbl *f, unsigned long req_rate)
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
+		_freq_tbl_determine_parent(hw, &f_tbl, f, rate);
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
 
 		if (f->n) {
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
@@ -352,40 +409,86 @@ static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	return update_config(rcg);
 }
 
-static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate)
+static void
+__clk_rcg2_select_conf(struct clk_hw *hw, struct freq_tbl *f_tbl,
+		       const struct freq_tbl *f, u8 parent_index)
+{
+	const struct freq_conf *conf, *best_conf;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int index, i;
+
+	/* Search in each provided config the one that is near the wanted rate */
+	for (i = 0, conf = f->confs; i < f->confs_num; i++, conf++) {
+		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+		if (index < 0)
+			continue;
+
+		if (index == parent_index)
+			break;
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
+static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate, u8 index)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
+	struct freq_tbl f_tbl;
 
 	f = qcom_find_freq_exact(rcg->freq_tbl, rate);
 	if (!f)
 		return -EINVAL;
 
-	return clk_rcg2_configure(rcg, f);
+	f_tbl = *f;
+	/*
+	 * A single freq may be reached by multiple configuration.
+	 * Select the conf for the requested parent.
+	 */
+	if (f->confs) {
+		/* Use current parent if not set */
+		if (index < 0)
+			index = clk_hw_get_parent_index(hw);
+
+		__clk_rcg2_select_conf(hw, &f_tbl, f, index);
+	}
+
+	return clk_rcg2_configure(rcg, &f_tbl);
 }
 
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
-	return __clk_rcg2_set_rate(hw, rate);
+	return __clk_rcg2_set_rate(hw, rate, -1);
 }
 
 static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
 {
-	return __clk_rcg2_set_rate(hw, rate);
+	return __clk_rcg2_set_rate(hw, rate, -1);
 }
 
 static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
-	return __clk_rcg2_set_rate(hw, rate);
+	return __clk_rcg2_set_rate(hw, rate, index);
 }
 
 static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
-	return __clk_rcg2_set_rate(hw, rate);
+	return __clk_rcg2_set_rate(hw, rate, index);
 }
 
 static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
-- 
2.38.1

