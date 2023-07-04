Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF37472AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGDNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGDNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:23:53 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F8F3;
        Tue,  4 Jul 2023 06:23:52 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-471b3ad20e1so1471891e0c.1;
        Tue, 04 Jul 2023 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688477032; x=1691069032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSiiFDXjl+Lpp4E2QISeF/M9219YCHb8h6as4n+mP/Q=;
        b=df8tRDBXMoxgCjpKyZV1RhrAkbjCqRs9SQcULafs37VE6+gBEGVE9JC+UfSVWT1my6
         OM2LQm1wB3r4Il+kqWIumo5eVmVqpJGiOPV6tOSId6VzIBL5NrIWzHKbnILstoreJ1+Q
         0xAlKBk4yPeQZjm2lwjILl8TW0a2nGc5aHyYhYmysf3JKTmJrMNVdzFmGRcylFNiaWjb
         7vdLE8UJKjlJRZ5r1g6q0Vhcrqtw5TXwZ9Nz2iHZIYA/VFFLBROlorbNVe8LrCFli7tq
         /WBsC1lCxzlal+h/eQxFtLuyEymlzePbagQD6gJ4NZgOkLJnWFEBt0MtugNeQjCZx1SZ
         WaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477032; x=1691069032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSiiFDXjl+Lpp4E2QISeF/M9219YCHb8h6as4n+mP/Q=;
        b=Iy+kclFncV8aFZo7FyYObxPIeMtl9V4uUcs6WCK3GD8TOgpustTbF5heTZ7qtB4jvW
         BGATog50Y+kjBx7v2c+fbW4id/Tz+Saz+WRWqW0iSwkh9bPqEcKIw0I9AfCAyb7FwdEq
         ZLLCK6aI3FPvCiY7n06Wi1/A1bjcmJtFXrU/LpUkgoBU+ZDBo1tARl4ZauC40dBqB1wn
         ROvGetpAnwEzPOAKWnhnOhtP2hhpkyu+hjbbJy4bTJgp9Yw9rVmd03GHGoXDswVe5ZoX
         s1JPA2pmIW+vSzfc1UHTpirJV/V1eWq3/PleEa0IWo0w3Dtj6MRYBY6vw5kWTSpYQdDr
         POLg==
X-Gm-Message-State: ABy/qLbYohB0ssqn7+cmTgngP4qx8mQm8fDCP7foIhUxYsOI9PQceUNE
        Hzrhtf5nI1gs/WvfF7lk9IX+rPh7zSWd9YTVDRA=
X-Google-Smtp-Source: APBJJlFgXvjChDNg5wodLBZkohrCxkIzY+gZW7QVCivYwEif4CcDQcEG6lbpp3JpXOlkwmA8WP73UkcMZ3ip4jlrOuw=
X-Received: by 2002:a1f:e484:0:b0:471:b18a:f9e5 with SMTP id
 b126-20020a1fe484000000b00471b18af9e5mr4149205vkh.4.1688477031784; Tue, 04
 Jul 2023 06:23:51 -0700 (PDT)
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
 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com> <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
In-Reply-To: <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 4 Jul 2023 15:23:40 +0200
Message-ID: <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 2:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Tue, 2023-07-04 at 13:36 +0200, Ian Kumlien wrote:
> > Propper bug this time:
> > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
>
> To be sure, is this with the last patch I shared? this one I mean:

The current modifications I have, on top of v6.4.1, is:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cea28d30abb5..8552caa197f9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4272,6 +4272,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb=
,

        skb_shinfo(skb)->frag_list =3D NULL;

+       /* later code will clear the gso area in the shared info */
+       err =3D skb_header_unclone(skb, GFP_ATOMIC);
+       if (err)
+               goto err_linearize;
+
        while (list_skb) {
                nskb =3D list_skb;
                list_skb =3D list_skb->next;
@@ -4328,6 +4333,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,

        skb->prev =3D tail;

+       if (WARN_ON_ONCE(!skb->next))
+               goto err_linearize;
+
        if (skb_needs_linearize(skb, features) &&
            __skb_linearize(skb))
                goto err_linearize;
---

> https://lore.kernel.org/netdev/92a4d42491a2c219192ae86fa04b579ea3676d8c.c=
amel@redhat.com/
>
> Could you please additionally enable CONFIG_DEBUG_NET in your build?

Sure, will do

> Could you please give a detailed description of your network topology
> and the running traffic?

This machine has two "real interfaces" and two interfaces that runs as
bridges for virtual machines
eno1 - real internal
eno2 - bridge - internal
eno3 - real external
eno4 - bridge - external

The bridges are used by three virtual machines, two of which are
attached on both networks

Traffic seemed to be video streaming, at least at first, now I don't
really know. I do have a few smart devices so I assume there is
a bit of multicast traffic as well - but not really anything unusual as suc=
h.

> Thanks!
>
> Paolo
>
