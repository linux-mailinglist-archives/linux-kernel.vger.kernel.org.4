Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E06EB28F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjDUTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjDUTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:54:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56262702
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:54:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f3df30043so304107566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682106879; x=1684698879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jY03NBxyUa9cLfROecrZT0o/9BPg+IYZ/iTvApZ3yro=;
        b=BE73x8xcGtqcv0nHEeWt8szK5sPpDCCaXkLiXM/Q6w00lChqyz3fZWxOrNfVKwX0JH
         ZdoGYAgwYT3+YIiOLc8p43HStxIHjRhhgZ0kW8G4YMvSJs4CIYZ5y/48fjyOCWVfZAuw
         Y0nq4dwsIcil3pDObBKSKcXOEnbDI6KdLLHrtzKYSsAuwm2IXoJ1r44kSUBf2QaLYLsV
         cG+ET0jT4H6d5ly23tDC9kBy3cy2GePG7YoATviMZaBF6J1wtHLwebJbnMgJlOoxZxxb
         zyOzKRSZRoP7ETLEgwZGW0P6uDC/uw4JPtJCzMspoH2xqh1IrVwsv9ORC7w7+UHlga1U
         ZcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106879; x=1684698879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY03NBxyUa9cLfROecrZT0o/9BPg+IYZ/iTvApZ3yro=;
        b=e/fLEBrbMBI7tuCdL6Nt/W+GvMZ2GLghhqNXNnZq1WBZFxpWBqqhzozd35IGmG7qHg
         gCoz7RlNPsNWca/U5mlXBcA0wYE1dTx4CNj2mfbz+e3NQVVpfSWDSRjz0/2xvFqpc6r1
         PdhX4YnDeG5UVkdNoA18lnsmcCgUvvyhF5R3NMYk2c92RexrQls6tydVO7TOrCiVXbOR
         lkySsy48rnGevI8BK4fQPIMSEWlidKj71RX6n9n6IdIEeMISEyeiSGKsT2UeinZD4NXU
         qCUKwxXPDpxdzWBVoFFocxjpkJT579nsSuuzlNkENW2bcZuQMLTv3ul+Lqwlbxer4rEQ
         8aPQ==
X-Gm-Message-State: AAQBX9dRDf6WrEI6VwI7rW33BFW/299ntA2FuHWnPwEQTg2xp/tcSyCn
        LZYw+depOmPwIplR4u7vhabidu0ftNkp0oZfbhrjNA==
X-Google-Smtp-Source: AKy350Yt1I0JLLbUQ2GCAgnRhxkg0yJyOV0Y4wJIW+9cBj0SvDAYIdT+29JtI5dAC9DEWQ4oxtj8Cg==
X-Received: by 2002:a17:906:1843:b0:94f:6058:4983 with SMTP id w3-20020a170906184300b0094f60584983mr3713774eje.76.1682106879258;
        Fri, 21 Apr 2023 12:54:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id y6-20020aa7c246000000b005068eefc59dsm2148933edo.42.2023.04.21.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:54:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: qcom: msm8974: align WCNSS Bluetooth node name with bindings
Date:   Fri, 21 Apr 2023 21:54:37 +0200
Message-Id: <20230421195437.31513-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect WCNSS Bluetooth child to be named "bluetooth":

  remoteproc@fb204000: smd-edge:wcnss: 'bt' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 939449a0c695..58e144957c5d 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -746,7 +746,7 @@ wcnss {
 
 					qcom,mmio = <&pronto>;
 
-					bt {
+					bluetooth {
 						compatible = "qcom,wcnss-bt";
 					};
 
-- 
2.34.1

