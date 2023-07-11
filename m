Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F274F286
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjGKOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGKOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:42:54 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB71705
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:50 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51e28d316d0so3133264a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086569; x=1691678569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gUN4hkfqv1qmZBEmgq0ujJ8OMQMxN9ipJDwtCO0z/w=;
        b=CAwfWmewCn9RQzJFbpwX7fQzBPNijsKbBxf0NpnX//OUHqpcXYTX58dvgmw+cedZtQ
         kYFFkiKFQDvPqurwCulWWdk5H3FN+xg8wfay44pQXF5LaPtdDiIh3T6yIXQxR4h0dtSh
         hzdIUndQiFP8V3aKKcuU/n7uIxNeyyIMLbdHruTyoLW3o81XFHFlnQYjW2QreYRkQ6ag
         EAilAzhTWbrzbEft+6iZHU4TLY/OKccx5LWQtWV1Gkmzk63yDCQxYtBNu2iswSfHGXow
         CWo8K360qoL45xBx8tvfISZhoes0u9OrLaAzVmZcdT8cEwnpa9m/W7bPLxf+M1kZi+Rl
         nSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086569; x=1691678569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gUN4hkfqv1qmZBEmgq0ujJ8OMQMxN9ipJDwtCO0z/w=;
        b=RJfNJZMMaA3E6ogzgu57P9kmIl4c5RmyMGfpmdecPrTZnqaBzNXGcRX/YeROYQi+cV
         uLidMMod44S7roH49UB+0Vfrz7sMOYcU/51wf3ikbmgK1q1tlJ4nrwA1Vx6KsnZZn3/a
         Ra0q1kZZJcQdiab8hCoh+U40hdQcrWa47QnT7WgUjyE/woA4nblzwPRVNrwNZLXB7xWu
         wZacsnXFzIRjsEODNTMR1HNyrqyuvQguCiZdGVgwMmZYMU+67gS9xzOzB+808HKOHv9s
         0f9Rvij/dOxPtsZ2i2YPwniZwO6ekP9DocEh800CcxsDKLn9Nddmu8bhfYyXmuM8Mr+i
         hPmQ==
X-Gm-Message-State: ABy/qLYJ9LLYZ6ZsKvVyLkGGTaCM/TWRNH4pd1wokDgwpS9H/mKxpm7u
        QooHOmmV7xJFGpoO3sVlf7qbC22OqM8=
X-Google-Smtp-Source: APBJJlFJ++vJxm+UgzMRNU0YCHZdMkerA2PInbG8ZSHPdSyYj9007l5/5vC3PGGHCEqDwMKzW9y2JYZ9V/I=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a50:8ac3:0:b0:51a:38e8:5f8b with SMTP id
 k3-20020a508ac3000000b0051a38e85f8bmr88669edk.4.1689086569124; Tue, 11 Jul
 2023 07:42:49 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:42:32 +0200
In-Reply-To: <20230711144233.3129207-1-glider@google.com>
Mime-Version: 1.0
References: <20230711144233.3129207-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711144233.3129207-5-glider@google.com>
Subject: [Resend v1 4/5] arm64: mte: add a test for MTE tags compression
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

Ensure that tag sequences containing alternating values are compressed
to buffers of expected size and correctly decompressed afterwards.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/Kconfig           |  10 ++
 arch/arm64/mm/Makefile       |   1 +
 arch/arm64/mm/test_mtecomp.c | 175 +++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/mm/test_mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b25b584a0a9cb..31fc50208b383 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2075,6 +2075,16 @@ config ARM64_MTE_COMP
 	  128-byte tag buffers corresponding to 4K pages can be compressed using
 	  the EA0 algorithm to save heap memory.
 
