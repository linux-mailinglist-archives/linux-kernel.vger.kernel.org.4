Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB24666954A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbjAMLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjAMLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:58 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30AD5BA26
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Vd9jhcP8uEUT5hmIk4rjX8e85onT
        P5WZD7k4yzlL92w=; b=CcDCgPv8aBaVmQ+gCP0YyTx/YB1kQ2Z8xUnrKOTP2tJ6
        rO8ptKXdCNFtIB13c5u7JhLeOcAVPYFD3D6j0osEPdr0BUdK1ln0dRA5G26IIJKX
        SzBDX93dK2cas7HI0+SwAREtu/HJZw3fQCAaWGiz1WVpvHjVIXBdTcotVzTvd8o=
Received: (qmail 1257272 invoked from network); 13 Jan 2023 12:10:28 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jan 2023 12:10:28 +0100
X-UD-Smtp-Session: l3s3148p1@oqPuRyPyHOlehh92
Date:   Fri, 13 Jan 2023 12:10:27 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Message-ID: <Y8E8IzJYqhTXLALE@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230113080550.1736-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdVw+fCqEewmY7BA4q0a=WAaDguaTChGKwUXFtWMCV8SaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qsBv+IE2hD/J6Qj2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVw+fCqEewmY7BA4q0a=WAaDguaTChGKwUXFtWMCV8SaQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qsBv+IE2hD/J6Qj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +       regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> > +                          RPCIF_PHYCNT_STRTIM(rpc->info->strtim),
> > +                          RPCIF_PHYCNT_STRTIM(rpc->info->strtim));
>=20
> I'm not sure this is guaranteed to work, as using rpc->info->strtim as
> the mask may not clear all bits (e.g. on R-Car M3-W it is 6, not 7), and
> the initial values of the bits are documented to be undefined.

Okay, thanks! I will fix this.


--qsBv+IE2hD/J6Qj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPBPB8ACgkQFA3kzBSg
KbZZQhAArUlOgri2MGsoj+3B32+aZBdhkUkaVqkxAvI6oTCEMJfMW2/xj6/Ulhvz
gnG7hT4b8wELAkjpUqRlyCDwVCfG1C/yQqBroaDOA5876cpIbeLIiYNdG69BPKxt
xk7JsDSWjKhChd3i+Ot98Is4n5gLN9bNjVBl/eeQzyTm6Jtjcu/k54mA7VmiG6ft
4TOWXKPqf91To7B0lGQkE/5C3FFx6hG/9Em8eJ+rbCtPWaZagEjlde6PSfLQ0DqK
dLaHrGGSCOW5xE6Y30LfQwofQGpHRNE/4XwbssRVGash5wtFjdp8SPO9nW75u+jl
2uenYR11QbZmN5ghow9VU5nKO6DgLgABpgMqPL0XQvgyh0dhJXVk8mDXccZSMGi+
b5D9YqxlI7vEujtGnJd4aPojxXJMAVihpAc7rdsjTWRiJK6sdwISZ5I5nes7WOwQ
JR2TNWuj5TYbNz3hLCWl5Z/lq9rKcWNM0j+wLJ8mE3X96G9VUneLXcFhbjjGH8pN
56RAH59wmtoJBHYmsjrYhcvwZOoGhxaohmr7mBL5ZXw1x48FcPsLQlA690XRWPnK
ruyjfYTxKnwDsyq3xtvOm/7CJt/HFrCi6hEnzxBW0bHEdcRm6BjBO/eAASmk5dq5
uIsrUGzbZSRKFB7uZhXRtZFnX7LAqlzts6dis2YQB8LyvM3/mrQ=
=/WdR
-----END PGP SIGNATURE-----

--qsBv+IE2hD/J6Qj2--
