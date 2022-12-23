Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C386552A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiLWQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLWQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:18:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA01C13C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:18:43 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o6so7632876lfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwrKrqGTLRy1JAzULXAgefih55u4tM0/VdC3aQtyB9E=;
        b=XV2F+VqvBRILuf+Sbv0pDg7V5bHcp8CV7VKHmAyzXwt5ahPnvZ2okP7+G4tqXs3fWK
         kY3rk4L34CqJrHFj7C2s2qyifzb2/NS2MLQOtPBxOIRIMYpAVValm6tky1H6832v+vbx
         0UbK7+W8Av0n4141SGyjg1PZn6NEWaoa76OdXWQUSNc3Koj+pPFO4+3terKHC/8lfM3j
         DVYmHuWkcf8DBMjtkHqnR/Mx1cRsF7dZxl5TZByRb9LZWYI8c4A+UHfbc9ppxdn5t6+a
         8nuUK6piZqjfiJdSpmprankLzM6iWgesw289OdQlb/P5OPHO0LUuVZmrhFAm1GOVDbB2
         S9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwrKrqGTLRy1JAzULXAgefih55u4tM0/VdC3aQtyB9E=;
        b=uogWihDBPYKpTp5RCYDcsH+tCN0ZA8nSUAyLglG1znT0iLoUAXnS4wOJp+HLkDfRpZ
         6/KYurvyEguXZ1CBVWDnGagG7hZunl+8lI4+qVWH7L7nmqBXXlSmi7jjFmNEHCEf5r8+
         +Nm6/CtnIwyrg7QYTjJn/EXHSQT9M9qgKBJgywMAl/ZZbBwGLRLo1rCWxNuBvmwynCx8
         3IAf6tRgT7yQp/3VpB+FUdhqZ8D/2AcAVEoMbfX4lX8ofESEVwAQlgYtPzn/RaaMufPr
         rVn8fsHkc4Ld9epjlSSVMsBrHzfjJJ2/zn0a/oj725beajV13NTxrBlvsQ1h5Y67NCBp
         /PIA==
X-Gm-Message-State: AFqh2koYpindaG98TJU9AmB5LMl4D2FjmnJuRT1MN1LMkoj61byULjlG
        xIbNSspZ1GZBIq2rJwHRKoeeYg==
X-Google-Smtp-Source: AMrXdXvwlFabJMcseKE0yS93G7KKhPCBbBrPLJ6TgV4pPa5MPdvkvNA3u5kYWLqvrowGCDJunk4Pyw==
X-Received: by 2002:a05:6512:2804:b0:4c0:91d0:e7ad with SMTP id cf4-20020a056512280400b004c091d0e7admr3763341lfb.26.1671812322211;
        Fri, 23 Dec 2022 08:18:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n18-20020a05651203f200b004b4f2a30e6csm581360lfq.0.2022.12.23.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:18:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ARM: dts: qcom: sdx55: add specific compatible for USB HS PHY
Date:   Fri, 23 Dec 2022 17:18:33 +0100
Message-Id: <20221223161835.112079-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
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

Add SoC-specific compatible to the USB HS PHY to match other devices and
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index f1c0dab40992..5408ff715fbf 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -214,7 +214,8 @@ blsp1_uart3: serial@831000 {
 		};
 
 		usb_hsphy: phy@ff4000 {
-			compatible = "qcom,usb-snps-hs-7nm-phy";
+			compatible = "qcom,sdx55-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
 			reg = <0x00ff4000 0x114>;
 			status = "disabled";
 			#phy-cells = <0>;
-- 
2.34.1

