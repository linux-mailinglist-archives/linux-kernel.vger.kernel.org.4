Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF56C249E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCTWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCTWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C158036455
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679350627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3diaV/qntELGZ823vxrRn9vLXA3Ahnarug2JpMiyJo=;
        b=UjFOMO98ELbzFfRR5ViyHiX1rvuFo8zzuaICkFWwcFN06hZ/YnR9BNzvgZtEDa/xW3rZT6
        A0PZO6G+12op4Cod9nGS4B4eos0qHamgs6x53E7wk63IvkpiGRySIXVcOjlbhTjw2q6/5d
        3+GOdE6EVd3Uog14vtPRA/In/Mg6xLA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-abTC9jkyO8mx6MuGWDd_PA-1; Mon, 20 Mar 2023 18:17:03 -0400
X-MC-Unique: abTC9jkyO8mx6MuGWDd_PA-1
Received: by mail-oo1-f69.google.com with SMTP id bp27-20020a056820199b00b0052513faabe1so4000228oob.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3diaV/qntELGZ823vxrRn9vLXA3Ahnarug2JpMiyJo=;
        b=LOdkjyTIkdP1Ww5hEg3jJeTLWCjn7McYtc50/91MNgRrM4L+kTnSiC0srQ6e0vzlfG
         AYKifV4vYu/rbU/73WIAZQFD25eOj6+SZ5G23G+qoS+BD4G6VwWJiEll1J+9i3RxxfK7
         CFMGZzTmwRWs5PgnYO5L4yFixBMSWoSxeQSlHPHbAfCgEyUXSnZMmP5Na2r6gtvcN2DV
         GVfxlWKpIvK8sm1RMuz8higVHVd2jj27iLqKGMQfP3+vrYWMlRIOp1j9v7bfkYcLJOoh
         47zzv8Q1B2b/QZO2R4YZLKGLHsauIfdzKOSZaq6TQJUBQwoRM2lTmYPE/mg1dF9NXs5V
         CSsA==
X-Gm-Message-State: AO0yUKV0qGGS4+X1FloAAqXmXpewjZg2tPkvdNQgTAMEw8kUd+H0z2FJ
        u9y7somUOcyvKP5j+FgXRvJnzAikq1UBmSPGSK6dT3YhWISyOeU/3XLjn+n0vkbyBJc67LSz4FO
        M9/r+qEOKe4qSX+Y8xk3W+Elb1hriFSYpUfV0t8tnmLv+bi8UcQH2YwKxhJTq6ZabzO+Ec+47fZ
        +Cja5t6Kx84UI=
X-Received: by 2002:a4a:5293:0:b0:525:29fa:a287 with SMTP id d141-20020a4a5293000000b0052529faa287mr595315oob.5.1679350621911;
        Mon, 20 Mar 2023 15:17:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set+lKWt5P4iyXda3ft4Vh3BH6Jt4rxJ7YszOgdHo4c2/OqbLuICyQp33x8Cph5fPIxboIt/mGw==
X-Received: by 2002:a4a:5293:0:b0:525:29fa:a287 with SMTP id d141-20020a4a5293000000b0052529faa287mr595263oob.5.1679350621631;
        Mon, 20 Mar 2023 15:17:01 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm4092465ooq.8.2023.03.20.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:17:01 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 07/12] arm64: dts: qcom: sa8540p-ride: Add ethernet nodes
Date:   Mon, 20 Mar 2023 17:16:12 -0500
Message-Id: <20230320221617.236323-8-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320221617.236323-1-ahalaney@redhat.com>
References: <20230320221617.236323-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable both the MACs found on the board.

ethernet0 and ethernet1 both ultimately go to a series of on board
switches which aren't managed by this processor.

ethernet0 is connected to a Marvell 88EA1512 phy via RGMII. That goes to
the series of switches via SGMII on the "media" side of the phy.
RGMII_SGMII mode is enabled via devicetree register descriptions.
The switch on the "media" side has auto-negotiation disabled, so
configuration from userspace similar to:

        ethtool -s eth0 autoneg off speed 1000 duplex full

is necessary to get traffic flowing on that interface.

ethernet1 is in a mac2mac/fixed-link configuration going to the same
series of switches directly via RGMII.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
	* None

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 181 ++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 8b7555f22528..b874f3909382 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -28,6 +28,65 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <1>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <1>;
+		snps,tx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
 };
 
 &apps_rsc {
@@ -151,6 +210,68 @@ vreg_l8g: ldo8 {
 	};
 };
 
+&ethernet0 {
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	max-speed = <1000>;
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-txid";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet0_default>;
+
+	status = "okay";
+
+	mdio {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		compatible = "snps,dwmac-mdio";
+
+		/* Marvell 88EA1512 */
+		rgmii_phy: phy@8 {
+			reg = <0x8>;
+
+			interrupt-parent = <&tlmm>;
+			interrupts-extended = <&tlmm 127 IRQ_TYPE_EDGE_FALLING>;
+
+			reset-gpios = <&pmm8540c_gpios 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+
+			device_type = "ethernet-phy";
+
+			/* Set to RGMII_SGMII mode and soft reset. Turn off auto-negotiation
+			 * from userspace to talk to the switch on the SGMII side of things
+			 */
+			marvell,reg-init =
+				/* Set MODE[2:0] to RGMII_SGMII */
+				<0x12 0x14 0xfff8 0x4>,
+				/* Soft reset required after changing MODE[2:0] */
+				<0x12 0x14 0x7fff 0x8000>;
+		};
+	};
+};
+
+&ethernet1 {
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	max-speed = <1000>;
+	phy-mode = "rgmii-txid";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet1_default>;
+
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_default>;
@@ -316,6 +437,66 @@ &xo_board_clk {
 /* PINCTRL */
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		mdc-pins {
+			pins = "gpio175";
+			function = "rgmii_0";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		mdio-pins {
+			pins = "gpio176";
+			function = "rgmii_0";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		rgmii-tx-pins {
+			pins = "gpio183", "gpio184", "gpio185", "gpio186", "gpio187", "gpio188";
+			function = "rgmii_0";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		rgmii-rx-pins {
+			pins = "gpio177", "gpio178", "gpio179", "gpio180", "gpio181", "gpio182";
+			function = "rgmii_0";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	ethernet1_default: ethernet1-default-state {
+		mdc-pins {
+			pins = "gpio97";
+			function = "rgmii_1";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		mdio-pins {
+			pins = "gpio98";
+			function = "rgmii_1";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		rgmii-tx-pins {
+			pins = "gpio105", "gpio106", "gpio107", "gpio108", "gpio109", "gpio110";
+			function = "rgmii_1";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		rgmii-rx-pins {
+			pins = "gpio99", "gpio100", "gpio101", "gpio102", "gpio103", "gpio104";
+			function = "rgmii_1";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
 	i2c0_default: i2c0-default-state {
 		/* To USB7002T-I/KDXVA0 USB hub (SIP1 only) */
 		pins = "gpio135", "gpio136";
-- 
2.39.2

