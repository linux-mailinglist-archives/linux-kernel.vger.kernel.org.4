Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD86711FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjARDam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjARDac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF95399C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EC15B81B05
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B695EC433F0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674012622;
        bh=cpni+bkqRqN1WNgmDR5iu5hF6r8xKU8JzSc8T2oCWkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a2VgN/SnRLw/oI+J31Dsy2kSkxRKJHQDpSA70nwjaPGq25fzDITQw8BPgkenz1B18
         iHZqxFxvtW2C/rpwz+wdftr6aAupYikzKIhcByPS2YNaAMl2g3N1UMrjXSdqVld0e7
         1831PHFmoCQlmndfgKd6nBiBe78DIq2IHy/9vpGj2EokxI2zr4XpLpDkiEmIvhyxoT
         RCD1QaO306NRnblKyml7vSHffTF4s7gzVdAVcz/QJ5Ay4G/iOjOp4pz3QT3Cgw1Bfj
         2RziUBaNiO46d5Z0fky0MWAFv3lZq+neyiDD64UNgpYJ7R0UiBlKC/3NsnTyklL3Nj
         2GOcc39UwHrhg==
Received: by mail-ed1-f45.google.com with SMTP id v6so47814228edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:30:22 -0800 (PST)
X-Gm-Message-State: AFqh2kpoIVe3KcaiR26ebdJWO2nBclojF6LdxRSTMpjrHylKtUDDg15O
        Kd4v77oS10241EGvzdX6IpP1fZGGk2MAmAQbdME=
X-Google-Smtp-Source: AMrXdXsUoxKHh4L31qjc2cdz/d5NeAHxJlRtJwGLhgguluIzdmU1vjggktYL21VUWhrZRtUSAF3j1xZcKGfpTsOmcVc=
X-Received: by 2002:a05:6402:40a:b0:49d:aca5:9ae0 with SMTP id
 q10-20020a056402040a00b0049daca59ae0mr664839edv.106.1674012620989; Tue, 17
 Jan 2023 19:30:20 -0800 (PST)
MIME-Version: 1.0
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 18 Jan 2023 11:30:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
Message-ID: <CAAhV-H4aTd6_cSy45KKjv-KrLTiwT4iG6+fkb84KfCrL3Y+hpg@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add kprobe and kretprobe support for LoongArch
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

Hi, Masami,

Could you please pay some time to review this series? Thank you.

Huacai

On Wed, Jan 18, 2023 at 10:01 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> v12:
>   -- Rebase on the latest code
>   -- Fix -Wmissing-prototypes warning when make W=1
>   -- Drop patch #6 "Use common function sign_extend64()"
>      since it has been applied yet
>
> v11:
>   -- Rebase on the latest code
>   -- Address all the review comments, thank you all
>   -- Modify arch_prepare_kprobe() and setup_singlestep()
>      to make the probe logic more clear
>   -- Mark some assembler symbols as non-kprobe-able
>   -- Use common function sign_extend64()
>   -- Test 20 times about 36 hours for all the 71 assembler
>      functions annotated with SYM_CODE_START and SYM_FUNC_START
>      under arch/loongarch, especially test memset alone for 10
>      hours, no hang problems
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
> Tiezhu Yang (5):
>   LoongArch: Simulate branch and PC* instructions
>   LoongArch: Add kprobe support
>   LoongArch: Add kretprobe support
>   LoongArch: Mark some assembler symbols as non-kprobe-able
>   samples/kprobes: Add LoongArch support
>
>  arch/loongarch/Kconfig                     |   2 +
>  arch/loongarch/include/asm/asm.h           |  10 +
>  arch/loongarch/include/asm/inst.h          |  20 ++
>  arch/loongarch/include/asm/kprobes.h       |  61 +++++
>  arch/loongarch/include/asm/ptrace.h        |   1 +
>  arch/loongarch/kernel/Makefile             |   2 +
>  arch/loongarch/kernel/entry.S              |   1 +
>  arch/loongarch/kernel/inst.c               | 123 +++++++++
>  arch/loongarch/kernel/kprobes.c            | 405 +++++++++++++++++++++++++++++
>  arch/loongarch/kernel/kprobes_trampoline.S |  96 +++++++
>  arch/loongarch/kernel/traps.c              |  11 +-
>  arch/loongarch/lib/memcpy.S                |   3 +
>  arch/loongarch/mm/fault.c                  |   3 +
>  samples/kprobes/kprobe_example.c           |   8 +
>  14 files changed, 741 insertions(+), 5 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kprobes.h
>  create mode 100644 arch/loongarch/kernel/kprobes.c
>  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
>
> --
> 2.1.0
>
>
