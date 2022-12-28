Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA16585C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiL1SaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiL1SaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:30:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B313DCB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 10:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68D01B818BD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C18C433EF;
        Wed, 28 Dec 2022 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672252218;
        bh=8GdpfCPYNbZ7pONcybw0AZexxDzJ9PmxSxjOD45MToI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMN8sn2qVZcrzRNGqHFFHegiRkzijJ7lgl63Nluh/32moJDMxsjBBpdfOHtOU2m/P
         JUZxv0u0XGMe/kTDCobfG+b7TcBZvMm0Q4s1a2Oha7ctEXj9ryy2aC97Mt2O9Qfz4p
         EM4BdlRjung9oxz/0osT1n6rkrsrTazQ2xn77BQSgRROGcMA5Wh8s4mXvCSowlG+o4
         8ZJcLZrcVfEyr0IZLvSdIEwTzpcRbGOGIXq4q/Sffb+OMU6WW4gPwa7Cz+haYYqKaJ
         cm0n6r4+pJi0//NsLGHYXoaXer2sWhqyFJize9T7g27HkcJ+U31DzSwh0WR25lDlIn
         4Iu49epuwIBPQ==
Date:   Wed, 28 Dec 2022 18:30:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH 0/3] riscv: sbi: Switch to the sys-off handler API
Message-ID: <Y6yLMwhSypqp5+Ir@spud>
References: <20221228161915.13194-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ATLP0lEXvRX45tso"
Content-Disposition: inline
In-Reply-To: <20221228161915.13194-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ATLP0lEXvRX45tso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Samuel,

On Wed, Dec 28, 2022 at 10:19:12AM -0600, Samuel Holland wrote:
> I want to convert the axp20x PMIC poweroff handler to use the sys-off
> API, so it can be used as a fallback for if the SBI poweroff handler
> is unavailable. But the SBI poweroff handler still uses pm_power_off, so
> done alone, this would cause the axp20x callback to be called first,
> before the SBI poweroff handler has a chance to run.
>=20
> In order to prevent this change in behavior, the SBI poweroff handler
> needs to be converted to the sys-off API first, at a higher priority.
>=20
> This series performs the conversion, after accounting for the fact that
> the SBI poweroff handler is registered quite early during boot.
>=20
> The first patch is a dependency for both this series and the PSCI
> series[1], so I would like to get at least patch 1 merged soon.
>=20
> [1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.o=
rg/
>=20
>=20
> Samuel Holland (3):
>   kernel/reboot: Use the static sys-off handler for any priority
>   riscv: sbi: Share the code for unsupported extension warnings
>   riscv: sbi: Switch to the sys-off handler API

Not what other stuff has reboot support, so I gave it a whirl on
PolarFire SoC & it seemed to work as expected:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ATLP0lEXvRX45tso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6yLMwAKCRB4tDGHoIJi
0ivzAP9+SH0Lql0XKHnaLv07MiLUmZWgUzA9fyFMuC2SL6mJvAEA+nzYanZ4TgWy
B8EyY10df0N49zc5ohweBmmjHCZz3A0=
=7zvo
-----END PGP SIGNATURE-----

--ATLP0lEXvRX45tso--
