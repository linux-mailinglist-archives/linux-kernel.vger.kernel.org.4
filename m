Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5465EBD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiI0Ig1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiI0Ifs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:35:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66915A2D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:35:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so5043986wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=26mHhiEWRCmHQANhFIxdEE/iPWuTtIYaTzT3xv6hslo=;
        b=j+3WjVpmzWdHSETe6MTOGRBFzbiixawFO2GaHu8QnVdGm+8wnHfDqoRJ1pYUEkxKu4
         s7FOegPUsUWCrn19OBgNNFfI7TAMkzF7iScw8M0SnhEnAeKpkfTnblNCzKlq/Dt2NxVE
         wH3aFvJPAS8eMsw/2b5CdcMCaDo+ExUimQdLDdS7WWfz/a1fp5bdhxlN3kcwhutYdYYX
         +WyhbFtqFaZEqnEhBf+bqT5pABl0pr5Admm2XXxXCjYX/mnxY60/0uSlAZNk0lHkfSui
         A9wUwpBzWeS4MB+1R/zrIqCyi0tDQJdVdJ60T2PlpQYBZ6EJIXLpem2kpLCqb4almQ1t
         yM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=26mHhiEWRCmHQANhFIxdEE/iPWuTtIYaTzT3xv6hslo=;
        b=aOtCE4iVWpygGHTCaBwBQxtGAwTD0MZgwrL7Bo+fdJKd92NdAzaETV6AVuPa0oefEi
         4a0Eoq/ozvRP9khjzLWm+lCsWOITcgokS+zxwmiVWLsmEhco0rE5HyrQ1rMg/03ZwrLz
         clIj+TELcq/tEQr85w6gct/CXrGCtM8P3WIGK9OjLYuvGTfO1j3Fng/5QV7tZMWzPW2x
         IA2A26SbsHNttjX2J2iBNfi96ppp/8F/PHta9q2XVsLekFVPuaQBV2mcE5RyITSy/0jz
         efHtVmg/AMOjN+RIJFM8uf1jM8LxCUwiUcasnvF2QiJN3N15zHP/f35Pe8+CLTFZ5PXf
         7Iow==
X-Gm-Message-State: ACrzQf2jVblLclkZRn4kDHMFWJgK/lmvRDMETS10mY/guU0g06AVXhkC
        16g0TvgivhFdFG8onAu0nbuH1g==
X-Google-Smtp-Source: AMsMyM5AK/UA8fdaCxkDYvovDUyzYod/AA3J2TiDOJ0V33ExYFn8HhlnXZvoIK2d7Aae1oCt/EOOOQ==
X-Received: by 2002:a05:600c:548b:b0:3b5:95b:57d3 with SMTP id iv11-20020a05600c548b00b003b5095b57d3mr1745563wmb.153.1664267734408;
        Tue, 27 Sep 2022 01:35:34 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b003b492b30822sm1122120wmr.2.2022.09.27.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:35:34 -0700 (PDT)
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
Subject: [PATCH v5 2/6] DONOTMERGE: arm64: dts: ti: Add pinmux and irq mapping for TPS65219 external interrupts
Date:   Tue, 27 Sep 2022 10:35:16 +0200
Message-Id: <20220927083520.15766-3-jneanne@baylibre.com>
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

Interrupt occurring on PMIC TPS65219 is propagated to SOC
through EXTINTn pin connected to gic500 interrupt controller

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 565b50810579..1f7ce60ecb57 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -294,6 +294,12 @@
 			AM64X_IOPAD(0x00b8, PIN_INPUT, 7) /* (Y7) PRG1_PRU0_GPO0.GPIO0_45 */
 		>;
 	};
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0278, PIN_INPUT, 0) /* (C19) EXTINTn */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -352,6 +358,10 @@
 		compatible = "ti,tps65219";
 		reg = <0x30>;
 		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

