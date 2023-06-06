Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD4E724834
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjFFPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjFFPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D9E10D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08725610A6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBF3C433EF;
        Tue,  6 Jun 2023 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686066591;
        bh=0d32+WCapjwVnQgaci/Xdg3bjraWXhNb2bKu6buPcK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IoZi0BQW66anQarIWSMnPwiut1QOJ9Q+u7ExVx3uFR+qftDx3biEjQ+U+w8aiHAvd
         xijGUPsZ3PdGeSWthdwbJmya9zMUgYGdj7JWkOOmAMyVucibyR0+kdLfkneyKyP2XX
         lRlI4M2d5BkG+eFM0NHenP0AfNyW1R1J50ehfrrGhOrAF6fuVCgLhMMLX4aCJGo84+
         TU/DRAXRf8egURMhhWLq/DSJB53CLKxi3YEkI/2Odc0mEYbaRVmiS9B8Q9Sx2QHlQi
         328SLQ2WvI7DemhS7edZdynQHYf7qLNXpTlDejTdHnolQaKDfEhphP75lXJh/zped3
         HF7FHPcjs7thA==
Date:   Tue, 6 Jun 2023 16:49:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 -next 2/2] RISC-V/perf: Use standard interface to get
 INTC domain
Message-ID: <20230606-scribe-discuss-b884605cb870@spud>
References: <20230605143512.707533-1-sunilvl@ventanamicro.com>
 <20230605143512.707533-3-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gwX9jHrHYHhC33x/"
Content-Disposition: inline
In-Reply-To: <20230605143512.707533-3-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gwX9jHrHYHhC33x/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 08:05:12PM +0530, Sunil V L wrote:
> Currently the PMU driver is using DT based lookup to
> find the INTC node for sscofpmf extension. This will not work
> for ACPI based systems causing the driver to fail to register
> the PMU overflow interrupt handler.
>=20
> Hence, change the code to use the standard interface to find
> the INTC node which works irrespective of DT or ACPI.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 4f3ac296b3e2..0bc491252a44 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -739,7 +739,6 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, =
struct platform_device *pde
>  {
>  	int ret;
>  	struct cpu_hw_events __percpu *hw_events =3D pmu->hw_events;
> -	struct device_node *cpu, *child;
>  	struct irq_domain *domain =3D NULL;
> =20
>  	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> @@ -756,20 +755,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>  	if (!riscv_pmu_use_irq)
>  		return -EOPNOTSUPP;
> =20
> -	for_each_of_cpu_node(cpu) {
> -		child =3D of_get_compatible_child(cpu, "riscv,cpu-intc");
> -		if (!child) {
> -			pr_err("Failed to find INTC node\n");
> -			of_node_put(cpu);
> -			return -ENODEV;
> -		}
> -		domain =3D irq_find_host(child);
> -		of_node_put(child);
> -		if (domain) {
> -			of_node_put(cpu);
> -			break;
> -		}
> -	}
> +	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> +					  DOMAIN_BUS_ANY);

This riscv_get_intc_hwnode stuff is horrific, but that's besides the
point.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>  	if (!domain) {
>  		pr_err("Failed to find INTC IRQ root domain\n");
>  		return -ENODEV;
> --=20
> 2.34.1
>=20

--gwX9jHrHYHhC33x/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH9VmgAKCRB4tDGHoIJi
0oFHAQCK0+LA4Hkdi2DZBS7TOsIy0vK07SpAap5peSAzvtbB9AD9HXu6oqENThnH
LWiUD5Y9PW0nx9C+Y9alXKaylYBWPwk=
=BJKN
-----END PGP SIGNATURE-----

--gwX9jHrHYHhC33x/--
