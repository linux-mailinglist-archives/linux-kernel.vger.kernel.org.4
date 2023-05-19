Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2519970A21C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjESVuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjESVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:50:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C310FF
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d2467d640so2501775b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684532969; x=1687124969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u5nTt5TmzYuCAEpy7v0bHr/c9oYRWSHg+eceJeWTGI=;
        b=BNcyzkI5/aihfSFsClaLOQm5qCqi7N8SqPFqAezWjcje7uvU6ZcljKsCJiEwz9IN/h
         3qq7ZhbMm+72kIvZQazYy3NmUSzM5EKKixo1LZkvz3D1MmGuyHwv1GmhyQF14qMe30+3
         ZfdRtkjoylDfqzQ4Lje2H80D2X2cEoWI3JQJs8+RuDSKWBfmnkS+MK3ydyoX5PzA7M53
         w5s8kp02qIviUeemdpRAJaDt6LmZjlfpnX9QNHindvZhb5ryIRK77oRSS8M7tABDXiM5
         cfLGKLONxdb0k56mNq+KeHkgxQ1GYQWjWfBzLRLpBSRjT0fmJ+UPUtPb1cjqhhPCTUwV
         iN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532969; x=1687124969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u5nTt5TmzYuCAEpy7v0bHr/c9oYRWSHg+eceJeWTGI=;
        b=mB4FUv63slG5It7tLbrshYqG3Q7dK2Kv18fQeCk3D9IHvuEkh/YhaGbjYUwqKlbV0f
         Fu/e8zfC8wwo3YaaWrlDDzyxlnv04HDLv/DnMy2rgTs0hv7QYa4bGpq5Q3ycP7NYu3KQ
         YjCXKCwX141nNtsdqSbZsbWG0XGbdxjSfXVDEfXPIpskewTvwpdDhEjshQe1+aUfhlyB
         M5JrSKBSHAx+72sVbfS9kn6eawL8KcTUlLXFdqO1WF0Yg2+boFy0h26C2h/ndkRNZH8a
         mvnrQvDUbJRexMf8Ge72m+QjoJcrp6gmJ0wOy2GLtNGK0EyeRQJK12bQDYpDzWIpuELG
         U1Ag==
X-Gm-Message-State: AC+VfDys/5VOTpUlxuJ1EtYuoGeqt70MQMq5eskmuryT5x06FSC0oPKS
        3TrbbkuuaH5D0z9MQay/aQRWbg==
X-Google-Smtp-Source: ACHHUZ4iruh83xQixGn6l/OD8gn9dwTopkElWv2oAldVAKx8hYcUEUHcfkHHoYnVapJQ/cUj24frRA==
X-Received: by 2002:a05:6a00:2d96:b0:64c:b819:89c1 with SMTP id fb22-20020a056a002d9600b0064cb81989c1mr4762386pfb.27.1684532969596;
        Fri, 19 May 2023 14:49:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm144891pfo.88.2023.05.19.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:49:29 -0700 (PDT)
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
Subject: [PATCH v7 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine support
Date:   Sat, 20 May 2023 03:18:12 +0530
Message-Id: <20230519214813.2593271-11-bhupesh.sharma@linaro.org>
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

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8350.dtsi'.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
[Bhupesh: Switch to '#interconnect-cells = <2>', available since commit 4f287e31ff5f]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ebcb481571c2..d00542f29dc8 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1726,6 +1726,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
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
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sm8350-ipa";
 
-- 
2.38.1

