Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC06CBAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjC1JaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjC1J30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:29:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125786A58
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w4so11047982plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679995738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gaq2pRYkVNQyPJ3XRF2sgEEJ7K2B6BxZF4eeMfjNR0=;
        b=XPbTuwt7+oxjeDsq+cRYBV4Z5FEpQJ18mBBU4NWVPh4b7rC11O2uV7anDgBQefJs0n
         SxIZwyi1heaQWUTSUwVs/F+Jr9J4j3n4eQGMD1J5zVHzaFF9vmgs2Z0wPIhKXSMUxPug
         cB8EeS27ckBAKjfY1qabS5Np59eWrT7MuOI34z/BVRJ/KFZ5388LOUuYVMkURQIUVjIJ
         DR0hiNc8HHzdLj9dgDGfXcKgHVe7DRy4Wl4PVb7SB1+wwatcZ4AKhWjj2PLj2MU/gavl
         kO2euXIyx3tZrhdGdPN7FhbEZhCpb/ViY3YsE2G9MEyX036ZDikf37EnqIhFDIxRrSp6
         +oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Gaq2pRYkVNQyPJ3XRF2sgEEJ7K2B6BxZF4eeMfjNR0=;
        b=t34zOI8sdmL6lTROdz8/Rg7YNcImsuiGamGzVLSRIGkRVXMcF7K6NiBTVCSFAotIbM
         2izAz0gf0UM+iktmKIClnDE8QBhJYIjjW8VnpzgXMqJY7TKcQGXKxZO0crOvO+xF0fxM
         Tn0QfNTFpnLz2oICKiBYVrd7+tpsyuvN9+T4lgxXpwgQ7qjbBnjtUBjpUB644EnM3bPF
         jbNqloW6AlkAS1aPupARW7yJ/nhBDMbRanDjhx+OCpD318I5zoL11FhbFeTzBpqey75V
         oKaHCizGeQo2eDMQdfcnrrZf5Z3O03q/YsB2SvveoVve5vs/EYsNtQ+H4vYNq3HJzwjs
         aLoA==
X-Gm-Message-State: AO0yUKVd1psM+Lbfiu+sfka3GlHJ6tlxM86QKXtr1qWmUPel04AbwEF7
        J8WovTakZKgM8ksyAO1uMVeBsA==
X-Google-Smtp-Source: AK7set8+CzxEp1X+SQoJAqGs1IGnnUeJ4j4jMTEBUikafYfm28YExHaj50pPtARaB2Hn5TmbheQhrw==
X-Received: by 2002:a05:6a20:811a:b0:d6:8c70:85ce with SMTP id g26-20020a056a20811a00b000d68c7085cemr12536739pza.54.1679995738069;
        Tue, 28 Mar 2023 02:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:449a:10df:e7c1:9bdd:74f0])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm21261518pfo.141.2023.03.28.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:28:57 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v3 7/9] arm64: dts: qcom: sm8250: Add Crypto Engine support
Date:   Tue, 28 Mar 2023 14:58:13 +0530
Message-Id: <20230328092815.292665-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
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
'sm8250.dtsi'.

Co-developed-by and Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7b78761f2041..2f6b8d4a2d41 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2222,6 +2222,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
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
+			compatible = "qcom,sm8250-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.38.1

