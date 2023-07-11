Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9274FAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGKWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815319B;
        Tue, 11 Jul 2023 15:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E1961615;
        Tue, 11 Jul 2023 22:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C47C433C7;
        Tue, 11 Jul 2023 22:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689114306;
        bh=mUZcNNX6rPX3DbQWIrh0EjiKAVMx3ZDFG6/Tg0vDG4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBnrxk9Jc4IAuAYCVs5Pfozc51OiK4niqnS5CtC2hPFlOBBndbfWZvNctV8Yad3tm
         YsnvCslxHEmDrLhWQuOWHO4LF1/Q+TqA3N90QLT0AZ729iOWt8uFiZtsvVkaxqz0+O
         wlLtkAmboRh4lMcfGGLDrc0zUPE0q/p+2r2Uq3B23Wss1usG4QQNr15nBL2+94b5Lt
         cDvj2XDUynhzmunWGSeixwqx7/8v8hUvCBdmaNFKyT15Yr/WImbkTZz21F0KghpV1H
         nvV0oS13lJvD7PhC4QW/00MAwpoFb90a6s+sfkkwzvQb9AmfblowqWIJZXprWHCB03
         tuZQ/Vy3/u8dg==
Date:   Tue, 11 Jul 2023 23:24:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regmap-irq: Fix out-of-bounds access when allocating
 config buffers
Message-ID: <fde7ae5c-fbda-4c73-84c0-2f8f9750fce1@sirena.org.uk>
References: <20230711193059.2480971-1-isaacmanjarres@google.com>
 <8e5fba54-9ec7-45a7-8dd6-6ea63d853907@sirena.org.uk>
 <ZK3TiuPZr0A8iaNN@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gzaPP50+HENqazNt"
Content-Disposition: inline
In-Reply-To: <ZK3TiuPZr0A8iaNN@google.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gzaPP50+HENqazNt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 03:11:22PM -0700, Isaac Manjarres wrote:
> On Tue, Jul 11, 2023 at 08:50:08PM +0100, Mark Brown wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative (it often is
> > for search engines if nothing else) then it's usually better to pull out
> > the relevant sections.

> Thanks for your feedback. I'll go ahead and send out a new version of
> the patch with a trimmed down commit message.

It's OK, I did some local edits myself.

--gzaPP50+HENqazNt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSt1roACgkQJNaLcl1U
h9Cyhwf9EIzOj3Yc3CgjinwIjM28rhxXzMvmXfAjh5uM1PbV+QDfRFkvt0DQI4ki
442V55zZzji7mIegMF0cHZsTJVvedp2+xBvEZ4fjjH8m6PlFuv1tVAbd9/vn6SRi
rHJuVaOF9f1KcTB04NwPcVlRNvN4R8X8crPatGoIX0rHr1W58d+HSNPjv4eleelU
OsYbZLHReHPdbft14S7g9sMu71HHkAAqDYh+ZQN2gEC0rL+reiu9O83dtvBJ/7vr
o7lcwZQMEsCt31IrjrlLimX7hkXPXKV10BwP3HM0x77kzw7KopEV3lRZbsvB8Bv1
hIWap+yI0Nn7A9+YhoSRPO2WObROzQ==
=9Tt9
-----END PGP SIGNATURE-----

--gzaPP50+HENqazNt--
