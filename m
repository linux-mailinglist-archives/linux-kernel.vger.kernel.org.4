Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7492734020
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbjFQKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346138AbjFQK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:29:46 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DA1FFE;
        Sat, 17 Jun 2023 03:29:43 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Qjshz24ctz9sb9;
        Sat, 17 Jun 2023 12:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686997779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VgAbYyJh48hxAs8I72LsWS5J2+rDqhQyILPVFj8OEQc=;
        b=bWmrmWi+8prioSC+1LbWqb/zTPzY+DRXxzPU418SST2mY10H2OwdEvxZoBg8ZI4QzLDxyK
        xwnHMtHoz31528+39tafNGCiF0uq89qXfX7KvXR2EjSPYwmmwvi45JJQ5BAXE3GVXc7uxZ
        8mGHcJ77iUjWC+dtcE3g/xJKc9pwbAhdi2eqMm95OuiC0t/JceSvtGTycZJiPEto7nLmlE
        SM5/Wk4ejB3hyzFvqe1xzRcYTPBgMo1o8YFTV1JHZBJ6mKgqPD969+dXyMUdifXf1Qg8sS
        PX0NFw1GQVNm2jLsm+dEoHAjAbiePItJvupsvRveV5ttyO0JmDih8XkMA1VARA==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 2/2] clk: fractional-divider: tests: Add test suite for edge cases
Date:   Sat, 17 Jun 2023 12:29:19 +0200
Message-ID: <20230617102919.27564-3-frank@oltmanns.dev>
In-Reply-To: <20230617102919.27564-1-frank@oltmanns.dev>
References: <20230617102919.27564-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In light of the recent discovery that the fractional divisor
approximation does not utilize the full available range for clocks that
are flagged CLK_FRAC_DIVIDER_ZERO_BASED [1], implement tests for the
edge cases of this clock type.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
Link: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev [1]
---
Please note: I get two checkpatch warnings for this patch:
 - Concerning the help text in Kconfig.
 - Regarding the file being added, asking if MAINTAINERS needs updating.

Both the help text as well as the MAINTAINERS file seem fine to me.

As expected, when the tests are run *without* PATCH 1, the two "zero
based" test cases fail:

================= clk-fd-test (4 subtests) =================
[PASSED] clk_fd_test_approximation_max_denominator
[PASSED] clk_fd_test_approximation_max_numerator
# clk_fd_test_approximation_max_denominator_zero_based: EXPECTATION FAILED at drivers/clk/clk-fractional-divider_test.c:107
Expected n == max_n, but
    n == 7 (0x7)
    max_n == 8 (0x8)
[FAILED] clk_fd_test_approximation_max_denominator_zero_based
# clk_fd_test_approximation_max_numerator_zero_based: EXPECTATION FAILED at drivers/clk/clk-fractional-divider_test.c:138
Expected m == max_m, but
    m == 7 (0x7)
    max_m == 8 (0x8)
[FAILED] clk_fd_test_approximation_max_numerator_zero_based
# clk-fd-test: pass:2 fail:2 skip:0 total:4
# Totals: pass:2 fail:2 skip:0 total:4
=================== [FAILED] clk-fd-test ===================

Best regards,
  Frank

 drivers/clk/.kunitconfig                  |   1 +
 drivers/clk/Kconfig                       |   7 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-fractional-divider_test.c | 161 ++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/clk/clk-fractional-divider_test.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 016814e15536..3fbb40cb5551 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -513,4 +513,11 @@ config CLK_GATE_KUNIT_TEST
 	help
 	  Kunit test for the basic clk gate type.
 
+config CLK_FD_KUNIT_TEST
+	tristate "Basic fractional divider type Kunit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Kunit test for the clk-fractional-divider type.
+
 endif
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0aebef17edc6..9d2337c12dd1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
+obj-$(CONFIG_CLK_FD_KUNIT_TEST) += clk-fractional-divider_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
 ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
