Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43A5B76C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIMQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIMQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:51:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76E9459AF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:45:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A731063;
        Tue, 13 Sep 2022 07:15:35 -0700 (PDT)
Received: from [10.57.15.170] (unknown [10.57.15.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920CB3F73B;
        Tue, 13 Sep 2022 07:15:27 -0700 (PDT)
Message-ID: <38988c89-ec61-faa1-6b15-2fd3aa51eede@arm.com>
Date:   Tue, 13 Sep 2022 15:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iommu/iova: Fix module config properly
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
 <4740744e-2e12-520d-8598-188b8d2ebd6b@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4740744e-2e12-520d-8598-188b8d2ebd6b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-13 14:01, John Garry wrote:
> On 13/09/2022 12:47, Robin Murphy wrote:
>> IOMMU_IOVA is intended to be an optional library for users to select as
>> and when they desire. Since it can be a module now, this means that
>> built-in code which has chosen not to select it should not fail to link
>> if it happens to have selected as a module by someone else. Replace
>> IS_ENABLED() with IS_REACHABLE() to do the right thing.
> 
> Hi Robin,
> 
> Recently you mentioned "I wonder if we couldn't replace the IS_ENABLED() 
> with IS_REACHABLE() and restore some of the previously-conditional 
> selects", and pointed me to 84db889e6d82 as an example of when a 
> conditional select was made unconditional.
> 
> So will you also restore some previously-conditional selects next?

I figured I'd leave that up to Thierry (and/or anyone else with a vested 
interest), but having mulled it over since that previous thread, there's 
really no excuse for the API itself not to do the right thing either 
way, so I felt compelled to write up this much.

Cheers,
Robin.

> 
> To me, it seems that any user of IOVA API selects IOMMU_IOVA always.
> 
> thanks,
> John
> 
>>
>> CC: Thierry Reding <thierry.reding@gmail.com>
>> Reported-by: John Garry <john.garry@huawei.com>
>> Fixes: 15bbdec3931e ("iommu: Make the iova library a module")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Phrased as a fix for the sake of complete honesty, but it seems
>> everyone's been making do for years already so by now it's really
>> just more of an enhancement.
>>
>>   include/linux/iova.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index 8f97a43be834..fe18c3e6a725 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -75,7 +75,7 @@ static inline unsigned long iova_pfn(struct 
>> iova_domain *iovad, dma_addr_t iova)
>>       return iova >> iova_shift(iovad);
>>   }
>> -#if IS_ENABLED(CONFIG_IOMMU_IOVA)
>> +#if IS_REACHABLE(CONFIG_IOMMU_IOVA)
>>   int iova_cache_get(void);
>>   void iova_cache_put(void);
> 
