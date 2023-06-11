Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4998572B14B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFKKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544C10C9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 03:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8DDA60D33
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 10:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67459C433D2;
        Sun, 11 Jun 2023 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686478511;
        bh=wAjOnzPfZnGlA7O9lsl0eoKYfnAkZ5NGFNa2T2qGSKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzJPSZYj0GDOcWFsAzNWo0anRacJxynblCHDgzQ3locAUn+OGD9dgSPMF/7/eNjTv
         7veUUA4Me8CcccdrFknRkGRc/OMH/mP1QLOEyxcW+dG/RPsfoECu0eXYV2xPOh+CoQ
         TGxfVnJDIt1yb0e6cqPcLq5QFMC5Y0GK5DVUN2YuRuizZc+/OqqAmMcDzW3B42/oeI
         vK7whovWacTtQxjNzR3+Qms2X9fq0KpJ94EYCA6m4AW5cWK3Fz5HsSrr+MBRoi/Vjx
         liR9OwGhzY0Df9BKYDMiISyIwaUNY/17b28ZIOCuDMTDkiYPIn9Z55/Q622qGL/tF2
         JxvY203wwQSJA==
Date:   Sun, 11 Jun 2023 11:15:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move memblock_allow_resize() after lm is ready
Message-ID: <20230611-canning-antiquity-b60b360ea683@spud>
References: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
 <20230610-ultimate-moisture-630c7672358b@spud>
 <tencent_72C3F44CD3565F83575F5632D9574C331208@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tcjkC733yzWvP198"
Content-Disposition: inline
In-Reply-To: <tencent_72C3F44CD3565F83575F5632D9574C331208@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tcjkC733yzWvP198
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 07:31:03AM +0800, Woody Zhang wrote:
> On Sat, Jun 10, 2023 at 04:44:19PM +0100, Conor Dooley wrote:
> >On Sat, Jun 10, 2023 at 07:43:20AM +0800, Woody Zhang wrote:
> >$subject: "riscv: move memblock_allow_resize() after lm is ready"
> >
> >s/lm/linear map/ if you resubmit, please.
>=20
> Thanks, will send a v2.
>=20
> >
> >> The initial memblock metadata is accessed from kernel image mapping. T=
he
> >> regions arrays need to "reallocated" from memblock and accessed through
> >> linear mapping to cover more memblock regions. So the resizing should
> >> not be allowed until linear mapping is ready. Note that there are
> >> memblock allocations when building linear mapping.
> >>=20
> >> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> >
> >What commit does this fix?
>=20
> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
>=20
> Will add this tag in v2.

b4 should pick up fixes tags from replies, you shouldn't need to
resubmit for that alone.

Cheers,
Conor.

--tcjkC733yzWvP198
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIWepwAKCRB4tDGHoIJi
0jFLAP4/9k6xvXQItKC98hykUy2EbSm56xcc/rZyYd0282CxiQD+IbGElxKlcEeF
wREvj1JS6GIfm4zWBbYCWkvL6C0TkgM=
=sFlO
-----END PGP SIGNATURE-----

--tcjkC733yzWvP198--
