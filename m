Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0724B5FB952
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJKR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJKR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:26:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72612356EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id jr1so668314qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEMOUzHy3Lbue0VlcEhhmI28Nc+eV4/vRjIaKRvM/Ws=;
        b=xmpni9XSuAScJVkleBMH3Db3GyJMq4x94lPZnwnz6H+nPbAqWtL/oFE3aC5T2TkbBH
         LJHc81EY9TrnJX3X4TtC0eXvTKTx3CeKzwHp0f+PnNc7Qqs+UuPnOXtXidBiK6XFAQk4
         zQdP7xn8Ip40eAQKHuJD0kTlbnOkfoMDGkBzkPHlP2fbxk/wxTitwOVM/cSEShdOvD1L
         Eau9R29dzWbOBYAbz5mMHUyj7VZB8svbycq2Du05bKEySRnrh6X4kZ94W8El7/otRv3N
         poR8QRFwkvcI6IhLpziPulz695zpq9z3nNcRO8bHDPiEsqS0+5P1ewa73R5n9HBn/brl
         3jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEMOUzHy3Lbue0VlcEhhmI28Nc+eV4/vRjIaKRvM/Ws=;
        b=A8p8V2btZUWWcQVnk2QYON2NWt+u3VeHhUn8nJ8jRV+d7RDTMIhRjVwL5vdrha2o7i
         wW5g54gA9/EM6RSQIZzrce0Gka3XV/qME/UKTt4Rfot8I68rp5U+6ZWwkQTRq1yynlGr
         x+slDnTba1cybPGRXeufzOnXI/pFXCTgbTrlIqoDBY8oaMEOYlG+3iEUWopI7MLubcNL
         1Uw2ziRVb/HCeShpDLUJe7FCMFsGnozIzQXrjQ+QEd6giGQLThI+vHFl87t5/J5W5Uep
         EYovvtzLMWLJqY/r/IydnNx+5wPoMaBOcYZGsbFQlVRt17zNM4cgGzlXVd61qW144Tzg
         /7PA==
X-Gm-Message-State: ACrzQf3zV6vyAO/A7FUZw+KhWLLRL+0oNyQXosRHKHeeOk7svsZusAk/
        Xll1ko3444OkFi5G5N0hldmBOJiNRTvpjw==
X-Google-Smtp-Source: AMsMyM4iQ5YfgkUf/D7DuHvG0eC6cKqTsvda8W3VRgRsqfeN/Zq+ppk1z2HbLSa/mToiyCH1L3YdLQ==
X-Received: by 2002:ac8:594b:0:b0:35c:d0b7:e2f9 with SMTP id 11-20020ac8594b000000b0035cd0b7e2f9mr20177238qtz.483.1665509180499;
        Tue, 11 Oct 2022 10:26:20 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 10/34] dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
Date:   Tue, 11 Oct 2022 13:23:34 -0400
Message-Id: <20221011172358.69043-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
index 94af82ee5967..894e59caa735 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
@@ -53,6 +53,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -110,16 +111,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-7])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

