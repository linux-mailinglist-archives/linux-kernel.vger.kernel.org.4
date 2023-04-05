Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB96D86B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjDETTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjDETTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:19:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D84ECA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:19:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so38310007pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680722357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt7M02oqu6KTx155BRHBlS3z+3ibHCaV+H3c4NDslQk=;
        b=svFkAQDPQ6lQfJOy3eX2VKdwwi9AG2pmGyTJt3q8YsxggmR0MxczaTHGDaotjex1ZO
         RbbVpQVur6VgIgNdFu3VJUYmc+HTnw1RydgsvixTJ93qXriZVDZiCgeqWl+6zxtYcNQ1
         AfiKpiiQmnAY5Ybr8Ay9efQIJus6Hvc/k2XdGj9AX96M1pLdGkkQXCavOu9+DSHgoDSk
         3e0l5f2gEDkd4y9vUi+9pzVa2/GkbFjAcxLO30sgfV9VCJ2j59VBt7wctYuEbQmrWtZ2
         suWIEjXI2ESpngeQEPxMaINxc3KjO8M4YOJIvKPxm45NNQCSU6SokjZPJULyOTyYyhEK
         bAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt7M02oqu6KTx155BRHBlS3z+3ibHCaV+H3c4NDslQk=;
        b=vT0o+ADhjMf6fgO7uVHRyv7u5v4l+XoV2u386u7JP74TM/wdi0f0lXQnrBnxvTZ/zi
         I3+i8qnVEbmnSADf9610wFmXNghSiE1cOag56JKqnbA3Fpl7U9ownTbX9Zhm6SxJchMk
         zZGvjo0n4WWiGu1R2SWHldrcyAd6w+5LZ3trqUiWietN9dk/t2aMXSoQTy7aZIgx5Fse
         Ih1y2OB76WtGeqMA5fseqk1X4QbYdG9IVSTIjYOfGmkbpWg5Bi221AeT2zp4l0AXueF3
         TwmMkPKRK1HDdpXsoFaJ+V8WGDwHMbBbxWS6UZf1p87TfOPLon6LSVA05fEVlO4f4Rmq
         llFw==
X-Gm-Message-State: AAQBX9d91LxutIfNvYAuxDrDUSv4VbEiDU9Ykpj8IDz5ZTrFNwxB0pE6
        6pOI1Uc/qzfffhAL/vGsnYG2wQ==
X-Google-Smtp-Source: AKy350b5JJdiYtWrN/RCf8v35EVXFdkifQOPo8juFYtwRgi6PZ7VfAaOzPfZ1PQwnNrV2zwYHiig1A==
X-Received: by 2002:a17:902:e18c:b0:19d:297:f30b with SMTP id y12-20020a170902e18c00b0019d0297f30bmr6156444pla.19.1680722356788;
        Wed, 05 Apr 2023 12:19:16 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001a1d7329235sm10478097plr.234.2023.04.05.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:19:16 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v5 1/2] dt-bindings: phy: qcom,qmp-usb: Fix phy subnode for SM6115 & QCM2290 USB3 PHY
Date:   Thu,  6 Apr 2023 00:46:32 +0530
Message-Id: <20230405191633.1864671-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405191633.1864671-1-bhupesh.sharma@linaro.org>
References: <20230405191633.1864671-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB3 SS (QMP) PHY found on Qualcomm SM6115 & QCM2290 SoCs is
similar to sm8150 QMP PHY (which is named as 'usb_1_qmpphy' in
sm8150 dtsi file, see [1]) in the sense that the phy subnode supports
6 regs, namely TX lane 1, RX lane 1, PCS, TX lane 2, RX lane 2 and
PCS_MISC.

Update the dt-bindings document to reflect the same.

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/sm8150.dtsi#n3394

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
index e81a38281f8c..1575dc70bcf2 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
@@ -276,7 +276,9 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcm2290-qmp-usb3-phy
               - qcom,sdm845-qmp-usb3-phy
+              - qcom,sm6115-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-phy
               - qcom,sm8350-qmp-usb3-phy
               - qcom,sm8450-qmp-usb3-phy
@@ -318,12 +320,10 @@ allOf:
             enum:
               - qcom,ipq6018-qmp-usb3-phy
               - qcom,ipq8074-qmp-usb3-phy
-              - qcom,qcm2290-qmp-usb3-phy
               - qcom,sc7180-qmp-usb3-phy
               - qcom,sc8180x-qmp-usb3-phy
               - qcom,sdx55-qmp-usb3-uni-phy
               - qcom,sdx65-qmp-usb3-uni-phy
-              - qcom,sm6115-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-phy
     then:
-- 
2.38.1

