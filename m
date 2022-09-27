Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43195EBD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiI0Igc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiI0Ifw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:35:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E471704A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:35:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so13815527wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=pTFms0OykH3h5MXVwN8YBhoi0TI1Pe+UVx7A8L2KakfX3kLpZCZkGMFYPUAkKuzcbE
         wtPwMtLJrVeH652MGYcMi60dHOAMdyvS7SDatjynaVk/iOTx2dmgUG8ApoYTaqVyEx6j
         QRGJz94Fzqj2Y8EyI5TVAq8w/Lb53YJpTwRKynC1UHwo8/g4m2gdgCiEZvxd/tjuy5KH
         qQR2Sqsuzxd6UE3QaS6YYQWSWp6hQexy8/BiVGducVK6/37nsx3/PfiyxLbMQnLIAgaD
         aHq9y/H4xsW7aWf9B+AYMI7qg/csh9vglI+NjMGDtmN8W8FF7ZFakW6a+i/r4zoj4PFE
         IDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=ys0AO8l37KWfHm/x9ktzgUJqMRbQfbIH6vSZ/KjtQoo5e1snZr0UGPOtiYFpSMFiDe
         X5ncd8qTsu9fEAv1qJPt5ufpGiUWy7/4/CdraxY+RExsqIgBSuftzOeGpHA3oIu3OTOW
         R7uhIPdrkTw5rKfG6tdnGX1dXTMBjnzwLB3wrBznh7ZwJkrL79XSD3IRmLlwTEPsgKHE
         ONIaH26ejBm9/xV3ffw55z6jXMhZpOqsnrmbwta7wgoNWCZYNnGdSSczygIidF34ADv3
         JrKb7DpanGGQ2CTj2srgF6pjmJsEkbKkGm7S2Iru8fGnKGsR6kuYWoA6VPXa+6yKzmdA
         Ws3g==
X-Gm-Message-State: ACrzQf3lr7RcYGH96OeKVXLRgbcmEbncPHT8jwhxOFNTd9dSylx14S75
        mIE+YMgeScsyWL3We3aKQD9JdA==
X-Google-Smtp-Source: AMsMyM5cO9jkRmX+HowsZSS0yY7CI8x+r8XkxeVyCukQTXCOS1+KOPhqOH5h5kzJe84U+XdKrTrP1A==
X-Received: by 2002:a5d:4bc3:0:b0:22a:4b7a:6f60 with SMTP id l3-20020a5d4bc3000000b0022a4b7a6f60mr15805099wrt.549.1664267737747;
        Tue, 27 Sep 2022 01:35:37 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b003b492b30822sm1122120wmr.2.2022.09.27.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:35:37 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v5 3/6] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
Date:   Tue, 27 Sep 2022 10:35:17 +0200
Message-Id: <20220927083520.15766-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927083520.15766-1-jneanne@baylibre.com>
References: <20220927083520.15766-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board uses the pin as a power-button, enable it.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1f7ce60ecb57..238798ea6a79 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -362,6 +362,7 @@
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		ti,power-button;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

