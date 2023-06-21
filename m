Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69631738DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjFUR4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFURzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:55:43 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A87419AB;
        Wed, 21 Jun 2023 10:54:45 -0700 (PDT)
Received: from lexxgentoo.devos.club (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id F150C1408B3;
        Wed, 21 Jun 2023 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1687369959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spj7M1eu0BpTeWO4D88uXHofRs63AcicfCjtgCEG0j4=;
        b=bUP0j+i7VThOhmj1qULSbsnS2q8655wfM/XpfJNl53YC4HK7km1yUcz5GBjPsrwQtrYOzT
        isUEBs95ZytRcRA/wMVGrEHCOxyLzG3GfiWf4DzgtLbi5EFx+ZGmPJ6GsoDThl46xQk3bh
        P9+yHoMSdQ7mLSvfECwFnVjK1SfbUME=
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add support for modem remoteproc
Date:   Wed, 21 Jun 2023 20:50:46 +0300
Message-Id: <20230621175046.61521-3-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230621175046.61521-1-alexeymin@postmarketos.org>
References: <20230621175046.61521-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modem subsystem in SDM630/660 is similar to MSM8998 and
device tree node for it is based on the one from msm8998.dtsi.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 65 ++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 014237d4b5b2..ad01f2951154 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1028,6 +1028,71 @@ data-pins {
 			};
 		};
 
+		remoteproc_mss: remoteproc@4080000 {
+			compatible = "qcom,sdm660-mss-pil";
+			reg = <0x04080000 0x100>, <0x04180000 0x40>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_BIMC_MSS_Q6_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&gcc GPLL0_OUT_MSSCC>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
+				 <&rpmcc RPM_SMD_QDSS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface",
+				      "bus",
+				      "mem",
+				      "gpll0_mss",
+				      "snoc_axi",
+				      "mnoc_axi",
+				      "qdss",
+				      "xo";
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&gcc GCC_MSS_RESTART>;
+			reset-names = "mss_restart";
+
+			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
+
+			power-domains = <&rpmpd SDM660_VDDCX>,
+					<&rpmpd SDM660_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			glink-edge {
+				interrupts = <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 15>;
+			};
+		};
+
 		adreno_gpu: gpu@5000000 {
 			compatible = "qcom,adreno-508.0", "qcom,adreno";
 
-- 
2.39.3

