Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA561706B18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjEQOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjEQOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:30:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BB276BC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:30:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso761502a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684333839; x=1686925839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sw4AmAQYZ1efOtuboC8tuzE6GxP3pTc6qv80qoB6U2M=;
        b=bKyhm0sFnndsJTAa3h1AVM8sIYeseNib/U3ZQYTtU2X+lPjPz4INyyqmDxdGODuRPr
         kbMaQMp/+/5E177ATV6ERiAR0uGhCRsGdwCS65MP3DvOuWQK/7gtGzqJfzkJRpjcinTB
         FOK/6ZVIP4deE6RwjAnzn8joSgBEpRqsaAuGCQ/9zOHNoqh2lAMIAa0jxnlodvadDk2T
         g9SYbtUY8ZFZyubq+qQhkEyOvL5ss2vNhCGV6PW5dMKd/VTY950o8Edw7lpsTAs9Nft1
         5iWYDaeybqGix5BPJgblKr3bEA7Pw9gEU1IC3JQLujELj6Kwr6EXbBxmSZgYmb0WAnlm
         yiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333839; x=1686925839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw4AmAQYZ1efOtuboC8tuzE6GxP3pTc6qv80qoB6U2M=;
        b=JavkDgRfWa1AaoZAf1RUFG2zmWUikvDWFbmA8tH0wRt0mLIGkaoNnBUjP9bNm1EXpj
         Md1LxXHP3WhLUQNHUtAHxv51Efo5LS8hNch/Wx9syEiPdeloix0jnCJZMqUByhh0WkyZ
         H1XkptPjcd5rrTqeVPRVevaV+Lrr3widL3pTiCD7OHchyyOwSv5Ep+gjPvgxaKFyzjlg
         jViYmRWUpDOdiei5K5TbT7GP6vH+0GNaA3NiB4g7quxwb2Zq7IBr3lZi2Twc6856ndGO
         M+8vuoucQOiBdPH/fLACACDoQq0QVfna88GePPBiVCu3gXNHE0MZtLqY1hP7gXAuOqRJ
         2SnQ==
X-Gm-Message-State: AC+VfDy3mhSr+QpOGDwwq0kXOl3KBF1EwyYo2QRBiGz3WJrB9AQzSzac
        9ygopcmUuusJt+d8dxusHTyttw==
X-Google-Smtp-Source: ACHHUZ6yw89KlxZBTvgE/5dOclub660CXUfA34kiArdQvxFvau9bhNBAgQuOCCeb8ird8GLV1AVaHw==
X-Received: by 2002:a17:907:961d:b0:966:6056:a7c1 with SMTP id gb29-20020a170907961d00b009666056a7c1mr35946908ejc.74.1684333839303;
        Wed, 17 May 2023 07:30:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906499000b0096b55be592asm3649592eju.92.2023.05.17.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:30:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        Conor Dooley <conor@kernel.org>, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        UNGLinuxDriver@microchip.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: Enable ARCH_SPARX5 and ARCH_REALTEK
Date:   Wed, 17 May 2023 16:30:11 +0200
Message-Id: <20230517143011.549319-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Microchip SparX-5 (ARCH_SPARX5) with its MMC controller and
Realtek (ARCH_REALTEK) so their DTS will get built with defconfig and
maybe platforms could be booted from it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..de1ef135c578 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -41,6 +41,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y
 CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
@@ -54,6 +55,7 @@ CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_QCOM=y
+CONFIG_ARCH_REALTEK=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
@@ -1003,6 +1005,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MMC_SDHCI_OF_SPARX5=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
-- 
2.34.1

