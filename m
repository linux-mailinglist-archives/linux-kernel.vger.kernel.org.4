Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040045FB430
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJKOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJKOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:06:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FD95AFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:06:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so10438950wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=MV4snjjBiXRzzPWIibJpaF2CvqfAvYPXfwZ0rAzCb1mJ4yV3Dk1Dwhiy3x/USZGFHs
         +H9PVXDGQNXvYEU4o9+ZjOKc1h5UMztoiIb8sWLkVinXdPKZkhNwjCbgBZgUMmEnpM6w
         2kpFyL4ibU0zhLY3IYsKI8rx26oAxvCf/ox7jJuTXlxqgsa0BCtpWed895sBOLu8R3ZH
         AOnKE5ddAJuTiWDTs8/bI08J39qXH+TL0oQiEHfkVtvZG1/0eV3zpgckESn13YPr1Pxu
         R9V+T9AdQkePDZFlP7JwV7P4+kfCPaIJYKCogsVO9+fUbxnyW7y77AsO3+wtBRf+GvB1
         Mb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEgAz8TyTEUxFcTpNCv4lGZ7t5+w4UkFWYn6r6UPn6c=;
        b=X6Wd0RxL1g5QlzzBeM0wwAVWQvHT6B5iJwzPrC/pUPLmM98bCKRee63vZKkd40Q7tu
         jdAx+QtPXiln9rFap4hUNUVJUSV49rYtP2a8CedwbDF/lJ3noQ+MCQ2DHcIVEWTit0jf
         wvJi7h7wjdlhos1SSCXjtyqRKT5tx2VlygLkeYkXkioi5luJhrM0ykuz6/wmBuzjt7IR
         yWINicI1gZnxm13HZHAI5f3FK3GvO+u/QRtSjXlaGo+iqP9QqnjeK1K4rUYl3rgG+L3W
         S7zohDLmZKrtMeF8MHFav4HE8ws170GKdzyg16NbOqHLh0FNrOrjKvnKJA4NOc/YyF1E
         C9gg==
X-Gm-Message-State: ACrzQf0Rk5a77ekYxp5NetIO0Bkpd0qsH9rfOw4IuFmnXL+bpCJB/CUr
        Z1Wtclb2CbUJIHAlP533F+ahLWMcRdYufzvh
X-Google-Smtp-Source: AMsMyM4djnPlu2jPMzbCgVrog5BeyhIfrzYzDTCkDR4S96pWm2sLfQn+We+cfGF7nAXrUfx2bFNy7g==
X-Received: by 2002:a7b:cd96:0:b0:3b4:856a:28f7 with SMTP id y22-20020a7bcd96000000b003b4856a28f7mr16922694wmj.117.1665497162665;
        Tue, 11 Oct 2022 07:06:02 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0022e55f40bc7sm11437453wrr.82.2022.10.11.07.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:06:02 -0700 (PDT)
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
Subject: [PATCH v6 3/6] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
Date:   Tue, 11 Oct 2022 16:05:46 +0200
Message-Id: <20221011140549.16761-4-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011140549.16761-1-jneanne@baylibre.com>
References: <20221011140549.16761-1-jneanne@baylibre.com>
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

