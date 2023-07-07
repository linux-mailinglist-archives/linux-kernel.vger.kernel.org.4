Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DB74AB71
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGGG4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGGG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF231FE6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688712913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiuIFdEbuG/V7vt0go6BhvTNeG2l7bZFx0tKuvLez8w=;
        b=Harerm3Ce4XUELpj3dIoJdwxzw1IX7ZBRDwT9CjskID9pbucdAMX1bILhmplz59vlkhgfJ
        Iz8shqj8pDmdRLzKcXh4maTI+0ilOrY4M2nUkg+YholOV8QksLW8OyjlRaf6sKF0NJgAaT
        zClihjj+lRRi9DvIzjyaKiBnmyiKa7c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-Z2rbnye4PqCe784t2-pRXQ-1; Fri, 07 Jul 2023 02:55:12 -0400
X-MC-Unique: Z2rbnye4PqCe784t2-pRXQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4032a3ad8c0so4133861cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688712911; x=1691304911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiuIFdEbuG/V7vt0go6BhvTNeG2l7bZFx0tKuvLez8w=;
        b=mIemanrE9XcJGSQuzAbypu5SnAPgkHQWL834/3+BxuramcQKk230rFWIP0SXur2sXF
         kYjiQjEncBG9c9BDVAjAcQYRJhGcp+gClwJi6Y86tHTSqwjIlFuVlh9OYLpWbRoHFbX3
         AKOioLI1aI5z0zNa4L86ReFpN0kyiS/NpwxcxQmK5/FIq8cemV7tIYwG1SYUnyXWj0/+
         bLi9SbRaULC1eqzhqZNLcbgK11v5BdGQipHAhj5DwcgcNipkBahAGpe4zbdgEklzx3xm
         mT4+ZpFCQRw70UVcesBD6UyPIbCITLX3hHmqypzK9eTK+VDheAykv7rmq0zEh7N1Bq9C
         J3Nw==
X-Gm-Message-State: ABy/qLbxXMKrPLFXQ7PxJ/7BdkXODD5gnRJZYAjfX42AOq+Kh8xUMyYc
        OR4xz13YNgs4uqGq/XhkJ+GoPGUN+Ydnr+ZzR41j2vXnbviMnUutGCCSd/GrABTV//+JTtmTIDb
        GU3SE+jrf0rRnuDtAq2VvsBEO
X-Received: by 2002:a05:620a:244a:b0:767:170d:887a with SMTP id h10-20020a05620a244a00b00767170d887amr5365468qkn.2.1688712911554;
        Thu, 06 Jul 2023 23:55:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1hIX2H/C32J0vYUFsa3n7kXbchn8wnbtPcqrhcTOHsi1P4Q9291eV8i6EzR3Hfc5vN2z5zw==
X-Received: by 2002:a05:620a:244a:b0:767:170d:887a with SMTP id h10-20020a05620a244a00b00767170d887amr5365455qkn.2.1688712911174;
        Thu, 06 Jul 2023 23:55:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-43.dyn.eolo.it. [146.241.240.43])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b00767177a5bebsm1550954qki.56.2023.07.06.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 23:55:10 -0700 (PDT)
Message-ID: <c21f6cc32ac9d1ee78d60452e52b62654152ae69.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Jul 2023 08:55:07 +0200
In-Reply-To: <CAA85sZsHKb3Wtsa5ktSAPJsjLrcmahtgaemPhN5dTeTxEBWaqw@mail.gmail.com>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
         <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
         <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
         <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
         <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
         <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
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
         <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
         <c4e40b45b41d0476afd8989d31e6bab74c51a72a.camel@redhat.com>
         <CAA85sZs_R3W42m8YmXO-k08bPow7zKj_eOxceEB_3MJveGMZ7A@mail.gmail.com>
         <a46bb3de011002c2446a6d836aaddc9f6bce71bc.camel@redhat.com>
         <CAA85sZsHKb3Wtsa5ktSAPJsjLrcmahtgaemPhN5dTeTxEBWaqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 00:32 +0200, Ian Kumlien wrote:
> On Thu, Jul 6, 2023 at 7:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > On Thu, 2023-07-06 at 18:17 +0200, Ian Kumlien wrote:
> > > On Thu, Jul 6, 2023 at 4:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > > >=20
> > > > On Thu, 2023-07-06 at 15:56 +0200, Eric Dumazet wrote:
> > > > > On Thu, Jul 6, 2023 at 3:02=E2=80=AFPM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > > >=20
> > > > > > On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> > > > > > > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@r=
edhat.com> wrote:
> > > > > > > > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > > > > > > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <paben=
i@redhat.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > > > > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <=
pabeni@redhat.com> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrot=
e:
> > > > > > > > > > > > > More stacktraces.. =3D)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmli=
nux
> > > > > > > > > > > > > [  411.413767] ------------[ cut here ]----------=
--
> > > > > > > > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at includ=
e/net/ud     p.h:509
> > > > > > > > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/=
ipv6/udp.c:800
> > > > > > > > > > > > > net/ipv6/udp.c:787)
> > > > > > > > > > > >=20
> > > > > > > > > > > > I'm really running out of ideas here...
> > > > > > > > > > > >=20
> > > > > > > > > > > > This is:
> > > > > > > > > > > >=20
> > > > > > > > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > > > > > > > >=20
> > > > > > > > > > > > sort of hint skb being shared (skb->users > 1) whil=
e enqueued in
> > > > > > > > > > > > multiple places (bridge local input and br forward/=
flood to tun
> > > > > > > > > > > > device). I audited the bridge mc flooding code, and=
 I could not find
