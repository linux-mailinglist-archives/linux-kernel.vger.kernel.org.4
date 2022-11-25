Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD24638B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKYNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKYNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:41:18 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FF10B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:41:15 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 2E15860016;
        Fri, 25 Nov 2022 13:41:11 +0000 (UTC)
Message-ID: <6fee29f8-8150-e6ec-e2ec-210610a7e27d@ghiti.fr>
Date:   Fri, 25 Nov 2022 14:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: increase boot command line size to 1K
Content-Language: en-US
To:     Andrea Righi <andrea.righi@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125133713.314796-1-andrea.righi@canonical.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20221125133713.314796-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On 11/25/22 14:37, Andrea Righi wrote:
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
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>   arch/riscv/include/asm/setup.h      | 7 +++++++
>   arch/riscv/include/uapi/asm/setup.h | 7 +++++++
>   2 files changed, 14 insertions(+)
>   create mode 100644 arch/riscv/include/asm/setup.h
>   create mode 100644 arch/riscv/include/uapi/asm/setup.h
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


Just for reference to previous discussions regarding this: 
https://lore.kernel.org/lkml/CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com/T/

Thanks,

Alex

