Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2374B890
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGGVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGGVKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF9A268E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:10:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5a17bfb38bso2388806276.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764204; x=1691356204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiHNQq4is8OfpqPP8WUfdO7SjWmZCjsvYIK/OQ2S34k=;
        b=VonlrmkMbI3LuSjfJ3pYEf6xp0inyiyeqCTlR44m1iDSyMSZUAfQlV+Kc/KCqqvUec
         Xw23LBVpCsCZvNKKfdz5oha9wL4QVAMZ+Dtoon6eqDT+4SEt9E84fu4q9v3K+QPAWRlM
         8M0zspEL1dgRhKJUh8TcA6Pk0B6Zi5pnrjK+hHcC2sXQMuDf3lGx4R7YEIUZamxHigss
         ftAbWUMol/2QRFeKFuBCUhtf8vA6+HMPmFalCJG2zIjB8dDAlsu1l8JXMbg8g93dPSVh
         l/yZcPDlX8Spt9xLyYRF4Jj7+qJ2GK7Z6P9DvhYBZe1BBR3wRs5hWys4CZa0dkL4avQm
         ZoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764204; x=1691356204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiHNQq4is8OfpqPP8WUfdO7SjWmZCjsvYIK/OQ2S34k=;
        b=F08DkWQQ/KEUBr/+jG3ZbUGw4RUBie0qi4mggVY1gxHKSaRD+6vmwtxAP/C0GgbVmP
         7uHa68EreOhluRGOnGIdw37rTxfix26bqXQR/+cmWp/2RknMMoQUYgkI3G4vI7dhAtXh
         CTQQaNRXFltgYER+MYD1T2piWIbVg4jXLKwzwK2K05HHliTw6ua+0/u4Rzy7p1e8L/WV
         nh8KxkCHvzb1fwMacu79i8hXY/P296tL5D1zg3J6djt6yKwPex73XTk7OItA4jtpVjHC
         LVz7nrVikljJsghG2aYTKuiamZPaJzusryz5NijoMEftsyFdXjyjYbemTk4qJ9LbOFkF
         +nLQ==
X-Gm-Message-State: ABy/qLa3AyWW63u2142ADPDyPEU37YYRrcAYTzDeICg11DqN8if9BrgJ
        rHxCu/1M2VjFQ5RHCJA8Px/8ij6Q0w==
X-Google-Smtp-Source: APBJJlHMLpOh1mgvW6p2KRfl8wu5pngmTRYZA0kyQdlmLsP6brtsTMVuTrgmSBewQt86FFknx29tAyzGeQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:30b:b0:c67:ebc5:de5d with SMTP id
 b11-20020a056902030b00b00c67ebc5de5dmr32376ybs.4.1688764204244; Fri, 07 Jul
 2023 14:10:04 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:44 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-7-rmoar@google.com>
Subject: [RFC v2 6/9] kunit: memcpy: Mark tests as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
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

Mark slow memcpy KUnit tests using test attributes.

Tests marked as slow are as follows: memcpy_large_test, memmove_test,
memmove_large_test, and memmove_overlap_test. These tests were the slowest
of the memcpy tests and relatively slower to most other KUnit tests. Most
of these tests are already skipped when CONFIG_MEMCPY_SLOW_KUNIT_TEST is
not enabled.

These tests can now be filtered using the KUnit test attribute filtering
feature. Example: --filter "speed>slow". This will run only the tests that
have speeds faster than slow. The slow attribute will also be outputted in
KTAP.

Note: This patch is intended to replace the use of
CONFIG_MEMCPY_SLOW_KUNIT_TEST and to potentially deprecate this feature.
This patch does not remove the config option but does add a note to the
config definition commenting on this future shift.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- Added note under CONFIG_MEMCPY_SLOW_KUNIT_TEST.

 lib/Kconfig.debug  | 3 +++
 lib/memcpy_kunit.c | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..f1e16bbbe491 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2607,6 +2607,9 @@ config MEMCPY_SLOW_KUNIT_TEST
 	  and bit ranges. These can be very slow, so they are split out
 	  as a separate config, in case they need to be disabled.
 
+	  Note this config option will be replaced by the use of KUnit test
+	  attributes.
+
 config IS_SIGNED_TYPE_KUNIT_TEST
 	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 887926f04731..440aee705ccc 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -551,10 +551,10 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
-	KUNIT_CASE(memcpy_large_test),
-	KUNIT_CASE(memmove_test),
-	KUNIT_CASE(memmove_large_test),
-	KUNIT_CASE(memmove_overlap_test),
+	KUNIT_CASE_SLOW(memcpy_large_test),
+	KUNIT_CASE_SLOW(memmove_test),
+	KUNIT_CASE_SLOW(memmove_large_test),
+	KUNIT_CASE_SLOW(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
 	{}
 };
-- 
2.41.0.255.g8b1d071c50-goog

