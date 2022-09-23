Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F015E77E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIWKGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIWKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E10E12FF39
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1EF6221E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8B9C433C1;
        Fri, 23 Sep 2022 10:06:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LfjEOtMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663927591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DOibG2G4RROJyTimhcP/64dWLHwNn7uLTgHZvtO2iSw=;
        b=LfjEOtMd2yrEyJ8RUOs6dRhOhIAHAAZEXwDfPZyzOUCl536hKxPPc+xtRwxU21wFzNipRT
        8Nrm4EPfVrLek/A7ChGjfds0kvbAq13FFU45oTqUfyBpzqpQiDCn47NaHHpKIMZrF8IzjE
        cDdxVn/NlDhlySEV49Z+TDvXtNH/PQM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e806e730 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 23 Sep 2022 10:06:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] minmax: clamp more efficiently by avoiding extra comparison
Date:   Fri, 23 Sep 2022 12:06:21 +0200
Message-Id: <20220923100621.3888015-1-Jason@zx2c4.com>
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
 include/linux/minmax.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 5433c08fcc68..0153c9eba013 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -19,42 +19,58 @@
 #define __typecheck(x, y) \
 	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
 #define __no_side_effects(x, y) \
 		(__is_constexpr(x) && __is_constexpr(y))
 
 #define __safe_cmp(x, y) \
 		(__typecheck(x, y) && __no_side_effects(x, y))
 
 #define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
 
 #define __cmp_once(x, y, unique_x, unique_y, op) ({	\
 		typeof(x) unique_x = (x);		\
 		typeof(y) unique_y = (y);		\
 		__cmp(unique_x, unique_y, op); })
 
 #define __careful_cmp(x, y, op) \
 	__builtin_choose_expr(__safe_cmp(x, y), \
 		__cmp(x, y, op), \
 		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
 
+#define __clamp(val, lo, hi) \
+	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
+
+#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({		\
+		typeof(val) unique_val = (val);					\
+		typeof(lo) unique_lo = (lo);					\
+		typeof(hi) unique_hi = (hi);					\
+		__clamp(unique_val, unique_lo, unique_hi); })
+
+#define __careful_clamp(val, lo, hi)						\
+	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) &&	\
+			      __is_constexpr(val) && 				\
+			      __is_constexpr(lo) && __is_constexpr(hi),		\
+		__clamp(val, lo, hi),						\
+		__clamp_once(val, lo, hi, __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi)))
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
 #define min(x, y)	__careful_cmp(x, y, <)
 
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
 #define max(x, y)	__careful_cmp(x, y, >)
 
 /**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
  * @z: third value
  */
 #define min3(x, y, z) min((typeof(x))min(x, y), z)
@@ -68,78 +84,78 @@
 #define max3(x, y, z) max((typeof(x))max(x, y), z)
 
 /**
  * min_not_zero - return the minimum that is _not_ zero, unless both are zero
  * @x: value1
  * @y: value2
  */
 #define min_not_zero(x, y) ({			\
 	typeof(x) __x = (x);			\
 	typeof(y) __y = (y);			\
 	__x == 0 ? __y : ((__y == 0) ? __x : min(__x, __y)); })
 
 /**
  * clamp - return a value clamped to a given range with strict typechecking
  * @val: current value
  * @lo: lowest allowable value
  * @hi: highest allowable value
  *
  * This macro does strict typechecking of @lo/@hi to make sure they are of the
  * same type as @val.  See the unnecessary pointer comparisons.
  */
-#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
 
 /*
  * ..and if you can't take the strict
  * types, you can specify one yourself.
  *
  * Or not use min/max/clamp at all, of course.
  */
 
 /**
  * min_t - return minimum of two values, using the specified type
  * @type: data type to use
  * @x: first value
  * @y: second value
  */
 #define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
 
 /**
  * max_t - return maximum of two values, using the specified type
  * @type: data type to use
  * @x: first value
  * @y: second value
  */
 #define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
  * @type: the type of variable to use
  * @val: current value
  * @lo: minimum allowable value
  * @hi: maximum allowable value
  *
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
  * @val: current value
  * @lo: minimum allowable value
  * @hi: maximum allowable value
  *
  * This macro does no typechecking and uses temporary variables of whatever
  * type the input argument @val is.  This is useful when @val is an unsigned
  * type and @lo and @hi are literals that will otherwise be assigned a signed
  * integer type.
  */
 #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
 
 /**
  * swap - swap values of @a and @b
  * @a: first value
  * @b: second value
  */
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
-- 
2.37.3

