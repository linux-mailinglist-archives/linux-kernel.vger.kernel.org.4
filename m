Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C166D0BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjC3QyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjC3Qxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:53:52 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3BE1AC;
        Thu, 30 Mar 2023 09:53:39 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PnTyS466Yz9scX;
        Thu, 30 Mar 2023 18:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680195216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m56WRt9MBUX21VaYs44Au/+VOI1zJ1co48wCBr7f3Y=;
        b=uyzaNUu090TdHOXj5AW9YbXQ4gccf82/ov67LGQwwLEMXJH3hsuUC5a6FljYOjEgwH8J+7
        URtUPTVj0dok11URn8uxQPK8FEI638+8X9SZ8TigjN6x6XyIuVZEDKFZigY7ai16An0rRt
        dVwbvZdhb8D/2zFyu2+rEPgMAScG9mWfINLO8MSzz++sT+rIWMBvUBHBT88UIjxrR7B40h
        C3AXtSbhnSRG1vNUQCDv8KwGVieOcAzNTam8iQ9cbMfs4QfwRG/DTIK9hKMveC/kqouOuH
        6rxaTLXveGWICWX65dmvXFUJnJUhTLkwAdKB9TJqPeR44i8oL6doHsI/yjBSPg==
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
Subject: [PATCH v3 1/4] dts: arm64: qcom: sdm845: add SLPI remoteproc
Date:   Thu, 30 Mar 2023 18:53:19 +0200
Message-Id: <20230330165322.118279-2-me@dylanvanassche.be>
In-Reply-To: <20230330165322.118279-1-me@dylanvanassche.be>
References: <20230330165322.118279-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PnTyS466Yz9scX
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
index 2f32179c7d1b..3b547cb7aeb8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3311,6 +3311,42 @@ glink-edge {
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
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
 			reg = <0 0x05090000 0 0x9000>;
-- 
2.39.2

