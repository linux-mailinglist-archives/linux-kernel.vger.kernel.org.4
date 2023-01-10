Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E77664F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjAJWwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjAJWvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:51:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245982F7A;
        Tue, 10 Jan 2023 14:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE1561912;
        Tue, 10 Jan 2023 22:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048CDC433D2;
        Tue, 10 Jan 2023 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673391005;
        bh=+RkdLFz3felJy1/GEptQd9wZ3WaSQVIRl9ertAsb6Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJAOUxYbEnY2lj99q3OGhbUBHfx49rU6a6bHt8u1k85iSLoRdmX22q9K/ZyZ5Hna9
         +p+AjGai2rrmsaLbiDgS1sUvQTefVtKFkjwHWlSwP05prRqvMn3ge5GDfD37vNMFdQ
         Ti16k4nvKTQ0Xz4LfiTYi+2OpHeGSyeulxiYO99poOHHDvz05wGc/dKxViIFJoRQIq
         Pm7MU88zlZq8ruVmhO9JdEJ0SMuX5zs4nE2A0ftfs7nAWBi/NCaliOdJ90mmI9OA2e
         rPd3322EwGLwsjuA+s54qi7U1iEc636nUQusvKGEBhNwH3nTcMjdsHe543uwgSpmnZ
         0zCqO1nElAfYA==
Date:   Tue, 10 Jan 2023 22:49:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] spi: bcm63xx-hsspi: Add polling mode support
Message-ID: <Y73rl8feUOnChWKF@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-8-william.zhang@broadcom.com>
 <Y7iW38Fsj0nIewDm@sirena.org.uk>
 <ec84b84b-41be-32ad-2e76-afac59a621d0@broadcom.com>
 <Y7xloRuHk5BHSOCb@sirena.org.uk>
 <ca22c9af-34bc-e857-881c-263f70a405e8@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dsTBb0yv/WOifVKY"
Content-Disposition: inline
In-Reply-To: <ca22c9af-34bc-e857-881c-263f70a405e8@broadcom.com>
X-Cookie: Live free or die.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dsTBb0yv/WOifVKY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2023 at 12:10:30PM -0800, William Zhang wrote:
> On 01/09/2023 11:06 AM, Mark Brown wrote:

> > You can put whatever logic is needed in the code - for something like
> > this an architecture based define isn't ideal but is probably good
> > enough if need be (though I'd not be surprised if it turned out that
> > there was also some performance benefit for the MIPS systems too, at
> > least for smaller transfers).

> I just don't know what other logic I can put in the driver to select
> interrupt or polling mode.  Only the end user know if performance or cpu
> usage is more important to their application.

Usually you can take a reasonable guess as to what would be a good point
to start switching, typically for short enough transfers the overhead of
setting up DMA, waiting for interrupts and tearing things down is very
much larger than the cost of just doing PIO - a bunch of other drivers
have pick a number logic of some kind, often things like FIFO sizes are
a good key for where to look.  A lot of the time this is good enough,
and it means that users have much better facilities for making tradeoffs
if they have a range of transfer sizes available - it's not an either/or
thing but based on some features of the individual message/transfer.

It is true that for people with heavy SPI traffic or otherwise very
demanding requirements for a specific system and software stack
additional tuning might produce better results, exposing some sysfs
knobs to allow tuning of parameters at runtime would be helpful for them
and I'd certainly be happy to see that added.

--dsTBb0yv/WOifVKY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO965YACgkQJNaLcl1U
h9BfgQf/T3FIrGTPXWBtb/Xe+nzT5F6/A5RXyCC+YpHtvFHHnqzXiD8j8sTyxYpk
ejYT1iJsWVt5un0Fbiu9nijFuOcbdVr0e8ztt0ItyQJpde/+lQt9c6ucwf/0/hwn
jCnjnQh5OSVmtvpRywW6HzYeEUM4xk1WcWtjgm5yj9tbMdKLx3WER6P6SB/Jtmhp
EPdgxass3RdBTA9PnZASARpCTMPy2FZI3hUt21GvAQulYlNDWmO3cSpTI3KuCaTI
a8HCev8ODbdHDO8FoQGjcZuq0tl6DrPuk8LkEQL5WWpd2uUkAtioK30fjM67PfjG
qLmzXHgc1iWSVR7KYPRuodyqm8t1Kg==
=5TDj
-----END PGP SIGNATURE-----

--dsTBb0yv/WOifVKY--
