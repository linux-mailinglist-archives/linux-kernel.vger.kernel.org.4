Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77C5677C45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjAWNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAWNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:19:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1C13DFC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:19:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z31so5631508pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vf7HzZ2FzkJA9LCsnYBUI4BkmATEeS0RRCfbvDc3nIY=;
        b=Hp0RYxiU9r6fKa4c9nXygqj5qT8I3r2Z5/IE/RMPEZb59UGqle4JKAuU+bD6Ab9P2/
         sz+3Mw9p3ZjnSTBAdCVrNfyI3LQ/2hAbo23McNNiCiJPQjILquC25IUCFCddi6e27LsW
         cyuGLDyufrMzu1Pio0MqG3tReKCmZ0hfEL3AZe3LcnRhabOwP7SKKTuEIxc3McbaqnaP
         /67XuYyLh2p0tAak8lTLKR4cXDXxEvRXcEQ5zpuaK9teJE23vye1O0l6idOn/h2CXByo
         9YlCHx6sfbrslO9s2v9xSlDcidjCsKqMaIm6zKQgvl37g4CijAnUms0CHSK2j+0pbJaF
         CwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf7HzZ2FzkJA9LCsnYBUI4BkmATEeS0RRCfbvDc3nIY=;
        b=Z/EQuqbsv44sXmFfYDEMfjydCGNc8V1IqzTK7i/9rkizmf9881ukoLz9vnFtLiF8TG
         fkuWBr8BjJGnSsy/mPF0W/ptE6q3Dro/4a4HNaW3JkjvoASt9AIqdZ3pnLfj2v8tEoUf
         qXTVJiKAZ8/0wreUxIBuM/3SHVBP9J3ZQFDxGNQiofZrP/Uk7I447Q5OYmlPeQHmBSsr
         IKvm+mUpTPQtYNun/sKDRUCSlSqLE8R1HnjGTgu/gfanL9D4o/nVoyDHHabQtOGcCOlG
         SjZn563Smc4gGYTYWuPJNL04aezJ76rSMCYpdEObWXSNrjlSq3MOCy5RTaGAJA+2DUph
         MenA==
X-Gm-Message-State: AFqh2kodfw5pLYxdl/P22rRjJHPZoNGfh/GAwxIQsPKL1kZhPljqhAlN
        Vz/UwifEMYTNlzvawxg+/2Zn
X-Google-Smtp-Source: AMrXdXsJLGGXaN/t/4PztX3ojVUGGW+Zsrq8vCocR2JCax+6ki5jOtam2EEraVZdqhmJK5bRXYz8VA==
X-Received: by 2002:aa7:982b:0:b0:58b:4ae0:c761 with SMTP id q11-20020aa7982b000000b0058b4ae0c761mr24838899pfl.34.1674479985718;
        Mon, 23 Jan 2023 05:19:45 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm30818783pfl.146.2023.01.23.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:19:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, will@kernel.org, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Fix SMMU on SDX55 and SDX65
Date:   Mon, 23 Jan 2023 18:49:28 +0530
Message-Id: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi,

Both SDX55 and SDX65 SoCs are using the Qcom version of the ARM SMMU-500
IP. Even though the SoC specfic compatibles were being used in devicetree,
the compatibles were not added to the arm-smmu-qcom driver. So they end up
using the generic ARM SMMU-500 driver instead.

Spotting this discrepancy, the recent arm,smmu bindings change moved these
SoCs under the non-qcom implementation of the SMMU.

This series fixes the binding by moving the compatibles under qcom impl.
and also adding the "qcom,smmu-500" fallback compatible to the devicetree
so that the qcom implementation can be used without adding SoC specific
entries to the driver.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65
  ARM: dts: qcom: sdx55: Add Qcom SMMU-500 as the fallback for IOMMU
    node
  ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the fallback for IOMMU
    node

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 10 ++--------
 arch/arm/boot/dts/qcom-sdx55.dtsi                     |  2 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi                     |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.25.1

