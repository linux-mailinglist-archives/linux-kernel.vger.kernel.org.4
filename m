Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A77664674
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbjAJQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjAJQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:45:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461646B5EF;
        Tue, 10 Jan 2023 08:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92645614F3;
        Tue, 10 Jan 2023 16:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09D5C433EF;
        Tue, 10 Jan 2023 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673369113;
        bh=HE6Q4NXUzpaBllounynVA5H1Vsv5Qxb9vxunO/lCiv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2anPB30X8YmUosIs5zc91RpfpZbQjzT9wKHh2Iv/3pv8juVRXpVU7ejOnqqt7eZG
         ME95R4y/vZXPU+6P/8ii8GjSJNFXGDLXI9Z/t2kg6WHg1fFqms1rg7Zq1+O21zZuPT
         cUDlNxU402r7WsCICOOH3bi5d5ymTLy4e6gE3w30dee4GgPffB9lobFFzlUV/KUZRf
         22S7I4EIfNyU6cN6l3gPd7uOYB6Aq8pgc3eoVA+l3rS8xTuRk+udUrvUqAbV0nWOD4
         r7XlCOplzuCc190BAE44/uUzwSu+oo3OrvB5qD5iyL9mqTgSrl5n7RXz4RD7ZiA+ft
         bM+KekEFtKgJg==
Date:   Tue, 10 Jan 2023 16:45:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>, james.clark@arm.com,
        nathan@kernel.org
Subject: Re: next-20230110: arm64: defconfig+kselftest config boot failed -
 Unable to handle kernel paging request at virtual address fffffffffffffff8
Message-ID: <Y72WEvxzARvnWVST@sirena.org.uk>
References: <CA+G9fYsns3krivbPSjQ1c1EQpVyd-bkW84MaUvqMTQr9c=iEaw@mail.gmail.com>
 <20230110163258.GC9436@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xgn8lZtczXaFspXy"
Content-Disposition: inline
In-Reply-To: <20230110163258.GC9436@willie-the-truck>
X-Cookie: Live free or die.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xgn8lZtczXaFspXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2023 at 04:32:59PM +0000, Will Deacon wrote:
> On Tue, Jan 10, 2023 at 09:44:40PM +0530, Naresh Kamboju wrote:

> > GOOD: next-20230109  (defconfig + kselftests configs)
> > BAD: next-20230110 (defconfig + kselftests configs)

> I couldn't find a kselftests .config in the tree (assumedly I'm just ont
> looking hard enough), but does that happen to enable CONFIG_STACK_TRACER=y?

It's adding on all the config fragments in

   tools/testing/selftests/*/config

which includes ftrace, which does set STACK_TRACER>

> If so, since you're using clang, I wonder if this is an issue with
> 68a63a412d18 ("arm64: Fix build with CC=clang, CONFIG_FTRACE=y and
> CONFIG_STACK_TRACER=y")?

ftrace also enables FTRACE.

> Please let us know how the bisection goes...

Not sure that Naresh has a bisection going, I don't think he's got
direct access to such a board.

--Xgn8lZtczXaFspXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO9lhEACgkQJNaLcl1U
h9DM1wf4sO6Fo8gQppTKumwECBNVeO+TdhIMe9/HbnqGY5crgsaaATNyv8BCnFVM
nFUDvsSm+/aaFl7JyP9j4G049XhajrXRY2pwDIZhd0AGWX8t4I30VSMwkrs55fS4
7akRRgvngaxcQtxof99W1r7zXCGIytUdyPbxwfwL7CdKuOGBdKNYMwzxDi3mDezU
4abIMUxqLdxfQ/NITR7843nADjUNvGSGWIkOxTMN7xt8qzTD+B8rGLRE85D94kr4
DZYbjqordIxk9uMuJ6rZzUkkHzg1Po7K7pL+O5yAEFIojUbyHVed2wdsw7W3Oxmi
5WyuaJVJ1ILFmCCqLBlrQdQCRrqm
=LS4A
-----END PGP SIGNATURE-----

--Xgn8lZtczXaFspXy--
