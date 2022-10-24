Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE660B894
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiJXTvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiJXTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:50:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F5270224
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:16:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so6938001wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsCCx9OZk9wFj2/DVHgt3Y9x9iq5RdCeFLOz27acm5w=;
        b=rqeArR92TWQ6RMFWhsf399K640S+XpWzzZv06BhqjdvwBgv0cFuyfyNyVw75iHGq+8
         RWiFs4H8VIXOaELHbKBprqAia1Awk6Lwi+RPVbndvitt8QkbS47KwDs/FbIg2wq8O3/5
         cVb0db7gr1AjtxhQn9zfcUhSJdLi5SGAeKx2/+mLUUc8RBGpJESxwXXU2MnWH2LZaR0e
         Rwh15l2xncqt74wRRx5iOkDKcpKPaf355ULSzSd10eTVOtNDKitBopy5YwUj3UyIqMCG
         CvVwGye8RdcgcITtU1h8RRdKOol4euRSetT8TV2PbuJFNilDRCuVeBCtdaseqKitzI52
         3XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsCCx9OZk9wFj2/DVHgt3Y9x9iq5RdCeFLOz27acm5w=;
        b=z6ocHGtJwp8LBXfa4VEJKwPyyMOUsfIXew6KBKGnw5ya8GDsZguyBYvGXTzYMBIlMl
         //5w87EgnWYhlqZzS2mLasc0GmuvpDW2YQq/czslbHWbPhCEGgUd6psRkhDxvmAhm/Ax
         LlR7XbWyG7rhWrH2P9ShKQZUgj2DxISc7upa3O+ScZTL3WRgvCZXi0ZeIX338zpvlNy5
         wCGONWPJ/37+YSS2AcVCl0J9glgxA+a5X6rbLtc2vDlo1kYBnyb/ws78cTYuQL4+CzmQ
         XgyXY9p5N4uXNnIMlEhNpiVtOUVPFNFaGcT/zu2ehkhDLAY06lIJiijH97IHVls4a7nf
         00ZQ==
X-Gm-Message-State: ACrzQf2AZ2uhDXiUsyd+iSunF6+PWra6io3KMGg//Z+Y4suDU7e8u0g3
        Wchiw7oi/t6GbUEcf+zOrdfQrSNxFrqNfhQ1
X-Google-Smtp-Source: AMsMyM6cGnaibkVY0dxGk5oTUXkssUJiFnPCCLcipjCgPvWzce4rl5vGIg3GCHPqTtwzx8i3qFQgFg==
X-Received: by 2002:adf:a4cc:0:b0:235:f41c:aa1e with SMTP id h12-20020adfa4cc000000b00235f41caa1emr15137169wrb.515.1666617393516;
        Mon, 24 Oct 2022 06:16:33 -0700 (PDT)
Received: from fadwachiby.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l24-20020a056000023800b00236627c078esm6322307wrz.110.2022.10.24.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:16:32 -0700 (PDT)
From:   Fadwa CHIBY <fchiby@baylibre.com>
X-Google-Original-From: Fadwa CHIBY
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Fadwa CHIBY <fchiby@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/3] soc: mediatek: pwrap: add mt8365 SoC support
Date:   Mon, 24 Oct 2022 15:15:43 +0200
Message-Id: <20221024131544.31219-4-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024131544.31219-1-fchiby@baylibre.com>
References: <20221024131544.31219-1-fchiby@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add PMIC Wrap support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 78 ++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index d56b00023ccd..15789a03e6c6 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -983,6 +983,68 @@ static int mt8195_regs[] = {
 	[PWRAP_WACS2_RDATA] =		0x8A8,
 };
 
