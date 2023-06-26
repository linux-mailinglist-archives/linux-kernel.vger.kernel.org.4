Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CA73EB47
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFZTrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C203170F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8906060E8D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC36C433C8;
        Mon, 26 Jun 2023 19:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687808852;
        bh=5oYDp9/fDjkDPkPKEZErn9T5eWPrVI46JMJ12MLir1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQb0ZnEMQoU4I/piLuO7at3z1JQGL9yfGSFNi59pIcF+62vNRU2pvKbriCvihKjpx
         r8QpALf8+oK0Ca6DvqAfuO0wWAYQBNZGS6cDUwT0XA6q/wrYeLY2A9MBYkNHE0JcwE
         EbsLaYLMT/x5dUQLdu1A2wr9G5bM0X9m3uzdQJCSxg4XW16HvsIRkqdmoW7SAHUFzS
         d0fg+vx2OVyS57AzKfiAVS5IRRRuAJpW5o1lZ20ezrswAooje6ZvFy/EYK5J8OD3p7
         +4Ek842GcWSU3SQWKyYmxFN0YW9d2GnGxxuofNH0hL/Ba18DNilW2DKSf20VIquKKO
         RK5UDZf0c0IoA==
Date:   Mon, 26 Jun 2023 20:47:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com,
        Jim Wylder <jwylder@google.com>
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Message-ID: <c5c95368-eac3-4250-b50a-50f0a526b753@sirena.org.uk>
References: <20230620202824.380313-1-russell.h.weight@intel.com>
 <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P8hXnjv+/0ZjnrEV"
Content-Disposition: inline
In-Reply-To: <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050>
X-Cookie: Nihilism should commence with oneself.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P8hXnjv+/0ZjnrEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 12:26:31PM +0800, Xu Yilun wrote:

> IIUC, max_raw_write/read is the max batch *DATA* size that could be
> handled by the receiver. reg addr bytes are not counted in. I'm not 100%
> sure this is obeyed by all drivers. But see several examples:

There's clearly been some confusion in a bunch of drivers, those you've
identified below need fixing too for the new code from the looks of it. =20
I'm frankly unclear why some of the drivers you're pointing at are even
implementing raw buses.

> So I'm not sure if commit 3981514180c9 is actually necessary.

That's "regmap: Account for register length when chunking".  It's
certainly a bit unclear now I go do another survey, though it's also
clear that things like the handling of padding are intermittent at best.
We probably would be safe reverting that.

Jim, where were you seeing the issue here?

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--P8hXnjv+/0ZjnrEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSZ608ACgkQJNaLcl1U
h9CabQf/dmaoHTZhgC/HEHvIbuhbEgHXv0xNgEDS2rQMVc8m2qZ1wyd9Wty+2Fvm
cBMXARYF/ZCDL16ehPBpn8qwSTV9KGNVT/y2ws7YksTo6tkK+8oeh6Lh/c7B0jfy
h9wZaE1UkgGhbgNGfDkC/O0BvicnbKuCoRYahe8qstssXFj2Tcb4COJQt0Cc13Ja
DPc3BavyZdcDFxxYVVzemqWYg2SueU75zGzxv5/YkNm8yudxwYjZLw0kYfLkeYrw
m0cyyaObCfRkS2W2qDsAcyJU62Ke3BUQ3zXlrozuzxVQVq4b+4K+HbqURDhZbPZr
zGr2J9VFdJ9ugDsNpmR5FgvXqKxKFQ==
=9YEL
-----END PGP SIGNATURE-----

--P8hXnjv+/0ZjnrEV--
