Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7617419B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjF1UgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjF1Ufd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9493E2113
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so1857768e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687984529; x=1690576529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShOVFQ7RXIUW1rLCJcISdnIxitPcQmG9jiBKht2mxDw=;
        b=fNvzPeTrPGUOqRRGumNpPGd+754lAgnO/eYgAcwbEajTsV4Yo9vtXgYRlrfMy4vOU+
         4wxSxfNS3KuLFWtJHAPSlMoS4+RZZt+tE/T7mhO1l8d0SD4nlBSZwIL86qzm7eaLNzfO
         ciYaMhg86FJ3nK+zMXRGDwK2PxCeJ8E1UfJpReNszWZN6Bxtv0yeOg0V+RqzK1Zg/tXj
         RWglgcVmVxoRURGvKVGscpioN2Bklr19WjycEAAX9VmQ4wkhSgxfbTA6UDjpbrSytcJH
         /vPYU3GcNZ+ytrB9EEAuW5M+KZLsGRJSRe1w7uK3lWpIPi4i0mXWrKi2S0ItZBWaJ/o+
         wBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984529; x=1690576529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShOVFQ7RXIUW1rLCJcISdnIxitPcQmG9jiBKht2mxDw=;
        b=XYyHIGTADhNGBF5zizhCMz5Tr2aaT+CLDRrlHUEsGU8RMs0BglAlZ+2lebAQz3TcH3
         se8b2CNvhWkgomkKOm6ftemcOavKUpiqWG+K7ZNVTQeY93ko1yo6+p7pON76KvtY2Tr8
         93ZA6x0GR6ivUBUnpqUrc3uiZqDcNYOwSer2MOOF189KoPuTcp9P53agA0Xl5yE7rmKb
         KY/RapCzwKvg968/qhL9PpINc/X8fzNkSvcYhraTM3ZPg5L/sfW3L7w/k2KdV77829hk
         wXr1QV4y+aQEGNn2KlV03VtsBqDjVKFXK25IxbyUFww+4Hf4+ir6xFWQbiMqHlvpzFGW
         Rh8Q==
X-Gm-Message-State: AC+VfDzkUNjUn0f0sqi//KJE64QdpRUY+Y+S6uEEBgqAEYriyrpbNN/6
        6my//2vTGVZ1jnsIXyfisV87yQ==
X-Google-Smtp-Source: ACHHUZ4dLQxKfpMvztzQNRy1edX0OC2T290+P4zJDP5A2ev5l2RQiBfE3/TQZlBoIovP20Zhyqtz9w==
X-Received: by 2002:a05:6512:308a:b0:4f8:6e1a:f3ac with SMTP id z10-20020a056512308a00b004f86e1af3acmr818922lfd.28.1687984528942;
        Wed, 28 Jun 2023 13:35:28 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512015900b004fb86c89fa1sm753363lfo.135.2023.06.28.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:35:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 22:35:02 +0200
Subject: [PATCH 02/14] dt-bindings: display/msm/gmu: Allow passing QMP
 handle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v1-2-a7f4496e0c12@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687984524; l=1089;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Zi8pu5SYXNW6tkMGEBTZIqc+2Rypg7fUU6hDiwoM2xw=;
 b=uC3bn2D19iI0waNc/bVHfDh6gUGVjhjvACMWf6s7R7DndLYPdT5QGdN5du2GLi5C+sV5+aWWM
 XXKWRLPMxBMDrz+ghSG6R4/ez/yar5S7D68HsS/BTPVOnOUHc83YUEZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting the GMU, the QMP mailbox should be pinged about some tunables
(e.g. adaptive clock distribution state). To achieve that, a reference to
it is necessary. Allow it and require it with A730.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 20ddb89a4500..9e6c4e0ab071 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -64,6 +64,10 @@ properties:
   iommus:
     maxItems: 1
 
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the QMP mailbox
+
   operating-points-v2: true
 
   opp-table:
@@ -251,6 +255,9 @@ allOf:
             - const: hub
             - const: demet
 
+      required:
+        - qcom,qmp
+
   - if:
       properties:
         compatible:

-- 
2.41.0

