Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0090F74F24E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjGKOdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjGKOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:33:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D712F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:33:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5707177ff8aso62954757b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086029; x=1691678029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i17FLoNCi12ib3F8C35t83wNdppeBZG3dj7HY/hu0Qg=;
        b=POMOteOGWVpEMzAdxRIRnpR2K5d5Xn0jeyr4+I4tSok+qBnJD2BhtswqJcYb6EvIjq
         40GDUnn2Q6K48/qpgxEh7qG8vJu4ed/WaVnvSqAgsOuIYHomu6lGzPpBwU3IYh/Hg8Ka
         H8ShOvmMYm+s0+19EmI89LN4icZW0QCk8qfQOIickWv3VOOX3XIQuQe33RwCss7CbaYh
         FfQyZExLgrVBAB+Zr6ljXSoERfdMiJqouw4MnCJDOId0qMgPyxIPEw2l17Nc2Y42HWo2
         srS0dFDMODwvtcb2HbIp8cCvBfQgyofrVxPcTX2tJ3z1SUDQ2WmVEvBoHVOxSElbNjjD
         thCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086029; x=1691678029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i17FLoNCi12ib3F8C35t83wNdppeBZG3dj7HY/hu0Qg=;
        b=GDaPGZD+Zxw49oUWjcPF5hBLmut1tWeBkDrv6n6EUDsEr9JdVV/vucuyZYxlxoo3zg
         aLSXs7w61NT2Wv2ir4pMzYR1G6Kfe51fgR04hWEQuSIY/sizcbW1Vj8+r4bbbw8s83Os
         mR560sSyzAK1pZNmzn42QPuLD4IP1lFZ8jzPKVNJ6+/w8QuFXdUMGvHsibZMsOXcpc63
         1m5fipEMqnvV7O2Fo26/dn51IaTB+8OGG0xgIFXLvaeL3UCWNEEB1ZpYxA1y30LwFQyS
         ZEGYiNYDxiUIPCB9l2tcVJ+ZwiVc3ivpSysyt8cgbwjzjxtTtzyrvtQD6cT5MVCXSOWt
         IXhw==
X-Gm-Message-State: ABy/qLb6yf5TeKX9eXykcbrAw8T+dmfY8vYq7yexYRKh49pE9XlY95P+
        7Sy/oOs7d6TQGvouIDYh/TveYD0AoPc=
X-Google-Smtp-Source: APBJJlGQycuhFuaUSIxQ82QAIoJs6wHgHFp6GCXAoJqCmsJ1+Hc9x7Y5LOtqM6CF56P3mb9FHh3eNETgLIA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a81:404d:0:b0:570:75a8:7867 with SMTP id
 m13-20020a81404d000000b0057075a87867mr127870ywn.4.1689086029340; Tue, 11 Jul
 2023 07:33:49 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:33:28 +0200
In-Reply-To: <20230711143337.3086664-1-glider@google.com>
Mime-Version: 1.0
References: <20230711143337.3086664-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711143337.3086664-2-glider@google.com>
Subject: [PATCH 1/5] linux/bitqueue.h: add a KUnit test for bitqueue.h
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests checking that struct bitq correctly handles sub-byte values.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/Kconfig.debug   |   8 ++
 lib/Makefile        |   1 +
 lib/test_bitqueue.c | 244 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 lib/test_bitqueue.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803e..a6598b2c250d5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2678,6 +2678,14 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config BITQUEUE_KUNIT_TEST
