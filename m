Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D9681A06
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjA3TLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjA3TLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:11:52 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930313D61;
        Mon, 30 Jan 2023 11:11:48 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id kt14so34822095ejc.3;
        Mon, 30 Jan 2023 11:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eU65rRYM52Gc5N9gkV6nZZxQJLE3/bOxD/7FlWwA6u4=;
        b=pHaTVlx5yrjQK1EqEUb+qTVX3jJ87y0PTPwKSR1fuQuYGvdu9txYFauFQYaQ0V+ImT
         OxNeYK2BpvdPbY8ivcBcKZelLk3tPqNfZwvT4F4qgTMSr6LN/fFuorCHqurNCLRP0dPX
         WyPf06od6Q6/2Z2jL5pWK2ZUhFq4hVMpBf69OW+gTUy5BTaY2TwWKaYDwN8bFOB3vVCt
         u7zOKPlbO7JMkKh4ApjCdGevE4TpFfzSOvf33095AHagOIYv6fArEr7Zdf9PP4azUPlb
         LRFcpaGb9Il+PkbcTYRUqwihmRPg3QeJlD8k9zaRR2qa/WWeasGX7CPo49eqikjRz923
         oAow==
X-Gm-Message-State: AO0yUKXH0mMifVZ7nQsVEx6AKxLuOqy2V8MTFqO0jiPCgmNBZT/R1oRV
        swtC05SSOxftkyJyNJ5vE75nRSQ9uiRX3+7GpcE=
X-Google-Smtp-Source: AK7set+Xu6B/4xzytt/Jz5draCvC7NhSMfDYO18XJfe49e1baxtM0KT9xIySxJqmB0gOmJA1MuBhQ/KrwoQqqYxa/7A=
X-Received: by 2002:a17:906:1dcd:b0:87f:575a:9b67 with SMTP id
 v13-20020a1709061dcd00b0087f575a9b67mr2806864ejh.274.1675105906763; Mon, 30
 Jan 2023 11:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 20:11:35 +0100
Message-ID: <CAJZ5v0g218rmTM+ra-vP6qcj7OFzDSBwd4ei9H2fPjhuFsXXrA@mail.gmail.com>
Subject: Re: [PATCH 00/24] Add basic ACPI support for RISC-V
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> This patch series enables the basic ACPI infrastructure for RISC-V.
> Supporting external interrupt controllers is in progress and hence it is
> tested using polling based HVC SBI console and RAM disk.
>
> The series depends on Anup's IPI improvement series.
> https://github.com/avpatel/linux/commits/riscv_ipi_imp_v17
>
> These changes are available at
> https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17
>
> Testing:
> 1) Build Qemu with ACPI support using below branch
> https://github.com/vlsunil/qemu/tree/acpi_b1_us_review
>
> 2) Build EDK2 as per instructions in
> https://github.com/vlsunil/riscv-uefi-edk2-docs/wiki/RISC-V-Qemu-Virt-support
>
> 3) Build Linux after enabling SBI HVC and SBI earlycon
> CONFIG_RISCV_SBI_V01=y
> CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> CONFIG_HVC_RISCV_SBI=y
>
> 4) Build buildroot.
>
> Run with below command.
> qemu-system-riscv64   -nographic \
> -drive file=Build/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
> -machine virt,acpi=on -smp 16 -m 2G \
> -kernel arch/riscv/boot/Image \
> -initrd buildroot/output/images/rootfs.cpio \
> -append "root=/dev/ram ro console=hvc0 earlycon=sbi"
>
> Jisheng Zhang (1):
>   riscv: move sbi_init() earlier before jump_label_init()
>
> Sunil V L (23):
>   ACPICA: MADT: Add RISC-V INTC interrupt controller
>   ACPICA: Add structure definitions for RISC-V RHCT
>   RISC-V: ACPI: Add empty headers to enable ACPI core
>   RISC-V: ACPI: Add basic functions to build ACPI core
>   RISC-V: ACPI: Add PCI functions to build ACPI core
>   RISC-V: ACPI: Enable ACPI build infrastructure
>   ACPI: Enable ACPI_PROCESSOR for RISC-V
>   ACPI: OSL: Make should_use_kmap() 0 for RISC-V.
>   ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
>   RISC-V: ACPI: irqchip/riscv-intc: Add ACPI support
>   RISC-V: ACPI: smpboot: Create wrapper smp_setup()
>   RISC-V: ACPI: smpboot: Add ACPI support in smp_setup()
>   RISC-V: ACPI: smpboot: Add function to retrieve the hartid
>   clocksource/timer-riscv: Refactor riscv_timer_init_dt()
>   RISC-V: ACPI: clocksource/timer-riscv: Add ACPI support
>   ACPI: RISC-V: drivers/acpi: Add RHCT related code
>   RISC-V: ACPI: time.c: Add ACPI support for time_init()
>   RISC-V: ACPI: cpufeature: Add ACPI support in riscv_fill_hwcap()
>   RISC-V: ACPI: cpu: Enable cpuinfo for ACPI systems
>   RISC-V: ACPI: Add ACPI initialization in setup_arch()
>   RISC-V: ACPI: Enable ACPI in defconfig
>   MAINTAINERS: Add entry for drivers/acpi/riscv
>   Documentation/kernel-parameters.txt: Add RISC-V for ACPI parameter

The series looks fine to me from the ACPI perspective, so please feel
free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it and route it via RISC-V.

Thanks!
