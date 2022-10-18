Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0956026A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJRIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJRIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:21:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA0A95AEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:21:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 78so12666794pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUtA6btORbAdE+YaY98PEwi36A6sFJfxGGBzovfz7Rs=;
        b=deRHvwdEcNRbxn+cuNFFqyLPnJvCPcoODGG7Q9YmvPkHFiW7E5cdJWURP54aSOwrPZ
         FijiU5J5jx9qvKv/SrLZtjgScZ4KD+lQphuFcScTBqhT7Gazr+/M4WiQp/wc/Mn7nzWX
         D2bK6v1fgRYHUjtlqDPMx7nUYtAztOnfaCJjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUtA6btORbAdE+YaY98PEwi36A6sFJfxGGBzovfz7Rs=;
        b=4TXEL+I+I3SkRzHKYlNe/NrHzuenVHe+3gtr38ri4gTwZBuWMR5nIU3vDDJPhoyCWt
         q9Is/JLcsdsa7O/T1HN/ypjIzd0eV72des8YemFA3ECOrMzR5yDfxP5waF8BHLsDWmh9
         /NPw7uJ3XOrZIbBJJRnmTSSIy4xDYFPDcSsNwZKmwxF1wqqmETKjn7y+t7WZKtTfzu6v
         FWfHE/Jhh/YxPKoGMi9H/8UxIZNdm125huiYe+6E+eWzED9ifjk/e9lMWKbqlhhTuoLq
         m/oOaoYPXffhu8EpXpo6UcFho1+kMMjB6eWOlple/RbiYjos7FdiE3hLPrRpVuauWclu
         76ew==
X-Gm-Message-State: ACrzQf0wBCZzKDFS+E3KBwZTiSuGmCMmXhdTQeEUju4g1JodFfJrHyuL
        uhM4pAhdQ2hdRiE+5jk2xmmusw==
X-Google-Smtp-Source: AMsMyM7Ma9BpP/KNLzk7JyJyzbUW8fB6TrhNZQJP2UX3rBpbhPXaDgNoGuVrB4SvjtaSVP+st6h79g==
X-Received: by 2002:a05:6a00:b83:b0:565:caea:38be with SMTP id g3-20020a056a000b8300b00565caea38bemr1792804pfj.72.1666081263722;
        Tue, 18 Oct 2022 01:21:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78f25000000b0053ae018a91esm8881417pfr.173.2022.10.18.01.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:21:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] kunit/memcpy: Adding dynamic size and window tests
Date:   Tue, 18 Oct 2022 01:20:59 -0700
Message-Id: <20221018082038.gonna.300-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8313; h=from:subject:message-id; bh=p9iuNbTUlskl3mdx46dt5TCsPKjpBEKbouSQmgcBARA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmHrMH+hy5p7zZ1lmYlr4FpESDLjPHUlpOyi5oIa Kh204WOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05h6wAKCRCJcvTf3G3AJjHNEA CbCNYvftxDmaNVZJdxwNx116BSjgLcODb/dGEL/d9UxlqM1CfnYlgPZ5EY1WppqYky17gj3XeMN/FP sC8kWhgQw8//mM903CYPcgd+YxVYlxN5uJOj1U3jvaG+LPdITD8pKASMIbPBPv3Ey/NrJjtGH63TTp eSV0klfV7c71YIYQCQDlhpVHrVuDQ5Y7VD1oeZG3D/rwzXMSIh95TSGGv9iDNbvvKIZYU/z3wyYOv+ dTYq0IlsTEPpoA+hMeGfYF5bzAQahg+IO+nzIbsG9kDKofOPHLQyPdb47hP8JOaT5kkeSBsWN0uIJk ZCWmgBNZiPqtlwXyHK7PsTWHW/fyO93TV0k/4otj33axh6J3viH/b/h+fdVLePyLfsHMaHiGrSRDzB G78ck4MjdIzFreI3kvxHhuPSBXBhudUlo6RArHH3glazyPSYntSN3isknDrMSIsv+oodkexgre3aOt zSi/7jhKhmplAO2rmyRlk3KTeEDgX4GSbLONcJ1hxJnMUgWlNwpnqKyVTlqpzogAwgDpTjGfYNajf0 Wor98LLP+aZyqBZsuHhJkxTnUPEZgwIdPl0gjcgchFoXbCqqKCa6YbhXVuEuk2DCcwzh9zSlncYQGy zFadtaoXeXNIase1JlTGO+fRyR2AK+9PP4RgQccmwE5ztIZS10k27POTWTZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "side effects" memmove() test accidentally found[1] a corner case in
the recent refactoring of the i386 assembly memmove(), but missed another
corner case. Instead of hoping to get lucky next time, implement much
more complete tests of memcpy() and memmove() -- especially the moving
window overlap for memmove() -- which catches all the issues encountered
and should catch anything new.

