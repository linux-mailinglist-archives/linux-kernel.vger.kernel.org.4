Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F86936E1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 11:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBLKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 05:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 05:41:24 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B4D10436
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 02:41:21 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31CAfF2V003442;
        Sun, 12 Feb 2023 11:41:15 +0100
Date:   Sun, 12 Feb 2023 11:41:15 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y+jCSx0RW1zL7Wk5@1wt.eu>
References: <20230209024044.13127-1-v@vda.io>
 <Y+RrySeoRJn9GbrI@1wt.eu>
 <38f0c544-cc4c-4e21-b9c6-4383ba0b6326@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f0c544-cc4c-4e21-b9c6-4383ba0b6326@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Feb 10, 2023 at 08:03:02AM -0500, Vincent Dagonneau wrote:
> > Thanks Vincent. At first glance it looks good. I'll give it a try on
> > all supported archs to make sure we didn't overlook anything and we'll
> > merge it. One tiny comment though, look below:
> >
> >> Vincent Dagonneau (4):
> >>   tools/nolibc: Adding stdint.h
> >>   tools/nolibc: Adding integer types and integer limit macros
> >>   tools/nolibc: Enlarging column width of tests
> >>   tools/nolibc: Adds tests for the integer limits in stdint.h
> >
> > I mentioned in the first review that it's generally preferred to use
> > the imperative form rather than present participle on subject lines.
> > This would give:
> >
> >     tools/nolibc: Add stdint.h
> >     tools/nolibc: Add integer types and integer limit macros
> >     tools/nolibc: Enlarge column width of tests
> >     tools/nolibc: Add tests for the integer limits in stdint.h
> >
> > I can perform this trivial change locally before merging without asking
> > you to respin a series just for this if that's OK for you. Just let me
> > know.
> >
> > Thanks!
> > Willy
> 
> Yep, go ahead!

Done, however I'm seeing the following failures on aarch64/riscv64/s390x:

  $ grep -B 200 limit.*FAIL stdint.out |  grep '\(limit.*FAIL\|gcc-11.3.0-nolibc.*-O0\)' 
  /f/tc/nolibc/gcc-11.3.0-nolibc/aarch64*/bin/aarch64*-gcc -g  -O0 -g -o nolibc-test \
  100 limit_intptr_min = -2147483648                              [FAIL]
  103 limit_ptrdiff_min = -2147483648                             [FAIL]
  105 limit_ptrdiff_min = -2147483648                             [FAIL]
  /f/tc/nolibc/gcc-11.3.0-nolibc/riscv64*/bin/riscv64*-gcc -g  -O0 -g -o nolibc-test \
  100 limit_intptr_min = -2147483648                              [FAIL]
  103 limit_ptrdiff_min = -2147483648                             [FAIL]
  105 limit_ptrdiff_min = -2147483648                             [FAIL]
  /f/tc/nolibc/gcc-11.3.0-nolibc/s390*/bin/s390*-gcc -g -march=z10 -m64 -O0 -g -o nolibc-test \
  100 limit_intptr_min = -2147483648                              [FAIL]
  103 limit_ptrdiff_min = -2147483648                             [FAIL]
  105 limit_ptrdiff_min = -2147483648                             [FAIL]

It makes me think that the __WORDSIZE==64 condition didn't match there,
I'm investigating. However while looking at this I noticed a mistake in
your patch: in the 32-bit part, limit_ptrdiff_{min,max} were repeated,
and no least64_{min,max} tests were placed, so I sense a copy-paste
mistake though I'm uncertain about the initial intent. If you just want
me to drop the duplicate lines I can easily do it, just let me know. I'll
be back with more info once I figure the reason for these archs not using
__WORDSIZE==64.

#if __WORDSIZE == 64
                CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
                CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
                CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
                CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
                CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
                CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
                CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
                CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
                CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffffffffffULL); break;
#else
                CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
                CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
                CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
                CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
                CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
                CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
                CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
                CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffU); break;
#endif /* __WORDSIZE == 64 */

Regards,
Willy
