Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2D74A717
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGFWcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGFWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:32:45 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4301E1997;
        Thu,  6 Jul 2023 15:32:43 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7943105effbso1652833241.1;
        Thu, 06 Jul 2023 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688682762; x=1691274762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZp2mYLUnGEp/C3fdcIBt/tcS+0m40XKH09rN3Mr/pg=;
        b=rykLiA4Hcblldov0nxIcF8r5MDaEkktnyBZiuMKgQ9/ERoaSgzM6dHAketdzC4a1sq
         kchr5wt7p01HGw6zCHW2Aplym/TDCvzRjqnLheNgPH6BtzxLIFOgXoun2f40hsOvWu+d
         CwH/C/g7b1DdBhxaQpqh2aMT5wk/pfqM4YMbpVt6dZosTIuN7/kJ7R9Pv7pS1j+Sg7iJ
         Gut+b1sHXK6obzUzbYJ8STgHV8v5uj6dY5NhvBjqo7QDGVxeInX8aVlCbLGmETPDNW0U
         ipNCI/pPQSWNLA7qXV1el9pJDPBIAtmtCm6PAiwmpYLlWQzmLJH6JJPLlLu9ET4Xsc+y
         xXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682762; x=1691274762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZp2mYLUnGEp/C3fdcIBt/tcS+0m40XKH09rN3Mr/pg=;
        b=lnpdUdHI9aCxyyoHVIyvqXCR0cfvH2EkpE8LO3OCV5XXYcYMuhgaw/EiwtD5ggot5E
         SYOlq4vw2HEpgFY0Tz1TLrXUvPL97JDuAtCsXOGid1fpXAjOpke7WhihEb1dXlK1pqAz
         Ag6Vnb0L2K76MvkLiJk4fcnYS4FoRN9YFFANclMd07P6i8OEGlywTAVCvPx3YB/YLOye
         Q+CbRQrUk2RfcUOKWD96P9DAzo0VejrtkrdF3fT10CPijgaLFUcIeim1HXOknndbJn97
         L9xL9G0YKMagRRr6/2xBjA+paMDSb7p08UwYRqLAHCQVRlkF9JOhBDjLWRRhu1/TcPto
         MEIg==
X-Gm-Message-State: ABy/qLbpynzZXs7b9Aorw8StTJtlJqiX7mrpiw1feuNw0xcl5Om4CDvx
        3CjXVx6etW3buiSM3tS97cR6pQsA4gC3RAIRN6Q=
X-Google-Smtp-Source: APBJJlHrgkzkvH12sS+GMxtaENz/iRuUhclzVACDSAdReOMgM3VeQX9mpXcgZ2CtErkss1x/NC7CmlKIddGgib35ydo=
X-Received: by 2002:a05:6102:2842:b0:443:5ddf:4f5b with SMTP id
 az2-20020a056102284200b004435ddf4f5bmr1066958vsb.11.1688682762001; Thu, 06
 Jul 2023 15:32:42 -0700 (PDT)
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
 <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
 <c4e40b45b41d0476afd8989d31e6bab74c51a72a.camel@redhat.com>
 <CAA85sZs_R3W42m8YmXO-k08bPow7zKj_eOxceEB_3MJveGMZ7A@mail.gmail.com> <a46bb3de011002c2446a6d836aaddc9f6bce71bc.camel@redhat.com>
In-Reply-To: <a46bb3de011002c2446a6d836aaddc9f6bce71bc.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 7 Jul 2023 00:32:30 +0200
Message-ID: <CAA85sZsHKb3Wtsa5ktSAPJsjLrcmahtgaemPhN5dTeTxEBWaqw@mail.gmail.com>
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

On Thu, Jul 6, 2023 at 7:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> On Thu, 2023-07-06 at 18:17 +0200, Ian Kumlien wrote:
> > On Thu, Jul 6, 2023 at 4:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On Thu, 2023-07-06 at 15:56 +0200, Eric Dumazet wrote:
> > > > On Thu, Jul 6, 2023 at 3:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> > > > > > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@red=
hat.com> wrote:
> > > > > > > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > > > > > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@=
redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > > > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pa=
beni@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > > > > > > > > More stacktraces.. =3D)
> > > > > > > > > > > >
> > > > > > > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinu=
x
> > > > > > > > > > > > [  411.413767] ------------[ cut here ]------------
> > > > > > > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/=
net/ud     p.h:509
> > > > > > > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ip=
v6/udp.c:800
> > > > > > > > > > > > net/ipv6/udp.c:787)
> > > > > > > > > > >
> > > > > > > > > > > I'm really running out of ideas here...
> > > > > > > > > > >
> > > > > > > > > > > This is:
> > > > > > > > > > >
> > > > > > > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > > > > > > >
> > > > > > > > > > > sort of hint skb being shared (skb->users > 1) while =
enqueued in
> > > > > > > > > > > multiple places (bridge local input and br forward/fl=
ood to tun
> > > > > > > > > > > device). I audited the bridge mc flooding code, and I=
 could not find
