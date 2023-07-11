Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EEC74F395
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjGKPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGKPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:35:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50987ED
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0FC461426
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0273DC433C7;
        Tue, 11 Jul 2023 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089710;
        bh=UXghBE2NE/kW/pRVkn/IvERI1bxXZoJhXe4i/ktt2/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUePYcj4YswI66LM2cxNpfR8NTSITOssW6XY7LlceoOoQ4i50geInh/FKf09BG3DL
         uLQuJKsTB1CzCAYUVRqKYrIcz7xpF7PrJ13E5twXvT70sbVRpu9YVosQhScwUP/kyu
         PKtVVB+GMHbis5hvWfoLOcmfXV1f26L+iGoXg6QD6FhqlngDy2RmQswqObrPdh4NVI
         nDkjPElO5QsZUUGQQMWk3Y2Ta+Bh7BWK8xJhlE0CPQHmvqJNcwkf87jXLEgaRTwkUO
         NUFGnnZjlPtviwjdsYXV7ETO7mJL6TTdw4A3giQgzutpOTTJniIEXpZymcOewKWOkn
         O+DRmo1O/ECuw==
Date:   Tue, 11 Jul 2023 16:34:59 +0100
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
Message-ID: <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
 <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4g5Ya+dx+5ErXu8"
Content-Disposition: inline
In-Reply-To: <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4g5Ya+dx+5ErXu8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 09:34:42PM -0700, Hugh Dickins wrote:

> This feels like one of those bugs which depends on the code size in
> some way (a bit like those bugs we used to have, where a function was
> mistakenly marked __init, then in some configs its code landed on a
> page which got freed at startup - I'm not saying this is that at all,
> just saying it feels weird in that way).

> Yet your bisection converges convincingly, which I wouldn't expect
> in that case.

Yes, it smells like code size or something other than the commit
itself, I have seen this sort of behaviour before where something nearby
in history introduced something which was then triggered by whatever the
bisect points at.

> I suppose I should ask you to try reverting this 0d1c81edc61e alone
> from 6.5-rc1: the consistency of your bisection implies that it will
> "fix" the issues, and it is a commit which we could drop.  It makes
> me a little nervous, applying userspace-pagetable validation to kernel
> pagetables, so I don't want to drop it; and it would really be cargo-
> culting to drop it without understanding.  But we could drop it.

I did look at that, it doesn't revert cleanly by itself.  Your other
suggestions are all good - I'll poke at them.  My suspicion is that
there's some longer standing breakage elsewhere and your series (or even
just this patch) just happens to push into happening reliably, had it
not been a mm change and a memory related bug I'd probably have just
discounted the bisect result.

--w4g5Ya+dx+5ErXu8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStdqMACgkQJNaLcl1U
h9B2ygf3WcoveZBcNCDFtF0/hH7JWuCVAeL856Ci/azCtT0y2w6cpUP3VO1xTxDr
m8YfCM2mWlg/iKZ6yC1FkJvgr1m2ZjGA+Q2awiZUiZt/htJOgDnQ3KMRt8jGvSs3
ctdg8gdYBz4LK9TOz5LPKX5UsjiDBcebYEWqAkgvy3ZSGdubnQ8WqlEmDXT/dlOL
3xE4fyDXFPMtZThRYoE0wrN5EwVLJTaE7O/8TpLhPxK2iXbQCgASZhSfe23CCKKF
k5C2XwR97eTiT/uwJtN2aYy/y+ay7+8Do7JEGu2hMJBm8/X7ZUrLtms8MaKNvTGJ
83r2M8FrNLXbhVdHNQJ249P5rF99
=ztfN
-----END PGP SIGNATURE-----

--w4g5Ya+dx+5ErXu8--
