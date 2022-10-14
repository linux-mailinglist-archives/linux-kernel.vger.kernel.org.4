Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8635FE8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJNGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJNGIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:08:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6608B1633AE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0140FB821B6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB011C43470
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665727683;
        bh=pjo0EBaYOm3B/44XfyP4yUNEG3H60VNDBmXU8fIbsQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DU064CD8Dfss2Qr05ts/ONK45RHGVd5hOuyM9nI9F6ReQsD1XWXQ2qa2HA1d5ngAb
         dLP4pv1ncqnj/XFlnR2jpTZ/4n5JOqGBIC9PM8dvR7vrxO3Jkqo8Rjwn1wgwUbdX/a
         8VJn6Sfny7Ttr89sZaqyiY3l4vvOLGHl34rndnP1+Rw7lm/xYaY9IL3Mtehmvv5eky
         1VYw1aHCpNoJ2cbtE8Oh56kNW7zYPk5+cOJRzoozhby4Sqd43c4x7dBzWoAKijzIgj
         y1msWi6LFwwLXMlTvLNbmkhJhnVEaV5kEArWRGuonHR23VzM7stZJmysmrBq9FfTnq
         PkIoce67cCdpg==
Received: by mail-ej1-f44.google.com with SMTP id 13so8337749ejn.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:08:03 -0700 (PDT)
X-Gm-Message-State: ACrzQf2LlIRXC6L9ZMegGEg3iwVCZ+5yN1DN2S/nWQVlPpDA6xQfZ9g/
        NB9B2kPfuTeoV6vIt3UOvSCN4nJakTgXaG1uLGw=
X-Google-Smtp-Source: AMsMyM4YfPEHVvqvhGf+VKX+WRNQB41i9RA3SXUZpmhhrJhka9iNvjat1Ogib0i/02e6PMecIesehaeahKg/ES15G6A=
X-Received: by 2002:a17:907:8a0a:b0:78d:b87d:e68a with SMTP id
 sc10-20020a1709078a0a00b0078db87de68amr2289298ejc.301.1665727681841; Thu, 13
 Oct 2022 23:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221007234315.2877365-1-song@kernel.org> <20221007234315.2877365-4-song@kernel.org>
 <Y0jcGjzjIYeFzNhv@ziqianlu-desk>
