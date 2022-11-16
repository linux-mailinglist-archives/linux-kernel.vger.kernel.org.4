Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15262CCED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiKPVrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKPVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AF13DDD;
        Wed, 16 Nov 2022 13:46:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f18so379770ejz.5;
        Wed, 16 Nov 2022 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykJo8V9fWn3GFRM/unyg99u9L1PO5QmNvrxh5n3ttGc=;
        b=NffHHuqtVh/pBVF5D21t5xweV1ph1r7m5P9bLakoUzpSIOYxSTJsHryKa75h2GqaOH
         4pqPaaoPc9OQ2QEY4fIN/797QpTbfH/q0eidaP4KEQpzW+ZE8gntbTBW+sUuJqfRRhZJ
         TxMwjY91+/5foG/uqNFppKKPIvA8mZMI7h8juyXqJUfiVRbh075gW2gnoIPP1ldvvGaG
         CLdrbF23O7BYWyknOhRQp7cAViG0JhurPDSi76KqukRWfdlMnnfUjaUphQwmst4iHeJh
         E9zSVEOF4QnPmgc9u9Iy/mWWLCNoLuy/HWoOvhgYt/87+dM3+P8y6aen49t6B8vuAMrO
         kBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykJo8V9fWn3GFRM/unyg99u9L1PO5QmNvrxh5n3ttGc=;
        b=1mO0kNraLkIKnONiFfXrtggGel4J43lkfBZhJ6sDhgb12grIQTh2Vj8HKODlw8HZJR
         s3WgYGAXJEd2ogB+HxVp/zvXRJfFk5/LE5wwzjkdsCiMDIogcLECnEXdk1Fn4nTcMXgW
         /p0p2QTfUZz85OJ+718or/CCk0bWMB9CcvhsWipvX3Bzvy/gF8JHKRPMEmzxRk7/bkQ6
         GzE/InqZZ+lLlF6tthquCqZVVKkI1CLx6pyTklx6KXITCeCw+1+BoRt7g1bM3pdFewtA
         f/FaiYQdFgX4hZGOEgfyqbMcZ3+/H1MMHDfM9fCmPm/zhXueWJdH6L21VjNxF3zW9X9s
         VVag==
X-Gm-Message-State: ANoB5pkIJMIrFoPnD4TC7GHBdwOKVUb3ba9MfZTpuh2358ZfffvWmaXc
        yOVl7JG8/tOzBwu0rYHiNSY=
X-Google-Smtp-Source: AA0mqf4MgcSZTKPoxfJV82q3xQrh3h3PidjHnRbvFvvTUy2tujz3E5HM+Uo1KqHQrnAaBDSc5Ij/vA==
X-Received: by 2002:a17:906:2ecf:b0:778:f9b6:6fc with SMTP id s15-20020a1709062ecf00b00778f9b606fcmr19739257eji.580.1668635218195;
        Wed, 16 Nov 2022 13:46:58 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id qx17-20020a170906fcd100b0073d7ab84375sm7420078ejb.92.2022.11.16.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:46:57 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2] clk: qcom: ipq8074: populate fw_name for all parents
Date:   Wed, 16 Nov 2022 22:46:55 +0100
Message-Id: <20221116214655.1116467-1-robimarko@gmail.com>
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
Changes in v2:
* Add fw_name for PCIe PHY pipe clocks as well
---
 drivers/clk/qcom/gcc-ipq8074.c | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index d231866804f6..8374cc40915a 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -680,7 +680,7 @@ static struct clk_rcg2 pcie0_aux_clk_src = {
 };
 
 static const struct clk_parent_data gcc_pcie20_phy0_pipe_clk_xo[] = {
-	{ .name = "pcie20_phy0_pipe_clk" },
+	{ .fw_name = "pcie0_pipe", .name = "pcie20_phy0_pipe_clk" },
 	{ .fw_name = "xo", .name = "xo" },
 };
 
@@ -733,7 +733,7 @@ static struct clk_rcg2 pcie1_aux_clk_src = {
 };
 
 static const struct clk_parent_data gcc_pcie20_phy1_pipe_clk_xo[] = {
-	{ .name = "pcie20_phy1_pipe_clk" },
+	{ .fw_name = "pcie1_pipe", .name = "pcie20_phy1_pipe_clk" },
 	{ .fw_name = "xo", .name = "xo" },
 };
 
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

