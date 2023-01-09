Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F79663066
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbjAITcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbjAITbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:31:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79A58819;
        Mon,  9 Jan 2023 11:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BA14CE117E;
        Mon,  9 Jan 2023 19:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513C2C433D2;
        Mon,  9 Jan 2023 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673292684;
        bh=voMOK2gL2nh7msuzNJyPVNbAzEjPsrpJDCO0l7BH3Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMNALv1YHlw3vp7QhbbGLlx5CEImDvKp59DkcDG/AUOwQ+LPQBJSBrMMZuhzKuuAV
         8uu1ZSO3uxkz9CeeQ5xCchHcVLra6tWqHtl3qAFQ3omZUF+ABtB7devWj+0kfqPvCC
         klmTnND+vEmx0EF/nDJZUgKWI6XfOJchrBo7iRFZzeDbsB9BJxUKVHIV7SD46ITCLW
         vzsxY7A9wcHzUKxXfiOWkHT7+BWYCokCjzwm6Bz2/I5OaiMUq773Gkmvyag14YyfZg
         c8ZxMiZ8WfET2g0HjjSsUfu6IY1ocU4GnDQocDGIDcc2XvOnmdXySu6/yiTxtwtXwq
         6UhDQEXM2oZlQ==
Date:   Mon, 9 Jan 2023 19:31:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
Message-ID: <Y7xrhjhhY3g5DE25@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-12-william.zhang@broadcom.com>
 <Y7iaEOBP4TRBoDYy@sirena.org.uk>
 <88534207-6b1c-75c1-26a1-be88a19eeecb@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yBS0HA2Gard2IIBC"
Content-Disposition: inline
In-Reply-To: <88534207-6b1c-75c1-26a1-be88a19eeecb@broadcom.com>
X-Cookie: Editing is a rewording activity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yBS0HA2Gard2IIBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 07:52:35PM -0800, William Zhang wrote:
> On 01/06/2023 02:00 PM, Mark Brown wrote:
> > On Fri, Jan 06, 2023 at 12:08:03PM -0800, William Zhang wrote:

> > > Multiple transfers within a SPI message may be combined into one
> > > transfer to the controller using its prepend feature. A SPI message is
> > > prependable only if the following are all true:
> > >    * One or more half duplex write transfer
> > >    * Optional full duplex read/write at the end
> > >    * No delay and cs_change between transfers

> > There is nothing driver specific here, this should be implemented in the
> > core - we have existing logic to rewrite messages to match driver
> > constraints, this could be added there possibly with flags to allow
> > drivers to disable or enable the merging if they've got special
> > requirements.

> My understanding of combining the spi transfer in the core level does not
> quite work out to our controller.  For example, for a spi message with three
> transfers, tx, tx and rx. We can possibly combine them in single duplex
> tx/rx transfer in the core. But this will be treated as duplex transaction
> in our controller level which require tx and rx data happens at the same
> time. Obviously this won't work when rx depends on tx happening first. We

I'm saying that if this logic is useful then implement in the core
rather than in the driver.

> can not differentiate this combined duplex transfer from the true duplex
> transfer unless there is some flag to indicate that. Also there is limit of
> max tx length as the prepend buffer so maybe another parameter.  And another
> reason to be done in the driver level is this prepend mode has dependency on
> dummy cs workaround which is driver level parameter currently.  I am not
> sure how practical and useful this is to factor them out to the core level?

If this relies on software control of the chip select (which is what I
*think* your dummy CS workaround thing is about, the other patch about
that is really hard to understand) then I'm confused about what the
advantage is?

--yBS0HA2Gard2IIBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO8a4UACgkQJNaLcl1U
h9DXXAf9GoBrf8OqIkt/3HWzEqQPSwgKjh1CzhsHVGlVfTNyP5J7vYcdUIJecKW4
cwBUUoMPhKySCTSdL5+KzJO9Z2WpoIQSn2b09Hd4uKPYVtNR7J3N77uNBxYSWGQE
4NBaJv5snRWcGyHjuWOqoy1s4TkZU03BHo+wQlpg7MR+vfTgquRxiY+L22vFSfF9
SbSX6Bc6W61g+gLil9qGcjX2fRn6eGddO42d8GEXElga7G4oCPyT6YpZqqc6jHWN
kh+0lqBlLWn6udC1bnyxGgXlFKAFVWuQHcg9ya1vw5SxLAqrbgMBhjhgcSBVRhQE
NJ0W0y4yDi0HcjsXBJb3MAo9lcEqOA==
=wvSh
-----END PGP SIGNATURE-----

--yBS0HA2Gard2IIBC--
