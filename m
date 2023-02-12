Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB869395A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBLS2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBLS2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:28:05 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC857EB70
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 10:28:01 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31CIRdXC005078;
        Sun, 12 Feb 2023 19:27:39 +0100
Date:   Sun, 12 Feb 2023 19:27:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y+kvmy/5oK9trrDH@1wt.eu>
References: <20230209024044.13127-1-v@vda.io>
 <Y+RrySeoRJn9GbrI@1wt.eu>
 <38f0c544-cc4c-4e21-b9c6-4383ba0b6326@app.fastmail.com>
 <Y+jCSx0RW1zL7Wk5@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+jCSx0RW1zL7Wk5@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Vincent,

On Sun, Feb 12, 2023 at 11:41:15AM +0100, Willy Tarreau wrote:
> Hi Vincent,
> 
> On Fri, Feb 10, 2023 at 08:03:02AM -0500, Vincent Dagonneau wrote:
> > > Thanks Vincent. At first glance it looks good. I'll give it a try on
> > > all supported archs to make sure we didn't overlook anything and we'll
> > > merge it. One tiny comment though, look below:
> > >
> > >> Vincent Dagonneau (4):
> > >>   tools/nolibc: Adding stdint.h
> > >>   tools/nolibc: Adding integer types and integer limit macros
> > >>   tools/nolibc: Enlarging column width of tests
> > >>   tools/nolibc: Adds tests for the integer limits in stdint.h
> > >
> > > I mentioned in the first review that it's generally preferred to use
> > > the imperative form rather than present participle on subject lines.
> > > This would give:
> > >
> > >     tools/nolibc: Add stdint.h
> > >     tools/nolibc: Add integer types and integer limit macros
> > >     tools/nolibc: Enlarge column width of tests
> > >     tools/nolibc: Add tests for the integer limits in stdint.h
> > >
> > > I can perform this trivial change locally before merging without asking
> > > you to respin a series just for this if that's OK for you. Just let me
> > > know.
> > >
> > > Thanks!
> > > Willy
> > 
> > Yep, go ahead!
> 
> Done, however I'm seeing the following failures on aarch64/riscv64/s390x:
> 
>   $ grep -B 200 limit.*FAIL stdint.out |  grep '\(limit.*FAIL\|gcc-11.3.0-nolibc.*-O0\)' 
>   /f/tc/nolibc/gcc-11.3.0-nolibc/aarch64*/bin/aarch64*-gcc -g  -O0 -g -o nolibc-test \
>   100 limit_intptr_min = -2147483648                              [FAIL]
>   103 limit_ptrdiff_min = -2147483648                             [FAIL]
>   105 limit_ptrdiff_min = -2147483648                             [FAIL]
>   /f/tc/nolibc/gcc-11.3.0-nolibc/riscv64*/bin/riscv64*-gcc -g  -O0 -g -o nolibc-test \
>   100 limit_intptr_min = -2147483648                              [FAIL]
>   103 limit_ptrdiff_min = -2147483648                             [FAIL]
>   105 limit_ptrdiff_min = -2147483648                             [FAIL]
>   /f/tc/nolibc/gcc-11.3.0-nolibc/s390*/bin/s390*-gcc -g -march=z10 -m64 -O0 -g -o nolibc-test \
>   100 limit_intptr_min = -2147483648                              [FAIL]
>   103 limit_ptrdiff_min = -2147483648                             [FAIL]
>   105 limit_ptrdiff_min = -2147483648                             [FAIL]
> 
> It makes me think that the __WORDSIZE==64 condition didn't match there,
> I'm investigating. However while looking at this I noticed a mistake in
> your patch: in the 32-bit part, limit_ptrdiff_{min,max} were repeated,
> and no least64_{min,max} tests were placed, so I sense a copy-paste
> mistake though I'm uncertain about the initial intent. If you just want
> me to drop the duplicate lines I can easily do it, just let me know. I'll
> be back with more info once I figure the reason for these archs not using
> __WORDSIZE==64.
> 
> #if __WORDSIZE == 64
>                 CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
>                 CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
>                 CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
>                 CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
>                 CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
>                 CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
>                 CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
>                 CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
>                 CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffffffffffULL); break;
> #else
>                 CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
>                 CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
>                 CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
>                 CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
>                 CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
>                 CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
>                 CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
>                 CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffU); break;
> #endif /* __WORDSIZE == 64 */

