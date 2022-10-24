Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AE60BFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJYAfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJYAex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:34:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8082D8736;
        Mon, 24 Oct 2022 16:00:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mx9Xf3qLKz4x1V;
        Tue, 25 Oct 2022 10:00:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666652451;
        bh=eotwvGasqAc4vnaOIwXKE/43nzNnMiRZsXgTE3pyD1k=;
        h=Date:From:To:Cc:Subject:From;
        b=VcS/ETfzGrzXYQEwO8swqZ0EakpKIb0yKyGtXJzUMSeYFUvv2foRfXl81HxhqP9Bo
         J43k3qY0moQ0pRem55wC8Q4C/aB2QlvRlw5LJo9j6ZvPkT9AeVKH+yg+6UV4w3k0Qz
         fxsjrlNQgT2ajxVYJyUyIc7bMIDrPoOzTB1pof2cXFjnW01ItjSFJqrbtFwRNMlLl0
         3QWvaTghiO1ckzYPjoy8ByR+gFovnZLCyGxasSVs5lEZDnMiSOmZkEVZczrl8xY5tW
         bRh11zbH3O0ofvaaWLlPmcqEyuS1wlAtFLIxm0WN0Mjvcmxt14hqh7iTBWv2udo7Ym
         29x0vYYV8RcqA==
Date:   Tue, 25 Oct 2022 10:00:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the input tree
Message-ID: <20221025100048.49384530@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J7Z6Km5Qa2LFiaGFGDNFuRp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J7Z6Km5Qa2LFiaGFGDNFuRp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the input tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/input/keyboard/stmpe-keypad.c: In function 'stmpe_keypad_probe':
drivers/input/keyboard/stmpe-keypad.c:353:9: error: implicit declaration of=
 function 'of_property_read_u32' [-Werror=3Dimplicit-function-declaration]
  353 |         of_property_read_u32(np, "debounce-interval", &keypad->debo=
unce_ms);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/input/keyboard/stmpe-keypad.c:355:33: error: implicit declaration o=
f function 'of_property_read_bool' [-Werror=3Dimplicit-function-declaration]
  355 |         keypad->no_autorepeat =3D of_property_read_bool(np, "st,no-=
autorepeat");
      |                                 ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  8b96465c93a8 ("Input: matrix_keypad - replace header inclusions by forwar=
d declarations")

I have used the input tree from next-20221024 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/J7Z6Km5Qa2LFiaGFGDNFuRp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNXGSAACgkQAVBC80lX
0GwSawf/c802VDOd96XgmbLkMH1QBVAKFfQdYBzdIZUAMDHcpAzn7InFvIotmYPf
uo7mGcEor0woempAZv8iLrdpJYA6JvoGko8J0cyEzaHtRRBOmqDITa3KbbBwr28V
lzI39ItsRAV3sMnWX1l2n2exmQ63MqXx04+C3/vkciq+Xj5wgEfYgOJ9Qle/4s4p
a7fO4oCDI0vZ25GZHOgDkXhaVON+tZPZTzCop/1FKTNTwnQvRFcjIM4URX+JHnqn
UziJAxCKvSalmB/b7WGwdFV/HWQE4O/ynZ4Do8mVoe435F+bJSWEEtl0l6Lz4/H+
38ftIex7fdrS81Nzre7XBiafqJqkqg==
=b6b1
-----END PGP SIGNATURE-----

--Sig_/J7Z6Km5Qa2LFiaGFGDNFuRp--
