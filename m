Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F2B70D29D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjEWD5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWD5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:57:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574193;
        Mon, 22 May 2023 20:57:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQLBF6qBMz4x46;
        Tue, 23 May 2023 13:57:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684814262;
        bh=OAB3v8zSIQ9J1f31msYxvJJ0TGrUimNxS5kJRAb27cs=;
        h=Date:From:To:Cc:Subject:From;
        b=SeGFic6OpRrIcHU5LkfzWdqUQAFF5ejcO0iXVCqna/OuBHubISD5d9/xgJjCJ5++R
         IjzCQ6O6Xxaf/BuGaKmU3ch4vWo5yJFcppAk9PND5o+MOb+43KIAuMe4Kyu34F5ACA
         G1FRqIu0+xwbrwlAnAoxXkub/a+3lqnmvELLKOA+D6Vq5xtR8QZ4l11AVuMdxvPoUB
         c8fxqL+5dVJtOb/LTJ7urrmhy6LJYvpRM2AbU3w6QpvpkxFX6qft0lb2YyacwAMGT0
         fy5s9XCojavQeaveb1tIMZpJAuzcrnm83i8MVUJvEph9NwJu9oY9b0HSyEZPmcP79f
         3hYK5SVfBMFYw==
Date:   Tue, 23 May 2023 13:57:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Joel Granados <j.granados@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: bott test warning
Message-ID: <20230523135739.73068c68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e04NEmNrpspEQeDhUfjkXsY";
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

--Sig_/e04NEmNrpspEQeDhUfjkXsY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next boot test (powerpc pseries_le_defconfig) produced
this warning:

sysctl table check failed: kernel/usermodehelper Not a file
sysctl table check failed: kernel/usermodehelper No proc_handler
sysctl table check failed: kernel/usermodehelper bogus .mode 0555
sysctl table check failed: kernel/keys Not a file
sysctl table check failed: kernel/keys No proc_handler
sysctl table check failed: kernel/keys bogus .mode 0555
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc3-04222-g1999c5d1802e #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
Call Trace:
[c0000000028bfd40] [c00000000113ea2c] dump_stack_lvl+0x70/0xa0 (unreliable)
[c0000000028bfd70] [c0000000006166f0] __register_sysctl_table+0x7f0/0x9e0
[c0000000028bfe50] [c00000000204e650] __register_sysctl_init+0x40/0x78
[c0000000028bfec0] [c00000000202d660] sysctl_init_bases+0x40/0xb4
[c0000000028bfef0] [c00000000204e6dc] proc_sys_init+0x54/0x68
[c0000000028bff10] [c00000000204dff4] proc_root_init+0xb8/0xdc
[c0000000028bff30] [c0000000020045d8] start_kernel+0x7f8/0x834
[c0000000028bffe0] [c00000000000e998] start_here_common+0x1c/0x20
failed when register_sysctl kern_table to kernel

I am not sure exactly which commit caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/e04NEmNrpspEQeDhUfjkXsY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRsObMACgkQAVBC80lX
0GwElQf+Nb3E+O9PyecI4GgNVdg7CF7sgFf2RnRfKkUaUrvh4Q83ykGUrleeVw3I
/NA1ReKQ+4huwCdKSX6eYz4pwvov2TVJ+HWGNd+SZ8vQCTweDwRgHAVG1QgBthSi
7ukERGADyp2mX8eXprJ9Zsdpm2pC/e01tI4rvCd5h904VMXBPqiQ4xvrpAHSafVZ
Q5o/ksee+uikMNalhe7MEf7jsIrpkAAECEJ2VIS7iH/aoEiY7LPGpAdRH2rdnebq
BfKIK/huy2eamSuJnAP8l2Ey4fNChcvAn37CoDo2GwOsl4q390JGBXYsKFFxrryP
+msw6GNN8ZvRKfywj/Z5lQXMneBZQQ==
=PxBl
-----END PGP SIGNATURE-----

--Sig_/e04NEmNrpspEQeDhUfjkXsY--
