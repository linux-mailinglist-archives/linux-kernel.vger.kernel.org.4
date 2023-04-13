Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CCF6E1102
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:25:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3EAD2735
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:25:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 182A6D75;
        Thu, 13 Apr 2023 08:26:19 -0700 (PDT)
Received: from [10.34.100.129] (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07A533F73F;
        Thu, 13 Apr 2023 08:25:32 -0700 (PDT)
Message-ID: <78419d88-1114-e58e-aeec-6a991a8fdb37@arm.com>
Date:   Thu, 13 Apr 2023 17:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/4] arch_topology: Remove early cacheinfo error
 message
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>, Conor Dooley <conor@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-4-pierre.gondois@arm.com>
 <20230413-prudishly-unruly-090f5297fd54@wendy>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230413-prudishly-unruly-090f5297fd54@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/23 12:02, Conor Dooley wrote:
> On Thu, Apr 13, 2023 at 11:14:33AM +0200, Pierre Gondois wrote:
>> fetch_cache_info() tries to get the number of cache leaves/levels
>> for each CPU in order to pre-allocate memory for cacheinfo struct.
>> Allocating this memory later triggers a:
>>    'BUG: sleeping function called from invalid context'
>> in PREEMPT_RT kernels.
>>
>> If there is no cache related information available in DT or ACPI,
>> fetch_cache_info() fails and an error message is printed:
>>    'Early cacheinfo failed, ret = ...'
>>
>> Not having cache information should be a valid configuration.
>> Remove the error message if fetch_cache_info() fails.
>>
>> Suggested-by: Conor Dooley <conor@kernel.org>
> 
> Not that it really matters for suggested-by, and there's no way really
> for you to know, but the corporate overlords prefer:
> s/conor@kernel.org/conor.dooley@microchip.com/
> 
>> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/base/arch_topology.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index b1c1dd38ab01..1f071eaede5b 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -843,10 +843,8 @@ void __init init_cpu_topology(void)
>>   
>>   	for_each_possible_cpu(cpu) {
>>   		ret = fetch_cache_info(cpu);
>> -		if (ret) {
>> -			pr_err("Early cacheinfo failed, ret = %d\n", ret);
> 
> Hmm do you really want to remove the print altogether? This can fail
> with -EINVAL and -ENOMEM too, so should we just check for
> | if (ret && ret != -ENOENT)
> instead, since in the other cases it really did fail?

I think [PATCH 2/4] requires the following update in this case:

--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -288,8 +288,10 @@ int init_of_cache_level(unsigned int cpu)
         struct device_node *prev = NULL;
         unsigned int levels = 0, leaves, level;
  
-       if (!of_check_cache_nodes(np))
-               goto err_out;
+       if (!of_check_cache_nodes(np)) {
+               of_node_put(np);
+               return -ENOENT;
+       }
  
         leaves = of_count_cache_leaves(np);
         if (leaves > 0)

Is it ok to do this and keep your Reviewed-by ?

Thanks for the review,
Regards,
Pierre
