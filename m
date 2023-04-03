Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF006D4FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDCSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjDCSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053626A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C5F7621DE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E91C433D2;
        Mon,  3 Apr 2023 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680545157;
        bh=fh1/BuMAeF3Cspq9s6y2qpX45pOe5cMpLK1zYAf1Oqw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FpNUaWtnEA6tFcMxYhArZrx5knkl2MCmM0OO7lCYWrXckt8zhj0VmFZbeejz995fc
         Pc/H0R6no6q1ezU1Aon0meGDT//+tFCA3Umr0fE64UI0uwFDC8HwDZlL/K3WEhsFfs
         KCLaZwuMSLsnlYnD18WzLFOfVxFAcCrec/XaxS5NcBEYpsV95HU5sHrHJfDIHbx4zw
         dabTFpkubG+4DlTE07/PmdczFPQPTgA+oxxggP36NqPaap0BTDZTopBiRe8nt8U+Bn
         FdE8kO341jWa4HamaNZI8QQeGFHN0d32PQwBt+DM1ae85XSLeJU3bttdR5iwmRMb7P
         FXCc7NkABa+pA==
Date:   Mon, 3 Apr 2023 19:05:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regmap: Add maple tree based register cache
Message-ID: <748e0661-03db-4661-ad4c-d45ceb050f0f@sirena.org.uk>
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
 <20230325-regcache-maple-v3-2-23e271f93dc7@kernel.org>
 <20230403154508.qia42tyasj4vhtm5@revolver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3UCjBfDU9p9fm8d"
Content-Disposition: inline
In-Reply-To: <20230403154508.qia42tyasj4vhtm5@revolver>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3UCjBfDU9p9fm8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 11:45:08AM -0400, Liam R. Howlett wrote:
> * Mark Brown <broonie@kernel.org> [230329 20:10]:

> > +	/* Any adjacent entries to extend/merge? */
> > +	mas_set_range(&mas, reg - 1, reg + 1);
> > +	index = reg;
> > +	last = reg;
> > +
> > +	lower = mas_find(&mas, reg - 1);

> If you just want to check the previous, you can use:
> mas_prev(&mas, reg - 1);
> This will try the previous entry without rewalking from the top of the
> tree and you don't need to mas_set_range() call.

I did give this a spin but it doesn't seem to be doing what I'd expect
for indexes 0 and 1, in a register map with index 0 if we attempt to
insert index 1 the mas_prev() doesn't find the existing entry for index
0 so we don't attempt to combine them.  It seems to do the right thing
for non-zero indexes, I'll have a poke at some point.

> > +	/*
> > +	 * This is safe because the regmap lock means the Maple lock
> > +	 * is redundant, but we need to take it due to lockdep asserts
> > +	 * in the maple tree code.
> > +	 */
> > +	mas_lock(&mas);

> > +	mas_set_range(&mas, index, last);
> > +	ret = mas_store_gfp(&mas, entry, GFP_KERNEL);

> You can avoid this walk as well by changing the order of the code
> before:

> mas_walk(&mas, reg);
> if entry... return
> mas_next(&mas, reg + 1);
> ...
> mas_prev(&mas, reg - 1);
> ...

> This should now be pointing at the location mas_store_gfp() expects:
> mas.last = last;
> ret = mas_store_gfp()

This appears to be triggering data corruption for me in the cache drop
test, again I'll have a poke at some point.  We seem to be getting
rubbish for the upper data block, though only in the drop test which
means it's possibly an interaction with how the tree is affected by
dropping the middle of a block.  Might well be something stupid I'm
doing either here or in the drop function.

--g3UCjBfDU9p9fm8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrFYAACgkQJNaLcl1U
h9Ciawf/eRYfy9/7wSDIUZ3+hkyUulr/rIZSxdfJ1AT+OaJrUhz1EGlGo3dj8aVk
RjykX3UKZzsyEl0DmeyUdyYmh8kNvBjk9nMzt0WZdgMPS3XAUnHtLW2R5bg1wSTV
e/kOfQLL5I+ewpSQvCHlaQakMpA/0J+T/qm8LrP6wSTJaVjP96xF2y0IVEFvBq81
aJSw7hLHJ2Od4yq6jld40S5Euy8rd5MnxUiX4xXypyxsIM1wLb1bLnK0Xx9moRkS
eL5sgghsKEhsY290XH/IX/PZwrW6cGqir9PJkFcdP+cmGk8GC1G3BUlnxTmCKlqU
ftPFyTW0ay3gpBtBquAmxew/OAaQ4A==
=Uxys
-----END PGP SIGNATURE-----

--g3UCjBfDU9p9fm8d--
