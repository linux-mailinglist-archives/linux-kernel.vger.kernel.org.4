Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6266DFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjAQNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAQNz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6F7ABC;
        Tue, 17 Jan 2023 05:55:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o17-20020a05600c511100b003db021ef437so3123031wms.4;
        Tue, 17 Jan 2023 05:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+8K4EO+Daz1wxfQ80+5vMacSGUxLmGR0DsNNmoO1rU=;
        b=iyqM/nh3hh0RdHGl3qNhNtb95HDQvufWzwOZ26VK/EFYAUOOqDzhl4tAydr1xF6e+M
         IDwemHIQ9xRh9Pg97SaISJR90cyn8U68WRoCeB34SOOGU7smX45ErRcnJlSERmgLTHeJ
         vPe6ODuVM4sOaGcGTJgSLBi1J7Gp+61zMoI2D5dj+/GC/AkPzSg0oNKPq9qIAsp52EnW
         /1fnpzlKyqnPQdI6ncSjoOAffFOOZFo/STscOKLo5NbW9dDwSciHR5Tx6grPpjEGW2mp
         sjTbPwoYx3lPSHHZ44ECYo+XXkNO68f1kVkNublAm/tS9OrOt5V/fC4XrI4SNov0c4w5
         Ft4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+8K4EO+Daz1wxfQ80+5vMacSGUxLmGR0DsNNmoO1rU=;
        b=W94jtJRQNoC9AATwS9OoM0n2PtLT11Okhusuyq6Tnlv94irUGvpniH3J6P2Gc+KjiJ
         ClwheQu3NUsmiUF86jAyJQ/W1DPayv7F3Vd3jJl3rePRasq24lWvatL7reiG4zUkUH9k
         uvxNWMwYxca0T4cDq+EyDbliMf2u9KPS7yJ4EoaT1BgIDud5vMNyc4emau9yL35zMIes
         IUI+1nejUer0Wy6gj7OJtRUZlnzDmHLuMIz5hFwgEt1hDyGBEq7jrutNzm+1oXt6/uIW
         +M0QJFXYjTinQ91hEclNJnpR4vGpoa6fgD8meyp6Bo0Xz47+k1+Nrm8AsscnBsNGjy3y
         V0Ig==
X-Gm-Message-State: AFqh2kpY6H0vp0euFVGqTkVzI9mjJfFe0ncBE2cIIHQTOPlO78W4YfSq
        3ALsNg1lsXNFNB9DbMX2750=
X-Google-Smtp-Source: AMrXdXskDLI9cbckDCrW8XlHoXPpJqn6mtanOTpdtORDF5CsAe+1kEZjrFYbfq1Yo0FdKxBTnv3ehg==
X-Received: by 2002:a1c:7919:0:b0:3da:79f:8953 with SMTP id l25-20020a1c7919000000b003da079f8953mr11790148wme.41.1673963725885;
        Tue, 17 Jan 2023 05:55:25 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:25 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 6/6] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Tue, 17 Jan 2023 14:54:59 +0100
Message-Id: <20230117135459.16868-7-ansuelsmth@gmail.com>
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

Rework nss_port5/6 to use the new multiple configuration implementation
and correctly fix the clocks for these port under some corner case.

This is particularly relevant for device that have 2.5G or 10G port
connected to port5 or port 6 on ipq8074. As the parent are shared
across multiple port it may be required to select the correct
configuration to accomplish the desired clock. Without this patch such
port doesn't work in some specific ethernet speed as the clock will be
set to the wrong frequency as we just select the first configuration for
the related frequency instead of selecting the best one.

Tested-by: Robert Marko <robimarko@gmail.com> # ipq8074 Qnap QHora-301W
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 64 +++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 42d185fe19c8..02d04a552b78 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1787,13 +1787,21 @@ static struct clk_regmap_div nss_port4_tx_div_clk_src = {
 	},
 };
 
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
 static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_RX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_RX, 5, 0, 0),
+	FM(25000000, ftbl_nss_port5_rx_clk_src_25),
 	F(78125000, P_UNIPHY1_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_RX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
+	FM(125000000, ftbl_nss_port5_rx_clk_src_125),
 	F(156250000, P_UNIPHY1_RX, 2, 0, 0),
 	F(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
@@ -1829,13 +1837,21 @@ static struct clk_regmap_div nss_port5_rx_div_clk_src = {
 	},
 };
 
+static struct freq_conf ftbl_nss_port5_tx_clk_src_25[] = {
+	C(P_UNIPHY1_TX, 12.5, 0, 0),
+	C(P_UNIPHY0_TX, 5, 0, 0),
+};
+
+static struct freq_conf ftbl_nss_port5_tx_clk_src_125[] = {
+	C(P_UNIPHY1_TX, 2.5, 0, 0),
+	C(P_UNIPHY0_TX, 1, 0, 0),
+};
+
 static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY1_TX, 12.5, 0, 0),
-	F(25000000, P_UNIPHY0_TX, 5, 0, 0),
+	FM(25000000, ftbl_nss_port5_tx_clk_src_25),
 	F(78125000, P_UNIPHY1_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY1_TX, 2.5, 0, 0),
-	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
+	FM(125000000, ftbl_nss_port5_tx_clk_src_125),
 	F(156250000, P_UNIPHY1_TX, 2, 0, 0),
 	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
 	{ }
@@ -1871,13 +1887,21 @@ static struct clk_regmap_div nss_port5_tx_div_clk_src = {
 	},
 };
 
+static struct freq_conf ftbl_nss_port6_rx_clk_src_25[] = {
+	C(P_UNIPHY2_RX, 5, 0, 0),
+	C(P_UNIPHY2_RX, 12.5, 0, 0),
+};
+
+static struct freq_conf ftbl_nss_port6_rx_clk_src_125[] = {
+	C(P_UNIPHY2_RX, 1, 0, 0),
+	C(P_UNIPHY2_RX, 2.5, 0, 0),
+};
+
 static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_RX, 12.5, 0, 0),
+	FM(25000000, ftbl_nss_port6_rx_clk_src_25),
 	F(78125000, P_UNIPHY2_RX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_RX, 2.5, 0, 0),
+	FM(125000000, ftbl_nss_port6_rx_clk_src_125),
 	F(156250000, P_UNIPHY2_RX, 2, 0, 0),
 	F(312500000, P_UNIPHY2_RX, 1, 0, 0),
 	{ }
@@ -1913,13 +1937,21 @@ static struct clk_regmap_div nss_port6_rx_div_clk_src = {
 	},
 };
 
+static struct freq_conf ftbl_nss_port6_tx_clk_src_25[] = {
+	C(P_UNIPHY2_TX, 5, 0, 0),
+	C(P_UNIPHY2_TX, 12.5, 0, 0),
+};
+
+static struct freq_conf ftbl_nss_port6_tx_clk_src_125[] = {
+	C(P_UNIPHY2_TX, 1, 0, 0),
+	C(P_UNIPHY2_TX, 2.5, 0, 0),
+};
+
 static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 5, 0, 0),
-	F(25000000, P_UNIPHY2_TX, 12.5, 0, 0),
+	FM(25000000, ftbl_nss_port6_tx_clk_src_25),
 	F(78125000, P_UNIPHY2_TX, 4, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 1, 0, 0),
-	F(125000000, P_UNIPHY2_TX, 2.5, 0, 0),
+	FM(125000000, ftbl_nss_port6_tx_clk_src_125),
 	F(156250000, P_UNIPHY2_TX, 2, 0, 0),
 	F(312500000, P_UNIPHY2_TX, 1, 0, 0),
 	{ }
-- 
2.38.1

