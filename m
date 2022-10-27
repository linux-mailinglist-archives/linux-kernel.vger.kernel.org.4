Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECDF60F5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiJ0KqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiJ0KqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:46:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E076A5B9F1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:46:07 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R9Xhcd004288;
        Thu, 27 Oct 2022 10:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LtkIr+lPSiHcvdABwFy+5FaSZ49U5nIyVIbrC2mZuU4=;
 b=rzuzsiEvU/emg8JaHSHTT+0SkGecPudxX+R/JV67lOCtNIc3RyZhluKAioRuLpKPLGS0
 qeZdF0NtuvVSVcVFy+vUcLBzDhSurGT2uTAUDTD4C7jhjlEyxMh3EAHMOJxJqBk0BCNp
 PcLPSfvEDqQEK/7WIqPLda++vdnMCJCwX3X6QxeX1lMU6iDTze1IDlPh2hILLYNvHlgC
 iYM/WOgNlq1/wgJxHwhQ7sbSq47nqqd0hjwpg9QBIpYN+t7i7hg+G4XPuOCMcQjuAkfF
 HkewbvRidb51xZI6g9LmGPt+eGWxDd/Az3eQOMUQ60BeC2Xxp2z9Si253Xi7vujfFoN3 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kfqfcjw0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:45:50 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29R9YlsV008850;
        Thu, 27 Oct 2022 10:45:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kfqfcjvyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:45:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29RAO0m5006727;
        Thu, 27 Oct 2022 10:45:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kfah81u5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:45:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29RAjjOV51118516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 10:45:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F8B4C046;
        Thu, 27 Oct 2022 10:45:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 616994C044;
        Thu, 27 Oct 2022 10:45:41 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Oct 2022 10:45:41 +0000 (GMT)
Message-ID: <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
Date:   Thu, 27 Oct 2022 16:15:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
References: <20221027065925.476955-1-ying.huang@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20221027065925.476955-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ts_ZvK4L2uF410T_TzDd9HEqLBD3xA2x
X-Proofpoint-GUID: Ic7NN2Y0RwrjyVFJ72m_pLOfn_wpDOK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_05,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 12:29 PM, Huang Ying wrote:
> We need some way to override the system default memory tiers.  For
> the example system as follows,
> 
> type		abstract distance
> ----		-----------------
> HBM		300
> DRAM		1000
> CXL_MEM		5000
> PMEM		5100
> 
> Given the memory tier chunk size is 100, the default memory tiers
> could be,
> 
> tier		abstract distance	types
>                 range
> ----		-----------------       -----
> 3		300-400			HBM
> 10		1000-1100		DRAM
> 50		5000-5100		CXL_MEM
> 51		5100-5200		PMEM
> 
> If we want to group CXL MEM and PMEM into one tier, we have 2 choices.
> 
> 1) Override the abstract distance of CXL_MEM or PMEM.  For example, if
> we change the abstract distance of PMEM to 5050, the memory tiers
> become,
> 
> tier		abstract distance	types
>                 range
> ----		-----------------       -----
> 3		300-400			HBM
> 10		1000-1100		DRAM
> 50		5000-5100		CXL_MEM, PMEM
> 
> 2) Override the memory tier chunk size.  For example, if we change the
> memory tier chunk size to 200, the memory tiers become,
> 
> tier		abstract distance	types
>                 range
> ----		-----------------       -----
> 1		200-400			HBM
> 5		1000-1200		DRAM
> 25		5000-5200		CXL_MEM, PMEM
> 
> But after some thoughts, I think choice 2) may be not good.  The
> problem is that even if 2 abstract distances are almost same, they may
> be put in 2 tier if they sit in the different sides of the tier
> boundary.  For example, if the abstract distance of CXL_MEM is 4990,
> while the abstract distance of PMEM is 5010.  Although the difference
> of the abstract distances is only 20, CXL_MEM and PMEM will put in
> different tiers if the tier chunk size is 50, 100, 200, 250, 500, ....
> This makes choice 2) hard to be used, it may become tricky to find out
> the appropriate tier chunk size that satisfying all requirements.
> 

