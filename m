Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA716B9E75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCNSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCNSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262AD1E9C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so5414587wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfzfaPBvy2iHf+DRsTEsWZvUw3uhdBHb/tIk1eFva8k=;
        b=jptdwn8EK8j4Em9IgxQcq5UKEO+QZKMjbMGUjGIPOE+hDRjnZbsil+5OpcKsvaWmIY
         wpSKZEVQ0bapKf9W8tBB267EZfyhgIBFxRSsHfGT4p/3kUgEz+TnjJZMTapxtds18Yyr
         mzy3AANoRArTrKWenvHq+Kwfz11S1GIA/FxfeCg16sMaIkkZCKNWh/5YHRNeu+B2DG9u
         CWA7xe13+ske3CO1Frg8aH3S072PnLVkA8LZujcJz4A/pmV32YiPBwKTWtjEx/Si4e2S
         tVicpz4x3ray/TA+wNCxf7XKS2s+X3KhsB88Nwe3hUzDjklvyNGrGTLGgrvtF3FnmB1e
         aEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfzfaPBvy2iHf+DRsTEsWZvUw3uhdBHb/tIk1eFva8k=;
        b=64EcNwrBu8z6LQnL4aBGJrCDUT7bycNJRdbzfAps7dvGdnThdFB2YZx82OcNtIVH+g
         7OsVA9nauhBH3DnHQGfR7+Z/IFenAzT/gVVpgliIv4ZiSzu6imXZ8x+XiQx9b1z2EiYP
         +8zmzLJXDPrFuwMnD56aW0rTc7ExRFnCm+tZ47djVDLnWfSXfatWsDwFTHS0WCZk/2WE
         DrgIJvhrfRHNfCP/HW0mT/Q3j5eYp5UHSf9yfNIuMzmg9mB2xBD3jL52Sut9jpZoASTu
         SKPWN0w85NODiE5Zzs4CAqdrwnRUlUUzD5t0N5/G2hFyGRctffSdDYe7eKm8zElQqJo7
         CQIA==
X-Gm-Message-State: AO0yUKVBGC3XWpe4KQALRfbFqi36B7OBm9KHqw8+EDNXOF06XA6ERh7V
        hX8lpFOONuEYk+MrmGaM76NG7w==
X-Google-Smtp-Source: AK7set/QsBggAASR81HPstv17jWT2SyT/ybiaRFJELtNo/iTKE38tzB+i5v4IdjR0FgMog2gsvyrng==
X-Received: by 2002:a05:600c:4448:b0:3dc:1687:9ba2 with SMTP id v8-20020a05600c444800b003dc16879ba2mr15041784wmn.35.1678818656755;
        Tue, 14 Mar 2023 11:30:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:30:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/14] arm64: dts: qcom: sa8775p: add the spmi node
Date:   Tue, 14 Mar 2023 19:30:32 +0100
Message-Id: <20230314183043.619997-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the SPMI PMIC Arbiter node for SA8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 428d9e0849b8..22c98ebc4c46 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -943,6 +943,24 @@ apps_smmu: iommu@15000000 {
 		};
 	};
 
+	spmi_bus: spmi@c440000 {
+		compatible = "qcom,spmi-pmic-arb";
+		reg = <0x0 0x0c440000 0x0 0x1100>,
+		      <0x0 0x0c600000 0x0 0x2000000>,
+		      <0x0 0x0e600000 0x0 0x100000>,
+		      <0x0 0x0e700000 0x0 0xa0000>,
+		      <0x0 0x0c40a000 0x0 0x26000>;
+		reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+		qcom,channel = <0>;
+		qcom,ee = <0>;
+		interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "periph_irq";
+		interrupt-controller;
+		#interrupt-cells = <4>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+	};
+
 	arch_timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.37.2

