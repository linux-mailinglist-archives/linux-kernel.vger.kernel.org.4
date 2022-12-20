Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A57651BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiLTHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiLTHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:34:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83A259;
        Mon, 19 Dec 2022 23:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E88261295;
        Tue, 20 Dec 2022 07:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA409C433D2;
        Tue, 20 Dec 2022 07:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671521682;
        bh=SKMTGuyR9554FXAyRA1M/fIfSE7/4Gt7RZF/9BPt6Cw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dCZXpIPtL0dB6yr7d3HMzMgJkVE9LMfEcGABEzn3ZGygCr+Nqklr6fbHFgV8g2Yv+
         GKoU4GWxg15VcoWV9OyiUj+6tJM5StECeug+nMgx6NcLiYxJxWbtFX4LsF6Kg2Ffbe
         1TGZOMzQzT/SRWYCX2DxBJSirw9kkz2MAo8kZgNpB+ISFR7GBHIqaKpTCzWZ6oaDgh
         nWNsHnvaYcBRM3zzJo3udZLLonwTsRxykkl8nUjCjzxnFgT4m0BbsezKvg5NBBFS9Z
         a17CzgGIUu7jou1HxNOdpl0FuDewGXLvO3YLM1ynIINmG5u+csZ1ngj/7wUmFOXAbT
         1mjmtFMOG+JRg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
In-Reply-To: <20221219191038.1973807-1-robh@kernel.org>
References: <20221219191038.1973807-1-robh@kernel.org>
Date:   Tue, 20 Dec 2022 09:34:27 +0200
Message-ID: <87edsua5q4.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Rob Herring <robh@kernel.org> writes:

> The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
> allowed by the schema:
>
> usb@fe900000: Unevaluated properties are not allowed ('power-domains' was=
 unexpected)
>
> Allow DWC3 nodes to have a single power-domains entry. We could instead
> move the power-domains property to the parent wrapper node, but the
> could be an ABI break (Linux shouldn't care). Also, we don't want to
> encourage the pattern of wrapper nodes just to define resources such as
> clocks, resets, power-domains, etc. when not necessary.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index 6d78048c4613..bcefd1c2410a 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -91,6 +91,9 @@ properties:
>          - usb2-phy
>          - usb3-phy
>=20=20
> +  power-domains:
> +    maxItems: 1

AFAICT this can be incorrect. Also, you could have Cc the dwc3
maintainer to get comments.

@Thinh, how many power rails does dwc3 need? I don't have access to a
databook anymore, but I have a vague memory that different parts of dwc3
could, potentially, be powered by completely separate supplies, no? Or
is that only the case for clock domains in dwc3?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEEg3wK/NVnD14JZqsmho6y4DXKpEQFAmOhZYMRHGJhbGJpQGtl
cm5lbC5vcmcACgkQho6y4DXKpEQIqA/9H58KYeua+8Pyj7k6pt7/Ib13Pe38UG2p
d19FS68TdSHctH947Qq126h+hpjanuLKzD4rBPWEoGw3gkC+CKAZhffv0dD6mr48
IroyOq9ApwHQ4qX7OvRN3f6gwxv3Ab9FvVT0fkcdiX4otdWs6OQku3Wa62hhHl2m
cgWD0iPrWgZb2TbWcC8r9eEbdFNvu+QEx728WqZuMxYNwUANjkptpwUEQgQyHw52
nwWASeFu4nl46/p2fOXmKYcFoCLDPDInteIGCg0U9SKFNIDpyKPZXlnfWNQJPLJC
4oaKORO6h3+aamKcE0b2yZq8o24R4FGx7XpwLJTH2OwnK/z30vwABL0vbvHNW8y6
0air/Db7AUkAxFpKcwtrze99LtoG5dvTpI7tHxLcCO/E5/UOg5WqzfsVXL6RCIM7
V11ZlteWaG+LGL2C88XzASTNR+vNUEUUiJv/3sheEYA9WDowoWnTtMGzUAsfq7LH
1KpHVXd0Yz+vgBNTkpRr1poxnneSCqLgoIs6z94s6WIdSc5Pl9gKIpx84a1dX8od
LJnhf9eEli91dn9jbM20aXabj/qi32UfE6w6e0FlFDXyLl8itHiqzqAfpm4w2voq
m75uXunv0FzPkMAIp10+5H0z8lpw8cvcNE+i+5gz8lnbEluJWQkelzttNMbN07TX
uJ6uSFoq2Hs=
=ufPS
-----END PGP SIGNATURE-----
--=-=-=--
