Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224366F9318
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEFQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:24:21 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3983FA;
        Sat,  6 May 2023 09:24:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3313fe59a61so7276885ab.0;
        Sat, 06 May 2023 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683390259; x=1685982259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khKwz5sXanssBqWJenlghMda3UHcmI6p3o8gOauYeXA=;
        b=BdGRwKhKrrUyt6L9ZQXOuIokSqZqRMKA9//i4NwFM1VS2LQmER3HKVI4ix2inR6aoq
         6Ld05QVYpf1UErA/8+rFNXUL2bTXCIIJZD4V7iWOeTMrbrPPpQEv7V6+vsj89qeEqjI0
         2udttB1VdSvsMd3jk6fc4NjrkjsH7gL6wVOPieoprEO5xqKu+fnl4T6APoKeC9fjc0rQ
         blI5oIflfjiXq32uvEyrND6+/QXz71tMJjXE7hTiLUP3eIAQdDfGElWFvWcWmbbF5k/H
         AnESyD2zRB6TeDcm7OEBM8r9BhOTm8+SHZH8Ry7/nrMRqX1tBvHtWEpkNi3wolRfezRs
         naXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683390259; x=1685982259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khKwz5sXanssBqWJenlghMda3UHcmI6p3o8gOauYeXA=;
        b=Rfw9gKX7SXz87xzA8hwUNsJDBhC2zHaRuBIgwsRhhRh8LZtRPQZuxn3KoAEiNmDqtv
         XcCg+CUJu25VyyZprryf4puTIEGCjRBn66DZY8+kSA3Av3jyoZbwec9lYJpaPGjMGwd7
         Vo0RvJB1PJvgRpOng8k+xLR6RXuFx78og/KCWqqS6F+ntJDASHWfvB88HL2dryUXsVSh
         72yr4oA0lRZmWaXE5vj/TfuTpxJkdRth+3xqx+smMA6XlPOhwegb37eKJbHYC83kqswa
         x5dcj67XacU/HwwAPf5Mw7vSPzndbvUH5mbTbd68uxKwZM7GQIjsJrhkw6EqbV8zsjJG
         PHpQ==
X-Gm-Message-State: AC+VfDzB0PXzhpfc39S4FXlMkUjhx/QlKg/3FI+3h+ZGpGBZnjti/3sq
        3UDPHMcj+kUTo2HKMj35d+00LTGjNkv+rA==
X-Google-Smtp-Source: ACHHUZ7HWXNiA5J8Trz+Vx0/H/VlUrfkWKtEN7fRoSleyiXkB+02/FRQ1CaVUN1zUegIzsrCfH7P7A==
X-Received: by 2002:a92:c530:0:b0:332:e5aa:f9b5 with SMTP id m16-20020a92c530000000b00332e5aaf9b5mr3345093ili.15.1683390259422;
        Sat, 06 May 2023 09:24:19 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:75c9:74af:40b2:789b])
        by smtp.gmail.com with ESMTPSA id eq4-20020a0566384e2400b00411bc1340c0sm754892jab.8.2023.05.06.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 09:24:18 -0700 (PDT)
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
Date:   Sat,  6 May 2023 11:24:03 -0500
Message-Id: <20230506162403.375212-1-aford173@gmail.com>
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

Currently, certain clocks, are derrived as a divider from their
parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
is set, the parent clock is not which can lead to some relatively
inaccurate clock values for child clocks.

Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
cannot rely on calling a standard clock function, because
the 8m composite clocks have a pre-divider and post-divider.
Because of this, a custom determine_rate function is
necessary to determine the maximum clock division which is
equivalent to pre-divider * the post-divider in most cases.

With this added, the system can attempt to adjust the parent rate
when the proper flags are set which can lead to a more precise clock
value.

For example.  When trying to get a pixel clock of 31.500MHz
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

Unlike the previous attempt, when tested with imx8mp, no clock
rate or parent changes were found.

Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to determine_rate"")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..fd49385bd2ae 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -119,10 +119,39 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
+int imx8m_divider_determine_rate(struct clk_hw *hw,
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
+
+		div_value = val >> PCG_DIV_SHIFT;
+		div_value &= clk_div_mask(PCG_DIV_WIDTH);
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

