Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE29562F3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiKRLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiKRLjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:39:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92548C78F;
        Fri, 18 Nov 2022 03:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 819CEB8233D;
        Fri, 18 Nov 2022 11:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1697C433D6;
        Fri, 18 Nov 2022 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668771550;
        bh=2pr+AWmfpVo7d6vKsaCOt0btyOHfwTUrK60YivL2bj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYF9k+d3yDBbqmNhd90BgPSJr6Qx3pQ3hm6JCvmP47Pgj+vP8V8oCbIMxtAXUrwpF
         jNRzDm3Yw9BbkY8W70goxrjBfN+ZKeGvQ14q5rikaxGe8pO9KWDbYKS4V8qq8I0kQm
         LV4LD90jgW7LIUf4OnL/NMTEh5Qg/K38LRGBS2f0YJBiaQym3lWWyscncNTZDXSE6m
         2RZUGtVfwTGIYc7sZCejTR6ifYwMGDwEDifAsiMFsM74yG5HdeEQtVtXzvSfiejU8k
         HXDH8lZIiCjVkBuugW1mDtj1bUsF+wR0rLh8eeI1wiAvt3ZNJZMaRU90uwu61H16c2
         wLVaeaDBz6Z8w==
Date:   Fri, 18 Nov 2022 11:39:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Socionext F_OSPI controller
 bindings
Message-ID: <Y3du24GWN/enGORf@sirena.org.uk>
References: <20221118005904.23557-1-hayashi.kunihiko@socionext.com>
 <20221118005904.23557-2-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y8IFLFxZiU6qsWM+"
Content-Disposition: inline
In-Reply-To: <20221118005904.23557-2-hayashi.kunihiko@socionext.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y8IFLFxZiU6qsWM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 09:59:03AM +0900, Kunihiko Hayashi wrote:

> +  socionext,cs-start-cycle:
> +  socionext,cs-end-cycle:
> +  socionext,cs-deassert-clk-cycle:

These are all generic SPI properties so we should add them
generically, on the device rather than the controller since this
is something that might vary per client device.  There was also a
core function spi_set_cs_timing() which was in earlier versions
and is about to get reintroduced.

> +  socionext,alternative-byte:
> +    description:
> +      Specify the extra bytes to transfer after address transfer.

This just doesn't seem like something the controller should be
worrying about, the device should just send whatever the device
needs sending. =20

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: the number of bytes to transfer
> +        maximum: 4
> +      - description: value to transfer
> +        default: 0
> +      - description: bit-width to transfer
> +        enum: [0, 1, 2, 4, 8]

This is also something SPI device should set up, as far as I can
tell this should be set vis spi_mem_op.dummy.nbytes.

> +  socionext,data-swap-2byte:
> +    description:
> +      Indicates swap byte order per 2-bytes.
> +    type: boolean

> +  socionext,data-swap-4byte:
> +    description:
> +      Indicates swap byte order per 4-bytes.
> +    type: boolean

Again these should be set by the device.  I think these should be
set based on a combination of bits per word and if the host is in
big endian or little endian mode.

--Y8IFLFxZiU6qsWM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3btoACgkQJNaLcl1U
h9DLcAf8DxL3lerA0yvy4gW5AZbaPmw4k8GgnxVbNQ3TanRwM/ctfTINzD93T/1z
WwYp6kkKjjSqsooNiUcRJ624aTcu8TlhJ4nWBupfWNknspjZ19Mkkt5ex5xHHrHG
CQCNvYBIrI8SD8k0mGDh3N5BX40WphA0inpq6XuAE2D4KHVxifO05o0jDh/0BFmM
rwqtpPnh/7qS22s3X+KqbRC1GgXrWgWjyMemeAUKmSADWW1Ov5oSRNV9qUpfdCTE
BoUuTaHy9TqhQ+CgxP52YOiHExWJquEbbvU++63Ea027xIAY89lVH1s+cEsLJ89d
fXnp01fF06jCgneSQsTC9Ob5rNIBfA==
=UA+E
-----END PGP SIGNATURE-----

--Y8IFLFxZiU6qsWM+--
