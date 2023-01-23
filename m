Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31B677687
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjAWInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjAWInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:43:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9E1CF40
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so8355757wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBYXU7BYe++OQvW58cNbRlLqJuMd3YZekY4rCqXq5Xg=;
        b=CZeldiGmAMoh9AyX++Cc9wiONG6AqYVq56JEOGws0sp5Id1XgurC2NY9QIpac3/jfC
         k3niGMyQQMEqQo1ENdkZHjVX9yGytIYmvfKirapkNnwFacXlBNxeZGr873cRFR4Wthmf
         vUiAFUEyW+aRIgtet10u8LxFtl6jaE1qFa6jBdqBjRQOuyDikyTpk9C8z2vDLpJUEaou
         JuROCiau9K7g/yyoVIh5xmCvOs24Otm9z1DXIqmRgYM6RjiStfT45TPIUCwzFCV3bTzC
         r/x6L4I1cQAZmQPIba6zqTHKd2s6o2+OG5ueJaVWpcHCiTMI1adOAXupbUmSj3gBIsQE
         4uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBYXU7BYe++OQvW58cNbRlLqJuMd3YZekY4rCqXq5Xg=;
        b=b9vMa+EuWu1ubKH/N+ry+oQ1gKlzStF5XLr8qYN2aCKEmaACt6Bvb2CBKxY+xM3c3p
         Qj53CmeqrCbLgwHmaunQpzv+6PpEIVU4YIDxzKWfRXzTBx2AnCybSqyeug/lxHJXVsSh
         TJF1tM1ySqUXGsONRmYESiwDfDi+rzuXDase3vvJvkXx2B3V2569ccwPUG5paOD4P3ay
         v7VRrk9oSpauU12eu1CCstXnAMWxCw5fJOa2t328wpBLo89uuiFJmc6wrR5cxtcBBJFq
         d0YQzyFB5P7HXcY/eWU0c0hIFkbz0y/Dbk4QDHxkFbXfYaEOsKL8DLaUQKB0hXTEqPyg
         nZPA==
X-Gm-Message-State: AFqh2kotOXIpvZMsbQMb8fEcnN6GGZQCw8TxELV0mHfyWwtxOWJgVAxC
        PrRWZ5fDUBtGPliwNcbKVh4HmO4MKqt415CI
X-Google-Smtp-Source: AMrXdXvepwyCojzXz6DeTO5J4kVb2lWaZqffXqo1Z9rqsGGVM/upZOXGuHkO+LIR0oi5/nr3Awda6Q==
X-Received: by 2002:a05:600c:c8d:b0:3da:fcee:2ef1 with SMTP id fj13-20020a05600c0c8d00b003dafcee2ef1mr22989216wmb.32.1674463388405;
        Mon, 23 Jan 2023 00:43:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b003c6b70a4d69sm10974120wms.42.2023.01.23.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:43:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 2/6] arm64: dts: qcom: sdm845-xiaomi-beryllium: add generic sound compatible
Date:   Mon, 23 Jan 2023 09:42:56 +0100
Message-Id: <20230123084300.22353-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
References: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
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

Use generic sound card fallback compatible, because the device is
actually fully compatible with the generic one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. None

Changes since v1:
1. New patch

Bindings: https://lore.kernel.org/alsa-devel/20230118101542.96705-1-krzysztof.kozlowski@linaro.org/T/#t
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 64de4ed9b0c8..5de8b4c372fc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -374,7 +374,7 @@ &sdhc_2 {
 };
 
 &sound {
-	compatible = "qcom,db845c-sndcard";
+	compatible = "qcom,db845c-sndcard", "qcom,sdm845-sndcard";
 	pinctrl-0 = <&quat_mi2s_active
 			&quat_mi2s_sd0_active>;
 	pinctrl-names = "default";
-- 
2.34.1

