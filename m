Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564A6B22CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCILZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCILZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:25:12 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE3F367C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:21:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y11so1628031plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1678360891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaCiOLBaUQCB6rPGv3z9wu2mPDg4Zl36GLz0U5k8XAQ=;
        b=eDDQMBf8YA43UxlopRAOf1Lt0xoeswoZXIRNdiKpC0jovisfhAA0T9565Sn2JRNwY0
         pvpQgXxKitI/yZ6QLux2RE2Hhj0GfTrGz2PYOxjxhGh1sizozfdkj9/A2mrCzwUP2FYl
         UxQlHJVg8j+0r/eN0uk1sYPH5Zbw/UKvHQRGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678360891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaCiOLBaUQCB6rPGv3z9wu2mPDg4Zl36GLz0U5k8XAQ=;
        b=e6O251FNxHIhNplyRTUSOZ3Xqn7giVJx8Ru6zU8O+BOTGjC3VG8L3iuUeRIrsoOysB
         ZccGda+5ZuO6ruQ5UCMoZIdVBeMcHIc8DjZKr5P+DRRUmMgxUrA9+KzuKtVTObh3fVgw
         khY6xuJGWFrf+dkkFWlVa40Yr54T2LUUe9ltoZlp6N0LrduVLl7yTA1BSdEP/Tomcbci
         C6HoMPD/nr+wD6GQr++mTrRsr7bTnywgQkM7C3jSe/bOl6gzlfVqRoCKJfrhxh78hDw7
         8Ad4jPQP6IA/1nNrh4zWjM/mlfAG9HKeXIAOMktDu5SvmFWOEx0JijVe0vlShmf4Wb8E
         Bbsw==
X-Gm-Message-State: AO0yUKWrbBcI3/ZAR87EcIIylUBuEL0ITvW5nj4ygdD416hoeFtQMFCc
        H0LFhGUf+vp20HIdn862ByrkRPQLNzpVbSf+YlkJ1Q==
X-Google-Smtp-Source: AK7set+CuIIqqJROsYxcY7Tk1FGy3KI4MAQNFEaxBD6fKKyxioLzKZ0vb809U2RO6bCc/jCNZK7EeIMf4RiDS1WCnzA=
X-Received: by 2002:a17:90a:8a82:b0:234:b4ad:d598 with SMTP id
 x2-20020a17090a8a8200b00234b4add598mr7996136pjn.7.1678360890807; Thu, 09 Mar
 2023 03:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com> <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
 <ZAdOgUdqwLpUyPlc@redhat.com> <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
 <CALrw=nFrbWF2ZhQtK9gx5ZFHK4Cd9outwEQqByJgmb7ryOoCgA@mail.gmail.com> <ZAjfu0R7rv45J3Dr@redhat.com>
