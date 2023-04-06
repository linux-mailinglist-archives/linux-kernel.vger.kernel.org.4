Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93416DA250
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjDFUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbjDFUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:08:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11998A51
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:07:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j1so1330967wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1/oUoOoXzFLIDuVwB7zkIe10EEDYrgRxMWetDqWBpE=;
        b=2RH0iODE5yV5snEGmF/NcTs3u43ObqS+wZHN/5GuwZHx8zSuEfdui2FTInRAsmsqTW
         8F9e9Gax53GN5DAQNCQOBZmZfaSa61/PGQG0WNRtsfQtEAENO+vEeFsqZvrx0ZlmDVEE
         1stXr44L7Z8mcLYEjEpgl4sWT+mJPusE76+iUaXK0oy1a5w1+1Mc6uveIWW4uX9YerwR
         LYCsZGunRrjYvPw6K8Wxd7qrjg/0LPJijjuJgeCay0sPltZQzWhC4sFpyGhf/P6Nnt9D
         0YScB/tIdeblYuHt4GaVzvCIQe25ub5IW7K7VaNf6BF18+okXEajwJEsNhpy9y9RLoXG
         3Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1/oUoOoXzFLIDuVwB7zkIe10EEDYrgRxMWetDqWBpE=;
        b=ABjXEdwhO7b37BCsoDj5K0zwUTCWnvvWEy8VyOo1FaN2ObRfZjSRJeC3SLtO60k9KE
         kZ+POw3T3fy5uuyFq1Gw5oFqg8c3dmMr5RlitlVYw1KVKtXWRsIT0yMoe87MXSXDIFv9
         svFMlvX/z2lGNy3cewr3HGptcZeWTSVTZk1xGNmFVRRYvMQqlt2IsV7Crh7zWTRJCQUY
         2xxwuuRd5MdAdl5exnuYKLHF7MtuPC98b3CSinjzpci6uD/1n91mfwjGNwk6YXnp7zG3
         femAOmodrZjIofUYoK3Pzc706PDJ4AFPuiLgv+lbJ9u7e2P5ssl3rIU4kVPqilHG013E
         AsPw==
X-Gm-Message-State: AAQBX9fiVFUCUShs/QyV72a1NjOfJSXXVuV5Nl8FjVhhoOJbp194gPVN
        FmGPmfPQTon+FXDiaQrfLe4IsA==
X-Google-Smtp-Source: AKy350ah/ZGZpM48sk760l0k+q6ScZHUAAvznXjFlCAGMoMiakB0ataAG2BNJdi0UfKg5ii+Q1kRlQ==
X-Received: by 2002:a5d:480b:0:b0:2d7:998c:5aee with SMTP id l11-20020a5d480b000000b002d7998c5aeemr7418614wrq.17.1680811673258;
        Thu, 06 Apr 2023 13:07:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/7] dt-bindings: iommu: arm,smmu: enable clocks for sa8775p
Date:   Thu,  6 Apr 2023 22:07:20 +0200
Message-Id: <20230406200723.552644-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406200723.552644-1-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The KGSL iommu will require the clocks property to be set. Enable it for
sa8775p in the bindings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..cb569ee4ca4b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -317,7 +317,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,sc7280-smmu-500
+            enum:
+              - qcom,sa8775p-smmu-500
+              - qcom,sc7280-smmu-500
     then:
       properties:
         clock-names:
@@ -375,7 +377,6 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
-              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.37.2

