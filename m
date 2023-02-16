Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879EA698B30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBPD34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPD3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:29:54 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D94DC28865
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:29:51 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31G3Tl47011916;
        Thu, 16 Feb 2023 04:29:47 +0100
Date:   Thu, 16 Feb 2023 04:29:47 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y+2jK3yyLx+0cPr9@1wt.eu>
References: <20230209024044.13127-1-v@vda.io>
 <Y+RrySeoRJn9GbrI@1wt.eu>
 <38f0c544-cc4c-4e21-b9c6-4383ba0b6326@app.fastmail.com>
 <Y+jCSx0RW1zL7Wk5@1wt.eu>
 <Y+kvmy/5oK9trrDH@1wt.eu>
 <d89977ec-d8a8-4ffe-8e3e-a77885ff5f96@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89977ec-d8a8-4ffe-8e3e-a77885ff5f96@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, Feb 15, 2023 at 07:11:09PM -0500, Vincent Dagonneau wrote:
> > So after investigation, __WORDSIZE is not defined, hence the failures!
> > It proves the importance of the tests you've added ;-)
> >
> > However we have the size of these types defined by the compiler itself
> > at least since gcc-4.4 and clang-3.8 which are the oldest I could test:
> >
> >   $ mips-gcc44_glibc214-linux-gnu-gcc -xc -dM -E - </dev/null |grep SIZE
> >   #define __SIZEOF_POINTER__ 4
> >   #define __SIZEOF_LONG__ 4
> >   #define __SIZEOF_LONG_DOUBLE__ 8
> >   #define __SIZEOF_SIZE_T__ 4
> >   #define __SIZEOF_WINT_T__ 4
> >   #define __SIZE_TYPE__ unsigned int
> >   #define __SIZEOF_PTRDIFF_T__ 4
> >   #define __SIZEOF_INT__ 4
> >   #define __SIZEOF_FLOAT__ 4
> >   #define __SIZEOF_SHORT__ 2
> >   #define __SIZEOF_WCHAR_T__ 4
> >   #define __SIZEOF_DOUBLE__ 8
> >   #define __SIZEOF_LONG_LONG__ 8
> >
> > In addition both provide __SIZE_TYPE__ which is defined either as
> > unsigned int or long unsigned int, so that can simplify quite some
> > parts (and other types are defined for other types in more recent
> > versions). Both also define __LONG_MAX__ that you could possibly
> > use to conveniently create INTPTR_MAX, INTPTR_MIN, UINTPTR_MAX and
> > so on.
> >
> 
> Mmmh, interesting, I hadn't thought about verifying what defined the
> __WORDSIZE. I assumed wrongly that it was set by standard but it seems not. 

No problem, that's exactly why I wanted to retry every combination.

> I replicated your example on my machine to see the intersection of what is
> defined by both GCC and clang. Do you know if we would need to check any
> other compilers?

I don't think it's particularly needed to go further for now. For example
I know that tcc doesn't support some of the asm constraints that we use
in register alllocation. Supporting the most commonly encountered
compilers is sufficient for our use case.

> > And finally we should set the __WORDSIZE ourselves as 8*__SIZEOF_LONG__
> > and that would do the job.
> >
> > I tested the following patch which passes all the tests successfully
> > on all supported archs. Let me know if you agree with such a change
> > and how you want us to proceed. It would require a small change in the
> > commit message though, to explain that our pointers are the size of a
> > long on supported platforms.
> >
> 
> I can integrate the changes and write an explanation as a commit message and
> submit a new version tomorrow, would that work for you?

Sure that would be great! I'll look at it this week-end anyway.

Thank you!
Willy
