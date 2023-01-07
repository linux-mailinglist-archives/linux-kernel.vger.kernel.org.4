Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202D3660C61
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 05:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjAGEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 23:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjAGECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 23:02:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B36339B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 20:02:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c4so3758472plc.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 20:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWXbynFoW/2e/uZz9M4AEeGGJkY04HNDA5rxUAIqcKE=;
        b=TwZFAwNJybUz0yonjGsE9z7kl9WbSslHemaDeV4wAmKEyvxKyNPZnKiYcA1kPZilAh
         +9x+3FmJkmrUtoE9n3M7ThHaNit+NMws+70Z+m4mbJAXDt+qtzeg5Laa87yMWP89zVJb
         AUnGtbbWNK5dyEI8uyKt4jmLaYIw6PZHfANG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWXbynFoW/2e/uZz9M4AEeGGJkY04HNDA5rxUAIqcKE=;
        b=kugmpIxbOTZ32+ZWI8Gwh9ecgS5+NjAga0wkMGagYEkk9yMXNLxf4VsCrdi5ztrI5l
         Qk1/ciF/OHxf0h9uFwAuZhytqeAvwJkJ9G7E3eWBpD2w8m9cKSyKnkI4DyJKcQ+23KLs
         74FcxAVFIJ5ROw92b2qZjE/NYeUVsbwpDnyN4NVIhFcnuAakj1P4EVcCBwpCEvDC0oFG
         iuC1uq+2nqqnL86cfcBuV6hwWrc8zxkscBf1/r+80X45yU4QK/H1ha4SFc2fsPmpMRCn
         RVcqSLNxoAut9qs80sSlBYsE6Qz43Mjef81BjLgJN8o3c3LLxvsyvEwGFsfJEVojE2Ch
         XUPQ==
X-Gm-Message-State: AFqh2ko3+IXzF9XKnIu/dGrSf07vpG6WF6SMTv58EnaXKOsnxmFepC1e
        nSOlrv6bs6Aj1m6iHVbq+r/waA==
X-Google-Smtp-Source: AMrXdXtDojsY9Zt9FTUptiq+P+dqInEiGH9QmyhbxiBSVPsShD5y6EFMHhZMQBnBHimmW+lVk+gHaw==
X-Received: by 2002:a17:90a:7607:b0:226:c72b:5dc with SMTP id s7-20020a17090a760700b00226c72b05dcmr8955271pjk.2.1673064130735;
        Fri, 06 Jan 2023 20:02:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a2a4500b0021e1c8ef788sm3461813pjg.51.2023.01.06.20.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 20:02:10 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
Date:   Fri,  6 Jan 2023 20:02:07 -0800
Message-Id: <20230107040203.never.112-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; h=from:subject:message-id; bh=V/i0uXy5BP8TRGxR82kJZeDEVMC9HYARmsaavbYd0Ks=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjuO6/MQqpabc6XOqu8BvbSrSXd/OVVfg0mqDmIQpV i6WHskWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7juvwAKCRCJcvTf3G3AJqkCD/ 9MP7gCFdhzhO5HM8a7dcjygkv3Ilst8zdtCxDAYXyJY5zXRFmw33rLgAHwO/+aV9x1VvHBExT6nnGh h0V4IaKXvLXJkIoeSiyopzfIjcoQqEY6W86yYyTIWtMsX13u+FU6Pr6TX/NjOo4kcnrCFjVAdDF9y4 L4aDjNymqFEJFXJklLDAgDL7ElJTznVdUC1HD39XTl+E2dFBMdbr8d5rRAFhcKvz215mo+Ra9MNJvf h8Q0i4gBIGOlS2DfZB8bIVpzZrtbrrbixdiBLG/h5D7/TekRIcG1ObVsvT8xOYbiy9/eYL/5oNvBSz 6l6tQYOTGB6kAk7JMIyJJYWFmr1bUOZIib1VSmZdHUZyPpdCDaYlXX5haWRqZ6CaLpRROSXHn95WoV iljizBHb/6+8S/BZmaKfVgCEqj+14XsGS6RA4aClBK2MLWGE7nyMZQvJhm7i8mpu7yzo6T0vsmMEc+ IYkwlE7i3BvE4IhC2QWlI99DGUeyVy7lhVAOSE/kRmopEtAR5Q26ej6MLaT1he5Zac6sX7n0GWojmu Kd/fyBpOjUZ0nwkfl41yrCSLl4JSC7EBwZ2NXkdMGEPReptAhMZPeCveY5Roi4gijxChig7P6RHzYQ zn5dLzKRrjOppOBPL2M7VWroKG6QYwaJk/Bt8omyY43mjID2NjSUJXoE64pw==
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Guenter, does this give you the needed flexibility to turn on the memcpy
kunit tests again in your slower environments?
---
 lib/Kconfig.debug  |  9 +++++++++
 lib/memcpy_kunit.c | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c2c78d0e761c..b5e94807f41c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MEMCPY_SLOW_KUNIT_TEST
+	tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS
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
index 89128551448d..cc1f36335a9b 100644
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
@@ -549,8 +558,8 @@ static void strtomem_test(struct kunit *test)
 static struct kunit_case memcpy_test_cases[] = {
 	KUNIT_CASE(memset_test),
 	KUNIT_CASE(memcpy_test),
-	KUNIT_CASE(memcpy_large_test),
 	KUNIT_CASE(memmove_test),
+	KUNIT_CASE(memcpy_large_test),
 	KUNIT_CASE(memmove_large_test),
 	KUNIT_CASE(memmove_overlap_test),
 	KUNIT_CASE(strtomem_test),
-- 
2.34.1

