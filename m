Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046786B0966
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCHNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCHNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:37:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FB5DB2576;
        Wed,  8 Mar 2023 05:35:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D0B106F;
        Wed,  8 Mar 2023 05:35:36 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474A53F67D;
        Wed,  8 Mar 2023 05:34:50 -0800 (PST)
Message-ID: <d9e5fdc4-3db0-4aa7-147c-c3c6bfbeac84@arm.com>
Date:   Wed, 8 Mar 2023 14:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ACPI: PPTT: Fix to avoid sleep in the atomic context when
 PPTT is absent
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Aishwarya TCV <aishwarya.tcv@arm.com>
References: <20230308112632.1908748-1-sudeep.holla@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230308112632.1908748-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Pierre Gondois <pierre.gondois@arm.com>

On 3/8/23 12:26, Sudeep Holla wrote:
> Commit 0c80f9e165f8 ("ACPI: PPTT: Leave the table mapped for the runtime usage")
> enabled to map PPTT once on the first invocation of acpi_get_pptt() and
> never unmapped the same allowing it to be used at runtime with out the
> hassle of mapping and unmapping the table. This was needed to fetch LLC
> information from the PPTT in the cpuhotplug path which is executed in
> the atomic context as the acpi_get_table() might sleep waiting for a
> mutex.
> 
> However it missed to handle the case when there is no PPTT on the system
> which results in acpi_get_pptt() being called from all the secondary
> CPUs attempting to fetch the LLC information in the atomic context
> without knowing the absence of PPTT resulting in the splat like below:
> 
>   | BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:164
>   | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
>   | preempt_count: 1, expected: 0
>   | RCU nest depth: 0, expected: 0
>   | no locks held by swapper/1/0.
>   | irq event stamp: 0
>   | hardirqs last  enabled at (0): 0x0
>   | hardirqs last disabled at (0): copy_process+0x61c/0x1b40
>   | softirqs last  enabled at (0): copy_process+0x61c/0x1b40
>   | softirqs last disabled at (0): 0x0
>   | CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-rc1 #1
>   | Call trace:
>   |  dump_backtrace+0xac/0x138
>   |  show_stack+0x30/0x48
>   |  dump_stack_lvl+0x60/0xb0
>   |  dump_stack+0x18/0x28
>   |  __might_resched+0x160/0x270
>   |  __might_sleep+0x58/0xb0
>   |  down_timeout+0x34/0x98
>   |  acpi_os_wait_semaphore+0x7c/0xc0
>   |  acpi_ut_acquire_mutex+0x58/0x108
>   |  acpi_get_table+0x40/0xe8
>   |  acpi_get_pptt+0x48/0xa0
>   |  acpi_get_cache_info+0x38/0x140
>   |  init_cache_level+0xf4/0x118
>   |  detect_cache_attributes+0x2e4/0x640
>   |  update_siblings_masks+0x3c/0x330
>   |  store_cpu_topology+0x88/0xf0
>   |  secondary_start_kernel+0xd0/0x168
>   |  __secondary_switched+0xb8/0xc0
> 
> Update acpi_get_pptt() to consider the fact that PPTT is once checked and
> is not available on the system and return NULL avoiding any attempts to
> fetch PPTT and thereby avoiding any possible sleep waiting for a mutex
> in the atomic context.
> 
> Fixes: 0c80f9e165f8 ("ACPI: PPTT: Leave the table mapped for the runtime usage")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/acpi/pptt.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 10975bb603fb..a35dd0e41c27 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -536,16 +536,19 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   static struct acpi_table_header *acpi_get_pptt(void)
>   {
>   	static struct acpi_table_header *pptt;
> +	static bool is_pptt_checked;
>   	acpi_status status;
>   
>   	/*
>   	 * PPTT will be used at runtime on every CPU hotplug in path, so we
>   	 * don't need to call acpi_put_table() to release the table mapping.
>   	 */
> -	if (!pptt) {
> +	if (!pptt && !is_pptt_checked) {
>   		status = acpi_get_table(ACPI_SIG_PPTT, 0, &pptt);
>   		if (ACPI_FAILURE(status))
>   			acpi_pptt_warn_missing();
> +
> +		is_pptt_checked = true;
>   	}
>   
>   	return pptt;
