Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2C60D59E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJYUh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:37:57 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7035B61DBB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:37:56 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1onQgK-0001bw-04;
        Tue, 25 Oct 2022 16:37:52 -0400
Message-ID: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
Subject: [BUG] hugetlbfs_no_page vs MADV_DONTNEED race leading to SIGBUS
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Chris Mason <clm@meta.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 25 Oct 2022 16:37:51 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JdsCtim/hl2EscNS8G/m"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JdsCtim/hl2EscNS8G/m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

After getting promising results initially, we discovered there
is yet another bug left with hugetlbfs MADV_DONTNEED.

This one involves a page fault on a hugetlbfs address, while
another thread in the same process is in the middle of MADV_DONTNEED
on that same memory address.

The code in __unmap_hugepage_range() will clear the page table
entry, and then at some point later the lazy TLB code will=20
actually free the huge page back into the hugetlbfs free page
pool.

Meanwhile, hugetlb_no_page will call alloc_huge_page, and that
will fail because the code calling __unmap_hugepage_range() has
not actually returned the page to the free list yet.

The result is that the process gets killed with SIGBUS.

I have thought of a few different solutions to this problem, but
none of them look good:
- Make MADV_DONTNEED take a write lock on mmap_sem, to exclude
  page faults. This could make MADV_DONTNEED on VMAs with 4kB
  pages unacceptably slow.
- Some sort of atomic counter kept by __unmap_hugepage_range()
  that huge pages may be getting placed in the tlb gather, and
  freed later by tlb_finish_mmu().  This would involve changes
  to the MMU gather code, outside of hugetlbfs.
- Some sort of generation counter that tracks tlb_gather_mmu
  cycles in progress, with the alloc_huge_page failure path
  waiting until all mmu gather operations that started before
  it to finish, before retrying the allocation. This requires
  changes to the generic code, outside of hugetlbfs.

What are the reasonable alternatives here?

Should we see if anybody can come up with a simple solution
to the problem, or would it be better to just disable
MADV_DONTNEED on hugetlbfs for now?

--=20
All Rights Reversed.

--=-JdsCtim/hl2EscNS8G/m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmNYSR8ACgkQznnekoTE
3oPphgf9Gzrh965pMbAxa+/exyZoh+bwvS54y3Ro9Djptt2/v8zJFdLaiHdlr1YC
MV5acp8sIWgrjz/Qxa9WOIl4XBQ0eVRdf1HHFEKKKmDls5iBHqvNSSZWs0CGi3+0
jyJydcxTyfXs/yyXDI7b5DdnwTtQlF0mcm3raIOvz8dubl6gslxW22Tec4Joyejf
6V465UKgV/ZBj5sjkoVOBns+0ilmAV7XvqHxIMU1DgTX7P5LwadqvZJe9hqPmVIb
XsKiwl/Dk3L861Rmr+63e/z+U85NG77SsVFCkFQ6IGJJbetbuFUOEx5GPSFyHp5x
DzV8ldRCqbbpcVZHr/qa1lRcCwg4zg==
=nKVs
-----END PGP SIGNATURE-----

--=-JdsCtim/hl2EscNS8G/m--
