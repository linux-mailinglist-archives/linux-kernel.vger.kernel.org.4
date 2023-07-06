Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA0749CED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGFNC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGFNCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A025A1996
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688648521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8l5j8dIvhISCIIl0jqgAgLBzgTngAvLgUg9DnWFjWI=;
        b=PZ6Y2ICCP02SeSSfXEYdtR/M6RH9tR23DN7xr/QiyAb2Eco++CieBqDtHQo1vKaIqnlYDw
        gtLNmmnrmO6yAOtRB4qYfHt+4lpwOqRWi5PeKEFX6wH2fxgNE8zHE+ryR4hK54wC+2tqfQ
        /91+UXEicY5obkQVEJ88NoacC/qCc3o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-gGa916P0OpezR5riP_hCdg-1; Thu, 06 Jul 2023 09:01:59 -0400
X-MC-Unique: gGa916P0OpezR5riP_hCdg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62ffa1214edso1437266d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648519; x=1691240519;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8l5j8dIvhISCIIl0jqgAgLBzgTngAvLgUg9DnWFjWI=;
        b=JOQ7lpyaj22jybZn8QwYUp49CdwTNpKdDzljgHTRbclJryci1WLy81SO93jg/CVuQE
         /SEXqFKeStEQCoBasrVHmsgRmV52pFY+T2A8e4G72GEwVN2q1TZVXH8/5rijnjQm6/Gj
         HCrSH7dkXmeKhMq3ohxhbWjP5L0uZ7ZvFw4k947E2Dtj0EIk2e6FOd+lrjp4GhVu0gSx
         JfB5wSBNoFIwy1BWJb2peIo/GHhuhF/R3jYj710wFFr2HDj8B24BUMsnStMzhG0zTRgJ
         PGdP6wWyGmma+5ZFbzMSKobObsjtJLIaCb3/nZDk2cOaomfvmhTvFT2hwkaTvrgMliYP
         RfEA==
X-Gm-Message-State: ABy/qLbRY7PVsLgEu5RoUdxwwtUOkbC3T+uPjNG43Ii5FkkWH/Fo/FtE
        48q21ki5oJWGsF9fhNdfi+Tl+llBVG3HWvI55xBSnshhl/zi5KS5XSV8zPEcIYX/3XNGOS+J2aG
        ZcKUaeG9+O+AYeHWU3Bgwep6C
X-Received: by 2002:a05:6214:1c49:b0:635:e528:521a with SMTP id if9-20020a0562141c4900b00635e528521amr1733944qvb.5.1688648518817;
        Thu, 06 Jul 2023 06:01:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6NwqA45p2o1N0C810pNF4XSaeufAnZsy9C63z4wRYMk8BdBigFlFD62tFXnEFTue7G6ekoA==
X-Received: by 2002:a05:6214:1c49:b0:635:e528:521a with SMTP id if9-20020a0562141c4900b00635e528521amr1733917qvb.5.1688648518513;
        Thu, 06 Jul 2023 06:01:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-43.dyn.eolo.it. [146.241.240.43])
        by smtp.gmail.com with ESMTPSA id y4-20020a0c8ec4000000b0062629cbff11sm856575qvb.11.2023.07.06.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:01:58 -0700 (PDT)
Message-ID: <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Jul 2023 15:01:55 +0200
In-Reply-To: <CAA85sZvZ_X=TqCXaPui0PDLq2pp5dw_uhga+wcXgBqudrLP9bQ@mail.gmail.com>
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

On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > > >=20
> > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@redha=
t.com> wrote:
> > > > > >=20
> > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > > > More stacktraces.. =3D)
> > > > > > >=20
> > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > > > [  411.413767] ------------[ cut here ]------------
> > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud    =
 p.h:509
> > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:8=
00
> > > > > > > net/ipv6/udp.c:787)
> > > > > >=20
> > > > > > I'm really running out of ideas here...
> > > > > >=20
> > > > > > This is:
> > > > > >=20
> > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > >=20
> > > > > > sort of hint skb being shared (skb->users > 1) while enqueued i=
n
> > > > > > multiple places (bridge local input and br forward/flood to tun
> > > > > > device). I audited the bridge mc flooding code, and I could not=
 find
> > > > > > how a shared skb could land into the local input path.
> > > > > >=20
> > > > > > Anyway the other splats reported here and in later emails are
> > > > > > compatible with shared skbs.
> > > > > >=20
> > > > > > The above leads to another bunch of questions:
> > > > > > * can you reproduce the issue after disabling 'rx-gro-list' on =
the
> > > > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> > > > >=20
> > > > > With rx-gro-list off, as in never turned on, everything seems to =
run fine
> > > > >=20
> > > > > > * do you have by chance qdiscs on top of the VM tun devices?
> > > > >=20
> > > > > default qdisc is fq
> > > >=20
> > > > IIRC libvirt could reset the qdisc to noqueue for the owned tun
> > > > devices.
> > > >=20
> > > > Could you please report the output of:
> > > >=20
> > > > tc -d -s qdisc show dev <tun dev name>
> > >=20
> > > I don't have these set:
> > > CONFIG_NET_SCH_INGRESS
> > > CONFIG_NET_SCHED
> > >=20
> > > so tc just gives an error...
> >=20
> > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
> > CONFIG_NET_SCHED, you should not have a default qdisc, too ;)
>=20
> Well it's still set in sysctl - dunno if it fails
>=20
> > Could you please share your kernel config?
>=20
> Sure...
>=20
> As a side note, it hasn't crashed - no traces since we did the last chang=
e

It sounds like an encouraging sing! (last famous words...). I'll wait 1
more day, than I'll submit formally...

> For reference, this is git diff on the running kernels source tree:
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index cea28d30abb5..1b2394ebaf33 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>=20
>         skb_push(skb, -skb_network_offset(skb) + offset);
>=20
> +       if (WARN_ON_ONCE(skb_shared(skb))) {
> +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> +               if (!skb)
> +                       goto err_linearize;
> +       }
> +
> +       /* later code will clear the gso area in the shared info */
> +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> +       if (err)
> +               goto err_linearize;
> +
>         skb_shinfo(skb)->frag_list =3D NULL;
>=20
>         while (list_skb) {

...the above check only, as the other 2 should only catch-up side
effects of lack of this one. In any case the above address a real
issue, so we likely want it no-matter-what.

Thanks,

Paolo

