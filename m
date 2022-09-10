Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64185B457A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIJJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIJJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:14:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B1167DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a8so6661584lff.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hnmXzvjIzn/KGbEWap9g0ZuckOp+5W2/ARJz1gMjBQE=;
        b=qapQdR93gzt4lPJoXQlVruTuS+4kJX83gbfxa2T5nD2Wwx+Ht6d9bHZvJYPv59WtFM
         c2a7f8tUYS+v1Tyu8CRrtcSu7J2enNj2vpqPnIavoPOOICP8lLxf1FyZLyO6kgEfTccg
         Q/MzgXgDP0KeB8p5obXwWx4qFLj9Jti3OII1xbZnBsL7JCWuzPEwElV2Hm5+z62u1MzN
         hywbl5tCEhDJE7gXzf+0SWkrLqQEHtTeLBYnwgqdRC0wLVLkCga7E1M49bY+XIYlluTK
         i6+lZt8S+FdI3eF7opOWe7OolgIUMIQ73dnW/GTQz7lsQ0XjgvqPEFjTyKAzRTMQj1P3
         LYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hnmXzvjIzn/KGbEWap9g0ZuckOp+5W2/ARJz1gMjBQE=;
        b=F4R59BmPHlw9omG1iFDbDymdvI3WSsH/oadELbuPM1skX1iuJ3qInAnRuw4OwMse3q
         Sx66fmaa4pasWznY9h24VQ2/zar9M/UktFx2RJRMFP6qGI3M9w5xgUt6VpV61L65AbLB
         fBunP0Gzsxl8fUrV8V2MpJtx4b1xLABHmHJhDVOXDILdhdq4k3pPgNVTVOHMkjQ4F536
         wsgBeb4fQ8EJmxQ0dOYcCWVj4kuf13JkwtFpfNScVMU+dKjbw6nZy4YN2oiC9AXN/6C8
         iP0C12ZO81RPp7ea/WYJr+TvU2P0mK76FDFHnu3n5cQeqLxp5nAFYcfMxQcioV9qeN0P
         ZfhA==
X-Gm-Message-State: ACgBeo1imCx+zWuVSZ833pPYDY9ZigcP4VexmOJ+6LBT3QJT77QaAkTj
        AaGAl0eVapo2yhnU8O+ZmZBn1A==
X-Google-Smtp-Source: AA6agR4l2NZ8pJM/3UHjTEf3fdyvalMImuyUUBO6xqTNHaSx5tAYbye1qsPA1VZwrA2gqRLq7RNayg==
X-Received: by 2002:a05:6512:b12:b0:492:daa9:75ea with SMTP id w18-20020a0565120b1200b00492daa975eamr6415903lfu.297.1662801281512;
        Sat, 10 Sep 2022 02:14:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:41 -0700 (PDT)
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
Subject: [PATCH v4 04/15] arm64: dts: qcom: msm8996: fix APR services nodes
Date:   Sat, 10 Sep 2022 11:14:17 +0200
Message-Id: <20220910091428.50418-5-krzysztof.kozlowski@linaro.org>
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

DT schema expects APR services node names to be "service" and to have an
unit address (as it has a "reg" property):

  qcom/msm8996-xiaomi-gemini.dtb: apr: 'power-domains', 'q6adm', 'q6afe', 'q6asm', 'qcom,smd-channels' do not match any of the regexes: '^service@[1-9a-d]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1e6b70582866..abc17c905bfe 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3389,12 +3389,12 @@ apr {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					q6core {
+					service@3 {
 						reg = <APR_SVC_ADSP_CORE>;
 						compatible = "qcom,q6core";
 					};
 
-					q6afe: q6afe {
+					q6afe: service@4 {
 						compatible = "qcom,q6afe";
 						reg = <APR_SVC_AFE>;
 						q6afedai: dais {
@@ -3408,7 +3408,7 @@ hdmi@1 {
 						};
 					};
 
-					q6asm: q6asm {
+					q6asm: service@7 {
 						compatible = "qcom,q6asm";
 						reg = <APR_SVC_ASM>;
 						q6asmdai: dais {
@@ -3420,7 +3420,7 @@ q6asmdai: dais {
 						};
 					};
 
-					q6adm: q6adm {
+					q6adm: service@8 {
 						compatible = "qcom,q6adm";
 						reg = <APR_SVC_ADM>;
 						q6routing: routing {
-- 
2.34.1

