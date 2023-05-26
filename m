Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75212712D49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbjEZTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjEZTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:23:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6025510C7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b01d912a76so4214855ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685128994; x=1687720994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOhQfsJK5dTieFAHpndB0sp0nugrzVr1VK8sl6Is5JA=;
        b=TH3DzXklVpoQLcvmbEHgOMUwYCSXzJn2RotIMOVEnaSCBK5DLHrLNleol3LHbsl8aY
         erU8ZFwyP46nnAPJkfJBG1orX/i15p0f9kVnbRpSAby+UUB3GNMVn8EzPtZ1ZQStGRj7
         VVn5uOGKMDZahEjOU8Xg/88CJeaR0RuP7qYO7AhSOqGM5t/fV4TWvi0bM4pwlbw1PLr0
         o8VAlAgqPsLdOaonmaxCY+IMJ8fmu0/H14+EaW52G9P1qnnqezlAjg5ff7d+atEjgVx+
         UuPfg9l/FIp6z8zPo12czfN39oI0vhXSj/axCiC++aCv6aXjqH0M3tjMJSr7h6rme5/Q
         ejKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685128994; x=1687720994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOhQfsJK5dTieFAHpndB0sp0nugrzVr1VK8sl6Is5JA=;
        b=Gi2AlP9/YepzwkFKku1nylei2ZRv/Mjgumi1drR5dN/dytdpbSgvC0VpHTumS9yPVG
         nHl672hHQioSWDXWkbTG2gcWYAn+0UE+b8dbei2ilZhA83MZJ3AN4/6f+j1D8kl4Y9ZN
         AcrhRL07GB/eQlPiyzNgeIIDGexy7bOTZWQ57hesXYl+8SqPKxLIpACe2lfDxRfuAcIM
         K1ZE3pwg5q+f27lpTR6yyGEqx//YwOYoh1HSpWC2PkoO72lmoaLWhehHxieoX6Fq8Txk
         CvALMY4cbm7ELU9ueJK/vrn6lqsS0zIrq38AKFw6IQA/f7EWuKuYhYCWkQEpcL5Xx+R5
         oTWA==
X-Gm-Message-State: AC+VfDzTIORgks6s90nu1t77Jy+ZUUh0cgHxkSY2XBlYKjrFr+rJFW4k
        fywcTReGto+MRWKFRGEnB5rSpg==
X-Google-Smtp-Source: ACHHUZ69KXEBSfoKY/MmiFtjut3HQuddyCGPARLHLvRDsNSz6mtvzwJmpCI/R26bLuCllY0hhGCFww==
X-Received: by 2002:a17:902:7084:b0:1ac:6882:1a6f with SMTP id z4-20020a170902708400b001ac68821a6fmr2794943plk.30.1685128994398;
        Fri, 26 May 2023 12:23:14 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:23:14 -0700 (PDT)
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
Subject: [PATCH v8 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine support
Date:   Sat, 27 May 2023 00:52:06 +0530
Message-Id: <20230526192210.3146896-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
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
'sm6115.dtsi'.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 43f31c1b9d5a..2aa148340277 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -663,6 +663,37 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x92 0>,
+				 <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>,
+				 <&apps_smmu 0x98 0x1>,
+				 <&apps_smmu 0x9F 0>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,sm6115-qce", "qcom,ipq4019-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
+			clock-names = "core";
+
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x92 0>,
+				 <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>,
+				 <&apps_smmu 0x98 0x1>,
+				 <&apps_smmu 0x9F 0>;
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
-- 
2.38.1

