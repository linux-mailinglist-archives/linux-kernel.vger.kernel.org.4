Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D879C730D44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbjFOCbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjFOCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D62683;
        Wed, 14 Jun 2023 19:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D177C618CE;
        Thu, 15 Jun 2023 02:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E80DC433CB;
        Thu, 15 Jun 2023 02:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686796277;
        bh=Si/Tf+Eqe5mk7ecGTKWOceVzZNl9K6bgEh+lpHRHCEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FquzsmDu8CYdj2bOLF9tUqIJjXS68sHmNxabtN+bH4B+PsealCGHtgJ+WwVTyyLwE
         iwlBQyEA1zOZTZMPKde9Yco3QknhXFrLzpQ4gQ66tBPypr0b7MBhrzlqRMple6iUe+
         ZZghvZDZ1I5fc6dTLsdBjZIa/hRZQDkkVNyckf6Tv2YRMZKrU7qIG2aK3PiTpv2C4q
         HLHiVv7nmRtobcgXY6Uixio7g1TsC/kvHpjuV2Fb62iw8vPFGslFTYxH9lz71j0woM
         RKBw1mS9cwf6QkwdUYPygRE2wfix01RiHVfmDMZqAvujcYXHSrFnUzgJ5t5Mo5s8XL
         xuK59qEwha/fQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f62b552751so9735413e87.3;
        Wed, 14 Jun 2023 19:31:17 -0700 (PDT)
X-Gm-Message-State: AC+VfDxHU1/FOm92cI4edWPeuPo3AbxqnPe3SEyBoj81M9qeLWlDUwwU
        R1BhbKs3FG65IHQgYgp2os7vOQkN7zbLxn2AELo=
X-Google-Smtp-Source: ACHHUZ58fYYF27zw2qoDK75nI8/jVNrLM8/3xmOzSL6rgh6Qe7fb5goj956EKKrraCoZGQx8rkP3HwWKqmLo9knsXec=
X-Received: by 2002:a19:e05a:0:b0:4e9:9f10:b31d with SMTP id
 g26-20020a19e05a000000b004e99f10b31dmr9130364lfj.2.1686796275141; Wed, 14 Jun
 2023 19:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230614093755.88881-1-wangliupu@loongson.cn> <CAJZ5v0iTKPbpskDVcsnVaWnhdvb5a-W2TVBfd0c=H2hVv8mOog@mail.gmail.com>
In-Reply-To: <CAJZ5v0iTKPbpskDVcsnVaWnhdvb5a-W2TVBfd0c=H2hVv8mOog@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 15 Jun 2023 10:31:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7=+cyLK=whuYL3qD+CwFqxvSWywnLEVJ5W=0uqH+ZKiQ@mail.gmail.com>
Message-ID: <CAAhV-H7=+cyLK=whuYL3qD+CwFqxvSWywnLEVJ5W=0uqH+ZKiQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add SMT (Simultaneous Multi-Threading) support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Liupu Wang <wangliupu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, Len Brown <lenb@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,

