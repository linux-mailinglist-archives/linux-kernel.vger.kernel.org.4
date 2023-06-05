Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD55721CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjFEEIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjFEEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:08:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56380CD;
        Sun,  4 Jun 2023 21:08:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-650352b89f6so2063798b3a.0;
        Sun, 04 Jun 2023 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685938083; x=1688530083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=IZy1HL2XKLngjDI2mxhpx5ridDWNCnu232bl8Iu9EHvRrAXCzwC6RotioeGoMNDThZ
         Rq71z3zRNUJ7rpMICnJ1z6rpwKwW/m+Akd09c3EfyfhwinVTwgg3SR7Y3rLNQiqng7t/
         oUTZ0f1UUjUplkL4gnVYRb0/swN8L7OShCszWb2nJK6LXTYcQcmlfLvcnGUYGp9SuZD9
         cOilEwupHixBdR3+tcYzOJztv9IjGQmIQKwf/esE7OlREey+RGQultPxwKecubUmqQQk
         88uSVQsRyIqJ/ZSpfr/M6RH0YvUiJVQ8BiGOkf6yE/x1xObPEcttYIv1fRM/QpbjEgCU
         CfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685938083; x=1688530083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzBlnANu1AM5Fjx46MEeCrq3qasOfTTbM5uM0GEAlY0=;
        b=lv6a/sozh6Iykve3dCrcz3rXq/9UgINk2xYHb0iKmloqLDODv/BcyyfQ/gdJ5S0E+F
         At3vMP9JiHmuD4E5feMeATJ7fUyX6TeRXCt6LX1DaXzRDIFlpsJU12m/ibpMcxQCYx9c
         zRXey+W2rD3nTfp++a5Cdo2iNcW25pPPawJ9mPsBXjGq6bZ5fEQkM0Jp+Tijj31fADp+
         QOvkrOubh2CZGSPswwnnYiYhhdY23QcyxUzyjtHMQi1IBwH3Z/8r75fnzJ6irrQzZ33G
         sSX+a9LdtFdjOCNocwrIMRLsx4paUKgknkpgS4NFyZltguBtOROefl2Jhdd4bTOCkfOC
         66wg==
X-Gm-Message-State: AC+VfDyvUk8EDPptyYRjmiB0N/OhK4JTBt3qQ73tYXI5lf+b6jx+id0/
        tHdj/YDRa43VkmyY+PTL0d0=
X-Google-Smtp-Source: ACHHUZ6lnNT3qIiWuTmhO0qL7zE/FmPm5o7P/1UwRjxNu2RZvKyWjy7zfJECsOyrNmXOuMi4FrM51Q==
X-Received: by 2002:a05:6a21:33a0:b0:111:92ef:314e with SMTP id yy32-20020a056a2133a000b0011192ef314emr1400147pzb.35.1685938082661;
        Sun, 04 Jun 2023 21:08:02 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001b21bcea439sm206164plh.170.2023.06.04.21.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:08:02 -0700 (PDT)
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
Subject: [PATCH v13 02/10] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Mon,  5 Jun 2023 04:07:41 +0000
Message-Id: <20230605040749.67964-3-ychuang570808@gmail.com>
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

This adds support for the Nuvoton MA35 family SoCs which
are based on the Cortex-A35 Armv8-A 64-bit architecture.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..0ee572753f1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -52,6 +52,7 @@ CONFIG_ARCH_NXP=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
+CONFIG_ARCH_MA35=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
-- 
2.34.1

