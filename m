Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103BB715707
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjE3Hil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjE3Hi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:38:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9546F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3078cc99232so3887842f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685432298; x=1688024298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctRkf1Nrzpq+Bo2Yx960UtDdp4B1S01USNtgO/gQUhM=;
        b=jMMrGUJAvfTZrZqX1mfK3okGKWvfNOoy+yZ4cMmFMBEU5SuvcgxRjsnG3DAsSLAZYT
         +8ANXDrhIBZOpGdTZFDJa4xt4wOU9Yy1GrENAbMGs0cSSklsmTzzdaPR7sbjsq4Hlwcv
         jL12ccLOUzaLRA+3w8EKTc5xC61IdMlSvE1LioGfP7sHYLJRWH866kG06J838NOfE0lG
         +DMABJ5t4tJxq6AAlh2GD0v6jQRgizrj41ayPgvVyaKbAwvbwpHWZtxOTCWeL8qOwvx5
         eo5dOW1P8R1GPTcODWWuc34BDSeSxqmO1B4LncBZQE6gR2jSF8pfoip9FN8103eg+FD/
         Qurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432298; x=1688024298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctRkf1Nrzpq+Bo2Yx960UtDdp4B1S01USNtgO/gQUhM=;
        b=CG6FofgQgGzYmdiDMg8tYckE/oO5tLaPghqaqzoCKNHciXdLK2ha9ik4rLtXeGkMb5
         ZX3zKYX1Zt2DjXjmZ4tqED1MbKDuA5R6lCc0rMpPJwgFAssYaQnMKscq9p2vhF9Ul8t9
         8galkZYvzyx7q6ljKftCnQZbd8LyPmTgujMoAY5hXL7VgxBs97a8wLoMapwBRg0gcwYf
         XO5tOgrfn0pQJUoDNEnbdqZ6O9vvoxP6Ry0mMTskyrGoUeudNQfYgofef4qnSQL2l//I
         M6SQRYjYcxqzUexQyJUERxAsoag3pdzBYJmk5Pe5ho7+nwHvzgJl8wlLY+SXhnwk1YZx
         0GBA==
X-Gm-Message-State: AC+VfDxXmk+EyJn5d1LViJ+iffNSNO0czFaegDr17uzUs1N3kWMoan6f
        d4kBvmpzz/B4I/dF9Ko5sjHCfg==
X-Google-Smtp-Source: ACHHUZ4C7tOtF573M3nwtI82CwuRsBcqayZMHzvOm/CW35Q7iEfXvwMttSTu2aZcZb8Vt79OK5xKIQ==
X-Received: by 2002:adf:e74d:0:b0:2f7:8f62:1a45 with SMTP id c13-20020adfe74d000000b002f78f621a45mr1236774wrn.66.1685432298189;
        Tue, 30 May 2023 00:38:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d4a04000000b003079c402762sm2312013wrq.19.2023.05.30.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:38:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 30 May 2023 09:38:05 +0200
Subject: [PATCH v5 04/17] clk: meson: g12: use VCLK2_SEL, CTS_ENCL &
 CTS_ENCL_SEL public CLK IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-4-56eb7a4d5b8e@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4965;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ykSwF0V0lUS+Xeggc75UkrBZ6e3mEPjzepbC0GhniEs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdafeS+RBYJ5gBUnorLdUmAymfM1ZVs6kR7L/wisf
 VI37kfGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHWn3gAKCRB33NvayMhJ0T+CEA
 DGHyBfRCXIDqYZbNurPI1sb/Ze3ilqYZTVrrQuJjM90Tdl5a0o8b0qbWQ4kDxqEAAU/IEY99JNJfed
 fN2ZePLSSArZ3dWZ27Uz9sHdan8oAH6ato+VnQaXwv0Gr2sVJd0pkIOhITtBi9S/R4LLjuwi4t3n/d
 j5HDJAkYcOJdI7Dchkjdz48fItlAadx8zAsSwHVL/kKBE9wAQOGjeK1ew+fIyDCkNvQOTadJCi6NxA
 aV+cql+M0q6BDWHu4yicOdD2mFyMSpVKCToEI/FLBTD+ygyZvxe3eQuKD9SGVqnMC599JfvAAI0N1W
 oo9R9a2rBKGTakLKlQkvN2mZ2m+8Irmb+TzSa6KuKz7KdvfOt+yr5DKoI8P8xh0PxcafZupyoPe96J
 zYufDbbAKJ1HvsSWuPk5qiU1wcEmDl8aPbkq48H0J7VDdNgCUIKvpkj3OjW9Q00lhqlubi20bMLBHd
 DawwHZqV4+uT/DnKHLjjAJXDw3M0lbx8Q7bmDywDggDW9DVEo2WdK2PEFe4Dn4h+ffxePtd3kPt3NU
 NugxodI/LFlkkgSxrZ0PRvdcAa8mVl34uRbcF+ObjLhe/HiKKIBhKZax7QZsWqxLYX/KjGc940s/fL
 jLXmJXY5pD4LmSVneMDFo94J6M24fGigo/zZALq+zEpiX1hoqd4Pmbwr0KDQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now those CLK IDs were added to the public bindings header, switch
to use those defines and drop the PRIV defines.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.c | 18 +++++++++---------
 drivers/clk/meson/g12a.h |  3 ---
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a132aad2aac9..461ebd79497c 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4411,7 +4411,7 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_PRIV_VID_PLL_SEL]	= &g12a_vid_pll_sel.hw,
 		[CLKID_PRIV_VID_PLL_DIV]	= &g12a_vid_pll.hw,
 		[CLKID_PRIV_VCLK_SEL]		= &g12a_vclk_sel.hw,
