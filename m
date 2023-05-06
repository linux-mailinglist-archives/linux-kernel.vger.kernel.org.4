Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D396F93E4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjEFTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:53:36 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07611D97;
        Sat,  6 May 2023 12:53:35 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3319a6f989aso22970095ab.2;
        Sat, 06 May 2023 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683402814; x=1685994814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=et5odkEWMhvUd9/Y4cXnYrY0jnj+L9/Dy7S8TmthK9w=;
        b=I275jrOTraNI70Wunv4m3wVa4U3ifeQIlGiZkWEVqF+lsmAwHKBlk/FXUzgLGgW30e
         2kgTw4rL47xkX3mfOFcBdhQFqhbImUjTfDp9HwbrcbSL5D3GIzN34s9N0tGf4G2O3vaa
         PekAG5BddG2ARY32guLUeLcFfY5TIY9qHknhyVsym/0T/qo+iB/KAATknBPRdy7H5L4T
         hNu4MMaFBnrfqOqF/x2v0HMsqCJ2XsdC8FbX4tVnAaxJFSo3BXUELeGGqhsxS69Ws1HZ
         FmpXY/AZFizrikcrXzesPSVYllGA6kgw4gs5a4b/sLpAJKHl8fNV7G3+eb5hdulpmk+a
         gv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683402814; x=1685994814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et5odkEWMhvUd9/Y4cXnYrY0jnj+L9/Dy7S8TmthK9w=;
        b=RhSnXC27tfaeNZLLzOdWVyT1x5KnmaYiPGdeAA0W8Kpw2uQNnNFc2kc1zdpR997LI3
         vwylZsjp8O1MG7bnPFsywPnA/IZ0c3yrToGTPnMNfQuXHk0USolFEZxLc12Ow0/KLB2k
         VrkEW6allaVTQFRn2RC12cNzZ8sEUPZkRri/KmmbBVCJAXJxr70OdbaOvZ+mEkCXNO/y
         kBQ8LWJA4JOIVK7y7FgspcF9Utpv5Irol8x1nNWYUmjq6wIcUDtjE6VgjLNY8ynv4c3q
         3l0fksEbc//9NaGe7fAXcA0aRil5SlAzBdHcrZrJEQJSHL1z5v2VkbtvTAxMd+x+jFJr
         Rmvg==
X-Gm-Message-State: AC+VfDyWhD7KhLKMCHjMp5gfm+WJ+dx4xczvekwEjRRbgnJY3czgwnrc
        vXAyI50R5x/qTh2bka8qGI/EzeOVAqzK/Q==
X-Google-Smtp-Source: ACHHUZ47xOFM4B8bzp32xmSsiHPdRaTulBX8t/1b1+aPhqzqw9dS068F64JdJSY3pHBMIsleQwM2ww==
X-Received: by 2002:a92:dd01:0:b0:331:9a82:33f9 with SMTP id n1-20020a92dd01000000b003319a8233f9mr4091856ilm.10.1683402814417;
        Sat, 06 May 2023 12:53:34 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:5e49:1bed:79d0:5c25])
        by smtp.gmail.com with ESMTPSA id s11-20020a92d90b000000b0032957b21c26sm1317220iln.77.2023.05.06.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 12:53:33 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
Date:   Sat,  6 May 2023 14:53:25 -0500
Message-Id: <20230506195325.876871-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, certain clocks are derrived as a divider from their
parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
is set, the parent clock is not properly set which can lead
to some relatively inaccurate clock values.

Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
cannot rely on calling a standard determine_rate function,
because the 8m composite clocks have a pre-divider and
post-divider. Because of this, a custom determine_rate
function is necessary to determine the maximum clock
division which is equivalent to pre-divider * the
post-divider.

With this added, the system can attempt to adjust the parent rate
when the proper flags are set which can lead to a more precise clock
value.

On the imx8mplus, no clock changes are present.
On the Mini and Nano, this can help achieve more accurate
lcdif clocks. When trying to get a pixel clock of 31.500MHz
on an imx8m Nano, the clocks divided the 594MHz down, but
left the parent rate untouched which caused a calulation error.

Before:
video_pll              594000000
  video_pll_bypass     594000000
    video_pll_out      594000000
      disp_pixel       31263158
        disp_pixel_clk 31263158

Variance = -236842 Hz

After this patch:
video_pll               31500000
  video_pll_bypass      31500000
    video_pll_out       31500000
      disp_pixel        31500000
        disp_pixel_clk  31500000

Variance = 0 Hz

All other clocks rates and parent were the same.
Similar results on imx8mm were found.

Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to determine_rate"")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Fix build warning found by build bot and fix prediv_value
     and div_value because the values stored are the divisor - 1,
     so we need to add 1 to the values to be correct.

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..7a6e3ce97133 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -119,10 +119,41 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
+static int imx8m_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	int prediv_value;
+	int div_value;
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val = readl(divider->reg);
+		prediv_value = val >> divider->shift;
+		prediv_value &= clk_div_mask(divider->width);
+		prediv_value++;
+
+		div_value = val >> PCG_DIV_SHIFT;
+		div_value &= clk_div_mask(PCG_DIV_WIDTH);
+		div_value++;
+
+		return divider_ro_determine_rate(hw, req, divider->table,
+						 PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
+						 divider->flags, prediv_value * div_value);
+	}
+
+	return divider_determine_rate(hw, req, divider->table,
+				      PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
+				      divider->flags);
+}
+
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
 	.round_rate = imx8m_clk_composite_divider_round_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
+	.determine_rate = imx8m_divider_determine_rate,
 };
 
 static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
-- 
2.39.2

