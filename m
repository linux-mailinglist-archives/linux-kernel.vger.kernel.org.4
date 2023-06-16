Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3373973340D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjFPO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFPO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1676730DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F8C562DC1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73531C433C8;
        Fri, 16 Jun 2023 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686927550;
        bh=ouesFuuU+y0Nvn7B/3cjuuMqNQ+7Jz9OIgReBwjtmnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVvupX0Mhe8XEIF2EqILhm9enJ7MK/A4hXQrN8N+O/fKkWnpKXxRbuDCAybnPlWVE
         UosKsEJgUDE8EnqEYwiWhuy8vsoVdetOhpNSSSUGg4bf4f9A23svvGboeU6e8cCe7M
         MfucQG6fjlucX4HaiU1IOOfo+zBt1nORKlFXuZetiokJgKfDQuGUE56dFg9C5fAXsR
         k4+4GTyol9VIio0YAR8f5X/SHyhtnQxWuXD5jd14KjcgpYvRyppQ/p43fqnQ2SbZ6M
         P0XHDOwJPpXBKIFUiTRJh7t/x84DkPbI/zvth9rqZtcujLX4AzERnTMs6MalgdOxi5
         1O9XG5eXQERTw==
Date:   Fri, 16 Jun 2023 15:59:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: da9063: fix null pointer deref with partial
 DT config
Message-ID: <49ba8434-f16e-415a-9059-1af532854cb0@sirena.org.uk>
References: <20230616143736.2946173-1-martin.fuzzey@flowbird.group>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G7fWAiFF1Z1ENwIb"
Content-Disposition: inline
In-Reply-To: <20230616143736.2946173-1-martin.fuzzey@flowbird.group>
X-Cookie: P-K4
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G7fWAiFF1Z1ENwIb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 04:36:28PM +0200, Martin Fuzzey wrote:

>  	const struct notification_limit *uv_l =3D &constr->under_voltage_limits;
>  	const struct notification_limit *ov_l =3D &constr->over_voltage_limits;
> =20
> +	if (!config->init_data) /* No config in DT, pointers will be invalid */
> +		return 0;
> +

We already dereferenced above when we were initialising the variables,
the compiler might still generate dereferences before it does the checks
here.

>  	/* make sure that only one severity is used to clarify if unchanged, en=
abled or disabled */
>  	if ((!!uv_l->prot + !!uv_l->err + !!uv_l->warn) > 1) {
>  		dev_err(config->dev, "%s: at most one voltage monitoring severity allo=
wed!\n",
> --=20
> 2.25.1
>=20

--G7fWAiFF1Z1ENwIb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSMeLkACgkQJNaLcl1U
h9ARsAf/WXcWbB5wGqNklpDm3RFefRMp0Gw0WHwRklLY2iZf8u2D7MEevfYB6rVu
g2fG5MPw8Bz1EyABS4NmVLBbqd/7spjvuSvSgfCCAjeHiCtE8OjuylZJdl/ZN/Du
3otyM9JhTO2sBIkFW7OEfCZ2vDiPUP5zUrcrgFu/1Gh8pB3Hz9KQqnA09anoBewW
8KseAkv+yM6t2YquHD2Q0ymAFznlf799VtKTMRJ6RUQdVdxUYh2tKu3NEyaAGa+R
Jbv3uYYP8vL5z0+w7uGJokBNODaTs7seg0OYdEZGGXo658VG1qF+IKAHYIIzEyfg
vTbiL2xiv9MRmuwgcp0rnihyO+hgcQ==
=XvwL
-----END PGP SIGNATURE-----

--G7fWAiFF1Z1ENwIb--
