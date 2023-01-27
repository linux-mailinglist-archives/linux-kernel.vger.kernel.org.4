Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79867E507
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjA0MWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjA0MVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:21:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9380167
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:19:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b7so4819154wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Da0qeWnQKms+lCstAxZwJwpzXqE2bzgXMZ3t/w2tyj0=;
        b=eaVeZzCI1Sv333gDqppfbEwTaDZ90FAGty0Z4HK5jkFr21cS9Mrib9NDGLNS2Y0hfj
         6cSXQNDMM8ScXlSn6T5YZAMZRFhg2t9sDVuxx75wuVxSdTaTW5adzeGaS7UV8zdBf/Fc
         AsPgsH8zYH7/dd3vbQRRYObDSKV79sW8MgYca71DxqE7CfJtPQMkoTTY0Taf6oJJ8u+6
         22adjHBWV5MSkPByjnnKQvIinZ9RGTykqWKRJvVCJdFrReRthRK+ci9Xv7eACHDLThKD
         fAyQ1/Jp0+RKlvSDIW1VgOyPtxrQ4K1cSg/TCOAGZ19x4ppOtnzNuuqNrywBM04f+PAh
         yReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Da0qeWnQKms+lCstAxZwJwpzXqE2bzgXMZ3t/w2tyj0=;
        b=5VnZgKRbBYq0A3yFBx7uojzRlOYpQxkqM4qRUDT8PONnNNnvYjK/HORAnKvoOsVOT0
         FyW8zvw1wsu5b4vGplFlzdJ7IpGivs8EG2jK9cIB13la1X11gRKhkB8s9naK87EsNBa3
         XA+OCyVALod4BlfDhuW+0liV/DnLV4JvjmT3gfCjdENrj9B0jFxFnr0qSQNMr0B3Vkxy
         8Fn1hujXoh9W5sHvngs3zOH4Cn7z3vQoAQ/YhNRtMcZuclwNhhz1Uv94r7kadrmMZxqw
         Ng04thjRbhTKPdXYevYQDpFRWD7u1FOR4UmJFFDFBnASZDEyIdu1eJSRi5vNQGUjoerB
         mCBw==
X-Gm-Message-State: AFqh2krnLmaHuBqrPxJLeDAyGNWVe2dMIlwEItu1zyeD0b0D2DZIVQfZ
        vCpf+6njBQ/f/G57Hf7NF6BRRg==
X-Google-Smtp-Source: AMrXdXtlNeEkyvIfAzqBAjQjp4sDKXkPfSH7UOmRMdZoDDkMQVba4IXTSXZT66zMtkMYguiDJmypxg==
X-Received: by 2002:adf:b60f:0:b0:2bd:f71a:5b32 with SMTP id f15-20020adfb60f000000b002bdf71a5b32mr33949862wre.58.1674821938820;
        Fri, 27 Jan 2023 04:18:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b002bdc39849d1sm3731089wrx.44.2023.01.27.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:18:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: sm8550-mtp: correct vdd-l5-l16-supply
Date:   Fri, 27 Jan 2023 13:18:43 +0100
Message-Id: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in vdd-l5-l16 supply of qcom,pm8550-rpmh-regulators.

Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct, not drop (Abel, Konrad).
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 725d3bc3ee72..5db6e789e6b8 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -47,7 +47,7 @@ regulators-0 {
 		vdd-bob2-supply = <&vph_pwr>;
 		vdd-l2-l13-l14-supply = <&vreg_bob1>;
 		vdd-l3-supply = <&vreg_s4g_1p3>;
-		vdd-l6-l16-supply = <&vreg_bob1>;
+		vdd-l5-l16-supply = <&vreg_bob1>;
 		vdd-l6-l7-supply = <&vreg_bob1>;
 		vdd-l8-l9-supply = <&vreg_bob1>;
 		vdd-l11-supply = <&vreg_s4g_1p3>;
-- 
2.34.1

