Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A86B0A33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjCHN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCHN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:57:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB7DB6F0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:55:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i10so17686329plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1678283746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXj6+ad4f3EaLBdb3iPpIYhKK3dGk1SM49tjUGgn240=;
        b=Lzhpvdix3chS5TycoH6yt9C2Q2GXv4sUMbOPL0mAQsmAuwplRPuZhGJwUPwgI0Jh+O
         vMwbmOk3+sS/mTimCDhP8WT063Q4wp3bR0fdU7h1+yU6vSWe8OpLtviHw2zTeAxU/i8K
         E2gNIxina27hs0m/lQZerYAlvPbaCbyKTpZ1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXj6+ad4f3EaLBdb3iPpIYhKK3dGk1SM49tjUGgn240=;
        b=2hj60aLjs23Y2U0dt+lMbWcqmFdF9z5skolrtD0IOODdHZScLRSH+3UH3gtJ6AgFz4
         T5hJYupjrj+0gfyOlCWByb0ty1qOmNtebXmeP4TxQ6xQSMLksBrpd2ywI+vELkFZ8O3I
         VKpwv7zs4iKZQTVcjGLlYoS0Eop715VeyjeF3Wm0nqbRH+RsSaberg+KVCy6pFk0jnL6
         Lob1A/LVs+PxsVAo97iaw/1282IZjAMNbOdyNd9hnBh5i9hts5Rpy2dAQY+FpeRs1Bmc
         Z25J4v+HwuZqk4f5HeBhkbyK8h0hH0sYo90z3OVD0wpM9JPoMlmhuTbbAGBHj5Tb6vmy
         0Zrw==
X-Gm-Message-State: AO0yUKWbwODUZyZ3d20fo+t5Pa6CK5Bq5IIENM4YJLY3H6ZwDjIADgtX
        zxlBD2/q/AQgAkjrg7ygFHUpLF+iy7CgLgavh/HxSg==
X-Google-Smtp-Source: AK7set8mUUyHczOx9K8OTiOb+VEJOgVjuhnEyS3UlTKS0ud7SE3aP7MsgqjnquIbNt3RzZ3wWjJPz1D66u7NxKWiwNg=
X-Received: by 2002:a17:902:9a03:b0:19a:afc4:2300 with SMTP id
 v3-20020a1709029a0300b0019aafc42300mr7321289plp.6.1678283745660; Wed, 08 Mar
 2023 05:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com> <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
 <ZAdOgUdqwLpUyPlc@redhat.com> <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
In-Reply-To: <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 8 Mar 2023 13:55:34 +0000
Message-ID: <CALrw=nFrbWF2ZhQtK9gx5ZFHK4Cd9outwEQqByJgmb7ryOoCgA@mail.gmail.com>
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        houtao1@huawei.com, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, mpatocka@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 2:56=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 3/7/2023 10:47 PM, Mike Snitzer wrote:
> > On Mon, Mar 06 2023 at  9:12P -0500,
> > Hou Tao <houtao@huaweicloud.com> wrote:
> >
> >> Hi,
> >>
> >> On 3/7/2023 3:31 AM, Mike Snitzer wrote:
> >>> On Mon, Mar 06 2023 at  8:49P -0500,
> >>> Hou Tao <houtao@huaweicloud.com> wrote:
> >>>
> >>>> From: Hou Tao <houtao1@huawei.com>
> >>>>
> >>>> When neither no_read_workqueue nor no_write_workqueue are enabled,
> >>>> tasklet_trylock() in crypt_dec_pending() may still return false due =
to
> >>>> an uninitialized state, and dm-crypt will do io completion in io_que=
ue
> >>>> instead of current context unnecessarily.
> >>> Have you actually experienced this?
> >> Yes. I had written a bpftrace script to check the completion context o=
f
> >> blkdev_bio_end_io_simple() when doing direct io read on dm-crypt devic=
e. The
> >> expected context should be unbound workers of crypt_queue, but sometim=
es the
> >> context is the bound worker of io_queue.
> > OK, thanks for clarifying.  Curious to know the circumstance (I
> > thought per-bio-data is zero'd -- but it may be I'm mistaken).
> The circumstance is just a normal qemu VM running the vanilla kernel for =
test
> purpose. According to the implementation of bio_alloc_bioset(), the front=
 pad of
> bio is not initialized and only bio itself is initialized. AFAIK if
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON is enabled, per-bio-data may be zeroed.
> >
> > I won't be marking this commit for stable@ but if others feel
> > differently please let me know and I'll do so. (We can always propose
> > it to stable@, after the fact, even if the commit header doesn't Cc
> > stable@)
> >
> >>>> Fix it by initializing io->tasklet in crypt_io_init().
> >>> Really would rather avoid always calling tasklet_init(). But I can
> >>> optimize it away with a later patch.
> >> My first though was "io->tasklet.state =3D 0", but it may be fragile b=
ecause it
> >> operated on the internal status of tasklet, so I switch to tasklet_ini=
t().
> > Yes, I looked into it and came up with the same hack.. and I too felt
> > it was too fragile due to open-coding direct access to the tasklet's
> > members.
> >
> > I have a patch I just staged that staged that uses jump_labels to
> > optimize this code.  If you might review/test/verify it works well for
> > you that'd be appreciated:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.=
git/commit/?h=3Ddm-6.3&id=3Dae75a25bd83f7c541240449d2fff3a44433e506b
> >
> > It builds on your patch, which I added a comment to:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.=
git/commit/?h=3Ddm-6.3&id=3Dd9fe0a98a2e0a1cf585e8a6555afb33be968bd13
> Thanks for the comments. It is fine to me.
> >
> > From: Mike Snitzer <snitzer@kernel.org>
> > Date: Mon, 6 Mar 2023 15:58:33 -0500
> > Subject: [PATCH] dm crypt: conditionally enable code needed for tasklet=
 usecases
