Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CCC6164CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKBORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiKBORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:17:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845FB27DFA;
        Wed,  2 Nov 2022 07:17:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q9so45768231ejd.0;
        Wed, 02 Nov 2022 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OvsFvC7MAbEsOX8IFvWXL3yuohBpehZrnsumSS6l5Y=;
        b=I94xNZB032xN/I+xFwgS4i1xMTczslDTtHMUVGoshdZ/3RqrcVx6ggSO1gkrF1gjfX
         HKSBKCCRFP9Z4qEjiUmsiuNI1YiJqpJ1t+ucH8Bd0egieDq1dJ94kTcY4WT9Pw82pCI/
         ceAau4TdeCCagvYuTewmK7nvHyHUWj0Eb27ptkWPZpNvDL/GLSK1GQ3DhE2S4d9nBEYK
         8LgPm4QDL6s80i/5BTfLNm/jgp7DtF8Kmp5I5tcRaVuDgjZxT0KgA0eVrod8TB+vh9Zc
         7nbC69J1/ujjz21XwP4fvMs1jXgDwCMXLwORccXtYMeE7mqSiKf8QiaE1voLWuGOPNJQ
         n0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OvsFvC7MAbEsOX8IFvWXL3yuohBpehZrnsumSS6l5Y=;
        b=EsHVu3ZfH5rQIUZm/EypbMaUN1le3zQjeSf8Yp3VmL4SQE2nUayerHI7FBC7B4yjUE
         8aRY8FH/SeL5n8xq64x902LXsjnUO/Ep2n1w7PxhNZrQWYKpcO8jCf2VcZUNo/xXPL5l
         PmZut3S9cIL9iXiP81udIRSNfhhnnu7IV3Ql5e+KUrkiDFBdjq2PXMMFytWccFYewd3e
         s7fDTiq4/TyEeMFDBuVaIewYmwMbYKnu7Afa3pCQ+eBU3cPgPnJAggC/Qh0I6iX3db48
         HUEERcuzVNUEq2nYBJjZZVj3/x9SRr4Lt3Ro+jTqDIG1VfCsqGY3hND/xzGcnQx9KvO3
         He7g==
X-Gm-Message-State: ACrzQf1kVzdcn4ehfDJWrO6UFh7N4AjA9KB31r1NLnZwjCbHSpkfo9oz
        L+WVWeCaMtSR9nUtCtMgwH+lafSwQq0=
X-Google-Smtp-Source: AMsMyM6DJtDJPn0GY0qzDwdPhWqfhXVOLLPpbFKX7ji9TiBh0loGXmAORNtJMyy/1fK9D3LQR0FDtg==
X-Received: by 2002:a17:906:58c9:b0:7a7:dcba:a987 with SMTP id e9-20020a17090658c900b007a7dcbaa987mr23908623ejs.88.1667398644094;
        Wed, 02 Nov 2022 07:17:24 -0700 (PDT)
Received: from localhost ([88.227.60.86])
        by smtp.gmail.com with UTF8SMTPSA id f21-20020aa7d855000000b00458d383a6ddsm5826495eds.44.2022.11.02.07.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:17:23 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Add entries for Apple PWM driver
Date:   Wed,  2 Nov 2022 17:15:13 +0300
Message-Id: <20221102141513.49289-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221102141513.49289-1-fnkl.kernel@gmail.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..414812941714 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1908,6 +1908,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
@@ -1921,6 +1922,7 @@ F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
-- 
2.37.3

