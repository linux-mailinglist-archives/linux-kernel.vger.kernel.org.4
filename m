Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C36CB923
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjC1IPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1IPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:15:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70DA2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:15:19 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pm2TZ3syQzgZhV;
        Tue, 28 Mar 2023 16:12:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 16:15:17 +0800
CC:     <yangyicong@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <palmer@rivosinc.com>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cacheinfo: Fix LLC is not exported through sysfs
To:     Sudeep Holla <sudeep.holla@arm.com>
References: <20230323122528.16691-1-yangyicong@huawei.com>
 <7cca5e74-6626-1c8b-9309-47b9f5d4395f@arm.com>
 <20230324113508.x2rt52aakruwelk3@bogus>
 <dd475eb6-7a0b-fbb4-316b-1af94c238699@huawei.com>
 <20230327111527.h46wdd3jva4npksy@bogus>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6fc284e0-70bb-9bcf-a35c-2701018c85e2@huawei.com>
Date:   Tue, 28 Mar 2023 16:15:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230327111527.h46wdd3jva4npksy@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/27 19:15, Sudeep Holla wrote:
> On Mon, Mar 27, 2023 at 02:57:07PM +0800, Yicong Yang wrote:
>> Hi Pierre and Sudeep,
>>
>> On 2023/3/24 19:35, Sudeep Holla wrote:
>>> On Thu, Mar 23, 2023 at 06:58:53PM +0100, Pierre Gondois wrote:
>>>> Hello Yicong,
>>>>
>>>> FWIW, I think the patch is correct and I could reproduce the issue.
>>>>
>>>> On 3/23/23 13:25, Yicong Yang wrote:
>>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>>
>>>>> After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI
>>>>> based arm64 server. This is because the LLC cacheinfo is partly reset
>>>>> when secondary CPUs boot up. On arm64 the primary cpu will allocate
>>>>> and setup cacheinfo:
>>>>> init_cpu_topology()
>>>>>    for_each_possible_cpu()
>>>>>      fetch_cache_info() // Allocate cacheinfo and init levels
>>>>> detect_cache_attributes()
>>>>>    cache_shared_cpu_map_setup()
>>>>>      if (!last_level_cache_is_valid()) // not valid, setup LLC
>>>>>        cache_setup_properties() // setup LLC
>>>>>
>>>>> On secondary CPU boot up:
>>>>> detect_cache_attributes()
>>>>>    populate_cache_leaves()
>>>>>      get_cache_type() // Get cache type from clidr_el1,
>>>>>                       // for LLC type=CACHE_TYPE_NOCACHE
>>>>>    cache_shared_cpu_map_setup()
>>>>>      if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
>>>>>                                        // leave LLC's type=CACHE_TYPE_NOCACHE
>>>>>
>>>>> The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
>>>>> test it's valid or not, but populate_cache_leaves() will only reset
>>>>> LLC's type, so we won't try to re-setup LLC's type and leave it
>>>>> CACHE_TYPE_NOCACHE and won't export it through sysfs.
>>>>>
>>>
>>> IIUC this is for the case where arch register doesn't report the system level
>>> cache. I wonder if it makes sense to fix the arch callback to deal with that
>>> instead of here. I am fine either way, just checking as ideally it is
>>> something populate_cache_leaves() is messing up.
>>>
>>
>> yes it's right, the LLC information is not provided by the CPU register and can
>> only be retrieved from PPTT on my machine. Maybe fix the issue first, I don't
>> know how to make arch callback handle this since arch_topology is also used
>> other than arm64 which I'm not familiar with.
>>
> 
> I was thinking of something like below.
> 
> --
> Regards,
> Sudeep
> 
> diff --git i/arch/arm64/kernel/cacheinfo.c w/arch/arm64/kernel/cacheinfo.c
> index c307f69e9b55..4ef1033fe47e 100644
> --- i/arch/arm64/kernel/cacheinfo.c
> +++ w/arch/arm64/kernel/cacheinfo.c
> @@ -79,12 +79,16 @@ int init_cache_level(unsigned int cpu)
> 
>  int populate_cache_leaves(unsigned int cpu)
>  {
> -       unsigned int level, idx;
> +       unsigned int hw_lvl, level, idx;
>         enum cache_type type;
>         struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>         struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> 
> -       for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
> +       for (hw_lvl = 0; hw_lvl <= MAX_CACHE_LEVEL; hw_lvl++)
> +               if (CACHE_TYPE_NOCACHE == get_cache_type(hw_lvl + 1))
> +                       break;
> +

We totally skip the system level caches and leaving their ->level initialized
as 0, then we still cannot get the correct infomation by the PPTT side since
it uses the ->level to find the cache info:
drivers/acpi/pptt.c:
cache_setup_acpi_cpu()
		[...]
		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
						   this_leaf->type,
						   this_leaf->level, <---- we cannot find it with level 0
						   &cpu_node);

So I'd prefer the original fixes of mine or by the arch side (if no other
archs suffer this issue) what about below for arm64 only:

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index c307f69e9b55..4801d0ff4ffb 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -86,6 +86,13 @@ int populate_cache_leaves(unsigned int cpu)

        for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
             idx < this_cpu_ci->num_leaves; idx++, level++) {
+               /*
+                * This leaf has already been populated, do not reset it since
+                * this could be a system level cache.
+                */
+               if (this_leaf->type != CACHE_TYPE_NOCACHE)
+                       continue;
+
                type = get_cache_type(level);
                if (type == CACHE_TYPE_SEPARATE) {
                        ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);

> +       for (idx = 0, level = 1; level <= hw_lvl &&
>              idx < this_cpu_ci->num_leaves; idx++, level++) {
>                 type = get_cache_type(level);
>                 if (type == CACHE_TYPE_SEPARATE) {
> 
> .
> 