+	tristate "Test <linux/bitqueue.h>" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the kernel's bit queue implementation
+	  (<linux/bitqueue.h>).
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 876fcdeae34ec..7efb6aba31cf9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -394,6 +394,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_BITQUEUE_KUNIT_TEST) += test_bitqueue.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_bitqueue.c b/lib/test_bitqueue.c
new file mode 100644
index 0000000000000..aec04b3a5f068
--- /dev/null
+++ b/lib/test_bitqueue.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for struct bitq, a simple bit queue.
+ */
+
+#include <kunit/test.h>
+#include <linux/bitqueue.h>
+#include <linux/slab.h>
+
+/* Set up a bit queue containing @size bytes. */
+static void bitq_setup(struct bitq *it, size_t size)
+{
+	u8 *data = kmalloc(size, GFP_KERNEL);
+
+	bitq_init(it, data, size);
+}
+
+/* Tear down the bit queue. */
+static void bitq_teardown(struct bitq *it)
+{
+	kfree(it->data);
+	memset(it, 0, sizeof(*it));
+}
+
+/* Test that nothing can be popped from an empty queue. */
+static void test_empty(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+
+	/* Allocate a two-byte queue. */
+	bitq_setup(&it, 2);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), -1);
+	bitq_teardown(&it);
+}
+
+/* Test that simple byte-granular enqueue/dequeue operations work. */
+static void test_basic_enqueue_dequeue(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+
+	/* Allocate a two-byte queue. */
+	bitq_setup(&it, 2);
+	/* Enqueue two 8-bit values. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0xaa, 8), 8);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0xbb, 8), 8);
+	/* Cannot enqueue the third byte. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 1, 8), -1);
+	/* Dequeue two bytes. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0xaa);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0xbb);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), -1);
+	bitq_teardown(&it);
+}
+
+/* Test that values shorter than 8 bits can be enqueued and dequeued. */
+static void test_shorter_than_byte(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+
+	/* Allocate a two-byte queue. */
+	bitq_setup(&it, 2);
+	/* Enqueue two 0b101 values. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b101, 3), 3);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b101, 3), 3);
+	/* The first byte of the queue is now 0b10110100. */
+
+	/* Now dequeue three 2-bit values: 0b10, 0b11, 0b01. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 2), 2);
+	KUNIT_EXPECT_EQ(test, val, 0b10);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 2), 2);
+	KUNIT_EXPECT_EQ(test, val, 0b11);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 2), 2);
+	KUNIT_EXPECT_EQ(test, val, 0b01);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 1), -1);
+	bitq_teardown(&it);
+}
+
+/* Test that bits are carried over correctly if they do not fit. */
+static void test_carryover(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+	int i;
+
+	/* Allocate a three-byte queue. */
+	bitq_setup(&it, 3);
+	/* Enqueue 0b100 seven times. */
+	for (i = 0; i < 7; i++)
+		KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b100, 3), 3);
+	/* Now dequeue three 7-bit values: 0b1001001, 0b0010010, 0b0100100. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 7), 7);
+	KUNIT_EXPECT_EQ(test, val, 0b1001001);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 7), 7);
+	KUNIT_EXPECT_EQ(test, val, 0b0010010);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 7), 7);
+	KUNIT_EXPECT_EQ(test, val, 0b0100100);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 1), -1);
+	bitq_teardown(&it);
+}
+
+/*
+ * Test case extracted from the EA0 tag compression algorithm, where
+ * carried over bits were accidentally written into the previous byte.
+ */
+static void test_carryover_ea0(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+
+	/* Allocate a three-byte queue. */
+	bitq_setup(&it, 3);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b100, 3), 3);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b1010, 4), 4);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b0000, 4), 4);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b1010, 4), 4);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0b1011, 4), 4);
+
+	/* Now dequeue two byte values: 0b10010100, 0b00010101. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0b10010100);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0b00010101);
+	/* And the remaining 0b011. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 3), 3);
+	KUNIT_EXPECT_EQ(test, val, 0b011);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 1), -1);
+	bitq_teardown(&it);
+}
+
+/* Test that upper bits of the pushed value are discarded. */
+static void test_trim_upper_bits(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+
+	/* Allocate a two-byte queue. */
+	bitq_setup(&it, 2);
+	/* Enqueue two values that do not fit into 4 bits. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0xab, 4), 4);
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0xab, 4), 4);
+	/* The first byte of the queue is now 0xbb. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0xbb);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 1), -1);
+	bitq_teardown(&it);
+}
+
+/* Another test for discarding the upper bits. */
+static void test_trim_upper_bits2(struct kunit *test)
+{
+	struct bitq it;
+	u8 val = 0;
+
+	/* Allocate a two-byte queue. */
+	bitq_setup(&it, 2);
+	/* Push seven zero bits. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0, 7), 7);
+	/* Push a single 1 bit, but pass a bigger value to bitq_enqueue(). */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0xff, 1), 1);
+	/* The first byte of the queue is now 0x01. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0x01);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 1), -1);
+	bitq_teardown(&it);
+}
+
+/* Test that a NULL value can be used as output of bitq_dequeue() */
+static void test_dequeue_to_null(struct kunit *test)
+{
+	struct bitq it;
+
+	/* Allocate a two-byte queue. */
+	bitq_setup(&it, 2);
+	/* Enqueue a byte value. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 0xab, 8), 8);
+	/* Dequeue the byte, but discard its value. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, NULL, 8), 8);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, NULL, 1), -1);
+	bitq_teardown(&it);
+}
+
+/* Test that bitq_init_full works. */
+static void test_init_full(struct kunit *test)
+{
+	struct bitq it;
+	u8 data[2] = { 0xaa, 0xbb };
+	u8 val = 0;
+
+	/* Initialize a queue with the contents of @data */
+	bitq_init_full(&it, data, 2);
+	/* Cannot enqueue anything else. */
+	KUNIT_EXPECT_EQ(test, bitq_enqueue(&it, 1, 8), -1);
+	/* Dequeue two bytes. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0xaa);
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, &val, 8), 8);
+	KUNIT_EXPECT_EQ(test, val, 0xbb);
+
+	/* Queue is empty. */
+	KUNIT_EXPECT_EQ(test, bitq_dequeue(&it, NULL, 1), -1);
+}
+
+static struct kunit_case bitq_test_cases[] = {
+	KUNIT_CASE(test_empty),
+	KUNIT_CASE(test_basic_enqueue_dequeue),
+	KUNIT_CASE(test_shorter_than_byte),
+	KUNIT_CASE(test_carryover),
+	KUNIT_CASE(test_carryover_ea0),
+	KUNIT_CASE(test_trim_upper_bits),
+	KUNIT_CASE(test_trim_upper_bits2),
+	KUNIT_CASE(test_dequeue_to_null),
+	KUNIT_CASE(test_init_full),
+	{}
+};
+
+static struct kunit_suite bitq_test_suite = {
+	.name = "bitq",
+	.test_cases = bitq_test_cases,
+};
+kunit_test_suites(&bitq_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
-- 
2.41.0.255.g8b1d071c50-goog

