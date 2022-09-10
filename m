Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4910B5B4575
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIJJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIJJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:14:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030E1B793
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn9so4757433ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=751surAPxPI7nKu0MMgW0W0B94zgA9MhkjYrnO7nGnI=;
        b=zQRFMq36RqrYYs98jR8t72WidrCl3iJiSCBHNxN1ZJYx6QbQ7WquWi5WgsXWdGpNQy
         BlBNnj+3iSehQi7ZJmYT4tPs+Ja5LD9i0dqMHzOOxOFynFINL8lBvwKfU5Wown/yVG4y
         JrrTJFZtdGHxd2PuORiccTfHbS7wy7/3WSwyac7hwLY0cNT6OUoZ+VxXPaUGbjOaOHmJ
         wAmoOBTO0t9qxZIqQjh3VN4Mhg7CsSf7+CCK2y3tZxTKhnA9UGCWnMdbiZlPh0avt/3z
         vwp7UdP4V2n2hH852lhzDSwg4YErw59prYf9+Hi9ejQT6I2OM47ZUJP8uI26lhwMXQfi
         3eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=751surAPxPI7nKu0MMgW0W0B94zgA9MhkjYrnO7nGnI=;
        b=rHFfO4sVyTWUuAIZ3sX+Xc/ADbc+TVmP7+omNIrYyX6f0U0vcNQ8CxDdF0O/OwgzJ7
         x8za9luGTkJT/QTPp1NJT9taKVbiShubqvm6T7qA1IoXP4s8DnLPE8sKTxaWD8aiHzYh
         A6hFza1ubMbaJqjSiZ6j0A6HF1ZE1Gtqc43EjdvyDXon1+8S8E8PmMzfMxCapwZsKbRj
         HWj1si95MdgWwdsr9m+GpYiDD3eNIDRhbeBzW6t8sRKYysvZ1+IQrJ/TsFkpPf0JUH5l
         znq2uxcLE46g+zZWR26tFpkIiegQ/Im7kmuZaubwNZdfG0ItLR+6ScvAR3nGPKgDvSGy
         4YQA==
X-Gm-Message-State: ACgBeo37dvG7szpRMZP6QvYBAEitz9irps+/eFYyvd5NBkcByQMVkerN
        osIT507Gi3UZvl7stiBHwLmSfA==
X-Google-Smtp-Source: AA6agR4U63/GsFPvu4Z2mdmgG77xs6DtfoVI+BdZsBLB64vmdeJ0oNDloNGvhtPn6XYNIDr7gAPedg==
X-Received: by 2002:a2e:a884:0:b0:25d:ea06:6a3f with SMTP id m4-20020a2ea884000000b0025dea066a3fmr4914365ljq.335.1662801280403;
        Sat, 10 Sep 2022 02:14:40 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/15] arm64: dts: qcom: sm8250: align APR services node names with dtschema
Date:   Sat, 10 Sep 2022 11:14:16 +0200
Message-Id: <20220910091428.50418-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects APR services node names to be "service":

  qcom/sm8250-sony-xperia-edo-pdx203.dtb: remoteproc@17300000: glink-edge:apr:service@7: 'dais' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index cf5d65940174..84b4b8e40e7f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4782,13 +4782,13 @@ apr {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					apr-service@3 {
+					service@3 {
 						reg = <APR_SVC_ADSP_CORE>;
 						compatible = "qcom,q6core";
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
 					};
 
-					q6afe: apr-service@4 {
+					q6afe: service@4 {
 						compatible = "qcom,q6afe";
 						reg = <APR_SVC_AFE>;
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
@@ -4805,7 +4805,7 @@ q6afecc: cc {
 						};
 					};
 
-					q6asm: apr-service@7 {
+					q6asm: service@7 {
 						compatible = "qcom,q6asm";
 						reg = <APR_SVC_ASM>;
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
@@ -4818,7 +4818,7 @@ q6asmdai: dais {
 						};
 					};
 
-					q6adm: apr-service@8 {
+					q6adm: service@8 {
 						compatible = "qcom,q6adm";
 						reg = <APR_SVC_ADM>;
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-- 
2.34.1

