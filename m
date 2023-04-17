Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7122D6E4F69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDQRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDQRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:39:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0071DAF38;
        Mon, 17 Apr 2023 10:39:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so2631415wmb.0;
        Mon, 17 Apr 2023 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753153; x=1684345153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge6TrlA/p6ayXQGvV+CbIXlcLyfgFjoT1Tk9+mFzZ08=;
        b=bTZdzl6lBI4dstbUO/p2qrGvtbkcTW2mtf6PCMDwAGQogvBo2DpxFxT+TyIy4yFCKb
         PLQjeaXy3AVVLmCHlLXCt/RfMtaUAtC+W43B9FYweyR8Y6e19XsFNvgTsIbk9jUlq579
         Q0o+4p9IYuKzXA2jo3FgNCxDssgoB+Bqi8x+UKkzg5U7w5qVT/WLimSAsW3NN6EfMl1r
         4+cbiTWuTl9m58uw0cD3P39Iirvt6Qhmv+bVwvZHWYSvkBN0vDzMJSgl+5CYJAr6wwxV
         HxPziUYEau1NmL2lHptCMAeM3PSmQy0ar+2Ejjpt+JmIXxPN4nh8a4vccRiwn9aWoVVO
         Q0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753153; x=1684345153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge6TrlA/p6ayXQGvV+CbIXlcLyfgFjoT1Tk9+mFzZ08=;
        b=bbKYr3bSw8NFzBXPuVH59ck+pXdgEDf0db9XM/qYbqz8HadTUcI5nv3i1RSPMMUfQG
         ouPcA+BvXMOW7cvRwmlRygDJ0hUuF+CS1+bxpgqODWneQ5vDaOj4GV1Nw8mcST9V1SkB
         GzNaZ2cpA2OZnfxOFZHbEvfVZEucPh8y0lluli8kvkMo+lRzjqq9t6FVs4kxZ2VHSNmW
         JpF0TqaBHXx8bNVvopwuQwNOgqg59Ke2vK5s9z9HYoPm/ueSBDncJCORxL9IHstbuVt8
         bPWZ+jNKNGoDtQOQYURxrQIPy9H6DaVcESfDBGDHR11UW0HBIDu/vIIjxKHc21GVkWB2
         CkmA==
X-Gm-Message-State: AAQBX9fVQXC10aLJt1D4/Kf0Szyaj9VJMWytsW5tp7jK2oWxyNvvg+oO
        SD9xNT9/kdGL6URSmA5QGwdjJ2PLpA/DmQ==
X-Google-Smtp-Source: AKy350Z/yYHKqmjJTzfYcXk95HfiN/oDh2I8Uf7raPkiokNLWc6L9VJpT9WmjO9h2n4ptxHOk9u2FQ==
X-Received: by 2002:a7b:c394:0:b0:3f1:6fb3:ffcc with SMTP id s20-20020a7bc394000000b003f16fb3ffccmr5428864wmj.22.1681753153286;
        Mon, 17 Apr 2023 10:39:13 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (35.145.195.178.dynamic.wline.res.cust.swisscom.ch. [178.195.145.35])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm2478211wmb.7.2023.04.17.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:39:12 -0700 (PDT)
From:   Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 3/4] arm64: dts: colibri-imx8x: fix iris pinctrl configuration
Date:   Mon, 17 Apr 2023 19:38:29 +0200
Message-Id: <20230417173830.19401-4-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
References: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Remove GPIO3_IO10 from Iris carrier board pinctrl configuration,
this is already defined in the SOM dtsi since this is a
standard SOM functionality (wake-up button).

Duplicating it leads to the following error message
imx8qxp-pinctrl scu:pinctrl: pin IMX8QXP_QSPI0A_DATA1 already requested

Fixes: aefb5e2d974d ("arm64: dts: colibri-imx8x: Add iris carrier board")

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
index 5f30c88855e7..f8953067bc3b 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -48,8 +48,7 @@ pinctrl_gpio_iris: gpioirisgrp {
 			   <IMX8QXP_SAI0_TXFS_LSIO_GPIO0_IO28		0x20>,		/* SODIMM 101 */
 			   <IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27		0x20>,		/* SODIMM  97 */
 			   <IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03	0x06000020>,	/* SODIMM  85 */
-			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20>,		/* SODIMM  79 */
-			   <IMX8QXP_QSPI0A_DATA1_LSIO_GPIO3_IO10	0x06700041>;	/* SODIMM  45 */
+			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20>;		/* SODIMM  79 */
 	};
 
 	pinctrl_uart1_forceoff: uart1forceoffgrp {
-- 
2.34.1

