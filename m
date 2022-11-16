Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1333662B368
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKPGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiKPGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:37:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F512A98
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0D5CB81C07
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BACC433D7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668580622;
        bh=/lWnJAASGLj2cYQzruT9TZ1vRfcxiG94RwOJswNKGvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fz3BgrqifX1NxmqJu84ugiEPxCosZmC3fN1YpKb0VgduDIU8RvJpyfbIHOBFuijMB
         nWq1yfiKbT/rwonwhr8vvTqjJJAcEVbIRt0WYANS/zmhVOtVaSmq1aYzqVslZHOojz
         OneKqUrumr8nxqrkFGKcMGrX41qkoOireG6QySkmaSFzw5nCYbzGiV5IpSXOULE3q6
         JazPsPzRwXqP6ad0J2phnRjoZM2ogNNY1EZOYwjfsj8lnniI7TBMzvKyXrrlTqX9Gd
         seFlc7wr7SzLWjWYgKvWyXdApLzMk3xWDs13uL50S6qdfjq3XfdB3GjUzG2ffD9V9m
         vCqLgJk76ybpQ==
Received: by mail-ed1-f41.google.com with SMTP id l11so25161013edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:37:02 -0800 (PST)
X-Gm-Message-State: ANoB5pn5fvrpejXWglR8OD8yxID1NRPfR6t8dF3ROi8beYCws5MQa6t1
        V3QfTivjVsU4xy7IRgnJHXXTGzJCwKeUeT9A3sY=
X-Google-Smtp-Source: AA0mqf7H/WTkrpT5pOpqICIWdIeOufjmE0/t4V6kZXpARGvpFR0U4ve6H6cuWDZM5P6BPrxbUQZH+snl0yWqyGPgSeQ=
X-Received: by 2002:aa7:c515:0:b0:462:a25f:f0f2 with SMTP id
 o21-20020aa7c515000000b00462a25ff0f2mr17796549edq.156.1668580620485; Tue, 15
 Nov 2022 22:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20221116025324.1624-1-zhangqing@loongson.cn> <20221116025324.1624-9-zhangqing@loongson.cn>
In-Reply-To: <20221116025324.1624-9-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 16 Nov 2022 14:36:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H64De4uSTkuaFuHsLnGpVXDjGSSiYPmLkR1tOvtyyMKww@mail.gmail.com>
Message-ID: <CAAhV-H64De4uSTkuaFuHsLnGpVXDjGSSiYPmLkR1tOvtyyMKww@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] LoongArch: modules/ftrace: Initialize PLT at load time
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
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

Hi, Qing,

