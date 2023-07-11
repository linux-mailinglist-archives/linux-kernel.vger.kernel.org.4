Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19974F7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGKR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGKR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473A170A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98DD4615AB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4920C433C8;
        Tue, 11 Jul 2023 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689098264;
        bh=zXrDCJKFB8vVgSszrJcLCbm92nu+l5wGbuT30UhMTg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYCZdiKV0Z6gq96y9jRLhGD1Qk1WV7w8KD+8x73yWOf/wsLNRk3FTLMgT/oFdDuIb
         F15DWWUh2lBghW1DPM78x0xZAAhBQiRavfiUo8Ntkw8f8aWFGflU8VUjpYnEsQlpMN
         oD3Bw5AvNGqfjUGEuybCBHTTlE+67XUUE1V/vXb+G3Sf0qf56ycF5q55UL1lZWJtb8
         8y1jCk+jM8SzyO1bpAWNc/CGxUolr0PJGhrBt+Y1sI3Q5l039VDI4NevXSAqrzPjHc
         bY+F6xxPrdUZ6QCR+B7rtt9Bi5A/CYD+TNhVfb9oyfDRTD0PTtIc/m/pwihDGxN4rm
         vkaJbzAf3JzeQ==
Date:   Tue, 11 Jul 2023 18:57:33 +0100
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
Message-ID: <591b5253-47f0-440c-84b6-7786ff59667d@sirena.org.uk>
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
        protocol="application/pgp-signature"; boundary="FgXD3/YC1RpaGmET"
Content-Disposition: inline
In-Reply-To: <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
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


--FgXD3/YC1RpaGmET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 09:13:18AM -0700, Hugh Dickins wrote:
> On Tue, 11 Jul 2023, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 09:34:42PM -0700, Hugh Dickins wrote:
> >=20
> > > I suppose I should ask you to try reverting this 0d1c81edc61e alone
> > > from 6.5-rc1: the consistency of your bisection implies that it will
> > > "fix" the issues, and it is a commit which we could drop.  It makes
> > > me a little nervous, applying userspace-pagetable validation to kernel
> > > pagetables, so I don't want to drop it; and it would really be cargo-
> > > culting to drop it without understanding.  But we could drop it.
> >=20
> > I did look at that, it doesn't revert cleanly by itself. ...
>=20
> Right, that ptep_get() wrapper on the next line came in on top.
> The patch to revert just 0d1c81edc61e is this:

Still investigating but I'm pretty convinced this is nothing to do with
your commit/series and is just common or garden memory corruption that
just happens to get tickled by your changes.  Sorry for the noise.

--FgXD3/YC1RpaGmET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStmAwACgkQJNaLcl1U
h9BVSQf+KnL1hqqyERin3gYRRghB0Kz2nNsNK2qNHnl40av8BTvNeGpjPtp5ZV9G
Z5kjhS0QSEvpCd6Y048HnE4qy1wx7B7sF74cvUJttSVUs9BAoWMqXHFF0zlVnRjr
xI/KPWc+ZyqBppF7zKZaFdXv/PDgVCVkbAFcmMH5ZEgi2hmrQRnG91SN0r9xvX94
oyg9EtrLhbdEQ3f1FqCU7XpFjJ4fI3qBQF4CHnuGzNo7q/2fJpdDDFw3T3xclcQJ
eSeY4Kzlijv1OaSMq/To4Ky85/OhmROM96el2vPC5/B+TmhWy5McNhMFfFZBInXW
tBICpj9RAybRnJsJ0agR/53kkvi2GA==
=Dh39
-----END PGP SIGNATURE-----

--FgXD3/YC1RpaGmET--
