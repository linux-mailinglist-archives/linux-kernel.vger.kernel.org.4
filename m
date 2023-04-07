Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7EB6DB102
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDGQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjDGQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:54:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0EBBA1;
        Fri,  7 Apr 2023 09:54:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br6so55130153lfb.11;
        Fri, 07 Apr 2023 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680886465; x=1683478465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+s0yjmHm/hGhH/bvVigSoqlYkWv8Px0RKb0A33OxUY=;
        b=jmIOYXfw3RHGbeEx6b8iF8yx0HdBtSX+DkSJUX+WFFNhOI8XolMQqSr1ps/FTtAUty
         5Iyx66BwGuc/xVFjEgaVd7JHgKTNHDZyllnq0Gt3XPrQS8OkXxa2YirQQvTKi2wWOm/q
         TQNSZy0O0e/tOEiIOI0ZpOS5XyvhQssYWngFClpWvmxPEIDYaXG9DUPHttcoRBEyA76r
         T3OsYajSaz8//IYyeT9J+RD9gOC24Zgp6hWXnKFkI9DuMtVrxkBVLjfchsFYaKft2Dwq
         LuLIOGdSuqx1r748s/8DeeH6sa/iFX6hOL/5oD6VYQUOitz8CycENJjLNh/NkRIwM1Ra
         D41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886465; x=1683478465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+s0yjmHm/hGhH/bvVigSoqlYkWv8Px0RKb0A33OxUY=;
        b=3/iif9rXa/AnNx9f+HtTa4o7YeT/UvWcOfWpU/uwmRaFcuehv4Ueu/WPI6rKY0b89s
         4vdVOx75yEKiYVR6pmC1slkOvPd4xcv/op8lSTjGnbF+JOfcfE1AT7vgHDFXpWeMuNcB
         AdIG2mozBDTSkvG4s1wGs7GcI1IsUfmsJq//CWn//WxFNFLrer4fFg90mmwDgd8VhD65
         5uSnYrXm6nr3owxI+qSRvKLjyfbT+eG6ihrCyP7fOWpg51VwyGJrbjR+J/S1eiKaRv1I
         fw/vLh83x5ZkCp2p2s+Y8bRnrSfo4HjD2xbeJznm4j1lfHEUEsSoBRxwGkAni1DzEXb4
         feng==
X-Gm-Message-State: AAQBX9fk+/pCcHfa5Ir4Sg0xhBdX0aSwzs4WWdrIgU2NOc3k7p47kert
        ot44Gs69vDKHfZxjiJhVqRi5qcMt0PuWDA==
X-Google-Smtp-Source: AKy350Y76P/yiyStbAkHH2DSjohSDDbWvT2R+fniqe66PQKppZXbgPaReu6KKQyGkmjmtrefg1Y71w==
X-Received: by 2002:a05:6512:2191:b0:4e9:8994:49bd with SMTP id b17-20020a056512219100b004e9899449bdmr1051862lft.3.1680886465648;
        Fri, 07 Apr 2023 09:54:25 -0700 (PDT)
Received: from localhost.localdomain (byy157.neoplus.adsl.tpnet.pl. [83.30.44.157])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25303000000b004db297957e8sm781712lfh.305.2023.04.07.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:54:25 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: MSM8953: Add mpss nodes
Date:   Fri,  7 Apr 2023 18:53:43 +0200
Message-Id: <20230407165345.42800-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407165345.42800-1-a39.skl@gmail.com>
References: <20230407165345.42800-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for remoteproc, smp2p and smsm to make it possible to use
modem functionality on this platform.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index df40584aafcf..257b1946372c 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -326,6 +326,31 @@ rpmpd_opp_turbo: opp9 {
 		};
 	};
 
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		smp2p_modem_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_modem_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smp2p-wcnss {
 		compatible = "qcom,smp2p";
 		qcom,smem = <451>, <431>;
@@ -366,6 +391,14 @@ apps_smsm: apps@0 {
 			#qcom,smem-state-cells = <1>;
 		};
 
+		modem_smsm: modem@1 {
+			reg = <1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		wcnss_smsm: wcnss@6 {
 			reg = <6>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
@@ -995,6 +1028,60 @@ spmi_bus: spmi@200f000 {
 			#size-cells = <0>;
 		};
 
+		mpss: remoteproc@4080000 {
+			compatible = "qcom,msm8953-mss-pil";
+			reg = <0x04080000 0x100>,
+			      <0x04020000 0x040>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			power-domains = <&rpmpd MSM8953_VDDCX>,
+					<&rpmpd MSM8953_VDDMX>,
+					<&rpmpd MSM8953_VDDMD>;
+			power-domain-names = "cx", "mx","mss";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "bus", "mem", "xo";
+
+			qcom,smem-states = <&smp2p_modem_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&gcc GCC_MSS_BCR>;
+			reset-names = "mss_restart";
+
+			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_mem>;
+			};
+
+			mpss {
+				memory-region = <&mpss_mem>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,smd-edge = <0>;
+				qcom,ipc = <&apcs 8 12>;
+				qcom,remote-pid = <1>;
+
+				label = "modem";
+			};
+		};
+
 		usb3: usb@70f8800 {
 			compatible = "qcom,msm8953-dwc3", "qcom,dwc3";
 			reg = <0x070f8800 0x400>;
-- 
2.25.1

