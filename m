Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EFE5FCE43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJLWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJLWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:17:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1CA347C;
        Wed, 12 Oct 2022 15:17:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mnn842cDDz4xGn;
        Thu, 13 Oct 2022 09:17:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665613045;
        bh=IdeIqATepEp8JG5crg9kVVBAs9Q8W74WpCzdfY5l/+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=WwNWvWscqkNgorXotjxRH9FQc3A/SZcskj027fK82xYTfIEPT8S4/6fX5EhAiKAl5
         0ab50EWhyVnufxlSWYtvuC/2me8udlvsOFXwK6FFx/SXh1P/+U8wRwYbxq2ilXfhlC
         CNMh0aKg9zNSSGoitJDWqdlcvzG/ZhCBXZOTuZYz0hY60IK72T1oN2Z4GyedvsjeIl
         Mtc/UVwNrabIVkvDrm25ukfiHaEPabV/lVUL+ZYKgcZBEk71l9dVgEjlcL2amJOsKC
         niWDdleYmHSO1O4d36ue+yucTbngvSa8Uo6IeZlJQG811qtsNDWSOAu4ElA2dL1G9g
         y+3MrTmr+BgWg==
Date:   Thu, 13 Oct 2022 09:17:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20221013091722.72263dca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3kobhu1J3bC10hV7je+0fP0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3kobhu1J3bC10hV7je+0fP0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (x86_64
allmodconfig) failed like this:


Exposed by commit

  61168a974a16 ("Makefile: add implicit enum-conversion check for compile b=
uild")

We don't add compiler flags that produce more warnings/errors without
first fixing the known problems.  This was the example of what would
happen that was cited in the commit message.

I have used the kbuild tree from next-20221012 for today.

Is this new stuff really destined for 6.1?

The actual error was caused by commits

  5fc11598166d ("drm/amd/display: expand dml structs")
  d478667253f9 ("drm/amd/display: use odm combine for YCbCr420 timing with =
h_active greater than 4096")

which entered Linus' tree during this merge window.

--=20
Cheers,
Stephen Rothwell

--Sig_/3kobhu1J3bC10hV7je+0fP0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNHPPIACgkQAVBC80lX
0Gz4mAf9FxbooudGPv8/owa6EiVxWXVTaqMc3xtXtWvZfaPPmmCg6fIMSkQFthei
9sfvts3beEgQiGiqhf3j178K1QuFHJREdKz7VlpNyj5dHTW/Bkt8buoOpbbhRcq2
0k2eiZmlm9xOdWUIKrG8nHs2CVXWJry4BBpfX3mKINXfNHoY3lkrkATxwJPq2BPv
7ColHs5iAEHFz4h6wS4NBxXcbgYtqV8Cx3t0/SvykZ5DrwZnLOENzG+a27hMr6/6
ggLAH2Pc7nFvtmx4LdUlrwJ/aQzyyiyrup+OhOMbp9Uzm031uRjo9CJP6vEmyegK
OC7YDnRDp64UttQwCIkRnnchV9wRyA==
=6e/u
-----END PGP SIGNATURE-----

--Sig_/3kobhu1J3bC10hV7je+0fP0--
