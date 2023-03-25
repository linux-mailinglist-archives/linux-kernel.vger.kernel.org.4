Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416886C8EA9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCYNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCYNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:51:39 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0C126D9;
        Sat, 25 Mar 2023 06:51:34 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PkL8f4gFjz9sWy;
        Sat, 25 Mar 2023 14:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679752290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pr1/1z33qnRwWK5m0kR+1VEHi8G6I0PDALrO54s/mn8=;
        b=JQlVfkYr6FDQbUON/fiTfPb+Tvd5QHukkpZIDbTqxnI65kQrjxSje6rjN5YkRxyKXAOV4O
        Kqu+RXF+FcjQRozGGvZGmFE9JYb/EhH2UcxwFRh9jqJ324SDIrgyBSI6ikLMeBaIJTefwq
        kfOiU6TRM2gxBnP4MnIU4bKWOKacKYNiglnATQHcO5EUcqHerl4JCXQn7MFDMjefvRsCb1
        GNMV4Mmo83v3HtPuJQU2s/hwg7Ht7heKKZLwhs0z6yaMfJScfdEyagIvY0vDoBLPjlW/Cz
        01mfVIYaU0uxNifaYlzJQqlcBu3aSqDCVxRB3vcCqg3S+aB5SOqNBUGZG1uMsQ==
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
Subject: [PATCH 1/4] dts: arm64: qcom: sdm845: add SLPI remoteproc
Date:   Sat, 25 Mar 2023 14:51:11 +0100
Message-Id: <20230325135114.21688-2-me@dylanvanassche.be>
In-Reply-To: <20230325135114.21688-1-me@dylanvanassche.be>
References: <20230325135114.21688-1-me@dylanvanassche.be>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2f32179c7d1b..8dcfe6293762 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3311,6 +3311,43 @@ glink-edge {
 			};
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
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
 			reg = <0 0x05090000 0 0x9000>;
-- 
2.39.2