> >
> > Use jump_label to limit the need for branching, and tasklet_init(),
> > unless either of the optional "no_read_workqueue" and/or
> > "no_write_workqueue" features are used.
> >
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  drivers/md/dm-crypt.c | 35 +++++++++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > index 641457e72603..2d0309ca07f5 100644
> > --- a/drivers/md/dm-crypt.c
> > +++ b/drivers/md/dm-crypt.c
> > @@ -40,6 +40,7 @@
> >  #include <keys/user-type.h>
> >  #include <keys/encrypted-type.h>
> >  #include <keys/trusted-type.h>
> > +#include <linux/jump_label.h>
> >
> >  #include <linux/device-mapper.h>
> >
> > @@ -85,6 +86,8 @@ struct dm_crypt_io {
> >       struct rb_node rb_node;
> >  } CRYPTO_MINALIGN_ATTR;
> >
> > +static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
> > +
> >  struct dm_crypt_request {
> >       struct convert_context *ctx;
> >       struct scatterlist sg_in[4];
> > @@ -1730,12 +1733,15 @@ static void crypt_io_init(struct dm_crypt_io *i=
o, struct crypt_config *cc,
> >       io->sector =3D sector;
> >       io->error =3D 0;
> >       io->ctx.r.req =3D NULL;
> > -     /*
> > -      * tasklet_init() here to ensure crypt_dec_pending()'s
> > -      * tasklet_trylock() doesn't incorrectly return false
> > -      * even when tasklet isn't in use.
> > -      */
> > -     tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)=
&io->work);
> > +     if (static_branch_unlikely(&use_tasklet_enabled)) {
> > +             /*
> > +              * tasklet_init() here to ensure crypt_dec_pending()'s
> > +              * tasklet_trylock() doesn't incorrectly return false
> > +              * even when tasklet isn't in use.
> > +              */
> > +             tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,
> > +                          (unsigned long)&io->work);
> > +     }
> >       io->integrity_metadata =3D NULL;
> >       io->integrity_metadata_from_pool =3D false;
> >       atomic_set(&io->io_pending, 0);
> > @@ -1775,6 +1781,10 @@ static void crypt_dec_pending(struct dm_crypt_io=
 *io)
> >               kfree(io->integrity_metadata);
> >
> >       base_bio->bi_status =3D error;
> > +     if (!static_branch_unlikely(&use_tasklet_enabled)) {
> > +             bio_endio(base_bio);
> > +             return;
> > +     }
> Because use_tasklet_enabled can be enabled concurrently, so I think it is=
 still
> possible that crypt_dec_pending will try-lock an unitialized tasklet if
> use_tasklet_enabled is enabled when invoking crypt_dec_pending().

Perhaps instead we can just pass an additional flag from
tasklet_schedule to indicate to the function that we're running in a
tasklet. I originally have chosen the tasklet_trylock/unlock hack to
avoid passing an extra flag. But unitialized memory makes sense as
well as the desire to avoid calling tasklet_init unconditionally. So
an extra member in dm_crypt_io might be the most straightforward here.

Ignat

> >       /*
> >        * If we are running this function from our tasklet,
> > @@ -2232,8 +2242,9 @@ static void kcryptd_queue_crypt(struct dm_crypt_i=
o *io)
> >  {
> >       struct crypt_config *cc =3D io->cc;
> >
> > -     if ((bio_data_dir(io->base_bio) =3D=3D READ && test_bit(DM_CRYPT_=
NO_READ_WORKQUEUE, &cc->flags)) ||
> > -         (bio_data_dir(io->base_bio) =3D=3D WRITE && test_bit(DM_CRYPT=
_NO_WRITE_WORKQUEUE, &cc->flags))) {
> > +     if (static_branch_unlikely(&use_tasklet_enabled) &&
> > +         ((bio_data_dir(io->base_bio) =3D=3D READ && test_bit(DM_CRYPT=
_NO_READ_WORKQUEUE, &cc->flags)) ||
> > +          (bio_data_dir(io->base_bio) =3D=3D WRITE && test_bit(DM_CRYP=
T_NO_WRITE_WORKQUEUE, &cc->flags)))) {
> >               /*
> >                * in_hardirq(): Crypto API's skcipher_walk_first() refus=
es to work in hard IRQ context.
> >                * irqs_disabled(): the kernel may run some IO completion=
 from the idle thread, but
> > @@ -2746,6 +2757,10 @@ static void crypt_dtr(struct dm_target *ti)
> >       crypt_calculate_pages_per_client();
> >       spin_unlock(&dm_crypt_clients_lock);
> >
> > +     if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags) ||
> > +         test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
> > +             static_branch_dec(&use_tasklet_enabled);
> > +
> >       dm_audit_log_dtr(DM_MSG_PREFIX, ti, 1);
> >  }
> >
> > @@ -3375,6 +3390,10 @@ static int crypt_ctr(struct dm_target *ti, unsig=
ned int argc, char **argv)
> >       ti->limit_swap_bios =3D true;
> >       ti->accounts_remapped_io =3D true;
> >
> > +     if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags) ||
> > +         test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
> > +             static_branch_inc(&use_tasklet_enabled);
> > +
> >       dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
> >       return 0;
> >
>
