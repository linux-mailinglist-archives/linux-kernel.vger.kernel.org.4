Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826C617E68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKCNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKCNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:50:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A53CE1A;
        Thu,  3 Nov 2022 06:50:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1219625wmp.5;
        Thu, 03 Nov 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYevc0/VBCj9wBQRWlQ/9Q4O5TfPY8fJu+BvNTU/yG0=;
        b=d6OJjLYkTVYyj0VjESkE5EWtHiqvjt0kEB6y4IcY77JYyXS8Cup8RaMvRDnHOpxbuo
         qZP+vizPDK6fdps12oaywwU12KIKc0tuOvkUyAZul6wIbilxp0khBz1Yxhk0+E+lx7N0
         Z3+99s0lgMYRiABw7VCPiVb/n3XN1D+q/blvLsKNl0KooCakYtysUGBgbLLm9yMYKoRt
         P0slatV+1Ltu5yG2zPhN85umCFptMKDj+yvRMFdNebJ8XvqLVcL4Hd9HgramtTo4HhRr
         m+dWOa/xNLX5/7THOGCWVkA7yCRysyzS2P+hAS4hb4hPJJBKvHSsHman05tp74IxcMsF
         CUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYevc0/VBCj9wBQRWlQ/9Q4O5TfPY8fJu+BvNTU/yG0=;
        b=bpUu/62kN4vZu8dGrvTWdXQZA+sWGGigyCezg8vw5MpU1nHY7qTX5lVGIBgfrB/WJw
         q6g/PgCEuUnipPdpTdhRH/2UOIggxu+vOHF49Oru/0grNzYzw7kl9D2em7Tcpg1FlAVC
         z3DtVWAOl3N7TdQ9DArcpuHaLWuCJ2o+2NVfPUdWBzT6UeDFi/djZaYJ5HI0CtL5vhY5
         g+mQ35zua1Ldb/yBsyDTPdrVsTzjSu1xvW9bjiNDh705hDlH9cu5GGor/gqNWrVSwSEE
         KUzNoQnVh+uDVuVToG6AlPfgasKqifwPPJORX1YKA+yB7qTt1QfHbK9rSOBQAzX6I0Q9
         ICvQ==
X-Gm-Message-State: ACrzQf0QqBk3DuI1T5pITJD9TS7AA2M/E970HIZ7NLzFNUSC3FElP6Wq
        jCtRqi0LnRtnZNvaWUl2Qu6dUTUH5GA=
X-Google-Smtp-Source: AMsMyM4/0Te6wr50IuSG1FJMDHBgSFNQGAvNEOPXZCEAfIgiGu6IIqEGLirF2PjMzHvLqkN7xp5pnA==
X-Received: by 2002:a05:600c:a04:b0:3b4:f20e:63f4 with SMTP id z4-20020a05600c0a0400b003b4f20e63f4mr19678312wmp.201.1667483408237;
        Thu, 03 Nov 2022 06:50:08 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id bt12-20020a056000080c00b00236576c8eddsm957414wrb.12.2022.11.03.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:50:07 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/4] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
Date:   Thu,  3 Nov 2022 14:49:44 +0100
Message-Id: <20221103134944.23275-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103134944.23275-1-ansuelsmth@gmail.com>
References: <20221103134944.23275-1-ansuelsmth@gmail.com>
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

