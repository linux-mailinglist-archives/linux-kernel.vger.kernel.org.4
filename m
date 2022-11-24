Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B36377CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKXLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKXLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:40:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E46AEF9;
        Thu, 24 Nov 2022 03:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F682B82778;
        Thu, 24 Nov 2022 11:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800CDC433C1;
        Thu, 24 Nov 2022 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669290024;
        bh=TBn0RNcelWmqvYoM8hMiG6Tfvt98UQIoRIopdlhRgKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YP6ptEpMtdPIBcQnl99n/7Vdh0ipzZ4mlxVgFkfBBYWAo7ov0DJJ7rwrA3KQ5zyLE
         9TrD/MnZGp4X+SgW0ENHF1uh193tDTchJk2QW6cZZF/ita9u8WD2q6oX+yfClfocf+
         5bcFAysVReM/yLIfp6S0PL0L65IRQklxNeS54dCqGaJ6ZLZ4gHrbDMFeN/BAURETOB
         8GYIYMGK83VB8Bvp3UubqKD52rlkHBayqFCrOLTCcTqc3p0WPZjofMVwtLzsYdWGsq
         Q6kn/SqglZfplHmdlDm0SBd6Q9aXP67c3M1hCOE8DXurP/ly2uQra+y8gyxksO5Su4
         rY0uBMCfVuy2w==
Date:   Thu, 24 Nov 2022 11:40:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: Add upper limit safety check to
 baudrate divisor
Message-ID: <Y39YJL02jFbkEMqw@sirena.org.uk>
References: <20221123211705.126900-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WHJEcvMfHxPPGIv1"
Content-Disposition: inline
In-Reply-To: <20221123211705.126900-1-nathan.morrison@timesys.com>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WHJEcvMfHxPPGIv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2022 at 04:17:05PM -0500, Nathan Barrett-Morrison wrote:

> +	/* Maximum baud divisor */
> +	if (div > CQSPI_REG_CONFIG_BAUD_MASK)
> +		div = CQSPI_REG_CONFIG_BAUD_MASK;

This will fix the overflow of the divisor but it means that we'll be
generating a faster clock than the device asked for which might lead to
problems.  We should at the very least warn, though returning an error
would be safer.  Ideally we'd be able to adjust the input clock to the
SPI controller to allow us to divide out an appropriate clock but that's
more disruptive.

--WHJEcvMfHxPPGIv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/WCMACgkQJNaLcl1U
h9DLQQf7BYaqpOqZQBXQ+2a9j8pyBEOgEtmqx558VbuNBR5FpSMMPhxwN6H+DZNg
MP2a0vHUw6KP3CejM+YqBz451NuSJo4Doo2H61jPRpal7cRVs0ccK4aqelvZfMKo
fU/fLdMJVWGvkmuc2YirOAy5s7d9kImX28VjavehgTVkcYggomwagkQfS90DOAkd
W9wUdQYF6s6syWo6FeEBlF+dcnOaYpgnXx2I6bPga3+Hic63oCGfzMvIuJfjoeQT
ZvRBBe+YxIq8Fblc2xHza4yhGI4ijXPDxa3RNrbEiZsnaMgoK9ZQtsB3tYr0MTiz
2KFWXpoAt51iKRBzHqt2m9KPEyVVAQ==
=bu/+
-----END PGP SIGNATURE-----

--WHJEcvMfHxPPGIv1--
