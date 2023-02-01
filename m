Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF1685EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBAE41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBAE4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:56:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6E3EC55
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2CA8B81F2C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F38C433D2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675227379;
        bh=/rMOgKoaFLGU2ZF+VfOT75t3kgheesZyUZ+Tm8H3Djo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SjMyXWU5PxxuGdyXwzyG/yiwX/Wc1VxOYVSbul69/KjIbm1aX0pQqhiLoZL1lUaqz
         CLel9bfz90fF12S5W8E0q+rxKxbNuYPKJNJYXiVrShPrOAHpDRTbB1htAiBoXCI4yE
         ccD4T72vhPKGovWiD+uA1u9ijLRfbNcmBx33pKlQnRX5/ABPAflrX48OYDWMQwTiu6
         V7ZGo8oqF0wrYQJEh4zPqPuGIVImDp5fipPICNxE/LTsNGG2PBHPpDK8z0Ns+xm7d7
         SECgTRZba7Vw+dtRW3JSa2cWZ6ikNp4EA63urmCxZzajJ0d3uxZ9//NoJMnepwGW22
         0jeNm64GkhH8Q==
Received: by mail-ej1-f41.google.com with SMTP id mf7so29185398ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:56:19 -0800 (PST)
X-Gm-Message-State: AO0yUKUZo6KtPRluwYS0e8A2LFbW901UcxyGqcnDR3nwFYXBicBtvr2t
        qUJbS4ROAqvJHtPfq88JPVqBxxUwYlBucQkSEfA=
X-Google-Smtp-Source: AK7set92hZkZD97DAYE2AchrM3JKoiNqu2cHYEi9o3Ug7E6yp4puK1BZovDygFPaDwSn08BqjFiA63PxHM5l7M7nQl0=
X-Received: by 2002:a17:906:5494:b0:860:f9a6:8d57 with SMTP id
 r20-20020a170906549400b00860f9a68d57mr251119ejo.287.1675227377555; Tue, 31
 Jan 2023 20:56:17 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn> <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
In-Reply-To: <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 1 Feb 2023 12:56:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
Message-ID: <CAAhV-H5WN5E=0Z9wpbXDc6VO7Nc+j7PGvnyAAGOmCRMJkdwSYw@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
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

Hi, Jeff,

Could you please pay some time to test this series? Thank you.

Huacai

On Wed, Jan 18, 2023 at 11:30 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Masami,
>
> Could you please pay some time to review this series? Thank you.
>
> Huacai
>
> On Wed, Jan 18, 2023 at 10:01 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > v12:
> >   -- Rebase on the latest code
> >   -- Fix -Wmissing-prototypes warning when make W=1
> >   -- Drop patch #6 "Use common function sign_extend64()"
> >      since it has been applied yet
> >
> > v11:
> >   -- Rebase on the latest code
> >   -- Address all the review comments, thank you all
> >   -- Modify arch_prepare_kprobe() and setup_singlestep()
> >      to make the probe logic more clear
> >   -- Mark some assembler symbols as non-kprobe-able
> >   -- Use common function sign_extend64()
> >   -- Test 20 times about 36 hours for all the 71 assembler
> >      functions annotated with SYM_CODE_START and SYM_FUNC_START
> >      under arch/loongarch, especially test memset alone for 10
> >      hours, no hang problems
> >
> > v10:
> >   -- Remove sign_extend() based on the latest code
> >   -- Rename insns_are_not_supported() to insns_not_supported()
> >   -- Rename insns_are_not_simulated() to insns_not_simulated()
> >   -- Set KPROBE_HIT_SSDONE if cur->post_handler is not NULL
> >   -- Enable preemption for KPROBE_REENTER in kprobe_fault_handler()
> >
> > v9:
> >   -- Rename sign_extended() to sign_extend()
> >   -- Modify kprobe_fault_handler() to handle all of kprobe_status
> >
> > v8:
> >   -- Put "regs->csr_prmd &= ~CSR_PRMD_PIE;" ahead to save one line
> >   -- Add code comment of preempt_disable()
> >   -- Put kprobe_page_fault() in __do_page_fault()
> >   -- Modify the check condition of break insn in kprobe_breakpoint_handler()
> >
> > v7:
> >   -- Remove stop_machine_cpuslocked() related code
> >
> > v6:
> >   -- Add a new patch to redefine larch_insn_patch_text() with
> >      stop_machine_cpuslocked()
> >   -- Modify kprobe_breakpoint_handler() to consider the original
> >      insn is break and return the correct value
> >   -- Modify do_bp() to refresh bcode when original insn is break
> >
> > v5:
> >   -- Rebase on the latest code
> >   -- Use stop_machine_cpuslocked() to modify insn to avoid CPU race
> >
> > v4:
> >   -- Remove kprobe_exceptions_notify() in kprobes.c
> >   -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
> >      in do_bp()
> >
> > v3:
> >   -- Rebase on the latest code
> >   -- Check the alignment of PC in simu_branch() and simu_pc()
> >   -- Add ibar in flush_insn_slot()
> >   -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
> >   -- Add preempt_disable() and preempt_enable_no_resched()
> >   -- Remove r0 save/restore and do some minor changes
> >      in kprobes_trampoline.S
> >   -- Do not enable CONFIG_KPROBES by default
> >
> > v2:
> >   -- Split simu_branch() and simu_pc() into a single patch
> >   -- Call kprobe_page_fault() in do_page_fault()
> >   -- Add kprobes_trampoline.S for kretprobe
> >
> > Tiezhu Yang (5):
> >   LoongArch: Simulate branch and PC* instructions
> >   LoongArch: Add kprobe support
> >   LoongArch: Add kretprobe support
> >   LoongArch: Mark some assembler symbols as non-kprobe-able
> >   samples/kprobes: Add LoongArch support
> >
> >  arch/loongarch/Kconfig                     |   2 +
> >  arch/loongarch/include/asm/asm.h           |  10 +
> >  arch/loongarch/include/asm/inst.h          |  20 ++
> >  arch/loongarch/include/asm/kprobes.h       |  61 +++++
> >  arch/loongarch/include/asm/ptrace.h        |   1 +
> >  arch/loongarch/kernel/Makefile             |   2 +
> >  arch/loongarch/kernel/entry.S              |   1 +
> >  arch/loongarch/kernel/inst.c               | 123 +++++++++
> >  arch/loongarch/kernel/kprobes.c            | 405 +++++++++++++++++++++++++++++
> >  arch/loongarch/kernel/kprobes_trampoline.S |  96 +++++++
> >  arch/loongarch/kernel/traps.c              |  11 +-
> >  arch/loongarch/lib/memcpy.S                |   3 +
> >  arch/loongarch/mm/fault.c                  |   3 +
> >  samples/kprobes/kprobe_example.c           |   8 +
> >  14 files changed, 741 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/loongarch/include/asm/kprobes.h
> >  create mode 100644 arch/loongarch/kernel/kprobes.c
> >  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
> >
> > --
> > 2.1.0
> >
> >
