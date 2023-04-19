Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B76E83AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjDSVZm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjDSVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:39 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C6974B;
        Wed, 19 Apr 2023 14:25:12 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ppFIV-003hnW-FK; Wed, 19 Apr 2023 23:25:03 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ppFIV-0002on-88; Wed, 19 Apr 2023 23:25:03 +0200
Message-ID: <149653ffbfa13e508777214174341f9c1263a487.camel@physik.fu-berlin.de>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org
Date:   Wed, 19 Apr 2023 23:25:01 +0200
In-Reply-To: <d2b2baca-589d-83ef-04b0-0f64b18f9d95@wanadoo.fr>
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
         <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
         <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
         <d2b2baca-589d-83ef-04b0-0f64b18f9d95@wanadoo.fr>
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

Hi Christophe!

On Tue, 2023-04-18 at 20:05 +0200, Christophe JAILLET wrote:
> Le 18/04/2023 à 09:14, Geert Uytterhoeven a écrit :
> > 
> > Nice catch!
> > 
> > Looking more deeply at the code, the intention is to allocate a bitmap
> > with nr_pages bits, so the code fater Christophe's patch is correct.
> > However, the old code is indeed wrong:
> > 
> >      (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG
> > 
> > The aim is to calculate the size in bytes, rounded up to an integral
> > number of longs, but it lacks a final multiplication by BITS_PER_BYTE,
> > so it's off by a factor of 4.
> > 
> > Fixes: d7c30c682a278abe ("sh: Store Queue API rework.")
> > 
> > As we didn't have bitmap_zalloc() until commit c42b65e363ce97a8
> > ("bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()")
> > in v4.19, it would be good to fix the bug first in a separate patch,
> > not using
> > 
> > BTW, interesting how this got missed when fixing the other out-of-range
> > bug in commit 9f650cf2b811cfb6 ("sh: Fix store queue bitmap end.",
> > s/marc.theaimsgroup.com/marc.info/ when following the link).
> 
> So, this means that this got unnoticed for 16 years?
> Waouh!
> 
> I would never have thought that a "trivial" clean-up that I took time to 
> repost could trigger such a thing!

I have fixed the original bug in my for-next branch [1] now. Would you mind
rebasing your patch on top of that branch and resend it?

The reason why we're doing this is because we want to be able to backport the
fix to older kernel versions such as 4.14 which don't have the bitmap API yet.

Thanks,
Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git/log/?h=for-next

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
