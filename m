Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A137472F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGDNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGDNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95DE6E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688478084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wN6My7QkCSTDEbV1bafiq227wzDsbUpmpzFl4pw15UQ=;
        b=Opop9tuzD9e5vNWNtS3I6NvA0bUV91u0+jUdRBG6/7yT+4qIHyvE4/K66tvfPFf9yvrXtX
        cvjuJ7YsSsmjR0cx+0HDggekCWFr3mBbWAQxywiB8NtBpWVs8YGUHYQVrSsWGbhs97yHP0
        alG1dFJlvHUt3Un6SyxM2yU+6XAlqd0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-XCUvHVGSOLeG8DM-kUriaw-1; Tue, 04 Jul 2023 09:41:23 -0400
X-MC-Unique: XCUvHVGSOLeG8DM-kUriaw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62dd79f63e0so12675186d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478083; x=1691070083;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN6My7QkCSTDEbV1bafiq227wzDsbUpmpzFl4pw15UQ=;
        b=H/Cl09X4H8QT3UWGw/dCwvz9BkDhIRjcEZzvzszGBLeOCjwv/GtW87lCNg+Lhlevoy
         3li1vD0vZkzqpuLexKxTmya5ZIAjuiOX9uHPhFwQBnDC51dY8bAJB6Jndl+GzIT+HJat
         j+kaBJdBx7wM7XxK3eyIPOmU2YhTwLcPTphLtFg8vMgYi6rdWUTHWzoDsicMlGyLtiCz
         UxP+hDp4CvOTY8xNTmxWl0xMHjd8xdaimK33o12xb2Mf1rflxvcMyjWk9UeUztw9VM2Y
         OIAKWq0WpGpw+tbHNMqOtw4jmb7hi1LlKeg1afOPl/BIXnTv9RZuGYMZIFoWJm1LXO79
         MctQ==
X-Gm-Message-State: ABy/qLYz8jyQb3NaMOO1zLhnVg1v6JIMh5U5yplF8LipIVUYeUSzx3KR
        ybY2OdyDNGC8z5keQlzj3+A+rFVePNkEAqFfsyy4UvJDOk7jFvxcsV8B2VZeMBQMsXmlQervDXl
        elUVfuhdj1stJgebU5/9B2u13
X-Received: by 2002:a05:6214:2aa3:b0:636:e4f:6b88 with SMTP id js3-20020a0562142aa300b006360e4f6b88mr14204373qvb.1.1688478083396;
        Tue, 04 Jul 2023 06:41:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXCCe62PE3K++Fb0dctl/2E4pM6lZzo0WB+ybxV1kEqus5eoSqkO8gs6NXLp3YpVeadEFZrA==
X-Received: by 2002:a05:6214:2aa3:b0:636:e4f:6b88 with SMTP id js3-20020a0562142aa300b006360e4f6b88mr14204362qvb.1.1688478083156;
        Tue, 04 Jul 2023 06:41:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id p1-20020a05621415c100b006260c683bf2sm12551882qvz.53.2023.07.04.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:41:22 -0700 (PDT)
Message-ID: <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 04 Jul 2023 15:41:19 +0200
In-Reply-To: <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
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

On Tue, 2023-07-04 at 15:23 +0200, Ian Kumlien wrote:
> On Tue, Jul 4, 2023 at 2:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Tue, 2023-07-04 at 13:36 +0200, Ian Kumlien wrote:
> > > Propper bug this time:
> > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> >=20
> > To be sure, is this with the last patch I shared? this one I mean:
>=20
> The current modifications I have, on top of v6.4.1, is:
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index cea28d30abb5..8552caa197f9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4272,6 +4272,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>=20
>         skb_shinfo(skb)->frag_list =3D NULL;
>=20
> +       /* later code will clear the gso area in the shared info */
> +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> +       if (err)
> +               goto err_linearize;
> +
>         while (list_skb) {
>                 nskb =3D list_skb;
>                 list_skb =3D list_skb->next;
> @@ -4328,6 +4333,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *sk=
b,
>=20
>         skb->prev =3D tail;
>=20
> +       if (WARN_ON_ONCE(!skb->next))
> +               goto err_linearize;
> +
>         if (skb_needs_linearize(skb, features) &&
>             __skb_linearize(skb))
>                 goto err_linearize;
> ---
>=20
> > https://lore.kernel.org/netdev/92a4d42491a2c219192ae86fa04b579ea3676d8c=
.camel@redhat.com/
> >=20
> > Could you please additionally enable CONFIG_DEBUG_NET in your build?
>=20
> Sure, will do
>=20
> > Could you please give a detailed description of your network topology
> > and the running traffic?
>=20
> This machine has two "real interfaces" and two interfaces that runs as
> bridges for virtual machines
> eno1 - real internal
> eno2 - bridge - internal
> eno3 - real external
> eno4 - bridge - external
>=20
> The bridges are used by three virtual machines, two of which are
> attached on both networks
>=20
> Traffic seemed to be video streaming, at least at first, now I don't
> really know. I do have a few smart devices so I assume there is
> a bit of multicast traffic as well - but not really anything unusual as s=
uch.

In there any XDP program running on the host side? Possibly changing
the packet hdr?

Thanks!

/P

