Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA776E5A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDRHOw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDRHOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:14:46 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47526272C;
        Tue, 18 Apr 2023 00:14:39 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-555bc7f6746so1599347b3.6;
        Tue, 18 Apr 2023 00:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802078; x=1684394078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37Q0oq5R7kZdTKmqbM4IEE6eu7wqQKN1Cf4j4F2SLq8=;
        b=iaDMC2IZj0Ttbqo9seMcf8A1j7TyB9VDhiSCo1dW5mYDyZW+lcWJeOuSc3bURQr57n
         lDNxzMa4xAJoslVkL4NqQ31XTLOI6GL7vhV9Kf/EOrPMn0r++as6/APK3pLLgcjYwpr4
         3QDtT+gZ0lOn56yXVFAg2T95FZclMnk57vK/9Xiwi8wRfRvhCFFzDEbvog+nzz60DKFL
         bUCpCN5X3169LtfclMw9vs9BCa7XAYvQTqJfJIOn5DwNKQHAYfyGn2E2LIbfUDQAmekk
         w3XI/Qi2KiUs4tvN3KR979iaa+d5Ucmgyce/JL+K9lD7k9seKpQ1F4L5+lJKhebqG+16
         7eeA==
X-Gm-Message-State: AAQBX9dkg01YXt4CFauSndnF/9+P+vdQbVRBRckMnBKz351ofurxjzFZ
        qFKhmeI3imNMEqnQzkUWpbQqIzWGEHa+LQ==
X-Google-Smtp-Source: AKy350aNEaaaMwDzkbZlq1GInqpt1giJVNkbUQdfWHauXpjeUrlxxfo8hZjErVDtg6oTdX5fNx5UTw==
X-Received: by 2002:a0d:d8d8:0:b0:54e:ac2b:8a8c with SMTP id a207-20020a0dd8d8000000b0054eac2b8a8cmr17176350ywe.24.1681802078162;
        Tue, 18 Apr 2023 00:14:38 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bh7-20020a05690c038700b00545c373f7c0sm3114024ywb.139.2023.04.18.00.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:14:37 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-552ae3e2cbeso74111397b3.13;
        Tue, 18 Apr 2023 00:14:37 -0700 (PDT)
X-Received: by 2002:a81:78f:0:b0:54f:af2e:d7c1 with SMTP id
 137-20020a81078f000000b0054faf2ed7c1mr20948607ywh.11.1681802077517; Tue, 18
 Apr 2023 00:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
 <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
In-Reply-To: <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Apr 2023 09:14:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
Message-ID: <CAMuHMdWz7YJ4ifkxU2GGdoj46fTsjS5WE66R0YzvOYr1ZKY=4w@mail.gmail.com>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Apr 18, 2023 at 8:36 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Thanks for your patch. The changes look good to me. However, I have
> one question, see below.
>
> On Sun, 2023-04-16 at 21:05 +0200, Christophe JAILLET wrote:
> > Using the bitmap API is less verbose than hand writing them.
> > It also improves the semantic.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> > --- a/arch/sh/kernel/cpu/sh4/sq.c
> > +++ b/arch/sh/kernel/cpu/sh4/sq.c
> > @@ -372,7 +372,6 @@ static struct subsys_interface sq_interface = {
> >  static int __init sq_api_init(void)
> >  {
> >       unsigned int nr_pages = 0x04000000 >> PAGE_SHIFT;
> > -     unsigned int size = (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
> >       int ret = -ENOMEM;
> >
> >       printk(KERN_NOTICE "sq: Registering store queue API.\n");
> > @@ -382,7 +381,7 @@ static int __init sq_api_init(void)
> >       if (unlikely(!sq_cache))
> >               return ret;
> >
> > -     sq_bitmap = kzalloc(size, GFP_KERNEL);
> > +     sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
> >       if (unlikely(!sq_bitmap))
> >               goto out;
> >
>
> I have look through other patches where k{z,c,m}alloc() were replaced with
> bitmap_zalloc() and I noticed that in the other cases such as [1], kcalloc()
> was used instead of kzalloc() in our cases with the element size set to
> sizeof(long) while kzalloc() is using an element size equal to a byte.
>
> Wouldn't that mean that the current code in sq is allocating a buffer that is
> too small by a factor of 1/sizeof(long) or am I missing something?
>
> @Geert: Do you have any idea?

Nice catch!

Looking more deeply at the code, the intention is to allocate a bitmap
with nr_pages bits, so the code fater Christophe's patch is correct.
However, the old code is indeed wrong:

    (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG

The aim is to calculate the size in bytes, rounded up to an integral
number of longs, but it lacks a final multiplication by BITS_PER_BYTE,
so it's off by a factor of 4.

Fixes: d7c30c682a278abe ("sh: Store Queue API rework.")

As we didn't have bitmap_zalloc() until commit c42b65e363ce97a8
("bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()")
in v4.19, it would be good to fix the bug first in a separate patch,
not using

BTW, interesting how this got missed when fixing the other out-of-range
bug in commit 9f650cf2b811cfb6 ("sh: Fix store queue bitmap end.",
s/marc.theaimsgroup.com/marc.info/ when following the link).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
