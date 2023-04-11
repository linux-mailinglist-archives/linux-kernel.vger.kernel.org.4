Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDCB6DE645
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjDKVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDKVQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:16:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2067630D0;
        Tue, 11 Apr 2023 14:16:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLFJRk026861;
        Tue, 11 Apr 2023 21:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AqeZXbDuPPU1NM2ef0P3QOYcGlcGpgGNd5YIz4wkf1I=;
 b=H5j4l0Am9Wn/nx1e4cbCGRftsLRN64BNTWjIb+7ZaCZ+xCPH6MJG89vWIMPJRkL9WrlM
 ECy0bvvVa8DVPsdKiixDGVtBT+0YZzyfVhFp2YKOZb1aFQM6SnhRVh+B/b8oyWrYobr5
 oxGfhCE5MxqyVyDGURmO8Z9M76ncqsg864RuLDXVx3FAiYhqt4MsuXdl/rBVFcz54DDC
 LjZjMdtEfOw2Kt9QlfdRmXZFn3tabbbIiesVS7Q+cIuitxsHnJGDEaPbq8lTMyw6s2gZ
 4dDsfkktEx1jDHazFb3XVKn55fastipPJ2kTPDPXzj/qqC2xQP/ATY/0MfAQCq7T0EPR Rw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvvux2fh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 21:16:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BLGTji029549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 21:16:29 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 14:16:28 -0700
Message-ID: <d736d53b-e289-85ca-ee78-e1f77ccc08c6@quicinc.com>
Date:   Tue, 11 Apr 2023 14:16:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
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
 <20230304010632.2127470-14-quic_eberman@quicinc.com>
 <3271fdf5-57cd-d962-fd20-01f5a5447232@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <3271fdf5-57cd-d962-fd20-01f5a5447232@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PEYH6DlHNqcFCXzBIrr2VFnKQTkQ-SKy
X-Proofpoint-ORIG-GUID: PEYH6DlHNqcFCXzBIrr2VFnKQTkQ-SKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_14,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110191
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:26 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> index 88a429dad09e..8b0b46f28e39 100644
>> --- a/include/linux/gunyah_rsc_mgr.h
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -29,6 +29,12 @@ struct gh_rm_vm_exited_payload {
>>   #define GH_RM_NOTIFICATION_VM_EXITED         0x56100001
>>   enum gh_rm_vm_status {
>> +    /**
>> +     * RM doesn't have a state where load partially failed because
>> +     * only Linux
> 
> I have no idea what the comment above means...  Please fix.
> 
> Several of the values below are never explicitly assigned,
> and some are used but not assigned.  The others apparently
> might come back from the resource manager?  Why, for
> example, are the PAUSED, AUTH, and RESETTING statuses
> defined if we don't use them?
> 

I ended up no longer needing VM_STATUS_LOAD_FAILED.

The other status values are defined by Gunyah resource manager. RM will 
notify us about the state transitions.

Some of the state transitions can be inferred by Linux directly. For 
instance, gh_rm_vm_init() will transition the VM from 
GH_RM_VM_STATUS_INIT to GH_RM_VM_STATUS_READY iff it returns 
successfully. There is one instance where we wait for VM to exit during 
the VM teardown as well.

Thanks,
Elliot

>> +     */
>> +    GH_RM_VM_STATUS_LOAD_FAILED    = -1,
>> +
>>       GH_RM_VM_STATUS_NO_STATE    = 0,
>>       GH_RM_VM_STATUS_INIT        = 1,
>>       GH_RM_VM_STATUS_READY        = 2,
>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>> index a19207e3e065..d6abd8605a2e 100644
>> --- a/include/uapi/linux/gunyah.h
>> +++ b/include/uapi/linux/gunyah.h
>> @@ -49,4 +49,17 @@ struct gh_userspace_memory_region {
>>   #define GH_VM_SET_USER_MEM_REGION    _IOW(GH_IOCTL_TYPE, 0x1, \
>>                           struct gh_userspace_memory_region)
>> +/**
>> + * struct gh_vm_dtb_config - Set the location of the VM's devicetree 
>> blob
>> + * @guest_phys_addr: Address of the VM's devicetree in guest memory.
>> + * @size: Maximum size of the devicetree.
>> + */
>> +struct gh_vm_dtb_config {
>> +    __u64 guest_phys_addr;
>> +    __u64 size;
>> +};
>> +#define GH_VM_SET_DTB_CONFIG    _IOW(GH_IOCTL_TYPE, 0x2, struct 
>> gh_vm_dtb_config)
>> +
>> +#define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>> +
>>   #endif
> 
