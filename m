Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242656132D0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJaJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJaJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:35:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13016388
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:35:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o4so15104242wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtUZKzQUrpqcEXFv8pDDgeNhPJPq/sgeZszFG9JX3VY=;
        b=uS9vQFDcPVAgiNCyGslkup6PZZpz1fIO+HDVCnKJuRNi7aoSnXolCLjkRVOFsf3OIH
         tv3nRv3NqaUtC5/zZYjQsc9v70GO2wZLacs7yV75sdQTXwIrfF47TIz1hCEUvT0VrPpc
         GDStnwMm78uwhFSVGFqHOIloFVQWRRwnJ2fqeed1yZM2ssIoegQI0XW8h3yi4Fzfsnlc
         fPJlYjeeQP9PV+Hns6fh3KxugvlI6G3QN66VFHrqAZDR0/xlRtqjKMd7oT2Eo/M3fREo
         FZaKW9HSc0UmFjZD2AjnU+uwLsBJ7hwdQPhM4Vlu3yU5MWEEY00gXw3rM3+CjswrBEJw
         tYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtUZKzQUrpqcEXFv8pDDgeNhPJPq/sgeZszFG9JX3VY=;
        b=KU0K/ZP07czaZa0e4u3FjptHCS9fjCQRJ6FH6YzslRRqlC0WHhnOBmFArMSQwCki9n
         VdACwQvqqf6L3YnjKFvbXsAi75Z8teZGcam9vaonhG5P39LgHFBVZkynZvgZ8rHjss3y
         BRhFKTTR7nYELuV08S+pwAV4Wj/QV5NXiJecCR5nhdQx35h0g9mZNYQ8+3hBI7W5TRI+
         YZAZhKnF0f7EanuNEX5bpgTi5bjm1WzkZYZZxhj9Cbsx0qvDtRrdqA04E4mY9zXJVK2d
         uhAV27YqNgmkY6PdPRVbXK966IbZUyuaL5rwutS6hTQgmCXREfA5smyHbUpGkA7eKfTF
         FrfQ==
X-Gm-Message-State: ACrzQf0JvyAjGUwUaCWjc9FZtGUHCnbU1gxn99URLIQLGdBQoe8RGX+f
        vggNyCG0Rj0Vy3lURKx7Qjvn0Q==
X-Google-Smtp-Source: AMsMyM7OeTtHKwAub1eTZjiO9xB2sK31H/EwGu8cgLWdEFAmNA9ajcQP29UFSbB3sg6EoqwoUF5TxQ==
X-Received: by 2002:a5d:61c9:0:b0:236:781a:8d7e with SMTP id q9-20020a5d61c9000000b00236781a8d7emr7448092wrv.576.1667208901026;
        Mon, 31 Oct 2022 02:35:01 -0700 (PDT)
Received: from fadwachiby.lan ([2001:861:3104:1980:6db3:63f:b30d:9361])
        by smtp.gmail.com with ESMTPSA id t16-20020adff610000000b0023538fb27c1sm6547566wrp.85.2022.10.31.02.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:35:00 -0700 (PDT)
From:   fchiby@baylibre.com
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
Subject: [PATCH v3 3/3] soc: mediatek: pwrap: add mt8365 SoC support
Date:   Mon, 31 Oct 2022 10:33:58 +0100
Message-Id: <20221031093401.22916-4-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031093401.22916-1-fchiby@baylibre.com>
References: <20221031093401.22916-1-fchiby@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add PMIC Wrap support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

