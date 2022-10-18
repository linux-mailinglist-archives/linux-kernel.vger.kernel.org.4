Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E376026FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:32:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21318361
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:32:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y1so13443547pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMgE1fyjrJY9vSnvRMz8bHn2yTvJe/km5liUet6OTaw=;
        b=YgTkaHRPQjsBsJNUHrik4HbQBzYewWyJ7ySyGTgdQ8p8w6U6zCfhpcFzjvfV59U62P
         3Da9gAOT1L3WBT5PcqX0ssxUuWmOH60c71ylOkujiiZ20i/VeNuvModSnHqPKb6nc5ZZ
         v/0FB6LL552bfW/aftPKoFJRAHyWo6Sg34ht0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMgE1fyjrJY9vSnvRMz8bHn2yTvJe/km5liUet6OTaw=;
        b=gdK3SooaiESr/bi+Zf3T9Cgb6Y6l6E0P73HgLUjkHE1ArwseEY/zFO/EYDoYNWff9r
         yb/6eRcWYZW18WR0ehvH08dhnJaEUf03Uq+hIzAAd/A8f1HP0iT7KT/uO2LqifoPqQuw
         YfAQxi1w0NCjSUF1oxXjCK664Mp1c6A9d5DeMPgiAlnPVoXmJEh0h48tY7UP51U1ivZg
         fCU6Vw+vMlgg5nfpHHVsqnSU30Quy119jct7e5fXOeHXtJBzLRbRRJlGeuZr8OuMENL/
         VqcX5HDMeqIXemR5Sfsm/raJcoxfWwMhHXmLKvNh/ZfTMH9I/erRR8D1e0PT7mA7VVSa
         fbWQ==
X-Gm-Message-State: ACrzQf3gJfDoCt+LmeZY7ixY7QadppPEX9RLY+2tuhZr2rPRuZ8EMANl
        CFP7z4xHLLSuzKUtjGjZqL6Gew==
X-Google-Smtp-Source: AMsMyM5vFszCXPViIzTCoQXJeqBBtRWDaVBsj5nCFCpJrmEX5X5wQFGFwCc7yT0rI3q+/X3a4I9Bbw==
X-Received: by 2002:a05:6a00:238d:b0:563:b212:9257 with SMTP id f13-20020a056a00238d00b00563b2129257mr2052202pfc.21.1666081976812;
        Tue, 18 Oct 2022 01:32:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090a1c1000b0020a81cf4a9asm11077191pjs.14.2022.10.18.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:32:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Short-circuit known-safe calls to strscpy()
Date:   Tue, 18 Oct 2022 01:32:51 -0700
Message-Id: <20221018083051.never.939-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706; h=from:subject:message-id; bh=TuV6DsCHn4YM1pzSIZxk5kOcXo+TKcB3VVIFFMdDAmw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmSy9TMK14Z6uFIMcZ/T8ujj2hXR4Xr/JigD6sMv 42vJH2iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05ksgAKCRCJcvTf3G3AJsPHD/ 9PrjfaHojf06MfJOXnvTmaDU+LsTURln+B94F70PVDLDd2Dav7dKtEGqNxJuG3bEbC6c5oEREbdQXK RrYPH2Wx5O8CtmmUwkaSiYIjjZc5y7Y3CfO2dbjGBNiFYD2jWESj5dkgWJLbibCkVHtiSGIoBO63oE fICz4Gy2XDEfxp+a2fPArCNgKzXW7QU7OBNE/2VdFn6mbVrCJhSZdhOKlS6HOh+IE+ma4n6dYL0IB7 e/MHsdfllNhhxqZa36zBSWiq6fz4DJjUJ4V7z/WQ4Agsj2mjiGVDSTM8MD8SII9Jz4Uh9TJmvnZExd SjY8asnB9rEAS3FXN+DQbm87gFf2jtHZOwOWs6klYMkR6cBtBsJ+OUM+FTzqOtfmlv0IQd47QraSFx Vr8GiqaOY+Pn9G/Rjpb+rjIFeJ4YMiY/lEia9QPmxU36+ML52uBrhAlNe/QsAVCXdBzZ500FRIIu/d uXFSZfQfoYkf8+mTlUo30HujO84nZ/0JVpYarc/JbJLynPuBQPsG0PGCoGJyA2/M3ZBiL8DF20TdXg x5JsNVPwhpcJOklcCegGs7A+kGhW6kvKCxOpEa99xZYzhSy3ozTqvxOY023eMoIcEhAwCeDxVVojFf NnVntHm6jMPdmeR5EH0vHa0d1lMBerG4BgLsbTXcTGmmSVYjBZWvusnKSSKQ==
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

Replacing compile-time safe calls of strcpy()-related functions with
strscpy() was always calling the full strscpy() logic when a builtin
would be better. For example:

	char buf[16];
	strcpy(buf, "yes");

would reduce to __builtin_memcpy(buf, "yes", 4), but not if it was:

	strscpy(buf, yes, sizeof(buf));

Fix this by checking if all sizes are known at compile-time.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 10 ++++++++++
 lib/strscpy_kunit.c            | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index aa1a50009632..c473adb55cf5 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -321,6 +321,16 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 
+	/* Short-circuit for compile-time known-safe lengths. */
+	if (__compiletime_lessthan(p_size, SIZE_MAX)) {
+		len = __compiletime_strlen(q);
+
+		if (len < SIZE_MAX && __compiletime_lessthan(len, size)) {
+			__underlying_memcpy(p, q, len + 1);
+			return len;
+		}
+	}
+
 	/*
 	 * This call protects from read overflow, because len will default to q
 	 * length if it smaller than size.
diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
index 98523f828d3a..a6b6344354ed 100644
--- a/lib/strscpy_kunit.c
+++ b/lib/strscpy_kunit.c
@@ -81,6 +81,8 @@ static void tc(struct kunit *test, char *src, int count, int expected,
 
 static void strscpy_test(struct kunit *test)
 {
+	char dest[8];
+
 	/*
 	 * tc() uses a destination buffer of size 6 and needs at
 	 * least 2 characters spare (one for null and one to check for
@@ -111,6 +113,17 @@ static void strscpy_test(struct kunit *test)
 	tc(test, "ab",   4, 2,	    2, 1, 1);
 	tc(test, "a",    4, 1,	    1, 1, 2);
 	tc(test, "",     4, 0,	    0, 1, 3);
+
+	/* Compile-time-known source strings. */
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 3), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 1), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 0), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", ARRAY_SIZE(dest)), 5);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 3), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 1), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 0), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "This is too long", ARRAY_SIZE(dest)), -E2BIG);
 }
 
 static struct kunit_case strscpy_test_cases[] = {
-- 
2.34.1

