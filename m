Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72C638CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKYPA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 10:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKYPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:00:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DDC3D939
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:00:50 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-233-GSQ7UKGuO4S1B_pHGfQDVA-2; Fri, 25 Nov 2022 15:00:47 +0000
X-MC-Unique: GSQ7UKGuO4S1B_pHGfQDVA-2
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 15:00:42 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 25 Nov 2022 15:00:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/1] minmax.h: Slightly relax the type checking done by min()
 and max().
Thread-Topic: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
Thread-Index: AdkA3jB+9p3HVKOjROWboToCz6X2bg==
Date:   Fri, 25 Nov 2022 15:00:42 +0000
Message-ID: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly relax the type checking done by min() and max().
- Promote signed/unsiged char/short to int prior to the type test.
  This matches what the compiler does before doing the comparison.
- Skip the type test if either argument is a positive 'int' constant.
  Instead cast the constant to 'int', the compiler may promote it
  back to 'unsigned int' when doing the test.

Reduces the need to use min_t/max_t() and the possibly unwanted
  side effects if a type that is too small is specified.

Signed-off-by: David Laight <David.Laight@aculab.com>
---
 include/linux/minmax.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 5433c08fcc68..77de234cf502 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -9,15 +9,28 @@
  *
  * - avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - perform strict type-checking (to generate warnings instead of
- *   nasty runtime surprises). See the "unnecessary" pointer comparison
- *   in __typecheck().
+ * - perform type-checking (to generate warnings instead of nasty runtime
+ *   surprises). See the "unnecessary" pointer comparison in __typecheck().
  * - retain result as a constant expressions when called with only
  *   constant expressions (to avoid tripping VLA warnings in stack
  *   allocation usage).
+ *
+ * The type-check need not be strict in all cases:
+ * - char and short can be promoted to int.
+ * - comparisons against non-negative constant integers can be done by
+ *   casting the constant to (int).
  */
+#define __is_constzero(x) \
+	(sizeof(*(1 ? ((void *)((long)(x))) : (int *)0)) == sizeof(void *))
+
+#define __is_positive_int(x) __is_constzero((long)(x) >> 31)
+#define __maybe_int_cast(x) __builtin_choose_expr(__is_positive_int(x), (int)(long)(x), x)
+
+#define __typecheck_ptr_type(x, y) \
+	(1 ? (void *)!(__is_positive_int(x) || __is_positive_int(y)) : (typeof((x) + 0) *)0)
+
 #define __typecheck(x, y) \
-	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
+	(!!(sizeof(__typecheck_ptr_type(x, y) == __typecheck_ptr_type(y, x))))
 
 #define __no_side_effects(x, y) \
 		(__is_constexpr(x) && __is_constexpr(y))
@@ -25,7 +38,8 @@
 #define __safe_cmp(x, y) \
 		(__typecheck(x, y) && __no_side_effects(x, y))
 
-#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+#define __cmp_maybe_int(x, y, op)	((x) op (y) ? (x) : (y))
+#define __cmp(x, y, op)	__cmp_maybe_int(__maybe_int_cast(x), __maybe_int_cast(y), op)
 
 #define __cmp_once(x, y, unique_x, unique_y, op) ({	\
 		typeof(x) unique_x = (x);		\
-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

