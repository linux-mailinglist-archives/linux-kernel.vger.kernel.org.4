Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E105BF5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiIUE4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIUE40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:56:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B667E80E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:56:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so4632095pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4dDKd9wp7f2UhxbbfY0ifehyTKrdIYEa/zzMgfdL7kI=;
        b=UX16cgtf3pZvfRyv3ivQJIEtyrKqB9G8OJl6AoJodHt6DWtPpGIJbmR21B9xv37PfR
         rNvgAcFBi+aarpVwK1zMHCtEL1JAu36DRamQHetcD2bUHIW1JcdgBci3pvjssTUkT/Zm
         zrXIheUWRTqgNoVH3J8LgIk+nkeGyMBDigqr9DIeOP4biPlZ0H61U19zp5m7nGLjDwSQ
         QwOXMbejgTFiseStLZ0DZl9JbXaSUHb0QbJDExqe+lS5z7A+YJqUGzDzEU8KIehOwsUO
         KsPlAtpWaFsyva1f7UOe0EiMQEnc4hz4QIzQBPd1FrOJr7ABkO2bF4yWzJyZ7XNu53YL
         jHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4dDKd9wp7f2UhxbbfY0ifehyTKrdIYEa/zzMgfdL7kI=;
        b=cXaMsxmvtI4D5bR5UuXGRM8WrCFpt/GaBVjkiwfrV8XmjQLTFomQ42fAOg+GYiHGUs
         +ltNAH583iHgHdHxxwhRi7Z7/7CMRRYoN8Eof5HPjU1NTiSXvAXLNuYH33EQBxwhfVYv
         4zY8f3uFUx84EhADod23zC87L7JdzcF3gFlxMq1qOA/Ckcv7XiH05v5Mxq7Fjef8kwra
         yJZ9FOSHrQheqTl90+tYbJACioS6Mn4mJ6GZ09vQJwSu+kdxIbNZqvAz90101v0bKGGw
         4UFOVBxCsQmOvzP+euoZtBBEwcdcgmV/a7cFoWbwVKnaChoE2GAmb0G1EbVlEQZOLSlJ
         x+rQ==
X-Gm-Message-State: ACrzQf1T0+I2zwVmqgry6NHU59lO4nx0xMTwJ/0w5/gBsoaHWTGG9tVF
        nYl7vS5kuS2ZXl268DFiIcp+Rt87lVpm3A==
X-Google-Smtp-Source: AMsMyM5FShqSgAybsT1Bhlvt1JwfgF6TuDmFZ+cg+TKPLmadGqSE+hzY8sR+MxcytGIEkNa7M4qABA==
X-Received: by 2002:a17:903:1246:b0:178:abc9:1a2b with SMTP id u6-20020a170903124600b00178abc91a2bmr2990721plh.74.1663736184614;
        Tue, 20 Sep 2022 21:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b00176e2fa216csm871829plf.52.2022.09.20.21.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:56:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de
Subject: [PATCH v7 2/4] arm64: dts: qcom: sm8250: Add dt entries to support crypto engine.
Date:   Wed, 21 Sep 2022 10:26:00 +0530
Message-Id: <20220921045602.1462007-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
References: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8250.dtsi'.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..7b3af34f8486 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2188,6 +2188,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x584 0x0011>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8250-qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x584 0x0011>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		ipa_virt: interconnect@1e00000 {
 			compatible = "qcom,sm8250-ipa-virt";
 			reg = <0 0x01e00000 0 0x1000>;
-- 
2.37.1

