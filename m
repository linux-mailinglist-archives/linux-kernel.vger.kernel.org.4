Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3A744237
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjF3S3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3S3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:29:09 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6F125;
        Fri, 30 Jun 2023 11:29:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b46e61638eso1795911a34.0;
        Fri, 30 Jun 2023 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688149747; x=1690741747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufSikJIzzdYkNZWsL96qLD3OA3hcigftlhdpCXOUpVY=;
        b=nbzoZF6TEaNfkAh3k3UNqiRuDnn3sEyQkyuFKAGqYEcYef9rR0QNxBOlxkSAVeoSCQ
         ZwWyxjSRsMFALSebYEM4oA2mYqedi0z23BfAywidOQTW9Uz+DjoC/sAuugAD74NaEfe7
         Me12sPAbivMVly7XSEoafK0AQdrqLVikevg7wx76KUouqcpoXVwzwAixCZqZIYPPeoBg
         rSlRkiNAe2HlPtzFq1lzT1EPrJRFSQt8Q2QSYg3txyOcikv0P9Ik8uX2GzXWGJ9cTGRa
         vd6KqDeZXJol6lw2jUeqk+sta51/5Pypg0eUwpd0OC7jocH95egG0U27jrqmovHKZYNI
         OuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149747; x=1690741747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufSikJIzzdYkNZWsL96qLD3OA3hcigftlhdpCXOUpVY=;
        b=Psa8aNLYWppkZP2MypO5EyhLPvy2BSniFT9dIZVncGuEkn7PB6vwQFWj2z9ZuwFGIX
         d/LJ9/tFZQ6xUZdXkPpGXRMUmcZmW4c8zwvHQGqE30H6cUatKXPlfZsEye9B/uLgQVPi
         RyyX5jCZVyALd+VO3McEv6FNz38KPZjt4WfG50vczzFLHXYwvBJ1OHcffAzjCXE73coC
         2TXXzwig/3XSEFkzWKA75HO77q6dpWUhv+GtVtmQ/T04vRh8WbIBg4mCFv629B1mx86a
         M48ESg/vY+/+dhxKQtHNdWBzgT8FDebN+xJhMeYKe2lTd7vs+XgGwgXEbX9S72tRljAZ
         djew==
X-Gm-Message-State: AC+VfDww3Xt+zCqiGouYGQDmx+NrSdPy6+oGQiu2NjNrhZeGcEfe9yl4
        QnP7anlhARrOJcLQMOF96bVXuM/1zbpfKkudYug=
X-Google-Smtp-Source: ACHHUZ6cCTLekE2G2hYmWifqUemk3aB0BDtWq98Nwn4Evf3ZmzSfqSnVXHYaBSyYhN/Kd/21WS4X+JQECxaR/BvbwN8=
X-Received: by 2002:a05:6830:1096:b0:6b7:5687:8a9e with SMTP id
 y22-20020a056830109600b006b756878a9emr4052306oto.15.1688149747253; Fri, 30
 Jun 2023 11:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-3-aleksander.lobakin@intel.com> <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
 <ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com> <CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com>
 <413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
