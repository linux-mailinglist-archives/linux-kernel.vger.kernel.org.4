Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAFC6E6740
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjDROel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDROek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:34:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ABA9F;
        Tue, 18 Apr 2023 07:34:38 -0700 (PDT)
Received: from mercury (unknown [91.248.213.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4CCB166030AB;
        Tue, 18 Apr 2023 15:34:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681828477;
        bh=YVhZnKJ5ECxtU4C6qrisrswyDM2gDfxNK8VZem9eeZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caxVnhAI8c9INieG9RyP2ZeqAO25TKzDcS2YHHJ0T+x8c06O1Xx4p6coX9H0j+Lf0
         wm6EHVg8E6mXQ7+Q02N5f18n3jrSAo7kAvUJQlJKpPLq2klNxFpJ8S2sXF/KRuERSn
         K0MgsaiS2dQtYkBIqluAqor7Tol1c4t3+OPaA6zqbgi+HY3YbB2a6rj9JLKW+HxnUp
         UFXkw8mFVoQ+DjkS265F0We0RuYpPDErE31Eynvn1xUeoVZD+L9AYF+cSAvxRRWYf7
         elUKUpqbuNQknCfiU0xD4ugvu4kr5Gx+jNACshChnG6o1uh6ybk6lDg+kLeOB9W2wi
         DrMJzt4mZNCaw==
Received: by mercury (Postfix, from userid 1000)
        id 25A481066F0C; Tue, 18 Apr 2023 16:34:35 +0200 (CEST)
Date:   Tue, 18 Apr 2023 16:34:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] irqchip/gic-v3: Add Rockchip 3588001 errata
 workaround
Message-ID: <20230418143435.th22y4thv5vinwqq@mercury.elektranox.org>
References: <20230417150038.51698-1-sebastian.reichel@collabora.com>
 <20230417150038.51698-2-sebastian.reichel@collabora.com>
 <86a5z6lbuv.wl-maz@kernel.org>
 <20230417214033.25ckpswkjj6twfot@mercury.elektranox.org>
 <865y9tlg7q.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbbhwx4mrkobsids"
Content-Disposition: inline
In-Reply-To: <865y9tlg7q.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kbbhwx4mrkobsids
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 18, 2023 at 09:58:17AM +0100, Marc Zyngier wrote:
> On Mon, 17 Apr 2023 22:40:33 +0100,
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> > On Mon, Apr 17, 2023 at 05:20:08PM +0100, Marc Zyngier wrote:
> > > Also, I don't see anything here addressing the *other* bug this
> > > platform suffers from, which is the 32bit limit to the allocations.
> > > Without a fix for it, this patch is pointless as the GIC may end-up
> > > with memory it cannot reach.
> > >
> > > What;s the plan for that?
> >=20
> > It got fixed in RK3588.
>=20
> So what's the plan for the affected SoCs? It might be a good idea to
> address it too, unless there are none of them in the wild?

The previous generation (RK3566 and RK3568) is affected by the 32
bit issue as well as the shareability issue. I'm currently focusing
on the RK3588 and that's the only Rockchip platform I have on my
desk. Missing PCIe support is a lot more critical on RK3588, because
multiple board designers decided to use a 2.5G PCIe network card
instead of using the 1G network MAC from the SoC.

Anyways, I will try to help out with RK356x once I find some time.

-- Sebastian

--kbbhwx4mrkobsids
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQ+qmoACgkQ2O7X88g7
+poOaxAAqLmebbW7CWZLqCIVVAxM/6dngT5X14eY2x27bNNmSsJGucNlvYJT6se+
GGAUWMm66joQZ81Zr3u5ioCXrpJrdmXoiNCy3A2RBEtSiJ0A7Yi2z1yRezHuXmLd
e38IrxQu/EbW+p3hXVetbdrrp39AiE8Rm734D/xFDbfUrwemQscfVj76Wg7EXyu3
LNbebiGtfMPXcH2328mIIE8MaiK0jgQlkNPDQLMA749SRLxGE8TdGweHLW3dOQys
0iY66CCRzzduB0jUnYyh+H8sVb3YVXzS31mD5+ONzdNjvA67Wz6hXmw2XLjVh+zx
IUEzb09CH61huvjx8RQz7RLzWTjowFLORpB/ZcNnlLmMcrM8pw49x1BZZaYPzLqc
KQcA6AcEQTRoISaVcFvRkiwDANJMCrrimuTIZV8GrTCxXoYqtH1tkEiB1VvJyTo2
XfIAzlw+dATucraNBVHvpoi1UlL7hrJ6ltykv0TVw0oeX3OwGPSwxrkr7BwwMHu/
8a35QogKik+uaJUBjENgjDmSa+IxyZAs7zIZmD8DcFe6Mod+VAM650iq2U8I3quv
7tbnp8V1P56Uh348WIYiPyBvuGEJhPeopxhu455w/j+xQJHC/IHdH9B8ig1zKpRd
cHPf8PP3N3fDSf68T5I1edptd/44fOgb6lkIOOqaqpqNglxhS50=
=zajV
-----END PGP SIGNATURE-----

--kbbhwx4mrkobsids--
