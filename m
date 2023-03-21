Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4F6C39BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCUTDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAAA5615D;
        Tue, 21 Mar 2023 12:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9CDEB8197D;
        Tue, 21 Mar 2023 19:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E993C433D2;
        Tue, 21 Mar 2023 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679425366;
        bh=DZpkA18Td+TB5rNUVUpYDY9F5hlRcbHEGl2DeB/6NyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpOA2WNAh8VlnTo7ntMdatWbklX1NH2ePrt1Ae0K/7iesieawSawMyYBoaoXWSGNd
         3ElE4SXR79PC+C7ePlHAAIC0UAnnMl7K5p49j8iYhrT2tINajduL9uBgJdKYVCMV+w
         kWq7rs0t+OyVKGPtJoo8k30E0cwyinciXm+gqmvnmNNCaqvElp5zPOXmxAfMeckKXA
         v0xcETFrUNx25uEwMGHcGZS8SXXF6uZFPko3nNoRUw1lTnleWvthEAJbj5V4wH32QV
         0PAFS+Mnq/EGsW3KveM1HbMXozjx2KYpSiGGzQh0h5b52WpriPpD1bGk3z5ctv/ve+
         93dte4wlEe1Cw==
Date:   Tue, 21 Mar 2023 19:02:40 +0000
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
Message-ID: <655ff114-99d2-4612-9167-cc8688f2b6b2@sirena.org.uk>
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZiGw5SLj3JFuo5Bg"
Content-Disposition: inline
In-Reply-To: <20230315051444.1683170-1-anshuman.khandual@arm.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZiGw5SLj3JFuo5Bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 10:44:34AM +0530, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
>=20
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers

While looking at another feature I noticed that HFGITR_EL2 has two traps
for BRBE instructions, nBRBINJ and nBRBIALL which trap BRB INJ and BRB
IALL.  Even if we don't use those right now does it make sense to
document a requirement for those traps to be disabled now in case we
need them later, and do so during EL2 setup for KVM guests?  That could
always be done incrementally.

I've got a patch adding the definition of that register to sysreg which
I should be sending shortly, no need to duplicate that effort.

--ZiGw5SLj3JFuo5Bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQZ/08ACgkQJNaLcl1U
h9A2Vwf+OlSvXdhyewDkyTQV0UhoX80wH9Aki8JnkTGnz29AiHDh9G1abuOJhkLZ
ipMeXx43tHlF37e44zk90Xl1TsyPuX0mCOIGwdfqyZCO8MPNA3nehtCuvm2pLgVd
ONOD6HZp9VM6sh3itx3EBI7Z37qrZ2MjO8VyYE0z6VHT2ZH3MJZaaUlqepBF2aP2
n3VpRR9ZdUpZI1oSlZJa1a9o4JRXknDgHKYkuj7Lp9naeBOuoNzSUm/SYB9RxDXu
FDU/RzYV6oCAfAEvb3H1Cr4SEpyK+TLcRGQ78JlFVZQOEAECtd8NjnxZebA9pRAK
XGMS2wcFvKk/Zqzbr6qxNyBJliQJsw==
=U6ZJ
-----END PGP SIGNATURE-----

--ZiGw5SLj3JFuo5Bg--
