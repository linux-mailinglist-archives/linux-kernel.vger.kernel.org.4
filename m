Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70366B5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAPDSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjAPDSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4EE76A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE74660E08
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CAFC433D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673839093;
        bh=xN0nB9m8Mlu0zwKCceXo+pC9SAQhuK5iA+VXSdLnQs8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HVVvza9ZGJjkt7sEzxGmzuTLqg2RZGgzD8Tze/iheITECJkV/S7NTDVP69amQFcFC
         /fcSVKAlc9Gi8QoJ3DqLRPfEcfYrIv9ffeCSSAOXyqZmF1tpukkiCMD0SLHBkSuZmp
         xO1jIMsoG2R2UrL6bFVM1kOsP28bPF/T6XSz2ChjDBaWNlSedO/+J35NXEN2fekFHw
         O1eW5Ifd5kIKW7sayhbQtyIGsJ5vTygrp+pzYBOl/8uspmWvUX0KT6idqbM/OFvVE/
         mINqOD13F4ol7uVPGeiXkvAzCTRIR1HwKXeADVisTilaWA6Q3n1JIL03MP6ROLB0fe
         SPlhpSLtl0tQA==
Received: by mail-ej1-f47.google.com with SMTP id vm8so65013253ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:18:13 -0800 (PST)
X-Gm-Message-State: AFqh2kqUzsA18uMeHOqYAPGAXwEVC8Gse8OJUq420xCkRElDs6B5XjIv
        9tXLLkKnCC+eZLZexkt4mKCh9+bUoKj5+yoAM4M=
X-Google-Smtp-Source: AMrXdXujtdw++p7a6byoW27xHy/lM3IXLBFnXPf4aQg/GiD1L3SxcQbhdq+FU2oajvc8xr5/AjtWlWWQNdjjCcICCcI=
X-Received: by 2002:a17:906:5616:b0:852:132b:2d7e with SMTP id
 f22-20020a170906561600b00852132b2d7emr2248742ejq.224.1673839091387; Sun, 15
 Jan 2023 19:18:11 -0800 (PST)
MIME-Version: 1.0
References: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn> <1673688444-24251-7-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1673688444-24251-7-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 16 Jan 2023 11:18:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H768YCCdpn62tBAzbT0W24KNK-vnFnPDmMW-+X5_EdxgA@mail.gmail.com>
Message-ID: <CAAhV-H768YCCdpn62tBAzbT0W24KNK-vnFnPDmMW-+X5_EdxgA@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] LoongArch: Use common function sign_extend64()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I queued this patch, but others need more reviews.

Huacai

On Sat, Jan 14, 2023 at 5:27 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> There exists a common function sign_extend64() to sign extend a 64-bit
> value using specified bit as sign-bit in include/linux/bitops.h, it is
> more efficient, let us use it and remove the arch-specific sign_extend()
> under arch/loongarch.
>
> Suggested-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/inst.h   | 8 --------
>  arch/loongarch/kernel/alternative.c | 6 +++---
>  2 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index e0771d2..ba18ce8 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -397,14 +397,6 @@ static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
>         return val < (1UL << bit);
>  }
>
> -static inline unsigned long sign_extend(unsigned long val, unsigned int idx)
> -{
> -       if (!is_imm_negative(val, idx + 1))
> -               return ((1UL << idx) - 1) & val;
> -       else
> -               return ~((1UL << idx) - 1) | val;
> -}
> -
>  #define DEF_EMIT_REG0I26_FORMAT(NAME, OP)                              \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
>                                int offset)                              \
> diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kernel/alternative.c
> index c5aebea..4ad1384 100644
> --- a/arch/loongarch/kernel/alternative.c
> +++ b/arch/loongarch/kernel/alternative.c
> @@ -74,7 +74,7 @@ static void __init_or_module recompute_jump(union loongarch_instruction *buf,
>         switch (src->reg0i26_format.opcode) {
>         case b_op:
>         case bl_op:
> -               jump_addr = cur_pc + sign_extend((si_h << 16 | si_l) << 2, 27);
> +               jump_addr = cur_pc + sign_extend64((si_h << 16 | si_l) << 2, 27);
>                 if (in_alt_jump(jump_addr, start, end))
>                         return;
>                 offset = jump_addr - pc;
> @@ -93,7 +93,7 @@ static void __init_or_module recompute_jump(union loongarch_instruction *buf,
>                 fallthrough;
>         case beqz_op:
>         case bnez_op:
> -               jump_addr = cur_pc + sign_extend((si_h << 16 | si_l) << 2, 22);
> +               jump_addr = cur_pc + sign_extend64((si_h << 16 | si_l) << 2, 22);
>                 if (in_alt_jump(jump_addr, start, end))
>                         return;
>                 offset = jump_addr - pc;
> @@ -112,7 +112,7 @@ static void __init_or_module recompute_jump(union loongarch_instruction *buf,
>         case bge_op:
>         case bltu_op:
>         case bgeu_op:
> -               jump_addr = cur_pc + sign_extend(si << 2, 17);
> +               jump_addr = cur_pc + sign_extend64(si << 2, 17);
>                 if (in_alt_jump(jump_addr, start, end))
>                         return;
>                 offset = jump_addr - pc;
> --
> 2.1.0
>
