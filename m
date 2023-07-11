Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4974F246
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjGKObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGKObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:31:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C46BC;
        Tue, 11 Jul 2023 07:31:10 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEPc1h030623;
        Tue, 11 Jul 2023 14:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=k5whsS7kOg0w8NvsFZpkoENsflayjHUaVNSyPCSYX88=;
 b=tDpMpBSpW2TClzakharP0AXhWsKuI0unAzQSkGdXJOnGF1EuBeGPLUCknrAzsyuD1QKf
 vC1QIwfRSNRtIi4R+PTXglDhighTRgR6XEkXpSCiEp+BJCTVbXRhg0TCqxA5mDdLWxiQ
 XANeESjxIxDNSQzkfoXeC7CkjlUVy/RB8AJeKd2ySKq/Ro8cwiMWdOFN0bPC64hnOXd1
 J5Cdm4K6jw0VwUIZiV5xubLcWVmws/r6QvM3vGEc1g77NHuE/m0w4GIxqUngz2blEkZo
 k//uQEo8vPEHYh6xJBZJWfFuJBlOWSY6vyD3UWNi2vdI84nXwbORYeZzUvhhxRBtxrY5 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs8u2r4wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:30:44 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BESJOC006169;
        Tue, 11 Jul 2023 14:30:43 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs8u2r4vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:30:43 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36B8lGFD026569;
        Tue, 11 Jul 2023 14:30:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3rpye5mxym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:30:42 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BEUfW24522712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 14:30:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E3758063;
        Tue, 11 Jul 2023 14:30:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02AA45803F;
        Tue, 11 Jul 2023 14:30:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.86.43])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 14:30:34 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
In-Reply-To: <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
 <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
Date:   Tue, 11 Jul 2023 20:00:32 +0530
Message-ID: <87edleplkn.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sBc0SZ-XJ6uR_-MUXidz4FusRLIp7phB
X-Proofpoint-GUID: NONq6tF3YjFkZtCggSFopj4pkW66iNU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 16.06.23 00:00, Vishal Verma wrote:
>> With DAX memory regions originating from CXL memory expanders or
>> NVDIMMs, the kmem driver may be hot-adding huge amounts of system memory
>> on a system without enough 'regular' main memory to support the memmap
>> for it. To avoid this, ensure that all kmem managed hotplugged memory is
>> added with the MHP_MEMMAP_ON_MEMORY flag to place the memmap on the
>> new memory region being hot added.
>>
>> To do this, call add_memory() in chunks of memory_block_size_bytes() as
>> that is a requirement for memmap_on_memory. Additionally, Use the
>> mhp_flag to force the memmap_on_memory checks regardless of the
>> respective module parameter setting.
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>> ---
>>   drivers/dax/kmem.c | 49 ++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 36 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index 7b36db6f1cbd..0751346193ef 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/mman.h>
>>   #include <linux/memory-tiers.h>
>> +#include <linux/memory_hotplug.h>
>>   #include "dax-private.h"
>>   #include "bus.h"
>>
>> @@ -105,6 +106,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   	data->mgid = rc;
>>
>>   	for (i = 0; i < dev_dax->nr_range; i++) {
>> +		u64 cur_start, cur_len, remaining;
>>   		struct resource *res;
>>   		struct range range;
>>
>> @@ -137,21 +139,42 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   		res->flags = IORESOURCE_SYSTEM_RAM;
>>
>>   		/*
>> -		 * Ensure that future kexec'd kernels will not treat
>> -		 * this as RAM automatically.
>> +		 * Add memory in chunks of memory_block_size_bytes() so that
>> +		 * it is considered for MHP_MEMMAP_ON_MEMORY
>> +		 * @range has already been aligned to memory_block_size_bytes(),
>> +		 * so the following loop will always break it down cleanly.
>>   		 */
>> -		rc = add_memory_driver_managed(data->mgid, range.start,
>> -				range_len(&range), kmem_name, MHP_NID_IS_MGID);
>> +		cur_start = range.start;
>> +		cur_len = memory_block_size_bytes();
>> +		remaining = range_len(&range);
>> +		while (remaining) {
>> +			mhp_t mhp_flags = MHP_NID_IS_MGID;
>>
>> -		if (rc) {
>> -			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>> -					i, range.start, range.end);
>> -			remove_resource(res);
>> -			kfree(res);
>> -			data->res[i] = NULL;
>> -			if (mapped)
>> -				continue;
>> -			goto err_request_mem;
>> +			if (mhp_supports_memmap_on_memory(cur_len,
>> +							  MHP_MEMMAP_ON_MEMORY))
>> +				mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>> +			/*
>> +			 * Ensure that future kexec'd kernels will not treat
>> +			 * this as RAM automatically.
>> +			 */
>> +			rc = add_memory_driver_managed(data->mgid, cur_start,
>> +						       cur_len, kmem_name,
>> +						       mhp_flags);
>> +
>> +			if (rc) {
>> +				dev_warn(dev,
>> +					 "mapping%d: %#llx-%#llx memory add failed\n",
>> +					 i, cur_start, cur_start + cur_len - 1);
>> +				remove_resource(res);
>> +				kfree(res);
>> +				data->res[i] = NULL;
>> +				if (mapped)
>> +					continue;
>> +				goto err_request_mem;
>> +			}
>> +
>> +			cur_start += cur_len;
>> +			remaining -= cur_len;
>>   		}
>>   		mapped++;
>>   	}
>>
>
> Maybe the better alternative is teach
> add_memory_resource()/try_remove_memory() to do that internally.
>
> In the add_memory_resource() case, it might be a loop around that
> memmap_on_memory + arch_add_memory code path (well, and the error path
> also needs adjustment):
>
> 	/*
> 	 * Self hosted memmap array
> 	 */
> 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> 		if (!mhp_supports_memmap_on_memory(size)) {
> 			ret = -EINVAL;
> 			goto error;
> 		}
> 		mhp_altmap.free = PHYS_PFN(size);
> 		mhp_altmap.base_pfn = PHYS_PFN(start);
> 		params.altmap = &mhp_altmap;
> 	}
>
> 	/* call arch's memory hotadd */
> 	ret = arch_add_memory(nid, start, size, &params);
> 	if (ret < 0)
> 		goto error;
>
>
> Note that we want to handle that on a per memory-block basis, because we
> don't want the vmemmap of memory block #2 to end up on memory block #1.
> It all gets messy with memory onlining/offlining etc otherwise ...
>

