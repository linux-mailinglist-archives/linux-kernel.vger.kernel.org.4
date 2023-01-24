Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14808679A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAXNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjAXNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:53:17 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F170B474FA;
        Tue, 24 Jan 2023 05:51:05 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id t10so16510458vsr.3;
        Tue, 24 Jan 2023 05:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UK0fXrTkJwJzi1pRcsI6wG0hg09s56RyLVMj/pXNLc=;
        b=wz8xWAe0mIc5k/3s9/n6VexXbsmyeNUKJDaFAbbQLzYJUhVyvpNeRmZcBohzAPs/Cx
         KdVK5OpvQw5AciFDnXGd6GtpRTM0Duezb0cVUqN7TnlmNxe9VqKq5ezaNxOpBHhiQCNX
         B9ChJATfS+K2KDCzsYhFZF4cl7qC46zX54NoMqCc2oMiKmPxsJDVP/cMf6KLDAhY3cfx
         sPy+Oeo5/n2bZZG6YsQMbfEV+B4ZlGACnXkgVK2SKFS2EE6DGlv7Tcq6Zu8BbWqs5wxo
         yTA1r5bPR+lL44XddY5lTbMKk91vNnn6QFiWMUGrypnyEqt9Ywu+RJ6iJ1hozkWPZtBE
         AGNw==
X-Gm-Message-State: AFqh2koNgXh+GUz5bD3EHnA9LhhpAwEIrhwi7vHgFiHo2Defx+JtRmgV
        KY8HV4y4ILbPXeVekP/1RuCCk62Pfn/+bA==
X-Google-Smtp-Source: AMrXdXt9CHc9JQMD77EsKnkBUCZiaUE+o/td/+8eaxpC05tCukheE7mbRVcNG7gJQPa7ACdC+pJl1A==
X-Received: by 2002:a67:dc86:0:b0:3d0:cf76:ccd4 with SMTP id g6-20020a67dc86000000b003d0cf76ccd4mr16957573vsk.29.1674568229564;
        Tue, 24 Jan 2023 05:50:29 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a158a00b007023fc46b64sm1413283qkk.113.2023.01.24.05.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:50:28 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5063029246dso50416827b3.6;
        Tue, 24 Jan 2023 05:50:27 -0800 (PST)
X-Received: by 2002:a81:68c4:0:b0:506:6059:e949 with SMTP id
 d187-20020a8168c4000000b005066059e949mr34950ywc.502.1674568227604; Tue, 24
 Jan 2023 05:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20230104183033.755668-1-pierre.gondois@arm.com> <20230104183033.755668-7-pierre.gondois@arm.com>
In-Reply-To: <20230104183033.755668-7-pierre.gondois@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jan 2023 14:50:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
Message-ID: <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Wed, Jan 4, 2023 at 7:35 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
> commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
> in the CPU hotplug path")
> adds a call to detect_cache_attributes() to populate the cacheinfo
> before updating the siblings mask. detect_cache_attributes() allocates
> memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
> kernels, on secondary CPUs, this triggers a:
>   'BUG: sleeping function called from invalid context' [1]
> as the code is executed with preemption and interrupts disabled.
>
> The primary CPU was previously storing the cache information using
> the now removed (struct cpu_topology).llc_id:
> commit 5b8dc787ce4a ("arch_topology: Drop LLC identifier stash from
> the CPU topology")
>
> allocate_cache_info() tries to build the cacheinfo from the primary
> CPU prior secondary CPUs boot, if the DT/ACPI description
> contains cache information.
> If allocate_cache_info() fails, then fallback to the current state
> for the cacheinfo allocation. [1] will be triggered in such case.
>
> When unplugging a CPU, the cacheinfo memory cannot be freed. If it
> was, then the memory would be allocated early by the re-plugged
> CPU and would trigger [1].
>
> Note that populate_cache_leaves() might be called multiple times
> due to populate_leaves being moved up. This is required since
> detect_cache_attributes() might be called with per_cpu_cacheinfo(cpu)
> being allocated but not populated.
>
> [1]:
> [    7.560791] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [    7.560794] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
> [    7.560796] preempt_count: 1, expected: 0
> [    7.560797] RCU nest depth: 1, expected: 1
> [    7.560799] 3 locks held by swapper/111/0:
> [    7.560800]  #0: ffff403e406cae98 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
> [    7.560811]  #1: ffffc5f8ed09f8e8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
> [    7.560820]  #2: ffff403f400b4fd8 (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
> [    7.560824] irq event stamp: 0
> [    7.560825] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    7.560827] hardirqs last disabled at (0): [<ffffc5f8e9f7d594>] copy_process+0x5dc/0x1ab8
> [    7.560830] softirqs last  enabled at (0): [<ffffc5f8e9f7d594>] copy_process+0x5dc/0x1ab8
> [    7.560833] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    7.560834] Preemption disabled at:
> [    7.560835] [<ffffc5f8e9fd3c28>] migrate_enable+0x30/0x130
> [    7.560838] CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
> [    7.560841] Call trace:
> [...]
> [    7.560870]  __kmalloc+0xbc/0x1e8
> [    7.560873]  detect_cache_attributes+0x2d4/0x5f0
> [    7.560876]  update_siblings_masks+0x30/0x368
> [    7.560880]  store_cpu_topology+0x78/0xb8
> [    7.560883]  secondary_start_kernel+0xd0/0x198
> [    7.560885]  __secondary_switched+0xb0/0xb4
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks for your patch, which is now commit 5944ce092b97caed
("arch_topology: Build cacheinfo from primary CPU") in
driver-core/driver-core-next.

> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -736,7 +736,7 @@ void update_siblings_masks(unsigned int cpuid)
>
>         ret = detect_cache_attributes(cpuid);
>         if (ret && ret != -ENOENT)
> -               pr_info("Early cacheinfo failed, ret = %d\n", ret);
> +               pr_info("Early cacheinfo allocation failed, ret = %d\n", ret);
>
>         /* update core and thread sibling masks */
>         for_each_online_cpu(cpu) {
> @@ -825,7 +825,7 @@ __weak int __init parse_acpi_topology(void)
>  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>  void __init init_cpu_topology(void)
>  {
> -       int ret;
> +       int cpu, ret;
>
>         reset_cpu_topology();
>         ret = parse_acpi_topology();
> @@ -840,6 +840,14 @@ void __init init_cpu_topology(void)
>                 reset_cpu_topology();
>                 return;
>         }
> +
> +       for_each_possible_cpu(cpu) {
> +               ret = fetch_cache_info(cpu);
> +               if (ret) {
> +                       pr_err("Early cacheinfo failed, ret = %d\n", ret);

This triggers on all my RV64 platforms (K210, Icicle, Starlight,
RZ/Five).

This seems to be a respin of
https://lore.kernel.org/all/CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com
which had the same issue.

> +                       break;
> +               }
> +       }
>  }
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
