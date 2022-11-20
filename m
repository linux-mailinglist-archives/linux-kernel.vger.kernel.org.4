Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A097C631279
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 05:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKTE0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 23:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTE0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 23:26:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3572922E3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 20:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 751FE60A39
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 04:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E38C433B5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 04:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668918401;
        bh=k1A92uAfw6CmkBCjaww5Sg5nXzI1WXKsXnx3KBejk3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j5XwF5SDL0nm4CHSVyx7DyXJ8DaIdiXsX0L01ZRn5KnO85mTYLVK2iOeTK0qrDOeH
         11hT7RoYkFXWdz+3y/z9+2hTNC5MzRRhJRz1uE03t5w1wJUwmrqkV1on/JNEZqHrGQ
         +wn9quYQwXne4ag+gwG6JRatuHPlFVfRhnKQdrx/KdtrAw4nRa2coQF6VwHxUDHNkV
         00hSCR70/FK6Ttzn7+fdfXfBWHrMHri/dLZbpBtIzf2P8ZkitFt9ZOk3aP/yXSJKQv
         EOtNhCMukQfSZiz/KXRJyWMoJhIRtCsMcgaTE4UBQminWfxgNUvzBwEq+ar8dqhjGm
         slToMFZXZnSYQ==
Received: by mail-ed1-f43.google.com with SMTP id s12so12152965edd.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 20:26:41 -0800 (PST)
X-Gm-Message-State: ANoB5pkYNg8g5ohxtZ1SXaYh0unh/ST+A2qQxn27Uue6DYl/JHNoB9uV
        Pty7KeAtrDVDzBzZuYmCeuB0jTJHUERy7xnIhKs=
X-Google-Smtp-Source: AA0mqf7wlt6QdnTN4ssgY0s76BTmX7b5yjCBfP346X/bNzDXOeBoOfUWxOJPr5bFgB0KWpacvfWo4vCdmbXQQHVa3zI=
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id
 r26-20020a056402019a00b0046074135d46mr11605961edv.47.1668918399977; Sat, 19
 Nov 2022 20:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20221118173217.888077-1-suagrfillet@gmail.com>
In-Reply-To: <20221118173217.888077-1-suagrfillet@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 20 Nov 2022 12:26:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTHWtm-nYD0SdcvnxAXkiNOVBZAkVx8SkJL2w-K9iaWZQ@mail.gmail.com>
Message-ID: <CAJF2gTTHWtm-nYD0SdcvnxAXkiNOVBZAkVx8SkJL2w-K9iaWZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] riscv/ftrace: make function graph use ftrace directly
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

On Sat, Nov 19, 2022 at 1:32 AM Song Shuai <suagrfillet@gmail.com> wrote:
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
> Changes since v2:
> - line up the comments [Andrew]
> - rename SAVE_ALL as SAVE_ABI_REGS [Guo Ren]
> - consolidate the modifications of mcount-dyn.S into one patch [Guo Ren]
> - adapt this series based on [riscv: ftrace: Fixup ftrace detour code][1] [Guo Ren]
Tested-by: Guo Ren <guoren@kernel.org>

https://github.com/guoren83/linux/tree/ftrace_fixup_v3

>
> [1]: https://lore.kernel.org/linux-riscv/20220921034910.3142465-1-guoren@kernel.org/
> v2 Link: https://lore.kernel.org/linux-riscv/20221116031305.286634-1-suagrfillet@gmail.com/
>
> Changes since v1:
> - fix the checkpatch warnings in patch 1
> v1 Link: https://lore.kernel.org/linux-riscv/20221115061525.112757-1-suagrfillet@gmail.com
>
> Song Shuai (2):
>   riscv/ftrace: add ftrace_graph_func
>   riscv/ftrace: make ftrace_caller call ftrace_graph_func
>
>  arch/riscv/include/asm/ftrace.h |  13 ++-
>  arch/riscv/kernel/ftrace.c      |  30 +++----
>  arch/riscv/kernel/mcount-dyn.S  | 143 +++++++++++++++++++++++---------
>  3 files changed, 129 insertions(+), 57 deletions(-)
>
> --
> 2.20.1
>


-- 
Best Regards
 Guo Ren
