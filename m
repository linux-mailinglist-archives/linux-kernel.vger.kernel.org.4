Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759596A5D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjB1Qt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjB1Qtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:49:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862930EA7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z2so11050589plf.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whT3aUmNdS5fuKcmFu2oegzQXBPH9cSV0MhwaeSEqaQ=;
        b=p89BVizFoCt2rywjb8ir45QqgmNYWpQsCliA7iowjoGG0Bcad9SJQlConyNwAPtkig
         ImTddcogyI2LJM8zDae5BeMaJsgp8VAUp0O7eKZmfwnhGzOSw0MhCfidV4UqIkxpwGut
         GhoNtT5GaTAiRDJ2vtPEx2eJg4Ea10yPECVhZdz1KyIrOrq8K2B5y9EhzGDZBP9UQAQR
         GfXnI5QeNqEv2RyO+lfnATsZHkIbG5tYhnV0Mpbohr4fp+ZrjgpLbcGgd9VTG6AiMYWP
         Qc4vsojgjBcsKe1qogHX5cwDtF1D/ExiXoGgsWvxuq9k0pEOnnFXLvEvRVyOphBlOejO
         9PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whT3aUmNdS5fuKcmFu2oegzQXBPH9cSV0MhwaeSEqaQ=;
        b=7Xa41krKPTbMn3vmAY4sAL5zMavwDkeHuljiCM/C3vL7D3NEg/HR7Y4BK2VtjiPQ2M
         B+2ZpxxDE3KzXZXwDStAf/dM0VgqZpSP4SCtEHhg7Jse2JJFHx6tyVIq3i+42U98/Xir
         T+lDYhVjNH9J5T38cauDF013557K67LcJwlQTVIwWtqYY+MHn5WOrlm1Yst+Xp1IAWuD
         QYi67dpRxM4w27pZ+Fe0QiVuS+K1tjKGKZN9u3xG23TnPsE7E4Lu/Mka+W++sZd9FYUT
         0OcSPR4v1ILHohBcltX5Bz/xcZNb0u0aA8ZNKlCBu1AgCjVNLrWf550Y27Hk2kS8bs1l
         d6Qg==
X-Gm-Message-State: AO0yUKUWUVV6tLj8YvNyGBEm0ZVdwSVm/RaiBIZuf1qhNhQnQ0KHKwPt
        c9+QZVNB5Eifj4cEiy+dOprn
X-Google-Smtp-Source: AK7set/ahJIG+lUGu0BS6YWnsnOmtBqfqpRp6Vdmc/erZoTHqT3mfhvyqmCT5nd+wiXj/p684Uc5xA==
X-Received: by 2002:a05:6a21:32a9:b0:cc:70df:ae20 with SMTP id yt41-20020a056a2132a900b000cc70dfae20mr13348786pzb.0.1677602933956;
        Tue, 28 Feb 2023 08:48:53 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/16] arm64: dts: qcom: sm8350: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:49 +0530
Message-Id: <20230228164752.55682-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
(0x60200000, 0x40200000) specified in the ranges property for I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: 6daee40678a0 ("arm64: dts: qcom: sm8350: add PCIe devices")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..1ca16bfc8988 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1487,8 +1487,8 @@ pcie0: pci@1c00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
@@ -1581,8 +1581,8 @@ pcie1: pci@1c08000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.25.1

