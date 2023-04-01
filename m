Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5736D32DB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDARfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDARfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:35:42 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCAB756;
        Sat,  1 Apr 2023 10:35:40 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ppkp10gS2z9slb;
        Sat,  1 Apr 2023 19:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680370537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqA+kJXDocnnJfMI7ArNRBbUlPcBQF5RtKhT0QIIGC4=;
        b=kyysQ7V6HBz5rWJmFl0CLG8yD5McCRW/PE5CPvoajm0R7X5kdg0LXAY62Ttqdf+hBszU48
        CDuJp1ew4TczyrxsK2IrGa5XFC6YFBooSbRikhCyDvf+b9zrGMbJraSxBygCYkMyaLjA2k
        aY31AWP6iWPNZXt2Zc2Ck+0v1rj9foEXKbHQoPv50FdagEEmOjudw5hSSC8upPgs69jT0Q
        A0Pm0HuAVQIEnS86cw43+KNQ/vmumo0LtKKCubdyytD6DFG7tkVs/2P4sCAVM/ZcrERvI+
        yt4Mza89mnKsZ7iQ5vMb4L6VY+NMMY+p5so5RW4Fyo3jnC+4gHZDlrdAqGiDxA==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v4 1/6] dts: arm64: qcom: sdm845: add SLPI remoteproc
Date:   Sat,  1 Apr 2023 19:35:18 +0200
Message-Id: <20230401173523.15244-2-me@dylanvanassche.be>
In-Reply-To: <20230401173523.15244-1-me@dylanvanassche.be>
References: <20230401173523.15244-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SLPI remoteproc to the SDM845 Qualcomm SoC which is responsible
for exposing the sensors connected to the SoC. The SLPI communicates
over GLink edge 'dsps' and is similar to other DSPs e.g. ADSP or CDSP.
This patch allows the SLPI to boot and expose itself over QRTR as
service 400.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f32179c7d1b..338a715d110a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3325,6 +3325,42 @@ gpucc: clock-controller@5090000 {
 				      "gcc_gpu_gpll0_div_clk_src";
 		};
 
+		slpi_pas: remoteproc@5c00000 {
+			compatible = "qcom,sdm845-slpi-pas";
+			reg = <0 0x5c00000 0 0x4000>;
+
+			interrupts-extended = <&intc GIC_SPI 494 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+						<&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+						"handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			power-domains = <&rpmhpd SDM845_CX>,
+					<&rpmhpd SDM845_MX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&slpi_mem>;
+
+			qcom,smem-states = <&slpi_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>;
+				label = "dsps";
+				qcom,remote-pid = <3>;
+				mboxes = <&apss_shared 24>;
+			};
+		};
+
 		stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0 0x06002000 0 0x1000>,
-- 
2.39.2

