Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA4686AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjBAPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjBAPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:51:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A829168
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:51:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o18so8267329wrj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeryggoBqekchic0Xraso7Hl0t6zBiM3T0I6aiXt/Tk=;
        b=E5IWDhYHkXdcMg4Q0Q+meR+zAsq8pbIaDfwG/FJlv57ve66iqTy4gkfQWEFl8+mBRy
         /2/FPL9cGXr4TB6wjItl8pPWUNL+T2OFIHP9p0JaNfdnaA9CMHivDdpaeZacwpEY46OX
         HQQSdCNjuPQVESu5dS9ZgaZpS0MEYrsgmcdumbbuqcp3NoPRWNWCyo9x6W1WaTyIEjDX
         cg52oUAf7hv9XiLTszmds5YV0KTNKFYjUX1L8jcBRzkBLuq0uXkwo1BEdOf2RTmvAsMp
         PL3rmkMMgdoTCj8E9HqD1JbP3N8lcHHbrI0FDifgpjzvQ0bgh+ZIEk5yrXMscFZjqBNi
         DdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeryggoBqekchic0Xraso7Hl0t6zBiM3T0I6aiXt/Tk=;
        b=ow8CR0mUsjH8r8b6C52L63olCcyMTPHLHZzCuBQUvm9OS496jbMahKZj9sK9bEPrew
         OQXGC1bUktTdxizw4gQGlgrgdeYDkkxhS7BmM0yNbiQau2bIbgUIVG0BgD5erL7BOROe
         U8ar1+7wgta9o/W1phI3NRuk72OywK47JyIjAnztUmX3b8q1wAq5gBYyj5MoPq4mpSBZ
         UZGofTOwiYuOmhpFQxZzdGFZOiXXkNaXTwUBxEQ+JjpP5Cq8SC+8aP20+w8oje7kOOEk
         R4yzDfPhBy2s5cnAAugq2atCQdgvLCqxmC3C/pSUM4WytQ1u3hEybvaUQTLU1DZgnbI/
         M23Q==
X-Gm-Message-State: AO0yUKUFZkxVNYAZszhwqHMF8/KCnAHtoA2NTIVXh72a9Fgp1LHQFhTE
        cKQ/8pMsu3IZ2bTYzaIi16G98w==
X-Google-Smtp-Source: AK7set8MQRw5OePyalMzsXYcSVuHPCm4M+DcKmM300BJHmDGyUiI1g+Cy63XQ4YW8a4n70l/TiWOuA==
X-Received: by 2002:adf:f946:0:b0:2bf:b281:1bbb with SMTP id q6-20020adff946000000b002bfb2811bbbmr2631743wrr.36.1675266675979;
        Wed, 01 Feb 2023 07:51:15 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm14816189wrm.43.2023.02.01.07.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:51:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 04/14] arm64: dts: qcom: sc7180: correct TLMM gpio-ranges
Date:   Wed,  1 Feb 2023 16:50:55 +0100
Message-Id: <20230201155105.282708-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ebfa21e9ed8a..f1ce996bc10e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1512,7 +1512,7 @@ tlmm: pinctrl@3500000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 120>;
+			gpio-ranges = <&tlmm 0 0 119>;
 			wakeup-parent = <&pdc>;
 
 			dp_hot_plug_det: dp-hot-plug-det-state {
-- 
2.34.1

