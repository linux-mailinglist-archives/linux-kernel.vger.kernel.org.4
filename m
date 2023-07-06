Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667037497A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGFInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D611D1BC8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688632966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6rDF3CskNlnocyiQd+/MQFl4wcMc6bzpk2CUQ+RXxc=;
        b=ZWG03A+5WCeYzu4Szat/i9mNdWhTRQqAMWhDGpO3Uf9D+4OUA6O0PykXJsqs7J1S4Zb/3i
        YggzWyF+0B831hMEP7CAdT0Q9cM3PWRe7L2ZxkUHitnCoiiLfJGGaIOJV+l/qaP7lVpZFB
        q+w9E8s133mVa7akD7JAYKlS8yx4ECk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-sYMw4LyqMPydOVeO1NYiEw-1; Thu, 06 Jul 2023 04:42:44 -0400
X-MC-Unique: sYMw4LyqMPydOVeO1NYiEw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765ad67e600so11538085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688632964; x=1691224964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6rDF3CskNlnocyiQd+/MQFl4wcMc6bzpk2CUQ+RXxc=;
        b=jEtArNIexIpPTXeqHQxdRVTUOiW062QAhXYY/TY1OxdYBotoXZ5j2K7L7n3UGT4hFq
         NJo2C1zeHCsomiIza4cqxtXRSF5HKQ72heVa3WvI6paN/UpmaJMqBRGsYMCWp5VGro55
         U0pWwFoAmQtS6N5/UQ/6o3eQeWMVK975ciSMQ5PKy9dt0iJhF0mhVm0SZHHsRBsWcajU
         3JqrUiCnqR0ZwvjZrx+4GOSEK4raVskWtPz7mvz4uLs+ZPGvDga4+hld8zp6meyQQPrM
         xkGrAnOWWZO4xOPn62nkUu0tArigg0UZOFDPckB7Cmcaq7d8SKAEMOQXzsUU5JNmgEgZ
         4xmg==
X-Gm-Message-State: ABy/qLZwqRkzcjCWzrtNf+j+0jY7fi8LNt8a8IeABzSyl7Nol9RgCIpR
        BKraiEDgLQ3NSku8wo2FjKLx6YbG6sPf9oBdTDAqNwF7i/PG7YJQTNpPMlzgxGPecTAUJpxj/49
        viVoV1kbm7oHgVpyOx3i/e9M6
X-Received: by 2002:a05:620a:40c2:b0:765:9e34:a77e with SMTP id g2-20020a05620a40c200b007659e34a77emr1523541qko.2.1688632964084;
        Thu, 06 Jul 2023 01:42:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzgaYXclsPfL9sEoyaeA9jji27GaEyrb+cFPy2fXy0aidVV/TNS07gc7ReWtcD6iCG08YP1Q==
X-Received: by 2002:a05:620a:40c2:b0:765:9e34:a77e with SMTP id g2-20020a05620a40c200b007659e34a77emr1523521qko.2.1688632963710;
        Thu, 06 Jul 2023 01:42:43 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id i22-20020ae9ee16000000b00767765561absm512848qkg.100.2023.07.06.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:42:43 -0700 (PDT)
Message-ID: <c6cf7b4c0a561700d2015c970d52fc9d92b114c7.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Jul 2023 10:42:38 +0200
In-Reply-To: <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >=20
> > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > More stacktraces.. =3D)
> > > > >=20
> > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > [  411.413767] ------------[ cut here ]------------
> > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud     p.h=
:509
> > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
> > > > > net/ipv6/udp.c:787)
> > > >=20
> > > > I'm really running out of ideas here...
> > > >=20
> > > > This is:
> > > >=20
> > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > >=20
> > > > sort of hint skb being shared (skb->users > 1) while enqueued in
> > > > multiple places (bridge local input and br forward/flood to tun
> > > > device). I audited the bridge mc flooding code, and I could not fin=
d
> > > > how a shared skb could land into the local input path.
> > > >=20
> > > > Anyway the other splats reported here and in later emails are
> > > > compatible with shared skbs.
> > > >=20
> > > > The above leads to another bunch of questions:
> > > > * can you reproduce the issue after disabling 'rx-gro-list' on the
> > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> > >=20
> > > With rx-gro-list off, as in never turned on, everything seems to run =
fine
> > >=20
> > > > * do you have by chance qdiscs on top of the VM tun devices?
> > >=20
> > > default qdisc is fq
> >=20
> > IIRC libvirt could reset the qdisc to noqueue for the owned tun
> > devices.
> >=20
> > Could you please report the output of:
> >=20
> > tc -d -s qdisc show dev <tun dev name>
>=20
> I don't have these set:
> CONFIG_NET_SCH_INGRESS
> CONFIG_NET_SCHED
>=20
> so tc just gives an error...

The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
CONFIG_NET_SCHED, you should not have a default qdisc, too ;)

Could you please share your kernel config?

Thanks!

/P

