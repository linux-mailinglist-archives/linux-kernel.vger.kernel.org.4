Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AC718E88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjEaW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjEaW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:29:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AEE48;
        Wed, 31 May 2023 15:28:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so1683985e9.1;
        Wed, 31 May 2023 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685572098; x=1688164098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgptBC2X/QXw1nLX7yvk4IcpAgHDSjhB7sqr45n66Qs=;
        b=eW4CSuJdS31Dj+YIUd6MeN2uDTcLQviCmXQ5qyPHr3SdpasASEXx5Ofjt5YLuFvXE6
         4jLQz5KI2kgan6VStixPfJRZLLJAwNz+fnw4dco9XC/vpM94k3sCfdsU3SYOvUX2/1le
         SSYhGBZl0FrGAjC2fBtRKVAoPRU6WpAmp/msDfJvjWNQ/3t5LOYOF0T3osCZZ/7EtOke
         z7Y57Uj7tPx1oDrw2pARlKQ0s0zANpn8srYHwDYFNPtHL0X4tjdRbop75x6zekAPHeI3
         Vfd4L8YJZeHUEvKl+Mr6VzwbpXdBY8DkmrWUfvYJFKQx5lBIAF4+OMBAVCwHntlnWbgj
         jRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572098; x=1688164098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgptBC2X/QXw1nLX7yvk4IcpAgHDSjhB7sqr45n66Qs=;
        b=Bek30WFeUTu6Ii5u4/8Eh0nbPU0Uy0s/rJI7OTRQwcLM9uTnlu5HuGBf24s9ZuGdTs
         DRB+Erwp0IGVfjKYR1WuYghwNDKoqt9AFePCgxhxaFitx08ygm6bVqnH8glZS75e325x
         iwIDKp3/PM8ui5XbV5PkhGTFUZgNz/l+IrlR1qlfusTnNKQwtuSDR+24NNTUX43NF9bz
         gArVly1dcXI8l/6Ea3kjF8Wo9aZN00lo6dqtxTFUycJDmzV7KVjFi+iaiXDT+djK3pBK
         Mdw/Oh9RHeEl7JPeK3blTWn2ScSrx4g96uAL5Op3Una9wNb981COjqGhrfee0ZxbwL+v
         FLnw==
X-Gm-Message-State: AC+VfDzQ/s/k1IOQysFtvU7NZuuyhvrB/bH2pdEnKxsmVv79SRL7Kuvr
        tWk6cLt/BaVnDldwCVyRBGI=
X-Google-Smtp-Source: ACHHUZ6NA/etTDk1IprlyzcOHk/Ib87qVDLOC/mUCW4i1gRGC03eBTAFpCa/XUp6EmPaWzVexcPu/Q==
X-Received: by 2002:a1c:4b06:0:b0:3f6:26a1:1d58 with SMTP id y6-20020a1c4b06000000b003f626a11d58mr438144wma.37.1685572098379;
        Wed, 31 May 2023 15:28:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c028900b003f6132f95e6sm70020wmk.35.2023.05.31.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:28:13 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v5 3/3] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Thu,  1 Jun 2023 00:26:54 +0200
Message-Id: <20230531222654.25475-4-ansuelsmth@gmail.com>
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