> > > > > > > > > > > how a shared skb could land into the local input path=
.
> > > > > > > > > > >
> > > > > > > > > > > Anyway the other splats reported here and in later em=
ails are
> > > > > > > > > > > compatible with shared skbs.
> > > > > > > > > > >
> > > > > > > > > > > The above leads to another bunch of questions:
> > > > > > > > > > > * can you reproduce the issue after disabling 'rx-gro=
-list' on the
> > > > > > > > > > > ingress device? (while keeping 'rx-udp-gro-forwarding=
' on).
> > > > > > > > > >
> > > > > > > > > > With rx-gro-list off, as in never turned on, everything=
 seems to run fine
> > > > > > > > > >
> > > > > > > > > > > * do you have by chance qdiscs on top of the VM tun d=
evices?
> > > > > > > > > >
> > > > > > > > > > default qdisc is fq
> > > > > > > > >
> > > > > > > > > IIRC libvirt could reset the qdisc to noqueue for the own=
ed tun
> > > > > > > > > devices.
> > > > > > > > >
> > > > > > > > > Could you please report the output of:
> > > > > > > > >
> > > > > > > > > tc -d -s qdisc show dev <tun dev name>
> > > > > > > >
> > > > > > > > I don't have these set:
> > > > > > > > CONFIG_NET_SCH_INGRESS
> > > > > > > > CONFIG_NET_SCHED
> > > > > > > >
> > > > > > > > so tc just gives an error...
> > > > > > >
> > > > > > > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
> > > > > > > CONFIG_NET_SCHED, you should not have a default qdisc, too ;)
> > > > > >
> > > > > > Well it's still set in sysctl - dunno if it fails
> > > > > >
> > > > > > > Could you please share your kernel config?
> > > > > >
> > > > > > Sure...
> > > > > >
> > > > > > As a side note, it hasn't crashed - no traces since we did the =
last change
> > > > >
> > > > > It sounds like an encouraging sing! (last famous words...). I'll =
wait 1
> > > > > more day, than I'll submit formally...
> > > > >
> > > > > > For reference, this is git diff on the running kernels source t=
ree:
> > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > index cea28d30abb5..1b2394ebaf33 100644
> > > > > > --- a/net/core/skbuff.c
> > > > > > +++ b/net/core/skbuff.c
> > > > > > @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struct =
sk_buff *skb,
> > > > > >
> > > > > >         skb_push(skb, -skb_network_offset(skb) + offset);
> > > > > >
> > > > > > +       if (WARN_ON_ONCE(skb_shared(skb))) {
> > > > > > +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> > > > > > +               if (!skb)
> > > > > > +                       goto err_linearize;
> > > > > > +       }
> > > > > > +
> > > > > > +       /* later code will clear the gso area in the shared inf=
o */
> > > > > > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > > > > > +       if (err)
> > > > > > +               goto err_linearize;
> > > > > > +
> > > > > >         skb_shinfo(skb)->frag_list =3D NULL;
> > > > > >
> > > > > >         while (list_skb) {
> > > > >
> > > > > ...the above check only, as the other 2 should only catch-up side
> > > > > effects of lack of this one. In any case the above address a real
> > > > > issue, so we likely want it no-matter-what.
> > > > >
> > > >
> > > > Interesting, I wonder if this could also fix some syzbot reports
> > > > Willem and I are investigating.
> > > >
> > > > Any idea of when the bug was 'added' or 'revealed' ?
> > >
> > > The issue specifically addressed above should be present since
> > > frag_list introduction commit 3a1296a38d0c ("net: Support GRO/GSO
> > > fraglist chaining."). AFAICS triggering it requires non trivial setup=
 -
> > > mcast rx on bridge with frag-list enabled and forwarding to multiple
> > > ports - so perhaps syzkaller found it later due to improvements on it=
s
> > > side ?!?
> >
> > I'm also a bit afraid that we just haven't triggered it - i don't see
> > any warnings or anything... :/
>
> Let me try to clarify: I hope/think that this chunk alone:
>
> +       /* later code will clear the gso area in the shared info */
> +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> +       if (err)
> +               goto err_linearize;
> +
>         skb_shinfo(skb)->frag_list =3D NULL;
>
>         while (list_skb) {
>
> does the magic/avoids the skb corruptions -> it everything goes well,
> you should not see any warnings at all. Running 'nstat' in the DUT
> should give some hints about reaching the relevant code paths.

Sorry about the html mail... but...

I was fully expecting a warning from:
 if (WARN_ON_ONCE(skb_shared(skb))) {

But I could be completely wrong and things =3D)

Which fields would i be looking at in nstat
nstat
#kernel
IpInReceives                    11076              0.0
IpForwDatagrams                 2384               0.0
IpInDelivers                    5107               0.0
IpOutRequests                   3478               0.0
IcmpInMsgs                      42                 0.0
IcmpInDestUnreachs              9                  0.0
IcmpInEchos                     32                 0.0
IcmpInEchoReps                  1                  0.0
IcmpOutMsgs                     49                 0.0
IcmpOutDestUnreachs             15                 0.0
IcmpOutEchos                    2                  0.0
IcmpOutEchoReps                 32                 0.0
IcmpMsgInType0                  1                  0.0
IcmpMsgInType3                  9                  0.0
IcmpMsgInType8                  32                 0.0
IcmpMsgOutType0                 32                 0.0
IcmpMsgOutType3                 15                 0.0
IcmpMsgOutType8                 2                  0.0
TcpInSegs                       220                0.0
TcpOutSegs                      381                0.0
UdpInDatagrams                  4893               0.0
UdpInErrors                     5                  0.0
UdpOutDatagrams                 655                0.0
UdpRcvbufErrors                 5                  0.0
UdpIgnoredMulti                 86                 0.0
Ip6InReceives                   7155               0.0
Ip6InDelivers                   7139               0.0
Ip6OutRequests                  136                0.0
Ip6OutNoRoutes                  8                  0.0
Ip6InMcastPkts                  7146               0.0
Ip6OutMcastPkts                 130                0.0
Ip6InOctets                     1062180            0.0
Ip6OutOctets                    41215              0.0
Ip6InMcastOctets                1061292            0.0
Ip6OutMcastOctets               40807              0.0
Ip6InNoECTPkts                  7845               0.0
Icmp6InMsgs                     44                 0.0
Icmp6OutMsgs                    21                 0.0
Icmp6InGroupMembQueries         8                  0.0
Icmp6InRouterAdvertisements     4                  0.0
Icmp6InNeighborSolicits         6                  0.0
Icmp6InNeighborAdvertisements   26                 0.0
Icmp6OutNeighborSolicits        3                  0.0
Icmp6OutNeighborAdvertisements  6                  0.0
Icmp6OutMLDv2Reports            12                 0.0
Icmp6InType130                  8                  0.0
Icmp6InType134                  4                  0.0
Icmp6InType135                  6                  0.0
Icmp6InType136                  26                 0.0
Icmp6OutType135                 3                  0.0
Icmp6OutType136                 6                  0.0
Icmp6OutType143                 12                 0.0
Udp6InDatagrams                 6537               0.0
Udp6InErrors                    1248               0.0
Udp6OutDatagrams                115                0.0
Udp6RcvbufErrors                1248               0.0
TcpExtTCPHPAcks                 200                0.0
TcpExtTCPBacklogCoalesce        3                  0.0
TcpExtIPReversePathFilter       89                 0.0
TcpExtTCPAutoCorking            4                  0.0
TcpExtTCPOrigDataSent           381                0.0
TcpExtTCPDelivered              381                0.0
IpExtInMcastPkts                4174               0.0
IpExtOutMcastPkts               68                 0.0
IpExtInBcastPkts                86                 0.0
IpExtOutBcastPkts               4                  0.0
IpExtInOctets                   1866664            0.0
IpExtOutOctets                  1715287            0.0
IpExtInMcastOctets              539751             0.0
IpExtOutMcastOctets             25636              0.0
IpExtInBcastOctets              7131               0.0
IpExtOutBcastOctets             304                0.0
IpExtInNoECTPkts                12158              0.0

But we do have a extreme uptime for this test:
 00:31:44 up 1 day, 10:55,  2 users,  load average: 0,77, 0,75, 0,82

> Cheers,
>
> Paolo
>
