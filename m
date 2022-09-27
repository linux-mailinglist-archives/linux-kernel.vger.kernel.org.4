Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7145EC3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiI0NG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiI0NGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:06:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B418177349
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:06:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2E11042;
        Tue, 27 Sep 2022 06:06:57 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1E03F792;
        Tue, 27 Sep 2022 06:06:49 -0700 (PDT)
Message-ID: <80d6238b-223c-e60a-6930-24a981d9dd0c@arm.com>
Date:   Tue, 27 Sep 2022 14:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] x86/resctrl: Clear the staged configs when destroying
 schemata list
Content-Language: en-GB
To:     Shawn Wang <shawnwang@linux.alibaba.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 27/09/2022 03:54, Shawn Wang wrote:
> Array staged_config in struct rdt_domain still maintains the original value when
> resctrl is unmounted. If resctrl is mounted with cdp option and then remounted
> without cdp option, field have_new_ctrl in staged_config[CDP_CODE] and
> staged_config[CDP_DATA] will still be true.

staged_config[CDP_DATA] is an array - its always 'true'. I think you mean
staged_config[CDP_DATA].have_new_ctrl, which will still be true because it is only
memset() when the schemata file is written to.


> Since resctrl_arch_update_domains()
> traverses all resctrl_conf_type, it will continue to update CDP_CODE and
> CDP_DATA configurations, which can cause overflow problem.

Only if its called with a stale staged config, and it should only be called when the
schemata file is written to, which would memset() the staged config first.


> The problem can be reproduced by the following commands:
>     # A system with 16 usable closids and mba disabled
>     mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>     mkdir /sys/fs/resctrl/p{1..7}
>     umount /sys/fs/resctrl/
>     mount -t resctrl resctrl /sys/fs/resctrl
>     mkdir /sys/fs/resctrl/p{1..8}

Thanks for the reproducer - but I don't see what could set have_new_ctrl in this sequence.
You can't call apply_config() to set CPUs in the mask without that being set.

Creating a new control group, (your mkdir step) shouldn't touch the hardware at all, as it
should be left in its reset state from the last umount(), or setup.

I can't reproduce this on v6.0-rc7.
Even if I dirty the configuration by writing to the schemata file, I can't reproduce this.

(I have mba enabled, but all this should affect is the number of closid available)


> dmesg will generate the following error:

Which kernel version is this?

>     [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
>     0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)

Is 0x7ff the default CBM bitmap for this CPU? Or was it written in a step missing from the
reproducer above?


The rest of this splat isn't helpful as its the result of an IPI...

>     [ 6180.951983] Call Trace:
>     [ 6180.954516]  <IRQ>
>     [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
>     [ 6180.962028]  __sysvec_call_function+0x24/0xd0
>     [ 6180.966485]  sysvec_call_function+0x89/0xc0
>     [ 6180.970760]  </IRQ>
>     [ 6180.972947]  <TASK>
>     [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
>     [ 6180.979757] RIP: 0010:cpuidle_enter_state+0xcd/0x400
>     [ 6180.984821] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 1e e5 77 ff 45 84
>     ff 74 12 9c 58 f6 c4 02 0f 85 13 03 00 00 31 ff e8 67 70 7d ff fb 45 85
>     f6 <0f> 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
>     [ 6181.003710] RSP: 0018:ffffffff83a03e48 EFLAGS: 00000202
>     [ 6181.009028] RAX: ffff943400800000 RBX: 0000000000000001 RCX: 000000000000001f
>     [ 6181.016261] RDX: 0000000000000000 RSI: ffffffff83795059 RDI: ffffffff837c101e
>     [ 6181.023490] RBP: ffff9434c9352000 R08: 0000059f1cb1a05e R09: 0000000000000008
>     [ 6181.030717] R10: 0000000000000001 R11: 0000000000005c66 R12: ffffffff83bbf3a0
>     [ 6181.037944] R13: 0000059f1cb1a05e R14: 0000000000000001 R15: 0000000000000000
>     [ 6181.045202]  ? cpuidle_enter_state+0xb2/0x400
>     [ 6181.049678]  cpuidle_enter+0x24/0x40
>     [ 6181.053370]  do_idle+0x1dd/0x260
>     [ 6181.056713]  cpu_startup_entry+0x14/0x20
>     [ 6181.060753]  rest_init+0xbb/0xc0
>     [ 6181.064097]  arch_call_rest_init+0x5/0xa
>     [ 6181.068137]  start_kernel+0x668/0x691
>     [ 6181.071914]  secondary_startup_64_no_verify+0xe0/0xeb
>     [ 6181.077086]  </TASK>

It would be good to know what triggered this IPI. It may not have been
resctrl_arch_update_domains(). This pattern also happens from reset_all_ctrls() which
happens during umount(). (and that would write the default CBM bitmap)

If you can reproduce this easily, could you add dump_stack() to update_config() to see if
any path is setting have_new_ctrl. You aren't writing to the schemata file in your reproducer.


> We fix this issue by clearing the staged configs when destroying schemata list.


> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
> Suggested-by: Xin Hao <xhao@linux.alibaba.com>

If we can work out why you are seeing this, it would need a Fixes tag.

Otherwise I agree it makes sense to make this more robust, but it would need a different
commit message.


Thanks,

James



> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f276aff521e8..b4a817ae83ab 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2127,8 +2127,15 @@ static int schemata_list_create(void)
>  static void schemata_list_destroy(void)
>  {
>  	struct resctrl_schema *s, *tmp;
> +	struct rdt_domain *dom;
>  
>  	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
> +		/*
> +		 * Clear staged_config on each domain before schemata list is
> +		 * destroyed.
> +		 */
> +		list_for_each_entry(dom, &s->res->domains, list)
> +			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>  		list_del(&s->list);
>  		kfree(s);
>  	}