In-Reply-To: <ZAjfu0R7rv45J3Dr@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 9 Mar 2023 11:21:19 +0000
Message-ID: <CALrw=nG5Q_5i6eMbyt0_ZemT+EGgYpSDAg5-tUPC+SmxrPkNUQ@mail.gmail.com>
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, mpatocka@redhat.com, houtao1@huawei.com,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:19=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> wr=
ote:
>
> On Wed, Mar 08 2023 at  8:55P -0500,
> Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> > On Wed, Mar 8, 2023 at 2:56=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > On 3/7/2023 10:47 PM, Mike Snitzer wrote:
> > > > On Mon, Mar 06 2023 at  9:12P -0500,
> > > > Hou Tao <houtao@huaweicloud.com> wrote:
> > > >
> > > >> Hi,
> > > >>
> > > >> On 3/7/2023 3:31 AM, Mike Snitzer wrote:
> > > >>> On Mon, Mar 06 2023 at  8:49P -0500,
> > > >>> Hou Tao <houtao@huaweicloud.com> wrote:
> > > >>>
> > > >>>> From: Hou Tao <houtao1@huawei.com>
> > > >>>>
> > > >>>> When neither no_read_workqueue nor no_write_workqueue are enable=
d,
> > > >>>> tasklet_trylock() in crypt_dec_pending() may still return false =
due to
> > > >>>> an uninitialized state, and dm-crypt will do io completion in io=
_queue
> > > >>>> instead of current context unnecessarily.
> > > >>> Have you actually experienced this?
> > > >> Yes. I had written a bpftrace script to check the completion conte=
xt of
> > > >> blkdev_bio_end_io_simple() when doing direct io read on dm-crypt d=
evice. The
> > > >> expected context should be unbound workers of crypt_queue, but som=
etimes the
> > > >> context is the bound worker of io_queue.
> > > > OK, thanks for clarifying.  Curious to know the circumstance (I
> > > > thought per-bio-data is zero'd -- but it may be I'm mistaken).
> > > The circumstance is just a normal qemu VM running the vanilla kernel =
for test
> > > purpose. According to the implementation of bio_alloc_bioset(), the f=
ront pad of
> > > bio is not initialized and only bio itself is initialized. AFAIK if
> > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is enabled, per-bio-data may be zeroe=
d.
>
> OK.
>
> > > > From: Mike Snitzer <snitzer@kernel.org>
> > > > Date: Mon, 6 Mar 2023 15:58:33 -0500
> > > > Subject: [PATCH] dm crypt: conditionally enable code needed for tas=
klet usecases
> > > >
> > > > Use jump_label to limit the need for branching, and tasklet_init(),
> > > > unless either of the optional "no_read_workqueue" and/or
> > > > "no_write_workqueue" features are used.
> > > >
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  drivers/md/dm-crypt.c | 35 +++++++++++++++++++++++++++--------
> > > >  1 file changed, 27 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > > > index 641457e72603..2d0309ca07f5 100644
> > > > --- a/drivers/md/dm-crypt.c
> > > > +++ b/drivers/md/dm-crypt.c
> > > > @@ -40,6 +40,7 @@
> > > >  #include <keys/user-type.h>
> > > >  #include <keys/encrypted-type.h>
> > > >  #include <keys/trusted-type.h>
> > > > +#include <linux/jump_label.h>
> > > >
> > > >  #include <linux/device-mapper.h>
> > > >
> > > > @@ -85,6 +86,8 @@ struct dm_crypt_io {
> > > >       struct rb_node rb_node;
> > > >  } CRYPTO_MINALIGN_ATTR;
> > > >
> > > > +static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
> > > > +
> > > >  struct dm_crypt_request {
> > > >       struct convert_context *ctx;
> > > >       struct scatterlist sg_in[4];
> > > > @@ -1730,12 +1733,15 @@ static void crypt_io_init(struct dm_crypt_i=
o *io, struct crypt_config *cc,
> > > >       io->sector =3D sector;
> > > >       io->error =3D 0;
> > > >       io->ctx.r.req =3D NULL;
> > > > -     /*
> > > > -      * tasklet_init() here to ensure crypt_dec_pending()'s
> > > > -      * tasklet_trylock() doesn't incorrectly return false
> > > > -      * even when tasklet isn't in use.
> > > > -      */
> > > > -     tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned l=
ong)&io->work);
> > > > +     if (static_branch_unlikely(&use_tasklet_enabled)) {
> > > > +             /*
> > > > +              * tasklet_init() here to ensure crypt_dec_pending()'=
s
> > > > +              * tasklet_trylock() doesn't incorrectly return false
> > > > +              * even when tasklet isn't in use.
> > > > +              */
> > > > +             tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,
> > > > +                          (unsigned long)&io->work);
> > > > +     }
> > > >       io->integrity_metadata =3D NULL;
> > > >       io->integrity_metadata_from_pool =3D false;
> > > >       atomic_set(&io->io_pending, 0);
> > > > @@ -1775,6 +1781,10 @@ static void crypt_dec_pending(struct dm_cryp=
t_io *io)
> > > >               kfree(io->integrity_metadata);
> > > >
> > > >       base_bio->bi_status =3D error;
> > > > +     if (!static_branch_unlikely(&use_tasklet_enabled)) {
> > > > +             bio_endio(base_bio);
> > > > +             return;
> > > > +     }
> > > Because use_tasklet_enabled can be enabled concurrently, so I think i=
t is still
> > > possible that crypt_dec_pending will try-lock an unitialized tasklet =
if
> > > use_tasklet_enabled is enabled when invoking crypt_dec_pending().
>
> Good point, while I think it is probably acceptable given the worst
> case is punting the bio_endio to a workqueue for a time ...
>
> > Perhaps instead we can just pass an additional flag from
> > tasklet_schedule to indicate to the function that we're running in a
> > tasklet. I originally have chosen the tasklet_trylock/unlock hack to
> > avoid passing an extra flag. But unitialized memory makes sense as
> > well as the desire to avoid calling tasklet_init unconditionally. So
> > an extra member in dm_crypt_io might be the most straightforward here.
>
> ... I think we should certainly evaluate the use of an extra flag.
>
> Ignat: I'll have a look at implementing it but if you have a patch
> already developed please do share.

I don't have but it seems your latest patch is exactly what I had in mind.

> Thanks,
> Mike
