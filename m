Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFE60B368
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiJXRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiJXREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3180E85;
        Mon, 24 Oct 2022 08:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB0EB811F9;
        Mon, 24 Oct 2022 15:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA60C433D6;
        Mon, 24 Oct 2022 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625912;
        bh=WrF4DOwB/sUQ9IUDjydI8IGEc8BG1x9piHxSda/Gavo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTo07BzcQmfBGryPtNNo8AELZs2nF64vBBbg4+k+ued9v2VgxaUwl8gunVceZt8yH
         KpfoGAPyvSaCGFCIXtk5lVjYD1ABbBKceXiH+KBTLSYyQdhnE6DX5uIarrmSLvee7Q
         mse9gPi9atk23Rss1N36C1i2V/+NIEEVPyUyybK/SaSWPWpgZQoRKbc8fjnD2o+eQD
         agMJg8Wty5mn06qOCI1WfAkpwqFQQRLfa34UsitLPoirholzWlvnVPmTHQ8xwesBtD
         kFKEI/3weNVHEENUGft4JHrEIHtAa1mwTk3OeS8IDgTi6EU3FH7qCiq5hDld6PgC+/
         CA3XHgQLeMbKg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/10] ARM: omap2: simplify clock2xxx header
Date:   Mon, 24 Oct 2022 17:38:08 +0200
Message-Id: <20221024153814.254652-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Only one of the functions in clock2xxx.h is used in a file
other than the one it is declared in, so remove the extra
declarations, and make the symbols static.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |  1 +
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 14 ++++++----
 arch/arm/mach-omap2/clock.c                  |  2 --
 arch/arm/mach-omap2/clock.h                  |  2 --
 arch/arm/mach-omap2/clock2xxx.h              | 29 --------------------
 arch/arm/mach-omap2/io.c                     |  1 -
 6 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 8a9983cb4733..93f6d3cd9525 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/clk.h>
+#include <linux/clk/ti.h>
 #include <linux/io.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index edf046b470ba..be4557d1fdac 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -39,6 +39,8 @@
 #include "sdrc.h"
 #include "sram.h"
 
+static u16 cpu_mask;
+
 const struct prcm_config *curr_prcm_set;
 const struct prcm_config *rate_table;
 
@@ -55,7 +57,7 @@ static unsigned long sys_ck_rate;
  *
  * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
  */
-unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
+static unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
 				     unsigned long parent_rate)
 {
 	return curr_prcm_set->mpu_speed;
@@ -68,7 +70,7 @@ unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
  * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
  * just uses the ARM rates.
  */
-long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
+static long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long *parent_rate)
 {
 	const struct prcm_config *ptr;
@@ -92,8 +94,8 @@ long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 /* Sets basic clocks based on the specified rate */
-int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
-			    unsigned long parent_rate)
+static int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
 {
 	u32 cur_rate, done_rate, bypass = 0;
 	const struct prcm_config *prcm;
@@ -167,7 +169,7 @@ int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
  * global to point to the active rate set when found; otherwise, sets
  * it to NULL.  No return value;
  */
-void omap2xxx_clkt_vps_check_bootloader_rates(void)
+static void omap2xxx_clkt_vps_check_bootloader_rates(void)
 {
 	const struct prcm_config *prcm = NULL;
 	unsigned long rate;
@@ -193,7 +195,7 @@ void omap2xxx_clkt_vps_check_bootloader_rates(void)
  * sys_ck rate, but before the virt_prcm_set clock rate is
  * recalculated.  No return value.
  */
-void omap2xxx_clkt_vps_late_init(void)
+static void omap2xxx_clkt_vps_late_init(void)
 {
 	struct clk *c;
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 3c1d12dc8ff3..83fae51722a9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -36,8 +36,6 @@
 #include "cm-regbits-34xx.h"
 #include "common.h"
 
-u16 cpu_mask;
-
 /* DPLL valid Fint frequency band limits - from 34xx TRM Section 4.7.6.2 */
 #define OMAP3430_DPLL_FINT_BAND1_MIN	750000
 #define OMAP3430_DPLL_FINT_BAND1_MAX	2100000
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index bbe4b32891bb..f365614405e8 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -63,8 +63,6 @@
 
 extern struct ti_clk_ll_ops omap_clk_ll_ops;
 
-extern u16 cpu_mask;
-
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_omap2_dflt;
 
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index a8408f9d0f33..73c011dadfd2 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -12,35 +12,6 @@
 #include <linux/clk-provider.h>
 #include "clock.h"
 
-unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
-				     unsigned long parent_rate);
-int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
-			    unsigned long parent_rate);
-long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate);
-unsigned long omap2xxx_sys_clk_recalc(struct clk_hw *clk,
-				      unsigned long parent_rate);
-unsigned long omap2_osc_clk_recalc(struct clk_hw *clk,
-				   unsigned long parent_rate);
-void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
 unsigned long omap2xxx_clk_get_core_rate(void);
-u32 omap2xxx_get_sysclkdiv(void);
-void omap2xxx_clk_prepare_for_reboot(void);
-void omap2xxx_clkt_vps_check_bootloader_rates(void);
-void omap2xxx_clkt_vps_late_init(void);
-
-#ifdef CONFIG_SOC_OMAP2420
-int omap2420_clk_init(void);
-#else
-#define omap2420_clk_init()	do { } while(0)
-#endif
-
-#ifdef CONFIG_SOC_OMAP2430
-int omap2430_clk_init(void);
-#else
-#define omap2430_clk_init()	do { } while(0)
-#endif
-
-extern struct clk_hw *dclk_hw;
 
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 921c18ccde6d..375fea35b981 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -32,7 +32,6 @@
 #include "clockdomain.h"
 #include "common.h"
 #include "clock.h"
-#include "clock2xxx.h"
 #include "sdrc.h"
 #include "control.h"
 #include "sram.h"
-- 
2.29.2

