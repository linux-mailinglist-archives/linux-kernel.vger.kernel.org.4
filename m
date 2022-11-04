Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344DF619B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiKDPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiKDPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:23:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89925EAD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:23:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l14so7551251wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj2w1tGqFrhwlCVV2d26VsI2mkbtG+prKkhLxaqop1w=;
        b=7hi4NUAF3YQFYWnwcghSF895+Ucy/0lZBvmaC00O1nAijKYfKRPwYzjXudWcNTAP3V
         IyGL5B4j3MSuwHFzyUiP8IZgOks+Xv3r0y1+XfzCELluGwRxK1X5Vefpy9bJ6+3w/SXy
         ABCEnlqsv2wr4CBH7vGrvHoxOpj17VqOz/H7J209joAGWBBwTywTCz+ju5TmIRseeK/S
         rAtW95P9TLGKLPA9EQiZEj+zCROXSg0ZTfSfpcNPrnn+UznU+/k2giaXDxM3s23t6GYU
         nz7X7gztUuRGDH43Tx012uBHOu5wM9+QakXmvdWvkPXQ1vxPLzwjmf7UUeGWJsfjj5pI
         AQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj2w1tGqFrhwlCVV2d26VsI2mkbtG+prKkhLxaqop1w=;
        b=Ow2ITGh2dssAbdWAG+spHNJ1mJLV7qad6UAnBQeqToqmx01wPPNbjy60owzDfIMc6V
         vVDJ1m/TS620D/gAEvKFTNLSyEcASCI8g//hbMvH3rAJgLoWL0Vqnt+b2xAh8UhTIig1
         39WsnUBwzUnaqqHe32fUoBLkTJRyeTFyAzn6gGayBtHCoUk7pVMHC8sSPX7BhqXsLX+J
         YImjptoM1fcUG/XufMQaNK7s/sJlqylWpffF4FgySyAKP9TIs79kUBDH2EYTVAV7qCjC
         C6f/yreFFEezLOv9BrUFfGU2FpzRLy2FNiX5q0Z7sPcut4l9fOshWNDHnI/d9f3mmdAc
         1AUQ==
X-Gm-Message-State: ACrzQf3m87sNi2KH9yPi3hn0OL9eWtQZA9nDN1dcegnsAYpXLwHa2VdN
        rfJ1T8DiPnVir/25oq1MtaYrjw==
X-Google-Smtp-Source: AMsMyM61scYrbyV5028sSGyUzL2AAUpuasdUgEm5WPNbWJ6QutskPUwsErARRq6d6Jr4qPDhz3m1VQ==
X-Received: by 2002:a5d:67cf:0:b0:236:6f36:6029 with SMTP id n15-20020a5d67cf000000b002366f366029mr22655592wrw.224.1667575412003;
        Fri, 04 Nov 2022 08:23:32 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c08a900b003b4935f04a4sm3689764wmp.5.2022.11.04.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:23:31 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v7 3/6] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
Date:   Fri,  4 Nov 2022 16:23:08 +0100
Message-Id: <20221104152311.1098603-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104152311.1098603-1-jneanne@baylibre.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
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

This board uses the pin as a power-button, enable it.

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 441bc746bda0..052a3fbc8a4f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -431,6 +431,7 @@ tps65219: pmic@30 {
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&gic500>;
 		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		ti,power-button;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.25.1

