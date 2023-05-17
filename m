Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B90707669
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEQX34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEQX3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:29:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1EE3A8D;
        Wed, 17 May 2023 16:29:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QM8TS3qFlz4x3j;
        Thu, 18 May 2023 09:29:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684366190;
        bh=fqAwdBEcQwKioNZmlFO4wgaErA1iMe5FGf8/9MUD/CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UJ6RHKZcP1kcssiI0rI4e6fdK5r2gRhFGi3esKqw21KAi3EHFyfNXRgZ/IguMhuIy
         mAXqoEJNyG7+nbWCYJIZ8CDvy0hpe63CbjWsO79v2uZa1FCt+IdTaQqDbKh9PE67sx
         yRYjt4cJbb+dnCcRwPmO6VRlAQ05S7VN6QD5ZE4CCeVOpd8XzpNJiovoYdWleqmv/j
         MDvA+quBp+k29wbyRk5qEveKsue/2SJ6jBBFVa/rk20aptrw040Tjxgx8Q1rx+6QJZ
         71eBIwQuaAYM5IPiez3ry37z8+cT9eNJAwLt5TAsFCEGqIHW7lm496CK6f6JC380P9
         Bcynt8IxYio2A==
Date:   Thu, 18 May 2023 09:29:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
Subject: Re: linux-next: build failure after merge of the net tree
Message-ID: <20230518092939.2a2c8c40@canb.auug.org.au>
In-Reply-To: <20230518090634.6ec6b1e1@canb.auug.org.au>
References: <20230518090634.6ec6b1e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bJuKku9fT=hor5qRBLm+WR9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bJuKku9fT=hor5qRBLm+WR9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 18 May 2023 09:06:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the net tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:419: arch/arm/boot/dts/stm32f746-disco=
.dtb] Error 1
> Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:419: arch/arm/boot/dts/stm32f769-disco=
.dtb] Error 1
> Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> FATAL ERROR: Unable to parse input tree
>=20
> Caused by commit
>=20
>   0920ccdf41e3 ("ARM: dts: stm32: add CAN support on stm32f746")
>=20
> I have used the net tree from next-20230517 for today.

This also meant that I used the ipvs tree from next-20230517 (because
it had merged the net tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/bJuKku9fT=hor5qRBLm+WR9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRlY2QACgkQAVBC80lX
0GyLnwf/ahC3L3K7OAxynqf1u0zTkK+bFFcgNPplYhCLHQStL3JxL1bEqP2bCn9p
/zW+RaiRhsRg8oBoZ0jpdWbDjKgHR6ZsExB8tLEC/CsuffSXJzb8avDbWFW8CAt0
ze9ES2aIqC3kSFbuxClQlPxseu+AUQt2AoYQ0fFrOP54j8WxW4UNB6Qz3b+qfd7x
fPfUYBi5y0bB6ORbxZiOq0VRZyDU+U8j0NDxP5zW+QGQNP+dwZnT3Zvj8f1cfj+Z
0+53FriFcbpdJYF2yrKUy3GmrVGEOZtoU/qc1mv3vuXNANT8VmklZDcGNl59EYYU
1s5Bg1fpEqyuFVB5pO143hu+8zDr/g==
=sgNB
-----END PGP SIGNATURE-----

--Sig_/bJuKku9fT=hor5qRBLm+WR9--
