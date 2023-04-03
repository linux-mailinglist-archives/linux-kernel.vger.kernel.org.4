Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9657B6D5330
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjDCVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjDCVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1910C4;
        Mon,  3 Apr 2023 14:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5110C62B49;
        Mon,  3 Apr 2023 21:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9CFC433D2;
        Mon,  3 Apr 2023 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680556369;
        bh=iCh41tCJEiTL5kJB6L+K+Erci9/82HsLmf/I2b6bZlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ew6PlLhLzlc1ejJQKbYjjKCMriDMCCqkDzZ5sdfXfDTDnssV2w1v2RNR+CpVoHoh5
         i9m1E9IwmX66TrwNye2oztPt1Hjdo1rC7++4wvuWqN2wLTcK4VkYmhskfv524fuTbx
         CGmnOzrTos/54LS39YgRwWfworr0nAMKpXq4H5xOlTMM7Wy1Mbr7GOuqb8qvS0k6Na
         L5zyE7nfe4NMm9VfQDhljVxdBr2raavkezZw6/stdg58VtcHTEr8Fiwc9UquVNKcZS
         rkGgkG2HWW7Od3+eAaK5cnxpFnOTSU+NinnkKKcfNXRaKyJoOeQTS43gOXmnmsbCKO
         ZRBebhUlGhA/Q==
Date:   Mon, 3 Apr 2023 22:12:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <f4377c61-8745-477d-ab8f-f83de203c4b3@sirena.org.uk>
References: <cover.1679845842.git.william.gray@linaro.org>
 <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
 <ZCF9bdyefA/oDmdG@smile.fi.intel.com>
 <ZCmThuzUBYdp29UR@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bT3UYpp4c8gGNugV"
Content-Disposition: inline
In-Reply-To: <ZCmThuzUBYdp29UR@fedora>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bT3UYpp4c8gGNugV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 02, 2023 at 10:39:02AM -0400, William Breathitt Gray wrote:
> On Mon, Mar 27, 2023 at 02:26:37PM +0300, Andy Shevchenko wrote:
> > On Sun, Mar 26, 2023 at 12:25:59PM -0400, William Breathitt Gray wrote:

> > > +static const struct regmap_config ws16c48_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.reg_stride = 1,
> > > +	.val_bits = 8,
> > > +	.io_port = true,
> > > +	.max_register = 0xA,
> > > +	.wr_table = &ws16c48_wr_table,
> > > +	.rd_table = &ws16c48_rd_table,
> > > +	.volatile_table = &ws16c48_volatile_table,
> > > +	.cache_type = REGCACHE_FLAT,
> > > +};

> > Do we need regmap lock?

> We make regmap calls within an interrupt context in this driver so I
> think we need to disable the default regmap mutex locking behavior; I
> believe the current raw_spin_lock locking in this driver is enough to
> protect access.

The above doesn't configure the regmap locking so you'll have a spinlock
by default (MMIO being a fast bus).

--bT3UYpp4c8gGNugV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrQUsACgkQJNaLcl1U
h9CqqAf9FQjwis8MhjhP8nggcH+Uy1nBfbCZAZoBxcGt2KoVGlL02rn1j2xZvRq+
cDL4HypzWQ0kPMWd7emRcoerwa6YkDrvj3B3bC9zY1Gg+wjYWqe+EcFlMRRxbp6o
ZKa8ef0vj1Yk3aq54rHzXZf+2t5rxTe8bF84hDV2eq4lTbYQUGxCWh0Vf/yQkrBw
LAYJ1MoboaBVmerUKDuBmpZZeK6EjOVKPj4NK7XUOnAXtTEKms9w6jdzzi+FPjmm
ewdoceQ25lFQDwLJqMBvi2rFBlb5PChR1lxbL8JHp6M3TB4F5f8TQH/LY+hi50Ye
LgmaVHQSyamtrvPgChs/q/n6wZsqvg==
=zgHq
-----END PGP SIGNATURE-----

--bT3UYpp4c8gGNugV--
