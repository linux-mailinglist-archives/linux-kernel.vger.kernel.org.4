Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE7734278
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjFQRQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjFQRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:15:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC11FD5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9827109c6e9so268286366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687022149; x=1689614149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps3QWhVVgM6yGh2UTWWsOwF/OhEiPRE19a/BAGqkfqA=;
        b=oVqwU31gtiEEDfj1eoeE+VmSOhCMLMwXXabNAHauNMZRtyHi1OSr8aIk8+OyWUrhDU
         3UeECwwK5pG6JxC3/ZcUfDPyYAFZgZ+O7tDYJO12ffSnz4PuPN3zgBpV+Q0fPB7gZBy6
         Q05camFlcR4He86LcAMbFKMWuNCpwgazMmvHKZ5ahanIBdZngLMAJorPzjrY/tOujAQx
         C7VHmZ9/qyiKuuLjPJdS4XnHO8yzPOL1E+sC/TXXjuHRZQRMwPTfcz42/GwP+Rf/xyyE
         k0CkL2ji9d9vT/i1XkkOjTTKREZ9PMBdBHdBYO8xwmD7T5Kd4rNu2IIBPMcNcEcGEXE5
         MRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022149; x=1689614149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps3QWhVVgM6yGh2UTWWsOwF/OhEiPRE19a/BAGqkfqA=;
        b=MuLOUlyUUvBBakzE7Rld7OUZhmzalRIwvX5MOhlYZgQZ9/myxKZHzcRZHUHZ6ZBf4S
         HawFwkerzUTw1iQk5pN4uYNoJMiz3q7O5cHJPLeyFwGql/d1p/iGHKUuKTdfY9fe2yUE
         RyS0ZjasPIrwKKhXHO4MOmdecKZ68i5oq0DK9n+TSGRdhZMU4dHJjGV4PYEW3uodbQIF
         JrVnr4ue+n/hQeqqvMj2ktP7FpzODIhGxxdYJ6uUQfngPo8r+yqkHLDyZY9qF5Tlz/y5
         E64FkDWw0izR+7yOheyil1TP/YGp+WsA5CTeW9Du/qnGhjZ3nJQk5cY0ooJ8ggqdvHoo
         haQQ==
X-Gm-Message-State: AC+VfDwlxiHwdzU3Bx8NvJD6Ve17EpO1AjGiX8B/4dk67oXLSoZlU0Kw
        CYaGm5H9PbXPcm7dfzbmgjpGAg==
X-Google-Smtp-Source: ACHHUZ5LRta2MSNgyD5Erud7nJ08cxzq9SD3oia0W3ulgA2TZ+4a1Qm7H3m11Sc648D6tS1N5llJ4Q==
X-Received: by 2002:a17:907:9453:b0:987:47b3:6e34 with SMTP id dl19-20020a170907945300b0098747b36e34mr2143469ejc.67.1687022149172;
        Sat, 17 Jun 2023 10:15:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009829dc0f2a0sm3841897ejb.111.2023.06.17.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:15:48 -0700 (PDT)
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
Subject: [PATCH 04/15] arm64: dts: qcom: apq8096-db820c: drop label from I2C
Date:   Sat, 17 Jun 2023 19:15:30 +0200
Message-Id: <20230617171541.286957-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C controller bindings do not allow label property:

  apq8096-db820c.dtb: i2c@7577000: Unevaluated properties are not allowed ('label' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 537547b97459..002cf5806d83 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -138,8 +138,7 @@ wlan_en: wlan-en-1-8v {
 };
 
 &blsp1_i2c3 {
-	/* On Low speed expansion */
-	label = "LS-I2C0";
+	/* On Low speed expansion: LS-I2C0 */
 	status = "okay";
 };
 
@@ -168,14 +167,12 @@ &adsp_pil {
 };
 
 &blsp2_i2c1 {
-	/* On High speed expansion */
-	label = "HS-I2C2";
+	/* On High speed expansion: HS-I2C2 */
 	status = "okay";
 };
 
 &blsp2_i2c1 {
-	/* On Low speed expansion */
-	label = "LS-I2C1";
+	/* On Low speed expansion: LS-I2C1 */
 	status = "okay";
 };
 
-- 
2.34.1

