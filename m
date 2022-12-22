Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197A654120
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiLVMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiLVMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:34:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCDC1A3A9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABFC6B81CB5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218ECC433EF;
        Thu, 22 Dec 2022 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671712481;
        bh=SoUlKjruLAgmysN53PLLgolAxy8ONwQLBGr4rmVIuJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbBGDP/BwjO6VuqInuMUl3mUlhPY5IL8s2Zxf0ZgF9Jq6pVjLycAas/L4tgBWDi4Y
         i0WhJVOWLhd90ZYwHWz1ihEMeovTmmtNHdSBA6W0OOQ1zKbvkdtTPqBKiXEK1UwoVh
         fyHcdtOv+jdU2dbQD72dirKW773rERILnG981t6045Evnhdo1WGDV9jasqIpElVf3a
         +FYs/LWza5xKTZUGyO6QWZi/nYSuhu9QDYFx5jGTqPvlCF/4nBArMlAiSIw4aoAwLs
         euMpOcRiJQqL1IUwbKrbzjiOtaiAQrSLZuUM9VkndsItm2kC/IhSDNM9oOYK9ovUdb
         JuoL5eUo9zUoQ==
Date:   Thu, 22 Dec 2022 12:34:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Remove use of ARM64_FEATURE_MASK()
Message-ID: <Y6RO29H8AmnswBN7@sirena.org.uk>
References: <20221221-kvm-sysreg-cleanup-v1-0-112ddb14fb4e@kernel.org>
 <20221221-kvm-sysreg-cleanup-v1-2-112ddb14fb4e@kernel.org>
 <86h6xnbp9m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uTei0FHqHVjcuC9J"
Content-Disposition: inline
In-Reply-To: <86h6xnbp9m.wl-maz@kernel.org>
X-Cookie: Yes, but which self do you want to be?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uTei0FHqHVjcuC9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2022 at 12:23:49PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > the users to directly use the generated mask macros, writing
> >=20
> > 	#define ARM64_FEATURE_MASK(x)	(x##_MASK)
> >=20
> > obviously looks redundant and if we look at the users updating them tur=
ns

> If the two are strictly equivalent, then let's use the former as it
> results in a tiny diff.

They are.  I'm tempted to move the define to a KVM header to discourage
new use.

> Constantly repainting these files causes no end of conflicts when
> rebasing large series (pKVM, NV...), and makes backporting of fixes
> much harder than it should be. Specially considering that there is a
> single occcurence of an ID register with non-4bit fields.

> Just put a FIXME in the various files so that people do the repainting
> as they change this code.

OK.  It does result in the half transitioned files looking really messy
which for the main arm64 code I'd expect to generate complaints but like
you say the conversions have their disadvantages too so if you're OK
with it.

--uTei0FHqHVjcuC9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOkTtoACgkQJNaLcl1U
h9CX2wf+Mr0zawe5JO17RyNpOixFQbndFDrQ6JzyoyjinZK+cBjbADY3prZW16hp
CCFP/ftgz2YyhtWB0KLmg4fEu8uFNSpigJTgp6QBQrcNMwxTmw7deXNhBjO4XmUi
wkI0k5icx1lAMKAL3GtzQ7iIJx/t7N1SfesN5O+cbc84JLERXCu+lceQMXDWaz7C
qcCFkE6623GbytuBg3w6OOUmqB8SlRYQ9n8AMk8NEZ2YC+Urc6XokKfsnkPx5byR
tAN5rOLxRp7XZ27Ej3GWRxOWt/Gyu2AhY+X+9Ikqv+91Qs9nFhtCO1eBpXCQW8J7
QmS1xDMeVtlehDH+1w1XUdDXVh5dGg==
=Jggo
-----END PGP SIGNATURE-----

--uTei0FHqHVjcuC9J--
