Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896DC69E5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjBURK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjBURKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:10:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C286A8;
        Tue, 21 Feb 2023 09:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3039CB8101C;
        Tue, 21 Feb 2023 17:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860EEC433D2;
        Tue, 21 Feb 2023 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999447;
        bh=8u6YDNc9yy+b2FhC1l0g6cqoBb6ZINj+1i2P4m3Xzwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdYFftk+6mfKGKJOCRNmPo/FcmGyA9bUoIxhDwtbpO8mD5Z38jIc1eRd64veNMbiK
         lNUU4+PQ0XYkBokC+bcklQeI9R7e+ij34o7+JiegYT/bSs0SFiZclzUYdV8LIbEnli
         FRiS2oMShuJkRrprJDKLsopsp2csI/rtQYFRbqW3vIbBOIPb2T3CcH9UyxGSiJzD4q
         pqXQy7aaFCsThi6oSqUwJMzXaj0UZlxdoLaEZRBBQ/0hHD2BKiD1B05mqC+wBhw5Ka
         yvpPjBq7HanEGeDORkJmLQB1ZAgZhGRlAzBZzJ0e05WHq1ZHHRlRfk/BdGqpizXFAG
         0oSb8FfW1ZfyQ==
Date:   Tue, 21 Feb 2023 17:10:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] reset: starfive: Factor out common JH71X0 reset
 code
Message-ID: <Y/T7EYISh0Zx9xWY@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-6-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j5HBhd3GwB1YKNyE"
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-6-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j5HBhd3GwB1YKNyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 10:46:31AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> The StarFive JH7100 SoC has additional reset controllers for audio and
> video, but the registers follow the same structure. On the JH7110 the
> reset registers don't get their own memory range, but instead follow the
> clock control registers. The registers still follow the same structure
> though, so let's factor out the common code to handle all these cases.

I think you split this out compared to the previous version of t he
series, and does look as described.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--j5HBhd3GwB1YKNyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/T7EAAKCRB4tDGHoIJi
0rVDAQCw3IZVbliwp83FiyQgHXpcHyUxrgL7eMvpDar3M4hgrwD/Vm55fmaYja6Y
OJb164Udw7J1FW02H+ccQHNJXHsUdQs=
=UY4d
-----END PGP SIGNATURE-----

--j5HBhd3GwB1YKNyE--
