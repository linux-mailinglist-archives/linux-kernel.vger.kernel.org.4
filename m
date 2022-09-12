Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570325B57EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiILKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE4F1D0E2;
        Mon, 12 Sep 2022 03:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EDA60B52;
        Mon, 12 Sep 2022 10:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF8C433C1;
        Mon, 12 Sep 2022 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662977545;
        bh=VIKYDpqyGbroUoNfBiwgULkR1+Ovyz/eqrGuBsLpdLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r747C6I5iUCHTk7nAe+/r3uIi1HvgeSSyWLtqhCl5tLu175t2mZKpynMnUL7IXDZi
         Yd6dT8KgoRHVk0YTzXgvLsksasJWzB2pH1CKK1rovoYjMJnVDxvV2C/LPmlS3+JShm
         koe5P/sNmACKrfY6Jb5ejTTX3n7M5Gd8NRBEYSYMKIcomj9ABljDqpIuChSfbdFapE
         vJyJQiw4UGoFRYIoCNiLybHNiDq8QgAcYKoxPB/sRv/RMgOGPnHwD9Svt8XD4+2Aft
         WNkSQ7IH+Zq7XNlXEHZgtB4cmA612L4TAklKlh+mm1jca02V7xLO/8+3IGl1A+mMfg
         lDviOiPbf4pUw==
Date:   Mon, 12 Sep 2022 11:12:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Message-ID: <Yx8GBq1FJN49iJs9@sirena.org.uk>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5XiVip4R+LpcC6tm"
Content-Disposition: inline
In-Reply-To: <20220908051046.465307-4-anshuman.khandual@arm.com>
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


--5XiVip4R+LpcC6tm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2022 at 10:40:42AM +0530, Anshuman Khandual wrote:

> +	/* Captured BRBE buffer - copied as is into perf_sample_data */
> +	struct perf_branch_stack	brbe_stack;
> +	struct perf_branch_entry	brbe_entries[BRBE_MAX_ENTRIES];

It looks like perf_branch_entry is intended to be the variably
sized entries array at the end of perf_branch_stack?  That could
probably do with being called out if it's the case.  It feels
like it would be clearer and safer to allocate these dynamically
when BRBE is used if that's possible, I'd expect that should also
deal with the stack frame size issues as well.

--5XiVip4R+LpcC6tm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMfBgMACgkQJNaLcl1U
h9BcUQf+NthdBgB+7qMcAeRLU5+8cGaYh4H8LiNFo9B7mWOF8fxLqYmdbA/IqptW
jJJ7+yEuNsJBVUo2nlcQPoWxhwfLS2LFi4LsckC0zMNujzzN7SdKzxym62sop1eX
ArMmIVYR55msvOch5GK36xXGEldpXacL4aksPddKvoFT+j6owOLV2SLwSc3SJX2R
P/DG8564fgjhYewhbJf/0piJUu4Rf8dF0g76+8eIVsTJjdOGDB4Y+mpnWWiukHe/
QMOjyo1RJQ6SmvRLm4Ff82Vj78ViTJ6EAr8jbnPBK0OL8Dtf9biVuNnxtERtdYb/
oItU2hje6TMiYpLwLUS9NwgWXlWnxg==
=nu0L
-----END PGP SIGNATURE-----

--5XiVip4R+LpcC6tm--
