Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D716B11E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCHTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:20:13 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFBDC78ED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:19:25 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id l13so19308570qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 11:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkHirdjLx4oluQvgjjTo950cjCWQijRI8BJMtzeHk6M=;
        b=l7A0kPtlW0QbkAuO+TeoZw4TBtLIQhK5M7TbSVAqLlGu/mOeuxCHB+hse+ng1JCCU0
         i1x751inlcM/IamQqonEX22v0hMczc/0SU2YPiWhSlWrLoZED78FSc2G8l+B4j6XllaI
         JjikDDQ4HiEqH2MtaGWzXjFrpU9PNAy8DWl9vK05otryualZkugSc815V+EqzzlCa1iJ
         Zoa7pHJGRJDpXvcoJeSmGikQsgN8CBCP5Z4f9+kDKCnQwAiHQ9loOkv+30abfrquwHiR
         J/O79+a17CS03r6KmUVY1cn4B3RFkhuIygv5JQryibBlCS131u8U9fgrWyhTTa7IqvC1
         XYcg==
X-Gm-Message-State: AO0yUKUjyQvdsD/BoCdSzVLDHnc+V3MkwXW8ZEFaa0Ztj2zO+c7fr1u7
        OmTGkM94T7ZpGoCSZkf/fiSy
X-Google-Smtp-Source: AK7set+gG0nocmMQ2Y25zUYYmfpN1pSJ3V/BZ+zhTG35XVfGet8HQOg/+TrAvZgfYlA4oFTiFmFb8Q==
X-Received: by 2002:a05:622a:1443:b0:3bf:c178:c6ea with SMTP id v3-20020a05622a144300b003bfc178c6eamr30040837qtx.56.1678303164749;
        Wed, 08 Mar 2023 11:19:24 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85bc3000000b003bfb820f17csm12392277qtb.63.2023.03.08.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:19:24 -0800 (PST)
Date:   Wed, 8 Mar 2023 14:19:23 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Ignat Korchagin <ignat@cloudflare.com>,
        Hou Tao <houtao@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        mpatocka@redhat.com, houtao1@huawei.com,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
Message-ID: <ZAjfu0R7rv45J3Dr@redhat.com>
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com>
 <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
 <ZAdOgUdqwLpUyPlc@redhat.com>
 <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
 <CALrw=nFrbWF2ZhQtK9gx5ZFHK4Cd9outwEQqByJgmb7ryOoCgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALrw=nFrbWF2ZhQtK9gx5ZFHK4Cd9outwEQqByJgmb7ryOoCgA@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08 2023 at  8:55P -0500,
Ignat Korchagin <ignat@cloudflare.com> wrote:

> On Wed, Mar 8, 2023 at 2:56 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > Hi,
> >
> > On 3/7/2023 10:47 PM, Mike Snitzer wrote:
> > > On Mon, Mar 06 2023 at  9:12P -0500,
> > > Hou Tao <houtao@huaweicloud.com> wrote:
> > >
> > >> Hi,
> > >>
> > >> On 3/7/2023 3:31 AM, Mike Snitzer wrote:
> > >>> On Mon, Mar 06 2023 at  8:49P -0500,
> > >>> Hou Tao <houtao@huaweicloud.com> wrote:
> > >>>
> > >>>> From: Hou Tao <houtao1@huawei.com>
> > >>>>
> > >>>> When neither no_read_workqueue nor no_write_workqueue are enabled,
> > >>>> tasklet_trylock() in crypt_dec_pending() may still return false due to
> > >>>> an uninitialized state, and dm-crypt will do io completion in io_queue
> > >>>> instead of current context unnecessarily.
> > >>> Have you actually experienced this?
> > >> Yes. I had written a bpftrace script to check the completion context of
> > >> blkdev_bio_end_io_simple() when doing direct io read on dm-crypt device. The
> > >> expected context should be unbound workers of crypt_queue, but sometimes the
> > >> context is the bound worker of io_queue.
> > > OK, thanks for clarifying.  Curious to know the circumstance (I
> > > thought per-bio-data is zero'd -- but it may be I'm mistaken).
> > The circumstance is just a normal qemu VM running the vanilla kernel for test
> > purpose. According to the implementation of bio_alloc_bioset(), the front pad of
> > bio is not initialized and only bio itself is initialized. AFAIK if
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is enabled, per-bio-data may be zeroed.

