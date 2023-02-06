Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD668B623
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBFHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBFHNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:13:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2117C30E8;
        Sun,  5 Feb 2023 23:13:21 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3166EncI015889;
        Mon, 6 Feb 2023 07:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sAK5wNgKDqiAOOQzymwEozZ7TKPzB70IpY/7wMiXPAk=;
 b=J4hyh7mJYQziwYsWr5Nzx6hPSzVeVpSClTuWaRPtYAsY5R1e/g1OCUXWZ8IB7vy1ZHG7
 rU4A22Fz4Hcp5GrtIGL8kfIw7oEAt2wdeBwdnhgPAFGaPNILJ8DsKGsWjI6ZXUzJyQlc
 0TAHK86s+I5lLAbbJE/7ALcd/uIpd+hj2HyLYSoSSlCy4oiQiFw1mgOZE7bvQl46LocQ
 2rJDaYW6qQrdL7hwsheuRYsrpIM4uLIxwnjCHQIdrKZFUyQWO4qKfNbFlYD0MZ/WPKQc
 vpZRdFcXcFZ30H6rumEfkF9F5pkWhxWCbnaBTZfe+wTU2nhcKDBMyjqZ7AEp4B8h7RWk Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhechb3n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 07:13:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3167D06i006589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 07:13:00 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 5 Feb 2023 23:12:52 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V3 2/9] pinctrl: qcom: Introduce IPQ5332 TLMM driver
Date:   Mon, 6 Feb 2023 12:42:10 +0530
Message-ID: <20230206071217.29313-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230206071217.29313-1-quic_kathirav@quicinc.com>
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _tWg0BJcZspXkqgc5_XrcMS8ooiOuvUN
X-Proofpoint-ORIG-GUID: _tWg0BJcZspXkqgc5_XrcMS8ooiOuvUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ5332 SoC comes with a TLMM block, like all other Qualcomm
platforms, so add a driver for it.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V3:
	- Grouped the individual pin entries of pta[0-2] and xfem[0-7]
	  to pta and xfem
	- Used the descriptive function names for wci pins to avoid the
	  ambiguity
	- Unwrapped the entries in ipq5332_groups for better
	  readability
Changes in V2:
	- Converted the function names to lowercase and sort it

 drivers/pinctrl/qcom/Kconfig           |  10 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5332.c | 861 +++++++++++++++++++++++++
 3 files changed, 872 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5332.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 8d4f871e07cf..10a549648819 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -48,6 +48,16 @@ config PINCTRL_IPQ8064
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm IPQ8064 platform.
 
+config PINCTRL_IPQ5332
+	tristate "Qualcomm Technologies Inc IPQ5332 pin controller driver"
+	depends on OF
+	depends on ARM64 || COMPILE_TEST
+	depends on PINCTRL_MSM
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc IPQ5332 platform.
+
 config PINCTRL_IPQ8074
 	tristate "Qualcomm Technologies, Inc. IPQ8074 pin controller driver"
 	depends on OF
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 6763aa8d319c..11b14c2805b0 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_PINCTRL_APQ8064)	+= pinctrl-apq8064.o
 obj-$(CONFIG_PINCTRL_APQ8084)	+= pinctrl-apq8084.o
 obj-$(CONFIG_PINCTRL_IPQ4019)	+= pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_IPQ8064)	+= pinctrl-ipq8064.o
+obj-$(CONFIG_PINCTRL_IPQ5332)	+= pinctrl-ipq5332.o
 obj-$(CONFIG_PINCTRL_IPQ8074)	+= pinctrl-ipq8074.o
 obj-$(CONFIG_PINCTRL_IPQ6018)	+= pinctrl-ipq6018.o
 obj-$(CONFIG_PINCTRL_MSM8226)	+= pinctrl-msm8226.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5332.c b/drivers/pinctrl/qcom/pinctrl-ipq5332.c
