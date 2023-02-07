Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038368E3A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBGWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjBGWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:54:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C427D5A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:54:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id z13so4638123wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GpMHLadhKBQ6+m2UPO236KZ/4fJUKcv4tl+ZjXMWOg=;
        b=sMbBMtAeCWA4vXGzLDmhjeUh/rfI6B5G76ykaIK+xBZyv8R88RMEuIgkvv4SL4sE5j
         XcCJCzyfIuCuP5ias1DX7y7J7Bw7iiicfY2/1rDoJgrENb2jXeeOZ+Z/B0ny4qnZqGXU
         W0Hzb1/J0OUk8+fbEEv/sEHP6SLRhfl/rTt05Xb+BlP0Mc4wBFq14RZC9Xc9fS4wQ52h
         LPd/lv9A7eqoRMRzarmYETR0tE3btg1LBGvTbhCLxwvHEKY/JVAKPHQw8ubkw/TdL74H
         37Th2rf+1FsJ1Gvq92Sg5Hh7v7MGKaeWZewQPBs1ovU7oaekwd96HY8Df9NBiSz70QTG
         ah5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GpMHLadhKBQ6+m2UPO236KZ/4fJUKcv4tl+ZjXMWOg=;
        b=I3Y6i0wTY6P6MckIbubg4e6XAEsVKYi/rhq7hMTcxIAYDNVEwbeYyDTbz0AOmef9mm
         n5RmUnsJcRfRDkbuCEjpIxCenAt4otum4IBgKyaifHzfhIztSh1K0+nAnrwhjcVnYyxc
         6O7ljmg1kabYWs4R92NYz08vHFLRVDHe07WMpnDgCYuYbzOYB7GflUXDSH0d3DJusJ+f
         dTq/U/MKqWMtafpWvy2DVs9bnKAksl2jq2pk4izJq6eLjiMt/Q/Jg8q4+Jgh9ryGFxao
         fHQp0ubHFozqo2xna0ruTR9kzDM56SF6/dWK2xNM3CdoG8Rx5w20zXrMUL1Cxhd8eDHt
         FWZQ==
X-Gm-Message-State: AO0yUKUtogxECoT9TGRUIUTwlmJhjZCYpqZCNrY/ZX5Bpjj5eEDPl8E/
        vlEpTDdzPiMNTnUS7JeeN6iw98qNxrSvgKCiFhXIJw4qLx3+QM1I
X-Google-Smtp-Source: AK7set+enYQAT6EptDabqZUbDV3esLdckJONxaTZ47keMG7iGdk0lZlEyJHzl1jWSuwBCj1kot2g4OCCuRxyvO0pSs4=
X-Received: by 2002:a05:600c:220f:b0:3e0:15c:860f with SMTP id
 z15-20020a05600c220f00b003e0015c860fmr64175wml.115.1675810472693; Tue, 07 Feb
 2023 14:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20230202012348.885402-1-nhuck@google.com> <alpine.LRH.2.21.2302021052580.21238@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.21.2302021052580.21238@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 7 Feb 2023 14:54:21 -0800
Message-ID: <CAJkfWY5d+FqGb_3PMZbMWYdNW4ED4CqiuJzMQFog_GLLEtZiBg@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH] dm-verity: Remove WQ_UNBOUND.
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 12:16 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 1 Feb 2023, Nathan Huckleberry wrote:
>
> > Setting WQ_UNBOUND increases scheduler latency on ARM64.  This is likely
> > due to the asymmetric architecture of ARM64 processors.
> >
> > I've been unable to reproduce the results that claim WQ_UNBOUND gives a
> > performance boost on x86-64.
> >
> > This flag is causing performance issues for multiple subsystems within
> > Android.  Notably, the same slowdown exists for decompression with
> > EROFS.
> >
> > | open-prebuilt-camera  | WQ_UNBOUND | ~WQ_UNBOUND   |
> > |-----------------------|------------|---------------|
> > | verity wait time (us) | 11746      | 119 (-98%)    |
> > | erofs wait time (us)  | 357805     | 174205 (-51%) |
> >
> > | sha256 ramdisk random read | WQ_UNBOUND    | ~WQ_UNBOUND |
> > |----------------------------|-----------=---|-------------|
> > | arm64 (accelerated)        | bw=42.4MiB/s  | bw=212MiB/s |
> > | arm64 (generic)            | bw=16.5MiB/s  | bw=48MiB/s  |
> > | x86_64 (generic)           | bw=233MiB/s   | bw=230MiB/s |
> >
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  drivers/md/dm-verity-target.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > index ccf5b852fbf7..020fd2341025 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -1399,8 +1399,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >               goto bad;
> >       }
> >
> > -     /* WQ_UNBOUND greatly improves performance when running on ramdisk */
> > -     wq_flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
> > +     wq_flags = WQ_MEM_RECLAIM;
> > +
> >       /*
> >        * Using WQ_HIGHPRI improves throughput and completion latency by
> >        * reducing wait times when reading from a dm-verity device.
>
> Hi
>
> If you remove WQ_UNBOUND, you should also change the last argument of
> alloc_workqueue from num_online_cpus() to either 0 or 1. Try both 0 and 1
> and tell us which performs better.

They look roughly the same on ARM64. There's a slight advantage for
using 1, but they're too close to conclusively say one is better.

Thanks,
Huck

>
> Mikulas
>