[1] https://lore.kernel.org/lkml/CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS        |   1 +
 lib/memcpy_kunit.c | 205 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..9dd8d74c4df0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8044,6 +8044,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/fortify-string.h
 F:	lib/fortify_kunit.c
+F:	lib/memcpy_kunit.c
 F:	lib/test_fortify/*
 F:	scripts/test_fortify.sh
 K:	\b__NO_FORTIFY\b
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 2b5cc70ac53f..c4a7107edd43 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -270,6 +270,208 @@ static void memset_test(struct kunit *test)
 #undef TEST_OP
 }
 
+static u8 large_src[1024];
+static u8 large_dst[2048];
+static const u8 large_zero[2048];
+
+static void set_random_nonzero(struct kunit *test, u8 *byte)
+{
+	int failed_rng = 0;
+
+	while (*byte == 0) {
+		get_random_bytes(byte, 1);
+		KUNIT_ASSERT_LT_MSG(test, failed_rng++, 100,
+				    "Is the RNG broken?");
+	}
+}
+
+static void init_large(struct kunit *test)
+{
+
+	/* Get many bit patterns. */
+	get_random_bytes(large_src, ARRAY_SIZE(large_src));
+
+	/* Make sure we have non-zero edges. */
+	set_random_nonzero(test, &large_src[0]);
+	set_random_nonzero(test, &large_src[ARRAY_SIZE(large_src) - 1]);
+
+	/* Explicitly zero the entire destination. */
+	memset(large_dst, 0, ARRAY_SIZE(large_dst));
+}
+
+/*
+ * Instead of an indirect function call for "copy" or a giant macro,
+ * use a bool to pick memcpy or memmove.
+ */
+static void copy_large_test(struct kunit *test, bool use_memmove)
+{
+	init_large(test);
+
+	/* Copy a growing number of non-overlapping bytes ... */
+	for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
+		/* Over a shifting destination window ... */
+		for (int offset = 0; offset < ARRAY_SIZE(large_src); offset++) {
+			int right_zero_pos = offset + bytes;
+			int right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
+
+			/* Copy! */
+			if (use_memmove)
+				memmove(large_dst + offset, large_src, bytes);
+			else
+				memcpy(large_dst + offset, large_src, bytes);
+
+			/* Did we touch anything before the copy area? */
+			KUNIT_ASSERT_EQ_MSG(test,
+				memcmp(large_dst, large_zero, offset), 0,
+				"with size %d at offset %d", bytes, offset);
+			/* Did we touch anything after the copy area? */
+			KUNIT_ASSERT_EQ_MSG(test,
+				memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
+				"with size %d at offset %d", bytes, offset);
+
+			/* Are we byte-for-byte exact across the copy? */
+			KUNIT_ASSERT_EQ_MSG(test,
+				memcmp(large_dst + offset, large_src, bytes), 0,
+				"with size %d at offset %d", bytes, offset);
+
+			/* Zero out what we copied for the next cycle. */
+			memset(large_dst + offset, 0, bytes);
+		}
+		/* Avoid stall warnings if this loop gets slow. */
+		cond_resched();
+	}
+}
+
+static void memcpy_large_test(struct kunit *test)
+{
+	copy_large_test(test, false);
+}
+
+static void memmove_large_test(struct kunit *test)
+{
+	copy_large_test(test, true);
+}
+
+/*
+ * On the assumption that boundary conditions are going to be the most
+ * sensitive, instead of taking a full step (inc) each iteration,
+ * take single index steps for at least the first "inc"-many indexes
+ * from the "start" and at least the last "inc"-many indexes before
+ * the "end". When in the middle, take full "inc"-wide steps. For
+ * example, calling next_step(idx, 1, 15, 3) with idx starting at 0
+ * would see the following pattern: 1 2 3 4 7 10 11 12 13 14 15.
+ */
+static int next_step(int idx, int start, int end, int inc)
+{
+	start += inc;
+	end -= inc;
+
+	if (idx < start || idx + inc > end)
+		inc = 1;
+	return idx + inc;
+}
+
+static void inner_loop(struct kunit *test, int bytes, int d_off, int s_off)
+{
+	int left_zero_pos, left_zero_size;
+	int right_zero_pos, right_zero_size;
+	int src_pos, src_orig_pos, src_size;
+	int pos;
+
+	/* Place the source in the destination buffer. */
+	memcpy(&large_dst[s_off], large_src, bytes);
+
+	/* Copy to destination offset. */
+	memmove(&large_dst[d_off], &large_dst[s_off], bytes);
+
+	/* Make sure destination entirely matches. */
+	KUNIT_ASSERT_EQ_MSG(test, memcmp(&large_dst[d_off], large_src, bytes), 0,
+		"with size %d at src offset %d and dest offset %d",
+		bytes, s_off, d_off);
+
+	/* Calculate the expected zero spans. */
+	if (s_off < d_off) {
+		left_zero_pos = 0;
+		left_zero_size = s_off;
+
+		right_zero_pos = d_off + bytes;
+		right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
+
+		src_pos = s_off;
+		src_orig_pos = 0;
+		src_size = d_off - s_off;
+	} else {
+		left_zero_pos = 0;
+		left_zero_size = d_off;
+
+		right_zero_pos = s_off + bytes;
+		right_zero_size = ARRAY_SIZE(large_dst) - right_zero_pos;
+
+		src_pos = d_off + bytes;
+		src_orig_pos = src_pos - s_off;
+		src_size = right_zero_pos - src_pos;
+	}
+
+	/* Check non-overlapping source is unchanged.*/
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(&large_dst[src_pos], &large_src[src_orig_pos], src_size), 0,
+		"with size %d at src offset %d and dest offset %d",
+		bytes, s_off, d_off);
+
+	/* Check leading buffer contents are zero. */
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(&large_dst[left_zero_pos], large_zero, left_zero_size), 0,
+		"with size %d at src offset %d and dest offset %d",
+		bytes, s_off, d_off);
+	/* Check trailing buffer contents are zero. */
+	KUNIT_ASSERT_EQ_MSG(test,
+		memcmp(&large_dst[right_zero_pos], large_zero, right_zero_size), 0,
+		"with size %d at src offset %d and dest offset %d",
+		bytes, s_off, d_off);
+
+	/* Zero out everything not already zeroed.*/
+	pos = left_zero_pos + left_zero_size;
+	memset(&large_dst[pos], 0, right_zero_pos - pos);
+}
+
+static void memmove_overlap_test(struct kunit *test)
+{
+	/*
+	 * Running all possible offset and overlap combinations takes a
+	 * very long time. Instead, only check up to 128 bytes offset
+	 * into the destination buffer (which should result in crossing
+	 * cachelines), with a step size of 1 through 7 to try to skip some
+	 * redundancy.
+	 */
+	static const int offset_max = 128; /* less than ARRAY_SIZE(large_src); */
+	static const int bytes_step = 7;
+	static const int window_step = 7;
+
+	static const int bytes_start = 1;
+	static const int bytes_end = ARRAY_SIZE(large_src) + 1;
+
+	init_large(test);
+
+	/* Copy a growing number of overlapping bytes ... */
+	for (int bytes = bytes_start; bytes < bytes_end;
+	     bytes = next_step(bytes, bytes_start, bytes_end, bytes_step)) {
+
+		/* Over a shifting destination window ... */
+		for (int d_off = 0; d_off < offset_max; d_off++) {
+			int s_start = max(d_off - bytes, 0);
+			int s_end = min_t(int, d_off + bytes, ARRAY_SIZE(large_src));
+
+			/* Over a shifting source window ... */
+			for (int s_off = s_start; s_off < s_end;
+			     s_off = next_step(s_off, s_start, s_end, window_step))
+				inner_loop(test, bytes, d_off, s_off);
+
+			/* Avoid stall warnings. */
+			cond_resched();
+		}
+	}
+}
+
 static void strtomem_test(struct kunit *test)
 {
 	static const char input[sizeof(unsigned long)] = "hi";
@@ -325,7 +527,10 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
+	KUNIT_CASE(memcpy_large_test),
 	KUNIT_CASE(memmove_test),
+	KUNIT_CASE(memmove_large_test),
+	KUNIT_CASE(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
 	{}
 };
-- 
2.34.1

