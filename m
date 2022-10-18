Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33445602D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJRN4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJRN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:56:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C3CF874;
        Tue, 18 Oct 2022 06:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E30ECB81F67;
        Tue, 18 Oct 2022 13:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE0CC433D6;
        Tue, 18 Oct 2022 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666101390;
        bh=qJ6vThAIE44VrwsfcxpiUgz6ZVzbsL/WPJFVhMYDSlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rx45QDPaSXJRF3zL7QHyHW33SWwq46lbIpEKwn6nTDAUPNQZLeiZDVidaRmpSzOfx
         8ltj05lsXIF/1lfBJLtknkl6Ph11dGi2QR9s5k+n71W3I9HqVb5jQX/v6OEX5VQpJG
         ByLs8gBcjQsUFWEnYHwjPRY+FtGKzjqmH0i6kP6IDt14E39MlohU6kIuCSydNaMTdL
         Wu67/PqcFV4JjiKO3AMSY5/7VtTOFt3wkUL9NZpVJq4yNZEmhQxyrTiE2g+b52Dntf
         koBythbCrMqOegKPPT5bW3trCbewh37572jmOg1VjVX/tXD3SMYqLJKcAXxcMulb3S
         D0ebFN3mraDnw==
Date:   Tue, 18 Oct 2022 14:56:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V4 1/7] arm64/perf: Add BRBE registers and fields
Message-ID: <Y06wiI2hgsz5QPTh@sirena.org.uk>
References: <20221017055713.451092-1-anshuman.khandual@arm.com>
 <20221017055713.451092-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GFneNsft22FHtzEa"
Content-Disposition: inline
In-Reply-To: <20221017055713.451092-2-anshuman.khandual@arm.com>
X-Cookie: Lake Erie died for your sins.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GFneNsft22FHtzEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 11:27:07AM +0530, Anshuman Khandual wrote:

I spotted one typo below but otherwise this looks good!

> +# This is just a dummy register declaration to get all common field masks and
> +# shifts for accessing given BRBINF contents.
> +Sysreg	BRBINF_EL1	2	1	8	0	0

This seems reasonable to me, others may disagree.

> +Sysreg	BRBCR_EL1	2	1	9	0	0
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:9
> +Field	8 	FZP
> +Res0	7
> +Enum	6:5	TS
> +	0b1	VIRTUAL

I'd have expected this to be written as 0b01.  Doesn't make any
practical difference though.

> +Sysreg	BRBFCR_EL1	2	1	9	0	1

> +Field	16	EnL

This is "EnI" in DDI0487I.a.

--GFneNsft22FHtzEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNOsIcACgkQJNaLcl1U
h9B8mQf/YGziWfn/iGHXXqP1g1TRcgidWG2RKf40LqRQFjE9CFIZXE9CFKF/phii
c6DnpdV6gRyWoQUN/0YyyYoVQqoOiZuLiec5/5izwOR/sz5KHAsiOmSBNouC2URX
HXB7X+ISeV8yJnmHv6LSTEPo9Wli55CDlcFa7r6gknyC6jz7pYG+jEBw6EGzLSAW
5S4ulolNpsNeWvzCXm9lqljVU8U9LYkKESspFoLMylIf+E5kY1T7Nl70g+ZM0wpo
3Y2eJZmaGg+tnXp7jPz4x9iJEpnc3YPdhTgOWKWSTS56qwxAo8jplreQdfEHdVwB
qXammSL9S07Ms9UB+Bo8nigp3ywwZw==
=cqL5
-----END PGP SIGNATURE-----

--GFneNsft22FHtzEa--
