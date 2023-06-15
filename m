Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063C2731BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjFOOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241515AbjFOOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:46:36 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43052738;
        Thu, 15 Jun 2023 07:46:35 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b2a4cb5776so5621824a34.0;
        Thu, 15 Jun 2023 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840395; x=1689432395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcbOz9pHLFBOk38AGg74VXBZ86a6qPG7DZVSA/rZI50=;
        b=Qvj316inizAAwktshPYAPULyYETZkGtZUBCjcDVyup8UunEMTyGGYhr0sY/ToeC+F9
         VWitYqtQDswQj/29IiKn/Syv8AUIucp/Ap0IUM+3pQOW/pKQhKYwR2FmdglVE89PdyWq
         rnQlsodMoHV2FrsHaJ+R/aNHyCeKrA3/HubfJXe66CQHPcgSZWfpCMsciTKkBfEdWiPr
         3IBtNkqYSv8bbYaCoe+DVRcwquJae07yufeFjyGoss3Nh6+oPDLRLLC1dGR7pBV7RPGm
         QNUuAU4GhZUCggEeIpE9cScqikccdZX5fniV1ujCot4AZdJ2DM9U7AUsapA9JwZFsAAA
         Uh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840395; x=1689432395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcbOz9pHLFBOk38AGg74VXBZ86a6qPG7DZVSA/rZI50=;
        b=JXKGJbg8BrmI5bR4Omu9LZk3i1Fs2y6qsoWc/E94Yz/ITwRi3XIgZPtt/2YIDJXS9p
         uv3xO+Buax+pnopK3GBBso7dmFW4SBWrJT2Q57SkxqfffP5QuP2jeFkY1JCg+ynA6bLV
         YItpCX7y8vAxuAg5z6PvV9r2b+bTAAJvx7UlmfIV7WwQFR+k99167/INOngMHfwMhL0T
         CLYXvHhprBHJ7NICDCJV3GQ6a+/bpEc67G8BVxAeDDctmYQGRkRHVH9qXNpl7J4JcPFo
         R+ozMs4FqnLqZlu1cg+lJq0oxdrhxH/aXa639m7QzMDxHlLMQ3qRbF4pwbyRl+FeC0SG
         qy1g==
X-Gm-Message-State: AC+VfDwpmTkf/zXg/dmKqp1Q4JpP3w4H6MaXnvNLIcY1NElwINMEDvgg
        VvPv5rdWIQa5DMMhAmtt25pwpGpjXRdIP/QrekXhNhTc
X-Google-Smtp-Source: ACHHUZ6UGw/GoO4xzLlmGqak1x2MeYWLmte9IEVaCS8IWz6cxQRpvJmKZPuNCMGP+ZQABDhN8g+6CEThwdfuMuPLyf0=
X-Received: by 2002:a05:6871:602:b0:1a9:8ec0:c5c3 with SMTP id
 w2-20020a056871060200b001a98ec0c5c3mr2536318oan.25.1686840394986; Thu, 15 Jun
 2023 07:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230609131740.7496-1-linyunsheng@huawei.com> <20230609131740.7496-4-linyunsheng@huawei.com>
 <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
 <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com> <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
In-Reply-To: <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 15 Jun 2023 07:45:58 -0700
Message-ID: <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc() API
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
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

On Wed, Jun 14, 2023 at 11:39=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2023/6/14 22:18, Alexander Duyck wrote:
> > On Tue, Jun 13, 2023 at 8:51=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/6/13 22:36, Alexander Duyck wrote:
> >>> On Fri, Jun 9, 2023 at 6:20=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>
> >> ...
> >>
> >>>>
> >>>> +static inline struct page *page_pool_alloc(struct page_pool *pool,
> >>>> +                                          unsigned int *offset,
> >>>> +                                          unsigned int *size, gfp_t=
 gfp)
