Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320DE6CB537
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjC1D5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjC1D5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:57:03 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE535B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:57:00 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id d18so9311630vsv.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679975820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up8kcpRh5A8AgkCvhCtffSQcv7zYc3KHSniLjQlYTHk=;
        b=HbICSn2AJRNuRLMxAFNjjJOPyWWI42hDZyHN7mD03LijOxYuTAOmkPprdVb11IQdz3
         HJVQe1DA1ea9KXU2f96CuprNOQDkrt8vv1iQYdvFBZQY2LVT9kZEU2k0AlsM+7ynKrq7
         kblI95vXSzKfuQe4eXkcJbfFA40wD2N1rvAmR5Zzofnb7UWoX8CMbMmUE0c7G/9Z+Klu
         vgT7CNR/HJ+NuL7ZfC8SaN0CFbR/HOXZI6Llqv0sk8K6/f5XZW44sKISrNjeWezHRwOv
         Ctf8ymfLeaSZ3EulTHZtTxIJ3Qo8phGLTbQ3DU7fubf0qQWFeAcOLez+DqKej+TREvBw
         QxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up8kcpRh5A8AgkCvhCtffSQcv7zYc3KHSniLjQlYTHk=;
        b=c+30QGfGBW1X58DRBxgZsKkhjxLOawwjfEwJz9P6FRm5GKUNB4naTepgLhN8MAag5b
         vdGj+WDENHOco+twSRemj5XAVCzWrPdih0hfymHRy0jF2sJmtMR20c/IW0CzRe0ehyEF
         KuaIT2ZSI0LBitUXco8BogwS8sVJ+y119g3zeSZQQYk+V6VjZKOaZNBwdxc/lrh5E25M
         dE8tQm5IK1Rc1DoFfTh+pBVwlGUp0Q4AlQ50T/GxDBqYUde8nWiF+ZqbvvQqkrd/2gaA
         KeOyKL65HMeDrp785VTgaesMb8jUb36JYqo1bK6OC/q6vujR0mIUGEDY7vzfgg5r6hkn
         cjyg==
X-Gm-Message-State: AAQBX9fI5y6MmX8AZdgoxLQcqypPuBMpqKvgA99hJZ/600njJqMimunJ
        LHyVJ8cU2zK4F+hNfYKIM41C6aLE6f7Lk9EyuxBprg==
X-Google-Smtp-Source: AKy350b9kY6olA1p3uxflXRf9RS6aOG1fZkmW/G0u80rxtSJyJOPuK+z5crL5G4SyolV9AkUyFRlZJP6d9LWKRXKFew=
X-Received: by 2002:a67:e086:0:b0:425:b38b:650 with SMTP id
 f6-20020a67e086000000b00425b38b0650mr7274841vsl.7.1679975819565; Mon, 27 Mar
 2023 20:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230328035223.1480939-1-apatel@ventanamicro.com>
In-Reply-To: <20230328035223.1480939-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 28 Mar 2023 09:26:47 +0530
Message-ID: <CAK9=C2VM=Xm95aPpikRZX9xfwV5y5=22ehUzhSbz45KGj4C2ew@mail.gmail.com>
Subject: Re: [PATCH v18 0/7] RISC-V IPI Improvements
To:     Palmer Dabbelt <palmer@dabbelt.com>, Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc and Palmer,

