Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD36B443F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjCJOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCJOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:22:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19081B329
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E3746182F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70650C4339B;
        Fri, 10 Mar 2023 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678458073;
        bh=pV8y+lDko0x9q1zU9LfO+KT6dE4oXj+6tJ2i3uC7jeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOvplGeqauzzyCdgmpCslD4l37qdG0NZT1OaO+MVcPmyxNrWoGZUzIi3JBUh4fbX3
         IeH/wGlqEqjbl8CPcscNbfFVjVu/bWdLfO4ZMOsk24cJXGCok8J3PmTeEaVTIqYoxa
         eETgNzYfe0DU8bJv4cnWQNfcGFAbgcv/sxQrnt1KDja9A5jkEHLzWxYV4+J3h8sS9Y
         Zzo+RjzxtSrOAaIGgciiJ94GG2PHqDxgpQI472MnZGcLeLVXR5kXKvB1aqXtwHLevN
         Yr5su1hDMwKwDxq5xJg8MCSpczwZ+qfMZmmO10RjZUNgxhVv6/gDwKWMsWd+o8N3uW
         cOJrnPsQNQqZA==
Date:   Fri, 10 Mar 2023 14:21:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: cache: Do not panic for REGCACHE_NONE regmap
Message-ID: <ZAs81tPqVruM4eAL@sirena.org.uk>
References: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com>
 <ZAsqVf8/C3lHOF8W@sirena.org.uk>
 <2399331.NgBsaNRSFp@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0TCfB71qknqSkwp3"
Content-Disposition: inline
In-Reply-To: <2399331.NgBsaNRSFp@steina-w>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0TCfB71qknqSkwp3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 02:35:13PM +0100, Alexander Stein wrote:
> Am Freitag, 10. M=E4rz 2023, 14:02:13 CET schrieb Mark Brown:

> > Why would we be trying to do a regcache_sync() on a device with
> > no cache?

> Indeed, that makes no sense. That's indicating a bug in a driver, but why=
 do=20
> we need to panic the kernel in this case?

You're trying to change this to silently ignore the call which
isn't going to make anything happy.

> On the other hand the same question applies to other regcache related=20
> functions currently checking for non-cached maps. There is no common=20
> behaviour:

> panic:
> * regcache_sync
> * regcache_sync_region

These are only ever triggered from a client driver, nothing in
regmap will ever sync the regmap without being explicitly asked
to.

> returning -ENOSYS:
> * regcache_read

> returning success (0):
> * regcache_write

> early return (void return value):
> * regcache_exit

These are all called transparently as part of the regmap core
regardless of if there is a cache, users never directly read or
write values to the cache.

--0TCfB71qknqSkwp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQLPNMACgkQJNaLcl1U
h9AcKgf9HL9YmHGsi3fCUMbzj++jdY38ZNLOx+XJVSlMlyBEz1zYkh6nzokE1Y+1
h+msQY+YaReDKwm3H8V4E9Q+PVbRYql66VyKjlmDQs69+NCAgJMkyajeUCMIX/Ko
UBYhn9kG0/S3x3Tt6pzoClV9pVzIeC03pmMh67pm6t05v/q1ae+lGtdYaag5oAt5
VdB8P1Tvs76dJ2k6X5BuoewsUyLpzioiW3MUMcJZG75Tp2bMRoJPVJZNVIKCKKJ/
F/VR/SQQf9USDRg+uR0hqLFERzEsu7fyZotL6MiAooq0QkafAfvJKS0TOmh8LVTY
P7N5gXlc1x/Qnj/Iv4z5aKBeHnL7jg==
=uH7+
-----END PGP SIGNATURE-----

--0TCfB71qknqSkwp3--
