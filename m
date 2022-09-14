Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E75B7E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiINBkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiINBkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:40:02 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A144363B;
        Tue, 13 Sep 2022 18:39:56 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d16so7221952ils.8;
        Tue, 13 Sep 2022 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iFBjT+kVgZLFl1I3aCYNHPtddToyGvrt9bRxa3+1gh0=;
        b=gvgCUkQdw6P5WJf6zsBR6HhI4DewPWE7CA4/Sa5mNSTo0E4pEhhWc0zann1KCzWy93
         Y0K+3H39JlhuCbaJIQce5OozT5lByWaBoV29p/IQclB5akrVyEJC335D5XnI6ADzPsaY
         wMO2jzrf/COpa1C8vGl4rzrrJX3fJEph8MzWbetfOlizutPsWNDbf9qBaRennu3MT0qv
         a1DM91Fzvt8fgGOBtRpEMfo4BFnbOgiRyQ/da4s7I4TVhwm5vd1V1tYk5yBdy4eEKfJR
         rMNJ/Sos6Jn/j//+20pQUooMmHYlmvHtGNRoAmioKI1BK8DcUykaX6Y4SVQ1UKbvAEXk
         EIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iFBjT+kVgZLFl1I3aCYNHPtddToyGvrt9bRxa3+1gh0=;
        b=6ptgV0fJV3RxIrdtgr+ZdQnu/3yDJHyBdlpsTVx8tvJt8PVsz2i+Xr4LBu0QXlTfA7
         ixE14XKfY4CMOYS3JRhZ+f4sReptraQmjDvyWr4BZIQ0wl4HpylobdJoUXjq3V+kI36B
         Ow47mXIrwrIi5r0YfONzbQlsfR3AuCcqwfgYHNTBQTj/id/Sl+UxwV4XXDZCFo8Xw3oN
         +uZ0pEe6kJvDG1m/60aEeH3yt3yiniL7ptXBnaW7ApXlj3tLyUwkMducnVtZyVgvhLMV
         VL8p0DkER2gKrYTg6zZGCkPUa0cJ+4iLtr4I9dedYMKAGQQCxxsjRnpG4qfJ/SCzO+CK
         tuSA==
X-Gm-Message-State: ACgBeo0S7Cj4XaquDdeAuxTggXvEi1a6/eAj6uzhYynA+WOfw3ywsBvl
        7X3vX66UNgAEi4GlBNQ3izL9hoBD/rg=
X-Google-Smtp-Source: AA6agR6NMaFpxniiughvZ0K2FMpCsGs3+Lr8yNaDDUdsWdNNy+ztPtxYT+NrajC90PWbvG9J7umUfg==
X-Received: by 2002:a05:6e02:1946:b0:2f2:1885:630a with SMTP id x6-20020a056e02194600b002f21885630amr14001588ilu.231.1663119595724;
        Tue, 13 Sep 2022 18:39:55 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::af41])
        by smtp.gmail.com with UTF8SMTPSA id 18-20020a056e020cb200b002f16e7021f6sm5838927ilg.22.2022.09.13.18.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:39:55 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH v4 3/3] clk: qcom: gcc-sdm845: add sdm670 global clock data
Date:   Tue, 13 Sep 2022 21:39:22 -0400
Message-Id: <20220914013922.198778-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914013922.198778-1-mailingradian@gmail.com>
References: <20220914013922.198778-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Snapdragon 670 adds and removes some clocks, adds new frequencies, and
adds a new GPLL (Global Phase-Locked Loop) in reference to SDM845, while
also removing some GDSCs. Despite these differences, there are many
similarities with SDM670. Add data for SDM670 in the driver for SDM845 to
reuse the most of the clock data.

Advantages and disadvantages of this approach:
 + maintenance applies to both sdm670 and sdm845 by default
 + less duplicate code (clocks) means smaller distro/pre-built kernels
   with all drivers enabled
 - clocks for both SoC's must be compiled if the user wants clocks for one
   specific SoC (both or none)
 - additional testing needed for sdm845 devices

Link: https://android.googlesource.com/kernel/msm/+/443bd8d6e2cf54698234c752e6de97b4b8a528bd%5E%21/#F10
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/Kconfig      |   4 +-
 drivers/clk/qcom/gcc-sdm845.c | 394 ++++++++++++++++++++++++++++++++++
 2 files changed, 396 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1cf1ef70e347..17951088b1db 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -545,10 +545,10 @@ config QCS_Q6SSTOP_404
 	  controller to reset the Q6SSTOP subsystem.
 
 config SDM_GCC_845
