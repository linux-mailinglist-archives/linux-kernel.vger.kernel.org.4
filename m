Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03EB6397AB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKZSqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKZSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AAB1C906
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A5FEB80958
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 18:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521ACC433D6;
        Sat, 26 Nov 2022 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669488369;
        bh=uWdFFAXg78nudNnPJUDiXEmEVy6V5aBDdLZwo3yon44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6dR+XFLq9Qto5l1h0WDJat2H97M7zodpyqFs4JjoT8cwVtyWSkP7RH7FruhnaYWl
         MfmF/x46qUZxhUMBdK7p3v8QZi2SqjfQ9FFqiCnvz3nSJP7Xzl0ztMy3ok/rc7T1B7
         E7aDsFzzIrJTXYRWjhazFczbAWBSV51qS1Ct2hQxdMZ9AFiFpNTOX9YnHD8TjNzgPb
         Tm2Smbj+mseRAkPCSzZv2/4zY1mFk6lZQRaw+sHCYCflcAQdHEqJvSZJIV+of1yzRy
         eKLOioMDdMnu02v2h/T9Hpnrib5FyUVvi+d+S132qheihkutra5XN7v2NjSp8sGTEt
         JlOeutqwQReMQ==
Date:   Sat, 26 Nov 2022 18:46:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: increase boot command line size to 1K
Message-ID: <Y4Je7chN+fQM3NpP@spud>
References: <20221125133713.314796-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125133713.314796-1-andrea.righi@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrea,

On Fri, Nov 25, 2022 at 02:37:13PM +0100, Andrea Righi wrote:
> Kernel parameters string is limited to 512 characters on riscv (using
> the default from include/uapi/asm-generic/setup.h).
> 
> In some testing environments (e.g., qemu with long kernel parameters
> string) we may exceed this limit, triggering errors like the following:
> 
> [    3.331893] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> [    3.332625] CPU: 2 PID: 1 Comm: sh Not tainted 6.1.0-rc6-kc #1
> [    3.333233] Hardware name: riscv-virtio,qemu (DT)
> [    3.333550] Call Trace:
> [    3.333736] [<ffffffff800062b6>] dump_backtrace+0x1c/0x24
> [    3.334053] [<ffffffff806e8f54>] show_stack+0x2c/0x38
> [    3.334260] [<ffffffff806f2d06>] dump_stack_lvl+0x5a/0x7c
> [    3.334483] [<ffffffff806f2d3c>] dump_stack+0x14/0x1c
> [    3.334687] [<ffffffff806e92fa>] panic+0x116/0x2d0
> [    3.334878] [<ffffffff8001b0aa>] do_exit+0x80a/0x810
> [    3.335079] [<ffffffff8001b1d0>] do_group_exit+0x24/0x70
> [    3.335287] [<ffffffff8001b234>] __wake_up_parent+0x0/0x20
> [    3.335502] [<ffffffff80003cee>] ret_from_syscall+0x0/0x2
> [    3.335857] SMP: stopping secondary CPUs
> [    3.337561] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---
> 
> It seems reasonable enough to increase the default command line size to
> 1024, like arm, to prevent issues like the one reported above.

error: arch/riscv/include/uapi/asm/setup.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier

Unfortunately this does not build :/

Thanks,
Conor.

> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  arch/riscv/include/asm/setup.h      | 7 +++++++
>  arch/riscv/include/uapi/asm/setup.h | 7 +++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 arch/riscv/include/asm/setup.h
>  create mode 100644 arch/riscv/include/uapi/asm/setup.h
> 
> diff --git a/arch/riscv/include/asm/setup.h b/arch/riscv/include/asm/setup.h
> new file mode 100644
> index 000000000000..f4fe549aab40
> --- /dev/null
> +++ b/arch/riscv/include/asm/setup.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASMRISCV_SETUP_H
> +#define __ASMRISCV_SETUP_H
> +
> +#include <uapi/asm/setup.h>
> +
> +#endif /* __ASMRISCV_SETUP_H */
> diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..5738f93ae437
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/setup.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _UAPI__ASMRISCV_SETUP_H
> +#define _UAPI__ASMRISCV_SETUP_H
> +
> +#define COMMAND_LINE_SIZE 1024
> +
> +#endif /* _UAPI__ASMRISCV_SETUP_H */
> -- 
> 2.37.2
> 
