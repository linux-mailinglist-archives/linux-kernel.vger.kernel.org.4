Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA75BD6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiISWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiISWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:08:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD094E60B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:08:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw17so568845plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ULCMcZ+Weq8ahgDLA2SKhRRxvxoclcBLchkSc7jAqNM=;
        b=Ye6300eXUIZAHv0rYRGmO/Zyt1gzU2bx2cqLk43yzM3yzDNvGg4EZx3pYE9epsbWdZ
         p2AlgRmDol1nKMKgPGD9jtnOmW+GcpuzmWFRvq0Q0Rrsn+8EufXIQ8Vn0NUTcRrKMwue
         W53S1EyVZSPkj37Xe5I2ih0I7PG4nJjB0p1HZjcaRMJCFfwXJL7soGmhlf23XgRKC9IS
         Ht1k7wb+7ozD3MbZq4j6ctzlM9QL/UteUSzc/pRBY+sFDgE4nmOYzpJ4OM2dWnsEAEJ4
         N4QLgKUJtLInY3w/egXGME3iGFveNDsNi22BoYZkAW4icA7a7QG4YH4+hMtwlToaG0/H
         upVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ULCMcZ+Weq8ahgDLA2SKhRRxvxoclcBLchkSc7jAqNM=;
        b=s3jmHLiUdH+IbqWj5BDFcNhWb27b/6xj4rKn/MGIHJes3/shLXx8SGa7WzOKv/u3UH
         KK6UD3ytqS8BGWTf2ooOSUWfmbpLiIV7Rqi0t25+O66RSYFMi4XIRWEofxcpoO6SB3JW
         Y9jOkK4So2OKoxDT1DNhbBD0nA46xQigYwj1N+Fb/h6fo0nbH5+WyBN26S/IGCPKjwhD
         Fr3Z3ebvZvhmv6KdE7EdxSyPQEwggtrTqmf2DF11wY8P4oZ9Y6Ys7/zEuHXui+hrlxVu
         lfcP5s+aw1j4lJviPBii3bF56tEsyF0+8mBskEF9T84+kUGT/VMTDrfXZqcmBsbTauMh
         qj5Q==
X-Gm-Message-State: ACrzQf14qxXYLHmjMlxKlYhn9IA2TqcVQ+YOIF82o58eoHMWIYK7Ycur
        Gu+0VT6LE83aP4bSYnrqKlXEhQ==
X-Google-Smtp-Source: AMsMyM4aSeZUrbhqk3LyPbALtkW1FXKWQPvHMVUc360mF6o0d13SfcoVXtxgDTmd1/NgaQoOYvrfTw==
X-Received: by 2002:a17:90a:fa8e:b0:200:b4b9:c6f3 with SMTP id cu14-20020a17090afa8e00b00200b4b9c6f3mr366671pjb.190.1663625309322;
        Mon, 19 Sep 2022 15:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a6a8200b001eee8998f2esm7068167pjj.17.2022.09.19.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:08:29 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 3/4] arm64: dts: qcom: sm8150: Add dt entries to support crypto engine.
Date:   Tue, 20 Sep 2022 03:38:03 +0530
Message-Id: <20220919220804.1047292-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
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

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8150.dtsi'.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..6e21352a158c 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2041,6 +2041,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8150-qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x504 0x0011>,
+				 <&apps_smmu 0x506 0x0011>,
+				 <&apps_smmu 0x514 0x0011>,
+				 <&apps_smmu 0x516 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		ipa_virt: interconnect@1e00000 {
 			compatible = "qcom,sm8150-ipa-virt";
 			reg = <0 0x01e00000 0 0x1000>;
-- 
2.37.1

