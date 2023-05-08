Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8536F9DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjEHC7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEHC7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:59:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0477DBD;
        Sun,  7 May 2023 19:59:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso1917884a12.1;
        Sun, 07 May 2023 19:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683514787; x=1686106787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=FYXelx98Tn2Wa/NiaItgBsV9VtwYw7Ow4IHWFRm1YB09v7lpNxocYd1HsCodos+TJv
         tuyugw6miHNbGLnuyIu3/wzBnlFJlG5F5i6YYDJbZbNmHL4nVVBeyxyM20vZIF/UXSU9
         TN6LTqE+Z8Sy+LGTWHdm6a2ehlk0Dmd+LMsr+Dld+PmU72WRyattjGm6ytv8eRI2ve4e
         wMpV3jgazwHQra5qpow4arowT2RLaiKoT2CUZzK71K0K+Prpc5x6lq8gIki3aJ6qV1O8
         DV2CJALOsWByJcqUdIhMCA6/jAHN9Qvl4QZsrhNmYWyqR1o6k/KTsvP/yUyKcs2lUihN
         IMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683514787; x=1686106787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=P4CDs9Sbchw0FyKFkGiU1LRTReHYBG1kowy+Q5qlL7qGhYYLYmgbaY8U2WCmYR2SkK
         0RsODLpOdrV9YcSy/sfdkHC6joZKfVCBpj0BQNG53qlDzWq2/z04FuiPlEoynR18LDmq
         xwUr4Ks8Zqh+LX1dpOA7W/8CTQcTyDxjYDGqP1DDLiEXc7YaDsovaW8qzgswq34i6wDK
         MjssLK5utk5f4x7F1dYiwlTjB54/dlWCRQMRweekthFrWcXWCb0yfciXKXXQsYBz4e+J
         8Q7E/90CIWt4nckqv1SJw3Q8/NrbZPIOKaPsNyVrwig3mwCgme/kWBxO2Bsd0vZC3ERY
         pz2g==
X-Gm-Message-State: AC+VfDzZ2gWnd4NZpikWqcZFuvMWogDgQZOhzoHP0LM+Z+86+JixGi7C
        qdED+47KGQxg5afZNL3QWTs=
X-Google-Smtp-Source: ACHHUZ7aApCa7SGS5PHMVgKdWAse1UdfD0/L3PAeh2alfUjsR+QT2JMBFSCeaQHuxt8666gyl7c4Ig==
X-Received: by 2002:a05:6a20:6a15:b0:f3:57b2:79e2 with SMTP id p21-20020a056a206a1500b000f357b279e2mr12022082pzk.12.1683514786926;
        Sun, 07 May 2023 19:59:46 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b0064559b58eb8sm1525422pfn.154.2023.05.07.19.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:59:46 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 01/10] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Mon,  8 May 2023 02:59:27 +0000
Message-Id: <20230508025936.36776-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508025936.36776-1-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
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

