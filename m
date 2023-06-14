Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA47307AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjFNSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjFNSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:55:48 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36C2132;
        Wed, 14 Jun 2023 11:55:45 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QhF4G3Ny9z9snP;
        Wed, 14 Jun 2023 20:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686768942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJiskTs3zCUsFmoIMCNW6HhLfedb3aaZiyeWz0SDuZ8=;
        b=Po20gNlv394onagKErhNGJdD2+ByMWN8z32JppbB8PGF7vePu3AXS0Do3Pd5fQ+Pq4FIGU
        IU9vJr2BPRLyc28llpXofYmf/PKaSoA1ovddCp1r7lpEUw7xFqKlXgjxwrI34tlzpR+XAL
        jrZ13a2ZHjrZM26LNai8SHEI+8s4ph/R/ai7XlQ6ZJny6N0gSo7r+sq6Gb3xpoEk2ub6Sk
        aNZ7zVSazUEPG8xebrnEPwzwvtmIERZrdTntJAf/lVQrP9iEU62JpamVpKw/dioq/Z9225
        5ql21/UgzADyMagM0fC4VdvnfZ07mByA9XkV25EbIFuCu2EWrmkp9w27XWM9vA==
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
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 2/2] clk: fractional-divider: tests: Add test suite for edge cases
Date:   Wed, 14 Jun 2023 20:55:21 +0200
Message-ID: <20230614185521.477924-3-frank@oltmanns.dev>
In-Reply-To: <20230614185521.477924-1-frank@oltmanns.dev>
References: <20230614185521.477924-1-frank@oltmanns.dev>
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
are flagged CLK_FRAC_DIVIDER_ZERO_BASED, implement tests for the edge
cases of this clock type.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---

Please note: I get two checkpatch warnings for this patch:
 - Concerning the help text in Kconfig.
 - Regarding the file being added, asking if MAINTAINERS needs updating.

Both the help text as well as the MAINTAINERS file seem fine to me.

As expected, when the tests are run *without* PATCH 1, the two "zero
based" test cases fail:

================= clk-fd-test (4 subtests) =================
[PASSED] clk_fd_test_round_rate_max_div
[PASSED] clk_fd_test_round_rate_max_mul
# clk_fd_test_round_rate_max_div_zero_based: EXPECTATION FAILED at drivers/clk/clk-fractional-divider_test.c:139
Expected rounded_rate == parent_rate / 8, but
    rounded_rate == 342857142 (0x146f95b6)
    parent_rate / 8 == 300000000 (0x11e1a300)
[FAILED] clk_fd_test_round_rate_max_div_zero_based
# clk_fd_test_round_rate_max_mul_zero_based: EXPECTATION FAILED at drivers/clk/clk-fractional-divider_test.c:172
Expected rounded_rate == rate, but
    rounded_rate == 252000000 (0xf053700)
    rate == 240000000 (0xe4e1c00)
[FAILED] clk_fd_test_round_rate_max_mul_zero_based
# clk-fd-test: pass:2 fail:2 skip:0 total:4
# Totals: pass:2 fail:2 skip:0 total:4
=================== [FAILED] clk-fd-test ===================

Best regards,
  Frank

 drivers/clk/.kunitconfig                  |   1 +
 drivers/clk/Kconfig                       |   7 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-fractional-divider_test.c | 196 ++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 drivers/clk/clk-fractional-divider_test.c

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index 2fbeb71316f8..efa12ac2b3f2 100644
*** a/drivers/clk/.kunitconfig
--- b/drivers/clk/.kunitconfig
***************
*** 2,5 ****
--- 2,6 ----
  CONFIG_COMMON_CLK=y
  CONFIG_CLK_KUNIT_TEST=y
  CONFIG_CLK_GATE_KUNIT_TEST=y
+ CONFIG_CLK_FD_KUNIT_TEST=y
  CONFIG_UML_PCI_OVER_VIRTIO=n
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 016814e15536..3fbb40cb5551 100644
*** a/drivers/clk/Kconfig
--- b/drivers/clk/Kconfig
***************
*** 513,516 ****
--- 513,523 ----
  	help
  	  Kunit test for the basic clk gate type.
  
