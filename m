Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E85F9C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiJJKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJJKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:20:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93885072A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65DDDB80E71
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251C3C433C1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397248;
        bh=w80vbmdBsUQ38PcZM7KUgaYXUtnKGnyzONFOJgcKacs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BK2lXICfa3SPleuwgbpQxkIsMz0HV4Htjyru/OJC3f9R1anlVMGRK0VeZqXp8mL1i
         HFoW5ZUtCx5J8gkwRQZwLZ5+QrBW4u4cWU2r2XQZd30zwi3cHL/4YcETgbBiISQvKA
         uvcx1vvaJic5nzXJ3cbYKSzhCBcvn3p8tyVkjMWO8+L1ZKovuBB2rq81BvlGZfkkmk
         V7y7Gc7G/lLaIrURQMNcK2kBxaDCUEVzlaD1ADwDMAhIAFnkHGzi3sAon98oBB5EsH
         MweUFZ8iZw/lakZVuhmLiJ1IuQWbnUnBZtqGDYjLDLsRp4a79ADvZCIQuNK6HBdKjm
         O3r9D/jJcF5wg==
Received: by mail-lf1-f42.google.com with SMTP id bu25so15929504lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:20:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ZPBE0/C03bj56N6cMxzl4UrIvhGoKGh5r0W+nOEZ3bb/i7hX2
        KyOtNeogbILgsAQ4+su2XPuqOC7MfNhWn7LBZCY=
X-Google-Smtp-Source: AMsMyM5244zjH5Fytb6hVEoSiq8q5sgmu6ZQ/7Swti5msJ1aEam/Gk6oXbr15EANbFpsa4I/lF+zTIGZx9q22rZlWNI=
X-Received: by 2002:a05:6512:104a:b0:4a2:9c7b:c9c with SMTP id
 c10-20020a056512104a00b004a29c7b0c9cmr5413624lfb.122.1665397246153; Mon, 10
 Oct 2022 03:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221010095346.1957-1-thunder.leizhen@huawei.com> <20221010095346.1957-2-thunder.leizhen@huawei.com>
In-Reply-To: <20221010095346.1957-2-thunder.leizhen@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Oct 2022 12:20:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
Message-ID: <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Fix the following warnings:
>  warning: incorrect type in initializer (different address spaces)
>     expected unsigned short [noderef] __user *register __p
>     got unsigned short [usertype] *
>  warning: cast removes address space '__user' of expression
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/kernel/traps.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 20b2db6dcd1ced7..34aa80c09c508c1 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>                         }
>                 } else {
>                         if (thumb)
> -                               bad = get_user(val, &((u16 *)addr)[i]);
> +                               bad = get_user(val, &((u16 __user *)addr)[i]);
>                         else
> -                               bad = get_user(val, &((u32 *)addr)[i]);
> +                               bad = get_user(val, &((u32 __user *)addr)[i]);
>                 }
>
>                 if (!bad)
> @@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>         if (processor_mode(regs) == SVC_MODE) {
>  #ifdef CONFIG_THUMB2_KERNEL
>                 if (thumb_mode(regs)) {
> -                       instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> +                       instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);

Shouldn't this be __user as well? (and below)

>                         if (is_wide_instruction(instr)) {
>                                 u16 inst2;
> -                               inst2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
> +                               inst2 = __mem_to_opcode_thumb16(((__force u16 *)pc)[1]);
>                                 instr = __opcode_thumb32_compose(instr, inst2);
>                         }
>                 } else
>  #endif
> -                       instr = __mem_to_opcode_arm(*(u32 *) pc);
> +                       instr = __mem_to_opcode_arm(*(__force u32 *) pc);
>         } else if (thumb_mode(regs)) {
>                 if (get_user(instr, (u16 __user *)pc))
>                         goto die_sig;
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
