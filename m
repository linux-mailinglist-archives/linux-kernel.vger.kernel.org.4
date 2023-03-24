Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFABD6C86C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCXUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjCXUW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:22:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B91A95E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:22:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so12442635edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679689376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ58NLKGdjyEg1idH07WspcmgphBh7cEwpUwdYjFqb4=;
        b=EUP4E8V7yULpCihAlLTSDscxdmFlB825g1RlJOV7h7mv36Da6M8XxrBe7MRr11+3pf
         ErWnowJuecbAnvGvzVN4Bfvhi5QIaNc2SwmXX5rOGZFOlwk3O0uiWodk/cw6XV3kpqhi
         vfggOeqqRy3TAKSsRjMZm8wnudgwFE0YO2WyjCbW6aJ5xiqRFOlRqoRUE/FrJQNUrui8
         hFJTj31AfrRXuuDlmi9qk+MwYOKWE/QnvcldWa8Qrik4CAeS8NYDexsmnqzPFliqnpAp
         nmIhrnuAx9JyXqkUKkQ8uRiSLPYj+P88XIiD1Q1FVplRxN3PHd/5tBfLhyPTSlgmbUW2
         3bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJ58NLKGdjyEg1idH07WspcmgphBh7cEwpUwdYjFqb4=;
        b=GzHZH0+fg1w9tjXFbyDJsKSsPIX66g7A4CjHxUIpSe450VvKqvZqWK9hnUwneM8BDJ
         xMJUS+HxvY70fHpPJVr9m37+tMFdPJoeqxfEfhTXLHP2CtbmenkknqN2mxzt81C1Ve7a
         dfHsJLlI7FX+hFZuUZ1FSJ/Srhad7f8RrOmPt8WVSyDWP1RxGOISvym+0EOKrwRNJE92
         VyAZp0PmCBgyK7rhyWqycwGnNkbZH8X13+eDbG0HrFtMA8nlHGKN0SQHn30Rrf1zzLIR
         og5rVyy/d/LWLjTZ0U/ZSMwAYCHzlzV370s+4e494KQliyatySecmaOk47KaXKibNfsd
         kjDw==
X-Gm-Message-State: AAQBX9cm3j8csaO4dWcL1v3nyUP8xvqWOOBfed/eEqWyR/jTjSL9mPJz
        epm0Dr2pSc3a7kw9J5rp8DpHAQ==
X-Google-Smtp-Source: AKy350b0yN2FLUQGE5tyvKFB7qt19vkMWgAwhwZxzC6DbRNnUGwvCyDcmm4LOFUz5UPKjdfGlTnpXw==
X-Received: by 2002:a17:906:8601:b0:7c4:fa17:7203 with SMTP id o1-20020a170906860100b007c4fa177203mr4025437ejx.63.1679689376316;
        Fri, 24 Mar 2023 13:22:56 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm10900041ejb.176.2023.03.24.13.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:22:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] arm64: dts: qcom: msm8996-xiaomi: drop simple-bus from clocks
Date:   Fri, 24 Mar 2023 21:22:43 +0100
Message-Id: <20230324202244.744271-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clocks' node is not a bus, but just a placeholder for clocks:

  msm8996-xiaomi-gemini.dtb: clocks: $nodename:0: 'clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
    From schema: dtschema/schemas/simple-bus.yaml
  msm8996-xiaomi-gemini.dtb: clocks: xo-board: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], ...
    From schema: dtschema/schemas/simple-bus.yaml

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 446b1d23dec0..1ce5df0a3405 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -12,8 +12,6 @@
 
 / {
 	clocks {
-		compatible = "simple-bus";
-
 		divclk1_cdc: divclk1 {
 			compatible = "gpio-gate-clock";
 			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-- 
2.34.1

