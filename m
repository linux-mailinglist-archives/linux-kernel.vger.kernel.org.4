Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021965BE79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjACKzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbjACKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:54:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4852DEB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80CEDB80E90
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02EAC433D2;
        Tue,  3 Jan 2023 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672743294;
        bh=sWxywAmA3iT6Hg1imz0WMwNxq0Cs4LLATsivcCc+QW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VeVQqIlzGiVZWzBhGkkCBfpFlIBtW5EdfD1QOxvUUoWCxCHFILUCD4mAarM5gcO46
         y4OOW9iEg8OPNI0T11JJXPCBfCQmiP9GaFIp2426HcSzddGmdZ1h7LIh21jU0hGx/L
         CWNLtm8eYyyy48i0eG/rGdpbntrlskKqWEdVDOxpv5zSAAQAhdDx57nCn6+z4mnxhC
         MBaRP5T9qN0ceAn7D2HGboPvY37X4x0CqFIyzvL8K+5Lo4FPDH5W9MOQSIg6RXsMsa
         yz9beXa+40HSgZGspMcSPrrYBJmw2pPu58aPNvoY+dNuq9sMTyBaiv8Y6W2mSdfyPf
         NFu/e0JZmUIRg==
Date:   Tue, 3 Jan 2023 10:54:48 +0000
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
Message-ID: <Y7QJeOj+rDnXzhFm@spud>
References: <20221228161915.13194-1-samuel@sholland.org>
 <Y6yLMwhSypqp5+Ir@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uM3g/cThuDJq0xJr"
Content-Disposition: inline
In-Reply-To: <Y6yLMwhSypqp5+Ir@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uM3g/cThuDJq0xJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 06:30:11PM +0000, Conor Dooley wrote:
> Hey Samuel,
>=20
> On Wed, Dec 28, 2022 at 10:19:12AM -0600, Samuel Holland wrote:
> > I want to convert the axp20x PMIC poweroff handler to use the sys-off
> > API, so it can be used as a fallback for if the SBI poweroff handler
> > is unavailable. But the SBI poweroff handler still uses pm_power_off, so
> > done alone, this would cause the axp20x callback to be called first,
> > before the SBI poweroff handler has a chance to run.
> >=20
> > In order to prevent this change in behavior, the SBI poweroff handler
> > needs to be converted to the sys-off API first, at a higher priority.
> >=20
> > This series performs the conversion, after accounting for the fact that
> > the SBI poweroff handler is registered quite early during boot.
> >=20
> > The first patch is a dependency for both this series and the PSCI
> > series[1], so I would like to get at least patch 1 merged soon.
> >=20
> > [1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland=
=2Eorg/
> >=20
> >=20
> > Samuel Holland (3):
> >   kernel/reboot: Use the static sys-off handler for any priority
> >   riscv: sbi: Share the code for unsupported extension warnings
> >   riscv: sbi: Switch to the sys-off handler API
>=20
> Not what other stuff has reboot support, so I gave it a whirl on

I happened to see this today and could barely understand what I wrote.
s/Not what/Not sure what"

> PolarFire SoC & it seemed to work as expected:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks,
> Conor.



--uM3g/cThuDJq0xJr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7QJeAAKCRB4tDGHoIJi
0nXSAQDaMeufEd7ejOdgNH13SEKuhv7tu2IlGvzJWSdg2bSWWQEA3ffySTJbn0PB
mD3bZmsio+Kk5ty/XaAjoP6WUfFbHQs=
=ip+Q
-----END PGP SIGNATURE-----

--uM3g/cThuDJq0xJr--