On Wed, Nov 16, 2022 at 10:53 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> To Implement ftrace trampiones through plt entry.
>
> Tested by forcing ftrace_make_call() to use the module PLT, and then
> loading up a module after setting up ftrace with:
>
> | echo ":mod:<module-name>" > set_ftrace_filter;
> | echo function > current_tracer;
> | modprobe <module-name>
>
> Since FTRACE_ADDR/FTRACE_REGS_ADDR is only defined when CONFIG_DYNAMIC_FTRACE
> is selected, we wrap its use along with most of module_init_ftrace_plt() with
> ifdeffery rather than using IS_ENABLED().
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/include/asm/ftrace.h     |  4 ++
>  arch/loongarch/include/asm/inst.h       |  3 +
>  arch/loongarch/include/asm/module.h     |  5 +-
>  arch/loongarch/include/asm/module.lds.h |  1 +
>  arch/loongarch/kernel/ftrace_dyn.c      | 79 +++++++++++++++++++++++++
>  arch/loongarch/kernel/inst.c            | 11 ++++
>  arch/loongarch/kernel/module-sections.c | 11 ++++
>  arch/loongarch/kernel/module.c          | 22 +++++++
>  8 files changed, 135 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 1583ec2171fc..8d194f6da8af 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -8,6 +8,10 @@
>
>  #define GRAPH_FAKE_OFFSET (sizeof(struct pt_regs) - offsetof(struct pt_regs, regs[1]))
>
> +#define FTRACE_PLT_IDX         0
> +#define FTRACE_REGS_PLT_IDX    1
> +#define NR_FTRACE_PLTS         2
> +
>  #ifdef CONFIG_FUNCTION_TRACER
>  #define MCOUNT_INSN_SIZE 4             /* sizeof mcount call */
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 59fee75590e9..417d6b8bc43e 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -13,10 +13,12 @@
>
>  #define ADDR_IMMMASK_LU52ID    0xFFF0000000000000
>  #define ADDR_IMMMASK_LU32ID    0x000FFFFF00000000
> +#define ADDR_IMMMASK_LU12IW    0x00000000FFFFF000
>  #define ADDR_IMMMASK_ADDU16ID  0x00000000FFFF0000
>
>  #define ADDR_IMMSHIFT_LU52ID   52
>  #define ADDR_IMMSHIFT_LU32ID   32
> +#define ADDR_IMMSHIFT_LU12IW   12
>  #define ADDR_IMMSHIFT_ADDU16ID 16
>
>  #define ADDR_IMM(addr, INSN)   ((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
> @@ -361,6 +363,7 @@ u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
>                         enum loongarch_gpr rk);
>  u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
>
> +u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
>  u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
> diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
> index b29b19a46f42..a311cfec2b23 100644
> --- a/arch/loongarch/include/asm/module.h
> +++ b/arch/loongarch/include/asm/module.h
> @@ -20,6 +20,9 @@ struct mod_arch_specific {
>         struct mod_section got;
>         struct mod_section plt;
>         struct mod_section plt_idx;
> +
> +       /* for CONFIG_DYNAMIC_FTRACE */
> +       struct plt_entry *ftrace_trampolines;
>  };
>
>  struct got_entry {
> @@ -49,7 +52,7 @@ static inline struct plt_entry emit_plt_entry(unsigned long val)
>  {
>         u32 lu12iw, lu32id, lu52id, jirl;
>
> -       lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | LOONGARCH_GPR_T1);
> +       lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
>         lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
>         lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
>         jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
> diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
> index a3d1bc0fcc72..438f09d4ccf4 100644
> --- a/arch/loongarch/include/asm/module.lds.h
> +++ b/arch/loongarch/include/asm/module.lds.h
> @@ -5,4 +5,5 @@ SECTIONS {
>         .got : { BYTE(0) }
>         .plt : { BYTE(0) }
>         .plt.idx : { BYTE(0) }
> +       .ftrace_trampoline : { BYTE(0) }
>  }
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index cd64887e26b5..b070ce225989 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -9,6 +9,7 @@
>  #include <linux/uaccess.h>
>
>  #include <asm/inst.h>
> +#include <asm/module.h>
>
>  static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>                               bool validate)
> @@ -72,12 +73,63 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>         return ftrace_modify_code(pc, old, new, true);
>  }
>
> +static inline int __get_mod(struct module **mod, unsigned long addr)
> +{
> +       preempt_disable();
> +       *mod = __module_text_address(addr);
> +       preempt_enable();
> +
> +       if (WARN_ON(!(*mod)))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
> +{
> +       struct plt_entry *plt = mod->arch.ftrace_trampolines;
> +
> +       if (addr == FTRACE_ADDR)
> +               return &plt[FTRACE_PLT_IDX];
> +       if (addr == FTRACE_REGS_ADDR &&
> +                       IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
> +               return &plt[FTRACE_REGS_PLT_IDX];
> +
> +       return NULL;
> +}
> +
> +static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
> +{
> +       struct plt_entry *plt;
> +
> +       plt = get_ftrace_plt(mod, addr);
> +       if (!plt) {
> +               pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
> +               return -EINVAL;
> +       }
> +
> +       return (unsigned long)plt;
> +}
> +
>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
>         unsigned long pc;
> +       long offset;
>         u32 old, new;
>
>         pc = rec->ip + LOONGARCH_INSN_SIZE;
> +       offset = (long)pc - (long)addr;
> +
> +       if (offset < -SZ_128M || offset >= SZ_128M) {
> +               int ret;
> +               struct module *mod;
> +
> +               ret = __get_mod(&mod, pc);
> +               if (ret)
> +                       return ret;
> +
> +               addr = get_plt_addr(mod, addr);
> +       }
>
>         old = larch_insn_gen_nop();
>         new = larch_insn_gen_bl(pc, addr);
> @@ -89,9 +141,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>                     unsigned long addr)
>  {
>         unsigned long pc;
> +       long offset;
>         u32 old, new;
>
>         pc = rec->ip + LOONGARCH_INSN_SIZE;
> +       offset = (long)pc - (long)addr;
> +
> +       if (offset < -SZ_128M || offset >= SZ_128M) {
> +               int ret;
> +               struct module *mod;
> +
> +               ret = __get_mod(&mod, pc);
> +               if (ret)
> +                       return ret;
> +
> +               addr = get_plt_addr(mod, addr);
> +       }
>
>         new = larch_insn_gen_nop();
>         old = larch_insn_gen_bl(pc, addr);
> @@ -108,6 +173,20 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>         u32 old, new;
>
>         pc = rec->ip + LOONGARCH_INSN_SIZE;
> +       offset = (long)pc - (long)addr;
> +
> +       if (offset < -SZ_128M || offset >= SZ_128M) {
> +               int ret;
> +               struct module *mod;
> +
> +               ret = __get_mod(&mod, pc);
> +               if (ret)
> +                       return ret;
> +
> +               addr = get_plt_addr(mod, addr);
> +
> +               old_addr = get_plt_addr(mod, old_addr);
> +       }
>
>         old = larch_insn_gen_bl(pc, old_addr);
>         new = larch_insn_gen_bl(pc, addr);
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 2d2e942eb06a..0d6bd7000ba6 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -103,6 +103,17 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
>         return insn.word;
>  }
>
> +u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
> +{
> +       union loongarch_instruction insn;
> +
> +       insn.reg1i20_format.opcode = lu12iw_op;
> +       insn.reg1i20_format.rd = rd;
> +       insn.reg1i20_format.immediate = imm;
> +
> +       return insn.word;
> +}
> +
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
>  {
>         union loongarch_instruction insn;
> diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
> index d296a70b758f..bd1a96691c98 100644
> --- a/arch/loongarch/kernel/module-sections.c
> +++ b/arch/loongarch/kernel/module-sections.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <linux/elf.h>
> +#include <linux/ftrace.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>
> @@ -103,6 +104,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                               char *secstrings, struct module *mod)
>  {
>         unsigned int i, num_plts = 0, num_gots = 0;
> +       Elf_Shdr *tramp = NULL;
>
>         /*
>          * Find the empty .plt sections.
> @@ -114,6 +116,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                         mod->arch.plt.shdr = sechdrs + i;
>                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
>                         mod->arch.plt_idx.shdr = sechdrs + i;
> +               else if (!strcmp(secstrings + sechdrs[i].sh_name, ".ftrace_trampoline"))
> +                       tramp = sechdrs + i;
>         }
>
>         if (!mod->arch.got.shdr) {
> @@ -166,5 +170,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>         mod->arch.plt_idx.num_entries = 0;
>         mod->arch.plt_idx.max_entries = num_plts;
>
> +       if (tramp) {
> +               tramp->sh_type = SHT_NOBITS;
> +               tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> +               tramp->sh_addralign = __alignof__(struct plt_entry);
> +               tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
> +       }
> +
>         return 0;
>  }
> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> index 825fcf77f9e7..a606a0cab968 100644
> --- a/arch/loongarch/kernel/module.c
> +++ b/arch/loongarch/kernel/module.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/moduleloader.h>
>  #include <linux/elf.h>
> +#include <linux/ftrace.h>
>  #include <linux/mm.h>
>  #include <linux/numa.h>
>  #include <linux/vmalloc.h>
> @@ -18,6 +19,7 @@
>  #include <linux/string.h>
>  #include <linux/kernel.h>
>  #include <asm/alternative.h>
> +#include <asm/inst.h>
>
>  static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
>  {
> @@ -458,6 +460,24 @@ void *module_alloc(unsigned long size)
>                         GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
>  }
>
> +static int module_init_ftrace_plt(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
> +                                 struct module *mod)
> +{
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +       struct plt_entry *ftrace_plts;
> +
> +       ftrace_plts = (void *)sechdrs->sh_addr;
> +
> +       ftrace_plts[FTRACE_PLT_IDX] = emit_plt_entry(FTRACE_ADDR);
> +
> +       if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
> +               ftrace_plts[FTRACE_REGS_PLT_IDX] = emit_plt_entry(FTRACE_REGS_ADDR);
> +
> +       mod->arch.ftrace_trampolines = ftrace_plts;
> +#endif
> +       return 0;
> +}
> +
>  int module_finalize(const Elf_Ehdr *hdr,
>                     const Elf_Shdr *sechdrs, struct module *mod)
>  {
> @@ -467,6 +487,8 @@ int module_finalize(const Elf_Ehdr *hdr,
>         for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
>                 if (!strcmp(".altinstructions", secstrs + s->sh_name))
>                         apply_alternatives((void *)s->sh_addr, (void *)s->sh_addr + s->sh_size);
> +               if (!strcmp(".ftrace_trampoline", secstrs + s->sh_name))
> +                       return module_init_ftrace_plt(hdr, s, mod);
We shouldn't return here, because we are in a loop, if
.ftrace_trampoline is before .altinstructions, we will lose the
apply_alternatives() call.

Huacai
>         }
>
>         return 0;
> --
> 2.36.0
>
