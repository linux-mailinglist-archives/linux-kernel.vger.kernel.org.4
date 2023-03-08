Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2416B0797
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCHM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCHM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5880E33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy23so65222333edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQcknXFcRCyyIMimEyV0fIdNecRF6Egmqx4z+RuFoug=;
        b=EhnTm0CSX3uC2byqj0VjUVzrcPbI+QRMZptVi/TfviQfnxGKWZV16S3RY/dTiqnNpl
         TZrAIWssJKi0+DM3CsWF72vKUCG60GbfYqhnWQaq4ZejigtZiD400VXD6ckQnepZvfrW
         DHLR+XsoFm9KFeSrVgVpBX+ZD1FE4UgV2y93+E9HMyTmUIO2rZDwEO5NXOV/Iij+DoVf
         Htxdda0medsyEhHsVLJYqK472Rw4U/DqOOuHqwmZ1AsIvATf1pSno9lawQB8QRcwyKpM
         q6nxlo+1a9O4xO4lxP3pBrnYulCMWO7fwLLYqC/DI0pJybmm7wbF/w3ClxQz1u5o0e4W
         UeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQcknXFcRCyyIMimEyV0fIdNecRF6Egmqx4z+RuFoug=;
        b=LgPARLelP0+91Qwcxf+TuGIFTRPkxl9HZFMqUl2qgJd5WedQc82bBIsoehnjPjEPJt
         urDzI1O4I4o4wubvEVIPS2e21FSS6x21jKKIszeRxKtLJLu5ZpK0m+hu0k5/w8yZPv77
         9SQbH1KlnbG2ZgBRGgv9bA52rBvvndpoXbflbJb//Wcryr0dR15GeIlmEX5WSean8GeC
         oI7zyM4Aes1CT5EQ3XPbpgrFOm9tOIVvZOn5xkx1zQ7HvWPwAy1Ue0G/x7lYyzJZDhGn
         9HHNNO8bYKS1nD6hxYdCHiDM42dcHO+pDO36HDXLVRsPUHeBVFD7XTCB7dz8BYqaa32n
         CoOg==
X-Gm-Message-State: AO0yUKVeWfiPQIRKL+yobCKhbkiZJ+oFsc787/EU6Ekzq16WiglJrrV0
        hg1vS/YD4TNstPepqDe7TRddYA==
X-Google-Smtp-Source: AK7set9nQxf0acN+blB1QAyc8FF1oMW7l8NydeeXs1Sn8jgxGq2P+MJ52ol1twE9Rr0epQp7WkVhvg==
X-Received: by 2002:aa7:ccd3:0:b0:4af:51dc:addb with SMTP id y19-20020aa7ccd3000000b004af51dcaddbmr16251265edt.19.1678280351704;
        Wed, 08 Mar 2023 04:59:11 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/11] arm64: dts: qcom: qdu1000: drop incorrect serial properties
Date:   Wed,  8 Mar 2023 13:58:58 +0100
Message-Id: <20230308125906.236885-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial node does not use/allow address/size cells:

  qdu1000-idp.dtb: geniqup@9c0000: serial@99c000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)

Fixes: 6bd20c54b589 ("arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. None
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index f234159d2060..c72a51c32a30 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -412,8 +412,6 @@ uart0: serial@980000 {
 				pinctrl-0 = <&qup_uart0_default>;
 				pinctrl-names = "default";
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -581,8 +579,6 @@ uart7: serial@99c000 {
 				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
 				pinctrl-names = "default";
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 		};
-- 
2.34.1

