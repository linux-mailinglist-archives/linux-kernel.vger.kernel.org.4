Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACCE6C68E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjCWMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjCWMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77D1C591;
        Thu, 23 Mar 2023 05:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95EC5626A9;
        Thu, 23 Mar 2023 12:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D7AC433D2;
        Thu, 23 Mar 2023 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679576076;
        bh=0f4sSDOGAezOQc/75NB+W0t39lJvoLyHm0ASgw6qym0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Unq2gywwMnHGvYrOHmT+ZU30GrmwWJ4kiBSFA9zwR0lqDdrp7ihThHtdiX066JUpA
         FAcjAYRqLEENCHVpqr92jXmxVM34dEHGRnJ8MfzWZ+bG+RC9an8FWkgwralxqyDx2i
         GVcWVbjiGA4Hf68qkHcvMUis1aUMb/lW+zNNTEEY6Sl+Zk78DruL91qIJAK2QM/bD6
         y/DHeAnRTVTnbwO5qEpXhZUB2vQdkfFBf6HoS2KpTOEz1QNRfuZ5as2XuNp6TytX/O
         K5tCAM26muIQvm5X+ftxPWvt3reBJXjA+ZUr0E0/arSrVZ63S6sURWgxhrDwb8XzM4
         Assqp0Pv+Z7DQ==
Date:   Thu, 23 Mar 2023 12:54:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 00/10] arm64/perf: Enable branch stack sampling
Message-ID: <4d93a3de-c86d-454b-8a43-b24e62ea3be7@sirena.org.uk>
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
 <655ff114-99d2-4612-9167-cc8688f2b6b2@sirena.org.uk>
 <f7e24b0c-3e33-755a-65c9-2ee78d5a79ec@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IzzsaEzQhBiT5n2I"
Content-Disposition: inline
In-Reply-To: <f7e24b0c-3e33-755a-65c9-2ee78d5a79ec@arm.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IzzsaEzQhBiT5n2I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 09:55:47AM +0530, Anshuman Khandual wrote:
> On 3/22/23 00:32, Mark Brown wrote:

> > document a requirement for those traps to be disabled now in case we
> > need them later, and do so during EL2 setup for KVM guests?  That could
> > always be done incrementally.

> Unlike all other instruction trap enable fields in SYS_HFGITR_EL2, these =
BRBE
> instructions ones are actually inverted in semantics i.e the particular f=
ields
> need to be set for these traps to be disabled in EL2.

Right, for backwards compatibility all newly added fields are trap by
default.

> SYS_HFGITR_EL2.nBRBIALL
> SYS_HFGITR_EL2.nBRBINJ

> By default entire SYS_HFGITR_EL2 is set as cleared during init and that w=
ould
> prevent a guest from using BRBE.

It should prevent the host as well shouldn't it? =20

> I guess something like the following (untested) needs to be done, to enab=
le
> BRBE in guests.

> +       mrs     x1, id_aa64dfr0_el1
> +       ubfx    x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +       cbz     x1, .Lskip_brbe_\@
> +       mov     x0, xzr
> +       orr     x0, x0, #HFGITR_EL2_nBRBIALL
> +       orr     x0, x0, #HFGITR_EL2_nBRBINJ
> +       msr_s   SYS_HFGITR_EL2, x0
> +
> +.Lskip_brbe_\@:

Yes, looks roughly what I'd expect.

> > I've got a patch adding the definition of that register to sysreg which
> > I should be sending shortly, no need to duplicate that effort.

> Sure, I assume you are moving the existing definition for SYS_HFGITR_EL2 =
along
> with all its fields from ../include/asm/sysreg.h to ../tools/sysreg. Righ=
t, it
> makes sense.

No fields at the minute but yes, like the other conversions.

--IzzsaEzQhBiT5n2I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcTAQACgkQJNaLcl1U
h9CHFAf9EtWrB/2JoeaIi3pXQAESHQ74/qrx9W/Ih/WTQpX+J2Do4nqspRKm5LxU
LUxsZP6nH6Tx1YN8gB/Lqa8icl8CI7mMxadWudTd2LhVsPpzOieJ+rEZcq7qKkSQ
OQxffNJto/e06eqNVvD4gEagA0ZOVHDGmtOBMkaKJGcVri0oMFQCEHFGcGzMATT3
rw0TOKRX7zEPhUCy42IBayzBddCWSXOHdPwJPLjFZmevGonhvQf1ujSRUeF+Zv6E
PiFI+AN9WheqYT5cm4GsWE0bF3gRteR0y74TUy7iwEasSNTKWsf5izOcIagpAPmw
AtW3a9hlhnnKR1kZQXW6ygRMnrsP6A==
=YCOY
-----END PGP SIGNATURE-----

--IzzsaEzQhBiT5n2I--
