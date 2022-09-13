Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668935B6C79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiIMLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIMLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:43:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE9564F4;
        Tue, 13 Sep 2022 04:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79C42B80E5B;
        Tue, 13 Sep 2022 11:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A9C433C1;
        Tue, 13 Sep 2022 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663069399;
        bh=+nJ7Rj3FLsg7DuXb+iDl45ORA6bPO0PKiH+GGv2hjNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLWvuKIPOoWJF+ZTTvEA1lBCgy3shcWi3dEoRFVXLnwx5oDO6FIh7la9jkdSfvMb9
         M2TJHAftRctnwila9sZiMhd8CfaTUckW9NezCucYGgyDsu3NOHJ6aKjjH7hkcRCtkZ
         lc7E5yPrIepoz6j2seYprP0ZjZv/4cQUXpC79b6H62d9lynb9CgyWW5I27KEFI0HCO
         +SqlHFZA1zaF+mOT68hjV73C3NW9nwrfmnSpDYPDq3uXjUeRGmgBKjYHkG72Z8ZqiH
         tAE2Jm2cUoISe79v3jvsXpUp9n6cNxkYzu/sAgON9hZTxmbpFLFtvX3RGhB+pRhLVf
         /gOImxd69s5cg==
Date:   Tue, 13 Sep 2022 12:43:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Message-ID: <YyBs1PJwNoNYv4NJ@sirena.org.uk>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-4-anshuman.khandual@arm.com>
 <Yx8GBq1FJN49iJs9@sirena.org.uk>
 <84683aa7-58ad-85f8-327b-daed2f704834@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u7UoJoh5Bi3vxoGn"
Content-Disposition: inline
In-Reply-To: <84683aa7-58ad-85f8-327b-daed2f704834@arm.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u7UoJoh5Bi3vxoGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 13, 2022 at 11:03:45AM +0530, Anshuman Khandual wrote:
> On 9/12/22 15:42, Mark Brown wrote:

> > like it would be clearer and safer to allocate these dynamically
> > when BRBE is used if that's possible, I'd expect that should also
> > deal with the stack frame size issues as well.

> That might not be possible because the generic 'struct perf_branch_stack'
> expects 'perf_branch_stack.entries' to be a variable array which is also
> contiguous in memory, with other elements in 'perf_branch_stack'. Besides
> that will be a deviation from similar implementations on x86 and powerpc
> platforms.

> The stack frame size came up because BRBE_MAX_ENTRIES is 64 compared to
> just 32 on other platforms, which follow the exact same method.

If this is a pattern used by other architectures and relied on by
the core that doesn't mean it's impossible to do anything, it
means that the existing code needs to be updated to allow the
larger number of entries for BRBE if we want to change things.
That is a lot of effort of course so something that moves the
allocation off the stack would be more expedient in the short
term.

--u7UoJoh5Bi3vxoGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMgbNMACgkQJNaLcl1U
h9D4MAf/aF3z/1es9J2nzieR93V2tWd1/bqxJk8jf0Cd/sv59XIF8zPUT5zPp3/N
+DkehTrDcO3uWrL8N7fZKgjb0Tvv69IJC2+QJ5fs3HCkp1qxX/Aqm9nhDqQGjp/p
t1xOni9vVwDImqq8dedD/DYLhTAAqEKFfvR11XA9l4RH96FdShRKF77tFyicKsFg
D8HdwiVJsqSdqWC82tukThKcMHoJ/HYQ0B7UxkF3gHqUkgRfqyzaU0O5VHm2frxu
IK6VJxeV2WNMzqFz9Gl4fmD3wri3tC4DvtTKCSu8LOt7nmdHqY309I2wNN+iKMY9
7q7wTAAlnSnqOPeXnngfOJ2H4IevoQ==
=S8Rj
-----END PGP SIGNATURE-----

--u7UoJoh5Bi3vxoGn--
