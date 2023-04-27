Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0616F0F77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjD1AUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbjD1AUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:20:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A630F7;
        Thu, 27 Apr 2023 17:20:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f315735514so41869485e9.1;
        Thu, 27 Apr 2023 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682641201; x=1685233201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgptBC2X/QXw1nLX7yvk4IcpAgHDSjhB7sqr45n66Qs=;
        b=b6qsPSPGxTEgRxTu6AIlXqqP36RW7AxfbYJdl5VA92f7W664kh+RSn2FZn92AioZSp
         k+zUTbFaIQactYcU0Ayl5AYgtFhOpCJQrAt3ghf4ApYpx953kKVBtnJUfPJ129gm6q+c
         9hBPsIQjDxVyClV/6FNJYCWvJPc7lL061MPzk1H7uBggoEg/WNdrdAgO8S3t5HubGfGp
         O80NCwdtrSj/UqdaoZnOGgOe2DXmSVLDiJ/3HFRGtu9OW/7sRkxCBwzuQJXqdBJ2j1EJ
         EmVLe3cJ7NDYvpC17b/myvtGnDp3wIwnHKyktr94DqWG90mP63EXSsRu2NV4E1bt7aSI
         4SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641201; x=1685233201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgptBC2X/QXw1nLX7yvk4IcpAgHDSjhB7sqr45n66Qs=;
        b=Iar24G99pTmGgyQN717dZ+xaHwFGRJOu8x5sO5ie4l4QYtjqy3G+bw4eKUVAM1joRp
         3LlAuC9WSaueiHnZtNgXzLZH4yOSCCgEVNAqR7EgZPbLCWC1bUrUe1VYMM9PYFcV4Cug
         pHcARK28GXbtMknuk74uDF2P+TWyCColtPThjiSR/WicSzVSsSDEvO4cHqvCFE0ZA6Sn
         B8GWgICgTMQk2ZXqVOIE4nlw14cKelKxRiqD0ysBmPrBS7N/ZLcgEPAJm2DeHSZ0WWx3
         GK7bd7HhApgBg7uxFOI2H/LUUdTpR/+hIPPbUNBte21hy8wLzEX9V3FTu9jN3GvjK9Wa
         3Z4Q==
X-Gm-Message-State: AC+VfDxY5Z68URn4OqF548uPOFuxNaQtGN3ypNl7DwxeAM4gUz+AdPy/
        nWwvJJrU4hexhgtFc86RWUA=
X-Google-Smtp-Source: ACHHUZ61JZ+yEK4PZMctl78t8ZFQQttKt3HcIVzo4m51003p3E3mQK0XiN8P3frURLHQ96X09NIyAA==
X-Received: by 2002:a5d:564d:0:b0:2fa:88d3:f8b8 with SMTP id j13-20020a5d564d000000b002fa88d3f8b8mr5428147wrw.12.1682641200892;
        Thu, 27 Apr 2023 17:20:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id d3-20020a05600c3ac300b003f19b3d89e9sm16362095wms.33.2023.04.27.17.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 17:20:00 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 3/3] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Thu, 27 Apr 2023 17:07:17 +0200
Message-Id: <20230427150717.20860-4-ansuelsmth@gmail.com>
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

Rework nss_port5/6 to use the new multiple configuration implementation
and correctly fix the clocks for these port under some corner case.