On Thu, Jun 15, 2023 at 2:24=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jun 14, 2023 at 11:38=E2=80=AFAM Liupu Wang <wangliupu@loongson.c=
n> wrote:
> >
> > From: Huacai Chen <chenhuacai@loongson.cn>
> >
> > Loongson-3A6000 has SMT (Simultaneous Multi-Threading) support, each
> > physical core has two logical cores (threads). This patch add SMT probe
> > and scheduler support via ACPI PPTT.
> >
> > If SCHED_SMT enabled, Loongson-3A6000 is treated as 4 cores, 8 threads;
> > If SCHED_SMT disabled, Loongson-3A6000 is treated as 8 cores, 8 threads=
.
> >
> > Remove smp_num_siblings to support HMP (Heterogeneous Multi-Processing)=
.
> >
> > Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/Kconfig                |  8 +++++++
> >  arch/loongarch/include/asm/acpi.h     |  9 ++++++++
> >  arch/loongarch/include/asm/cpu-info.h |  1 +
> >  arch/loongarch/kernel/acpi.c          | 32 +++++++++++++++++++++++++++
> >  arch/loongarch/kernel/proc.c          |  1 +
> >  arch/loongarch/kernel/smp.c           | 24 +++++++++-----------
> >  drivers/acpi/Kconfig                  |  2 +-
> >  7 files changed, 62 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index d38b066fc931..6d36b681068e 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -5,6 +5,7 @@ config LOONGARCH
> >         select ACPI
> >         select ACPI_GENERIC_GSI if ACPI
> >         select ACPI_MCFG if ACPI
> > +       select ACPI_PPTT if ACPI
> >         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> >         select ARCH_BINFMT_ELF_STATE
> >         select ARCH_ENABLE_MEMORY_HOTPLUG
> > @@ -372,6 +373,13 @@ config EFI_STUB
> >           This kernel feature allows the kernel to be loaded directly b=
y
> >           EFI firmware without the use of a bootloader.
> >
> > +config SCHED_SMT
> > +       bool "SMT scheduler support"
> > +       default y
> > +       help
> > +         Improves scheduler's performance when there are multiple
> > +         threads in one physical core.
> > +
> >  config SMP
> >         bool "Multi-Processing support"
> >         help
> > diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include=
/asm/acpi.h
> > index 976a810352c6..5c78b5d2bfb7 100644
> > --- a/arch/loongarch/include/asm/acpi.h
> > +++ b/arch/loongarch/include/asm/acpi.h
> > @@ -13,6 +13,7 @@ extern int acpi_strict;
> >  extern int acpi_disabled;
> >  extern int acpi_pci_disabled;
> >  extern int acpi_noirq;
> > +extern int pptt_enabled;
> >
> >  #define acpi_os_ioremap acpi_os_ioremap
> >  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size si=
ze);
> > @@ -30,6 +31,14 @@ static inline bool acpi_has_cpu_in_madt(void)
> >  }
> >
> >  extern struct list_head acpi_wakeup_device_list;
> > +extern struct acpi_madt_core_pic acpi_core_pic[NR_CPUS];
> > +
> > +extern int __init parse_acpi_topology(void);
> > +
> > +static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
> > +{
> > +       return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
> > +}
> >
> >  #endif /* !CONFIG_ACPI */
> >
> > diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/inc=
lude/asm/cpu-info.h
> > index cd73a6f57fe3..900589cb159d 100644
> > --- a/arch/loongarch/include/asm/cpu-info.h
> > +++ b/arch/loongarch/include/asm/cpu-info.h
> > @@ -54,6 +54,7 @@ struct cpuinfo_loongarch {
> >         struct cache_desc       cache_leaves[CACHE_LEAVES_MAX];
> >         int                     core;   /* physical core number in pack=
age */
> >         int                     package;/* physical package number */
> > +       int                     global_id; /* physical global thread nu=
mber */
> >         int                     vabits; /* Virtual Address size in bits=
 */
> >         int                     pabits; /* Physical Address size in bit=
s */
> >         unsigned int            ksave_mask; /* Usable KSave mask. */
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.=
c
> > index 98f431157e4c..9450e09073eb 100644
> > --- a/arch/loongarch/kernel/acpi.c
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -33,6 +33,8 @@ u64 acpi_saved_sp;
> >
> >  #define PREFIX                 "ACPI: "
> >
> > +struct acpi_madt_core_pic acpi_core_pic[NR_CPUS];
> > +
> >  void __init __iomem * __acpi_map_table(unsigned long phys, unsigned lo=
ng size)
> >  {
> >
> > @@ -99,6 +101,7 @@ acpi_parse_processor(union acpi_subtable_headers *he=
ader, const unsigned long en
> >
> >         acpi_table_print_madt_entry(&header->common);
> >  #ifdef CONFIG_SMP
> > +       acpi_core_pic[processor->core_id] =3D *processor;
> >         set_processor_mask(processor->core_id, processor->flags);
> >  #endif
> >
> > @@ -140,6 +143,35 @@ static void __init acpi_process_madt(void)
> >         loongson_sysconf.nr_cpus =3D num_processors;
> >  }
> >
> > +int pptt_enabled;
> > +
> > +int __init parse_acpi_topology(void)
> > +{
> > +       int cpu, topology_id;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               topology_id =3D find_acpi_cpu_topology(cpu, 0);
> > +               if (topology_id < 0) {
> > +                       pr_warn("Invalid BIOS PPTT\n");
> > +                       return -ENOENT;
> > +               }
> > +
> > +               if (acpi_pptt_cpu_is_thread(cpu) <=3D 0)
> > +                       cpu_data[cpu].core =3D topology_id;
> > +               else {
> > +                       topology_id =3D find_acpi_cpu_topology(cpu, 1);
> > +                       if (topology_id < 0)
> > +                               return -ENOENT;
> > +
> > +                       cpu_data[cpu].core =3D topology_id;
> > +               }
> > +       }
> > +
> > +       pptt_enabled =3D 1;
> > +
> > +       return 0;
> > +}
> > +
> >  #ifndef CONFIG_SUSPEND
> >  int (*acpi_suspend_lowlevel)(void);
> >  #else
> > diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.=
c
> > index 0d82907b5404..d4b270630bb5 100644
> > --- a/arch/loongarch/kernel/proc.c
> > +++ b/arch/loongarch/kernel/proc.c
> > @@ -49,6 +49,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >         seq_printf(m, "processor\t\t: %ld\n", n);
> >         seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
> >         seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
> > +       seq_printf(m, "global_id\t\t: %d\n", cpu_data[n].global_id);
> >         seq_printf(m, "CPU Family\t\t: %s\n", __cpu_family[n]);
> >         seq_printf(m, "Model Name\t\t: %s\n", __cpu_full_name[n]);
> >         seq_printf(m, "CPU Revision\t\t: 0x%02x\n", version);
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index ed167e244cda..062f3fe8df60 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -8,6 +8,7 @@
> >   * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
> >   * Copyright (C) 2000, 2001, 2003 Broadcom Corporation
> >   */
> > +#include <linux/acpi.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/init.h>
> > @@ -37,10 +38,6 @@ EXPORT_SYMBOL(__cpu_number_map);
> >  int __cpu_logical_map[NR_CPUS];                /* Map logical to physi=
cal */
> >  EXPORT_SYMBOL(__cpu_logical_map);
> >
> > -/* Number of threads (siblings) per CPU core */
> > -int smp_num_siblings =3D 1;
> > -EXPORT_SYMBOL(smp_num_siblings);
> > -
> >  /* Representing the threads (siblings) of each logical CPU */
> >  cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
> >  EXPORT_SYMBOL(cpu_sibling_map);
> > @@ -228,9 +225,12 @@ void __init loongson_prepare_cpus(unsigned int max=
_cpus)
> >  {
> >         int i =3D 0;
> >
> > +       parse_acpi_topology();
> > +
> >         for (i =3D 0; i < loongson_sysconf.nr_cpus; i++) {
> >                 set_cpu_present(i, true);
> >                 csr_mail_send(0, __cpu_logical_map[i], 0);
> > +               cpu_data[i].global_id =3D __cpu_logical_map[i];
> >         }
> >
> >         per_cpu(cpu_state, smp_processor_id()) =3D CPU_ONLINE;
> > @@ -271,10 +271,10 @@ void loongson_init_secondary(void)
> >         numa_add_cpu(cpu);
> >  #endif
> >         per_cpu(cpu_state, cpu) =3D CPU_ONLINE;
> > -       cpu_data[cpu].core =3D
> > -                    cpu_logical_map(cpu) % loongson_sysconf.cores_per_=
package;
> >         cpu_data[cpu].package =3D
> >                      cpu_logical_map(cpu) / loongson_sysconf.cores_per_=
package;
> > +       cpu_data[cpu].core =3D pptt_enabled ? cpu_data[cpu].core :
> > +                    cpu_logical_map(cpu) % loongson_sysconf.cores_per_=
package;
> >  }
> >
> >  void loongson_smp_finish(void)
> > @@ -380,14 +380,10 @@ static inline void set_cpu_sibling_map(int cpu)
> >
> >         cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
> >
> > -       if (smp_num_siblings <=3D 1)
> > -               cpumask_set_cpu(cpu, &cpu_sibling_map[cpu]);
> > -       else {
> > -               for_each_cpu(i, &cpu_sibling_setup_map) {
> > -                       if (cpus_are_siblings(cpu, i)) {
> > -                               cpumask_set_cpu(i, &cpu_sibling_map[cpu=
]);
> > -                               cpumask_set_cpu(cpu, &cpu_sibling_map[i=
]);
> > -                       }
> > +       for_each_cpu(i, &cpu_sibling_setup_map) {
> > +               if (cpus_are_siblings(cpu, i)) {
> > +                       cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
> > +                       cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
> >                 }
> >         }
> >  }
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index ccbeab9500ec..00dd309b6682 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -542,10 +542,10 @@ config ACPI_PFRUT
> >
> >  if ARM64
> >  source "drivers/acpi/arm64/Kconfig"
> > +endif
> >
> >  config ACPI_PPTT
> >         bool
> > -endif
>
> x86 doesn't use PPTT as of today.  Why do you enable it for them?
ACPI_PPTT is an invisible symbol, it cannot be enabled by explicitly
selecting and its default value is n, so I think it isn't enabled for
x86. On the other hand, moving it out of ARM64 can make other archs
don't need to modify this file any more if they need PPTT.

Huacai

>
> >  config ACPI_PCC
> >         bool "ACPI PCC Address Space"
> > --
