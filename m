Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E846663EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjAKTpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjAKTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:44:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230C138;
        Wed, 11 Jan 2023 11:43:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d17so16127266wrs.2;
        Wed, 11 Jan 2023 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYevc0/VBCj9wBQRWlQ/9Q4O5TfPY8fJu+BvNTU/yG0=;
        b=Xk3wLwZIsPcBP4s0vXhPN8TQl2dDXq36Tyy8/K1UYGJmyCuf96p2Hm7Y5mE+3yBc6N
         EldNKEN2ZXmBlnfrHG7+IH0x1vx/1nAN4Gmweoj8Ublcm3VB/tzy03kEoSyhA15vnget
         PCImX4WRw8ON9d6k8CLhoAJ6UuVpQUS1WGJiiqVI4sz8e6ASeltwWGCaSxA6KHXHaTAH
         27wiJYYD9E49R65bM4NMZxseFT7043MfUpagCoIUcFiUbrgAVXlwSXS28RvuoKhQ3ddg
         kBCvh49QIJyqg3lSnFkl7rDe23tlfV+cNTu1wqP6lTvHSRbBO32OfAKdVGhIXegjfFq4
         Jwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYevc0/VBCj9wBQRWlQ/9Q4O5TfPY8fJu+BvNTU/yG0=;
        b=cEI5QsTNGQmcdk4gX2U8owFzEykB2mch54jRRXFjufm+E3x7EjqxuPo10kwmy1UiZC
         +eewa/nkQHSRNy+Lf8DnbgftpxHNyN5Tl2Chf1KyQNPDugNJ0foPDuEH1BB4jVF3HkXH
         mWk0yDwfJ8EQggiZJPL/odR0l6Bz3JvJyK2R938mC5zlblUi5ABawcExN6gmiF1RkfUG
         O0G1xFNxmdYsfW7/RkWnHi8V3tH6WTFCptmN5SB1MuK7bYMCi3sswR9mKdnEFm2ubD2K
         EJVzzFCATTuy3hgXxl+NUtT8dXxflMSigMELi4gxisIh+5j0uGnwTA1tkDHVmYGs4mWZ
         /QdA==
X-Gm-Message-State: AFqh2kpWjzIDST1+iVdjqeBXVIE9dpl0vLYId5x9qTkGf4ja1IJ2CY0g
        o0dDCAtZK5iBZOaglArLDWY=
X-Google-Smtp-Source: AMrXdXsmuPWreyUo7TQ6maw1tmEdm5EoqYay1ncZIsrNYTLkueMvwCZyA7hJvKlFT5YsNysC+6Z+8w==
X-Received: by 2002:a05:6000:1a41:b0:24b:b74d:8012 with SMTP id t1-20020a0560001a4100b0024bb74d8012mr44439839wry.18.1673466180776;
        Wed, 11 Jan 2023 11:43:00 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm2179789wrb.89.2023.01.11.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:43:00 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [RESEND PATCH 2/2] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Wed, 11 Jan 2023 20:42:50 +0100
Message-Id: <20230111194250.15793-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230111194250.15793-1-ansuelsmth@gmail.com>
References: <20230111194250.15793-1-ansuelsmth@gmail.com>
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
2.37.2

