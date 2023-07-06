Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7583C7492DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGFBCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGFBCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:02:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA880198E;
        Wed,  5 Jul 2023 18:02:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b702319893so1043841fa.3;
        Wed, 05 Jul 2023 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688605321; x=1691197321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdhW3BVrlsULo/54PLjG3J4JAu+hcY9wjpkkIGvMDVk=;
        b=fhJ7urNLYxMtTY7Z53qgETa3l7URJ5Q1Hn0FDrmzC1R1Y8XL1xq5w+zNXL0sgyCcOq
         7YDB5DEUoLOCYHjsZLnBBPlCnagAXFdQHQKRBc7H+Tjt6JpT6h8wiJvOPnQguFIzSR6d
         gxrryDtKYxDhWLCHT+DVLVpazBPCm3wvhYj9MSG2MJOIb4etpQ/J7VAoVr1KgyHKg+TB
         8OzS9hhOh4ufZN7Ys/4iyAnvIsMtKcBKhASsx1k80SGS6xqUF03DcDwav4B4WL3Swxfe
         ebCXBN0WXvoNyZhzyMhfqeXWxwUmyFrntHnK0968U0rcf3jjjpYBSvHJREvY/W8ciOWS
         J58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688605321; x=1691197321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdhW3BVrlsULo/54PLjG3J4JAu+hcY9wjpkkIGvMDVk=;
        b=XumPGEwNIxrWVXL1iKd9iKwhk1dE/E/y+edoT4wAXlqv9iZX4Xeuwo5ZvAzsEgqqT4
         KvCD3tAJW+QddMwe+GM+mZt8X+w1MWTACjRFAuBZvJ2CfU/3Iv/YamDEJPW3ARYMfgz3
         iVU72qIQUV6PStQfoz/D2+hkHV6uppColnCe8mCDZmJkK2nOETJHZN8gxZeKkWQVpl0X
         E+uBsd4QlVtaH7fSX3qvy8AHxda6mA41Akmbd/qn+WiQCQwmJfaX1ST6BJXKeU7PfmsD
         4ykBJtm5PDS7yoh0OsU3PjpixEZOj3pEwtF96wkg0FoVccvESPKDg+qWSqC5Nw1U3wbV
         2MBQ==
X-Gm-Message-State: ABy/qLZCO3SFk+PwoZF8/fK/f86DZPj1OWFYTo8YDIgXJBl/HOpjNthP
        XZYnTLBxmkccXn7gwKpJ9VRVZPdqoM3V64+g3y4=
X-Google-Smtp-Source: APBJJlHLci1UMyLjxQoKO6T9yJbrg4QYdj52cG0cHFIeRZi15ezTggqa5CVveIjEJXArRz6S3tEiuAEqZv7A7gk21Pw=
X-Received: by 2002:a2e:8809:0:b0:2b7:15d:24 with SMTP id x9-20020a2e8809000000b002b7015d0024mr198243ljh.41.1688605320549;
 Wed, 05 Jul 2023 18:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com> <20230528021708-mutt-send-email-mst@kernel.org>
 <CAKhg4tKzW6akbKLvg1UFpey+Lkiic3hBWh87jyg-a8ASchPvMA@mail.gmail.com>
 <20230529055439-mutt-send-email-mst@kernel.org> <CAKhg4t+64E5oisgwpJvt5zwcAzKpLoNhN-cMutRuiC9D-Z7C5A@mail.gmail.com>
 <CAKhg4tKpBFgGaEq743dvYJxZFavDSyOdqbvc7mE4+_sqeSpgQQ@mail.gmail.com>
 <20230607161724-mutt-send-email-mst@kernel.org> <CACGkMEsTuHShqiruqTA9DOHvSg41s1OyqAhpP+uOwTTq61mzTw@mail.gmail.com>
 <CAKhg4tJ-=R6Us5hqDOLG2evnvjcFmhunVO1aXtFAvEe3qzH+EQ@mail.gmail.com>
 <CAKhg4tJd=MdXTYD8bdSwOqdEJ=7Ukvv+13PE4kC96wL+m6-ctA@mail.gmail.com> <CACGkMEtvq6LkJFiV2SdGf0s+_VgDaNePX118_ikXgNDazyLY0A@mail.gmail.com>
In-Reply-To: <CACGkMEtvq6LkJFiV2SdGf0s+_VgDaNePX118_ikXgNDazyLY0A@mail.gmail.com>
From:   Liang Chen <liangchen.linux@gmail.com>
Date:   Thu, 6 Jul 2023 09:01:47 +0800
Message-ID: <CAKhg4tLqxEiO-v-oorT0vy-X1=UbnQ0d=ZLF_HZEz8m-5+i-UA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve performance
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, alexander.duyck@gmail.com
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

