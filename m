Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348B6D15F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjCaDZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCaDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:25:35 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714FD3A91
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1680233130; bh=882S7QFXm5n//3nqg1xYTL7PCI7LqWbNY4wq4uGr7zQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WNZASJgpIHXh9KJlbjD56lxOmxbZB+osCc6R7kMJHZYmvRy2Zm8SpMIxRbNC/39Vb
         8rTs98eR2BeIqLbs5BSGsDF19vOfL9GVOkdbZO1PPeRnsegeyD9UbTgaDSpmOpSpSx
         B7PAnZZg9qD9ySM3brfMZUiA3hMSMfShWuCJF3yw=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3C0A560148;
        Fri, 31 Mar 2023 11:25:30 +0800 (CST)
Message-ID: <0942af8b-64f5-2ed5-d8dc-a56a0761741e@xen0n.name>
Date:   Fri, 31 Mar 2023 11:25:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] LoongArch: Fix build error if CONFIG_SUSPEND is not set
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Randy Dunlap <rdunlap@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20230331025322.442337-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230331025322.442337-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 10:53, Huacai Chen wrote:
> We can see the following build error on LoongArch if CONFIG_SUSPEND is
> not set:
> 
>    ld: drivers/acpi/sleep.o: in function 'acpi_pm_prepare':
>    sleep.c:(.text+0x2b8): undefined reference to 'loongarch_wakeup_start'
> 
> Here is the call trace:
> 
>    acpi_pm_prepare()
>      __acpi_pm_prepare()
>        acpi_sleep_prepare()
>          acpi_get_wakeup_address()
>            loongarch_wakeup_start()
> 
> Root cause: loongarch_wakeup_start() is defined in arch/loongarch/power/
> suspend_asm.S which is only built under CONFIG_SUSPEND. In order to fix
> the build error, just let acpi_get_wakeup_address() return 0 if CONFIG_
> SUSPEND is not set.
> 
> Fixes: 366bb35a8e48 ("LoongArch: Add suspend (ACPI S3) support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/11215033-fa3c-ecb1-2fc0-e9aeba47be9b@infradead.org/
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/acpi.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> index 4198753aa1d0..976a810352c6 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -41,8 +41,11 @@ extern void loongarch_suspend_enter(void);
>   
>   static inline unsigned long acpi_get_wakeup_address(void)
>   {
> +#ifdef CONFIG_SUSPEND
>   	extern void loongarch_wakeup_start(void);
>   	return (unsigned long)loongarch_wakeup_start;
> +#endif
> +	return 0UL;
>   }
>   
>   #endif /* _ASM_LOONGARCH_ACPI_H */

Reviewed-by: WANG Xuerui <git@xen0n.name>

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

