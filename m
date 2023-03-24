Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5C6C7908
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCXHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCXHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:38:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE03C13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:38:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b20so4440775edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679643498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1JPVhPaKbK9t6zWORTjEjcFohQ8Rc4HAUg0NuNw4Xc=;
        b=ndY85iwE3RVt5WVLWo8eeDVxPfY2k7Dw0VGoZzuE4Q1qHDHEUVZJTOlEjw5rHVUTBI
         tVxqGaKLK5AhgSYmomRxhz7af+x0L/ESGZ/zQd03W8w7+XaT1LuZ6kScEwgwk1NFI8pV
         bb9LaQRi5MCOb1QjaOZ3Rhn4TEHsuuXFU9eMfHgAxQ9ErHvVRb1QgWhj3JBshOEjLtJZ
         8ZDg+Jrh6hpjelgBmk+CNpXvriwitnTYPr8LGHES0sfQnjf3qoGXp0lnGL2spLyZPXk8
         wCOCd6/pwVbwd9hn/REpA0k/pYsS7VKNn8ynQ4sc8kA6L0nWDCmcG8uZMwPRDjejlurI
         LGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1JPVhPaKbK9t6zWORTjEjcFohQ8Rc4HAUg0NuNw4Xc=;
        b=N04TSIBKSF+5GERpt3ty937E3ZYeE633/FhruxRTQn8xr5ir5S/h2hedoM2nun1xvJ
         kICQlYd6c21VjT/kaM+9T3wY6yOmBedzV4uQkAuEUtR8ul5DKdHYejEGqUeNhkJRL324
         YgwxlAg6Tdgfuxqm35cIGaWm4I4U7QkJYYs9AFaJxkKM9n0GN6YHq4te1WcBqeMsSomw
         D5JcB022fxtvZMNHX+VVGBLGWGP9+n4p6GcfDLNC7ywQolyM0Dk+bGXRD6y+u5nhlFWv
         ujPsdfZry/LoiTuOu2gdQOlyyE1M1qzHRGqk1ZIbc1KFNKMkif6AvEkGKZSOHD4v8vEx
         ZNEQ==
X-Gm-Message-State: AAQBX9dd1M16Srhx7C1E3pJ7sgF1XZAzODRQXmIL/Ivn7FvIv0F3tz0M
        b0VMnY0l4jkINs9gwIQrBwCRDg==
X-Google-Smtp-Source: AKy350Ycx3CDmLkOlEBiyNB7hA2XRwYqRWxKrsIe7d7/rmV5hctI3km8t2WdRZ7WscFgC/lHpVzUCw==
X-Received: by 2002:a17:906:7189:b0:930:6591:15ee with SMTP id h9-20020a170906718900b00930659115eemr2026580ejk.10.1679643497767;
        Fri, 24 Mar 2023 00:38:17 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm9970429ejb.176.2023.03.24.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:38:17 -0700 (PDT)
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
Subject: [PATCH 3/6] arm64: dts: qcom: sm6375: drop incorrect domain idle states properties
Date:   Fri, 24 Mar 2023 08:38:10 +0100
Message-Id: <20230324073813.22158-3-krzysztof.kozlowski@linaro.org>
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

  sm6375-sony-xperia-murray-pdx225.dtb: domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes: 'pinctrl-[0-9]+'

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/all/20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-4-3ead1e418fe4@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index a99a5641623f..c020f5bd6491 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -229,12 +229,10 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
-				idle-state-name = "cluster-power-collapse";
 				arm,psci-suspend-param = <0x41000044>;
 				entry-latency-us = <2752>;
 				exit-latency-us = <3048>;
 				min-residency-us = <6118>;
-				local-timer-stop;
 			};
 		};
 	};
-- 
2.34.1