On Wed, Jul 5, 2023 at 2:05=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Jul 5, 2023 at 1:41=E2=80=AFPM Liang Chen <liangchen.linux@gmail.=
com> wrote:
> >
> > On Fri, Jun 9, 2023 at 10:57=E2=80=AFAM Liang Chen <liangchen.linux@gma=
il.com> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 8:38=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Thu, Jun 8, 2023 at 4:17=E2=80=AFAM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Wed, Jun 07, 2023 at 05:08:59PM +0800, Liang Chen wrote:
> > > > > > On Tue, May 30, 2023 at 9:19=E2=80=AFAM Liang Chen <liangchen.l=
inux@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, May 29, 2023 at 5:55=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, May 29, 2023 at 03:27:56PM +0800, Liang Chen wrote:
> > > > > > > > > On Sun, May 28, 2023 at 2:20=E2=80=AFPM Michael S. Tsirki=
n <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, May 26, 2023 at 01:46:18PM +0800, Liang Chen wr=
ote:
> > > > > > > > > > > The implementation at the moment uses one page per pa=
cket in both the
> > > > > > > > > > > normal and XDP path. In addition, introducing a modul=
e parameter to enable
> > > > > > > > > > > or disable the usage of page pool (disabled by defaul=
t).
> > > > > > > > > > >
> > > > > > > > > > > In single-core vm testing environments, it gives a mo=
dest performance gain
> > > > > > > > > > > in the normal path.
> > > > > > > > > > >   Upstream codebase: 47.5 Gbits/sec
> > > > > > > > > > >   Upstream codebase + page_pool support: 50.2 Gbits/s=
ec
> > > > > > > > > > >
> > > > > > > > > > > In multi-core vm testing environments, The most signi=
ficant performance
> > > > > > > > > > > gain is observed in XDP cpumap:
> > > > > > > > > > >   Upstream codebase: 1.38 Gbits/sec
> > > > > > > > > > >   Upstream codebase + page_pool support: 9.74 Gbits/s=
ec
> > > > > > > > > > >
> > > > > > > > > > > With this foundation, we can further integrate page p=
ool fragmentation and
> > > > > > > > > > > DMA map/unmap support.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > > > > > > > >
> > > > > > > > > > Why off by default?
> > > > > > > > > > I am guessing it sometimes has performance costs too?
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > What happens if we use page pool for big mode too?
> > > > > > > > > > The less modes we have the better...
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Sure, now I believe it makes sense to enable it by defaul=
t. When the
> > > > > > > > > packet size is very small, it reduces the likelihood of s=
kb
> > > > > > > > > coalescing. But such cases are rare.
> > > > > > > >
> > > > > > > > small packets are rare? These workloads are easy to create =
actually.
> > > > > > > > Pls try and include benchmark with small packet size.
> > > > > > > >
> > > > > > >
> > > > > > > Sure, Thanks!
> > > > > >
> > > > > > Before going ahead and posting v2 patch, I would like to hear m=
ore
> > > > > > advice for the cases of small packets. I have done more perform=
ance
> > > > > > benchmark with small packets since then. Here is a list of iper=
f
> > > > > > output,
> > > > > >
> > > > > > With PP and PP fragmenting:
> > > > > > 256K:   [  5] 505.00-510.00 sec  1.34 GBytes  2.31 Gbits/sec   =
 0    144 KBytes
> > > > > > 1K:       [  5]  30.00-35.00  sec  4.63 GBytes  7.95 Gbits/sec =
   0
> > > > > > 223 KBytes
> > > > > > 2K:       [  5]  65.00-70.00  sec  8.33 GBytes  14.3 Gbits/sec =
   0
> > > > > > 324 KBytes
> > > > > > 4K:       [  5]  30.00-35.00  sec  13.3 GBytes  22.8 Gbits/sec =
   0
> > > > > > 1.08 MBytes
> > > > > > 8K:       [  5]  50.00-55.00  sec  18.9 GBytes  32.4 Gbits/sec =
   0
> > > > > > 744 KBytes
> > > > > > 16K:     [  5]  25.00-30.00  sec  24.6 GBytes  42.3 Gbits/sec  =
  0    963 KBytes
> > > > > > 32K:     [  5]  45.00-50.00  sec  29.8 GBytes  51.2 Gbits/sec  =
  0   1.25 MBytes
> > > > > > 64K:     [  5]  35.00-40.00  sec  34.0 GBytes  58.4 Gbits/sec  =
  0   1.70 MBytes
> > > > > > 128K:   [  5]  45.00-50.00  sec  36.7 GBytes  63.1 Gbits/sec   =
 0   4.26 MBytes
> > > > > > 256K:   [  5]  30.00-35.00  sec  40.0 GBytes  68.8 Gbits/sec   =
 0   3.20 MBytes
> > > >
> > > > Note that virtio-net driver is lacking things like BQL and others, =
so
> > > > it might suffer from buffer bloat for TCP performance. Would you mi=
nd
> > > > to measure with e.g using testpmd on the vhost to see the rx PPS?
> > > >
> > >
> > > No problem. Before we proceed to measure with testpmd, could you
> > > please take a look at the PPS measurements we obtained previously and
> > > see if they are sufficient? Though we will only utilize page pool for
> > > xdp on v2.
> > >
> > > netperf -H 192.168.124.197 -p 4444 -t UDP_STREAM -l 0 -- -m $((1))
> > >
> > > with page pool:
> > > 1.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 655092.27      0.35  27508.77      0.03
> > > 0.00      0.00      0.00      0.00
> > > 2.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 654749.87      0.63  27494.42      0.05
> > > 0.00      0.00      0.00      0.00
> > > 3.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 654230.40      0.10  27472.57      0.01
> > > 0.00      0.00      0.00      0.00
> > > 4.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 656661.33      0.15  27574.65      0.01
> > > 0.00      0.00      0.00      0.00
> > >
> > >
> > > without page pool:
> > > 1.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 646515.20      0.47  27148.60      0.04
> > > 0.00      0.00      0.00      0.00
> > > 2.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 653874.13      0.18  27457.61      0.02
> > > 0.00      0.00      0.00      0.00
> > > 3.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 647246.93      0.15  27179.32      0.01
> > > 0.00      0.00      0.00      0.00
> > > 4.
> > > Average:        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
> > > rxcmp/s   txcmp/s  rxmcst/s   %ifutil
> > > Average:       enp8s0 650625.07      0.27  27321.18      0.02
> > > 0.00      0.00      0.00      0.00
> > >
> > >
> > > (655092+654749+654230+656661)/(646515+653874+647246+650625) =3D
> > > 1.00864886500966031113
> > > On average it gives around 0.8% increase in PPS, and this figure can
> > > be reproduced consistently.
> > >
> > > > > >
> > > > > > Without PP:
> > > > > > 256:     [  5] 680.00-685.00 sec  1.57 GBytes  2.69 Gbits/sec  =
  0    359 KBytes
