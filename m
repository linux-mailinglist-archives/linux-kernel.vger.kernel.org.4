Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7168F6728FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjARUHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjARUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:06:59 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF43928E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:06:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so25332496pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYOiWV7XtZHLsiEvKJ4Aq9SdMJwGCG7DLkdCH1pVIRs=;
        b=MHA8t03jLm15PFQcJ5fsrqbIOEnjPOc6aUrLPWCq2TnvGfm7xD/c7lXOPUA0LdfOVu
         fB1NyG12qYAFC5s87vifn4/fsawZ/hUfDsmUaVw0CLrvmm1gbgrF+i2/XmeV93e30a+O
         sG/JKYSEcxiMKwR8uqZghtsemVXWhEkoWBC+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYOiWV7XtZHLsiEvKJ4Aq9SdMJwGCG7DLkdCH1pVIRs=;
        b=WWZkuNt9pzjCnHReeo3MBJI4Gq2s1ixZxSIG2m9hcO2d50hu9txegNYEp9D7+mcMkm
         lHXenP9JokiTGbj6PlpST55WBe1yM6VzESN2kS3PYoEDq9JILG5W2juVl6Ny2oL52K13
         b4V0OypTt7EU2EL8qPX7rFMpfeHzeejKmotUkeooBn/SoBvdT1oUaxkpeRMKI36cBGXK
         yCFVWdWk/8Lp4FuvWL7WsEui7zW8profeSHYChVCuzRyPII2GeDNEYWc3boT9Nnj5CWI
         03RNrSnO8Ib1dCq/lKgqtLOrAMx3cDVXbP+5HdeJtZZq0i0AGm1vqRj8auGoEcZAx0yM
         qEHQ==
X-Gm-Message-State: AFqh2ko8eqKRwlZF06SHTJSrnaQ+epCfE/J40WAwT8BvXnQX7FoPmr5v
        5eGDFAKLYkE59qgD9ox9ELkYwQ==
X-Google-Smtp-Source: AMrXdXvdfEPxsrLi3aN7jiIhBZP10sDUhSgmDic28eP0BPxCg9Nyc1gcROXBG73bhpU/Z4q2EG+sLQ==
X-Received: by 2002:a62:1910:0:b0:58d:c1ca:9360 with SMTP id 16-20020a621910000000b0058dc1ca9360mr8777141pfz.17.1674072417327;
        Wed, 18 Jan 2023 12:06:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11-20020aa79d8b000000b0058dd9c32fcasm2837217pfq.180.2023.01.18.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:06:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
Date:   Wed, 18 Jan 2023 12:06:54 -0800
Message-Id: <20230118200653.give.574-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; h=from:subject:message-id; bh=7dD2ETKz1kSHW0EhAvk/jTtE59a6xdH3SwJS1MztNRY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjyFFdHhGR6EcLP0KFq0cL1EX7goeP8L8W9mh6i7r0 Ldjf7nuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY8hRXQAKCRCJcvTf3G3AJotNEA CLIPYxj0UEibzDiMpmf6JbwzcK07wDYuMZI6rWCzjg9xFFd8qZa6mc2ki896fyoJUVsnzSyMoHhm4P U+7bH+ZN79nMN4ryuwpM3m1FCryYzPhk0HdR8JQzZkmPGHS0BbSTV09cgnTxnkjZvzYf2F/2yLXKkw 8I/bO2TC/br/I3MVMcRFoHnl7QK22pq88Wby3TrUa/Yv+GoIYjKL9AOJu5uswxL3hNGaOAWXdZ3b2a OWp4ZUZkFys2F/ann+unMCx2YrNfJrwXFPylMVHkzzJ+HN91YFFe2dAmTy5AW07bSFmZ3244CPiNRZ FOCDtJs3AOeVHGb0eEa35ZYNm1JVOmhmSi1jHNpoBwyB7Uf5tidOvW60OA392dXK5rDq9YEmZm6fgt ledFrUOAHimtnE8ueI3YuJ2cNmSd2d5JZdgnRD2eySIgiPj8A6E3uQzYHabeUkkWqLYB8kLwa5eQun AOuZeQEkhoQYh1XxbeoT3eoUoiFl2tSFSb9xOyt52FYZt348XDiZp+HikERWDwpo5dD9ESVFoeg6Ec Z9V3gxNYwck2Q4fI59AaEk1gtuHD7IrsJDOVPWErE3s7VterCHaKUK1RTuQq2xJS5hdDD6tR4AYiXP gULBPBnuhFZjqPxIPyykD8Nzqwwvfiu9vufp+qoinbMf75z5f3PhTIMio2Vg==
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
v3: fix defaults, avoid redundant returns.
v2: https://lore.kernel.org/all/20230114005408.never.756-kees@kernel.org/
v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
---
 lib/Kconfig.debug  | 9 +++++++++
 lib/memcpy_kunit.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..149d6403b8a9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2566,6 +2566,15 @@ config MEMCPY_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MEMCPY_SLOW_KUNIT_TEST
+	bool "Include exhaustive memcpy tests"
+	depends on MEMCPY_KUNIT_TEST
+	default y
+	help
+	  Some memcpy tests are quite exhaustive in checking for overlaps
+	  and bit ranges. These can be very slow, so they are split out
+	  as a separate config, in case they need to be disabled.
+
 config IS_SIGNED_TYPE_KUNIT_TEST
 	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 89128551448d..90f3aa9e909f 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -309,6 +309,8 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
 
 static void init_large(struct kunit *test)
 {
+	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST))
+		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
 
 	/* Get many bit patterns. */
 	get_random_bytes(large_src, ARRAY_SIZE(large_src));
@@ -327,6 +329,7 @@ static void init_large(struct kunit *test)
  */
 static void copy_large_test(struct kunit *test, bool use_memmove)
 {
+
 	init_large(test);
 
 	/* Copy a growing number of non-overlapping bytes ... */
-- 
2.34.1