OK.

> > > From: Mike Snitzer <snitzer@kernel.org>
> > > Date: Mon, 6 Mar 2023 15:58:33 -0500
> > > Subject: [PATCH] dm crypt: conditionally enable code needed for tasklet usecases
> > >
> > > Use jump_label to limit the need for branching, and tasklet_init(),
> > > unless either of the optional "no_read_workqueue" and/or
> > > "no_write_workqueue" features are used.
> > >
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  drivers/md/dm-crypt.c | 35 +++++++++++++++++++++++++++--------
> > >  1 file changed, 27 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > > index 641457e72603..2d0309ca07f5 100644
> > > --- a/drivers/md/dm-crypt.c
> > > +++ b/drivers/md/dm-crypt.c
> > > @@ -40,6 +40,7 @@
> > >  #include <keys/user-type.h>
> > >  #include <keys/encrypted-type.h>
> > >  #include <keys/trusted-type.h>
> > > +#include <linux/jump_label.h>
> > >
> > >  #include <linux/device-mapper.h>
> > >
> > > @@ -85,6 +86,8 @@ struct dm_crypt_io {
> > >       struct rb_node rb_node;
> > >  } CRYPTO_MINALIGN_ATTR;
> > >
> > > +static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
> > > +
> > >  struct dm_crypt_request {
> > >       struct convert_context *ctx;
> > >       struct scatterlist sg_in[4];
> > > @@ -1730,12 +1733,15 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
> > >       io->sector = sector;
> > >       io->error = 0;
> > >       io->ctx.r.req = NULL;
> > > -     /*
> > > -      * tasklet_init() here to ensure crypt_dec_pending()'s
> > > -      * tasklet_trylock() doesn't incorrectly return false
> > > -      * even when tasklet isn't in use.
> > > -      */
> > > -     tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> > > +     if (static_branch_unlikely(&use_tasklet_enabled)) {
> > > +             /*
> > > +              * tasklet_init() here to ensure crypt_dec_pending()'s
> > > +              * tasklet_trylock() doesn't incorrectly return false
> > > +              * even when tasklet isn't in use.
> > > +              */
> > > +             tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,
> > > +                          (unsigned long)&io->work);
> > > +     }
> > >       io->integrity_metadata = NULL;
> > >       io->integrity_metadata_from_pool = false;
> > >       atomic_set(&io->io_pending, 0);
> > > @@ -1775,6 +1781,10 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
> > >               kfree(io->integrity_metadata);
> > >
> > >       base_bio->bi_status = error;
> > > +     if (!static_branch_unlikely(&use_tasklet_enabled)) {
> > > +             bio_endio(base_bio);
> > > +             return;
> > > +     }
> > Because use_tasklet_enabled can be enabled concurrently, so I think it is still
> > possible that crypt_dec_pending will try-lock an unitialized tasklet if
> > use_tasklet_enabled is enabled when invoking crypt_dec_pending().

Good point, while I think it is probably acceptable given the worst
case is punting the bio_endio to a workqueue for a time ...

> Perhaps instead we can just pass an additional flag from
> tasklet_schedule to indicate to the function that we're running in a
> tasklet. I originally have chosen the tasklet_trylock/unlock hack to
> avoid passing an extra flag. But unitialized memory makes sense as
> well as the desire to avoid calling tasklet_init unconditionally. So
> an extra member in dm_crypt_io might be the most straightforward here.

... I think we should certainly evaluate the use of an extra flag.

Ignat: I'll have a look at implementing it but if you have a patch
already developed please do share.

Thanks,
Mike
