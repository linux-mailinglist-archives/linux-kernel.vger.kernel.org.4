Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74B6C7905
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCXHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCXHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:38:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92539B452
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:38:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so4440682edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679643497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBj1rBlifTeYBWfBaFqrskZBvLx8jr8lX+ag75/Q/1c=;
        b=OjLJFTqqp8mdL099pdHn4eZnJMjNBsU50KnvGWmYalcuxXrHli0kHGjMdm7YV21Gqh
         k7sJAE++HehtM/KboC3IeqBliJ6Zq67ZQyt9gCXXSVLchsrN+gFtTYh68IcgMS3RRNjq
         wZEt5SulLcPX6Jkze6N6SYHuQPyyYODWzSsCVVEA/PY3ADOP0Ew/C0Awskzr9ehBvJmm
         UwqOoXTwH2KNN0nJm7AyIpRm0lAEvdLHchvVYf4I/k92wOpYiA87vJh3HEzMMArom9F/
         ySFQTSU1RQvI8ZAVDFg/kvmb8f1/aZb5PfVvDdxcPiYPsxxMufOUjW3VBfWGhz2JSSK7
         P7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBj1rBlifTeYBWfBaFqrskZBvLx8jr8lX+ag75/Q/1c=;
        b=Rv/A50eqa9niVv6rmp/FH3+gNRi8DGhmrLe7F3AT2yYR6iylK8rZMQahdqMrDsLCtO
         TeEGLndxKc6JwwX3MSAV8Z26yPj7dYnljDf2C1eoEhuYft3An/FFaCEOJojDeELF4vde
         Ukpl+5Z9jnWQTQCOwUPRwKfKK1+W4aE2TgT9IkUnCmtzGfCbHscWwCkwRj9lY4I6abe6
         ibUxmVSmeXzFkGXeXa67ee0O7G4eMxjmg1K/utwvfk9J1gA24/ZK2Awg/yQetH3WgB5I
         MPz+HY4eU7jV3efTE/6hZMGcKO+wWvs6m7Xt6GC09E0NdxCqCjAhdrDjoR1A5CmkUUvt
         cZ/A==
X-Gm-Message-State: AAQBX9fpHz4CaY/R3rWNmTiUQoX+gQaxRP36a8AnmL45ev2tNgFjN5aB
        3JBShOdp2zXEyofGE6xlXErbpt1OKJxiq10+C+Y=
X-Google-Smtp-Source: AKy350aSmqp/jTl8AJ+hC/jfH5+R63J/jJrzIC1zRUVvbFF0ZIowk5FSVewHqL3dI+B1Vj6dtX7b0Q==
X-Received: by 2002:a17:906:ca56:b0:921:7e42:2777 with SMTP id jx22-20020a170906ca5600b009217e422777mr2179362ejb.69.1679643496869;
        Fri, 24 Mar 2023 00:38:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm9970429ejb.176.2023.03.24.00.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:38:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: sdm845: drop incorrect domain idle states properties
Date:   Fri, 24 Mar 2023 08:38:09 +0100
Message-Id: <20230324073813.22158-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324073813.22158-1-krzysztof.kozlowski@linaro.org>
References: <20230324073813.22158-1-krzysztof.kozlowski@linaro.org>
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

Domain idle states do not use 'idle-state-name' and 'local-timer-stop':

  sdm845-shift-axolotl.dtb: domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes: 'pinctrl-[0-9]+'

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/all/20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-4-3ead1e418fe4@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index dc43e438b64a..189786a7c5a7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -331,12 +331,10 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
-				idle-state-name = "cluster-power-collapse";
 				arm,psci-suspend-param = <0x4100c244>;
 				entry-latency-us = <3263>;
 				exit-latency-us = <6562>;
 				min-residency-us = <9987>;
-				local-timer-stop;
 			};
 		};
 	};
-- 
2.34.1

