Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6A69C219
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 20:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBSTPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 14:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjBSTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 14:15:21 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75BD3FF0D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 11:15:20 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31JJFGsE007217;
        Sun, 19 Feb 2023 20:15:16 +0100
Date:   Sun, 19 Feb 2023 20:15:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Vincent Dagonneau <v@vda.io>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] tools/nolibc: add tests for the integer limits
 in stdint.h
Message-ID: <Y/J1RB1T4tFeBxgs@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
 <20230219185133.14576-5-w@1wt.eu>
 <c549eaa8-02c4-4ca5-9ad9-6b713e183609@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c549eaa8-02c4-4ca5-9ad9-6b713e183609@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Feb 19, 2023 at 07:04:04PM +0000, Thomas Weißschuh wrote:
> > +#elif __SIZEOF_LONG__ == 4
> > +		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
> > +		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
> > +		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
> > +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
> > +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
> > +		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
> > +		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
> 
> ptrdiff tests are duplicate.

Argh, I thought I had already removed these duplicates, I noticed them
previously indeed. Vincent, please address this in your next iteration.

> > +		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffU); break;
> > +#else
> > +# warning "__SIZEOF_LONG__ is undefined"
> 
> Why not #error?

It's just a matter of choice. Since the tool's goal is to spot errors,
and if possible several at once, I find it preferable to still not fail
on other tests, as often when you get multiple failures it's easier to
figure what's going on. During the last test session I precisely had a
build error that was quite annoying because once I managed to fix it I
figured the fix was not the right one regarding other places.

Alternately we could probably just add one line that always reports a
failure like the other ones (it would be even better so that we can
compare all outputs and still know that something fails):

 +#else
 +		CASE_TEST(__SIZEOF_LONG__defined);  EXPECT_EQ(1, 1, 0); break;

> > +#endif /* __WORDSIZE == 64 */
> 
> #endif comment is now incorrect

Good catch indeed!
> 
> > +			case __LINE__:
> 
> The "case" should be further left, no?

You're right!

Thank you!
Willy
