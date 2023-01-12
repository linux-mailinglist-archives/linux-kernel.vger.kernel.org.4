Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88771667FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjALTyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbjALTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19846254
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC1462169
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA37C433F0;
        Thu, 12 Jan 2023 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553036;
        bh=zda6P5kzwDBNzHpULjSdKEirPfffPTlEHkVxGhfGnvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0zUA64d4a7lfX2UERUJnv30wFRLkjkh2KQ/laS2nV8lKpB6e/Azsxvmpg6gJoVyB
         MISkqwY9CweefuTLOdWRT7WPddStRV5qo9Rj2J+AnzBSbN7hZyu1PPcDqwfOYaTJvC
         /5gsxyzZC4Yki0Qk0gz/DtkACuxGXStMb6JpgrEijtM//VQM7qnDooj3ss2YwjYKTn
         n+OQ+tjkk1amKbWpsn3WTVjv2AUBqfOusaolJbYutcmt8wZsHTnY6C1sEWKQuGKV8f
         MI8sT7e7P5Xe2OfdE0yiIXZwAxe4rIBuesOPZcP2EJ+jTApG7VDB/483JmTCfJ6VYX
         Pfya8PLZopCLg==
Date:   Thu, 12 Jan 2023 19:50:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Message-ID: <Y8BkiF8sfqPifYTO@sirena.org.uk>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
 <Y8BOCpXyOyF3igfG@sirena.org.uk>
 <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kdxHzIo+lmpm7kNT"
Content-Disposition: inline
In-Reply-To: <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
X-Cookie: A watched clock never boils.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kdxHzIo+lmpm7kNT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 12, 2023 at 12:43:46PM -0600, Pierre-Louis Bossart wrote:
> On 1/12/23 12:14, Mark Brown wrote:

> > The regmap gather_write() operation allows the bus to take two buffers,
> > one for the register and one for the value, rather than requiring the
> > core combine everything into a single buffer (mainly useful for large
> > transfers like firmware downloads).

> Right, but that's not supported in SoundWire. sdw_nwrite() will only
> work with consecutive addresses - and the auto-increment is handled in
> software, not hardware.

No, that's exactly what this is for.  It's for the *register address*
being in a separate buffer, the data is then a sequence of consecutive
register values.

> What's suggested here is to use the first element of reg_buf, which begs
> the question how different this is from a regular write. If there was a
> discontinuity in reg_buf then this wouldn't work at all.

reg_buf contains the address of exactly one register.

--kdxHzIo+lmpm7kNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPAZIcACgkQJNaLcl1U
h9A1Ngf+KIeT4cHA1t0heeIsCmRspEmUq1LpG69jvzpevaJxWp+UwyYexAhb6Ny5
W9E0VwV/kxd+cRCvATjFbJstHICBBYZ91FHf5Vm02aO0howOio6qdunk1lYPz9X/
IT4T80yD+QF7bZD+lr7znfbStVp1ORQtJJl7BtjtFKZobLWz9KWVCLSDLd6acMRF
MZ+uKsKleQG4R9hWRRzfS7KvZ2epfgjV0GPMHm5/OM2iXLMZdsapHehN2AyfLJVm
bQSAw5Zq3Otqg6WjpaZewK/t1qJYEihF7eHghETSiNPez7+qUxRPdFjNkLRy9uPP
I5c0ZW80V6UYUcMKcrXdeCUzpZU6lQ==
=TNuV
-----END PGP SIGNATURE-----

--kdxHzIo+lmpm7kNT--
