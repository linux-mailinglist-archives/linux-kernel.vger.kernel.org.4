Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73986242BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKJNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiKJNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:01:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F38701BB;
        Thu, 10 Nov 2022 05:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BEA5B821AB;
        Thu, 10 Nov 2022 13:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE11C433D6;
        Thu, 10 Nov 2022 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668085293;
        bh=awwjva4KZ2j6QkTmvpKuu4ND/OJmD/rXZYyLj3sJfwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jm9tzOZcyJIRkxz7zAA+lg5GrAqQE5jY8nqiPAzzaitR7BL1dlyOn3R4o4DTpkube
         VKe6xwKP3LHcCNVnvG3OW4+VcDDhAluV0oaYk4v5Iw/tYJ7g5BK69aMrzpQWHsugRn
         kIgnnS79DTmx33sU6b+3kQvoqUl49qUFPIzqPmrjp1vYLXKjQBNt2++rQysPMSJkv4
         NDGpPk+kPNtvoTl6GT+5yTu8KrACOKvA19ux3Bx3+a65/7m9PsobskNEzXSZlFAHvU
         1q8tjQVf/owO2La1VNPfL2EOfASIk8tobrMF2tWMuiW4lMdQVmPUHtGbWDa9szj606
         Nb5j/pDAiraSg==
Date:   Thu, 10 Nov 2022 13:01:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Marc Zyngier <maz@kernel.org>, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        tglx@linutronix.de, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Message-ID: <Y2z2JwQaYS9N5A8x@sirena.org.uk>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-10-rf@opensource.cirrus.com>
 <87mt8zutib.wl-maz@kernel.org>
 <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9XagPH0CfsDB+cb"
Content-Disposition: inline
In-Reply-To: <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
X-Cookie: Torque is cheap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9XagPH0CfsDB+cb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2022 at 11:22:26AM +0000, Richard Fitzgerald wrote:
> On 10/11/2022 08:02, Marc Zyngier wrote:

> > belongs IMO to the MFD code.

> We did once put interrupt support in MFD for an older product line but
> the MFD maintainer doesn't like the MFD being a dumping-ground for
> random other functionality that have their own subsystems.

There's bits of this like logging the top level error interrupts that
seem like they clearly fit in the driver for the top level chip (SYSCLK
possibly in the audio driver, dunno if it gets used by other functions),
they're users of the interrupt controller rather than part of the
interrupt controller.

> >  It is also a direct copy of the existing
> > irq-madera.c code, duplicated for no obvious reason.

> It's not a duplicate. The register map of this device is different
> (different addressing, 32-bit registers not 16-bit)

Isn't that just a data difference which could be parameterised?

--s9XagPH0CfsDB+cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNs9iYACgkQJNaLcl1U
h9C6/gf9GfHmYBwIwz3hP4w+omdX4OnqxZu0y5L3ZYq/q7x3gRz+YHxA83Z+7rrN
1PEYL9nJmSYS1niCtRDCT3EDLrcoD5AX7Ouv7wc6m7cze4zQaLH8h92foGwPZd5u
AMo6jxPBMTOhL5+8LQfOTSJFOBuQEMb3i8rPWG7Sx+YeIseD1xWvoevpBPWYjjwW
zqpPB+lfEF9o+gmnrbyAXOGWsTxYoa7PjCQkSwrvzrDj7GLzHvVhmDKI8wrp+tSt
ldgt7y1VZfMUinAsmYl2PtPy8tLkfxDfd/NvFxZydwtBNbxo+EAcam7aOSWx1Wkv
g6zdzussbdiTH3+QlsfyUy9gKCnnbQ==
=dwPr
-----END PGP SIGNATURE-----

--s9XagPH0CfsDB+cb--
