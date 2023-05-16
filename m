Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63BF705299
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjEPPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjEPPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:46:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A427AA9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:45:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510a59ead3fso660462a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684251943; x=1686843943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQlA3yGFk+W7iwOwNJA/IHC43J6THIUeCVeGDi4cn+U=;
        b=VK6YP2iWRxhrKJYvG7HfcKg27w19vYmQLHqpzqx7iCe3mmZQ++716UsVI0Am7GqWL+
         Mzkq4XRwVU5WBasxRCEh2Mv/SxiocZL1Kx+0ObtVX09Ioq7NjVHMRPXOGfQyZ31grP/1
         CJsVBKseo3JxnvvvyGGlYnnrExdGHWcdoprywM118VvY+4Gz2JoOMrerXTEeGOciNysf
         nSEVLR5imfRm3+ow8gYAJYrabuQbV79SVwh7N0CZM9HuguypmIMETTnPzb9XgewlFvm6
         jNl7808bOgN1Y0ztm3/Ro3FDResBHJfa2TDdrMRiNH7JXXSKw4XOUVpVdPVU+oe3IGQ+
         WHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251943; x=1686843943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQlA3yGFk+W7iwOwNJA/IHC43J6THIUeCVeGDi4cn+U=;
        b=eUsnmt2+5WzY22jlWHA8wvAsCsWVqzHma7qPXC/g8P9B3i1HuB6x2hmHC6h8r5xnJf
         d3zq1FtDJG1mT2TOWYpmKIOFdhkmanURmsKO3uafcvbOTYRBQNTw3N+/pf0qzDkFGagY
         waszqFc6uRuwpPa1fMTJC9hyivAeUoPTFJQjTYsVc/uLq4O3pzA6BU5EFMgyp/6L9QGM
         InxrVuAwdn/rvY1PXzzUkZ7Qi6LVGnnmuLCxaFhp2VGj28H+IIQmxxJ5f0Pd2LklGGqo
         foO5A02UAOV36Fw2f40hzcSVMIrNS9IEr2D7uOMBaJIkD82ciez6VmPNBfgT78M4X6c2
         VFDA==
X-Gm-Message-State: AC+VfDzq3u74kw+Gvu1zr5M+C55tZA2lKTN+LHIn1UPuZ36v+EMSr5gP
        2PLcedaW7Wob1ERsf614U2dpEg==
X-Google-Smtp-Source: ACHHUZ4CRZKuoHwoGmVwpJlrbkQ1LUo7Al6/SbQKg0Rx7PtzMW6yTz79nHA2GU7ki+vU9VLNEHWKtA==
X-Received: by 2002:a17:907:6eaa:b0:94a:9ae2:1642 with SMTP id sh42-20020a1709076eaa00b0094a9ae21642mr38134440ejc.46.1684251943102;
        Tue, 16 May 2023 08:45:43 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id z25-20020a17090674d900b0096ac3e01a35sm5787587ejl.130.2023.05.16.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:45:42 -0700 (PDT)
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
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8550-mtp: drop redundant MDP status
Date:   Tue, 16 May 2023 17:45:38 +0200
Message-Id: <20230516154539.238655-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
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

MDP in sm8550.dtsi is not disabled (although its parent MDSS is), so
board DTS does not have to enable it.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index f27d5c657f44..579f65f52370 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -459,10 +459,6 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
-&mdss_mdp {
-	status = "okay";
-};
-
 &pcie_1_phy_aux_clk {
 	clock-frequency = <1000>;
 };
-- 
2.34.1

