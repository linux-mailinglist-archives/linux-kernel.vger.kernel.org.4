Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A093662D94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjAIRtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjAIRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:47:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA133B81
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:45:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t5so4595484wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuEV1y0ZHggJ2U74QXGSnhB+olrzqX7rJCa8R9xof/k=;
        b=1oK9bfmMzCrM5VhwOjGwAndfQGIzCwC3VXYACWKNETbxM5a7GL2wBMvu1a6Kg22aug
         SC5bKzhvhA8P+flr8W8deAx3rXBXEs6KS/ep2bLEoAepDeqs7Oyg+CFl1wXdT3KOxbKF
         8EUQpup92gBHy7k3g725NzS4w8LvmUZCCeFxOTGwYPqbNLxbtTFDo6TsCRfkFq+c0slf
         32XlDqP4ErJfQYUN8wHcsJnvYM3LEJ/NgzPjkm3Fb87t4kBx/p5zAaS7dihyuXnzI87N
         Qs+VpOGbRkObFPNYykq3a2chF3RwhO71q9J4WoIbH/0r/BvyaYTnVgGPO2HV/sWVp4HC
         86Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuEV1y0ZHggJ2U74QXGSnhB+olrzqX7rJCa8R9xof/k=;
        b=rr594fi/uB43/bWIIQQElc6FJVR/am0O1iL4ahHGi2fxo9nA4Mk493j/E7bPdNXanc
         6SWw6ilvPG2bdAiLX14P/SfSadhlwqiXbImcl8E5FFwC2GbpOULVwiuTEtVol1rm+wZJ
         TB/ra2QyrnxZeOf2SS/kvKk99rdn3irlKBorXahP6xRi8lSFZTlAISpZBLaCMa6lW9XC
         Tn8+EZB3LY+6/6msc9b0WoWsLS6Pat+uFTRQiNn6fpa+JT7xW8wrpiUZvd7LQn5JnjT1
         k5wWm9s5G6N5+xaKIJ3mSJPyEqcGWs5h+FoHr8C2nVaqNLTbQKnaxKFJwuUsARc2TqFG
         euCg==
X-Gm-Message-State: AFqh2koLouhCrJgbDsRf1dhkIm/l+OXiMmsMSwQRnKQREwHOKompL13N
        X+l+vAkqRcHD2SW351yE2sHvQg==
X-Google-Smtp-Source: AMrXdXtkbZtNiskZEH7F3cw97ksGs6B9HyI1mJEQEKT2aOFe7MwmAwO0MBsrBK9a7hOzqXaVBJeO4g==
X-Received: by 2002:a5d:5910:0:b0:27c:7c2a:f700 with SMTP id v16-20020a5d5910000000b0027c7c2af700mr28717178wrd.8.1673286352284;
        Mon, 09 Jan 2023 09:45:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 15/18] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
Date:   Mon,  9 Jan 2023 18:45:08 +0100
Message-Id: <20230109174511.1740856-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document the qcom,smmu-500 SMMU on SA8775P platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index b28c5c2b0ff2..95c5808456ea 100644
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
-- 
2.37.2

