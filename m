Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176D74A312
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGFR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGFR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:28:46 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4361BEC;
        Thu,  6 Jul 2023 10:28:44 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3461163c0b6so3518315ab.2;
        Thu, 06 Jul 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688664523; x=1691256523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1SXTCBV+Z6xgBoo5S4POlLvEQtmwzmlx2Q+dCb+w6s=;
        b=JXtteNjLih0QyL64Q/LmABAGma/dzRqiRHKu6Lh6pcxywb9ynuZKOhWSa3gmZdcltu
         Vpk+SDVj/3RWT+V8bhnlqeBlpaeQeFA8Lf8kxDVTJgjjRuEJK8ITTRXN6AAIPnmGFNiy
         BPmPKsXErgRZfxtfXBpUwA2uGHz6zjnxXpjqECPs1tpAtpXYZ5ghkaPb1wczLkV3YpVX
         Qf3ZUu6DxGhasrJ/V3NEbqBHtjd64nzs1IIjXEhL75G7IGyHyK5cGJ93NAR5K+MkCuIy
         nToEXYkkepmq42QtLveSyIeYFtysxAoJUV5Zi1pDyCOG9tfIYb5qzwv9D9K7SxE5YNfl
         FaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688664523; x=1691256523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1SXTCBV+Z6xgBoo5S4POlLvEQtmwzmlx2Q+dCb+w6s=;
        b=JD+Uo+R+7s/ZBKF5i4WfehvqexZIXtUB6+C1V+OeyHlHpK1CPJ8YBmzPmDVIbUyhlI
         JeuLmsTpfXjVmKxLvJrxxXbzgB8jpyncBXx3+F9Qd9adqjX7+IyoH7x8hGCfmOb5bvsr
         T+IbNs+C61aYe/FlAId9Kt3QwmdqkI5SFxg5xoM+0EdwpdG2dpYl7NXZvzHCgN8ldo2S
         TcgFEVUW3tGJk8BXcCSUvLnsTNjTieOAyLRGuDkac1znswni9tg/4Be2P/2c5XRqpi7u
         MEYYx20mQXdDTI9Gb5AEsd98DCvUAz0Ti16BihHL7fpP9+VvXhX1T6Vh2yVkR308VDvO
         0VyQ==
X-Gm-Message-State: ABy/qLbpWg5QBV8wFU4AyJcD+WOTm3jNqy2C5UsIBVxJPcj0wceoQwUw
        OHviYUMW1ybqNSRVgFynifBkqC0KR2jLZf14R6A=
X-Google-Smtp-Source: APBJJlELeZn1D3BplZE1EpqxswWLc/zf7f6K/JnoJRJhuWIJXvB5iCFv60TH2dS0NIvP9IW9Z5kyFPg3Cm8Lf6vepS8=
X-Received: by 2002:a92:d092:0:b0:346:d48:15e7 with SMTP id
 h18-20020a92d092000000b003460d4815e7mr2990094ilh.25.1688664523472; Thu, 06
 Jul 2023 10:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-7-aleksander.lobakin@intel.com> <CAKgT0Ud4h32UFwiUhcpLxSrPRMhbKYSDncL2YiursWgS7Qg7Ug@mail.gmail.com>
 <52963031-76be-b215-052e-a200f01d7130@intel.com>
In-Reply-To: <52963031-76be-b215-052e-a200f01d7130@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 6 Jul 2023 10:28:06 -0700
Message-ID: <CAKgT0Ufqno2z=6w6XmJ+rVeqzOnHudgsRs8Fgs+eke_cyc0hjQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 6/9] iavf: switch to
 Page Pool
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        David Christensen <drc@linux.vnet.ibm.com>
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

On Thu, Jul 6, 2023 at 9:57=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Thu, 6 Jul 2023 08:26:00 -0700
>
> > On Wed, Jul 5, 2023 at 8:58=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> Now that the IAVF driver simply uses dev_alloc_page() + free_page() wi=
th
> >> no custom recycling logics, it can easily be switched to using Page
> >> Pool / libie API instead.
> >> This allows to removing the whole dancing around headroom, HW buffer
> >> size, and page order. All DMA-for-device is now done in the PP core,
> >> for-CPU -- in the libie helper.
> >> Use skb_mark_for_recycle() to bring back the recycling and restore the
> >> performance. Speaking of performance: on par with the baseline and
> >> faster with the PP optimization series applied. But the memory usage f=
or
> >> 1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
> >> every second descriptor.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >
> > One thing I am noticing is that there seems to be a bunch of cleanup
> > changes in here as well. Things like moving around values within
> > structures which I am assuming are to fill holes. You may want to look
> > at breaking some of those out as it makes it a bit harder to review
> > this since they seem like unrelated changes.
>
> min_mtu and watchdog are unrelated, I'll drop those.
> Moving tail pointer around was supposed to land in a different commit,
> not this one, as I wrote 10 minutes ago already :s
>
> [...]
>
> >> -       bi_size =3D sizeof(struct iavf_rx_buffer) * rx_ring->count;
> >> -       memset(rx_ring->rx_bi, 0, bi_size);
> >> -
> >> -       /* Zero out the descriptor ring */
> >> -       memset(rx_ring->desc, 0, rx_ring->size);
> >> -
> >
> > I have some misgivings about not clearing these. We may want to double
> > check to verify the code paths are resilient enough that it won't
> > cause any issues w/ repeated up/down testing on the interface. The
> > general idea is to keep things consistent w/ the state after
> > setup_rx_descriptors. If we don't need this when we don't need to be
> > calling the zalloc or calloc version of things in
> > setup_rx_descriptors.
>
> Both arrays will be freed couple instructions below, why zero them?

