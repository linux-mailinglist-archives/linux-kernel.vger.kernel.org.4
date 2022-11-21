Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09C6330DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiKUXnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKUXm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:42:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4348DEACD;
        Mon, 21 Nov 2022 15:41:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGP6n6G0tz4wgv;
        Tue, 22 Nov 2022 10:41:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669074098;
        bh=6ACU4lm6mckyP2bUnEllUx7Xslx2xTIp6EMN9eZfHWI=;
        h=Date:From:To:Cc:Subject:From;
        b=kp41VEGGQPiZn/s0bNVHyyrknq2tOy6cdMpBY58QuZtVGrN1Y3m/3WviT6dnaQZuE
         eSs5pOhSsulgKJn1CPtyBFrId2OdOUH/A+Ix4plKC2s4+zcZ63OGOYsJmdCFPc0uVE
         WwWHzRckjs9Ggp+zizVh6HUARPO/DBfVmpiX9f61o9YMT96a6n7A2Cp4vOLAs2MehJ
         9F4E1DKzNVTlgeF/WbnJDLBTFQfLeQw0/oYCOEbdqk6Q79VVi0efcZItaLUylyrJ4v
         XS+ivXaUUVG2U7zJvBWg+LROniJk+5tJEh1rDIt9OEHya/cgHQTWJRHuYHBGQDt5lv
         ffWBjJx45jCdw==
Date:   Tue, 22 Nov 2022 10:41:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Chris Healy <healych@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm64 tree
Message-ID: <20221122104136.601ba45e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z7W22ZE_9kW+JiUxp1pPYkX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z7W22ZE_9kW+JiUxp1pPYkX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/perf/amlogic/meson_g12_ddr_pmu.c: In function 'dmc_g12_get_freq_qui=
ck':
drivers/perf/amlogic/meson_g12_ddr_pmu.c:135:15: error: implicit declaratio=
n of function 'readl' [-Werror=3Dimplicit-function-declaration]
  135 |         val =3D readl(info->pll_reg);
      |               ^~~~~
drivers/perf/amlogic/meson_g12_ddr_pmu.c: In function 'dmc_g12_counter_enab=
le':
drivers/perf/amlogic/meson_g12_ddr_pmu.c:204:9: error: implicit declaration=
 of function 'writel' [-Werror=3Dimplicit-function-declaration]
  204 |         writel(clock_count, info->ddr_reg[0] + DMC_MON_G12_TIMER);
      |         ^~~~~~

Caused by commit

  2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PM=
U driver")

I have used the arm64 tree from next-20221121 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z7W22ZE_9kW+JiUxp1pPYkX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8DLAACgkQAVBC80lX
0GyKYgf/QP3u/VIkEa9VD1Jgu1khhOP2XTSA0Jyd/JPSN8vFenRGp+2/eVclwPT3
yFsxrIdaSNXc7rEZ/QyEPu68kTJNDc4rtQZ3yhCDFaG3wsvIzOWDIYhySNlAoXMa
uAR/uKbKtz2Xtxawir0dWMr6l6qdoi9gRqL7E0A5s4+G3wjAF+J3PuLBnyH2Z0Z/
zqMwPvP5KEmUz31CIfSKHv1Mb6j+fE+oehameaJO7G/2vCCkX36qPwActndMWjEp
a9SdPaMlJpYXyDX5QRiQUTEY5xYKJN1UnwRSotZ14hpFPjKAQVBtI8jj7A88lH9F
JGEjO7Qh4fogg45pQjcNDsIZ95/eKQ==
=01Fu
-----END PGP SIGNATURE-----

--Sig_/Z7W22ZE_9kW+JiUxp1pPYkX--
