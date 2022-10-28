Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB936109B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ1FVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ1FV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:21:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8632DAC285
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:21:27 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxvrfVZltjggUDAA--.6651S3;
        Fri, 28 Oct 2022 13:21:25 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuLTZltjVi0GAA--.21982S3;
        Fri, 28 Oct 2022 13:21:25 +0800 (CST)
Subject: Re: [PATCH v5 07/10] LoongArch: modules/ftrace: Initialize PLT at
 load time
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220919031632.15374-1-zhangqing@loongson.cn>
 <20220919031632.15374-8-zhangqing@loongson.cn>
 <CAAhV-H5WqjoC-jgVD5TNx3mkq6gWoerkXHTD4SUkr-DfdnSkig@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <6f1122be-ffd2-b4ad-c7c2-9ec953b4bbb1@loongson.cn>
Date:   Fri, 28 Oct 2022 13:21:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5WqjoC-jgVD5TNx3mkq6gWoerkXHTD4SUkr-DfdnSkig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuLTZltjVi0GAA--.21982S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KF45ZFWDXF17trWrJw4UCFg_yoW8Jr4rGo
        W3tF1Igr4xJr429FW3Ja4jqFW7tw1FkrW5A3yfAwsxAa1qya4UKF17Ga1Yqay3W34ktFWf
        Gas7GFW8AayxJr95n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2
        z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hucai

On 2022/10/28 上午11:06, Huacai Chen wrote:
> Hi, Qing,
> 
> Maybe this patch can be squashed to another one? If not, please move
> it earlier because it looks like some preparation work.
>

ok, I'll move this patch sequence and send it later.

- Qing

