Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D116B1113
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCHSd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCHSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:33:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C14E5D9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:33:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec29so38627761edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678300400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgI7M9f7uxE1fqJoZol9DRzCA9OZOelkziPNUY4577g=;
        b=o43QCu0Dt/IJevXs8aYajqqhK6Hsl6V3oWB7BA3V8q8dYLmKAOKFSBXOzPHQepkKEy
         HdhEdBdx3GsLNNqU18hRNz+KnFwX9i5eVVyK1w6P5R/tQFR1SLtckCqcwKRAfhja/5HK
         TEvL8StOG/vYaY1wmaVKYkpPCr51eGiwCSVeyf2sZRfiQOJJ+Ia/BKbsNDU38zawal4N
         oyEM3hluHsdExFfYzZqFLq7y/h6TQmuqhVa8GFBBY+1Ruivm25F3shz7bSBHW/P57S8I
         E3rwb6c78E1DzOoVCzW8rKOioiGaGtIWo7a53ZrXB/dY2qLzc6TPjV9bw6hLk1U+UkSB
         I3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgI7M9f7uxE1fqJoZol9DRzCA9OZOelkziPNUY4577g=;
        b=38buMUScpSo864LUUMDLsNjfWkYjsAcRCM1RlciBlext19zJEkVZC+BkrPY0yl+vmN
         7PrYG2BaEAFi2PtNRtKY17fmoplgEecU0X2IW5l+8eFL7X/iNNXvZfKf50vk5bWaF5iB
         L787WdPOhyAflhHVHecLQ64W9JxvKQ2OQbwtPJIiuZia38DbVyoPEest5Quttc1d4OJs
         blKUkQCsXSC110rzOnTy6c8nH1SE+bkMRL5xE8a2wiLwzfKjvRc+0KfEXECwu5aY5ZRZ
         cXMQTO3R1e1/MsBKPcD0i2kW6DQJVcKg/vaP8PwcNFPyFHJAWy8s0B8YRlSCFKZUx9Ca
         qM4w==
X-Gm-Message-State: AO0yUKUoWBa1OVh8iOEajSAnje8+Vat4T6TtrnOpZBBoxPHhq5IIv/4X
        siJhQ/9witXqMCkMgrYBU0zGga5/k8RYNa6Ova8=
X-Google-Smtp-Source: AK7set/rB5yXgW8HmTS5K6mLEqa9Ql+zlBQcQWZZcMvV/S0Jl4XLcv9SWE3esrRAQweTgg+1MqHHRw==
X-Received: by 2002:a17:906:b51:b0:8b1:3ba8:3f4d with SMTP id v17-20020a1709060b5100b008b13ba83f4dmr16772181ejg.70.1678300400295;
        Wed, 08 Mar 2023 10:33:20 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id r25-20020a1709067fd900b008e125ee7be4sm7852709ejs.176.2023.03.08.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:33:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8450-hdk: use precise WCD9385 compatible
Date:   Wed,  8 Mar 2023 19:33:16 +0100
Message-Id: <20230308183317.559253-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The HDK8450 uses WCD9385 audio codec, so use precise compatible, even
though WCD9380 and WCD9385 are both compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index e04de4bb7fae..9cd1d1bd86cb 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -25,7 +25,7 @@ aliases {
 	};
 
 	wcd938x: audio-codec {
-		compatible = "qcom,wcd9380-codec";
+		compatible = "qcom,wcd9385-codec";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&wcd_default>;
-- 
2.34.1

