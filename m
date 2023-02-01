Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBC683BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBAAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBAAOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:14:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521A4391D;
        Tue, 31 Jan 2023 16:14:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P62Th1FT2z4x1f;
        Wed,  1 Feb 2023 11:14:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675210456;
        bh=o0o3Moxir1kLlh7WEDMz9hWZVx2Z19uTufs0lLVHxfY=;
        h=Date:From:To:Cc:Subject:From;
        b=LQDKv8kowSf5NYwGUB2r6aS9AF2uPE5lcasWD8J9iYbMnFFJewRMNTzzf4gUGJerg
         53sT2TaBZK0f5KnqEAUOz1btfq4ulrjxzSjRoLkSDsamw9PacdOxEYSAE+AHvd4liF
         NQxkGVx8TFNhNodmbhJsjlunUMJr3KzOdEhAD1fDzjpZxvE3tSfeb1GGnBK1XUrjF4
         YheScHZQcNG5kYj4kqDSPcVaqKN2XzMrHgOLyEjgwF2cUv5eIY4dx7NLuyAt5h6Fwz
         itwvx0ALjOFTAkurPv2BoxiWExjoP1vNf1hHxozPVx6qCWYB7vTBiiRpNsJXtZcPJP
         QNRyA+Q+Lxwuw==
Date:   Wed, 1 Feb 2023 11:14:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20230201111415.67bd4b7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yFu.unNO5Q7WdfogWE7l3Kr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yFu.unNO5Q7WdfogWE7l3Kr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/codecs/cs42l42-sdw.c: In function 'cs42l42_sdw_dai_set_sdw_stream=
':
sound/soc/codecs/cs42l42-sdw.c:159:20: error: 'struct snd_soc_dai' has no m=
ember named 'playback_dma_data'
  159 |                 dai->playback_dma_data =3D sdw_stream;
      |                    ^~
sound/soc/codecs/cs42l42-sdw.c:161:20: error: 'struct snd_soc_dai' has no m=
ember named 'capture_dma_data'
  161 |                 dai->capture_dma_data =3D sdw_stream;
      |                    ^~

Caused by commit

  90f6a2a20bd2 ("ASoC: cs42l42: Add SoundWire support")

interacting with commit

  3653480c6812 ("ASoC: soc-dai.h: cleanup Playback/Capture data for snd_soc=
_dai")

which should have been fixed up in commit

  98fda42a85b4 ("ASoC: cs42l42: Add SoundWire support")

I have used the sound-asoc tree from next-20230131 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/yFu.unNO5Q7WdfogWE7l3Kr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZrtcACgkQAVBC80lX
0GyvrAf/c8F/WieuJ3UtXEe8gSDmzIollxuLvqeP5hL+O56Z+UlGuPPNK/Ye8Mbe
Qn5O5nBXKQ1i4bRPIwBKrohZ/dDmdBomj9gWkJZKjotPYjZGjWEAOD1fApXyyguN
PPiUCCOj2EBELAqolR8f+dwI003f0D7Tkf5IzkhkEZeGxSy0x/G+dBFpLb62JZsb
+q1YopBTs/SeXYqiRdVKFU0xBp2pu4bkVJOGaOaTgfEOQCuDf3E5Jv6X1me9YCJe
VJS6TuSZmG5I6VuRM+9Mxa8BDmtT1mqleBRX9+GKUWoxi/WQbwLvEk5kXNB+wqE2
xEV6R/7Up83bqeC4s6QvD7+KCIZB/g==
=o+kE
-----END PGP SIGNATURE-----

--Sig_/yFu.unNO5Q7WdfogWE7l3Kr--
