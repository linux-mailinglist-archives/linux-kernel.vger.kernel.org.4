Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC66C520E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCVRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjCVRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E4C64B28;
        Wed, 22 Mar 2023 10:15:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n19so1740892wms.0;
        Wed, 22 Mar 2023 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEknM98Izmc8d/crPsoJ+ejZxfl78958Ei6SPYhYDHs=;
        b=LTOQ75W3s5nYo+nEfiJAKqytSopONB4jCtU3zRygzPMasugVOrYFMsUR+WrpsAjuRT
         v4HgWpJxEsIWeRXrUN9W21mFXhGgJLJXSxRnrio0CsZZBNMdkebbNOphgKXIWAdm+2iM
         PzqAdGm5t38wT2mmm6V/9hCy90+12raHM82tNFdhhiezfg2cukVOKP3j/TeOVCwas0gQ
         iFc+CuZB6y73zYXvMUMUpTsqI5vev4xJsSMHIQJVmUxJAwqhOBhN9JCRo7Ao+wayjn2d
         Fxo6AV3A8v68nVfoQ0K0I+eWXG48nMCX45iWh/lVvVTOFcR99kn4va7NY1oVnPsh+WQz
         WcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEknM98Izmc8d/crPsoJ+ejZxfl78958Ei6SPYhYDHs=;
        b=wv2NSR1B5RnsdoEE7mgJSHAfSs1JHZbQ1HPMldyaGWAk1dcucqh/uDzM3Flz+ADRi1
         19NoaB2Ur7QaWZejbuplnIOK/nte3PnmqJ9ZNw8HejmuS4eU8mB1V1aJUSKSPGsfUi4a
         LYe3HSw87l0jrAC7ptdKvdUtzBoIkX0CeFvfguTQQkDhUTyAFIG144hY6uPXY9Mga96b
         gnNe2dLCzHQLbEJpaDaavT7FEEcLDxaq7jNcR2xqEEZaIwfcew+Q05t4xL/3i8GAj9Ru
         6ivQjIbBKfYQF88o7KnOW9o1wjrGsk+Nd4Iy0OLZix3JQasCJGrKV7ib5awI9J39upYV
         fa4A==
X-Gm-Message-State: AO0yUKWw75I1M5Vjrd4vXq4GTruQu0H84pycgyi2CT3bczTYRJpWmEWg
        +bHDhvp1n5IWW85GI9vKWpbclB13a/S0RQ==
X-Google-Smtp-Source: AK7set9T/2oJsVetUb2L4mPEWu8YqDrnK8EzHK5bJf1ABIa1Et8f7BFJ7AA3j14ITZuf8cH0HqlRtg==
X-Received: by 2002:a05:600c:2304:b0:3ed:2949:985b with SMTP id 4-20020a05600c230400b003ed2949985bmr206833wmo.23.1679505322457;
        Wed, 22 Mar 2023 10:15:22 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ee11ac2288sm8414333wmo.21.2023.03.22.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: clk: add BCM63268 timer clock definitions
Date:   Wed, 22 Mar 2023 18:15:12 +0100
Message-Id: <20230322171515.120353-2-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230322171515.120353-1-noltari@gmail.com>
References: <20230322171515.120353-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing timer clock definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v4: no changes
 v3: no changes
 v2: change commit title, as suggested by Stephen Boyd

 include/dt-bindings/clock/bcm63268-clock.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/clock/bcm63268-clock.h b/include/dt-bindings/clock/bcm63268-clock.h
index da23e691d359..dea8adc8510e 100644
--- a/include/dt-bindings/clock/bcm63268-clock.h
+++ b/include/dt-bindings/clock/bcm63268-clock.h
@@ -27,4 +27,17 @@
 #define BCM63268_CLK_TBUS	27
 #define BCM63268_CLK_ROBOSW250	31
 
+#define BCM63268_TCLK_EPHY1		0
+#define BCM63268_TCLK_EPHY2		1
+#define BCM63268_TCLK_EPHY3		2
+#define BCM63268_TCLK_GPHY1		3
+#define BCM63268_TCLK_DSL		4
+#define BCM63268_TCLK_WAKEON_EPHY	6
+#define BCM63268_TCLK_WAKEON_DSL	7
+#define BCM63268_TCLK_FAP1		11
+#define BCM63268_TCLK_FAP2		15
+#define BCM63268_TCLK_UTO_50		16
+#define BCM63268_TCLK_UTO_EXTIN		17
+#define BCM63268_TCLK_USB_REF		18
+
 #endif /* __DT_BINDINGS_CLOCK_BCM63268_H */
-- 
2.30.2