This is particularly relevant for device that have 2.5G or 10G port
connected to port5 or port 6 on ipq8074. As the parent are shared
across multiple port it may be required to select the correct
configuration to accomplish the desired clock. Without this patch such
port doesn't work in some specific ethernet speed as the clock will be
set to the wrong frequency as we just select the first configuration for
the related frequency instead of selecting the best one.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 120 +++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 6541d98c0348..bce459cecb2d 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1682,15 +1682,23 @@ static struct clk_regmap_div nss_port4_tx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_RX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_RX, 5, 0, 0),
-	F(78125000, P_UNIPHY1_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_RX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
-	F(156250000, P_UNIPHY1_RX, 2, 0, 0),
-	F(312500000, P_UNIPHY1_RX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port5_rx_clk_src_25[] = {
+	C(P_UNIPHY1_RX, 12.5, 0, 0),
+	C(P_UNIPHY0_RX, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port5_rx_clk_src_125[] = {
+	C(P_UNIPHY1_RX, 2.5, 0, 0),
+	C(P_UNIPHY0_RX, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port5_rx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port5_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port5_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1717,14 +1725,14 @@ gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port5_rx_clk_src = {
 	.cmd_rcgr = 0x68060,
-	.freq_tbl = ftbl_nss_port5_rx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port5_rx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port5_rx_clk_src",
 		.parent_data = gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1744,15 +1752,23 @@ static struct clk_regmap_div nss_port5_rx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_TX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_TX, 5, 0, 0),
-	F(78125000, P_UNIPHY1_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_TX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
-	F(156250000, P_UNIPHY1_TX, 2, 0, 0),
-	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port5_tx_clk_src_25[] = {
+	C(P_UNIPHY1_TX, 12.5, 0, 0),
+	C(P_UNIPHY0_TX, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port5_tx_clk_src_125[] = {
+	C(P_UNIPHY1_TX, 2.5, 0, 0),
+	C(P_UNIPHY0_TX, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port5_tx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port5_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_TX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port5_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_TX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_TX, 1, 0, 0),
 	{ }
 };
 
@@ -1779,14 +1795,14 @@ gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port5_tx_clk_src = {
 	.cmd_rcgr = 0x68068,
-	.freq_tbl = ftbl_nss_port5_tx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port5_tx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port5_tx_clk_src",
 		.parent_data = gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1806,15 +1822,23 @@ static struct clk_regmap_div nss_port5_tx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 12.5, 0, 0),
-	F(78125000, P_UNIPHY2_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 2.5, 0, 0),
-	F(156250000, P_UNIPHY2_RX, 2, 0, 0),
-	F(312500000, P_UNIPHY2_RX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port6_rx_clk_src_25[] = {
+	C(P_UNIPHY2_RX, 5, 0, 0),
+	C(P_UNIPHY2_RX, 12.5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port6_rx_clk_src_125[] = {
+	C(P_UNIPHY2_RX, 1, 0, 0),
+	C(P_UNIPHY2_RX, 2.5, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port6_rx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port6_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY2_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port6_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1836,14 +1860,14 @@ static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port6_rx_clk_src = {
 	.cmd_rcgr = 0x68070,
-	.freq_tbl = ftbl_nss_port6_rx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port6_rx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy2_rx_tx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port6_rx_clk_src",
 		.parent_data = gcc_xo_uniphy2_rx_tx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_rx_tx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
@@ -1863,15 +1887,23 @@ static struct clk_regmap_div nss_port6_rx_div_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 12.5, 0, 0),
-	F(78125000, P_UNIPHY2_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 2.5, 0, 0),
-	F(156250000, P_UNIPHY2_TX, 2, 0, 0),
-	F(312500000, P_UNIPHY2_TX, 1, 0, 0),
+static const struct freq_conf ftbl_nss_port6_tx_clk_src_25[] = {
+	C(P_UNIPHY2_TX, 5, 0, 0),
+	C(P_UNIPHY2_TX, 12.5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_port6_tx_clk_src_125[] = {
+	C(P_UNIPHY2_TX, 1, 0, 0),
+	C(P_UNIPHY2_TX, 2.5, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_port6_tx_clk_src[] = {
+	FMS(19200000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_port6_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_RX, 4, 0, 0),
+	FM(125000000, ftbl_nss_port6_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_RX, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
 };
 
@@ -1893,14 +1925,14 @@ static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
 
 static struct clk_rcg2 nss_port6_tx_clk_src = {
 	.cmd_rcgr = 0x68078,
-	.freq_tbl = ftbl_nss_port6_tx_clk_src,
+	.freq_multi_tbl = ftbl_nss_port6_tx_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_uniphy2_tx_rx_ubi32_bias_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_port6_tx_clk_src",
 		.parent_data = gcc_xo_uniphy2_tx_rx_ubi32_bias,
 		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_tx_rx_ubi32_bias),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_fm_ops,
 	},
 };
 
-- 
2.39.2

