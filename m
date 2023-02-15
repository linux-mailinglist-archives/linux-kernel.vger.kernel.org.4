Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E50697393
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjBOBZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjBOBZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:25:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415D23844
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56EA56197C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B379CC433EF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424286;
        bh=u1lerKNi+uC9ctoGa1IAX5v2hkavKJUjtp2Wmk29mEg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jfvLsoT1lxqLYCwUkMK7JVaEf0bHvmIIPmqrRQLXc38+dJgUwPIVuBSH5aQuFbWpN
         tdrWzJgFf/ezLigWvpkMElPc12+SOAvRdUswHIVa92UYTnJrMS4quJ+X8B4fDVDPEo
         eQn+H1y5moqevw+OPqmgg3bwI8AdK8F47QvDTFDl0QT+xTNmPacHIQU7yq8kaKyv2/
         U+5s7pHXSzv346XO2j0JLnLrjh53d3pNGEzMiASbDDgCyeNYOcp9eTweUyhj7sTJCs
         qpmikGIOvExJJtHzKSwqcpgegp0bdsSQmxQxGiBaooNQiU2okCcgWvCAFh3UXufnKz
         WOhW9rPmnZXgA==
Received: by mail-ed1-f47.google.com with SMTP id w3so12925860edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:24:46 -0800 (PST)
X-Gm-Message-State: AO0yUKWPqwdvJEJ30+OgremE0ObWCakPw6RjAYQYKxstnRppQHx+i/eB
        Tag71ZzYiyMHqGwevPTXwbSVhtdC6aCUO58Q1IA=
X-Google-Smtp-Source: AK7set9+9p6h6ZVap3gQuh/P0mwxYz17koOzaSTL09tM1wSOI6hxCpLv4/mh7fspog2U+DnQzRb4kqbn6uHUMxdj0tw=
X-Received: by 2002:a05:6402:2694:b0:4ab:1f1b:95a1 with SMTP id
 w20-20020a056402269400b004ab1f1b95a1mr1354251edd.0.1676424284947; Tue, 14 Feb
 2023 17:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20230202114116.3695793-1-changbin.du@huawei.com> <Y+wlula69tYrSZjQ@spud>
In-Reply-To: <Y+wlula69tYrSZjQ@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 15 Feb 2023 09:24:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQBiE7d_RiNjxoyx9gppYQxXBLeNhEsX04tjtjM_56gRQ@mail.gmail.com>
Message-ID: <CAJF2gTQBiE7d_RiNjxoyx9gppYQxXBLeNhEsX04tjtjM_56gRQ@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: patch: Fixup lockdep warning in stop_machine
To:     Conor Dooley <conor@kernel.org>
Cc:     Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hui Wang <hw.huiwang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 8:22 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Changbin,
>
> On Thu, Feb 02, 2023 at 07:41:16PM +0800, Changbin Du wrote:
> > The task of ftrace_arch_code_modify(_post)_prepare() caller is
> > stop_machine, whose caller and work thread are of different tasks. The
> > lockdep checker needs the same task context, or it's wrong. That means
> > it's a bug here to use lockdep_assert_held because we don't guarantee
> > the same task context.
I'm trying to delete all stop_machine in riscv, from ftrace to kprobe.
When I have done, we needn't this patch.

