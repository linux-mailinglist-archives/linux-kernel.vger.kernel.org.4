Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0554725C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbjFGK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjFGK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313072694
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30af159b433so7097941f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135388; x=1688727388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeOKg8gxIWxqcy4SgPa1WpjS6ave2RGNUe7qwUbFu1g=;
        b=tJCOUREfs1/iqU7erL3kUeqst5UhWaQIj+1G+8BX/tYP9FrvJdBGGo4h/u0mJosIkr
         sCeIYFyXSZwarXVvwDt1YHVeAg20EeG8sC9BukZVrb+ctj2a66ODsphAHACUm5Q7+9nD
         NU2JyGFZKsVVIUTrYIQmIdlg0DzpPA+0wacyYenfXXIpn3i7htIOaK8jrm+gey2VH4cb
         2+fAxulECyKxTGO+vlaSCDgdhdELr50xGIWdVE1yqbDGhLYAjuVDHVFCPUM1+SNUJQp8
         uKkReo00d1aBUEi9558HPVIG7F1CNMP4AbKs/g8TCPtGWJuR0JwmhtxAAbc33glKaJQ0
         Np5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135388; x=1688727388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeOKg8gxIWxqcy4SgPa1WpjS6ave2RGNUe7qwUbFu1g=;
        b=aq3VLGtQkxiCTkiCTH3pzirZiYAJsY/w6slFJ2DbqosaeX0XHD/41S25lVijVD240C
         NSiDKYcCGHV53vuB62EO+gNOWKvzMDjOrQ50hSC2lKeWZP9cKknUA0q4ywApaVxyvVMD
         04bGBXXOjH7nHINmMyo2gPGvo+7d3qxEGcE7AXOcLBxKLnxeUEQZ1MCQJy2dG9APXpRB
         pFGEQaQuKRXsFkX+oICRJmWIiL9GwUcDwu9FRGoCeCxdX9seVhMxChdV2sFvdar/z8vv
         bKsZ0XFk2AOzpry0tIl9ixCE3pNa8ravYLfiIVZh7lDSDzOcMvcdz0Ryt2WEfD1rqBHN
         BTqg==
X-Gm-Message-State: AC+VfDwoVFS11dLjnLjqtSZIT9P2/ORyGf6oG/46p2yCPhOIUUXJVAYE
        eVfVVz7b3gfoGdA5UjKB0rIvdQ==
X-Google-Smtp-Source: ACHHUZ7FoOzlh86UT00JvXCoMDpYpBlC4t6337m/p27T1eXpsT/+ADohDtiV9KHHkd5ZTQKzWXj9mw==
X-Received: by 2002:adf:efc9:0:b0:30a:f19b:ff98 with SMTP id i9-20020adfefc9000000b0030af19bff98mr4760211wrp.9.1686135388277;
        Wed, 07 Jun 2023 03:56:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:27 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:16 +0200
Subject: [PATCH 05/18] clk: meson: migrate axg-audio out of hw_onecell_data
 to drop NR_CLKS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-5-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=46789;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ouIjUAhq3/BBJCDvMhsyMoE1bjWIOw3dusUqtAUrbjU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJQYsPccXfsOe0LgMvbKhOxEvdO12nIFqvLUAsG
 nX//YPKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUAAKCRB33NvayMhJ0ZAqEA
 CEFZJHYiODwK1OjAscJoEqTHT0bxAT80TZijUmzgBNkybPZLCId5LNhetqxu0P938fDooVxHsYNBe/
 NaOk3V/T0g4kCVsRT9wnbpk1kkLv9j2pT9PhpoKyBbMVS/YxOdBhDd35XKd7GktPWXqtCYcr4JPQIA
 evn9u0YFQe53uBEyDaqG0kZLXYXQxdYMY3owexG0JoZ8KWPIMittZTQYIxKC9xfwMIfE1ZzW/2qdId
 lwnggKk3k4gsPch1EoC+qqzeLT/Rgt/GJzU0jlFfoOIGI0juDz+jESdsYrM/T+0MGCmWJ+idDzma7C
 M4VTwvg/w6GP/87tmlarl2Jh4f27cPZD3khNXzWXNDPCSXxri3onJv7Duhtbkbon4iTSaFjSd+Jues
 d6tOrfahvxvIVopPo1PNJFZ+sKWRZ8N5vwPt8i9qR9Hw/ClG966JPamqqD5AyM/ChdO2P50RB/G7vo
 bCfkXfObGdY+PZdLNTz7shaoY3EhIPBLo5Vs813/qcWuhRIHkKuAQm5pjKWbr/5ibHcX4I0n2xMGxA
 Y/d+HH83Y4UydY7KackM/CkIDDOz21lW2ryjmQ1NhfT5mQvOhDoN1hVb9Q8vXVoK8BUMeWdDVW9eOf
 +2GV8RFVfAAkkOKPH4lZSPnREDlfIHi8IHZunji3BKs1sVgbhK9znFTXSvww==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way hw_onecell_data is declared:
struct clk_hw_onecell_data {
	unsigned int num;
	struct clk_hw *hws[];
};

makes it impossible to have the clk_hw table declared outside while
using ARRAY_SIZE() to determine ".num" due to ".hws" being a flexible
array member.

