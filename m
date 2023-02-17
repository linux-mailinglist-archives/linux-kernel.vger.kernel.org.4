Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F869B060
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjBQQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjBQQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:14:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7C711BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:14:34 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HFgnU7014021;
        Fri, 17 Feb 2023 10:14:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4ASq5wE/HhzQqhHyWQhMtSzuKicwRma0UuxuFNS914g=;
 b=JldwFx4wJBCqoThIQPpMU+hDuj8pRWm51u1rXXMiNM8U0fee8m5k7AiE/eyUkRMxa7tL
 cKOr+ed9aAp5etCS0P3H7GQh59uonjsWTazc+mf79gKYLWDWNl//1smTnLyjXWqsdNC6
 xWgoFKDFA46wyAPm7f2CYxd1WCszhy3/qu1wbWMoM8cZxab9iPibRzhy/8qunlOL07C3
 /1KuUc8mJrA49tt/55xSe3dONGLRJf8dAMRNcY2xZlLm+wmltty+QlGxvg0qw65dQQqz
 UzPEGP2WogOZJsVRfvQbI1r9ZA7Lz8wh4c3xUy0VIYm4iyodyKMrdHeU6Phm+rSnHzOZ Mw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wm7t6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:14:14 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 17 Feb
 2023 10:14:10 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Fri, 17 Feb 2023 10:14:10 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AC98746B;
        Fri, 17 Feb 2023 16:14:10 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <cezary.rojewski@intel.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 08/10] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
Date:   Fri, 17 Feb 2023 16:14:08 +0000
Message-ID: <20230217161410.915202-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230217161410.915202-1-rf@opensource.cirrus.com>
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lDjTp5d3NasjmGv6GoevyTETQUwMX2lE
X-Proofpoint-ORIG-GUID: lDjTp5d3NasjmGv6GoevyTETQUwMX2lE
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS35L56 combines a high-performance mono audio amplifier, Class-H
tracking inductive boost converter, Halo Core(TM) DSP and a DC-DC boost
converter supporting Class-H tracking.

Supported control interfaces are I2C, SPI or SoundWire.
Supported audio interfaces are I2S/TDM or SoundWire.

Most chip functionality is controlled by on-board ROM firmware that is
always running. The driver must apply patch/tune to the firmware
before using the CS35L56.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                       |    1 +
 include/sound/cs35l56.h           |  266 ++++++
 sound/soc/codecs/Kconfig          |   34 +
 sound/soc/codecs/Makefile         |   10 +
 sound/soc/codecs/cs35l56-i2c.c    |   83 ++
 sound/soc/codecs/cs35l56-sdw.c    |  525 +++++++++++
 sound/soc/codecs/cs35l56-shared.c |  387 ++++++++
 sound/soc/codecs/cs35l56-spi.c    |   81 ++
 sound/soc/codecs/cs35l56.c        | 1451 +++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.h        |   77 ++
 10 files changed, 2915 insertions(+)
 create mode 100644 include/sound/cs35l56.h
 create mode 100644 sound/soc/codecs/cs35l56-i2c.c
 create mode 100644 sound/soc/codecs/cs35l56-sdw.c
 create mode 100644 sound/soc/codecs/cs35l56-shared.c
 create mode 100644 sound/soc/codecs/cs35l56-spi.c
 create mode 100644 sound/soc/codecs/cs35l56.c
 create mode 100644 sound/soc/codecs/cs35l56.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 970adbcefc2f..3d7aaa42b854 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5035,6 +5035,7 @@ L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
 F:	include/dt-bindings/sound/cs*
+F:	include/sound/cs*
 F:	sound/pci/hda/cs*
 F:	sound/pci/hda/hda_cs_dsp_ctl.*
 F:	sound/soc/codecs/cs*
diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
new file mode 100644
index 000000000000..5f8ea2dfaa21
--- /dev/null
+++ b/include/sound/cs35l56.h
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common definitions for Cirrus Logic CS35L56 smart amp
+ *
+ * Copyright (C) 2023 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef __CS35L56_H
+#define __CS35L56_H
+
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+
+#define CS35L56_DEVID					0x0000000
+#define CS35L56_REVID					0x0000004
+#define CS35L56_RELID					0x000000C
+#define CS35L56_OTPID					0x0000010
+#define CS35L56_SFT_RESET				0x0000020
+#define CS35L56_GLOBAL_ENABLES				0x0002014
+#define CS35L56_BLOCK_ENABLES				0x0002018
+#define CS35L56_BLOCK_ENABLES2				0x000201C
+#define CS35L56_REFCLK_INPUT				0x0002C04
+#define CS35L56_GLOBAL_SAMPLE_RATE			0x0002C0C
+#define CS35L56_ASP1_ENABLES1				0x0004800
+#define CS35L56_ASP1_CONTROL1				0x0004804
+#define CS35L56_ASP1_CONTROL2				0x0004808
+#define CS35L56_ASP1_CONTROL3				0x000480C
+#define CS35L56_ASP1_FRAME_CONTROL1			0x0004810
+#define CS35L56_ASP1_FRAME_CONTROL5			0x0004820
+#define CS35L56_ASP1_DATA_CONTROL1			0x0004830
+#define CS35L56_ASP1_DATA_CONTROL5			0x0004840
+#define CS35L56_DACPCM1_INPUT				0x0004C00
+#define CS35L56_DACPCM2_INPUT				0x0004C08
+#define CS35L56_ASP1TX1_INPUT				0x0004C20
+#define CS35L56_ASP1TX2_INPUT				0x0004C24
+#define CS35L56_ASP1TX3_INPUT				0x0004C28
+#define CS35L56_ASP1TX4_INPUT				0x0004C2C
+#define CS35L56_DSP1RX1_INPUT				0x0004C40
+#define CS35L56_DSP1RX2_INPUT				0x0004C44
+#define CS35L56_SWIRE_DP3_CH1_INPUT			0x0004C70
+#define CS35L56_SWIRE_DP3_CH2_INPUT			0x0004C74
+#define CS35L56_SWIRE_DP3_CH3_INPUT			0x0004C78
+#define CS35L56_SWIRE_DP3_CH4_INPUT			0x0004C7C
+#define CS35L56_SWIRE_DP3_CH5_INPUT			0x0004C80
+#define CS35L56_SWIRE_DP3_CH6_INPUT			0x0004C84
+#define CS35L56_IRQ1_CFG				0x000E000
+#define CS35L56_IRQ1_STATUS				0x000E004
+#define CS35L56_IRQ1_EINT_1				0x000E010
+#define CS35L56_IRQ1_EINT_2				0x000E014
+#define CS35L56_IRQ1_EINT_4				0x000E01C
+#define CS35L56_IRQ1_EINT_8				0x000E02C
+#define CS35L56_IRQ1_EINT_18				0x000E054
+#define CS35L56_IRQ1_EINT_20				0x000E05C
+#define CS35L56_IRQ1_MASK_1				0x000E090
+#define CS35L56_IRQ1_MASK_2				0x000E094
+#define CS35L56_IRQ1_MASK_4				0x000E09C
+#define CS35L56_IRQ1_MASK_8				0x000E0AC
+#define CS35L56_IRQ1_MASK_18				0x000E0D4
+#define CS35L56_IRQ1_MASK_20				0x000E0DC
+#define CS35L56_DSP_VIRTUAL1_MBOX_1			0x0011020
+#define CS35L56_DSP_VIRTUAL1_MBOX_2			0x0011024
+#define CS35L56_DSP_VIRTUAL1_MBOX_3			0x0011028
+#define CS35L56_DSP_VIRTUAL1_MBOX_4			0x001102C
+#define CS35L56_DSP_VIRTUAL1_MBOX_5			0x0011030
+#define CS35L56_DSP_VIRTUAL1_MBOX_6			0x0011034
+#define CS35L56_DSP_VIRTUAL1_MBOX_7			0x0011038
+#define CS35L56_DSP_VIRTUAL1_MBOX_8			0x001103C
+#define CS35L56_DSP_RESTRICT_STS1			0x00190F0
+#define CS35L56_DSP1_XMEM_PACKED_0			0x2000000
+#define CS35L56_DSP1_XMEM_PACKED_6143			0x2005FFC
+#define CS35L56_DSP1_XMEM_UNPACKED32_0			0x2400000
+#define CS35L56_DSP1_XMEM_UNPACKED32_4095		0x2403FFC
+#define CS35L56_DSP1_SYS_INFO_ID			0x25E0000
+#define CS35L56_DSP1_SYS_INFO_END			0x25E004C
+#define CS35L56_DSP1_AHBM_WINDOW_DEBUG_0		0x25E2040
+#define CS35L56_DSP1_AHBM_WINDOW_DEBUG_1		0x25E2044
+#define CS35L56_DSP1_XMEM_UNPACKED24_0			0x2800000
+#define CS35L56_DSP1_HALO_STATE_A1			0x2801E58
+#define CS35L56_DSP1_HALO_STATE				0x28021E0
+#define CS35L56_DSP1_PM_CUR_STATE_A1			0x2804000
+#define CS35L56_DSP1_PM_CUR_STATE			0x2804308
+#define CS35L56_DSP1_XMEM_UNPACKED24_8191		0x2807FFC
+#define CS35L56_DSP1_CORE_BASE				0x2B80000
+#define CS35L56_DSP1_SCRATCH1				0x2B805C0
+#define CS35L56_DSP1_SCRATCH2				0x2B805C8
+#define CS35L56_DSP1_SCRATCH3				0x2B805D0
+#define CS35L56_DSP1_SCRATCH4				0x2B805D8
+#define CS35L56_DSP1_YMEM_PACKED_0			0x2C00000
+#define CS35L56_DSP1_YMEM_PACKED_4604			0x2C047F0
+#define CS35L56_DSP1_YMEM_UNPACKED32_0			0x3000000
+#define CS35L56_DSP1_YMEM_UNPACKED32_3070		0x3002FF8
+#define CS35L56_DSP1_YMEM_UNPACKED24_0			0x3400000
+#define CS35L56_MAIN_RENDER_USER_MUTE			0x3400024
+#define CS35L56_MAIN_RENDER_USER_VOLUME			0x340002C
+#define CS35L56_MAIN_POSTURE_NUMBER			0x3400094
+#define CS35L56_TRANSDUCER_ACTUAL_PS			0x3400150
+#define CS35L56_DSP1_YMEM_UNPACKED24_6141		0x3405FF4
+#define CS35L56_DSP1_PMEM_0				0x3800000
+#define CS35L56_DSP1_PMEM_5114				0x3804FE8
+
+/* DEVID */
+#define CS35L56_DEVID_MASK				0x00FFFFFF
+
+/* REVID */
+#define CS35L56_AREVID_MASK				0x000000F0
+#define CS35L56_MTLREVID_MASK				0x0000000F
+#define CS35L56_REVID_B0				0x000000B0
+
+/* ASP_ENABLES1 */
+#define CS35L56_ASP_RX2_EN_SHIFT			17
+#define CS35L56_ASP_RX1_EN_SHIFT			16
+#define CS35L56_ASP_TX4_EN_SHIFT			3
+#define CS35L56_ASP_TX3_EN_SHIFT			2
+#define CS35L56_ASP_TX2_EN_SHIFT			1
+#define CS35L56_ASP_TX1_EN_SHIFT			0
+
+/* ASP_CONTROL1 */
+#define CS35L56_ASP_BCLK_FREQ_MASK			0x0000003F
+#define CS35L56_ASP_BCLK_FREQ_SHIFT			0
+
+/* ASP_CONTROL2 */
+#define CS35L56_ASP_RX_WIDTH_MASK			0xFF000000
+#define CS35L56_ASP_RX_WIDTH_SHIFT			24
+#define CS35L56_ASP_TX_WIDTH_MASK			0x00FF0000
+#define CS35L56_ASP_TX_WIDTH_SHIFT			16
+#define CS35L56_ASP_FMT_MASK				0x00000700
+#define CS35L56_ASP_FMT_SHIFT				8
+#define CS35L56_ASP_BCLK_INV_MASK			0x00000040
+#define CS35L56_ASP_FSYNC_INV_MASK			0x00000004
+
+/* ASP_CONTROL3 */
+#define CS35L56_ASP1_DOUT_HIZ_CTRL_MASK			0x00000003
+
+/* ASP_DATA_CONTROL1 */
+#define CS35L56_ASP_TX_WL_MASK				0x0000003F
+
+/* ASP_DATA_CONTROL5 */
+#define CS35L56_ASP_RX_WL_MASK				0x0000003F
+
+/* ASPTXn_INPUT */
+#define CS35L56_ASP_TXn_SRC_MASK			0x0000007F
+
+/* SWIRETX[1..7]_SRC SDWTXn INPUT */
+#define CS35L56_SWIRETXn_SRC_MASK			0x0000007F
+
+/* IRQ1_STATUS */
+#define CS35L56_IRQ1_STS_MASK				0x00000001
+
+/* IRQ1_EINT_1 */
+#define CS35L56_AMP_SHORT_ERR_EINT1_MASK		0x80000000
+
+/* IRQ1_EINT_2 */
+#define CS35L56_DSP_VIRTUAL2_MBOX_WR_EINT1_MASK		0x00200000
+
+/* IRQ1_EINT_4 */
+#define CS35L56_OTP_BOOT_DONE_MASK			0x00000002
+
+/* IRQ1_EINT_8 */
+#define CS35L56_TEMP_ERR_EINT1_MASK			0x80000000
+
+/* Mixer input sources */
+#define CS35L56_INPUT_SRC_NONE				0x00
+#define CS35L56_INPUT_SRC_ASP1RX1			0x08
+#define CS35L56_INPUT_SRC_ASP1RX2			0x09
+#define CS35L56_INPUT_SRC_VMON				0x18
+#define CS35L56_INPUT_SRC_IMON				0x19
+#define CS35L56_INPUT_SRC_ERR_VOL			0x20
+#define CS35L56_INPUT_SRC_CLASSH			0x21
+#define CS35L56_INPUT_SRC_VDDBMON			0x28
+#define CS35L56_INPUT_SRC_VBSTMON			0x29
+#define CS35L56_INPUT_SRC_DSP1TX1			0x32
+#define CS35L56_INPUT_SRC_DSP1TX2			0x33
+#define CS35L56_INPUT_SRC_DSP1TX3			0x34
+#define CS35L56_INPUT_SRC_DSP1TX4			0x35
+#define CS35L56_INPUT_SRC_DSP1TX5			0x36
+#define CS35L56_INPUT_SRC_DSP1TX6			0x37
+#define CS35L56_INPUT_SRC_DSP1TX7			0x38
+#define CS35L56_INPUT_SRC_DSP1TX8			0x39
+#define CS35L56_INPUT_SRC_TEMPMON			0x3A
+#define CS35L56_INPUT_SRC_INTERPOLATOR			0x40
+#define CS35L56_INPUT_SRC_SWIRE_RX1			0x44
+#define CS35L56_INPUT_SRC_SWIRE_RX2			0x45
+#define CS35L56_INPUT_SRC_SWIRE_RX3			0x46
+#define CS35L56_INPUT_MASK				0x7F
+
+#define CS35L56_NUM_INPUT_SRC				22
+
+/* ASP formats */
+#define CS35L56_ASP_FMT_DSP_A				0
+#define CS35L56_ASP_FMT_I2S				2
+
+/* ASP HiZ modes */
+#define CS35L56_ASP_UNUSED_HIZ_OFF_HIZ			3
+
+/* MAIN_RENDER_ACTUAL_PS */
+#define CS35L56_PS0					0
+#define CS35L56_PS3					3
+
+/* CS35L56_DSP_RESTRICT_STS1 */
+#define CS35L56_RESTRICTED_MASK				0x7
+
+/* CS35L56_MAIN_RENDER_USER_MUTE */
+#define CS35L56_MAIN_RENDER_USER_MUTE_MASK		1
+
+/* CS35L56_MAIN_RENDER_USER_VOLUME */
+#define CS35L56_MAIN_RENDER_USER_VOLUME_MIN		-400
+#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		400
+#define CS35L56_MAIN_RENDER_USER_VOLUME_MASK		0x0000FFC0
+#define CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT		6
+#define CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT		9
+
+/* CS35L56_MAIN_POSTURE_NUMBER */
+#define CS35L56_MAIN_POSTURE_MIN			0
+#define CS35L56_MAIN_POSTURE_MAX			255
+#define CS35L56_MAIN_POSTURE_MASK			CS35L56_MAIN_POSTURE_MAX
+
+/* Software Values */
+#define CS35L56_HALO_STATE_SHUTDOWN			1
+#define CS35L56_HALO_STATE_BOOT_DONE			2
+
+#define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
+#define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
+#define CS35L56_MBOX_CMD_HIBERNATE_NOW			0x02000001
+#define CS35L56_MBOX_CMD_WAKEUP				0x02000002
+#define CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE		0x02000003
+#define CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE		0x02000004
+#define CS35L56_MBOX_CMD_SHUTDOWN			0x02000005
+#define CS35L56_MBOX_CMD_SYSTEM_RESET			0x02000007
+
+#define CS35L56_MBOX_TIMEOUT_US				5000
+#define CS35L56_MBOX_POLL_US				250
+
+#define CS35L56_PS0_POLL_US				500
+#define CS35L56_PS0_TIMEOUT_US				50000
+#define CS35L56_PS3_POLL_US				500
+#define CS35L56_PS3_TIMEOUT_US				300000
+
+#define CS35L56_CONTROL_PORT_READY_US			2200
+#define CS35L56_HALO_STATE_POLL_US			1000
+#define CS35L56_HALO_STATE_TIMEOUT_US			50000
+#define CS35L56_HIBERNATE_WAKE_POLL_US			500
+#define CS35L56_HIBERNATE_WAKE_TIMEOUT_US		5000
+#define CS35L56_RESET_PULSE_MIN_US			1100
+
+#define CS35L56_SDW1_PLAYBACK_PORT			1
+#define CS35L56_SDW1_CAPTURE_PORT			3
+
+#define CS35L56_NUM_BULK_SUPPLIES			3
+#define CS35L56_NUM_DSP_REGIONS				5
+
+extern struct regmap_config cs35l56_regmap_i2c;
+extern struct regmap_config cs35l56_regmap_spi;
+extern struct regmap_config cs35l56_regmap_sdw;
+
+extern const struct cs_dsp_region cs35l56_dsp1_regions[CS35L56_NUM_DSP_REGIONS];
+extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
+extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
+
+void cs35l56_patch(struct device *dev, struct regmap *regmap, u8 revid);
+void cs35l56_reread_firmware_registers(struct device *dev, struct regmap *regmap);
+int cs35l56_get_bclk_freq_id(unsigned int freq);
+void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
+
+#endif /* ifndef __CS35L56_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bd72c426a93d..e2dbbea68d11 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,6 +68,9 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS35L41_I2C
 	imply SND_SOC_CS35L45_I2C
 	imply SND_SOC_CS35L45_SPI
