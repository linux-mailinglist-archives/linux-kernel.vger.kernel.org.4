Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5069C806
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjBTJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjBTJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:54:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6E4B440
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:54:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eq27so6941196edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GItfMy2AOnZrs+UnLKb4J8ge6Nj1GDd/gCeZeeOU7ME=;
        b=sdskdLbRPex04UMB5J6jq5+smwAV/dftTVzwYJPgey93GMogC9oz4k9t997m/ZjUYd
         ucxCxCeILkWlv+XXoGLjuA7X6I486+mwvMbtuqaZkLMiLoYQRLx/JlEibyocIRUe9MG1
         8SePQaOMXAaawQDH2/I68oWHBSIT6fdS2u7C6VaA42JME3GNeJZpvaGo+md6n6QwuHmt
         p/YuApfCi7wa5IIT3cufeY9l0R+X/OpBAwiKBaHgM2dgj62vHsDM7M2RJZIiPXXJB38V
         13FaeHFycZ7OwTr9VI1aSn5oDgIZF5Ar7/C41mSj2e2uUKJYZLLPVXHQU8DbGyxaLc8l
         Z7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GItfMy2AOnZrs+UnLKb4J8ge6Nj1GDd/gCeZeeOU7ME=;
        b=a1HZbOK6/VEgckHBt70hj8VGIdWlXUan0LZ7+brVm9HvkVkxRGAw0uUnJf+/RKC6No
         bvbi9DnCLlSHmswUs5ZQBM1Q1ZDdxfFXfX3oVMFdCKJTrDafiSWIed1QSgEipQq00yKA
         +uu6s206n02gPtbMju0xBVVRSPjEOAPxinIGTDoFaRiVJDqLhDfiW1C25y4p5yO00o4D
         b3UsLwp72mnWpd//u/IgDrXxRdqMbtYndlx9xfzVhn/2dHYTff+sNa/EaTvgjmKjPDIz
         lv+xhEOsf5UeiHPziP4sNR34hhbLhEzJxe+ht4sAcsRfFEmO4+lcHLj42YCkBdwxB8bl
         yOoA==
X-Gm-Message-State: AO0yUKVcg0ElwPfG1WtVGSHL4k0Csx6QgfKa1rZDy22woV/DURHWlVWs
        f1qsyjFlFf/wAoND3Vn1Zoo4+g==
X-Google-Smtp-Source: AK7set+30jrGrYfzo5dofHFkV1H5orXVtOWvAO73fRiaG5EbMTbZdrC/i4vPIfgfFIC+nzfuROefIw==
X-Received: by 2002:a17:906:a294:b0:8b1:7ead:7d43 with SMTP id i20-20020a170906a29400b008b17ead7d43mr10502806ejz.50.1676886846898;
        Mon, 20 Feb 2023 01:54:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709062b4b00b008b147ad0ad1sm5499236ejg.200.2023.02.20.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:54:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW
Date:   Mon, 20 Feb 2023 10:54:01 +0100
Message-Id: <20230220095401.64196-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org>
References: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WCD938x audio codec Soundwire interface part is not a DAI and does
not allow sound-dai-cells:

  sc7280-herobrine-crd.dtb: codec@0,4: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index cb0cc2ba2fa3..95d9e4a19d76 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -419,7 +419,6 @@ &swr0 {
 	wcd_rx: codec@0,4 {
 		compatible = "sdw20217010d00";
 		reg = <0 4>;
-		#sound-dai-cells = <1>;
 		qcom,rx-port-mapping = <1 2 3 4 5>;
 	};
 };
@@ -428,7 +427,6 @@ &swr1 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		#sound-dai-cells = <1>;
 		qcom,tx-port-mapping = <1 2 3 4>;
 	};
 };
-- 
2.34.1

