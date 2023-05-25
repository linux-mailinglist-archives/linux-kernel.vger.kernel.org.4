Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E0710E97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbjEYOuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbjEYOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:50:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD5197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:50:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6cbdf16d2so5406045e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685026242; x=1687618242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dk7QJei9PeWUkzrOfgGS8Gy9rm2de0CYH4aZNTGkzf4=;
        b=RDYOuDjHqN5yM2HylJX8fjxPxXwdjjEn/cAh57zUpQtn/q7ZiSpr8HfxMpZikuGWLw
         LBI+UFMOmLFEng2EAKP/xE7wAkgi72eyq8IYXbpr5S93FLllIiLH+s2+/UIXa7o1vSRd
         566RoUvd4hldZhYjPqYFDKbV1hw0/aXy2DsO90pmaLe6Rv+x+ntlEF0hsY0NSkZakWZO
         KdlUpt99qkaKBW6XvnwRfFCv3iRAS1YwE8E52p16IbT8fjtnO/nqUdl3Tb/1pdAdi2Cz
         RcaWhPhFDyIz+ruY+yiMq8ZPFqn+or6GzBVdnkxmUS+hUxPmeTvTDHRzttvazhWhR0hx
         1FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026242; x=1687618242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk7QJei9PeWUkzrOfgGS8Gy9rm2de0CYH4aZNTGkzf4=;
        b=hYRzQYx18y9YZFDZddJxfoUNr1MFVtZ6XBPUEhyAjxOevCnPyjdf7Tu4uO5Hd8iFfi
         NB3MEKipcJBM+07FwDAdUr8Cz/wpN1neCqIFhqY5Szj5HjWIyYgO7L19vNvKD7AKjyQj
         Cointp16fVPRCHoAhi7UHI1kTHM1WNSNCUdCf6WoCelGeQGHo27CG1W1HLuR3NwYgkCD
         Gq+myMONUd3pknzIpjqXBTuAquk1FDnyYGSL0MbqaT+oh8Wk4KpVd25BnJ7XunXfU9vv
         FACxcDrafpiM/oakCvSWM+WvVBmQWR6IWAfHEjYj0Ex44LVrrquV5lXh/5eVCUHpc6Wm
         4bZA==
X-Gm-Message-State: AC+VfDwM+ljKOf+XzBTWm3xdibp51BrlAYrFwIm40qTGuXrWthmyadvY
        mqraOn+xvagUCOvq0LMOebWHRQ==
X-Google-Smtp-Source: ACHHUZ42xNQWVL0brQ8SGM/70DXdaDwrPk90wl3j0E8Dzivt8ZR+BsmepjCzfa79r/1DdgjYrkkDJQ==
X-Received: by 2002:a05:600c:2152:b0:3f6:426:eae with SMTP id v18-20020a05600c215200b003f604260eaemr2466110wml.15.1685026242015;
        Thu, 25 May 2023 07:50:42 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n4-20020a05600c294400b003f3157988f8sm2349559wmd.26.2023.05.25.07.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:50:41 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 16:50:28 +0200
Subject: [PATCH v2 2/2] clk: mediatek: mt8365: Fix index issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-fix-clk-index-v2-2-1b686cefcb7e@baylibre.com>
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
In-Reply-To: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3945; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=h4CYMTHY+i6lrYnmhgx8aF98Btv8+w8cHJz9HWafPts=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkb3W+OhDmteG4nw7zZfgxSFRSGHsPONsu2EhaYln8
 LTOxFnSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG91vgAKCRArRkmdfjHURb3sEA
 C+HameIOZ/zOTzknXCgncCzzXdKLAwF+YxxjNIV3lMeucqs/dQiRtk/jnJ32zowP0KN/NAgCyh+9+g
 yHLAlMtgrWQFiGupWkJREZ8J2zCTxipX8yhulBaPZQUJH4D+X5D/ksC+BuBC++HJ2afXyflFhMlaqS
 n99Ma/qF49neqoe+SFske6IyASQgcCwZsSEsISTL0KG0cOrSIiou34bQ9ohNOFNH03HK9JAJxx9Zv+
 HY/UxHua/E7RnBzFc6jfcbfQPgS/zBqF1TiBx1UQECMKaSpFep5k6pnBSw8akBhzb9Qo+w6IXW850P
 vNsdHwBW4jVl6aY+E6Gxcx7o9MrbcM0M9Ti1AnusX6nT3H31iRBO7BgnbKlB2STTz953gFS8MXKOSi
 Etds32yoO1XR3dYA4MaX8eEvT+DS2b+zSAZw1IUyXthT/11jXuAilVQl57JBPWB82oncSl5brRplN+
 r30QIkY4PJ1fzuw444gXoXoRJqqK42rttmPpRUzmLzJcV7Owyt/DGTSndWPgkJP1ZUXZDQk3WwlfJv
 0giWg90hzlA/youxIzY8KuHnnwHwYHhG3uCXgppyg17V/Ucg4ul+Q5DlQ6LBKT7u+BTalOS0RDnzaw
 bqD6eUdamA2i6N1D/A20sLv54OQ98+2LmM/Y1TTOj19zVjkZDCXYwi83sEtA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the patch [1], the clock probe was done directly in the