Shouldn't we wait for gaining experience w.r.t how we would end up
mapping devices with different latencies and bandwidth before tuning these values? 

> So I suggest to abandon choice 2) and use choice 1) only.  This makes
> the overall design and user space interface to be simpler and easier
> to be used.  The overall design of the abstract distance could be,
> 
> 1. Use decimal for abstract distance and its chunk size.  This makes
>    them more user friendly.
> 
> 2. Make the tier chunk size as small as possible.  For example, 10.
>    This will put different memory types in one memory tier only if their
>    performance is almost same by default.  And we will not provide the
>    interface to override the chunk size.
> 

this could also mean we can end up with lots of memory tiers with relative
smaller performance difference between them. Again it depends how HMAT
attributes will be used to map to abstract distance.



> 3. Make the abstract distance of normal DRAM large enough.  For
>    example, 1000, then 100 tiers can be defined below DRAM, this is
>    more than enough in practice.

Why 100? Will we really have that many tiers below/faster than DRAM? As of now 
I see only HBM below it.

> 
> 4. If we want to override the default memory tiers, just override the
>    abstract distances of some memory types with a per memory type
>    interface.
> 
> This patch is to apply the design choices above in the existing code.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Hesham Almatary <hesham.almatary@huawei.com>
> Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/memory-tiers.h | 7 +++----
>  mm/memory-tiers.c            | 7 +++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 965009aa01d7..2e39d9a6c8ce 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -7,17 +7,16 @@
>  #include <linux/kref.h>
>  #include <linux/mmzone.h>
>  /*
> - * Each tier cover a abstrace distance chunk size of 128
> + * Each tier cover a abstrace distance chunk size of 10
>   */
> -#define MEMTIER_CHUNK_BITS	7
> -#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
> +#define MEMTIER_CHUNK_SIZE	10
>  /*
>   * Smaller abstract distance values imply faster (higher) memory tiers. Offset
>   * the DRAM adistance so that we can accommodate devices with a slightly lower
>   * adistance value (slightly faster) than default DRAM adistance to be part of
>   * the same memory tier.
>   */
> -#define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
> +#define MEMTIER_ADISTANCE_DRAM	((100 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE / 2))
>  #define MEMTIER_HOTPLUG_PRIO	100
>  
>  struct memory_tier;
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index fa8c9d07f9ce..e03011428fa5 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -165,11 +165,10 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  	bool found_slot = false;
>  	struct memory_tier *memtier, *new_memtier;
>  	int adistance = memtype->adistance;
> -	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
>  
>  	lockdep_assert_held_once(&memory_tier_lock);
>  
> -	adistance = round_down(adistance, memtier_adistance_chunk_size);
> +	adistance = rounddown(adistance, MEMTIER_CHUNK_SIZE);
>  	/*
>  	 * If the memtype is already part of a memory tier,
>  	 * just return that.
> @@ -204,7 +203,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  	else
>  		list_add_tail(&new_memtier->list, &memory_tiers);
>  
> -	new_memtier->dev.id = adistance >> MEMTIER_CHUNK_BITS;
> +	new_memtier->dev.id = adistance / MEMTIER_CHUNK_SIZE;
>  	new_memtier->dev.bus = &memory_tier_subsys;
>  	new_memtier->dev.release = memory_tier_device_release;
>  	new_memtier->dev.groups = memtier_dev_groups;
> @@ -641,7 +640,7 @@ static int __init memory_tier_init(void)
>  #endif
>  	mutex_lock(&memory_tier_lock);
>  	/*
> -	 * For now we can have 4 faster memory tiers with smaller adistance
> +	 * For now we can have 100 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
>  	 */
>  	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);

