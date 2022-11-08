Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66213621D21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKHTma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHTm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:42:27 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B32F716FA;
        Tue,  8 Nov 2022 11:42:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f5so41333076ejc.5;
        Tue, 08 Nov 2022 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCfFBPnvKgh1kXxmqYQOr9Dj76h0DzapsRsTmMteAyo=;
        b=IQN9hEauYkqPNz3uDp7hm+fsvMGwRkAil3F6vVajQda2BkKKr+mDQYVUkw/hf2sb+/
         9OWejEsRzQA6Ww70dbsT3hMJ+hiUZUf+jxELTn2MRZN/ViVJVft2iSI52y1FW56gqU3l
         8OM+jxM4dVryfewYzxHvdymytD8Z/ronn7yRXRoZK6bzUW88PBJM/L+0iRHl/4KyY+RP
         NQXhBg6rg1849qSZCmborLA3Rxa1zD8sS10NRb9JWmmCwgYCU72e0qbQ++P1BWgG6zol
         p2OKptIqXHdpFI8BhlKStG4VPBaqOwKCRcTxNXx7RhmSPfupXK8aFLjQCBkqMt2oHtxH
         o+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCfFBPnvKgh1kXxmqYQOr9Dj76h0DzapsRsTmMteAyo=;
        b=tTh78YsINRgNIDFHSt4yBByFvf35PEcK7ER3X7/Haiudj/IJGngRdBLGfMSg20z2x2
         nIH4PDeP7Ipb+Xf+Etqx920qPa5ClGZYSqJvH6reYMRu1P3K1AIyFrjcfx7o+hr9yN9U
         eZqBg3bhoQaTQLY5P8tDmmJrHhUL15jpoajxRyUZYUGnb1yYQDE0DoWeEkGyS3gEC1jU
         td0r5dVnmQ9pzBY3SDXOBTuVasE5LHs3eHSFVcLcUK101Jnbh3aDd8VwRfK98RhvzqWh
         HxwKADyoTZFOYH8mGZ3WjA5JVqcuIuwNPu3s2VtE8frFs8RpBe+3wacuuxLk27XQz+kM
         b6eg==
X-Gm-Message-State: ANoB5pmZUMRU7eovKnsAAywlzzUxFZ8Yt3nG4cprY739srVZt9ol0Vz+
        lWgceR05a2MReTv8vnYFxzXJYRU6uz6J4g==
X-Google-Smtp-Source: AA0mqf5IwHC6JWNP+c7u4NO+CCMmNKWD3xYJivdfKnBsQQOObhTs4zo9bPlWFPCKqafEzPuMCD7pbQ==
X-Received: by 2002:a17:907:2e0b:b0:7a7:d37e:4650 with SMTP id ig11-20020a1709072e0b00b007a7d37e4650mr13427702ejc.261.1667936544550;
        Tue, 08 Nov 2022 11:42:24 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id p20-20020aa7cc94000000b00457c85bd890sm5916142edt.55.2022.11.08.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:42:23 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] clk: qcom: ipq8074: populate fw_name for all parents
Date:   Tue,  8 Nov 2022 20:42:17 +0100
Message-Id: <20221108194217.553303-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
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

It appears that having only .name populated in parent_data for clocks
which are only globally searchable currently will not work as the clk core
won't copy that name if there is no .fw_name present as well.

So, populate .fw_name for all parent clocks in parent_data.

Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 48 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index d231866804f6..bf64aa683605 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1137,7 +1137,7 @@ static const struct freq_tbl ftbl_nss_noc_bfdcd_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_bias_pll_nss_noc_clk_gpll0_gpll2[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "bias_pll_nss_noc_clk" },
+	{ .fw_name = "bias_pll_nss_noc_clk", .name = "bias_pll_nss_noc_clk" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll2.clkr.hw },
 };
@@ -1362,7 +1362,7 @@ static const struct freq_tbl ftbl_nss_ppe_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_bias_gpll0_gpll4_nss_ubi32[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll4.clkr.hw },
 	{ .hw = &nss_crypto_pll.clkr.hw },
@@ -1413,10 +1413,10 @@ static const struct freq_tbl ftbl_nss_port1_rx_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_uniphy0_rx_tx_ubi32_bias[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "uniphy0_gcc_rx_clk" },
-	{ .name = "uniphy0_gcc_tx_clk" },
+	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
+	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
 	{ .hw = &ubi32_pll.clkr.hw },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 };
 
 static const struct parent_map gcc_xo_uniphy0_rx_tx_ubi32_bias_map[] = {
@@ -1465,10 +1465,10 @@ static const struct freq_tbl ftbl_nss_port1_tx_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_uniphy0_tx_rx_ubi32_bias[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "uniphy0_gcc_tx_clk" },
-	{ .name = "uniphy0_gcc_rx_clk" },
+	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
+	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
 	{ .hw = &ubi32_pll.clkr.hw },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 };
 
 static const struct parent_map gcc_xo_uniphy0_tx_rx_ubi32_bias_map[] = {
@@ -1696,12 +1696,12 @@ static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "uniphy0_gcc_rx_clk" },
-	{ .name = "uniphy0_gcc_tx_clk" },
-	{ .name = "uniphy1_gcc_rx_clk" },
-	{ .name = "uniphy1_gcc_tx_clk" },
+	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
+	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
+	{ .fw_name = "uniphy1_gcc_rx_clk", .name = "uniphy1_gcc_rx_clk" },
+	{ .fw_name = "uniphy1_gcc_tx_clk", .name = "uniphy1_gcc_tx_clk" },
 	{ .hw = &ubi32_pll.clkr.hw },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 };
 
 static const struct parent_map
@@ -1758,12 +1758,12 @@ static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "uniphy0_gcc_tx_clk" },
-	{ .name = "uniphy0_gcc_rx_clk" },
-	{ .name = "uniphy1_gcc_tx_clk" },
-	{ .name = "uniphy1_gcc_rx_clk" },
+	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
+	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
+	{ .fw_name = "uniphy1_gcc_tx_clk", .name = "uniphy1_gcc_tx_clk" },
+	{ .fw_name = "uniphy1_gcc_rx_clk", .name = "uniphy1_gcc_rx_clk" },
 	{ .hw = &ubi32_pll.clkr.hw },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 };
 
 static const struct parent_map
@@ -1820,10 +1820,10 @@ static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_uniphy2_rx_tx_ubi32_bias[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "uniphy2_gcc_rx_clk" },
-	{ .name = "uniphy2_gcc_tx_clk" },
+	{ .fw_name = "uniphy2_gcc_rx_clk", .name = "uniphy2_gcc_rx_clk" },
+	{ .fw_name = "uniphy2_gcc_tx_clk", .name = "uniphy2_gcc_tx_clk" },
 	{ .hw = &ubi32_pll.clkr.hw },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 };
 
 static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
@@ -1877,10 +1877,10 @@ static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
 
 static const struct clk_parent_data gcc_xo_uniphy2_tx_rx_ubi32_bias[] = {
 	{ .fw_name = "xo", .name = "xo" },
-	{ .name = "uniphy2_gcc_tx_clk" },
-	{ .name = "uniphy2_gcc_rx_clk" },
+	{ .fw_name = "uniphy2_gcc_tx_clk", .name = "uniphy2_gcc_tx_clk" },
+	{ .fw_name = "uniphy2_gcc_rx_clk", .name = "uniphy2_gcc_rx_clk" },
 	{ .hw = &ubi32_pll.clkr.hw },
-	{ .name = "bias_pll_cc_clk" },
+	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
 };
 
 static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
-- 
2.38.1