> >>>> +{
> >>>> +       unsigned int max_size =3D PAGE_SIZE << pool->p.order;
> >>>> +       struct page *page;
> >>>> +
> >>>> +       *size =3D ALIGN(*size, dma_get_cache_alignment());
> >>>> +
> >>>> +       if (WARN_ON(*size > max_size))
> >>>> +               return NULL;
> >>>> +
> >>>> +       if ((*size << 1) > max_size || PAGE_POOL_DMA_USE_PP_FRAG_COU=
NT) {
> >>>> +               *size =3D max_size;
> >>>> +               *offset =3D 0;
> >>>> +               return page_pool_alloc_pages(pool, gfp);
> >>>> +       }
> >>>> +
> >>>> +       page =3D __page_pool_alloc_frag(pool, offset, *size, gfp);
> >>>> +       if (unlikely(!page))
> >>>> +               return NULL;
> >>>> +
> >>>> +       /* There is very likely not enough space for another frag, s=
o append the
> >>>> +        * remaining size to the current frag to avoid truesize unde=
restimate
> >>>> +        * problem.
> >>>> +        */
> >>>> +       if (pool->frag_offset + *size > max_size) {
> >>>> +               *size =3D max_size - *offset;
> >>>> +               pool->frag_offset =3D max_size;
> >>>> +       }
> >>>> +
> >>>
> >>> Rather than preventing a truesize underestimation this will cause one=
.
> >>> You are adding memory to the size of the page reserved and not
> >>> accounting for it anywhere as this isn't reported up to the network
> >>> stack. I would suggest dropping this from your patch.
> >>
> >> I was thinking about the driver author reporting it up to the network
> >> stack using the new API as something like below:
> >>
> >> int truesize =3D size;
> >> struct page *page;
> >> int offset;
> >>
> >> page =3D page_pool_dev_alloc(pool, &offset, &truesize);
> >> if (unlikely(!page))
> >>         goto err;
> >>
> >> skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
> >>                 offset, size, truesize);
> >>
> >> and similiar handling for *_build_skb() case too.
> >>
> >> Does it make senses for that? or did I miss something obvious here?
> >
> > It is more the fact that you are creating a solution in search of a
> > problem. As I said before most of the drivers will deal with these
> > sorts of issues by just doing the fragmentation themselves or
> > allocating fixed size frags and knowing how it will be divided into
> > the page.
>
> It seems that there are already some drivers which using the page pool
> API with different frag size for almost every calling, the virtio_net
> and veth are the obvious ones.
>
> When reviewing the page frag support for virtio_net, I found that it
> was manipulating the page_pool->frag_offset directly to do something
> as this patch does, see:
>
> https://lore.kernel.org/lkml/CAKhg4tL9PrUebqQHL+s7A6-xqNnju3erNQejMr7UFjw=
TaOduZw@mail.gmail.com/
>
> I am not sure we are both agreed that drivers should not be manipulating
> the page_pool->frag_offset directly unless it is really necessary?

Agreed, they are doing something similar to this. The difference is
though that they have chosen to do that. With your change you are
forcing driver writers into a setup that will likely not work for
most.

> For the specific case for virtio_net, it seems we have the below options:
> 1. both the driver and page pool do not handle it.
> 2. the driver handles it by manipulating the page_pool->frag_offset
>    directly.

I view 2 as being the only acceptable approach. Otherwise we are
forcing drivers into a solution that may not fit and forcing yet
another fork of allocation setups. There is a reason vendors have
already taken the approach of manipulating frag_offset directly. In
many cases trying to pre-allocate things just isn't going to work.

> 3. the page pool handles it as this patch does.

The problem is the page pool isn't handling it. It is forcing the
allocations larger without reporting them as of this patch. It is
trying to forecast what the next request is going to be which is
problematic since it doesn't have enough info to necessarily be making
such assumptions.

> Is there any other options I missed for the specific case for virtio_net?
> What is your perfer option? And why?

My advice would be to leave it to the driver.

What concerns me is that you seem to be taking the page pool API in a
direction other than what it was really intended for. For any physical
device you aren't going to necessarily know what size fragment you are
working with until you have already allocated the page and DMA has
been performed. That is why drivers such as the Mellanox driver are
fragmenting in the driver instead of allocated pre-fragmented pages.

> >
> > If you are going to go down this path then you should have a consumer
> > for the API and fully implement it instead of taking half measures and
> > making truesize underreporting worse by evicting pages earlier.
>
> I am not sure I understand what do you mean by "a consumer for the API",
> Do you mean adding a new API something like page_pool_free() to do
> something ligthweight, such as decrementing the frag user and adjusting
> the frag_offset, which is corresponding to the page_pool_alloc() API
> introduced in this patch?

What I was getting at is that if you are going to add an API you have
to have a consumer for the API. That is rule #1 for kernel API
development. You don't add API without a consumer for it. The changes
you are making are to support some future implementation, and I see it
breaking most of the existing implementation. That is my concern.