So after investigation, __WORDSIZE is not defined, hence the failures!
It proves the importance of the tests you've added ;-)

However we have the size of these types defined by the compiler itself
at least since gcc-4.4 and clang-3.8 which are the oldest I could test:

  $ mips-gcc44_glibc214-linux-gnu-gcc -xc -dM -E - </dev/null |grep SIZE
  #define __SIZEOF_POINTER__ 4
  #define __SIZEOF_LONG__ 4
  #define __SIZEOF_LONG_DOUBLE__ 8
  #define __SIZEOF_SIZE_T__ 4
  #define __SIZEOF_WINT_T__ 4
  #define __SIZE_TYPE__ unsigned int
  #define __SIZEOF_PTRDIFF_T__ 4
  #define __SIZEOF_INT__ 4
  #define __SIZEOF_FLOAT__ 4
  #define __SIZEOF_SHORT__ 2
  #define __SIZEOF_WCHAR_T__ 4
  #define __SIZEOF_DOUBLE__ 8
  #define __SIZEOF_LONG_LONG__ 8

In addition both provide __SIZE_TYPE__ which is defined either as
unsigned int or long unsigned int, so that can simplify quite some
parts (and other types are defined for other types in more recent
versions). Both also define __LONG_MAX__ that you could possibly
use to conveniently create INTPTR_MAX, INTPTR_MIN, UINTPTR_MAX and
so on.

And finally we should set the __WORDSIZE ourselves as 8*__SIZEOF_LONG__
and that would do the job.

I tested the following patch which passes all the tests successfully
on all supported archs. Let me know if you agree with such a change
and how you want us to proceed. It would require a small change in the
commit message though, to explain that our pointers are the size of a
long on supported platforms.

Regards,
Willy

---

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 6a7683de09ec..7da0d35c481c 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -65,20 +65,12 @@ typedef uint64_t          uintmax_t;
 #define UINT_LEAST32_MAX UINT32_MAX
 #define UINT_LEAST64_MAX UINT64_MAX
 
-#if __WORDSIZE == 64
-  #define         SIZE_MAX  UINT64_MAX
-  #define       INTPTR_MIN  INT64_MIN
-  #define       INTPTR_MAX  INT64_MAX
-  #define      UINTPTR_MAX  UINT64_MAX
-  #define      PTRDIFF_MIN  INT64_MIN
-  #define      PTRDIFF_MAX  INT64_MAX
-#else
-  #define         SIZE_MAX  UINT32_MAX
-  #define       INTPTR_MIN  INT32_MIN
-  #define       INTPTR_MAX  INT32_MAX
-  #define      UINTPTR_MAX  UINT32_MAX
-  #define      PTRDIFF_MIN  INT32_MIN
-  #define      PTRDIFF_MAX  INT32_MAX
-#endif /* __WORDSIZE == 64 */
+#define SIZE_MAX         ((__SIZE_TYPE__)(__LONG_MAX__) * 2 + 1)
+#define INTPTR_MIN       (-__LONG_MAX__ - 1)
+#define INTPTR_MAX       __LONG_MAX__
+#define UINTPTR_MAX      (SIZE_MAX)
+#define PTRDIFF_MIN      INTPTR_MIN
+#define PTRDIFF_MAX      INTPTR_MAX
+#define __WORDSIZE       (__SIZEOF_LONG__ * 8)
 
 #endif /* _NOLIBC_STDINT_H */

