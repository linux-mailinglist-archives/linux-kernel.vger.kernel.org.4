Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA36DE5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDKUfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:35:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8726A6;
        Tue, 11 Apr 2023 13:35:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BK0Bsx001454;
        Tue, 11 Apr 2023 20:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FXxcaIIwTMCd0oXXf6T9qzaBnMuzEh2uKrLR/xfoVIc=;
 b=Q/M6Me0FPSKUjCeak19LQKSccTrnELiK+nscnlGgSueqss1XDj11nz2TD6dl6VS+HcnS
 xyVreZc/sECnmLFk9IJ8ar4t4Nxi7zTiF0INmkLhbt4yWDR029vv/PU8yElpOhGbYlCd
 2ebntvWvvICpmP/7tolhux5a30tkumA5hieiKoRPRaJPFCsIhQtGJQ5/Dy2nF+N60kR2
 PSdFeEJ7ZavGOnGJCGAlEYnKwdTHqXHdpi+gfjo7dUJm0gaF/yLu3PmBodLvLodZfFw3
 z2joa3QA4VghnoRNUZSRl5HTO7P938R8Jgnqq8KvhJNwIE6DTBxA0Eg92xn9LfMOWi60 Kw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw3cehk6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 20:34:36 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BKYZAj005203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 20:34:35 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 13:34:35 -0700
Message-ID: <5d1c6160-6bc4-5246-2a0b-de5ddcbbc2c4@quicinc.com>
Date:   Tue, 11 Apr 2023 13:34:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 12/26] gunyah: vm_mgr: Add/remove user memory regions
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
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-13-quic_eberman@quicinc.com>
 <20230324183659.GB28266@willie-the-truck>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230324183659.GB28266@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6o1jgUhiE7rw1lZgDf-yUqhHBmPZdqfQ
X-Proofpoint-GUID: 6o1jgUhiE7rw1lZgDf-yUqhHBmPZdqfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_14,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110185
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2023 11:37 AM, Will Deacon wrote:
> On Fri, Mar 03, 2023 at 05:06:18PM -0800, Elliot Berman wrote:
>> When launching a virtual machine, Gunyah userspace allocates memory for
>> the guest and informs Gunyah about these memory regions through
>> SET_USER_MEMORY_REGION ioctl.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile    |   2 +-
>>   drivers/virt/gunyah/vm_mgr.c    |  44 ++++++
>>   drivers/virt/gunyah/vm_mgr.h    |  25 ++++
>>   drivers/virt/gunyah/vm_mgr_mm.c | 229 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/gunyah.h     |  29 ++++
>>   5 files changed, 328 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
> 
> [...]
> 
>> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
>> +{
>> +	struct gh_vm_mem *mapping, *tmp_mapping;
>> +	struct gh_rm_mem_entry *mem_entries;
>> +	phys_addr_t curr_page, prev_page;
>> +	struct gh_rm_mem_parcel *parcel;
>> +	int i, j, pinned, ret = 0;
>> +	size_t entry_size;
>> +	u16 vmid;
>> +
>> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
>> +		!PAGE_ALIGNED(region->userspace_addr) || !PAGE_ALIGNED(region->guest_phys_addr))
>> +		return -EINVAL;
>> +
>> +	if (region->guest_phys_addr + region->memory_size < region->guest_phys_addr)
>> +		return -EOVERFLOW;
>> +
>> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
>> +	if (mapping) {
>> +		mutex_unlock(&ghvm->mm_lock);
>> +		return -EEXIST;
>> +	}
>> +
>> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>> +	if (!mapping) {
>> +		mutex_unlock(&ghvm->mm_lock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	mapping->parcel.label = region->label;
>> +	mapping->guest_phys_addr = region->guest_phys_addr;
>> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
>> +	parcel = &mapping->parcel;
>> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
>> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
>> +
>> +	/* Check for overlap */
>> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
>> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
>> +			tmp_mapping->guest_phys_addr) ||
>> +			(mapping->guest_phys_addr >=
>> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
>> +			ret = -EEXIST;
>> +			goto free_mapping;
>> +		}
>> +	}
>> +
>> +	list_add(&mapping->list, &ghvm->memory_mappings);
>> +
>> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
>> +	if (!mapping->pages) {
>> +		ret = -ENOMEM;
>> +		mapping->npages = 0; /* update npages for reclaim */
>> +		goto reclaim;
>> +	}
>> +
>> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
>> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
>> +	if (pinned < 0) {
>> +		ret = pinned;
>> +		mapping->npages = 0; /* update npages for reclaim */
>> +		goto reclaim;
>> +	} else if (pinned != mapping->npages) {
>> +		ret = -EFAULT;
>> +		mapping->npages = pinned; /* update npages for reclaim */
>> +		goto reclaim;
>> +	}
> 
> I think Fuad mentioned this on an older version of these patches, but it
> looks like you're failing to account for the pinned memory here which is
> a security issue depending on who is able to issue the ioctl() calling
> into here.
> 
> Specifically, I'm thinking that your kXalloc() calls should be using
> GFP_KERNEL_ACCOUNT in this function and also that you should be calling
> account_locked_vm() for the pages being pinned.
> 

Added the accounting for the v12.

> Finally, what happens if userspace passes in a file mapping?

Userspace will get EBADADDR (-14) back when trying to launch the VM 
(pin_user_pages_fast returns this as you might have been expecting). We 
haven't yet had any need to support file-backed mappings.

Thanks,
Elliot
