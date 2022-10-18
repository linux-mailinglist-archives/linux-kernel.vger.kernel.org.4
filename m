Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8B6031E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJRSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:00:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E1DAE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D4B0B820E1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2701C433D6;
        Tue, 18 Oct 2022 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666116018;
        bh=Je8O2f54KX4SRbRGQWxkrhxqufhtd9FXHhR4xFvabjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8BEhKs1MB3ikmYcJDPHFFHV9IP3OZ1vn1d4+qIBEgyfq1FJtllZnn0yS6dEJpXlv
         ksHIfttSDZ3zf0kREGiuQLn9NmlTiNpzKN9SD82i9X5DwtUbTQOvE/Rw6l47mGBh8g
         SrlZkx5aqLA5kPJnUKFIx2s7Jw1ohcfzVRb7OlxTWtnitlvjKQQyHoaJyzOGA03x9R
         2TL65WwQTk9MdtSiunKlKV8vkwUjmDklxxIbntsW8kV6jioWE8KSDSQGsGy1f+Crub
         scgiq9pBFJEwOyVKEWj9vHcztWpL0Q44CaJZJoBZ1+hMG/KFomntJko+t2OR26hKCX
         H9DEfp6/DZ+aA==
Date:   Tue, 18 Oct 2022 19:00:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     joel@jms.id.au, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH 0/5] fsi: Add regmap and refactor sbefifo
Message-ID: <Y07pqhpm/1hzx9LR@sirena.org.uk>
References: <20221014220540.55570-1-eajames@linux.ibm.com>
 <Y02SztthO39FYIeu@sirena.org.uk>
 <36908c1d-4672-807a-d157-d3ccd0b03148@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="731fm/Mxx/dGraEs"
Content-Disposition: inline
In-Reply-To: <36908c1d-4672-807a-d157-d3ccd0b03148@linux.ibm.com>
X-Cookie: Lake Erie died for your sins.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--731fm/Mxx/dGraEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 18, 2022 at 09:02:33AM -0500, Eddie James wrote:
> On 10/17/22 12:37, Mark Brown wrote:

> > Is there any great reason to provide support in the regmap core for this
> > rather than just implementing in drivers/fsi?  AFAICT this is just
> > ending up as an implementation detail of shared code in drivers/fsi and
> > won't have any external users?

> One reason is to have a common interface with the new FSI regmap. That way
> abstracting out the bus transfer is trivial in the new SBEFIFO driver,
> assuming the SBEFIFO driver should switch to use the FSI regmap.

> But you are correct, I doubt anyone else will use this. I suppose SBEFIFO
> may as well not use the regmap and just use some callbacks for whichever bus
> transfer...

I'm not saying don't use regmap, I'm saying why not just do this in the
driver - you can just as easily set the reg_read() and reg_write()
callbacks in an individual driver without needing to create a new regmap
bus type for just that one driver to use.

--731fm/Mxx/dGraEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNO6aoACgkQJNaLcl1U
h9CdBQf/VWAmXhm6IpGSjUC0wj4Nbr/1RlO2Ff4YwSJQMlBROyh4g9d9siFBjYPI
UEDZNIhq8FHJJaAQo0u/nOt0VPynJ4w38KhchjfzlhwbxRjhxgLdqL4QVHQSV5K/
lnaQIIwIVa3fU64egWH4NoNzYUx41siENAVvKgOVHgjExry78xS/S42fN9YPk/92
nYcv7vp8TUSl0uUfaKDtvSI79dwHaBjXivuZnVDIy+o8My7noyFFjbwyiIbzZdAj
1kw2zmjLfC1bjrEOM2Sps5hj0bpMwyJYZH0ZwXiSXEWwWLlHdyQKEB3OfErZZB6f
PqK3X9+8xkQntYKQW5UKoKl2kidZpg==
=8umn
-----END PGP SIGNATURE-----

--731fm/Mxx/dGraEs--