I tried to implement this inside add_memory_driver_managed() and also
within dax/kmem. IMHO doing the error handling inside dax/kmem is
better. Here is how it looks:

1. If any blocks got added before (mapped > 0) we loop through all successful request_mem_regions
2. For each succesful request_mem_regions if any blocks got added, we
keep the resource. If none got added, we will kfree the resource



	for (i = 0; i < dev_dax->nr_range; i++) {
		u64 cur_start, cur_len, remaining;
		struct resource *res;
		struct range range;
		bool block_added;

		rc = dax_kmem_range(dev_dax, i, &range);
		if (rc)
			continue;

		/* Region is permanently reserved if hotremove fails. */
		res = request_mem_region(range.start, range_len(&range), data->res_name);
		if (!res) {
			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
					i, range.start, range.end);
			/*
			 * Once some memory has been onlined we can't
			 * assume that it can be un-onlined safely.
			 */
			if (mapped)
				continue;
			rc = -EBUSY;
			goto err_request_mem;
		}
		data->res[i] = res;

		/*
		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
		 * so that add_memory() can add a child resource.  Do not
		 * inherit flags from the parent since it may set new flags
		 * unknown to us that will break add_memory() below.
		 */
		res->flags = IORESOURCE_SYSTEM_RAM;

		/*
		 * Add memory in chunks of memory_block_size_bytes() so that
		 * it is considered for MHP_MEMMAP_ON_MEMORY
		 * @range has already been aligned to memory_block_size_bytes(),
		 * so the following loop will always break it down cleanly.
		 */
		cur_start = range.start;
		cur_len = memory_block_size_bytes();
		remaining = range_len(&range);
		block_added = false;
		while (remaining) {
			/*
			 * If alignment rules are not satisified we will
			 * fallback normal memmap allocation.
			 */
			mhp_t mhp_flags = MHP_NID_IS_MGID | MHP_MEMMAP_ON_MEMORY;
			/*
			 * Ensure that future kexec'd kernels will not treat
			 * this as RAM automatically.
			 */
			rc = add_memory_driver_managed(data->mgid, cur_start,
						       cur_len, kmem_name,
						       mhp_flags);

			if (rc)
				dev_warn(dev,
					 "mapping%d: %#llx-%#llx memory add failed\n",
					 i, cur_start, cur_start + cur_len - 1);
			else
				block_added = true;

			cur_start += cur_len;
			remaining -= cur_len;
		}
		if (!block_added) {
			/*
			 * None of the blocks got added, remove the resource.
			 */
			remove_resource(res);
			kfree(res);
			data->res[i] = NULL;
		} else
			mapped++;
	}
	if (mapped) {
		dev_set_drvdata(dev, data);
		return 0;
	}

err_request_mem:
	/*
	 *  If none of the resources got mapped.
	 *  unregister the group.
	 */
	memory_group_unregister(data->mgid);
err_reg_mgid:
	kfree(data->res_name);
