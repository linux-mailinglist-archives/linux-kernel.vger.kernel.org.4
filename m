Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CBE6B84E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCMWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCMWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:40:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF10360B0;
        Mon, 13 Mar 2023 15:40:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbBS33X26z4x1f;
        Tue, 14 Mar 2023 09:40:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678747203;
        bh=Pvfqgvv+EHl81UeJsG7bKqCwtVj2X0ZtG8D9xaAfoVk=;
        h=Date:From:To:Cc:Subject:From;
        b=ipXx0F9qj4i63jCHZGOK5jUtCr0zbXUPzNhtEoDs3OJN36mdJSzPUtPjtLsLyzycA
         6VuwLHgm0qRt2ZwO4iJofYWdHOvwCBpTdlbZEAbqJEjqBxrVT33voggKcHB6XoscM+
         T+WFASmOr25IKLhObHxjdeUEZsx67fYvjDxmmrZvuGZ4bBIyNYnNeJSs4CuqEqXeoI
         1fDAqJyCw+DhP4s20PNly2I50n2ny0DfpdXpirET0o45ZzBuR00XBhCQmuv3Iih3W7
         VI+CW2+tkTpRXSuHUL/nZ5gFPfJcXnvFRVyN5UoYl7AYLy9tWKN43j6ZWGbog0x4Sh
         A5Caju/G1kkrw==
Date:   Tue, 14 Mar 2023 09:40:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the efi-fixes tree
Message-ID: <20230314094002.50555b2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kO0dPsPDA=JMtW+CKh/_Nvn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kO0dPsPDA=JMtW+CKh/_Nvn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the efi-fixes tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: drivers/firmware/efi/efi-init.o: in function `efi_ini=
t':
efi-init.c:(.init.text+0x474): undefined reference to `efi_earlycon_reprobe'

Caused by commit

  3923c4cf06af ("efi: earlycon: Reprobe after parsing config tables")

$ grep CONFIG_EFI_EARLYCON .config
$

I have used the efi-fixes tree from next-20230310 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kO0dPsPDA=JMtW+CKh/_Nvn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPpkIACgkQAVBC80lX
0GxlIQf/bhH5MMOWLzkBBUubHPdcOTzF6dj7HgvsNH04eMRtPGyyet87Jhg3t4/C
2Fyj/MT43a8F6gq3rZODQI0h+aHJ6BAeIP6R0LPMjwufg/iYxCWf29ZKktzZOqtt
FKa6U1jakhhYj2xKG9wCf7+WhVPP8Mv1HFlygcOPsoaL1ax0UpqI950f41XUHk1d
ARqYO7kFRnOvN4juVgilaUgOV55DRBWgJGO8XFljGPMyf5+B2rXcGhAoOkx5m2cX
IQx/pL2PvRVipPrzF33zed6k6p7TPU41e2TWAxXSEYmfIqevXWjT4SgjVUK31bas
OWNRBWELUeklfUoc11G/ASXYCudEcQ==
=+tlj
-----END PGP SIGNATURE-----

--Sig_/kO0dPsPDA=JMtW+CKh/_Nvn--
