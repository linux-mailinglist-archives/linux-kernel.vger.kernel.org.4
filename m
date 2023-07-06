Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2263174A21A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjGFQSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjGFQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:18:05 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6701BD4;
        Thu,  6 Jul 2023 09:18:01 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47e57b8498aso310287e0c.2;
        Thu, 06 Jul 2023 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688660281; x=1691252281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6trA7i/Q1+6Uh5pOaGbvlJJc0dwoyiShmt6TgrS7dQQ=;
        b=SA0osFoY8Rg2TDWN4qQRQk2GMTbD3SoAHjED27fW7Dzb3Vs2Zgddnov7iQXOAF+WqA
         7CWZFOzGs8NyJ/N6whbQLrBeD57Tre03a3G7tEqDjbaYgt+KG5UeRU89vyJDNQ2V+QJ1
         PxZEnSfidXJeLdZ6kMb5HKp5ACbU/rBfPjjYWfoXV8wNtnCDTonCAG3IA8Ut4Zsugvmp
         ykokh97BXLM/WrD3iuieWvnyC7Mo0oFscVTxd8xYFEVUvE9IC0R4OVHeFEfuLSUCf+pk
         5jNTP3PB9scTt3vSGJGpXEYuBh8FHHjLuubupCEMHaZoHW3a+wPP9ge4qW5EGsBKxxIf
         jjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688660281; x=1691252281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6trA7i/Q1+6Uh5pOaGbvlJJc0dwoyiShmt6TgrS7dQQ=;
        b=ZPAFiKcUvBzcyiL921FdxnaNzfxfnvGtU75VMhXX/F+Ki/1xPPxdFjii0MdhGA9sTa
         K0NZhh/GJWIjw5I3TRSNnY30VJj8BwaidDTbHmBtuitO19EJOHFVs4ULtN3SGNAFy2yL
         HeUYGDR+gHtyqJJIkcaIFlzsLA+uwqYlyssxn0CO8KW0goc7GqMrcsW51JQcCYKJ8Bs2
         C4tTiYiYwyYcxSB9OP7V4etvAE0OJ4Du4f6WPVfrrZGBSFAHunKuhF2HsFDMGpZnp3dW
         eN2fJfkMJEJIoratWzz2KvN43ivicfYtQbaaEGenaIZ37l3X130xQMRAX5MobX2KZhO5
         5Pmw==
X-Gm-Message-State: ABy/qLbdZREXc2rfqqh6uwITzfb7J6xRVd+OzsUurRzNgMCPPvNrx3tg
        SVb/uxhrfHlFwp7CbLx+c38mqAAI5cRRM4g6qoa3uaE5wnw=
X-Google-Smtp-Source: APBJJlFkeB5xe0s3yx7qnzI0i2ss7i/hgubFrjNPzsX0wW7SaTcLfXaqstHcIwC21dRbgTg5NlwMzCFimAsvja+n8zA=
X-Received: by 2002:a1f:5c05:0:b0:47e:19b4:85e9 with SMTP id
 q5-20020a1f5c05000000b0047e19b485e9mr1670297vkb.0.1688660280885; Thu, 06 Jul
 2023 09:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
 <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
 <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
 <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
 <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
 <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
 <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
 <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
 <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
 <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
 <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
 <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com>
 <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
 <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
 <c6cf7b4c0a561700d2015c970d52fc9d92b114c7.camel@redhat.com>
 <CAA85sZvZ_X=TqCXaPui0PDLq2pp5dw_uhga+wcXgBqudrLP9bQ@mail.gmail.com>
 <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
 <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com> <c4e40b45b41d0476afd8989d31e6bab74c51a72a.camel@redhat.com>
