Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464375B8525
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiINJhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiINJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:37:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5C1CFD1;
        Wed, 14 Sep 2022 02:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E34DB816F4;
        Wed, 14 Sep 2022 09:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DDAC433D6;
        Wed, 14 Sep 2022 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663148151;
        bh=rjKoWpCPT6MqSNSlR40glepnjwId59HKNZTsSUmJ5Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hM/uXR1fV1nmxauituR2Mo+zpNwoeNdELsDqyZU3tRnTlM2OeW3uQM/NNHbjFsToM
         KcdNtrC/UisnNdiG74vTnWNL8Z8nmeiwllJzIyKAr6W1vHraFuCY55um2lMrOtPEXs
         DD3hvGStO/LYSZ7QgoPPhUzaFxE52p1fdsW3ZGJWjhiJLX0K3PlzAZ9bKpdswmAxSV
         EnmAKcQhCzO/N2ecdhHV00lTB1PmixIy+bukuNA3O7v4hU+hfMi9h82TBaSN8syHWI
         C9AjAipnHowAkgwUd0rS2B/I1JJrpbCBO2dAoYAUG5WLDaEH7NuvPHbgIihHqikNwW
         WGLYDmE05hN/A==
Date:   Wed, 14 Sep 2022 10:35:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Message-ID: <YyGgdPzJG3+0nCC4@sirena.org.uk>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-4-anshuman.khandual@arm.com>
 <Yx8GBq1FJN49iJs9@sirena.org.uk>
 <84683aa7-58ad-85f8-327b-daed2f704834@arm.com>
 <YyBs1PJwNoNYv4NJ@sirena.org.uk>
 <c4800957-825c-a5c7-d8d4-946d9c6cdf6c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qd4GMgCzvle7Q0M+"
Content-Disposition: inline
In-Reply-To: <c4800957-825c-a5c7-d8d4-946d9c6cdf6c@arm.com>
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


--Qd4GMgCzvle7Q0M+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2022 at 09:09:10AM +0530, Anshuman Khandual wrote:

> Something like the following change moves the buffer allocation off the stack,
> although it requires updating the driver, and buffer assignment during a PMU
> interrupt. But it does seem to work (will require some more testing).

Yeah, looks like it should do the trick.

> +
> +               events->branch_records = kmalloc(sizeof(struct brbe_records), flags);
> +               WARN_ON(!events->branch_records);

No need for the WARN_ON(), if we run out of memory the memory
management code is already very loud about it.

--Qd4GMgCzvle7Q0M+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMhoHMACgkQJNaLcl1U
h9DcGQf+OXKRIda5SncAckSpROuZfhe2UQmsc1HWBOT6Fh/spEWHHaY/qBM7f4pb
cV/ZmKOyWxVQ4NrMAp2QqN2rq4EUGc//GYlWZbwNJ8l+YqA0oo60MVFD4U06T9zE
vduwXIxKA2hcIzFceYmRfDGNx55TPEQsBuv15eiCa+llq5mu7VUhTgYjXZlNj506
YqQCX2lirtAPn0WrFURTnnzUPQCp9Su10G1AwbGj1UA9YTbC1ezXL/jp8KvkNU02
uc7P3OexKcJ2MuLcvkauJvrPI0i1w4lBt6sEHyswdXfmfElb3JH+X6WG8KwWR+rQ
i7lTTsVtEiv9UowTSTZ9kclR07YujQ==
=V9+X
-----END PGP SIGNATURE-----

--Qd4GMgCzvle7Q0M+--
