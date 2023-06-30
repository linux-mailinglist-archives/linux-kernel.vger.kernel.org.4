Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B7743DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjF3Opd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjF3Op2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:45:28 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961C1FC2;
        Fri, 30 Jun 2023 07:45:23 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b723aedd3dso1385100a34.3;
        Fri, 30 Jun 2023 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688136322; x=1690728322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCqsP8XO7B1p8RAxtSlO/FnCPRr08EENqWwOAf3sC+E=;
        b=qVdXzBH8WjUA9L1VyNci3etKoSEHQuU9KN6Ex1ShfYvadQztuThYEV56Gg4N91bmI6
         J/Wch61VIWZrHssyTcvMFzrgeAPUxoTdiFUUFKPEhdXd7vm/8BMrL8+bu1mYXbnEI8Zh
         LHqV/O+rv+jZfOlkPmO7UoraWrlQdgzV0538MFq9ZT10MeKkBWQAWGpUUk+d1HXxn58v
         KcMWYWDhMM4FJ5NHjDf+Ly3U722Kg3UcUERKULJEvx1aLXpBFjo82vo1qwz11sU2Swb0
         gr+gfaT61PggH/y6Yh4RW66ify9PifAG38GqxiuK4ChVRiXqnJqCCg268Ho7r39rghIY
         SLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136322; x=1690728322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCqsP8XO7B1p8RAxtSlO/FnCPRr08EENqWwOAf3sC+E=;
        b=d1AOdZdGyht/zxzvzGFqnbXuBEZsrkHFt7BINiqxO4F5DpTLm6GqLjABPdk7TLUJAU
         s5auOS0VOze1O/trSCxS+h3xgB9fe5pHamAZoWRTcLpSTs+buiunSAD8auIVQj1JfVJk
         FtxOFgIRvnwkMvF9EqduvVefhkIF7Sm9UQ5afvecdd7EdGtSU20nphD+Ey3asvFldESG
         EnRu9PwAhsKPWDeLLDx0SkZbeG08x7QW3J4rRer2Xss7FRJlbaLXraNEmVivgUPzjrzg
         s1IF2qfiqvS48ExEagAiyO5wK6oXqFkEVkLl+ma6sZJ2QVxA2ToFXiZF33Zs3gWCHjTB
         F0Eg==
X-Gm-Message-State: AC+VfDy3kPzbLY3FR7v3Jw/3p1DSl3Pws3O5+du2VXSiD0f2rrU8LTQJ
        AXyTuSmpM4YzcHJm92/WfYSRll272Qx9kTkgN7U=
X-Google-Smtp-Source: ACHHUZ6x47k+BXIygzeqymMPvPthnxGZSrYcX5eKzXrClNt885Eq14YiHr7/Dt7QMj+OWwLY3sc41XGYcU6gqVwOeU0=
X-Received: by 2002:a9d:6f0a:0:b0:6b7:4411:505d with SMTP id
 n10-20020a9d6f0a000000b006b74411505dmr3021676otq.4.1688136322562; Fri, 30 Jun
 2023 07:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-3-aleksander.lobakin@intel.com> <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
 <ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com>
In-Reply-To: <ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 30 Jun 2023 07:44:45 -0700
Message-ID: <CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com>
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

On Fri, Jun 30, 2023 at 5:30=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander H Duyck <alexander.duyck@gmail.com>
> Date: Thu, 29 Jun 2023 09:45:26 -0700
>
> > On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
> >> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycl=
es
> >> even when on DMA-coherent platforms (like x86) with no active IOMMU or
> >> swiotlb, just for the call ladder.
> >> Indeed, it's
>
> [...]
>
> >> @@ -341,6 +345,12 @@ static bool page_pool_dma_map(struct page_pool *p=
ool, struct page *page)
> >>
> >>      page_pool_set_dma_addr(page, dma);
> >>
> >> +    if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
> >> +        dma_need_sync(pool->p.dev, dma)) {
> >> +            pool->p.flags |=3D PP_FLAG_DMA_SYNC_DEV;
> >> +            pool->p.flags &=3D ~PP_FLAG_DMA_MAYBE_SYNC;
> >> +    }
> >> +
> >>      if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> >>              page_pool_dma_sync_for_device(pool, page, pool->p.max_len=
);
> >>
> >
> > I am pretty sure the logic is flawed here. The problem is
> > dma_needs_sync depends on the DMA address being used. In the worst case
> > scenario we could have a device that has something like a 32b DMA
> > address space on a system with over 4GB of memory. In such a case the
> > higher addresses would need to be synced because they will go off to a
> > swiotlb bounce buffer while the lower addresses wouldn't.
> >
> > If you were to store a flag like this it would have to be generated per
> > page.
>
> I know when DMA might need syncing :D That's the point of this shortcut:
> if at least one page needs syncing, I disable it for the whole pool.
> It's a "better safe than sorry".
> Using a per-page flag involves more changes and might hurt some
> scenarios/setups. For example, non-coherent systems, where you always
> need to do syncs. The idea was to give some improvement when possible,
> otherwise just fallback to what we have today.

I am not a fan of having the page pool force the syncing either. Last
I knew I thought the PP_FLAG_DMA_SYNC_DEV was meant to be set by the
driver, not by the page pool API itself. The big reason for that being
that the driver in many cases will have to take care of the DMA sync
itself instead of letting the allocator take care of it.

Basically we are just trading off the dma_need_sync cost versus the
page_pool_dma_sync_for_device cost. If we think it is a win to call
dma_need_sync for every frame then maybe we should look at folding it
into page_pool_dma_sync_for_device itself since that is the only
consumer of it it or just fold it into the PP_FLAG_DMA_SYNC_DEV if
statement after the flag check rather than adding yet another flag
that will likely always be true for most devices. Otherwise you are
just adding overhead for the non-exception case and devices that don't
bother setting PP_FLAG_DMA_SYNC_DEV.