diff --git a/drivers/clk/clk-fractional-divider_test.c b/drivers/clk/clk-fractional-divider_test.c
new file mode 100644
index 000000000000..30a776cf33c0
--- /dev/null
+++ b/drivers/clk/clk-fractional-divider_test.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit test for clock fractional divider
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+/* Needed for clk_hw_get_clk() */
+#include "clk.h"
+
+/* Needed for clk_fractional_divider_general_approximation */
+#include "clk-fractional-divider.h"
+
+#include <kunit/test.h>
+
+/*
+ * Test the maximum denominator case for fd clock without flags.
+ *
+ * Expect the highest possible denominator to be used in order to get as close as possible to the
+ * requested rate.
+ */
+static void clk_fd_test_approximation_max_denominator(struct kunit *test)
+{
+	struct clk_fractional_divider *fd;
+	struct clk_hw *hw;
+	unsigned long rate, parent_rate, m, n, max_m, max_n;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->mwidth = 3;
+	max_m = 7;
+	fd->nwidth = 3;
+	max_n = 7;
+
+	hw = &fd->hw;
+
+	rate = 240000000;
+	parent_rate = (max_n + 1) * rate; /* so that it exceeds the maximum divisor */
+
+	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
+	KUNIT_EXPECT_EQ(test, parent_rate, (max_n + 1) * rate); /* parent remains unchanged */
+	KUNIT_EXPECT_EQ(test, m, 1);
+	KUNIT_EXPECT_EQ(test, n, max_n);
+}
+
+/*
+ * Test the maximum numerator case for fd clock without flags.
+ *
+ * Expect the highest possible numerator to be used in order to get as close as possible to the
+ * requested rate.
+ */
+static void clk_fd_test_approximation_max_numerator(struct kunit *test)
+{
+	struct clk_fractional_divider *fd;
+	struct clk_hw *hw;
+	unsigned long rate, parent_rate, m, n, max_m, max_n;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->mwidth = 3;
+	max_m = 7;
+	fd->nwidth = 3;
+	max_n = 7;
+
+	hw = &fd->hw;
+
+	rate = 240000000;
+	parent_rate = rate / (max_m + 1); /* so that it exceeds the maximum numerator */
+
+	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
+	KUNIT_EXPECT_EQ(test, parent_rate, rate / (max_n + 1)); /* parent remains unchanged */
+	KUNIT_EXPECT_EQ(test, m, max_m);
+	KUNIT_EXPECT_EQ(test, n, 1);
+}
+
+/*
+ * Test the maximum denominator case for zero based fd clock.
+ *
+ * Expect the highest possible denominator to be used in order to get as close as possible to the
+ * requested rate.
+ */
+static void clk_fd_test_approximation_max_denominator_zero_based(struct kunit *test)
+{
+	struct clk_fractional_divider *fd;
+	struct clk_hw *hw;
+	unsigned long rate, parent_rate, m, n, max_m, max_n;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	fd->mwidth = 3;
+	max_m = 8;
+	fd->nwidth = 3;
+	max_n = 8;
+
+	hw = &fd->hw;
+
+	rate = 240000000;
+	parent_rate = (max_n + 1) * rate; /* so that it exceeds the maximum divisor */
+
+	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
+	KUNIT_EXPECT_EQ(test, parent_rate, (max_n + 1) * rate); /* parent remains unchanged */
+	KUNIT_EXPECT_EQ(test, m, 1);
+	KUNIT_EXPECT_EQ(test, n, max_n);
+}
+
+/*
+ * Test the maximum numerator case for zero based fd clock.
+ *
+ * Expect the highest possible numerator to be used in order to get as close as possible to the
+ * requested rate.
+ */
+static void clk_fd_test_approximation_max_numerator_zero_based(struct kunit *test)
+{
+	struct clk_fractional_divider *fd;
+	struct clk_hw *hw;
+	unsigned long rate, parent_rate, m, n, max_m, max_n;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	fd->mwidth = 3;
+	max_m = 8;
+	fd->nwidth = 3;
+	max_n = 8;
+
+	hw = &fd->hw;
+
+	rate = 240000000;
+	parent_rate = rate / (max_m + 1); /* so that it exceeds the maximum numerator */
+
+	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
+	KUNIT_EXPECT_EQ(test, parent_rate, rate / (max_n + 1)); /* parent remains unchanged */
+	KUNIT_EXPECT_EQ(test, m, max_m);
+	KUNIT_EXPECT_EQ(test, n, 1);
+}
+
+static struct kunit_case clk_fd_test_cases[] = {
+	KUNIT_CASE(clk_fd_test_approximation_max_denominator),
+	KUNIT_CASE(clk_fd_test_approximation_max_numerator),
+	KUNIT_CASE(clk_fd_test_approximation_max_denominator_zero_based),
+	KUNIT_CASE(clk_fd_test_approximation_max_numerator_zero_based),
+	{}
+};
+
+/*
+ * Test suite for a fractional divider clock.
+ */
+static struct kunit_suite clk_fd_test_suite = {
+	.name = "clk-fd-test",
+	.test_cases = clk_fd_test_cases,
+};
+
+kunit_test_suites(
+	&clk_fd_test_suite
+);
+MODULE_LICENSE("GPL");
-- 
2.41.0

