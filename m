Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6F6A656B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCACW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCACWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:22:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9E303F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:22:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D478B80ED2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E47C4339E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677637340;
        bh=U33P0NyrqWLHKl8GZ4YuPEs18eKHtUPecDCiQFZw5yo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fDVDgZ/vwaUIdgMHa//um6SNWnks3Bi8gYwRRPL32QTYJ8F2ODysA8RcYJzlsfaHH
         VXJzzyJ9MsBw0uEjeed4hiRpJsTknxgZQ/4cQK/+bhfQkVprvlNEFF1I3o4pVBx8/4
         jLl2842aAEgUn2nJyCmjuTf+JZ95SSdMPQXe33EnLRYceDv1kN4QPG2OOe8yNKK6Cy
         rsj5dPNjBmtlK88vHSVxjVt/ZxRZcwQMGxj32UzD1R2UJcHVXM8Kfio+bE07QWXpO4
         og0IpT8mGQIqHj0iGYIonCiaDIO/SIsCwUJO3QuDRMNfZoxuucWHpIN1FcvmNoCZji
         +fdimsgww8jkw==
Received: by mail-ed1-f54.google.com with SMTP id s26so47949988edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:22:20 -0800 (PST)
X-Gm-Message-State: AO0yUKVWb8H1PjEhB4K+sf6s4REaxpmXLjt4riMhK2iGOff7WMcj4jDE
        37sPOgVRzOX4i7WcrjPoGbiN4zhcVTtiwEfD8mc=
X-Google-Smtp-Source: AK7set8CC2LfBvQLsabLWQBvlwpphENbr9MVwvCMYqTjstMKH69q4QthOs9G4L7V4Vq2KUIHfX1hvVsfJmMLxKAIzSM=
X-Received: by 2002:a17:907:2ce6:b0:8df:dc64:30d2 with SMTP id
 hz6-20020a1709072ce600b008dfdc6430d2mr10384264ejc.1.1677637339026; Tue, 28
 Feb 2023 18:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20230228215435.3366914-1-heiko@sntech.de> <20230228215435.3366914-2-heiko@sntech.de>
In-Reply-To: <20230228215435.3366914-2-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Mar 2023 10:22:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJRy1ABdNTHJY+4SZpyAFnRgr6POT37JjS6bV_r+d7bQ@mail.gmail.com>
Message-ID: <CAJF2gTTJRy1ABdNTHJY+4SZpyAFnRgr6POT37JjS6bV_r+d7bQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] RISC-V: define the elements of the VCSR vector CSR
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        samuel@sholland.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Mar 1, 2023 at 5:54=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wro=
te:
>
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].
>
> Define constants for those to access the elements in a readable way.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/csr.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index add51662b7c3..8b06f2472915 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -176,6 +176,11 @@
>  #define ENVCFG_CBIE_INV                        _AC(0x3, UL)
>  #define ENVCFG_FIOM                    _AC(0x1, UL)
>
> +/* VCSR flags */
> +#define VCSR_VXRM_MASK                 3
> +#define VCSR_VXRM_SHIFT                        1
> +#define VCSR_VXSAT_MASK                        1
> +
>  /* symbolic CSR names: */
>  #define CSR_CYCLE              0xc00
>  #define CSR_TIME               0xc01
> --
> 2.39.0
>


--=20
Best Regards
 Guo Ren
