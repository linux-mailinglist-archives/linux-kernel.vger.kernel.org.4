Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDB72ACA6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjFJPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjFJPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C80270B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B136B60DF0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDD7C433D2;
        Sat, 10 Jun 2023 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686411605;
        bh=/Ofoh0I1XnlXPrUcylaPl3zI8vSXYdbK5AqQOlhyJDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTaoUii41+/zbN5OnM2Xrz2U59v9x8zJlTSmJR5e9KOVhvdnpBNuwO7wFfRZjHk1N
         BlbVt6KQEdybsiIJwqbeltnfJvzTD/Z1og+HgFBmanz8ghO5DTsqw+F218G+A38q0x
         YKeKD0W8cvRfPS3BpG0BShu+OuPfGmdzD9ECN7SpVRxCrbY+0jpBYHt4L+EV5nX3Gn
         6o1LHFnz3lOA15xh9m+934txSGLram2NB4QHAqjpyPiQsEzZuqDZWDgftHZoyvmBZL
         bROCWlt2SjnE6MsckVPKaNGPC3q1hC1WIei/MaAKe8XOSMvmRy1p6KU4ck6oTJMf/B
         cDsoi+TJrxWig==
Date:   Sat, 10 Jun 2023 16:39:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, steven.price@arm.com,
        vincenzo.frascino@arm.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, jeeheng.sia@starfivetech.com,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH V2 3/4] riscv: hibernate: remove WARN_ON in
 save_processor_state
Message-ID: <20230610-immerse-stained-e07fa52fa978@spud>
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
 <20230609075049.2651723-4-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rZXGa7jE6687ew2c"
Content-Disposition: inline
In-Reply-To: <20230609075049.2651723-4-songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rZXGa7jE6687ew2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 03:50:48PM +0800, Song Shuai wrote:
> During hibernation or restoration, freeze_secondary_cpus
> checks num_online_cpus via BUG_ON, and the subsequent
> save_processor_state also does the checking with WARN_ON.
>=20
> In the case of CONFIG_PM_SLEEP_SMP=3Dn, freeze_secondary_cpus
> is not defined, but the sole possible condition to disable
> CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
> We also don't have to check it in save_processor_state.
>=20
> So remove the unnecessary checking in save_processor_state.

In the future, please write function with a () in commit
messages, so freeze_secondary_cpus() etc.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Fixes: c0317210012e ("RISC-V: Add arch functions to support hibernation/s=
uspend-to-disk")
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/kernel/hibernate.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> index 395f835f067c..86f1c9ab6b0b 100644
> --- a/arch/riscv/kernel/hibernate.c
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -119,7 +119,6 @@ int pfn_is_nosave(unsigned long pfn)
> =20
>  void notrace save_processor_state(void)
>  {
> -	WARN_ON(num_online_cpus() !=3D 1);
>  }
> =20
>  void notrace restore_processor_state(void)
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--rZXGa7jE6687ew2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZISZTgAKCRB4tDGHoIJi
0vJyAP9EKfmf2sqixNnKmlQNpfPiKuUhZxNlT3lhCKkpFnqHngEAhvOHTbsZXvDm
ySeqtdfo8Ycj13L8JonolaCh/5o9uQA=
=qLxy
-----END PGP SIGNATURE-----

--rZXGa7jE6687ew2c--
