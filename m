Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC2A721CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjFEEIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjFEEIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:08:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261EA6;
        Sun,  4 Jun 2023 21:07:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b0201d9a9eso31406595ad.0;
        Sun, 04 Jun 2023 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685938079; x=1688530079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=aInT1qLmEdOG4TwibQm4UbGiLMf4l9bHtKcRAKPg0qT8V5JgFunc9jK99j7BNATnba
         uXNwjpLpkSD5yJn5O2cb4n+CS/dLZTvZNjc6GQn1A9m5qh7W80QLy4WIc2VR2gEqXwnJ
         szSaY+utqORloiowWWrbWlJW8LmwWBW+afmgjrvfqYyheuRdcZJDbGFmRknXKc8oROTJ
         kWPAs0w4o3RF1ZPOUwnlNetGJPvBOtoMIvefmShG5gqEK1BwY/AeDxOv9Fn1oB7mmCPD
         8nQRBVN4dauadBn2TsnwOBeIE/tFUNUdDks5+ZM+ZgVF7fp22Gr+hyz2APT2OWMT7+7T
         fPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685938079; x=1688530079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=SQJI0o4WuexTaL+Ay5pTykldob0V9UiKSW9e6afsdW5Ugqm3anghJmmIeObBVvRwGW
         i0IPULF6NKDAMRq0cNGmmoPBFx8m2tAEX6YkBT8ipTAW/Q8PnSL/ZhiEkBh4fmRrvKTi
         XqINYa2nEv2GM2eIIdXNdDyPRGsPUo7p1tPIkvypD9Z96WL+Ia/mbn8Ev6AMMTOk+y6t
         k9vDI0Gt6tcz1kiLudT9PH+qcOBo1xx/42JM0jPKO47saRBfRr+6ZL8iuNRv4hSgV/Yb
         51M3o7JHUZfQC6RxYODr2zuYOGBDmGn2qMLuT0di5Lqtp6mgp23PogTHFFYdfSkTjcK2
         +Q3Q==
X-Gm-Message-State: AC+VfDxxRz0eX6bjLZO3PHKEsjLY6klxVi7FezST/6TsxmV6k6kkD/uN
        hwZvteaZciIZfS6eFwmTpPnKLydBW2Y=
X-Google-Smtp-Source: ACHHUZ6cBynh9TtGAFDwB0YjQpBqXh8X1ayfefOTFbSMVBHyprMCWphWSqRQIemqAlgMwJQJRae9mQ==
X-Received: by 2002:a17:902:e547:b0:1b1:d52f:321d with SMTP id n7-20020a170902e54700b001b1d52f321dmr8140763plf.17.1685938078969;
        Sun, 04 Jun 2023 21:07:58 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001b21bcea439sm206164plh.170.2023.06.04.21.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:07:58 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v13 01/10] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Mon,  5 Jun 2023 04:07:40 +0000
Message-Id: <20230605040749.67964-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605040749.67964-1-ychuang570808@gmail.com>
References: <20230605040749.67964-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..e28dbc477a99 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -225,6 +225,14 @@ config ARCH_S32
 
 endif
 
+config ARCH_MA35
+	bool "Nuvoton MA35 Architecture"
+	select GPIOLIB
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  This enables support for the ARMv8 based Nuvoton MA35 series SoCs.
+
 config ARCH_NPCM
 	bool "Nuvoton NPCM Architecture"
 	select PINCTRL
-- 
2.34.1

