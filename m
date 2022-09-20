Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB65BDF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiITIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiITIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB96658F;
        Tue, 20 Sep 2022 01:08:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWvLz5Cd8z4xGC;
        Tue, 20 Sep 2022 18:08:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663661323;
        bh=B8qq/233/Cde8M31dwO1JUWi4jzNoEdF+KLmylEybiQ=;
        h=Date:From:To:Cc:Subject:From;
        b=JDSfWxOm64Dcztj0AuZ2D3jdLX1D04jbx5eoWyNnsuO04IiOGD+eiDL1wmMD1Xypr
         g2iJzAX73dyU4STkhnmcbqpPkY946m9YfJAFJCAR9/sEhzLpLMWEXJGnlexPbuzYJg
         bKzibvEbUaWD6d9PEQglkPuF+5pW0IQ3jY9qKz52rVm5sepvahDOjCwkxim0oedWR9
         foqlJJqtoQ4Xz4ScnwKmAA5bI76SaaHWEW113GYnwg4WMqT2JIpHebBW7TNs9J8A6K
         LFf83OyIyTfWz4OQ2yJD1mgC0Uce2XvDrgIH70JqzqHkf/2/RIoO2NhKy3rl7y8EaL
         9jtkLIMWxJXgg==
Date:   Tue, 20 Sep 2022 18:08:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20220920180839.79870ef4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8AR6AaCQKj__XkhCm2gEw93";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8AR6AaCQKj__XkhCm2gEw93
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (powerpc
allyesconfig) failed like this:

ld: arch/powerpc/kernel/head_64.o: in function `generic_secondary_common_in=
it':
(.text+0x545e): undefined reference to `nr_cpu_ids'

Caused by commit

  c90c5bd9f2d6 ("lib/cpumask: add FORCE_NR_CPUS config option")

This build has CONFIG_FORCE_NR_CPUS set but the (assembler) code expects
nr_cpu_ids to be a variable ...

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8AR6AaCQKj__XkhCm2gEw93
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMpdQcACgkQAVBC80lX
0GwKUQf+I+fabUjO88xgqDZHCQTDKzWvZ6s3CRACQSPSKQsSyVUUWFPCzgUUNdAL
43lfsrSlWPXnZtwtmP7OINHbm5BeBkEGC6LI8bL9oBlcQVGXszKX3ZwURZY4kgSj
NrDssdd4z3fJBUxnhAjaGMkPakl0SXbfvg9g9Gd1NMn3Z5kSOvujsEzBrLJgk4k0
dKiLWPwkL28UgwLGRdcNWyHXukNGj4+lDxQxea2us41764h2gxbU9Mi9kE/ALC/a
mJRZ3iMp18TgeNrvqY/y3VBV5hgqoVriPYetimVoqUsxivmapCAF7xCTzEiyev94
XAf4AUvmZlm2OhVaotwi086xUX9E+A==
=Bmpz
-----END PGP SIGNATURE-----

--Sig_/8AR6AaCQKj__XkhCm2gEw93--