-	tristate "SDM845 Global Clock Controller"
+	tristate "SDM845/SDM670 Global Clock Controller"
 	select QCOM_GDSC
 	help
-	  Support for the global clock controller on SDM845 devices.
+	  Support for the global clock controller on SDM845 and SDM670 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  i2C, USB, UFS, SDDC, PCIe, etc.
 
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index cd6e4e41dc9b..6af08e0ca847 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -31,6 +31,7 @@ enum {
 	P_GPLL0_OUT_EVEN,
 	P_GPLL0_OUT_MAIN,
 	P_GPLL4_OUT_MAIN,
+	P_GPLL6_OUT_MAIN,
 	P_SLEEP_CLK,
 };
 
@@ -68,6 +69,23 @@ static struct clk_alpha_pll gpll4 = {
 	},
 };
 
+static struct clk_alpha_pll gpll6 = {
+	.offset = 0x13000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(6),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll6",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo", .name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
 static const struct clk_div_table post_div_table_fabia_even[] = {
 	{ 0x0, 1 },
 	{ 0x1, 2 },
@@ -194,6 +212,19 @@ static const struct clk_parent_data gcc_parent_data_10[] = {
 	{ .hw = &gpll0_out_even.clkr.hw },
 };
 
+static const struct parent_map gcc_parent_map_11[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 1 },
+	{ P_GPLL6_OUT_MAIN, 2 },
+	{ P_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_11[] = {
+	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll6.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+};
 
 static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
@@ -233,6 +264,26 @@ static struct clk_rcg2 gcc_cpuss_rbcpr_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_gcc_sdm670_cpuss_rbcpr_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdm670_cpuss_rbcpr_clk_src = {
+	.cmd_rcgr = 0x4815c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_sdm670_cpuss_rbcpr_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gcc_cpuss_rbcpr_clk_src",
+		.parent_data = gcc_parent_data_8_ao,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8_ao),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
@@ -656,6 +707,54 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
 	.clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_src_init,
 };
 
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, P_BI_TCXO, 16, 3, 25),
+	F(400000, P_BI_TCXO, 12, 1, 4),
+	F(20000000, P_GPLL0_OUT_EVEN, 5, 1, 3),
+	F(25000000, P_GPLL0_OUT_EVEN, 6, 1, 2),
+	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(192000000, P_GPLL6_OUT_MAIN, 2, 0, 0),
+	F(384000000, P_GPLL6_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
+	.cmd_rcgr = 0x26028,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_11,
+	.freq_tbl = ftbl_gcc_sdcc1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gcc_sdcc1_apps_clk_src",
+		.parent_data = gcc_parent_data_11,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_11),
+		.ops = &clk_rcg2_floor_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk_src[] = {
+	F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
+	.cmd_rcgr = 0x26010,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_sdcc1_ice_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gcc_sdcc1_ice_core_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(400000, P_BI_TCXO, 12, 1, 4),
 	F(9600000, P_BI_TCXO, 2, 0, 0),
@@ -705,6 +804,31 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_gcc_sdm670_sdcc4_apps_clk_src[] = {
+	F(400000, P_BI_TCXO, 12, 1, 4),
+	F(9600000, P_BI_TCXO, 2, 0, 0),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(33333333, P_GPLL0_OUT_EVEN, 9, 0, 0),
+	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdm670_sdcc4_apps_clk_src = {
+	.cmd_rcgr = 0x1600c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_sdm670_sdcc4_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gcc_sdcc4_apps_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.ops = &clk_rcg2_floor_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_tsif_ref_clk_src[] = {
 	F(105495, P_BI_TCXO, 2, 1, 91),
 	{ }
@@ -1283,6 +1407,28 @@ static struct clk_branch gcc_cpuss_rbcpr_clk = {
 	},
 };
 
+/*
+ * The source clock frequencies are different for SDM670; define a child clock
+ * pointing to the source clock that uses SDM670 frequencies.
+ */
+static struct clk_branch gcc_sdm670_cpuss_rbcpr_clk = {
+	.halt_reg = 0x48008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x48008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cpuss_rbcpr_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdm670_cpuss_rbcpr_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ddrss_gpu_axi_clk = {
 	.halt_reg = 0x44038,
 	.halt_check = BRANCH_VOTED,
@@ -2353,6 +2499,55 @@ static struct clk_branch gcc_qupv3_wrap_1_s_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_sdcc1_ahb_clk = {
+	.halt_reg = 0x26008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x26008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc1_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_apps_clk = {
+	.halt_reg = 0x26004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x26004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc1_apps_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdcc1_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_ice_core_clk = {
+	.halt_reg = 0x2600c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2600c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc1_ice_core_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdcc1_ice_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sdcc2_ahb_clk = {
 	.halt_reg = 0x14008,
 	.halt_check = BRANCH_HALT,
@@ -2415,6 +2610,28 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
 	},
 };
 
+/*
+ * The source clock frequencies are different for SDM670; define a child clock
+ * pointing to the source clock that uses SDM670 frequencies.
+ */
+static struct clk_branch gcc_sdm670_sdcc4_apps_clk = {
+	.halt_reg = 0x16004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x16004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc4_apps_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gcc_sdm670_sdcc4_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
 	.halt_reg = 0x414c,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -3308,6 +3525,155 @@ static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
 	.flags = VOTABLE,
 };
 
+static struct clk_regmap *gcc_sdm670_clocks[] = {
+	[GCC_AGGRE_UFS_PHY_AXI_CLK] = &gcc_aggre_ufs_phy_axi_clk.clkr,
+	[GCC_AGGRE_USB3_PRIM_AXI_CLK] = &gcc_aggre_usb3_prim_axi_clk.clkr,
+	[GCC_APC_VS_CLK] = &gcc_apc_vs_clk.clkr,
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_CAMERA_AHB_CLK] = &gcc_camera_ahb_clk.clkr,
+	[GCC_CAMERA_AXI_CLK] = &gcc_camera_axi_clk.clkr,
+	[GCC_CAMERA_XO_CLK] = &gcc_camera_xo_clk.clkr,
+	[GCC_CE1_AHB_CLK] = &gcc_ce1_ahb_clk.clkr,
+	[GCC_CE1_AXI_CLK] = &gcc_ce1_axi_clk.clkr,
+	[GCC_CE1_CLK] = &gcc_ce1_clk.clkr,
+	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
+	[GCC_CPUSS_AHB_CLK] = &gcc_cpuss_ahb_clk.clkr,
+	[GCC_CPUSS_AHB_CLK_SRC] = &gcc_cpuss_ahb_clk_src.clkr,
+	[GCC_CPUSS_RBCPR_CLK] = &gcc_sdm670_cpuss_rbcpr_clk.clkr,
+	[GCC_CPUSS_RBCPR_CLK_SRC] = &gcc_sdm670_cpuss_rbcpr_clk_src.clkr,
+	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
+	[GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
+	[GCC_DISP_AXI_CLK] = &gcc_disp_axi_clk.clkr,
+	[GCC_DISP_GPLL0_CLK_SRC] = &gcc_disp_gpll0_clk_src.clkr,
+	[GCC_DISP_GPLL0_DIV_CLK_SRC] = &gcc_disp_gpll0_div_clk_src.clkr,
+	[GCC_DISP_XO_CLK] = &gcc_disp_xo_clk.clkr,
+	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
+	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
+	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
+	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
+	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
+	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
+	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
+	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
+	[GCC_GPU_IREF_CLK] = &gcc_gpu_iref_clk.clkr,
+	[GCC_GPU_MEMNOC_GFX_CLK] = &gcc_gpu_memnoc_gfx_clk.clkr,
+	[GCC_GPU_SNOC_DVM_GFX_CLK] = &gcc_gpu_snoc_dvm_gfx_clk.clkr,
+	[GCC_GPU_VS_CLK] = &gcc_gpu_vs_clk.clkr,
+	[GCC_MSS_AXIS2_CLK] = &gcc_mss_axis2_clk.clkr,
+	[GCC_MSS_CFG_AHB_CLK] = &gcc_mss_cfg_ahb_clk.clkr,
+	[GCC_MSS_GPLL0_DIV_CLK_SRC] = &gcc_mss_gpll0_div_clk_src.clkr,
+	[GCC_MSS_MFAB_AXIS_CLK] = &gcc_mss_mfab_axis_clk.clkr,
+	[GCC_MSS_Q6_MEMNOC_AXI_CLK] = &gcc_mss_q6_memnoc_axi_clk.clkr,
+	[GCC_MSS_SNOC_AXI_CLK] = &gcc_mss_snoc_axi_clk.clkr,
+	[GCC_MSS_VS_CLK] = &gcc_mss_vs_clk.clkr,
+	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PDM2_CLK_SRC] = &gcc_pdm2_clk_src.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_PDM_XO4_CLK] = &gcc_pdm_xo4_clk.clkr,
+	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
+	[GCC_QMIP_CAMERA_AHB_CLK] = &gcc_qmip_camera_ahb_clk.clkr,
+	[GCC_QMIP_DISP_AHB_CLK] = &gcc_qmip_disp_ahb_clk.clkr,
+	[GCC_QMIP_VIDEO_AHB_CLK] = &gcc_qmip_video_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP0_S0_CLK] = &gcc_qupv3_wrap0_s0_clk.clkr,
+	[GCC_QUPV3_WRAP0_S0_CLK_SRC] = &gcc_qupv3_wrap0_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S1_CLK] = &gcc_qupv3_wrap0_s1_clk.clkr,
+	[GCC_QUPV3_WRAP0_S1_CLK_SRC] = &gcc_qupv3_wrap0_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S2_CLK] = &gcc_qupv3_wrap0_s2_clk.clkr,
+	[GCC_QUPV3_WRAP0_S2_CLK_SRC] = &gcc_qupv3_wrap0_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S3_CLK] = &gcc_qupv3_wrap0_s3_clk.clkr,
+	[GCC_QUPV3_WRAP0_S3_CLK_SRC] = &gcc_qupv3_wrap0_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S4_CLK] = &gcc_qupv3_wrap0_s4_clk.clkr,
+	[GCC_QUPV3_WRAP0_S4_CLK_SRC] = &gcc_qupv3_wrap0_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S5_CLK] = &gcc_qupv3_wrap0_s5_clk.clkr,
+	[GCC_QUPV3_WRAP0_S5_CLK_SRC] = &gcc_qupv3_wrap0_s5_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S6_CLK] = &gcc_qupv3_wrap0_s6_clk.clkr,
+	[GCC_QUPV3_WRAP0_S6_CLK_SRC] = &gcc_qupv3_wrap0_s6_clk_src.clkr,
+	[GCC_QUPV3_WRAP0_S7_CLK] = &gcc_qupv3_wrap0_s7_clk.clkr,
+	[GCC_QUPV3_WRAP0_S7_CLK_SRC] = &gcc_qupv3_wrap0_s7_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S0_CLK] = &gcc_qupv3_wrap1_s0_clk.clkr,
+	[GCC_QUPV3_WRAP1_S0_CLK_SRC] = &gcc_qupv3_wrap1_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S1_CLK] = &gcc_qupv3_wrap1_s1_clk.clkr,
+	[GCC_QUPV3_WRAP1_S1_CLK_SRC] = &gcc_qupv3_wrap1_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S2_CLK] = &gcc_qupv3_wrap1_s2_clk.clkr,
+	[GCC_QUPV3_WRAP1_S2_CLK_SRC] = &gcc_qupv3_wrap1_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S3_CLK] = &gcc_qupv3_wrap1_s3_clk.clkr,
+	[GCC_QUPV3_WRAP1_S3_CLK_SRC] = &gcc_qupv3_wrap1_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S4_CLK] = &gcc_qupv3_wrap1_s4_clk.clkr,
+	[GCC_QUPV3_WRAP1_S4_CLK_SRC] = &gcc_qupv3_wrap1_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S5_CLK] = &gcc_qupv3_wrap1_s5_clk.clkr,
+	[GCC_QUPV3_WRAP1_S5_CLK_SRC] = &gcc_qupv3_wrap1_s5_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S6_CLK] = &gcc_qupv3_wrap1_s6_clk.clkr,
+	[GCC_QUPV3_WRAP1_S6_CLK_SRC] = &gcc_qupv3_wrap1_s6_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S7_CLK] = &gcc_qupv3_wrap1_s7_clk.clkr,
+	[GCC_QUPV3_WRAP1_S7_CLK_SRC] = &gcc_qupv3_wrap1_s7_clk_src.clkr,
+	[GCC_QUPV3_WRAP_0_M_AHB_CLK] = &gcc_qupv3_wrap_0_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_0_S_AHB_CLK] = &gcc_qupv3_wrap_0_s_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_1_M_AHB_CLK] = &gcc_qupv3_wrap_1_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_1_S_AHB_CLK] = &gcc_qupv3_wrap_1_s_ahb_clk.clkr,
+	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
+	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
+	[GCC_SDCC1_APPS_CLK_SRC] = &gcc_sdcc1_apps_clk_src.clkr,
+	[GCC_SDCC1_ICE_CORE_CLK_SRC] = &gcc_sdcc1_ice_core_clk_src.clkr,
+	[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
+	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
+	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
+	[GCC_SDCC2_APPS_CLK_SRC] = &gcc_sdcc2_apps_clk_src.clkr,
+	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
+	[GCC_SDCC4_APPS_CLK] = &gcc_sdm670_sdcc4_apps_clk.clkr,
+	[GCC_SDCC4_APPS_CLK_SRC] = &gcc_sdm670_sdcc4_apps_clk_src.clkr,
+	[GCC_SYS_NOC_CPUSS_AHB_CLK] = &gcc_sys_noc_cpuss_ahb_clk.clkr,
+	[GCC_TSIF_AHB_CLK] = &gcc_tsif_ahb_clk.clkr,
+	[GCC_TSIF_INACTIVITY_TIMERS_CLK] =
+					&gcc_tsif_inactivity_timers_clk.clkr,
+	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,
+	[GCC_TSIF_REF_CLK_SRC] = &gcc_tsif_ref_clk_src.clkr,
+	[GCC_UFS_MEM_CLKREF_CLK] = &gcc_ufs_mem_clkref_clk.clkr,
+	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
+	[GCC_UFS_PHY_AXI_CLK] = &gcc_ufs_phy_axi_clk.clkr,
+	[GCC_UFS_PHY_AXI_CLK_SRC] = &gcc_ufs_phy_axi_clk_src.clkr,
+	[GCC_UFS_PHY_ICE_CORE_CLK] = &gcc_ufs_phy_ice_core_clk.clkr,
+	[GCC_UFS_PHY_ICE_CORE_CLK_SRC] = &gcc_ufs_phy_ice_core_clk_src.clkr,
+	[GCC_UFS_PHY_PHY_AUX_CLK] = &gcc_ufs_phy_phy_aux_clk.clkr,
+	[GCC_UFS_PHY_PHY_AUX_CLK_SRC] = &gcc_ufs_phy_phy_aux_clk_src.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_0_CLK] = &gcc_ufs_phy_rx_symbol_0_clk.clkr,
+	[GCC_UFS_PHY_TX_SYMBOL_0_CLK] = &gcc_ufs_phy_tx_symbol_0_clk.clkr,
+	[GCC_UFS_PHY_UNIPRO_CORE_CLK] = &gcc_ufs_phy_unipro_core_clk.clkr,
+	[GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC] =
+					&gcc_ufs_phy_unipro_core_clk_src.clkr,
+	[GCC_USB30_PRIM_MASTER_CLK] = &gcc_usb30_prim_master_clk.clkr,
+	[GCC_USB30_PRIM_MASTER_CLK_SRC] = &gcc_usb30_prim_master_clk_src.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_CLK] = &gcc_usb30_prim_mock_utmi_clk.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC] =
+					&gcc_usb30_prim_mock_utmi_clk_src.clkr,
+	[GCC_USB30_PRIM_SLEEP_CLK] = &gcc_usb30_prim_sleep_clk.clkr,
+	[GCC_USB3_PRIM_CLKREF_CLK] = &gcc_usb3_prim_clkref_clk.clkr,
+	[GCC_USB3_PRIM_PHY_AUX_CLK] = &gcc_usb3_prim_phy_aux_clk.clkr,
+	[GCC_USB3_PRIM_PHY_AUX_CLK_SRC] = &gcc_usb3_prim_phy_aux_clk_src.clkr,
+	[GCC_USB3_PRIM_PHY_COM_AUX_CLK] = &gcc_usb3_prim_phy_com_aux_clk.clkr,
+	[GCC_USB3_PRIM_PHY_PIPE_CLK] = &gcc_usb3_prim_phy_pipe_clk.clkr,
+	[GCC_USB_PHY_CFG_AHB2PHY_CLK] = &gcc_usb_phy_cfg_ahb2phy_clk.clkr,
+	[GCC_VDDA_VS_CLK] = &gcc_vdda_vs_clk.clkr,
+	[GCC_VDDCX_VS_CLK] = &gcc_vddcx_vs_clk.clkr,
+	[GCC_VDDMX_VS_CLK] = &gcc_vddmx_vs_clk.clkr,
+	[GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
+	[GCC_VIDEO_AXI_CLK] = &gcc_video_axi_clk.clkr,
+	[GCC_VIDEO_XO_CLK] = &gcc_video_xo_clk.clkr,
+	[GCC_VS_CTRL_AHB_CLK] = &gcc_vs_ctrl_ahb_clk.clkr,
+	[GCC_VS_CTRL_CLK] = &gcc_vs_ctrl_clk.clkr,
+	[GCC_VS_CTRL_CLK_SRC] = &gcc_vs_ctrl_clk_src.clkr,
+	[GCC_VSENSOR_CLK_SRC] = &gcc_vsensor_clk_src.clkr,
+	[GPLL0] = &gpll0.clkr,
+	[GPLL0_OUT_EVEN] = &gpll0_out_even.clkr,
+	[GPLL4] = &gpll4.clkr,
+	[GPLL6] = &gpll6.clkr,
+	[GCC_CPUSS_DVM_BUS_CLK] = &gcc_cpuss_dvm_bus_clk.clkr,
+	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
+	[GCC_QSPI_CORE_CLK_SRC] = &gcc_qspi_core_clk_src.clkr,
+	[GCC_QSPI_CORE_CLK] = &gcc_qspi_core_clk.clkr,
+	[GCC_QSPI_CNOC_PERIPH_AHB_CLK] = &gcc_qspi_cnoc_periph_ahb_clk.clkr,
+};
+
 static struct clk_regmap *gcc_sdm845_clocks[] = {
 	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
 	[GCC_AGGRE_UFS_CARD_AXI_CLK] = &gcc_aggre_ufs_card_axi_clk.clkr,
@@ -3533,6 +3899,22 @@ static const struct qcom_reset_map gcc_sdm845_resets[] = {
 	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
 };
 
+static struct gdsc *gcc_sdm670_gdscs[] = {
+	[UFS_PHY_GDSC] = &ufs_phy_gdsc,
+	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] =
+			&hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc,
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] =
+			&hlos1_vote_aggre_noc_mmu_tbu1_gdsc,
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] =
+			&hlos1_vote_aggre_noc_mmu_tbu2_gdsc,
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] =
+			&hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc,
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] =
+			&hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc,
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = &hlos1_vote_mmnoc_mmu_tbu_sf_gdsc,
+};
+
 static struct gdsc *gcc_sdm845_gdscs[] = {
 	[PCIE_0_GDSC] = &pcie_0_gdsc,
 	[PCIE_1_GDSC] = &pcie_1_gdsc,
@@ -3563,6 +3945,17 @@ static const struct regmap_config gcc_sdm845_regmap_config = {
 	.fast_io	= true,
 };
 
+static const struct qcom_cc_desc gcc_sdm670_desc = {
+	.config = &gcc_sdm845_regmap_config,
+	.clks = gcc_sdm670_clocks,
+	.num_clks = ARRAY_SIZE(gcc_sdm670_clocks),
+	/* Snapdragon 670 can function without its own exclusive resets. */
+	.resets = gcc_sdm845_resets,
+	.num_resets = ARRAY_SIZE(gcc_sdm845_resets),
+	.gdscs = gcc_sdm670_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_sdm670_gdscs),
+};
+
 static const struct qcom_cc_desc gcc_sdm845_desc = {
 	.config = &gcc_sdm845_regmap_config,
 	.clks = gcc_sdm845_clocks,
@@ -3574,6 +3967,7 @@ static const struct qcom_cc_desc gcc_sdm845_desc = {
 };
 
 static const struct of_device_id gcc_sdm845_match_table[] = {
+	{ .compatible = "qcom,gcc-sdm670", .data = &gcc_sdm670_desc },
 	{ .compatible = "qcom,gcc-sdm845", .data = &gcc_sdm845_desc },
 	{ }
 };
-- 
2.37.3

