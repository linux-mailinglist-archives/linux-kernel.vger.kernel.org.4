Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4236A18B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBXJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:26:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD765CF1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:26:16 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PNPXJ608WzKmLv;
        Fri, 24 Feb 2023 17:21:20 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Feb
 2023 17:26:14 +0800
Message-ID: <4c1084b6-2295-df22-9370-31e24d6df97e@huawei.com>
Date:   Fri, 24 Feb 2023 17:26:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>
References: <20230224084945.134038-1-chenzhongjin@huawei.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20230224084945.134038-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_maintainer.pl gets a wrong spelled mail address 
'akpm@linux-foudation.org'.

Seems it's because Andrew left a wrong Reviewed-by in the last commit.. 
so -cc alone for Andrew.

Sorry for bothering.


On 2023/2/24 16:49, Chen Zhongjin wrote:
> KASAN reported a UAF problem in profile_tick():
>
>    BUG: KASAN: use-after-free in profile_tick+0x5c/0x80
>    Read of size 8 at addr ffff888100928aa0 by task bash/1108
>
>    CPU: 2 PID: 1108 Comm: bash Not tainted 5.10.0+ #72
>    Call Trace:
>     <IRQ>
>     dump_stack+0x93/0xc5
>     print_address_description.constprop.0+0x1c/0x3c0
>     kasan_report.cold+0x37/0x74
>     check_memory_region+0x161/0x1c0
>     profile_tick+0x5c/0x80
>     tick_sched_timer+0xcd/0x100
>     __hrtimer_run_queues+0x23e/0x480
>     hrtimer_interrupt+0x1c2/0x440
>     asm_call_irq_on_stack+0xf/0x20
>     </IRQ>
>    ...
>
> It is beacause in profiling_store(), profile_init() is possible to fail
> and free prof_cpu_mask. However prof_cpu_mask is not set to NULL and
> cpumask_available(prof_cpu_mask) will return true in profile_tick().
> Then cpumask_test_cpu() will dereference prof_cpu_mask and trigger the
> KASAN warning.
>
> There is no interface to disable profile_tick() even though profile_init()
> has been already failed. So just set prof_cpu_mask to NULL when free it.
> Then accessing to prof_cpu_mask can be rejected by prof_buffer or
> cpumask_available().
>
> Fixes: c309b917cab5 ("cpumask: convert kernel/profile.c")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   kernel/profile.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/profile.c b/kernel/profile.c
> index 8a77769bc4b4..d60f9634fb2a 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -133,6 +133,7 @@ int __ref profile_init(void)
>   		return 0;
>   
>   	free_cpumask_var(prof_cpu_mask);
> +	prof_cpu_mask = NULL;
>   	return -ENOMEM;
>   }
>   
> @@ -334,7 +335,7 @@ void profile_tick(int type)
>   {
>   	struct pt_regs *regs = get_irq_regs();
>   
> -	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
> +	if (!user_mode(regs) && prof_buffer && cpumask_available(prof_cpu_mask) &&
>   	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
>   		profile_hit(type, (void *)profile_pc(regs));
>   }
