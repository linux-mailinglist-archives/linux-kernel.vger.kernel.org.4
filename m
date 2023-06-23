Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0073B3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFWJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjFWJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D626A0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687513039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fxg71GwonJ2lLdj/TmXZbBE8jlv4yQXpkQ99x3iYdD8=;
        b=ELfYJOkIBDIZA2ETjDaY2BEjWoY0eJsYQ8M8XNWpxEk154fGoXiny/7c4H5dLwwtvUrLJH
        mM75dc/sjPTSQqxIonuj3cfFL6AAwXtLJEcIbl7phE9RuwblvAoHWq4hxiUzzphRecfDoe
        /dmyJbXHnKImmEuvcnwIP8YmvHfDY2o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-h1gSGyucMvOqujcEue6RbA-1; Fri, 23 Jun 2023 05:37:17 -0400
X-MC-Unique: h1gSGyucMvOqujcEue6RbA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62dd79f63e0so1151146d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513036; x=1690105036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fxg71GwonJ2lLdj/TmXZbBE8jlv4yQXpkQ99x3iYdD8=;
        b=afhJCnadoIe9nc4nv6E904QP/dPbehN/mVma/eqMDLzIwGhqG4pLiusNyxAEAhOycR
         Z/kXnpjIz4/h7zbArhzUMDP2xLHHqch22BE80iR57f/x1DclaWcHuAM6tw/XwiFo98IF
         rVjT9V/RfAJ+pz0QlojMFH9WJR2FHYutVLBQHY4jdLapcDw7hTa5ICQyVstyKxMbJgb7
         5/g73c6AcJhpRxPfjB7na1hc7xT3lnzA+a6BRnut8ekOrXxA0oiLA08ZW2M3oNgjbhM2
         AVroB7t7QeP97Wqm3bcO1lvqhTAFmId5kXS4PltP5Z1/4dpXvimeszvx6du1D2m6RDpP
         AuOg==
X-Gm-Message-State: AC+VfDwyFNp3p35l8hdcr8Ri+EYtO8lIKtutepZo110hs5QTB7xD9A18
        l3FyleJFPXc9vDZWuiGVbky5wgFZ5oqGZk7HYuW3CgUt+5CrZ1YBbyI20uI72WMwO4JA9z3N8mc
        N/R4Y7/LYnLgwkb1OlENWX6Zo
X-Received: by 2002:ad4:5c83:0:b0:62e:ffc3:a9cb with SMTP id o3-20020ad45c83000000b0062effc3a9cbmr26280144qvh.2.1687513036722;
        Fri, 23 Jun 2023 02:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4emjXvyu0vwC95mriQSkKhIcdBJ/xzwdwdd4nlnQZQIG6kdrN0Z5ZQRmuqh25MRMSlZcnC0A==
X-Received: by 2002:ad4:5c83:0:b0:62e:ffc3:a9cb with SMTP id o3-20020ad45c83000000b0062effc3a9cbmr26280128qvh.2.1687513036400;
        Fri, 23 Jun 2023 02:37:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id u10-20020a0c8dca000000b0060530c942f4sm4883219qvb.46.2023.06.23.02.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:37:15 -0700 (PDT)
Message-ID: <6cf2ea121c4fdbd04682224c5acf6c73cc47f2f7.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date:   Fri, 23 Jun 2023 11:37:12 +0200
In-Reply-To: <1969720.1687511219@warthog.procyon.org.uk>
References: <634c885ccfb2e49e284aedc60e157bb12e5f3530.camel@redhat.com>
         <20230620145338.1300897-1-dhowells@redhat.com>
         <20230620145338.1300897-2-dhowells@redhat.com>
         <1969720.1687511219@warthog.procyon.org.uk>
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

On Fri, 2023-06-23 at 10:06 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > IMHO this function uses a bit too much labels and would be more easy to
> > read, e.g. moving the above chunk of code in conditional branch.
>=20
> Maybe.  I was trying to put the fast path up at the top without the slow =
path
> bits in it, but I can put the "insufficient_space" bit there.

I *think* you could move the insufficient_space in a separate helped,
that should achieve your goal with fewer labels and hopefully no
additional complexity.

