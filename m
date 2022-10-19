Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B73603ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiJSJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiJSJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:19:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F85EB99
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:09:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so15818763ybk.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c8o2xpxs+RS4/DEwLn7pAvuoJ6D9DUOeVpcYY5/eGtA=;
        b=F3mCd7yVd6lajsXX9epZlyUhkZrObRrxUMfGiDU0t6D3kwut7jdOK48H9qisPJA51i
         iCFAgxhoDJ42r43DvCgSDpgRrDgBlZwkZiz9AvDDHafW26hQs7uFA7qq7gl2HMUYFMFh
         CJOvcCKALlG4Mb4yyUedGPXUcMBOVqk5axA7oa5stpx5N7sCDK8+x07ahaNooWVSaWAr
         2hJszbCIw4bNpft71Fa8Y6HfVUbPc+EN8nwVCLXVKpm3h+Lj+1iowwoXC6+ELpTQP1If
         CgV0yFgCoKdepX6w9owj7SUjb6ksCbz0LynTefYVRRooUpBOFdVUlTNNtBKVbjbf+uDr
         P2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8o2xpxs+RS4/DEwLn7pAvuoJ6D9DUOeVpcYY5/eGtA=;
        b=Ccp/Vu1eZ21cZ/5PGmMr0nzHozZXERVQACaYHIOXHM1MjQQjk5nr7pKPagxzj4mzq+
         r1Nu4U9Jd1PJv5jSKUpKGzdqLm9wAgWWl1LXcPK+F35Wtb3HYOi7RpJmvjAGugQwuoLh
         MNJoAA7Z3Mi7C0mAKqqo9zZZ0QNGbbeUy5c7XZnY9lVrxOu1mnXmlnHKwendJ5i4HfoL
         yFY26ZvzmgkNXDD0MfzggziJROqV8m80E2Rm+/99815sgVD5zUM0El1nUvGyNPIPawU/
         3gq/LJOPeawP8nRLAMXOaIRRDOpCPHCMsLkFYqBlRTfejnBCTKJ+lAptoAxvEwZfdWSd
         chUg==
X-Gm-Message-State: ACrzQf00c2q8/5y551RHipnkAZ9Fl7ZGKvLVz46hBtvEOd9rQy3tiGTw
        0/t3JuMi9oIkrMBG4F4Xyo6EPMb7Jr3U9g==
X-Google-Smtp-Source: AMsMyM5VOZZdASm5LNMbolLRFDxxLsXPcEV4v6v1/18NPIwxSshF2mz0iRTuqjx/f9yBzqJejifAb3wMZ6mTdw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:db52:0:b0:357:94ca:f32c with SMTP id
 d79-20020a0ddb52000000b0035794caf32cmr5703668ywe.25.1666169883452; Wed, 19
 Oct 2022 01:58:03 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:57:48 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019085747.3810920-1-davidgow@google.com>
Subject: [PATCH] kasan: Enable KUnit integration whenever CONFIG_KUNIT is enabled
From:   David Gow <davidgow@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Gow <davidgow@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

Enable the KASAN/KUnit integration even when the KASAN tests are
disabled, as it's useful for testing other things under KASAN.
Essentially, this reverts commit 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT").

To mitigate the performance impact slightly, add a likely() to the check
for a currently running test.

There's more we can do for performance if/when it becomes more of a
problem, such as only enabling the "expect a KASAN failure" support wif
the KASAN tests are enabled, or putting the whole thing behind a "kunit
tests are running" static branch (which I do plan to do eventually).

Fixes: 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT")
Signed-off-by: David Gow <davidgow@google.com>
---

Basically, hiding the KASAN/KUnit integration broke being able to just
pass --kconfig_add CONFIG_KASAN=y to kunit_tool to enable KASAN
integration. We didn't notice this, because usually
CONFIG_KUNIT_ALL_TESTS is enabled, which in turn enables
CONFIG_KASAN_KUNIT_TEST. However, using a separate .kunitconfig might
result in failures being missed.

Take, for example:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y \
	--kunitconfig drivers/gpu/drm/tests

This should run the drm tests with KASAN enabled, but even if there's a
KASAN failure (such as the one fixed by [1]), kunit_tool will report
success.

[1]: https://lore.kernel.org/dri-devel/20221019073239.3779180-1-davidgow@google.com/

---
 mm/kasan/kasan.h  | 2 +-
 mm/kasan/report.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index abbcc1b0eec5..afacef14c7f4 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -261,7 +261,7 @@ struct kasan_stack_ring {
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
-#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 /* Used in KUnit-compatible KASAN tests. */
 struct kunit_kasan_status {
 	bool report_found;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index df3602062bfd..efa063b9d093 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -114,7 +114,7 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
 
 #endif
 
-#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+#if IS_ENABLED(CONFIG_KUNIT)
 static void update_kunit_status(bool sync)
 {
 	struct kunit *test;
@@ -122,7 +122,7 @@ static void update_kunit_status(bool sync)
 	struct kunit_kasan_status *status;
 
 	test = current->kunit_test;
-	if (!test)
+	if (likely(!test))
 		return;
 
 	resource = kunit_find_named_resource(test, "kasan_status");
-- 
2.38.0.413.g74048e4d9e-goog

