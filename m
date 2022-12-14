Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAB64CD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiLNPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiLNPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:39:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5672A0;
        Wed, 14 Dec 2022 07:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9767DB818E5;
        Wed, 14 Dec 2022 15:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97066C433D2;
        Wed, 14 Dec 2022 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671032343;
        bh=WV8Ks/w5GzfCJYbihJ02iBiB3DlG+fE3MpPxGRtjLmQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mCZlGxg2ymMDDCfzP4rC3sLdn5J/Hz+r6apM01YKMc0RIzYAq4W7tE+voD9fmQpqV
         wa8E+dT5tcbtVSwXZfEpEmsVSNwuUVh+Vodq8o69cDRHycQY5okpYZyaLWCj6SzcKH
         ySMEPQH7dy85bfjNkGpwSp18YJ83uC0yLvcX4N9ONikOWXzqRbMIWa8PTkhhNrnanv
         jRxbnBC1Z+nRh6b9NbsLSlKt4TRxtw9cXEX43gO0FrIPdN3RPHmu5IaK7/HzZimgt1
         BefqCk8JgOg2cBYdGP2y4QT9CR3A5n9rdFeKKmvrOSJLlbFt4TH/kUVOM23qTvR1YO
         m5/hhblbLwfnQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH] riscv: Allow to downgrade paging mode from the command
 line
In-Reply-To: <20221214143311.960266-1-alexghiti@rivosinc.com>
References: <20221214143311.960266-1-alexghiti@rivosinc.com>
Date:   Wed, 14 Dec 2022 16:38:57 +0100
Message-ID: <87cz8m3sha.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b56a0a75533f..8140fefe0e57 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -752,12 +752,35 @@ static void __init disable_pgtable_l4(void)
>   * then read SATP to see if the configuration was taken into account
>   * meaning sv48 is supported.
>   */
> -static __init void set_satp_mode(void)
> +static __init void set_satp_mode(uintptr_t dtb_pa)
>  {
>  	u64 identity_satp, hw_satp;
>  	uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & PMD_MA=
SK;
>  	bool check_l4 =3D false;
>=20=20
> +#ifndef CONFIG_KASAN
> +	/*
> +	 * The below fdt functions are kasan instrumented, since at this point
> +	 * there is no mapping for the kasan shadow memory, this can't be used
> +	 * when kasan is enabled.
> +	 */
> +	int chosen_node;
> +
> +	chosen_node =3D fdt_path_offset((void *)dtb_pa, "/chosen");
> +	if (chosen_node >=3D 0) {
> +		const char *cmdline =3D fdt_getprop((void *)dtb_pa, chosen_node,
> +						  "bootargs", NULL);

The command line handling needs to honor CONFIG_CMDLINE_FORCE and
CONFIG_CMDLINE_EXTEND (which makes it possible to use no{4,5}lvl *and*
KASAN ;-)).


Bj=C3=B6rn
