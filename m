Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA971F037
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjFARD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFARDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:03:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6CC192
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:03:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso5280421fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685639026; x=1688231026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYXAD9NgGprUIQkhXdsDo3LP+5BIf2ORjzEhEoh2Q0k=;
        b=YEyE4MplOuffKToNXoByaO0YIRahiBQrlXYzMq3NE7mD9SvEWvtIpQ4QjKuUjOkj1T
         U4ul77rYN2OwXiwDemsBFLPmcJRebNTIAm5Kwkux5fhC6HvvbvE+lDFgsh0rMaXTPln/
         Y4fjlsmXpHr9EpCjwT0j/eKuVIyvv6ArA2k8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639026; x=1688231026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYXAD9NgGprUIQkhXdsDo3LP+5BIf2ORjzEhEoh2Q0k=;
        b=YM5XG6QJ7vzYluvjExTjpzmCjof1eC31fjp7lyv0eglO856tbgmlskEAdT5PCGtNIc
         LDYY7RtX2+OeBF/okFuk2XkJiq5jduy5ZgCzd+y/nmSeO6tTagYgtMrjj4Dd5/nNQUKB
         a+BF5SlkAm0YCaokbIdiYNfCTmgmO7ROVDHq8VgXjSrTvAmOMXJKis4IvPW8lTb3Vr+P
         sVkHirSWzmcJnxjFY7ffCRxYPSax6PGm7aAcSYnT2Gozf9qPkif1AEs0s3K+xBhzSKSC
         cOv9adnGr/xfN507wgRhJY09BW7HLpAH/oAs3JRoVyXCIuNkCRmWtJVXu3muekpLR/Ip
         MjBQ==
X-Gm-Message-State: AC+VfDzj6j6DLYuR2JDaYQt/7GjIQn24iizSCET+SNgYfUIR8ClrxV17
        Ruqe00+0NoIeBIaS25vcf485ohio7/rWvIp3f3wT/Q==
X-Google-Smtp-Source: ACHHUZ7y/MadAmcG8+tiTZ3xPXcxTCxSt8Z6tfaDt1Gboo+wMV/9REfMseHNxiYgmiOmCfOJtQKSNA==
X-Received: by 2002:a2e:8eca:0:b0:2b0:5a04:a5b6 with SMTP id e10-20020a2e8eca000000b002b05a04a5b6mr69305ljl.8.1685639026117;
        Thu, 01 Jun 2023 10:03:46 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b0096165b2703asm10658522ejb.110.2023.06.01.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:03:45 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/6] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Thu,  1 Jun 2023 19:03:15 +0200
Message-Id: <20230601170320.2845218-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
References: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/stm32f746.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index dc868e6da40e..9c4ba0b7f239 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -507,6 +507,16 @@ pwm {
 			};
 		};
 
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.32.0

