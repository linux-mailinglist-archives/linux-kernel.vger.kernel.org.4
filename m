Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC973020F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbjFNOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbjFNOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1B1FEB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2ED642FB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40F8C433C0;
        Wed, 14 Jun 2023 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686753217;
        bh=9JzPa89SLgIYVcS1sGIoucw35T80NHDyFD8jVqjaO84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rw95WW1EHfYHjKaG2yfP6Fhjnudx3/HesaE+XxOg8iI3uE4p6GPvc1Y1fYpBq3o97
         G2f52wAIAOhXWYKzQ0q8HnpOlFfukUY2zJstDLOBbGWGVnP4EuKVbQzhwpEHyAmlIL
         EfpWYbOebIOT/52KbGrCnw4TMataU2ktTE6af0ovMij+uvk2ovMhN6dn8RPEMvhL9a
         PvS3F8UGUn/lZzMtvp7zv9uDq9jcw4etaLqWM+3yP5GPmWz0P391/cSVvZOSit7YoV
         h9qwBE3NqHDFhJzjjLyvBsNl1AERPFJ2KqVkfKiHSlCi7jSfBqOSn8RktdeBUFPQzD
         tld/ocbS5cx6Q==
Date:   Wed, 14 Jun 2023 15:33:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:base:Fix unsigned compared with less than zero
Message-ID: <20230614-passcode-stimulate-70eecb6d81d2@spud>
References: <20230614133549.3774-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GrdvnB76oexuJXKF"
Content-Disposition: inline
In-Reply-To: <20230614133549.3774-1-machel@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GrdvnB76oexuJXKF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jun 14, 2023 at 09:35:36PM +0800, Wang Ming wrote:
> The return value of the of_count_cache_leaves() is long.
> However, the return value is being assigned to an unsigned
> long variable 'leaves',so making 'leaves' to long.

But you actually made it an int?

> silence the warning:
> ./drivers/base/cacheinfo.c:300:5-11: WARNING: Unsigned expression
> compared with zero: leaves > 0

I'm dumb, why is comparing an unsigned value with zero a problem in and
of itself? Zero is a valid value for an unsigned type, no?

If you actually look at the function, it only returns positive, non-zero
values anyway, so returning an int is a bit pointless, as are the
checks, no?

>=20
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/base/cacheinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index cbae8be1f..7280d5cb3 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -289,7 +289,8 @@ int init_of_cache_level(unsigned int cpu)
>         struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>         struct device_node *np =3D of_cpu_device_node_get(cpu);
>         struct device_node *prev =3D NULL;
> -       unsigned int levels =3D 0, leaves, level;
> +       unsigned int levels =3D 0, level;
> +       int leaves;
>=20
>         if (!of_check_cache_nodes(np)) {
>                 of_node_put(np);
> --
> 2.25.1
>=20
>=20
> ________________________________
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=
=E5=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=
=E6=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=
=8C=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=
=A8=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=
=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=
=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=
=AD=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=
=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=
=99=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=
=E7=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=
=BA=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=
=81=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=
=E5=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
> The contents of this message and any attachments may contain confidential=
 and/or privileged information and are intended exclusively for the address=
ee(s). If you are not the intended recipient of this message or their agent=
, please note that any use, dissemination, copying, or storage of this mess=
age or its attachments is not allowed. If you receive this message in error=
, please notify the sender by reply the message or phone and delete this me=
ssage, any attachments and any copies immediately.
^^^
Gotta sort this out chief, I should probably be deleting this, not
replying to it...

--GrdvnB76oexuJXKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZInPugAKCRB4tDGHoIJi
0qHhAQCF3VK8khEDmkbzs/mDiL8+1OvFsNsMWO5JQwgz7iDiQAEAiD8SMvHgXspd
s9g8hBqNd6oqgle2HMRNAuzEB0q5eAM=
=zSRU
-----END PGP SIGNATURE-----

--GrdvnB76oexuJXKF--
