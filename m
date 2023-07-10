Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1747B74DC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjGJRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGJRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5CC7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3533661169
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A5BC433C7;
        Mon, 10 Jul 2023 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689010400;
        bh=LyvZDFM9bSEkcm2a6CqTWE+L7T8svqEvSBQJe6ZM6Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPEiIvqYIATEpR1M29zxIhGvfH6efU5aAeHY+ZraMSeSYxX87xqYGYfWTKAoYbUEG
         +ZcCEPEH/RVya5s6Zj+NROYJ6MsyvSiK18wcdmOYZCyBoqSRSQjKJYPaFvPMsIXHqa
         tt113ERKhGEtK9g5tDG/g/fUWniHOsVFiFDi7V3wEI9EfcaLHpv4Rt84hizvURCmbw
         cOsu6JLjcRzKX4nwBu1e4FpN996cjaMUmaggKqf+ss5Fety8jz1R9tHK2PPqJjPFNU
         xp0GlmOYBxkzlDQS+7MnjdaB7fsVyg3ABjbvjJBUSbVyWFSRS49eIWEqtS0HliOuBy
         c6hKbt0YYvpQg==
Date:   Mon, 10 Jul 2023 18:33:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
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
Message-ID: <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
 <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eWc9hbXR7DFVsU2"
Content-Disposition: inline
In-Reply-To: <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3eWc9hbXR7DFVsU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 06:18:27PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jul 10, 2023 at 03:42:31PM +0100, Mark Brown wrote:

> > We end up seeing NULL or otherwise bad pointer dereferences, the
> > specific error does vary a bit though it mostly appears to be in the
> > pinctrl code.  A bisect (full log below) identified this patch as
> > introducing the failure, nothing is jumping out at me about the patch
> > and it's not affecting everything so I'd not be surprised if it's just
> > unconvering some bug in the platform support but I'm not super familiar
> > with the code.

> Yeah seems likely. Do you have a .config you can share for this board? For
> a 64-bit device you'd expect that this change would probably be a nop.

It's definitely happening with arm64 defconfig, possibly with other
configs but that's the main one.

--3eWc9hbXR7DFVsU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsQNMACgkQJNaLcl1U
h9BMswgAgP0XoTGKw3tRPTaAh+qqP2+nQzbiHXKXlruthM53LO0Mp+6YBsb8Br5m
s7fAoP+VvNcNiS1CJjVrHryg16txMlFCyfckUtlca8+vdIFQin4cP0WFejtrZMhg
WFOupvGC9kU8HoCgXvsdK97QcnkLgZNp6jf4QBgLzuQg+9EnmfbiqvHfkJxgHaPn
VOfL9aLVyh0Vw9ttzKfIJ0Fjd1Vlh/uEVBFBh4JBZx9oeZYO0iUhSExyQAKlUJJf
gNwdOr7YK19xyEhaYUXJq4XUP0SBj48iHskc7R/eWBuhRwwyoNBnWz/4JwVkU8Ik
/Q1yGbPZtVB9NAyMFAo/6kNK4CRRyA==
=8zqU
-----END PGP SIGNATURE-----

--3eWc9hbXR7DFVsU2--
