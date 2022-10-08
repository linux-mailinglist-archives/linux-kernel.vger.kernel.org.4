Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040B5F8496
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJHJ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJHJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:27:26 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EDC52E4D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665221240; bh=4RXWvHOEFN+CAwbA4Tw1ZvFjHe9LQrVJ2duQJHKG17k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q3mjswVrpBCbTNjcTk3Yd3hwbrYITzgEg53yTepRDEBTKw4FRC/Z9auWZC0lkwlAN
         2mU0wwLGUHrU6cRBBKXT9vOAynSizu62c9XRn0R3SHhngWk6B29Yh7Q7YXtdLQOOW5
         mPlghUjUCe6Rei+jwxYxD4HmC+Pij0gJbj+9/03E=
Received: from [100.100.35.204] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9BA07600CE;
        Sat,  8 Oct 2022 17:27:20 +0800 (CST)
Message-ID: <922e6d73-78e5-8852-788b-017d0dbe4df5@xen0n.name>
Date:   Sat, 8 Oct 2022 17:27:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH] LoongArch: Do not create sysfs control file for io master
 CPUs
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1665219579-2501-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <1665219579-2501-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/8 16:59, Tiezhu Yang wrote:
> Now io master CPUs are not hotpluggable on LoongArch, in the current code,
> only /sys/devices/system/cpu/cpu0/online is not created, let us set the
> hotpluggable field of all the io master CPUs as 0, then prevent to create
> sysfs control file for the other io master CPUs which confuses some user
> space tools. This is similar with commit 9cce844abf07 ("MIPS: CPU#0 is not
> hotpluggable").
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/kernel/smp.c      |  8 --------
>   arch/loongarch/kernel/topology.c | 12 +++++++++++-
>   2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index b5fab30..ef89292 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -240,19 +240,11 @@ void loongson3_smp_finish(void)
>   
>   #ifdef CONFIG_HOTPLUG_CPU
>   
> -static bool io_master(int cpu)
> -{
> -	return test_bit(cpu, &loongson_sysconf.cores_io_master);
> -}
> -
>   int loongson3_cpu_disable(void)
>   {
>   	unsigned long flags;
>   	unsigned int cpu = smp_processor_id();
>   
> -	if (io_master(cpu))
> -		return -EBUSY;
> -

Could this get invoked from somewhere other than the sysfs entries that 
"confuse user-space tools", e.g. from somewhere else in kernel land? If 
so (or if we can't rule out the possibility) keeping the guard here 
might prove more prudent.

>   #ifdef CONFIG_NUMA
>   	numa_remove_cpu(cpu);
>   #endif
> diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
> index ab1a75c..7e7a77f 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -5,6 +5,7 @@
>   #include <linux/node.h>
>   #include <linux/nodemask.h>
>   #include <linux/percpu.h>
> +#include <asm/bootinfo.h>
>   
>   static DEFINE_PER_CPU(struct cpu, cpu_devices);
>   
> @@ -33,6 +34,11 @@ void arch_unregister_cpu(int cpu)
>   EXPORT_SYMBOL(arch_unregister_cpu);
>   #endif
>   
> +static bool io_master(int cpu)
> +{
> +	return test_bit(cpu, &loongson_sysconf.cores_io_master);
> +}
> +
>   static int __init topology_init(void)
>   {
>   	int i, ret;
> @@ -40,7 +46,11 @@ static int __init topology_init(void)
>   	for_each_present_cpu(i) {
>   		struct cpu *c = &per_cpu(cpu_devices, i);
>   
> -		c->hotpluggable = !!i;
> +		if (io_master(i))
> +			c->hotpluggable = 0;
> +		else
> +			c->hotpluggable = 1;
> +

This is just "c->hotpluggable = !io_master(i);".

>   		ret = register_cpu(c, i);
>   		if (ret < 0)
>   			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
Other changes should be okay as they are in line with the previous MIPS 
change you referenced, but let's see what Huacai thinks.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

