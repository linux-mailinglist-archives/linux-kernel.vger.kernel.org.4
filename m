Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4F86E39AF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDPPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDPPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:13:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF0212F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:13:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c9so18982806ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681657996; x=1684249996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vFZujeb45Cux4/hIfTESYrw4QuZxe5NaUo5lk285fQ=;
        b=M05VTyzIRfp0lJMz0GQXrZPL/t7pNC3AqptY7bUOZNVI2BzX4jqvIQ6KDMTxXEbeum
         EQgcyI5FbsNIFVpw4GzbVytMV5Rk3Ykw8R/6tpuxrRlhmzy2dEE6OgH0BQ079wWiP1O0
         4vEdJjDGpj/JShFybN3yC91lCOG5MnsQtZcmm5Ddr7uSedo7VE/geymO/mLoUcoDO5fu
         ebI+9vmYZU6IoP2AI7Ms7tSqX/dT67x7HiFtLXMJpjVECoMUXzXRT+GlWIXX0UJRFYDz
         v0jhuqjTcggUqqPZIm09p1TT+kJgmvwnFANdEaSIPoDgUdT3CMqkhNct+UAaRRsjCNXH
         MpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681657996; x=1684249996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vFZujeb45Cux4/hIfTESYrw4QuZxe5NaUo5lk285fQ=;
        b=k+Qdkxw29nMyAVVpKagoMtKdtXI7H/9VYZ4BihSIPO79USfh9n7N4oRo5WO+yiDJDF
         zypPk2w8RZ4+yBHUDtLU2edTQ6yKxx9N0hOc5Q5joTEliDOywb1ff2jxQrdzeBY/g1p7
         wxPJBKr8wkRcXBYVBa4XahG9nuEZA7CxEBJidupH67A8rm35iZvnlJybhksR1IJ3gYVJ
         /M8P1rcLB40+WEQ5BtuXotDiZnC0QlnjYr1CMZk7JXpUdzBwNQ02tNpG5m2nv0hxFOkv
         E5CbbjpWeFe7vn8Vr97TVoGM9qS26STYOCW0/w5Nz/d7W0rcfCTmJdxs+BYJvMFZl/uG
         6gXQ==
X-Gm-Message-State: AAQBX9f2TLlAMrVsTMOL4+ejiI51bqgqlEnkEqfmokgx4YWLCkdhcH2F
        TOkG9Zdm+axS1cVGYY/laD1+JA==
X-Google-Smtp-Source: AKy350ZfXavYzi/CNS2jjBhwrfaOEy3c2JgNTbbkon4urYT3EAhwugLQFxyZEk10c2ig7QGEGNOzfA==
X-Received: by 2002:a17:906:6d15:b0:94a:a41b:558 with SMTP id m21-20020a1709066d1500b0094aa41b0558mr5049351ejr.54.1681657995872;
        Sun, 16 Apr 2023 08:13:15 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b0094efcc4a076sm3009201eju.164.2023.04.16.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:13:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8150: drop snps,dw-pcie fallback compatible
Date:   Sun, 16 Apr 2023 17:13:10 +0200
Message-Id: <20230416151311.346596-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
References: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PCI express root complex does not use snps,dw-pcie fallback:

  ['qcom,pcie-sm8150', 'snps,dw-pcie'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 024b3c79ea11..1d22eca9cbde 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1823,7 +1823,7 @@ dma@10a2000 {
 		};
 
 		pcie0: pci@1c00000 {
-			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8150";
 			reg = <0 0x01c00000 0 0x3000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
@@ -1918,7 +1918,7 @@ pcie0_lane: phy@1c06200 {
 		};
 
 		pcie1: pci@1c08000 {
-			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8150";
 			reg = <0 0x01c08000 0 0x3000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
-- 
2.34.1

