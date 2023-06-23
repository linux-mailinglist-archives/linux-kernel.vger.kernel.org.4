Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED2873B261
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFWIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFWIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA381FF7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687507735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRsrloG5XK9IUekWqHBCtRBKWd5yuNn8Erowenhh7uo=;
        b=Luf4Sie1Vj2nBzVSkceNdeRVrU3IxSTdapEKHLbMtabM5slvd5k2PqhfLr0wu8YyKuSDYf
        fDmPpPSbKZazezu5p7puX0QHaG0t+F6WO6PAJ+xKAVUtfiLt2ExQ9bsBFCkJsnHEn7B8wt
        RtR2h25FRAevZfAjCcKUAgBR3juswBk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-c-eq6Dx_PTCTk223_YbhMg-1; Fri, 23 Jun 2023 04:08:54 -0400
X-MC-Unique: c-eq6Dx_PTCTk223_YbhMg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62ff7a8b9aeso908846d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507733; x=1690099733;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRsrloG5XK9IUekWqHBCtRBKWd5yuNn8Erowenhh7uo=;
        b=Uujb1HYFrz9H8iCpFx8d39rYXiCXbIcQNsT/Gp3QW+eDnkKRtJEkwY5eMvWLiR9sTM
         3KYrgbYWsKCuHpq5UO5Nw0LyXnPqBlkh8NTAsg1YnsXcn4U81Qni953FlFb42snwjkhm
         Q+437Sw16Jjr9/yUslc+5oAmzoCRO7nvaJp1ybZbPXgCbjVyEq1lpN4sg8xWXG4yvN3E
         c3ccqSYiIfZUN+dngqqXzKeUR/KBhD4Zf4/phuyPgStSkyqcDZzh1morKqhSNgxhGP1W
         49dq8rBcbwJjBviHNLPwhQfBxnzCGCK37vjax43BFLUzwdVbkRxV0Bq9xiuibKQUUs8O
         5svQ==
X-Gm-Message-State: AC+VfDwdd6RgBy+/EANzgwWOSXccEc/iwrW/NB+O6OB6Y9RSc64Nzmcw
        uYoiNqUANNN9tvf4V1xljAOXFb/JgWGsfoKF3ix2xtMMlLoFjuN2bpQt7eC3PUjvyeJ+/F/01l/
        gsgDqX2sZEle3c2dm0tQFpFQd
X-Received: by 2002:ad4:5945:0:b0:625:aa48:e50f with SMTP id eo5-20020ad45945000000b00625aa48e50fmr23823138qvb.6.1687507733601;
        Fri, 23 Jun 2023 01:08:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4np55509X5SjvvyV/z6p3nBJkRmzoebgMoA+uLUJVCIrabJOfi5M325Mt3d67PAMUYklxL7Q==
X-Received: by 2002:ad4:5945:0:b0:625:aa48:e50f with SMTP id eo5-20020ad45945000000b00625aa48e50fmr23823134qvb.6.1687507733324;
        Fri, 23 Jun 2023 01:08:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id y1-20020a0ce041000000b005dd8b9345b4sm4748746qvk.76.2023.06.23.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:08:53 -0700 (PDT)
Message-ID: <634c885ccfb2e49e284aedc60e157bb12e5f3530.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
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
Date:   Fri, 23 Jun 2023 10:08:48 +0200
In-Reply-To: <20230620145338.1300897-2-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
         <20230620145338.1300897-2-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First thing first, I'm sorry for the delayed feedback. I was traveling.

