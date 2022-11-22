Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2AD63348E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 05:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKVEw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 23:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVEwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 23:52:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC527B23;
        Mon, 21 Nov 2022 20:52:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGX1H33fbz4wgv;
        Tue, 22 Nov 2022 15:52:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669092740;
        bh=rp6Nsgm6fcD7cOsZIVlJFAzX3QoeC2dAZrx5St04Rvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=skNPp7tb51i4FbD4cykqiGQG00bzDwUKnyVL5YrJZfBV+MX2lwv0TuFLLm++X9F/H
         ySV2e/591LqVhOwOsr6tDZ9z9fS7kOGpO/T9jcH8zqLChfIGs4K2lG+VFOosyR9DT/
         Ne5/HP3JNYGgvcJSAi8NazZ9KInIBxtcr//F4QDt3B7QoSMx7dsP1EPr46VHjieS4U
         uzFTuynEs+4jfAC9fa/WghBDJnMQgTH6YS4D2Qza2p+6V66Uvf46Ef8nTDq49DRwxu
         q5wGa8ljcqTXwwMdXkaj+w/VDR9UqP60wCkGi+lxKCz9U6XJqzFLqthjjiAfj/3Spl
         TdDtPXnvFqd5Q==
Date:   Tue, 22 Nov 2022 15:52:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Healy <healych@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm64 tree
Message-ID: <20221122155216.47e0aca9@canb.auug.org.au>
In-Reply-To: <e12a12a4-ab6c-ff4a-5cb8-10e498e696a5@amlogic.com>
References: <20221122104136.601ba45e@canb.auug.org.au>
        <e12a12a4-ab6c-ff4a-5cb8-10e498e696a5@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kr3wh5Y2ecqoL8K.3PylY/Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kr3wh5Y2ecqoL8K.3PylY/Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 22 Nov 2022 12:17:24 +0800 Jiucheng Xu <jiucheng.xu@amlogic.com> wr=
ote:
>
> Could you please share your compiler information, commit id and other
>=20
> environments info for me to reproduce the building error?

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 12.2.0-3) 12.2.0

The head of the arm64 tree that I merged was

  27131b99f024 ("Merge branches 'for-next/acpi', 'for-next/asm-const', 'for=
-next/cpufeature', 'for-next/dynamic-scs', 'for-next/errata', 'for-next/fps=
imd', 'for-next/insn', 'for-next/kbuild', 'for-next/kdump', 'for-next/mm', =
'for-next/perf', 'for-next/selftests', 'for-next/stacks', 'for-next/trivial=
', 'for-next/uaccess' and 'for-next/undef-traps' into for-next/core")

This is a cross build, host ppc64le, target x86_64 allmodconfig.

drivers/perf/amlogic/meson_g12_ddr_pmu.c needs to include linux/io.h
(and your test builds probably got it (or asm/io.h) via some other
include file).

--=20
Cheers,
Stephen Rothwell

--Sig_/Kr3wh5Y2ecqoL8K.3PylY/Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8VYAACgkQAVBC80lX
0GwQowf/UE7oCc3KNqNBMHm9fC+hbNKUj2t2HVQkOmrAEsY6ZANGNjaxsVcdAwmb
UNKXkwZse8Mr6x984NHMrmaY4RJjooXM5DO+RJbJ/++pWopCeG5Jl2x9Le+zv5Dy
foLJ/cSJeDRGhe/ibChrkxiRImIuBY+s1q935NzhCXM7c6y+Q3jqKKxwdkKsvPW5
swloan6WDaQNi+MJ73k1cJvVNrsP5XhlFpnOGo7WCcDIyFSRVOYnBXzoJnB4ExrS
0d8HrWCMSemSnDpYqUp4KZ9Dx2PxTDQp7Hs7KUFtw7MMJj0jJZpKuhj4d7ovOWEb
2koLyHm4s0mnBjYol6FUzqDwcXAysA==
=6UFc
-----END PGP SIGNATURE-----

--Sig_/Kr3wh5Y2ecqoL8K.3PylY/Q--
