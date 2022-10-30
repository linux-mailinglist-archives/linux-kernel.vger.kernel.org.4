Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7E61268A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ3ADv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 20:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ3ADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 20:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214BE18376
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 17:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3100B80D79
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CEBC43140
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667088226;
        bh=N8BoS/M4L7MN742ZawYJ9PH0fLN3a+oJBqMQwatxgWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R67YY1Gav64QhlE6uoqvYWw7WVMiCUgujQzsj0WitIB76bL2THVR2Vk6/2TpfFrqa
         puQfQpLcRiO3N2pF7tAfk4IAU/1cXWQR5cDL3iptfwWThnbaPT4nb6iZLz5Khh33WB
         fQEaxIlijK4X5wAnptBRF85szuartiKcMyeW7lVyLwBByFPllysiXZOC1jwLZG2o1G
         Cxw7hNLJ6YchlUK1AUfVbWGHWGTrq+V88iMgPdICTr+UwrA+XRbRJzLHE4ebpXnAym
         gqNtA/y9epgwGn/g5AhbpooiKl0nln5US2i5eTPUH7AyK5dVxNYSFEnM9sUTQh31wI
         FdGdWtT10S7XA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13ba9a4430cso10160802fac.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 17:03:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf2SSDbUXRBkhnGY0YCd1o/YtcHtzaVLoU0+WXkkNR+/1qsQP6YP
        4ayXPFCsPIdsvpTKujRmvv4op8G3aWTVA8OToiU=
X-Google-Smtp-Source: AMsMyM7u7FnY5J/Sn92YX/tmBWBfNwC2I1fvd6MSTja2mLLJiocBWd2dIHfYQgMB6ADsv+9K64aQBQL/1+HvAwmdW+c=
X-Received: by 2002:a05:6870:64a1:b0:13c:d09d:79f9 with SMTP id
 cz33-20020a05687064a100b0013cd09d79f9mr830568oab.112.1667088225682; Sat, 29
 Oct 2022 17:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221029113450.4027-1-jszhang@kernel.org>
In-Reply-To: <20221029113450.4027-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Oct 2022 08:03:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSqUtU77HvEsQi8+akod4Fn1pEe2REH2nae39dK2VsacA@mail.gmail.com>
Message-ID: <CAJF2gTSqUtU77HvEsQi8+akod4Fn1pEe2REH2nae39dK2VsacA@mail.gmail.com>
Subject: Re: [PATCH] riscv: process: fix kernel info leakage
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 7:44 PM Jisheng Zhang <jszhang@kernel.org> wrote:
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
>
> Previously, it's one of the series of "riscv: entry: further clean up
> and VMAP_STACK fix". This is a fix, so I move it out of the series and
> send it separately
>
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
Tested-by: Guo Ren <guoren@kernel.org>

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
