Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5C5FD8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJMMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJMMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:11:43 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16452F88EE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Bs6UaAtdKRczUE9CXUJ6ws9B8/5Q
        tcCJT0ZD9hFHa1I=; b=qSMaNS6nmiUAS8Ga4uxIy1OfchpgpUJIkKRXlr6WTjde
        a0n3bEK+fBAZroabc/SVXiN6zn8gDOliCrhhRe/Vreud5TXVY4QrJj1jDmOsRbbb
        uEJbjafJ5FmsuhtQRbHEt4zvmYfAej1yAlFTNy7uqp4SPC17E/2vc93KdKZ7SgA=
Received: (qmail 1098375 invoked from network); 13 Oct 2022 14:11:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Oct 2022 14:11:40 +0200
X-UD-Smtp-Session: l3s3148p1@g0hdaenqTa0ucrUX
Date:   Thu, 13 Oct 2022 14:11:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memory: renesas-rpc-if: Add support for R-Car Gen4
Message-ID: <Y0gAezsj7gCAvL3U@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665583089.git.geert+renesas@glider.be>
 <4d0824bf5ed0fb95c51cd36f9a3f0f562b1a6bf8.1665583089.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5WOA92+W0p1Wi3PQ"
Content-Disposition: inline
In-Reply-To: <4d0824bf5ed0fb95c51cd36f9a3f0f562b1a6bf8.1665583089.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5WOA92+W0p1Wi3PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 04:01:52PM +0200, Geert Uytterhoeven wrote:
> The SPI Multi I/O Bus Controller (RPC-IF) on R-Car Gen4 SoCs is very
> similar to the RPC-IF on R-Car Gen3 SoCs.  It does support four instead
> of three bits of strobe timing adjustment (STRTIM), and thus requires a
> new mask and new settings.
>=20
> Inspired by a patch in the BSP by Cong Dang.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15 | ((v) & 0x8) << 24) /=
* valid for R-Car and RZ/G2{E,H,M,N} */

Very minor but I spent a minute to get it: To make sure the reader
easily understands that we want to set bit 27, we could make that maybe
more clear with:

	... | !!((v) & 0x8) << 27)

But if you prefer, we can keep it like this.


--5WOA92+W0p1Wi3PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNIAHsACgkQFA3kzBSg
KbZmvA//bKaE//8bh/0bhSzHJAKP3qLJl5MFpTTBalSsHCgQ1Q44MlxrmWIOk3ki
XQCMCY943fMYpcNB65kMNONI1FqEUhYPjnTKBvTdgTOOL4fA3Rpt8Rqvos/dOzUZ
OJgBPcOsrJRcME2Sir6O3hwZQC3iTrw5tDjAUgW7rJhtrptGO6Q3EtQv/yJuu6CK
Z/FCjGl3Z/hmWi8JwQ49X6WFaJqIG9z9RIc5SR83vzu8Fea8WImGtZahLDNdKZEe
UJQNuHPH+bRq97DiNXUtwbun4RZZLjBZ5qPWDtBkc2KguoolkAPeBYdV0FcGygyt
/uRQRXyPc613G8uvsE8U5h1zs1/uv+1ueJuTAbBi6N9o0doXvaeL2nqbmrM9Vvr1
QtER5cdtoimF7+4qYeR5jLdxFT7TApNaD+0qrBIPFI98QROVq0Bh73MjrP+vyyQ0
mXhpvQRtINJ356Y03PhfER7n+5tEkI5PRRAlv752u0kQkzVWlLTvgBOhcp34vqE+
5ibgpp2LD5+iC15arWqCtD7k6vHYF7Tpd6lDXyE5y52izzOAu5rWFgFKAJ4DUdUm
AKNjcdKQZpyi/pVX+lmpbikQTUkLpPYWwhJYRAXSp8zO3wO49dYpy6WH3lGw7q0V
GefCSnHE9T7OUXnKBUPE5mvP+0n3go8lIdgRR5XOFy1UoluFW6U=
=utA2
-----END PGP SIGNATURE-----

--5WOA92+W0p1Wi3PQ--
