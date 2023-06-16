Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A5733C54
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjFPWQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbjFPWPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B44234
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77C8D616F0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA4AC6118A;
        Fri, 16 Jun 2023 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686953695;
        bh=k04vhcZhLCca2NoGhwp8fAqBR3ci3S4EksI7ub9lyDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeUZ9nts7QUi9Obvej4ffixWMjmmdi/3wBEHmjTB4mYTDHFk07YdmFWdgb+Qq1seU
         LgF9i9KPpALbhRciXVJoLsdER85btCz8s2gQmM5dZhDP2eR2zJZDVrJgTEtnriVJ23
         8yk6s0CgqX2We0SajNjGJN6iUWpQtXe8q7nJUL+QfsyDlYQmLN+LSBBVh9ydYx3cXc
         BBJswGwXBjbtCz0BpC28ZXmt8S3PPVvepNHSk3xs9zkDCq0X415/O3XzlQul8AoL21
         5AxbxlNJtUlqVT+Sd9IcC5zvqgZqpkWJw9TAEd8hf9s3xjt7xZdfjyTTVrDCDQAn9U
         2MKRF65mTJyGA==
Date:   Fri, 16 Jun 2023 23:14:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Jim Wylder <jwylder@google.com>,
        "Gerlach, Matthew" <matthew.gerlach@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] _regmap_raw_write() - divide-by-zero
Message-ID: <648e22d2-d455-4439-a00d-4042077a8571@sirena.org.uk>
References: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwEMVu4xz1Zyn/2k"
Content-Disposition: inline
In-Reply-To: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gwEMVu4xz1Zyn/2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2023 at 02:58:24PM -0700, Russ Weight wrote:

> The origination of the regmap->max_raw_write value is here:
> https://github.com/torvalds/linux/blob/4973ca29552864a7a047ab8a15611a585827412f/drivers/base/regmap/regmap-spi-avmm.c#L663
> > .max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,

> SPI_AVMM_VAL_SIZE is defined as 4, and MAX_WRITE_CNT is defined as 1

This should add in some headroom for the value too.

We should also fix the max_raw_write comments since it's a bit confusing
between users and buses, though AFAICT nothing outside the core ever
checks.

--gwEMVu4xz1Zyn/2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSM3toACgkQJNaLcl1U
h9DKUwf/VxfC6aUBtkIyK371Ly48kWOZX4QXncvQXzd8G5U3MVpb+uROTOuvt2r3
RNuJcteYuJsbMJW8mjMjCKoYBOaub2MhcEQpjPSm6kYOLtoeXLW4RW+C4uVtY0t5
pKBACXVqnUixcwg2S5TXG46iniIcMuSm2j/22v3MjcmvPBrvxc8iBsFv+Gh3t0/0
0SItfVEIhbL14JAak4/+75d9JUHyRhfT4pVTbgUeUXNdSOgpBIi++rVSSAUCx+qb
Z94R8M5fMpvLPb3FgNuDvYUmidDWBdUV0v9ON+Z3iyYrIPlwcSoXmvj1+4yank3i
xOwykLsU0sLas43sxJ3E9UekolbN2Q==
=5r2A
-----END PGP SIGNATURE-----

--gwEMVu4xz1Zyn/2k--
