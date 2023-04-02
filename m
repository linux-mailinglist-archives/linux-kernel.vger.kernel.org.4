Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199286D3AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 01:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDBX2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 19:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBX2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 19:28:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09993AF29;
        Sun,  2 Apr 2023 16:28:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqVZf0BkHz4x1d;
        Mon,  3 Apr 2023 09:28:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680478108;
        bh=scqXINyn5PkPyesGIzKR6g3bD+rz5JUuwzD7IWl2tZg=;
        h=Date:From:To:Cc:Subject:From;
        b=FX4dsGWmC4R3W/oLVGwg4sHwZHrwRlC3hUlM/9eXh1OT4DJwlfkd2ezkviDcaju5+
         ACq5hmXEW3JF7BFsETAAxzhqhB8Vfd0yanr5psftOE1zwWL83XLiAq8PUE8iWGffsz
         YmeRtUvKlVJeV0JCPpEZh6I1wdWIKeYCEMpN/1mehw5Mtg1l5zSuvxAaQ+MA755xwM
         GMVHy/7pRsi+MVHfV9fWLfiSnISFTbIdOuiglmBf2CwWe5Jl8UX6UvdXY23wg8wqYx
         YMCXgT4E50BprAKhuPQ21gzcPPHgkm1QJU5Butwf2E4h4h4slf6723MO6kAeBKJB5X
         j6aYcZUo+RAFw==
Date:   Mon, 3 Apr 2023 09:28:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>
Subject: linux-next: manual merge of the clk-imx tree with the clk tree
Message-ID: <20230403092824.67117617@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WS.qhpd_80KTRl8sU9poFhx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WS.qhpd_80KTRl8sU9poFhx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the clk-imx tree got a conflict in:

  include/linux/clk-provider.h

between commit:

  d54c1fd4a51e ("clk: Add Sunplus SP7021 clock driver")

from the clk tree and commit:

  27fc5ec673b5 ("clk: Introduce devm_clk_hw_register_gate_parent_data()")

from the clk-imx tree.

These add the same macro, but the letter has the docmenting comment wrong.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/clk-provider.h
index faad3cdc1e48,92b7c794c627..000000000000
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@@ -608,9 -608,9 +608,10 @@@ struct clk *clk_register_gate(struct de
  	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
  			       NULL, (flags), (reg), (bit_idx),		      \
  			       (clk_gate_flags), (lock))
+=20
  /**
 - * devm_clk_hw_register_gate - register a gate clock with the clock frame=
work
 + * devm_clk_hw_register_gate_parent_data - register a gate clock with the
 + * clock framework
   * @dev: device that is registering this clock
   * @name: name of this clock
   * @parent_data: parent clk data

--Sig_/WS.qhpd_80KTRl8sU9poFhx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqD5gACgkQAVBC80lX
0Gz3wgf8CigVtHHO3b8Z8RPXi8Zh42yH4ewp1KFVUsR8i8tPg74ibnABKdkum8Hx
PrGp4H0kjlxUxDP1dkGP/vXgZJy3yJRa5IQByvNs5nqJG01J7dk8CHw+iaHD5+bS
nLua0IrNloAc20gD9NBpL0L+yVmciKY8B1x7Kj8pjayJkC09tH5wkx4ciSXdRFWm
hsBQYchYAq1myBc7i0C2mAsshz7q53T1kOiMk87B6PvfCazOsSwY1wY8JtVuHyVK
kSqnfEWhrMfnU4A+ar/sgWiiXLc8NceSr+eVSeRAyhro3qNdInu3R11zpwUtURMy
n4SNybMsSML5P2QMAXpxyJyFvH3qFg==
=KqOs
-----END PGP SIGNATURE-----

--Sig_/WS.qhpd_80KTRl8sU9poFhx--
