Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCF6D33EB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDAUvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDAUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0A27804;
        Sat,  1 Apr 2023 13:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C101E60FC8;
        Sat,  1 Apr 2023 20:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83A1C433EF;
        Sat,  1 Apr 2023 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680382251;
        bh=cblNPwspiLiu6TBVBEScNWqtn9HgaLDxVomWxXoSOWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2Xsf7OmDrvxKOnaV1o2olTZD/+xO24c1NxVVjgi4tY54cdvVXRkP8hJX46e8UoKN
         vHFfU3gTbKbx1gzg/9ZYBwKR77EFvO/bE9X5mbcwTnp5Xav6jrPMbaxht6AO6eYeeU
         8uZ8Q6WVgufuMawepfUsnfuH+0iPYWMfn+pjTVn+FOP5n6swmE7RwLL05Fp4hH719s
         trz6qOMwQ7pEP0BXeCulcHfwhx2FbZDit9dRQgxqa4X+m6eps5Cu7fkyEs8Jd/kMXl
         yBu1tZ0WR2yiKZf80HCi8SKkX8C0Q74lFP4zMMEs70FtCI4Ykck7/2RopRFMfOCEyW
         HPxAvf8S4LXqQ==
Date:   Sat, 1 Apr 2023 21:50:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v15 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <0b91dee7-6c1d-4a33-8235-8fd5d58b200e@spud>
References: <20230330071203.286972-1-conor.dooley@microchip.com>
 <20230330071203.286972-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WqrHL50fzIiM0DjG"
Content-Disposition: inline
In-Reply-To: <20230330071203.286972-2-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WqrHL50fzIiM0DjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 08:12:03AM +0100, Conor Dooley wrote:

> +	/*
> +	 * Because 0xff is not a permitted value some error will seep into the
> +	 * calculation of prescale as prescale grows. Specifically, this error
> +	 * occurs where the remainder of the prescale calculation is less than
> +	 * prescale.
> +	 * For small values of prescale, only a handful of values will need
> +	 * correction, but overall this applies to almost half of the valid
> +	 * values for tmp.
> +	 *
> +	 * To keep the algorithm's decision making consistent, this case is
> +	 * checked for and the simple solution is to, in these cases,
> +	 * decrement prescale and check that the resulting value of period_steps
> +	 * is valid.
> +	 *
> +	 * period_steps can be computed from prescale:
> +	 *                      period * clk_rate
> +	 * period_steps = ----------------------------- - 1
> +	 *                NSEC_PER_SEC * (prescale + 1)
> +	 *
> +	 */
> +	if (tmp % (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) < *prescale) {

Hmm, looks like 32-bit doesn't like this modulus.
I pushed things out for LKP to test before sending as I felt I'd not be
allowed to do that operation, but got a build success email from it.
I'm not sure why the mail wasn't sent as a reply to this, but
<202304020410.A86IBNES-lkp@intel.com> complains:
pwm-microchip-core.c:(.text+0x20a): undefined reference to `__aeabi_uldivmod'

I know that tmp < 65536 at this point, so if the general approach is
fine, I can always cast it to a non 64-bit type without losing any
information.

> +		u16 smaller_prescale = *prescale - 1;
> +
> +		*period_steps = div_u64(tmp, smaller_prescale + 1) - 1;
> +		if (*period_steps < 255) {
> +			*prescale = smaller_prescale;
> +
> +			return 0;
> +		}
> +	}

--WqrHL50fzIiM0DjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCiZJwAKCRB4tDGHoIJi
0iJlAQCB2UJl++XV4NMR+7ECnWEx79RdqD/XDFZb1Ug8Y9BRwwEAvSU+APt+rIRQ
PbPJgMxFUNyTzMFYCMWtE6d2M3dPCQ8=
=v2Y6
-----END PGP SIGNATURE-----

--WqrHL50fzIiM0DjG--
