Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566167AA33
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjAYGKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjAYGKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:10:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F311664;
        Tue, 24 Jan 2023 22:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FA816142A;
        Wed, 25 Jan 2023 06:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D255C4339C;
        Wed, 25 Jan 2023 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674627010;
        bh=QYJeYY20BgDsud5Zu/+g6nvvqlsity5d/L+YjBlxeHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VOzeM42ezsu51+T8Hb30AvXQ0ZUM0DzN4QuOUyY63hkaI2CDYQBNHYHT2byfV8zqZ
         dJ3QDSZEeEURjcWbpLNqgCEu838NLikF+WDV56MNG44SeMDAUyC7MuT7OB1QUt3Oiv
         xeBeP6va03f+H4xFSfcprVtr6c4K/EmlZa66aEnsQwKtbsT9SIcy9TPv/Dm2RabCEm
         vnMRS5D48mCxSk1Aqwx2A1qUxba0wd+M6A3eAY0SV7KUBmTI6L5dNL1sWrh8u8/24z
         1SXDQR/wP+KEaAP/lPLguE2kaYdspnmrkLMGaOeGy/sfC3Eg4zdtNPGnrJ57bXcW0h
         ad2Ht113YlRTg==
Received: by mail-lf1-f50.google.com with SMTP id f34so27201578lfv.10;
        Tue, 24 Jan 2023 22:10:10 -0800 (PST)
X-Gm-Message-State: AFqh2ko8ZtfrDxdrUiP3n9LUAddqh5jAqUYpMdWO7pyxLMODz63aXxTu
        4Nv1CJyCculEKt2WC+ptl2DfiNK6dZjf7hp6Uzw=
X-Google-Smtp-Source: AMrXdXuIktI9baA33gg3/3x1La8ODdbzgS9/HPcKm2Sp+dkBqV0jiRRF9wG3LmaU3IvLUgLVBadKFq9LLW/qEoCxHdM=
X-Received: by 2002:a05:6512:308a:b0:4d1:3e32:5436 with SMTP id
 z10-20020a056512308a00b004d13e325436mr3405315lfd.215.1674627008613; Tue, 24
 Jan 2023 22:10:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674617130.git.jpoimboe@kernel.org> <2f6329ffd9674df6ff57e03edeb2ca54414770ab.1674617130.git.jpoimboe@kernel.org>
In-Reply-To: <2f6329ffd9674df6ff57e03edeb2ca54414770ab.1674617130.git.jpoimboe@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 24 Jan 2023 22:09:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW40jEiyp0ogsO6oH_frpFCmiioSHrMOKkwGcZ8_6w5dZA@mail.gmail.com>
Message-ID: <CAPhsuW40jEiyp0ogsO6oH_frpFCmiioSHrMOKkwGcZ8_6w5dZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/module_64: Fix "expected nop" error on module re-patching
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        live-patching@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 7:38 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> When a module with a livepatched function is unloaded and then reloaded,
> klp attempts to dynamically re-patch it.  On ppc64, that fails with the
> following error:
>
>   module_64: livepatch_nfsd: Expected nop after call, got e8410018 at e_show+0x60/0x548 [livepatch_nfsd]
>   livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
>   livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'
>
> The error happens because the restore r2 instruction had already
> previously been written into the klp module's replacement function when
> the original function was patched the first time.  So the instruction
> wasn't a nop as expected.
>
> When the restore r2 instruction has already been patched in, detect that
> and skip the warning and the instruction write.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/powerpc/kernel/module_64.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 016e79bba531..bf1da99fff74 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -502,6 +502,7 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
>  static int restore_r2(const char *name, u32 *instruction, struct module *me)
>  {
>         u32 *prev_insn = instruction - 1;
> +       u32 insn_val = *instruction;
>
>         if (is_mprofile_ftrace_call(name))
>                 return 0;
> @@ -514,9 +515,18 @@ static int restore_r2(const char *name, u32 *instruction, struct module *me)
>         if (!instr_is_relative_link_branch(ppc_inst(*prev_insn)))
>                 return 0;
>
> -       if (*instruction != PPC_RAW_NOP()) {
> +       /*
> +        * For livepatch, the restore r2 instruction might have already been
> +        * written previously, if the referenced symbol is in a previously
> +        * unloaded module which is now being loaded again.  In that case, skip
> +        * the warning and the instruction write.
> +        */
> +       if (insn_val == PPC_INST_LD_TOC)
> +               return 0;

Do we need "sym->st_shndx == SHN_LIVEPATCH" here?

Thanks,
Song


> +
> +       if (insn_val != PPC_RAW_NOP()) {
>                 pr_err("%s: Expected nop after call, got %08x at %pS\n",
> -                       me->name, *instruction, instruction);
> +                       me->name, insn_val, instruction);
>                 return -ENOEXEC;
>         }
>
> --
> 2.39.0
>
