Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E712373E3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjFZPvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFZPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA41703;
        Mon, 26 Jun 2023 08:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8FAF60E97;
        Mon, 26 Jun 2023 15:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92307C433C0;
        Mon, 26 Jun 2023 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687794694;
        bh=cU5DSziNAOrXhpvgrl/54P8ukmcWLFJDRxZj1+C07pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEIcsGKJEiUuMAsVgngWJ09kq0Prk8Vkujv5K98yNtKPrwajkjYWIRoQ+SZ2sO1Nv
         qIn29afaLaDMc9UCXW2icRn/mFa6GprGZFAScXGDH5A+PQ9Jv+1gInyRQsgZ4i/XCD
         iaP2yaBYcLTkk+Pu7sYivagJqraj9OEV5Vw8YPuGD8KqmBlrr58WOnrik21/nZKC8K
         bGgqmVxvV8fuvDeSmNmpiZT1qhUEJBbFAaXO4KajjeyV9RnngckTutcrzupp9eH1q9
         CdeO8R+Mx1jKBx2d6Fh2M8fFWoR1XJTEXe0+k0KleXdttDl12MHZzRyfLgGT6mzCu0
         pvYogUFZ4lxZA==
Date:   Mon, 26 Jun 2023 16:51:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] RISC-V: don't parse dt/acpi isa string to get
 rv32/rv64
Message-ID: <20230626-dragonish-romp-9acf4846ae01@spud>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-silk-colonize-824390303994@wendy>
 <20230626-e3ea7beb39c584bfbf7ee836@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FRGPr8JGNqOl1Avz"
Content-Disposition: inline
In-Reply-To: <20230626-e3ea7beb39c584bfbf7ee836@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FRGPr8JGNqOl1Avz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 05:14:15PM +0200, Andrew Jones wrote:
> On Mon, Jun 26, 2023 at 12:19:39PM +0100, Conor Dooley wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > @@ -333,8 +335,6 @@ static int c_show(struct seq_file *m, void *v)
> > =20
> >  		of_node_put(node);
> >  	} else {
> > -		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
> > -			print_isa(m, isa);
> > =20
>=20
> Extra blank line here to remove. Actually the whole 'else' can be removed
> because the print_mmu() call can be brought up above the
> 'if (acpi_disabled)'

Can it be? I intentionally did not make that change - wasn't sure
whether re-ordering the fields in there was permissible.

One of the few things I know does parsing of /proc/cpuinfo is:
https://github.com/google/cpu_features/blob/main/src/impl_riscv_linux.c
and that doesn't seem to care about the mmu, but does rely on
vendor/uarch ordering.

Makes me wonder, does ACPI break things by leaving out uarch/vendor
fields, if there is something that expects them to exist? We should
not intentionally break stuff in /proc/cpuinfo, but can't say I feel any
sympathy for naively parsing it.

> >  		print_mmu(m);


--FRGPr8JGNqOl1Avz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJm0AQAKCRB4tDGHoIJi
0gB8AP9iCRWLKExtLLeh6ETpNmcB/2kGTzWN4Odb8Z0n6C+fHQEAnKMQtHI5zAwA
7wiZ9pJqqpKM4N2JJI1eCwyfl2JjfAQ=
=OAfc
-----END PGP SIGNATURE-----

--FRGPr8JGNqOl1Avz--