clk-mt8365 driver. In this probe function, the array which stores the
data clocks is sized using the higher defined numbers (*_NR_CLOCK) in
the clock lists [2]. Currently, with the patch [1], the specific
clk-mt8365 probe function is replaced by the mtk generic one [3], which
size the clock data array by adding all the clock descriptor array size
provided by the clk-mt8365 driver.

Actually, all clock indexes come from the header file [2], that mean, if
there are more clock (then more index) in the header file [2] than the
number of clock declared in the clock descriptor arrays (which is the
case currently), the clock data array will be undersized and then the
generic probe function will overflow when it will try to write in
"clk_data[CLK_INDEX]". Actually, instead of crashing at boot, the probe
function returns an error in the log which looks like:
"of_clk_hw_onecell_get: invalid index 135", then this clock isn't
enabled.

Solve this issue by adding in the driver the missing clocks declared in
the header clock file [2].

[1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
     mtk_clk_simple_{probe,remove}()")
[2]: include/dt-bindings/clock/mediatek,mt8365-clk.h
[3]: drivers/clk/mediatek/clk-mtk.c

Fixes: ffe91cb28f6a ("clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()")

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 6b4e193f648d..35aafeefbf31 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -23,6 +23,7 @@
 static DEFINE_SPINLOCK(mt8365_clk_lock);
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
+	FIXED_CLK(CLK_TOP_CLK_NULL, "clk_null", NULL, 0),
 	FIXED_CLK(CLK_TOP_I2S0_BCK, "i2s0_bck", NULL, 26000000),
 	FIXED_CLK(CLK_TOP_DSI0_LNTC_DSICK, "dsi0_lntc_dsick", "clk26m",
 		  75000000),
@@ -559,6 +560,14 @@ static const struct mtk_clk_divider top_adj_divs[] = {
 		  0x324, 16, 8, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV3, "apll12_ck_div3", "apll_i2s3_sel",
 		  0x324, 24, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV4, "apll12_ck_div4", "apll_tdmout_sel",
+		  0x328, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV4B, "apll12_ck_div4b", "apll_tdmout_sel",
+		  0x328, 8, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV5, "apll12_ck_div5", "apll_tdmin_sel",
+		  0x328, 16, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV5B, "apll12_ck_div5b", "apll_tdmin_sel",
+		  0x328, 24, 8, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV6, "apll12_ck_div6", "apll_spdif_sel",
 		  0x32c, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
 };
@@ -696,6 +705,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR3(CLK_IFR_GCPU, "ifr_gcpu", "axi_sel", 8),
 	GATE_IFR3(CLK_IFR_TRNG, "ifr_trng", "axi_sel", 9),
 	GATE_IFR3(CLK_IFR_AUXADC, "ifr_auxadc", "clk26m", 10),
+	GATE_IFR3(CLK_IFR_CPUM, "ifr_cpum", "clk26m", 11),
 	GATE_IFR3(CLK_IFR_AUXADC_MD, "ifr_auxadc_md", "clk26m", 14),
 	GATE_IFR3(CLK_IFR_AP_DMA, "ifr_ap_dma", "axi_sel", 18),
 	GATE_IFR3(CLK_IFR_DEBUGSYS, "ifr_debugsys", "axi_sel", 24),
@@ -717,6 +727,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR5(CLK_IFR_PWRAP_TMR, "ifr_pwrap_tmr", "clk26m", 12),
 	GATE_IFR5(CLK_IFR_PWRAP_SPI, "ifr_pwrap_spi", "clk26m", 13),
 	GATE_IFR5(CLK_IFR_PWRAP_SYS, "ifr_pwrap_sys", "clk26m", 14),
+	GATE_IFR5(CLK_IFR_AES_TOP0_BK, "ifr_aes_top0_bk", "clk26m", 16),
 	GATE_IFR5(CLK_IFR_IRRX_26M, "ifr_irrx_26m", "clk26m", 22),
 	GATE_IFR5(CLK_IFR_IRRX_32K, "ifr_irrx_32k", "clk32k", 23),
 	GATE_IFR5(CLK_IFR_I2C0_AXI, "ifr_i2c0_axi", "i2c_sel", 24),

-- 
2.25.1