Completely move out of hw_onecell_data and add a custom
devm_of_clk_add_hw_provider() "get" callback to retrieve the clk_hw
in order to finally get rid on the NR_CLKS define.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/axg-audio.c | 856 +++++++++++++++++++++---------------------
 drivers/clk/meson/axg-audio.h |   2 -
 2 files changed, 430 insertions(+), 428 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 5016682e47c8..ef4e0552f77c 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -811,436 +811,424 @@ static struct clk_regmap sm1_tdm_sclk_pad_2 = AUD_TDM_PAD_CTRL(
  * Array of all clocks provided by this provider
  * The input clocks of the controller will be populated at runtime
  */
-static struct clk_hw_onecell_data axg_audio_hw_onecell_data = {
-	.hws = {
-		[AUD_CLKID_DDR_ARB]		= &ddr_arb.hw,
-		[AUD_CLKID_PDM]			= &pdm.hw,
-		[AUD_CLKID_TDMIN_A]		= &tdmin_a.hw,
-		[AUD_CLKID_TDMIN_B]		= &tdmin_b.hw,
-		[AUD_CLKID_TDMIN_C]		= &tdmin_c.hw,
-		[AUD_CLKID_TDMIN_LB]		= &tdmin_lb.hw,
-		[AUD_CLKID_TDMOUT_A]		= &tdmout_a.hw,
-		[AUD_CLKID_TDMOUT_B]		= &tdmout_b.hw,
-		[AUD_CLKID_TDMOUT_C]		= &tdmout_c.hw,
-		[AUD_CLKID_FRDDR_A]		= &frddr_a.hw,
-		[AUD_CLKID_FRDDR_B]		= &frddr_b.hw,
-		[AUD_CLKID_FRDDR_C]		= &frddr_c.hw,
-		[AUD_CLKID_TODDR_A]		= &toddr_a.hw,
-		[AUD_CLKID_TODDR_B]		= &toddr_b.hw,
-		[AUD_CLKID_TODDR_C]		= &toddr_c.hw,
-		[AUD_CLKID_LOOPBACK]		= &loopback.hw,
-		[AUD_CLKID_SPDIFIN]		= &spdifin.hw,
-		[AUD_CLKID_SPDIFOUT]		= &spdifout.hw,
-		[AUD_CLKID_RESAMPLE]		= &resample.hw,
-		[AUD_CLKID_POWER_DETECT]	= &power_detect.hw,
-		[AUD_CLKID_MST_A_MCLK_SEL]	= &mst_a_mclk_sel.hw,
-		[AUD_CLKID_MST_B_MCLK_SEL]	= &mst_b_mclk_sel.hw,
-		[AUD_CLKID_MST_C_MCLK_SEL]	= &mst_c_mclk_sel.hw,
-		[AUD_CLKID_MST_D_MCLK_SEL]	= &mst_d_mclk_sel.hw,
-		[AUD_CLKID_MST_E_MCLK_SEL]	= &mst_e_mclk_sel.hw,
-		[AUD_CLKID_MST_F_MCLK_SEL]	= &mst_f_mclk_sel.hw,
-		[AUD_CLKID_MST_A_MCLK_DIV]	= &mst_a_mclk_div.hw,
-		[AUD_CLKID_MST_B_MCLK_DIV]	= &mst_b_mclk_div.hw,
-		[AUD_CLKID_MST_C_MCLK_DIV]	= &mst_c_mclk_div.hw,
-		[AUD_CLKID_MST_D_MCLK_DIV]	= &mst_d_mclk_div.hw,
-		[AUD_CLKID_MST_E_MCLK_DIV]	= &mst_e_mclk_div.hw,
-		[AUD_CLKID_MST_F_MCLK_DIV]	= &mst_f_mclk_div.hw,
-		[AUD_CLKID_MST_A_MCLK]		= &mst_a_mclk.hw,
-		[AUD_CLKID_MST_B_MCLK]		= &mst_b_mclk.hw,
-		[AUD_CLKID_MST_C_MCLK]		= &mst_c_mclk.hw,
-		[AUD_CLKID_MST_D_MCLK]		= &mst_d_mclk.hw,
-		[AUD_CLKID_MST_E_MCLK]		= &mst_e_mclk.hw,
-		[AUD_CLKID_MST_F_MCLK]		= &mst_f_mclk.hw,
-		[AUD_CLKID_SPDIFOUT_CLK_SEL]	= &spdifout_clk_sel.hw,
-		[AUD_CLKID_SPDIFOUT_CLK_DIV]	= &spdifout_clk_div.hw,
-		[AUD_CLKID_SPDIFOUT_CLK]	= &spdifout_clk.hw,
-		[AUD_CLKID_SPDIFIN_CLK_SEL]	= &spdifin_clk_sel.hw,
-		[AUD_CLKID_SPDIFIN_CLK_DIV]	= &spdifin_clk_div.hw,
-		[AUD_CLKID_SPDIFIN_CLK]		= &spdifin_clk.hw,
-		[AUD_CLKID_PDM_DCLK_SEL]	= &pdm_dclk_sel.hw,
-		[AUD_CLKID_PDM_DCLK_DIV]	= &pdm_dclk_div.hw,
-		[AUD_CLKID_PDM_DCLK]		= &pdm_dclk.hw,
-		[AUD_CLKID_PDM_SYSCLK_SEL]	= &pdm_sysclk_sel.hw,
-		[AUD_CLKID_PDM_SYSCLK_DIV]	= &pdm_sysclk_div.hw,
-		[AUD_CLKID_PDM_SYSCLK]		= &pdm_sysclk.hw,
-		[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &mst_a_sclk_pre_en.hw,
-		[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &mst_b_sclk_pre_en.hw,
-		[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &mst_c_sclk_pre_en.hw,
-		[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &mst_d_sclk_pre_en.hw,
-		[AUD_CLKID_MST_E_SCLK_PRE_EN]	= &mst_e_sclk_pre_en.hw,
-		[AUD_CLKID_MST_F_SCLK_PRE_EN]	= &mst_f_sclk_pre_en.hw,
-		[AUD_CLKID_MST_A_SCLK_DIV]	= &mst_a_sclk_div.hw,
-		[AUD_CLKID_MST_B_SCLK_DIV]	= &mst_b_sclk_div.hw,
-		[AUD_CLKID_MST_C_SCLK_DIV]	= &mst_c_sclk_div.hw,
-		[AUD_CLKID_MST_D_SCLK_DIV]	= &mst_d_sclk_div.hw,
-		[AUD_CLKID_MST_E_SCLK_DIV]	= &mst_e_sclk_div.hw,
-		[AUD_CLKID_MST_F_SCLK_DIV]	= &mst_f_sclk_div.hw,
-		[AUD_CLKID_MST_A_SCLK_POST_EN]	= &mst_a_sclk_post_en.hw,
-		[AUD_CLKID_MST_B_SCLK_POST_EN]	= &mst_b_sclk_post_en.hw,
-		[AUD_CLKID_MST_C_SCLK_POST_EN]	= &mst_c_sclk_post_en.hw,
-		[AUD_CLKID_MST_D_SCLK_POST_EN]	= &mst_d_sclk_post_en.hw,
-		[AUD_CLKID_MST_E_SCLK_POST_EN]	= &mst_e_sclk_post_en.hw,
-		[AUD_CLKID_MST_F_SCLK_POST_EN]	= &mst_f_sclk_post_en.hw,
-		[AUD_CLKID_MST_A_SCLK]		= &mst_a_sclk.hw,
-		[AUD_CLKID_MST_B_SCLK]		= &mst_b_sclk.hw,
-		[AUD_CLKID_MST_C_SCLK]		= &mst_c_sclk.hw,
-		[AUD_CLKID_MST_D_SCLK]		= &mst_d_sclk.hw,
-		[AUD_CLKID_MST_E_SCLK]		= &mst_e_sclk.hw,
-		[AUD_CLKID_MST_F_SCLK]		= &mst_f_sclk.hw,
-		[AUD_CLKID_MST_A_LRCLK_DIV]	= &mst_a_lrclk_div.hw,
-		[AUD_CLKID_MST_B_LRCLK_DIV]	= &mst_b_lrclk_div.hw,
-		[AUD_CLKID_MST_C_LRCLK_DIV]	= &mst_c_lrclk_div.hw,
-		[AUD_CLKID_MST_D_LRCLK_DIV]	= &mst_d_lrclk_div.hw,
-		[AUD_CLKID_MST_E_LRCLK_DIV]	= &mst_e_lrclk_div.hw,
-		[AUD_CLKID_MST_F_LRCLK_DIV]	= &mst_f_lrclk_div.hw,
-		[AUD_CLKID_MST_A_LRCLK]		= &mst_a_lrclk.hw,
-		[AUD_CLKID_MST_B_LRCLK]		= &mst_b_lrclk.hw,
-		[AUD_CLKID_MST_C_LRCLK]		= &mst_c_lrclk.hw,
-		[AUD_CLKID_MST_D_LRCLK]		= &mst_d_lrclk.hw,
-		[AUD_CLKID_MST_E_LRCLK]		= &mst_e_lrclk.hw,
-		[AUD_CLKID_MST_F_LRCLK]		= &mst_f_lrclk.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &tdmin_a_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &tdmin_b_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_SEL]	= &tdmin_c_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &tdmin_lb_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &tdmout_a_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &tdmout_b_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_SEL]	= &tdmout_c_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &tdmin_a_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &tdmin_b_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_PRE_EN]	= &tdmin_c_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_A_SCLK]	= &tdmin_a_sclk.hw,
-		[AUD_CLKID_TDMIN_B_SCLK]	= &tdmin_b_sclk.hw,
-		[AUD_CLKID_TDMIN_C_SCLK]	= &tdmin_c_sclk.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK]	= &tdmin_lb_sclk.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK]	= &axg_tdmout_a_sclk.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK]	= &axg_tdmout_b_sclk.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK]	= &axg_tdmout_c_sclk.hw,
-		[AUD_CLKID_TDMIN_A_LRCLK]	= &tdmin_a_lrclk.hw,
-		[AUD_CLKID_TDMIN_B_LRCLK]	= &tdmin_b_lrclk.hw,
-		[AUD_CLKID_TDMIN_C_LRCLK]	= &tdmin_c_lrclk.hw,
-		[AUD_CLKID_TDMIN_LB_LRCLK]	= &tdmin_lb_lrclk.hw,
-		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
-		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
-		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
-		[AUD_CLKID_TOP]			= &axg_aud_top,
-		[NR_CLKS] = NULL,
-	},
-	.num = NR_CLKS,
+static struct clk_hw *axg_audio_hw_clks[] = {
+	[AUD_CLKID_DDR_ARB]		= &ddr_arb.hw,
+	[AUD_CLKID_PDM]			= &pdm.hw,
+	[AUD_CLKID_TDMIN_A]		= &tdmin_a.hw,
+	[AUD_CLKID_TDMIN_B]		= &tdmin_b.hw,
+	[AUD_CLKID_TDMIN_C]		= &tdmin_c.hw,
+	[AUD_CLKID_TDMIN_LB]		= &tdmin_lb.hw,
+	[AUD_CLKID_TDMOUT_A]		= &tdmout_a.hw,
+	[AUD_CLKID_TDMOUT_B]		= &tdmout_b.hw,
+	[AUD_CLKID_TDMOUT_C]		= &tdmout_c.hw,
+	[AUD_CLKID_FRDDR_A]		= &frddr_a.hw,
+	[AUD_CLKID_FRDDR_B]		= &frddr_b.hw,
+	[AUD_CLKID_FRDDR_C]		= &frddr_c.hw,
+	[AUD_CLKID_TODDR_A]		= &toddr_a.hw,
+	[AUD_CLKID_TODDR_B]		= &toddr_b.hw,
+	[AUD_CLKID_TODDR_C]		= &toddr_c.hw,
+	[AUD_CLKID_LOOPBACK]		= &loopback.hw,
+	[AUD_CLKID_SPDIFIN]		= &spdifin.hw,
+	[AUD_CLKID_SPDIFOUT]		= &spdifout.hw,
+	[AUD_CLKID_RESAMPLE]		= &resample.hw,
+	[AUD_CLKID_POWER_DETECT]	= &power_detect.hw,
+	[AUD_CLKID_MST_A_MCLK_SEL]	= &mst_a_mclk_sel.hw,
+	[AUD_CLKID_MST_B_MCLK_SEL]	= &mst_b_mclk_sel.hw,
+	[AUD_CLKID_MST_C_MCLK_SEL]	= &mst_c_mclk_sel.hw,
+	[AUD_CLKID_MST_D_MCLK_SEL]	= &mst_d_mclk_sel.hw,
+	[AUD_CLKID_MST_E_MCLK_SEL]	= &mst_e_mclk_sel.hw,
+	[AUD_CLKID_MST_F_MCLK_SEL]	= &mst_f_mclk_sel.hw,
+	[AUD_CLKID_MST_A_MCLK_DIV]	= &mst_a_mclk_div.hw,
+	[AUD_CLKID_MST_B_MCLK_DIV]	= &mst_b_mclk_div.hw,
+	[AUD_CLKID_MST_C_MCLK_DIV]	= &mst_c_mclk_div.hw,
+	[AUD_CLKID_MST_D_MCLK_DIV]	= &mst_d_mclk_div.hw,
+	[AUD_CLKID_MST_E_MCLK_DIV]	= &mst_e_mclk_div.hw,
+	[AUD_CLKID_MST_F_MCLK_DIV]	= &mst_f_mclk_div.hw,
+	[AUD_CLKID_MST_A_MCLK]		= &mst_a_mclk.hw,
+	[AUD_CLKID_MST_B_MCLK]		= &mst_b_mclk.hw,
+	[AUD_CLKID_MST_C_MCLK]		= &mst_c_mclk.hw,
+	[AUD_CLKID_MST_D_MCLK]		= &mst_d_mclk.hw,
+	[AUD_CLKID_MST_E_MCLK]		= &mst_e_mclk.hw,
+	[AUD_CLKID_MST_F_MCLK]		= &mst_f_mclk.hw,
+	[AUD_CLKID_SPDIFOUT_CLK_SEL]	= &spdifout_clk_sel.hw,
+	[AUD_CLKID_SPDIFOUT_CLK_DIV]	= &spdifout_clk_div.hw,
+	[AUD_CLKID_SPDIFOUT_CLK]	= &spdifout_clk.hw,
+	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &spdifin_clk_sel.hw,
+	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &spdifin_clk_div.hw,
+	[AUD_CLKID_SPDIFIN_CLK]		= &spdifin_clk.hw,
+	[AUD_CLKID_PDM_DCLK_SEL]	= &pdm_dclk_sel.hw,
+	[AUD_CLKID_PDM_DCLK_DIV]	= &pdm_dclk_div.hw,
+	[AUD_CLKID_PDM_DCLK]		= &pdm_dclk.hw,
+	[AUD_CLKID_PDM_SYSCLK_SEL]	= &pdm_sysclk_sel.hw,
+	[AUD_CLKID_PDM_SYSCLK_DIV]	= &pdm_sysclk_div.hw,
+	[AUD_CLKID_PDM_SYSCLK]		= &pdm_sysclk.hw,
+	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &mst_a_sclk_pre_en.hw,
+	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &mst_b_sclk_pre_en.hw,
+	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &mst_c_sclk_pre_en.hw,
+	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &mst_d_sclk_pre_en.hw,
+	[AUD_CLKID_MST_E_SCLK_PRE_EN]	= &mst_e_sclk_pre_en.hw,
+	[AUD_CLKID_MST_F_SCLK_PRE_EN]	= &mst_f_sclk_pre_en.hw,
+	[AUD_CLKID_MST_A_SCLK_DIV]	= &mst_a_sclk_div.hw,
+	[AUD_CLKID_MST_B_SCLK_DIV]	= &mst_b_sclk_div.hw,
+	[AUD_CLKID_MST_C_SCLK_DIV]	= &mst_c_sclk_div.hw,
+	[AUD_CLKID_MST_D_SCLK_DIV]	= &mst_d_sclk_div.hw,
+	[AUD_CLKID_MST_E_SCLK_DIV]	= &mst_e_sclk_div.hw,
+	[AUD_CLKID_MST_F_SCLK_DIV]	= &mst_f_sclk_div.hw,
+	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &mst_a_sclk_post_en.hw,
+	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &mst_b_sclk_post_en.hw,
+	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &mst_c_sclk_post_en.hw,
+	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &mst_d_sclk_post_en.hw,
+	[AUD_CLKID_MST_E_SCLK_POST_EN]	= &mst_e_sclk_post_en.hw,
+	[AUD_CLKID_MST_F_SCLK_POST_EN]	= &mst_f_sclk_post_en.hw,
+	[AUD_CLKID_MST_A_SCLK]		= &mst_a_sclk.hw,
+	[AUD_CLKID_MST_B_SCLK]		= &mst_b_sclk.hw,
+	[AUD_CLKID_MST_C_SCLK]		= &mst_c_sclk.hw,
+	[AUD_CLKID_MST_D_SCLK]		= &mst_d_sclk.hw,
+	[AUD_CLKID_MST_E_SCLK]		= &mst_e_sclk.hw,
+	[AUD_CLKID_MST_F_SCLK]		= &mst_f_sclk.hw,
+	[AUD_CLKID_MST_A_LRCLK_DIV]	= &mst_a_lrclk_div.hw,
+	[AUD_CLKID_MST_B_LRCLK_DIV]	= &mst_b_lrclk_div.hw,
+	[AUD_CLKID_MST_C_LRCLK_DIV]	= &mst_c_lrclk_div.hw,
+	[AUD_CLKID_MST_D_LRCLK_DIV]	= &mst_d_lrclk_div.hw,
+	[AUD_CLKID_MST_E_LRCLK_DIV]	= &mst_e_lrclk_div.hw,
+	[AUD_CLKID_MST_F_LRCLK_DIV]	= &mst_f_lrclk_div.hw,
+	[AUD_CLKID_MST_A_LRCLK]		= &mst_a_lrclk.hw,
+	[AUD_CLKID_MST_B_LRCLK]		= &mst_b_lrclk.hw,
+	[AUD_CLKID_MST_C_LRCLK]		= &mst_c_lrclk.hw,
+	[AUD_CLKID_MST_D_LRCLK]		= &mst_d_lrclk.hw,
+	[AUD_CLKID_MST_E_LRCLK]		= &mst_e_lrclk.hw,
+	[AUD_CLKID_MST_F_LRCLK]		= &mst_f_lrclk.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &tdmin_a_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &tdmin_b_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_SEL]	= &tdmin_c_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &tdmin_lb_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &tdmout_a_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &tdmout_b_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_SEL]	= &tdmout_c_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &tdmin_a_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &tdmin_b_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_PRE_EN]	= &tdmin_c_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_A_SCLK]	= &tdmin_a_sclk.hw,
+	[AUD_CLKID_TDMIN_B_SCLK]	= &tdmin_b_sclk.hw,
+	[AUD_CLKID_TDMIN_C_SCLK]	= &tdmin_c_sclk.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK]	= &tdmin_lb_sclk.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK]	= &axg_tdmout_a_sclk.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK]	= &axg_tdmout_b_sclk.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK]	= &axg_tdmout_c_sclk.hw,
+	[AUD_CLKID_TDMIN_A_LRCLK]	= &tdmin_a_lrclk.hw,
+	[AUD_CLKID_TDMIN_B_LRCLK]	= &tdmin_b_lrclk.hw,
+	[AUD_CLKID_TDMIN_C_LRCLK]	= &tdmin_c_lrclk.hw,
+	[AUD_CLKID_TDMIN_LB_LRCLK]	= &tdmin_lb_lrclk.hw,
+	[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
+	[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
+	[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
+	[AUD_CLKID_TOP]			= &axg_aud_top,
 };
 
 /*
  * Array of all G12A clocks provided by this provider
  * The input clocks of the controller will be populated at runtime
  */
-static struct clk_hw_onecell_data g12a_audio_hw_onecell_data = {
-	.hws = {
-		[AUD_CLKID_DDR_ARB]		= &ddr_arb.hw,
-		[AUD_CLKID_PDM]			= &pdm.hw,
-		[AUD_CLKID_TDMIN_A]		= &tdmin_a.hw,
-		[AUD_CLKID_TDMIN_B]		= &tdmin_b.hw,
-		[AUD_CLKID_TDMIN_C]		= &tdmin_c.hw,
-		[AUD_CLKID_TDMIN_LB]		= &tdmin_lb.hw,
-		[AUD_CLKID_TDMOUT_A]		= &tdmout_a.hw,
-		[AUD_CLKID_TDMOUT_B]		= &tdmout_b.hw,
-		[AUD_CLKID_TDMOUT_C]		= &tdmout_c.hw,
-		[AUD_CLKID_FRDDR_A]		= &frddr_a.hw,
-		[AUD_CLKID_FRDDR_B]		= &frddr_b.hw,
-		[AUD_CLKID_FRDDR_C]		= &frddr_c.hw,
-		[AUD_CLKID_TODDR_A]		= &toddr_a.hw,
-		[AUD_CLKID_TODDR_B]		= &toddr_b.hw,
-		[AUD_CLKID_TODDR_C]		= &toddr_c.hw,
-		[AUD_CLKID_LOOPBACK]		= &loopback.hw,
-		[AUD_CLKID_SPDIFIN]		= &spdifin.hw,
-		[AUD_CLKID_SPDIFOUT]		= &spdifout.hw,
-		[AUD_CLKID_RESAMPLE]		= &resample.hw,
-		[AUD_CLKID_POWER_DETECT]	= &power_detect.hw,
-		[AUD_CLKID_SPDIFOUT_B]		= &spdifout_b.hw,
-		[AUD_CLKID_MST_A_MCLK_SEL]	= &mst_a_mclk_sel.hw,
-		[AUD_CLKID_MST_B_MCLK_SEL]	= &mst_b_mclk_sel.hw,
-		[AUD_CLKID_MST_C_MCLK_SEL]	= &mst_c_mclk_sel.hw,
-		[AUD_CLKID_MST_D_MCLK_SEL]	= &mst_d_mclk_sel.hw,
-		[AUD_CLKID_MST_E_MCLK_SEL]	= &mst_e_mclk_sel.hw,
-		[AUD_CLKID_MST_F_MCLK_SEL]	= &mst_f_mclk_sel.hw,
-		[AUD_CLKID_MST_A_MCLK_DIV]	= &mst_a_mclk_div.hw,
-		[AUD_CLKID_MST_B_MCLK_DIV]	= &mst_b_mclk_div.hw,
-		[AUD_CLKID_MST_C_MCLK_DIV]	= &mst_c_mclk_div.hw,
-		[AUD_CLKID_MST_D_MCLK_DIV]	= &mst_d_mclk_div.hw,
-		[AUD_CLKID_MST_E_MCLK_DIV]	= &mst_e_mclk_div.hw,
-		[AUD_CLKID_MST_F_MCLK_DIV]	= &mst_f_mclk_div.hw,
-		[AUD_CLKID_MST_A_MCLK]		= &mst_a_mclk.hw,
-		[AUD_CLKID_MST_B_MCLK]		= &mst_b_mclk.hw,
-		[AUD_CLKID_MST_C_MCLK]		= &mst_c_mclk.hw,
-		[AUD_CLKID_MST_D_MCLK]		= &mst_d_mclk.hw,
-		[AUD_CLKID_MST_E_MCLK]		= &mst_e_mclk.hw,
-		[AUD_CLKID_MST_F_MCLK]		= &mst_f_mclk.hw,
-		[AUD_CLKID_SPDIFOUT_CLK_SEL]	= &spdifout_clk_sel.hw,
-		[AUD_CLKID_SPDIFOUT_CLK_DIV]	= &spdifout_clk_div.hw,
-		[AUD_CLKID_SPDIFOUT_CLK]	= &spdifout_clk.hw,
-		[AUD_CLKID_SPDIFOUT_B_CLK_SEL]	= &spdifout_b_clk_sel.hw,
-		[AUD_CLKID_SPDIFOUT_B_CLK_DIV]	= &spdifout_b_clk_div.hw,
-		[AUD_CLKID_SPDIFOUT_B_CLK]	= &spdifout_b_clk.hw,
-		[AUD_CLKID_SPDIFIN_CLK_SEL]	= &spdifin_clk_sel.hw,
-		[AUD_CLKID_SPDIFIN_CLK_DIV]	= &spdifin_clk_div.hw,
-		[AUD_CLKID_SPDIFIN_CLK]		= &spdifin_clk.hw,
-		[AUD_CLKID_PDM_DCLK_SEL]	= &pdm_dclk_sel.hw,
-		[AUD_CLKID_PDM_DCLK_DIV]	= &pdm_dclk_div.hw,
-		[AUD_CLKID_PDM_DCLK]		= &pdm_dclk.hw,
-		[AUD_CLKID_PDM_SYSCLK_SEL]	= &pdm_sysclk_sel.hw,
-		[AUD_CLKID_PDM_SYSCLK_DIV]	= &pdm_sysclk_div.hw,
-		[AUD_CLKID_PDM_SYSCLK]		= &pdm_sysclk.hw,
-		[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &mst_a_sclk_pre_en.hw,
-		[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &mst_b_sclk_pre_en.hw,
-		[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &mst_c_sclk_pre_en.hw,
-		[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &mst_d_sclk_pre_en.hw,
-		[AUD_CLKID_MST_E_SCLK_PRE_EN]	= &mst_e_sclk_pre_en.hw,
-		[AUD_CLKID_MST_F_SCLK_PRE_EN]	= &mst_f_sclk_pre_en.hw,
-		[AUD_CLKID_MST_A_SCLK_DIV]	= &mst_a_sclk_div.hw,
-		[AUD_CLKID_MST_B_SCLK_DIV]	= &mst_b_sclk_div.hw,
-		[AUD_CLKID_MST_C_SCLK_DIV]	= &mst_c_sclk_div.hw,
-		[AUD_CLKID_MST_D_SCLK_DIV]	= &mst_d_sclk_div.hw,
-		[AUD_CLKID_MST_E_SCLK_DIV]	= &mst_e_sclk_div.hw,
-		[AUD_CLKID_MST_F_SCLK_DIV]	= &mst_f_sclk_div.hw,
-		[AUD_CLKID_MST_A_SCLK_POST_EN]	= &mst_a_sclk_post_en.hw,
-		[AUD_CLKID_MST_B_SCLK_POST_EN]	= &mst_b_sclk_post_en.hw,
-		[AUD_CLKID_MST_C_SCLK_POST_EN]	= &mst_c_sclk_post_en.hw,
-		[AUD_CLKID_MST_D_SCLK_POST_EN]	= &mst_d_sclk_post_en.hw,
-		[AUD_CLKID_MST_E_SCLK_POST_EN]	= &mst_e_sclk_post_en.hw,
-		[AUD_CLKID_MST_F_SCLK_POST_EN]	= &mst_f_sclk_post_en.hw,
-		[AUD_CLKID_MST_A_SCLK]		= &mst_a_sclk.hw,
-		[AUD_CLKID_MST_B_SCLK]		= &mst_b_sclk.hw,
-		[AUD_CLKID_MST_C_SCLK]		= &mst_c_sclk.hw,
-		[AUD_CLKID_MST_D_SCLK]		= &mst_d_sclk.hw,
-		[AUD_CLKID_MST_E_SCLK]		= &mst_e_sclk.hw,
-		[AUD_CLKID_MST_F_SCLK]		= &mst_f_sclk.hw,
-		[AUD_CLKID_MST_A_LRCLK_DIV]	= &mst_a_lrclk_div.hw,
-		[AUD_CLKID_MST_B_LRCLK_DIV]	= &mst_b_lrclk_div.hw,
-		[AUD_CLKID_MST_C_LRCLK_DIV]	= &mst_c_lrclk_div.hw,
-		[AUD_CLKID_MST_D_LRCLK_DIV]	= &mst_d_lrclk_div.hw,
-		[AUD_CLKID_MST_E_LRCLK_DIV]	= &mst_e_lrclk_div.hw,
-		[AUD_CLKID_MST_F_LRCLK_DIV]	= &mst_f_lrclk_div.hw,
-		[AUD_CLKID_MST_A_LRCLK]		= &mst_a_lrclk.hw,
-		[AUD_CLKID_MST_B_LRCLK]		= &mst_b_lrclk.hw,
-		[AUD_CLKID_MST_C_LRCLK]		= &mst_c_lrclk.hw,
-		[AUD_CLKID_MST_D_LRCLK]		= &mst_d_lrclk.hw,
-		[AUD_CLKID_MST_E_LRCLK]		= &mst_e_lrclk.hw,
-		[AUD_CLKID_MST_F_LRCLK]		= &mst_f_lrclk.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &tdmin_a_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &tdmin_b_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_SEL]	= &tdmin_c_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &tdmin_lb_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &tdmout_a_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &tdmout_b_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_SEL]	= &tdmout_c_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &tdmin_a_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &tdmin_b_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_PRE_EN]	= &tdmin_c_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_A_SCLK]	= &tdmin_a_sclk.hw,
-		[AUD_CLKID_TDMIN_B_SCLK]	= &tdmin_b_sclk.hw,
-		[AUD_CLKID_TDMIN_C_SCLK]	= &tdmin_c_sclk.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK]	= &tdmin_lb_sclk.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK]	= &g12a_tdmout_a_sclk.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK]	= &g12a_tdmout_b_sclk.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK]	= &g12a_tdmout_c_sclk.hw,
-		[AUD_CLKID_TDMIN_A_LRCLK]	= &tdmin_a_lrclk.hw,
-		[AUD_CLKID_TDMIN_B_LRCLK]	= &tdmin_b_lrclk.hw,
-		[AUD_CLKID_TDMIN_C_LRCLK]	= &tdmin_c_lrclk.hw,
-		[AUD_CLKID_TDMIN_LB_LRCLK]	= &tdmin_lb_lrclk.hw,
-		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
-		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
-		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
-		[AUD_CLKID_TDM_MCLK_PAD0]	= &g12a_tdm_mclk_pad_0.hw,
-		[AUD_CLKID_TDM_MCLK_PAD1]	= &g12a_tdm_mclk_pad_1.hw,
-		[AUD_CLKID_TDM_LRCLK_PAD0]	= &g12a_tdm_lrclk_pad_0.hw,
-		[AUD_CLKID_TDM_LRCLK_PAD1]	= &g12a_tdm_lrclk_pad_1.hw,
-		[AUD_CLKID_TDM_LRCLK_PAD2]	= &g12a_tdm_lrclk_pad_2.hw,
-		[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
-		[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
-		[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
-		[AUD_CLKID_TOP]			= &axg_aud_top,
-		[NR_CLKS] = NULL,
-	},
-	.num = NR_CLKS,
+static struct clk_hw *g12a_audio_hw_clks[] = {
+	[AUD_CLKID_DDR_ARB]		= &ddr_arb.hw,
+	[AUD_CLKID_PDM]			= &pdm.hw,
+	[AUD_CLKID_TDMIN_A]		= &tdmin_a.hw,
+	[AUD_CLKID_TDMIN_B]		= &tdmin_b.hw,
+	[AUD_CLKID_TDMIN_C]		= &tdmin_c.hw,
+	[AUD_CLKID_TDMIN_LB]		= &tdmin_lb.hw,
+	[AUD_CLKID_TDMOUT_A]		= &tdmout_a.hw,
+	[AUD_CLKID_TDMOUT_B]		= &tdmout_b.hw,
+	[AUD_CLKID_TDMOUT_C]		= &tdmout_c.hw,
+	[AUD_CLKID_FRDDR_A]		= &frddr_a.hw,
+	[AUD_CLKID_FRDDR_B]		= &frddr_b.hw,
+	[AUD_CLKID_FRDDR_C]		= &frddr_c.hw,
+	[AUD_CLKID_TODDR_A]		= &toddr_a.hw,
+	[AUD_CLKID_TODDR_B]		= &toddr_b.hw,
+	[AUD_CLKID_TODDR_C]		= &toddr_c.hw,
+	[AUD_CLKID_LOOPBACK]		= &loopback.hw,
+	[AUD_CLKID_SPDIFIN]		= &spdifin.hw,
+	[AUD_CLKID_SPDIFOUT]		= &spdifout.hw,
+	[AUD_CLKID_RESAMPLE]		= &resample.hw,
+	[AUD_CLKID_POWER_DETECT]	= &power_detect.hw,
+	[AUD_CLKID_SPDIFOUT_B]		= &spdifout_b.hw,
+	[AUD_CLKID_MST_A_MCLK_SEL]	= &mst_a_mclk_sel.hw,
+	[AUD_CLKID_MST_B_MCLK_SEL]	= &mst_b_mclk_sel.hw,
+	[AUD_CLKID_MST_C_MCLK_SEL]	= &mst_c_mclk_sel.hw,
+	[AUD_CLKID_MST_D_MCLK_SEL]	= &mst_d_mclk_sel.hw,
+	[AUD_CLKID_MST_E_MCLK_SEL]	= &mst_e_mclk_sel.hw,
+	[AUD_CLKID_MST_F_MCLK_SEL]	= &mst_f_mclk_sel.hw,
+	[AUD_CLKID_MST_A_MCLK_DIV]	= &mst_a_mclk_div.hw,
+	[AUD_CLKID_MST_B_MCLK_DIV]	= &mst_b_mclk_div.hw,
+	[AUD_CLKID_MST_C_MCLK_DIV]	= &mst_c_mclk_div.hw,
+	[AUD_CLKID_MST_D_MCLK_DIV]	= &mst_d_mclk_div.hw,
+	[AUD_CLKID_MST_E_MCLK_DIV]	= &mst_e_mclk_div.hw,
+	[AUD_CLKID_MST_F_MCLK_DIV]	= &mst_f_mclk_div.hw,
+	[AUD_CLKID_MST_A_MCLK]		= &mst_a_mclk.hw,
+	[AUD_CLKID_MST_B_MCLK]		= &mst_b_mclk.hw,
+	[AUD_CLKID_MST_C_MCLK]		= &mst_c_mclk.hw,
+	[AUD_CLKID_MST_D_MCLK]		= &mst_d_mclk.hw,
+	[AUD_CLKID_MST_E_MCLK]		= &mst_e_mclk.hw,
+	[AUD_CLKID_MST_F_MCLK]		= &mst_f_mclk.hw,
+	[AUD_CLKID_SPDIFOUT_CLK_SEL]	= &spdifout_clk_sel.hw,
+	[AUD_CLKID_SPDIFOUT_CLK_DIV]	= &spdifout_clk_div.hw,
+	[AUD_CLKID_SPDIFOUT_CLK]	= &spdifout_clk.hw,
+	[AUD_CLKID_SPDIFOUT_B_CLK_SEL]	= &spdifout_b_clk_sel.hw,
+	[AUD_CLKID_SPDIFOUT_B_CLK_DIV]	= &spdifout_b_clk_div.hw,
+	[AUD_CLKID_SPDIFOUT_B_CLK]	= &spdifout_b_clk.hw,
+	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &spdifin_clk_sel.hw,
+	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &spdifin_clk_div.hw,
+	[AUD_CLKID_SPDIFIN_CLK]		= &spdifin_clk.hw,
+	[AUD_CLKID_PDM_DCLK_SEL]	= &pdm_dclk_sel.hw,
+	[AUD_CLKID_PDM_DCLK_DIV]	= &pdm_dclk_div.hw,
+	[AUD_CLKID_PDM_DCLK]		= &pdm_dclk.hw,
+	[AUD_CLKID_PDM_SYSCLK_SEL]	= &pdm_sysclk_sel.hw,
+	[AUD_CLKID_PDM_SYSCLK_DIV]	= &pdm_sysclk_div.hw,
+	[AUD_CLKID_PDM_SYSCLK]		= &pdm_sysclk.hw,
+	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &mst_a_sclk_pre_en.hw,
+	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &mst_b_sclk_pre_en.hw,
+	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &mst_c_sclk_pre_en.hw,
+	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &mst_d_sclk_pre_en.hw,
+	[AUD_CLKID_MST_E_SCLK_PRE_EN]	= &mst_e_sclk_pre_en.hw,
+	[AUD_CLKID_MST_F_SCLK_PRE_EN]	= &mst_f_sclk_pre_en.hw,
+	[AUD_CLKID_MST_A_SCLK_DIV]	= &mst_a_sclk_div.hw,
+	[AUD_CLKID_MST_B_SCLK_DIV]	= &mst_b_sclk_div.hw,
+	[AUD_CLKID_MST_C_SCLK_DIV]	= &mst_c_sclk_div.hw,
+	[AUD_CLKID_MST_D_SCLK_DIV]	= &mst_d_sclk_div.hw,
+	[AUD_CLKID_MST_E_SCLK_DIV]	= &mst_e_sclk_div.hw,
+	[AUD_CLKID_MST_F_SCLK_DIV]	= &mst_f_sclk_div.hw,
+	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &mst_a_sclk_post_en.hw,
+	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &mst_b_sclk_post_en.hw,
+	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &mst_c_sclk_post_en.hw,
+	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &mst_d_sclk_post_en.hw,
+	[AUD_CLKID_MST_E_SCLK_POST_EN]	= &mst_e_sclk_post_en.hw,
+	[AUD_CLKID_MST_F_SCLK_POST_EN]	= &mst_f_sclk_post_en.hw,
+	[AUD_CLKID_MST_A_SCLK]		= &mst_a_sclk.hw,
+	[AUD_CLKID_MST_B_SCLK]		= &mst_b_sclk.hw,
+	[AUD_CLKID_MST_C_SCLK]		= &mst_c_sclk.hw,
+	[AUD_CLKID_MST_D_SCLK]		= &mst_d_sclk.hw,
+	[AUD_CLKID_MST_E_SCLK]		= &mst_e_sclk.hw,
+	[AUD_CLKID_MST_F_SCLK]		= &mst_f_sclk.hw,
+	[AUD_CLKID_MST_A_LRCLK_DIV]	= &mst_a_lrclk_div.hw,
+	[AUD_CLKID_MST_B_LRCLK_DIV]	= &mst_b_lrclk_div.hw,
+	[AUD_CLKID_MST_C_LRCLK_DIV]	= &mst_c_lrclk_div.hw,
+	[AUD_CLKID_MST_D_LRCLK_DIV]	= &mst_d_lrclk_div.hw,
+	[AUD_CLKID_MST_E_LRCLK_DIV]	= &mst_e_lrclk_div.hw,
+	[AUD_CLKID_MST_F_LRCLK_DIV]	= &mst_f_lrclk_div.hw,
+	[AUD_CLKID_MST_A_LRCLK]		= &mst_a_lrclk.hw,
+	[AUD_CLKID_MST_B_LRCLK]		= &mst_b_lrclk.hw,
+	[AUD_CLKID_MST_C_LRCLK]		= &mst_c_lrclk.hw,
+	[AUD_CLKID_MST_D_LRCLK]		= &mst_d_lrclk.hw,
+	[AUD_CLKID_MST_E_LRCLK]		= &mst_e_lrclk.hw,
+	[AUD_CLKID_MST_F_LRCLK]		= &mst_f_lrclk.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &tdmin_a_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &tdmin_b_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_SEL]	= &tdmin_c_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &tdmin_lb_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &tdmout_a_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &tdmout_b_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_SEL]	= &tdmout_c_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &tdmin_a_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &tdmin_b_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_PRE_EN]	= &tdmin_c_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_A_SCLK]	= &tdmin_a_sclk.hw,
+	[AUD_CLKID_TDMIN_B_SCLK]	= &tdmin_b_sclk.hw,
+	[AUD_CLKID_TDMIN_C_SCLK]	= &tdmin_c_sclk.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK]	= &tdmin_lb_sclk.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK]	= &g12a_tdmout_a_sclk.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK]	= &g12a_tdmout_b_sclk.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK]	= &g12a_tdmout_c_sclk.hw,
+	[AUD_CLKID_TDMIN_A_LRCLK]	= &tdmin_a_lrclk.hw,
+	[AUD_CLKID_TDMIN_B_LRCLK]	= &tdmin_b_lrclk.hw,
+	[AUD_CLKID_TDMIN_C_LRCLK]	= &tdmin_c_lrclk.hw,
+	[AUD_CLKID_TDMIN_LB_LRCLK]	= &tdmin_lb_lrclk.hw,
+	[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
+	[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
+	[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
+	[AUD_CLKID_TDM_MCLK_PAD0]	= &g12a_tdm_mclk_pad_0.hw,
+	[AUD_CLKID_TDM_MCLK_PAD1]	= &g12a_tdm_mclk_pad_1.hw,
+	[AUD_CLKID_TDM_LRCLK_PAD0]	= &g12a_tdm_lrclk_pad_0.hw,
+	[AUD_CLKID_TDM_LRCLK_PAD1]	= &g12a_tdm_lrclk_pad_1.hw,
+	[AUD_CLKID_TDM_LRCLK_PAD2]	= &g12a_tdm_lrclk_pad_2.hw,
+	[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
+	[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
+	[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
+	[AUD_CLKID_TOP]			= &axg_aud_top,
 };
 
 /*
  * Array of all SM1 clocks provided by this provider
  * The input clocks of the controller will be populated at runtime
  */
-static struct clk_hw_onecell_data sm1_audio_hw_onecell_data = {
-	.hws = {
-		[AUD_CLKID_DDR_ARB]		= &ddr_arb.hw,
-		[AUD_CLKID_PDM]			= &pdm.hw,
-		[AUD_CLKID_TDMIN_A]		= &tdmin_a.hw,
-		[AUD_CLKID_TDMIN_B]		= &tdmin_b.hw,
-		[AUD_CLKID_TDMIN_C]		= &tdmin_c.hw,
-		[AUD_CLKID_TDMIN_LB]		= &tdmin_lb.hw,
-		[AUD_CLKID_TDMOUT_A]		= &tdmout_a.hw,
-		[AUD_CLKID_TDMOUT_B]		= &tdmout_b.hw,
-		[AUD_CLKID_TDMOUT_C]		= &tdmout_c.hw,
-		[AUD_CLKID_FRDDR_A]		= &frddr_a.hw,
-		[AUD_CLKID_FRDDR_B]		= &frddr_b.hw,
-		[AUD_CLKID_FRDDR_C]		= &frddr_c.hw,
-		[AUD_CLKID_TODDR_A]		= &toddr_a.hw,
-		[AUD_CLKID_TODDR_B]		= &toddr_b.hw,
-		[AUD_CLKID_TODDR_C]		= &toddr_c.hw,
-		[AUD_CLKID_LOOPBACK]		= &loopback.hw,
-		[AUD_CLKID_SPDIFIN]		= &spdifin.hw,
-		[AUD_CLKID_SPDIFOUT]		= &spdifout.hw,
-		[AUD_CLKID_RESAMPLE]		= &resample.hw,
-		[AUD_CLKID_SPDIFOUT_B]		= &spdifout_b.hw,
-		[AUD_CLKID_MST_A_MCLK_SEL]	= &sm1_mst_a_mclk_sel.hw,
-		[AUD_CLKID_MST_B_MCLK_SEL]	= &sm1_mst_b_mclk_sel.hw,
-		[AUD_CLKID_MST_C_MCLK_SEL]	= &sm1_mst_c_mclk_sel.hw,
-		[AUD_CLKID_MST_D_MCLK_SEL]	= &sm1_mst_d_mclk_sel.hw,
-		[AUD_CLKID_MST_E_MCLK_SEL]	= &sm1_mst_e_mclk_sel.hw,
-		[AUD_CLKID_MST_F_MCLK_SEL]	= &sm1_mst_f_mclk_sel.hw,
-		[AUD_CLKID_MST_A_MCLK_DIV]	= &sm1_mst_a_mclk_div.hw,
-		[AUD_CLKID_MST_B_MCLK_DIV]	= &sm1_mst_b_mclk_div.hw,
-		[AUD_CLKID_MST_C_MCLK_DIV]	= &sm1_mst_c_mclk_div.hw,
-		[AUD_CLKID_MST_D_MCLK_DIV]	= &sm1_mst_d_mclk_div.hw,
-		[AUD_CLKID_MST_E_MCLK_DIV]	= &sm1_mst_e_mclk_div.hw,
-		[AUD_CLKID_MST_F_MCLK_DIV]	= &sm1_mst_f_mclk_div.hw,
-		[AUD_CLKID_MST_A_MCLK]		= &sm1_mst_a_mclk.hw,
-		[AUD_CLKID_MST_B_MCLK]		= &sm1_mst_b_mclk.hw,
-		[AUD_CLKID_MST_C_MCLK]		= &sm1_mst_c_mclk.hw,
-		[AUD_CLKID_MST_D_MCLK]		= &sm1_mst_d_mclk.hw,
-		[AUD_CLKID_MST_E_MCLK]		= &sm1_mst_e_mclk.hw,
-		[AUD_CLKID_MST_F_MCLK]		= &sm1_mst_f_mclk.hw,
-		[AUD_CLKID_SPDIFOUT_CLK_SEL]	= &spdifout_clk_sel.hw,
-		[AUD_CLKID_SPDIFOUT_CLK_DIV]	= &spdifout_clk_div.hw,
-		[AUD_CLKID_SPDIFOUT_CLK]	= &spdifout_clk.hw,
-		[AUD_CLKID_SPDIFOUT_B_CLK_SEL]	= &spdifout_b_clk_sel.hw,
-		[AUD_CLKID_SPDIFOUT_B_CLK_DIV]	= &spdifout_b_clk_div.hw,
-		[AUD_CLKID_SPDIFOUT_B_CLK]	= &spdifout_b_clk.hw,
-		[AUD_CLKID_SPDIFIN_CLK_SEL]	= &spdifin_clk_sel.hw,
-		[AUD_CLKID_SPDIFIN_CLK_DIV]	= &spdifin_clk_div.hw,
-		[AUD_CLKID_SPDIFIN_CLK]		= &spdifin_clk.hw,
-		[AUD_CLKID_PDM_DCLK_SEL]	= &pdm_dclk_sel.hw,
-		[AUD_CLKID_PDM_DCLK_DIV]	= &pdm_dclk_div.hw,
-		[AUD_CLKID_PDM_DCLK]		= &pdm_dclk.hw,
-		[AUD_CLKID_PDM_SYSCLK_SEL]	= &pdm_sysclk_sel.hw,
-		[AUD_CLKID_PDM_SYSCLK_DIV]	= &pdm_sysclk_div.hw,
-		[AUD_CLKID_PDM_SYSCLK]		= &pdm_sysclk.hw,
-		[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &mst_a_sclk_pre_en.hw,
-		[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &mst_b_sclk_pre_en.hw,
-		[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &mst_c_sclk_pre_en.hw,
-		[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &mst_d_sclk_pre_en.hw,
-		[AUD_CLKID_MST_E_SCLK_PRE_EN]	= &mst_e_sclk_pre_en.hw,
-		[AUD_CLKID_MST_F_SCLK_PRE_EN]	= &mst_f_sclk_pre_en.hw,
-		[AUD_CLKID_MST_A_SCLK_DIV]	= &mst_a_sclk_div.hw,
-		[AUD_CLKID_MST_B_SCLK_DIV]	= &mst_b_sclk_div.hw,
-		[AUD_CLKID_MST_C_SCLK_DIV]	= &mst_c_sclk_div.hw,
-		[AUD_CLKID_MST_D_SCLK_DIV]	= &mst_d_sclk_div.hw,
-		[AUD_CLKID_MST_E_SCLK_DIV]	= &mst_e_sclk_div.hw,
-		[AUD_CLKID_MST_F_SCLK_DIV]	= &mst_f_sclk_div.hw,
-		[AUD_CLKID_MST_A_SCLK_POST_EN]	= &mst_a_sclk_post_en.hw,
-		[AUD_CLKID_MST_B_SCLK_POST_EN]	= &mst_b_sclk_post_en.hw,
-		[AUD_CLKID_MST_C_SCLK_POST_EN]	= &mst_c_sclk_post_en.hw,
-		[AUD_CLKID_MST_D_SCLK_POST_EN]	= &mst_d_sclk_post_en.hw,
-		[AUD_CLKID_MST_E_SCLK_POST_EN]	= &mst_e_sclk_post_en.hw,
-		[AUD_CLKID_MST_F_SCLK_POST_EN]	= &mst_f_sclk_post_en.hw,
-		[AUD_CLKID_MST_A_SCLK]		= &mst_a_sclk.hw,
-		[AUD_CLKID_MST_B_SCLK]		= &mst_b_sclk.hw,
-		[AUD_CLKID_MST_C_SCLK]		= &mst_c_sclk.hw,
-		[AUD_CLKID_MST_D_SCLK]		= &mst_d_sclk.hw,
-		[AUD_CLKID_MST_E_SCLK]		= &mst_e_sclk.hw,
-		[AUD_CLKID_MST_F_SCLK]		= &mst_f_sclk.hw,
-		[AUD_CLKID_MST_A_LRCLK_DIV]	= &mst_a_lrclk_div.hw,
-		[AUD_CLKID_MST_B_LRCLK_DIV]	= &mst_b_lrclk_div.hw,
-		[AUD_CLKID_MST_C_LRCLK_DIV]	= &mst_c_lrclk_div.hw,
-		[AUD_CLKID_MST_D_LRCLK_DIV]	= &mst_d_lrclk_div.hw,
-		[AUD_CLKID_MST_E_LRCLK_DIV]	= &mst_e_lrclk_div.hw,
-		[AUD_CLKID_MST_F_LRCLK_DIV]	= &mst_f_lrclk_div.hw,
-		[AUD_CLKID_MST_A_LRCLK]		= &mst_a_lrclk.hw,
-		[AUD_CLKID_MST_B_LRCLK]		= &mst_b_lrclk.hw,
-		[AUD_CLKID_MST_C_LRCLK]		= &mst_c_lrclk.hw,
-		[AUD_CLKID_MST_D_LRCLK]		= &mst_d_lrclk.hw,
-		[AUD_CLKID_MST_E_LRCLK]		= &mst_e_lrclk.hw,
-		[AUD_CLKID_MST_F_LRCLK]		= &mst_f_lrclk.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &tdmin_a_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &tdmin_b_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_SEL]	= &tdmin_c_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &tdmin_lb_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &tdmout_a_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &tdmout_b_sclk_sel.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_SEL]	= &tdmout_c_sclk_sel.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &tdmin_a_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &tdmin_b_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_PRE_EN]	= &tdmin_c_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
-		[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
-		[AUD_CLKID_TDMIN_A_SCLK]	= &tdmin_a_sclk.hw,
-		[AUD_CLKID_TDMIN_B_SCLK]	= &tdmin_b_sclk.hw,
-		[AUD_CLKID_TDMIN_C_SCLK]	= &tdmin_c_sclk.hw,
-		[AUD_CLKID_TDMIN_LB_SCLK]	= &tdmin_lb_sclk.hw,
-		[AUD_CLKID_TDMOUT_A_SCLK]	= &g12a_tdmout_a_sclk.hw,
-		[AUD_CLKID_TDMOUT_B_SCLK]	= &g12a_tdmout_b_sclk.hw,
-		[AUD_CLKID_TDMOUT_C_SCLK]	= &g12a_tdmout_c_sclk.hw,
-		[AUD_CLKID_TDMIN_A_LRCLK]	= &tdmin_a_lrclk.hw,
-		[AUD_CLKID_TDMIN_B_LRCLK]	= &tdmin_b_lrclk.hw,
-		[AUD_CLKID_TDMIN_C_LRCLK]	= &tdmin_c_lrclk.hw,
-		[AUD_CLKID_TDMIN_LB_LRCLK]	= &tdmin_lb_lrclk.hw,
-		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
-		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
-		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
-		[AUD_CLKID_TDM_MCLK_PAD0]	= &sm1_tdm_mclk_pad_0.hw,
-		[AUD_CLKID_TDM_MCLK_PAD1]	= &sm1_tdm_mclk_pad_1.hw,
-		[AUD_CLKID_TDM_LRCLK_PAD0]	= &sm1_tdm_lrclk_pad_0.hw,
-		[AUD_CLKID_TDM_LRCLK_PAD1]	= &sm1_tdm_lrclk_pad_1.hw,
-		[AUD_CLKID_TDM_LRCLK_PAD2]	= &sm1_tdm_lrclk_pad_2.hw,
-		[AUD_CLKID_TDM_SCLK_PAD0]	= &sm1_tdm_sclk_pad_0.hw,
-		[AUD_CLKID_TDM_SCLK_PAD1]	= &sm1_tdm_sclk_pad_1.hw,
-		[AUD_CLKID_TDM_SCLK_PAD2]	= &sm1_tdm_sclk_pad_2.hw,
-		[AUD_CLKID_TOP]			= &sm1_aud_top.hw,
-		[AUD_CLKID_TORAM]		= &toram.hw,
-		[AUD_CLKID_EQDRC]		= &eqdrc.hw,
-		[AUD_CLKID_RESAMPLE_B]		= &resample_b.hw,
-		[AUD_CLKID_TOVAD]		= &tovad.hw,
-		[AUD_CLKID_LOCKER]		= &locker.hw,
-		[AUD_CLKID_SPDIFIN_LB]		= &spdifin_lb.hw,
-		[AUD_CLKID_FRDDR_D]		= &frddr_d.hw,
-		[AUD_CLKID_TODDR_D]		= &toddr_d.hw,
-		[AUD_CLKID_LOOPBACK_B]		= &loopback_b.hw,
-		[AUD_CLKID_CLK81_EN]		= &sm1_clk81_en.hw,
-		[AUD_CLKID_SYSCLK_A_DIV]	= &sm1_sysclk_a_div.hw,
-		[AUD_CLKID_SYSCLK_A_EN]		= &sm1_sysclk_a_en.hw,
-		[AUD_CLKID_SYSCLK_B_DIV]	= &sm1_sysclk_b_div.hw,
-		[AUD_CLKID_SYSCLK_B_EN]		= &sm1_sysclk_b_en.hw,
-		[NR_CLKS] = NULL,
-	},
-	.num = NR_CLKS,
+static struct clk_hw *sm1_audio_hw_clks[] = {
+	[AUD_CLKID_DDR_ARB]		= &ddr_arb.hw,
+	[AUD_CLKID_PDM]			= &pdm.hw,
+	[AUD_CLKID_TDMIN_A]		= &tdmin_a.hw,
+	[AUD_CLKID_TDMIN_B]		= &tdmin_b.hw,
+	[AUD_CLKID_TDMIN_C]		= &tdmin_c.hw,
+	[AUD_CLKID_TDMIN_LB]		= &tdmin_lb.hw,
+	[AUD_CLKID_TDMOUT_A]		= &tdmout_a.hw,
+	[AUD_CLKID_TDMOUT_B]		= &tdmout_b.hw,
+	[AUD_CLKID_TDMOUT_C]		= &tdmout_c.hw,
+	[AUD_CLKID_FRDDR_A]		= &frddr_a.hw,
+	[AUD_CLKID_FRDDR_B]		= &frddr_b.hw,
+	[AUD_CLKID_FRDDR_C]		= &frddr_c.hw,
+	[AUD_CLKID_TODDR_A]		= &toddr_a.hw,
+	[AUD_CLKID_TODDR_B]		= &toddr_b.hw,
+	[AUD_CLKID_TODDR_C]		= &toddr_c.hw,
+	[AUD_CLKID_LOOPBACK]		= &loopback.hw,
+	[AUD_CLKID_SPDIFIN]		= &spdifin.hw,
+	[AUD_CLKID_SPDIFOUT]		= &spdifout.hw,
+	[AUD_CLKID_RESAMPLE]		= &resample.hw,
+	[AUD_CLKID_SPDIFOUT_B]		= &spdifout_b.hw,
+	[AUD_CLKID_MST_A_MCLK_SEL]	= &sm1_mst_a_mclk_sel.hw,
+	[AUD_CLKID_MST_B_MCLK_SEL]	= &sm1_mst_b_mclk_sel.hw,
+	[AUD_CLKID_MST_C_MCLK_SEL]	= &sm1_mst_c_mclk_sel.hw,
+	[AUD_CLKID_MST_D_MCLK_SEL]	= &sm1_mst_d_mclk_sel.hw,
+	[AUD_CLKID_MST_E_MCLK_SEL]	= &sm1_mst_e_mclk_sel.hw,
+	[AUD_CLKID_MST_F_MCLK_SEL]	= &sm1_mst_f_mclk_sel.hw,
+	[AUD_CLKID_MST_A_MCLK_DIV]	= &sm1_mst_a_mclk_div.hw,
+	[AUD_CLKID_MST_B_MCLK_DIV]	= &sm1_mst_b_mclk_div.hw,
+	[AUD_CLKID_MST_C_MCLK_DIV]	= &sm1_mst_c_mclk_div.hw,
+	[AUD_CLKID_MST_D_MCLK_DIV]	= &sm1_mst_d_mclk_div.hw,
+	[AUD_CLKID_MST_E_MCLK_DIV]	= &sm1_mst_e_mclk_div.hw,
+	[AUD_CLKID_MST_F_MCLK_DIV]	= &sm1_mst_f_mclk_div.hw,
+	[AUD_CLKID_MST_A_MCLK]		= &sm1_mst_a_mclk.hw,
+	[AUD_CLKID_MST_B_MCLK]		= &sm1_mst_b_mclk.hw,
+	[AUD_CLKID_MST_C_MCLK]		= &sm1_mst_c_mclk.hw,
+	[AUD_CLKID_MST_D_MCLK]		= &sm1_mst_d_mclk.hw,
+	[AUD_CLKID_MST_E_MCLK]		= &sm1_mst_e_mclk.hw,
+	[AUD_CLKID_MST_F_MCLK]		= &sm1_mst_f_mclk.hw,
+	[AUD_CLKID_SPDIFOUT_CLK_SEL]	= &spdifout_clk_sel.hw,
+	[AUD_CLKID_SPDIFOUT_CLK_DIV]	= &spdifout_clk_div.hw,
+	[AUD_CLKID_SPDIFOUT_CLK]	= &spdifout_clk.hw,
+	[AUD_CLKID_SPDIFOUT_B_CLK_SEL]	= &spdifout_b_clk_sel.hw,
+	[AUD_CLKID_SPDIFOUT_B_CLK_DIV]	= &spdifout_b_clk_div.hw,
+	[AUD_CLKID_SPDIFOUT_B_CLK]	= &spdifout_b_clk.hw,
+	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &spdifin_clk_sel.hw,
+	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &spdifin_clk_div.hw,
+	[AUD_CLKID_SPDIFIN_CLK]		= &spdifin_clk.hw,
+	[AUD_CLKID_PDM_DCLK_SEL]	= &pdm_dclk_sel.hw,
+	[AUD_CLKID_PDM_DCLK_DIV]	= &pdm_dclk_div.hw,
+	[AUD_CLKID_PDM_DCLK]		= &pdm_dclk.hw,
+	[AUD_CLKID_PDM_SYSCLK_SEL]	= &pdm_sysclk_sel.hw,
+	[AUD_CLKID_PDM_SYSCLK_DIV]	= &pdm_sysclk_div.hw,
+	[AUD_CLKID_PDM_SYSCLK]		= &pdm_sysclk.hw,
+	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &mst_a_sclk_pre_en.hw,
+	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &mst_b_sclk_pre_en.hw,
+	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &mst_c_sclk_pre_en.hw,
+	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &mst_d_sclk_pre_en.hw,
+	[AUD_CLKID_MST_E_SCLK_PRE_EN]	= &mst_e_sclk_pre_en.hw,
+	[AUD_CLKID_MST_F_SCLK_PRE_EN]	= &mst_f_sclk_pre_en.hw,
+	[AUD_CLKID_MST_A_SCLK_DIV]	= &mst_a_sclk_div.hw,
+	[AUD_CLKID_MST_B_SCLK_DIV]	= &mst_b_sclk_div.hw,
+	[AUD_CLKID_MST_C_SCLK_DIV]	= &mst_c_sclk_div.hw,
+	[AUD_CLKID_MST_D_SCLK_DIV]	= &mst_d_sclk_div.hw,
+	[AUD_CLKID_MST_E_SCLK_DIV]	= &mst_e_sclk_div.hw,
+	[AUD_CLKID_MST_F_SCLK_DIV]	= &mst_f_sclk_div.hw,
+	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &mst_a_sclk_post_en.hw,
+	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &mst_b_sclk_post_en.hw,
+	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &mst_c_sclk_post_en.hw,
+	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &mst_d_sclk_post_en.hw,
+	[AUD_CLKID_MST_E_SCLK_POST_EN]	= &mst_e_sclk_post_en.hw,
+	[AUD_CLKID_MST_F_SCLK_POST_EN]	= &mst_f_sclk_post_en.hw,
+	[AUD_CLKID_MST_A_SCLK]		= &mst_a_sclk.hw,
+	[AUD_CLKID_MST_B_SCLK]		= &mst_b_sclk.hw,
+	[AUD_CLKID_MST_C_SCLK]		= &mst_c_sclk.hw,
+	[AUD_CLKID_MST_D_SCLK]		= &mst_d_sclk.hw,
+	[AUD_CLKID_MST_E_SCLK]		= &mst_e_sclk.hw,
+	[AUD_CLKID_MST_F_SCLK]		= &mst_f_sclk.hw,
+	[AUD_CLKID_MST_A_LRCLK_DIV]	= &mst_a_lrclk_div.hw,
+	[AUD_CLKID_MST_B_LRCLK_DIV]	= &mst_b_lrclk_div.hw,
+	[AUD_CLKID_MST_C_LRCLK_DIV]	= &mst_c_lrclk_div.hw,
+	[AUD_CLKID_MST_D_LRCLK_DIV]	= &mst_d_lrclk_div.hw,
+	[AUD_CLKID_MST_E_LRCLK_DIV]	= &mst_e_lrclk_div.hw,
+	[AUD_CLKID_MST_F_LRCLK_DIV]	= &mst_f_lrclk_div.hw,
+	[AUD_CLKID_MST_A_LRCLK]		= &mst_a_lrclk.hw,
+	[AUD_CLKID_MST_B_LRCLK]		= &mst_b_lrclk.hw,
+	[AUD_CLKID_MST_C_LRCLK]		= &mst_c_lrclk.hw,
+	[AUD_CLKID_MST_D_LRCLK]		= &mst_d_lrclk.hw,
+	[AUD_CLKID_MST_E_LRCLK]		= &mst_e_lrclk.hw,
+	[AUD_CLKID_MST_F_LRCLK]		= &mst_f_lrclk.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &tdmin_a_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &tdmin_b_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_SEL]	= &tdmin_c_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &tdmin_lb_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &tdmout_a_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &tdmout_b_sclk_sel.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_SEL]	= &tdmout_c_sclk_sel.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &tdmin_a_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &tdmin_b_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_PRE_EN]	= &tdmin_c_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
+	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
+	[AUD_CLKID_TDMIN_A_SCLK]	= &tdmin_a_sclk.hw,
+	[AUD_CLKID_TDMIN_B_SCLK]	= &tdmin_b_sclk.hw,
+	[AUD_CLKID_TDMIN_C_SCLK]	= &tdmin_c_sclk.hw,
+	[AUD_CLKID_TDMIN_LB_SCLK]	= &tdmin_lb_sclk.hw,
+	[AUD_CLKID_TDMOUT_A_SCLK]	= &g12a_tdmout_a_sclk.hw,
+	[AUD_CLKID_TDMOUT_B_SCLK]	= &g12a_tdmout_b_sclk.hw,
+	[AUD_CLKID_TDMOUT_C_SCLK]	= &g12a_tdmout_c_sclk.hw,
+	[AUD_CLKID_TDMIN_A_LRCLK]	= &tdmin_a_lrclk.hw,
+	[AUD_CLKID_TDMIN_B_LRCLK]	= &tdmin_b_lrclk.hw,
+	[AUD_CLKID_TDMIN_C_LRCLK]	= &tdmin_c_lrclk.hw,
+	[AUD_CLKID_TDMIN_LB_LRCLK]	= &tdmin_lb_lrclk.hw,
+	[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
+	[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
+	[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
+	[AUD_CLKID_TDM_MCLK_PAD0]	= &sm1_tdm_mclk_pad_0.hw,
+	[AUD_CLKID_TDM_MCLK_PAD1]	= &sm1_tdm_mclk_pad_1.hw,
+	[AUD_CLKID_TDM_LRCLK_PAD0]	= &sm1_tdm_lrclk_pad_0.hw,
+	[AUD_CLKID_TDM_LRCLK_PAD1]	= &sm1_tdm_lrclk_pad_1.hw,
+	[AUD_CLKID_TDM_LRCLK_PAD2]	= &sm1_tdm_lrclk_pad_2.hw,
+	[AUD_CLKID_TDM_SCLK_PAD0]	= &sm1_tdm_sclk_pad_0.hw,
+	[AUD_CLKID_TDM_SCLK_PAD1]	= &sm1_tdm_sclk_pad_1.hw,
+	[AUD_CLKID_TDM_SCLK_PAD2]	= &sm1_tdm_sclk_pad_2.hw,
+	[AUD_CLKID_TOP]			= &sm1_aud_top.hw,
+	[AUD_CLKID_TORAM]		= &toram.hw,
+	[AUD_CLKID_EQDRC]		= &eqdrc.hw,
+	[AUD_CLKID_RESAMPLE_B]		= &resample_b.hw,
+	[AUD_CLKID_TOVAD]		= &tovad.hw,
+	[AUD_CLKID_LOCKER]		= &locker.hw,
+	[AUD_CLKID_SPDIFIN_LB]		= &spdifin_lb.hw,
+	[AUD_CLKID_FRDDR_D]		= &frddr_d.hw,
+	[AUD_CLKID_TODDR_D]		= &toddr_d.hw,
+	[AUD_CLKID_LOOPBACK_B]		= &loopback_b.hw,
+	[AUD_CLKID_CLK81_EN]		= &sm1_clk81_en.hw,
+	[AUD_CLKID_SYSCLK_A_DIV]	= &sm1_sysclk_a_div.hw,
+	[AUD_CLKID_SYSCLK_A_EN]		= &sm1_sysclk_a_en.hw,
+	[AUD_CLKID_SYSCLK_B_DIV]	= &sm1_sysclk_b_div.hw,
+	[AUD_CLKID_SYSCLK_B_EN]		= &sm1_sysclk_b_en.hw,
 };
 
 
@@ -1745,11 +1733,25 @@ static const struct regmap_config axg_audio_regmap_cfg = {
 struct audioclk_data {
 	struct clk_regmap *const *regmap_clks;
 	unsigned int regmap_clk_num;
-	struct clk_hw_onecell_data *hw_onecell_data;
+	struct clk_hw **hw_clks;
+	unsigned int hw_clk_num;
 	unsigned int reset_offset;
 	unsigned int reset_num;
 };
 
+static struct clk_hw *axg_audio_clkc_hw_get(struct of_phandle_args *clkspec, void *clk_data)
+{
+	const struct audioclk_data *data = clk_data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->hw_clk_num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return data->hw_clks[idx];
+}
+
 static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1791,10 +1793,10 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		data->regmap_clks[i]->map = map;
 
 	/* Take care to skip the registered input clocks */
-	for (i = AUD_CLKID_DDR_ARB; i < data->hw_onecell_data->num; i++) {
+	for (i = AUD_CLKID_DDR_ARB; i < data->hw_clk_num; i++) {
 		const char *name;
 
-		hw = data->hw_onecell_data->hws[i];
+		hw = data->hw_clks[i];
 		/* array might be sparse */
 		if (!hw)
 			continue;
@@ -1808,8 +1810,7 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					data->hw_onecell_data);
+	ret = devm_of_clk_add_hw_provider(dev, axg_audio_clkc_hw_get, (void *)data);
 	if (ret)
 		return ret;
 
@@ -1834,13 +1835,15 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 static const struct audioclk_data axg_audioclk_data = {
 	.regmap_clks = axg_clk_regmaps,
 	.regmap_clk_num = ARRAY_SIZE(axg_clk_regmaps),
-	.hw_onecell_data = &axg_audio_hw_onecell_data,
+	.hw_clks = axg_audio_hw_clks,
+	.hw_clk_num = ARRAY_SIZE(axg_audio_hw_clks),
 };
 
 static const struct audioclk_data g12a_audioclk_data = {
 	.regmap_clks = g12a_clk_regmaps,
 	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
-	.hw_onecell_data = &g12a_audio_hw_onecell_data,
+	.hw_clks = g12a_audio_hw_clks,
+	.hw_clk_num = ARRAY_SIZE(g12a_audio_hw_clks),
 	.reset_offset = AUDIO_SW_RESET,
 	.reset_num = 26,
 };
@@ -1848,7 +1851,8 @@ static const struct audioclk_data g12a_audioclk_data = {
 static const struct audioclk_data sm1_audioclk_data = {
 	.regmap_clks = sm1_clk_regmaps,
 	.regmap_clk_num = ARRAY_SIZE(sm1_clk_regmaps),
-	.hw_onecell_data = &sm1_audio_hw_onecell_data,
+	.hw_clks = sm1_audio_hw_clks,
+	.hw_clk_num = ARRAY_SIZE(sm1_audio_hw_clks),
 	.reset_offset = AUDIO_SM1_SW_RESET0,
 	.reset_num = 39,
 };
diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
index fd65a7d0704b..d6ed27c77729 100644
--- a/drivers/clk/meson/axg-audio.h
+++ b/drivers/clk/meson/axg-audio.h
@@ -138,6 +138,4 @@
 /* include the CLKIDs which are part of the DT bindings */
 #include <dt-bindings/clock/axg-audio-clkc.h>
 
-#define NR_CLKS	178
-
 #endif /*__AXG_AUDIO_CLKC_H */

-- 
2.34.1

