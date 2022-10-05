Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7566F5F5C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJEWVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJEWVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:21:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F492654B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:21:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3579d28ffd6so1720227b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=0j8310cNrpL5zAttBinw00jwdLpJXpiF3b2+R72LkuM=;
        b=FchmUBEZ9FpGCuF0PkP6QUoX9EyPgCO2J1WW0wQFTSdGNa7eRCzL9MvP3EX/Mui/2J
         LR+Uupy728yAgJzXiod6LqvGyuO7acmie0XE/SwWf7HdBEsPEtiLJAHJbKPAJifXU1Fg
         Hxj1Cc1sCK3Ngx1H6GAZetO8+t1Nlf+Pe/3BC7myMxliOfVFdoxaDCkCgzKdjPVsBBiX
         hYDJj2AS5ijWQfm5nSugyrCC7iAgutXN7mTIZYsGts6cparU3qTzqVODKiyc3PzSyFtQ
         CdjJ4rsYydKCuQxh1b+wvLtfvDCPUnwvPVG5Eyfwyjhjbf+gYyurx0j+WUHivdp/UzEH
         XPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0j8310cNrpL5zAttBinw00jwdLpJXpiF3b2+R72LkuM=;
        b=zfMmVWqzItX2iIam9jGQKkmZcjZjVVVHqKPkFdd56mo1wJwrQGIivzXlnXKV6PCmA2
         QAcS+OnmAH3AlvhTfj8TWQ23odaRFZQev2NPU4BnfWQBTeKOw5ScaigQ8jtRjJW/bleu
         N15LCW8T+cV0+7vbVOaolbQphbfAtR+vnC4VudN1bdEhjeFfgAb+4Xoxo5M5peGeLbA/
         giPSpd6Zdu5B8Upk0MUnLKZNxXQVJvP4entnYt61t5+JkWk7HO6DXf89XGEKooEOU/vv
         LU7utAOXHYQSvdXYSMkX5p4gbP6gnaWtOfVJEogTpnSjec+mo1CCl43ihB0Ia5IZ9EKM
         szsw==
X-Gm-Message-State: ACrzQf3NNhhxxRDbQ5O0o4HKDqW1HRApa+6cGxtcvaXA+4G8w1M+fnZP
        Wgu5ti/ASVuNKhK6BYjI0h9/WRtyYVD7MEkylVE=
X-Google-Smtp-Source: AMsMyM7TDiFj45VXtJO4WOl9b4Eer7PN+AShERZDKlVcYIFZW3MQjgTktvfKrqBlDi/6SNVpmS1Zhi5vZuHGBqeGhgc=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:b2dd:e583:b2f1:2e20])
 (user=ndesaulniers job=sendgmr) by 2002:a81:1393:0:b0:35d:17d8:c7b6 with SMTP
 id 141-20020a811393000000b0035d17d8c7b6mr1954280ywt.203.1665008489839; Wed,
 05 Oct 2022 15:21:29 -0700 (PDT)
Date:   Wed,  5 Oct 2022 15:21:23 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665008483; l=2516;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=4vvyZvS0tg6NZ4KTQeio+rjTXVuriVCayUFtKAhNiik=;
 b=RuHxxKB4qHqHVr5+1IqEHvhgGiwZAh43kZ9rBdkLkRD1x6cOKIPnBWn8XsFhv1nh320u++G4z7cF
 4op6dMgCAQBuIq0Mdooc7N2neeBqTPHFJWYJgpQN1PNikjpTKxRa
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221005222123.3191609-1-ndesaulniers@google.com>
Subject: [PATCH] overflow: disable failing tests for older clang versions
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
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

Building the overflow kunit tests with clang-11 fails with:

$ ./tools/testing/kunit/kunit.py run --arch=arm --make_options LLVM=1 \
overflow
...
ld.lld: error: undefined symbol: __mulodi4
...

Clang 11 and earlier generate unwanted libcalls for signed output,
unsigned input.

Disable these tests for now, but should these become used in the kernel
we might consider that as justification for dropping clang-11 support.
Keep the clang-11 build alive a little bit longer.

Avoid -Wunused-function warnings via __maybe_unused.

Link: https://github.com/ClangBuiltLinux/linux/issues/1711
Link: https://github.com/llvm/llvm-project/commit/3203143f1356a4e4e3ada231156fc6da6e1a9f9d
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 lib/overflow_kunit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index f385ca652b74..d035768ed734 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -254,6 +254,7 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
 }									\
 									\
+__maybe_unused								\
 static void n ## _overflow_test(struct kunit *test) {			\
 	unsigned i;							\
 									\
@@ -716,12 +717,23 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(u32_u32__u32_overflow_test),
 	KUNIT_CASE(s32_s32__s32_overflow_test),
 /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
-#if BITS_PER_LONG == 64
+#if defined(CONFIG_CC_IS_GCC) || \
+	(defined(CONFIG_CC_IS_CLANG) && \
+		(__clang_major__ > 13 || BITS_PER_LONG == 64))
 	KUNIT_CASE(u64_u64__u64_overflow_test),
 	KUNIT_CASE(s64_s64__s64_overflow_test),
 #endif
-	KUNIT_CASE(u32_u32__u8_overflow_test),
+/*
+ * Clang 11 and earlier generate unwanted libcalls for signed output, unsigned
+ * input.
+ * https://github.com/llvm/llvm-project/commit/3203143f1356a4e4e3ada231156fc6da6e1a9f9d
+ */
+#if defined(CONFIG_CC_IS_GCC) || \
+	(defined(CONFIG_CC_IS_CLANG) && \
+		(__clang_major__ > 11 || BITS_PER_LONG == 64))
 	KUNIT_CASE(u32_u32__int_overflow_test),
+#endif
+	KUNIT_CASE(u32_u32__u8_overflow_test),
 	KUNIT_CASE(u8_u8__int_overflow_test),
 	KUNIT_CASE(int_int__u8_overflow_test),
 	KUNIT_CASE(shift_sane_test),

base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.38.0.rc1.362.ged0d419d3c-goog

