Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41F7482EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGELcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGELcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:32:19 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B51703;
        Wed,  5 Jul 2023 04:32:18 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79470b88d88so1793061241.0;
        Wed, 05 Jul 2023 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688556737; x=1691148737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UPFOtJ/1P+Kya9sAeKB3ss7jxb+Td3mNLUw65FXVZE=;
        b=ESpveTcNMTg2mV5NGM/HfQrKl9BdxreUVnQ2sVGv7BnhSpNl9NSD+XsDL1c29JZT4W
         dHaO3ha+964ysYnoo1hoSorY68xHBIR2yp04DR1nhZxrEmnY/3Woh2VcvysAV1/3PE9T
         4oxp67ZpwHB4gmFGZXm8h9wCX7VpE7j3YWoGSHhWAHECNt43FrOlciCizhyDQna8HRCv
         nvpFefyAlRF8Nm/OwzOEq+vENVZguAGFGKUxe9cgeGUPJ4mnozuNr3J/1Hskbm/FTs8r
         19Jps3LAyQCxhfCnUU0EXQ9BoWPiTjaXIb1XuTTeCDGa/A26anM8nrkFfHUM0nE8ytRq
         +KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688556737; x=1691148737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UPFOtJ/1P+Kya9sAeKB3ss7jxb+Td3mNLUw65FXVZE=;
        b=Odht+bLcDqX/lqEPnecI5NXCQAlapl8wlpECn63EzMfXaE4FigWBBpU9evvATWE33T
         pr9oK/PEt00vHK0TTPSGd7pa1dnSnhV2+DLWG6nA2P2xCQmvh+O0ybv8EStY7PgeMKVQ
         8aStOv/T+WNVToJ4EDGbGh4LgRukmx9GAfW5QxQUJiZPSoliKX4T4iVf4N4en/39fvmQ
         pVmetjQVV5QQk8dx4uP73tcOQu/QMgAE4aTt/KRrHdGupWSAUbMhSFJ8oPKSGd0eYKPi
         XXoLRkygFbtmID/Drs0K43S3SVSZBAhyK52Atbu5y1fsxLq3hz8tPV16URnKpZD7ZJk4
         lrkA==
X-Gm-Message-State: ABy/qLbdqsbnLLicAwVLie/EqJvl+yUboE2LmTvq5o9SZSRF9BKf5ZE1
        qhA5GpRb5k4RFvfYTqfeA46+GEXYk+t/sVN3xnY=
X-Google-Smtp-Source: APBJJlF0hWbdvodH2g95WBviS61zOGFQ9d1/z1V8mJ5O9ZaBq0Aq2eSqb143Uh5C9R4ktk2KV07RMhD6X7qGorlOS3U=
X-Received: by 2002:a67:ad0b:0:b0:444:d19c:8fed with SMTP id
 t11-20020a67ad0b000000b00444d19c8fedmr4895498vsl.27.1688556737167; Wed, 05
 Jul 2023 04:32:17 -0700 (PDT)
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
 <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com> <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
In-Reply-To: <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 5 Jul 2023 13:32:05 +0200
Message-ID: <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > More stacktraces.. =3D)
> >
> > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > [  411.413767] ------------[ cut here ]------------
> > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud     p.h:509
> > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
> > net/ipv6/udp.c:787)
>
> I'm really running out of ideas here...
>
> This is:
>
>         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
>
> sort of hint skb being shared (skb->users > 1) while enqueued in
> multiple places (bridge local input and br forward/flood to tun
> device). I audited the bridge mc flooding code, and I could not find
> how a shared skb could land into the local input path.
>
> Anyway the other splats reported here and in later emails are
> compatible with shared skbs.
>
> The above leads to another bunch of questions:
> * can you reproduce the issue after disabling 'rx-gro-list' on the
> ingress device? (while keeping 'rx-udp-gro-forwarding' on).

With rx-gro-list off, as in never turned on, everything seems to run fine

> * do you have by chance qdiscs on top of the VM tun devices?

default qdisc is fq

> The last patch I shared was buggy, as it attempts to unclone the skb
> after already touching skb_shared_info.
>
> Could you please replace such patch with the following?

Will do, building atm

> Thanks!
>
> Paolo
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6c5915efbc17..0b0f4309506d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4261,6 +4261,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>
>         skb_push(skb, -skb_network_offset(skb) + offset);
>
> +       if (WARN_ON_ONCE(skb_shared(skb))) {
> +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> +               if (!skb)
> +                       goto err_linearize;
> +       }
> +
> +       /* later code will clear the gso area in the shared info */
> +       err =3D skb_unclone(skb, GFP_ATOMIC);
> +       if (err)
> +               goto err_linearize;
> +
>         skb_shinfo(skb)->frag_list =3D NULL;
>
>         while (list_skb) {
>
