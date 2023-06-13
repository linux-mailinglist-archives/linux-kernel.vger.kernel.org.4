Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDB72E797
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbjFMPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbjFMPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC404D1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 720EB633E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6758CC433F0;
        Tue, 13 Jun 2023 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686671234;
        bh=+ohipxYNxEPiJYNmfAXVMC4O4nJHcUHSzXecjYk9z08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0MWlEzcnvFqQ2Y0D4KCE5QjY++EVkiMDUn70n3KVM1O5JmPHBX1UL2Hhjn46vGVs
         XLlJFlt04EGOOsT+q2xaMD4q6anHXuY08/24Uby+QDCcJTeVQfYT07nXy8MG4SHIAV
         xSZVJFhP3vHZye2oyByGRcGEOsyz8J8gqAwgoZk9LZnYJnTWyKq8v9j5cpDcOJ9IeL
         KR3oaxteprBmXf7+Xc1h5LejYCVTjnQfB+GpfD1nGb/laydu9pmUAQBlMvDtxhwmkc
         99kZlqILbdbDrkMu11kqNBqtj5UskAAbExRGaKXtSmV069ao9rhP0zL5/rQ0R1xCNQ
         2jT/e8+EGQj6Q==
Date:   Tue, 13 Jun 2023 16:47:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ricard Wanderlof <ricardw@axis.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Waqar Hameed <waqar.hameed@axis.com>, kernel@axis.com,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] regmap: Add debugfs file for forcing field writes
Message-ID: <1c1f7fae-7eee-473a-b637-af021510d7d3@sirena.org.uk>
References: <pnd1qifa7sj.fsf@axis.com>
 <2023061322-garter-linseed-6dfe@gregkh>
 <5b20509c-e4d5-21f8-fc20-4d02b9abd87d@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5A4kAC+oX43H9Pox"
Content-Disposition: inline
In-Reply-To: <5b20509c-e4d5-21f8-fc20-4d02b9abd87d@axis.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5A4kAC+oX43H9Pox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 05:15:10PM +0200, Ricard Wanderlof wrote:

> I can understand that enabling a write-always behavior results in a=20
> different behavior on the associated bus (e.g. I2C), but in the end it=20
> shouldn't affect the functionality of the peripheral device any more than=
=20
> rearranging driver code to perform regmap writes in a different order,=20
> which might also lead to fewer or more bus writes.

> It seems I'm clearly in the wrong here, so there must be some scenario=20
> I've missed. It just doesn't seem that dangerous; it's a debug=20
> functionality after all.

There are devices where the act of writing to a register can have side
effects even if the values in the register are the same (for example
triggering some kind of recalibration based on the "new" value).  It's
rare, and it's probably more likely to be annoying or disruptive than
actually dangerous, but it is something drivers might be relying on.

--5A4kAC+oX43H9Pox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIj30ACgkQJNaLcl1U
h9DvFAf/cQwuvYnO7JDuL83AFlpdAHUglQLWdk4YV7wQuxjt+nnVZuKRDADuX2rL
hNfdmO1mEwYBGon7bI8fY+omEisls736KXLAUs69DeEHz4tgO/zzMjYjLDsJmjev
QkxFreFWcvRLHsCTGxE9zTAcDysxULFmqotS9WI5EPCVnuZoj6cKLfxi2UwmILWB
QFxuKOttitcpWBz7HQhwzFCiMJFFsomtFvvK+QbmtAWEa6VIhUdDk0Jya5ilAfhk
VD4EQFEhWIy4YVT4YdGju+F6botKpzpXATjfGRROaRNDCfBwnaw3Yz9k0jN8RJKx
IPQ2jZii+OCd4Svwkl+vHapqsVc8qA==
=3Q0/
-----END PGP SIGNATURE-----

--5A4kAC+oX43H9Pox--
