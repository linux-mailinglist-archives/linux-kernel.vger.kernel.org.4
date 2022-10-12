Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901DC5FCEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJLXPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:15:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3091B1106;
        Wed, 12 Oct 2022 16:15:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnpR62js3z4x1G;
        Thu, 13 Oct 2022 10:15:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665616530;
        bh=uulpi7hsvZgyVCmbVTbY0Yr4fvpQwR6qN8jW4s61zWc=;
        h=Date:From:To:Cc:Subject:From;
        b=G1nle5bbqG7QfR7VoDJq3dBaBjXCUoMw2ijw3MxjGS/eU+Pd/Y0Xt0CLVL0x6necd
         k7qvWkOV5iNFUFREIRk0wWqLgLKkgxZLEroX5+c7BMGXtXcnrJtsoMDa4Q41fUBFJk
         1oPw7//JGFVDOZ3XfMGSSI7WoB/g1es7C5xBqLIpiIWtC0B2M0cPVwYlArkXVVWoGK
         tJPx2LZTJuc+z1Xmn+VU7iDZVepgkFkHNXtIg5lNiFfL+L3JpAwfnxCR/Oemz4/hiB
         TYjzCQ7d86ZMIk6yxsfocRFbsiIwLvQIvwAOtxblKLndEzibTMcXGcrD/vErpTamNj
         sBsVAdwwl7r2w==
Date:   Thu, 13 Oct 2022 10:15:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the fuse tree
Message-ID: <20221013101528.4afacfe3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VjOEsYHV=Gm/kFZji/nAt6u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VjOEsYHV=Gm/kFZji/nAt6u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fuse tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: ".delete_from_page_cache" [fs/fuse/fuse.ko] undefined!

Caused by commit

  0d659ac83481 ("fuse: fix readdir cache race")

delete_from_page_cache has not been exported to modules since commit

  452e9e6992fe ("filemap: Add filemap_remove_folio and __filemap_remove_fol=
io")

Which was merged into Linus tree in v5.17-rc1.

I have used the fuse tree from next-20221012 for today.

Is this really destined for v6.1?

--=20
Cheers,
Stephen Rothwell

--Sig_/VjOEsYHV=Gm/kFZji/nAt6u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNHSpAACgkQAVBC80lX
0GyY5Qf/SKD9GE3uqhIO1+JICt7AfvtNs3vN+WfLuMnoZi+AMkHAaxkvnNWjeK37
JW+e/58qPUOvKj4ha394pIx42ZIIPKsZil6+W6mLulWsRwG9hELzDI/SMbOLH22C
G4LjyMypCQlHHf+Z/ZC+DHbejP2CIDi4zimz0tjm+S/NsecP4SLlICqo7H/IRV5v
rfJ1buxvKTGqSeJBzS+ORveAj0yzkh9mveHcApNjrWOjirMJTy6KSqUg4pEBpdZU
tabBhYJA+41hwMSVFYjbqgPza7kwZvE+WZjeKYPv1zPrGiPbU9vbY+rvUOamn6Bf
Ar1ifxkd+AnO4DyN7b9NjNS6ai3opQ==
=qQp4
-----END PGP SIGNATURE-----

--Sig_/VjOEsYHV=Gm/kFZji/nAt6u--
