Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985CB74D921
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGJOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjGJOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED6F2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0330261035
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15635C433C8;
        Mon, 10 Jul 2023 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688999940;
        bh=AUlruH3s1wacsHeMRzmLofq6L9av9dgYHCn87VE1zBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Un2bMhIloarK/zblklrdZsD5OddgPIB58VWS4s0gCgu8NehHvAJOv6K/S1ZGscFC4
         YrI/FBuj/SEgj63bnERzMK0DLcaKUxBf9C/BXUab4MlLcCGFrmKy/n8fqMk6q8S8c5
         8KNI5qC8fPqrUYFIb5h72c40/q4OaKocsaGPOsOXBmtHtRx70Z0cgFeYDTwEySPb+d
         6jMLXc06UtIMv6SruqlUKjlE2TJFhPHIYfT4M6A37fTqu1tcXVdnStymQedXJFApq0
         IJKXYsUYWEdlMf40fFPKGj66JWHN6FPv/ighDfc+KYqlfR/TyPAMKu0gNiM+9FTTUw
         kSdiywdXKPBLw==
Date:   Mon, 10 Jul 2023 15:38:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Use spi_message_init_with_transfers()
Message-ID: <17de613f-c417-440e-95c6-3cf65607dc99@sirena.org.uk>
References: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hVQyu0NbCu39511e"
Content-Disposition: inline
In-Reply-To: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hVQyu0NbCu39511e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 05:23:35PM +0300, Andy Shevchenko wrote:

> @@ -66,10 +64,7 @@ static int regmap_spi_async_write(void *context,
>  	async->t[1].tx_buf =3D val;
>  	async->t[1].len =3D val_len;
> =20
> -	spi_message_init(&async->m);
> -	spi_message_add_tail(&async->t[0], &async->m);
> -	if (val)
> -		spi_message_add_tail(&async->t[1], &async->m);
> +	spi_message_init_with_transfers(&async->m, async->t, val ? 2 : 1);

I'm not sure this is a legibility win.

--hVQyu0NbCu39511e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsF/8ACgkQJNaLcl1U
h9BrIQgAhJOPNljoy+GT+bmy1TQQbzqkv6J/bzmW7OJjo3eG9T3dnfNWOxvlI9cP
TaUyFmL1O7KcdUhIn/RTo8sNdecixqdeVYjxgvJcwWrfrAaFSdRI5Q/36X3nQVfR
XR6xva6P/iaoycoybLwB7RIRKNJC9vuiUu/PK1jxrnOoMAxmd4jp7rAcUyGYyicu
BgeMuEHqqZEaMSnL5BqQ3YLO+fAEPZbvnEfQuE/fwIReIZD5hPeHKB1WM5PcywYL
nuMKazJAeuv1i9addfO7E5wyuwHJrE0V9GeE46/LY7C+zQJno6mH4qJOrytaxbk0
ASrGZliHpmze6V6MFQP/heYvE4IjeQ==
=7c8W
-----END PGP SIGNATURE-----

--hVQyu0NbCu39511e--