> > > > > > 1K:      [  5]  75.00-80.00  sec  5.47 GBytes  9.40 Gbits/sec  =
  0    730 KBytes
> > > > > > 2K:      [  5]  65.00-70.00  sec  9.46 GBytes  16.2 Gbits/sec  =
  0   1.99 MBytes
> > > > > > 4K:      [  5]  30.00-35.00  sec  14.5 GBytes  25.0 Gbits/sec  =
  0   1.20 MBytes
> > > > > > 8K:      [  5]  45.00-50.00  sec  19.9 GBytes  34.1 Gbits/sec  =
  0   1.72 MBytes
> > > > > > 16K:    [  5]   5.00-10.00  sec  23.8 GBytes  40.9 Gbits/sec   =
 0   2.90 MBytes
> > > > > > 32K:    [  5]  15.00-20.00  sec  28.0 GBytes  48.1 Gbits/sec   =
 0   3.03 MBytes
> > > > > > 64K:    [  5]  60.00-65.00  sec  31.8 GBytes  54.6 Gbits/sec   =
 0   3.05 MBytes
> > > > > > 128K:  [  5]  45.00-50.00  sec  33.0 GBytes  56.6 Gbits/sec    =
1   3.03 MBytes
> > > > > > 256K:  [  5]  25.00-30.00  sec  34.7 GBytes  59.6 Gbits/sec    =
0   3.11 MBytes
> > > > > >
> > > > > >
> > > > > > The major factor contributing to the performance drop is the re=
duction
> > > > > > of skb coalescing. Additionally, without the page pool, small p=
ackets
> > > > > > can still benefit from the allocation of 8 continuous pages by
> > > > > > breaking them down into smaller pieces. This effectively reduce=
s the
> > > > > > frequency of page allocation from the buddy system. For instanc=
e, the
> > > > > > arrival of 32 1K packets only triggers one alloc_page call. The=
refore,
> > > > > > the benefits of using a page pool are limited in such cases.
> > > >
> > > > I wonder if we can improve page pool in this case anyhow.
> > > >
> > >
> > > We would like to make the effort to enhance skb coalecsing to be more
> > > friendly with page pool buffers. But that involves modifications to
> > > some core data structure of mm.
> > >
> > >
> >
> > Just to give an update on the status of v2 progress. We have
> > identified the specific situation where skb coalescing is affected by
> > page pool and small packets. In summary, it was because, in our
> > environment (Fedora 37 default network setup), NetworkManager creates
> > a SOCK_DGRAM socket, which eventually results in skbs being cloned,
> > thus causing the failure of skb coalescing.
> >
> > While it affects small packet performance in our environment, it
> > doesn't necessarily have the same impact for other users.
> > Nevertheless, we are trying to make an optimization to allow skb
> > coalescing in that situation. It may take some time as we are advised
> > to wait for some relevant prior patches to land first.
> > (https://patchwork.kernel.org/project/netdevbpf/patch/20230628121150.47=
778-1-liangchen.linux@gmail.com/)
>
> If it's not too late, I would like to be copied in the next version of
> this. (Since it seems to be suggested by me).
>

Sure, no problem. It indeed was suggested by you.

Thanks,
Liang

