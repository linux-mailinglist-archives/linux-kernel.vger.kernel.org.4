Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5C748595
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGEN7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjGEN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:58:57 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6CD13E;
        Wed,  5 Jul 2023 06:58:56 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-47dcb8a5e89so541113e0c.0;
        Wed, 05 Jul 2023 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688565535; x=1691157535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmFh+BQT1+pGjJ/ogkEF9g/4D4Q9jOcfYFATuZt2yWQ=;
        b=HJi4haiCbFAKGCKMOQBx1dDphE8VEGpf+ciCnU4qW+jraWtXDJ7ajtTNWFudIJTAV2
         9YkziI0pu2awYR4WUWueHQg3NFmd7HkMzyYPCGQyBQTDA6pf3GvRf5nz+wwPZCoP0tqS
         +py/7LH8Nnqqn2hOUfdMUfYHfsOE7dgokCSnFnyohQfqHtk0ZxIa678FoF2wWJTLIli3
         CIWd5JL4dM1/LkhZRwELrGN7RrEqmMC5qPlPxwJSg8ArXE3XXGbHKn0vsWR4OVaqefoW
         htlwrD62c/Vi/GyMBdfAHXHvSOEKW34w2uW662YEQ/E1kAKKlhpyJuhyaB5S60GAiLfM
         sbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688565535; x=1691157535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmFh+BQT1+pGjJ/ogkEF9g/4D4Q9jOcfYFATuZt2yWQ=;
        b=ADNqLjUrEkcWLoZSzYg5IXxHW1zM3+AuJGSgj3STKMivJUcqXIeYQ2gSPWwprAdQTC
         4/VM9VFa7lYVtQhJ1mS/TugP+usZjBpgtCevVzhBqJ1rDqQtp11hNTLoRVYHydGNch3a
         BUdndW5G7VWeXrLxtWMVnajTq0x/AgO1zNzfWUSGU6cJi0iPfzy32MoAEEN8iRRAZYb/
         IEIl1d4cm0ioHtjrOqzXFsWh+ZlpSdfPZ1CRQby7GNsaoxWwQ8x3fZxsYy4BicHkv01q
         0TCcvCoDEUAbIhrfH/mHIGUF0ePUQWbqB6+2Gm9j3g6S/OqxOF8CMN9HXdIzr1xpFIyB
         W+vg==
X-Gm-Message-State: ABy/qLY3/jZQl0jkgypvZaJCUM6g+8MSAmN950REnAaSKpbqJVF9qqR/
        Mi5GOYxLGltVWGYw7KJOy9yV5VhJb4wQLph7t1o=
X-Google-Smtp-Source: APBJJlH7sDTWvrcXOuG1twI0e6GfuI+IdpsQFIfNSBMaMdkOlCrqn3cUimp07Xml2NqrSQ4RQYxjT0WjMjD9z4d4liI=
X-Received: by 2002:a1f:9bc9:0:b0:477:4872:7f9d with SMTP id
 d192-20020a1f9bc9000000b0047748727f9dmr663119vke.4.1688565535543; Wed, 05 Jul
 2023 06:58:55 -0700 (PDT)
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
 <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com> <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
In-Reply-To: <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 5 Jul 2023 15:58:43 +0200
Message-ID: <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
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

On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > More stacktraces.. =3D)
> > > >
> > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > [  411.413767] ------------[ cut here ]------------
> > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud     p.h:5=
09
> > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
> > > > net/ipv6/udp.c:787)
> > >
> > > I'm really running out of ideas here...
> > >
> > > This is:
> > >
> > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > >
> > > sort of hint skb being shared (skb->users > 1) while enqueued in
> > > multiple places (bridge local input and br forward/flood to tun
> > > device). I audited the bridge mc flooding code, and I could not find
> > > how a shared skb could land into the local input path.
> > >
> > > Anyway the other splats reported here and in later emails are
> > > compatible with shared skbs.
> > >
> > > The above leads to another bunch of questions:
> > > * can you reproduce the issue after disabling 'rx-gro-list' on the
> > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> >
> > With rx-gro-list off, as in never turned on, everything seems to run fi=
ne
> >
> > > * do you have by chance qdiscs on top of the VM tun devices?
> >
> > default qdisc is fq
>
> IIRC libvirt could reset the qdisc to noqueue for the owned tun
> devices.
>
> Could you please report the output of:
>
> tc -d -s qdisc show dev <tun dev name>

I don't have these set:
CONFIG_NET_SCH_INGRESS
CONFIG_NET_SCHED

so tc just gives an error...

> Thanks!
>
> /P
>
