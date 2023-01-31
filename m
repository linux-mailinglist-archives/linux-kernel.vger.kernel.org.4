Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2C682E80
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjAaNzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAaNzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:55:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641E4B1A9;
        Tue, 31 Jan 2023 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675173331; x=1706709331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IejCjfETg28DEDjjWsKtgjkb7Y0hOwxTAEjBfl4ZLhE=;
  b=Vt7RHBsrQWC5Bq6J9xT5WLRjWaRTxUutaXSR0c3iF4SbOYTklcLJ4FJc
   H3HSl72dJOo3ohj4xkH1Te7O6R1u6C+1qm7pFVp572EvF4pbOUndHA43u
   RmP2iyrZRjR1qFCZR+fMgTJ8KMzhcTuN/MsBuDmWJ2DrmbQNirGBDyqwc
   MrhsKXvJJNrtF7I9OdGH+SliYG1OGbg5zick/kiI6itJM8h5Y1w7HiHva
   x3X03CYqnPryqcCF2Af67JNfgz75YHKipkCSaESM+V5HHMmmEuXXOsMW5
   2nXT1ce5QphgZD0L5Ti3bSqfoQjADLsosZpk3VQ2bjmMNmrvvx6f2fIZq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392392291"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="392392291"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:55:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909911049"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909911049"
Received: from amedve1x-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.35.45])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:55:11 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH] hwmon: intel-m10-bmc-hwmon: Add N6000 sensors
Date:   Tue, 31 Jan 2023 15:54:50 +0200
Message-Id: <20230131135450.43072-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

Add sensors supported by N6000 card with MAX10 BMC to monitor
temperature, voltage, current, and power on board.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>

---
 drivers/hwmon/intel-m10-bmc-hwmon.c | 229 ++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index 6e82f7200d1c..2f0323c14bab 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -340,6 +340,231 @@ static const struct m10bmc_hwmon_board_data n5010bmc_hwmon_bdata = {
 	.hinfo = n5010bmc_hinfo,
 };
 