+ config CLK_FD_KUNIT_TEST
+ 	tristate "Basic fractional divider type Kunit test" if !KUNIT_ALL_TESTS
+ 	depends on KUNIT
+ 	default KUNIT_ALL_TESTS
+ 	help
+ 	  Kunit test for the clk-fractional-divider type.
+ 
  endif
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0aebef17edc6..9d2337c12dd1 100644
*** a/drivers/clk/Makefile
--- b/drivers/clk/Makefile
@@ -12,6 +12,7 @@
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
+obj-$(CONFIG_CLK_FD_KUNIT_TEST) += clk-fractional-divider_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
 ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
diff --git a/drivers/clk/clk-fractional-divider_test.c b/drivers/clk/clk-fractional-divider_test.c
new file mode 100644
index 000000000000..0ea6b1ae85a8
--- /dev/null
+++ b/drivers/clk/clk-fractional-divider_test.c
@@ -0,0 +1,196 @@
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
+/* Needed for clk_fractional_divider_ops */
+#include "clk-fractional-divider.h"
+
+#include <kunit/test.h>
+
+u32 fdregsim;
+
+static int clk_fd_test_init(struct kunit *test)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fractional_divider(NULL, "test_fd", NULL,
+						0,     /* flags */
+						&fdregsim,
+						0, 2,  /* mshift, mwidth */
+						8, 3,  /* nshift, nwidth */
+						0,     /* clk_divider_flags */
+						NULL); /* spinlock */
+	if (!hw)
+		return -ENOMEM;
+	else if (IS_ERR_VALUE(hw))
+		return PTR_ERR(hw);
+
+	test->priv = hw;
+	return 0;
+}
+
+static void clk_fd_test_exit(struct kunit *test)
+{
+	struct clk_hw *hw = test->priv;
+
+	clk_hw_unregister(hw);
+}
+
+/*
+ * Test the maximum divisor case for fd clock without flags.
+ *
+ * Prerequisites:
+ * - Requested rate is 240MHz.
+ * - Parent runs at 10 times the rate of the requested rate (2.4GHz).
+ * - m and n are 2 and 3 bits wide respectively.
+ * - The clock has no flags set, hence
+ *    - the maximum value for the numerator is 3
+ *    - the maximum value for the denominator is 7
+ *
+ * Expected result:
+ * Expect the highest possible divisor to be used in order to get as close as possible to the
+ * requested rate, resulting in the following rounded rate:
+ *         rounded_rate = parent_rate / 7.
+ */
+static void clk_fd_test_round_rate_max_div(struct kunit *test)
+{
+	struct clk_hw *hw = test->priv;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	unsigned long rate, parent_rate, rounded_rate;
+
+	rate = 240000000;
+	parent_rate = 10 * rate;
+
+	rounded_rate = clk_fractional_divider_ops.round_rate(hw, rate, &parent_rate);
+	/* This test case assumes that the round_rate operation does not change the parent */
+	KUNIT_ASSERT_EQ(test, parent_rate, 10 * rate);
+	/* Make sure the highest possible divisor was used */
+	KUNIT_EXPECT_EQ(test, rounded_rate, parent_rate / 7);
+
+	clk_put(clk);
+}
+
+/*
+ * Test the maximum multiplier case for fd clock without flags.
+ *
+ * Prerequisites:
+ * - Requested rate is 240MHz.
+ * - Parent runs at 7/4th the rate of the requested rate (420MHz).
+ * - m and n are 2 and 3 bits wide respectively.
+ * - The clock has no flags set, hence
+ *    - the maximum value for the numerator is 3
+ *    - the maximum value for the denominator is 7
+ *
+ * Expected result:
+ * Ideally the parent rate must be multiplied by 4 and divided by 7. But the highest possible
+ * multiplier is 3. So, the closest rate is not 4/7th of the parent rate, but 3/5th (252 MHz).
+ */
+static void clk_fd_test_round_rate_max_mul(struct kunit *test)
+{
+	struct clk_hw *hw = test->priv;
+	unsigned long rate, parent_rate, rounded_rate;
+
+	rate = 240000000;
+	parent_rate = 240000000 * 7 / 4;
+
+	rounded_rate = clk_fractional_divider_ops.round_rate(hw, rate, &parent_rate);
+	/* This test case assumes that the round_rate operation does not change the parent */
+	KUNIT_ASSERT_EQ(test, parent_rate, rate * 7 / 4);
+	/* Make sure the highest possible multiplier was used */
+	KUNIT_EXPECT_EQ(test, rounded_rate, parent_rate * 3 / 5);
+}
+
+/*
+ * Test the maximum divisor case for zero based fd clock.
+ *
+ * Prerequisites:
+ * - Requested rate is 240MHz.
+ * - Parent runs at 10 times the rate of the requested rate (2.4 GHz).
+ * - m and n are 2 and 3 bits wide respectively.
+ * - The clock is zero based, hence
+ *    - the maximum value for the numerator is 4
+ *    - the maximum value for the denominator is 8
+ *
+ * Expected result:
+ * Expect the highest possible divisor to be used resulting in the following rounded rate:
+ *         rounded_rate = parent_rate / 8.
+ */
+static void clk_fd_test_round_rate_max_div_zero_based(struct kunit *test)
+{
+	struct clk_hw *hw = test->priv;
+	unsigned long rate, parent_rate, rounded_rate;
+	struct clk_fractional_divider *fd = to_clk_fd(hw);
+
+	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+
+	rate = 240000000;
+	parent_rate = 10 * rate;
+
+	rounded_rate = clk_fractional_divider_ops.round_rate(hw, rate, &parent_rate);
+	/* This test case assumes that the round_rate operation does not change the parent */
+	KUNIT_ASSERT_EQ(test, parent_rate, 10 * rate);
+	/* Make sure the highest possible divisor was used */
+	KUNIT_EXPECT_EQ(test, rounded_rate, parent_rate / 8);
+}
+
+/*
+ * Test the maximum multiplier case for fd clock without flags.
+ *
+ * Prerequisites:
+ * - Requested rate is 240MHz.
+ * - Parent runs at 7/4th the rate of the requested rate (420MHz).
+ * - m and n are 2 and 3 bits wide respectively.
+ * - The clock is zero based, hence
+ *    - the maximum value for the numerator is 4
+ *    - the maximum value for the denominator is 8
+ *
+ * Expected result:
+ * Ideally the parent rate must be multiplied by 4 and divided by seven. And since for a zero based
+ * clock 4 is actually the highest possible multiplier the exact rate can be reached.
+ */
+static void clk_fd_test_round_rate_max_mul_zero_based(struct kunit *test)
+{
+	struct clk_hw *hw = test->priv;
+	unsigned long rate, parent_rate, rounded_rate;
+	struct clk_fractional_divider *fd = to_clk_fd(hw);
+
+	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+
+	rate = 240000000;
+	parent_rate = 240000000 * 7 / 4;
+
+	rounded_rate = clk_fractional_divider_ops.round_rate(hw, rate, &parent_rate);
+	/* This test case assumes that the round_rate operation does not change the parent */
+	KUNIT_ASSERT_EQ(test, parent_rate, rate * 7 / 4);
+	/* Make sure the highest possible multiplier was used */
+	KUNIT_EXPECT_EQ(test, rounded_rate, rate);
+}
+
+static struct kunit_case clk_fd_test_cases[] = {
+	KUNIT_CASE(clk_fd_test_round_rate_max_div),
+	KUNIT_CASE(clk_fd_test_round_rate_max_mul),
+	KUNIT_CASE(clk_fd_test_round_rate_max_div_zero_based),
+	KUNIT_CASE(clk_fd_test_round_rate_max_mul_zero_based),
+	{}
+};
+
+/*
+ * Test suite for a fractional divider clock.
+ */
+static struct kunit_suite clk_fd_test_suite = {
+	.name = "clk-fd-test",
+	.init = clk_fd_test_init,
+	.exit = clk_fd_test_exit,
+	.test_cases = clk_fd_test_cases,
+};
+
+kunit_test_suites(
+	&clk_fd_test_suite
+);
+MODULE_LICENSE("GPL");
-- 
2.41.0

