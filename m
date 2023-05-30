Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4709D715756
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjE3Hnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjE3HnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8318D;
        Tue, 30 May 2023 00:42:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so4802808b3a.2;
        Tue, 30 May 2023 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685432551; x=1688024551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=lijqtv7Mop5TTcWa4R/iD9tRFiOq8y4NMK1SddQs+X3+HmNRLmyuJ0wJSIqjaoKTyz
         1TwAO0lqaH5ICYThG1rKBtTNMFxdZVveu59qNqK5CjPvpbmZO0iSxNVizx8POQnLP/8s
         5qZFs00tRCWnmfXkU1HaxkGQGFzYg9vxasrcH6h7oNQu9L8pOCpQ9mkgC6/3p8yW65pO
         NgfewxMr1fK+lVZAVyx0nyf7ktpnJwDCGnqYfWiZuSlBDprUXcqXZgPbXx9t/DKtkFcq
         j3+o8tAjSVGWl7t3wp79XxRfR5xD/BvLXDT2jfYoPZE1OOd/Ltw7kTfEE2GMnKqThIUt
         OjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432551; x=1688024551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=fMsC4CX61cy+6QdAiJ4/DsiimnI5/qptacYLKMR76TT2iqDLXdLZZ2KvU3ZKAEA5Jz
         cv87p92+L0ekiWykKDPEM6CEANG1WxOEt9gak6Dq4O482yJfB1LPdVI1VFZ7IySZ99xm
         bzwFmXN54de3SYkhP4wMjPLhunagYBdLp5nAMw6Ddpulom4kufUgk3WxpQTEq3Ckff6z
         91fEhefqwZQR8fX0yBbgwAqcwDJcCI8iDI9TYlbI5nCJwWWS+hFd9VuI92OiGE/NgiiJ
         1hPRSl1jyUb3FD/c1krI+Ilvi9wqDV4pSYx0fZ6E641F2MeWxXk8OH9PaXh9cdy1XC6S
         FZiw==
X-Gm-Message-State: AC+VfDwQmxPplmPl0t0YU3S63bjvm14Cx9iXkaOl6+JK1fc7POFbjEdO
        R3CJFMVwcz8F2voWvkHwuCv1VnrlFiE=
X-Google-Smtp-Source: ACHHUZ4D/2Sc2wjOqEtSG4Iev+CqOrzade3iyE3OK96zJcF7WhMVTvvdYiLvf2EdiDD5+truUcSIUQ==
X-Received: by 2002:a05:6a20:a21a:b0:f8:b39b:b24e with SMTP id u26-20020a056a20a21a00b000f8b39bb24emr1205868pzk.11.1685432551420;
        Tue, 30 May 2023 00:42:31 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001afb96f4b90sm5930793plh.274.2023.05.30.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:42:31 -0700 (PDT)
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
Subject: [PATCH v12 01/10] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Tue, 30 May 2023 07:42:12 +0000
Message-Id: <20230530074221.1031011-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530074221.1031011-1-ychuang570808@gmail.com>
References: <20230530074221.1031011-1-ychuang570808@gmail.com>
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

