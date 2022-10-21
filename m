Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499B1607E16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJUSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJUSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:07:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCB256401;
        Fri, 21 Oct 2022 11:07:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e18so2772101wmq.3;
        Fri, 21 Oct 2022 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYevc0/VBCj9wBQRWlQ/9Q4O5TfPY8fJu+BvNTU/yG0=;
        b=dUVoeS+r4UdeGMB+N1lX6A7ISaf2eJpRGohWDvas5cCg0h0Gcp5He+TmxRMkDkCqvT
         x5exD9Oic5lyVKj6i8H3WukULH5PJz9XPMOnmH77GtSIazHzwhXfmjZASyEE+ukZOhbm
         6sUznWCYsz2v2vNCrxoGZP+vqL6QIV8PTs4VBrEp/WJdWrpH014xO8b2+sTu8EKBv/tw
         iUQtQT+WdP2Gxqe4/b85aahP4ag8EC1ZZtlEvVygVgsYrUF5L1PDUoJ/aE+mK56wW1km
         /CYGqwoUG3V5AhkYby8nsvlPOZlpLY+evbCp4u8ZhKwdJRa9XuIoLwi5E1QTbqVBzYX1
         nVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYevc0/VBCj9wBQRWlQ/9Q4O5TfPY8fJu+BvNTU/yG0=;
        b=jmXSeIEys6KSmwS/8sGo8Wr2iX8nglh9Tt38AnMLtqx9DEXAwSP9gX5vJYEN/q8yWq
         No/qOV9Bv6xoitfWJuIqYSEU4Mj+4YYITDleO0rgkYxrNBYxOemGpiA59rqMkbhQWWZ9
         0p6y2QSncPqiU/3wiMFO1auLh8e7tEz8o3IiwMDv7J/I0tq0qj1hqElTRHYadcbCiQvX
         vqrnuII9odf/dF1bkHAazi9DiaVt7dETLX/wg0s6lEs1/ErHO94PoITiUu9bWtkOPyb1
         MEOw3XCmHg21CyhIU/wh9iRbUXYww+zXL66YpS3aR4jRD/RJEZL0qbZCFmqdS/cWbg6a
         CpEw==
X-Gm-Message-State: ACrzQf36DyTlLCI77OHe78bwgk0aRlSDebwBmZQm+tzTzwd+ewApmuPY
        Qcp+xWSfQYtlARH8XySAkOek5rBi+NA=
X-Google-Smtp-Source: AMsMyM7O4wDTum8skBufRBwmROFBmHxMJ6EUTtfJYvNoxki5cnaYBDlB6wDG84J1Q5H4O1LcF63wdQ==
X-Received: by 2002:a1c:f20e:0:b0:3c2:5062:4017 with SMTP id s14-20020a1cf20e000000b003c250624017mr34025752wmc.175.1666375632872;
        Fri, 21 Oct 2022 11:07:12 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id n4-20020a1ca404000000b003c41144b3cfsm280348wme.20.2022.10.21.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:07:12 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [RFC PATCH 2/2] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Fri, 21 Oct 2022 20:06:57 +0200
Message-Id: <20221021180657.13474-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221021180657.13474-1-ansuelsmth@gmail.com>
References: <20221021180657.13474-1-ansuelsmth@gmail.com>
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