>=20
> > Even without such change, I think the above 'goto try_again;'
> > introduces an unneeded conditional, as at this point we know 'fragsz <=
=3D
> > fsize'.
>=20
> Good point.
>=20
> > > +		cache->pfmemalloc =3D folio_is_pfmemalloc(spare);
> > > +		if (cache->folio)
> > > +			goto reload;
> >=20
> > I think there is some problem with the above.
> >=20
> > If cache->folio is !=3D NULL, and cache->folio was not pfmemalloc-ed
> > while the spare one is, it looks like the wrong policy will be used.
> > And should be even worse if folio was pfmemalloc-ed while spare is not.
> >=20
> > I think moving 'cache->pfmemalloc' initialization...
> >=20
> > > +	}
> > > +
> >=20
> > ... here should fix the above.
>=20
> Yeah.  We might have raced with someone else or been moved to another cpu=
 and
> there might now be a folio we can allocate from.
>=20
> > > +	/* Reset page count bias and offset to start of new frag */
> > > +	cache->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > > +	offset =3D folio_size(folio);
> > > +	goto try_again;
> >=20
> > What if fragsz > PAGE_SIZE, we are consistently unable to allocate an
> > high order page, but order-0, pfmemalloc-ed page allocation is
> > successful? It looks like this could become an unbounded loop?
>=20
> It shouldn't.  It should go:
>=20
> 	try_again:
> 		if (fragsz > offset)
> 			goto insufficient_space;
> 	insufficient_space:
> 		/* See if we can refurbish the current folio. */
> 		...

I think the critical path is with pfmemalloc-ed pages:

		if (unlikely(cache->pfmemalloc)) {
			__folio_put(folio);
			goto get_new_folio;
		}

just before the following.

> 		fsize =3D folio_size(folio);
> 		if (unlikely(fragsz > fsize))
> 			goto frag_too_big;
> 	frag_too_big:
> 		...
> 		return NULL;
>=20
> Though for safety's sake, it would make sense to put in a size check in t=
he
> case we fail to allocate a larger-order folio.
>=20
> > >  		do {
> > >  			struct page *page =3D pages[i++];
> > >  			size_t part =3D min_t(size_t, PAGE_SIZE - off, len);
> > > -
> > > -			ret =3D -EIO;
> > > -			if (WARN_ON_ONCE(!sendpage_ok(page)))
> > > +			bool put =3D false;
> > > +
> > > +			if (PageSlab(page)) {
> >=20
> > I'm a bit concerned from the above. If I read correctly, tcp 0-copy
>=20
> Well, splice()-to-tcp will; MSG_ZEROCOPY is unaffected.

Ah right! I got lost in some 'if' branch.

> > will go through that for every page, even if the expected use-case is
> > always !PageSlub(page). compound_head() could be costly if the head
> > page is not hot on cache and I'm not sure if that could be the case for
> > tcp 0-copy. The bottom line is that I fear a possible regression here.
>=20
> I can put the PageSlab() check inside the sendpage_ok() so the page flag =
is
> only checked once. =C2=A0

Perhaps I'm lost again, but AFAICS:

__PAGEFLAG(Slab, slab, PF_NO_TAIL)

// ...
#define __PAGEFLAG(uname, lname, policy)			\
	TESTPAGEFLAG(uname, lname, policy)			\
// ...

#define TESTPAGEFLAG(uname, lname, policy)				\
static __always_inline bool folio_test_##lname(struct folio *folio)	\
{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));}	\
static __always_inline int Page##uname(struct page *page)               \
{ return test_bit(PG_##lname, &policy(page, 0)->flags); }
// ... 'policy' is PF_NO_TAIL here

#define PF_NO_TAIL(page, enforce) ({                                    \
                VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
                PF_POISONED_CHECK(compound_head(page)); })

It looks at compound_head in the end ?!?

> But PageSlab() doesn't check the headpage, only the page
> it is given.  sendpage_ok() is more the problem as it also calls
> page_count().  I could drop the check.

Once the head page is hot on cache due to the previous check, it should
be cheap?

Cheers,

Paolo

