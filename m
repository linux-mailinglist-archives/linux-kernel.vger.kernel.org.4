Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862576AA97B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCDMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 07:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCDMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 07:34:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC61351B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:34:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u9so20605247edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 04:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677933243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMVTh1sL5flAjLBAWSk6qXJsqRvFChv+pzIgQKj6Luw=;
        b=TOpThwDgg2In5aechAslGNPOZPSenAFltKkfvNDjpv0wNgPBSsKtsldMVsTo/CwhFL
         MSDLwWT5aZSXXpKpZMOMg6ymUouKiZDjx8AUFG+1BRVLVuktHAC+5cAEc8kmbjUHZcGO
         NmM1OxIWYYJydJ5suorO9PSAHFTLq5ykB3IU+4Nu09j9Dcr89jbKUGwq3fQuf9FrhAgc
         +7JT4/ufVw+RBekbj0Qdb10PglHK8NMQOkxzBMqiQYYr2ab+FzYjTn0xebIvu5VRbnHU
         HC6UZ1RUDJtkpegrcPWk+ixHhDCjLiJA8EXglMkumqnVhrh22VGyaWHDiwosHlzEAeN9
         AWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677933243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMVTh1sL5flAjLBAWSk6qXJsqRvFChv+pzIgQKj6Luw=;
        b=0R6I0bAMhuQ4Gnj/FsEyXHOrSdH13WU+1wJ9oiHhi+yCZ+2iqowKjDwQTi1TysV8vk
         iz3YSX9T+rJawVdBPOhK3P6jvsSDGQIX3yC+nJ7bJ4ubbcDK+i6rf7TVYEaEvDH8u5AD
         m5ucXik2HPuYOjOn7WpE47VvJQDcPItAXhByuwlkZAC7jWKlRRne+JNAq/iqwACTZ3Bw
         Rxiu3GwSrgVjpjPgthsliizkwaRHgwsIxzdXL+oM64K6HBorNxxmns1yDjUEj8Z4pF+v
         4QsVWdbn7bxiNXFrGeRzeUk2MTAkS4/PgdSLywFdxqCUq9VvdjPcdOxqBQF8PqG18Vsx
         lflw==
X-Gm-Message-State: AO0yUKVSdl2wlT6v/nuzUFMWmTHgSEcpR7QL8Z29DVC20Nn1nT2i2YoW
        cwLY+iDLwhF02bC7JaG+zLQxjA==
X-Google-Smtp-Source: AK7set/RoMP3sNzbIkKt2Zk8RuXYjWc7gSwEAULZ4BNK2U/mATyL+zra7cuQsaj4LQHXTh3lkxGNKQ==
X-Received: by 2002:a17:906:6b1a:b0:8b1:7ab0:a462 with SMTP id q26-20020a1709066b1a00b008b17ab0a462mr4428602ejr.7.1677933243657;
        Sat, 04 Mar 2023 04:34:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id q27-20020a17090622db00b008b1787ce722sm2017087eja.152.2023.03.04.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 04:34:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] arm64: dts: qcom: msm8998-fxtec: correct GPIO keys wakeup
Date:   Sat,  4 Mar 2023 13:33:52 +0100
Message-Id: <20230304123358.34274-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
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

gpio-keys,wakeup is a deprecated property:

  msm8998-fxtec-pro1.dtb: gpio-hall-sensors: event-hall-sensor1: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 5aad9f05780a..8b71b1f8f300 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -44,7 +44,7 @@ event-hall-sensor1 {
 			label = "Keyboard Hall Sensor";
 			gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>;
 			debounce-interval = <15>;
-			gpio-key,wakeup;
+			wakeup-source;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_KEYPAD_SLIDE>;
 		};
@@ -116,7 +116,7 @@ button-vol-up {
 			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
 			linux,code = <KEY_VOLUMEUP>;
-			gpio-key,wakeup;
+			wakeup-source;
 			debounce-interval = <15>;
 		};
 
-- 
2.34.1