In-Reply-To: <Y0jcGjzjIYeFzNhv@ziqianlu-desk>
From:   Song Liu <song@kernel.org>
Date:   Thu, 13 Oct 2022 23:07:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6qhyuo_M60_rgmK54eBQsestca5dz4wM+rRqpGkKBLAw@mail.gmail.com>
Message-ID: <CAPhsuW6qhyuo_M60_rgmK54eBQsestca5dz4wM+rRqpGkKBLAw@mail.gmail.com>
Subject: Re: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, kernel-team@fb.com, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 8:49 PM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Fri, Oct 07, 2022 at 04:43:14PM -0700, Song Liu wrote:
> > This is a prototype that allows modules to share 2MB text pages with other
> > modules and BPF programs.
> >
> > Current version only covers core_layout.
> > ---
> >  arch/x86/Kconfig              |  1 +
> >  arch/x86/kernel/alternative.c | 30 ++++++++++++++++++++++++------
> >  arch/x86/kernel/module.c      |  1 +
> >  kernel/module/main.c          | 23 +++++++++++++----------
> >  kernel/module/strict_rwx.c    |  3 ---
> >  kernel/trace/ftrace.c         |  3 ++-
> >  6 files changed, 41 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index f9920f1341c8..0b1ea05a1da6 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -91,6 +91,7 @@ config X86
> >       select ARCH_HAS_SET_DIRECT_MAP
> >       select ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_HAS_STRICT_MODULE_RWX
> > +     select ARCH_WANTS_MODULES_DATA_IN_VMALLOC       if X86_64
> >       select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> >       select ARCH_HAS_SYSCALL_WRAPPER
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 4f3204364caa..0e47a558c5bc 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -332,7 +332,13 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
> >
> >               DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
> >
> > -             text_poke_early(instr, insn_buff, insn_buff_sz);
> > +             if (system_state < SYSTEM_RUNNING) {
> > +                     text_poke_early(instr, insn_buff, insn_buff_sz);
> > +             } else {
> > +                     mutex_lock(&text_mutex);
> > +                     text_poke(instr, insn_buff, insn_buff_sz);
> > +                     mutex_unlock(&text_mutex);
> > +             }
> >
> >  next:
> >               optimize_nops(instr, a->instrlen);
> > @@ -503,7 +509,13 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
> >                       optimize_nops(bytes, len);
> >                       DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
> >                       DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
> > -                     text_poke_early(addr, bytes, len);
> > +                     if (system_state == SYSTEM_BOOTING) {
> > +                             text_poke_early(addr, bytes, len);
> > +                     } else {
> > +                             mutex_lock(&text_mutex);
> > +                             text_poke(addr, bytes, len);
> > +                             mutex_unlock(&text_mutex);
> > +                     }
> >               }
> >       }
> >  }
> > @@ -568,7 +580,13 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
> >               if (len == insn.length) {
> >                       DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
> >                       DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
> > -                     text_poke_early(addr, bytes, len);
> > +                     if (unlikely(system_state == SYSTEM_BOOTING)) {
> > +                             text_poke_early(addr, bytes, len);
> > +                     } else {
> > +                             mutex_lock(&text_mutex);
> > +                             text_poke(addr, bytes, len);
> > +                             mutex_unlock(&text_mutex);
> > +                     }
> >               }
> >       }
> >  }
> > @@ -609,7 +627,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
> >                */
> >               DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
> >               DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
> > -             text_poke_early(addr, &poison, 4);
> > +             text_poke(addr, &poison, 4);
> >       }
> >  }
> >
> > @@ -791,7 +809,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
> >
> >               /* Pad the rest with nops */
> >               add_nops(insn_buff + used, p->len - used);
> > -             text_poke_early(p->instr, insn_buff, p->len);
> > +             text_poke(p->instr, insn_buff, p->len);
>
> Got below warning when booting a VM:
>
> [    0.190098] ------------[ cut here ]------------
> [    0.190377] WARNING: CPU: 0 PID: 0 at /home/aaron/linux/src/arch/x86/kernel/alternative.c:1224 text_poke+0x53/0x60
> [    0.191083] Modules linked in:
> [    0.191269] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-00004-gc49d19177d78 #5
> [    0.191721] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    0.192083] RIP: 0010:text_poke+0x53/0x60
> [    0.192326] Code: c7 c7 20 e7 02 81 5b 5d e9 2a f8 ff ff be ff ff ff ff 48 c7 c7 b0 6d 06 83 48 89 14 24 e8 75 fd bf 00 85 c0 48 8b 14 24 75 c8 <0f> 0b eb c4 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56
> [    0.193083] RSP: 0000:ffffffff83003d60 EFLAGS: 00010246
> [    0.194083] RAX: 0000000000000000 RBX: ffffffff810295b7 RCX: 0000000000000001
> [    0.194506] RDX: 0000000000000006 RSI: ffffffff828b01c5 RDI: ffffffff8293898e
> [    0.195083] RBP: ffffffff83003d82 R08: ffffffff82206520 R09: 0000000000000001
> [    0.195506] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a9949c0
> [    0.195929] R13: ffffffff8a95f400 R14: 00000000ffffffff R15: 00000000ffffffff
> [    0.196083] FS:  0000000000000000(0000) GS:ffff88842de00000(0000) knlGS:0000000000000000
> [    0.196562] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.197083] CR2: ffff88843ffff000 CR3: 0000000003012001 CR4: 0000000000770ef0
> [    0.197508] PKRU: 55555554
> [    0.197673] Call Trace:
> [    0.197822]  <TASK>
> [    0.198084]  apply_paravirt+0xaf/0x150
> [    0.198313]  ? __might_resched+0x3f/0x280
> [    0.198557]  ? synchronize_rcu+0xe0/0x1c0
> [    0.198799]  ? lock_release+0x230/0x450
> [    0.199030]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> [    0.199083]  ? lockdep_hardirqs_on+0x79/0x100
> [    0.199345]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
> [    0.199643]  ? atomic_notifier_chain_unregister+0x51/0x80
> [    0.200084]  alternative_instructions+0x27/0xfa
> [    0.200357]  check_bugs+0xe08/0xe82
> [    0.200570]  start_kernel+0x692/0x6cc
> [    0.200797]  secondary_startup_64_no_verify+0xe0/0xeb
> [    0.201088]  </TASK>
> [    0.201223] irq event stamp: 13575
> [    0.201428] hardirqs last  enabled at (13583): [<ffffffff811193c2>] __up_console_sem+0x52/0x60
> [    0.202083] hardirqs last disabled at (13592): [<ffffffff811193a7>] __up_console_sem+0x37/0x60
> [    0.202594] softirqs last  enabled at (12762): [<ffffffff8117e169>] cgroup_idr_alloc.constprop.60+0x59/0x100
> [    0.203083] softirqs last disabled at (12750): [<ffffffff8117e13d>] cgroup_idr_alloc.constprop.60+0x2d/0x100
> [    0.203665] ---[ end trace 0000000000000000 ]---
>
> Looks like it is also necessary to differentiate system_state in
> apply_paravirt() like you did in the other apply_XXX() functions.

Thanks for the report! Somehow I didn't see this in my qemu vm.

Song
