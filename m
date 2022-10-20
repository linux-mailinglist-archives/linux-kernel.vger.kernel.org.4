Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38C606144
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJTNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJTNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:14:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF714D8CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:13:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v11so4879735wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot9nuC1I4qAigSvkVZLdiUhVV5F8thjtHAvIFE60P0s=;
        b=RfQd7pCu5JXtfHFtctkAdsV36AfpV51SnjlbQNPKe4zwbwR37DsF3XdxzHBe/dNAhU
         OLEFcUxJrTLfxU4wEyp82PJd03MrmVZIN4a67O2rTxIbHIrPFJRUFvqvlhwS3TzbhDY0
         YJ+aMgWruFtNr0CksFwNGKe1kxUsT0/1qPsDhykcmk5LmVFgYmKYTMcXnNcjm5vK5edw
         4YwkmOL7NOmFsPR9mX1QYF5zSi1Bs6EIvyfSRSMWAZhuAxF5j8yjpEVAjMOa8Y794+Ue
         XUd1zmboEzkUiiHzbKB7H9vHotDh4nroJv7yS2l42Skdh11REWPhwrJw9XAL5jQQCQ3n
         tsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot9nuC1I4qAigSvkVZLdiUhVV5F8thjtHAvIFE60P0s=;
        b=MXCeAKDS38XR6OpbmJmHblOJIEju4jg6bpNb9LaMLqpfSyJ4Kd/HEMS5e+S5CVgGLK
         6MrOgHWQXK5/e7/Zds8ti/3KskLc3SZg/vdqXpTSlH9lj6YKdUqhFORiV4vo7iQuZECc
         SnzN1lOPwfJO3MWf+p0HgdmZFS2iF0cfXunTqragjCThIYIIT0jAJe8exjtv+QrNitY2
         FQoYSa2tsOry1dOuSoechd9nHdvhtgWNyfwYPKynuX8Y2tjAyFL8yvQeiZa23bqWMUXt
         IyPMtzFaJoPrgoOYDgDV0NtkDHOA9dmOpFTj6F17wNp+zmwikRGbcnJHWfqdaaVTzHBV
         NlJA==
X-Gm-Message-State: ACrzQf3r6BSrGzR7cejGx0+jk0batIKp6ega373byvXxXRvO3p28KCep
        QGgNUrxNfgxYp6y5uAOyEUZ+8qJQhjn+xA==
X-Google-Smtp-Source: AMsMyM7eTn/HY8TMG4XXER2zpBfU9Os0yTIHlNciY86QkvzG+I7D/GNHezch8CN5w1iKmaPS8yF1Rg==
X-Received: by 2002:a05:600c:4f13:b0:3c6:eb72:51e3 with SMTP id l19-20020a05600c4f1300b003c6eb7251e3mr21174576wmq.34.1666271509601;
        Thu, 20 Oct 2022 06:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a82:90b0:2979:1615:9a68:f204])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b00228dff8d975sm16453927wru.109.2022.10.20.06.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:11:49 -0700 (PDT)
From:   fchiby@baylibre.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] soc: mediatek: pwrap: add mt8365 SoC support
Date:   Thu, 20 Oct 2022 15:09:57 +0200
Message-Id: <20221020130957.25197-4-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020130957.25197-1-fchiby@baylibre.com>
References: <20221020130957.25197-1-fchiby@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add PMIC Wrap support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
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

