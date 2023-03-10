Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F46B3FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCJNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCJNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:02:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255010DE69
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56FE1B8228F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818B0C433D2;
        Fri, 10 Mar 2023 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678453329;
        bh=NULlRWZNm9leedzyrH5BhHNX7AaSEb80UKoFaAjvj20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/Bm07hoD1hApEGRqrgTuXXzpBaxfjMaGiy20k/OB8hpNuOdcmb5TMYleTIJ+Kl1N
         R408glBy0SMdkmGSU59KdyqTAwMXCUuiu5VTwTS4Yio0jENiapg1CMOV+n6d2x+HEe
         LY9Xt3czoa2iHwRzIPkX0IEQmOTi/1/NGbKk0u2ABNWRxdi+6Za25cNwjRpnB6il+k
         6VCp8KEndJlGOBtUgezrKf3WWgGQJTU3an7V78/KLcreTuu4CKPadcIkUhCixnW+Vg
         SU74ke8iK/ZKgFqw2hrPEoN6vJ+ZUs872OrMGzsMRWtunZnhNVYuGXyUUzmKFxOx1k
         i9lyy2gHbN47g==
Date:   Fri, 10 Mar 2023 13:02:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: cache: Do not panic for REGCACHE_NONE regmap
Message-ID: <ZAsqVf8/C3lHOF8W@sirena.org.uk>
References: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyppB7n71no1RLEi"
Content-Disposition: inline
In-Reply-To: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyppB7n71no1RLEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 10, 2023 at 08:39:10AM +0100, Alexander Stein wrote:
> Most regcache operations do check for REGCACHE_NONE, before ensuring
> doing BUG_ON(!map->cache_ops). The missing regcache_sync* functions
> panic on REGCACHE_NONE regmaps instead. Add an early return for non-cached
> ones.

Why would we be trying to do a regcache_sync() on a device with
no cache?

--oyppB7n71no1RLEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQLKlQACgkQJNaLcl1U
h9CFfQf7BPlAaUA3obz8xBsCdO34dR9E/Ek767pi/tfvLgrxo4lrKFqOmq4B0zwt
NwChbMMJ+tPk1RDnO9h7u18FE3kU9OzsAH3XKrKD4zDtYoz8cAhfNMUkVicA8NeQ
068vL3zjRyEk9v5ibqr8nuIHlL6UXN+bAnE+Sb8u/lUasafbDBva/cfR5a6/c73U
ARhj/CxIHYAdoD7YOURZLUg2MCf8WU2Ma/gdKL7EELkdr4CL1NOWwq8Ay9L2qWS3
E0CktmeevKUhV7KgeADbNZD/g32RFfmLZTHXGEw8vtDH1eCUHWUywooMKkF9s5XD
K1kHWrwtFtQFBwcVpwv+7KDhjhw5pQ==
=V5aL
-----END PGP SIGNATURE-----

--oyppB7n71no1RLEi--
