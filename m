Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8048973B2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFWIWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjFWIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:21:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284152685
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:21:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b4790ff688so6272751fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687508511; x=1690100511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IZTTdyBUU6kATu3fUQ5nadTxHv+u++mh69pFEYTDLk=;
        b=LNOkB7INXGOoecOv8+l3/Dgm+QBB5adKiCupWOi143QWjyhOwzBGuss99Mz5vCPYx3
         C1fkGjXyhRvOlB7RI8Fsubo6LXvd4yZg6j5Bq4aWos82NuN26FMsUfSJaXItRoeRTIwI
         XxZU1fLtyPArusmzylmK9xNt3NeVHfhGnL54iEgWf+nXK1n4rDc1qpLnNjhAfJC/t4Ho
         5fkjdNxHDIFHyN7L9GE3Ao9+9W49PYh802bLx8Tj7CvJAgGR1KtMjTNxtii8Fn03uglu
         gLV3ouBDEtQNlEaXS7cMfYX29bXew2v/vCXOlMu+d9TzwS8FT6n5NAcmy1FDIl92yS9K
         SyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508511; x=1690100511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IZTTdyBUU6kATu3fUQ5nadTxHv+u++mh69pFEYTDLk=;
        b=PgTwWJFiUcg6m/0V42vl+eEVqTZNRBf3QSbvWsv/4hAuuIsx1y5ZoHp1oEbTXbqQHs
         pcOTE0ABxANwbkCz/6ueT/5A2/h2YFdkFO5sxkqT0WEqJY5ll8KLMuQcxZZKEDnL2mhR
         jOQP3jEqpSQX/eCrmNntP5Y9pp5Tlu7jKTFwreFIIThxgoFmzTnbGVV2Runt3cf7xaYc
         JXUitnVTf1x77+Bj/QK0W4kTbo3AYjM2Ecy4vc5FdkBjS10l8SfvDz+vU6s5rPstESQh
         S3AubWEDW3KguYY6NHkD6QEqmoIzwZ8xSUqfTS5ptsUGeHbhNknJcnuJ9/+FrzPbl3DC
         Ts0g==
X-Gm-Message-State: AC+VfDw6Uy98+0cbZ3O9VzBqcThjoLjimND4DUEXtyGNOXTbDWAyl8dS
        HflmFaNKiPdUpyfvoUFDeYJGD0f3YuMtN8ME7HSYFw==
X-Google-Smtp-Source: ACHHUZ4njTd+hh7CL7SU3SYO3tZHVYQGGsQUr8SVZSERnrZKXx+YZ9aTJrEJG0Zi+XpjFViU8W4HTLh72Fb0WOCNaP8=
X-Received: by 2002:a2e:a175:0:b0:2b1:fda8:e653 with SMTP id
 u21-20020a2ea175000000b002b1fda8e653mr13641043ljl.27.1687508510953; Fri, 23
 Jun 2023 01:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-2-eric.lin@sifive.com>
 <3f264505-af11-b667-fc82-a5310982ef8b@codethink.co.uk>
