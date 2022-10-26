Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6421F60E099
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiJZMZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiJZMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:25:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D3A42AF8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB877B82245
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF8C433D6;
        Wed, 26 Oct 2022 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666787146;
        bh=A+whfoCaFetY1vtT6WlJoMJ4i5r7wnLO8PHUEzY3Stc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/Bq2vQbnuOvSTVGNxl7QsdwtUxRdyot1GJzSX65QKkfbc81j5sPS5yKb+nUVdB/w
         +Hri1yiBG0MVhxS5bGQ/Q0aOrvJav+c5+Zi10V1jqPo+pVb0pI52Tqu/1qzy7sdhLo
         zUeaeflH4Woj2fYk696WdQan4FMMhX1yVoJ21S6cdcItiuGpLdiYwPkhmmkCbhYw1Y
         ga89Lp+TrD6iKhvbHWwVCgEH8kOpCKALem/cYxw/fXG8EPBaQJz3N1wqP/+sKadBzM
         3SUrFzvxpl2DBlJ/MZtZfKgg9M11dBQx0ri1yjE7cXl9A2koNiiBpa7Yevaf5HuFme
         O5w9OHYUXzHYw==
Date:   Wed, 26 Oct 2022 13:25:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     wangkailong@jari.cn, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, motolav@gmail.com, cezary.rojewski@intel.com,
        mkumard@nvidia.com, pierre-louis.bossart@linux.intel.com,
        kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA/ASoC: replace ternary operator with min()
Message-ID: <Y1knRM2jU8RhlFWn@sirena.org.uk>
References: <3d74bcaf.5.1840fa4d439.Coremail.wangkailong@jari.cn>
 <Y1gWbN2/Tbf1jeL6@sirena.org.uk>
 <87pmefp30l.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/5KUVHpwyY0+WZIc"
Content-Disposition: inline
In-Reply-To: <87pmefp30l.wl-tiwai@suse.de>
X-Cookie: Prunes give you a run for your money.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/5KUVHpwyY0+WZIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2022 at 07:28:26AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Oct 25, 2022 at 10:56:11PM +0800, wangkailong@jari.cn wrote:

> > > sound/soc/soc-ops.c:817: WARNING opportunity for min()

> > >  	kfree(uctl);
> > > -	return err < 0 ? err : 0;
> > > +	return min(err, 0);

> > I don't think this is a good warning, while I'm no big fan of the
> > ternery operator the new code is less clear about the intent than the
> > old code.

> Agreed.  That use of ternery is a standard idiom.

> If we have to eliminate the use of ternery inevitably, it'd be better
> to introduce a new macro for clarity instead.

It looks like it's more about identifying a pattern that could be min()
but not being able to detect the semantics of why we're comparing
numbers.

--/5KUVHpwyY0+WZIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNZJ0MACgkQJNaLcl1U
h9Cwbwf/cqlYQWULu7hIA0A7lorD8guPrIuX+zs6vfL42K2W71v4HfBL55hL02ze
IFf6fLe1AQfEchrw3IgotczAWpAuV2MqC/3G6aIbNRvUbNYXAhqAYgv6EyhqBsgr
mQgrSSAJfuyvKz53WHelaZCq3+1RphQfoo9VvqHV8gaOUZbBG8uiAa8QR3pdL7aI
X5sR3++SzqL8P4MOgqyX4RuHtyky8FZrbfaQdgJTCTtVK1KivnaXJoCK8x+DRDVi
MyEceA1L5oBuDhIV50ck1cmartnxVSnDqYT3wVfRd9DrZ338QQ620a7CkDg8szrV
7wAi618RzollohwVIGPkuXsi7eIu0g==
=jtm0
-----END PGP SIGNATURE-----

--/5KUVHpwyY0+WZIc--
