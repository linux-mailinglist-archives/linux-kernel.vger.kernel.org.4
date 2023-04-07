Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D616DB434
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDGT2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDGT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A508BBA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso2166661pjm.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKXPyf9/jVgEky/woKrd/ToiUHGkbctLniTEZtkVQes=;
        b=I+kfyOmr6Qoo6b3/ZrybUklENlej9HUCZeiHZWTfUK8hgYP2sFFTMsxQt8zVnLvW/K
         wYBqqv+1jfCkBmYfQalUiZEGod0FkWEtpF7XKo7EHsDPqB2ov5uQLVdJLwa8uTAZr5VX
         E503I7yHGHqXZ/Jf6c8jmieB91j0J0xp++8tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKXPyf9/jVgEky/woKrd/ToiUHGkbctLniTEZtkVQes=;
        b=3pkOv5gSPDVbnJ0gWX1TghEYphS1h766VNMFKt2ujVgH0aBp11q3So72fQge6o8+X1
         H+AaXZjeCEg6kZ8Li8YyiYd0LHXaazspesr3theY5p6JS8u0254AcFukXgFj59QQk+l+
         xcorMhYtpvbJBUtUWlyXmeLg6ME0kYhruC+mPR0qVFbCOUEA7OCKtnHhAOhtSlyKPAfj
         Adxrag4KbFzwQI93djofL6ibMbIhNnLZ0n5yiKrXV6xeDoLpqXgSdelmNyiToEZRechI
         TCFz5sH8RNPm5oFN6BrwNhRSnTiXF3Qj3V1Jjcx6klV+gxmEI31MtOIsyX4dMoVDdXdW
         9pMQ==
X-Gm-Message-State: AAQBX9e0yQ3VoC/GwnDwOS3cl7a+R65iIazhkdEBuo3a3IG3gJQEqOKZ
        XwC9HqjtpQYje+xNgH18XSFiMA==
X-Google-Smtp-Source: AKy350auDS4oaAAn1AOzPaTk/oMSPDhh5uXyZv9XlIO13aS34wwCdGcfln5z+NGTjmzJ9riRIp9UxA==
X-Received: by 2002:a05:6a20:7010:b0:cc:606a:4330 with SMTP id h16-20020a056a20701000b000cc606a4330mr3067846pza.55.1680895645530;
        Fri, 07 Apr 2023 12:27:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b00590ede84b1csm3502406pfm.147.2023.04.07.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Andy Shevchenko" <andy@kernel.org>,
        "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Puyou Lu" <puyou.lu@gmail.com>, "Mark Brown" <broonie@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "David Gow" <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Sander Vanheule" <sander@svanheule.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v2 09/10] fortify: Add KUnit tests for runtime overflows
