Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31486C790B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCXHil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjCXHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:38:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D72AD31
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:38:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so4422866edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679643498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0CXrEO0kHiEzAxVSvYkVOU3gt452PSdh5fBlOScP70=;
        b=txP9jfzdiXhV57tUGUvx/Nr288Di2Kd4DyfwqiXGf3sEzRawJ9R0dzHlZiDXp/cfQ8
         9yPpP+852qEckiTIq8k8Nu6n5Hyhg8DVb/2SozTbgMhcyLvOilpCGB1NXYhsgipVztN0
         KetpUWafVQlJOjwID7GKaI23n+b/6HH4kxzCkG68b1UjZuvdHRKdT7oPFQgx4PPTtlL7
         KTZQ4GuVsb6fHqK/Er4Pq6VBrl+ELjHv1TlragN5FG0BzWNem5rDIaPiSR1OCwLJsakV
         6SFU1TSLmea0k6CiLQGBEOHfeN0wc0ArkiXVzNYu26VC5MR+3oFiVhRXdn1aDp7Rawrp
         qJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0CXrEO0kHiEzAxVSvYkVOU3gt452PSdh5fBlOScP70=;
        b=iDgf8VDERSFdAx1ghaEtuuu9Ut+H3iDJj71VDyfqLXtVG/BMEGBLXECzmCV9Nx9H3Y
         7LPTtSl99/xEmasMS+6wJj7BzLQ1wjLxvBw+lfJED6yWbN6bcijzL9q9RCfJSZzrvSTt
         9xV1FdcM+val/KakXYga/SVZdNx1m18/EvsFAJ5oi/raUI41+2gpTiS3QDm1q8PV4DG7
         sVJhxJql5dLWTBAfEn8SAIrAvXyWtbYBuGtK8+Ybd3uCA3v4Qtf5QYmexJSD85mplwFM
         hvykUfrcO8xmOqOpQ/zb0yIvaJoqSm5dUx9lkPDvBAx8HJljB9D+Cxhk0+PN2Ow2rD3t
         hZ1A==
X-Gm-Message-State: AAQBX9fte/YN3JzFAx8zY+9KRRU36UJmdDy+icy9Aze5hulRx6UxPF2E
        fBBA6Fz8J9JUSnq2/80bVvJl9A==
X-Google-Smtp-Source: AKy350Y95ECzPAy9a25mMDi63+t+A41Pldkx5vPXjcrKdHuLv9Aj+jl4u6E8yEwxdj02vm6I/uKI8g==
X-Received: by 2002:a17:906:3896:b0:933:3a22:8513 with SMTP id q22-20020a170906389600b009333a228513mr2493570ejd.53.1679643498750;
        Fri, 24 Mar 2023 00:38:18 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm9970429ejb.176.2023.03.24.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:38:18 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: qcom: sm8150: drop incorrect domain idle states properties
Date:   Fri, 24 Mar 2023 08:38:11 +0100
Message-Id: <20230324073813.22158-4-krzysztof.kozlowski@linaro.org>
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

  sm8150-hdk.dtb: domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes: 'pinctrl-[0-9]+'

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/all/20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-4-3ead1e418fe4@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 0de406752a4c..da048f86c50e 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -287,12 +287,10 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
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

