Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F56D2619
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjCaQqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjCaQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:46:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5732369E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so23948420pjt.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQeWB7xzGpVsc7eSrbLdl2ydZmcfTTPBoAGH1zyjD1o=;
        b=MgbGb9+BajR7U9Py9m3Waklr7ZRT5TbXE0rkhdrigVGuXvy9FH1Mb9DCA3RNwdC8P+
         W7gZj6Ayj1u7v5GHACtoETocx4IX0wY59TWhL2ZoOe3M8NixjXSkKTgWNJTp1RzJICpb
         S1Tbb0eHpfCXHhRThqTFDgJNW5eKxLs9MLiN5qjnOEoM8X0lB43Wg6tSE2eQDMOZRu2a
         5V1QJZ0WcDvQ00tFobV3d3AcdHLlyG7xOw+94sfLv9Wk5WxkXVNTou8mq5050nSyQIT1
         wG3x3rq4uE1egPNbGXjb7YRjJMqwssU4MHc1tQg4loQyoM+gzu3yVZPS5tJXspbmaApF
         yDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQeWB7xzGpVsc7eSrbLdl2ydZmcfTTPBoAGH1zyjD1o=;
        b=OHNBE1XxpC1yEgq2bkCZ8pmPaAwnbIVk1ySFtl4p7p4E7wWKzDMwTWk7TMNBiLdeEJ
         iSykw+Rkp+sEdX+ynLWaglt5QK5evQPl7rpBhpkaIz+CNATgGJ4VRTKImhT4EVZDYzpU
         NUTs9QlOQnjITjKLKkSKPBMw4t5n7CIVdZQ+kRmeeBhTTiuMZAG7wIjSqozr5ygugfT6
         VHaWeMB+2QCuryfIf8vU8TNbi9CJ7EjMmlQsbMR7j05rqpRKYSwStgxdfiEfrVlHqi1r
         9ymBecPWYt7X6KZX1JQWcn4NjSMA7TE1jDchQQTRYLnLrF++umK+rZ8qXpzfn9H04Hx1
         xI2w==
X-Gm-Message-State: AAQBX9dfaSfDCfurYVNiSMhlTxGvh0pFXhBihBFNiCXwmaargDgr6JK6
        zaEEIlpk70x0NxxRbPppQYCypw==
X-Google-Smtp-Source: AKy350b+9sXAELUkkF3jqAghaMeDCPUqUPxSM1UJMNGAYXF0XGG/jRg976mLigMSa5OmDBAqdFIUoQ==
X-Received: by 2002:a17:903:886:b0:1a1:bcaa:aaea with SMTP id kt6-20020a170903088600b001a1bcaaaaeamr26472474plb.3.1680281060248;
        Fri, 31 Mar 2023 09:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019b089bc8d7sm1798767plr.78.2023.03.31.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:44:19 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v4 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine support
Date:   Fri, 31 Mar 2023 22:13:22 +0530
Message-Id: <20230331164323.729093-11-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
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
'sm8350.dtsi'.

Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 7fbc288eca58..090ee07d1800 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1730,6 +1730,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8350-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO &mc_virt SLAVE_EBI1>;
+			interconnect-names = "memory";
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sm8350-ipa";
 
-- 
2.38.1