In-Reply-To: <c4e40b45b41d0476afd8989d31e6bab74c51a72a.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 6 Jul 2023 18:17:49 +0200
Message-ID: <CAA85sZs_R3W42m8YmXO-k08bPow7zKj_eOxceEB_3MJveGMZ7A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Jul 6, 2023 at 4:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2023-07-06 at 15:56 +0200, Eric Dumazet wrote:
> > On Thu, Jul 6, 2023 at 3:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> > > > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > > > > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > > > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redh=
at.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > > > > > > More stacktraces.. =3D)
> > > > > > > > > >
> > > > > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > > > > > > [  411.413767] ------------[ cut here ]------------
> > > > > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/=
ud     p.h:509
> > > > > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/u=
dp.c:800
> > > > > > > > > > net/ipv6/udp.c:787)
> > > > > > > > >
> > > > > > > > > I'm really running out of ideas here...
> > > > > > > > >
> > > > > > > > > This is:
> > > > > > > > >
> > > > > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > > > > >
> > > > > > > > > sort of hint skb being shared (skb->users > 1) while enqu=
eued in
> > > > > > > > > multiple places (bridge local input and br forward/flood =
to tun
> > > > > > > > > device). I audited the bridge mc flooding code, and I cou=
ld not find
> > > > > > > > > how a shared skb could land into the local input path.
> > > > > > > > >
> > > > > > > > > Anyway the other splats reported here and in later emails=
 are
> > > > > > > > > compatible with shared skbs.
> > > > > > > > >
> > > > > > > > > The above leads to another bunch of questions:
> > > > > > > > > * can you reproduce the issue after disabling 'rx-gro-lis=
t' on the
> > > > > > > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on=
).
> > > > > > > >
> > > > > > > > With rx-gro-list off, as in never turned on, everything see=
ms to run fine
> > > > > > > >
> > > > > > > > > * do you have by chance qdiscs on top of the VM tun devic=
es?
> > > > > > > >
> > > > > > > > default qdisc is fq
> > > > > > >
> > > > > > > IIRC libvirt could reset the qdisc to noqueue for the owned t=
un
> > > > > > > devices.
> > > > > > >
> > > > > > > Could you please report the output of:
> > > > > > >
> > > > > > > tc -d -s qdisc show dev <tun dev name>
> > > > > >
> > > > > > I don't have these set:
> > > > > > CONFIG_NET_SCH_INGRESS
> > > > > > CONFIG_NET_SCHED
> > > > > >
> > > > > > so tc just gives an error...
> > > > >
> > > > > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
> > > > > CONFIG_NET_SCHED, you should not have a default qdisc, too ;)
> > > >
> > > > Well it's still set in sysctl - dunno if it fails
> > > >
> > > > > Could you please share your kernel config?
> > > >
> > > > Sure...
> > > >
> > > > As a side note, it hasn't crashed - no traces since we did the last=
 change
> > >
> > > It sounds like an encouraging sing! (last famous words...). I'll wait=
 1
> > > more day, than I'll submit formally...
> > >
> > > > For reference, this is git diff on the running kernels source tree:
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index cea28d30abb5..1b2394ebaf33 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struct sk_b=
uff *skb,
> > > >
> > > >         skb_push(skb, -skb_network_offset(skb) + offset);
> > > >
> > > > +       if (WARN_ON_ONCE(skb_shared(skb))) {
> > > > +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> > > > +               if (!skb)
> > > > +                       goto err_linearize;
> > > > +       }
> > > > +
> > > > +       /* later code will clear the gso area in the shared info */
> > > > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > > > +       if (err)
> > > > +               goto err_linearize;
> > > > +
> > > >         skb_shinfo(skb)->frag_list =3D NULL;
> > > >
> > > >         while (list_skb) {
> > >
> > > ...the above check only, as the other 2 should only catch-up side
> > > effects of lack of this one. In any case the above address a real
> > > issue, so we likely want it no-matter-what.
> > >
> >
> > Interesting, I wonder if this could also fix some syzbot reports
> > Willem and I are investigating.
> >
> > Any idea of when the bug was 'added' or 'revealed' ?
>
> The issue specifically addressed above should be present since
> frag_list introduction commit 3a1296a38d0c ("net: Support GRO/GSO
> fraglist chaining."). AFAICS triggering it requires non trivial setup -
> mcast rx on bridge with frag-list enabled and forwarding to multiple
> ports - so perhaps syzkaller found it later due to improvements on its
> side ?!?

I'm also a bit afraid that we just haven't triggered it - i don't see
any warnings or anything... :/

> Cheers,
>
> Paolo
>