+static int mt8365_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_CSHEXT_WRITE] =		0x24,
+	[PWRAP_CSHEXT_READ] =		0x28,
+	[PWRAP_STAUPD_PRD] =		0x3c,
+	[PWRAP_STAUPD_GRPEN] =		0x40,
+	[PWRAP_STAUPD_MAN_TRIG] =	0x58,
+	[PWRAP_STAUPD_STA] =		0x5c,
+	[PWRAP_WRAP_STA] =		0x60,
+	[PWRAP_HARB_INIT] =		0x64,
+	[PWRAP_HARB_HPRIO] =		0x68,
+	[PWRAP_HIPRIO_ARB_EN] =		0x6c,
+	[PWRAP_HARB_STA0] =		0x70,
+	[PWRAP_HARB_STA1] =		0x74,
+	[PWRAP_MAN_EN] =		0x7c,
+	[PWRAP_MAN_CMD] =		0x80,
+	[PWRAP_MAN_RDATA] =		0x84,
+	[PWRAP_MAN_VLDCLR] =		0x88,
+	[PWRAP_WACS0_EN] =		0x8c,
+	[PWRAP_INIT_DONE0] =		0x90,
+	[PWRAP_WACS0_CMD] =		0xc00,
+	[PWRAP_WACS0_RDATA] =		0xc04,
+	[PWRAP_WACS0_VLDCLR] =		0xc08,
+	[PWRAP_WACS1_EN] =		0x94,
+	[PWRAP_INIT_DONE1] =		0x98,
+	[PWRAP_WACS2_EN] =		0x9c,
+	[PWRAP_INIT_DONE2] =		0xa0,
+	[PWRAP_WACS2_CMD] =		0xc20,
+	[PWRAP_WACS2_RDATA] =		0xc24,
+	[PWRAP_WACS2_VLDCLR] =		0xc28,
+	[PWRAP_INT_EN] =		0xb4,
+	[PWRAP_INT_FLG_RAW] =		0xb8,
+	[PWRAP_INT_FLG] =		0xbc,
+	[PWRAP_INT_CLR] =		0xc0,
+	[PWRAP_SIG_ADR] =		0xd4,
+	[PWRAP_SIG_MODE] =		0xd8,
+	[PWRAP_SIG_VALUE] =		0xdc,
+	[PWRAP_SIG_ERRVAL] =		0xe0,
+	[PWRAP_CRC_EN] =		0xe4,
+	[PWRAP_TIMER_EN] =		0xe8,
+	[PWRAP_TIMER_STA] =		0xec,
+	[PWRAP_WDT_UNIT] =		0xf0,
+	[PWRAP_WDT_SRC_EN] =		0xf4,
+	[PWRAP_WDT_FLG] =		0xfc,
+	[PWRAP_DEBUG_INT_SEL] =		0x104,
+	[PWRAP_CIPHER_KEY_SEL] =	0x1c4,
+	[PWRAP_CIPHER_IV_SEL] =		0x1c8,
+	[PWRAP_CIPHER_RDY] =		0x1d0,
+	[PWRAP_CIPHER_MODE] =		0x1d4,
+	[PWRAP_CIPHER_SWRST] =		0x1d8,
+	[PWRAP_DCM_EN] =		0x1dc,
+	[PWRAP_DCM_DBC_PRD] =		0x1e0,
+	[PWRAP_EINT_STA0_ADR] =		0x44,
+	[PWRAP_EINT_STA1_ADR] =		0x48,
+	[PWRAP_INT1_EN] =		0xc4,
+	[PWRAP_INT1_FLG] =		0xcc,
+	[PWRAP_INT1_CLR] =		0xd0,
+	[PWRAP_WDT_SRC_EN_1] =		0xf8,
+};
+
 static int mt8516_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1139,6 +1201,7 @@ enum pwrap_type {
 	PWRAP_MT8183,
 	PWRAP_MT8186,
 	PWRAP_MT8195,
+	PWRAP_MT8365,
 	PWRAP_MT8516,
 };
 
@@ -1598,6 +1661,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT6797:
 	case PWRAP_MT8173:
 	case PWRAP_MT8186:
+	case PWRAP_MT8365:
 	case PWRAP_MT8516:
 		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
 		break;
@@ -2106,6 +2170,19 @@ static struct pmic_wrapper_type pwrap_mt8195 = {
 	.init_soc_specific = NULL,
 };
 
+static const struct pmic_wrapper_type pwrap_mt8365 = {
+	.regs = mt8365_regs,
+	.type = PWRAP_MT8365,
+	.arb_en_all = 0x3ffff,
+	.int_en_all = 0x7f1fffff,
+	.int1_en_all = 0x0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static struct pmic_wrapper_type pwrap_mt8516 = {
 	.regs = mt8516_regs,
 	.type = PWRAP_MT8516,
@@ -2143,6 +2220,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
 	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
 	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
+	{ .compatible = "mediatek,mt8365-pwrap", .data = &pwrap_mt8365 },
 	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
 	{ /* sentinel */ }
 };
-- 
2.25.1

