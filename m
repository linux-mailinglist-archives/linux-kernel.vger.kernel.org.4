Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B650D73D5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFZCkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFZCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:40:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D110D;
        Sun, 25 Jun 2023 19:39:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqBrh51X0z4wb1;
        Mon, 26 Jun 2023 12:39:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687747188;
        bh=YRYS5rodKLDM5QmZrejVxwridNiZjtQfoMD2mlp31Fg=;
        h=Date:From:To:Cc:Subject:From;
        b=Y2toNPQXtCZS6Aq1VDMwO7TuL0/HldJ/+//NbHVcOFRqE0bPf+QgWXu7OKR3YZkUk
         ZC+l4bepQYRf3F0LrIxbFTSKa/1O0/nQ/R9ZN52deFSKkDC2eaOf6hA31bYhNsRZsW
         7Tmc0zP8qHBKMoycSHXYP+xAYa9/ydaYYEe8inxlFQ+8TLbXZZ4J2aLMhNTH2e1by4
         yjwKVK9AvCEJNF7IMnM5CX4dxgTJAnpjAJfjI87j/6qiH2CML6h5n2jMVlIG4aMRHP
         Pm36ogGtZIonvyhH5y+NvkI57qHNkp4oHmTsvLQEoTMCvwQhDWZ3gXyPBwbVMmLUj7
         9UHsv2lIa6ddw==
Date:   Mon, 26 Jun 2023 12:39:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20230626123946.6de22527@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HScrxUH+i7hEBmNz4NBuy6A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HScrxUH+i7hEBmNz4NBuy6A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: warning: discarding dynamic section .glink
ld: warning: discarding dynamic section .plt
ld: linkage table error against `sm2_compute_z_digest'
ld: stubs don't match calculated size
ld: can not build stubs: bad value
ld: crypto/asymmetric_keys/x509_public_key.o: in function `x509_get_sig_par=
ams':
x509_public_key.c:(.text+0x474): undefined reference to `sm2_compute_z_dige=
st'

Possibly caused by commit

  e5221fa6a355 ("KEYS: asymmetric: Move sm2 code into x509_public_key")

This looks like it may be a compiler bug?  Maybe the deep ternary
expressions may be contributing to that? (cc'ing the ppc guys in case
they have any ideas.)

I have reverted that commit (and the following one) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HScrxUH+i7hEBmNz4NBuy6A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSY+nIACgkQAVBC80lX
0Gxhugf/db+U5ipJ0TNqttnNlAMQqUTTN6HE01Vl/VDq2ZBVWgJGhiUEBsc6Hypa
a1vHn4xFm/A9z7sEeoiBJDzcnq/89LimWAquEQLhGlcyxcN7GUGyuNsuOL3TYktV
Kg6WpMSXTWbfmltvNKBVyr0cRe1TFGXgs2afNce8E9i24i+D6MLQUFIKfJv61cIB
nnd9swDUqJLCRjLVwRx/rV3Fsd0sRRuexOACVsfv+wN+Wy4qQWxAW90MakfyyQ1y
pPleqCBsmsxOpdE5qKcvy4SWm2KkdTODyZ/wQ/f+lSVM22xqiWLihhnzrc4Qe0jF
4GXxbymZqmfZl9QNJt4poJCD/gO4Dw==
=uP7F
-----END PGP SIGNATURE-----

--Sig_/HScrxUH+i7hEBmNz4NBuy6A--
