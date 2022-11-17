Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD862D0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiKQBqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQBqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:46:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7886A6AE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD87BB81F5F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBDBC43145
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668649561;
        bh=ZQ72dHxfzCyCaQz3CU/waK5F/XDoW5QrMiejHqa2A18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TXRyYqgDoXpXPTDkrlZNSzTNGzU4TOEnQ2rnkMaDzv34sguJbjL5nZNVoGa7wIm6Y
         mXe53vdgSiOSF6wypK0FTsZJ0zr1FWrJ7kp1K1wSKnf9WJSz5dWBTxtbyP8zW6Lf10
         tcwjMpQR7JMy4Y6XDYjFYRbounQF0ezpqWz3GBc6UH/aPLzCPdHKQFGjU20CcuU7ag
         03lUXe2ZkCpgEFUqA7AT3lwpVz5roEMlQGWDEKF85BqtuTdbmYSzlzn23NTXq2tJQo
         0rE09jf4Ep5EirEW+ovcsNrjlLtxWpnoe45YMdnQvdNXl/a/xDCKp0q3FTfgrniSc8
         q65w9AL62srUw==
Received: by mail-ed1-f48.google.com with SMTP id u24so458931edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:46:01 -0800 (PST)
X-Gm-Message-State: ANoB5pn7wSqT+p4pGuUKctPLXGIi4GySpCZSPwST7ZDUHKK2OvKk3ik3
        cp0nDIPjmSvDOG4MY6TY66VXYngLDW4BnjAYXP8=
X-Google-Smtp-Source: AA0mqf5vGCdSJ+MQ4ohyTYv8MIycakRYqNFyn2MWQYAZgcTJhU/qVqT81Z7wWxd8fEErepAsnpVV9AmbGLA17OpBPRM=
X-Received: by 2002:aa7:db91:0:b0:458:bd09:1b20 with SMTP id
 u17-20020aa7db91000000b00458bd091b20mr337228edt.176.1668649559600; Wed, 16
 Nov 2022 17:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20221116031305.286634-1-suagrfillet@gmail.com>
In-Reply-To: <20221116031305.286634-1-suagrfillet@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 17 Nov 2022 09:45:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0jFkynErVVnQPoqzo-_cWRPRCYZLwRyTpuaxu7NVdWQ@mail.gmail.com>
Message-ID: <CAJF2gTS0jFkynErVVnQPoqzo-_cWRPRCYZLwRyTpuaxu7NVdWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] riscv/ftrace: make function graph use ftrace directly
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this series could base on the following:
https://lore.kernel.org/linux-riscv/20220921034910.3142465-4-guoren@kernel.org/

They all modified the mcount-dyn.S.

On Wed, Nov 16, 2022 at 11:13 AM Song Shuai <suagrfillet@gmail.com> wrote:
>
> In RISC-V architecture, when we enable the ftrace_graph tracer on some
> functions, the function tracings on other functions will suffer extra
> graph tracing work. In essence, graph_ops isn't limited by its func_hash
> due to the global ftrace_graph_[regs]_call label. That should be corrected.
>
> What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> graph use ftrace directly") that uses graph_ops::func function to install
> return_hooker and makes the function called against its func_hash.
>
> This series of patches makes function graph use ftrace directly for riscv.
>
> If FTRACE_WITH_REGS isn't defined, ftrace_caller keeps ftrace_graph_call
> so that it can be replaced with the calling of prepare_ftrace_return by
> the enable/disable helper.
>
> As for defining FTRACE_WITH_REGS, ftrace_caller is adjusted to save the
> necessary regs against the pt_regs layout, so it can reasonably call the
> graph_ops::func function - ftrace_graph_func. And ftrace_graph_[regs]_call
> and its enable/disable helper aren't needed.
>
> The tests generated by CONFIG_FTRACE_STARTUP_TEST have passed in the local
> qemu-system-riscv64 virt machine. The following is the log during startup.
>
> ```
> Nov 15 03:07:13 stage4 kernel: Testing tracer function: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #1:
> Nov 15 03:07:13 stage4 kernel: (1 0 1 0 0)
> Nov 15 03:07:13 stage4 kernel: (1 1 2 0 0)
> Nov 15 03:07:13 stage4 kernel: (2 1 3 0 365)
> Nov 15 03:07:13 stage4 kernel: (2 2 4 0 399)
> Nov 15 03:07:13 stage4 kernel: (3 2 4 0 146071)
> Nov 15 03:07:13 stage4 kernel: (3 3 5 0 146105) PASSED
> Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #2:
> Nov 15 03:07:13 stage4 kernel: (1 0 1 589 0)
> Nov 15 03:07:13 stage4 kernel: (1 1 2 635 0)
> Nov 15 03:07:13 stage4 kernel: (2 1 3 1 2)
> Nov 15 03:07:13 stage4 kernel: (2 2 4 125 126)
> Nov 15 03:07:13 stage4 kernel: (3 2 4 146001 146078)
> Nov 15 03:07:13 stage4 kernel: (3 3 5 146035 146112) PASSED
> Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion safe: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing ftrace regs: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer nop: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer irqsoff: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup:
> Nov 15 03:07:13 stage4 kernel: sched: DL replenish lagged too much
> Nov 15 03:07:13 stage4 kernel: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_rt: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_dl: PASSED
> Nov 15 03:07:13 stage4 kernel: Testing tracer function_graph: PASSED
> ```
>
> Note that the changes of mcount-dyn.S conflicts with this unmerged
> commit (riscv: entry: consolidate general regs saving/restoring).
> https://lore.kernel.org/linux-riscv/20221103075047.1634923-15-guoren@kernel.org
>
> Changes since v1
> -  fixed the checkpatch warnings in patch 1
> Link: https://lore.kernel.org/linux-riscv/20221115061525.112757-1-suagrfillet@gmail.com
>
> Song Shuai (3):
>   riscv/ftrace: add ftrace_graph_func
>   riscv/ftrace: SAVE_ALL supports lightweight save
>   riscv/ftrace: cleanup ftrace_caller and ftrace_regs_caller
>
>  arch/riscv/include/asm/ftrace.h |  13 ++-
>  arch/riscv/kernel/ftrace.c      |  35 ++++----
>  arch/riscv/kernel/mcount-dyn.S  | 145 +++++++++++++++++++++++---------
>  3 files changed, 136 insertions(+), 57 deletions(-)
>
> --
> 2.20.1
>


--
Best Regards
 Guo Ren