> > > > > > > > > > > > how a shared skb could land into the local input pa=
th.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Anyway the other splats reported here and in later =
emails are
> > > > > > > > > > > > compatible with shared skbs.
> > > > > > > > > > > >=20
> > > > > > > > > > > > The above leads to another bunch of questions:
> > > > > > > > > > > > * can you reproduce the issue after disabling 'rx-g=
ro-list' on the
> > > > > > > > > > > > ingress device? (while keeping 'rx-udp-gro-forwardi=
ng' on).
> > > > > > > > > > >=20
> > > > > > > > > > > With rx-gro-list off, as in never turned on, everythi=
ng seems to run fine
> > > > > > > > > > >=20
> > > > > > > > > > > > * do you have by chance qdiscs on top of the VM tun=
 devices?
> > > > > > > > > > >=20
> > > > > > > > > > > default qdisc is fq
> > > > > > > > > >=20
> > > > > > > > > > IIRC libvirt could reset the qdisc to noqueue for the o=
wned tun
> > > > > > > > > > devices.
> > > > > > > > > >=20
> > > > > > > > > > Could you please report the output of:
> > > > > > > > > >=20
> > > > > > > > > > tc -d -s qdisc show dev <tun dev name>
> > > > > > > > >=20
> > > > > > > > > I don't have these set:
> > > > > > > > > CONFIG_NET_SCH_INGRESS
> > > > > > > > > CONFIG_NET_SCHED
> > > > > > > > >=20
> > > > > > > > > so tc just gives an error...
> > > > > > > >=20
> > > > > > > > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends o=
n
> > > > > > > > CONFIG_NET_SCHED, you should not have a default qdisc, too =
;)
> > > > > > >=20
> > > > > > > Well it's still set in sysctl - dunno if it fails
> > > > > > >=20
> > > > > > > > Could you please share your kernel config?
> > > > > > >=20
> > > > > > > Sure...
> > > > > > >=20
> > > > > > > As a side note, it hasn't crashed - no traces since we did th=
e last change
> > > > > >=20
> > > > > > It sounds like an encouraging sing! (last famous words...). I'l=
l wait 1
> > > > > > more day, than I'll submit formally...
> > > > > >=20
> > > > > > > For reference, this is git diff on the running kernels source=
 tree:
> > > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > > index cea28d30abb5..1b2394ebaf33 100644
> > > > > > > --- a/net/core/skbuff.c
> > > > > > > +++ b/net/core/skbuff.c
> > > > > > > @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struc=
t sk_buff *skb,
> > > > > > >=20
> > > > > > >         skb_push(skb, -skb_network_offset(skb) + offset);
> > > > > > >=20
> > > > > > > +       if (WARN_ON_ONCE(skb_shared(skb))) {
> > > > > > > +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> > > > > > > +               if (!skb)
> > > > > > > +                       goto err_linearize;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       /* later code will clear the gso area in the shared i=
nfo */
> > > > > > > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > > > > > > +       if (err)
> > > > > > > +               goto err_linearize;
> > > > > > > +
> > > > > > >         skb_shinfo(skb)->frag_list =3D NULL;
> > > > > > >=20
> > > > > > >         while (list_skb) {
> > > > > >=20
> > > > > > ...the above check only, as the other 2 should only catch-up si=
de
> > > > > > effects of lack of this one. In any case the above address a re=
al
> > > > > > issue, so we likely want it no-matter-what.
> > > > > >=20
> > > > >=20
> > > > > Interesting, I wonder if this could also fix some syzbot reports
> > > > > Willem and I are investigating.
> > > > >=20
> > > > > Any idea of when the bug was 'added' or 'revealed' ?
> > > >=20
> > > > The issue specifically addressed above should be present since
> > > > frag_list introduction commit 3a1296a38d0c ("net: Support GRO/GSO
> > > > fraglist chaining."). AFAICS triggering it requires non trivial set=
up -
> > > > mcast rx on bridge with frag-list enabled and forwarding to multipl=
e
> > > > ports - so perhaps syzkaller found it later due to improvements on =
its
> > > > side ?!?
> > >=20
> > > I'm also a bit afraid that we just haven't triggered it - i don't see
> > > any warnings or anything... :/
> >=20
> > Let me try to clarify: I hope/think that this chunk alone:
> >=20
> > +       /* later code will clear the gso area in the shared info */
> > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > +       if (err)
> > +               goto err_linearize;
> > +
> >         skb_shinfo(skb)->frag_list =3D NULL;
> >=20
> >         while (list_skb) {
> >=20
> > does the magic/avoids the skb corruptions -> it everything goes well,
> > you should not see any warnings at all. Running 'nstat' in the DUT
> > should give some hints about reaching the relevant code paths.
>=20
> Sorry about the html mail... but...
>=20
> I was fully expecting a warning from:
>  if (WARN_ON_ONCE(skb_shared(skb))) {
>=20
> But I could be completely wrong and things =3D)
>=20
> Which fields would i be looking at in nstat
[...]
> UdpInDatagrams                  4893               0.0
[...]
> Ip6InMcastPkts                  7146               0.0
[...]
> Ip6InMcastOctets                1061292            0.0

The above ones. We have ingress mcast traffic, but the figures are
inconclusive about GRO aggregation taking place (Ip6InMcastOctets /
Ip6InMcastPkts > MTU would prove that). Similar thing for IPv4 mcast.

Still the change look sane, the alive time encouraging. I'll submit it
formally with your reported/tested-by tags.

Many thanks for all the debugging effort!

Paolo

