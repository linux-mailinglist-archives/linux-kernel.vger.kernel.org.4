Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2B6B22FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjCIL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjCIL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:28:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15096E63F6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:27:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so5536484pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1678361250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTkd/ocqzqHF903X3l/TIbGxupeKtrhJgXkaQqPp9AE=;
        b=wyFHy7RrQ/uL+2CVfDkEZTb4MA3NHgQRqmZr/rtzRrhGjUCdUkobaitQPgjIOLt3im
         JTPK8lQohKB7y63pUineoXPQh+tkjbx+PhwckURr/38Gwp4D9OfocXUJ4ekW8RxBzbFR
         Va/5iLv4MFgSNRX/rTAWKoGCHqxnkvqpfiZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678361250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTkd/ocqzqHF903X3l/TIbGxupeKtrhJgXkaQqPp9AE=;
        b=wKIK8ty9ObkCrTbjz6rGdhGTq0mRzp5/6UCwYcR2VBXuhDudSnSxVBel0xeSh4Ogjv
         rOBBcWfTwCXTv1kLRScv2wJpEQHs1km/KDJkRWp1UiPdHUqNSkqHDCCo0h9zR7wwh8Fj
         vABKBSl7o/3flY6PINmxRWipZrWC3XtjdinSKoCf37wW1B9BZYlw9g5xkTIsHFC0AHr9
         JBhdEHr1RkrPW1MpWPjKm9HKkiBfHpxWT74s9bwj6EgZQftqO+tplLW2J3xidMRK8k1i
         J6uOfUDtcyNbPvV/h+FPRM5RXL+hSdLM/6gbKQsRe8ucGsYLgZnMPEicc0Q3UZltkUbR
         +ytw==
X-Gm-Message-State: AO0yUKWRqmc+wwf3BZkRdWYy4yDOvHkF+tQIXKKgQ1NTQq+kWF+QxrzS
        ALy7K4fTKNPggZwmf0jxDecpk71xQfJB7RqXuR3qDQ==
X-Google-Smtp-Source: AK7set+0WkaHZixQx2+BsrO0fjzkrnjGjfnSiMls2OdnOe3y7QaAQFzS8mLzCHTib255JUwIjmIJF9xJP/D1hhZ4HWo=
X-Received: by 2002:a17:90a:c217:b0:234:b8cb:5133 with SMTP id
 e23-20020a17090ac21700b00234b8cb5133mr8017870pjt.7.1678361250400; Thu, 09 Mar
 2023 03:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com> <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
 <ZAdOgUdqwLpUyPlc@redhat.com> <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
 <CALrw=nFrbWF2ZhQtK9gx5ZFHK4Cd9outwEQqByJgmb7ryOoCgA@mail.gmail.com>
 <ZAjfu0R7rv45J3Dr@redhat.com> <ZAjvqz5pWf8aSkJ7@redhat.com>
In-Reply-To: <ZAjvqz5pWf8aSkJ7@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 9 Mar 2023 11:27:19 +0000
Message-ID: <CALrw=nGXQ__cL_AX7SccNYZ=BKpHatXeh4nd_wjK2EbBTVm4Pg@mail.gmail.com>
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

On Wed, Mar 8, 2023 at 8:27=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> wr=
ote:
>
> On Wed, Mar 08 2023 at  2:19P -0500,
> Mike Snitzer <snitzer@kernel.org> wrote:
>
> > On Wed, Mar 08 2023 at  8:55P -0500,
> > Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > > Perhaps instead we can just pass an additional flag from
> > > tasklet_schedule to indicate to the function that we're running in a
> > > tasklet. I originally have chosen the tasklet_trylock/unlock hack to
> > > avoid passing an extra flag. But unitialized memory makes sense as
> > > well as the desire to avoid calling tasklet_init unconditionally. So
> > > an extra member in dm_crypt_io might be the most straightforward here=
.
> >
> > ... I think we should certainly evaluate the use of an extra flag.
> >
> > Ignat: I'll have a look at implementing it but if you have a patch
> > already developed please do share.
>
> I've staged the following in linux-next for 6.3 via the linux-dm.git,
> but if you see anything wrong with it I can obviously fix:
>
> From: Mike Snitzer <snitzer@kernel.org>
> Date: Wed, 8 Mar 2023 14:39:54 -0500
> Subject: [PATCH] dm crypt: avoid accessing uninitialized tasklet
>
> When neither "no_read_workqueue" nor "no_write_workqueue" are enabled,
> tasklet_trylock() in crypt_dec_pending() may still return false due to
> an uninitialized state, and dm-crypt will unnecessarily do io completion
> in io_queue workqueue instead of current context.
>
> Fix this by adding an 'in_tasklet' flag to dm_crypt_io struct and
> initialize it to false in crypt_io_init(). Set this flag to true in
> kcryptd_queue_crypt() before calling tasklet_schedule(). If set
> crypt_dec_pending() will punt io completion to a workqueue.
>
> This also nicely avoids the tasklet_trylock/unlock hack when tasklets
> aren't in use.
>
> Fixes: 8e14f610159d ("dm crypt: do not call bio_endio() from the dm-crypt=
 tasklet")
> Cc: stable@vger.kernel.org
> Reported-by: Hou Tao <houtao1@huawei.com>
> Suggested-by: Ignat Korchagin <ignat@cloudflare.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-crypt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index faba1be572f9..de08ff4f7c98 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -72,7 +72,9 @@ struct dm_crypt_io {
>         struct crypt_config *cc;
>         struct bio *base_bio;
>         u8 *integrity_metadata;
> -       bool integrity_metadata_from_pool;
> +       bool integrity_metadata_from_pool:1;
> +       bool in_tasklet:1;
> +
>         struct work_struct work;
>         struct tasklet_struct tasklet;
>
> @@ -1731,6 +1733,7 @@ static void crypt_io_init(struct dm_crypt_io *io, s=
truct crypt_config *cc,
>         io->ctx.r.req =3D NULL;
>         io->integrity_metadata =3D NULL;
>         io->integrity_metadata_from_pool =3D false;
> +       io->in_tasklet =3D false;
>         atomic_set(&io->io_pending, 0);
>  }
>
> @@ -1777,8 +1780,7 @@ static void crypt_dec_pending(struct dm_crypt_io *i=
o)
>          * our tasklet. In this case we need to delay bio_endio()
>          * execution to after the tasklet is done and dequeued.
>          */
> -       if (tasklet_trylock(&io->tasklet)) {
> -               tasklet_unlock(&io->tasklet);
> +       if (!io->in_tasklet) {

nitpick: maybe invert the logic here for better readability? (so it
becomes "if (in_tasklet) queue..." else just falls through bio_endio()
)

>                 bio_endio(base_bio);
>                 return;
>         }
> @@ -2233,6 +2235,7 @@ static void kcryptd_queue_crypt(struct dm_crypt_io =
*io)
>                  * it is being executed with irqs disabled.
>                  */
>                 if (in_hardirq() || irqs_disabled()) {
> +                       io->in_tasklet =3D true;
>                         tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,=
 (unsigned long)&io->work);
>                         tasklet_schedule(&io->tasklet);
>                         return;
> --
> 2.37.1 (Apple Git-137.1)
>

Reviewed-by: Ignat Korchagin <ignat@cloudflare.com>
