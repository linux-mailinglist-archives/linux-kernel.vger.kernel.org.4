Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF473B28E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFWITZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFWITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24522118
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687508316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkaQxx+Y1hANa87C64UPOn1w6sw0j2xvZ0R3DPOEvLI=;
        b=clVftSn6OMIAYMDeWdfaH55xpUnacHkxiEIB3viosNWPDbG8DZTvyrRXkFSRBOWBnjyKsW
        y3wdNHjtRladMhXmwHq34HO2k7MuYtENc4KJl161eRjAxQ8qAerwqXp9MRFk2c9bPF2sbi
        DwSU6+spNUFYgnJ8SSG/9Iu77DMvK48=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-8aQGnOAcMEmB_jRvFaqZBQ-1; Fri, 23 Jun 2023 04:18:29 -0400
X-MC-Unique: 8aQGnOAcMEmB_jRvFaqZBQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62ff7a8b9aeso928166d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508308; x=1690100308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkaQxx+Y1hANa87C64UPOn1w6sw0j2xvZ0R3DPOEvLI=;
        b=fjjPQ4scoo2rRVtVNQyx1ENgUUKwpK89LSCMp2r8RsK7qymWQfllOhSBmoiHfHZ3xD
         W9AILHqb5tmRmaMUqFDcl7xgg3ZG4VcQcxZoPxAGJwiJbgeMc1BWNH5qHL4Yyue6UrlG
         DPeYRS1RVv+YCVNmItkrEZDb4CL5VNAGO1nTGKo4AMilv9xBqJCQtdL4qo6IvDnDLu9m
         O/18W0UCfm5tPIz9tgrtNhsSvLTIibp2fa49JVoSERHKXRf7VXCHmRTKCqcbGkxRjk6V
         HwSxhvnaoFgvWtSMDmWr4YUoR9Hc+qW25c7em4L6LXIdx4vPWv0yBmFdAcIEYtLt5GHl
         oBtQ==
X-Gm-Message-State: AC+VfDzwnAnsT8dkuTJ8yDSV2dPpq0qicfCwEGmjeZvn/sDwmWXJ1QYs
        f1pbMnP0ab6VP0G5Q7tSeBGNlDAWQbE66utHB3QUGyx+FgpaJjfMo4fuiZg2l+euc73gMFQ4qx+
        NALWAyj1x/t9xgkwZk3Ef7Cbx
X-Received: by 2002:a05:6214:2426:b0:62f:e386:1e45 with SMTP id gy6-20020a056214242600b0062fe3861e45mr23780094qvb.1.1687508308657;
        Fri, 23 Jun 2023 01:18:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FUnG3bG8uHAhc8j3r/ENi0CHUWTQvEeqCtObZFm1IgXCwU67fCwyZEOd9Nuyxm4AXcz667w==
X-Received: by 2002:a05:6214:2426:b0:62f:e386:1e45 with SMTP id gy6-20020a056214242600b0062fe3861e45mr23780085qvb.1.1687508308351;
        Fri, 23 Jun 2023 01:18:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id m1-20020a0ce6e1000000b006238b37fb05sm4759922qvn.119.2023.06.23.01.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:18:28 -0700 (PDT)
Message-ID: <2ee000f803bd1a099aa8fb02ef79c7b25e5f5b08.camel@redhat.com>
Subject: Re: [PATCH net-next v3 02/18] net: Display info about
 MSG_SPLICE_PAGES memory handling in proc
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date:   Fri, 23 Jun 2023 10:18:24 +0200
In-Reply-To: <20230620145338.1300897-3-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
         <20230620145338.1300897-3-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-20 at 15:53 +0100, David Howells wrote:
> Display information about the memory handling MSG_SPLICE_PAGES does to co=
py
> slabbed data into page fragments.
>=20
> For each CPU that has a cached folio, it displays the folio pfn, the offs=
et
> pointer within the folio and the size of the folio.
>=20
> It also displays the number of pages refurbished and the number of pages
> replaced.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Duyck <alexander.duyck@gmail.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: David Ahern <dsahern@kernel.org>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Menglong Dong <imagedong@tencent.com>
> cc: netdev@vger.kernel.org
> ---
>  net/core/skbuff.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d962c93a429d..36605510a76d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -83,6 +83,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/textsearch.h>
> +#include <linux/proc_fs.h>
> =20
>  #include "dev.h"
>  #include "sock_destructor.h"
> @@ -6758,6 +6759,7 @@ nodefer:	__kfree_skb(skb);
>  struct skb_splice_frag_cache {
>  	struct folio	*folio;
>  	void		*virt;
> +	unsigned int	fsize;
>  	unsigned int	offset;
>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>  	 * containing page->_refcount every time we allocate a fragment.
> @@ -6767,6 +6769,26 @@ struct skb_splice_frag_cache {
>  };
> =20
>  static DEFINE_PER_CPU(struct skb_splice_frag_cache, skb_splice_frag_cach=
e);
> +static atomic_t skb_splice_frag_replaced, skb_splice_frag_refurbished;

(in case we don't agree to restrict this series to just remove
MSG_SENDPAGE_NOTLAST)

Have you considered percpu counters instead of the above atomics?

I think the increments are in not so unlikely code-paths, and the
contention there could possibly hurt performances.

Thanks,

Paolo


