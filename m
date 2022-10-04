Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7285F4717
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJDQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJDQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6FF62D1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90DC9614D0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02D7C4347C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664899485;
        bh=3pV6AIwU55/8n3EL0wktKXf5jqjVPI7+4Jglg8t7kVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RZdEPknVjUyxSI+lDkW+g6t0IagpW3m4Qsjmn4D+o/r/h3vJLSR9nPNL8jCYSjimt
         Jplymem+ChCD5U1XdLY4L5Q4L/ew3lRucbuws0MWKrcR61WYlIAzgR1P7lodpwr6HO
         Om3tPeslshxNE7rkfbU6hi28HG6lLQUq480A3aP2DDsXJXaj5B1tlSw0zlKcjqJRoo
         cqucpJAZ+YlfsioFzHEqZYltPSsCXGUCk3U8FZUJEQ8CfetuJFc0HvGahL0m++0CI3
         nzwek0AcaEHoTo+ivAluSBN6mb1BTrqC7oKAPM/pktZhWervnaxrrHcAJlMDfoewde
         HbiJTeGEFV+zg==
Received: by mail-oi1-f175.google.com with SMTP id t79so1412465oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:04:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf1JswksoPsLIWBkMPGj0hGMnlNBEdQTAMacQ7dcAcPxjKWxndwT
        iVvJNIznvo1XSMaJgEbJK5B0vx4NbMcZRM2tWek=
X-Google-Smtp-Source: AMsMyM5Fh+SkCXkLs5GbiHKA2F9vSc94HUg9MCJ+RJZytX6MtXIRXSX9Hn+mcjCaX/DvTUIubPfj0S2ZQMoA7HfgZHs=
X-Received: by 2002:aca:6155:0:b0:353:e740:ce01 with SMTP id
 v82-20020aca6155000000b00353e740ce01mr212443oib.19.1664899484112; Tue, 04 Oct
 2022 09:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221003102921.3973-1-jszhang@kernel.org> <20221003102921.3973-2-jszhang@kernel.org>
In-Reply-To: <20221003102921.3973-2-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 5 Oct 2022 00:04:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSdVyAaM12T+7kXAdRPGS4VyuO08X1c7paE-n4Fr8OtRA@mail.gmail.com>
Message-ID: <CAJF2gTSdVyAaM12T+7kXAdRPGS4VyuO08X1c7paE-n4Fr8OtRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] riscv: process: fix kernel info leakage
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Oct 3, 2022 at 6:38 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> thread_struct's s[12] may contain random kernel memory content, which
> may be finally leaked to userspace. This is a security hole. Fix it
> by clearing the s[12] array in thread_struct when fork.
>
> As for kthread case, it's better to clear the s[12] array as well.
>
> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index ceb9ebab6558..52002d54b163 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -164,6 +164,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>         unsigned long tls = args->tls;
>         struct pt_regs *childregs = task_pt_regs(p);
>
> +       memset(&p->thread.s, 0, sizeof(p->thread.s));
> +
>         /* p->thread holds context to be restored by __switch_to() */
>         if (unlikely(args->fn)) {
>                 /* Kernel thread */
> --
> 2.37.2
>


-- 
Best Regards
 Guo Ren
