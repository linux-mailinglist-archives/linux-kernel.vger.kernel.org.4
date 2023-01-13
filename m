Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176CB669E19
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjAMQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAMQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D47F47A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id v6so10470224ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/o3cDhl1VDCIhimkK4z4B4fUtw4xpL6u2a+ZhDH/qY=;
        b=q5bwqIYKcVlpXQx7yfIVzB2kWsP0AsMOz3CSBAyQxwpf63kGPfnklzoPexGpbe7m9t
         x9dx7vHCHobX2zhyhx22gqU3++27hxNy6YWX+2qyd22/Q7IL1a6Xaa70K3LHYEbdyu4h
         QGHfjd5vky6vaFzz311KgJErqqKrAH+UUgvo5Mq1CAZenMx5zhPpjFRsZRGtskuTRONo
         O7LhS6Fy/ywaNxCgCrhCAZHUO/olRMi5nwLHpyfLS7oOchL3MccQ0KOKNz7fzqjsYAE4
         6ywV3i/mMz4iMhDvokA3CAZWblcWAS4ATYVRFhJvl8Hpg4/Icagy8mlTuWmGSsM9Hwfb
         H46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/o3cDhl1VDCIhimkK4z4B4fUtw4xpL6u2a+ZhDH/qY=;
        b=IH+XYDELrDlA46F7OgAxVY0EMJpAMVCcIETCwMEOtWgBnmhYDrMcfJACrS99TamFIX
         ASxsielpouBZWGRqa2SS1fUFZMyNnJIch3Wqhni4TvqkwoJ7i+1T9OoUReNxt0ZrFUDd
         vtNSxrmvbaPQcsYIL+IyAuCfhcujqj4Dl7tdHAtk5uLwecIoQ5Jrf8U6mMFa6D4UaSFt
         kiRTNN2LTE3SE2GbpynusLpm2A7xoPy1A10H8sp4HvZgtfG08b81d8yNMullJAbNwAOh
         titLTnY1c3ZM/M8km4aijKKOHB61tWacp8iC2Lfnktk0SwfJSmVBlm9Pl7ABmsp7gDLx
         wuCA==
X-Gm-Message-State: AFqh2koxKS9sq8NULZiiDirzhNv6BqTjVsNY9RnEK7xikTG1v6/t8wVh
        wZQKO/AuvBvGskdauKVPTXMvKw==
X-Google-Smtp-Source: AMrXdXsEB9DBeXGM8m6kmN4csDLoYQGbHXzkjVvECMuguflfw8lprXbS7Ov+fnTmjSUMOZSUi0obEg==
X-Received: by 2002:a17:906:b00c:b0:7c4:fa17:7202 with SMTP id v12-20020a170906b00c00b007c4fa177202mr68035056ejy.33.1673626968525;
        Fri, 13 Jan 2023 08:22:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090676c100b007c0d4d3a0c1sm8739479ejn.32.2023.01.13.08.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:22:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] arm64: dts: qcom: sm8250: drop unused clock-frequency from rx-macro
Date:   Fri, 13 Jan 2023 17:22:40 +0100
Message-Id: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Neither qcom,sm8250-lpass-rx-macro bindings nor the driver use
"clock-frequency" property.

  sm8250-mtp.dtb: rxmacro@3200000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index f614992709d2..b22569101314 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2301,7 +2301,6 @@ rxmacro: rxmacro@3200000 {
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
 
 			#clock-cells = <0>;
-			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
 		};
-- 
2.34.1

