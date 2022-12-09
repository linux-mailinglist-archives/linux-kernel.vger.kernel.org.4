Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDD64808F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLIKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLIKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:02:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D0379D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:01:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8245621C0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C84C433F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670580117;
        bh=S7JvkQlEpBQlXiXHS+xN4aeOvvWcZ+Af5ihulBXLNj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TuVfr4QskWa94RfMqWKCiLvZZK0O9IHwMmXZSOhROEgEM/wxrkvdyT9ZxYXgNN7zl
         i/zvqPzOpsfESzht0LJmYydGmYGBq671BmEBYeZTNALZMo0vuy8C1VI1tCUtcCiqI9
         fi+w8QpapXoXN9k49xVfTfkRSX8Q9omhXKiDKcusV0dPaabwkBLux7Fn8tHKo9jtEt
         0LfxIZsUEsO1wRKHG4tmj0KAiIICERwl+ubmbbgl8NGDRD5UHKgYrwZsPvklbvC+tH
         zQ7KdPg4mnAwmwGuSiAP0r3WpsiEpf+0MXAK8dAyDdLZwM1zRojTBYV2QIJZSnU1Lw
         UweeqaOUaBx+Q==
Received: by mail-ej1-f41.google.com with SMTP id fc4so10253900ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:01:57 -0800 (PST)
X-Gm-Message-State: ANoB5pnuEUU37dtRG0caOA9WNmTmAvn/hHVJPH9WPXnGcdqMGL9UzYor
        8zJipvaDIYO+NfjElQLh8jrgKsE4eWSFhxdb5bI=
X-Google-Smtp-Source: AA0mqf5qJ6rWgPUZud4Ld4Q1QpUY08LNFsLvjSw2VJzly5437slRhRkf00JYgyrY8us6gWQtE1Vt4nhU9V9JMh3DvrY=
X-Received: by 2002:a17:907:37a:b0:7c0:e4b6:132e with SMTP id
 rs26-20020a170907037a00b007c0e4b6132emr16395816ejb.224.1670580115534; Fri, 09
 Dec 2022 02:01:55 -0800 (PST)
MIME-Version: 1.0
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Dec 2022 18:01:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com>
Message-ID: <CAAhV-H6e2HzXs9PCcdnebPBvGZrx5vRXji1vGXfPwkEihBOiKA@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] Add kprobe and kretprobe support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jeff Xie <xiehuan09@gmail.com>
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

Hi, Masami,

This series looks good to me now, but I'm not familiar with kprobes.
So, if you have any comments, please let me know.

And Jeff,

As we all know, you are an expert in this domain, so could you please
help me to test this series?

If there are no objections, I plan to merge this series in a few days.
But since the next merge window will be open soon, if there are any
problems, I will revert the patches to wait for the next cycle.

Thanks,
Huacai

On Fri, Dec 9, 2022 at 4:53 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> v10:
>   -- Remove sign_extend() based on the latest code
>   -- Rename insns_are_not_supported() to insns_not_supported()
>   -- Rename insns_are_not_simulated() to insns_not_simulated()
>   -- Set KPROBE_HIT_SSDONE if cur->post_handler is not NULL
>   -- Enable preemption for KPROBE_REENTER in kprobe_fault_handler()
>
> v9:
>   -- Rename sign_extended() to sign_extend()
>   -- Modify kprobe_fault_handler() to handle all of kprobe_status
>
> v8:
>   -- Put "regs->csr_prmd &= ~CSR_PRMD_PIE;" ahead to save one line
>   -- Add code comment of preempt_disable()
>   -- Put kprobe_page_fault() in __do_page_fault()
>   -- Modify the check condition of break insn in kprobe_breakpoint_handler()
>
> v7:
>   -- Remove stop_machine_cpuslocked() related code
>
> v6:
>   -- Add a new patch to redefine larch_insn_patch_text() with
>      stop_machine_cpuslocked()
>   -- Modify kprobe_breakpoint_handler() to consider the original
>      insn is break and return the correct value
>   -- Modify do_bp() to refresh bcode when original insn is break
>
> v5:
>   -- Rebase on the latest code
>   -- Use stop_machine_cpuslocked() to modify insn to avoid CPU race
>
> v4:
>   -- Remove kprobe_exceptions_notify() in kprobes.c
>   -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
>      in do_bp()
>
> v3:
>   -- Rebase on the latest code
>   -- Check the alignment of PC in simu_branch() and simu_pc()
>   -- Add ibar in flush_insn_slot()
>   -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
>   -- Add preempt_disable() and preempt_enable_no_resched()
>   -- Remove r0 save/restore and do some minor changes
>      in kprobes_trampoline.S
>   -- Do not enable CONFIG_KPROBES by default
>
> v2:
>   -- Split simu_branch() and simu_pc() into a single patch
>   -- Call kprobe_page_fault() in do_page_fault()
>   -- Add kprobes_trampoline.S for kretprobe
>
> Tiezhu Yang (4):
>   LoongArch: Simulate branch and PC instructions
>   LoongArch: Add kprobe support
>   LoongArch: Add kretprobe support
>   samples/kprobes: Add LoongArch support
>
>  arch/loongarch/Kconfig                     |   2 +
>  arch/loongarch/include/asm/inst.h          |  20 ++
>  arch/loongarch/include/asm/kprobes.h       |  59 +++++
>  arch/loongarch/include/asm/ptrace.h        |   1 +
>  arch/loongarch/kernel/Makefile             |   2 +
>  arch/loongarch/kernel/inst.c               | 123 ++++++++++
>  arch/loongarch/kernel/kprobes.c            | 364 +++++++++++++++++++++++++++++
>  arch/loongarch/kernel/kprobes_trampoline.S |  96 ++++++++
>  arch/loongarch/kernel/traps.c              |  13 +-
>  arch/loongarch/mm/fault.c                  |   3 +
>  samples/kprobes/kprobe_example.c           |   8 +
>  11 files changed, 687 insertions(+), 4 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kprobes.h
>  create mode 100644 arch/loongarch/kernel/kprobes.c
>  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
>
> --
> 2.1.0
>
