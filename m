Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64AE5EF9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiI2QHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiI2QHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:07:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF613E21;
        Thu, 29 Sep 2022 09:06:59 -0700 (PDT)
X-QQ-Spam: true
X-QQ-mid: bizesmtp84t1664461977tq1saah5
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:32:56 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/30] reset: starfive: jh7100: Use 32bit I/O on 32bit registers
Date:   Thu, 29 Sep 2022 22:32:02 +0800
Message-Id: <20220929143225.17907-8-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

We currently use 64bit I/O on the 32bit registers. This works because
there are an even number of assert and status registers, so they're only
ever accessed in pairs on 64bit boundaries.

There are however other reset controllers for audio and video on the
JH7100 SoC with only one status register that isn't 64bit aligned so
64bit I/O results in an unaligned access exception.

Switch to 32bit I/O in preparation for supporting these resets too.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 drivers/reset/reset-starfive-jh7100.c | 41 +++++++++++++--------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/reset-starfive-jh7100.c
index fc44b2fb3e03..a6e0945071e9 100644
--- a/drivers/reset/reset-starfive-jh7100.c
+++ b/drivers/reset/reset-starfive-jh7100.c
@@ -7,7 +7,6 @@
 
 #include <linux/bitmap.h>
 #include <linux/io.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -34,16 +33,16 @@
  * lines don't though, so store the expected value of the status registers when
  * all lines are asserted.
  */
-static const u64 jh7100_reset_asserted[2] = {
+static const u32 jh7100_reset_asserted[4] = {
 	/* STATUS0 */
-	BIT_ULL_MASK(JH7100_RST_U74) |
-	BIT_ULL_MASK(JH7100_RST_VP6_DRESET) |
-	BIT_ULL_MASK(JH7100_RST_VP6_BRESET) |
+	BIT(JH7100_RST_U74 % 32) |
+	BIT(JH7100_RST_VP6_DRESET % 32) |
+	BIT(JH7100_RST_VP6_BRESET % 32),
 	/* STATUS1 */
-	BIT_ULL_MASK(JH7100_RST_HIFI4_DRESET) |
-	BIT_ULL_MASK(JH7100_RST_HIFI4_BRESET),
+	BIT(JH7100_RST_HIFI4_DRESET % 32) |
+	BIT(JH7100_RST_HIFI4_BRESET % 32),
 	/* STATUS2 */
-	BIT_ULL_MASK(JH7100_RST_E24) |
+	BIT(JH7100_RST_E24 % 32),
 	/* STATUS3 */
 	0,
 };
@@ -65,12 +64,12 @@ static int jh7100_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
 	struct jh7100_reset *data = jh7100_reset_from(rcdev);
-	unsigned long offset = BIT_ULL_WORD(id);
-	u64 mask = BIT_ULL_MASK(id);
-	void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u64);
-	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
-	u64 done = jh7100_reset_asserted[offset] & mask;
-	u64 value;
+	unsigned long offset = id / 32;
+	u32 mask = BIT(id % 32);
+	void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u32);
+	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u32);
+	u32 done = jh7100_reset_asserted[offset] & mask;
+	u32 value;
 	unsigned long flags;
 	int ret;
 
@@ -79,15 +78,15 @@ static int jh7100_reset_update(struct reset_controller_dev *rcdev,
 
 	spin_lock_irqsave(&data->lock, flags);
 
-	value = readq(reg_assert);
+	value = readl(reg_assert);
 	if (assert)
 		value |= mask;
 	else
 		value &= ~mask;
-	writeq(value, reg_assert);
+	writel(value, reg_assert);
 
 	/* if the associated clock is gated, deasserting might otherwise hang forever */
-	ret = readq_poll_timeout_atomic(reg_status, value, (value & mask) == done, 0, 1000);
+	ret = readl_poll_timeout_atomic(reg_status, value, (value & mask) == done, 0, 1000);
 
 	spin_unlock_irqrestore(&data->lock, flags);
 	return ret;
@@ -121,10 +120,10 @@ static int jh7100_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct jh7100_reset *data = jh7100_reset_from(rcdev);
-	unsigned long offset = BIT_ULL_WORD(id);
-	u64 mask = BIT_ULL_MASK(id);
-	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
-	u64 value = readq(reg_status);
+	unsigned long offset = id / 32;
+	u32 mask = BIT(id % 32);
+	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u32);
+	u32 value = readl(reg_status);
 
 	return !((value ^ jh7100_reset_asserted[offset]) & mask);
 }
-- 
2.17.1