On Tue, 2023-06-20 at 15:53 +0100, David Howells wrote:
> If sendmsg() is passed MSG_SPLICE_PAGES and is given a buffer that contai=
ns
> some data that's resident in the slab, copy it rather than returning EIO.
> This can be made use of by a number of drivers in the kernel, including:
> iwarp, ceph/rds, dlm, nvme, ocfs2, drdb.  It could also be used by iscsi,
> rxrpc, sunrpc, cifs and probably others.
>=20
> skb_splice_from_iter() is given it's own fragment allocator as
> page_frag_alloc_align() can't be used because it does no locking to preve=
nt
> parallel callers from racing.  alloc_skb_frag() uses a separate folio for
> each cpu and locks to the cpu whilst allocating, reenabling cpu migration
> around folio allocation.
>=20
> This could allocate a whole page instead for each fragment to be copied, =
as
> alloc_skb_with_frags() would do instead, but that would waste a lot of
> space (most of the fragments look like they're going to be small).
>=20
> This allows an entire message that consists of, say, a protocol header or
> two, a number of pages of data and a protocol footer to be sent using a
> single call to sock_sendmsg().
>=20
> The callers could be made to copy the data into fragments before calling
> sendmsg(), but that then penalises them if MSG_SPLICE_PAGES gets ignored.
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
>=20
> Notes:
>     ver #3)
>      - Remove duplicate decl of skb_splice_from_iter().
>    =20
>     ver #2)
>      - Fix parameter to put_cpu_ptr() to have an '&'.
>=20
>  include/linux/skbuff.h |   2 +
>  net/core/skbuff.c      | 171 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 170 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 91ed66952580..5f53bd5d375d 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5037,6 +5037,8 @@ static inline void skb_mark_for_recycle(struct sk_b=
uff *skb)
>  #endif
>  }
> =20
> +void *alloc_skb_frag(size_t fragsz, gfp_t gfp);
> +void *copy_skb_frag(const void *s, size_t len, gfp_t gfp);
>  ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>  			     ssize_t maxsize, gfp_t gfp);
> =20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index fee2b1c105fe..d962c93a429d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6755,6 +6755,145 @@ nodefer:	__kfree_skb(skb);
>  		smp_call_function_single_async(cpu, &sd->defer_csd);
>  }
> =20
> +struct skb_splice_frag_cache {
> +	struct folio	*folio;
> +	void		*virt;
> +	unsigned int	offset;
> +	/* we maintain a pagecount bias, so that we dont dirty cache line
> +	 * containing page->_refcount every time we allocate a fragment.
> +	 */
> +	unsigned int	pagecnt_bias;
> +	bool		pfmemalloc;
> +};
> +
> +static DEFINE_PER_CPU(struct skb_splice_frag_cache, skb_splice_frag_cach=
e);
> +
> +/**
> + * alloc_skb_frag - Allocate a page fragment for using in a socket
> + * @fragsz: The size of fragment required
> + * @gfp: Allocation flags
> + */
> +void *alloc_skb_frag(size_t fragsz, gfp_t gfp)
> +{
> +	struct skb_splice_frag_cache *cache;
> +	struct folio *folio, *spare =3D NULL;
> +	size_t offset, fsize;
> +	void *p;
> +
> +	if (WARN_ON_ONCE(fragsz =3D=3D 0))
> +		fragsz =3D 1;
> +
> +	cache =3D get_cpu_ptr(&skb_splice_frag_cache);
> +reload:
> +	folio =3D cache->folio;
> +	offset =3D cache->offset;
> +try_again:
> +	if (fragsz > offset)
> +		goto insufficient_space;
> +
> +	/* Make the allocation. */
> +	cache->pagecnt_bias--;
> +	offset =3D ALIGN_DOWN(offset - fragsz, SMP_CACHE_BYTES);
> +	cache->offset =3D offset;
> +	p =3D cache->virt + offset;
> +	put_cpu_ptr(&skb_splice_frag_cache);
> +	if (spare)
> +		folio_put(spare);
> +	return p;
> +
> +insufficient_space:
> +	/* See if we can refurbish the current folio. */
> +	if (!folio || !folio_ref_sub_and_test(folio, cache->pagecnt_bias))
> +		goto get_new_folio;
> +	if (unlikely(cache->pfmemalloc)) {
> +		__folio_put(folio);
> +		goto get_new_folio;
> +	}
> +
> +	fsize =3D folio_size(folio);
> +	if (unlikely(fragsz > fsize))
> +		goto frag_too_big;
> +
> +	/* OK, page count is 0, we can safely set it */
> +	folio_set_count(folio, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +
> +	/* Reset page count bias and offset to start of new frag */
> +	cache->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +	offset =3D fsize;
> +	goto try_again;

IMHO this function uses a bit too much labels and would be more easy to
read, e.g. moving the above chunk of code in conditional branch.

Even without such change, I think the above 'goto try_again;'
introduces an unneeded conditional, as at this point we know 'fragsz <=3D
fsize'.

> +
> +get_new_folio:
> +	if (!spare) {
> +		cache->folio =3D NULL;
> +		put_cpu_ptr(&skb_splice_frag_cache);
> +
> +#if PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE
> +		spare =3D folio_alloc(gfp | __GFP_NOWARN | __GFP_NORETRY |
> +				    __GFP_NOMEMALLOC,
> +				    PAGE_FRAG_CACHE_MAX_ORDER);
> +		if (!spare)
> +#endif
> +			spare =3D folio_alloc(gfp, 0);
> +		if (!spare)
> +			return NULL;
> +
> +		cache =3D get_cpu_ptr(&skb_splice_frag_cache);
> +		/* We may now be on a different cpu and/or someone else may
> +		 * have refilled it
> +		 */
> +		cache->pfmemalloc =3D folio_is_pfmemalloc(spare);
> +		if (cache->folio)
> +			goto reload;

I think there is some problem with the above.

If cache->folio is !=3D NULL, and cache->folio was not pfmemalloc-ed
while the spare one is, it looks like the wrong policy will be used.
And should be even worse if folio was pfmemalloc-ed while spare is not.

I think moving 'cache->pfmemalloc' initialization...

> +	}
> +

... here should fix the above.

> +	cache->folio =3D spare;
> +	cache->virt  =3D folio_address(spare);
> +	folio =3D spare;
> +	spare =3D NULL;
> +
> +	/* Even if we own the page, we do not use atomic_set().  This would
> +	 * break get_page_unless_zero() users.
> +	 */
> +	folio_ref_add(folio, PAGE_FRAG_CACHE_MAX_SIZE);
> +
> +	/* Reset page count bias and offset to start of new frag */
> +	cache->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +	offset =3D folio_size(folio);
> +	goto try_again;

What if fragsz > PAGE_SIZE, we are consistently unable to allocate an
high order page, but order-0, pfmemalloc-ed page allocation is
successful? It looks like this could become an unbounded loop?

> +
> +frag_too_big:
> +	/* The caller is trying to allocate a fragment with fragsz > PAGE_SIZE
> +	 * but the cache isn't big enough to satisfy the request, this may
> +	 * happen in low memory conditions.  We don't release the cache page
> +	 * because it could make memory pressure worse so we simply return NULL
> +	 * here.
> +	 */
> +	cache->offset =3D offset;
> +	put_cpu_ptr(&skb_splice_frag_cache);
> +	if (spare)
> +		folio_put(spare);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(alloc_skb_frag);
> +
> +/**
> + * copy_skb_frag - Copy data into a page fragment.
> + * @s: The data to copy
> + * @len: The size of the data
> + * @gfp: Allocation flags
> + */
> +void *copy_skb_frag(const void *s, size_t len, gfp_t gfp)
> +{
> +	void *p;
> +
> +	p =3D alloc_skb_frag(len, gfp);
> +	if (!p)
> +		return NULL;
> +
> +	return memcpy(p, s, len);
> +}
> +EXPORT_SYMBOL(copy_skb_frag);
> +
>  static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
>  				 size_t offset, size_t len)
>  {
> @@ -6808,17 +6947,43 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb,=
 struct iov_iter *iter,
>  			break;
>  		}
> =20
> +		if (space =3D=3D 0 &&
> +		    !skb_can_coalesce(skb, skb_shinfo(skb)->nr_frags,
> +				      pages[0], off)) {
> +			iov_iter_revert(iter, len);
> +			break;
> +		}
> +
>  		i =3D 0;
>  		do {
>  			struct page *page =3D pages[i++];
>  			size_t part =3D min_t(size_t, PAGE_SIZE - off, len);
> -
> -			ret =3D -EIO;
> -			if (WARN_ON_ONCE(!sendpage_ok(page)))
> +			bool put =3D false;
> +
> +			if (PageSlab(page)) {

I'm a bit concerned from the above. If I read correctly, tcp 0-copy
will go through that for every page, even if the expected use-case is
always !PageSlub(page). compound_head() could be costly if the head
page is not hot on cache and I'm not sure if that could be the case for
tcp 0-copy. The bottom line is that I fear a possible regression here.

Given all the above, and the late stage of the current devel cycle,
would you consider slicing down this series to just kill
MSG_SENDPAGE_NOTLAST, as Jakub suggested?

Thanks!

Paolo

