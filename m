Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD836DB0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDGQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDGQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:54:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8326A47;
        Fri,  7 Apr 2023 09:54:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br6so55130031lfb.11;
        Fri, 07 Apr 2023 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680886463; x=1683478463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvOzKISy1I9WEd0b/cwK5YdYQf47Pm9gMWrSeGmbKNk=;
        b=fCR8DXz31svvgeT9RtWbEdGpNub9rRc1Rqy/GdwDzyaRehDPvVBbPtzySvWAxKtat8
         h95DJvdGqCqVk1k2uSovXsw6xc6GK39B6rts+l8TIXStq+9xe72Exl8qgJ3wEg6M08Wc
         xX/3WMFKFhh8PfnkNTR0y5pngqt8MSH0iQaanaRklsaDuN7wL6gyC3UhTA/rB5uzJMxM
         CDlxXQkAbEMGiBEXeOm76SPo4arRxlMIE/LzteXsAnJtpeKOWbEZ4EB1FPPUJ5Fy3ndn
         juzRXIdXsn5HJLhepxbmXDROtopCISwi3d3g6nX9JZa6jcaG/dxxPBrFpJ5D2Ku3taGb
         zzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886463; x=1683478463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvOzKISy1I9WEd0b/cwK5YdYQf47Pm9gMWrSeGmbKNk=;
        b=ln9r8BXGoWoB6LLL8q+LIxNiVg3kUPAk9eJWH8R715sScxAQPxOK2relQ8/UavdisF
         8DVbrARjB7wYBdpyKybtfu/tJBaPKvwrXNBaHwEVRFhJqvfqPw5kl1B0OpXpOtR+SqjP
         i/s6uYGlWBtMlXPcZNMHBu3qq/5sKNbfFkaRKIc0RCb5gLOX/BlKhDncCGPXA7OtyKxW
         bOy/Ts0jEfteAwNjbB80wiMN5ftnlMZj1fqKSyINVr7b/nK2VNODhqB1DLmsv4PMd+Ht
         1+bEDAm3ZR5ZbcrOrGyIYJLdQiJhZCSDDwJb4FWeR3qboVbBbIhDA7hRgTtefDHkLDfi
         7pfQ==
X-Gm-Message-State: AAQBX9e4X1HstF/RqAOBFM9Anpq652cJhcDwOxVSM8y5rYdseja9vWEw
        6hfhIt5hoBBzPo0K1r5xzz1v/qEuFP7S8w==
X-Google-Smtp-Source: AKy350bA7EXU9XKR7fumJ2mB3G4RRhiHbXK6aVBXkgj8MagCz9x37MQMyyG8HXUMD0Xv8FK5aiHlVg==
X-Received: by 2002:ac2:5982:0:b0:4e8:4abf:f19d with SMTP id w2-20020ac25982000000b004e84abff19dmr989558lfn.15.1680886462738;
        Fri, 07 Apr 2023 09:54:22 -0700 (PDT)
Received: from localhost.localdomain (byy157.neoplus.adsl.tpnet.pl. [83.30.44.157])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25303000000b004db297957e8sm781712lfh.305.2023.04.07.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:54:22 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: dts: MSM8953: Add wcnss nodes
Date:   Fri,  7 Apr 2023 18:53:42 +0200
Message-Id: <20230407165345.42800-2-a39.skl@gmail.com>
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
wifi/bt functionality on this platform.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 130 ++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 684668170353..df40584aafcf 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -326,6 +326,31 @@ rpmpd_opp_turbo: opp9 {
 		};
 	};
 
+	smp2p-wcnss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <451>, <431>;
+
+		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 18>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <4>;
+
+		smp2p_wcnss_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_wcnss_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smsm {
 		compatible = "qcom,smsm";
 
@@ -340,6 +365,14 @@ apps_smsm: apps@0 {
 
 			#qcom,smem-state-cells = <1>;
 		};
+
+		wcnss_smsm: wcnss@6 {
+			reg = <6>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	soc: soc@0 {
@@ -630,6 +663,37 @@ i2c_8_sleep: i2c-8-sleep-state {
 				drive-strength = <2>;
 				bias-disable;
 			};
+
+			wcnss_pin_a: wcnss-active-state {
+
+				wcss-wlan2-pins {
+					pins = "gpio76";
+					function = "wcss_wlan2";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss-wlan1-pins {
+					pins = "gpio77";
+					function = "wcss_wlan1";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss-wlan0-pins {
+					pins = "gpio78";
+					function = "wcss_wlan0";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss-wlan-pins {
+					pins = "gpio79", "gpio80";
+					function = "wcss_wlan";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -1245,6 +1309,72 @@ i2c_8: i2c@7af8000 {
 			status = "disabled";
 		};
 
+		wcnss: remoteproc@a21b000 {
+			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
+			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
+			reg-names = "ccu", "dxe", "pmu";
+
+			memory-region = <&wcnss_fw_mem>;
+
+			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wcnss_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wcnss_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wcnss_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_wcnss_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			power-domains = <&rpmpd MSM8953_VDDCX>,
+					<&rpmpd MSM8953_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,smem-states = <&smp2p_wcnss_out 0>;
+			qcom,smem-state-names = "stop";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wcnss_pin_a>;
+
+			status = "disabled";
+
+			wcnss_iris: iris {
+				/* Separate chip, compatible is board-specific */
+				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
+				clock-names = "xo";
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 17>;
+				qcom,smd-edge = <6>;
+				qcom,remote-pid = <4>;
+
+				label = "pronto";
+
+				wcnss_ctrl: wcnss {
+					compatible = "qcom,wcnss";
+					qcom,smd-channels = "WCNSS_CTRL";
+
+					qcom,mmio = <&wcnss>;
+
+					wcnss_bt: bluetooth {
+						compatible = "qcom,wcnss-bt";
+					};
+
+					wcnss_wifi: wifi {
+						compatible = "qcom,wcnss-wlan";
+
+						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+						interrupt-names = "tx", "rx";
+
+						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+						qcom,smem-state-names = "tx-enable",
+									"tx-rings-empty";
+					};
+				};
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.25.1

