Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B576E39AE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjDPPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDPPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:13:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F31FEF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:13:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dm2so57943077ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681657994; x=1684249994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUFiSKqC1P8c4Lc5W5aXm/s3cJ8DsuHM5FMs81rED4M=;
        b=TdKPP4fRzRJiLMiNKyiIOWdMzMQfMmmWdJjU02u7SqFXP0a/hbHBwiBps6C1UBQgbs
         3/eBG/b5DYJTmrIged8H+R5W1yayFIc21EybfoNuzqMJYx8/19G7xWLOBR1lIHjodLzU
         4HpkaAYHM8yRBYVNrw1OVkW7IpE+CjQad2gCLh2ysnlI/4zqmQappE/H0syhG7SSD9Ul
         Hu9aTMd/v27FAnGqGw/0FbBFFQJGQ6d256uxXoQrjcd+frQzqc33GBaTyV2KsCwkNaH4
         85ble6n6D4gNvECoUUaSWdCAtXHA2ZD+lBycrTySesZiViaGwBMwoZKXTHPRzowz1nZX
         Cb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681657994; x=1684249994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUFiSKqC1P8c4Lc5W5aXm/s3cJ8DsuHM5FMs81rED4M=;
        b=TZxj6eaUZgXu9bcKiSh7vblPjWmzs7UOOv5BKxjXFRSTRVPd33PGk9QysKY1YrauNy
         /Ih7WWy/+hHCcvHiTNbi8WOm/E99su6EjNjBCjiC+IM0BerWlLtPWnT0YjXfk5ITRGxH
         2fCdcbuZC1tEXnsNh0oGg1iJ3QmH+Wn/bMMlr1QilXoAJMZcIXLGSBgZ9+YlYlSeOp0B
         bkhK6gySOxbeViXYxaT/Hyi+SpW8h1CIbdqr2GV3OBZw/+5RzMmX4R14BCBGRDaqLpgk
         pE0jMsAMEk8GO0Q7k2rIwG7BQAZG59D8IxS2OPd9wRac0xKK9deSnIG+iUycvHlK35fM
         hB7A==
X-Gm-Message-State: AAQBX9cc1/Z9dgxCoy40Kqp9OoVF9KMMZ1CA6bbjo4IrqPMOsHC0X+ZM
        EZXAhqtlpG44bCJQp2UM9Hp8lw==
X-Google-Smtp-Source: AKy350ZZTx3ZQvryIRPNYhU6lr76HDvB6FavhiJlWV5Sxgxt13MtXzwcyXyT6F64GNR9WUjA//gmHw==
X-Received: by 2002:a17:907:a50b:b0:94f:536a:791 with SMTP id vr11-20020a170907a50b00b0094f536a0791mr1508479ejc.9.1681657994125;
        Sun, 16 Apr 2023 08:13:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b0094efcc4a076sm3009201eju.164.2023.04.16.08.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:13:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sm8150: drop incorrect serial properties
Date:   Sun, 16 Apr 2023 17:13:08 +0200
Message-Id: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
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

Drop incorrect and unused serial properties - address/size-cells and
reg-names:

  sa8155p-adp.dtb: geniqup@ac0000: serial@a84000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'reg-names' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

