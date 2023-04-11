Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B46DE61C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDKVEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDKVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:04:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9A30C4;
        Tue, 11 Apr 2023 14:04:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BKOUZp029715;
        Tue, 11 Apr 2023 21:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b8ePNZOTICqSe+xK2ngJRni1H4oSJZNkfsVmf0MDt3Y=;
 b=btva9PBOjaVDrEycZByrXlarkFQvrcrPlSgqdkO0JLFdQpZVNyB9M/L3wXzm34RCZkLW
 nm8jfzfT0pChL5lRZxu/sBASC8Q7Z0M2UDeFIm4oDh4+UhYY6THG+gfAON2xr/E4dOgU
 qsutNkCXhSOUemsoYFYaVhYntlMTVEbFQhd7nkYPD6D+d1dZDVAiHBJiwjb5mPyjM0Dk
 X6v5dQXbYTbJ8sgmGVyTgBoU+qSIB0XrCo3sEFUhztJI40RXjUcG/R9WwOrQZhrk64TY
 sXuzzFTYu+sa+Eu5jIkR7WQKMPVNjMrYpinJXZNN6p+3Jb7X4mERW0726iqvAfPcxLJm ag== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw3cv9mg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 21:04:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BL4DaS016655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 21:04:13 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 14:04:13 -0700
Message-ID: <1276ec4c-e177-aeb2-d493-93bd48634ee8@quicinc.com>
Date:   Tue, 11 Apr 2023 14:04:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 12/26] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-13-quic_eberman@quicinc.com>
 <3b4e230c-6635-43f6-99ce-1ed51b55a450@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <3b4e230c-6635-43f6-99ce-1ed51b55a450@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xn1is88OUJ6e3fH2xhPQpYYbaZDYmSH9
X-Proofpoint-ORIG-GUID: Xn1is88OUJ6e3fH2xhPQpYYbaZDYmSH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_14,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=914 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110190
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:26 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> +
>> +    mem_entries = kcalloc(mapping->npages, sizeof(*mem_entries), 
>> GFP_KERNEL);
>> +    if (!mem_entries) {
>> +        ret = -ENOMEM;
>> +        goto reclaim;
>> +    }
>> +
>> +    /* reduce number of entries by combining contiguous pages into 
>> single memory entry */
> 
> Are you sure you need to do this?  I.e., does pin_user_pages_fast()
> already take care of consolidating these pages?
> 

pin_user_pages_fast wouldn't consolidate the page entries. There's a 
speedup in sharing memory when pages are contiguous since less 
information needs to be transmitted to Gunyah describing the memory.

>> +    prev_page = page_to_phys(mapping->pages[0]);
>> +    mem_entries[0].ipa_base = cpu_to_le64(prev_page);
>> +    entry_size = PAGE_SIZE;
>> +    for (i = 1, j = 0; i < mapping->npages; i++) {
>> +        curr_page = page_to_phys(mapping->pages[i]);
> 
> I think you can actually use the page frame numbers
> here instead of the addresses.  If they are consecutive,
> they are contiguous.  See pages_are_mergeable() for an
> example of that.  Using PFNs might simplify this code.
> 

It did, thanks for the suggestion!

>> +        if (curr_page - prev_page == PAGE_SIZE) {
>> +            entry_size += PAGE_SIZE;
>> +        } else {
>> +            mem_entries[j].size = cpu_to_le64(entry_size);
>> +            j++;
>> +            mem_entries[j].ipa_base = cpu_to_le64(curr_page);
>> +            entry_size = PAGE_SIZE;
>> +        }
>> +
>> +        prev_page = curr_page;
>> +    }
>> +    mem_entries[j].size = cpu_to_le64(entry_size);
> 
> It might be messier, but it seems like you could scan the pages to
> see how many you'll need (after combining), then allocate the array
> of mem entries based on that.  That is, do that rather than allocating,
> filling, then duplicating and freeing.
> 
>      count = 1;
>      curr_page = mapping->pages[0];
>      for (i = 1; i < mapping->npages; i++) {
>          next_page = mapping->pages[i];
>          if (page_to_pfn(next_page) !=
>                  page_to_pfn(curr_page) + 1)
>              count++;
>          curr_page = next_page;
>      }
>      parcel->n_mem_entries = count;
>      parcel->mem_entries = kcalloc(count, ...);
>      /* Then fill them up */
> 
> (Not tested, but you get the idea.)
> 