In-Reply-To: <413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 30 Jun 2023 11:28:30 -0700
Message-ID: <CAKgT0UcNRCiMDbM7AwXA+dRnikS31tDGZdZhnkBs1u-yi4yN8g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op
 externals when possible
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 8:34=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Fri, 30 Jun 2023 07:44:45 -0700
>
> > On Fri, Jun 30, 2023 at 5:30=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Alexander H Duyck <alexander.duyck@gmail.com>
> >> Date: Thu, 29 Jun 2023 09:45:26 -0700
> >>
> >>> On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
> >>>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cy=
cles
> >>>> even when on DMA-coherent platforms (like x86) with no active IOMMU =
or
> >>>> swiotlb, just for the call ladder.
> >>>> Indeed, it's
> >>
> >> [...]
> >>
> >>>> @@ -341,6 +345,12 @@ static bool page_pool_dma_map(struct page_pool =
*pool, struct page *page)
> >>>>
> >>>>      page_pool_set_dma_addr(page, dma);
> >>>>
> >>>> +    if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
> >>>> +        dma_need_sync(pool->p.dev, dma)) {
> >>>> +            pool->p.flags |=3D PP_FLAG_DMA_SYNC_DEV;
> >>>> +            pool->p.flags &=3D ~PP_FLAG_DMA_MAYBE_SYNC;
> >>>> +    }
> >>>> +
> >>>>      if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> >>>>              page_pool_dma_sync_for_device(pool, page, pool->p.max_l=
en);
> >>>>
> >>>
> >>> I am pretty sure the logic is flawed here. The problem is
> >>> dma_needs_sync depends on the DMA address being used. In the worst ca=
se
> >>> scenario we could have a device that has something like a 32b DMA
> >>> address space on a system with over 4GB of memory. In such a case the
> >>> higher addresses would need to be synced because they will go off to =
a
> >>> swiotlb bounce buffer while the lower addresses wouldn't.
> >>>
> >>> If you were to store a flag like this it would have to be generated p=
er
> >>> page.
> >>
> >> I know when DMA might need syncing :D That's the point of this shortcu=
t:
> >> if at least one page needs syncing, I disable it for the whole pool.
> >> It's a "better safe than sorry".
> >> Using a per-page flag involves more changes and might hurt some
> >> scenarios/setups. For example, non-coherent systems, where you always
> >> need to do syncs. The idea was to give some improvement when possible,
> >> otherwise just fallback to what we have today.
> >
> > I am not a fan of having the page pool force the syncing either. Last
> > I knew I thought the PP_FLAG_DMA_SYNC_DEV was meant to be set by the
>
> Please follow the logics of the patch.
>
> 1. The driver sets DMA_SYNC_DEV.
> 2. PP tries to shortcut and replaces it with MAYBE_SYNC.
> 3. If dma_need_sync() returns true for some page, it gets replaced back
>    to DMA_SYNC_DEV, no further dma_need_sync() calls for that pool.
>
> OR
>
> 1. The driver doesn't set DMA_SYNC_DEV.
> 2. PP doesn't turn on MAYBE_SYNC.
> 3. No dma_need_sync() tests.
>
> Where does PP force syncs for drivers which don't need them?

You are right. I was looking at it out of context.

> > driver, not by the page pool API itself. The big reason for that being
> > that the driver in many cases will have to take care of the DMA sync
> > itself instead of letting the allocator take care of it.
> >
> > Basically we are just trading off the dma_need_sync cost versus the
> > page_pool_dma_sync_for_device cost. If we think it is a win to call
>
> dma_need_sync() is called once per newly allocated and mapped page.
> page_pool_dma_sync_for_device() is called each time you ask for a page.
>
> On my setup and with patch #4, I have literally 0 allocations once a
> ring is filled. This means dma_need_sync() is not called at all during
> Rx, while sync_for_device() would be called all the time.
> When pages go through ptr_ring, sometimes new allocations happen, but
> still the number of times dma_need_sync() is called is thousands times
> lower.

I see, so you are using it as a screener for pages as they are added
to the pool. However the first time somebody trips the dma_need_sync
then everybody in the pool is going to be getting hit with the sync
code.

> > dma_need_sync for every frame then maybe we should look at folding it
> > into page_pool_dma_sync_for_device itself since that is the only
> > consumer of it it or just fold it into the PP_FLAG_DMA_SYNC_DEV if
> > statement after the flag check rather than adding yet another flag
> > that will likely always be true for most devices. Otherwise you are
>
> What you suggest is either calling dma_need_sync() each time a page is
> requested or introducing a flag to store it somewhere in struct page to
> allow some optimization for really-not-common-cases when dma_need_sync()
> might return different values due to swiotlb etc. Did I get it right?

Yeah, my thought would be to have a flag in the page to indicate if it
will need the sync bits or not. Then you could look at exposing that
to the drivers as well so that they could cut down on their own
overhead. We could probably look at just embedding a flag in the lower
bits of the DMA address stored in the page since I suspect at a
minimum the resultant DMA address for a page would always be at least
aligned to a long if not a full page.
