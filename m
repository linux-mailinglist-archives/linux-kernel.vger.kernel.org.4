Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC11D6E8367
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjDSVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjDSVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19997ED8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud9so1642964ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939155; x=1684531155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fKdG4IAFTjTbJ1Tq/YMvnFxzYWlAaTBksWv+vU3eDE=;
        b=N6oK8IOv7RviKfj6Lyns8glsJhwggzLf5xh2KlUareH6SCOE+9KCGyeXxVDn7gCCRu
         jNvXTxwLD8cJWmtySqP2CcCGerOJap2xX44KrqkKsME12QvPoy/t3/oinDyyjNdce1Ap
         0U8MhCn/zAkNZ7rrUzbfiKFfPSnS35NB3hZ6fKnyQ8CfwZXx55Cj9KmkH8uXgi89Eq/7
         tHItd3DyyMg7WtwL3RvlnMdpXYImSaEqLLfitw1lcAfWuBL3rsqoEZo3RXoGs7uIepde
         Ck7ZreYN5TDTluymFDzxkaHzNHe1uA+gKiUcuEm7bhiL40wjrbFINUBtgL9n7yXsfpSa
         Dbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939155; x=1684531155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fKdG4IAFTjTbJ1Tq/YMvnFxzYWlAaTBksWv+vU3eDE=;
        b=Mr+U6vvNkRzORx4v5lsThOxxzjejIsXQT6igJPDtvgtGq12N8LPFajLJLqRD8bVLDz
         vmFzJzV7akogSQlRXuEveGbajZrzLE14/41oayNeqCUzdvAH2yRKzz+DRNTCSGv/0ao4
         bcKmDtMLK8kNJlErU1pYng6vB2aFyM7E8PeWVU361AcBEgwIZVara7y4QaLNPjOxSnF2
         Mz+h09XJ7EFLOgIOZdGsPtsnFv/g4m3muDjmnyFbzSlu872ghwszHq2/vIQMINo9rMqL
         mYK+4YA84VypEX6w3IlNjpFI3U1tHR3/3n6kqgJq6hkK2ntHRgZC/6dDHTHAUyVzaqAe
         KUrQ==
X-Gm-Message-State: AAQBX9ev/Xra1kaTWlCld9RyiaLwCkhvhbEfTU73aJSEmEdnUSn1prd5
        jnUXusmPmg719Y0Vi53KZd//Nw==
X-Google-Smtp-Source: AKy350bpIIBeKxoFF76FmB0fvgHKRhwtQb7Yzvrqo7xBxMfx1V/cebYZ7nwMUHiTKJMAqhwn9QMCSw==
X-Received: by 2002:a17:906:5943:b0:953:4481:3305 with SMTP id g3-20020a170906594300b0095344813305mr4244181ejr.24.1681939155063;
        Wed, 19 Apr 2023 14:19:15 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:14 -0700 (PDT)
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
Subject: [PATCH 10/18] arm64: dts: qcom: sdm630: correct camss unit address
Date:   Wed, 19 Apr 2023 23:18:48 +0200
Message-Id: <20230419211856.79332-10-krzysztof.kozlowski@linaro.org>
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

  Warning (simple_bus_reg): /soc/camss@ca00000: simple-bus unit address format error, expected "ca00020"

Fixes: f3d5d3cc6971 ("arm64: dts: qcom: sdm630: Configure the camera subsystem")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index eaead2f7beb4..ab04903fa3ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1894,7 +1894,7 @@ pil-reloc@94c {
 			};
 		};
 
-		camss: camss@ca00000 {
+		camss: camss@ca00020 {
 			compatible = "qcom,sdm660-camss";
 			reg = <0x0ca00020 0x10>,
 			      <0x0ca30000 0x100>,
-- 
2.34.1