In-Reply-To: <3f264505-af11-b667-fc82-a5310982ef8b@codethink.co.uk>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 23 Jun 2023 16:21:38 +0800
Message-ID: <CAPqJEFp+4F3cjUUd6vse72zDa021wodtbvzxz41vvztGreLN6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: sifive: Add SiFive private L2 cache support
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Nick Hu <nick.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Fri, Jun 16, 2023 at 4:30=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> On 16/06/2023 07:32, Eric Lin wrote:
> > This adds SiFive private L2 cache driver which will show
> > cache config information when booting and add cpu hotplug
> > callback functions.
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > ---
> >   drivers/soc/sifive/Kconfig            |   8 +
> >   drivers/soc/sifive/Makefile           |   1 +
> >   drivers/soc/sifive/sifive_pl2.h       |  25 ++++
> >   drivers/soc/sifive/sifive_pl2_cache.c | 202 +++++++++++++++++++++++++=
+
> >   include/linux/cpuhotplug.h            |   1 +
> >   5 files changed, 237 insertions(+)
> >   create mode 100644 drivers/soc/sifive/sifive_pl2.h
> >   create mode 100644 drivers/soc/sifive/sifive_pl2_cache.c
> >
> > diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> > index e86870be34c9..573564295058 100644
> > --- a/drivers/soc/sifive/Kconfig
> > +++ b/drivers/soc/sifive/Kconfig
> > @@ -7,4 +7,12 @@ config SIFIVE_CCACHE
> >       help
> >         Support for the composable cache controller on SiFive platforms=
.
> >
> > +config SIFIVE_PL2
> > +     bool "Sifive private L2 Cache controller"
> > +     help
> > +       Support for the private L2 cache controller on SiFive platforms=
.
> > +       The SiFive Private L2 Cache Controller is per hart and communic=
ates
> > +       with both the upstream L1 caches and downstream L3 cache or mem=
ory,
> > +       enabling a high-performance cache subsystem.
> > +
> >   endif
> > diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
> > index 1f5dc339bf82..707493e1c691 100644
> > --- a/drivers/soc/sifive/Makefile
> > +++ b/drivers/soc/sifive/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >
> >   obj-$(CONFIG_SIFIVE_CCACHE) +=3D sifive_ccache.o
> > +obj-$(CONFIG_SIFIVE_PL2)     +=3D sifive_pl2_cache.o
> > diff --git a/drivers/soc/sifive/sifive_pl2.h b/drivers/soc/sifive/sifiv=
e_pl2.h
> > new file mode 100644
> > index 000000000000..57aa1019d5ed
> > --- /dev/null
> > +++ b/drivers/soc/sifive/sifive_pl2.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 SiFive, Inc.
> > + *
> > + */
> > +
> > +#ifndef _SIFIVE_PL2_H
> > +#define _SIFIVE_PL2_H
> > +
> > +#define SIFIVE_PL2_CONFIG1_OFFSET    0x1000
> > +#define SIFIVE_PL2_CONFIG0_OFFSET    0x1008
> > +#define SIFIVE_PL2_PMCLIENT_OFFSET   0x2800
> > +
> > +struct sifive_pl2_state {
> > +     void __iomem *pl2_base;
> > +     u32 config1;
> > +     u32 config0;
> > +     u64 pmclientfilter;
> > +};
> > +
> > +int sifive_pl2_pmu_init(void);
> > +int sifive_pl2_pmu_probe(struct device_node *pl2_node,
> > +                      void __iomem *pl2_base, int cpu);
> > +
> > +#endif /*_SIFIVE_PL2_H */
> > diff --git a/drivers/soc/sifive/sifive_pl2_cache.c b/drivers/soc/sifive=
/sifive_pl2_cache.c
> > new file mode 100644
> > index 000000000000..aeb51d576af9
> > --- /dev/null
> > +++ b/drivers/soc/sifive/sifive_pl2_cache.c
> > @@ -0,0 +1,202 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SiFive private L2 cache controller Driver
> > + *
> > + * Copyright (C) 2018-2023 SiFive, Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "pL2CACHE: " fmt
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/cpu_pm.h>
> > +#include <linux/cpuhotplug.h>
> > +#include "sifive_pl2.h"
> > +
> > +static DEFINE_PER_CPU(struct sifive_pl2_state, sifive_pl2_state);
> > +
> > +static void sifive_pl2_state_save(struct sifive_pl2_state *pl2_state)
> > +{
> > +     void __iomem *pl2_base =3D pl2_state->pl2_base;
> > +
> > +     if (!pl2_base)
> > +             return;
>
> is this test realy needed?
>

Yes,
The function cpuhp_setup_state() is called before sifive_pl2_cache_dev_prob=
e().
When registering the CPU hotplug state, the kernel will issue the pl2
CPU hotplug callback.
However, the pl2_base is not yet being ioremap in sifive_pl2_cache_dev_prob=
e().
Therefore, it is necessary to check pl2_base first to avoid such a scenario=
.

> > +
> > +     pl2_state->config1 =3D readl(pl2_base + SIFIVE_PL2_CONFIG1_OFFSET=
);
> > +     pl2_state->config0 =3D readl(pl2_base + SIFIVE_PL2_CONFIG0_OFFSET=
);
> > +     pl2_state->pmclientfilter =3D readq(pl2_base + SIFIVE_PL2_PMCLIEN=
T_OFFSET);
> > +}
> > +
> > +static void sifive_pl2_state_restore(struct sifive_pl2_state *pl2_stat=
e)
> > +{
> > +     void __iomem *pl2_base =3D pl2_state->pl2_base;
> > +
> > +     if (!pl2_base)
> > +             return;
> > +
> > +     writel(pl2_state->config1, pl2_base + SIFIVE_PL2_CONFIG1_OFFSET);
> > +     writel(pl2_state->config0, pl2_base + SIFIVE_PL2_CONFIG0_OFFSET);
> > +     writeq(pl2_state->pmclientfilter, pl2_base + SIFIVE_PL2_PMCLIENT_=
OFFSET);
> > +}
> > +
> > +/*
> > + * CPU Hotplug call back function
> > + */
> > +static int sifive_pl2_online_cpu(unsigned int cpu)
> > +{
> > +     struct sifive_pl2_state *pl2_state =3D this_cpu_ptr(&sifive_pl2_s=
tate);
> > +
> > +     sifive_pl2_state_restore(pl2_state);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sifive_pl2_offline_cpu(unsigned int cpu)
> > +{
> > +     struct sifive_pl2_state *pl2_state =3D this_cpu_ptr(&sifive_pl2_s=
tate);
> > +
> > +     /* Save the pl2 state */
> > +     sifive_pl2_state_save(pl2_state);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + *  PM notifer for suspend to ram
> > + */
> > +#ifdef CONFIG_CPU_PM
> > +static int sifive_pl2_pm_notify(struct notifier_block *b, unsigned lon=
g cmd,
> > +                             void *v)
> > +{
> > +     struct sifive_pl2_state *pl2_state =3D this_cpu_ptr(&sifive_pl2_s=
tate);
> > +
> > +     switch (cmd) {
> > +     case CPU_PM_ENTER:
> > +             /* Save the pl2 state */
> > +             sifive_pl2_state_save(pl2_state);
> > +             break;
> > +     case CPU_PM_ENTER_FAILED:
> > +     case CPU_PM_EXIT:
> > +             sifive_pl2_state_restore(pl2_state);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block sifive_pl2_pm_notifier_block =3D {
> > +     .notifier_call =3D sifive_pl2_pm_notify,
> > +};
> > +
> > +static inline void sifive_pl2_pm_init(void)
> > +{
> > +     cpu_pm_register_notifier(&sifive_pl2_pm_notifier_block);
> > +}
> > +
> > +#else
> > +static inline void sifive_pl2_pm_init(void) { }
> > +#endif /* CONFIG_CPU_PM */
> > +
> > +static const struct of_device_id sifive_pl2_cache_of_ids[] =3D {
> > +     { .compatible =3D "sifive,pL2Cache0" },
> > +     { .compatible =3D "sifive,pL2Cache1" },
>
> why the single cap here? I think that looks ugly.
>

OK, I'll fix it in v2.

> > +     { /* sentinel value */ }
> > +};
> > +
> > +static void pl2_config_read(void __iomem *pl2_base, int cpu)
> > +{
> > +     u32 regval, bank, way, set, cacheline;
> > +
> > +     regval =3D readl(pl2_base);
> > +     bank =3D regval & 0xff;
> > +     pr_info("in the CPU: %d\n", cpu);
> > +     pr_info("No. of Banks in the cache: %d\n", bank);
> > +     way =3D (regval & 0xff00) >> 8;
> > +     pr_info("No. of ways per bank: %d\n", way);
> > +     set =3D (regval & 0xff0000) >> 16;
> > +     pr_info("Total sets: %llu\n", (uint64_t)1 << set);
> > +     cacheline =3D (regval & 0xff000000) >> 24;
> > +     pr_info("Bytes per cache block: %llu\n", (uint64_t)1 << cacheline=
);
> > +     pr_info("Size: %d\n", way << (set + cacheline));
>
>
> please either remove this or make it a single line, this is just going
> to spam the log with any system with more than one cpu core.
>

OK, I will make this log more simple in v2.
Thanks for the review.

Best Regards,
Eric Lin.

> > +}
> > +
> > +static int sifive_pl2_cache_dev_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *res;
> > +     int cpu, ret =3D -EINVAL;
> > +     struct device_node *cpu_node, *pl2_node;
> > +     struct sifive_pl2_state *pl2_state =3D NULL;
> > +     void __iomem *pl2_base;
> > +
> > +     /* Traverse all cpu nodes to find the one mapping to its pl2 node=
. */
> > +     for_each_cpu(cpu, cpu_possible_mask) {
> > +             cpu_node =3D of_cpu_device_node_get(cpu);
> > +             pl2_node =3D of_parse_phandle(cpu_node, "next-level-cache=
", 0);
> > +
> > +             /* Found it! */
> > +             if (dev_of_node(&pdev->dev) =3D=3D pl2_node) {
> > +                     /* Use cpu to get its percpu data sifive_pl2_stat=
e. */
> > +                     pl2_state =3D per_cpu_ptr(&sifive_pl2_state, cpu)=
;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!pl2_state) {
> > +             pr_err("Not found the corresponding cpu_node in dts.\n");
> > +             goto early_err;
> > +     }
> > +
> > +     /* Set base address of select and counter registers. */
> > +     pl2_base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res=
);
> > +     if (IS_ERR(pl2_base)) {
> > +             ret =3D PTR_ERR(pl2_base);
> > +             goto early_err;
> > +     }
> > +
> > +     /* Print pL2 configs. */
> > +     pl2_config_read(pl2_base, cpu);
> > +     pl2_state->pl2_base =3D pl2_base;
> > +
> > +     return 0;
> > +
> > +early_err:
> > +     return ret;
> > +}
> > +
> > +static struct platform_driver sifive_pl2_cache_driver =3D {
> > +     .driver =3D {
> > +                .name =3D "SiFive-pL2-cache",
> > +                .of_match_table =3D sifive_pl2_cache_of_ids,
> > +                },
> > +     .probe =3D sifive_pl2_cache_dev_probe,
> > +};
> > +
> > +static int __init sifive_pl2_cache_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D cpuhp_setup_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
> > +                             "soc/sifive/pl2:online",
> > +                                   sifive_pl2_online_cpu,
> > +                                   sifive_pl2_offline_cpu);
> > +     if (ret < 0) {
> > +             pr_err("Failed to register CPU hotplug notifier %d\n", re=
t);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D platform_driver_register(&sifive_pl2_cache_driver);
> > +     if (ret) {
> > +             pr_err("Failed to register sifive_pl2_cache_driver: %d\n"=
, ret);
> > +             return ret;
> > +     }
> > +
> > +     sifive_pl2_pm_init();
> > +
> > +     return ret;
> > +}
> > +
> > +device_initcall(sifive_pl2_cache_init);
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 0f1001dca0e0..35cd5ba0030b 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -207,6 +207,7 @@ enum cpuhp_state {
> >       CPUHP_AP_IRQ_AFFINITY_ONLINE,
> >       CPUHP_AP_BLK_MQ_ONLINE,
> >       CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
> > +     CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
> >       CPUHP_AP_X86_INTEL_EPB_ONLINE,
> >       CPUHP_AP_PERF_ONLINE,
> >       CPUHP_AP_PERF_X86_ONLINE,
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
