Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD235BC50C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiISJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiISJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:11:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D72408E;
        Mon, 19 Sep 2022 02:11:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWJnq6wFtz4x1L;
        Mon, 19 Sep 2022 19:11:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663578688;
        bh=vNx0GWo6WyrEzb5CFFYyU8jDwOLiaBgcvMOm1ZtZkc0=;
        h=Date:From:To:Cc:Subject:From;
        b=RyR4CNu6LV4+Jlz06Xs7nr3Q827riEAuyK0purF9i2h4INN0zOCX/sdyXCVQQYiNu
         Cjgh9aWIASBk4Ro5kLhXe8GM921pLdzpsyo4lmY2z8sY90zhvAShgyct/IeT8WSOwg
         j6VvFMTatrKTp7jIt9YYaoFOydm1d9pyf0ghUT57sFD2/dSmAq9ONBPNiqtWIL1zot
         XuAmm1+Ig0C/N7av0hstTs9zqgtmMYq0yT6giLWmsYrsb3OpsZzriHw7d+Avw11owB
         Y2zopvGbOjRTGCVjDoEr7Wk9ipMOxsnWbOX7XBZfaSyngXN6DSCxh54PRbsI7qGfO1
         hDCEzePgHwXyw==
Date:   Mon, 19 Sep 2022 19:11:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the efi tree
Message-ID: <20220919191126.4a3c36f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bs1Z+aw.c1FTwgwZEw+6d99";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bs1Z+aw.c1FTwgwZEw+6d99
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the efi tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

x86_64-linux-gnu-ld: drivers/firmware/efi/libstub/x86-stub.stub.o:(.bss.efi=
stub+0x8): multiple definition of `efi_system_table'; drivers/firmware/efi/=
libstub/systable.stub.o:(.bss.efistub+0x0): first defined here

Presumably caused by commit

  8fd3c9a90998 ("efi/libstub: move efi_system_table global var into separat=
e object")

(or maybe commit

  ba2dd31b7588 ("efi/libstub: implement generic EFI zboot")
)

I have used the efi tree from next-20220916 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/bs1Z+aw.c1FTwgwZEw+6d99
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMoMj4ACgkQAVBC80lX
0GxDcggAg3a3VwCU1WUesRzDABb36wqyQAt8NV6HH3ihOSUWlOMfn3gXDjIV6uhB
Rpbrtb7OLaSEZ+AeXMGHXh5hu4Xpmzdst3ZkiHzapNnwmXg1yRFQvovjGU31MvCp
jmE1RojtUpVit/mbSnxlb5Lur9KTRsGdKHgMvAD8h4PNnc2bGIic2+EhGTv6HNsd
WTqKvoFrqU7SOHWojWCoJUViLLglz8o3GdO3pGiQJCF3Mu+9G8MW1lTBQWqIqZzz
Sb0PvCYmMNw79ehdeFcUss99hUjVgNRjQB8fqhtKZnKM2iUtQe42mM03nRoalIHr
/drF6+DgcTk3gse1yp6JcezbHFkapQ==
=JzgD
-----END PGP SIGNATURE-----

--Sig_/bs1Z+aw.c1FTwgwZEw+6d99--