+	imply SND_SOC_CS35L56_I2C
+	imply SND_SOC_CS35L56_SPI
+	imply SND_SOC_CS35L56_SDW
 	imply SND_SOC_CS42L42
 	imply SND_SOC_CS42L42_SDW
 	imply SND_SOC_CS42L51_I2C
@@ -364,6 +367,7 @@ config SND_SOC_WM_ADSP
 	default y if SND_SOC_WM2200=y
 	default y if SND_SOC_CS35L41_SPI=y
 	default y if SND_SOC_CS35L41_I2C=y
+	default y if SND_SOC_CS35L56=y
 	default m if SND_SOC_MADERA=m
 	default m if SND_SOC_CS47L24=m
 	default m if SND_SOC_WM5102=m
@@ -371,6 +375,7 @@ config SND_SOC_WM_ADSP
 	default m if SND_SOC_WM2200=m
 	default m if SND_SOC_CS35L41_SPI=m
 	default m if SND_SOC_CS35L41_I2C=m
+	default m if SND_SOC_CS35L56=m
 
 config SND_SOC_AB8500_CODEC
 	tristate
@@ -711,6 +716,35 @@ config SND_SOC_CS35L45_I2C
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
 	  with I2C control.
 
+config SND_SOC_CS35L56
+	tristate
+
+config SND_SOC_CS35L56_SHARED
+	tristate
+
+config SND_SOC_CS35L56_I2C
+	tristate "Cirrus Logic CS35L56 CODEC (I2C)"
+	depends on I2C
+	select SERIAL_MULTI_INSTANTIATE
+	select REGMAP_I2C
+	select SND_SOC_CS35L56
+	select SND_SOC_CS35L56_SHARED
+
+config SND_SOC_CS35L56_SPI
+	tristate "Cirrus Logic CS35L56 CODEC (SPI)"
+	depends on SPI_MASTER
+	select SERIAL_MULTI_INSTANTIATE
+	select REGMAP_SPI
+	select SND_SOC_CS35L56
+	select SND_SOC_CS35L56_SHARED
+
+config SND_SOC_CS35L56_SDW
+	tristate "Cirrus Logic CS35L56 CODEC (SDW)"
+	depends on SOUNDWIRE
+	select REGMAP
+	select SND_SOC_CS35L56
+	select SND_SOC_CS35L56_SHARED
+
 config SND_SOC_CS42L42_CORE
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f1ca18f7946c..25ebce58a0ba 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -66,6 +66,11 @@ snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o
 snd-soc-cs35l45-objs := cs35l45.o cs35l45-tables.o
 snd-soc-cs35l45-spi-objs := cs35l45-spi.o
 snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
+snd-soc-cs35l56-objs := cs35l56.o
+snd-soc-cs35l56-shared-objs := cs35l56-shared.o
+snd-soc-cs35l56-i2c-objs := cs35l56-i2c.o
+snd-soc-cs35l56-spi-objs := cs35l56-spi.o
+snd-soc-cs35l56-sdw-objs := cs35l56-sdw.o
 snd-soc-cs42l42-objs := cs42l42.o
 snd-soc-cs42l42-i2c-objs := cs42l42-i2c.o
 snd-soc-cs42l42-sdw-objs := cs42l42-sdw.o
@@ -433,6 +438,11 @@ obj-$(CONFIG_SND_SOC_CS35L41_I2C)	+= snd-soc-cs35l41-i2c.o
 obj-$(CONFIG_SND_SOC_CS35L45)	+= snd-soc-cs35l45.o
 obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
 obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
+obj-$(CONFIG_SND_SOC_CS35L56)	+= snd-soc-cs35l56.o
+obj-$(CONFIG_SND_SOC_CS35L56_SHARED)	+= snd-soc-cs35l56-shared.o
+obj-$(CONFIG_SND_SOC_CS35L56_I2C)	+= snd-soc-cs35l56-i2c.o
+obj-$(CONFIG_SND_SOC_CS35L56_SPI)	+= snd-soc-cs35l56-spi.o
+obj-$(CONFIG_SND_SOC_CS35L56_SDW)	+= snd-soc-cs35l56-sdw.o
 obj-$(CONFIG_SND_SOC_CS42L42_CORE)	+= snd-soc-cs42l42.o
 obj-$(CONFIG_SND_SOC_CS42L42)	+= snd-soc-cs42l42-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L42_SDW)	+= snd-soc-cs42l42-sdw.o
