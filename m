Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1276173A56F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjFVP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFVP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:56:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2527A199F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:56:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f867700f36so7874307e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687449378; x=1690041378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZz1MWlumgnM+wp0QVxppezVNb3Fgjy59UxeRVaXANg=;
        b=AwB2HaENuJfOEm7Alo7cv/DJb+7nWVsLnFkWeNpkUJ0qfFMEAGLEwKkBIw8CBUsqh5
         2y8jQ/gSlNbmKV+2Ua1HNgZwpXtYV9k9dKiMsbC8kdu4bnJm03ESeVGgBLVMiNpzVAqj
         hSw1hjtcJ1qGHzG5BGwhIK3cz6XS8s9i9Elg1aHoDL3bU2mDM2tuVtYhta/SryjjiDNr
         A1yHMui6vSryO9y8HKCbw9JlOatShHc/oxkCrXbG74gm8AkhbPXAwrvVjGGwb4GCV29E
         kL8279XUjoX+tOkIe4xC4YFPW0WpfYiEn4/OLJYiqdfSReKZQchT7oTZoi+71VVusB42
         diUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687449378; x=1690041378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZz1MWlumgnM+wp0QVxppezVNb3Fgjy59UxeRVaXANg=;
        b=h3gqN5RkDoO5KsEW3EWKkxsVBfPcEV8cMqPoprQYtqvfSPAuyoj8F4rxmBp0dZCkk1
         e1h1vcjCOs3nwcFk/FEFQQlU/zSJjS25b72Kd7lb6ofM5VsiBQNutm/GVSMlektHumDH
         wDiuIo633Ta9WQ9bIywrjTrJyOfX35Mf/CJcuah+eA7jdYH1vDJnSWzPW7T//4k+f6xh
         zZRTq3Wqqe0FqVddXIpNEiDDlIGIIiGW5eVhD9pkCwY3yfgPEnT2ifMI7Boetkpl2cCC
         LWDyyXdNCOSoYQMdclpMTAUkIAGNM1r4Erttoha8GOU12DVD0rJXya8/ZkQC5pjhu5Jq
         Lf9g==
X-Gm-Message-State: AC+VfDxQqz5oJQo/bFnvPP1Il7MefDCWKFVPuz2xib5aDCNX5I5jYSZj
        6cK4u63erzjLLg09ltwDewupVw==
X-Google-Smtp-Source: ACHHUZ4hBVeDcoulULfDaMl1yIeXGI22tR3XwUEz6R+XRPxoedJos8Jil8c3Qan5JZ17LOEOg+v0wg==
X-Received: by 2002:a05:6512:b94:b0:4f9:5ff6:c06a with SMTP id b20-20020a0565120b9400b004f95ff6c06amr3246849lfv.67.1687449378499;
        Thu, 22 Jun 2023 08:56:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id h25-20020ac25979000000b004f8747e519bsm1146876lfp.125.2023.06.22.08.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:56:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 17:56:15 +0200
Subject: [PATCH 1/2] dt-bindings: firmware: qcom,scm: Allow interconnect on
 SC8280XP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8280scmicc-v1-1-6ef318919ea5@linaro.org>
References: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
In-Reply-To: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687449375; l=804;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+UfpFZ/wJIEsyc9bAr5nQcF5M174YsTVUpB1F+LOz78=;
 b=AAB3uEjnIq3Yp4vPg9MT0jrLckhsxK5SY3wooS5vMPCEk/YX6VcbVC9j6NPknxySEaG0jWp5p
 /Ie22N51PNTDvIjLrVdZLOv/ze2vEzwG34HXjx99BWl5/eNdu5gHkFo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like all other Qualcomm SoCs, SC8280XP SCM should be fed an
interconnect path. Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 09073e1d88ff..42d064be753b 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -174,6 +174,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-qdu1000
+                - qcom,scm-sc8280xp
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550
     then:

-- 
2.41.0

