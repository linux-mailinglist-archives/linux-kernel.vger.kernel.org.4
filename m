Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423BF6807DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjA3Ivr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjA3Ivo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1EE269F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675068614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETWZiFJuvDxfRpj4m9fhbGhq8mdnQQj8KzaCMCobHmE=;
        b=PghlcQ+PjoEqYH2UeAWTBvtdNWCUdkW3bMlQR6AHbOuFgYXJh0tFTtUk/FDsmAyrfgLPkM
        KFqyAsQCSvwuQIeNQ03xajGRhVnFlGz4aiwkyjL757eR5CbRy4B2xDjXAFVnMN+v3IbwIM
        avLdpVs8gtksVhzZBcigFI1w05yAIp0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-cfb5ZvYwO5eDMTp-Yyfw5A-1; Mon, 30 Jan 2023 03:50:12 -0500
X-MC-Unique: cfb5ZvYwO5eDMTp-Yyfw5A-1
Received: by mail-qk1-f197.google.com with SMTP id bq15-20020a05620a468f00b00706ae242abcso6766627qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETWZiFJuvDxfRpj4m9fhbGhq8mdnQQj8KzaCMCobHmE=;
        b=mHMe2zpm0MquX6LunVLSoWE0S06nhlLLZJbzfh/US9iUHpPifR2zr1JF3wPvhrtoTg
         FnzGcHDogp9FRZO6qaFEWIkob9mnCK7YV42bLjtDKdRFFzJsAl2TMg6E6MWsUzerl54Y
         D77h4e9fFjrBsN3rB1Exs8JwNs+H4JunUvS4ESdJg0XxBhEJt9jtKE7x1jlvlXB6Fzt0
         hkCqrZ6PW0y8lkehQaHhd2FN1fRqA6WtP0j4cHho1viHYJo42NGa8Z4XT8lNe8ZFI91w
         y2ZzZRiQTIyWmxNMQK/Zu1uqk6Y1xdfcudO53kWUDMhlsZaaOsvI76NK6zpfWm93LHLP
         UWZA==
X-Gm-Message-State: AFqh2kpyt9hLgdkzP55YmSHbaarxxHmSEo/q6IgfcVdCH7XATbFekWFA
        qKyI+r4IkjCLWXYNLswomQRFT4nIjB6WDWrQh2iIYPFuTX0MofYr5LLclJuM73a6cwEgkpbAZLX
        EqP9TzV7a/Mjgfbo7is2uBaAI
X-Received: by 2002:a05:6214:3c98:b0:534:a801:1117 with SMTP id ok24-20020a0562143c9800b00534a8011117mr70508929qvb.49.1675068612343;
        Mon, 30 Jan 2023 00:50:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt62wRIQFd2BqlEWxGlcfaPxrQtbtWHJYjjiPiNI6lpwthrnpINmGwCX2M3B3u0AyoiV+x2Wg==
X-Received: by 2002:a05:6214:3c98:b0:534:a801:1117 with SMTP id ok24-20020a0562143c9800b00534a8011117mr70508915qvb.49.1675068612068;
        Mon, 30 Jan 2023 00:50:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id dy31-20020a05620a60df00b0070531c5d655sm7694441qkb.90.2023.01.30.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:50:11 -0800 (PST)
Message-ID: <ec534eacabf5c859930eb5ca7f417f7f01197d24.camel@redhat.com>
Subject: Re: [net PATCH] skb: Do mix page pool and page referenced frags in
 GRO
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexander.duyck@gmail.com>, nbd@nbd.name,
        davem@davemloft.net, hawk@kernel.org, ilias.apalodimas@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        netdev@vger.kernel.org
Date:   Mon, 30 Jan 2023 09:50:08 +0100
In-Reply-To: <CANn89iKgZU4Q+THXupzZi4hETuKuCOvOB=iHpp5JzQTNv_Fg_A@mail.gmail.com>
References: <04e27096-9ace-07eb-aa51-1663714a586d@nbd.name>
         <167475990764.1934330.11960904198087757911.stgit@localhost.localdomain>
         <cde24ed8-1852-ce93-69f3-ff378731f52c@huawei.com>
         <20230127212646.4cfeb475@kernel.org>
         <CANn89iKgZU4Q+THXupzZi4hETuKuCOvOB=iHpp5JzQTNv_Fg_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-28 at 08:08 +0100, Eric Dumazet wrote:
> On Sat, Jan 28, 2023 at 6:26 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >=20
> > On Sat, 28 Jan 2023 10:37:47 +0800 Yunsheng Lin wrote:
> > > If we are not allowing gro for the above case, setting NAPI_GRO_CB(p)=
->flush
> > > to 1 in gro_list_prepare() seems to be making more sense so that the =
above
> > > case has the same handling as skb_has_frag_list() handling?
> > > https://elixir.bootlin.com/linux/v6.2-rc4/source/net/core/gro.c#L503
> > >=20
> > > As it seems to avoid some unnecessary operation according to comment
> > > in tcp4_gro_receive():
> > > https://elixir.bootlin.com/linux/v6.2-rc4/source/net/ipv4/tcp_offload=
.c#L322
> >=20
> > The frag_list case can be determined with just the input skb.
> > For pp_recycle we need to compare input skb's pp_recycle with
> > the pp_recycle of the skb already held by GRO.
> >=20
> > I'll hold off with applying a bit longer tho, in case Eric
> > wants to chime in with an ack or opinion.
>=20
> We can say that we are adding in the fast path an expensive check
> about an unlikely condition.
>=20
> GRO is by far the most expensive component in our stack.

Slightly related to the above: currently the GRO engine performs the
skb metadata check for every packet. My understanding is that even with
XDP enabled and ebpf running on the given packet, the skb should=20
usually have meta_len =3D=3D 0.=C2=A0

What about setting 'skb->slow_gro' together with meta_len and moving
the skb_metadata_differs() check under the slow_gro guard?

Cheers,

Paolo

