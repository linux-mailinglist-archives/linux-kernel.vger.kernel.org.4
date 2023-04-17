Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD786E4225
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjDQIIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDQIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:08:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562046AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:08:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xd13so27920644ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718909; x=1684310909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQJ7WRIROJNRsBKAyL6TG+aWODJFqJnhKcD+H/twEi8=;
        b=bSJcdRynVCuoM2KupKqejM2B0WGsVcO+G+R1IZPtHYiKv5q+Tg/90CGkMQZLSk71Eb
         zRhUVdPVREPE/cxpLa7L44K7M6yPqvRvcN1Wk4EyCTg4kRm+2BnTRfho5Ia3Cz8VMMQT
         MfO/lzrxMdFETdzqdsQHYhOJ7cXBhWe+86UWcjpRyXYaibcrK3ke/TppDXQO6Z6qiy4q
         zaiPcj2MvF86Y/79ieKtWu65cTdeDZ6ifJswxoNGM0RtuFxkUDrLxACRgAjAfYWWtg7R
         ozQZwWI5lSzBD2qcv2wYTHhzsVRX7N0DVR7+ugJg0d8CTXV28Xx/Y+ijMKnVP/xjNOuT
         46YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718909; x=1684310909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQJ7WRIROJNRsBKAyL6TG+aWODJFqJnhKcD+H/twEi8=;
        b=OyfZklPMnn1yGfTXggRHgg477cn2RlsAF6Y8dqeF2QR3Fna6ZujnoVdmwMldxsNK+T
         IDb/DksATqQ/JH7/T+7Tgo2uU9h+EGN4mEgJnBf4rcJ7UB8/Ay9khyts3ZH2mE3duLtn
         0n5az4IwNjdf1eu29TwJiEAOoOEj4C+PlQ20UW4f/f8w7LkYQOGmtLJVJZANMeeh/Hr3
         IFDRGLKs+48RFWiljKk++GCfiaVhgsvFl8u+kQAgy2VmKnGLtRYsFGujjCa+qOqRpq2a
         if490/meoLcTUkmIhS22rbUP6LLBddXpi4k7yLFVniGYmM7O4vmrrx70OGc7r6Hlzqig
         YlAw==
X-Gm-Message-State: AAQBX9cfaNgRJNDOYzNwqDPo77cxEbBWogG1qMHy14VYwKpOM/3M2l1i
        ISObz+lyBFXj/EA6yn6cbvlu4ssFGXK5NBpZd5A=
X-Google-Smtp-Source: AKy350aAVVKQWnFf41usawThl6KubR7Da4LuMEHW3fDT7WFbzF6LSQRy3LfjSzPLj0Zj0ouY8cDqpA==
X-Received: by 2002:a17:906:abd2:b0:930:f953:962c with SMTP id kq18-20020a170906abd200b00930f953962cmr6268495ejb.1.1681718909007;
        Mon, 17 Apr 2023 01:08:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id v25-20020a170906381900b0094f3f222d34sm2338984ejc.56.2023.04.17.01.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:08:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm8150: drop incorrect serial properties
Date:   Mon, 17 Apr 2023 10:08:15 +0200
Message-Id: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop incorrect and unused serial properties - address/size-cells and
reg-names:

  sa8155p-adp.dtb: geniqup@ac0000: serial@a84000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'reg-names' were unexpected)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 27dcda0d4288..3846f5e0f656 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1362,14 +1362,11 @@ spi9: spi@a84000 {
 			uart9: serial@a84000 {
 				compatible = "qcom,geni-uart";
 				reg = <0x0 0x00a84000 0x0 0x4000>;
-				reg-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart9_default>;
 				pinctrl-names = "default";
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.34.1

