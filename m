Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3670C487
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEVRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjEVRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3BA12B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98BCE61B9A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BD8C433EF;
        Mon, 22 May 2023 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684777399;
        bh=V9lNYJ1FODYT/ky9VFFLcxluNDglQQa2NTObXOY9NqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2JQPcGf9ehkYuyB4drRzH9X3jFTW0zdwhiVIwkYZz4U7SXS/fRPccRy8ZfjC01ma
         1yvJlrYo5hcRl1L6OlZL6wMaUrTxDTnx9RMY923HodgZHt/f7qZHOBFQeuDs8y64wr
         pUvEad5kpUcFs6LScL1YSG276tgOlPkwFeUA1cQ6FC6FgwZNzvzJxoGfCiiZurEoW/
         a3MyXDgIdqcIYMccdrqs+FQxjG4QaKgAMjFFp6K/Vq/TVMshBAfVlQmcf/qyrExxee
         YMNC9iW3n1YydFlsH9ISJRCddRkSs3yF/nE7Hc/JUNFLxgOMRqFnPkusMDDgDzF0Aq
         Qo8G0qvCwL97Q==
Date:   Mon, 22 May 2023 18:43:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        christoph.muellner@vrull.eu, David.Laight@aculab.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v3 2/2] riscv: Add Zawrs support for spinlocks
Message-ID: <20230522-karaoke-reproduce-be1bb503b49c@spud>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <20230521114715.955823-3-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IYoWI8tHVLtleIAG"
Content-Disposition: inline
In-Reply-To: <20230521114715.955823-3-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IYoWI8tHVLtleIAG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Heiko,

On Sun, May 21, 2023 at 01:47:15PM +0200, Heiko Stuebner wrote:
> From: Christoph M=FCllner <christoph.muellner@vrull.eu>
>=20
> The current RISC-V code uses the generic ticket lock implementation,
> that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
> Currently, RISC-V uses the generic implementation of these macros.
> This patch introduces a RISC-V specific implementation, of these
> macros, that peels off the first loop iteration and modifies the waiting
> loop such, that it is possible to use the WRS.STO instruction of the Zawrs
> ISA extension to stall the CPU.
>=20
> The resulting implementation of smp_cond_load_*() will only work for
> 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> This is caused by the restrictions of the LR instruction (RISC-V only
> has LR.W and LR.D). Compiler assertions guard this new restriction.
>=20
> This patch uses the existing RISC-V ISA extension framework
> to detect the presence of Zawrs at run-time.
> If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.
>=20
> The whole mechanism is gated by Kconfig setting, which defaults to Y.
>=20
> The Zawrs specification can be found here:
> https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
>=20
> Signed-off-by: Christoph M=FCllner <christoph.muellner@vrull.eu>
> [rebase, update to review comments]
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

I do intend actually reviewing these two, but busy this week with dt
stuff! In the interim, got some build complaints..

gcc-13 & clang-16 allmodconfig:
kernel/rcu/rcuscale.c:819:3: warning: logical not is only applied to the le=
ft hand side of this comparison [-Wlogical-not-parentheses]

k210_nommu_defconfig:
include/linux/atomic/atomic-arch-fallback.h:249:23: error: implicit declara=
tion of function 'smp_load_acquire' [-Werror=3Dimplicit-function-declaratio=
n]
include/linux/atomic/atomic-arch-fallback.h:265:17: error: implicit declara=
tion of function 'smp_store_release' [-Werror=3Dimplicit-function-declarati=
on]

Thanks,
Conor.

--IYoWI8tHVLtleIAG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGupsgAKCRB4tDGHoIJi
0qJzAQDWqaUWfrtpQ6OYOg/TnaIxCu72rx/hm9EmU/Ml4he2BAD/RiZe8j6xfCGn
UBL1FP69hwwqCPGkT5OGlsqx7ZrruQM=
=Zm9B
-----END PGP SIGNATURE-----

--IYoWI8tHVLtleIAG--
