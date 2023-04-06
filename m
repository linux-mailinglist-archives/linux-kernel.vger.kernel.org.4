Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2806D9B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjDFPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjDFPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74795FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1911E64814
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B5DC433EF;
        Thu,  6 Apr 2023 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793343;
        bh=ePbbcCzKS9r71gW4xljY9K1xocoFQhtNCTNZnkhz9Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E16PmSu8xAkvKxmjBQnM6YnAY5E8G4P9jX16ZRXVnOOy325o5uiDJOE9Y3NlRWglN
         rmjSgAOqdfksHmMBRQPvvigioeTLKeEFxa9tweM822ntGCftnL50ixspaD5XDRgy0C
         Y2zu2Y6cFqsTTK75cgCtcmB+X1KBkbmErHwIeCV2igNT2K5TaOjOiVjCK6flOShfpT
         J1lJKr9oQcyFbxp09rO3tk1ncLrJQ9XSefZWRLKEtaM2IQmZ0mn5ZNP87pCofIITR2
         H6CzIg75kfOt00/4YS+IkiD9W3wN22yC9XK48ixRR34t9uCN7EgCkGs2ixcIEuKhdG
         bZHzvFNKgyiGQ==
Date:   Thu, 6 Apr 2023 16:02:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
Message-ID: <8474042a-d0e3-4316-9740-733c524f2e27@sirena.org.uk>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
 <20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org>
 <20230406144653.GB11479@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QtFauvB+KU6YDrML"
Content-Disposition: inline
In-Reply-To: <20230406144653.GB11479@willie-the-truck>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QtFauvB+KU6YDrML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2023 at 03:46:54PM +0100, Will Deacon wrote:
> On Thu, Mar 23, 2023 at 08:44:54PM +0000, Mark Brown wrote:

> > Automatically generate the Hypervisor Fine-Grained Instruction Trap
> > Register as per DDI0601 2022-12, currently we only have a definition for
> > the register name not any of the contents.  No functional change.

> > +Res0	63:61
> > +Field	60	COSPRCTX
> > +Field	59	nGCSEPP
> > +Field	58	nGCSSTR_EL1
> > +Field	57	nGCSPUSHM_EL1

> These aren't in the Arm ARM afaict ^^^

Yes, as mentioned in the cover letter these are as per DDI0601 2022-12,
the current at time of posting the patch latest release of the
architecture XML.  They should appear in the next release of the ARM,
the XML is updated more frequently.  The XML can be seen on the web
here:

    https://developer.arm.com/documentation/ddi0601/2022-12/AArch64-Registers/HFGITR-EL2--Hypervisor-Fine-Grained-Instruction-Trap-Register?lang=en

> Can't we generate this file from the architecture xml? That would hopefully
> avoid typos like this and make review less tedious.

I agree that this seems like a sensible idea however there has
previously been pushback on the idea of providing tooling to do that,
and we would want to manually integrate the output of any such tool
since there are a number of cases where for legacy or usability reasons
we rename or combine fields.  The cases where we use a Fields block to
cover identical ELx versions are another issue.

I also note that while the XML is viewable on the web AFAICT the only
directly downloadable version of the architecture XML available
externally is in PDF format which is not entirely helpful for this
purpose.

--QtFauvB+KU6YDrML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQu3vkACgkQJNaLcl1U
h9CJqwf9E37f5nijaNcD+W6Jjz0ZLRj6scniKOrr8NRD2ZEQjI8RZzjBvtEuPYY4
53gOVZK5BPcsf1nFjnIe4Ux88N6x2aQN/yNrD4iSrtP00XE03udNz+23scNk0ZMl
jZb7Fh+yU4qtdPy49Ex2PXKHOVhtZ1oyRAagv5A2Lq2JIqhO/wjZBZToaCzt6gUS
QOUr5MS2JlLgrH4TmCw++oaPGTm+YLtJQ+nPc/fJ9r0DGWlyTUiE/bKA7gvQOp2t
krGH+R1tJCZmG8Xl48wRS/kAhdF9hVd3Q48gdGR0gRC1/8lbrp1QtqKY6ev622xi
IxICYqvZquX9vFZSnW13i7fahvhOLQ==
=hTmY
-----END PGP SIGNATURE-----

--QtFauvB+KU6YDrML--
