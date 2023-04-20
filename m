Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412576E9B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjDTSHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDTSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:07:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB3359F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:07:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c9so8424370ejz.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682014070; x=1684606070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDUWXjSZqgL3MQ7XtAIDqVuKn7I9hLWeYQmaYgVku3E=;
        b=SdytsvcTOt6/0UypFzm5SY9QdAOGJkhoGz5IAwcvkmeM2rrZ7AB59g596ruaCL740S
         PdQj6iixMZdkEYJL4+QeWcw3ug+l/t4d+CKM/kzKLaV1wPDTKAmlPHd1a+AGHYbufisl
         zSjSgmUq2zsmYBfcGgvE2gIH+EAqwsO/aDO1Xb6DexRBa7/OWq076O9U5TgtarlN3WXL
         SAFiyQHZu71o4QWrfCB7Ir77teVTH/xXKw+QzUf+orLoYp8J3EyDnw6BvrRmGdRcsBZJ
         AGtTcLLcZ0EwCM/XgGHefH8cBUGwvr0VYtRJonlgor4rEsbRoY88Ri4OkdipTHsGmRr8
         pX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014070; x=1684606070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDUWXjSZqgL3MQ7XtAIDqVuKn7I9hLWeYQmaYgVku3E=;
        b=UEExQhmrF4FH7FbrudAgxuqNBFPmEV5S4eeYDKsI9CK8FFm89OeShIKdx/RvzfjY93
         hvctjyqRcZ1QTTC8rbeLRK1yhrKwWNYU0TE1RvGLMNwqLtf5uMq+6B9TO5OYRfnSA2PO
         xNoFFLJkvEZ1YEsKBeOGmGK8cA5sN/VoYd0tSjfR0VMv1KmNKWI8MaXbymHmtrVwcr31
         ra+tvbYe0TjlPavO8JCTBPe1Dh2TwxVFWyphcD01oN10RjHVCKmw60BTTXt5IuQ/jZGn
         D/HQDBGquegz3nHa9fs6k871WThQgKDM+Qa5PlNv+oCenXwC00uim3RSPOpGqZ+hPEZM
         ZnDw==
X-Gm-Message-State: AAQBX9ewQ23Q17w6cpQhC79Ao9Tk2nxS3T8lkNgRLBq028CXTKBLDOVN
        foFbVZ+m/HIikhZYQU1uZ7s/Dg==
X-Google-Smtp-Source: AKy350YFVSgj9uphIaXTteEWBitCwvhg4YUyTeQccxjGVK3lrMOa/OJd2CItLioeL3GGwDt2pQRb6Q==
X-Received: by 2002:a17:906:5589:b0:953:64f6:a5d5 with SMTP id y9-20020a170906558900b0095364f6a5d5mr2280553ejp.60.1682014069768;
        Thu, 20 Apr 2023 11:07:49 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090610c800b0093313f4fc3csm984778ejv.70.2023.04.20.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:07:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 1/3] arm64: dts: qcom: msm8996: correct /soc/bus ranges
Date:   Thu, 20 Apr 2023 20:07:44 +0200
Message-Id: <20230420180746.860934-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus@0 node should have reg or ranges to fix dtbs W=1 warnings:

  Warning (unit_address_vs_reg): /soc@0/bus@0: node has a unit name, but no reg or ranges property
  Warning (simple_bus_reg): /soc@0/bus@0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please kindly test on hardware.
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index e160d5e6863f..a88d0a9bb7e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1832,7 +1832,7 @@ bus@0 {
 			compatible = "simple-pm-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0x0 0x0 0xffffffff>;
 
 			pcie0: pcie@600000 {
 				compatible = "qcom,pcie-msm8996";
-- 
2.34.1

