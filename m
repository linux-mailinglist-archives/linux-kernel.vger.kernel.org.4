Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8370ED43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjEXFpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbjEXFpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:45:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D213E;
        Tue, 23 May 2023 22:45:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QR0Wc4rDSz4x3x;
        Wed, 24 May 2023 15:45:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684907101;
        bh=f/I3/vdedLsXjJMBa5rvDPJjW/XaG4l9x0WeCUQ8xnc=;
        h=Date:From:To:Cc:Subject:From;
        b=LHazJkIR0mYp7cwMQWHa5XR0THC7X2J1C9fVb6mRyhu4OBFxND7ZQslu/UNRhn1mc
         Cq3asJ0a9YwtdeTd9+VH+bGn8dWpM2NYc5xLUBw0U2PtHgYZC0ro6+ZUQmYHTrcCck
         VzxopJnCbVg+1R7o3+9P5C4Wd3hYKHzoVvXtqzLYPyW+XYD+T9MribWIFpeAR/mLaZ
         M86EBZSZhx1NYYDBSHgzMw+BSzkslTJVkj0oWj3l/oReFEqaFH6cOu4qkMHpwwoGDr
         YpM7u2rrwtj0D/q1IEp0wBf3R4LGD8v562S2aW2rLGownULrZfgKLCN4MDh1+aU+r6
         XQYHUWJ25TFtw==
Date:   Wed, 24 May 2023 15:44:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: boot failure after merge of the tip tree
Message-ID: <20230524154459.48cda184@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//tEoMQJMHAPUW9maNvLvEo/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//tEoMQJMHAPUW9maNvLvEo/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
pseries_le_defconfig) failed to boot like this:

 Built 1 zonelists, mobility grouping on.  Total pages: 32736
 Policy zone: Normal
 mem auto-init: stack:all(zero), heap alloc:off, heap free:off
 Memory: 2027392K/2097152K available (17984K kernel code, 3328K rwdata, 147=
84K rodata, 6080K init, 1671K bss, 69760K reserved, 0K cma-reserved)

*crickets*

Bisected to commit

  f4ab23558310 ("slub: Replace cmpxchg_double()")

I have reverted that commit (and the following one) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//tEoMQJMHAPUW9maNvLvEo/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtpFsACgkQAVBC80lX
0GwVDAgAlL5vAXSXgHZv3lw2Zu0vvMEbO3IR//QNs9XHsQULb4rYnoVBbEQ3vZds
z3Gm0yaTMgz7LjjSllEUKHw2FBNzHq4yfnwUVf/6tV5IxqQOQMD4JfKs9y54TTIX
WK3A1q4YwcW9ORDo4Yn3tl6ETu8sYKnpOdoehx7jodsFUv55RE+z14zTx4sy1Eex
g85vnkegD8CAHEt28tZYwyuu8nErMzYrNRd3wfHogtLtZPwx+5/pr8zY1CQvn+XV
xZDIqnBNPweCNgVreFLp64XZD+RG5Q2vRbhn8KnscCid3yCULfm7ouMOXOuCuAa7
GeKrtrG3epuZqLwlmmfegN4cZkStwQ==
=l2Q4
-----END PGP SIGNATURE-----

--Sig_//tEoMQJMHAPUW9maNvLvEo/--
