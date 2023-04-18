Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D366E5A47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjDRHTA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 03:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDRHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:18:58 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96401FFF;
        Tue, 18 Apr 2023 00:18:56 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pofc2-002QcH-GH; Tue, 18 Apr 2023 09:18:50 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pofc2-0011uS-1N; Tue, 18 Apr 2023 09:18:50 +0200
Message-ID: <f72a4fd778eb34487860bae8b597c827e4270061.camel@physik.fu-berlin.de>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org
Date:   Tue, 18 Apr 2023 09:18:47 +0200
In-Reply-To: <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
         <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
         <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Tue, 2023-04-18 at 09:14 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Tue, Apr 18, 2023 at 8:36 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > Thanks for your patch. The changes look good to me. However, I have
> > one question, see below.
> > 
> > On Sun, 2023-04-16 at 21:05 +0200, Christophe JAILLET wrote:
> > > Using the bitmap API is less verbose than hand writing them.
> > > It also improves the semantic.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> > > --- a/arch/sh/kernel/cpu/sh4/sq.c
> > > +++ b/arch/sh/kernel/cpu/sh4/sq.c
> > > @@ -372,7 +372,6 @@ static struct subsys_interface sq_interface = {
> > >  static int __init sq_api_init(void)
> > >  {
> > >       unsigned int nr_pages = 0x04000000 >> PAGE_SHIFT;
> > > -     unsigned int size = (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
> > >       int ret = -ENOMEM;
> > > 
> > >       printk(KERN_NOTICE "sq: Registering store queue API.\n");
> > > @@ -382,7 +381,7 @@ static int __init sq_api_init(void)
> > >       if (unlikely(!sq_cache))
> > >               return ret;
> > > 
> > > -     sq_bitmap = kzalloc(size, GFP_KERNEL);
> > > +     sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
> > >       if (unlikely(!sq_bitmap))
> > >               goto out;
> > > 
> > 
> > I have look through other patches where k{z,c,m}alloc() were replaced with
> > bitmap_zalloc() and I noticed that in the other cases such as [1], kcalloc()
> > was used instead of kzalloc() in our cases with the element size set to
> > sizeof(long) while kzalloc() is using an element size equal to a byte.
> > 
> > Wouldn't that mean that the current code in sq is allocating a buffer that is
> > too small by a factor of 1/sizeof(long) or am I missing something?
> > 
> > @Geert: Do you have any idea?
> 
> Nice catch!
> 
> Looking more deeply at the code, the intention is to allocate a bitmap
> with nr_pages bits, so the code fater Christophe's patch is correct.
> However, the old code is indeed wrong:
> 
>     (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG
> 
> The aim is to calculate the size in bytes, rounded up to an integral
> number of longs, but it lacks a final multiplication by BITS_PER_BYTE,
> so it's off by a factor of 4.

Yeah, that's what I understood from reading the code which is why I was
wondering why the factor was missing.

> Fixes: d7c30c682a278abe ("sh: Store Queue API rework.")
> 
> As we didn't have bitmap_zalloc() until commit c42b65e363ce97a8
> ("bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()")
> in v4.19, it would be good to fix the bug first in a separate patch,
> not using

I agree. Do you want to send a patch I can review?

> BTW, interesting how this got missed when fixing the other out-of-range
> bug in commit 9f650cf2b811cfb6 ("sh: Fix store queue bitmap end.",
> s/marc.theaimsgroup.com/marc.info/ when following the link).

Yeah.

PS: Sorry for the slightly messy grammar in my previous mail, didn't have
    a coffee yet that early in the morning :-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
