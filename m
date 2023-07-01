Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600627445FA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGACAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 22:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGACAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 22:00:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2A4212
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:00:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401f4408955so65571cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688176844; x=1690768844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaVezS/+JQV57xvj5fNb4PPthEyQc/LQbKbtQJe4ZRE=;
        b=7w9aLGYKNTt6D1+bVMbb17RhF8C+rRNuaw4vyDbyVH/CM6nwWV0boif3sYwGJo9L5O
         Aml+t3Ivaiif3sg+0+LmHVHef4DWzM1qS4opcO256p36DkAN0Jqzkxi2WFQ/slnOdNIE
         9F/OcLhhBwNH3v/vETYX0v4nytkvdb0z/niLQvHOAdNmOTO72e2wciUcmurDCgrWjOKb
         XIA4FVOSBkKk0Eha1MPYj94oylEB32FPjQFycq1M2g2DxgtS+LbB/DhyqiC6M/l+6v6J
         Tg52d9yDjPeWWeNYK4f1wqPD/LcAzNWlFSlDpdFw0jnVZHAjrPkV0+qAtttc3jrkUq3l
         JBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688176844; x=1690768844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaVezS/+JQV57xvj5fNb4PPthEyQc/LQbKbtQJe4ZRE=;
        b=OCeasSuF67Rlw5Oborslvi0OUEsmt6cJShySYW07sbnlyAgnYwxArYjNO9v+i8+ZPY
         Nc7x/l7IKy/IFfaK5cZj6nVn84kr/P0BCuB6ZfebwjUevwLqQCEV+mNiuo7u/4AuGyCM
         Od3zIgL0xmLlRZW+jZvv+MzsdO5JhoBj3QDTWym0DhBhuCbdTWXskvs+vR1VN7wW9Re6
         9F9ZRNwQ/L+BqAHWQhWgAC9ICHm+TViz6tOZmjlWYR5T/kf/989hIzGxFMezHA9Qi6sT
         92TX8ysVZJxsUkEbWMpof9LUHW0IMddD/F/hdslnEi/kj2EzfNie2Dwna4R6sDUC0Z1H
         f6hw==
X-Gm-Message-State: ABy/qLa3SbQzPdWrOrJRNTwxOkIWhS3EkfD2uprHW5SQVxI9Da6O+vib
        Wf3xHn/amuv8QcUAz3HBZbnJD/P1zm9gdr2FIEiHUQ==
X-Google-Smtp-Source: APBJJlF/PwfmDQkOlM6jVa2cWWmHy5HoMqgsdTRC/CcUnKrpKXeYKOyCfH4m/A7nSSAT8wSFlGI2qcQFw95gSjfKtuA=
X-Received: by 2002:ac8:5b05:0:b0:3ef:5f97:258f with SMTP id
 m5-20020ac85b05000000b003ef5f97258fmr78788qtw.16.1688176844468; Fri, 30 Jun
 2023 19:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230629015844.800280-1-samjonas@amazon.com> <CANn89i+6d9K1VwNK1Joc-Yb_4jAfV_YFzk=z_K2_Oy+xJHSn_g@mail.gmail.com>
 <182D446E-8871-4811-9275-98FF067B1BA9@amazon.com>
In-Reply-To: <182D446E-8871-4811-9275-98FF067B1BA9@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 1 Jul 2023 04:00:33 +0200
Message-ID: <CANn89i+oEvhGgtD6OrFFKXiRT3WD3uPRpNJLN6Qm2_HWaBVzrg@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: Reduce chance of collisions in inet6_hashfn()
To:     "Smith, Stewart" <trawets@amazon.com>,
        Amit Klein <aksecurity@gmail.com>
