Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72161733A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKCAJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKCAJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:09:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A398644F;
        Wed,  2 Nov 2022 17:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B8E5CE2264;
        Thu,  3 Nov 2022 00:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5CBC433C1;
        Thu,  3 Nov 2022 00:09:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jaKDOqOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667434142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ss+0UcaTi7dI1wdBpT9CwV3xqKbtQHsvn2bTvMdYCP0=;
        b=jaKDOqOsj/DStmNwdcX2gNqr1/GhYThy6Bvl8kXjWExekVntgasP+YDqgK4auFtBM4erc/
        3i0K+miw/+Lu6ZjdAF2NH5u2d0z1x2pAPZncc96XLS3Rsbs272vyr4Shokn4+igoBPxkCo
        4g+G7+eHRqxxwRB0LiiBWh3K0YdXlj8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c1601152 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 00:09:02 +0000 (UTC)
Date:   Thu, 3 Nov 2022 01:08:53 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kees Cook <keescook@chromium.org>, cocci@inria.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y2MGlTwh9aB+4z4l@zx2c4.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com>
 <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:17:04PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 26 Oct 2022, Jason A. Donenfeld wrote:
> 
> > On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> > > The traditional objdump comparison does work, though. It produces a good
> >
> > Another thing that appears to work well is just using Coccinelle
> > scripts. I've had some success just scrolling through the results of:
> >
> >     @@
> >     char c;
> >     expression E;
> >     @@
> >     (
> >     * E > c
> >     |
> >     * E >= c
> >     |
> >     * E < c
> >     |
> >     * E <= c
> >     )
> >
> > That also triggers on explicitly signed chars, and examining those
> > reveals that quite a bit of code in the tree already does do the right
> > thing, which is good.
> >
> > From looking at this and objdump output, it looks like most naked-char
> > usage that isn't for strings is actually already assuming it's unsigned,
> > using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
> > things here and there, but all and all, I don't think this is looking as
> > terrible as I initially feared.
> >
> > I'm CC'ing the Coccinelle people to see if they have any nice ideas on
> > improvements. Specifically, the thing we're trying to identify is:
> >
> >   - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
> >     where:
> 
> Try putting
> 
> disable optional_qualifier
> 
> between the initial @@, to avoid the implicit matching of signed and
> unsigned.

Hmm, this doesn't quite work. Here are my rules:

    @disable optional_qualifier@
    char c;
    expression E;
    @@
    (
    * E > c
    |
    * E >= c
    |
    * E < c
    |
    * E <= c
    )
    
    @disable optional_qualifier@
    char c;
    @@
    * c == -1
    
    @disable optional_qualifier@
    char c;
    @@
    * c = -1

This produces, for example:

diff -u -p ./sound/firewire/bebob/bebob_focusrite.c /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
--- ./sound/firewire/bebob/bebob_focusrite.c
+++ /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
@@ -192,7 +192,6 @@ saffirepro_both_clk_src_get(struct snd_b

        /* In a case that this driver cannot handle the value of register. */
        value &= SAFFIREPRO_CLOCK_SOURCE_SELECT_MASK;
-       if (value >= SAFFIREPRO_CLOCK_SOURCE_COUNT || map[value] < 0) {
                err = -EIO;
                goto end;
        }

Except map is defined as:

    const signed char *map;

So this would be one of those cases that I had hoped `disable
optional_qualifier` would exclude. (I think internally coccinelle might
be assuming `char` is signed, by the way.)

> >   - It's not being used for characters; and
> >   - It's doing something that assumes it is signed, such as various
> >     types of comparisons or decrements.
> 
> I took a quick look at the article, but I'm not completely sure what you
> are getting at here.  Could you give some examples of what you do and
> don't want to find?
> 
> You don't want the case where c is 'x', for some x?

Something I would want to find is `if (c < 0)`. Something I wouldn't
want to find is `if (c < '9')`. IOW, I'm looking for code that assumes
`c` is signed, and would become incorrect if `c` suddenly became
unsigned. Most things involving actual characters are fine. But most
things involving signed arithmetic or comparisons with numbers isn't
find.

Jason