> >
> > kernel/locking/lockdep.c:
> > int __lock_is_held(const struct lockdep_map *lock, int read)
> > {
> >         struct task_struct *curr = current;
> >         int i;
> >
> >         for (i = 0; i < curr->lockdep_depth; i++) {
> >                       ^^^^^^^^^^^^^^^^^^^
> >                 struct held_lock *hlock = curr->held_locks + i;
> >                                         ^^^^^^^^^^^^^^^^
> >                 if (match_held_lock(hlock, lock)) {
> >                         if (read == -1 || !!hlock->read == read)
> >                                 return LOCK_STATE_HELD;
> >
> > The __lock_is_held depends on current held_locks records; if
> > stop_machine makes the checker running on another task, that's wrong.
> >
> > Here is the log:
> > [   15.761523] ------------[ cut here ]------------
> > [   15.762125] WARNING: CPU: 0 PID: 15 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x72/0x364
> > [   15.763258] Modules linked in:
> > [   15.764154] CPU: 0 PID: 15 Comm: migration/0 Not tainted 6.1.0-rc1-00014-g66924be85884-dirty #377
> > [   15.765339] Hardware name: riscv-virtio,qemu (DT)
> > [   15.765985] Stopper: multi_cpu_stop+0x0/0x192 <- stop_cpus.constprop.0+0x90/0xe2
> > [   15.766711] epc : patch_insn_write+0x72/0x364
> > [   15.767011]  ra : patch_insn_write+0x70/0x364
> > [   15.767276] epc : ffffffff8000721e ra : ffffffff8000721c sp : ff2000000067bca0
> > [   15.767622]  gp : ffffffff81603f90 tp : ff60000002432a00 t0 : 7300000000000000
> > [   15.767919]  t1 : 0000000000000000 t2 : 73695f6b636f6c5f s0 : ff2000000067bcf0
> > [   15.768238]  s1 : 0000000000000008 a0 : 0000000000000000 a1 : 0000000000000000
> > [   15.768537]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> > [   15.768837]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
> > [   15.769139]  s2 : ffffffff80009faa s3 : ff2000000067bd10 s4 : ffffffffffffffff
> > [   15.769447]  s5 : 0000000000000001 s6 : 0000000000000001 s7 : 0000000000000003
> > [   15.769740]  s8 : 0000000000000002 s9 : 0000000000000004 s10: 0000000000000003
> > [   15.770027]  s11: 0000000000000002 t3 : 0000000000000000 t4 : ffffffff819af097
> > [   15.770323]  t5 : ffffffff819af098 t6 : ff2000000067ba28
> > [   15.770574] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> > [   15.771102] [<ffffffff80007520>] patch_text_nosync+0x10/0x3a
> > [   15.771421] [<ffffffff80009c66>] ftrace_update_ftrace_func+0x74/0x10a
> > [   15.771704] [<ffffffff800fa17e>] ftrace_modify_all_code+0xb0/0x16c
> > [   15.771958] [<ffffffff800fa24c>] __ftrace_modify_code+0x12/0x1c
> > [   15.772196] [<ffffffff800e110e>] multi_cpu_stop+0x14a/0x192
> > [   15.772454] [<ffffffff800e0a34>] cpu_stopper_thread+0x96/0x14c
> > [   15.772699] [<ffffffff8003f4ea>] smpboot_thread_fn+0xf8/0x1cc
> > [   15.772945] [<ffffffff8003ac9c>] kthread+0xe2/0xf8
> > [   15.773160] [<ffffffff80003e98>] ret_from_exception+0x0/0x14
> > [   15.773471] ---[ end trace 0000000000000000 ]---
> >
> > By the way, this also fixes the same issue for patch_text().
>
> Given this lockdep stuff seems to have pointed out that we weren't
> taking the lock for alternative patching just this past week [1], I'm
> really not convinced that deleting this is a good idea.
>
> Thanks,
> Conor.
>
> 1 - https://patchwork.kernel.org/project/linux-riscv/patch/20230212194735.491785-1-conor@kernel.org/
>
> >
> > Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Zong Li <zong.li@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> > Changes in v4:
> >  - preserve and update comments.
> >
> > Changes in v3:
> >  - denote this also fixes function patch_text().
> >
> > Changes in v2:
> >  - Rewrite commit log with lockdep explanation [Guo Ren]
> >  - Rebase on v6.1 [Guo Ren]
> >
> > v1:
> > https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
> > ---
> >  arch/riscv/kernel/ftrace.c |  5 ++---
> >  arch/riscv/kernel/patch.c  | 15 ++++++++-------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 2086f6585773..f73660e73822 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -126,9 +126,8 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  /*
> >   * This is called early on, and isn't wrapped by
> >   * ftrace_arch_code_modify_{prepare,post_process}() and therefor doesn't hold
> > - * text_mutex, which triggers a lockdep failure.  SMP isn't running so we could
> > - * just directly poke the text, but it's simpler to just take the lock
> > - * ourselves.
> > + * text_mutex. SMP isn't running so we could just directly poke the text, but
> > + * it's simpler to just take the lock ourselves.
> >   */
> >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> >  {
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 765004b60513..8eb243703efe 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -49,19 +49,20 @@ static void patch_unmap(int fixmap)
> >  }
> >  NOKPROBE_SYMBOL(patch_unmap);
> >
> > +/*
> > + * Before reaching here, it was expected to lock the text_mutex
> > + * already, so we don't need to give another lock here and could
> > + * ensure that it was safe between each cores. We do not add
> > + * lockdep assertion here since it would trigger a false positive
> > + * when called by stop_machine (The lockdep checker requires the
> > + * same task context).
> > + */
> >  static int patch_insn_write(void *addr, const void *insn, size_t len)
> >  {
> >       void *waddr = addr;
> >       bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> >       int ret;
> >
> > -     /*
> > -      * Before reaching here, it was expected to lock the text_mutex
> > -      * already, so we don't need to give another lock here and could
> > -      * ensure that it was safe between each cores.
> > -      */
> > -     lockdep_assert_held(&text_mutex);
> > -
> >       if (across_pages)
> >               patch_map(addr + len, FIX_TEXT_POKE1);
> >
> > --
> > 2.25.1
> >



-- 
Best Regards
 Guo Ren
