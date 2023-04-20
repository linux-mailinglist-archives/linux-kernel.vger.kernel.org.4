Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5266E8A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDTGgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjDTGgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:36:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3B4C01
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94ed7e49541so38645966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681972575; x=1684564575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fd+WmOuvZDqpOrb3c5W9KpeObjjYn8+pBoDPkIFF8g=;
        b=r3p2Ka6ztFemVweAY7E0l9pl5aAbRBDgiC+59fmR1QaqnyOIz+5oN7dCXk/Rt2qTcI
         oBkhSF64FwIRbEDxVsaNeOJDvXDHE+vaRPTCONU8412BgiTZ2hKnDda895bln1IaM3tK
         I73C4Eaxcb+CUHyfoPNzUI95XWFShpPoSbwHBYo7rFPsVaXTC89kFvZNBj/O3qMYebwE
         zJeegvkByzobSIxKnff3PBeZ0F/fFs4N1daleyHlFWpsJe0zC+vAIlJEu+R5vYlGznvJ
         6qgcIKOVx1k8AEKDFptJcmU0MVn7/bFIapitrIyj/boGw79BLYkgO33yP21868sy5nSo
         mTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681972575; x=1684564575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fd+WmOuvZDqpOrb3c5W9KpeObjjYn8+pBoDPkIFF8g=;
        b=U2usNSgnYNMEh347NEb7hSHpZFmWu0Qd2wr/hXCTiMP+09MKO6+Q/yhSn1Ld9lvErZ
         Ndn2V6s/PAG0zqbEvh3x3zuegZhPVqxzNKEMsMp6PrseCDHLtuquPRgUHyUq6QF+J4nN
         LHeRcpsW93lb1VMOuB2jtGzRGzJYHFc4JwMrBgINfh6UPrpdphbV1m3n9hLGy94cnV+m
         9iSCQmXFmwHDJ83gXqk2bVuJzmzq/DdHDxuA0lRpbrS8NCfzBfiV49CsSExWpLHAXlSk
         UhRj5Nmm6fAKmV8T11ycZE86R7bDHV5SeMcP2EwbaktIAXzkf8uBOKN1/DU6VeLUR7BR
         Psjw==
X-Gm-Message-State: AAQBX9esBJG4jA9YRd0Vq7j3LwjG5IbR5EDMbOO3hq/bm/XguR2l4+5j
        F6oi3HTiPkuwKQvgeUZ7FHjQ4Q==
X-Google-Smtp-Source: AKy350ZWIRqLA0WOSh07l+hVGAh/6mTcl0qoyuNhKqQCAAJLGWwLMekF2sfdkP//YA+PXWsb63Ha+A==
X-Received: by 2002:a05:6402:510:b0:504:9394:188c with SMTP id m16-20020a056402051000b005049394188cmr614146edv.9.1681972575362;
        Wed, 19 Apr 2023 23:36:15 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm395342edx.77.2023.04.19.23.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 23:36:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] arm64: dts: qcom: ipq8074: add unit address to soc node
Date:   Thu, 20 Apr 2023 08:36:05 +0200
Message-Id: <20230420063610.11068-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
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

"soc" node is supposed to have unit address:

  Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 84e715aa4310..c9d679bfc10b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -105,7 +105,7 @@ scm {
 		};
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		ranges = <0 0 0 0xffffffff>;
-- 
2.34.1

