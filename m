Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F326F7197A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjFAJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjFAJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21394138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685612962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bSBV8Q60GdSQ9cSAx/GWXvbTZ/nLQNHe8IPVOifGAA=;
        b=W0qgd7793UnjKotRFcLnHY8JrUmH9oxnBMnJ2Sg1FkrRSaVrezEJzjssRwkBpDNAxtsG0E
        ioKbT29BqcM5nOTiT2m4ORp6YK4XdPRFmZDuMCGQyCql+A4xOITJ5OsJaVWuxNJHsPoXXC
        caVL4CMSxmLBhexLXqDnaEYPtogjS4Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-UNkL2QV4NoippsKJzAC3LA-1; Thu, 01 Jun 2023 05:49:20 -0400
X-MC-Unique: UNkL2QV4NoippsKJzAC3LA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75cb47e5507so7112685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612960; x=1688204960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bSBV8Q60GdSQ9cSAx/GWXvbTZ/nLQNHe8IPVOifGAA=;
        b=GpCvghk8JhqPlDbnnGvZBbetOc9fUkhv0b9AHWwZlsm9SVO+4fzzlLGIETqKgt8of+
         eVuKyxKLu3nI1XWjahfEX9PYoPVtmeqm1i4slUcKj99429aK+k81pHVLjWkYCq462XiF
         lniBHor9DLbwG3MHt0tOuHk47epJmXI9jvoDu6IeZa8E4OfNDG2qIOJjJzhSZIlEc9oJ
         qocBhnDcK7Z3Faw8nPSpPPT4ffdM5nfUN1ZDiel8aDbPKNKa/g4ye+QBZEe6s9+SG4Jf
         bnpKjASUGBN79J5rRt7FFe9dXH7oosa9PlR+uMjKLwwG6LRhvxfwPrZIPE9g3mBGBBxt
         9qdA==
X-Gm-Message-State: AC+VfDwhhzf1eIB+HWrwxt2+q8Fm4mV1BW8aBMjufeTrgv/REndyEmXQ
        PnJYRETp+bAMzAfq6DvXJM9kUdgMr87nlmJnX8w8ywHZzNI+mXa/yZdUKqRfF5lNHiX82iq4YPq
        YAIklXvcgAvA/aIzQC03h6uoU
X-Received: by 2002:a05:620a:17ab:b0:75b:23a1:829f with SMTP id ay43-20020a05620a17ab00b0075b23a1829fmr5373383qkb.0.1685612960368;
        Thu, 01 Jun 2023 02:49:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yBracybuX3X6v4h6rND3GfM88+X6dv2LFLqr5nImNW+d0uKGReZCHar0BcmPXwrs9IoB7eg==
X-Received: by 2002:a05:620a:17ab:b0:75b:23a1:829f with SMTP id ay43-20020a05620a17ab00b0075b23a1829fmr5373359qkb.0.1685612960126;
        Thu, 01 Jun 2023 02:49:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-89.dyn.eolo.it. [146.241.242.89])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a004f00b0075d22e15f1bsm367441qkt.129.2023.06.01.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:49:19 -0700 (PDT)
Message-ID: <bd2750e52b47af1782233e254114eb8d627f1073.camel@redhat.com>
Subject: Re: [PATCH net-next v2 08/10] crypto: af_alg: Support
 MSG_SPLICE_PAGES
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 01 Jun 2023 11:49:15 +0200
In-Reply-To: <20230530141635.136968-9-dhowells@redhat.com>
References: <20230530141635.136968-1-dhowells@redhat.com>
         <20230530141635.136968-9-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 15:16 +0100, David Howells wrote:
> Make AF_ALG sendmsg() support MSG_SPLICE_PAGES.  This causes pages to be
> spliced from the source iterator.
>=20
> This allows ->sendpage() to be replaced by something that can handle
> multiple multipage folios in a single transaction.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-crypto@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  crypto/af_alg.c         | 28 ++++++++++++++++++++++++++--
>  crypto/algif_aead.c     | 22 +++++++++++-----------
>  crypto/algif_skcipher.c |  8 ++++----
>  3 files changed, 41 insertions(+), 17 deletions(-)
>=20
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index fd56ccff6fed..62f4205d42e3 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -940,6 +940,10 @@ int af_alg_sendmsg(struct socket *sock, struct msghd=
r *msg, size_t size,
>  	bool init =3D false;
>  	int err =3D 0;
> =20
> +	if ((msg->msg_flags & MSG_SPLICE_PAGES) &&
> +	    !iov_iter_is_bvec(&msg->msg_iter))
> +		return -EINVAL;
> +
>  	if (msg->msg_controllen) {
>  		err =3D af_alg_cmsg_send(msg, &con);
>  		if (err)
> @@ -985,7 +989,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr=
 *msg, size_t size,
>  	while (size) {
>  		struct scatterlist *sg;
>  		size_t len =3D size;
> -		size_t plen;
> +		ssize_t plen;
> =20
>  		/* use the existing memory in an allocated page */
>  		if (ctx->merge) {
> @@ -1030,7 +1034,27 @@ int af_alg_sendmsg(struct socket *sock, struct msg=
hdr *msg, size_t size,
>  		if (sgl->cur)
>  			sg_unmark_end(sg + sgl->cur - 1);
> =20
> -		if (1 /* TODO check MSG_SPLICE_PAGES */) {
> +		if (msg->msg_flags & MSG_SPLICE_PAGES) {
> +			struct sg_table sgtable =3D {
> +				.sgl		=3D sg,
> +				.nents		=3D sgl->cur,
> +				.orig_nents	=3D sgl->cur,
> +			};
> +
> +			plen =3D extract_iter_to_sg(&msg->msg_iter, len, &sgtable,
> +						  MAX_SGL_ENTS, 0);

It looks like the above expect/supports only ITER_BVEC iterators, what
about adding a WARN_ON_ONCE(<other iov type>)?

Also, I'm keeping this series a bit more in pw to allow Herbert or
others to have a look.

Cheers,

Paolo

