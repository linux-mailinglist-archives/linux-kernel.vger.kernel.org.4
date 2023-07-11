Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529C174F59D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjGKQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjGKQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9192129
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8456F6155B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825BBC433C7;
        Tue, 11 Jul 2023 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093291;
        bh=cpSt6wSp9MML3SCZgntwF/5xJMCrBIMrNErWPgETwrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtGGN+ayDJvNn7CYl0Y6Mg8Nol64sZSdGU4J7QFWWHQhkiRUhok+ZgtO0zhzd6fI8
         IwYKeAf56hI07dIlmXNAJJ+xokzwk08MJLgMD52cZ5rMNmSqAiRXM5GaL6OAxrq+Ca
         GX5lMtEJY+ucpQ6gRkNa/0MzBqyDLLvpjx3k6YMQJqvrC4iLB0GgVKlPfecai4fddH
         52hS5OWCI4FfdYs1Qn6ZFZ/BTbJ/+/+Fo5G2dvoQmDmeD9UbUy3D8jWaM1/4vWNV5G
         +KmtFpmEbrXJOFav1A2qyDpkr+vyrhUlsqQj1FpwRn8DS2x2mrDXgWMKLyn8VcqTz3
         a6P1FGhOpAEQg==
Date:   Tue, 11 Jul 2023 17:34:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@leemhuis.info, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Message-ID: <a4088bb3-7f78-41b1-baa4-44d5e238ee44@sirena.org.uk>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
 <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
 <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
 <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GzGnTnQhN99CmdXE"
Content-Disposition: inline
In-Reply-To: <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GzGnTnQhN99CmdXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 09:13:18AM -0700, Hugh Dickins wrote:
> On Tue, 11 Jul 2023, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 09:34:42PM -0700, Hugh Dickins wrote:

> > > I suppose I should ask you to try reverting this 0d1c81edc61e alone
> > > from 6.5-rc1: the consistency of your bisection implies that it will
> > > "fix" the issues, and it is a commit which we could drop.  It makes
> > > me a little nervous, applying userspace-pagetable validation to kernel
> > > pagetables, so I don't want to drop it; and it would really be cargo-
> > > culting to drop it without understanding.  But we could drop it.

> > I did look at that, it doesn't revert cleanly by itself. ...

> Right, that ptep_get() wrapper on the next line came in on top.
> The patch to revert just 0d1c81edc61e is this:

Thanks, tried that and it's still exploding in a similar way (though
this time inside a regulator call from the pinctrl code which was
happening in other cases).

--GzGnTnQhN99CmdXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSthKAACgkQJNaLcl1U
h9B2aAf8C8X78iHr1+jlI1B9Sc2Jl67lIJJk807nXppJ2iudYWfWYcfQEQuUHL7E
K/ywaUbPz/TJ+uaIBHKvc98E3JxkSDr0SKZs2HtSv+bTNhPP3F7fyU7VG/Ea6EiC
0bSwjlSmWn4rri1K4P8TMOsdC0lpZl4yMpTLHFV64/atLAtMACpKXnpKLbc+fr3U
y32n809VR2e/QlYyI0rrZ8ZWMiW8HOitDbWrXPZESI5aKWVkXvjYF9D+C/OTqxbC
smxEv4tAwTAvHv9qmdZPTHoyv0dEaSIFeDVi885pDtpQjj6vb7HgmfSJBWn6tGH7
InOST+lI6sT293TXfUzBvpxuDdbY8A==
=ED9C
-----END PGP SIGNATURE-----

--GzGnTnQhN99CmdXE--