new file mode 100644
index 000000000000..e78d11292f42
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5332.c
@@ -0,0 +1,861 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-msm.h"
+
+#define FUNCTION(fname)			                \
+	[msm_mux_##fname] = {		                \
+		.name = #fname,				\
+		.groups = fname##_groups,               \
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+	}
+
+#define REG_SIZE 0x1000
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
+	{					        \
+		.name = "gpio" #id,			\
+		.pins = gpio##id##_pins,		\
+		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\
+		.funcs = (int[]){			\
+			msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9			\
+		},				        \
+		.nfuncs = 10,				\
+		.ctl_reg = REG_SIZE * id,		\
+		.io_reg = 0x4 + REG_SIZE * id,		\
+		.intr_cfg_reg = 0x8 + REG_SIZE * id,		\
+		.intr_status_reg = 0xc + REG_SIZE * id,	\
+		.intr_target_reg = 0x8 + REG_SIZE * id,	\
+		.mux_bit = 2,			\
+		.pull_bit = 0,			\
+		.drv_bit = 6,			\
+		.oe_bit = 9,			\
+		.in_bit = 0,			\
+		.out_bit = 1,			\
+		.intr_enable_bit = 0,		\
+		.intr_status_bit = 0,		\
+		.intr_target_bit = 5,		\
+		.intr_target_kpss_val = 3,	\
+		.intr_raw_status_bit = 4,	\
+		.intr_polarity_bit = 1,		\
+		.intr_detection_bit = 2,	\
+		.intr_detection_width = 2,	\
+	}
+
+static const struct pinctrl_pin_desc ipq5332_pins[] = {
+	PINCTRL_PIN(0, "GPIO_0"),
+	PINCTRL_PIN(1, "GPIO_1"),
+	PINCTRL_PIN(2, "GPIO_2"),
+	PINCTRL_PIN(3, "GPIO_3"),
+	PINCTRL_PIN(4, "GPIO_4"),
+	PINCTRL_PIN(5, "GPIO_5"),
+	PINCTRL_PIN(6, "GPIO_6"),
+	PINCTRL_PIN(7, "GPIO_7"),
+	PINCTRL_PIN(8, "GPIO_8"),
+	PINCTRL_PIN(9, "GPIO_9"),
+	PINCTRL_PIN(10, "GPIO_10"),
+	PINCTRL_PIN(11, "GPIO_11"),
+	PINCTRL_PIN(12, "GPIO_12"),
+	PINCTRL_PIN(13, "GPIO_13"),
+	PINCTRL_PIN(14, "GPIO_14"),
+	PINCTRL_PIN(15, "GPIO_15"),
+	PINCTRL_PIN(16, "GPIO_16"),
+	PINCTRL_PIN(17, "GPIO_17"),
+	PINCTRL_PIN(18, "GPIO_18"),
+	PINCTRL_PIN(19, "GPIO_19"),
+	PINCTRL_PIN(20, "GPIO_20"),
+	PINCTRL_PIN(21, "GPIO_21"),
+	PINCTRL_PIN(22, "GPIO_22"),
+	PINCTRL_PIN(23, "GPIO_23"),
+	PINCTRL_PIN(24, "GPIO_24"),
+	PINCTRL_PIN(25, "GPIO_25"),
+	PINCTRL_PIN(26, "GPIO_26"),
+	PINCTRL_PIN(27, "GPIO_27"),
+	PINCTRL_PIN(28, "GPIO_28"),
+	PINCTRL_PIN(29, "GPIO_29"),
+	PINCTRL_PIN(30, "GPIO_30"),
+	PINCTRL_PIN(31, "GPIO_31"),
+	PINCTRL_PIN(32, "GPIO_32"),
+	PINCTRL_PIN(33, "GPIO_33"),
+	PINCTRL_PIN(34, "GPIO_34"),
+	PINCTRL_PIN(35, "GPIO_35"),
+	PINCTRL_PIN(36, "GPIO_36"),
+	PINCTRL_PIN(37, "GPIO_37"),
+	PINCTRL_PIN(38, "GPIO_38"),
+	PINCTRL_PIN(39, "GPIO_39"),
+	PINCTRL_PIN(40, "GPIO_40"),
+	PINCTRL_PIN(41, "GPIO_41"),
+	PINCTRL_PIN(42, "GPIO_42"),
+	PINCTRL_PIN(43, "GPIO_43"),
+	PINCTRL_PIN(44, "GPIO_44"),
+	PINCTRL_PIN(45, "GPIO_45"),
+	PINCTRL_PIN(46, "GPIO_46"),
+	PINCTRL_PIN(47, "GPIO_47"),
+	PINCTRL_PIN(48, "GPIO_48"),
+	PINCTRL_PIN(49, "GPIO_49"),
+	PINCTRL_PIN(50, "GPIO_50"),
+	PINCTRL_PIN(51, "GPIO_51"),
+	PINCTRL_PIN(52, "GPIO_52"),
+};
+
+#define DECLARE_MSM_GPIO_PINS(pin) \
+	static const unsigned int gpio##pin##_pins[] = { pin }
+DECLARE_MSM_GPIO_PINS(0);
+DECLARE_MSM_GPIO_PINS(1);
+DECLARE_MSM_GPIO_PINS(2);
+DECLARE_MSM_GPIO_PINS(3);
+DECLARE_MSM_GPIO_PINS(4);
+DECLARE_MSM_GPIO_PINS(5);
+DECLARE_MSM_GPIO_PINS(6);
+DECLARE_MSM_GPIO_PINS(7);
+DECLARE_MSM_GPIO_PINS(8);
+DECLARE_MSM_GPIO_PINS(9);
+DECLARE_MSM_GPIO_PINS(10);
+DECLARE_MSM_GPIO_PINS(11);
+DECLARE_MSM_GPIO_PINS(12);
+DECLARE_MSM_GPIO_PINS(13);
+DECLARE_MSM_GPIO_PINS(14);
+DECLARE_MSM_GPIO_PINS(15);
+DECLARE_MSM_GPIO_PINS(16);
+DECLARE_MSM_GPIO_PINS(17);
+DECLARE_MSM_GPIO_PINS(18);
+DECLARE_MSM_GPIO_PINS(19);
+DECLARE_MSM_GPIO_PINS(20);
+DECLARE_MSM_GPIO_PINS(21);
+DECLARE_MSM_GPIO_PINS(22);
+DECLARE_MSM_GPIO_PINS(23);
+DECLARE_MSM_GPIO_PINS(24);
+DECLARE_MSM_GPIO_PINS(25);
+DECLARE_MSM_GPIO_PINS(26);
+DECLARE_MSM_GPIO_PINS(27);
+DECLARE_MSM_GPIO_PINS(28);
+DECLARE_MSM_GPIO_PINS(29);
+DECLARE_MSM_GPIO_PINS(30);
+DECLARE_MSM_GPIO_PINS(31);
+DECLARE_MSM_GPIO_PINS(32);
+DECLARE_MSM_GPIO_PINS(33);
+DECLARE_MSM_GPIO_PINS(34);
+DECLARE_MSM_GPIO_PINS(35);
+DECLARE_MSM_GPIO_PINS(36);
+DECLARE_MSM_GPIO_PINS(37);
+DECLARE_MSM_GPIO_PINS(38);
+DECLARE_MSM_GPIO_PINS(39);
+DECLARE_MSM_GPIO_PINS(40);
+DECLARE_MSM_GPIO_PINS(41);
+DECLARE_MSM_GPIO_PINS(42);
+DECLARE_MSM_GPIO_PINS(43);
+DECLARE_MSM_GPIO_PINS(44);
+DECLARE_MSM_GPIO_PINS(45);
+DECLARE_MSM_GPIO_PINS(46);
+DECLARE_MSM_GPIO_PINS(47);
+DECLARE_MSM_GPIO_PINS(48);
+DECLARE_MSM_GPIO_PINS(49);
+DECLARE_MSM_GPIO_PINS(50);
+DECLARE_MSM_GPIO_PINS(51);
+DECLARE_MSM_GPIO_PINS(52);
+
+enum ipq5332_functions {
+	msm_mux_atest_char,
+	msm_mux_atest_char0,
+	msm_mux_atest_char1,
+	msm_mux_atest_char2,
+	msm_mux_atest_char3,
+	msm_mux_atest_tic,
+	msm_mux_audio_pri,
+	msm_mux_audio_pri0,
+	msm_mux_audio_pri1,
+	msm_mux_audio_sec,
+	msm_mux_audio_sec0,
+	msm_mux_audio_sec1,
+	msm_mux_blsp0_i2c,
+	msm_mux_blsp0_spi,
+	msm_mux_blsp0_uart0,
+	msm_mux_blsp0_uart1,
+	msm_mux_blsp1_i2c0,
+	msm_mux_blsp1_i2c1,
+	msm_mux_blsp1_spi0,
+	msm_mux_blsp1_spi1,
+	msm_mux_blsp1_uart0,
+	msm_mux_blsp1_uart1,
+	msm_mux_blsp1_uart2,
+	msm_mux_blsp2_i2c0,
+	msm_mux_blsp2_i2c1,
+	msm_mux_blsp2_spi,
+	msm_mux_blsp2_spi0,
+	msm_mux_blsp2_spi1,
+	msm_mux_core_voltage,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_cri_trng2,
+	msm_mux_cri_trng3,
+	msm_mux_cxc_clk,
+	msm_mux_cxc_data,
+	msm_mux_dbg_out,
+	msm_mux_gcc_plltest,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_lock_det,
+	msm_mux_mac0,
+	msm_mux_mac1,
+	msm_mux_mdc0,
+	msm_mux_mdc1,
+	msm_mux_mdio0,
+	msm_mux_mdio1,
+	msm_mux_pc,
+	msm_mux_pcie0_clk,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk,
+	msm_mux_pcie1_wake,
+	msm_mux_pcie2_clk,
+	msm_mux_pcie2_wake,
+	msm_mux_pll_test,
+	msm_mux_prng_rosc0,
+	msm_mux_prng_rosc1,
+	msm_mux_prng_rosc2,
+	msm_mux_prng_rosc3,
+	msm_mux_pta,
+	msm_mux_pwm0,
+	msm_mux_pwm1,
+	msm_mux_pwm2,
+	msm_mux_pwm3,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_traceclk_b,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracectl_b,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qdss_tracedata_b,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_resout,
+	msm_mux_rx0,
+	msm_mux_rx1,
+	msm_mux_sdc_data,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_tsens_max,
+	msm_mux_wci_txd,
+	msm_mux_wci_rxd,
+	msm_mux_wsi_clk,
+	msm_mux_wsi_clk3,
+	msm_mux_wsi_data,
+	msm_mux_wsi_data3,
+	msm_mux_wsis_reset,
+	msm_mux_xfem,
+	msm_mux__,
+};
+
+static const char * const gpio_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
+	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48", "gpio49",
+	"gpio50", "gpio51", "gpio52",
+};
+
+static const char * const atest_char_groups[] = {
+	"gpio46",
+};
+
+static const char * const atest_char0_groups[] = {
+	"gpio0",
+};
+
+static const char * const atest_char1_groups[] = {
+	"gpio1",
+};
+
+static const char * const atest_char2_groups[] = {
+	"gpio2",
+};
+
+static const char * const atest_char3_groups[] = {
+	"gpio3",
+};
+
+static const char * const atest_tic_groups[] = {
+	"gpio9",
+};
+
+static const char * const audio_pri_groups[] = {
+	"gpio29", "gpio30", "gpio31", "gpio32",
+};
+
+static const char * const audio_pri0_groups[] = {
+	"gpio34", "gpio34",
+};
+
+static const char * const audio_pri1_groups[] = {
+	"gpio43", "gpio43",
+};
+
+static const char * const audio_sec_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio36",
+};
+
+static const char * const audio_sec0_groups[] = {
+	"gpio30", "gpio30",
+};
+
+static const char * const audio_sec1_groups[] = {
+	"gpio45", "gpio45",
+};
+
+static const char * const blsp0_i2c_groups[] = {
+	"gpio16", "gpio17",
+};
+
+static const char * const blsp0_spi_groups[] = {
+	"gpio14", "gpio15", "gpio16", "gpio17",
+};
+
+static const char * const blsp0_uart0_groups[] = {
+	"gpio18", "gpio19",
+};
+
+static const char * const blsp0_uart1_groups[] = {
+	"gpio27", "gpio28",
+};
+
+static const char * const blsp1_i2c0_groups[] = {
+	"gpio29", "gpio30",
+};
+
+static const char * const blsp1_i2c1_groups[] = {
+	"gpio40", "gpio41",
+};
+
+static const char * const blsp1_spi0_groups[] = {
+	"gpio29", "gpio30", "gpio31", "gpio32",
+};
+
+static const char * const blsp1_spi1_groups[] = {
+	"gpio25", "gpio26", "gpio27", "gpio28",
+};
+
+static const char * const blsp1_uart0_groups[] = {
+	"gpio14", "gpio15", "gpio16", "gpio17",
+};
+
+static const char * const blsp1_uart1_groups[] = {
+	"gpio25", "gpio26", "gpio27", "gpio28",
+};
+
+static const char * const blsp1_uart2_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio36",
+};
+
+static const char * const blsp2_i2c0_groups[] = {
+	"gpio43", "gpio45",
+};
+
+static const char * const blsp2_i2c1_groups[] = {
+	"gpio33", "gpio34",
+};
+
+static const char * const blsp2_spi_groups[] = {
+	"gpio37",
+};
+
+static const char * const blsp2_spi0_groups[] = {
+	"gpio33", "gpio34", "gpio35", "gpio36",
+};
+
+static const char * const blsp2_spi1_groups[] = {
+	"gpio40", "gpio41", "gpio42", "gpio52",
+};
+
+static const char * const core_voltage_groups[] = {
+	"gpio21", "gpio23",
+};
+
+static const char * const cri_trng0_groups[] = {
+	"gpio17",
+};
+
+static const char * const cri_trng1_groups[] = {
+	"gpio18",
+};
+
+static const char * const cri_trng2_groups[] = {
+	"gpio19",
+};
+
+static const char * const cri_trng3_groups[] = {
+	"gpio20",
+};
+
+static const char * const cxc_clk_groups[] = {
+	"gpio49",
+};
+
+static const char * const cxc_data_groups[] = {
+	"gpio50",
+};
+
+static const char * const dbg_out_groups[] = {
+	"gpio48",
+};
+
+static const char * const gcc_plltest_groups[] = {
+	"gpio43", "gpio45",
+};
+
+static const char * const gcc_tlmm_groups[] = {
+	"gpio44",
+};
+
+static const char * const lock_det_groups[] = {
+	"gpio51",
+};
+
+static const char * const mac0_groups[] = {
+	"gpio18",
+};
+
+static const char * const mac1_groups[] = {
+	"gpio19",
+};
+
+static const char * const mdc0_groups[] = {
+	"gpio25",
+};
+
+static const char * const mdc1_groups[] = {
+	"gpio27",
+};
+
+static const char * const mdio0_groups[] = {
+	"gpio26",
+};
+
+static const char * const mdio1_groups[] = {
+	"gpio28",
+};
+
+static const char * const pc_groups[] = {
+	"gpio35",
+};
+
+static const char * const pcie0_clk_groups[] = {
+	"gpio37",
+};
+
+static const char * const pcie0_wake_groups[] = {
+	"gpio39",
+};
+
+static const char * const pcie1_clk_groups[] = {
+	"gpio46",
+};
+
+static const char * const pcie1_wake_groups[] = {
+	"gpio48",
+};
+
+static const char * const pcie2_clk_groups[] = {
+	"gpio43",
+};
+
+static const char * const pcie2_wake_groups[] = {
+	"gpio45",
+};
+
+static const char * const pll_test_groups[] = {
+	"gpio49",
+};
+
+static const char * const prng_rosc0_groups[] = {
+	"gpio22",
+};
+
+static const char * const prng_rosc1_groups[] = {
+	"gpio24",
+};
+
+static const char * const prng_rosc2_groups[] = {
+	"gpio25",
+};
+
+static const char * const prng_rosc3_groups[] = {
+	"gpio26",
+};
+
+static const char * const pta_groups[] = {
+	"gpio49", "gpio50", "gpio51",
+};
+
+static const char * const pwm0_groups[] = {
+	"gpio43", "gpio44", "gpio45", "gpio46",
+};
+
+static const char * const pwm1_groups[] = {
+	"gpio29", "gpio30", "gpio31", "gpio32",
+};
+
+static const char * const pwm2_groups[] = {
+	"gpio25", "gpio26", "gpio27", "gpio28",
+};
+
+static const char * const pwm3_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11",
+};
+
+static const char * const qdss_cti_trig_in_a0_groups[] = {
+	"gpio5",
+};
+
+static const char * const qdss_cti_trig_in_a1_groups[] = {
+	"gpio7",
+};
+
+static const char * const qdss_cti_trig_in_b0_groups[] = {
+	"gpio47",
+};
+
+static const char * const qdss_cti_trig_in_b1_groups[] = {
+	"gpio49",
+};
+
+static const char * const qdss_cti_trig_out_a0_groups[] = {
+	"gpio4",
+};
+
+static const char * const qdss_cti_trig_out_a1_groups[] = {
+	"gpio6",
+};
+
+static const char * const qdss_cti_trig_out_b0_groups[] = {
+	"gpio46",
+};
+
+static const char * const qdss_cti_trig_out_b1_groups[] = {
+	"gpio48",
+};
+
+static const char * const qdss_traceclk_a_groups[] = {
+	"gpio8",
+};
+
+static const char * const qdss_traceclk_b_groups[] = {
+	"gpio45",
+};
+
+static const char * const qdss_tracectl_a_groups[] = {
+	"gpio9",
+};
+
+static const char * const qdss_tracectl_b_groups[] = {
+	"gpio44",
+};
+
+static const char * const qdss_tracedata_a_groups[] = {
+	"gpio10", "gpio11", "gpio12", "gpio13", "gpio14", "gpio15", "gpio16",
+	"gpio17", "gpio18", "gpio19", "gpio20", "gpio22", "gpio24", "gpio25",
+	"gpio26", "gpio27",
+};
+
+static const char * const qdss_tracedata_b_groups[] = {
+	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
+	"gpio43", "gpio52",
+};
+
+static const char * const qspi_clk_groups[] = {
+	"gpio13",
+};
+
+static const char * const qspi_cs_groups[] = {
+	"gpio12",
+};
+
+static const char * const qspi_data_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11",
+};
+
+static const char * const resout_groups[] = {
+	"gpio20",
+};
+
+static const char * const rx0_groups[] = {
+	"gpio48",
+};
+
+static const char * const rx1_groups[] = {
+	"gpio45",
+};
+
+static const char * const sdc_clk_groups[] = {
+	"gpio13",
+};
+
+static const char * const sdc_cmd_groups[] = {
+	"gpio12",
+};
+
+static const char * const sdc_data_groups[] = {
+	"gpio8", "gpio9", "gpio10", "gpio11",
+};
+
+static const char * const tsens_max_groups[] = {
+	"gpio28",
+};
+
+static const char * const wci_txd_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio36", "gpio43", "gpio45",
+};
+
+static const char * const wci_rxd_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio35", "gpio36", "gpio43", "gpio45",
+};
+
+static const char * const wsi_clk_groups[] = {
+	"gpio40", "gpio42",
+};
+
+static const char * const wsi_clk3_groups[] = {
+	"gpio43",
+};
+
+static const char * const wsi_data_groups[] = {
+	"gpio41", "gpio52",
+};
+
+static const char * const wsi_data3_groups[] = {
+	"gpio44",
+};
+
+static const char * const wsis_reset_groups[] = {
+	"gpio41",
+};
+
+static const char * const xfem_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+};
+
+static const struct msm_function ipq5332_functions[] = {
+	FUNCTION(atest_char),
+	FUNCTION(atest_char0),
+	FUNCTION(atest_char1),
+	FUNCTION(atest_char2),
+	FUNCTION(atest_char3),
+	FUNCTION(atest_tic),
+	FUNCTION(audio_pri),
+	FUNCTION(audio_pri0),
+	FUNCTION(audio_pri1),
+	FUNCTION(audio_sec),
+	FUNCTION(audio_sec0),
+	FUNCTION(audio_sec1),
+	FUNCTION(blsp0_i2c),
+	FUNCTION(blsp0_spi),
+	FUNCTION(blsp0_uart0),
+	FUNCTION(blsp0_uart1),
+	FUNCTION(blsp1_i2c0),
+	FUNCTION(blsp1_i2c1),
+	FUNCTION(blsp1_spi0),
+	FUNCTION(blsp1_spi1),
+	FUNCTION(blsp1_uart0),
+	FUNCTION(blsp1_uart1),
+	FUNCTION(blsp1_uart2),
+	FUNCTION(blsp2_i2c0),
+	FUNCTION(blsp2_i2c1),
+	FUNCTION(blsp2_spi),
+	FUNCTION(blsp2_spi0),
+	FUNCTION(blsp2_spi1),
+	FUNCTION(core_voltage),
+	FUNCTION(cri_trng0),
+	FUNCTION(cri_trng1),
+	FUNCTION(cri_trng2),
+	FUNCTION(cri_trng3),
+	FUNCTION(cxc_clk),
+	FUNCTION(cxc_data),
+	FUNCTION(dbg_out),
+	FUNCTION(gcc_plltest),
+	FUNCTION(gcc_tlmm),
+	FUNCTION(gpio),
+	FUNCTION(lock_det),
+	FUNCTION(mac0),
+	FUNCTION(mac1),
+	FUNCTION(mdc0),
+	FUNCTION(mdc1),
+	FUNCTION(mdio0),
+	FUNCTION(mdio1),
+	FUNCTION(pc),
+	FUNCTION(pcie0_clk),
+	FUNCTION(pcie0_wake),
+	FUNCTION(pcie1_clk),
+	FUNCTION(pcie1_wake),
+	FUNCTION(pcie2_clk),
+	FUNCTION(pcie2_wake),
+	FUNCTION(pll_test),
+	FUNCTION(prng_rosc0),
+	FUNCTION(prng_rosc1),
+	FUNCTION(prng_rosc2),
+	FUNCTION(prng_rosc3),
+	FUNCTION(pta),
+	FUNCTION(pwm0),
+	FUNCTION(pwm1),
+	FUNCTION(pwm2),
+	FUNCTION(pwm3),
+	FUNCTION(qdss_cti_trig_in_a0),
+	FUNCTION(qdss_cti_trig_in_a1),
+	FUNCTION(qdss_cti_trig_in_b0),
+	FUNCTION(qdss_cti_trig_in_b1),
+	FUNCTION(qdss_cti_trig_out_a0),
+	FUNCTION(qdss_cti_trig_out_a1),
+	FUNCTION(qdss_cti_trig_out_b0),
+	FUNCTION(qdss_cti_trig_out_b1),
+	FUNCTION(qdss_traceclk_a),
+	FUNCTION(qdss_traceclk_b),
+	FUNCTION(qdss_tracectl_a),
+	FUNCTION(qdss_tracectl_b),
+	FUNCTION(qdss_tracedata_a),
+	FUNCTION(qdss_tracedata_b),
+	FUNCTION(qspi_data),
+	FUNCTION(qspi_clk),
+	FUNCTION(qspi_cs),
+	FUNCTION(resout),
+	FUNCTION(rx0),
+	FUNCTION(rx1),
+	FUNCTION(sdc_data),
+	FUNCTION(sdc_clk),
+	FUNCTION(sdc_cmd),
+	FUNCTION(tsens_max),
+	FUNCTION(wci_txd),
+	FUNCTION(wci_rxd),
+	FUNCTION(wsi_clk),
+	FUNCTION(wsi_clk3),
+	FUNCTION(wsi_data),
+	FUNCTION(wsi_data3),
+	FUNCTION(wsis_reset),
+	FUNCTION(xfem),
+};
+
+static const struct msm_pingroup ipq5332_groups[] = {
+	PINGROUP(0, atest_char0, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(1, atest_char1, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(2, atest_char2, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(3, atest_char3, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(4, qdss_cti_trig_out_a0, wci_txd, wci_rxd, xfem, _, _, _, _,	 _),
+	PINGROUP(5, qdss_cti_trig_in_a0, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(6, qdss_cti_trig_out_a1, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(7, qdss_cti_trig_in_a1, wci_txd, wci_rxd, xfem, _, _, _, _, _),
+	PINGROUP(8, sdc_data, qspi_data, pwm3, qdss_traceclk_a, _, _, _, _, _),
+	PINGROUP(9, sdc_data, qspi_data, pwm3, qdss_tracectl_a, _, atest_tic, _, _, _),
+	PINGROUP(10, sdc_data, qspi_data, pwm3, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(11, sdc_data, qspi_data, pwm3, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(12, sdc_cmd, qspi_cs, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(13, sdc_clk, qspi_clk, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(14, blsp0_spi, blsp1_uart0, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(15, blsp0_spi, blsp1_uart0, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(16, blsp0_spi, blsp0_i2c, blsp1_uart0, _, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(17, blsp0_spi, blsp0_i2c, blsp1_uart0, _, cri_trng0, qdss_tracedata_a, _, _, _),
+	PINGROUP(18, blsp0_uart0, mac0, _, cri_trng1, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(19, blsp0_uart0, mac1, _, cri_trng2, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(20, resout, _, cri_trng3, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(21, core_voltage, _, _, _, _, _, _, _, _),
+	PINGROUP(22, _, prng_rosc0, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(23, core_voltage, _, _, _, _, _, _, _, _),
+	PINGROUP(24, _, prng_rosc1, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(25, mdc0, blsp1_uart1, blsp1_spi1, pwm2, _, _, prng_rosc2, qdss_tracedata_a, _),
+	PINGROUP(26, mdio0, blsp1_uart1, blsp1_spi1, pwm2, _, _, prng_rosc3, qdss_tracedata_a, _),
+	PINGROUP(27, mdc1, blsp0_uart1, blsp1_uart1, blsp1_spi1, pwm2, _, _, qdss_tracedata_a, _),
+	PINGROUP(28, mdio1, blsp0_uart1, blsp1_uart1, blsp1_spi1, pwm2, _, tsens_max, _, _),
+	PINGROUP(29, audio_pri, blsp1_spi0, blsp1_i2c0, pwm1, _, qdss_tracedata_b, _, _, _),
+	PINGROUP(30, audio_pri, blsp1_spi0, blsp1_i2c0, pwm1, audio_sec0, audio_sec0, _, qdss_tracedata_b, _),
+	PINGROUP(31, audio_pri, blsp1_spi0, pwm1, _, qdss_tracedata_b, _, _, _, _),
+	PINGROUP(32, audio_pri, blsp1_spi0, pwm1, _, qdss_tracedata_b, _, _, _, _),
+	PINGROUP(33, audio_sec, blsp1_uart2, blsp2_i2c1, blsp2_spi0, _, qdss_tracedata_b, _, _, _),
+	PINGROUP(34, audio_sec, blsp1_uart2, blsp2_i2c1, blsp2_spi0, audio_pri0, audio_pri0, _, qdss_tracedata_b, _),
+	PINGROUP(35, audio_sec, blsp1_uart2, pc, wci_rxd, blsp2_spi0,  _, qdss_tracedata_b, _, _),
+	PINGROUP(36, audio_sec, blsp1_uart2, wci_txd, wci_rxd, blsp2_spi0, _, qdss_tracedata_b, _, _),
+	PINGROUP(37, pcie0_clk, blsp2_spi, _, qdss_tracedata_b, _, _, _, _, _),
+	PINGROUP(38, _, qdss_tracedata_b, _, _, _, _, _, _, _),
+	PINGROUP(39, pcie0_wake, _, qdss_tracedata_b, _, _, _, _, _, _),
+	PINGROUP(40, wsi_clk, blsp1_i2c1, blsp2_spi1, _, _, qdss_tracedata_b, _, _, _),
+	PINGROUP(41, wsi_data, blsp1_i2c1, blsp2_spi1, _, _, qdss_tracedata_b, _, wsis_reset, _),
+	PINGROUP(42, wsi_clk, blsp2_spi1, _, qdss_tracedata_b, _, _, _, _, _),
+	PINGROUP(43, pcie2_clk, wci_txd, wci_rxd, blsp2_i2c0, pwm0, audio_pri1, audio_pri1, _, gcc_plltest),
+	PINGROUP(44, pwm0, _, gcc_tlmm, qdss_tracectl_b, _, wsi_data3, _, _, _),
+	PINGROUP(45, pcie2_wake, wci_txd, wci_rxd, blsp2_i2c0, rx1, pwm0, audio_sec1, audio_sec1, _),
+	PINGROUP(46, pcie1_clk, atest_char, pwm0, _, qdss_cti_trig_out_b0, _, _, _, _),
+	PINGROUP(47, _, qdss_cti_trig_in_b0, _, _, _, _, _, _, _),
+	PINGROUP(48, pcie1_wake, rx0, dbg_out, qdss_cti_trig_out_b1, _, _, _, _, _),
+	PINGROUP(49, pta, cxc_clk, pll_test, _, qdss_cti_trig_in_b1, _, _, _, _),
+	PINGROUP(50, pta, cxc_data, _, _, _, _, _, _, _),
+	PINGROUP(51, pta, lock_det, _, _, _, _, _, _, _),
+	PINGROUP(52, wsi_data, blsp2_spi1, _, qdss_tracedata_b, _, _, _, _, _),
+};
+
+static const struct msm_pinctrl_soc_data ipq5332_pinctrl = {
+	.pins = ipq5332_pins,
+	.npins = ARRAY_SIZE(ipq5332_pins),
+	.functions = ipq5332_functions,
+	.nfunctions = ARRAY_SIZE(ipq5332_functions),
+	.groups = ipq5332_groups,
+	.ngroups = ARRAY_SIZE(ipq5332_groups),
+	.ngpios = 53,
+};
+
+static int ipq5332_pinctrl_probe(struct platform_device *pdev)
+{
+	return msm_pinctrl_probe(pdev, &ipq5332_pinctrl);
+}
+
+static const struct of_device_id ipq5332_pinctrl_of_match[] = {
+	{ .compatible = "qcom,ipq5332-tlmm", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ipq5332_pinctrl_of_match);
+
+static struct platform_driver ipq5332_pinctrl_driver = {
+	.driver = {
+		.name = "ipq5332-tlmm",
+		.of_match_table = ipq5332_pinctrl_of_match,
+	},
+	.probe = ipq5332_pinctrl_probe,
+	.remove = msm_pinctrl_remove,
+};
+
+static int __init ipq5332_pinctrl_init(void)
+{
+	return platform_driver_register(&ipq5332_pinctrl_driver);
+}
+arch_initcall(ipq5332_pinctrl_init);
+
+static void __exit ipq5332_pinctrl_exit(void)
+{
+	platform_driver_unregister(&ipq5332_pinctrl_driver);
+}
+module_exit(ipq5332_pinctrl_exit);
+
+MODULE_DESCRIPTION("QTI IPQ5332 TLMM driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

