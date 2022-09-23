Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654375E7EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIWPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiIWPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:41:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3D915D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47594CE254E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5642C433D7;
        Fri, 23 Sep 2022 15:40:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="R2ylUb1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663947641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVd2zhtvZAHJZH3TdZ1OGDCm/8edUcNmyc2Qb68LLfw=;
        b=R2ylUb1C0fULYMDaZ7GyKdqUZ5MkaAYrFkbjApL9/tvsdIbSAKjydrIk1jKouy0j+A8oZY
        kLZKvmA43CCBekf4aPwRYD0YAO+uWArIkUH4I4sC8FCeNQZinkt711x4IRhw922rLGCQ0q
        yCs/Re4+vTRQEePbYSDWK4XjuXKrkyg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a882478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 23 Sep 2022 15:40:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] minmax: clamp more efficiently by avoiding extra comparison
Date:   Fri, 23 Sep 2022 17:40:01 +0200
Message-Id: <20220923154001.4074849-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the clamp algorithm does:

	if (val > hi)
		val = hi;
	if (val < lo)
		val = lo;

But since hi > lo by definition, this can be made more efficient with:

	if (val > hi)
		val = hi;
	else if (val < lo)
		val = lo;

So fix up the clamp and clamp_t functions to do this, adding the same
argument checking as for min and min_t.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/minmax.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 5433c08fcc68..30e2e2cd0f44 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -37,6 +37,27 @@
 		__cmp(x, y, op), \
 		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
 
+#define __clamp(val, lo, hi)							\
+	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
+
+#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({		\
+		typeof(val) unique_val = (val);					\
+		typeof(lo) unique_lo = (lo);					\
+		typeof(hi) unique_hi = (hi);					\
+		__clamp(unique_val, unique_lo, unique_hi); })
+
+#define __clamp_input_check(lo, hi)						\
+        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(				\
+                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
+
+#define __careful_clamp(val, lo, hi) ({						\
+	__clamp_input_check(lo, hi) + 						\
+	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) &&	\
+			      __typecheck(hi, lo) && __is_constexpr(val) && 	\
+			      __is_constexpr(lo) && __is_constexpr(hi),		\
+		__clamp(val, lo, hi),						\
+		__clamp_once(val, lo, hi, __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
@@ -86,7 +107,7 @@
  * This macro does strict typechecking of @lo/@hi to make sure they are of the
  * same type as @val.  See the unnecessary pointer comparisons.
  */
-#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
 
 /*
  * ..and if you can't take the strict
@@ -121,7 +142,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
-- 
2.37.3