Cc:     "Mendoza-Jonas, Samuel" <samjonas@amazon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 2:26=E2=80=AFAM Smith, Stewart <trawets@amazon.com> =
wrote:
>
>
>
> > On Jun 29, 2023, at 3:05 AM, Eric Dumazet <edumazet@google.com> wrote:
> >
> >
> > On Thu, Jun 29, 2023 at 3:59=E2=80=AFAM Samuel Mendoza-Jonas
> > <samjonas@amazon.com> wrote:
> >>
> >> From: Stewart Smith <trawets@amazon.com>
> >>
> >> For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
> >> table with a hash over the source & destination addresses and ports.
> >> However, the IPv6 hash is insufficient and can lead to a high rate of
> >> collisions.
> >>
> >> The IPv6 hash used an XOR to fit everything into the 96 bits for the
> >> fast jenkins hash, meaning it is possible for an external entity to
> >> ensure the hash collides, thus falling back to a linear search in the
> >> bucket, which is slow.
> >>
> >> We take the approach of hash half the data; hash the other half; and
> >> then hash them together. We do this with 3x jenkins hashes rather than
> >> 2x to calculate the hashing value for the connection covering the full
> >> length of the addresses and ports.
> >>
> >
> > ...
> >
> >> While this may look like it adds overhead, the reality of modern CPUs
> >> means that this is unmeasurable in real world scenarios.
> >>
> >> In simulating with llvm-mca, the increase in cycles for the hashing co=
de
> >> was ~5 cycles on Skylake (from a base of ~50), and an extra ~9 on
> >> Nehalem (base of ~62).
> >>
> >> In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
> >> netfilter switched from a jenkins hash to a siphash, but even the fast=
er
> >> hsiphash is a more significant overhead (~20-30%) in some preliminary
> >> testing. So, in this patch, we keep to the more conservative approach =
to
> >> ensure we don't add much overhead per SYN.
> >>
> >> In testing, this results in a consistently even spread across the
> >> connection buckets. In both testing and real-world scenarios, we have
> >> not found any measurable performance impact.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
> >> Fixes: b3da2cf37c5c ("[INET]: Use jhash + random secret for ehash.")
> >> Signed-off-by: Stewart Smith <trawets@amazon.com>
> >> Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
> >> ---
> >> include/net/ipv6.h          | 4 +---
> >> net/ipv6/inet6_hashtables.c | 5 ++++-
> >> 2 files changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> >> index 7332296eca44..f9bb54869d82 100644
> >> --- a/include/net/ipv6.h
> >> +++ b/include/net/ipv6.h
> >> @@ -752,9 +752,7 @@ static inline u32 ipv6_addr_hash(const struct in6_=
addr *a)
> >> /* more secured version of ipv6_addr_hash() */
> >> static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u3=
2 initval)
> >> {
> >> -       u32 v =3D (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_ad=
dr32[1];
> >> -
> >> -       return jhash_3words(v,
> >> +       return jhash_3words((__force u32)a->s6_addr32[1],
> >>                            (__force u32)a->s6_addr32[2],
> >>                            (__force u32)a->s6_addr32[3],
> >>                            initval);
> >
> > Hmmm... see my following comment.
> >
> >> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> >> index b64b49012655..bb7198081974 100644
> >> --- a/net/ipv6/inet6_hashtables.c
> >> +++ b/net/ipv6/inet6_hashtables.c
> >> @@ -33,7 +33,10 @@ u32 inet6_ehashfn(const struct net *net,
> >>        net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_sec=
ret));
> >>        net_get_random_once(&ipv6_hash_secret, sizeof(ipv6_hash_secret)=
);
> >>
> >> -       lhash =3D (__force u32)laddr->s6_addr32[3];
> >> +       lhash =3D jhash_3words((__force u32)laddr->s6_addr32[3],
> >> +                           (((u32)lport) << 16) | (__force u32)fport,
> >> +                           (__force u32)faddr->s6_addr32[0],
> >> +                           ipv6_hash_secret);
> >
> > This seems wrong to me.
> >
> > Reusing ipv6_hash_secret and other keys twice is not good, I am sure
> > some security researchers
> > would love this...
>
> My personal math here is nowhere near what=E2=80=99s needed to work out i=
f it=E2=80=99s a problem or not, it passed the =E2=80=9CAm I a complete idi=
ot here?=E2=80=9D question of someone much smarter than me in the area, but=
 that=E2=80=99s not sustained scrutiny of course. It=E2=80=99s quite possib=
le there=E2=80=99s something there given enough time to noodle on it.
>
> > Please just change __ipv6_addr_jhash(), so that all users can benefit
> > from a more secure version ?
> > It also leaves lhash / fhash names relevant here.
> >
> > We will probably have to switch to sip (or other stronger hash than
> > jhash)  at some point, it is a tradeoff.
>
> Probably to a hsiphash?
>
> When using the same kind of sim with llvm-mca, hsiphash appears to be abo=
ut the same number of cycles as jhash2 you suggest, so maybe we should just=
 go there and be done with it?
>
> I put my tests and output up at https://github.com/stewartsmith/inet6_has=
hfn-sim
>
> I=E2=80=99ll throw some traffic at the hsiphash and see if we can observe=
 a difference.
>
> If nobody is madly complaining about netfilter switching to it as of dd6d=
2910c5e071a8683827df1a89e527aa5145ab, then it may be fine, but will throw s=
ome more benchmarks at it.
>

Make sure to include Amit Klein <aksecurity@gmail.com> to the next
round, he will "do the maths" for sure :)

Thanks.
