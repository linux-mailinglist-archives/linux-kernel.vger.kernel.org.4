Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24D7188FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjEaSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEaSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:01:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D845134
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:01:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f70597707eso9055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685556062; x=1688148062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtXx/Jfs6Knj/1esq0QhOq1bu9UcHXAuIjS1Kq/WynM=;
        b=RShbKX+D/rfPkIjs2UArfcY1aHOI38aCfu1pYbqdT9dTL0o0SIJnjy8dXPZn3X2M1J
         x28HAtjsK1kfoy4neidQI+anFy7aguoo0simMy5L86yK7pbbxfDIiCUTlZIdZp1SZk9o
         cTPoJJQ3zZBBFBP/c24soy7Zom4cZ+aeXePyQ1r0w9+gw17vXz0YYHPXO9p6cnWZKIfu
         PH5q8KPTVnlBX2UgrOVR2HC94HGol3sIEPfXbCn6zUwK4ZdKSldbojck0dvNRWiLJEVO
         EMo1wME+fibnB7+fAf7jNFOH2VTFN5mdP/ZW32lgzObhWCy4mN4zCGzcTpDE+GSwv7Ed
         jXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685556062; x=1688148062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtXx/Jfs6Knj/1esq0QhOq1bu9UcHXAuIjS1Kq/WynM=;
        b=DJ6QIcpAGWP3pX4jHKbuPE5drDHJms93pTY0ZhIkaPdtUfFAPFNwNCBCAwRYOAwGbz
         UAdWZAQSenOdDW3bKUOh2eHzFMhEkSA8urHyCEAlfxawN//P5vjR6OIGIrk3LejdS91P
         5r/R36Rtfr/4SeIDFiIyXiPXbUbs4xxtEyE9rCz7917bBfXQkSb2Wgos6YrTRsvK38xK
         sDp75LHBcw0IxAfKoV4e6AtEh0WjzJCEcvfMyYa4UtwkUTNAEzF+lg5D8wd9wbjciI14
         IhZxD4mvWaCHQ5T3hT2peWDQlyWuKJqb1w1n4fXdZSx6X5J3ScauYRigzQTjyM+xxE2S
         CV+g==
X-Gm-Message-State: AC+VfDz7SOrFDEDZV0Xln4Ctu4RprTwopTUzBcsRbSDLt9VQ101W3hvK
        53vz8NZwrXWtGnJx+zO5oq1X6BZmFO54le/EfOl7CQ==
X-Google-Smtp-Source: ACHHUZ7ewBseHk7k3haVW+eJ3HUlmmPWIWunfMIDiJjubFS0ml4kDRhnaP4BrcKJlZ8PHaW/Fu02Yfn6PtMuEiRak4I=
X-Received: by 2002:a05:600c:1d90:b0:3f1:758c:dd23 with SMTP id
 p16-20020a05600c1d9000b003f1758cdd23mr947wms.7.1685556062379; Wed, 31 May
 2023 11:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531172158.90406-1-jon@nutanix.com> <CANn89iLE1d=MuSMTisEbLh6Q_c4rjagd8xuRj0PC-4ua0pDRPA@mail.gmail.com>
 <30861EDF-D063-43C7-94A7-9C3C5ED13E54@nutanix.com>
In-Reply-To: <30861EDF-D063-43C7-94A7-9C3C5ED13E54@nutanix.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 31 May 2023 20:00:50 +0200
Message-ID: <CANn89i+EKgtVnnq-LqtmHXd5Yg2WMVn5Uw+F7zM0jPRdaj3wsQ@mail.gmail.com>
Subject: Re: [PATCH] flow_dissector: introduce skb_get_hash_symmetric()
To:     Jon Kohler <jon@nutanix.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Guillaume Nault <gnault@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Qingqing Yang <qingqing.yang@broadcom.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Felix Fietkau <nbd@nbd.name>,
        Ludovic Cintrat <ludovic.cintrat@gatewatcher.com>,
        Jason Wang <jasowang@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, May 31, 2023 at 7:47=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On May 31, 2023, at 1:33 PM, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, May 31, 2023 at 7:22=E2=80=AFPM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >> tun.c changed from skb_get_hash() to __skb_get_hash_symmetric() on
