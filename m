Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B673411F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbjFQNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbjFQNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:11:05 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D4F3;
        Sat, 17 Jun 2023 06:11:04 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QjxH90KwZz9sjK;
        Sat, 17 Jun 2023 15:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687007461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5tjwuOtHg+H68IXOztHB24QdLm2Kp3Ta/skyoV/pfU=;
        b=yEkl9cQjLR/gPQ0xIZ84snzggl/ppBru2aqpg9C5TCZglUjAlt1Nqy5RHDsZ47VR970fOc
        SN+DmrhcsCSA6tOITVxZWkO2uXAlMsFj1DxlR8GrcUjDVhZAvx75PkfoSoCKUwVMNyiNlC
        oEALHCehHAsToDym8//EfNcu+5/zXYJhgwqeHcF9hqANruw1MvnX7OrNn9CP2o6DAAPuYs
        TS661RmS/nTr7RtOoQW/zfAi8TdE2+1bXdHh69+i4mMSZ64ok7EvgP8+iAHNDRLJHxVei9
        H2bwR7whv/ojRXMqylO2+8hN2OGna4XdW6Q4vmR+rXtddd83n+iKt4L7onCtcA==
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
Subject: [PATCH v5 2/2] clk: fractional-divider: tests: Add test suite for edge cases
Date:   Sat, 17 Jun 2023 15:10:41 +0200
Message-ID: <20230617131041.18313-3-frank@oltmanns.dev>
In-Reply-To: <20230617131041.18313-1-frank@oltmanns.dev>
References: <20230617131041.18313-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QjxH90KwZz9sjK
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
# clk_fd_test_approximation_max_denominator_zero_based: EXPECTATION FAILED at drivers/clk/clk-fractional-divider_test.c:104
Expected n == max_n, but
    n == 7 (0x7)
    max_n == 8 (0x8)
[FAILED] clk_fd_test_approximation_max_denominator_zero_based
# clk_fd_test_approximation_max_numerator_zero_based: EXPECTATION FAILED at drivers/clk/clk-fractional-divider_test.c:134
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
 drivers/clk/clk-fractional-divider_test.c | 157 ++++++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/clk-fractional-divider_test.c

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index 2fbeb71316f8..efa12ac2b3f2 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -2,4 +2,5 @@ CONFIG_KUNIT=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
+CONFIG_CLK_FD_KUNIT_TEST=y
 CONFIG_UML_PCI_OVER_VIRTIO=n
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
index 000000000000..7b8105496cbb
--- /dev/null
+++ b/drivers/clk/clk-fractional-divider_test.c
@@ -0,0 +1,157 @@
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
+	unsigned long rate, parent_rate, m, n, max_n;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->mwidth = 3;
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
+	unsigned long rate, parent_rate, m, n, max_m;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->mwidth = 3;
+	max_m = 7;
+	fd->nwidth = 3;
+
+	hw = &fd->hw;
+
+	rate = 240000000;
+	parent_rate = rate / (max_m + 1); /* so that it exceeds the maximum numerator */
+
+	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
+	KUNIT_EXPECT_EQ(test, parent_rate, rate / (max_m + 1)); /* parent remains unchanged */
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
+	unsigned long rate, parent_rate, m, n, max_n;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	fd->mwidth = 3;
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
+	unsigned long rate, parent_rate, m, n, max_m;
+
+	fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fd);
+
+	fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	fd->mwidth = 3;
+	max_m = 8;
+	fd->nwidth = 3;
+
+	hw = &fd->hw;
+
+	rate = 240000000;
+	parent_rate = rate / (max_m + 1); /* so that it exceeds the maximum numerator */
+
+	clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
+	KUNIT_EXPECT_EQ(test, parent_rate, rate / (max_m + 1)); /* parent remains unchanged */
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

