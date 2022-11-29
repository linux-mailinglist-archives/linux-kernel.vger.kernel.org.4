Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A751E63C9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiK2Ur3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiK2UrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:17 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE46A76C;
        Tue, 29 Nov 2022 12:47:12 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z4so18663709ljq.6;
        Tue, 29 Nov 2022 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GXxM1nqK364oUTYPhJF7Ku7/EgOLFJ2UJoNxZjUleQ=;
        b=niQYxWYTJPw9C7zm4O9ipcOd/SO5f+jJbzwDo4IlXrpfGdkMqMzXcJv/5c7fZ014TS
         mIK7V+nArFCNTJ7d9vvk8N2bHa2IYACM/yaw+N9mUxefiFdXJRbjV9/1inrQ7zlfawn1
         Crj39XGSbxhdtU3B0RzKtha6L0FAgPGr/1UZ8w5A0NUsrWpck4JmxaS7iTvEzbYDvVVg
         wz9je561VEqOyUoS0yoWChsBrSezrM/0BB8p8a1h0qM9wnA7Baz1UAdbF6qJYHtxvf3e
         PE1y5SEKsiI3kIhUdLNeCNR1epDUL8DEb0/m/8b4v3v7Z+b/aLkemx9vkCrwsHiZ5X+P
         ejQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GXxM1nqK364oUTYPhJF7Ku7/EgOLFJ2UJoNxZjUleQ=;
        b=kWeliUY9PMvOm5T5p9gp6iWfhBOlugv01/bK8KIFOfGkS8L2Zwm8a6VOcIvkfB7XJx
         sau70v/aJuUlC/iOUXl1BJRE725LwrKjXBYveDW/s2ahA0DWxe+iE76VwmXri/Vf8sEV
         s35hpZyMkSAkkJShAz4iN6AkrJi/kNtkOU8e1woXaL2N3yiSEUbxU5fnfv4fovosz0FN
         mkUbkaCK1rJhZ/kT7fN7fclcj/ScMhWuqaUqoNfG7hItqY8DGPATTD5OPee2OCgITPVL
         bmNQ9ziJvwRZsNOURR954GzzkmzuFzTgDl8A72f4VGnPuIeFk/WyJtGRIUm7soIQa60r
         z/XA==
X-Gm-Message-State: ANoB5pnXn7iD7VlFyaCeJdOudI7ad6GOrSaoO8iLP8O+kHIchypkFPV6
        cL9fp7vxu/EqCdyoFrmGmV9/gJ3hzlk=
X-Google-Smtp-Source: AA0mqf5Lj019HBIAtQJ5dyPFCPwQBaZl7B5P5RwE/byxr1ksM2umIp2b4SZY6y+eahc6/XvLOb3rHQ==
X-Received: by 2002:a2e:a4b4:0:b0:26c:5cf3:cc89 with SMTP id g20-20020a2ea4b4000000b0026c5cf3cc89mr19293471ljm.483.1669754832127;
        Tue, 29 Nov 2022 12:47:12 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:11 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 09/12] arm64: dts: qcom: sm6115: Add GPI DMA
Date:   Tue, 29 Nov 2022 21:46:13 +0100
Message-Id: <20221129204616.47006-10-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPI DMA node which will be wired to i2c/spi/uart.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b459f1746a7f..e9de7aa1efdd 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -673,6 +673,26 @@ ufs_mem_phy_lanes: phy@4807400 {
 			};
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,sm6115-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x04a00000 0x60000>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =  <10>;
+			dma-channel-mask = <0xf>;
+			iommus = <&apps_smmu 0xf6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.25.1

