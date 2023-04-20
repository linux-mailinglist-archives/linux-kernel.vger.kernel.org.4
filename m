Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010BF6E9411
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjDTMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjDTMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34D4695
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0269648F9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04FC433D2;
        Thu, 20 Apr 2023 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681993034;
        bh=AWchaTG+UcXDG8i93RYP6ezMkdSQ+n69w4ytZN/4d9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q383neQemC3dGB/wPLwIUalf7cwAqtwUZYrhbc5+ERjSeE7tQAIrZzHX3C+S0AhzU
         N9JCK4ZTYmk/udJjph9Osf7+QsIpnb4I1AdNt6UaDcBaCaSk/yVog749CThx+fg09K
         kdtGLz4/mPXfTlGpr+ss8Q3jruQL+L4v2MdETQ6pd77Qw+lY1FWSL7JO9ItTJaoCEf
         9b+sox0edDU8UtjHgZfGKlxhdZqPe4frq2lkhRkKFxj2UhddPOXKUxSajs7o67Aeyn
         06OeKdg7Opcl6u0aB3wvAM+c0DIz6YmJ8acHPjzGStJ38jj2N5h8TiMJgSItfRYSLf
         /+/PiYB8t4x5A==
Date:   Thu, 20 Apr 2023 13:17:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring
 constraints
Message-ID: <3eb854e2-8631-4f4e-aa00-d06236967f54@sirena.org.uk>
References: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
 <20230419-dynamic-vmon-v1-1-f48b7438e891@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o8NYCIMTUu5HWZln"
Content-Disposition: inline
In-Reply-To: <20230419-dynamic-vmon-v1-1-f48b7438e891@skidata.com>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o8NYCIMTUu5HWZln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2023 at 12:29:20PM +0200, Benjamin Bara wrote:

> Add constraints for regulator monitoring. These are useful when the
> state of the regulator might change during runtime, but the monitor
> state (in hardware) is not implicitly changed with the change of the
> regulator state or mode (in hardware).

> When used, the core takes care of handling the monitor state. This could
> ensure that a monitor does not stay active when its regulator is
> disabled.

Are these constraints (ie, board specific limits) or are these more just
properties of the regulator device?  It does feel useful to factor out
this stuff, but it's not clear to me that these are things that should
be configured on a per board basis.=20

> + * @mon_disable_during_reg_set: Monitor should be disabled before and en=
abled after the regulators'
> + *                              value is changed
> + * @mon_disable_during_reg_off: Monitor should be disabled before a regu=
lator disable and enabled
> + *                              after a regulator enable

> + * @mon_disable_pre_reg_idle: Monitor should be disabled before a switch=
 to MODE_IDLE
> + * @mon_disable_pre_reg_standby: Monitor should be disabled before a swi=
tch to MODE_STANDBY
> + * @mon_enable_post_reg_normal: Monitor should be enabled after a switch=
 to MODE_NORMAL
> + * @mon_enable_post_reg_fast: Monitor should be enabled after a switch t=
o MODE_FAST

These all sound like things where the regulator device is simply not
going to support having monitoring enabled when doing the relevant
actions no matter what situation we're in.  If that's the case we should
just have the regulator driver set things up.

For the modes might it be clearer to mark a set of modes as not
supporting monitoring?  I think that's the intended effect here.

--o8NYCIMTUu5HWZln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBLUQACgkQJNaLcl1U
h9CgrAf9Gxd6GRfrSwnDkfmBtiTCJSEN1RUFAfweMl34mvTUphU41+W1/6RzxXE+
x/GyDSqagwmzK3j0uCUkisZf+JUgSMTBlEA/2lThNners/YnQuDCROh/mTpygYHD
4vGrbbKn5+wyUoucX+qk6T7TPO37t2tRvSuhL6S1dHwz4t9wEoRgpDbAEjKtB1Ep
LW5JzKB/AX3oL54CsGw5hQA+Fn5xMkaA1vXZcqWgBaQ+38R0Vdecur3NaaC3U8He
4G9ASioqdprDfYMw47k7CfyAq0JGhzXO8DQhlQQUipNglqp9CnQbJuv8VJU0wMnQ
Ub7dHjSeGrVxZPGUeOsF7HWs3m6SXg==
=zpgz
-----END PGP SIGNATURE-----

--o8NYCIMTUu5HWZln--
