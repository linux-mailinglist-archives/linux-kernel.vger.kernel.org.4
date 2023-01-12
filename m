Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B006679F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjALP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjALPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:55:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540BD37503
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:46:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d17so18509173wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3a+da2Ixkv3+UWjaOBcx9XincgA8EoIsPdzWIEP5Xs=;
        b=B0tfqo7jE7yLMGnt5k4IEh2fyztJBU3NkVI59EUvtzIcERfsNgeQHWmCULubiMKtE1
         hOoJnm60UmqeKtlTjbKOTGTaIVcddcMTTWoF6BAZQP5tK4a+NN7hClja3XJ8RyF7/jOy
         Xp+M8AqvqGdiLHf+vZDKpA3NEUP9r0vhTR2ua1nw7Rdk5bKRT+dowPsW1j8SCfbQT8LL
         k00MDKY+H0NZKnS8OBcTen8OcPUC0wPkh+z/6lQZ16Xxk0aYRqKQa1jr4zA4pBO8+ykL
         iT7E2nt5D2eqX8eAaT3puGVRQVsYuR2TfJRmwxiNhTxb1mDwrdtdxqTGQbIBcpHeZj6e
         Sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3a+da2Ixkv3+UWjaOBcx9XincgA8EoIsPdzWIEP5Xs=;
        b=LttmLESUCvw35636EBQRXM7Htoww+Z+KHZOTgE1l4mg/MvQbihQ+YAxQz1htCpKklW
         S04PNJpUDalVdC9hOwoJek8jJeYUw7kyuGXu62zioy0IO+ULlLJo//LEwGZw0JHWnjJ+
         8v+DHuFvbklfZ7Qr/YDtlW9it1/Cau2Y2sfTNuEnjUKVF43+9O2wWdOzeUwwoK5RMHf8
         tgklvFNheUlLIlTPr2G9vZmuQCHCp0OcWOInyUQdV/GbEX1GO6nFz31cHxk36geFNqEV
         +ClB0Gl+RjDXkKUs3yfuq+jbU/NqJrFTLCAHXjvZo+442X5TAvgZeJE3eirFCCn6+IiD
         bbdQ==
X-Gm-Message-State: AFqh2kpyhWOg6TRo9e7IFR4VdSlMVuEGErbh2WHi1tb1RqxQ+m2Og3QR
        3v3XhA5dTu2E5j+eAm/r6umQ7A==
X-Google-Smtp-Source: AMrXdXvAVKr/5nv/RC9zvUl2zmh1IkA2ZjzZBFcajvmT94k7AqO7muhveMm8oBLXyFRuLTPbR/geJw==
X-Received: by 2002:a5d:5405:0:b0:284:8a24:59e6 with SMTP id g5-20020a5d5405000000b002848a2459e6mr35819328wrv.3.1673538363871;
        Thu, 12 Jan 2023 07:46:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d8:37a9:b9c7:ec8a])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003d9fb04f658sm8223555wmc.4.2023.01.12.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:46:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
Date:   Thu, 12 Jan 2023 16:45:54 +0100
Message-Id: <20230112154554.442808-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document the qcom,smmu-500 SMMU on SA8775P platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
- rebase on top of Krzysztof's work and add the compatible to the
  "clock disallow" list

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 124253e84c02..ea9205706b7c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -36,6 +36,7 @@ properties:
           - enum:
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
@@ -326,6 +327,7 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.37.2

