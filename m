Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04F731E74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjFOQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjFOQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:15 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC42972;
        Thu, 15 Jun 2023 09:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847858; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X1tQNBeymxepoqTB18vxRy8wwik1Px3RYQsExD4T4AYShm28gyXT2qCnDoWXbznDTX
    pUvjZRHtffnLNotY9w/Ji9I74+41g/xhvADAFATEaIMwipaheJRzbX7eU5NEv9y6k7mz
    s0zCmvSkutpN1INUgNTfzMKKC2Glrj+Mi8ga2OT6OcWyyxdt/PYXvWgNXC5PZS0AQHE0
    jc45VmW3wVif5PYxbsBPAvXbrmT3b6pmEoy01eVDd0jQvqlAMPL8yX63yyhnSwIVzKe0
    e8JvNEy0J0ngLIUCCQoc5mzI1FwiPfJO8KSWdmeNYSxHLwMjTbUs8IruM1kncgyM4ngh
    T3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847858;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=j+YDPjlYmNI42s4VrGmFYEAJ7pHTo5x79hCNT51VwjA=;
    b=gURBKWCFObdxZWCTKcjcYwdjnQqYdV/nOgyDrCDDHyXtXSgogP75hwSiyjx1crC64I
    oLAJvoQBJqTdtdfz9jMetvUYCeb16mKyrdNHBDaDJN4mUdaDUFVPTv3PGzvxE9mVUg+t
    MAH7AQ1nWWjK4Ju3rcXOW+8laTvJJBWQ7n6BFdn6C2iW24LTaOHZ3Nv/Erx6sInFY31r
    HLiPBf9LJJ50LJulMcpBEImhxVYj2fPhskFXJRXq+MBzuaz/N+Mi3mZB+94W7GAfH9K+
    fOGTR0/4PAf9TttkVp2KOdQk+TxNKk3QRg0gM8jsB7UU6rZcySf3l3LrRTpUItohqXQo
    3yqA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847858;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=j+YDPjlYmNI42s4VrGmFYEAJ7pHTo5x79hCNT51VwjA=;
    b=AqPHzRCQmdiX20wUHZBjyxpMHlJpOf+2QDuNXg2Eb40Fh7dzcbxs9bnDBgMXQ5ojRq
    z7MJwPSlQiJ1kuIysYmGNZAXXifxfLVFSGUmO0DgB90nGIpbF6MA+W529WkGNPD1sEmH
    HmrsijG0twrBkdkg7VZuvfsuItuG/EqAOWJ7koGEypobn8kS1GjSxs4HAjE7mmKCJ6q+
    VjZn+5LpLngh4l8Ek7h2NEdzhFLMu06cyOcpqsr02uSrRIgDfCrMZJtV+PN1Buzni9O5
    8dYqLJ+O+9LbSkLej76YMviGvrh1GictGJ7OlhHihlKqvHIfns/4CxPCnb0+4mV1g+Cv
    Ukyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847858;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=j+YDPjlYmNI42s4VrGmFYEAJ7pHTo5x79hCNT51VwjA=;
    b=X958zh7FoCIEi00cepFnE91+07EdHrz4it6wpBV2UIZKuOKxdgYVeY5awJgE8VFI6L
    u4+6vCmakbiVPeHCV1Cg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGov42l
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:57 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:43 +0200
Subject: [PATCH v3 10/13] arm64: dts: qcom: Add rpm-proc node for SMD
 platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-10-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having the RPM SMD channels as the only child of a dummy
SMD node, switch to representing the RPM as remoteproc like all the
other remoteprocs (WCNSS, modem DSP).

