Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02E720137
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjFBMMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjFBMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F71A7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E750164F95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0191EC433EF;
        Fri,  2 Jun 2023 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685707942;
        bh=DeR9jdn2aD0pXg/74mAViVzW94m5Xm9sixmeSjtcjZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRKfhj6azKRNMDRoKT176p6SviYbYAcDaCrNwEoS+5eWKC8zUGP+NLL9JrZtaIxtO
         AUBv8BL38DEP6RVYeB2N0m1VzUMHYcgwn6zqPonzvFpQ3AqVTKI8U97/A8pC56K4F/
         MyYmHCj8R6ymzV4pekn7LXHxXmS96zw9DlNbrg49xEDuszjqrUUHZZ5/Cj/1rePaps
         kTl/AY2yHSb0WS0fBmklefs270O5xwrmXOrFTE2Z604gjuusa7NKIxLyTa6TIil/Mx
         WE1+og8y+THp1avk9b2O3yeul40mtFwx6IS6YDS7io7q+arxOzFENNgndTXgcecfCz
         jWM4cNNZj2awQ==
Date:   Fri, 2 Jun 2023 13:12:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 14/14] arm64/sysreg: Convert TRBIDR_EL1 register to
 automatic generation
Message-ID: <4de1ec32-f07b-4eca-99e2-f71a08f5cd5b@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-15-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTas1DyUP+FyjLbQ"
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-15-anshuman.khandual@arm.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTas1DyUP+FyjLbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 11:55:52AM +0530, Anshuman Khandual wrote:
> This converts TRBIDR_EL1 register to automatic generation without
> causing any functional change.

> +Sysreg	TRBIDR_EL1	3	0	9	11	7
> +Res0	63:12
> +Field	11:8	EA

EA is another field which looks like it should be an enum, as with the
others this shouldn't be a blocker and could be done incrementally.

> +Res0	7:6
> +Field	5	F
> +Field	4	P
> +Field	3:0	Align

Align arguably too though really it's just encoding the relevant power
of 2 with the enum coming from the fact that it's limited to at most 2KB
alignment so a Field may well make more sense.

Reviewed-by: Mark Brown <broonie@kernel.org>

--dTas1DyUP+FyjLbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR53J8ACgkQJNaLcl1U
h9D2Ngf8DdpbgSIzxvhHKCEPrhEYGWbxkXAIKE7vu6AkRiuMTW+NzqcTLVist3RW
uzmGA6pm0laJ6OXKAfmZukpjaK3cJ4p9FhNjyofdQSXCmnchxS0YWWKhyGaC79Kd
nD9j+wIT+xzjqBnGeaGQK6vaD3UFrKuEnsR/Wf3QEXRXmfswcOASgtznD6wj0zRX
R+IHPS7cK02lstXMTgn7lMechfO2rKil45TBKgI1P16VmDkC4uUJNf4oaEXgOu2/
aF0Ans5ZUwY3xK1qyCpzR9n2hNdBZKPafAfkj22HzCgWrM/qfxyXGH/NkNYSeH3e
LVjIfQY0oesrSXu4zO3Wt0Zaiu6q3g==
=OgiS
-----END PGP SIGNATURE-----

--dTas1DyUP+FyjLbQ--
