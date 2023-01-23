Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA99677B33
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjAWMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:39:48 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED023DAA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:39:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso9005807wmn.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMEXBUhz1I/IqxZeXa+fNMJbdk1gkDT/FjHuaLwENDc=;
        b=ikprnw+HLw3iK2peulGj9depeyHuekQquYDdT60rfdTZp2Ly+EyUs4xtxARYKi5aJo
         54Tp+amTOHUXSiefk/83+/IMBlHhYwLR+dtJX4H6JRGRDHcazP3D50f06qzZ4oLJ28bF
         3BLe2vmB8XSvIczabQRnJ+pB+WU76GFOqzV7rJUEKwvIV1IsTAK2dNUsucOpqCfNdITu
         f0xHpQBsbk06TrStpKNfj+lX9hWvPv517Ca8Cc7/j6S60rRclXVM0o3OTE3aDtCisjTp
         Nn+CFA4fTWKeqqiQ0871joPwATWMBvxhXCMBD93aDrfPQ0leNjaKh71F979xVd6qcvW4
         CXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMEXBUhz1I/IqxZeXa+fNMJbdk1gkDT/FjHuaLwENDc=;
        b=gpIIZoihLxkmHsOAgXperm4tCnOKBLx7AvLR3gfZyJaYumTWsMtZz1T33NCrhkJlnD
         +IlIWDQjL6NrXtV5WwhuzUFmeZis6ivylE93u7FFRIFqS2QcQk04M+NTOJc+ew69GKRn
         Axq9Eux5Hg8ozxNABmo1uY17gVeCbA77/RGQi5SS/o17q/dNZhpCCfMeqBOK+rvaHAl4
         5MWe13R4M7qGsbZbYJxg52XE8l47cKD4Sthk93v58YmnzW1vsgXOkl8UHTTZ/ux64TXh
         01I2om3bgnKnP7jKuPYeSp+TVCDsNJdXrfIiPh2C9pHIaviWEOfHPzKht6VqUqdlTPvY
         crUA==
X-Gm-Message-State: AFqh2kpB64yjiYwmYLRLUWFdtRPSfD/ulcANb8PfR8on1OjoSou+3MS5
        DmYmm6TRSXo2nfNB3B6NHb6r+g==
X-Google-Smtp-Source: AMrXdXs/9pcknF6x4KEg1VOGmzmJs/yxQyYQu7TT9MmzZJjl7EhvWNFRoRMwY5r7fv5gbR/1D9sJGw==
X-Received: by 2002:a05:600c:4f07:b0:3db:2295:9977 with SMTP id l7-20020a05600c4f0700b003db22959977mr15245855wmq.40.1674477583703;
        Mon, 23 Jan 2023 04:39:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b003daf681d05dsm11347568wms.26.2023.01.23.04.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:39:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8350: drop incorrect cells from serial
Date:   Mon, 23 Jan 2023 13:39:38 +0100
Message-Id: <20230123123939.139327-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123123939.139327-1-krzysztof.kozlowski@linaro.org>
References: <20230123123939.139327-1-krzysztof.kozlowski@linaro.org>
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

The serial/UART device node does not have children with unit addresses,
so adderss/size cells are not correct.

Fixes: cf03cd7e12bd ("arm64: dts: qcom: sm8350: Set up WRAP0 QUPs")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 4efe79985186..018f26f729f1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1031,8 +1031,6 @@ uart2: serial@98c000 {
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SM8350_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.34.1