-		[CLKID_PRIV_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
+		[CLKID_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
 		[CLKID_PRIV_VCLK_INPUT]		= &g12a_vclk_input.hw,
 		[CLKID_PRIV_VCLK2_INPUT]	= &g12a_vclk2_input.hw,
 		[CLKID_PRIV_VCLK_DIV]		= &g12a_vclk_div.hw,
@@ -4438,12 +4438,12 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
 		[CLKID_PRIV_CTS_ENCI_SEL]	= &g12a_cts_enci_sel.hw,
 		[CLKID_PRIV_CTS_ENCP_SEL]	= &g12a_cts_encp_sel.hw,
-		[CLKID_PRIV_CTS_ENCL_SEL]	= &g12a_cts_encl_sel.hw,
+		[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
 		[CLKID_PRIV_CTS_VDAC_SEL]	= &g12a_cts_vdac_sel.hw,
 		[CLKID_PRIV_HDMI_TX_SEL]	= &g12a_hdmi_tx_sel.hw,
 		[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
 		[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
-		[CLKID_PRIV_CTS_ENCL]		= &g12a_cts_encl.hw,
+		[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
 		[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
 		[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
 		[CLKID_PRIV_HDMI_SEL]		= &g12a_hdmi_sel.hw,
@@ -4642,7 +4642,7 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
 		[CLKID_PRIV_VID_PLL_SEL]	= &g12a_vid_pll_sel.hw,
 		[CLKID_PRIV_VID_PLL_DIV]	= &g12a_vid_pll.hw,
 		[CLKID_PRIV_VCLK_SEL]		= &g12a_vclk_sel.hw,
-		[CLKID_PRIV_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
+		[CLKID_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
 		[CLKID_PRIV_VCLK_INPUT]		= &g12a_vclk_input.hw,
 		[CLKID_PRIV_VCLK2_INPUT]	= &g12a_vclk2_input.hw,
 		[CLKID_PRIV_VCLK_DIV]		= &g12a_vclk_div.hw,
@@ -4669,12 +4669,12 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
 		[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
 		[CLKID_PRIV_CTS_ENCI_SEL]	= &g12a_cts_enci_sel.hw,
 		[CLKID_PRIV_CTS_ENCP_SEL]	= &g12a_cts_encp_sel.hw,
-		[CLKID_PRIV_CTS_ENCL_SEL]	= &g12a_cts_encl_sel.hw,
+		[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
 		[CLKID_PRIV_CTS_VDAC_SEL]	= &g12a_cts_vdac_sel.hw,
 		[CLKID_PRIV_HDMI_TX_SEL]	= &g12a_hdmi_tx_sel.hw,
 		[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
 		[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
-		[CLKID_PRIV_CTS_ENCL]		= &g12a_cts_encl.hw,
+		[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
 		[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
 		[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
 		[CLKID_PRIV_HDMI_SEL]		= &g12a_hdmi_sel.hw,
@@ -4908,7 +4908,7 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
 		[CLKID_PRIV_VID_PLL_SEL]	= &g12a_vid_pll_sel.hw,
 		[CLKID_PRIV_VID_PLL_DIV]	= &g12a_vid_pll.hw,
 		[CLKID_PRIV_VCLK_SEL]		= &g12a_vclk_sel.hw,
-		[CLKID_PRIV_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
+		[CLKID_VCLK2_SEL]		= &g12a_vclk2_sel.hw,
 		[CLKID_PRIV_VCLK_INPUT]		= &g12a_vclk_input.hw,
 		[CLKID_PRIV_VCLK2_INPUT]	= &g12a_vclk2_input.hw,
 		[CLKID_PRIV_VCLK_DIV]		= &g12a_vclk_div.hw,
@@ -4935,12 +4935,12 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
 		[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
 		[CLKID_PRIV_CTS_ENCI_SEL]	= &g12a_cts_enci_sel.hw,
 		[CLKID_PRIV_CTS_ENCP_SEL]	= &g12a_cts_encp_sel.hw,
-		[CLKID_PRIV_CTS_ENCL_SEL]	= &g12a_cts_encl_sel.hw,
+		[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
 		[CLKID_PRIV_CTS_VDAC_SEL]	= &g12a_cts_vdac_sel.hw,
 		[CLKID_PRIV_HDMI_TX_SEL]	= &g12a_hdmi_tx_sel.hw,
 		[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
 		[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
-		[CLKID_PRIV_CTS_ENCL]		= &g12a_cts_encl.hw,
+		[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
 		[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
 		[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
 		[CLKID_PRIV_HDMI_SEL]		= &g12a_hdmi_sel.hw,
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 9a3091fcaa41..8275413f2beb 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -168,7 +168,6 @@
 #define CLKID_PRIV_VID_PLL_SEL			130
 #define CLKID_PRIV_VID_PLL_DIV			131
 #define CLKID_PRIV_VCLK_SEL			132
-#define CLKID_PRIV_VCLK2_SEL			133
 #define CLKID_PRIV_VCLK_INPUT			134
 #define CLKID_PRIV_VCLK2_INPUT			135
 #define CLKID_PRIV_VCLK_DIV			136
@@ -265,8 +264,6 @@
 #define CLKID_PRIV_NNA_CORE_CLK_SEL		265
 #define CLKID_PRIV_NNA_CORE_CLK_DIV		266
 #define CLKID_PRIV_MIPI_DSI_PXCLK_DIV		268
-#define CLKID_PRIV_CTS_ENCL			271
-#define CLKID_PRIV_CTS_ENCL_SEL			272
 
 #define NR_CLKS					273
 

-- 
2.34.1

