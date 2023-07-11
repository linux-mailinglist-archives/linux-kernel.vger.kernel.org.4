Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783A674F285
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGKOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGKOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:42:47 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7EAE60
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:45 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51dd16f823bso3920404a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086563; x=1691678563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i17FLoNCi12ib3F8C35t83wNdppeBZG3dj7HY/hu0Qg=;
        b=JVxA60rxbQakJABYgGrtZoU/wRUB7v5l4kceDuaI7uXWajFkbhwwj93aPZdEJ1/hT5
         MtH233z9IrqWyrX1H7MbpiDkLuLhWNBS1E3tERMBFGpRoahhe7Aa5q12gcs0ms/s3rCE
         Ep0Ri9uZeBFsw2dC++Wco60/2TnxU5djoKJy9VosD6b4EYFGaGJndhEVF1USkrrH9vwt
         /d0H9S/0equRVn66mlwE7bFdmzyK2jbM80X2+I0sdFWcUmNRVgTmL887gfDSLApbj0Do
         WBeorBaG6JIjhl3t4mnJ/Te8IilTOA3CXIhOICvmw+v6SzqsMaKAQltxqK7saUWNzQ1D
         ZvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086563; x=1691678563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i17FLoNCi12ib3F8C35t83wNdppeBZG3dj7HY/hu0Qg=;
        b=NLEqpOkChzJ+Trf1JbqO9lsNvS6b8EB0QNYbraKEkxRxg4XqceghBAuqjkfsUHePCS
         Zae2g107HiMeMPve/W1ajKVt03bQs4rQ9V64Q1cVc3WqnbPBvyIkwk/ImmO0DMVnhpo0
         w9ZswROiEGgzVOntCkaQjaMLxdiQ9MFVLIqq92L3lUJgWb1XPfDReFohrbHd9MK1D5lg
         INFU30uE2ii91VHoaf8Am+bpUbnzO1Rr8mcLLQUtmUSVaRQp5U2BLUMMxLRyqM2GCXzc
         f752K7jNIffDgusZ2jGVBPSt5K1VZmIoGCCyGvWjSW0nYeopfQcmd+qBykw/c7XEsp4F
         ONcA==
X-Gm-Message-State: ABy/qLbO3TsVqr9exWdvGcdjZCgsESQpXyqCvrfWYa8fDm140d73dKtA
        sJv/N2Kp8bJVmZRFgYiFRk1jAbNwlqI=
X-Google-Smtp-Source: APBJJlH9M+PjPEY2zg5brX8xWgckR1Xl6SupLw0UVEZg3dJxdi/uYjWCNvcxW5CYg6D+PGhizpkvx5q3Gfw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a50:d681:0:b0:51a:60b6:f4e6 with SMTP id
 r1-20020a50d681000000b0051a60b6f4e6mr92152edi.5.1689086563460; Tue, 11 Jul
 2023 07:42:43 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:42:30 +0200
In-Reply-To: <20230711144233.3129207-1-glider@google.com>
Mime-Version: 1.0
References: <20230711144233.3129207-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711144233.3129207-3-glider@google.com>
Subject: [Resend v1 2/5] linux/bitqueue.h: add a KUnit test for bitqueue.h
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

