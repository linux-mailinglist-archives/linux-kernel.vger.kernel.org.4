Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723506C2691
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCUAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:54:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C534007;
        Mon, 20 Mar 2023 17:54:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PgY5g4jd9z4x80;
        Tue, 21 Mar 2023 11:54:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679360056;
        bh=S0dRr7aWTlOpD1xt7LZSTRtV8AEzS+uBW3ImPemQflM=;
        h=Date:From:To:Cc:Subject:From;
        b=cRRH1Yfxxk+nvxPAUbuRC6fXG3rVHpKJuZzzXd4smjbTIgjuI0tNaKPGX0X9I2fyW
         44+qkXwxTrce9569TxeGXbNj4Y5o8Pj2+jmPp7kbwjQf0j3q3LqwAGHoXmVjviTHej
         7AYYu5T7wCzYukfXTPI7Mf2sa5mH1KKoyjxWx2WQgVI9wHrlikzebUTDo8gB6V8yiL
         Q8TBHNZLAIkIN9xz6w1f81WzsliIutKGVR24CECdhhP3fZsAx0+7YECqJvOsDxYu9m
         AeI68yV4+Fq8D0VD8lVXCgzhDZjvPEMCOvDjrSC9q95bVGBYouxqRYz73MPsiyLJ4E
         q7pKMP+6UrNng==
Date:   Tue, 21 Mar 2023 11:54:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20230321115413.106fa139@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H4+CtQroBqnlXTlSJkZl4o=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H4+CtQroBqnlXTlSJkZl4o=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tpmdd tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/char/tpm/tpm-chip.c: In function 'tpm_amd_is_rng_defective':
drivers/char/tpm/tpm-chip.c:531:15: error: too many arguments to function '=
tpm_request_locality'
  531 |         ret =3D tpm_request_locality(chip, 0);
      |               ^~~~~~~~~~~~~~~~~~~~
drivers/char/tpm/tpm-chip.c:35:12: note: declared here
   35 | static int tpm_request_locality(struct tpm_chip *chip)
      |            ^~~~~~~~~~~~~~~~~~~~

Caused by commit

  923c8dfa9a36 ("tpm: fix build break in tpm-chip.c caused by AMD fTPM quir=
k")

I have used the tmpdd tree from next-20230320 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/H4+CtQroBqnlXTlSJkZl4o=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQZADUACgkQAVBC80lX
0GwgIAf/a+5AHKX5Utrvn5hF87Cd93QR2/YCLz44lnQketHZet+bZZZxDUXUAs4B
y/ur2zEdHhaViWyjwKF2AA44YP/e4bCm4fJId45gwdKEPfjMrSsaZiDeT+Gh/3kQ
Io/TNpPa1ueVZB1aDJpSgRNYgeZDxE5uHbq2cS6VnuHz2UWGC3FlFxCwjv4mUhNv
SAkLBsZfoKjZUVPKcOdx1NY6qinq9AIvbQ0gRFrGz77D1BNnPbC7y0UdZ6MzzwJd
PuA+0+xhvc/WkQwtJlf7+G+axjrXmwNl7ZTnJYEt8d8uYOl2qr1IYF7ctB+pSNbD
coHe5VVKVwtcRAOOaw1ViqyuMbi+FQ==
=jGn4
-----END PGP SIGNATURE-----

--Sig_/H4+CtQroBqnlXTlSJkZl4o=--
