Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CEA6E8354
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjDSVTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDSVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196B44BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dm2so1618906ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939142; x=1684531142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+S1PGV40leJbvMByVhOfE65UL2JdGFknuaSBN+G7W4=;
        b=TfjcQJQmpkTC4C8RQY6hX3CePx/OXPgugf9zPuXGeYyxiyxOXV7aqHdIu18qSoM7Rz
         81yNQE0/f/N8TwHM0Gg0fInqIo9vXQ5Mv1tgaNiFvsjKFqGRBnXrA2oZLXUyTVMe4vbA
         aHYEdDtYWZDMUPQlkMepRIxmXeI0+9dDmHSs1uVB0QstAu9D3p0XKOvaCT/f4TXoIqPH
         MSMefRKxklUNfQVrjfV6VSxF8A2528e8+JI1NbWvKWS4KkLnpC08uNUKOcneCFHS6VbV
         BxQi3jomtKsXYQ6clT/oumkRq/QBIY8BkQ2dZtd7DkNw8eV+PFyyLEWYClqpmOWmjQNA
         d9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939142; x=1684531142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+S1PGV40leJbvMByVhOfE65UL2JdGFknuaSBN+G7W4=;
        b=IYZvZ1bqDAhOxjTGYt8pq5rlhKfMONzIYJrKqNEKfIQBMNGGC2s1XsL9Sm77HMXpXJ
         waeCwfHuusPr220kZ0A8U+J2KtYaADm7qm5noEbmuuZXv6IX4JruKsm2acc9mVGmryCm
         fcKFWA+YdiKpmlpNgQCluujoQHSyaXoAjTklABs/idp3NYukB3A/cZHuCE7Qcj0We/Ko
         H3u8clmG04u5Z00R+8YBVB6wFuAIQyeOkfPLCWPtbFifw+ACAf6GkpmJZ92Ndap9Gl9p
         1LTAZfC30eWmhbLXYNBNaDBrpIralrQM3UbZaGlzNgmM6XBrlOHgU5/Te1oq4nlBwHi3
         YwDA==
X-Gm-Message-State: AAQBX9fH56BBYpkyCqPsej73+Uk+6sIQCBgntTuSpz2QrpC/znZiLRXv
        iBHSIGdC7rnY2OOAQX8IK3TaEA==
X-Google-Smtp-Source: AKy350ZUWRhMuvZa/+7AptTp8ymbNo/9VKL3BoRqvF2YrAnLclMmqxpFVX15zU+FOVqH/VBGfOb7BA==
X-Received: by 2002:a17:906:4fd4:b0:94f:a8fd:b69f with SMTP id i20-20020a1709064fd400b0094fa8fdb69fmr10397282ejw.18.1681939141878;
        Wed, 19 Apr 2023 14:19:01 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/18] arm64: dts: qcom: msm8916: correct camss unit address
Date:   Wed, 19 Apr 2023 23:18:40 +0200
Message-Id: <20230419211856.79332-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
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

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/camss@1b00000: simple-bus unit address format error, expected "1b0ac00"

Fixes: 58f479f90a7c ("arm64: dts: qcom: msm8916: Add CAMSS support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 834e0b66b7f2..894a99431158 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1162,7 +1162,7 @@ dsi_phy0: phy@1a98300 {
 			};
 		};
 
-		camss: camss@1b00000 {
+		camss: camss@1b0ac00 {
 			compatible = "qcom,msm8916-camss";
 			reg = <0x01b0ac00 0x200>,
 				<0x01b00030 0x4>,
-- 
2.34.1

