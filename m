Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406216D9C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbjDFP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbjDFP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318DA244
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D7F64956
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB2C433AC;
        Thu,  6 Apr 2023 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680794757;
        bh=0XcFxg2ON9n02AwkyUk+wOw5Kqak4ShAAevzNca1xvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYHkuQ4xbB3ZPaH5cfe81BTQiCl1DaCLmjEdW1gEgWozyywUvAdj/u+kZ3gCOkEHt
         v156BcMQfJ3TrI6O8IBkkxCFwRpPtSjBitdm7a2QbMaky3R91Xsc+y8Um8VNKc9c/E
         7Ki7Wz38wQ2iBsC0Mcmq6Zo4lvHmb7YD2Tb1ghXku//AvhOnIiWiMp87zTo9zUvc9c
         OMa5Z/gDkYZ/4+e3ldFstihQ0W+EfqnONZayqUla97UHsT+yJOWl+xxboR3z7A+7vC
         RXFOhdWRmkoBNOwjjTjVNLBAOP4oS8jAeFld5uQXJEL2TRz3zEldBoZgeTHUeYpTZ1
         KB2iOn3+ndqKw==
Date:   Thu, 6 Apr 2023 16:25:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
Message-ID: <8aeccf95-6582-495e-930c-2d6723a21b6f@sirena.org.uk>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
 <20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org>
 <20230406144653.GB11479@willie-the-truck>
 <8474042a-d0e3-4316-9740-733c524f2e27@sirena.org.uk>
 <20230406150456.GA11802@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dFFL3Q5P6UjSt4HY"
Content-Disposition: inline
In-Reply-To: <20230406150456.GA11802@willie-the-truck>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dFFL3Q5P6UjSt4HY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2023 at 04:04:57PM +0100, Will Deacon wrote:
> On Thu, Apr 06, 2023 at 04:02:18PM +0100, Mark Brown wrote:
> > On Thu, Apr 06, 2023 at 03:46:54PM +0100, Will Deacon wrote:

> > > Can't we generate this file from the architecture xml? That would hopefully
> > > avoid typos like this and make review less tedious.

> > I agree that this seems like a sensible idea however there has
> > previously been pushback on the idea of providing tooling to do that,
> > and we would want to manually integrate the output of any such tool
> > since there are a number of cases where for legacy or usability reasons
> > we rename or combine fields.  The cases where we use a Fields block to
> > cover identical ELx versions are another issue.

> > I also note that while the XML is viewable on the web AFAICT the only
> > directly downloadable version of the architecture XML available
> > externally is in PDF format which is not entirely helpful for this
> > purpose.

> Sorry, I didn't mean to automate this in the tree, just that you could
> do it locally when you generate the patch (as I suspect this must be
> tedious for you to write out by hand too!). We've had a string of typos
> in the definitions so far, and it would be nice to take steps to avoid
> that for future changes.

Yeah, normally it's not too bad (and it can be useful to make sure
you've actually looked at the entire register definition properly) but I
did just about get annoyed enough to write something locally while doing
this register.  You could certainly get a good chunk of the way there,
especially for simple fields (enums would need manual naming IIRC) - if
it hadn't been for the pushback mentioned above combined with what's on
developer.arm.com I'd probably have got round to doing something
already.

--dFFL3Q5P6UjSt4HY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQu5H8ACgkQJNaLcl1U
h9ASYwf+PKDiTK9B9hnM0lw5l4npXwSDgcAfZid5yLu8ZrXAK4Q3UdmdsQisS5oB
Hcah25KOzgKd7I9CNYkMwe9V8vhCOXZYOiJ9M4+Ws2U1WRG9KK3E8HjvMFJTExSs
y6PJZNtc3F9PQT0An/D3pK6a28z4hA8UoVCqzi5bqHBuZO6V0+FJipU5P7PvdXaQ
OuDYlwZ9yYAsuy46gtU+EGSCyoy6PRm1n37zjHGGzMgywdbdeje46s/Mi5ZnBzYu
tE/n7X+5SqVZx7XBkBC2yqZKpUfiEpUKPvocUimL5AJpIUF4fDIEIkbkIioOeCPa
MWuF05raXBrWnvDpWvsNRrMzC8qHHg==
=9Lpm
-----END PGP SIGNATURE-----

--dFFL3Q5P6UjSt4HY--