> >> commit feec084a7cf4 ("tun: use symmetric hash"), which exposes an
> >> overhead for OVS datapath, where ovs_dp_process_packet() has to
> >> calculate the hash again because __skb_get_hash_symmetric() does not
> >> retain the hash that it calculates.
> >>
> >> Introduce skb_get_hash_symmetric(), which will get and save the hash
> >> in one go, so that calcuation work does not go to waste, and plumb it
> >> into tun.c.
> >>
> >> Fixes: feec084a7cf4 ("tun: use symmetric hash")
> >
> >
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> CC: Jason Wang <jasowang@redhat.com>
> >> CC: David S. Miller <davem@davemloft.net>
> >> ---
> >>
> >
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 0b40417457cd..8112b1ab5735 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -1474,6 +1474,7 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 has=
h, bool is_l4)
> >>
> >> void __skb_get_hash(struct sk_buff *skb);
> >> u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
> >> +u32 skb_get_hash_symmetric(struct sk_buff *skb);
> >> u32 skb_get_poff(const struct sk_buff *skb);
> >> u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
> >>                   const struct flow_keys_basic *keys, int hlen);
> >> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> >> index 25fb0bbc310f..d8c0e804bbfe 100644
> >> --- a/net/core/flow_dissector.c
> >> +++ b/net/core/flow_dissector.c
> >> @@ -1747,6 +1747,35 @@ u32 __skb_get_hash_symmetric(const struct sk_bu=
ff *skb)
> >> }
> >> EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
> >>
> >> +/**
> >> + * skb_get_hash_symmetric: calculate and set a flow hash in @skb, usi=
ng
> >> + * flow_keys_dissector_symmetric.
> >> + * @skb: sk_buff to calculate flow hash from
> >> + *
> >> + * This function is similar to __skb_get_hash_symmetric except that i=
t
> >> + * retains the hash within the skb, such that it can be reused withou=
t
> >> + * being recalculated later.
> >> + */
> >> +u32 skb_get_hash_symmetric(struct sk_buff *skb)
> >> +{
> >> +       struct flow_keys keys;
> >> +       u32 hash;
> >> +
> >> +       __flow_hash_secret_init();
> >> +
> >> +       memset(&keys, 0, sizeof(keys));
> >> +       __skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
> >> +                          &keys, NULL, 0, 0, 0,
> >> +                          FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
> >> +
> >> +       hash =3D __flow_hash_from_keys(&keys, &hashrnd);
> >> +
> >> +       __skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
> >> +
> >> +       return hash;
> >> +}
> >> +EXPORT_SYMBOL_GPL(skb_get_hash_symmetric);
> >> +
> >
> > Why copy/pasting __skb_get_hash_symmetric() ?
> >
> > Can you reuse it ?
>
> Not directly, because to use __skb_set_sw_hash requires struct flow_keys
> when using flow_keys_have_l4(). __skb_get_hash_symmetric() does not
> take or return that struct, so we=E2=80=99d either have to refactor that =
(and its callers)
> or introduce yet another function and consolidate down to that =E2=80=9Cn=
ew one=E2=80=9D.
>
> I played around with that exact thought by taking the functional guts out=
 of
> __skb_get_hash_symmetric, making it a new static function, plumbing that
> into __skb_get_hash_symmetric and this new skb_get_hash_symmetric, but
> the LOC churn was basically the same and it felt a bit worse than just a
> copy/paste.
>
> Alternatively, if it turned out that flow_keys_have_l4() wasn=E2=80=99t i=
mportant, we
> Could simply set that to false and then reuse __skb_get_hash_symmetric
> in a trivial manner. I couldn=E2=80=99t quite figure out if L4 flag was n=
ecessary, so I
> went the safe(maybe?) route and copy/paste instead.
>
> Happy to take suggestions either way!

There are 6 callers of __skb_get_hash_symmetric()

I would convert __skb_get_hash_symmetric()  to

skb_get_hash_symmetric(struct sk_buff *skb, bool record_hash)
