Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071406AD0EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCFV6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFV6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:58:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC3D2FCCF;
        Mon,  6 Mar 2023 13:58:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVssQ73pyz4wgq;
        Tue,  7 Mar 2023 08:58:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678139915;
        bh=AadnS7GsdyT0/Y78V0exWved253jyT4b8fjmwNe2RTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W2JBYWnmgBFu7OO42fSwU2EljnHcbtsloekSQpWeBW4rL8N7XKaFfbuOjsAHibbqF
         Ocs7jS0QqQxwv64TbRfxoirO+AWPdhaPFsPuJFjyAivrrFY8Mr3/D2ipFJpxHCvLR6
         WjssXKJuyIB8ve/Elc/UuvT+hPpINuUv3opikR6CzyZRT6ep1fkgLjRgYTwkceH+Oe
         837Jc6lIv4xpDFDapKU6gDZlHReLrwjwbAbL/GDW0vzMp/d8e70FJjeiAZvxGL2AbW
         Vv9gyNhhkCFzMfM6R/e/1JTdepC/tOQnAs2qfgQVqu3D4WCGylPXDGMlBJLYgeWBwq
         5EQtcB3UDi7fg==
Date:   Tue, 7 Mar 2023 08:58:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230307085834.209cce60@canb.auug.org.au>
In-Reply-To: <20230306115256.1da8983d@canb.auug.org.au>
References: <20230306115256.1da8983d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/raMsRNbibNbQjvqq4SfZ7Ss";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/raMsRNbibNbQjvqq4SfZ7Ss
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Mar 2023 11:52:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the mm tree, today's linux-next build (sparc64 defconfig)
> failed like this:
>=20
> sparc64-linux-ld: mm/vmstat.o: in function `cpu_vm_stats_fold':
> vmstat.c:(.text+0x2a18): undefined reference to `__xchg_called_with_bad_p=
ointer'
> sparc64-linux-ld: vmstat.c:(.text+0x2a98): undefined reference to `__xchg=
_called_with_bad_pointer'
>=20
> Caused by commit
>=20
>   676a3befc9ba ("mm/vmstat: use xchg in cpu_vm_stats_fold")
>=20
> Sparc does not support xchg() on 8 bit variables.
>=20
> I have reverted the above commit (and the 2 following ones) for today.

I have used the supplied patch instead of these reverts today.

--=20
Cheers,
Stephen Rothwell

--Sig_/raMsRNbibNbQjvqq4SfZ7Ss
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQGYgoACgkQAVBC80lX
0Gw5PAgAmh3stKWkIF9cI2TcAKOZOowOAjtz/hH5tN/Spt7Qgf5Tb4ebPuMJVDMu
kLYkJV8BTZW1xJSKR3E2SdgAb9T6BCjQvT74ofs5mpkueFiK9iewbQrH/RSeOVZY
rW/Bhz72e863s9vz3ul7HinMfLOCdDiUXWVcOMad/u1SI87P7T16tAjqY26cXK1y
DlCOOtdwsTQvOTgoLsc9OdrhdV0rGIh4K7lTkJFSZa/azNs0EM8507pPaAOfJpr6
Q349iebyA3IQy8yINNILBXSNDiXJLY0WnrvXGJOIFQRlqR/2C2U70pxukdJpmHlB
6Y6QcZcRB+hHFOjSOdEX1wt4EZa79Q==
=uXdo
-----END PGP SIGNATURE-----

--Sig_/raMsRNbibNbQjvqq4SfZ7Ss--
