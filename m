Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF35472ACA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjFJPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjFJPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B062C270B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D78560BFF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35220C433D2;
        Sat, 10 Jun 2023 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686411681;
        bh=6uyaujNQDJF61dpwxgeEr+l/0vMjSzCrIltBVri0m2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6UfCqbTsPq9cww1yKJXgdO4LS6+QahtoJCpqa52NZ+0VmIeDeUTRkz9UHvsWu/gp
         x+8r7+I990/kp4ZjJ1aLOe+IGGrmOuSPsQIX5EonAyOGTB/dud8sYqG3Z/TYh0g3Hg
         nVi3V9XldQ7p5QW97cGbKkZJB/kHbqW23YIC0edViTzogk6ss29laVuW15NPVKUW9s
         Q+R+3OuKwRFT7I7leWPPWSApvz36Cw9vgcv60tSOneZqOA0CYUoDHLIR8vuWr+XZ3I
         O01ExP4aKHa08tcuzYuifajH0s5GovNtfqVz4x0UEnjmjer2OZdATHzwIB1mAX3vah
         AIAcIkb09eBQg==
Date:   Sat, 10 Jun 2023 16:41:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Woody Zhang <woodylab@foxmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
Message-ID: <20230610-ability-mockup-f6aa71bad6a1@spud>
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
 <20230607-jogging-grudging-70dede86bc53@spud>
 <CAHVXubggydGfNu3OzcxWXREJbB+G9dmr9sFD7vXhVxbG-N58Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57IlWUOTjI1jlSeK"
Content-Disposition: inline
In-Reply-To: <CAHVXubggydGfNu3OzcxWXREJbB+G9dmr9sFD7vXhVxbG-N58Pg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--57IlWUOTjI1jlSeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 09:49:44AM +0200, Alexandre Ghiti wrote:
> On Wed, Jun 7, 2023 at 8:17=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > +CC Alex, you should take a look at this patch.
> >
> > On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
> > > It's possible that early_init_fdt_scan_reserved_mem() allocates memory
> > > from memblock for dynamic reserved memory in `/reserved-memory` node.
> > > Any fixed reservation must be done before that to avoid potential
> > > conflicts.
> > >
> > > Reserve the DTB in memblock just after early scanning it.
> >
> > The rationale makes sense to me, I am just wondering what compelling
> > reason there is to move it away from the memblock_reserve()s for the
> > initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
> > should be the sufficient minimum & would keep things together.

> Thanks Conor.
>=20
> So the patch looks good to me.
>=20
> But I find this fragile:
>=20
> - we do not check memblock_reserve() return value to make sure the
> reservation really happened (and quickly looking at the code, I'm not
> even sure it returns an error if the region was already allocated).
> - we have to make sure no memblock allocation happens before setup_bootme=
m().
> - we also have to check that no fixed memblock_reserve() happens after.
>=20
> The last 2 points may sound natural, but we'll have to take great care
> when adding some code around here. I'm working on an "early boot
> document" and I'll add something about that, but a runtime thing would
> be way better IMO.
>=20
> You can add:
>=20
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

btw Alex/Woody, what is the appropriate Fixes tag here?

Cheers,
Conor.

--57IlWUOTjI1jlSeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZISZnQAKCRB4tDGHoIJi
0jitAPsGETvv+Ge9i+UXddSumDMVVeXOHKBeG62OPGpGaIKpswEA6ADb2o38+VgM
owK9g/aeShlCxmEjpwj9hVDei/uaHAM=
=dJEZ
-----END PGP SIGNATURE-----

--57IlWUOTjI1jlSeK--
