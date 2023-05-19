Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F8709D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjESRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESRDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:03:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB11132;
        Fri, 19 May 2023 10:03:12 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDFdwD022366;
        Fri, 19 May 2023 17:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=15mqatN0JtAeqDTDURc3+E1nmxFNbcd2tiKr9rIMIXA=;
 b=goVIuVlSw3toAzeF82WTFdm3Zf9PACYUlywnPgnHsUMBJLEhFtPBSvR9IVuGAFCM7nxr
 9GNYMiwzPZUyXxnNLcD0N8ww8H2PApz4SGEbNphqXZ/fuvioCOqfkbHbh0ujIvz1TMAV
 VF9+v8S0S+Lqv+UnSHaAN6sasP38I+7NK7d2ZTOPWGCDdXVs6k0HsGrUGtu90ylX/tGs
 hrH4VNBcP9fxaIQrGZy+tOXAeZisM2nB5eHkzACzT5+wJ9TcfW5y5ASJQf+p2UXRXXF5
 E6H2Hp+aV88tm/LFLbaEdi7Q7TEr6/wjPlUnxVUQK6Hv4Szp2z+v3kCcOANqPrn4PXSk eQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4nt9aju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 17:02:32 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JH2VMo021638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 17:02:31 GMT
Received: from [10.110.48.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 10:02:30 -0700
Message-ID: <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
Date:   Fri, 19 May 2023 10:02:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
To:     Will Deacon <will@kernel.org>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
 <20230519115948.GB2637@willie-the-truck>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230519115948.GB2637@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qssvahDTuyjVZhfr-3TN9xikhuY7sI_z
X-Proofpoint-GUID: qssvahDTuyjVZhfr-3TN9xikhuY7sI_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_12,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190145
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2023 4:59 AM, Will Deacon wrote:
> Hi Elliot,
> 
> On Tue, May 09, 2023 at 01:47:47PM -0700, Elliot Berman wrote:
>> When launching a virtual machine, Gunyah userspace allocates memory for
>> the guest and informs Gunyah about these memory regions through
>> SET_USER_MEMORY_REGION ioctl.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile    |   2 +-
>>   drivers/virt/gunyah/vm_mgr.c    |  59 +++++++-
>>   drivers/virt/gunyah/vm_mgr.h    |  26 ++++
>>   drivers/virt/gunyah/vm_mgr_mm.c | 236 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/gunyah.h     |  37 +++++
>>   5 files changed, 356 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
> 
> [...]
> 
>> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
>> +{
>> +	struct gh_vm_mem *mapping, *tmp_mapping;
>> +	struct page *curr_page, *prev_page;
>> +	struct gh_rm_mem_parcel *parcel;
>> +	int i, j, pinned, ret = 0;
>> +	unsigned int gup_flags;
>> +	size_t entry_size;
>> +	u16 vmid;
>> +
>> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
>> +		!PAGE_ALIGNED(region->userspace_addr) ||
>> +		!PAGE_ALIGNED(region->guest_phys_addr))
>> +		return -EINVAL;
>> +
>> +	if (overflows_type(region->guest_phys_addr + region->memory_size, u64))
>> +		return -EOVERFLOW;
>> +
>> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
>> +	if (mapping) {
>> +		ret = -EEXIST;
>> +		goto unlock;
>> +	}
>> +
>> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
>> +		if (gh_vm_mem_overlap(tmp_mapping, region->guest_phys_addr,
>> +					region->memory_size)) {
>> +			ret = -EEXIST;
>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL_ACCOUNT);
>> +	if (!mapping) {
>> +		ret = -ENOMEM;
>> +		goto unlock;
>> +	}
>> +
>> +	mapping->guest_phys_addr = region->guest_phys_addr;
>> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
>> +	parcel = &mapping->parcel;
>> +	parcel->label = region->label;
>> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
>> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
>> +
>> +	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
>> +	if (ret)
>> +		goto free_mapping;
>> +
>> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
>> +	if (!mapping->pages) {
>> +		ret = -ENOMEM;
>> +		mapping->npages = 0; /* update npages for reclaim */
>> +		goto unlock_pages;
>> +	}
>> +
>> +	gup_flags = FOLL_LONGTERM;
>> +	if (region->flags & GH_MEM_ALLOW_WRITE)
>> +		gup_flags |= FOLL_WRITE;
>> +
>> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
>> +					gup_flags, mapping->pages);
>> +	if (pinned < 0) {
>> +		ret = pinned;
>> +		goto free_pages;
>> +	} else if (pinned != mapping->npages) {
>> +		ret = -EFAULT;
>> +		mapping->npages = pinned; /* update npages for reclaim */
>> +		goto unpin_pages;
>> +	}
> 
> Sorry if I missed it, but I still don't see where you reject file mappings
> here.
> 

Sure, I can reject file mappings. I didn't catch that was the ask 
previously and thought it was only a comment about behavior of file 
mappings.

> This is also the wrong interface for upstream. Please get involved with
> the fd-based guest memory discussions [1] and port your series to that.
> 

The user interface design for *shared* memory aligns with 
KVM_SET_USER_MEMORY_REGION.

I understood we want to use restricted memfd for giving guest-private 
memory (Gunyah calls this "lending memory"). When I went through the 
changes, I gathered KVM is using restricted memfd only for guest-private 
memory and not for shared memory. Thus, I dropped support for lending 
memory to the guest VM and only retained the shared memory support in 
this series. I'd like to merge what we can today and introduce the 
guest-private memory support in tandem with the restricted memfd; I 
don't see much reason to delay the series.

I briefly evaluated and picked the arm64/pKVM support that Fuad shared 
[2] and found it should be fine for Gunyah. I did build-only at the 
time. I don't have any comments on the base restricted_memfd support and 
Fuad has not posted [2] on mailing lists yet as far as I can tell.

> This patch cannot be merged in its current form.
> 

I am a little confused why the implementation to share memory with the 
VM is being rejected. Besides rejecting file mappings, any other changes 
needed to be accepted?

- Elliot

> Will
> 
> [1] https://lore.kernel.org/kvm/20221202061347.1070246-1-chao.p.peng@linux.intel.com/
[2]: 
https://android-kvm.googlesource.com/linux/+/refs/heads/tabba/fdmem-v10-core