It wasn't too messy IMO, I think this ended up simplifying the loop.

>> +
>> +    parcel->n_mem_entries = j + 1;
>> +    parcel->mem_entries = kmemdup(mem_entries, sizeof(*mem_entries) * 
>> parcel->n_mem_entries,
>> +                    GFP_KERNEL);
>> +    kfree(mem_entries);
>> +    if (!parcel->mem_entries) {
>> +        ret = -ENOMEM;
>> +        goto reclaim;
>> +    }
>> +
>> +    mutex_unlock(&ghvm->mm_lock);
>> +    return 0;
>> +reclaim:
>> +    gh_vm_mem_reclaim(ghvm, mapping);
>> +free_mapping:
>> +    kfree(mapping);
>> +    mutex_unlock(&ghvm->mm_lock);
>> +    return ret;
>> +}
>> +
>> +int gh_vm_mem_free(struct gh_vm *ghvm, u32 label)
>> +{
>> +    struct gh_vm_mem *mapping;
>> +    int ret;
>> +
>> +    ret = mutex_lock_interruptible(&ghvm->mm_lock);
>> +    if (ret)
>> +        return ret;
>> +
>> +    mapping = __gh_vm_mem_find_by_label(ghvm, label);
>> +    if (!mapping)
>> +        goto out;
>> +
>> +    gh_vm_mem_reclaim(ghvm, mapping);
>> +    kfree(mapping);
>> +out:
>> +    mutex_unlock(&ghvm->mm_lock);
>> +    return ret;
>> +}
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index 10ba32d2b0a6..a19207e3e065 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -20,4 +20,33 @@
>>    */
>>   #define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns a 
>> Gunyah VM fd */
>> +/*
>> + * ioctls for VM fds
>> + */
>> +
> 
> I think you should define the following three values in an enum.
> 
>> +#define GH_MEM_ALLOW_READ    (1UL << 0)
>> +#define GH_MEM_ALLOW_WRITE    (1UL << 1)
>> +#define GH_MEM_ALLOW_EXEC    (1UL << 2)
>> +
>> +/**
>> + * struct gh_userspace_memory_region - Userspace memory descripion 
>> for GH_VM_SET_USER_MEM_REGION
>> + * @label: Unique identifer to the region.
> 
> Unique with respect to what?  I think it's unique among memory
> regions defined within a VM.  And I think it's arbitrary and
> defined by the caller (right?).
> 
>> + * @flags: Flags for memory parcel behavior
>> + * @guest_phys_addr: Location of the memory region in guest's memory 
>> space (page-aligned)
>> + * @memory_size: Size of the region (page-aligned)
>> + * @userspace_addr: Location of the memory region in caller 
>> (userspace)'s memory
>> + *
>> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
>> + */
>> +struct gh_userspace_memory_region {
>> +    __u32 label;
>> +    __u32 flags;
> 
> Add a comment to indicate what types of values "flags" can have.
> Maybe "flags" should be called "perms" or something?
> 

Added documentation for the valid values of flags. I'm anticipating 
needing to add other flag values beyond permission bits.

>> +    __u64 guest_phys_addr;
>> +    __u64 memory_size;
>> +    __u64 userspace_addr;
> 
> Why isn't userspace_addr just a (void *)?  That would be a more natural
> thing to pass to the kernel.  Is it to avoid 32-bit/64-bit pointer
> differences in the API?
> 

Yes, to avoid 32-bit/64-bit pointer differences in API.

>> +};
>> +
>> +#define GH_VM_SET_USER_MEM_REGION    _IOW(GH_IOCTL_TYPE, 0x1, \
>> +                        struct gh_userspace_memory_region)
>> +
> 
> I think it's nicer to group the definitions of these IOCTL values.
> Then in the struct definitions that follow, you can add comment that
> indicates which IOCTL the struct is used for.
> 
>>   #endif
> 
