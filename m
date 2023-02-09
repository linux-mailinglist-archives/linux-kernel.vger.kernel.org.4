Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF19B68FE09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBIDi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIDi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:38:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABD83CD;
        Wed,  8 Feb 2023 19:38:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PC2dV30gQz4xyp;
        Thu,  9 Feb 2023 14:38:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675913902;
        bh=+lsrmnvMkBjYDYgsQnN01hkw7j4+LCkHmZpE2vSTW1g=;
        h=Date:From:To:Cc:Subject:From;
        b=sC3f3awp40nkW76fFhdw9eU3eQvCPNJh/T65GmYZ2Uxg8uz465TqE2o3UolqAtPGS
         FdhaDaE+mTK/2mQLP+6bwIjw/IJlL3qPsTrg40sz1Aq11igwrSdpXAH28kyyFsHK0/
         f17HgO3QMwR3kQbjSCxSK/OpWXzt3c99ZcAIIoUJ9fCliVF2blKzHn9U42JL3RDa3B
         sV9MAJrMRbVuKInkUfzzz7WDyYjDWjsGbaSIMrl4Z4oeGFz6Em0FxhpkX1Fe08xtLL
         GJQkCmc2EgxikoWfN9dVU/iwOE5NqHMACmodz8CgaU58o4XWoaXOmBDglfKmfbSpPn
         J2CtrkkCmSTog==
Date:   Thu, 9 Feb 2023 14:38:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the iio tree
Message-ID: <20230209143821.7e6870e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ps92zH2zxsBvGZ1c6IU_bGq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ps92zH2zxsBvGZ1c6IU_bGq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iio tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/iio/proximity/sx_common.c: In function 'sx_common_get_raw_register_=
config':
drivers/iio/proximity/sx_common.c:438:55: error: implicit declaration of fu=
nction 'acpi_device_hid'; did you mean 'dmi_device_id'? [-Werror=3Dimplicit=
-function-declaration]
  438 |         snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_h=
id(adev), reg_def->property);
      |                                                       ^~~~~~~~~~~~~=
~~
      |                                                       dmi_device_id
drivers/iio/proximity/sx_common.c:438:44: error: format '%s' expects argume=
nt of type 'char *', but argument 4 has type 'int' [-Werror=3Dformat=3D]
  438 |         snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_h=
id(adev), reg_def->property);
      |                                           ~^          ~~~~~~~~~~~~~=
~~~~~~~~
      |                                            |          |
      |                                            char *     int
      |                                           %d
cc1: all warnings being treated as errors

Caused by commit

  91af1d6c497b ("iio: proximity: sx_common: Add old register mapping")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ps92zH2zxsBvGZ1c6IU_bGq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkaq0ACgkQAVBC80lX
0GynkQf/bm3F8eQlncH4LO0T3Hv/2UXPI3EJ6j1sEaIV4e131VUv/0rMctG3tfpk
zXyEchhhvDWEYN7bf3225T/XpAi3KxTZAJq/N3h1xmkZ218eVaa2T1I8exX4ksMW
3O622H8lLt92Nk7vrYW/KMiJdzoJ231Bc7QwnOvisUACgSZnaZHQi2XPy7ZZMJsB
pTl5ryZrNf4wa1708cEsPHYaS4YJ83Vx1ka6BztoVko2vKsNtEWGcqjJH+i0/Rxs
OIe4W7Hbdl+wi+bdyf/ZhWhyxFUHN8sm11s3iE+lyugGg0bJY0g8aefgXAWgwJLK
8+o6Z9eiGhSksi4g4SZ05cctagWH4Q==
=gbL8
-----END PGP SIGNATURE-----

--Sig_/Ps92zH2zxsBvGZ1c6IU_bGq--
