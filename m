Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E56F637B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjEDDhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEDDho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:37:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48242198E;
        Wed,  3 May 2023 20:37:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so1165822a12.3;
        Wed, 03 May 2023 20:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683171460; x=1685763460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Eq0LicHuP3/B1RKivMtl8cdYZaHatrXQFpgIibRuJI=;
        b=gAnKSIVzh6rJQJ9r6PaFYl9RIlq0kQw0DhSf6xEZQWX5xg9Z+sytJQzAmQi8nLp9W+
         uMQyv2Y+XzRN5VuHTySg+t0hajFKMoRfXCyqm2XVAVbOECK4BqnmbxaZXL1ulwW0FscX
         JTdeqxSXFl4L3UG6g4LIiLBW7BggL3h7MCbIownItdNEwhjp/1hLp1kDFVwgwhqO3P7g
         TOwTQOsEXjKRyyNFrJ51J4oBspdx8QGbADEgMdGb3PpY90tv0TLWsy713lYXWGGqCPVt
         hI2qt3iAseiB16+jkN0T6H1Sd7wnbtuFQAR2gm+3bghsbs5V5qT1crswsHLuPFYvaqJy
         QDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683171460; x=1685763460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Eq0LicHuP3/B1RKivMtl8cdYZaHatrXQFpgIibRuJI=;
        b=bWqlTfOZ0Qh5WKqKXaHDkjAWkMqOuz0oTgJwcx7OKzlzBAViq4vRAOx0jU1ZGyualo
         7xaUcM3x7w5a7S53DtK8mnxWPb6Q0XM4Mz2ThKVOYic6UUHyIiCqPrjJx91LAjcTQN8F
         TiOjcAY5ckCKc/XLVLhTsKbo52J2kwrWNLfzVk6+7MEg4Vh/4Ep8dXqLFX9W+nqgGFgg
         KURmyI+ng0nIpUzNSHlfCxYPlTc0g7FRLDXGJk6/ZFkwVb2dzbbyejT27R5ntEoJOooM
         7CveSr+a5Jh8wl76KwPiUQldTMgRTr2iYchDm4wNR9b7YE+eqp5izIDn8I+MAEo3Q8up
         rL2w==
X-Gm-Message-State: AC+VfDw8SGwljmjGL51qEGCS3hfqP6haKFkc6Jt3t7UnvxgJRcMmX19z
        kYVWnHKbDD+teuJyG54kwuU=
X-Google-Smtp-Source: ACHHUZ7fWs65S8db9yor84Room0N8hy4k5s1BlaBJDSPm//71SgD8w3JP47D7q1ebpKjovgr4eTFNQ==
X-Received: by 2002:a17:902:ee8b:b0:1a9:736a:5251 with SMTP id a11-20020a170902ee8b00b001a9736a5251mr2009927pld.16.1683171459554;
        Wed, 03 May 2023 20:37:39 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001ab849b46d3sm468761plb.178.2023.05.03.20.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:37:39 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v9 02/10] arm64: defconfig: Add support for Nuvoton MA35 family SoCs
Date:   Thu,  4 May 2023 03:37:18 +0000
Message-Id: <20230504033726.93-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504033726.93-1-ychuang570808@gmail.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
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
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..19e1b384f940 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
 CONFIG_ARCH_NPCM=y
+CONFIG_ARCH_NUVOTON=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
2.34.1

