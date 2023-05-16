Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D610705296
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjEPPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjEPPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:46:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F015F902B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:45:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso21523174a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684251942; x=1686843942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVvw51M3oghXEdU4QbKnqMa7gMGVZBvLOUaDcEfxIYI=;
        b=ytE8rV5ZI+aian4Sl6AOp0vjREMjTnZr37rOcYU3sN+b7EWSWmJeZ5/Fo8/C4tleIZ
         KBhEudhex1I/pmUtbrpWrYlOUzbD//JJUrUpO/duk5LKUFn33dhd7OJC6xNvsGpp7nL5
         bbCndVK1npIiwHEMiMIh4OSdMjDyGoWbvf6hTbH+aM/2h7L4gg1gf33cuh96+KDd5NlZ
         oZATg5uyuCf0075tV72481F8wJsPOEVIVgkTs02z90DoTUlmg841IqwcBIRGSWAe6Zwn
         Nmg5BWdJt+3LnJImr+cpsalGx+IpeMKppjY4H7tPo30Xrl/Efk9D3Z4IbiJIp6gaN47l
         yWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251942; x=1686843942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVvw51M3oghXEdU4QbKnqMa7gMGVZBvLOUaDcEfxIYI=;
        b=jDnPOetCQl/Epb27y9kJ6zM2XZ291uM0gKyKQ1LioJYzDRL+VMqFfgxCTuSEiRPBGY
         l6Fdl8AV3zchvlqoh99PPkzmiK1qAyLwhOsisM98r9lwzD+n4Tgvcfxf5eQWg1OSX2pJ
         TP7diSo+4WHkIcwnXlQ32In/QGtYVfHe/qMolq5FjEWpi2QOIF49MLTKXvP6TqmUfp9O
         I8sznK+b4OW1C8OKQhHPue3pjlNLKGbXjhh7X7sRUic7OSQTztdcdTtmzd1HT5FC5kmD
         8fZ/WkuBWEEITwNl0hAxxuXY6qfQe2gx62zM+Ec9jHmtMKxwU4ws3URkJlno0XuUFSap
         zq3Q==
X-Gm-Message-State: AC+VfDxR6QCCA70C+cRPD7QCVgHHG4L3wPLmf8CXe1jURVSTCSMYdwFm
        L84TkzmJWB8KLxhtWgmIX2fRtQ==
X-Google-Smtp-Source: ACHHUZ7DxXQjN+1+QCOknN6+ey/UP+0j03lKz8nbMqa+um3HYnxt9AF7TvKHKTfKDQJ7Wn/ZN4gVlA==
X-Received: by 2002:a17:907:2d12:b0:969:98eb:3fdd with SMTP id gs18-20020a1709072d1200b0096998eb3fddmr29573166ejc.3.1684251941993;
        Tue, 16 May 2023 08:45:41 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id z25-20020a17090674d900b0096ac3e01a35sm5787587ejl.130.2023.05.16.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:45:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm8550: enable DISPCC by default
Date:   Tue, 16 May 2023 17:45:37 +0200
Message-Id: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Enable the Display Clock Controller by default in SoC DTSI so unused
clocks can be turned off.  It does not require any external resources,
so as core SoC component should be always available to boards.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 785889450e8a..f27d5c657f44 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -419,10 +419,6 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
-&dispcc {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..0a3a08336b46 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2684,7 +2684,6 @@ dispcc: clock-controller@af00000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			status = "disabled";
 		};
 
 		usb_1_hsphy: phy@88e3000 {
-- 
2.34.1

