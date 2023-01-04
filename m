Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C794765CEC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjADIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjADIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:51:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D012AFB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AC73B81440
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FAAC433F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822261;
        bh=BAa/Fb4Ybg4enWz1rxJLnXeOGBYh9ADpZmSkL1qRZg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mgkhdwz9K/1kUcvSJSL2wWD5otFO4451IjcYtsMOZO6Ftoeijv3wDlAlAYfk+VHlq
         LP4D+gTYwxTU0H0dOfwy+DDL1EVlnN7IiPb8Xfe56FUCwhyTUZZPsShuQJts5UQ7EA
         XKIqvQjDDGWb+8fyQfOfZc2HKZu7ZAF4lIQ7i9AUjVQ/lk8LfNJgDDUKuScog885p6
         YyhA5dU3apPaoESDuCV0owWErhIWkRBFHrhzMIqqm6+domJ//DRY+rFXUf9zQwEGQ0
         O9CLkQOdJ8CLZ2W/I+xPcREc5vywt1Q4s6FHeZOg9rjOo92MlXMPfoSJyAjKgNTLtq
         +uXEGb8iLrNYQ==
Received: by mail-ej1-f50.google.com with SMTP id gh17so81014367ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:51:01 -0800 (PST)
X-Gm-Message-State: AFqh2koOoLOaE4B4eBH7+HUWsS1oAlzAmjQ+ZeLwVEqWX7jVbPMn/rOc
        h9v8uihzAmzHFRHBTG6bJtJxJOdUubO1Z3C2SxQ=
X-Google-Smtp-Source: AMrXdXuUiz5OOTTeQZ0iuBYxnbOgxe/GyCd9Zfk6syDioGxgdqEXRSkq0CPWwolmi8ZjVryTX9WR0edCVP+atSz0rJ4=
X-Received: by 2002:a17:906:66d8:b0:7c4:efcf:3bc8 with SMTP id
 k24-20020a17090666d800b007c4efcf3bc8mr5732010ejp.702.1672822260122; Wed, 04
 Jan 2023 00:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20230104074146.578485-1-uwu@icenowy.me> <20230104074146.578485-3-uwu@icenowy.me>
In-Reply-To: <20230104074146.578485-3-uwu@icenowy.me>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 4 Jan 2023 16:50:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSb4qEPHw8hy1ro+UMoyKQaoQESNGveSGLdPL=cXac8jQ@mail.gmail.com>
Message-ID: <CAJF2gTSb4qEPHw8hy1ro+UMoyKQaoQESNGveSGLdPL=cXac8jQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] riscv: use VA+PA variant of CMO macros for DMA synchorization
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 3:43 PM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> DMA synchorization is done on PA and the VA is calculated from the PA.
>
> Use the alternative macro variant that takes both VA and PA as
> parameters, thus in case the ISA extension used support PA directly, the
> overhead for re-converting VA to PA can be omitted.
>
> Suggested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index d919efab6eba..a751f4aece62 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -19,13 +19,13 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>
>         switch (dir) {
>         case DMA_TO_DEVICE:
> -               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP_VPA(clean, vaddr, paddr, size, riscv_cbom_block_size);
ALT_CMO_OP -> ALT_CMO_OP_VPA, is the renaming necessary?

Others:
Reviewed-by: Guo Ren <guoren@kernel.org>

>                 break;
>         case DMA_FROM_DEVICE:
> -               ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP_VPA(clean, vaddr, paddr, size, riscv_cbom_block_size);
>                 break;
>         case DMA_BIDIRECTIONAL:
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP_VPA(flush, vaddr, paddr, size, riscv_cbom_block_size);
>                 break;
>         default:
>                 break;
> @@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>                 break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
> -               ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +               ALT_CMO_OP_VPA(flush, vaddr, paddr, size, riscv_cbom_block_size);
>                 break;
>         default:
>                 break;
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
