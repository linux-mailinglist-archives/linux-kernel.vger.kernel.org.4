Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194F625DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiKKPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiKKPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:08:03 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BE3866CA6;
        Fri, 11 Nov 2022 07:06:50 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1otVcD-00037d-01; Fri, 11 Nov 2022 16:06:45 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 88D11C11F2; Fri, 11 Nov 2022 16:03:51 +0100 (CET)
Date:   Fri, 11 Nov 2022 16:03:51 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        tangyouling@loongson.cn, hejinyang@loongson.cn,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson64: Add WARN_ON on kexec related kmalloc
 failed
Message-ID: <20221111150351.GB13465@alpha.franken.de>
References: <20221103011815.139424-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103011815.139424-1-liaochang1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:18:15AM +0800, Liao Chang wrote:
> Add WARN_ON on kexec related kmalloc failed, avoid to pass NULL pointer
> to following memcpy and loongson_kexec_prepare.
> 
> Fixes: 6ce48897ce47 ("MIPS: Loongson64: Add kexec/kdump support")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/mips/loongson64/reset.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/mips/loongson64/reset.c b/arch/mips/loongson64/reset.c
> index 758d5d26aaaa..e420800043b0 100644
> --- a/arch/mips/loongson64/reset.c
> +++ b/arch/mips/loongson64/reset.c
> @@ -16,6 +16,7 @@
>  #include <asm/bootinfo.h>
>  #include <asm/idle.h>
>  #include <asm/reboot.h>
> +#include <asm/bug.h>
>  
>  #include <loongson.h>
>  #include <boot_param.h>
> @@ -159,8 +160,17 @@ static int __init mips_reboot_setup(void)
>  
>  #ifdef CONFIG_KEXEC
>  	kexec_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
> +	if (WARN_ON(!kexec_argv))
> +		return -ENOMEM;
> +
>  	kdump_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
> +	if (WARN_ON(!kdump_argv))
> +		return -ENOMEM;
> +
>  	kexec_envp = kmalloc(KEXEC_ENVP_SIZE, GFP_KERNEL);
> +	if (WARN_ON(!kexec_envp))
> +		return -ENOMEM;
> +
>  	fw_arg1 = KEXEC_ARGV_ADDR;
>  	memcpy(kexec_envp, (void *)fw_arg2, KEXEC_ENVP_SIZE);
>  
> -- 
> 2.17.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
