Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4623B7247DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjFFPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjFFPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E74E7E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A9B63517
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBBC433D2;
        Tue,  6 Jun 2023 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686065734;
        bh=Xt4audZ365Q+PvUv6uNxy2e/yIbqQ28OmbVNfLY4CKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhNyr11CmQawhEhlHUx6nQMF29fI9ghKpUoFa2oDTUfY710tgzYk6Jwjvl64G/tDI
         yMnd7Cwk1FNic9l+wO1mxHnW8bioxqlAWLEXHZWFSovLzW88CrrjlWX6o0WVriC7qF
         HcycoIyk2rDpPXP7X/ltVVilykY/KsGVD5K1CjvmJD83nHZSBFBak89AA4qBgYsIIA
         D7py/B4/U4ETH9BhM4NdZ2y6xT6nom8LWvv4T+1cSTWte224TlUeU2QXg7R7ph9V4n
         9ILlUgN5vHsGBoqpHcKJiOpY6D1VQ6Snm0sE1/KFdknH4rFAD0/JETsrf0zz+0Zx2o
         qSLmbZ9YwkBjA==
Date:   Tue, 6 Jun 2023 16:35:29 +0100
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
        Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 -next 1/2] RISC-V: ACPI : Fix for usage of pointers in
 different address space
Message-ID: <20230606-conduit-cupped-1791a640713b@spud>
References: <20230605143512.707533-1-sunilvl@ventanamicro.com>
 <20230605143512.707533-2-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HLHcBDvaBo7VA5cu"
Content-Disposition: inline
In-Reply-To: <20230605143512.707533-2-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HLHcBDvaBo7VA5cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Mon, Jun 05, 2023 at 08:05:11PM +0530, Sunil V L wrote:
> The arch specific __acpi_map_table can be wrapper around either
> early_memremap or early_ioremap. But early_memremap
> routine works with normal pointers whereas __acpi_map_table expects
> pointers in iomem address space. This causes kernel test bot to fail
> while using the sparse tool. Fix the issue by using early_ioremap and
> similar fix done for __acpi_unmap_table.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305201427.I7QhPjNW-lkp@i=
ntel.com/

Is this
Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
?
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/kernel/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index df5a45a2eb93..5ee03ebab80e 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -204,7 +204,7 @@ void __init __iomem *__acpi_map_table(unsigned long p=
hys, unsigned long size)
>  	if (!size)
>  		return NULL;
> =20
> -	return early_memremap(phys, size);
> +	return early_ioremap(phys, size);
>  }
> =20
>  void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> @@ -212,7 +212,7 @@ void __init __acpi_unmap_table(void __iomem *map, uns=
igned long size)
>  	if (!map || !size)
>  		return;
> =20
> -	early_memunmap(map, size);
> +	early_iounmap(map, size);
>  }
> =20
>  void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> --=20
> 2.34.1
>=20

--HLHcBDvaBo7VA5cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH9SQQAKCRB4tDGHoIJi
0hZTAQDzgYgjwG/DSfMNyBQuzsY/PvRtR+1BBA2sQdrN9IKUQQEAgKPZEeWa6ykw
OcKB1bLk8MSPeMYY+K3Qn7D0stu5UQs=
=JNG7
-----END PGP SIGNATURE-----

--HLHcBDvaBo7VA5cu--
