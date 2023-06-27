Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9FF7400FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjF0QZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjF0QZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:25:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413E2D7D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:25:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3853529e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883102; x=1690475102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQgv+M2yvcOQU4FeOLMklrteeN9rCIkhqHWc6b1bMlw=;
        b=kDAt9Yy2OlLY6IWaIgh8Bk9OfVdK25RlsrNuwLLMtXXbG397TVa8a3J+BE2Rthx19v
         ohLNC/e5SJMBYIIx9zS2sFd/JWPzMOHoJq33iJVFsCwitbawpcYQxHixGIODdZjNyoBa
         ZzskP4FEFk2ilEFEAaixuyH1WQha+2ExAWd6CEgTK1Y9lQ77j2gYVGYys3ECidK9mrHk
         nvJj+DSJ2Zxm3GEMajsX81wBQieJ1d4ahWo9QmqJRXHZlDJLhMcjLkakBY8kA8KmjYwC
         VFI7sMK3I0eHGPSZYa3fQRAeFm0je1CrG0P0NoPv5kecifNBI9VjBaa7iVbD/OGDkCea
         ax8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883102; x=1690475102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQgv+M2yvcOQU4FeOLMklrteeN9rCIkhqHWc6b1bMlw=;
        b=l1ZIwz0sygoh41SNsYvrHZhlqFs6OZpryUv03iRavOalvbeQcxO347ULTerWYhsCus
         0AjF10hzT1kUK46NTKEQvm2SVV02shf1M6cySbyBU8tpYwTMFuRIskNeT8BIdg7UAZcG
         92SbU8JUaoqjn8Q9hhdPLcXRwF49iCwY29a6uKNVCBXAi+qiwo+ijsNBfvbXRevZI8Pu
         Jvj5gCXc9FZPpVqSQVXgXMwJy97SeL+0HQVa8HEq2LWoCGGANO3EQyYRtdPYZKau0qwo
         FbfkaGBT3IXGYp26qhRUskytrLJIchNxfF7OoVM0iYUAHIhtKxoPOMveSIQ/fqx4xbil
         W3Bg==
X-Gm-Message-State: AC+VfDwf0pnhE2Y2F28gowtjwuEMDSAF8rxKUakWpCDeoX380ccUiumK
        k/QqEtwyZvCDcUuQVAHpJQBjlw==
X-Google-Smtp-Source: ACHHUZ5yApBC4INNLgHvtxRRdunBBs9+0RduUnvVu4BrnfQlBcgFBMr/Gb/6J5qgvmBXvYAWuE6Fvw==
X-Received: by 2002:a05:6512:3c9e:b0:4fb:7be5:46b3 with SMTP id h30-20020a0565123c9e00b004fb7be546b3mr3902801lfv.55.1687883102401;
        Tue, 27 Jun 2023 09:25:02 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:25:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 18:24:26 +0200
Subject: [PATCH 10/11] dt-bindings: usb: dwc3: Allow just 1 interrupt for
 MSM8996
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-10-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=1056;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uv1qnNvLB8G/rnBdtPGJ5lEE8zxGk1cKOrp6LALI2o0=;
 b=CbB0RfIBkaHhb6P0sSoQoxoKLH0+Nroq3t9sxL+VfHWMFB3r3IxNmJNLNTbVFLUIegbeAFWQG
 oue2RQYT9w3Ch9MjHPlF80d7+kumlsNMxdRcFp2gCaZ4O5ae5p95yJx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8996, similarly to SDM660 has two DWC3 controllers: one for SS and
another one for HS operation. Allow just specifying the HS interrupt
in the latter case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index aca20aa8f504..beaeba47a150 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -394,7 +394,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8953-dwc3
-              - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
               - qcom,sm6115-dwc3
     then:
@@ -411,6 +410,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8996-dwc3
               - qcom,sdm660-dwc3
     then:
       properties:

-- 
2.41.0

