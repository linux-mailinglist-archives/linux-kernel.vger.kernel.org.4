Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08695699B19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBPRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBPRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:18:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342C4C3F1;
        Thu, 16 Feb 2023 09:18:33 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GArWmU013797;
        Thu, 16 Feb 2023 17:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=065Xd7//5pM+MBjAeMGCDbNIHvUuqvLOuk8VwXjjjDI=;
 b=P6LYdkhaASC7CRP/KQ/fiB9OrGmv6kinIxNTsaYCb8Fc7ZIfnlJ5h3ISMVIlXci+U+2J
 tFoq/W/PSSOAN6NM1DktRV/2UmAM61d7a+0rHoC2jVJNGYveRCFZUX5Oa/LTVOXLpSGF
 GHBKyOfY4qexmbUyrGmjL9fFWw+9NFhR2De5H10SAKgPziqU+EwI6MHfoYDknVlxPygt
 SKgLqiw0odsPxveqk0ivVvhYOborkePH5CVC6ZvBi69BoUSsRuaMOZb1lnMg7s4nSsck
 7mb+2fYWMdyLiGhz5r4GNtuYDPm1cNa9PxAZb20cg5lpWOiaq7ni4qLrfTbWAKdY8wM3 mQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsja913vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:18:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GHIF20030402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:18:15 GMT
Received: from [10.110.95.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 09:18:14 -0800
Message-ID: <f273f9c6-7a6f-f451-4afa-eaea303613d9@quicinc.com>
Date:   Thu, 16 Feb 2023 09:18:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212343.3311875-1-quic_eberman@quicinc.com>
 <Y+3PvUqkC2YJaW5o@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y+3PvUqkC2YJaW5o@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vGZA4yzQKNvoP32q0R7fM1y6uxNK5uUT
X-Proofpoint-ORIG-GUID: vGZA4yzQKNvoP32q0R7fM1y6uxNK5uUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160150
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 10:39 PM, Greg Kroah-Hartman wrote:
> On Tue, Feb 14, 2023 at 01:23:42PM -0800, Elliot Berman wrote:
>>
>> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile      |   2 +-
>>   drivers/virt/gunyah/rsc_mgr.h     |  45 ++++++
>>   drivers/virt/gunyah/rsc_mgr_rpc.c | 226 ++++++++++++++++++++++++++++++
>>   include/linux/gunyah_rsc_mgr.h    |  73 ++++++++++
>>   4 files changed, 345 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
>>
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index cc864ff5abbb..de29769f2f3f 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -2,5 +2,5 @@
>>   
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>>   
>> -gunyah_rsc_mgr-y += rsc_mgr.o
>> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
>>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
>> index d4e799a7526f..7406237bc66d 100644
>> --- a/drivers/virt/gunyah/rsc_mgr.h
>> +++ b/drivers/virt/gunyah/rsc_mgr.h
>> @@ -74,4 +74,49 @@ struct gh_rm;
>>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>>   		void **resp_buf, size_t *resp_buff_size);
>>   
>> +/* Message IDs: VM Management */
>> +#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
>> +#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
>> +#define GH_RM_RPC_VM_START			0x56000004
>> +#define GH_RM_RPC_VM_STOP			0x56000005
>> +#define GH_RM_RPC_VM_RESET			0x56000006
>> +#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
>> +#define GH_RM_RPC_VM_INIT			0x5600000B
>> +#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
>> +#define GH_RM_RPC_VM_GET_VMID			0x56000024
>> +
>> +struct gh_rm_vm_common_vmid_req {
>> +	__le16 vmid;
>> +	__le16 reserved0;
> 
> reserved for what?  What is a valid value for this field?  Should it be
> checked for 0?

This struct is transmitted "over the wire" and RM makes all of its 
structures 4-byte aligned. The reserved fields are padding for this 
alignment and will be zero but don't need to be checked. Linux 
initializes the reserved fields to zero.

> 
> Same with other "reserved0" fields in this file.
> 
> 
>> +} __packed;
>> +
>> +/* Call: VM_ALLOC */
>> +struct gh_rm_vm_alloc_vmid_resp {
>> +	__le16 vmid;
>> +	__le16 reserved0;
>> +} __packed;
>> +
>> +/* Call: VM_STOP */
>> +struct gh_rm_vm_stop_req {
>> +	__le16 vmid;
>> +#define GH_RM_VM_STOP_FLAG_FORCE_STOP	BIT(0)
>> +	u8 flags;
>> +	u8 reserved;
> 
> Why just "reserved" and not "reserved0"?  Naming is hard :(
> 

Some fields have multiple reserved fields. I'll clean up so "reserved0" 
only appears when there are multiple padding fields.

Thanks,
Elliot