This allows assigning additional subdevices to it like the MPM
interrupt-controller or rpm-master-stats.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 112 ++++++++++++-------------
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 136 +++++++++++++++---------------
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 152 +++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/msm8994.dtsi |  99 +++++++++++-----------
 5 files changed, 253 insertions(+), 252 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7582c7d748fe..c4d673904698 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -282,10 +282,10 @@ CLUSTER_PD: power-domain-cluster {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
+	rpm: remoteproc {
+		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
 
-		rpm {
+		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 895cafc11480..5faaf4bfb0a3 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -240,6 +240,62 @@ pmu {
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8936-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs1_mbox 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8936";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clock-names = "xo";
+					clocks = <&xo_board>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8939-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+
+						rpmpd_opp_super_turbo: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -308,62 +364,6 @@ mba_mem: mba@8cb00000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs1_mbox 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8936";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
-					#clock-cells = <1>;
-					clock-names = "xo";
-					clocks = <&xo_board>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8939-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <1>;
-						};
-
-						rpmpd_opp_svs_krait: opp2 {
-							opp-level = <2>;
-						};
-
-						rpmpd_opp_svs_soc: opp3 {
-							opp-level = <3>;
-						};
-
-						rpmpd_opp_nom: opp4 {
-							opp-level = <4>;
-						};
-
-						rpmpd_opp_turbo: opp5 {
-							opp-level = <5>;
-						};
-
-						rpmpd_opp_super_turbo: opp6 {
-							opp-level = <6>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smp2p-hexagon {
 		compatible = "qcom,smp2p";
 		qcom,smem = <435>, <428>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index b711cf9a6dc0..e7de7632669a 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -190,6 +190,74 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8953-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8953";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8953-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -263,74 +331,6 @@ rmtfs@f2d00000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8953";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
-					clocks = <&xo_board>;
-					clock-names = "xo";
-					#clock-cells = <1>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8953-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION>;
-						};
-
-						rpmpd_opp_ret_plus: opp2 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-						};
-
-						rpmpd_opp_min_svs: opp3 {
-							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-						};
-
-						rpmpd_opp_low_svs: opp4 {
-							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-						};
-
-						rpmpd_opp_svs: opp5 {
-							opp-level = <RPM_SMD_LEVEL_SVS>;
-						};
-
-						rpmpd_opp_svs_plus: opp6 {
-							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-						};
-
-						rpmpd_opp_nom: opp7 {
-							opp-level = <RPM_SMD_LEVEL_NOM>;
-						};
-
-						rpmpd_opp_nom_plus: opp8 {
-							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-						};
-
-						rpmpd_opp_turbo: opp9 {
-							opp-level = <RPM_SMD_LEVEL_TURBO>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smp2p-adsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <443>, <429>;
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 753b9a2105ed..ab76806317a7 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -232,6 +232,82 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8976-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8976";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8976-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_no_cpr: opp10 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
+
+						rpmpd_opp_turbo_high: opp111 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -346,82 +422,6 @@ wcnss_smp2p_in: slave-kernel {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8976";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
-					clocks = <&xo_board>;
-					clock-names = "xo";
-					#clock-cells = <1>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8976-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION>;
-						};
-
-						rpmpd_opp_ret_plus: opp2 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-						};
-
-						rpmpd_opp_min_svs: opp3 {
-							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-						};
-
-						rpmpd_opp_low_svs: opp4 {
-							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-						};
-
-						rpmpd_opp_svs: opp5 {
-							opp-level = <RPM_SMD_LEVEL_SVS>;
-						};
-
-						rpmpd_opp_svs_plus: opp6 {
-							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-						};
-
-						rpmpd_opp_nom: opp7 {
-							opp-level = <RPM_SMD_LEVEL_NOM>;
-						};
-
-						rpmpd_opp_nom_plus: opp8 {
-							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-						};
-
-						rpmpd_opp_turbo: opp9 {
-							opp-level = <RPM_SMD_LEVEL_TURBO>;
-						};
-
-						rpmpd_opp_turbo_no_cpr: opp10 {
-							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
-						};
-
-						rpmpd_opp_turbo_high: opp111 {
-							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smsm {
 		compatible = "qcom,smsm";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 5a7923d7c62a..c374fba5d8f9 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -178,6 +178,56 @@ psci {
 		method = "hvc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8994-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+			qcom,remote-pid = <6>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8994";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8994-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+						rpmpd_opp_super_turbo: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -237,55 +287,6 @@ reserved@6c00000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-			qcom,remote-pid = <6>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8994";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
-					#clock-cells = <1>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8994-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <1>;
-						};
-						rpmpd_opp_svs_krait: opp2 {
-							opp-level = <2>;
-						};
-						rpmpd_opp_svs_soc: opp3 {
-							opp-level = <3>;
-						};
-						rpmpd_opp_nom: opp4 {
-							opp-level = <4>;
-						};
-						rpmpd_opp_turbo: opp5 {
-							opp-level = <5>;
-						};
-						rpmpd_opp_super_turbo: opp6 {
-							opp-level = <6>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;

-- 
2.40.1