+static const struct m10bmc_sdata n6000bmc_temp_tbl[] = {
+	{ 0x444, 0x448, 0x44c, 0x0, 0x0, 500, "FPGA E-TILE Temperature #1" },
+	{ 0x450, 0x454, 0x458, 0x0, 0x0, 500, "FPGA E-TILE Temperature #2" },
+	{ 0x45c, 0x460, 0x464, 0x0, 0x0, 500, "FPGA E-TILE Temperature #3" },
+	{ 0x468, 0x46c, 0x470, 0x0, 0x0, 500, "FPGA E-TILE Temperature #4" },
+	{ 0x474, 0x478, 0x47c, 0x0, 0x0, 500, "FPGA P-TILE Temperature" },
+	{ 0x484, 0x488, 0x48c, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #1" },
+	{ 0x490, 0x494, 0x498, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #2" },
+	{ 0x49c, 0x4a0, 0x4a4, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #3" },
+	{ 0x4a8, 0x4ac, 0x4b0, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #4" },
+	{ 0x4b4, 0x4b8, 0x4bc, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #5" },
+	{ 0x4c0, 0x4c4, 0x4c8, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #1" },
+	{ 0x4cc, 0x4d0, 0x4d4, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #2" },
+	{ 0x4d8, 0x4dc, 0x4e0, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #3" },
+	{ 0x4e4, 0x4e8, 0x4ec, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #4" },
+	{ 0x4f0, 0x4f4, 0x4f8, 0x52c, 0x0, 500, "Board Top Near FPGA Temperature" },
+	{ 0x4fc, 0x500, 0x504, 0x52c, 0x0, 500, "Board Bottom Near CVL Temperature" },
+	{ 0x508, 0x50c, 0x510, 0x52c, 0x0, 500, "Board Top East Near VRs Temperature" },
+	{ 0x514, 0x518, 0x51c, 0x52c, 0x0, 500, "Columbiaville Die Temperature" },
+	{ 0x520, 0x524, 0x528, 0x52c, 0x0, 500, "Board Rear Side Temperature" },
+	{ 0x530, 0x534, 0x538, 0x52c, 0x0, 500, "Board Front Side Temperature" },
+	{ 0x53c, 0x540, 0x544, 0x0, 0x0, 500, "QSFP1 Case Temperature" },
+	{ 0x548, 0x54c, 0x550, 0x0, 0x0, 500, "QSFP2 Case Temperature" },
+	{ 0x554, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage Phase 0 VR Temperature" },
+	{ 0x560, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage Phase 1 VR Temperature" },
+	{ 0x56c, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage Phase 2 VR Temperature" },
+	{ 0x578, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage VR Controller Temperature" },
+	{ 0x584, 0x0, 0x0, 0x0, 0x0, 500, "FPGA VCCH VR Temperature" },
+	{ 0x590, 0x0, 0x0, 0x0, 0x0, 500, "FPGA VCC_1V2 VR Temperature" },
+	{ 0x59c, 0x0, 0x0, 0x0, 0x0, 500, "FPGA VCCH, VCC_1V2 VR Controller Temperature" },
+	{ 0x5a8, 0x0, 0x0, 0x0, 0x0, 500, "3V3 VR Temperature" },
+	{ 0x5b4, 0x0, 0x0, 0x0, 0x0, 500, "CVL Core Voltage VR Temperature" },
+	{ 0x5c4, 0x5c8, 0x5cc, 0x5c0, 0x0, 500, "FPGA P-Tile Temperature [Remote]" },
+	{ 0x5d0, 0x5d4, 0x5d8, 0x5c0, 0x0, 500, "FPGA E-Tile Temperature [Remote]" },
+	{ 0x5dc, 0x5e0, 0x5e4, 0x5c0, 0x0, 500, "FPGA SDM Temperature [Remote]" },
+	{ 0x5e8, 0x5ec, 0x5f0, 0x5c0, 0x0, 500, "FPGA Corner Temperature [Remote]" },
+};
+
+static const struct m10bmc_sdata n6000bmc_in_tbl[] = {
+	{ 0x5f4, 0x0, 0x0, 0x0, 0x0, 1, "Inlet 12V PCIe Rail Voltage" },
+	{ 0x60c, 0x0, 0x0, 0x0, 0x0, 1, "Inlet 12V Aux Rail Voltage" },
+	{ 0x624, 0x0, 0x0, 0x0, 0x0, 1, "Inlet 3V3 PCIe Rail Voltage" },
+	{ 0x63c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage Rail Voltage" },
+	{ 0x644, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCH Rail Voltage" },
+	{ 0x64c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCC_1V2 Rail Voltage" },
+	{ 0x654, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCH_GXER_1V1, VCCA_1V8 Voltage" },
+	{ 0x664, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCIO_1V2 Voltage" },
+	{ 0x674, 0x0, 0x0, 0x0, 0x0, 1, "CVL Non Core Rails Inlet Voltage" },
+	{ 0x684, 0x0, 0x0, 0x0, 0x0, 1, "MAX10 & Board CLK PWR 3V3 Inlet Voltage" },
+	{ 0x694, 0x0, 0x0, 0x0, 0x0, 1, "CVL Core Voltage Rail Voltage" },
+	{ 0x6ac, 0x0, 0x0, 0x0, 0x0, 1, "Board 3V3 VR Voltage" },
+	{ 0x6b4, 0x0, 0x0, 0x0, 0x0, 1, "QSFP 3V3 Rail Voltage" },
+	{ 0x6c4, 0x0, 0x0, 0x0, 0x0, 1, "QSFP (Primary) Supply Rail Voltage" },
+	{ 0x6c8, 0x0, 0x0, 0x0, 0x0, 1, "QSFP (Secondary) Supply Rail Voltage" },
+	{ 0x6cc, 0x0, 0x0, 0x0, 0x0, 1, "VCCCLK_GXER_2V5 Voltage" },
+	{ 0x6d0, 0x0, 0x0, 0x0, 0x0, 1, "AVDDH_1V1_CVL Voltage" },
+	{ 0x6d4, 0x0, 0x0, 0x0, 0x0, 1, "VDDH_1V8_CVL Voltage" },
+	{ 0x6d8, 0x0, 0x0, 0x0, 0x0, 1, "VCCA_PLL Voltage" },
+	{ 0x6e0, 0x0, 0x0, 0x0, 0x0, 1, "VCCRT_GXER_0V9 Voltage" },
+	{ 0x6e8, 0x0, 0x0, 0x0, 0x0, 1, "VCCRT_GXPL_0V9 Voltage" },
+	{ 0x6f0, 0x0, 0x0, 0x0, 0x0, 1, "VCCH_GXPL_1V8 Voltage" },
+	{ 0x6f4, 0x0, 0x0, 0x0, 0x0, 1, "VCCPT_1V8 Voltage" },
+	{ 0x6fc, 0x0, 0x0, 0x0, 0x0, 1, "VCC_3V3_M10 Voltage" },
+	{ 0x700, 0x0, 0x0, 0x0, 0x0, 1, "VCC_1V8_M10 Voltage" },
+	{ 0x704, 0x0, 0x0, 0x0, 0x0, 1, "VCC_1V2_EMIF1_2_3 Voltage" },
+	{ 0x70c, 0x0, 0x0, 0x0, 0x0, 1, "VCC_1V2_EMIF4_5 Voltage" },
+	{ 0x714, 0x0, 0x0, 0x0, 0x0, 1, "VCCA_1V8 Voltage" },
+	{ 0x718, 0x0, 0x0, 0x0, 0x0, 1, "VCCH_GXER_1V1 Voltage" },
+	{ 0x71c, 0x0, 0x0, 0x0, 0x0, 1, "AVDD_ETH_0V9_CVL Voltage" },
+	{ 0x720, 0x0, 0x0, 0x0, 0x0, 1, "AVDD_PCIE_0V9_CVL Voltage" },
+};
+
+static const struct m10bmc_sdata n6000bmc_curr_tbl[] = {
+	{ 0x600, 0x604, 0x608, 0x0, 0x0, 1, "Inlet 12V PCIe Rail Current" },
+	{ 0x618, 0x61c, 0x620, 0x0, 0x0, 1, "Inlet 12V Aux Rail Current" },
+	{ 0x630, 0x634, 0x638, 0x0, 0x0, 1, "Inlet 3V3 PCIe Rail Current" },
+	{ 0x640, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage Rail Current" },
+	{ 0x648, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCH Rail Current" },
+	{ 0x650, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCC_1V2 Rail Current" },
+	{ 0x658, 0x65c, 0x660, 0x0, 0x0, 1, "FPGA VCCH_GXER_1V1, VCCA_1V8 Current" },
+	{ 0x668, 0x66c, 0x670, 0x0, 0x0, 1, "FPGA VCCIO_1V2 Current" },
+	{ 0x678, 0x67c, 0x680, 0x0, 0x0, 1, "CVL Non Core Rails Inlet Current" },
+	{ 0x688, 0x68c, 0x690, 0x0, 0x0, 1, "MAX10 & Board CLK PWR 3V3 Inlet Current" },
+	{ 0x698, 0x0, 0x0, 0x0, 0x0, 1, "CVL Core Voltage Rail Current" },
+	{ 0x6b0, 0x0, 0x0, 0x0, 0x0, 1, "Board 3V3 VR Current" },
+	{ 0x6b8, 0x6bc, 0x6c0, 0x0, 0x0, 1, "QSFP 3V3 Rail Current" },
+};
+
+static const struct m10bmc_sdata n6000bmc_power_tbl[] = {
+	{ 0x724, 0x0, 0x0, 0x0, 0x0, 1, "Board Power" },
+};
+
+static const struct hwmon_channel_info *n6000bmc_hinfo[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
+			   HWMON_C_LABEL),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_LABEL),
+	NULL
+};
+
+static const struct m10bmc_hwmon_board_data n6000bmc_hwmon_bdata = {
+	.tables = {
+		[hwmon_temp] = n6000bmc_temp_tbl,
+		[hwmon_in] = n6000bmc_in_tbl,
+		[hwmon_curr] = n6000bmc_curr_tbl,
+		[hwmon_power] = n6000bmc_power_tbl,
+	},
+
+	.hinfo = n6000bmc_hinfo,
+};
+
 static umode_t
 m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 			u32 attr, int channel)
@@ -549,6 +774,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
 		.name = "n5010bmc-hwmon",
 		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
 	},
+	{
+		.name = "n6000bmc-hwmon",
+		.driver_data = (unsigned long)&n6000bmc_hwmon_bdata,
+	},
 	{ }
 };
 

-- 
tg: (65f974c89cff..) hwmon/n6000 (depends on: log/drv)