> >
> > In addition, if small packet performance is not dropping anymore,
> > perhaps we can enable page pool for the normal path as well.
>
> It would be simpler if we start from XDP and normal on top. But it's
> your call anyway.
>
> Thanks
>
> >
> >
> > Thanks,
> > Liang
> >
> >
> >
> > > > > In fact,
> > > > > > without page pool fragmenting enabled, it can even hinder perfo=
rmance
> > > > > > from this perspective.
> > > > > >
> > > > > > Upon further consideration, I tend to believe making page pool =
the
> > > > > > default option may not be appropriate. As you pointed out, we c=
annot
> > > > > > simply ignore the performance impact on small packets. Any comm=
ents on
> > > > > > this will be much appreciated.
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Liang
> > > > >
> > > > >
> > > > > So, let's only use page pool for XDP then?
> > > >
> > > > +1
> > > >
> > > > We can start from this.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > > > > The usage of page pool for big mode is being evaluated no=
w. Thanks!
> > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/net/virtio_net.c | 188 +++++++++++++++++++++=
+++++++++---------
> > > > > > > > > > >  1 file changed, 146 insertions(+), 42 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/v=
irtio_net.c
> > > > > > > > > > > index c5dca0d92e64..99c0ca0c1781 100644
> > > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > > @@ -31,6 +31,9 @@ module_param(csum, bool, 0444);
> > > > > > > > > > >  module_param(gso, bool, 0444);
> > > > > > > > > > >  module_param(napi_tx, bool, 0644);
> > > > > > > > > > >
> > > > > > > > > > > +static bool page_pool_enabled;
> > > > > > > > > > > +module_param(page_pool_enabled, bool, 0400);
> > > > > > > > > > > +
> > > > > > > > > > >  /* FIXME: MTU in config. */
> > > > > > > > > > >  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_=
DATA_LEN)
> > > > > > > > > > >  #define GOOD_COPY_LEN        128
> > > > > > > > > > > @@ -159,6 +162,9 @@ struct receive_queue {
> > > > > > > > > > >       /* Chain pages by the private ptr. */
> > > > > > > > > > >       struct page *pages;
> > > > > > > > > > >
> > > > > > > > > > > +     /* Page pool */
> > > > > > > > > > > +     struct page_pool *page_pool;
> > > > > > > > > > > +
> > > > > > > > > > >       /* Average packet length for mergeable receive =
buffers. */
> > > > > > > > > > >       struct ewma_pkt_len mrg_avg_pkt_len;
> > > > > > > > > > >
> > > > > > > > > > > @@ -459,6 +465,14 @@ static struct sk_buff *virtnet_b=
uild_skb(void *buf, unsigned int buflen,
> > > > > > > > > > >       return skb;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static void virtnet_put_page(struct receive_queue *r=
q, struct page *page)
> > > > > > > > > > > +{
> > > > > > > > > > > +     if (rq->page_pool)
> > > > > > > > > > > +             page_pool_put_full_page(rq->page_pool, =
page, true);
> > > > > > > > > > > +     else
> > > > > > > > > > > +             put_page(page);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /* Called from bottom half context */
> > > > > > > > > > >  static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
> > > > > > > > > > >                                  struct receive_queue=
 *rq,
> > > > > > > > > > > @@ -555,7 +569,7 @@ static struct sk_buff *page_to_sk=
b(struct virtnet_info *vi,
> > > > > > > > > > >       hdr =3D skb_vnet_hdr(skb);
> > > > > > > > > > >       memcpy(hdr, hdr_p, hdr_len);
> > > > > > > > > > >       if (page_to_free)
> > > > > > > > > > > -             put_page(page_to_free);
> > > > > > > > > > > +             virtnet_put_page(rq, page_to_free);
> > > > > > > > > > >
> > > > > > > > > > >       return skb;
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -802,7 +816,7 @@ static int virtnet_xdp_xmit(struc=
t net_device *dev,
> > > > > > > > > > >       return ret;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > -static void put_xdp_frags(struct xdp_buff *xdp)
> > > > > > > > > > > +static void put_xdp_frags(struct xdp_buff *xdp, stru=
ct receive_queue *rq)
> > > > > > > > > > >  {
> > > > > > > > > > >       struct skb_shared_info *shinfo;
> > > > > > > > > > >       struct page *xdp_page;
> > > > > > > > > > > @@ -812,7 +826,7 @@ static void put_xdp_frags(struct =
xdp_buff *xdp)
> > > > > > > > > > >               shinfo =3D xdp_get_shared_info_from_buf=
f(xdp);
> > > > > > > > > > >               for (i =3D 0; i < shinfo->nr_frags; i++=
) {
> > > > > > > > > > >                       xdp_page =3D skb_frag_page(&shi=
nfo->frags[i]);
> > > > > > > > > > > -                     put_page(xdp_page);
> > > > > > > > > > > +                     virtnet_put_page(rq, xdp_page);
> > > > > > > > > > >               }
> > > > > > > > > > >       }
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -903,7 +917,11 @@ static struct page *xdp_lineariz=
e_page(struct receive_queue *rq,
> > > > > > > > > > >       if (page_off + *len + tailroom > PAGE_SIZE)
> > > > > > > > > > >               return NULL;
> > > > > > > > > > >
> > > > > > > > > > > -     page =3D alloc_page(GFP_ATOMIC);
> > > > > > > > > > > +     if (rq->page_pool)
> > > > > > > > > > > +             page =3D page_pool_dev_alloc_pages(rq->=
page_pool);
> > > > > > > > > > > +     else
> > > > > > > > > > > +             page =3D alloc_page(GFP_ATOMIC);
> > > > > > > > > > > +
> > > > > > > > > > >       if (!page)
> > > > > > > > > > >               return NULL;
> > > > > > > > > > >
> > > > > > > > > > > @@ -926,21 +944,24 @@ static struct page *xdp_lineari=
ze_page(struct receive_queue *rq,
> > > > > > > > > > >                * is sending packet larger than the MT=
U.
> > > > > > > > > > >                */
> > > > > > > > > > >               if ((page_off + buflen + tailroom) > PA=
GE_SIZE) {
> > > > > > > > > > > -                     put_page(p);
> > > > > > > > > > > +                     virtnet_put_page(rq, p);
> > > > > > > > > > >                       goto err_buf;
> > > > > > > > > > >               }
> > > > > > > > > > >
> > > > > > > > > > >               memcpy(page_address(page) + page_off,
> > > > > > > > > > >                      page_address(p) + off, buflen);
> > > > > > > > > > >               page_off +=3D buflen;
> > > > > > > > > > > -             put_page(p);
> > > > > > > > > > > +             virtnet_put_page(rq, p);
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > >       /* Headroom does not contribute to packet lengt=
h */
> > > > > > > > > > >       *len =3D page_off - VIRTIO_XDP_HEADROOM;
> > > > > > > > > > >       return page;
> > > > > > > > > > >  err_buf:
> > > > > > > > > > > -     __free_pages(page, 0);
> > > > > > > > > > > +     if (rq->page_pool)
> > > > > > > > > > > +             page_pool_put_full_page(rq->page_pool, =
page, true);
> > > > > > > > > > > +     else
> > > > > > > > > > > +             __free_pages(page, 0);
> > > > > > > > > > >       return NULL;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > @@ -1144,7 +1165,7 @@ static void mergeable_buf_free(=
struct receive_queue *rq, int num_buf,
> > > > > > > > > > >               }
> > > > > > > > > > >               stats->bytes +=3D len;
> > > > > > > > > > >               page =3D virt_to_head_page(buf);
> > > > > > > > > > > -             put_page(page);
> > > > > > > > > > > +             virtnet_put_page(rq, page);
> > > > > > > > > > >       }
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > @@ -1264,7 +1285,7 @@ static int virtnet_build_xdp_bu=
ff_mrg(struct net_device *dev,
> > > > > > > > > > >               cur_frag_size =3D truesize;
> > > > > > > > > > >               xdp_frags_truesz +=3D cur_frag_size;
> > > > > > > > > > >               if (unlikely(len > truesize - room || c=
ur_frag_size > PAGE_SIZE)) {
> > > > > > > > > > > -                     put_page(page);
> > > > > > > > > > > +                     virtnet_put_page(rq, page);
> > > > > > > > > > >                       pr_debug("%s: rx error: len %u =
exceeds truesize %lu\n",
> > > > > > > > > > >                                dev->name, len, (unsig=
ned long)(truesize - room));
> > > > > > > > > > >                       dev->stats.rx_length_errors++;
> > > > > > > > > > > @@ -1283,7 +1304,7 @@ static int virtnet_build_xdp_bu=
ff_mrg(struct net_device *dev,
> > > > > > > > > > >       return 0;
> > > > > > > > > > >
> > > > > > > > > > >  err:
> > > > > > > > > > > -     put_xdp_frags(xdp);
> > > > > > > > > > > +     put_xdp_frags(xdp, rq);
> > > > > > > > > > >       return -EINVAL;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > @@ -1344,7 +1365,10 @@ static void *mergeable_xdp_get=
_buf(struct virtnet_info *vi,
> > > > > > > > > > >               if (*len + xdp_room > PAGE_SIZE)
> > > > > > > > > > >                       return NULL;
> > > > > > > > > > >
> > > > > > > > > > > -             xdp_page =3D alloc_page(GFP_ATOMIC);
> > > > > > > > > > > +             if (rq->page_pool)
> > > > > > > > > > > +                     xdp_page =3D page_pool_dev_allo=
c_pages(rq->page_pool);
> > > > > > > > > > > +             else
> > > > > > > > > > > +                     xdp_page =3D alloc_page(GFP_ATO=
MIC);
> > > > > > > > > > >               if (!xdp_page)
> > > > > > > > > > >                       return NULL;
> > > > > > > > > > >
> > > > > > > > > > > @@ -1354,7 +1378,7 @@ static void *mergeable_xdp_get_=
buf(struct virtnet_info *vi,
> > > > > > > > > > >
> > > > > > > > > > >       *frame_sz =3D PAGE_SIZE;
> > > > > > > > > > >
> > > > > > > > > > > -     put_page(*page);
> > > > > > > > > > > +     virtnet_put_page(rq, *page);
> > > > > > > > > > >
> > > > > > > > > > >       *page =3D xdp_page;
> > > > > > > > > > >
> > > > > > > > > > > @@ -1400,6 +1424,8 @@ static struct sk_buff *receive_=
mergeable_xdp(struct net_device *dev,
> > > > > > > > > > >               head_skb =3D build_skb_from_xdp_buff(de=
v, vi, &xdp, xdp_frags_truesz);
> > > > > > > > > > >               if (unlikely(!head_skb))
> > > > > > > > > > >                       break;
> > > > > > > > > > > +             if (rq->page_pool)
> > > > > > > > > > > +                     skb_mark_for_recycle(head_skb);
> > > > > > > > > > >               return head_skb;
> > > > > > > > > > >
> > > > > > > > > > >       case XDP_TX:
> > > > > > > > > > > @@ -1410,10 +1436,10 @@ static struct sk_buff *receiv=
e_mergeable_xdp(struct net_device *dev,
> > > > > > > > > > >               break;
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > > -     put_xdp_frags(&xdp);
> > > > > > > > > > > +     put_xdp_frags(&xdp, rq);
> > > > > > > > > > >
> > > > > > > > > > >  err_xdp:
> > > > > > > > > > > -     put_page(page);
> > > > > > > > > > > +     virtnet_put_page(rq, page);
> > > > > > > > > > >       mergeable_buf_free(rq, num_buf, dev, stats);
> > > > > > > > > > >
> > > > > > > > > > >       stats->xdp_drops++;
> > > > > > > > > > > @@ -1467,6 +1493,9 @@ static struct sk_buff *receive_=
mergeable(struct net_device *dev,
> > > > > > > > > > >       head_skb =3D page_to_skb(vi, rq, page, offset, =
len, truesize, headroom);
> > > > > > > > > > >       curr_skb =3D head_skb;
> > > > > > > > > > >
> > > > > > > > > > > +     if (rq->page_pool)
> > > > > > > > > > > +             skb_mark_for_recycle(curr_skb);
> > > > > > > > > > > +
> > > > > > > > > > >       if (unlikely(!curr_skb))
> > > > > > > > > > >               goto err_skb;
> > > > > > > > > > >       while (--num_buf) {
> > > > > > > > > > > @@ -1509,6 +1538,8 @@ static struct sk_buff *receive_=
mergeable(struct net_device *dev,
> > > > > > > > > > >                       curr_skb =3D nskb;
> > > > > > > > > > >                       head_skb->truesize +=3D nskb->t=
ruesize;
> > > > > > > > > > >                       num_skb_frags =3D 0;
> > > > > > > > > > > +                     if (rq->page_pool)
> > > > > > > > > > > +                             skb_mark_for_recycle(cu=
rr_skb);
> > > > > > > > > > >               }
> > > > > > > > > > >               if (curr_skb !=3D head_skb) {
> > > > > > > > > > >                       head_skb->data_len +=3D len;
> > > > > > > > > > > @@ -1517,7 +1548,7 @@ static struct sk_buff *receive_=
mergeable(struct net_device *dev,
> > > > > > > > > > >               }
> > > > > > > > > > >               offset =3D buf - page_address(page);
> > > > > > > > > > >               if (skb_can_coalesce(curr_skb, num_skb_=
frags, page, offset)) {
> > > > > > > > > > > -                     put_page(page);
> > > > > > > > > > > +                     virtnet_put_page(rq, page);
> > > > > > > > > > >                       skb_coalesce_rx_frag(curr_skb, =
num_skb_frags - 1,
> > > > > > > > > > >                                            len, trues=
ize);
> > > > > > > > > > >               } else {
> > > > > > > > > > > @@ -1530,7 +1561,7 @@ static struct sk_buff *receive_=
mergeable(struct net_device *dev,
> > > > > > > > > > >       return head_skb;
> > > > > > > > > > >
> > > > > > > > > > >  err_skb:
> > > > > > > > > > > -     put_page(page);
> > > > > > > > > > > +     virtnet_put_page(rq, page);
> > > > > > > > > > >       mergeable_buf_free(rq, num_buf, dev, stats);
> > > > > > > > > > >
> > > > > > > > > > >  err_buf:
> > > > > > > > > > > @@ -1737,31 +1768,40 @@ static int add_recvbuf_mergea=
ble(struct virtnet_info *vi,
> > > > > > > > > > >        * disabled GSO for XDP, it won't be a big issu=
e.
> > > > > > > > > > >        */
> > > > > > > > > > >       len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_=
pkt_len, room);
> > > > > > > > > > > -     if (unlikely(!skb_page_frag_refill(len + room, =
alloc_frag, gfp)))
> > > > > > > > > > > -             return -ENOMEM;
> > > > > > > > > > > +     if (rq->page_pool) {
> > > > > > > > > > > +             struct page *page;
> > > > > > > > > > >
> > > > > > > > > > > -     buf =3D (char *)page_address(alloc_frag->page) =
+ alloc_frag->offset;
> > > > > > > > > > > -     buf +=3D headroom; /* advance address leaving h=
ole at front of pkt */
> > > > > > > > > > > -     get_page(alloc_frag->page);
> > > > > > > > > > > -     alloc_frag->offset +=3D len + room;
> > > > > > > > > > > -     hole =3D alloc_frag->size - alloc_frag->offset;
> > > > > > > > > > > -     if (hole < len + room) {
> > > > > > > > > > > -             /* To avoid internal fragmentation, if =
there is very likely not
> > > > > > > > > > > -              * enough space for another buffer, add=
 the remaining space to
> > > > > > > > > > > -              * the current buffer.
> > > > > > > > > > > -              * XDP core assumes that frame_size of =
xdp_buff and the length
> > > > > > > > > > > -              * of the frag are PAGE_SIZE, so we dis=
able the hole mechanism.
> > > > > > > > > > > -              */
> > > > > > > > > > > -             if (!headroom)
> > > > > > > > > > > -                     len +=3D hole;
> > > > > > > > > > > -             alloc_frag->offset +=3D hole;
> > > > > > > > > > > -     }
> > > > > > > > > > > +             page =3D page_pool_dev_alloc_pages(rq->=
page_pool);
> > > > > > > > > > > +             if (unlikely(!page))
> > > > > > > > > > > +                     return -ENOMEM;
> > > > > > > > > > > +             buf =3D (char *)page_address(page);
> > > > > > > > > > > +             buf +=3D headroom; /* advance address l=
eaving hole at front of pkt */
> > > > > > > > > > > +     } else {
> > > > > > > > > > > +             if (unlikely(!skb_page_frag_refill(len =
+ room, alloc_frag, gfp)))
> > > > > > > > > > > +                     return -ENOMEM;
> > > > > > > > > > >
> > > > > > > > > > > +             buf =3D (char *)page_address(alloc_frag=
->page) + alloc_frag->offset;
> > > > > > > > > > > +             buf +=3D headroom; /* advance address l=
eaving hole at front of pkt */
> > > > > > > > > > > +             get_page(alloc_frag->page);
> > > > > > > > > > > +             alloc_frag->offset +=3D len + room;
> > > > > > > > > > > +             hole =3D alloc_frag->size - alloc_frag-=
>offset;
> > > > > > > > > > > +             if (hole < len + room) {
> > > > > > > > > > > +                     /* To avoid internal fragmentat=
ion, if there is very likely not
> > > > > > > > > > > +                      * enough space for another buf=
fer, add the remaining space to
> > > > > > > > > > > +                      * the current buffer.
> > > > > > > > > > > +                      * XDP core assumes that frame_=
size of xdp_buff and the length
> > > > > > > > > > > +                      * of the frag are PAGE_SIZE, s=
o we disable the hole mechanism.
> > > > > > > > > > > +                      */
> > > > > > > > > > > +                     if (!headroom)
> > > > > > > > > > > +                             len +=3D hole;
> > > > > > > > > > > +                     alloc_frag->offset +=3D hole;
> > > > > > > > > > > +             }
> > > > > > > > > > > +     }
> > > > > > > > > > >       sg_init_one(rq->sg, buf, len);
> > > > > > > > > > >       ctx =3D mergeable_len_to_ctx(len + room, headro=
om);
> > > > > > > > > > >       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg,=
 1, buf, ctx, gfp);
> > > > > > > > > > >       if (err < 0)
> > > > > > > > > > > -             put_page(virt_to_head_page(buf));
> > > > > > > > > > > +             virtnet_put_page(rq, virt_to_head_page(=
buf));
> > > > > > > > > > >
> > > > > > > > > > >       return err;
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -1994,8 +2034,15 @@ static int virtnet_enable_queu=
e_pair(struct virtnet_info *vi, int qp_index)
> > > > > > > > > > >       if (err < 0)
> > > > > > > > > > >               return err;
> > > > > > > > > > >
> > > > > > > > > > > -     err =3D xdp_rxq_info_reg_mem_model(&vi->rq[qp_i=
ndex].xdp_rxq,
> > > > > > > > > > > -                                      MEM_TYPE_PAGE_=
SHARED, NULL);
> > > > > > > > > > > +     if (vi->rq[qp_index].page_pool)
> > > > > > > > > > > +             err =3D xdp_rxq_info_reg_mem_model(&vi-=
>rq[qp_index].xdp_rxq,
> > > > > > > > > > > +                                              MEM_TY=
PE_PAGE_POOL,
> > > > > > > > > > > +                                              vi->rq=
[qp_index].page_pool);
> > > > > > > > > > > +     else
> > > > > > > > > > > +             err =3D xdp_rxq_info_reg_mem_model(&vi-=
>rq[qp_index].xdp_rxq,
> > > > > > > > > > > +                                              MEM_TY=
PE_PAGE_SHARED,
> > > > > > > > > > > +                                              NULL);
> > > > > > > > > > > +
> > > > > > > > > > >       if (err < 0)
> > > > > > > > > > >               goto err_xdp_reg_mem_model;
> > > > > > > > > > >
> > > > > > > > > > > @@ -2951,6 +2998,7 @@ static void virtnet_get_strings=
(struct net_device *dev, u32 stringset, u8 *data)
> > > > > > > > > > >                               ethtool_sprintf(&p, "tx=
_queue_%u_%s", i,
> > > > > > > > > > >                                               virtnet=
_sq_stats_desc[j].desc);
> > > > > > > > > > >               }
> > > > > > > > > > > +             page_pool_ethtool_stats_get_strings(p);
> > > > > > > > > > >               break;
> > > > > > > > > > >       }
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -2962,12 +3010,30 @@ static int virtnet_get_sset_c=
ount(struct net_device *dev, int sset)
> > > > > > > > > > >       switch (sset) {
> > > > > > > > > > >       case ETH_SS_STATS:
> > > > > > > > > > >               return vi->curr_queue_pairs * (VIRTNET_=
RQ_STATS_LEN +
> > > > > > > > > > > -                                            VIRTNET_=
SQ_STATS_LEN);
> > > > > > > > > > > +                                            VIRTNET_=
SQ_STATS_LEN +
> > > > > > > > > > > +                                             (page_p=
ool_enabled && vi->mergeable_rx_bufs ?
> > > > > > > > > > > +                                              page_p=
ool_ethtool_stats_get_count() : 0));
> > > > > > > > > > >       default:
> > > > > > > > > > >               return -EOPNOTSUPP;
> > > > > > > > > > >       }
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static void virtnet_get_page_pool_stats(struct net_d=
evice *dev, u64 *data)
> > > > > > > > > > > +{
> > > > > > > > > > > +#ifdef CONFIG_PAGE_POOL_STATS
> > > > > > > > > > > +     struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > > > > > > +     struct page_pool_stats pp_stats =3D {};
> > > > > > > > > > > +     int i;
> > > > > > > > > > > +
> > > > > > > > > > > +     for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> > > > > > > > > > > +             if (!vi->rq[i].page_pool)
> > > > > > > > > > > +                     continue;
> > > > > > > > > > > +             page_pool_get_stats(vi->rq[i].page_pool=
, &pp_stats);
> > > > > > > > > > > +     }
> > > > > > > > > > > +     page_pool_ethtool_stats_get(data, &pp_stats);
> > > > > > > > > > > +#endif /* CONFIG_PAGE_POOL_STATS */
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static void virtnet_get_ethtool_stats(struct net_dev=
ice *dev,
> > > > > > > > > > >                                     struct ethtool_st=
ats *stats, u64 *data)
> > > > > > > > > > >  {
> > > > > > > > > > > @@ -3003,6 +3069,8 @@ static void virtnet_get_ethtool=
_stats(struct net_device *dev,
> > > > > > > > > > >               } while (u64_stats_fetch_retry(&sq->sta=
ts.syncp, start));
> > > > > > > > > > >               idx +=3D VIRTNET_SQ_STATS_LEN;
> > > > > > > > > > >       }
> > > > > > > > > > > +
> > > > > > > > > > > +     virtnet_get_page_pool_stats(dev, &data[idx]);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static void virtnet_get_channels(struct net_device *=
dev,
> > > > > > > > > > > @@ -3623,6 +3691,8 @@ static void virtnet_free_queues=
(struct virtnet_info *vi)
> > > > > > > > > > >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > > > > > > >               __netif_napi_del(&vi->rq[i].napi);
> > > > > > > > > > >               __netif_napi_del(&vi->sq[i].napi);
> > > > > > > > > > > +             if (vi->rq[i].page_pool)
> > > > > > > > > > > +                     page_pool_destroy(vi->rq[i].pag=
e_pool);
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > >       /* We called __netif_napi_del(),
> > > > > > > > > > > @@ -3679,12 +3749,19 @@ static void virtnet_rq_free_u=
nused_buf(struct virtqueue *vq, void *buf)
> > > > > > > > > > >       struct virtnet_info *vi =3D vq->vdev->priv;
> > > > > > > > > > >       int i =3D vq2rxq(vq);
> > > > > > > > > > >
> > > > > > > > > > > -     if (vi->mergeable_rx_bufs)
> > > > > > > > > > > -             put_page(virt_to_head_page(buf));
> > > > > > > > > > > -     else if (vi->big_packets)
> > > > > > > > > > > +     if (vi->mergeable_rx_bufs) {
> > > > > > > > > > > +             if (vi->rq[i].page_pool) {
> > > > > > > > > > > +                     page_pool_put_full_page(vi->rq[=
i].page_pool,
> > > > > > > > > > > +                                             virt_to=
_head_page(buf),
> > > > > > > > > > > +                                             true);
> > > > > > > > > > > +             } else {
> > > > > > > > > > > +                     put_page(virt_to_head_page(buf)=
);
> > > > > > > > > > > +             }
> > > > > > > > > > > +     } else if (vi->big_packets) {
> > > > > > > > > > >               give_pages(&vi->rq[i], buf);
> > > > > > > > > > > -     else
> > > > > > > > > > > +     } else {
> > > > > > > > > > >               put_page(virt_to_head_page(buf));
> > > > > > > > > > > +     }
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static void free_unused_bufs(struct virtnet_info *vi=
)
> > > > > > > > > > > @@ -3718,6 +3795,26 @@ static void virtnet_del_vqs(st=
ruct virtnet_info *vi)
> > > > > > > > > > >       virtnet_free_queues(vi);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static void virtnet_alloc_page_pool(struct receive_q=
ueue *rq)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct virtio_device *vdev =3D rq->vq->vdev;
> > > > > > > > > > > +
> > > > > > > > > > > +     struct page_pool_params pp_params =3D {
> > > > > > > > > > > +             .order =3D 0,
> > > > > > > > > > > +             .pool_size =3D rq->vq->num_max,
> > > > > > > > > > > +             .nid =3D dev_to_node(vdev->dev.parent),
> > > > > > > > > > > +             .dev =3D vdev->dev.parent,
> > > > > > > > > > > +             .offset =3D 0,
> > > > > > > > > > > +     };
> > > > > > > > > > > +
> > > > > > > > > > > +     rq->page_pool =3D page_pool_create(&pp_params);
> > > > > > > > > > > +     if (IS_ERR(rq->page_pool)) {
> > > > > > > > > > > +             dev_warn(&vdev->dev, "page pool creatio=
n failed: %ld\n",
> > > > > > > > > > > +                      PTR_ERR(rq->page_pool));
> > > > > > > > > > > +             rq->page_pool =3D NULL;
> > > > > > > > > > > +     }
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /* How large should a single buffer be so a queue fu=
ll of these can fit at
> > > > > > > > > > >   * least one full packet?
> > > > > > > > > > >   * Logic below assumes the mergeable buffer header i=
s used.
> > > > > > > > > > > @@ -3801,6 +3898,13 @@ static int virtnet_find_vqs(st=
ruct virtnet_info *vi)
> > > > > > > > > > >               vi->rq[i].vq =3D vqs[rxq2vq(i)];
> > > > > > > > > > >               vi->rq[i].min_buf_len =3D mergeable_min=
_buf_len(vi, vi->rq[i].vq);
> > > > > > > > > > >               vi->sq[i].vq =3D vqs[txq2vq(i)];
> > > > > > > > > > > +
> > > > > > > > > > > +             if (page_pool_enabled && vi->mergeable_=
rx_bufs)
> > > > > > > > > > > +                     virtnet_alloc_page_pool(&vi->rq=
[i]);
> > > > > > > > > > > +             else
> > > > > > > > > > > +                     dev_warn(&vi->vdev->dev,
> > > > > > > > > > > +                              "page pool only suppor=
t mergeable mode\n");
> > > > > > > > > > > +
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > >       /* run here: ret =3D=3D 0. */
> > > > > > > > > > > --
> > > > > > > > > > > 2.31.1
> > > > > > > > > >
> > > > > > > >
> > > > >
> > > >
> >
>