Ugh. You are right, but not for a good reason. So the other Intel
drivers in the past would be doing the clean_rx_ring calls on the
_down() with the freeing of resources on _close(). Specifically it
allowed reducing the overhead for things like resets or setting
changes since it didn't require reallocating the descriptor rings and
buffer info structures.

I guess you are good to remove these since this code doesn't do that.

> >
> >
> >>         rx_ring->next_to_clean =3D 0;
> >>         rx_ring->next_to_use =3D 0;
> >>  }
>
> [...]
>
> >>         struct net_device *netdev;      /* netdev ring maps to */
> >>         union {
> >> +               struct libie_rx_buffer *rx_bi;
> >>                 struct iavf_tx_buffer *tx_bi;
> >> -               struct iavf_rx_buffer *rx_bi;
> >>         };
> >>         DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
> >> +       u8 __iomem *tail;
> >>         u16 queue_index;                /* Queue number of ring */
> >>         u8 dcb_tc;                      /* Traffic class of ring */
> >> -       u8 __iomem *tail;
> >>
> >>         /* high bit set means dynamic, use accessors routines to read/=
write.
> >>          * hardware only supports 2us resolution for the ITR registers=
.
> >
> > I'm assuming "tail" was moved here since it is a pointer and fills a ho=
le?
>
> (see above)
>
> >
> >> @@ -329,9 +264,8 @@ struct iavf_ring {
> >>          */
> >>         u16 itr_setting;
> >>
> >> -       u16 count;                      /* Number of descriptors */
> >>         u16 reg_idx;                    /* HW register index of the ri=
ng */
> >> -       u16 rx_buf_len;
> >> +       u16 count;                      /* Number of descriptors */
> >
> > Why move count down here? It is moving the constant value that is
> > read-mostly into an area that will be updated more often.
>
> With the ::tail put in a different slot, ::count was landing in a
> different cacheline. I wanted to avoid this. But now I feel like I was
> just lazy and must've tested both variants to see if this move affects
> performance. I'll play with this one in the next rev.

The performance impact should be minimal. Odds are the placement was
the way it was since it was probably just copying the original code
that has been there since igb/ixgbe. The general idea is just keep the
read-mostly items grouped at the top and try to order them somewhat by
frequency of being read so that wherever the cache line ends up you
won't take much of a penalty as hopefully you will just have the
infrequently read items end up getting pulled into the active cache
line.

> >
> >>         /* used in interrupt processing */
> >>         u16 next_to_use;
> >> @@ -398,17 +332,6 @@ struct iavf_ring_container {
> >>  #define iavf_for_each_ring(pos, head) \
> >>         for (pos =3D (head).ring; pos !=3D NULL; pos =3D pos->next)
> >>
> >> -static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
> >> -{
> >> -#if (PAGE_SIZE < 8192)
> >> -       if (ring->rx_buf_len > (PAGE_SIZE / 2))
> >> -               return 1;
> >> -#endif
> >> -       return 0;
> >> -}
> >> -
> >> -#define iavf_rx_pg_size(_ring) (PAGE_SIZE << iavf_rx_pg_order(_ring))
> >> -
> >
> > All this code probably could have been removed in an earlier patch
> > since I don't think we need the higher order pages once we did away
> > with the recycling. Odds are we can probably move this into the
> > recycling code removal.
>
> This went here as I merged "always use order 0" commit with "switch to
> Page Pool". In general, IIRC having removals of all the stuff at once in
> one commit (#2) was less readable than the current version, but I'll
> double-check.

It all depends on how much is having to be added to accommodate this.
In my mind when we did away with the page splitting/recycling we also
did away with the need for the higher order pages. That is why I was
thinking it might make more sense there as it would just be more
removals with very few if any additions needed to support it.


> >
> >>  bool iavf_alloc_rx_buffers(struct iavf_ring *rxr, u16 cleaned_count);
> >>  netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *n=
etdev);
> >>  int iavf_setup_tx_descriptors(struct iavf_ring *tx_ring);
>
> [...]
>
> >> @@ -309,9 +310,7 @@ void iavf_configure_queues(struct iavf_adapter *ad=
apter)
> >>                 vqpi->rxq.ring_len =3D adapter->rx_rings[i].count;
> >>                 vqpi->rxq.dma_ring_addr =3D adapter->rx_rings[i].dma;
> >>                 vqpi->rxq.max_pkt_size =3D max_frame;
> >> -               vqpi->rxq.databuffer_size =3D
> >> -                       ALIGN(adapter->rx_rings[i].rx_buf_len,
> >> -                             BIT_ULL(IAVF_RXQ_CTX_DBUFF_SHIFT));
> >
> > Is this rendered redundant by something? Seems like you should be
> > guaranteeing somewhere that you are still aligned to this.
>
> See the previous commit, the place where I calculate max_len for the PP
> params. 128 byte is Intel-wide HW req, so it lives there now.

Okay, that is the piece I missed. It was converted from a BIT_ULL(7)
to just a 128. Thanks.

> >
> >
> >> +               vqpi->rxq.databuffer_size =3D max_len;
> >>                 vqpi++;
> Thanks,
> Olek
