Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F486D54B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjDCWZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDCWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADA1981;
        Mon,  3 Apr 2023 15:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A84862D76;
        Mon,  3 Apr 2023 22:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72485C433D2;
        Mon,  3 Apr 2023 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680560711;
        bh=M73AMS5BwKeTmwi/9PJcYG6M2ePZILRcLIk8rH1ZvFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ3jx736A/0X+YL4DxJIsHNpk5G+BF0gp0gO6TUEy/8/kUX4Z0F7iub9xZE1hzSqc
         3T79dvOYTqotoHAg+a19RdUNOoUG4i+DW/Ie2hh6KRplnTvneoxDz/LkLij/rLIHXD
         XW/di0pVOd2Vcv/H65O0O+Nmnwg9i1+gWCBSrC7JGyNYyOr1eW94chPOM8yNXf3EAc
         Yflgr7vI8fBZsDHR/u9JF02stsd36zJcjvUSzD89WS0Hm7T2Q7qDqZ9Ftq72zJDFDf
         WqvDnnwje3LIATLZbT+D97XlU84Y2NS1YQ7DgKRu+ET6irk2M0+QR3L+wTx0CGLErt
         l29W8UFF85ubg==
Date:   Mon, 3 Apr 2023 23:25:06 +0100
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
Message-ID: <6399e7d7-d748-4b97-bf60-99df2b29ed70@sirena.org.uk>
References: <cover.1679845842.git.william.gray@linaro.org>
 <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
 <ZCF9bdyefA/oDmdG@smile.fi.intel.com>
 <ZCmThuzUBYdp29UR@fedora>
 <f4377c61-8745-477d-ab8f-f83de203c4b3@sirena.org.uk>
 <ZCtRSFLL5lkDimeL@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sv+xHyJ36IYkfZiO"
Content-Disposition: inline
In-Reply-To: <ZCtRSFLL5lkDimeL@fedora>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sv+xHyJ36IYkfZiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 06:20:56PM -0400, William Breathitt Gray wrote:
> On Mon, Apr 03, 2023 at 10:12:44PM +0100, Mark Brown wrote:

> > The above doesn't configure the regmap locking so you'll have a spinlock
> > by default (MMIO being a fast bus).

> You're right, it'll be a spinlock in this case and not mutex.
> Unfortunately, we'll still need to change that to avoid deadlocks on -rt
> kernels [0].

My point is that you haven't actually done that.

--sv+xHyJ36IYkfZiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrUkEACgkQJNaLcl1U
h9BFMAf+O8kaWMCMbhmR1VbGcD4oDysUOhfoV4ELldcgp6x1nYZORLtwmDyRFrzs
urrnSh8OM/0w2IRuk7BqEuFjqoBR9+fUw++pkYZUiL5Jaels9UuXqROcOEod+RvF
RD3gkk+CCrFeZ17b9BJWxOP4cFNCmo+Nxz1L6C5eOWtzHolYg1gg3kgsOpYTaavq
tnikBH2pkXfNb63WgtiRhpGQbchiIrO1YM/vYsCCcIycecGpPkylmgDRSxakSdVc
UkKugCIqWbdC8OLZpLZ763nSgLVAP5y1V6Q1Moph2Cw/IMMp17amfUx1Ur78/u9v
H8exqABCpP7Cp0bTRzFxDXgfcqbHmA==
=0LB9
-----END PGP SIGNATURE-----

--sv+xHyJ36IYkfZiO--
