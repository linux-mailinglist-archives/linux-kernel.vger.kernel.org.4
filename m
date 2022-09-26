Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062BE5E9FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiIZK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiIZK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:26:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB05E11A26
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664187514; x=1695723514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w5JjJDXrkyUyXqGn1bmKBkBsCl7GSmQYPD4A5lM+cSo=;
  b=FMDkPHBxk6G3puTNj0PykswBHDV5MGgdqlGfrCqrGpsR96BGC+25I6oE
   fkN2QPrim1AzJBinPznJVE1uRDYAg2jq2C5OhrmmfuiqZE5UUA+KWb3tq
   VIU0be/HK3g4tZPNE57sK3VL2xkz8bbuP440iZ3IX+WIp8tgbCXqp6kMO
   Zxegc5hgHQBdiCB1p8hd0HQSU4BS16gKVvL+HqKBdy0L/g7yhJLuLXrzp
   TkYbDkBXGEex88piTSwtZLWqnIkSe9nZoE6+EKqyvheFsA2bb7OgUTfNG
   MnpFB3EXFHe0twLktwu5QIkf4eYT41QS2oTrcg18AAmABnimOm5Gad4QH
   g==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="178886226"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2022 03:17:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 26 Sep 2022 03:17:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 26 Sep 2022 03:17:43 -0700
Date:   Mon, 26 Sep 2022 11:17:22 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Binglei Wang <l3b2w1@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <mhiramat@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] rethook: add riscv rethook implementation.
Message-ID: <YzF8MqouI96oBtJJ@wendy>
References: <20220926084136.629638-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220926084136.629638-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:41:36PM +0800, Binglei Wang wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes on riscv arch by using rethook mechanism
> which abstracts general kretprobe info into a struct rethook_node
> to be embedded in the struct kretprobe_instance.
> 
> 1. remove arch dependent kretprobe implementation
> 2. replace __kretprobe_trampoline with arch_hook_trampoline
> 
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> ---

What changed since v5? You need to put a changelog under the --- for
what changed in each revision.
Thanks,
Conor.

>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/kernel/probes/Makefile             |  2 +-
>  arch/riscv/kernel/probes/kprobes.c            | 13 ----------
>  arch/riscv/kernel/probes/rethook.c            | 26 +++++++++++++++++++
>  arch/riscv/kernel/probes/rethook.h            |  8 ++++++
>  ...obes_trampoline.S => rethook_trampoline.S} |  0
>  6 files changed, 36 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/kernel/probes/rethook.c
>  create mode 100644 arch/riscv/kernel/probes/rethook.h
>  rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (100%)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4..c5cae0825 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -97,6 +97,7 @@ config RISCV
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
> +	select HAVE_RETHOOK if !XIP_KERNEL
>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
>  	select HAVE_PCI
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index 7f0840dcc..9a96a7038 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
> -obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
> +obj-$(CONFIG_KPROBES)		+= rethook.o rethook_trampoline.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7c..f21592d20 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
>  	return ret;
>  }
>  
> -void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> -{
> -	return (void *)kretprobe_trampoline_handler(regs, NULL);
> -}
> -
> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -				      struct pt_regs *regs)
> -{
> -	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
> -	ri->fp = NULL;
> -	regs->ra = (unsigned long) &__kretprobe_trampoline;
> -}
> -
>  int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	return 0;
> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
> new file mode 100644
> index 000000000..edfeaa256
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic return hook for riscv.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +#include "rethook.h"
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> +{
> +	return rethook_trampoline_handler(regs, regs->s0);
> +}
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> +{
> +	rhn->ret_addr = regs->ra;
> +	rhn->frame = regs->s0;
> +
> +	/* replace return addr with trampoline */
> +	regs->ra = (u64)arch_rethook_trampoline;
> +}
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
> new file mode 100644
> index 000000000..cc573d701
> --- /dev/null
> +++ b/arch/riscv/kernel/probes/rethook.h
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#ifndef __RISCV_RETHOOK_H
> +#define __RISCV_RETHOOK_H
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
> +
> +#endif
> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> similarity index 100%
> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
> rename to arch/riscv/kernel/probes/rethook_trampoline.S
> -- 
> 2.27.0
> 
