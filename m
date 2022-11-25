Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199CD63839E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKYFtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYFtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:49:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9C22285;
        Thu, 24 Nov 2022 21:49:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJP7G6mqLz4x1V;
        Fri, 25 Nov 2022 16:48:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669355339;
        bh=UGZv5F/YksoE6tIBH01E+4WayIoxYeEoe8iqYP96unc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rfp0Z6Ej23NPX3m35hxEsCndyYcq90EHLqMDotqdyBLowj825wwTWtmsKPHOkxp7g
         H1XoCgMN+VkGSua//KGLrDj0EWYq/PXgWpR3CyT5uQp0/NicMXAWGhZnGF/ae2CIl4
         YeCXcvvTLqRe5P635LNlwu62xc5kWbTMGtEyUl+KXP3RCRDgEBWjzescrK2ry1320n
         Lj6c+YOoXyYXpqSaIHMnLoO78ncbHeRBUkbnNVIBo56JzBGfsFAdzendcTIG5Q8HrK
         JbY5Bi00UnLe9lf6dX1GariPajUr2sxhHq1MAQW/0dlBD9KbdhWurmEZMoq4RF7pMw
         ZqeF/wezfDJ3A==
Date:   Fri, 25 Nov 2022 16:48:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Message-ID: <20221125164857.25b63a58@canb.auug.org.au>
In-Reply-To: <20221124212457.06a9928d931d00ad98d7d454@linux-foundation.org>
References: <20221125121051.311beecd@canb.auug.org.au>
        <20221124212457.06a9928d931d00ad98d7d454@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d=LkzdV7EG3l6zkGO2VDdve";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d=LkzdV7EG3l6zkGO2VDdve
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 24 Nov 2022 21:24:57 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Fri, 25 Nov 2022 12:10:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > Hi all,
> >=20
> > After merging the mm-hotfixes tree, today's linux-next build (arm
> > allmodconfig) failed like this:
> >=20
> > mm/vmscan.c:4090:9: error: implicit declaration of function =E2=80=98pm=
d_young=E2=80=99; did you mean =E2=80=98pte_young=E2=80=99? [-Werror=3Dimpl=
icit-function-declaration]
> >=20
> > Caused by commit
> >=20
> >   3f85e711d5af ("mm: introduce arch_has_hw_nonleaf_pmd_young()")
> >=20
> > This error was found by the kernel.ci bot and so is still int today's
> > tree. =20
>=20
> Thanks.  Did that tree include "mm: add dummy pmd_young() for
> architectures not having it"?

It did not when I merged the mm-hotfixes branch, but then I refetched
your trees during the day and so that patch appeared when I merged the
mm tree (which is now based on a later version of the mm-hotfixes
branch). So next-20221125 as a whole will not have the build failure.

After I merge all the "fixes" branches, I upload a "pending-updates"
branch that feeds into the various bots independently of the full next
tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/d=LkzdV7EG3l6zkGO2VDdve
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOAV0kACgkQAVBC80lX
0GzlIQgAjbzlFgsL4eB34AW+AYTz1XhAFB4jwECDBDc2UljF+60wx+N9BDpRgXwE
Erw6WNHPqXy7dG+9SAK3TzH17psLcVYjN/XnGEWrWJz4IQSvk1l6QFhPO4CPgAKw
J7dCgGLkZkP5xsEqwQ0OysaqbFvbGyvwaGOunDuAUNAE0KY/Bc2UZmQ3IFl4YHoK
QBLLNNAAJ4xP4UAU3OdiwZQHccYjaLOCID85BtJasvXy2yQ6kf2xvEomvehzhAg6
ZXsqsNKA6AOG31BUWYGbOgkNOARU71eMxEjWZXt6Dn2NqG52b61KnyYRRy4NXCnE
FYMVshA88iZ4ec5wxZ5m4CY/WIG8yg==
=evJu
-----END PGP SIGNATURE-----

--Sig_/d=LkzdV7EG3l6zkGO2VDdve--
