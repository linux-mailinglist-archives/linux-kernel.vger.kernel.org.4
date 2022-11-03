Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82D6176C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKCGbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCGbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:31:53 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDF51A396;
        Wed,  2 Nov 2022 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8l0CQTM9ypXNWiw0zCbDPA1te+kKB1KXHppBD2iO0Sw=;
  b=K90GIjx5EFgDXEMSv5IMsuP3RcoiGN24rxzUEBGw1ap0xF2ts9jq5mob
   bHsykEiLyZLvCkLiQjw747PTIralmTLN3wiaPTTl4a337XdLjSwHG0yNN
   lSy0AC9O4+Pbk/WbOV9P4Xk+SnIDR0BrooRTaV4dhf1E09U2lsTElX2Ch
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="36318700"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 07:31:48 +0100
Date:   Thu, 3 Nov 2022 07:31:47 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Kees Cook <keescook@chromium.org>, cocci@inria.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
In-Reply-To: <Y2MGlTwh9aB+4z4l@zx2c4.com>
Message-ID: <alpine.DEB.2.22.394.2211030726351.2877@hadrien>
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain> <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com> <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com> <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com> <202210201151.ECC19BC97A@keescook> <Y1iSYddi3BpP8gvf@zx2c4.com> <Y1ku+jfRAyezq6Nz@zx2c4.com> <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2022, Jason A. Donenfeld wrote:

> On Wed, Nov 02, 2022 at 06:17:04PM +0100, Julia Lawall wrote:
> >
> >
> > On Wed, 26 Oct 2022, Jason A. Donenfeld wrote:
> >
> > > On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> > > > The traditional objdump comparison does work, though. It produces a good
> > >
> > > Another thing that appears to work well is just using Coccinelle
> > > scripts. I've had some success just scrolling through the results of:
> > >
> > >     @@
> > >     char c;
> > >     expression E;
> > >     @@
> > >     (
> > >     * E > c
> > >     |
> > >     * E >= c
> > >     |
> > >     * E < c
> > >     |
> > >     * E <= c
> > >     )
> > >
> > > That also triggers on explicitly signed chars, and examining those
> > > reveals that quite a bit of code in the tree already does do the right
> > > thing, which is good.
> > >
> > > From looking at this and objdump output, it looks like most naked-char
> > > usage that isn't for strings is actually already assuming it's unsigned,
> > > using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
> > > things here and there, but all and all, I don't think this is looking as
> > > terrible as I initially feared.
> > >
> > > I'm CC'ing the Coccinelle people to see if they have any nice ideas on
> > > improvements. Specifically, the thing we're trying to identify is:
> > >
> > >   - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
> > >     where:
> >
> > Try putting
> >
> > disable optional_qualifier
> >
> > between the initial @@, to avoid the implicit matching of signed and
> > unsigned.
>
> Hmm, this doesn't quite work. Here are my rules:
>
>     @disable optional_qualifier@
>     char c;
>     expression E;
>     @@
>     (
>     * E > c
>     |
>     * E >= c
>     |
>     * E < c
>     |
>     * E <= c
>     )
>
>     @disable optional_qualifier@
>     char c;
>     @@
>     * c == -1
>
>     @disable optional_qualifier@
>     char c;
>     @@
>     * c = -1
>
> This produces, for example:
>
> diff -u -p ./sound/firewire/bebob/bebob_focusrite.c /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
> --- ./sound/firewire/bebob/bebob_focusrite.c
> +++ /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
> @@ -192,7 +192,6 @@ saffirepro_both_clk_src_get(struct snd_b
>
>         /* In a case that this driver cannot handle the value of register. */
>         value &= SAFFIREPRO_CLOCK_SOURCE_SELECT_MASK;
> -       if (value >= SAFFIREPRO_CLOCK_SOURCE_COUNT || map[value] < 0) {
>                 err = -EIO;
>                 goto end;
>         }
>
> Except map is defined as:
>
>     const signed char *map;
>
> So this would be one of those cases that I had hoped `disable
> optional_qualifier` would exclude. (I think internally coccinelle might
> be assuming `char` is signed, by the way.)

OK, I see the problem.  Coccinelle isn't taking the "disable
optional_qualifier" into account when it checks types on expressions.  It
would work if you put, eg:

char x;
... when any
* x < 0

But that would be much slower and less general.  I will fix it.

>
> > >   - It's not being used for characters; and
> > >   - It's doing something that assumes it is signed, such as various
> > >     types of comparisons or decrements.
> >
> > I took a quick look at the article, but I'm not completely sure what you
> > are getting at here.  Could you give some examples of what you do and
> > don't want to find?
> >
> > You don't want the case where c is 'x', for some x?
>
> Something I would want to find is `if (c < 0)`. Something I wouldn't
> want to find is `if (c < '9')`. IOW, I'm looking for code that assumes
> `c` is signed, and would become incorrect if `c` suddenly became
> unsigned. Most things involving actual characters are fine. But most
> things involving signed arithmetic or comparisons with numbers isn't
> find.

This seems to do what you want:

@disable optional_qualifier@
constant char cc;
expression e;
char c;
@@

(
  c < cc
|
* c < e
)

It highlights only the two return lines in:

int main () {
        char x;
        if (x < 'd')
                return x < 0;
        else return x < y;
}


julia

>
> Jason
>
