Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF260662420
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjAILWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjAILWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:22:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FB183B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:22:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso3433445wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWFroMaGP/rBBuyi1aeBwg2KMoCRdSf/+bqqQ6WNoCs=;
        b=wIwMz4aEz7zu6ICEJoSATuPYt+Y6KnYkMNIhgFcwEyDPypmi0i4g510B6VV5bHfRDU
         +VN/xk6qJ4/z6MX+AfQncA3afAawQokugN/Fjg75abe9oZN4Z21fkTvaUqBKe0krEKUR
         ai2Hnfmlmul81tvKUn7LiFAn/QBSOjzqabffwKKbaIA5UXrO3IXwJ1q1h57TBLh0c2qv
         HvDEtCGodd56GOh1bcyJoExusqdIb6GG/jngXUZlEB0IPGAxedyyoNmCI9LZ8CFLTQiH
         6i4VYCXKUIf4wbeUdc60VMbShyq3+WOO4BViuf+//h8KGKQ0Ayj/ti+EhwaqzTbwnQvd
         zJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWFroMaGP/rBBuyi1aeBwg2KMoCRdSf/+bqqQ6WNoCs=;
        b=bNlzp1zZOOeU0TzkCZ24S3M0U0/RvaIhGdCq+KI1Ocr40yIdZemRtaJ/Nl1JvFmzO5
         rXmeFGhr4mRYK4q3eFWBM4afXE5KVfWUNtbt3Vh04E5N0ptlXJHEjY5GF+BBTJKe3ukt
         OjWQ9mZc7mpcIGPe9CvCWV09KPwQxY2YsqZ8P7J8VA+6LlF6fQl7lmueH30AA7rYVp+O
         tmNkxdSD63AGwlM/5JmnDgqijLvlSj7OuAKdbrjCotMZt1Jx1SVimyHSDZ/Lb+pmjENn
         QS+Kf227Uek2x/pVAavC46JnlAdOogl4RlZORJrBUgwq5QM2JgtaUCuXpC5Y56J/hMqr
         6Qpw==
X-Gm-Message-State: AFqh2kqcNkIM3xH/KotvPGi1Xk5bZhVqxPG9QFYBvViS4nf3q2hx/o0+
        jfm4Tgd89KftDNXyJ7MMRhiXPA==
X-Google-Smtp-Source: AMrXdXuRNDCmsI3QcjFwVPHm42JW+QKz2uF51ApN1JzaQ4roCnwTpfVnYNvc+fryESftFAC4JkKqEA==
X-Received: by 2002:a05:600c:4f11:b0:3d9:ee01:ae5b with SMTP id l17-20020a05600c4f1100b003d9ee01ae5bmr2930005wmq.12.1673263350532;
        Mon, 09 Jan 2023 03:22:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm17456986wms.15.2023.01.09.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:22:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8250: drop unused properties from tx-macro
Date:   Mon,  9 Jan 2023 12:22:21 +0100
Message-Id: <20230109112221.102473-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
References: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
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

Neither qcom,sm8250-lpass-tx-macro bindings nor the driver use
"clock-frequency" and address/size cells properties.

  sm8250-mtp.dtb: txmacro@3220000: Unevaluated properties are not allowed ('clock-frequency', '#address-cells', '#size-cells' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add tags.
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a58f51083715..ddd750591e8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2329,10 +2329,7 @@ txmacro: txmacro@3220000 {
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
 
 			#clock-cells = <0>;
-			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
-			#address-cells = <2>;
-			#size-cells = <2>;
 			#sound-dai-cells = <1>;
 		};
 
-- 
2.34.1

