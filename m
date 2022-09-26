Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95C35EA976
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiIZPDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiIZPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A1B140A0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5447B8094E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2ECC433D6;
        Mon, 26 Sep 2022 13:34:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Rv60Bf6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664199280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=313pwtBToP40WjGZK/I54DDFWUsiqmEDXM/dOhciNrY=;
        b=Rv60Bf6LZj2LCMhVj4ssLEc2q8EggalxCPmMtSRbKLnTKo5563NgG/KfUkcjuuUqAj1OJo
        li+cfZdBiGds5kuZcX4tO8poRPbNlHjiPmcUf2MsshvbQZ7QXKPlkZ+ExVkzewVxm1z/R6
        niu6vuNlfBqmpU442Oxfp4Fe2auaptA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f7f8981b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 13:34:39 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 1/2] minmax: sanity check constant bounds when clamping
Date:   Mon, 26 Sep 2022 15:34:34 +0200
Message-Id: <20220926133435.1333846-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
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

The clamp family of functions only makes sense if hi>=lo. If hi and lo
are compile-time constants, then raise a build error. Doing so has
already caught buggy code. This also introduces the infrastructure to
improve the clamping function in subsequent commits.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/minmax.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 5433c08fcc68..293a66ad7830 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -37,6 +37,28 @@
 		__cmp(x, y, op), \
 		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
 
+#define __clamp(val, lo, hi)							\
+	__cmp(__cmp(val, lo, >), hi, <)
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
+		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),			\
+			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
@@ -86,7 +108,7 @@
  * This macro does strict typechecking of @lo/@hi to make sure they are of the
  * same type as @val.  See the unnecessary pointer comparisons.
  */
-#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
 
 /*
  * ..and if you can't take the strict
@@ -121,7 +143,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
-- 
2.37.3

