Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726BA5ED6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiI1IAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiI1H75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:59:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8663F1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:59:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McpkQ4YbQzHptq;
        Wed, 28 Sep 2022 15:57:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:59:51 +0800
Subject: Re: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
To:     Thomas Tai <thomas.tai@oracle.com>
References: <20220927183411.910077-1-thomas.tai@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
CC:     <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <reinette.chatre@intel.co>,
        <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Message-ID: <ab8fd1b3-5c36-ed7b-b385-375fcfa2ea9b@huawei.com>
Date:   Wed, 28 Sep 2022 15:59:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220927183411.910077-1-thomas.tai@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/28 2:34, Thomas Tai wrote:
> Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> address validation), add a similar code in hwpoison_inject function to
> check if the address is located in SGX Memory. The error will then be
> handled by the arch_memory_failure function in the SGX driver.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>  Documentation/mm/hwpoison.rst | 44 +++++++++++++++++++++++++++++++++++
>  mm/hwpoison-inject.c          |  3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
> index b9d5253c1305..8a542aca4744 100644
> --- a/Documentation/mm/hwpoison.rst
> +++ b/Documentation/mm/hwpoison.rst
> @@ -162,6 +162,50 @@ Testing
>  
>    Some portable hwpoison test programs in mce-test, see below.
>  
> +* Special notes for injection into SGX enclaves
> +
> +  1) Determine physical address of enclave page
> +
> +	dmesg | grep "sgx: EPC"
> +
> +	sgx: EPC section 0x8000c00000-0x807f7fffff
> +	sgx: EPC section 0x10000c00000-0x1007fffffff
> +
> +  2) Convert the EPC address to page frame number.
> +
> +	For 4K page size, the page frame number for 0x8000c00000 is
> +	0x8000c00000 / 0x1000 = 0x8000c00.
> +
> +  3) Trace memory_failure
> +
> +	echo nop > /sys/kernel/tracing/current_tracer
> +	echo *memory_failure > /sys/kernel/tracing/set_ftrace_filter
> +	echo function > /sys/kernel/tracing/current_tracer
> +
> +  4) Inject a memory error
> +
> +	modprobe hwpoison-inject
> +	echo "0x8000c00" > /sys/kernel/debug/hwpoison/corrupt-pfn
> +
> +  5) Check the trace output
> +
> +	cat /sys/kernel/tracing/trace
> +
> +	# tracer: function
> +	#
> +	# entries-in-buffer/entries-written: 2/2   #P:128
> +	#
> +	#                            _-----=> irqs-off
> +	#                           / _----=> need-resched
> +	#                          | / _---=> hardirq/softirq
> +	#                          || / _--=> preempt-depth
> +	#                          ||| / _-=> migrate-disable
> +	#                          |||| /     delay
> +	#       TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +	#          | |         |   |||||     |         |
> +	        bash-12167   [002] .....   113.136808: memory_failure<-simple_attr_write
> +	        bash-12167   [002] .....   113.136810: arch_memory_failure<-memory_failure
> +
>  References
>  ==========
>  
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 65e242b5a432..8134dc983699 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -21,6 +21,9 @@ static int hwpoison_inject(void *data, u64 val)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (arch_is_platform_page(pfn << PAGE_SHIFT))

Maybe it's better to add a comment above. Anyway, this patch looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>


Thanks,
Miaohe Lin

