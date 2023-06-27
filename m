Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74873F508
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjF0HCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0HCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:02:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB4198C;
        Tue, 27 Jun 2023 00:02:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqwdS1Cp5z4wZr;
        Tue, 27 Jun 2023 17:02:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687849356;
        bh=i4SxaP8a9T9btoMtZq2VYnR+kHKIACZI6GHyyd4NwV8=;
        h=Date:From:To:Cc:Subject:From;
        b=ZF+KLwN6g0tFkqTKxcu9Nr/t9PsfyvmOZAqcz7JpWHCQsHyAv9Z7bii5q1nLWS/Tk
         b9BvIDp/8DCegNMoYhR99ahSxuIPJGG6JyTsU4QfQvpTA3Qg92tK7ASlwkdS0IFnGF
         0lZa2O+8JmLuYLR2oBwFqm9taUiBFDk7/1Y7UPVcY8E0hEZ+6NjLeDCSKJADpsfLfW
         9xPGMOFly3bMa+EHnpglRrpWM83eRYW3N4gFPGgFfj+RRJoMLRdMgddhadV9Awy6va
         86V1fRsSJ+Ieeh2dyai27CG/ArbmwmylE/UiOCwSf7i5RQCD9m+xzBeipr7SdxpqHE
         nLAgqxwRVIPiA==
Date:   Tue, 27 Jun 2023 17:02:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the crypto tree
Message-ID: <20230627170234.1c86ecdc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WDv.au+H.QsfR2zGT_5WaN=";
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

--Sig_/WDv.au+H.QsfR2zGT_5WaN=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next qemu boot test
(powerpc pseries_le_defconfig) failed like this:

 Loading compiled-in X.509 certificates
 BUG: Kernel NULL pointer dereference at 0x00000018
 Faulting instruction address: 0xc00000000092a054
 Oops: Kernel access of bad area, sig: 11 [#1]
 LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-12597-g59adf7c9b6b4 #1
 Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000=
004 of:SLOF,HEAD pSeries
 NIP:  c00000000092a054 LR: c000000000929fdc CTR: 0000000000000000
 REGS: c00000000478f450 TRAP: 0380   Not tainted  (6.4.0-12597-g59adf7c9b6b=
4)
 MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24002420  XER: 2000=
0000
 CFAR: c0000000009b30c0 IRQMASK: 0=20
 GPR00: c000000000929fdc c00000000478f6f0 c000000001568f00 c000000006819800=
=20
 GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000010100=
=20
 GPR08: 0000000000000000 0000000000000000 0000000000000002 bc0793dad8bdf255=
=20
 GPR12: 2e12589b9abeba33 c000000002b00000 c0000000000111a8 0000000000000000=
=20
 GPR16: 0000000000000000 0000000000000000 c0000000028d1280 c000000002808a88=
=20
 GPR20: c000000004764900 0000000000000000 0000000000000001 000000001f030000=
=20
 GPR24: 000000000000052c c000000002139b00 000000000000000e 0000000000000040=
=20
 GPR28: 000000000000dac0 c00000000404db00 0000000000000200 000000000000a400=
=20
 NIP [c00000000092a054] crypto_sig_verify+0x114/0x180
 LR [c000000000929fdc] crypto_sig_verify+0x9c/0x180
 Call Trace:
 [c00000000478f6f0] [c000000000929fdc] crypto_sig_verify+0x9c/0x180 (unreli=
able)
 [c00000000478f7e0] [c0000000009361c0] public_key_verify_signature+0x3c0/0x=
590
 [c00000000478f8c0] [c0000000009393f0] x509_check_for_self_signed+0xc0/0x1b0
 [c00000000478f8f0] [c000000000937618] x509_cert_parse+0x1c8/0x270
 [c00000000478f970] [c000000000938c48] x509_key_preparse+0x38/0x260
 [c00000000478f9c0] [c00000000093262c] asymmetric_key_preparse+0x8c/0xe0
 [c00000000478fa10] [c0000000008af11c] __key_create_or_update+0x3cc/0x770
 [c00000000478fb40] [c000000000938b30] x509_load_certificate_list+0xb0/0x190
 [c00000000478fbe0] [c00000000203dac0] load_system_certificate_list+0x4c/0x=
60
 [c00000000478fc40] [c000000000010bc0] do_one_initcall+0x80/0x320
 [c00000000478fd20] [c000000002004994] kernel_init_freeable+0x304/0x3ac
 [c00000000478fdf0] [c0000000000111d0] kernel_init+0x30/0x1a0
 [c00000000478fe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
 --- interrupt: 0 at 0x0
 NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
 REGS: c00000000478fe80 TRAP: 0000   Not tainted  (6.4.0-12597-g59adf7c9b6b=
4)
 MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
 CFAR: 0000000000000000 IRQMASK: 0=20
 GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 NIP [0000000000000000] 0x0
 LR [0000000000000000] 0x0
 --- interrupt: 0
 Code: 7d4a4378 f9410070 0b060000 579c043e 9361009c e9410090 e8610040 93810=
098 794a07a0 7d295378 f9210090 e9230020 <e9290018> e989ffc0 7d8903a6 4e8004=
21=20
 ---[ end trace 0000000000000000 ]---

Reverting the following commits made it boot fine again:

  3867caee497e ("crypto: sm2 - Provide sm2_compute_z_digest when sm2 is dis=
abled")
  63ba4d67594a ("KEYS: asymmetric: Use new crypto interface without scatter=
lists")
  e5221fa6a355 ("KEYS: asymmetric: Move sm2 code into x509_public_key")

--=20
Cheers,
Stephen Rothwell

--Sig_/WDv.au+H.QsfR2zGT_5WaN=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSaiYoACgkQAVBC80lX
0GwsTQgAkOFNf6+M2g3F2R92OmewbDK70U6cg2vgehyi9yvdY1aSn2zT8nvJEdon
dHThazapHCywazZNRMvBFt5ehalF+GQqcDElrN/a1XMxyQeagmPOC+fsP7qg5+SQ
C8t1WiLThm3cEgcLv2IDhCizFJ8uoJjwPv0bR2+RJGW3xQWF5pXHO6exAd1Gr3/U
xDv4cOTYX8jh9G1Cj1GjUni0Gc5yDBOnB/M6lORNBPJqMiY3LhaZZG7YVE3EUrLz
8N3vhuWMst9ISiZqd8C4IZxeQiJeHD/YhPg+rGp3BQGQWkT/Zi5nFsnN+ykCUHrj
IrShM9d5IBaUqAz51E2VXJqJ0P11YQ==
=uHjx
-----END PGP SIGNATURE-----

--Sig_/WDv.au+H.QsfR2zGT_5WaN=--
