Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C247423BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF2KLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjF2KI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:08:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEE44A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:05:42 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401f4408955so194411cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688033141; x=1690625141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53kXaqEUom5GCaioc4bl7JRGZ5sp8FvMcIkzS408jNI=;
        b=oUcEzcSDnOtplpv6jr7yAxIcwth23qX90Q/ADDC/r0ol4cdG/0WFE/LdRD6cVTtjrl
         YrCH4cLIHg22THQELbD30RZlUqdNrkkZcp7Qmc7Pdb1JVZYlqoq1NtcoabY1L0QAixuA
         Zt1b5DGKDC0jUHCrb0L8d1+zIeaCmOi0zh64cs15dSnj9/ifjwlx8CwRWbAq1BV/aMt4
         pHgGBIe/8l5JQV692ZFmrsguXxN9NEC0e0s8f0qgl0OmP3vYrm3Jv2Y+Yvo0YeIDG+ql
         XPUM6dQZcHRzRQq8FC9R83l8YMuRN8gD7ywdVokBWyY1I+LNYXmWSDz6E0LjbaQkFJoF
         THzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688033141; x=1690625141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53kXaqEUom5GCaioc4bl7JRGZ5sp8FvMcIkzS408jNI=;
        b=a2fIw+3VQnaqqicxsUmGTFrdrakVDJFI9jGu/kM1kI16kieH5RxmlVZABtHemPVW8Y
         0aGR8Uk6j4X5mYrcnFjUEUKs1RczDRX24sDH+ht5+GPTLMh8iCOSe5zpPsZsThlTUjVe
         dOuBRYWwM/Hf0IETjHlAwUAb20Fewe3IXDTBz52wx2HpF8dxLOCH8nm/YDonxdKs7qz9
         kM2vG61vymZShcRR47MWdGjLIcZ2T24kcd5xB08Bz7myuwGAb0m8pjjyUHQmo8jH7Crb
         MED/+sBlF3e+DwZsVhaZC6Wy0Ych8GKprgOV2udkh79DAKJKHB2eesRRCs5aetYCVBsw
         JiVQ==
X-Gm-Message-State: AC+VfDwRyPObUBbAh+sxSd6dnDJmyJsWGguKLX/tseGcLFMG9LPgdzNA
        Yi4qhNjFSku5TBOgpqMtJdpLZCfOjaHWuePctaos9Q==
X-Google-Smtp-Source: ACHHUZ4cDKzyvP+R/YnJL96VIhWmdoovDKEZEFSvG71MjFqTZDs/6dSXFDfbObtnZQUeifbTFq5sMUFwBMdAezyQsMg=
X-Received: by 2002:a05:622a:1393:b0:3de:1aaa:42f5 with SMTP id
 o19-20020a05622a139300b003de1aaa42f5mr480089qtk.15.1688033140929; Thu, 29 Jun
 2023 03:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230629015844.800280-1-samjonas@amazon.com>
In-Reply-To: <20230629015844.800280-1-samjonas@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 29 Jun 2023 12:05:29 +0200
Message-ID: <CANn89i+6d9K1VwNK1Joc-Yb_4jAfV_YFzk=z_K2_Oy+xJHSn_g@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: Reduce chance of collisions in inet6_hashfn()
To:     Samuel Mendoza-Jonas <samjonas@amazon.com>
Cc:     netdev@vger.kernel.org, Stewart Smith <trawets@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        benh@amazon.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 3:59=E2=80=AFAM Samuel Mendoza-Jonas
<samjonas@amazon.com> wrote:
>
> From: Stewart Smith <trawets@amazon.com>
>
> For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
> table with a hash over the source & destination addresses and ports.
> However, the IPv6 hash is insufficient and can lead to a high rate of
> collisions.
>
> The IPv6 hash used an XOR to fit everything into the 96 bits for the
> fast jenkins hash, meaning it is possible for an external entity to
> ensure the hash collides, thus falling back to a linear search in the
> bucket, which is slow.
>
> We take the approach of hash half the data; hash the other half; and
> then hash them together. We do this with 3x jenkins hashes rather than
> 2x to calculate the hashing value for the connection covering the full
> length of the addresses and ports.
>

...

> While this may look like it adds overhead, the reality of modern CPUs
> means that this is unmeasurable in real world scenarios.
>
> In simulating with llvm-mca, the increase in cycles for the hashing code
> was ~5 cycles on Skylake (from a base of ~50), and an extra ~9 on
> Nehalem (base of ~62).
>
> In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
> netfilter switched from a jenkins hash to a siphash, but even the faster
> hsiphash is a more significant overhead (~20-30%) in some preliminary
> testing. So, in this patch, we keep to the more conservative approach to
> ensure we don't add much overhead per SYN.
>
> In testing, this results in a consistently even spread across the
> connection buckets. In both testing and real-world scenarios, we have
> not found any measurable performance impact.
>
> Cc: stable@vger.kernel.org
> Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
> Fixes: b3da2cf37c5c ("[INET]: Use jhash + random secret for ehash.")
> Signed-off-by: Stewart Smith <trawets@amazon.com>
> Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
> ---
>  include/net/ipv6.h          | 4 +---
>  net/ipv6/inet6_hashtables.c | 5 ++++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 7332296eca44..f9bb54869d82 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -752,9 +752,7 @@ static inline u32 ipv6_addr_hash(const struct in6_add=
r *a)
>  /* more secured version of ipv6_addr_hash() */
>  static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 =
initval)
>  {
> -       u32 v =3D (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr3=
2[1];
> -
> -       return jhash_3words(v,
> +       return jhash_3words((__force u32)a->s6_addr32[1],
>                             (__force u32)a->s6_addr32[2],
>                             (__force u32)a->s6_addr32[3],
>                             initval);

Hmmm... see my following comment.

> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b64b49012655..bb7198081974 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -33,7 +33,10 @@ u32 inet6_ehashfn(const struct net *net,
>         net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_secre=
t));
>         net_get_random_once(&ipv6_hash_secret, sizeof(ipv6_hash_secret));
>
> -       lhash =3D (__force u32)laddr->s6_addr32[3];
> +       lhash =3D jhash_3words((__force u32)laddr->s6_addr32[3],
> +                           (((u32)lport) << 16) | (__force u32)fport,
> +                           (__force u32)faddr->s6_addr32[0],
> +                           ipv6_hash_secret);

This seems wrong to me.

Reusing ipv6_hash_secret and other keys twice is not good, I am sure
some security researchers
would love this...

Please just change __ipv6_addr_jhash(), so that all users can benefit
from a more secure version ?
It also leaves lhash / fhash names relevant here.

We will probably have to switch to sip (or other stronger hash than
jhash)  at some point, it is a tradeoff.

We might also add a break in the loop when a bucket exceeds a given
safety length,
because attackers can eventually exploit hashes after some point.

The following patch looks much saner to me.

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44b84dca1bbecb545f6824a0e8ed3d..2acc4c808d45d1c1bb1c5076e79=
842e136203e4c
100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -752,12 +752,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr=
 *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const
u32 initval)
 {
-       u32 v =3D (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[=
1];
-
-       return jhash_3words(v,
-                           (__force u32)a->s6_addr32[2],
-                           (__force u32)a->s6_addr32[3],
-                           initval);
+       return jhash2((__force const u32 *)a->s6_addr32,
+                     ARRAY_SIZE(a->s6_addr32), initval);
 }
