Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42306A6E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCAOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCAOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:39:49 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247B3403A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:39:46 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id ck7-20020a0564021c0700b004a25d8d7593so19492296edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nI6aPFa9WKtq8ZRbJBabpyygWI3BetO7s5boeToCFf4=;
        b=cATkgsuouPJkBNjeAYA9+s1iR8apIqRMfi4XOoGeFHMEhEog2NEsq1DeNYIGai5Ak0
         S3QmO80XpPCdudI8YFrtI32Eypmi77dH6qEyo+Fn16KbadIvqPWwzVb1NhC+Ap8tLi1Z
         7/6EVmJlQHOY5Zxc9ILO9G3PR5FLohvlv81MJ6rJ/QZUcZOrNn3i34tb9JgkpYewI1U7
         WRP+37VMuNFxMMT77lhKdJzvbMo5ZiHyh7h6ub9R8P004bZq0qY3Jl/0n2yOj+DeB2iO
         PbgCdp3Zi+2+zhfH98j+JOYUrHnfzL9wjwB4dlavlx2rz6xKg4yx7lSVUSBcOjrrNuc7
         lAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI6aPFa9WKtq8ZRbJBabpyygWI3BetO7s5boeToCFf4=;
        b=fope5Ct5WegPQiDXZqS51ndUDg6/tFj6GdC1EFRmxn8kamPSjT4dh1mMWtfdD5ixhQ
         jPdCPWIQ8PuJ8xdkaZg6liqPimwYfKNh7O1d7SJPQJw4TmkSGFwwqIyjzPDJRKV9PFfu
         AA+Y75WH+77Pf/b6zMRK9pQG97RPAFvSihuwv3YYkradf0PlQqUd1BAatYyySwUdLET6
         BcQwpe43u9yB0N8b02CrsyinWeai49fDzEofEEx0NnW/zCD7mBQ6fN744zGtRlvVZBhr
         xeAxtmm5hHg6pg7fon+1rBiZnNphxGaIufKRDHxohrqu9sskAeQ9+OXzU7g1mUq6rlCq
         +gYw==
X-Gm-Message-State: AO0yUKUDJgI+ENROysO/emFUmf1adU+dd33gDllaGokJoAu9RA4ayu0c
        RBvSGaD8QrjAB9hjCUGn9qThTVxHo5s=
X-Google-Smtp-Source: AK7set93S1q2C0fosEy31BA46EXe+QoNnTidYRE1hF4D1mqRDUvDHPSE18kwxyuL0JHbses5B6pE+oEH8Vc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3c31:b0cf:1498:e916])
 (user=glider job=sendgmr) by 2002:a17:906:ce59:b0:888:b471:8e18 with SMTP id
 se25-20020a170906ce5900b00888b4718e18mr3181793ejb.8.1677681585154; Wed, 01
 Mar 2023 06:39:45 -0800 (PST)
Date:   Wed,  1 Mar 2023 15:39:33 +0100
In-Reply-To: <20230301143933.2374658-1-glider@google.com>
Mime-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301143933.2374658-4-glider@google.com>
Subject: [PATCH 4/4] kmsan: add memsetXX tests
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests ensuring that memset16()/memset32()/memset64() are
instrumented by KMSAN and correctly initialize the memory.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index cc98a3f4e0899..e450a000441fb 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -503,6 +503,25 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/* Generate test cases for memset16(), memset32(), memset64(). */
+#define DEFINE_TEST_MEMSETXX(size, var_ty)                                  \
+	static void test_memset##size(struct kunit *test)                   \
+	{                                                                   \
+		EXPECTATION_NO_REPORT(expect);                              \
+		volatile var_ty uninit;                                     \
+                                                                            \
+		kunit_info(test,                                            \
+			   "memset" #size "() should initialize memory\n"); \
+		DO_NOT_OPTIMIZE(uninit);                                    \
+		memset##size((var_ty *)&uninit, 0, 1);                      \
+		kmsan_check_memory((void *)&uninit, sizeof(uninit));        \
+		KUNIT_EXPECT_TRUE(test, report_matches(&expect));           \
+	}
+
+DEFINE_TEST_MEMSETXX(16, uint16_t)
+DEFINE_TEST_MEMSETXX(32, uint32_t)
+DEFINE_TEST_MEMSETXX(64, uint64_t)
+
 static noinline void fibonacci(int *array, int size, int start)
 {
 	if (start < 2 || (start == size))
@@ -549,6 +568,9 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
+	KUNIT_CASE(test_memset16),
+	KUNIT_CASE(test_memset32),
+	KUNIT_CASE(test_memset64),
 	KUNIT_CASE(test_long_origin_chain),
 	{},
 };
-- 
2.39.2.722.g9855ee24e9-goog

