Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4650E66A7CE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjANAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjANAyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:54:19 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD87EC9C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:54:18 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so16081103pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtT80bwMFSi1TX04ncn3aOT9AB2TEcPEld78kv25IDk=;
        b=mHJYdSLc6iXM53tj8HapzvxN5xiNNTdHJPjLOWr3t+vAF+Ch6vAD2xhScGZKM781FR
         pW2A6UKJFAPzftLJlrhJE1lzR6U/xgqRoN3ie13fOgNTPr96nOaect0+0VH5lowoNVNL
         MvKx7ofMJHS0M6+9M9sZeGVkbPSFELUVIvpNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtT80bwMFSi1TX04ncn3aOT9AB2TEcPEld78kv25IDk=;
        b=bvBqTuYBwm0DcLHAgBcNZH4giWKIzUGEuAy6PbVUJZQuNF36kjsR+F5GxnVzqC/1xk
         y5e357mZWZVuqBdOP3dST37qR2rcOe6TYLAItymTrNIA5DR4ehFhambErO+yAjgh5zn3
         3W7zocP6tLNVESUzOXIY7vurRnvUlpXRDwng/jyt++tUEhnOJlmuD5aeK3JzA2XW0JJM
         gllt8R9gpendThPNAxXtVSu7KKpNXgNNbhJwWY/wvAwf5wtllpTYtpGC6wW+8X3JDnLx
         /ZdBOcHw9FROMWa7YRAsPr4oG2FX1kVjt//t+lQiYf9pEWxfbim+dZw8Rg2UvocW3yXQ
         E60A==
X-Gm-Message-State: AFqh2krvHzH8+ePe+HRFGkWlkAWxam6YsCV2jVgQI+ZxPe53UyVh3LX9
        oqotvalg9Ob/RxIBSVe5i3VzJw==
X-Google-Smtp-Source: AMrXdXt2B3bMTZYUpQ/0WY9fFL0ZAJmVyEy7dd1iIMUnSqNQpJXhXykW8qHqjTpdBMqhlZIIxdzPaQ==
X-Received: by 2002:a62:1c90:0:b0:58b:a309:b7c7 with SMTP id c138-20020a621c90000000b0058ba309b7c7mr8505657pfc.16.1673657658453;
        Fri, 13 Jan 2023 16:54:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r4-20020aa79624000000b0056bd1bf4243sm14313552pfg.53.2023.01.13.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:54:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Daniel Latypov <dlatypov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
Date:   Fri, 13 Jan 2023 16:54:12 -0800
Message-Id: <20230114005408.never.756-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3048; h=from:subject:message-id; bh=8xeMvtElsjKDZOz/S0Mopn8nlPXq3OS7Nh6P7UNbvxk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjwf0zQRlWtRfMmxr6kATuvVn6AuvVcB0GZiq+rX09 kqohRZ2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY8H9MwAKCRCJcvTf3G3AJmBrEA CFrU7VuS8XfYRW8wwbgxw0fqKkGJws6CAXjDuEH8vBbAsG1Byfhr5SjDoaxgUW3cV8C50re/eyRfZM /WaZc1ObvGeCcfvXESkpU/jZtnREVb1dPZu+4ZBQ7VjjniPX8Y+MeMZ9v6vmgX8WfkiImsStSiRxYg B8WqM5FcNNu50WjEDfDZrG7sMNJf1gQVli6bFEMMxxUdDauaZY+2UxRr66ogVNGolplIRxhqr4nirL ONbs67vHnSO5iLOIxU5ZWtQnbDYHznAbPQKdkwXZl68AzoLrG1x5IFDCtDRVbizU4rQav7xEnxSJf4 3CqbS+ybPjoyLv0A4NiIhd5bxQXrD/FZYocM+7511TAoL0cwRRsuKbN2nd8j4sz3af8JLJvSKc7A3U eGtxW9Q76Sy1lxgBdpQ9wCC0anDE7G5C65J9R1awTm/c63Q3b4vsoEC2+UzBpDNbEEmNjoKgesgZGn dZ4Pjy25q0cbC08jtvQwCUz62VsVz27AnthhkfWNQ8+8VNrQXAaLCkGcKYc3ZxGFkfL3sUjHdQZP5A MYUizoJA39EnMk5cufAeB4fDA9eHu43MK0xj7QVcYelV7DeeOLDZNQ5eMpPoYpkvfRxa1VbCviCjav 557bLTPI4rf1CjGX93wh1jEh/dzPXwFlP3cTV0n34BFaZTO1BaniasLEsqYg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the long memcpy tests may stall a system for tens of seconds
in virtualized architecture environments, split those tests off under
CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: fix tristate to bool
v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
---
 lib/Kconfig.debug  |  9 +++++++++
 lib/memcpy_kunit.c | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c2c78d0e761c..f90637171453 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MEMCPY_SLOW_KUNIT_TEST
+	bool "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS
+	depends on MEMCPY_KUNIT_TEST
+	default KUNIT_ALL_TESTS
+	help
+	  Some memcpy tests are quite exhaustive in checking for overlaps
+	  and bit ranges. These can be very slow, so they are split out
+	  as a separate config.
+
 config IS_SIGNED_TYPE_KUNIT_TEST
 	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 89128551448d..5a545e1b5dbb 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
 	}
 }
 
-static void init_large(struct kunit *test)
+static int init_large(struct kunit *test)
 {
+	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
+		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
+		return -EBUSY;
+	}
 
 	/* Get many bit patterns. */
 	get_random_bytes(large_src, ARRAY_SIZE(large_src));
@@ -319,6 +323,8 @@ static void init_large(struct kunit *test)
 
 	/* Explicitly zero the entire destination. */
 	memset(large_dst, 0, ARRAY_SIZE(large_dst));
+
+	return 0;
 }
 
 /*
@@ -327,7 +333,9 @@ static void init_large(struct kunit *test)
  */
 static void copy_large_test(struct kunit *test, bool use_memmove)
 {
-	init_large(test);
+
+	if (init_large(test))
+		return;
 
 	/* Copy a growing number of non-overlapping bytes ... */
 	for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
@@ -472,7 +480,8 @@ static void memmove_overlap_test(struct kunit *test)
 	static const int bytes_start = 1;
 	static const int bytes_end = ARRAY_SIZE(large_src) + 1;
 
-	init_large(test);
+	if (init_large(test))
+		return;
 
 	/* Copy a growing number of overlapping bytes ... */
 	for (int bytes = bytes_start; bytes < bytes_end;
-- 
2.34.1

