Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B39681D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjA3Vqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjA3Vqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:46:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38DA4996D;
        Mon, 30 Jan 2023 13:46:44 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UKxEiv005232;
        Mon, 30 Jan 2023 21:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s/98MwVcL38UIsZzsytvTp8dsTQvjFf4DXmZcFk5S+U=;
 b=PmX3xWP98oz/HCRjxw+iBKIzjsXsKHyuxf+dOjonidaMDRaqEY6a2Yf7wscHb2cdXpCc
 dU6Lu4Bxac9vCBepnbO+YkfRPV9HOMAbmV6e2ia9iJtMZdpnmJV4jI2dvBpjxF/k/Zev
 /aZjwQZFm59oCBJryguzzAwp1D12gbs7AHRAYDQdl9YVL71ROBeIhtr7YvD+y8rAkn1j
 YPQaTzuyZ1Uae55A71kC/fRvjfxmfbcs4cIvNvM0Yrw2/aJQ7jNuckiIrkS2B4QGKtjY
 z3dyBu/Fb+XXDMlyLy97ZzIeZmU5XIzkbxfCl/mU9WGHQH86MU7OtwuPoi/lfG5sy9Ol ng== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncut2n2fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:46:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULkV8W017131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:46:31 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 13:46:31 -0800
Message-ID: <c64ee823-33bd-1b89-0f17-4e73901ab40d@quicinc.com>
Date:   Mon, 30 Jan 2023 13:46:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 13/27] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-14-quic_eberman@quicinc.com>
 <20230125133424.GA332@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230125133424.GA332@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fqnEkPeUjsUKnmNLhO8oAmGwD9z7K8UP
X-Proofpoint-ORIG-GUID: fqnEkPeUjsUKnmNLhO8oAmGwD9z7K8UP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=722 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300201
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 5:34 AM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:12]:
> 
>> +	/* Check for overlap */
>> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
>> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
>> +			tmp_mapping->guest_phys_addr) ||
>> +			(mapping->guest_phys_addr >=
>> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
>> +			ret = -EEXIST;
>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	list_add(&mapping->list, &ghvm->memory_mappings);
> 
> I think the potential race condition described last time is still possible. Pls
> check.
> 
>> +unlock:
>> +	mutex_unlock(&ghvm->mm_lock);
>> +	if (ret)
>> +		goto free_mapping;
>> +
>> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
>> +	if (!mapping->pages) {
>> +		ret = -ENOMEM;
>> +		goto reclaim;
> 
> Same comment as last time. Can you check this error path? We seem to call
> unpin_user_page() in this path, which is not correct.
> 
>> +	}
>> +
>> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
>> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
>> +	if (pinned < 0) {
>> +		ret = pinned;
>> +		goto reclaim;
> 
> Same comment as above.
> 

Caught the race condition you are describing between adding and removing 
the memory parcels. Should be fixed for v10.

- Elliot
