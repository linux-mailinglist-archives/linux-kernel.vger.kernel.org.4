Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B266E835D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjDSVTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjDSVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D235FC0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b16so1732277ejz.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939148; x=1684531148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnOb+4WvI3k1YdYX+1AvaBMgcWn4PAgPOR6hlBIZSsg=;
        b=qLYMzbNhdcjmPz6cfxJn3bGOM2Km6FW1YmIbKOjJvqE9z413u5VXhlEYuHsO94MDox
         aik9g9oBccLuJSaaq8hOPeSlV2Vh9WLF0xtNq9/ssLa4F2QyBN7NMnrBo2JMnCfUhULu
         DBTaU/Fe2KnZ0ZJUioZO3eqjrX6HxyBHNvPUMMhtvRtckLyT4DtItJlK4qX97GeQ03JL
         W4vVzCkd/1RFguQxAX7Kuom2DTEL/N7PQmyozj3K4BNZ4FVshTXPL8UEs4pAF5AbYrP5
         EQ+aTjI3joCx00zs3izwqHY4KMYIaZvCjcmSs8OX0+bY7x1XinSIv0qgsfjWSr292iBC
         KlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939148; x=1684531148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnOb+4WvI3k1YdYX+1AvaBMgcWn4PAgPOR6hlBIZSsg=;
        b=H9RIC8P9O9kvuUYv4TWYbZrjsTcAoDX1juW7a1g1Kcs/EPt3tAOJNVJkHldLWFC/lq
         gyBHyzNntQgtZ9R5aqmkUW6f8yN1IAVNkREO2HvJQtSU5hANtUiwaByKUBKgcVU5SG/d
         nu+x6hng0HAZKfU7JxBlqv17hzijFqEdcg5l4dzNDBeQks0uDH4jtgkmOtz17nEjeAoO
         EJ8AXW+mmGPnWuDkh8JtViTanx7lCBysssf0VSAHbrpZzXIhQA53d2IaCJgpd2rAdhEP
         5SkblQYG2ir4ak0hZkEPwsv7twWwFEr/bo7WXidFKDrVGRaEJS0ghUJGz9/eFjBlW0qQ
         uMlg==
X-Gm-Message-State: AAQBX9d+FXCgI9IfbQZGfqsRPc0gv4cgO5nK9M2w+hnn7+DGTdsPaiBe
        FHGY/ITaEUmKiA0SVu36xLIfsg==
X-Google-Smtp-Source: AKy350YTKzQgMxhrGZvKhw4q0lFbnY04oC9f6dJvFGJnaXAvk9OrpzrjAt3GIZJXqG6YpnsUsI2ItA==
X-Received: by 2002:a17:906:d935:b0:94e:d97e:7a5d with SMTP id rn21-20020a170906d93500b0094ed97e7a5dmr15777623ejb.47.1681939148244;
        Wed, 19 Apr 2023 14:19:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:07 -0700 (PDT)
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
Subject: [PATCH 06/18] arm64: dts: qcom: msm8953: correct WCNSS unit address
Date:   Wed, 19 Apr 2023 23:18:44 +0200
Message-Id: <20230419211856.79332-6-krzysztof.kozlowski@linaro.org>
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

  Warning (simple_bus_reg): /soc@0/remoteproc@a21b000: simple-bus unit address format error, expected "a204000"

Fixes: b12428640ebe ("arm64: dts: MSM8953: Add wcnss nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 4038e47a4610..d1d6f80bb2e6 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1425,7 +1425,7 @@ i2c_8: i2c@7af8000 {
 			status = "disabled";
 		};
 
-		wcnss: remoteproc@a21b000 {
+		wcnss: remoteproc@a204000 {
 			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
 			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
 			reg-names = "ccu", "dxe", "pmu";
-- 
2.34.1

