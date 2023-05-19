Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30B170A21E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjESVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjESVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:50:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E091711
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d426e63baso450170b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684532975; x=1687124975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX3REAuTIsVZ6DzzbZjgxi6x6RxwtquozCIGLLCHmIk=;
        b=b1RKkDvksKLGmpT/EePmAxBCny09Q8ABI2ZOS/AahJ95WTR/XKUx1Xi0Lwupi84AgN
         q78qnHcZbVvTREDAWZHIlQKI3/17yFz7MfSnN25tKUTNdvjl7zTbtMPDr7OpB2smOM4x
         64ftMOc4OHycDjXL7Qa7WBBnI+0II0yCBr+RggyFd8kDWGSKv+Es245t+2CPwlsDJpw/
         ImaGahLSj5iVkZHHNEIz1q88iXVBVVpPIgJ84bVrTg1ncjUEQB0pVBn0NuUKtQUF2Xw0
         G7kofeFvOjbG13fZVqTVzZ6C3pNvNR3q/YZS4B+xizw27dY/QM7CgrMtkfYLZU8SpcxZ
         B1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532975; x=1687124975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX3REAuTIsVZ6DzzbZjgxi6x6RxwtquozCIGLLCHmIk=;
        b=JdOcHp64T9vyhGDBiszhL6Poadb24O7WuZi2I5VrK6EUlhTytUgBwqYJZmtqKoObyA
         niZWH/qJcfphzC66oLW5Td9naGpVq5cUJESDyGSp8ifLXzy9sQrtHyftEUOo8AV3UdeO
         +EQalzEwA0JiTyQxRuee3KN+yCrbZFU+0fGyaBeTDf86WWTBkEiqK4svWO89Boqhnjhv
         jCvUWMetB+c+gw+T673VNq8cQCjw27G0J+8OZVYB+aDRpF91TH45FaYzLAI+aR+pZGnN
         i1F9PTP9r3cfgd4C0oWqb4/2DoLq5jrYPXHYcKUCs8sf+lAYdCIQsvizzqGXJ1VFPUDN
         n7ig==
X-Gm-Message-State: AC+VfDw/d4CZCvbGkScgMzNUOe9fRbwTjPgWW6gfTyynN7/YSLA1ZEnO
        GnlbWa09ZIC0MZN7BsoxL4CHFQ==
X-Google-Smtp-Source: ACHHUZ5XFBBazjQnC9SapcON49nM7yp9PFi6hL2/RvVNtYkoWpfPuJC/BWW0x5ixKhqy/Vsc8b2ADg==
X-Received: by 2002:a05:6a00:2405:b0:640:f313:efba with SMTP id z5-20020a056a00240500b00640f313efbamr4225248pfh.19.1684532975199;
        Fri, 19 May 2023 14:49:35 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm144891pfo.88.2023.05.19.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:49:34 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v7 11/11] arm64: dts: qcom: sm8450: add crypto nodes
Date:   Sat, 20 May 2023 03:18:13 +0530
Message-Id: <20230519214813.2593271-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
References: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Add crypto engine (CE) and CE BAM related nodes and definitions
for the SM8450 SoC.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bhupesh: Corrected the compatible list]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 595533aeafc4..1c65f7dc67f2 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4138,6 +4138,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x28000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x584 0x11>,
+				 <&apps_smmu 0x588 0x0>,
+				 <&apps_smmu 0x598 0x5>,
+				 <&apps_smmu 0x59a 0x0>,
+				 <&apps_smmu 0x59f 0x0>;
+		};
+
+		crypto: crypto@1de0000 {
+			compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x584 0x11>,
+				 <&apps_smmu 0x588 0x0>,
+				 <&apps_smmu 0x598 0x5>,
+				 <&apps_smmu 0x59a 0x0>,
+				 <&apps_smmu 0x59f 0x0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.38.1

