Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659A5B3379
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIIJVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIIJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:20:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B853B4EBB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:20:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f14so696994lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Vnt4ugqapD9RIcZoY+UmvwqyFEMunwd7V4v1nbiDufw=;
        b=uNnnoc4si+LmyLI5q8ea6VOZC9hfJFqCN61Qitwm/aKqEbq1x7bqP9YrP2CMGEzgox
         ar+KpKYzxc2RCnGGsnMEzCPrLgItTVeJ0jfG+W8cRylAmd/sV5O0B876GKX45gZrLUhe
         6DCyLkl32lJg5RJVObx7XfXE9iThWmvcIwComZWZKMrFsi2B4Tyq/EVZ2mHFhLU5NGTg
         ZHuTnge3TAdRNVkiNg7URwoBhwjQMDC8/7uoom6oYLg+jRPJfcTEVHcAqVuVcmZ32sLI
         ab1W9m4rXu9wFH4ipdtNW4s4o1Zl0tadUOEPZsbVa/kdmaI5JrQmoL2sEC9vpe8IWG6A
         Z76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Vnt4ugqapD9RIcZoY+UmvwqyFEMunwd7V4v1nbiDufw=;
        b=jbEmdtdJ8Zens/X8Ng6CkuhhhQfQYySLhsgN0mN/WeVJP1sRry+i6RFuYXoxeyesaA
         KE+hd5fvv2eNsJCICRAP6vsaDmNxj6MLucxMMWuXASdP0GBRNYtmbNUHtZEYP+Ov8Fng
         cfzLuZo0RxGa0+tzOyWmhQvVl5+pwamoVdCcbiecqtthH/OL2dyThQOv7yqPNym6R1RB
         Jdh52joQDzZauXHllR17H/nApGucp4F24mfZaSKEHcoEPxU9xWYLT/DD10D5bwt4WvAi
         ePGDL6mtMHsP4TXQfNgDjuXvX/4u5ZJxXrQAgdryEWvkxESN5U3Mfs4DOtTdRr3EsIwm
         6roA==
X-Gm-Message-State: ACgBeo1y+WmNePzY3nc0Ou+fj9bWo7VOVK08tmQkb9F13nvS81NTCX/+
        YwRqYKApvITBpSmo99T/b599DA==
X-Google-Smtp-Source: AA6agR6o0cxQzGc2tF2U8tSoHOcvCPwivFpx6Zn5CbOlTUngij9JMVFLum0DOs1dL0Zng36FrgwF+w==
X-Received: by 2002:a05:6512:2248:b0:48a:f36a:2e63 with SMTP id i8-20020a056512224800b0048af36a2e63mr4163674lfu.485.1662715246864;
        Fri, 09 Sep 2022 02:20:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00498fe38ea0fsm2170lfr.174.2022.09.09.02.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:20:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/15] arm64: dts: qcom: ipq6018: add missing TCSR syscon compatible
Date:   Fri,  9 Sep 2022 11:20:25 +0200
Message-Id: <20220909092035.223915-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
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

TCSR syscon node should come with dedicated compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The compatible is documented in separate patchset:
https://lore.kernel.org/linux-devicetree/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/T/#u
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index aaad7d9059f6..6b35f03c4862 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -258,7 +258,7 @@ tcsr_mutex_regs: syscon@1905000 {
 		};
 
 		tcsr: syscon@1937000 {
-			compatible = "syscon";
+			compatible = "qcom,tcsr-ipq6018", "syscon";
 			reg = <0x0 0x01937000 0x0 0x21000>;
 		};
 
-- 
2.34.1

