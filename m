Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8797432E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjF3C7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjF3C7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:59:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4773596;
        Thu, 29 Jun 2023 19:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688093969;
        bh=ozucUvMvHPvDnkxJhht/oqP4/dlTdtJU5QloNUbNU3g=;
        h=Date:From:To:Cc:Subject:From;
        b=t9nRWu1iFcUjNMaWA5NuggPkjDCNYHAHtXRGxbUpqi1ldLUdIDTAW81bX2kTGhmQq
         BIixxeyYJ3kxZXFRzF/bATh2cUCxto9BDhCgooUowf1ff3lIoK4lnzFUOY15UEg82q
         jq5YV2XdJaX3XoJFgDEIsS/hAxR4hp36T3TJSz/lOBme6BKZ/u3bh1SsUIc88dVt3M
         dX9dIkvhOGxmIKy24pu7/oPYg9Gde7iIUUi0/kUVaadFBU9zYGmYFTTTNTMBOSvL1z
         6GIS41jjOXvKcpJbRm2zu9BdEbhQpt4t0BTm7NtZJkwQF08yiNrrc+t0Zo/pb89SNj
         d7o+H/PIv8lzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qsg5Y2Sl9z4wb8;
        Fri, 30 Jun 2023 12:59:29 +1000 (AEST)
Date:   Fri, 30 Jun 2023 12:59:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the origin tree
Message-ID: <20230630125926.785699c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J.URPYJQRl.Ck47PylM3MKd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J.URPYJQRl.Ck47PylM3MKd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (sparc defconfig)
failed like this:

<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
/home/sfr/next/next/arch/sparc/mm/fault_32.c: In function 'force_user_fault=
':
/home/sfr/next/next/arch/sparc/mm/fault_32.c:315:49: error: 'regs' undeclar=
ed (first use in this function)
  315 |         vma =3D lock_mm_and_find_vma(mm, address, regs);
      |                                                 ^~~~

Caused by commit

  a050ba1e7422 ("mm/fault: convert remaining simple cases to lock_mm_and_fi=
nd_vma()")

I have just left this broken for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/J.URPYJQRl.Ck47PylM3MKd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSeRQ4ACgkQAVBC80lX
0GyWaAf/eZ9b1H88VQmnMkLkcttkwh0HO+7C6g9XE5MNIxrQISdy832zMGyI7vTQ
QGR1jQhzL/t49CZ0GLl56iqVWaL3elee5V04+1sUMTqttwyZS90/F2jibhP+/g1Q
GShMKZlnnQNPueBeC8fB4UHs3RGayjkYQ1WZxjPTQftMwDdnqArSrGNhHUjZpbfK
7uUw5NVlMA//eUx8t+A4AoWyXp5G7JniOACGnvtcHblSNGZXaM0KC80LzvP6fGos
uEyc690SuWd8zUTuKg4Bujsj9kgi4ai5vKdclTe+K3bZtwKaO2Lqt1DCSDB/IQ9y
6lcrcejEdtCHmPmDQMWGFUQWisxnaw==
=Y38i
-----END PGP SIGNATURE-----

--Sig_/J.URPYJQRl.Ck47PylM3MKd--
