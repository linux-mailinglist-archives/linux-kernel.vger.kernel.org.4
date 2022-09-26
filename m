Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18BE5E9B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiIZHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiIZHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE736DCF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s6so9480460lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=swAMWumsDo3YqkhHFZ0ggYaEkP49dlEnbQstPrv80sw=;
        b=NrUFoQAxSmBC+loWlEONVRFSFVQzbfn+ZvCH/O7cLIJ6E8sfm5fyIrETjo8xHxIPDS
         nTOYsrUcOGWYwAWjzhHhku29XxFNpzbyp6lmH3oI7xu8Cf+EnMcBmzjhLg1SxPmnV+A0
         X9O4Vsa04kCMx/IE55CMBHhMGxhpU8/k7F1xwK2Mf4ZWkRyYvusFi/26gjNYfbUZ+CqD
         VeFr3lIO076+3xoOipgG4I2Jod4jRk+aOCmMEahbn1xyQ1k+HRiJToWYqcfJv+EVvoT9
         B01tJ3pW7zgSSLDJ3k3GzFHJXgCtF//b2h1ra+sPQfjFjzYezjgsDOBnSosMzWueXlWh
         jBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=swAMWumsDo3YqkhHFZ0ggYaEkP49dlEnbQstPrv80sw=;
        b=wTyvyLI4N9PjBpvmGGpr7J5FruNTJb4RxzdIGbjtSCXTBw7SRwPAfCHUf96BVerWvp
         VPwpJJ/oeE6pH+t40S3JQKGt+iSSzZMxWNvG4I3YchAJkAG7AzNdpdEulIyVMi2dJH9p
         6eIGwCvzVQidFr/FtLf3jVLwCHSkriZA0Em8XduNbkXey4ykaSdNB0HYnikFvUg7Wa9Q
         ssHA+opV7qGpiMRbhKty0y7pUsvg5du/aA2Ha5ucjoXB7lreoUvN8FDssFr2hGiYLQ/W
         1wdFbZugoNDIkXF52jMFlFfOit8xXFLV/KIekZsdnbZMwx1BrahHebVRRQOKamM1FRCb
         tDmQ==
X-Gm-Message-State: ACrzQf0DJwid4oCedpSdMAkiKTdcG6y982TiIl+m/OPR2DUBYJKS3o/H
        g3LWECbybxPnZlCs13r8SbhYsg==
X-Google-Smtp-Source: AMsMyM7dGeiaQaKniUDUvjImOzWrlqZh4Hj0uvdt/CaUTWWKGLblN1aVcBEyva5zGkdgBBJvXCiZzw==
X-Received: by 2002:a05:6512:3e1e:b0:499:34:e8a7 with SMTP id i30-20020a0565123e1e00b004990034e8a7mr7952844lfv.655.1664178315376;
        Mon, 26 Sep 2022 00:45:15 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 26/33] dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
Date:   Mon, 26 Sep 2022 09:44:08 +0200
Message-Id: <20220926074415.53100-27-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference common Qualcomm TLMM pin controller schema, to bring other
regular schemas and additional checks, like function required only for
GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 5324b61eb4f7..2a23f413c8c2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -119,7 +119,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 required:
   - compatible
-- 
2.34.1

