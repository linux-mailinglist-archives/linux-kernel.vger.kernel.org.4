Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331E65B15A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjABLmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjABLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:42:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911DE86
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:42:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so41247382lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0DGttLpYO77MEtgPKeJIho/3p0G8MvI4IyRdGCB7vI=;
        b=zqwcpag510R0I1O97o6VuVZ7eDegAgifXOQ6W3qLAzENOo8o5qW4rN02gCLAL6dCsu
         2up8OZSLUB52nq77A6YT/Cn8+3bwlzh65dK0BuXJ/yf9BbkmocISqvy3/YFOz5PN0ms3
         LNBJAao0LkVySQAdAqQTKxYPoz8Bti1VKoKKN691D6hEVgX5JHjhncSMwWmYt41eueFp
         Bkr+iuNDg1KfXAjvSJem4BQmHAiTMKQEMofOWgGFfvukDZKK2efqVXZcDzHPq1C+bjIC
         9ou629mojNGDu9SLn1cOVK3U5kv/bx2gUXOSMvBHnPfs6F385ErLc81fHO7dR8ezmH+3
         16ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0DGttLpYO77MEtgPKeJIho/3p0G8MvI4IyRdGCB7vI=;
        b=UqfCP29xn2W6mkQ6Mk3ZLqlIACs1puoc4VLN06u/1aRqpywmv1pYAVqwuu8rWSZNC8
         eCz/YyNXNtuVFmQoiUwtl/Joud3ghDEgKTX43DXqKNhWPgvn6bARx69hq52s+/b8mPr6
         Uglbfcun5DFLde/mE7OtGbNcHIzqj1P1a27Dwg3v3wTsAQqb/k0sZJmit6gqSYHfp+yL
         6Xy4noOi4krmaLNSAZQ+wpDxBkEV4Ed0GARZHrc3RPm+OGNpfEvaODkCkQCji5UFU9RB
         Om7B5Hz9LqjcBAEcgjimtC1dmg3HuOhuoTbinJYBPMOC4ApFvIMibgK+95ka8/YfVe3F
         CxVw==
X-Gm-Message-State: AFqh2kqMslgeTa6MJaedvgePB6+hngs4VVdGTIkwxGwEPXdTQ1FLgypX
        pOljR/bDfood/R/P7bq3YCFqXw==
X-Google-Smtp-Source: AMrXdXvQ4GlhI7AwL8ZBSeQBpJlW54TbgMV0HW6QzbLTFQGu4if90hQWSqplHqqN7UVJYKnBOJGYzQ==
X-Received: by 2002:a05:6512:3f19:b0:4cb:780:813a with SMTP id y25-20020a0565123f1900b004cb0780813amr8558425lfa.13.1672659724660;
        Mon, 02 Jan 2023 03:42:04 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b0048a8c907fe9sm4356397lfi.167.2023.01.02.03.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 03:42:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] arm64: dts: qcom: sm8250-mtp: Use proper WSA881x shutdown GPIO polarity
Date:   Mon,  2 Jan 2023 12:41:51 +0100
Message-Id: <20230102114152.297305-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
References: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
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

The WSA881x shutdown GPIO is active low (SD_N), but Linux driver assumed
DTS always comes with active high.  Since Linux drivers were updated to
handle proper flag, correct the DTS.

The change is not backwards compatible with older Linux kernel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 3ed8c84e25b8..f3669c1a311e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -760,7 +760,7 @@ &swr0 {
 	left_spkr: speaker@0,3 {
 		compatible = "sdw10217211000";
 		reg = <0 3>;
-		powerdown-gpios = <&tlmm 26 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
 		#thermal-sensor-cells = <0>;
 		sound-name-prefix = "SpkrLeft";
 		#sound-dai-cells = <0>;
@@ -769,7 +769,7 @@ left_spkr: speaker@0,3 {
 	right_spkr: speaker@0,4 {
 		compatible = "sdw10217211000";
 		reg = <0 4>;
-		powerdown-gpios = <&tlmm 127 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&tlmm 127 GPIO_ACTIVE_LOW>;
 		#thermal-sensor-cells = <0>;
 		sound-name-prefix = "SpkrRight";
 		#sound-dai-cells = <0>;
-- 
2.34.1

