Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2E6D759A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjDEHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbjDEHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:31:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693159FF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so36429936pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MVums2xGimULwLAksXbnkYaopPwvTqx5iwZKEFGpjA=;
        b=zGOdeyUuHbssOQ7Z1mPYifIrImzF0vUnQh4Iw+uFJy5hY8QkDtGxFIGiG3kQuaTxhm
         u56fsLmTn4sJoiDloYF0AozECkkKzxU4bafTT7eZ39jiA8sOR1uJLdIRWyBBb8K3inQG
         U6WBpxN3cYIoOt3D8JP6Be5owOmPe147i0mbAtgAph5yWGWSUS4W7KFToxkkbixIceV7
         E7ksTM/lHtxEIRW2e7aeep3WgvtpLn6ituYfGV4kuUNPSEXITCTdqivik/x6DJ1UMdXe
         SnJDBCcNMRVTjDXLGEniSeo8qelBz7zYsciLArvf/ii48/h7WcXJTOmyVW/riM56MsGU
         Ib0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MVums2xGimULwLAksXbnkYaopPwvTqx5iwZKEFGpjA=;
        b=3BtfrUQO8v95XHb3sxzFalrB1hcBmDaqiH81PUHtpvi91LiV3EaUoPpkVRJCP7bUFZ
         n/lq76wUcV5JOTiDbxZoLqt/vCEu0JtOhVHZ/t7pXvSrODo+cGfK7f4w3J3iD/AcP3OO
         7OkRGnXjaAsLXoUK0GbIeVjJVAVRq9sntsnGWFpFNeKmCzrva3fCBwvzhSM/9QhJv7u1
         6XiaN6CcDX59J+69txmiiwMRsxofWc9otD239rseFPaZjkvl2D4dl/og560ndUprcPIS
         sKpzpXSSAO3rpQy2VqfkrjD9ex3rCHePrXUBYZZ5BeEl4s2ZvcisQS6sr3Pz385cXjSc
         mnpg==
X-Gm-Message-State: AAQBX9e1EY6Vtf7YLkV0JZ+t1ImqgnpEmT2b2Vf6IMQBfIQBFjIUwYpw
        ZEwg/H1xKgt7i8p5hXj4HGfU1g==
X-Google-Smtp-Source: AKy350ZHbDWY+SUIF0C/sKiPkQp05MMrfJ/2mBdXbCQmwonFN3luVkhQwf72PaKWsmD0OlCGFkcygg==
X-Received: by 2002:a05:6a20:4b16:b0:d9:162d:98e4 with SMTP id fp22-20020a056a204b1600b000d9162d98e4mr4000483pzb.54.1680679888795;
        Wed, 05 Apr 2023 00:31:28 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a635b47000000b004facdf070d6sm8781507pgm.39.2023.04.05.00.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 00:31:28 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
Subject: [PATCH v6 08/11] arm64: dts: qcom: sm8150: Add Crypto Engine support
Date:   Wed,  5 Apr 2023 12:58:33 +0530
Message-Id: <20230405072836.1690248-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
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

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8150.dtsi'.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 9491be4a6bf0..c104d0b12dc6 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2081,6 +2081,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
-- 
2.38.1