Date:   Fri,  7 Apr 2023 12:27:15 -0700
Message-Id: <20230407192717.636137-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28211; h=from:subject; bh=9234LPqVGxZ+vQONlRmA/WilFWlwyeVTGRc6LK6b9W4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TnXtnMdDU49QvmJyRXJ8CSL/Hg1N9YJdbQMRS /0eSRcuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJjmPD/ 9xPFuTnIXCYrM0wPvMUs/6KEc5xlYocj5GeDJGbcW2VWChCjsDoP7kEyCGA2RM1/IEKzV7/klLFTRd YYaCD4P1DfN5YBbHpSOhtywUvCooQ95kg5yO6fdYSZ7WVhlPHLk7v6kgthy75zWZf0KqsSI3gX0wqU dYHmjBbjfdUQvTEPmKzNZefPtvPy5aPN0kbY6lLOj32OYVEbkvE/EAyrQNtRIXTy1M4jG5yHApaDnn MuoCqG++6q7XzrpS/KhfGkWvozecaGiWqyVZPpIDYgfGGcEXvfnISl47J/FrmaIWFTdC7kHgzkR+C9 NMxkHRQwhtGWRqY/YM+P33Vhv6kBWLPfW8KTWvQls+lW4XR1AicqWQ5EaxXZui5Z3vaRiu9V/13zHo AJKUx8nMk+0iL2gKdz9Ek1rPPKwJGJNooWqVGoldFq5kMTpqu7iLJneDi9x7q5LynjbXIf4LAy+YdW I7XnWtijlG/WebWYqwNQWbjh2iLF7aJUc1RGcmOjVUhtjx/4xKxpwKOYCe2DAfIJ+uOtv9isKM/XFX 0cy8N6OtA5u5Vm0DbS96mbeCNJlMtAAhIU5ZQWVvzfkvjC9Be4998aBXR0cGIIklbzArH1rY5N668T GinmVYfNDK+axxi1DNG2Tw5jWQvLvIV9onUmFI0Xdjebm9sak9xcQZ/f3qRA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With fortify overflows able to be redirected, we can use KUnit to
exercise the overflow conditions. Add tests for every API covered by
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/fortify_kunit.c | 673 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 673 insertions(+)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index ea2b39f279c2..3206fe723110 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -347,6 +347,663 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+/*
+ * We can't have an array at the end of a structure or else
+ * builds without -fstrict-flex-arrays=3 will report them as
+ * being an unknown length. Additionally, add bytes before
+ * and after the string to catch over/underflows if tests
+ * fail.
+ */
+struct fortify_padding {
+	unsigned long bytes_before;
+	char buf[32];
+	unsigned long bytes_after;
+};
+/* Force compiler into not being able to resolve size at compile-time. */
+static volatile int unconst;
+
+static void strlen_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	int i, end = sizeof(pad.buf) - 1;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(pad.buf) - 1; i++)
+		pad.buf[i] = i + '0';
+	/* Trailing bytes are still %NUL. */
+	KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* String is terminated, so strlen() is valid. */
+	KUNIT_EXPECT_EQ(test, strlen(pad.buf), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Make string unterminated, and recount. */
+	pad.buf[end] = 'A';
+	end = sizeof(pad.buf);
+	KUNIT_EXPECT_EQ(test, strlen(pad.buf), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+}
+
+static void strnlen_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	int i, end = sizeof(pad.buf) - 1;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(pad.buf) - 1; i++)
+		pad.buf[i] = i + '0';
+	/* Trailing bytes are still %NUL. */
+	KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* String is terminated, so strnlen() is valid. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf)), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* A truncated strnlen() will be safe, too. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf) / 2),
+					sizeof(pad.buf) / 2);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Make string unterminated, and recount. */
+	pad.buf[end] = 'A';
+	end = sizeof(pad.buf);
+	/* Reading beyond with strncpy() will fail. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+
+	/* Early-truncated is safe still, though. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+
+	end = sizeof(pad.buf) / 2;
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void strcpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf) + 1] = { };
+	int i;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(src) - 2; i++)
+		src[i] = i + '0';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strcpy() 1 less than of max size. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Only last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	src[sizeof(src) - 2] = 'A';
+	/* But now we trip the overflow checking. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Trailing %NUL -- thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	src[sizeof(src) - 1] = 'A';
+	/* And for sure now, two bytes past. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	/*
+	 * Which trips both the strlen() on the unterminated src,
+	 * and the resulting copy attempt.
+	 */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Trailing %NUL -- thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strncpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strncpy() 1 less than of max size. */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst - 1)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Only last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate (though unterminated) max-size strncpy. */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* No trailing %NUL -- thanks strncpy API. */
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* But we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst + 1)
+				== pad.buf);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And further... */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst + 2)
+				== pad.buf);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strlcpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+	char tiny[4] = "abcd";
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strlcpy() 1 less than of max size. */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst - 1),
+			sizeof(src) - 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Keeping space for %NUL, last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate max-size strlcpy. */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst),
+			sizeof(src) - 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* A trailing %NUL will exist. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst + 1),
+			sizeof(src) - 1);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And much further... */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(src) * 2 + unconst),
+			sizeof(src) - 1);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Catch over-read. */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, tiny,
+				      sizeof(pad.buf) + unconst),
+			sizeof(tiny));
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+}
+
+static void strscpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strscpy() 1 less than of max size. */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst - 1),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Keeping space for %NUL, last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate max-size strscpy. */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* A trailing %NUL will exist. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst + 1),
+			-E2BIG);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And much further... */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(src) * 2 + unconst),
+			-E2BIG);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strcat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf) / 2] = { };
+	char one[] = "A";
+	char two[] = "BC";
+	int i;
+
+	/* Fill 15 bytes with valid characters. */
+	for (i = 0; i < sizeof(src) - 1; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strcat() using less than half max size. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, src) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strcat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, src) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, one) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, one) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, two) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strncat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf)] = { };
+	int i, partial;
+
+	/* Fill 31 bytes with valid characters. */
+	partial = sizeof(src) / 2 - 1;
+	for (i = 0; i < partial; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strncat() using less than half max size. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, partial) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strncat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, partial) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 2) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated destination, and overflow. */
+	pad.buf[sizeof(pad.buf) - 1] = 'A';
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	/* This will have tripped both strlen() and strcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 3);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strlcat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf)] = { };
+	int i, partial;
+	int len = sizeof(pad.buf) + unconst;
+
+	/* Fill 15 bytes with valid characters. */
+	partial = sizeof(src) / 2 - 1;
+	for (i = 0; i < partial; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strlcat() using less than half max size. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len), partial);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strlcat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len), partial * 2);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "Q", len), partial * 2 + 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "V", len * 2), len);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "QQ", len * 2), len + 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated destination, and overflow. */
+	pad.buf[sizeof(pad.buf) - 1] = 'A';
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "TT", len * 2), len + 2);
+	/* This will have tripped both strlen() and strlcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated source, and overflow. */
+	memset(src, 'B', sizeof(src));
+	pad.buf[sizeof(pad.buf) - 1] = '\0';
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len * 3), len - 1 + sizeof(src));
+	/* This will have tripped both strlen() and strlcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 3);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void memscan_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + strlen("Where oh where is ");
+	char needle = 'm';
+	size_t len = sizeof(haystack) + unconst;
+
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memchr_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + strlen("Where oh where is ");
+	char needle = 'm';
+	size_t len = sizeof(haystack) + unconst;
+
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memchr_inv_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + 1;
+	char needle = 'W';
+	size_t len = sizeof(haystack) + unconst;
+
+	/* Normal search is okay. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memcmp_test(struct kunit *test)
+{
+	char one[] = "My mind is going ...";
+	char two[] = "My mind is going ... I can feel it.";
+	size_t one_len = sizeof(one) + unconst - 1;
+	size_t two_len = sizeof(two) + unconst - 1;
+
+	/* We match the first string (ignoring the %NUL). */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Still in bounds, but no longer matching. */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 1), -32);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Catch too-large ranges. */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 2), INT_MIN);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+
+	KUNIT_ASSERT_EQ(test, memcmp(two, one, two_len + 2), INT_MIN);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void kmemdup_test(struct kunit *test)
+{
+	char src[] = "I got Doom running on it!";
+	char *copy;
+	size_t len = sizeof(src) + unconst;
+
+	/* Copy is within bounds. */
+	copy = kmemdup(src, len, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Without %NUL. */
+	copy = kmemdup(src, len - 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Tiny bounds. */
+	copy = kmemdup(src, 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Out of bounds by 1 byte. */
+	copy = kmemdup(src, len + 1, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	kfree(copy);
+
+	/* Way out of bounds. */
+	copy = kmemdup(src, len * 2, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+	kfree(copy);
+
+	/* Starting offset causing out of bounds. */
+	copy = kmemdup(src + 1, len, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
+	kfree(copy);
+}
+
 static int fortify_test_init(struct kunit *test)
 {
 	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
@@ -375,6 +1032,22 @@ static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(alloc_size_kvmalloc_dynamic_test),
 	KUNIT_CASE(alloc_size_devm_kmalloc_const_test),
 	KUNIT_CASE(alloc_size_devm_kmalloc_dynamic_test),
+	KUNIT_CASE(strlen_test),
+	KUNIT_CASE(strnlen_test),
+	KUNIT_CASE(strcpy_test),
+	KUNIT_CASE(strncpy_test),
+	KUNIT_CASE(strlcpy_test),
+	KUNIT_CASE(strscpy_test),
+	KUNIT_CASE(strcat_test),
+	KUNIT_CASE(strncat_test),
+	KUNIT_CASE(strlcat_test),
+	/* skip memset: performs bounds checking on whole structs */
+	/* skip memcpy: still using warn-and-clobber instead of hard-fail */
+	KUNIT_CASE(memscan_test),
+	KUNIT_CASE(memchr_test),
+	KUNIT_CASE(memchr_inv_test),
+	KUNIT_CASE(memcmp_test),
+	KUNIT_CASE(kmemdup_test),
 	{}
 };
 
-- 
2.34.1

