Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B327674CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjATFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjATFiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:38:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5072C33;
        Thu, 19 Jan 2023 21:34:35 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K3o2V9011583;
        Fri, 20 Jan 2023 05:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=5AwsPcgBKb4mMBYPkdjE+yVcpgBpoQQmg99thVzIvtg=;
 b=MyHtXJEVAZa7E/joLQi+OBc4OirSPbgBGkoVLcfBccf9qGlAqrxRn7GA+Ejdgzu6RZAF
 AwYXOm8XnO/qe/YnMPZFySntTBPGIy2R/ENhq+4JFUeiMtBuwb7usgLDejPmDmBWWYnD
 VyLVc0BaS3/sv1ExALTr3LQNeXkeHfYCOXnyjgEMrj0LRvTSaXFSvYyyBAul/F0mk8j4
 O8k2OcfRcI5UniTBkwQIvPlKM17HPw0sn7Xt66Dr4kS4OSDb7TaCFnWcCZG1Bowb/3IR
 WGKn93wWWcbZ2kkBAvfOQUB0vwDhAbknMwXeI0r6H3AGxF+bzCBumLE6465dyUjmHaEU BA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vjbk9x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 05:34:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30K5YI9a014355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 05:34:18 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 21:34:11 -0800
Date:   Fri, 20 Jan 2023 11:04:07 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 14/28] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230118090859.GC1737564@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-15-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20221219225850.2397345-15-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hwDDQ5ftKuDYkmwG8_jwJQaSrm3ey9s7
X-Proofpoint-GUID: hwDDQ5ftKuDYkmwG8_jwJQaSrm3ey9s7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_02,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=812
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:35]:

>  static int gh_vm_release(struct inode *inode, struct file *filp)
>  {
>  	struct gunyah_vm *ghvm = filp->private_data;
> +	struct gunyah_vm_memory_mapping *mapping, *tmp;
>  
> +	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> +		gh_vm_mem_mapping_reclaim(ghvm, mapping);

kfree(mapping) also?

> +	}
>  	put_gh_rm(ghvm->rm);
>  	kfree(ghvm);
>  	return 0;

[snip]

> +struct gunyah_vm_memory_mapping {
> +	struct list_head list;
> +	enum gunyah_vm_mem_share_type share_type;
> +	struct gh_rm_mem_parcel parcel;
> +
> +	__u64 guest_phys_addr;
> +	__u32 mem_size;

'gh_userspace_memory_region' allows 64-bit mem_size, so perhaps make it 64-bit
here as well?

> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
> +							struct gh_userspace_memory_region *region)
> +{
> +	phys_addr_t curr_page, prev_page;
> +	struct gunyah_vm_memory_mapping *mapping, *tmp_mapping;
> +	struct gh_rm_mem_entry *mem_entries;
> +	int i, j, pinned, ret = 0;
> +	struct gh_rm_mem_parcel *parcel;
> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr))
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	mapping = __gh_vm_mem_mapping_find(ghvm, region->label);
> +	if (mapping) {
> +		ret = -EEXIST;
> +		goto unlock;

We should avoid kfree(mapping) in this case?

> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	mapping->parcel.label = region->label;
> +	mapping->guest_phys_addr = region->guest_phys_addr;
> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
> +	parcel = &mapping->parcel;
> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +	/* Check for overlap */
> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
> +			tmp_mapping->guest_phys_addr) ||
> +			(mapping->guest_phys_addr >=
> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
> +			ret = -EEXIST;
> +			goto unlock;
> +		}
> +	}
> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);

I think we need to either avoid adding to the list this early (until all steps
below are successfull) or maintain some additional state in 'mapping' to
indicate that its work in progress. Consider the race condition for example when
multiple threads call SET_USER_MEM_REGION ioctl on same label (one with size > 0
and other with size = 0), which can lead to unpleasant outcome AFAICS.

> +unlock:
> +	mutex_unlock(&ghvm->mm_lock);
> +	if (ret)
> +		goto free_mapping;
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		goto reclaim;

Can you check this error path? We seem to call unpin_user_page() in this path,
which is not correct.

> +	}
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
> +		goto reclaim;

Same comment as above

> +	parcel->acl_entries[0].vmid = ghvm->vmid;

cpu_to_le() wrapper missing here and few other places in this function. Pls check.