> Huacai
> 
> On Mon, Sep 19, 2022 at 11:16 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>>
>> To Implement ftrace trampiones through plt entry.
>>
>> Tested by forcing ftrace_make_call() to use the module PLT, and then
>> loading up a module after setting up ftrace with:
>>
>> | echo ":mod:<module-name>" > set_ftrace_filter;
>> | echo function > current_tracer;
>> | modprobe <module-name>
>>
>> Since FTRACE_ADDR/FTRACE_REGS_ADDR is only defined when CONFIG_DYNAMIC_FTRACE
>> is selected, we wrap its use along with most of module_init_ftrace_plt() with
>> ifdeffery rather than using IS_ENABLED().
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/ftrace.h     |  4 ++
>>   arch/loongarch/include/asm/inst.h       |  3 +
>>   arch/loongarch/include/asm/module.h     |  5 +-
>>   arch/loongarch/include/asm/module.lds.h |  1 +
>>   arch/loongarch/kernel/ftrace_dyn.c      | 79 +++++++++++++++++++++++++
>>   arch/loongarch/kernel/inst.c            | 11 ++++
>>   arch/loongarch/kernel/module-sections.c | 11 ++++
>>   arch/loongarch/kernel/module.c          | 47 +++++++++++++++
>>   8 files changed, 160 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
>> index 5cc13ae48164..807226aad1c0 100644
>> --- a/arch/loongarch/include/asm/ftrace.h
>> +++ b/arch/loongarch/include/asm/ftrace.h
>> @@ -6,6 +6,10 @@
>>   #ifndef _ASM_LOONGARCH_FTRACE_H
>>   #define _ASM_LOONGARCH_FTRACE_H
>>
>> +#define FTRACE_PLT_IDX         0
>> +#define FTRACE_REGS_PLT_IDX    1
>> +#define NR_FTRACE_PLTS         2
>> +
>>   #ifdef CONFIG_FUNCTION_TRACER
>>   #define MCOUNT_INSN_SIZE 4             /* sizeof mcount call */
>>
>> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
>> index f4a12f872a71..5a1aa977ae20 100644
>> --- a/arch/loongarch/include/asm/inst.h
>> +++ b/arch/loongarch/include/asm/inst.h
>> @@ -15,10 +15,12 @@
>>
>>   #define ADDR_IMMMASK_LU52ID    0xFFF0000000000000
>>   #define ADDR_IMMMASK_LU32ID    0x000FFFFF00000000
>> +#define ADDR_IMMMASK_LU12IW    0x00000000FFFFF000
>>   #define ADDR_IMMMASK_ADDU16ID  0x00000000FFFF0000
>>
>>   #define ADDR_IMMSHIFT_LU52ID   52
>>   #define ADDR_IMMSHIFT_LU32ID   32
>> +#define ADDR_IMMSHIFT_LU12IW   12
>>   #define ADDR_IMMSHIFT_ADDU16ID 16
>>
>>   #define ADDR_IMM(addr, INSN)   ((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
>> @@ -346,6 +348,7 @@ u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
>>                          enum loongarch_gpr rk);
>>   u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
>>
>> +u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
>>   u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>>   u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
>>   u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
>> diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
>> index b29b19a46f42..a311cfec2b23 100644
>> --- a/arch/loongarch/include/asm/module.h
>> +++ b/arch/loongarch/include/asm/module.h
>> @@ -20,6 +20,9 @@ struct mod_arch_specific {
>>          struct mod_section got;
>>          struct mod_section plt;
>>          struct mod_section plt_idx;
>> +
>> +       /* for CONFIG_DYNAMIC_FTRACE */
>> +       struct plt_entry *ftrace_trampolines;
>>   };
>>
>>   struct got_entry {
>> @@ -49,7 +52,7 @@ static inline struct plt_entry emit_plt_entry(unsigned long val)
>>   {
>>          u32 lu12iw, lu32id, lu52id, jirl;
>>
>> -       lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | LOONGARCH_GPR_T1);
>> +       lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
>>          lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
>>          lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
>>          jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
>> diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
>> index a3d1bc0fcc72..438f09d4ccf4 100644
>> --- a/arch/loongarch/include/asm/module.lds.h
>> +++ b/arch/loongarch/include/asm/module.lds.h
>> @@ -5,4 +5,5 @@ SECTIONS {
>>          .got : { BYTE(0) }
>>          .plt : { BYTE(0) }
>>          .plt.idx : { BYTE(0) }
>> +       .ftrace_trampoline : { BYTE(0) }
>>   }
>> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
>> index f538829312d7..dd37185d446e 100644
>> --- a/arch/loongarch/kernel/ftrace_dyn.c
>> +++ b/arch/loongarch/kernel/ftrace_dyn.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/uaccess.h>
>>
>>   #include <asm/inst.h>
>> +#include <asm/module.h>
>>
>>   static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>>                                bool validate)
>> @@ -72,12 +73,63 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>>          return ftrace_modify_code(pc, old, new, true);
>>   }
>>
>> +static inline int __get_mod(struct module **mod, unsigned long addr)
>> +{
>> +       preempt_disable();
>> +       *mod = __module_text_address(addr);
>> +       preempt_enable();
>> +
>> +       if (WARN_ON(!(*mod)))
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
>> +{
>> +       struct plt_entry *plt = mod->arch.ftrace_trampolines;
>> +
>> +       if (addr == FTRACE_ADDR)
>> +               return &plt[FTRACE_PLT_IDX];
>> +       if (addr == FTRACE_REGS_ADDR &&
>> +                       IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
>> +               return &plt[FTRACE_REGS_PLT_IDX];
>> +
>> +       return NULL;
>> +}
>> +
>> +static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
>> +{
>> +       struct plt_entry *plt;
>> +
>> +       plt = get_ftrace_plt(mod, addr);
>> +       if (!plt) {
>> +               pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return (unsigned long)plt;
>> +}
>> +
>>   int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>   {
>>          unsigned long pc;
>> +       long offset;
>>          u32 old, new;
>>
>>          pc = rec->ip + LOONGARCH_INSN_SIZE;
>> +       offset = (long)pc - (long)addr;
>> +
>> +       if (offset < -SZ_128M || offset >= SZ_128M) {
>> +               int ret;
>> +               struct module *mod;
>> +
>> +               ret = __get_mod(&mod, pc);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               addr = get_plt_addr(mod, addr);
>> +       }
>>
>>          old = larch_insn_gen_nop();
>>          new = larch_insn_gen_bl(pc, addr);
>> @@ -89,9 +141,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>                      unsigned long addr)
>>   {
>>          unsigned long pc;
>> +       long offset;
>>          u32 old, new;
>>
>>          pc = rec->ip + LOONGARCH_INSN_SIZE;
>> +       offset = (long)pc - (long)addr;
>> +
>> +       if (offset < -SZ_128M || offset >= SZ_128M) {
>> +               int ret;
>> +               struct module *mod;
>> +
>> +               ret = __get_mod(&mod, pc);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               addr = get_plt_addr(mod, addr);
>> +       }
>>
>>          new = larch_insn_gen_nop();
>>          old = larch_insn_gen_bl(pc, addr);
>> @@ -108,6 +173,20 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>>          u32 old, new;
>>
>>          pc = rec->ip + LOONGARCH_INSN_SIZE;
>> +       offset = (long)pc - (long)addr;
>> +
>> +       if (offset < -SZ_128M || offset >= SZ_128M) {
>> +               int ret;
>> +               struct module *mod;
>> +
>> +               ret = __get_mod(&mod, pc);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               addr = get_plt_addr(mod, addr);
>> +
>> +               old_addr = get_plt_addr(mod, old_addr);
>> +       }
>>
>>          old = larch_insn_gen_bl(pc, old_addr);
>>          new = larch_insn_gen_bl(pc, addr);
>> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
>> index 2d2e942eb06a..0d6bd7000ba6 100644
>> --- a/arch/loongarch/kernel/inst.c
>> +++ b/arch/loongarch/kernel/inst.c
>> @@ -103,6 +103,17 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
>>          return insn.word;
>>   }
>>
>> +u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
>> +{
>> +       union loongarch_instruction insn;
>> +
>> +       insn.reg1i20_format.opcode = lu12iw_op;
>> +       insn.reg1i20_format.rd = rd;
>> +       insn.reg1i20_format.immediate = imm;
>> +
>> +       return insn.word;
>> +}
>> +
>>   u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
>>   {
>>          union loongarch_instruction insn;
>> diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
>> index d296a70b758f..bd1a96691c98 100644
>> --- a/arch/loongarch/kernel/module-sections.c
>> +++ b/arch/loongarch/kernel/module-sections.c
>> @@ -4,6 +4,7 @@
>>    */
>>
>>   #include <linux/elf.h>
>> +#include <linux/ftrace.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>
>> @@ -103,6 +104,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>>                                char *secstrings, struct module *mod)
>>   {
>>          unsigned int i, num_plts = 0, num_gots = 0;
>> +       Elf_Shdr *tramp = NULL;
>>
>>          /*
>>           * Find the empty .plt sections.
>> @@ -114,6 +116,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>>                          mod->arch.plt.shdr = sechdrs + i;
>>                  else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
>>                          mod->arch.plt_idx.shdr = sechdrs + i;
>> +               else if (!strcmp(secstrings + sechdrs[i].sh_name, ".ftrace_trampoline"))
>> +                       tramp = sechdrs + i;
>>          }
>>
>>          if (!mod->arch.got.shdr) {
>> @@ -166,5 +170,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>>          mod->arch.plt_idx.num_entries = 0;
>>          mod->arch.plt_idx.max_entries = num_plts;
>>
>> +       if (tramp) {
>> +               tramp->sh_type = SHT_NOBITS;
>> +               tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
>> +               tramp->sh_addralign = __alignof__(struct plt_entry);
>> +               tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
>> +       }
>> +
>>          return 0;
>>   }
>> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
>> index 097595b2fc14..e036b1ebf98e 100644
>> --- a/arch/loongarch/kernel/module.c
>> +++ b/arch/loongarch/kernel/module.c
>> @@ -10,6 +10,7 @@
>>
>>   #include <linux/moduleloader.h>
>>   #include <linux/elf.h>
>> +#include <linux/ftrace.h>
>>   #include <linux/mm.h>
>>   #include <linux/numa.h>
>>   #include <linux/vmalloc.h>
>> @@ -17,6 +18,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/string.h>
>>   #include <linux/kernel.h>
>> +#include <asm/inst.h>
>>
>>   static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
>>   {
>> @@ -456,3 +458,48 @@ void *module_alloc(unsigned long size)
>>          return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
>>                          GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
>>   }
>> +
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>> +static const Elf_Shdr *find_section(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
>> +                                   const char *name)
>> +{
>> +       const Elf_Shdr *s, *se;
>> +       const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>> +
>> +       for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
>> +               if (strcmp(name, secstrs + s->sh_name) == 0)
>> +                       return s;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +#endif
>> +
>> +static int module_init_ftrace_plt(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
>> +                                 struct module *mod)
>> +{
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>> +       const Elf_Shdr *s;
>> +       struct plt_entry *ftrace_plts;
>> +
>> +       s = find_section(hdr, sechdrs, ".ftrace_trampoline");
>> +       if (!s)
>> +               return -ENOEXEC;
>> +
>> +       ftrace_plts = (void *)s->sh_addr;
>> +
>> +       ftrace_plts[FTRACE_PLT_IDX] = emit_plt_entry(FTRACE_ADDR);
>> +
>> +       if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
>> +               ftrace_plts[FTRACE_REGS_PLT_IDX] = emit_plt_entry(FTRACE_REGS_ADDR);
>> +
>> +       mod->arch.ftrace_trampolines = ftrace_plts;
>> +#endif
>> +       return 0;
>> +}
>> +
>> +int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mod)
>> +{
>> +       return module_init_ftrace_plt(hdr, sechdrs, mod);
>> +
>> +}
>> --
>> 2.36.1
>>

