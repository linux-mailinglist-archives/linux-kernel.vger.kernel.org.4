Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F22697DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBOOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:01:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A139311C4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46C96B81C17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A87C433D2;
        Wed, 15 Feb 2023 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676469690;
        bh=ih8cCmOjSaythxSzoNP7xozuV5Hz0UOWad2vgI/B9SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXqeBZFH2IPa6OhaJpK41x9/Oqs7m+oICw9diVJnIzx5ga5o6ejzZpX6S2FElIaVu
         YuDM40FxDEeuy23n9dkKzbPGakD62BDhg3ganlhA9DWNJMUgrVKkgi0isZ8OKM2W+J
         BN/KxV2HL2U5KEpcPyxKEksFoSXMkCdiiup6XrLtYyRlifmCPdZZpoGblptu9NKlph
         WhlL4CMGdwvgsu4c7GUcnLHzuravNuC8DJQ+vmLOPoxVatkmW3TEaz6ze9SNEoTmP8
         FLEe2XGVfRvC7WEPj1HJ0pGDKB5BKXyXVjEtR3ZbgY1nLtidReuaZu0S4zA+lH7gab
         AOZlpznLdfg1w==
Date:   Wed, 15 Feb 2023 14:01:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: max597x: Align for simple_mfd_i2c driver
Message-ID: <Y+zlt6tJajvtZ4uV@sirena.org.uk>
References: <20230214101321.1902855-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LRxVLZoKOD4t8DLc"
Content-Disposition: inline
In-Reply-To: <20230214101321.1902855-1-Naresh.Solanki@9elements.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LRxVLZoKOD4t8DLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2023 at 11:13:20AM +0100, Naresh Solanki wrote:

> +	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
> +		max597x->num_switches = MAX597x_TYPE_MAX5978;
> +	else
> +		max597x->num_switches = MAX597x_TYPE_MAX5970;

It looks like this will break if there's any more variants, it
looks like it should be checking each compatible in turn and
erroring out if nothing matches somehow.

--LRxVLZoKOD4t8DLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPs5bYACgkQJNaLcl1U
h9APZAf/dXGqapgnA06SUDV8KGsKQRB1DlZ53nDDBecz+FvM0bKiJtjsPFJX2Hke
bZBSigxBNeK4IbzYVNQoucuZu9rUODN6yGfPqI+kIX8IXJgKRK4gj7Rm25qNji/s
l3CMcmbb1RxYsHTUncVrRbjIPvNe8/VRstPa9OKEqYFVYAzoX+KrSdrD00AeNmT3
a0EVrdGJpWs1jqrqFb3+DKxPHFwNMK1KDPu2wJScrzkkpFekarWeF7CHFdzw7vF9
cMr9dBsHcDx+7KPJN3aCNc59ZaOU6BEy4PZNV+E05Ui9Ukpf0cJTq19xjBVf4JlL
c19EU4GitbO7HKUzlOtfk1qY+ySmgw==
=Zr8N
-----END PGP SIGNATURE-----

--LRxVLZoKOD4t8DLc--
