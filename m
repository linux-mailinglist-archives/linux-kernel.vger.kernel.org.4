Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0060E108
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiJZMkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiJZMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27A33E34;
        Wed, 26 Oct 2022 05:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 792BCB8223A;
        Wed, 26 Oct 2022 12:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2527CC433C1;
        Wed, 26 Oct 2022 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666787997;
        bh=nZyuqLx+6uxbjW68/34pb1i0VYW3PxBvAZFlwinx2VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA7mHixe8OKOC6B+Xwxv6zB3L9nBWHSuxKyQbnYQnGc068pBk2NLmExadnS8jvpFo
         kAFP2G9+a0TFrLfZT4awiDBxsRa5XzHbsz4d7kXDhBENVbDdxHAqjTfSWIipjXRUxx
         DgKTOpfiDhsVUtq9NVrbg+0NjZlDTkXeZJyy+DQ2wHBhpMQ9F3megj3JNuMUSpAfIF
         89fpc8dBHpJWOzp94kfBIJMtQPCUkeU1X/yGhHBOvhrngrjq43f+bYZFIBecox87PJ
         2+EzaYcjhisEArVTBYaHCQENAgRwCkRk82amO+m32cmiP/2H96NYBxi+W7uoomdXo/
         z71VbjGFhVNVw==
Date:   Wed, 26 Oct 2022 13:39:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spicc: move wait completion in driver to take
 bursts delay in account
Message-ID: <Y1kql/WwAX+ZV8us@sirena.org.uk>
References: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OiPSywjFVb7KoiNF"
Content-Disposition: inline
In-Reply-To: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
X-Cookie: Prunes give you a run for your money.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OiPSywjFVb7KoiNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2022 at 09:58:28AM +0200, Neil Armstrong wrote:

> -		spi_finalize_current_transfer(spicc->master);
> +		complete(&spicc->done);

No, you need to call spi_finalize_current_transfer() - you need to block
inside the transfer function if you want to open code this stuff.

--OiPSywjFVb7KoiNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNZKpYACgkQJNaLcl1U
h9C2AAf+On8ZkqQcFewrYfuP8Ug1PJmIq/gmECvUtesQ18Y+vaANvc6kZTqPGAYL
H/WQkFsjFVQv+tEZLvFbisejDOcA9OL6Z4dnFsE+LFJdz/1typ5OySErgvOVco0N
+PqpGoRjI8gy6cy3vdSi2iNHBx70Xp5Nz7yLJayQyALu4+h6WWywuk1NL/dTJ9GJ
KSfIEbFcazcMZsPlzeyK6NCSoMZOf3ebU0VLqicsH9ONKjDoaBg9Zs1TZm4hcwlY
vWxnN/zejXyOcEfYYYb7JE6oxhv1LcifxtxDG08Vf0JcdR/DzbmUgjDppXZRZF9D
o6RTZ26fjdxtWwKIL3IaXI/1cXJWgQ==
=9Zpz
-----END PGP SIGNATURE-----

--OiPSywjFVb7KoiNF--