+config ARM64_MTE_COMP_KUNIT_TEST
+	tristate "Test tag compression for ARM64 MTE" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	depends on KUNIT && ARM64_MTE_COMP
+	help
+	  Test EA0 compression algorithm enabled by CONFIG_ARM64_MTE_COMP.
+
+	  Ensure that tag sequences containing alternating values are compressed
+	  to buffers of expected size and correctly decompressed afterwards.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 46778f6dd83c2..170dc62b010b9 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 obj-$(CONFIG_ARM64_MTE_COMP)	+= mtecomp.o
+obj-$(CONFIG_ARM64_MTE_COMP_KUNIT_TEST) += test_mtecomp.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/test_mtecomp.c b/arch/arm64/mm/test_mtecomp.c
new file mode 100644
index 0000000000000..67bef6f28dac4
--- /dev/null
+++ b/arch/arm64/mm/test_mtecomp.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for EA0, the compression algorithm for MTE tags.
+ */
+
+#include <asm/mtecomp.h>
+#include <kunit/test.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/*
+ * Test that ea0_tags_to_ranges() produces a single range for a zero-filled tag
+ * buffer.
+ */
+static void test_tags_to_ranges_zero(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	short r_sizes[256];
+	int r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0, 128);
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 1);
+	KUNIT_EXPECT_EQ(test, r_tags[0], 0);
+	KUNIT_EXPECT_EQ(test, r_sizes[0], 256);
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that a small number of different tags is correctly transformed into
+ * ranges.
+ */
+static void test_tags_to_ranges_simple(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	const u8 ex_tags[] = { 0xa, 0x0, 0xa, 0xb, 0x0 };
+	const short ex_sizes[] = { 1, 2, 2, 1, 250 };
+	short r_sizes[256];
+	int r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0, 128);
+	tags[0] = 0xa0;
+	tags[1] = 0x0a;
+	tags[2] = 0xab;
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 5);
+	KUNIT_EXPECT_EQ(test, memcmp(r_tags, ex_tags, sizeof(ex_tags)), 0);
+	KUNIT_EXPECT_EQ(test, memcmp(r_sizes, ex_sizes, sizeof(ex_sizes)), 0);
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/* Test that repeated 0xa0 byte produces 256 ranges of length 1. */
+static void test_tags_to_ranges_repeated(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	short r_sizes[256];
+	int r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0xa0, 128);
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 256);
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/* Test that a zero-filled array is compressed into inline storage. */
+static void test_compress_zero(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	u64 handle;
+
+	memset(tags, 0, 128);
+	handle = ea0_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, ea0_storage_size(handle), 8);
+	KUNIT_EXPECT_TRUE(test, ea0_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that a very small number of tag ranges ends up compressed into 8 bytes.
+ */
+static void test_compress_simple(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	u64 handle;
+
+	memset(tags, 0, 128);
+	tags[0] = 0xa0;
+	tags[1] = 0x0a;
+	tags[2] = 0xab;
+
+	handle = ea0_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, ea0_storage_size(handle), 8);
+	KUNIT_EXPECT_TRUE(test, ea0_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Generate a buffer that will contain @nranges of tag ranges, test that it
+ * compresses into @exp_size bytes and decompresses into the original tag
+ * sequence.
+ */
+static void compress_range_helper(struct kunit *test, int nranges, int exp_size)
+{
+	u8 tags[128], dtags[128];
+	u64 handle;
+	int i;
+
+	memset(tags, 0, 128);
+
+	if (nranges > 1) {
+		nranges--;
+		for (i = 0; i < nranges / 2; i++)
+			tags[i] = 0xab;
+		if (nranges % 2)
+			tags[nranges / 2] = 0xa0;
+	}
+
+	handle = ea0_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	KUNIT_EXPECT_EQ(test, ea0_storage_size(handle), exp_size);
+	KUNIT_EXPECT_TRUE(test, ea0_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that every number of tag ranges is correctly compressed and
+ * decompressed.
+ */
+static void test_compress_ranges(struct kunit *test)
+{
+	int i, exp_size;
+
+	for (i = 1; i <= 256; i++) {
+		if (i < 7)
+			exp_size = 8;
+		else if (i < 12)
+			exp_size = 16;
+		else if (i < 24)
+			exp_size = 32;
+		else if (i < 47)
+			exp_size = 64;
+		else
+			exp_size = 128;
+		compress_range_helper(test, i, exp_size);
+	}
+}
+
+static struct kunit_case mtecomp_test_cases[] = {
+	KUNIT_CASE(test_tags_to_ranges_zero),
+	KUNIT_CASE(test_tags_to_ranges_simple),
+	KUNIT_CASE(test_tags_to_ranges_repeated),
+	KUNIT_CASE(test_compress_zero),
+	KUNIT_CASE(test_compress_simple),
+	KUNIT_CASE(test_compress_ranges),
+	{}
+};
+
+static struct kunit_suite mtecomp_test_suite = {
+	.name = "mtecomp",
+	.test_cases = mtecomp_test_cases,
+};
+kunit_test_suites(&mtecomp_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
-- 
2.41.0.255.g8b1d071c50-goog