On Tue, Mar 28, 2023 at 9:22=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series aims to improve IPI support in Linux RISC-V in following ways=
:
>  1) Treat IPIs as normal per-CPU interrupts instead of having custom RISC=
-V
>     specific hooks. This also makes Linux RISC-V IPI support aligned with
>     other architectures.
>  2) Remote TLB flushes and icache flushes should prefer local IPIs instea=
d
>     of SBI calls whenever we have specialized hardware (such as RISC-V AI=
A
>     IMSIC and RISC-V SWI) which allows S-mode software to directly inject
>     IPIs without any assistance from M-mode runtime firmware.
>
> These patches were originally part of the "Linux RISC-V ACLINT Support"
> series but this now a separate series so that it can be merged independen=
tly
> of the "Linux RISC-V ACLINT Support" series.
> (Refer, https://lore.kernel.org/lkml/20211007123632.697666-1-anup.patel@w=
dc.com/)
>
> These patches are also a preparatory patches for the up-coming:
>  1) Linux RISC-V AIA support
>  2) Linux RISC-V SWI support
>
> These patches can also be found in riscv_ipi_imp_v18 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v17:
>  - Resolved merge conflicts and rebased on Linux-6.3-rc4
>
> Changes since v16:
>  - Rebased on Linux-6.3-rc1
>  - Dropped PATCH3 and PATCH9 since these patches are already merged
>  - Added Palmer's Acked-by
>
> Changes since v15:
>  - Rebased on Linux-6.2-rc2
>  - Added Reviewed-by and Tested-by tags to some of the patches.
>
> Changes since v14:
>  - Minor fixes in commit description of PATCH3 (as suggested by tglx)
>  - Don't disable parent IPI when CPU goes offline for SBI IPI driver and
>    CLINT driver in PATCH4.
>  - Include Apple AIC driver changes from Marc Z as PATCH9
>
> Changes since v13:
>  - Included changes suggested by Marc Z in PATCH3
>  - Use chained handlers in PATCH4
>  - Added new PATCH8 to have empty irq_eoi() in RISC-V INTC driver. This
>    avoids the unnecessary mask/unmask dance at time of handling interrupt=
s.
>
> Changes since v12:
>  - Rebased on Linux-6.1-rc7
>  - Bring-back the IPI optimization in ipi_mux_send_mask() for PATCH3
>  - Call ipi_mux_send() for one target CPU at a time in PATCH3
>
> Changes since v11:
>  - Removed ipi_mux_pre/post_handle() callbacks in PATCH3
>  - Removed sturct ipi_mux_ops in PATCH3
>  - Removed parent_virq and data pointer from everywhere in PATCH3
>  - Removed struct ipi_mux_control in PATCH3
>  - Improved function signature of ipi_mux_send() callback in PATCH3
>  - Used unsigned type with atomic operation in PATCH3
>
> Changes since v10:
>  - Rebased on Linux-6.1-rc5
>  - Drop the "!(pending & ibit)" check in ipi_mux_send_mask() of PATCH3
>  - Disable local interrupts in ipi_mux_send_mask() of PATCH3 because we
>    can be preempted while using a per-CPU temporary variable.
>
> Changes since v9:
>  - Rebased on Linux-6.1-rc3
>  - Updated header comment block of ipi-mux.c in PATCH3
>  - Use a struct for global data of ipi-mux.c in PATCH3
>  - Add per-CPU temp cpumask for sending IPIs in PATCH3
>  - Drop the use of fwspec in PATCH3
>  - Use static key for ipi_mux_pre_handle() and ipi_mux_post_handle()
>    in PATCH3
>  - Remove redundant pr_warn_ratelimited() called by ipi_mux_process()
>    in PATCH3
>  - Remove CPUHP thingy from ipi_mux_create() in PATCH3
>
> Changes since v8:
>  - Rebased on Linux-6.0-rc3
>  - Use dummy percpu data as parameter for request_percpu_irq() in PATCH4.
>
> Changes since v7:
>  - Rebased on Linux-6.0-rc1
>  - Use atomic operations to track per-CPU pending and enabled IPIs in PAT=
CH3.
>    (Note: this is inspired from IPI muxing implemented in
>     drivers/irqchip/irq-apple-aic.c)
>  - Made "struct ipi_mux_ops" (added by PATCH3) flexible so that
>    drivers/irqchip/irq-apple-aic.c can adopt it in future.
>
> Changes since v6:
>  - Rebased on Linux-5.19-rc7
>  - Added documentation for struct ipi_mux_ops in PATCH3
>  - Dropped dummy irq_mask()/unmask() in PATCH3
>  - Added const for "ipi_mux_chip" in PATCH3
>  - Removed "type" initialization from ipi_mux_domain_alloc() in PATCH3
>  - Dropped translate() from "ipi_mux_domain_ops" in PATCH3
>  - Improved barrier documentation in ipi_mux_process() of PATCH3
>  - Added percpu check in ipi_mux_create() for parent_virq of PATCH3
>  - Added nr_ipi parameter in ipi_mux_create() of PATCH3
>
> Changes since v5:
>  - Rebased on Linux-5.18-rc3
>  - Used kernel doc style in PATCH3
>  - Removed redundant loop in ipi_mux_process() of PATCH3
>  - Removed "RISC-V" prefix form ipi_mux_chip.name of PATCH3
>  - Removed use of "this patch" in PATCH3 commit description
>  - Addressed few other nit comments in PATCH3
>
> Changes since v4:
>  - Rebased on Linux-5.17
>  - Includes new PATCH3 which adds mechanism to multiplex a single HW IPI
>
> Changes since v3:
>  - Rebased on Linux-5.17-rc6
>  - Updated PATCH2 to not export riscv_set_intc_hwnode_fn()
>  - Simplified riscv_intc_hwnode() in PATCH2
>
> Changes since v2:
>  - Rebased on Linux-5.17-rc4
>  - Updated PATCH2 to not create synthetic INTC fwnode and instead provide
>    a function which allows drivers to directly discover INTC fwnode
>
> Changes since v1:
>  - Use synthetic fwnode for INTC instead of irq_set_default_host() in PAT=
CH2
>
> Anup Patel (7):
>   RISC-V: Clear SIP bit only when using SBI IPI operations
>   irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
>   RISC-V: Treat IPIs as normal Linux IRQs
>   RISC-V: Allow marking IPIs as suitable for remote FENCEs
>   RISC-V: Use IPIs for remote TLB flush when possible
>   RISC-V: Use IPIs for remote icache flush when possible
>   irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers

There were merge conflicts with Linux-6.3-rc4 which are resolved
in this series.

It would be great if this series can be considered for Linux-6.4

Thanks,
Anup

>
>  arch/riscv/Kconfig                |   2 +
>  arch/riscv/include/asm/irq.h      |   4 +
>  arch/riscv/include/asm/sbi.h      |   9 +-
>  arch/riscv/include/asm/smp.h      |  49 ++++++---
>  arch/riscv/kernel/Makefile        |   1 +
>  arch/riscv/kernel/cpu-hotplug.c   |   3 +-
>  arch/riscv/kernel/irq.c           |  21 +++-
>  arch/riscv/kernel/sbi-ipi.c       |  77 ++++++++++++++
>  arch/riscv/kernel/sbi.c           | 100 +++--------------
>  arch/riscv/kernel/smp.c           | 171 +++++++++++++++---------------
>  arch/riscv/kernel/smpboot.c       |   5 +-
>  arch/riscv/mm/cacheflush.c        |   5 +-
>  arch/riscv/mm/tlbflush.c          |  93 +++++++++++++---
>  drivers/clocksource/timer-clint.c |  65 +++++++++---
>  drivers/irqchip/Kconfig           |   1 +
>  drivers/irqchip/irq-riscv-intc.c  |  71 ++++++++-----
>  16 files changed, 429 insertions(+), 248 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi-ipi.c
>
> --
> 2.34.1
>
