Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D801E6E5E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjDRJ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDRJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:57:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E9A7A8A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:57:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xi5so71625129ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681811856; x=1684403856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3pxl4lPryH2E2sQaHaQ+oIDeHX2pw5OTpWOzTlbljQ=;
        b=jx9qal3Xonx3dBZORhZeoNu8RxWsT/zLcnvKy0mOexdy1QmZJ/21bUIWiTD7bZCtzP
         /0XiIgYBhLZFcvKzxCwMLY+OBu49V22IV30GbDPhZIrtFfJIFBomMY8cjj2BbARtMorC
         didVaQ0CL6SikxhgLNX2EMhkuCwCr5YPdNlLZhL7CXeYlWwtUZ3lot/fRieknjgOa4ki
         0b1ZiOJQMIeBubSeXyTVMRuXpKyQgv9hiuhs0a79iDDBY3+KgQJUVVOYYmxrS1mhyJ5T
         07wizhGwwjwrEJNjnuRq+vRn6L8Q8fCHPmCrnLiA7Zw51IDeoNzkbwNypMxQXZKRZ0d7
         A2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811856; x=1684403856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3pxl4lPryH2E2sQaHaQ+oIDeHX2pw5OTpWOzTlbljQ=;
        b=TgVnAP2Zioqoisu8wgUt8FFgPPgQ0BRehU2aQAQppAwV6xTcZNZpw3C98Rh0PpTTcp
         CGt7Y9E90+KQeWu5ZfR6/Rc835mAoUHz38z8Pj1QTNLAsxlW/HdHluYKsYkCCeXLlEX9
         JmL50xYnYznm6LQ9nvZ1hSdW89jCEkz0ZMDgleyGBifuiDdy9EfEqLyx+Y6YT8dBkhyq
         wrXSNtk0b+I2bGLn4km1ww06hbTg8f3AwsIqBdTEzLablMOeDtJ5/eb+v3Jcaz7v39bH
         ol7Wbf024asaMfxtrIQOCLbCBo6brKID9svBWkmSvdJYFye0/0QeBvQVJyJa1q5/9Pt7
         /6DQ==
X-Gm-Message-State: AAQBX9cnVwTxq8GCIYQJfs+l16losPGHreUWRsCgZ7rrtRlPIh8vDvZM
        cXOgrxnrZYW3AxfG9WOjE9Ljuw==
X-Google-Smtp-Source: AKy350aNJ460Zklk00yf1a38jkPEMVgyZ4M5eIyVTm+sWG7SoroLsIiwALBTyWu9AdHEyCSjZwH0Mg==
X-Received: by 2002:a17:906:e118:b0:94a:6c0a:63e7 with SMTP id gj24-20020a170906e11800b0094a6c0a63e7mr8955475ejb.54.1681811856673;
        Tue, 18 Apr 2023 02:57:36 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id vt2-20020a170907a60200b0094f257e3e05sm4632321ejc.168.2023.04.18.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:57:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8550: use uint16 for Soundwire interval
Date:   Tue, 18 Apr 2023 11:57:34 +0200
Message-Id: <20230418095734.669858-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Soundwire bindings changed during review, after the SM8550 DTS
Soundwire nodes were merged.  Switch to uint16 for Soundwire
qcom,ports-sinterval property, to match with current bindings.

Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Fix for v6.4-rc1.

Bindings v3 (with uint16):
https://lore.kernel.org/linux-arm-msm/20230418095447.577001-1-krzysztof.kozlowski@linaro.org/T/#md34302ec02eebdbe3e4defef79a40b32a7e621b8
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..80a01ff3ee30 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2022,7 +2022,7 @@ swr3: soundwire-controller@6ab0000 {
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <9>;
 
-			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
+			qcom,ports-sinterval =		/bits/ 16 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
 			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
@@ -2068,7 +2068,7 @@ swr1: soundwire-controller@6ad0000 {
 			qcom,din-ports = <0>;
 			qcom,dout-ports = <10>;
 
-			qcom,ports-sinterval =		<0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff>;
+			qcom,ports-sinterval =		/bits/ 16 <0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff>;
 			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00 0x00 0xff 0xff 0xff 0xff>;
 			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00 0x00 0xff 0xff 0xff 0xff>;
 			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff>;
@@ -2133,7 +2133,7 @@ swr0: soundwire-controller@6b10000 {
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <9>;
 
-			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
+			qcom,ports-sinterval =		/bits/ 16 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
 			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
 			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
-- 
2.34.1

