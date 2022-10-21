Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015260820E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJUXaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJUXaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:30:05 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10D6EF2C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:30:02 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1om1Si-0002Fd-34;
        Fri, 21 Oct 2022 19:30:00 -0400
Message-ID: <e0fc94ec3e6e088ad26d1b2ba7a1e9dfb4fb8079.camel@surriel.com>
Subject: Re: [PATCH] mm,madvise,hugetlb: fix unexpected data loss with
 MADV_DONTNEED on hugetlbfs
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Date:   Fri, 21 Oct 2022 19:29:59 -0400
In-Reply-To: <Y1MFjnDBOzpCW/9Z@monkey>
References: <20221021154546.57df96db@imladris.surriel.com>
         <Y1MFjnDBOzpCW/9Z@monkey>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ln3tjc1s0eh8wFvc/pi/"
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


--=-Ln3tjc1s0eh8wFvc/pi/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-10-21 at 13:48 -0700, Mike Kravetz wrote:
> On 10/21/22 15:45, Rik van Riel wrote:
> > A common use case for hugetlbfs is for the application to create
> > memory pools backed by huge pages, which then get handed over to
> > some malloc library (eg. jemalloc) for further management.
> >=20
> > That malloc library may be doing MADV_DONTNEED calls on memory
> > that is no longer needed, expecting those calls to happen on
> > PAGE_SIZE boundaries.
> >=20
>=20
> Thanks Rik.=C2=A0 I tend to agree with this direction as it is 'breaking'
> current code.=C2=A0 David and I discussed this in this thread,
> https://lore.kernel.org/linux-mm/356a4b9a-1f56-ae06-b211-bd32fc93ecda@red=
hat.com/
>=20
> One thing to note is that there was not any documentation saying
> madvise would happen on page boundaries.=C2=A0 The system call takes a
> length and rounds up to page size.=C2=A0 However, the man page explicitly
> said it operates on a byte range.=C2=A0 Certainly mm people and others
> know we only operate on pages.=C2=A0 But, that is not what was documented=
.
>=20
> When the change was made to add hugetlb support, the decision was
> made
> to round up the range to hugetlb page boundaries in hugetlb vmas.=C2=A0
> This
> was to be consistent with how madvise operated on base pages.=C2=A0 At th=
e
> same time, madvise documentation was updated say it operates on page
> boundaries as well as the behavior for hugetlb mappings.=C2=A0 If moving
> forward with this change we will need to update the man page.

I'll send in a patch for the man page after the patch gets
merged. I'll change the text to clarify that the system
may round up the specified length to PAGE_SIZE granularity,
which is a quantity programs can get through (IIRC) getconf.

Andrew, I split out the bit of the patch for stable.

--=20
All Rights Reversed.

--=-Ln3tjc1s0eh8wFvc/pi/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmNTK3gACgkQznnekoTE
3oPuIwgAm0O7awmpragf2EibhYa6Cav047vyduUCGjVoZQG4wMZgs0ui/u4JG+O1
C8l0qoih42ttFeLMqWWdmNiFHIb8v69QPFktZTo/IPMph700qxTo+VmnIir9KBGw
1U4dDeQqikvT0SpsijAXDmyvLFWAUCBPW+G2DiqHGzgArIw0vu0ycKX6wX8jcp3y
ptYdq8fGCsfQn1NWYQWyPMT8y6SQNnWpF713yxEuI2PCpfwQ1Qa/yrcGP4XwqKN5
HlqWK1yq/6vhHJ8hd+iBP7lXUrbOo0Fl0v1nR29NQDi7/OxsgYsg34u2PS+NS7z8
h9ysC5ux3VWnX8sTfc9DfnEf5swRqA==
=JQHs
-----END PGP SIGNATURE-----

--=-Ln3tjc1s0eh8wFvc/pi/--