diff --git a/sound/soc/codecs/cs35l56-i2c.c b/sound/soc/codecs/cs35l56-i2c.c
new file mode 100644
index 000000000000..4b7f034a7670
--- /dev/null
+++ b/sound/soc/codecs/cs35l56-i2c.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// CS35L56 ALSA SoC audio driver I2C binding
+//
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "cs35l56.h"
+
+static int cs35l56_i2c_probe(struct i2c_client *client)
+{
+	struct cs35l56_private *cs35l56;
+	struct device *dev = &client->dev;
+	const struct regmap_config *regmap_config = &cs35l56_regmap_i2c;
+	int ret;
+
+	cs35l56 = devm_kzalloc(dev, sizeof(struct cs35l56_private), GFP_KERNEL);
+	if (!cs35l56)
+		return -ENOMEM;
+
+	cs35l56->dev = dev;
+	cs35l56->irq = client->irq;
+	cs35l56->can_hibernate = true;
+
+	i2c_set_clientdata(client, cs35l56);
+	cs35l56->regmap = devm_regmap_init_i2c(client, regmap_config);
+	if (IS_ERR(cs35l56->regmap)) {
+		ret = PTR_ERR(cs35l56->regmap);
+		return dev_err_probe(cs35l56->dev, ret, "Failed to allocate register map\n");
+	}
+
+	ret = cs35l56_common_probe(cs35l56);
+	if (ret != 0)
+		return ret;
+
+	ret = cs35l56_init(cs35l56);
+	if (ret == 0)
+		ret = cs35l56_irq_request(cs35l56);
+	if (ret < 0)
+		cs35l56_remove(cs35l56);
+
+	return ret;
+}
+
+static void cs35l56_i2c_remove(struct i2c_client *client)
+{
+	struct cs35l56_private *cs35l56 = i2c_get_clientdata(client);
+
+	cs35l56_remove(cs35l56);
+}
+
+static const struct i2c_device_id cs35l56_id_i2c[] = {
+	{ "cs35l56", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs35l56_id_i2c);
+
+static struct i2c_driver cs35l56_i2c_driver = {
+	.driver = {
+		.name		= "cs35l56",
+		.pm = &cs35l56_pm_ops_i2c_spi,
+	},
+	.id_table	= cs35l56_id_i2c,
+	.probe_new	= cs35l56_i2c_probe,
+	.remove		= cs35l56_i2c_remove,
+};
+
+module_i2c_driver(cs35l56_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS35L56 I2C driver");
+MODULE_IMPORT_NS(SND_SOC_CS35L56_CORE);
+MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
new file mode 100644
index 000000000000..4fe3cfacfe52
--- /dev/null
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// CS35L56 ALSA SoC audio driver SoundWire binding
+//
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/swab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "cs35l56.h"
+
+/* Register addresses are offset when sent over SoundWire */
+#define CS35L56_SDW_ADDR_OFFSET		0x8000
+
+static int cs35l56_sdw_read_one(struct sdw_slave *peripheral, unsigned int reg, void *buf)
+{
+	int ret;
+
+	ret = sdw_nread_no_pm(peripheral, reg, 4, (u8 *)buf);
+	if (ret != 0) {
+		dev_err(&peripheral->dev, "Read failed @%#x:%d\n", reg, ret);
+		return ret;
+	}
+
+	swab32s((u32 *)buf);
+
+	return 0;
+}
+
+static int cs35l56_sdw_read(void *context, const void *reg_buf,
+			    const size_t reg_size, void *val_buf,
+			    size_t val_size)
+{
+	struct sdw_slave *peripheral = context;
+	u8 *buf8 = val_buf;
+	unsigned int reg, bytes;
+	int ret;
+
+	reg = le32_to_cpu(*(const __le32 *)reg_buf);
+	reg += CS35L56_SDW_ADDR_OFFSET;
+
+	if (val_size == 4)
+		return cs35l56_sdw_read_one(peripheral, reg, val_buf);
+
+	while (val_size) {
+		bytes = SDW_REG_NO_PAGE - (reg & SDW_REGADDR); /* to end of page */
+		if (bytes > val_size)
+			bytes = val_size;
+
+		ret = sdw_nread_no_pm(peripheral, reg, bytes, buf8);
+		if (ret != 0) {
+			dev_err(&peripheral->dev, "Read failed @%#x..%#x:%d\n",
+				reg, reg + bytes - 1, ret);
+			return ret;
+		}
+
+		swab32_array((u32 *)buf8, bytes / 4);
+		val_size -= bytes;
+		reg += bytes;
+		buf8 += bytes;
+	}
+
+	return 0;
+}
+
+static inline void cs35l56_swab_copy(void *dest, const void *src, size_t nbytes)
+{
+	u32 *dest32 = dest;
+	const u32 *src32 = src;
+
+	for (; nbytes > 0; nbytes -= 4)
+		*dest32++ = swab32(*src32++);
+}
+
+static int cs35l56_sdw_write_one(struct sdw_slave *peripheral, unsigned int reg, const void *buf)
+{
+	u32 val_le = swab32(*(u32 *)buf);
+	int ret;
+
+	ret = sdw_nwrite_no_pm(peripheral, reg, 4, (u8 *)&val_le);
+	if (ret != 0) {
+		dev_err(&peripheral->dev, "Write failed @%#x:%d\n", reg, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cs35l56_sdw_gather_write(void *context,
+				    const void *reg_buf, size_t reg_size,
+				    const void *val_buf, size_t val_size)
+{
+	struct sdw_slave *peripheral = context;
+	const u8 *src_be = val_buf;
+	u32 val_le_buf[64];	/* Define u32 so it is 32-bit aligned */
+	unsigned int reg, bytes;
+	int ret;
+
+	reg = le32_to_cpu(*(const __le32 *)reg_buf);
+	reg += CS35L56_SDW_ADDR_OFFSET;
+
+	if (val_size == 4)
+		return cs35l56_sdw_write_one(peripheral, reg, src_be);
+
+	while (val_size) {
+		bytes = SDW_REG_NO_PAGE - (reg & SDW_REGADDR); /* to end of page */
+		if (bytes > val_size)
+			bytes = val_size;
+		if (bytes > sizeof(val_le_buf))
+			bytes = sizeof(val_le_buf);
+
+		cs35l56_swab_copy(val_le_buf, src_be, bytes);
+
+		ret = sdw_nwrite_no_pm(peripheral, reg, bytes, (u8 *)val_le_buf);
+		if (ret != 0) {
+			dev_err(&peripheral->dev, "Write failed @%#x..%#x:%d\n",
+				reg, reg + bytes - 1, ret);
+			return ret;
+		}
+
+		val_size -= bytes;
+		reg += bytes;
+		src_be += bytes;
+	}
+
+	return 0;
+}
+
+static int cs35l56_sdw_write(void *context, const void *val_buf, size_t val_size)
+{
+	const u8 *src_buf = val_buf;
+
+	/* First word of val_buf contains the destination address */
+	return cs35l56_sdw_gather_write(context, &src_buf[0], 4, &src_buf[4], val_size - 4);
+}
+
+/*
+ * Registers are big-endian on I2C and SPI but little-endian on SoundWire.
+ * Exported firmware controls are big-endian on I2C/SPI but little-endian on
+ * SoundWire. Firmware files are always big-endian and are opaque blobs.
+ * Present a big-endian regmap and hide the endianness swap, so that the ALSA
+ * byte controls always have the same byte order, and firmware file blobs
+ * can be written verbatim.
+ */
+static const struct regmap_bus cs35l56_regmap_bus_sdw = {
+	.read = cs35l56_sdw_read,
+	.write = cs35l56_sdw_write,
+	.gather_write = cs35l56_sdw_gather_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static void cs35l56_sdw_init(struct sdw_slave *peripheral)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+	int ret;
+
+	pm_runtime_get_noresume(cs35l56->dev);
+
+	regcache_cache_only(cs35l56->regmap, false);
+
+	ret = cs35l56_init(cs35l56);
+	if (ret < 0) {
+		regcache_cache_only(cs35l56->regmap, true);
+		goto out;
+	}
+
+	/*
+	 * cs35l56_init can return with !init_done if it triggered
+	 * a soft reset.
+	 */
+	if (cs35l56->init_done) {
+		/* Enable SoundWire interrupts */
+		sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1,
+				CS35L56_SDW_INT_MASK_CODEC_IRQ);
+	}
+
+out:
+	pm_runtime_mark_last_busy(cs35l56->dev);
+	pm_runtime_put_autosuspend(cs35l56->dev);
+}
+
+static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
+				 struct sdw_slave_intr_status *status)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+
+	/* SoundWire core holds our pm_runtime when calling this function. */
+
+	dev_dbg(cs35l56->dev, "int control_port=%#x\n", status->control_port);
+
+	if ((status->control_port & SDW_SCP_INT1_IMPL_DEF) == 0)
+		return 0;
+
+	/* Prevent host controller suspending before we handle the interrupt */
+	pm_runtime_get_noresume(cs35l56->dev);
+
+	/*
+	 * Mask and clear until it has been handled. The read of GEN_INT_STAT_1
+	 * is required as per the SoundWire spec for interrupt status bits
+	 * to clear. GEN_INT_MASK_1 masks the _inputs_ to GEN_INT_STAT1.
+	 * None of the interrupts are time-critical so use the
+	 * power-efficient queue.
+	 */
+	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
+	sdw_read_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1);
+	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
+	queue_work(system_power_efficient_wq, &cs35l56->sdw_irq_work);
+
+	return 0;
+}
+
+static void cs35l56_sdw_irq_work(struct work_struct *work)
+{
+	struct cs35l56_private *cs35l56 = container_of(work,
+						       struct cs35l56_private,
+						       sdw_irq_work);
+
+	cs35l56_irq(-1, cs35l56);
+
+	/* unmask interrupts */
+	if (!cs35l56->sdw_irq_no_unmask)
+		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
+				CS35L56_SDW_INT_MASK_CODEC_IRQ);
+
+	pm_runtime_put_autosuspend(cs35l56->dev);
+}
+
+static int cs35l56_sdw_read_prop(struct sdw_slave *peripheral)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+	struct sdw_slave_prop *prop = &peripheral->prop;
+	struct sdw_dpn_prop *ports;
+
+	ports = devm_kcalloc(cs35l56->dev, 2, sizeof(*ports), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+
+	prop->source_ports = BIT(CS35L56_SDW1_CAPTURE_PORT);
+	prop->sink_ports = BIT(CS35L56_SDW1_PLAYBACK_PORT);
+	prop->paging_support = true;
+	prop->clk_stop_mode1 = false;
+	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY | SDW_SCP_INT1_IMPL_DEF;
+
+	/* DP1 - playback */
+	ports[0].num = CS35L56_SDW1_PLAYBACK_PORT;
+	ports[0].type = SDW_DPN_FULL;
+	ports[0].ch_prep_timeout = 10;
+	prop->sink_dpn_prop = &ports[0];
+
+	/* DP3 - capture */
+	ports[1].num = CS35L56_SDW1_CAPTURE_PORT;
+	ports[1].type = SDW_DPN_FULL;
+	ports[1].ch_prep_timeout = 10;
+	prop->src_dpn_prop = &ports[1];
+
+	return 0;
+}
+
+static int cs35l56_sdw_update_status(struct sdw_slave *peripheral,
+				     enum sdw_slave_status status)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+
+	switch (status) {
+	case SDW_SLAVE_ATTACHED:
+		dev_dbg(cs35l56->dev, "%s: ATTACHED\n", __func__);
+		if (cs35l56->sdw_attached)
+			break;
+
+		if (!cs35l56->init_done || cs35l56->soft_resetting)
+			cs35l56_sdw_init(peripheral);
+
+		cs35l56->sdw_attached = true;
+		break;
+	case SDW_SLAVE_UNATTACHED:
+		dev_dbg(cs35l56->dev, "%s: UNATTACHED\n", __func__);
+		cs35l56->sdw_attached = false;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cs35l56_a1_kick_divider(struct cs35l56_private *cs35l56,
+				   struct sdw_slave *peripheral)
+{
+	unsigned int curr_scale_reg, next_scale_reg;
+	int curr_scale, next_scale, ret;
+
+	if (!cs35l56->init_done)
+		return 0;
+
+	if (peripheral->bus->params.curr_bank) {
+		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
+		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
+	} else {
+		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
+		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
+	}
+
+	/*
+	 * Current clock scale value must be different to new value.
+	 * Modify current to guarantee this. If next still has the dummy
+	 * value we wrote when it was current, the core code has not set
+	 * a new scale so restore its original good value
+	 */
+	curr_scale = sdw_read_no_pm(peripheral, curr_scale_reg);
+	if (curr_scale < 0) {
+		dev_err(cs35l56->dev, "Failed to read current clock scale: %d\n", curr_scale);
+		return curr_scale;
+	}
+
+	next_scale = sdw_read_no_pm(peripheral, next_scale_reg);
+	if (next_scale < 0) {
+		dev_err(cs35l56->dev, "Failed to read next clock scale: %d\n", next_scale);
+		return next_scale;
+	}
+
+	if (next_scale == CS35L56_SDW_INVALID_BUS_SCALE) {
+		next_scale = cs35l56->old_sdw_clock_scale;
+		ret = sdw_write_no_pm(peripheral, next_scale_reg, next_scale);
+		if (ret < 0) {
+			dev_err(cs35l56->dev, "Failed to modify current clock scale: %d\n", ret);
+			return ret;
+		}
+	}
+
+	cs35l56->old_sdw_clock_scale = curr_scale;
+	ret = sdw_write_no_pm(peripheral, curr_scale_reg, CS35L56_SDW_INVALID_BUS_SCALE);
+	if (ret < 0) {
+		dev_err(cs35l56->dev, "Failed to modify current clock scale: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(cs35l56->dev, "Next bus scale: %#x\n", next_scale);
+
+	return 0;
+}
+
+static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
+				  struct sdw_bus_params *params)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+	int sclk;
+
+	sclk = params->curr_dr_freq / 2;
+	dev_dbg(cs35l56->dev, "%s: sclk=%u c=%u r=%u\n", __func__, sclk, params->col, params->row);
+
+	if (cs35l56->rev < 0xb0)
+		return cs35l56_a1_kick_divider(cs35l56, peripheral);
+
+	return 0;
+}
+
+static int __maybe_unused cs35l56_sdw_clk_stop(struct sdw_slave *peripheral,
+					       enum sdw_clk_stop_mode mode,
+					       enum sdw_clk_stop_type type)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+
+	dev_dbg(cs35l56->dev, "%s: mode:%d type:%d\n", __func__, mode, type);
+
+	return 0;
+}
+
+static const struct sdw_slave_ops cs35l56_sdw_ops = {
+	.read_prop = cs35l56_sdw_read_prop,
+	.interrupt_callback = cs35l56_sdw_interrupt,
+	.update_status = cs35l56_sdw_update_status,
+	.bus_config = cs35l56_sdw_bus_config,
+#ifdef DEBUG
+	.clk_stop = cs35l56_sdw_clk_stop,
+#endif
+};
+
+static int __maybe_unused cs35l56_sdw_handle_unattach(struct cs35l56_private *cs35l56)
+{
+	struct sdw_slave *peripheral = cs35l56->sdw_peripheral;
+
+	if (peripheral->unattach_request) {
+		/* Cannot access registers until master re-attaches. */
+		dev_dbg(cs35l56->dev, "Wait for initialization_complete\n");
+		if (!wait_for_completion_timeout(&peripheral->initialization_complete,
+						 msecs_to_jiffies(5000))) {
+			dev_err(cs35l56->dev, "initialization_complete timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		peripheral->unattach_request = 0;
+
+		/*
+		 * Don't call regcache_mark_dirty(), we can't be sure that the
+		 * Manager really did issue a Bus Reset.
+		 */
+	}
+
+	return 0;
+}
+
+static int __maybe_unused cs35l56_sdw_runtime_suspend(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	if (!cs35l56->init_done)
+		return 0;
+
+	return cs35l56_runtime_suspend(dev);
+}
+
+static int __maybe_unused cs35l56_sdw_runtime_resume(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "Runtime resume\n");
+
+	if (!cs35l56->init_done)
+		return 0;
+
+	ret = cs35l56_sdw_handle_unattach(cs35l56);
+	if (ret < 0)
+		return ret;
+
+	ret = cs35l56_runtime_resume_common(cs35l56);
+	if (ret)
+		return ret;
+
+	/* Re-enable SoundWire interrupts */
+	sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
+			CS35L56_SDW_INT_MASK_CODEC_IRQ);
+
+	return 0;
+}
+
+static int cs35l56_sdw_probe(struct sdw_slave *peripheral, const struct sdw_device_id *id)
+{
+	struct device *dev = &peripheral->dev;
+	struct cs35l56_private *cs35l56;
+	int ret;
+
+	cs35l56 = devm_kzalloc(dev, sizeof(*cs35l56), GFP_KERNEL);
+	if (!cs35l56)
+		return -ENOMEM;
+
+	cs35l56->dev = dev;
+	cs35l56->sdw_peripheral = peripheral;
+	INIT_WORK(&cs35l56->sdw_irq_work, cs35l56_sdw_irq_work);
+
+	dev_set_drvdata(dev, cs35l56);
+
+	cs35l56->regmap = devm_regmap_init(dev, &cs35l56_regmap_bus_sdw,
+					   peripheral, &cs35l56_regmap_sdw);
+	if (IS_ERR(cs35l56->regmap)) {
+		ret = PTR_ERR(cs35l56->regmap);
+		return dev_err_probe(dev, ret, "Failed to allocate register map\n");
+	}
+
+	/* Start in cache-only until device is enumerated */
+	regcache_cache_only(cs35l56->regmap, true);
+
+	ret = cs35l56_common_probe(cs35l56);
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
+static int cs35l56_sdw_remove(struct sdw_slave *peripheral)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
+
+	/* Disable SoundWire interrupts */
+	cs35l56->sdw_irq_no_unmask = true;
+	cancel_work_sync(&cs35l56->sdw_irq_work);
+	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
+	sdw_read_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1);
+	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
+
+	return cs35l56_remove(cs35l56);
+}
+
+static const struct dev_pm_ops cs35l56_sdw_pm = {
+	SET_RUNTIME_PM_OPS(cs35l56_sdw_runtime_suspend, cs35l56_sdw_runtime_resume, NULL)
+};
+
+static const struct sdw_device_id cs35l56_sdw_id[] = {
+	SDW_SLAVE_ENTRY(0x01FA, 0x3556, 0),
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, cs35l56_sdw_id);
+
+static struct sdw_driver cs35l56_sdw_driver = {
+	.driver = {
+		.name = "cs35l56",
+		.pm = &cs35l56_sdw_pm,
+	},
+	.probe = cs35l56_sdw_probe,
+	.remove = cs35l56_sdw_remove,
+	.ops = &cs35l56_sdw_ops,
+	.id_table = cs35l56_sdw_id,
+};
+
+module_sdw_driver(cs35l56_sdw_driver);
+
+MODULE_DESCRIPTION("ASoC CS35L56 SoundWire driver");
+MODULE_IMPORT_NS(SND_SOC_CS35L56_CORE);
+MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
new file mode 100644
index 000000000000..7081cbfb6ba2
--- /dev/null
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Components shared between ASoC and HDA CS35L56 drivers
+//
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include "cs35l56.h"
+
+static const struct reg_default cs35l56_reg_defaults[] = {
+	{ CS35L56_ASP1_ENABLES1,		0x00000000 },
+	{ CS35L56_ASP1_CONTROL1,		0x00000028 },
+	{ CS35L56_ASP1_CONTROL2,		0x18180200 },
+	{ CS35L56_ASP1_CONTROL3,		0x00000002 },
+	{ CS35L56_ASP1_FRAME_CONTROL1,		0x03020100 },
+	{ CS35L56_ASP1_FRAME_CONTROL5,		0x00020100 },
+	{ CS35L56_ASP1_DATA_CONTROL1,		0x00000018 },
+	{ CS35L56_ASP1_DATA_CONTROL5,		0x00000018 },
+	{ CS35L56_ASP1TX1_INPUT,		0x00000018 },
+	{ CS35L56_ASP1TX2_INPUT,		0x00000019 },
+	{ CS35L56_ASP1TX3_INPUT,		0x00000020 },
+	{ CS35L56_ASP1TX4_INPUT,		0x00000028 },
+	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
+	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
+	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
+	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
+	{ CS35L56_SWIRE_DP3_CH5_INPUT,		0x00000018 },
+	{ CS35L56_SWIRE_DP3_CH6_INPUT,		0x00000018 },
+	{ CS35L56_IRQ1_CFG,			0x00000000 },
+	{ CS35L56_IRQ1_MASK_1,			0x83ffffff },
+	{ CS35L56_IRQ1_MASK_2,			0xffff7fff },
+	{ CS35L56_IRQ1_MASK_4,			0xe0ffffff },
+	{ CS35L56_IRQ1_MASK_8,			0xfc000fff },
+	{ CS35L56_IRQ1_MASK_18,			0x1f7df0ff },
+	{ CS35L56_IRQ1_MASK_20,			0x15c00000 },
+	/* CS35L56_MAIN_RENDER_USER_MUTE - soft register, no default	*/
+	/* CS35L56_MAIN_RENDER_USER_VOLUME - soft register, no default	*/
+	/* CS35L56_MAIN_POSTURE_NUMBER - soft register, no default	*/
+};
+
+/*
+ * The Ax devices have different default register values to that of B0,
+ * establish a common set of register defaults.
+ */
+static const struct reg_sequence cs35l56_reva_patch[] = {
+	{ CS35L56_SWIRE_DP3_CH5_INPUT,	0x00000018 },
+	{ CS35L56_SWIRE_DP3_CH6_INPUT,	0x00000018 },
+};
+
+void cs35l56_patch(struct device *dev, struct regmap *regmap, u8 revid)
+{
+	int ret;
+
+	if (revid >= CS35L56_REVID_B0)
+		return;
+
+	ret = regmap_register_patch(regmap, cs35l56_reva_patch,
+				    ARRAY_SIZE(cs35l56_reva_patch));
+	if (ret)
+		dev_err(dev, "Failed to apply patch: %d\n", ret);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_patch, SND_SOC_CS35L56_SHARED);
+
+static bool cs35l56_is_dsp_memory(unsigned int reg)
+{
+	switch (reg) {
+	case CS35L56_DSP1_XMEM_PACKED_0 ... CS35L56_DSP1_XMEM_PACKED_6143:
+	case CS35L56_DSP1_XMEM_UNPACKED32_0 ... CS35L56_DSP1_XMEM_UNPACKED32_4095:
+	case CS35L56_DSP1_XMEM_UNPACKED24_0 ... CS35L56_DSP1_XMEM_UNPACKED24_8191:
+	case CS35L56_DSP1_YMEM_PACKED_0 ... CS35L56_DSP1_YMEM_PACKED_4604:
+	case CS35L56_DSP1_YMEM_UNPACKED32_0 ... CS35L56_DSP1_YMEM_UNPACKED32_3070:
+	case CS35L56_DSP1_YMEM_UNPACKED24_0 ... CS35L56_DSP1_YMEM_UNPACKED24_6141:
+	case CS35L56_DSP1_PMEM_0 ... CS35L56_DSP1_PMEM_5114:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs35l56_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L56_DEVID:
+	case CS35L56_REVID:
+	case CS35L56_RELID:
+	case CS35L56_OTPID:
+	case CS35L56_SFT_RESET:
+	case CS35L56_GLOBAL_ENABLES:
+	case CS35L56_BLOCK_ENABLES:
+	case CS35L56_BLOCK_ENABLES2:
+	case CS35L56_REFCLK_INPUT:
+	case CS35L56_GLOBAL_SAMPLE_RATE:
+	case CS35L56_ASP1_ENABLES1:
+	case CS35L56_ASP1_CONTROL1:
+	case CS35L56_ASP1_CONTROL2:
+	case CS35L56_ASP1_CONTROL3:
+	case CS35L56_ASP1_FRAME_CONTROL1:
+	case CS35L56_ASP1_FRAME_CONTROL5:
+	case CS35L56_ASP1_DATA_CONTROL1:
+	case CS35L56_ASP1_DATA_CONTROL5:
+	case CS35L56_DACPCM1_INPUT:
+	case CS35L56_DACPCM2_INPUT:
+	case CS35L56_ASP1TX1_INPUT:
+	case CS35L56_ASP1TX2_INPUT:
+	case CS35L56_ASP1TX3_INPUT:
+	case CS35L56_ASP1TX4_INPUT:
+	case CS35L56_DSP1RX1_INPUT:
+	case CS35L56_DSP1RX2_INPUT:
+	case CS35L56_SWIRE_DP3_CH1_INPUT:
+	case CS35L56_SWIRE_DP3_CH2_INPUT:
+	case CS35L56_SWIRE_DP3_CH3_INPUT:
+	case CS35L56_SWIRE_DP3_CH4_INPUT:
+	case CS35L56_SWIRE_DP3_CH5_INPUT:
+	case CS35L56_SWIRE_DP3_CH6_INPUT:
+	case CS35L56_IRQ1_CFG:
+	case CS35L56_IRQ1_STATUS:
+	case CS35L56_IRQ1_EINT_1 ... CS35L56_IRQ1_EINT_8:
+	case CS35L56_IRQ1_EINT_18:
+	case CS35L56_IRQ1_EINT_20:
+	case CS35L56_IRQ1_MASK_1 ... CS35L56_IRQ1_MASK_8:
+	case CS35L56_IRQ1_MASK_18:
+	case CS35L56_IRQ1_MASK_20:
+	case CS35L56_DSP_VIRTUAL1_MBOX_1:
+	case CS35L56_DSP_VIRTUAL1_MBOX_2:
+	case CS35L56_DSP_VIRTUAL1_MBOX_3:
+	case CS35L56_DSP_VIRTUAL1_MBOX_4:
+	case CS35L56_DSP_VIRTUAL1_MBOX_5:
+	case CS35L56_DSP_VIRTUAL1_MBOX_6:
+	case CS35L56_DSP_VIRTUAL1_MBOX_7:
+	case CS35L56_DSP_VIRTUAL1_MBOX_8:
+	case CS35L56_DSP_RESTRICT_STS1:
+	case CS35L56_DSP1_SYS_INFO_ID ... CS35L56_DSP1_SYS_INFO_END:
+	case CS35L56_DSP1_AHBM_WINDOW_DEBUG_0:
+	case CS35L56_DSP1_AHBM_WINDOW_DEBUG_1:
+	case CS35L56_DSP1_SCRATCH1:
+	case CS35L56_DSP1_SCRATCH2:
+	case CS35L56_DSP1_SCRATCH3:
+	case CS35L56_DSP1_SCRATCH4:
+		return true;
+	default:
+		return cs35l56_is_dsp_memory(reg);
+	}
+}
+
+static bool cs35l56_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L56_DSP1_XMEM_PACKED_0 ... CS35L56_DSP1_XMEM_PACKED_6143:
+	case CS35L56_DSP1_YMEM_PACKED_0 ... CS35L56_DSP1_YMEM_PACKED_4604:
+	case CS35L56_DSP1_PMEM_0 ... CS35L56_DSP1_PMEM_5114:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs35l56_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS35L56_DEVID:
+	case CS35L56_REVID:
+	case CS35L56_RELID:
+	case CS35L56_OTPID:
+	case CS35L56_SFT_RESET:
+	case CS35L56_GLOBAL_ENABLES:		   /* owned by firmware */
+	case CS35L56_BLOCK_ENABLES:		   /* owned by firmware */
+	case CS35L56_BLOCK_ENABLES2:		   /* owned by firmware */
+	case CS35L56_REFCLK_INPUT:		   /* owned by firmware */
+	case CS35L56_GLOBAL_SAMPLE_RATE:	   /* owned by firmware */
+	case CS35L56_DACPCM1_INPUT:		   /* owned by firmware */
+	case CS35L56_DACPCM2_INPUT:		   /* owned by firmware */
+	case CS35L56_DSP1RX1_INPUT:		   /* owned by firmware */
+	case CS35L56_DSP1RX2_INPUT:		   /* owned by firmware */
+	case CS35L56_IRQ1_STATUS:
+	case CS35L56_IRQ1_EINT_1 ... CS35L56_IRQ1_EINT_8:
+	case CS35L56_IRQ1_EINT_18:
+	case CS35L56_IRQ1_EINT_20:
+	case CS35L56_DSP_VIRTUAL1_MBOX_1:
+	case CS35L56_DSP_VIRTUAL1_MBOX_2:
+	case CS35L56_DSP_VIRTUAL1_MBOX_3:
+	case CS35L56_DSP_VIRTUAL1_MBOX_4:
+	case CS35L56_DSP_VIRTUAL1_MBOX_5:
+	case CS35L56_DSP_VIRTUAL1_MBOX_6:
+	case CS35L56_DSP_VIRTUAL1_MBOX_7:
+	case CS35L56_DSP_VIRTUAL1_MBOX_8:
+	case CS35L56_DSP_RESTRICT_STS1:
+	case CS35L56_DSP1_SYS_INFO_ID ... CS35L56_DSP1_SYS_INFO_END:
+	case CS35L56_DSP1_AHBM_WINDOW_DEBUG_0:
+	case CS35L56_DSP1_AHBM_WINDOW_DEBUG_1:
+	case CS35L56_DSP1_SCRATCH1:
+	case CS35L56_DSP1_SCRATCH2:
+	case CS35L56_DSP1_SCRATCH3:
+	case CS35L56_DSP1_SCRATCH4:
+		return true;
+	case CS35L56_MAIN_RENDER_USER_MUTE:
+	case CS35L56_MAIN_RENDER_USER_VOLUME:
+	case CS35L56_MAIN_POSTURE_NUMBER:
+		return false;
+	default:
+		return cs35l56_is_dsp_memory(reg);
+	}
+}
+
+static const u32 cs35l56_firmware_registers[] = {
+	CS35L56_MAIN_RENDER_USER_MUTE,
+	CS35L56_MAIN_RENDER_USER_VOLUME,
+	CS35L56_MAIN_POSTURE_NUMBER,
+};
+
+void cs35l56_reread_firmware_registers(struct device *dev, struct regmap *regmap)
+{
+	int i;
+	unsigned int val;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_firmware_registers); i++) {
+		regmap_read(regmap, cs35l56_firmware_registers[i], &val);
+		dev_dbg(dev, "%s: %d: %#x: %#x\n", __func__,
+			i, cs35l56_firmware_registers[i], val);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_reread_firmware_registers, SND_SOC_CS35L56_SHARED);
+
+const struct cs_dsp_region cs35l56_dsp1_regions[] = {
+	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
+	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
+	{ .type = WMFW_HALO_YM_PACKED,	.base = CS35L56_DSP1_YMEM_PACKED_0 },
+	{ .type = WMFW_ADSP2_XM,	.base = CS35L56_DSP1_XMEM_UNPACKED24_0 },
+	{ .type = WMFW_ADSP2_YM,	.base = CS35L56_DSP1_YMEM_UNPACKED24_0 },
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_dsp1_regions, SND_SOC_CS35L56_SHARED);
+
+static const u32 cs35l56_bclk_valid_for_pll_freq_table[] = {
+	[0x0C] = 128000,
+	[0x0F] = 256000,
+	[0x11] = 384000,
+	[0x12] = 512000,
+	[0x15] = 768000,
+	[0x17] = 1024000,
+	[0x1A] = 1500000,
+	[0x1B] = 1536000,
+	[0x1C] = 2000000,
+	[0x1D] = 2048000,
+	[0x1E] = 2400000,
+	[0x20] = 3000000,
+	[0x21] = 3072000,
+	[0x23] = 4000000,
+	[0x24] = 4096000,
+	[0x25] = 4800000,
+	[0x27] = 6000000,
+	[0x28] = 6144000,
+	[0x29] = 6250000,
+	[0x2A] = 6400000,
+	[0x2E] = 8000000,
+	[0x2F] = 8192000,
+	[0x30] = 9600000,
+	[0x32] = 12000000,
+	[0x33] = 12288000,
+	[0x37] = 13500000,
+	[0x38] = 19200000,
+	[0x39] = 22579200,
+	[0x3B] = 24576000,
+};
+
+int cs35l56_get_bclk_freq_id(unsigned int freq)
+{
+	int i;
+
+	if (freq == 0)
+		return -EINVAL;
+
+	/* The BCLK frequency must be a valid PLL REFCLK */
+	for (i = 0; i < ARRAY_SIZE(cs35l56_bclk_valid_for_pll_freq_table); ++i) {
+		if (cs35l56_bclk_valid_for_pll_freq_table[i] == freq)
+			return i;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_get_bclk_freq_id, SND_SOC_CS35L56_SHARED);
+
+static const char * const cs35l56_supplies[/* auto-sized */] = {
+	"VDD_P",
+	"VDD_IO",
+	"VDD_A",
+};
+
+void cs35l56_fill_supply_names(struct regulator_bulk_data *data)
+{
+	int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_supplies) != CS35L56_NUM_BULK_SUPPLIES);
+	for (i = 0; i < ARRAY_SIZE(cs35l56_supplies); i++)
+		data[i].supply = cs35l56_supplies[i];
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_fill_supply_names, SND_SOC_CS35L56_SHARED);
+
+const char * const cs35l56_tx_input_texts[] = {
+	"None", "ASP1RX1", "ASP1RX2", "VMON", "IMON", "ERRVOL", "CLASSH",
+	"VDDBMON", "VBSTMON", "DSP1TX1", "DSP1TX2", "DSP1TX3", "DSP1TX4",
+	"DSP1TX5", "DSP1TX6", "DSP1TX7", "DSP1TX8", "TEMPMON",
+	"INTERPOLATOR", "SDW1RX1", "SDW1RX2", "SDW2RX1",
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_tx_input_texts, SND_SOC_CS35L56_SHARED);
+
+const unsigned int cs35l56_tx_input_values[] = {
+	CS35L56_INPUT_SRC_NONE,
+	CS35L56_INPUT_SRC_ASP1RX1,
+	CS35L56_INPUT_SRC_ASP1RX2,
+	CS35L56_INPUT_SRC_VMON,
+	CS35L56_INPUT_SRC_IMON,
+	CS35L56_INPUT_SRC_ERR_VOL,
+	CS35L56_INPUT_SRC_CLASSH,
+	CS35L56_INPUT_SRC_VDDBMON,
+	CS35L56_INPUT_SRC_VBSTMON,
+	CS35L56_INPUT_SRC_DSP1TX1,
+	CS35L56_INPUT_SRC_DSP1TX2,
+	CS35L56_INPUT_SRC_DSP1TX3,
+	CS35L56_INPUT_SRC_DSP1TX4,
+	CS35L56_INPUT_SRC_DSP1TX5,
+	CS35L56_INPUT_SRC_DSP1TX6,
+	CS35L56_INPUT_SRC_DSP1TX7,
+	CS35L56_INPUT_SRC_DSP1TX8,
+	CS35L56_INPUT_SRC_TEMPMON,
+	CS35L56_INPUT_SRC_INTERPOLATOR,
+	CS35L56_INPUT_SRC_SWIRE_RX1,
+	CS35L56_INPUT_SRC_SWIRE_RX2,
+	CS35L56_INPUT_SRC_SWIRE_RX3,
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_tx_input_values, SND_SOC_CS35L56_SHARED);
+
+struct regmap_config cs35l56_regmap_i2c = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L56_DSP1_PMEM_5114,
+	.reg_defaults = cs35l56_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs35l56_reg_defaults),
+	.volatile_reg = cs35l56_volatile_reg,
+	.readable_reg = cs35l56_readable_reg,
+	.precious_reg = cs35l56_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_regmap_i2c, SND_SOC_CS35L56_SHARED);
+
+struct regmap_config cs35l56_regmap_spi = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.pad_bits = 16,
+	.reg_stride = 4,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L56_DSP1_PMEM_5114,
+	.reg_defaults = cs35l56_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs35l56_reg_defaults),
+	.volatile_reg = cs35l56_volatile_reg,
+	.readable_reg = cs35l56_readable_reg,
+	.precious_reg = cs35l56_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_regmap_spi, SND_SOC_CS35L56_SHARED);
+
+struct regmap_config cs35l56_regmap_sdw = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = CS35L56_DSP1_PMEM_5114,
+	.reg_defaults = cs35l56_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs35l56_reg_defaults),
+	.volatile_reg = cs35l56_volatile_reg,
+	.readable_reg = cs35l56_readable_reg,
+	.precious_reg = cs35l56_precious_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_regmap_sdw, SND_SOC_CS35L56_SHARED);
+
+MODULE_DESCRIPTION("ASoC CS35L56 Shared");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
new file mode 100644
index 000000000000..80dcf37daae2
--- /dev/null
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// CS35L56 ALSA SoC audio driver SPI binding
+//
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "cs35l56.h"
+
+static int cs35l56_spi_probe(struct spi_device *spi)
+{
+	const struct regmap_config *regmap_config = &cs35l56_regmap_spi;
+	struct cs35l56_private *cs35l56;
+	int ret;
+
+	cs35l56 = devm_kzalloc(&spi->dev, sizeof(struct cs35l56_private), GFP_KERNEL);
+	if (!cs35l56)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs35l56);
+	cs35l56->regmap = devm_regmap_init_spi(spi, regmap_config);
+	if (IS_ERR(cs35l56->regmap)) {
+		ret = PTR_ERR(cs35l56->regmap);
+		return dev_err_probe(&spi->dev, ret, "Failed to allocate register map\n");
+		return ret;
+	}
+
+	cs35l56->dev = &spi->dev;
+	cs35l56->irq = spi->irq;
+
+	ret = cs35l56_common_probe(cs35l56);
+	if (ret != 0)
+		return ret;
+
+	ret = cs35l56_init(cs35l56);
+	if (ret == 0)
+		ret = cs35l56_irq_request(cs35l56);
+	if (ret < 0)
+		cs35l56_remove(cs35l56);
+
+	return ret;
+}
+
+static void cs35l56_spi_remove(struct spi_device *spi)
+{
+	struct cs35l56_private *cs35l56 = spi_get_drvdata(spi);
+
+	cs35l56_remove(cs35l56);
+}
+
+static const struct spi_device_id cs35l56_id_spi[] = {
+	{ "cs35l56", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cs35l56_id_spi);
+
+static struct spi_driver cs35l56_spi_driver = {
+	.driver = {
+		.name		= "cs35l56",
+		.pm = &cs35l56_pm_ops_i2c_spi,
+	},
+	.id_table	= cs35l56_id_spi,
+	.probe		= cs35l56_spi_probe,
+	.remove		= cs35l56_spi_remove,
+};
+
+module_spi_driver(cs35l56_spi_driver);
+
+MODULE_DESCRIPTION("ASoC CS35L56 SPI driver");
+MODULE_IMPORT_NS(SND_SOC_CS35L56_CORE);
+MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
new file mode 100644
index 000000000000..c8ff649f6456
--- /dev/null
+++ b/sound/soc/codecs/cs35l56.c
@@ -0,0 +1,1451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Driver for Cirrus Logic CS35L56 smart amp
+//
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "wm_adsp.h"
+#include "cs35l56.h"
+
+static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event);
+
+static int cs35l56_wait_dsp_ready(struct cs35l56_private *cs35l56)
+{
+	int ret;
+
+	if (!cs35l56->fw_patched) {
+		/* block until firmware download completes */
+		ret = wait_for_completion_timeout(&cs35l56->dsp_ready_completion,
+						  msecs_to_jiffies(25000));
+		if (!ret) {
+			dev_err(cs35l56->dev, "dsp_ready_completion timeout\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int cs35l56_dspwait_get_volsw(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	int ret = cs35l56_wait_dsp_ready(cs35l56);
+
+	if (ret)
+		return ret;
+
+	return snd_soc_get_volsw(kcontrol, ucontrol);
+}
+
+static int cs35l56_dspwait_put_volsw(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	int ret = cs35l56_wait_dsp_ready(cs35l56);
+
+	if (ret)
+		return ret;
+
+	return snd_soc_put_volsw(kcontrol, ucontrol);
+}
+
+static DECLARE_TLV_DB_SCALE(vol_tlv, -10000, 25, 0);
+
+static const struct snd_kcontrol_new cs35l56_controls[] = {
+	SOC_SINGLE_EXT("Speaker Switch",
+		       CS35L56_MAIN_RENDER_USER_MUTE, 0, 1, 1,
+		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
+	SOC_SINGLE_S_EXT_TLV("Speaker Volume",
+			     CS35L56_MAIN_RENDER_USER_VOLUME,
+			     6, -400, 400, 9, 0,
+			     cs35l56_dspwait_get_volsw,
+			     cs35l56_dspwait_put_volsw,
+			     vol_tlv),
+	SOC_SINGLE_EXT("Posture Number", CS35L56_MAIN_POSTURE_NUMBER,
+		       0, 255, 0,
+		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx1_enum,
+				  CS35L56_ASP1TX1_INPUT,
+				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  cs35l56_tx_input_texts,
+				  cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new asp1_tx1_mux =
+	SOC_DAPM_ENUM("ASP1TX1 SRC", cs35l56_asp1tx1_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx2_enum,
+				  CS35L56_ASP1TX2_INPUT,
+				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  cs35l56_tx_input_texts,
+				  cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new asp1_tx2_mux =
+	SOC_DAPM_ENUM("ASP1TX2 SRC", cs35l56_asp1tx2_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx3_enum,
+				  CS35L56_ASP1TX3_INPUT,
+				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  cs35l56_tx_input_texts,
+				  cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new asp1_tx3_mux =
+	SOC_DAPM_ENUM("ASP1TX3 SRC", cs35l56_asp1tx3_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx4_enum,
+				  CS35L56_ASP1TX4_INPUT,
+				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  cs35l56_tx_input_texts,
+				  cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new asp1_tx4_mux =
+	SOC_DAPM_ENUM("ASP1TX4 SRC", cs35l56_asp1tx4_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx1_enum,
+				CS35L56_SWIRE_DP3_CH1_INPUT,
+				0, CS35L56_SWIRETXn_SRC_MASK,
+				cs35l56_tx_input_texts,
+				cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new sdw1_tx1_mux =
+	SOC_DAPM_ENUM("SDW1TX1 SRC", cs35l56_sdw1tx1_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx2_enum,
+				CS35L56_SWIRE_DP3_CH2_INPUT,
+				0, CS35L56_SWIRETXn_SRC_MASK,
+				cs35l56_tx_input_texts,
+				cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new sdw1_tx2_mux =
+	SOC_DAPM_ENUM("SDW1TX2 SRC", cs35l56_sdw1tx2_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx3_enum,
+				CS35L56_SWIRE_DP3_CH3_INPUT,
+				0, CS35L56_SWIRETXn_SRC_MASK,
+				cs35l56_tx_input_texts,
+				cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new sdw1_tx3_mux =
+	SOC_DAPM_ENUM("SDW1TX3 SRC", cs35l56_sdw1tx3_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx4_enum,
+				CS35L56_SWIRE_DP3_CH4_INPUT,
+				0, CS35L56_SWIRETXn_SRC_MASK,
+				cs35l56_tx_input_texts,
+				cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new sdw1_tx4_mux =
+	SOC_DAPM_ENUM("SDW1TX4 SRC", cs35l56_sdw1tx4_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx5_enum,
+				CS35L56_SWIRE_DP3_CH5_INPUT,
+				0, CS35L56_SWIRETXn_SRC_MASK,
+				cs35l56_tx_input_texts,
+				cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new sdw1_tx5_mux =
+	SOC_DAPM_ENUM("SDW1TX5 SRC", cs35l56_sdw1tx5_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx6_enum,
+				CS35L56_SWIRE_DP3_CH6_INPUT,
+				0, CS35L56_SWIRETXn_SRC_MASK,
+				cs35l56_tx_input_texts,
+				cs35l56_tx_input_values);
+
+static const struct snd_kcontrol_new sdw1_tx6_mux =
+	SOC_DAPM_ENUM("SDW1TX6 SRC", cs35l56_sdw1tx6_enum);
+
+static const struct snd_soc_dapm_widget cs35l56_dapm_widgets[] = {
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_B", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_AMP", 0, 0),
+
+	SND_SOC_DAPM_OUT_DRV("AMP", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("SPK"),
+
+	SND_SOC_DAPM_PGA_E("DSP1", SND_SOC_NOPM, 0, 0, NULL, 0, cs35l56_dsp_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_AIF_IN("ASP1RX1", NULL, 0, CS35L56_ASP1_ENABLES1,
+			    CS35L56_ASP_RX1_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_IN("ASP1RX2", NULL, 1, CS35L56_ASP1_ENABLES1,
+			    CS35L56_ASP_RX2_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP1TX1", NULL, 0, CS35L56_ASP1_ENABLES1,
+			     CS35L56_ASP_TX1_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP1TX2", NULL, 1, CS35L56_ASP1_ENABLES1,
+			     CS35L56_ASP_TX2_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP1TX3", NULL, 2, CS35L56_ASP1_ENABLES1,
+			     CS35L56_ASP_TX3_EN_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("ASP1TX4", NULL, 3, CS35L56_ASP1_ENABLES1,
+			     CS35L56_ASP_TX4_EN_SHIFT, 0),
+
+	SND_SOC_DAPM_MUX("ASP1 TX1 Source", SND_SOC_NOPM, 0, 0, &asp1_tx1_mux),
+	SND_SOC_DAPM_MUX("ASP1 TX2 Source", SND_SOC_NOPM, 0, 0, &asp1_tx2_mux),
+	SND_SOC_DAPM_MUX("ASP1 TX3 Source", SND_SOC_NOPM, 0, 0, &asp1_tx3_mux),
+	SND_SOC_DAPM_MUX("ASP1 TX4 Source", SND_SOC_NOPM, 0, 0, &asp1_tx4_mux),
+
+	SND_SOC_DAPM_MUX("SDW1 TX1 Source", SND_SOC_NOPM, 0, 0, &sdw1_tx1_mux),
+	SND_SOC_DAPM_MUX("SDW1 TX2 Source", SND_SOC_NOPM, 0, 0, &sdw1_tx2_mux),
+	SND_SOC_DAPM_MUX("SDW1 TX3 Source", SND_SOC_NOPM, 0, 0, &sdw1_tx3_mux),
+	SND_SOC_DAPM_MUX("SDW1 TX4 Source", SND_SOC_NOPM, 0, 0, &sdw1_tx4_mux),
+	SND_SOC_DAPM_MUX("SDW1 TX5 Source", SND_SOC_NOPM, 0, 0, &sdw1_tx5_mux),
+	SND_SOC_DAPM_MUX("SDW1 TX6 Source", SND_SOC_NOPM, 0, 0, &sdw1_tx6_mux),
+
+	SND_SOC_DAPM_SIGGEN("VMON ADC"),
+	SND_SOC_DAPM_SIGGEN("IMON ADC"),
+	SND_SOC_DAPM_SIGGEN("ERRVOL ADC"),
+	SND_SOC_DAPM_SIGGEN("CLASSH ADC"),
+	SND_SOC_DAPM_SIGGEN("VDDBMON ADC"),
+	SND_SOC_DAPM_SIGGEN("VBSTMON ADC"),
+	SND_SOC_DAPM_SIGGEN("TEMPMON ADC"),
+};
+
+#define CS35L56_SRC_ROUTE(name) \
+	{ name" Source", "ASP1RX1", "ASP1RX1" }, \
+	{ name" Source", "ASP1RX2", "ASP1RX2" }, \
+	{ name" Source", "VMON", "VMON ADC" }, \
+	{ name" Source", "IMON", "IMON ADC" }, \
+	{ name" Source", "ERRVOL", "ERRVOL ADC" },   \
+	{ name" Source", "CLASSH", "CLASSH ADC" },   \
+	{ name" Source", "VDDBMON", "VDDBMON ADC" }, \
+	{ name" Source", "VBSTMON", "VBSTMON ADC" }, \
+	{ name" Source", "DSP1TX1", "DSP1" }, \
+	{ name" Source", "DSP1TX2", "DSP1" }, \
+	{ name" Source", "DSP1TX3", "DSP1" }, \
+	{ name" Source", "DSP1TX4", "DSP1" }, \
+	{ name" Source", "DSP1TX5", "DSP1" }, \
+	{ name" Source", "DSP1TX6", "DSP1" }, \
+	{ name" Source", "DSP1TX7", "DSP1" }, \
+	{ name" Source", "DSP1TX8", "DSP1" }, \
+	{ name" Source", "TEMPMON", "TEMPMON ADC" }, \
+	{ name" Source", "INTERPOLATOR", "AMP" }, \
+	{ name" Source", "SDW1RX1", "SDW1 Playback" }, \
+	{ name" Source", "SDW1RX2", "SDW1 Playback" },
+
+static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
+	{ "AMP", NULL, "VDD_B" },
+	{ "AMP", NULL, "VDD_AMP" },
+
+	{ "ASP1RX1", NULL, "ASP1 Playback" },
+	{ "ASP1RX2", NULL, "ASP1 Playback" },
+	{ "DSP1", NULL, "ASP1RX1" },
+	{ "DSP1", NULL, "ASP1RX2" },
+	{ "DSP1", NULL, "SDW1 Playback" },
+	{ "AMP", NULL, "DSP1" },
+	{ "SPK", NULL, "AMP" },
+
+	CS35L56_SRC_ROUTE("ASP1 TX1")
+	CS35L56_SRC_ROUTE("ASP1 TX2")
+	CS35L56_SRC_ROUTE("ASP1 TX3")
+	CS35L56_SRC_ROUTE("ASP1 TX4")
+
+	{ "ASP1TX1", NULL, "ASP1 TX1 Source" },
+	{ "ASP1TX2", NULL, "ASP1 TX2 Source" },
+	{ "ASP1TX3", NULL, "ASP1 TX3 Source" },
+	{ "ASP1TX4", NULL, "ASP1 TX4 Source" },
+	{ "ASP1 Capture", NULL, "ASP1TX1" },
+	{ "ASP1 Capture", NULL, "ASP1TX2" },
+	{ "ASP1 Capture", NULL, "ASP1TX3" },
+	{ "ASP1 Capture", NULL, "ASP1TX4" },
+
+	CS35L56_SRC_ROUTE("SDW1 TX1")
+	CS35L56_SRC_ROUTE("SDW1 TX2")
+	CS35L56_SRC_ROUTE("SDW1 TX3")
+	CS35L56_SRC_ROUTE("SDW1 TX4")
+	CS35L56_SRC_ROUTE("SDW1 TX5")
+	CS35L56_SRC_ROUTE("SDW1 TX6")
+	{ "SDW1 Capture", NULL, "SDW1 TX1 Source" },
+	{ "SDW1 Capture", NULL, "SDW1 TX2 Source" },
+	{ "SDW1 Capture", NULL, "SDW1 TX3 Source" },
+	{ "SDW1 Capture", NULL, "SDW1 TX4 Source" },
+	{ "SDW1 Capture", NULL, "SDW1 TX5 Source" },
+	{ "SDW1 Capture", NULL, "SDW1 TX6 Source" },
+};
+
+static int cs35l56_mbox_send(struct cs35l56_private *cs35l56, unsigned int command)
+{
+	unsigned int val;
+	int ret;
+
+	regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
+	ret = regmap_read_poll_timeout(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+				       val, (val == 0),
+				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
+	if (ret) {
+		dev_warn(cs35l56->dev, "MBOX command %#x failed: %d\n", command, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+
+	dev_dbg(cs35l56->dev, "%s: %d\n", __func__, event);
+
+	return wm_adsp_event(w, kcontrol, event);
+}
+
+irqreturn_t cs35l56_irq(int irq, void *data)
+{
+	struct cs35l56_private *cs35l56 = data;
+	unsigned int status1 = 0, status8 = 0, status20 = 0;
+	unsigned int mask1, mask8, mask20;
+	unsigned int val;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (!cs35l56->init_done)
+		return IRQ_NONE;
+
+	mutex_lock(&cs35l56->irq_lock);
+	pm_runtime_get_sync(cs35l56->dev);
+
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_STATUS, &val);
+	if ((val & CS35L56_IRQ1_STS_MASK) == 0) {
+		dev_dbg(cs35l56->dev, "Spurious IRQ: no pending interrupt\n");
+		goto err;
+	}
+
+	/* Ack interrupts */
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_1, &status1);
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_MASK_1, &mask1);
+	status1 &= ~mask1;
+	regmap_write(cs35l56->regmap, CS35L56_IRQ1_EINT_1, status1);
+
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_8, &status8);
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_MASK_8, &mask8);
+	status8 &= ~mask8;
+	regmap_write(cs35l56->regmap, CS35L56_IRQ1_EINT_8, status8);
+
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_20, &status20);
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_MASK_20, &mask20);
+	status20 &= ~mask20;
+	/* We don't want EINT20 but they default to unmasked: force mask */
+	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+
+	dev_dbg(cs35l56->dev, "%s: %#x %#x\n", __func__, status1, status8);
+
+	/* Check to see if unmasked bits are active */
+	if (!status1 && !status8 && !status20)
+		goto err;
+
+	if (status1 & CS35L56_AMP_SHORT_ERR_EINT1_MASK)
+		dev_crit(cs35l56->dev, "Amp short error\n");
+
+	if (status8 & CS35L56_TEMP_ERR_EINT1_MASK)
+		dev_crit(cs35l56->dev, "Overtemp error\n");
+
+	ret = IRQ_HANDLED;
+
+err:
+	pm_runtime_put(cs35l56->dev);
+	mutex_unlock(&cs35l56->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_irq, SND_SOC_CS35L56_CORE);
+
+int cs35l56_irq_request(struct cs35l56_private *cs35l56)
+{
+	int ret;
+
+	if (!cs35l56->irq)
+		return 0;
+
+	ret = devm_request_threaded_irq(cs35l56->dev, cs35l56->irq, NULL,
+					cs35l56_irq,
+					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
+					"cs35l56", cs35l56);
+	if (ret < 0)
+		dev_err(cs35l56->dev, "Failed to get IRQ: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_irq_request, SND_SOC_CS35L56_CORE);
+
+static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(codec_dai->component);
+	unsigned int val;
+
+	dev_dbg(cs35l56->dev, "%s: %#x\n", __func__, fmt);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	default:
+		dev_err(cs35l56->dev, "Unsupported clock source mode\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		val = CS35L56_ASP_FMT_DSP_A << CS35L56_ASP_FMT_SHIFT;
+		cs35l56->tdm_mode = true;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		val = CS35L56_ASP_FMT_I2S << CS35L56_ASP_FMT_SHIFT;
+		cs35l56->tdm_mode = false;
+		break;
+	default:
+		dev_err(cs35l56->dev, "Unsupported DAI format\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_IF:
+		val |= CS35L56_ASP_FSYNC_INV_MASK;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		val |= CS35L56_ASP_BCLK_INV_MASK;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		val |= CS35L56_ASP_BCLK_INV_MASK | CS35L56_ASP_FSYNC_INV_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		dev_err(cs35l56->dev, "Invalid clock invert\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(cs35l56->regmap,
+			   CS35L56_ASP1_CONTROL2,
+			   CS35L56_ASP_FMT_MASK |
+			   CS35L56_ASP_BCLK_INV_MASK | CS35L56_ASP_FSYNC_INV_MASK,
+			   val);
+
+	/* Hi-Z DOUT in unused slots and when all TX are disabled */
+	regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL3,
+			   CS35L56_ASP1_DOUT_HIZ_CTRL_MASK,
+			   CS35L56_ASP_UNUSED_HIZ_OFF_HIZ);
+
+	return 0;
+}
+
+static void cs35l56_set_asp_slot_positions(struct cs35l56_private *cs35l56,
+					   unsigned int reg, unsigned long mask)
+{
+	unsigned int reg_val, channel_shift;
+	int bit_num;
+
+	/* Init all slots to 63 */
+	switch (reg) {
+	case CS35L56_ASP1_FRAME_CONTROL1:
+		reg_val = 0x3f3f3f3f;
+		break;
+	case CS35L56_ASP1_FRAME_CONTROL5:
+		reg_val = 0x3f3f3f;
+		break;
+	}
+
+	/* Enable consecutive TX1..TXn for each of the slots set in mask */
+	channel_shift = 0;
+	for_each_set_bit(bit_num, &mask, 32) {
+		reg_val &= ~(0x3f << channel_shift);
+		reg_val |= bit_num << channel_shift;
+		channel_shift += 8;
+	}
+
+	regmap_write(cs35l56->regmap, reg, reg_val);
+}
+
+static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+					unsigned int rx_mask, int slots, int slot_width)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+
+	if ((slots == 0) || (slot_width == 0)) {
+		dev_dbg(cs35l56->dev, "tdm config cleared\n");
+		cs35l56->asp_slot_width = 0;
+		cs35l56->asp_slot_count = 0;
+		return 0;
+	}
+
+	if (slot_width > (CS35L56_ASP_RX_WIDTH_MASK >> CS35L56_ASP_RX_WIDTH_SHIFT)) {
+		dev_err(cs35l56->dev, "tdm invalid slot width %d\n", slot_width);
+		return -EINVAL;
+	}
+
+	/* More than 32 slots would give an unsupportable BCLK frequency */
+	if (slots > 32) {
+		dev_err(cs35l56->dev, "tdm invalid slot count %d\n", slots);
+		return -EINVAL;
+	}
+
+	cs35l56->asp_slot_width = (u8)slot_width;
+	cs35l56->asp_slot_count = (u8)slots;
+
+	// Note: rx/tx is from point of view of the CPU end
+	if (tx_mask == 0)
+		tx_mask = 0x3;	// ASPRX1/RX2 in slots 0 and 1
+
+	if (rx_mask == 0)
+		rx_mask = 0xf;	// ASPTX1..TX4 in slots 0..3
+
+	cs35l56_set_asp_slot_positions(cs35l56, CS35L56_ASP1_FRAME_CONTROL1, rx_mask);
+	cs35l56_set_asp_slot_positions(cs35l56, CS35L56_ASP1_FRAME_CONTROL5, tx_mask);
+
+	dev_dbg(cs35l56->dev, "tdm slot width: %u count: %u tx_mask: %#x rx_mask: %#x\n",
+		cs35l56->asp_slot_width, cs35l56->asp_slot_count, tx_mask, rx_mask);
+
+	return 0;
+}
+
+static int cs35l56_asp_dai_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+	unsigned int rate = params_rate(params);
+	u8 asp_width, asp_wl;
+
+	asp_wl = params_width(params);
+	if (cs35l56->asp_slot_width)
+		asp_width = cs35l56->asp_slot_width;
+	else
+		asp_width = asp_wl;
+
+	dev_dbg(cs35l56->dev, "%s: wl=%d, width=%d, rate=%d", __func__, asp_wl, asp_width, rate);
+
+	if (!cs35l56->sysclk_set) {
+		unsigned int slots = cs35l56->asp_slot_count;
+		unsigned int bclk_freq;
+		int freq_id;
+
+		if (slots == 0) {
+			slots = params_channels(params);
+
+			/* I2S always has an even number of slots */
+			if (!cs35l56->tdm_mode)
+				slots = round_up(slots, 2);
+		}
+
+		bclk_freq = asp_width * slots * rate;
+		freq_id = cs35l56_get_bclk_freq_id(bclk_freq);
+		if (freq_id < 0) {
+			dev_err(cs35l56->dev, "%s: Invalid BCLK %u\n", __func__, bclk_freq);
+			return -EINVAL;
+		}
+
+		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL1,
+				   CS35L56_ASP_BCLK_FREQ_MASK,
+				   freq_id << CS35L56_ASP_BCLK_FREQ_SHIFT);
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL2,
+				   CS35L56_ASP_RX_WIDTH_MASK, asp_width <<
+				   CS35L56_ASP_RX_WIDTH_SHIFT);
+		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_DATA_CONTROL5,
+				   CS35L56_ASP_RX_WL_MASK, asp_wl);
+	} else {
+		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL2,
+				   CS35L56_ASP_TX_WIDTH_MASK, asp_width <<
+				   CS35L56_ASP_TX_WIDTH_SHIFT);
+		regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_DATA_CONTROL1,
+				   CS35L56_ASP_TX_WL_MASK, asp_wl);
+	}
+
+	return 0;
+}
+
+static int cs35l56_asp_dai_set_sysclk(struct snd_soc_dai *dai,
+				      int clk_id, unsigned int freq, int dir)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+	int freq_id;
+
+	if (freq == 0) {
+		cs35l56->sysclk_set = false;
+		return 0;
+	}
+
+	freq_id = cs35l56_get_bclk_freq_id(freq);
+	if (freq_id < 0)
+		return freq_id;
+
+	regmap_update_bits(cs35l56->regmap, CS35L56_ASP1_CONTROL1,
+			   CS35L56_ASP_BCLK_FREQ_MASK,
+			   freq_id << CS35L56_ASP_BCLK_FREQ_SHIFT);
+	cs35l56->sysclk_set = true;
+
+	return 0;
+}
+
+static int cs35l56_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+	unsigned int val;
+	int ret;
+
+	dev_dbg(cs35l56->dev, "%s: %d %s\n", __func__, stream, mute ? "mute" : "unmute");
+
+	if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
+	if (mute) {
+		ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_PAUSE);
+	} else {
+		ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_AUDIO_PLAY);
+		if (ret == 0) {
+			/* Wait for firmware to enter PS0 power state */
+			ret = regmap_read_poll_timeout(cs35l56->regmap,
+						       CS35L56_TRANSDUCER_ACTUAL_PS,
+						       val, (val == CS35L56_PS0),
+						       CS35L56_PS0_POLL_US,
+						       CS35L56_PS0_TIMEOUT_US);
+			if (ret)
+				dev_err(cs35l56->dev, "PS0 wait failed: %d\n", ret);
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops cs35l56_ops = {
+	.set_fmt = cs35l56_asp_dai_set_fmt,
+	.set_tdm_slot = cs35l56_asp_dai_set_tdm_slot,
+	.hw_params = cs35l56_asp_dai_hw_params,
+	.set_sysclk = cs35l56_asp_dai_set_sysclk,
+	.mute_stream = cs35l56_mute_stream,
+};
+
+static void cs35l56_sdw_dai_shutdown(struct snd_pcm_substream *substream,
+				     struct snd_soc_dai *dai)
+{
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+}
+
+static int cs35l56_sdw_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+					unsigned int rx_mask, int slots, int slot_width)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+
+	/* rx/tx are from point of view of the CPU end so opposite to our rx/tx */
+	cs35l56->rx_mask = tx_mask;
+	cs35l56->tx_mask = rx_mask;
+
+	return 0;
+}
+
+static int cs35l56_sdw_dai_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
+	struct sdw_stream_config sconfig;
+	struct sdw_port_config pconfig;
+	int ret;
+
+	dev_dbg(cs35l56->dev, "%s: rate %d\n", __func__, params_rate(params));
+
+	if (!cs35l56->init_done)
+		return -ENODEV;
+
+	if (!sdw_stream)
+		return -EINVAL;
+
+	memset(&sconfig, 0, sizeof(sconfig));
+	memset(&pconfig, 0, sizeof(pconfig));
+
+	sconfig.frame_rate = params_rate(params);
+	sconfig.bps = snd_pcm_format_width(params_format(params));
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sconfig.direction = SDW_DATA_DIR_RX;
+		pconfig.num = CS35L56_SDW1_PLAYBACK_PORT;
+		pconfig.ch_mask = cs35l56->rx_mask;
+	} else {
+		sconfig.direction = SDW_DATA_DIR_TX;
+		pconfig.num = CS35L56_SDW1_CAPTURE_PORT;
+		pconfig.ch_mask = cs35l56->tx_mask;
+	}
+
+	if (pconfig.ch_mask == 0) {
+		sconfig.ch_count = params_channels(params);
+		pconfig.ch_mask = GENMASK(sconfig.ch_count - 1, 0);
+	} else {
+		sconfig.ch_count = hweight32(pconfig.ch_mask);
+	}
+
+	ret = sdw_stream_add_slave(cs35l56->sdw_peripheral, &sconfig, &pconfig,
+				   1, sdw_stream);
+	if (ret) {
+		dev_err(dai->dev, "Failed to add sdw stream: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cs35l56_sdw_dai_hw_free(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
+	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!cs35l56->sdw_peripheral)
+		return -EINVAL;
+
+	sdw_stream_remove_slave(cs35l56->sdw_peripheral, sdw_stream);
+
+	return 0;
+}
+
+static int cs35l56_sdw_dai_set_stream(struct snd_soc_dai *dai,
+				      void *sdw_stream, int direction)
+{
+	if (!sdw_stream)
+		return 0;
+
+	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs35l56_sdw_dai_ops = {
+	.set_tdm_slot = cs35l56_sdw_dai_set_tdm_slot,
+	.shutdown = cs35l56_sdw_dai_shutdown,
+	.hw_params = cs35l56_sdw_dai_hw_params,
+	.hw_free = cs35l56_sdw_dai_hw_free,
+	.mute_stream = cs35l56_mute_stream,
+	.set_stream = cs35l56_sdw_dai_set_stream,
+};
+
+static struct snd_soc_dai_driver cs35l56_dai[] = {
+	{
+		.name = "cs35l56-asp1",
+		.id = 0,
+		.playback = {
+			.stream_name = "ASP1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = CS35L56_RATES,
+			.formats = CS35L56_RX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASP1 Capture",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = CS35L56_RATES,
+			.formats = CS35L56_TX_FORMATS,
+		},
+		.ops = &cs35l56_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+	{
+		.name = "cs35l56-sdw1",
+		.id = 1,
+		.playback = {
+			.stream_name = "SDW1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = CS35L56_RATES,
+			.formats = CS35L56_RX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "SDW1 Capture",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = CS35L56_RATES,
+			.formats = CS35L56_TX_FORMATS,
+		},
+		.symmetric_rate = 1,
+		.ops = &cs35l56_sdw_dai_ops,
+	}
+};
+
+static int cs35l56_wait_for_firmware_boot(struct cs35l56_private *cs35l56)
+{
+	unsigned int reg;
+	unsigned int val;
+	int ret;
+
+	if (cs35l56->rev < CS35L56_REVID_B0)
+		reg = CS35L56_DSP1_HALO_STATE_A1;
+	else
+		reg = CS35L56_DSP1_HALO_STATE;
+
+	ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
+				       val,
+				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
+				       CS35L56_HALO_STATE_POLL_US,
+				       CS35L56_HALO_STATE_TIMEOUT_US);
+
+	if ((ret < 0) && (ret != -ETIMEDOUT)) {
+		dev_err(cs35l56->dev, "Failed to read HALO_STATE: %d\n", ret);
+		return ret;
+	}
+
+	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
+		dev_err(cs35l56->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct reg_sequence cs35l56_system_reset_seq[] = {
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
+};
+
+static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
+{
+	cs35l56->soft_resetting = true;
+
+	/*
+	 * Must enter cache-only first so there can't be any more register
+	 * accesses other than the controlled system reset sequence below.
+	 */
+	regcache_cache_only(cs35l56->regmap, true);
+	regmap_multi_reg_write_bypassed(cs35l56->regmap,
+					cs35l56_system_reset_seq,
+					ARRAY_SIZE(cs35l56_system_reset_seq));
+
+	/* On SoundWire the registers won't be accessible until it re-enumerates. */
+	if (cs35l56->sdw_peripheral)
+		return;
+
+	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
+	regcache_cache_only(cs35l56->regmap, false);
+}
+
+static void cs35l56_dsp_work(struct work_struct *work)
+{
+	struct cs35l56_private *cs35l56 = container_of(work,
+						       struct cs35l56_private,
+						       dsp_work);
+	unsigned int reg;
+	unsigned int val;
+	int ret = 0;
+
+	if (!wait_for_completion_timeout(&cs35l56->init_completion,
+					 msecs_to_jiffies(5000))) {
+		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
+		goto complete;
+	}
+
+	if (!cs35l56->init_done || cs35l56->removing)
+		goto complete;
+
+	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
+					   cs35l56->secured ? "s" : "", cs35l56->rev);
+
+	if (!cs35l56->dsp.part)
+		goto complete;
+
+	pm_runtime_get_sync(cs35l56->dev);
+
+	/*
+	 * Disable SoundWire interrupts to prevent race with IRQ work.
+	 * Setting sdw_irq_no_unmask prevents the handler re-enabling
+	 * the SoundWire interrupt.
+	 */
+	if (cs35l56->sdw_peripheral) {
+		cs35l56->sdw_irq_no_unmask = true;
+		cancel_work_sync(&cs35l56->sdw_irq_work);
+		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
+		sdw_read_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1);
+		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
+	}
+
+	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
+	if (ret) {
+		dev_dbg(cs35l56->dev, "%s: CS35L56_MBOX_CMD_SHUTDOWN ret %d\n", __func__, ret);
+		goto err;
+	}
+
+	if (cs35l56->rev < CS35L56_REVID_B0)
+		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
+	else
+		reg = CS35L56_DSP1_PM_CUR_STATE;
+
+	ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
+				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
+				       CS35L56_HALO_STATE_POLL_US,
+				       CS35L56_HALO_STATE_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(cs35l56->dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
+			val, ret);
+
+	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
+	ret = wm_adsp_power_up(&cs35l56->dsp);
+	if (ret) {
+		dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
+		goto err;
+	}
+
+	if (cs35l56->removing)
+		goto err;
+
+	mutex_lock(&cs35l56->irq_lock);
+
+	init_completion(&cs35l56->init_completion);
+
+	cs35l56_system_reset(cs35l56);
+
+	if (cs35l56->sdw_peripheral) {
+		if (!wait_for_completion_timeout(&cs35l56->init_completion,
+						 msecs_to_jiffies(5000))) {
+			dev_err(cs35l56->dev, "%s: init_completion timed out (SDW)\n", __func__);
+			goto err_unlock;
+		}
+	} else {
+		if (cs35l56_init(cs35l56))
+			goto err_unlock;
+	}
+
+	cs35l56->fw_patched = true;
+
+err_unlock:
+	mutex_unlock(&cs35l56->irq_lock);
+err:
+	pm_runtime_mark_last_busy(cs35l56->dev);
+	pm_runtime_put_autosuspend(cs35l56->dev);
+
+	/* Re-enable SoundWire interrupts */
+	if (cs35l56->sdw_peripheral) {
+		cs35l56->sdw_irq_no_unmask = false;
+		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
+				CS35L56_SDW_INT_MASK_CODEC_IRQ);
+	}
+
+complete:
+	complete_all(&cs35l56->dsp_ready_completion);
+}
+
+static int cs35l56_component_probe(struct snd_soc_component *component)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct dentry *debugfs_root = component->debugfs_root;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_tx_input_texts) != ARRAY_SIZE(cs35l56_tx_input_values));
+
+	cs35l56->removing = false;
+	cs35l56->component = component;
+	wm_adsp2_component_probe(&cs35l56->dsp, component);
+
+	debugfs_create_bool("init_done", 0444, debugfs_root, &cs35l56->init_done);
+	debugfs_create_bool("can_hibernate", 0444, debugfs_root, &cs35l56->can_hibernate);
+	debugfs_create_bool("fw_patched", 0444, debugfs_root, &cs35l56->fw_patched);
+
+	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
+
+	return 0;
+}
+
+static void cs35l56_component_remove(struct snd_soc_component *component)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+
+	cs35l56->removing = true;
+	complete(&cs35l56->init_completion);
+	cancel_work_sync(&cs35l56->dsp_work);
+}
+
+static int cs35l56_set_bias_level(struct snd_soc_component *component,
+				  enum snd_soc_bias_level level)
+{
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		/*
+		 * Wait for patching to complete when transitioning from
+		 * BIAS_OFF to BIAS_STANDBY
+		 */
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+			ret = cs35l56_wait_dsp_ready(cs35l56);
+
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver soc_component_dev_cs35l56 = {
+	.probe = cs35l56_component_probe,
+	.remove = cs35l56_component_remove,
+
+	.dapm_widgets = cs35l56_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cs35l56_dapm_widgets),
+	.dapm_routes = cs35l56_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(cs35l56_audio_map),
+	.controls = cs35l56_controls,
+	.num_controls = ARRAY_SIZE(cs35l56_controls),
+
+	.set_bias_level = cs35l56_set_bias_level,
+};
+
+static const struct reg_sequence cs35l56_hibernate_seq[] = {
+	/* This must be the last register access */
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_HIBERNATE_NOW),
+};
+
+static const struct reg_sequence cs35l56_hibernate_wake_seq[] = {
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_WAKEUP),
+};
+
+int cs35l56_runtime_suspend(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	if (!cs35l56->init_done)
+		return 0;
+
+	/* Firmware must have entered a power-save state */
+	ret = regmap_read_poll_timeout(cs35l56->regmap,
+				       CS35L56_TRANSDUCER_ACTUAL_PS,
+				       val, (val >= CS35L56_PS3),
+				       CS35L56_PS3_POLL_US,
+				       CS35L56_PS3_TIMEOUT_US);
+	if (ret)
+		dev_warn(cs35l56->dev, "PS3 wait failed: %d\n", ret);
+
+	/* Clear BOOT_DONE so it can be used to detect a reboot */
+	regmap_write(cs35l56->regmap, CS35L56_IRQ1_EINT_4, CS35L56_OTP_BOOT_DONE_MASK);
+
+	if (!cs35l56->can_hibernate) {
+		regcache_cache_only(cs35l56->regmap, true);
+		dev_dbg(dev, "Suspended: no hibernate");
+
+		return 0;
+	}
+
+	/*
+	 * Enable auto-hibernate. If it is woken by some other wake source
+	 * it will automatically return to hibernate.
+	 */
+	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
+	if (ret)
+		dev_warn(cs35l56->dev, "ALLOW_HIBERNATE failed: %d\n", ret);
+
+	/*
+	 * Must enter cache-only first so there can't be any more register
+	 * accesses other than the controlled hibernate sequence below.
+	 */
+	regcache_cache_only(cs35l56->regmap, true);
+
+	regmap_multi_reg_write_bypassed(cs35l56->regmap,
+					cs35l56_hibernate_seq,
+					ARRAY_SIZE(cs35l56_hibernate_seq));
+
+	dev_dbg(dev, "Suspended: hibernate");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_suspend, SND_SOC_CS35L56_CORE);
+
+static int __maybe_unused cs35l56_runtime_resume_i2c_spi(struct device *dev)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+
+	if (!cs35l56->init_done)
+		return 0;
+
+	return cs35l56_runtime_resume_common(cs35l56);
+}
+
+int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
+{
+	unsigned int val;
+	int ret;
+
+	if (!cs35l56->can_hibernate) {
+		regcache_cache_only(cs35l56->regmap, false);
+		goto out_sync;
+	}
+
+	if (!cs35l56->sdw_peripheral) {
+		/*
+		 * Dummy transaction to trigger I2C/SPI auto-wake. This will NAK on I2C.
+		 * Must be done before releasing cache-only.
+		 */
+		regmap_multi_reg_write_bypassed(cs35l56->regmap,
+						cs35l56_hibernate_wake_seq,
+						ARRAY_SIZE(cs35l56_hibernate_wake_seq));
+
+		usleep_range(CS35L56_CONTROL_PORT_READY_US,
+			     CS35L56_CONTROL_PORT_READY_US + 400);
+	}
+
+	regcache_cache_only(cs35l56->regmap, false);
+
+	ret = cs35l56_wait_for_firmware_boot(cs35l56);
+	if (ret) {
+		dev_err(cs35l56->dev, "Hibernate wake failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
+	if (ret)
+		goto err;
+
+out_sync:
+	/* BOOT_DONE will be 1 if the amp reset */
+	regmap_read(cs35l56->regmap, CS35L56_IRQ1_EINT_4, &val);
+	if (val & CS35L56_OTP_BOOT_DONE_MASK) {
+		dev_dbg(cs35l56->dev, "Registers reset in suspend\n");
+		regcache_mark_dirty(cs35l56->regmap);
+	}
+
+	regcache_sync(cs35l56->regmap);
+
+	dev_dbg(cs35l56->dev, "Resumed");
+
+	return 0;
+
+err:
+	regmap_write(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+		     CS35L56_MBOX_CMD_HIBERNATE_NOW);
+
+	regcache_cache_only(cs35l56->regmap, true);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
+
+static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
+{
+	struct wm_adsp *dsp;
+	int ret;
+
+	cs35l56->dsp_wq = create_singlethread_workqueue("cs35l56-dsp");
+	if (!cs35l56->dsp_wq)
+		return -ENOMEM;
+
+	INIT_WORK(&cs35l56->dsp_work, cs35l56_dsp_work);
+	init_completion(&cs35l56->dsp_ready_completion);
+
+	dsp = &cs35l56->dsp;
+	dsp->part = "cs35l56";
+	dsp->cs_dsp.num = 1;
+	dsp->cs_dsp.type = WMFW_HALO;
+	dsp->cs_dsp.rev = 0;
+	dsp->fw = 12;
+	dsp->cs_dsp.dev = cs35l56->dev;
+	dsp->cs_dsp.regmap = cs35l56->regmap;
+	dsp->cs_dsp.base = CS35L56_DSP1_CORE_BASE;
+	dsp->cs_dsp.base_sysinfo = CS35L56_DSP1_SYS_INFO_ID;
+	dsp->cs_dsp.mem = cs35l56_dsp1_regions;
+	dsp->cs_dsp.num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
+	dsp->cs_dsp.no_core_startstop = true;
+	dsp->wmfw_optional = true;
+
+	dev_dbg(cs35l56->dev, "DSP system name: '%s'\n", dsp->system_name);
+
+	ret = wm_halo_init(dsp);
+	if (ret != 0) {
+		dev_err(cs35l56->dev, "wm_halo_init failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
+{
+	acpi_handle handle = ACPI_HANDLE(cs35l56->dev);
+	const char *sub;
+
+	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
+	if (!handle)
+		return 0;
+
+	sub = acpi_get_subsystem_id(handle);
+	if (IS_ERR(sub)) {
+		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwise fail */
+		if (PTR_ERR(sub) == -ENODATA)
+			return 0;
+		else
+			return PTR_ERR(sub);
+	}
+
+	cs35l56->dsp.system_name = sub;
+	dev_dbg(cs35l56->dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
+
+	return 0;
+}
+
+int cs35l56_common_probe(struct cs35l56_private *cs35l56)
+{
+	int ret;
+
+	init_completion(&cs35l56->init_completion);
+	mutex_init(&cs35l56->irq_lock);
+
+	dev_set_drvdata(cs35l56->dev, cs35l56);
+
+	cs35l56_fill_supply_names(cs35l56->supplies);
+	ret = devm_regulator_bulk_get(cs35l56->dev, ARRAY_SIZE(cs35l56->supplies),
+				      cs35l56->supplies);
+	if (ret != 0)
+		return dev_err_probe(cs35l56->dev, ret, "Failed to request supplies\n");
+
+	/* Reset could be controlled by the BIOS or shared by multiple amps */
+	cs35l56->reset_gpio = devm_gpiod_get_optional(cs35l56->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs35l56->reset_gpio)) {
+		ret = PTR_ERR(cs35l56->reset_gpio);
+		/*
+		 * If RESET is shared the first amp to probe will grab the reset
+		 * line and reset all the amps
+		 */
+		if (ret != -EBUSY)
+			return dev_err_probe(cs35l56->dev, ret, "Failed to get reset GPIO\n");
+
+		dev_info(cs35l56->dev, "Reset GPIO busy, assume shared reset\n");
+		cs35l56->reset_gpio = NULL;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
+	if (ret != 0)
+		return dev_err_probe(cs35l56->dev, ret, "Failed to enable supplies\n");
+
+	if (cs35l56->reset_gpio) {
+		/* satisfy minimum reset pulse width spec */
+		usleep_range(CS35L56_RESET_PULSE_MIN_US,
+			     CS35L56_RESET_PULSE_MIN_US + 400);
+		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
+	}
+
+	ret = cs35l56_acpi_get_name(cs35l56);
+	if (ret != 0)
+		goto err;
+
+	ret = cs35l56_dsp_init(cs35l56);
+	if (ret < 0) {
+		dev_err_probe(cs35l56->dev, ret, "DSP init failed\n");
+		goto err;
+	}
+
+	ret = devm_snd_soc_register_component(cs35l56->dev,
+					      &soc_component_dev_cs35l56,
+					      cs35l56_dai, ARRAY_SIZE(cs35l56_dai));
+	if (ret < 0) {
+		dev_err_probe(cs35l56->dev, ret, "Register codec failed\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_common_probe, SND_SOC_CS35L56_CORE);
+
+int cs35l56_init(struct cs35l56_private *cs35l56)
+{
+	int ret;
+	unsigned int devid, revid, otpid, secured;
+
+	/*
+	 * Check whether the actions associated with soft reset or one time
+	 * init need to be performed.
+	 */
+	if (cs35l56->soft_resetting)
+		goto post_soft_reset;
+
+	if (cs35l56->init_done)
+		return 0;
+
+	pm_runtime_set_autosuspend_delay(cs35l56->dev, 100);
+	pm_runtime_use_autosuspend(cs35l56->dev);
+	pm_runtime_set_active(cs35l56->dev);
+	pm_runtime_enable(cs35l56->dev);
+
+	/*
+	 * If the system is not using a reset_gpio then issue a
+	 * dummy read to force a wakeup.
+	 */
+	if (!cs35l56->reset_gpio)
+		regmap_read(cs35l56->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
+
+	/* Wait for control port to be ready (datasheet tIRS). */
+	usleep_range(CS35L56_CONTROL_PORT_READY_US,
+		     CS35L56_CONTROL_PORT_READY_US + 400);
+
+	/*
+	 * The HALO_STATE register is in different locations on Ax and B0
+	 * devices so the REVID needs to be determined before waiting for the
+	 * firmware to boot.
+	 */
+	ret = regmap_read(cs35l56->regmap, CS35L56_REVID, &revid);
+	if (ret < 0) {
+		dev_err(cs35l56->dev, "Get Revision ID failed\n");
+		return ret;
+	}
+	cs35l56->rev = revid & (CS35L56_AREVID_MASK | CS35L56_MTLREVID_MASK);
+
+	ret = cs35l56_wait_for_firmware_boot(cs35l56);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(cs35l56->regmap, CS35L56_DEVID, &devid);
+	if (ret < 0) {
+		dev_err(cs35l56->dev, "Get Device ID failed\n");
+		return ret;
+	}
+	devid &= CS35L56_DEVID_MASK;
+
+	switch (devid) {
+	case 0x35A56:
+		break;
+	default:
+		dev_err(cs35l56->dev, "Unknown device %x\n", devid);
+		return ret;
+	}
+
+	ret = regmap_read(cs35l56->regmap, CS35L56_DSP_RESTRICT_STS1, &secured);
+	if (ret) {
+		dev_err(cs35l56->dev, "Get Secure status failed\n");
+		return ret;
+	}
+
+	/* When any bus is restricted treat the device as secured */
+	if (secured & CS35L56_RESTRICTED_MASK)
+		cs35l56->secured = true;
+
+	ret = regmap_read(cs35l56->regmap, CS35L56_OTPID, &otpid);
+	if (ret < 0) {
+		dev_err(cs35l56->dev, "Get OTP ID failed\n");
+		return ret;
+	}
+
+	dev_info(cs35l56->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
+		 cs35l56->secured ? "s" : "", cs35l56->rev, otpid);
+
+	cs35l56_patch(cs35l56->dev, cs35l56->regmap, cs35l56->rev);
+
+	/* Wake source interrupts default to unmasked, so mask them */
+	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_1,
+			   CS35L56_AMP_SHORT_ERR_EINT1_MASK,
+			   0);
+	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_8,
+			   CS35L56_TEMP_ERR_EINT1_MASK,
+			   0);
+
+	if (!cs35l56->reset_gpio) {
+		dev_dbg(cs35l56->dev, "No reset gpio: using soft reset\n");
+		cs35l56_system_reset(cs35l56);
+		if (cs35l56->sdw_peripheral) {
+			/* Keep alive while we wait for re-enumeration */
+			pm_runtime_get_noresume(cs35l56->dev);
+			return 0;
+		}
+	}
+
+post_soft_reset:
+	if (cs35l56->soft_resetting) {
+		cs35l56->soft_resetting = false;
+
+		/* Done re-enumerating after one-time init so release the keep-alive */
+		if (cs35l56->sdw_peripheral && !cs35l56->init_done)
+			pm_runtime_put_noidle(cs35l56->dev);
+
+		regcache_mark_dirty(cs35l56->regmap);
+		ret = cs35l56_wait_for_firmware_boot(cs35l56);
+		if (ret)
+			return ret;
+
+		dev_dbg(cs35l56->dev, "Firmware rebooted after soft reset\n");
+	}
+
+	/* Disable auto-hibernate so that runtime_pm has control */
+	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
+	if (ret)
+		return ret;
+
+	/* Populate soft registers in the regmap cache */
+	cs35l56_reread_firmware_registers(cs35l56->dev, cs35l56->regmap);
+
+	/* Registers could be dirty after soft reset or SoundWire enumeration */
+	regcache_sync(cs35l56->regmap);
+
+	cs35l56->init_done = true;
+	complete(&cs35l56->init_completion);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_init, SND_SOC_CS35L56_CORE);
+
+int cs35l56_remove(struct cs35l56_private *cs35l56)
+{
+	cs35l56->init_done = false;
+
+	/*
+	 * WAKE IRQs unmask if CS35L56 hibernates so free the handler to
+	 * prevent it racing with remove().
+	 */
+	if (cs35l56->irq)
+		devm_free_irq(cs35l56->dev, cs35l56->irq, cs35l56);
+
+	flush_workqueue(cs35l56->dsp_wq);
+	destroy_workqueue(cs35l56->dsp_wq);
+
+	pm_runtime_suspend(cs35l56->dev);
+	pm_runtime_disable(cs35l56->dev);
+
+	regcache_cache_only(cs35l56->regmap, true);
+
+	kfree(cs35l56->dsp.system_name);
+
+	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
+
+const struct dev_pm_ops cs35l56_pm_ops_i2c_spi = {
+	SET_RUNTIME_PM_OPS(cs35l56_runtime_suspend, cs35l56_runtime_resume_i2c_spi, NULL)
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE);
+
+MODULE_DESCRIPTION("ASoC CS35L56 driver");
+MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
new file mode 100644
index 000000000000..efc4b99180f9
--- /dev/null
+++ b/sound/soc/codecs/cs35l56.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Driver for Cirrus Logic CS35L56 smart amp
+ *
+ * Copyright (C) 2023 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef CS35L56_H
+#define CS35L56_H
+
+#include <linux/completion.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/workqueue.h>
+#include <sound/cs35l56.h>
+#include "wm_adsp.h"
+
+#define CS35L56_SDW_GEN_INT_STAT_1	0xc0
+#define CS35L56_SDW_GEN_INT_MASK_1	0xc1
+#define CS35L56_SDW_INT_MASK_CODEC_IRQ	BIT(0)
+
+#define CS35L56_SDW_INVALID_BUS_SCALE	0xf
+
+#define CS35L56_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define CS35L56_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE \
+			    | SNDRV_PCM_FMTBIT_S32_LE)
+
+#define CS35L56_RATES (SNDRV_PCM_RATE_48000)
+
+struct sdw_slave;
+
+struct cs35l56_private {
+	struct wm_adsp dsp; /* must be first member */
+	struct work_struct dsp_work;
+	struct workqueue_struct *dsp_wq;
+	struct completion dsp_ready_completion;
+	struct mutex irq_lock;
+	struct snd_soc_component *component;
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator_bulk_data supplies[CS35L56_NUM_BULK_SUPPLIES];
+	int irq;
+	struct sdw_slave *sdw_peripheral;
+	u8 rev;
+	struct work_struct sdw_irq_work;
+	bool secured;
+	bool sdw_irq_no_unmask;
+	bool soft_resetting;
+	bool init_done;
+	bool sdw_attached;
+	bool removing;
+	bool fw_patched;
+	bool can_hibernate;
+	struct completion init_completion;
+	struct gpio_desc *reset_gpio;
+
+	u32 rx_mask;
+	u32 tx_mask;
+	u8 asp_slot_width;
+	u8 asp_slot_count;
+	bool tdm_mode;
+	bool sysclk_set;
+	u8 old_sdw_clock_scale;
+};
+
+extern const struct dev_pm_ops cs35l56_pm_ops_i2c_spi;
+
+int cs35l56_runtime_suspend(struct device *dev);
+int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56);
+irqreturn_t cs35l56_irq(int irq, void *data);
+int cs35l56_irq_request(struct cs35l56_private *cs35l56);
+int cs35l56_common_probe(struct cs35l56_private *cs35l56);
+int cs35l56_init(struct cs35l56_private *cs35l56);
+int cs35l56_remove(struct cs35l56_private *cs35l56);
+
+#endif /* ifndef CS35L56_H */
-- 
2.30.2

