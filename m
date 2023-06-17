Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C102734286
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbjFQRQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjFQRP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:15:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893D19B0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a270e4d57so2746445a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687022156; x=1689614156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trZypnUBwbyd7HQpp3qXfZZnZON3/NJwmhM5fJGahr0=;
        b=KJN/tLuUnb/r3AJxJthw3lA+Yy0hrBO8zHSte4/QM85EAIMrmzYNS14afTKToNVaVl
         KuS7nvTgXvfeTdL4mXPhH4FkJylgM1T+Kce7pYQG5dwFt5AcZIu10yoSOpf4sM5lNdvU
         psiAmwgE9khqDnYSuft5XJV3jRHeIrQUmiLQCi2BmqKOGksD5ZxabgsPWfkmUdnbqEO8
         FaUckKxeMTAf8SnkYlZRzK3MQ8cPBo/k+SXBzDuab6bb8UKfSYD5iLmpSDKnFNyZFxyd
         tSju5aM+YIEvYI6WSu+RqdMTXrHqnYPu2LqGVMBdt+U2GaHVt1hdqpibXk3DLj7lyLUX
         T6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022156; x=1689614156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trZypnUBwbyd7HQpp3qXfZZnZON3/NJwmhM5fJGahr0=;
        b=Nq4yY230naOFu489Vs5MRpTpCd/6OW0XgXzDtY9D85cjfsKKAN4m4rpjrVxZQBjY47
         wU5zVZSgQYGV9xP/B9ZsSH5Md/gJiGzIDf8IUem+IGCOHYjW7qs3FQti+qqh87d67AdL
         BFdDe0y7IigcZoCceZ+b+Km/xPrmJ+II8tIVQg/7NkpI4gP79b0o2VQRMyy0DhUq6oyK
         u6TMdwN2MSGWLd09AQnNRrTR3LnJy26o4/P7CnkSKr00vEn4mZNAql0jyIo/IHX7bMmy
         XqgZKb5bTNHImkK9+mnTXmhci2Z1mCgCtCxYPJTEAXJy955lbu1xXkZBV50vDP/v4RHK
         SbxA==
X-Gm-Message-State: AC+VfDwiQlgOvmjsDxuC8UKULipQm6PmEHhJfRWu80c5DmGukJb6QOKX
        K6zCElAM4pjVt+Lvvapm/D98lg==
X-Google-Smtp-Source: ACHHUZ6bupV4QTwKsvcCu7E3c4kQ8QhqFdeVLvWUNd6eThr0YgXZZ8AfwjYPjPs6XIYzYEBQCg562A==
X-Received: by 2002:a17:907:6e17:b0:958:cc8:bd55 with SMTP id sd23-20020a1709076e1700b009580cc8bd55mr6139103ejc.0.1687022156163;
        Sat, 17 Jun 2023 10:15:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009829dc0f2a0sm3841897ejb.111.2023.06.17.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:15:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/15] arm64: dts: qcom: sc7280-crd: add dummy Bluetooth VDDIO supply
Date:   Sat, 17 Jun 2023 19:15:35 +0200
Message-Id: <20230617171541.286957-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bluetooth requires VDDIO supply.  Due to lack of schematics provide
something dummy to satisfy `dtbs_check`:

  sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index afae7f46b050..b1aa5b0ee95c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -24,6 +24,13 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	bt_vddio: regulator-bt-vddio {
+		compatible = "regulator-fixed";
+		regulator-name = "bt-vddio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
 
 &apps_rsc {
@@ -38,6 +45,10 @@ vreg_s1k_1p0: smps1 {
 	};
 };
 
+&bluetooth {
+	vddio-supply = <&bt_vddio>;
+};
+
 ap_tp_i2c: &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.34.1

