Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58376E54E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQW5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDQW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:57:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256940FB;
        Mon, 17 Apr 2023 15:57:30 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HM2MwT007875;
        Mon, 17 Apr 2023 22:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TYiYTf71z2QgKJBu/vBOofEjUIMRz93Rtu7+eYyDuHM=;
 b=BjYy4y4hlgTnSr+4IwhM8QQfNv+eBf0I58/MJqGD8gZ6NwHIQb3h7TQV7k5m+JNrYjoG
 aUkn3nZgOgBQ71imRbDZ4s3FbLVugjMVg4fTqvlqX+YGxKL4eMNduKQ5BNgzFO+hOkI5
 s/nA+IBaQF2eBGpEz+1qj5KpH4Hs6kAReD7KxfUJBd3NrxfVvu88zCKdIcQbl0H/jEw5
 HCS438ghoUnvWwYOSWwtEJQSiQySgAyN+znoUmy0zlf24QGcWrCi7z8NBNay1uA1yoaV
 be2eoE+z8Z3sviGiEBbovMNzTrwqlEJAIgziwOtE6EgRLaMqeNEr7Ac/lz2zTwazx3S4 vw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q19kg0phr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:57:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HMvHfQ026364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:57:17 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 15:57:16 -0700
Message-ID: <fb6bd0fe-96a0-ac66-31c3-88e61cddcdca@quicinc.com>
Date:   Mon, 17 Apr 2023 15:57:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 20/26] virt: gunyah: Add resource tickets
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
 <20230304010632.2127470-21-quic_eberman@quicinc.com>
 <dd56d297-2483-5b7d-4c63-fd103070af5c@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <dd56d297-2483-5b7d-4c63-fd103070af5c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pQIDRNy4YdHcA9erZIuWQwlbO6_BTI_7
X-Proofpoint-ORIG-GUID: pQIDRNy4YdHcA9erZIuWQwlbO6_BTI_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170202
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:27 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> Some VM functions need to acquire Gunyah resources. For instance, Gunyah
>> vCPUs are exposed to the host as a resource. The Gunyah vCPU function
>> will register a resource ticket and be able to interact with the
>> hypervisor once the resource ticket is filled.
>>
>> Resource tickets are the mechanism for functions to acquire ownership of
>> Gunyah resources. Gunyah functions can be created before the VM's
>> resources are created and made available to Linux. A resource ticket
>> identifies a type of resource and a label of a resource which the ticket
>> holder is interested in.
>>
>> Resources are created by Gunyah as configured in the VM's devicetree
>> configuration. Gunyah doesn't process the label and that makes it
>> possible for userspace to create multiple resources with the same label.
>> Resource ticket owners need to be prepared for populate to be called
>> multiple times if userspace created multiple resources with the same
>> label.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> One possibly substantive suggestion here, plus a couple suggestions
> to add or revise comments.
> 
>                      -Alex
> 
>> ---
>>   drivers/virt/gunyah/vm_mgr.c  | 112 +++++++++++++++++++++++++++++++++-
>>   drivers/virt/gunyah/vm_mgr.h  |   4 ++
>>   include/linux/gunyah_vm_mgr.h |  14 +++++
>>   3 files changed, 129 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
>> index 88db011395ec..0269bcdaf692 100644
>> --- a/drivers/virt/gunyah/vm_mgr.c
>> +++ b/drivers/virt/gunyah/vm_mgr.c
>> @@ -165,6 +165,74 @@ static long gh_vm_rm_function(struct gh_vm *ghvm, 
>> struct gh_fn_desc *f)
>>       return r;
>>   }
>> +int gh_vm_add_resource_ticket(struct gh_vm *ghvm, struct 
>> gh_vm_resource_ticket *ticket)
>> +{
>> +    struct gh_vm_resource_ticket *iter;
>> +    struct gh_resource *ghrsc;
>> +    int ret = 0;
>> +
>> +    mutex_lock(&ghvm->resources_lock);
>> +    list_for_each_entry(iter, &ghvm->resource_tickets, list) {
>> +        if (iter->resource_type == ticket->resource_type && 
>> iter->label == ticket->label) {
>> +            ret = -EEXIST;
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    if (!try_module_get(ticket->owner)) {
>> +        ret = -ENODEV;
>> +        goto out;
>> +    }
>> +
>> +    list_add(&ticket->list, &ghvm->resource_tickets);
>> +    INIT_LIST_HEAD(&ticket->resources);
>> +
>> +    list_for_each_entry(ghrsc, &ghvm->resources, list) {
>> +        if (ghrsc->type == ticket->resource_type && ghrsc->rm_label 
>> == ticket->label) {
>> +            if (!ticket->populate(ticket, ghrsc))
>> +                list_move(&ghrsc->list, &ticket->resources);
>> +        }
>> +    }
>> +out:
>> +    mutex_unlock(&ghvm->resources_lock);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_add_resource_ticket);
>> +
>> +void gh_vm_remove_resource_ticket(struct gh_vm *ghvm, struct 
>> gh_vm_resource_ticket *ticket)
>> +{
>> +    struct gh_resource *ghrsc, *iter;
>> +
>> +    mutex_lock(&ghvm->resources_lock);
>> +    list_for_each_entry_safe(ghrsc, iter, &ticket->resources, list) {
>> +        ticket->unpopulate(ticket, ghrsc);
>> +        list_move(&ghrsc->list, &ghvm->resources);
>> +    }
>> +
>> +    module_put(ticket->owner);
>> +    list_del(&ticket->list);
>> +    mutex_unlock(&ghvm->resources_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_vm_remove_resource_ticket);
>> +
>> +static void gh_vm_add_resource(struct gh_vm *ghvm, struct gh_resource 
>> *ghrsc)
>> +{
>> +    struct gh_vm_resource_ticket *ticket;
>> +
>> +    mutex_lock(&ghvm->resources_lock);
>> +    list_for_each_entry(ticket, &ghvm->resource_tickets, list) {
>> +        if (ghrsc->type == ticket->resource_type && ghrsc->rm_label 
>> == ticket->label) {
>> +            if (!ticket->populate(ticket, ghrsc)) {
>> +                list_add(&ghrsc->list, &ticket->resources);
>> +                goto found;
>> +            }
> 
> I think the "goto found" belongs here, unconditionally.
> You disallow adding more than one ticket of a given type
> with the same label.  So you will never match another
> ticket once you've matched this one.
> 
> The populate function generally shouldn't fail.  I think
> it only fails if you find a duplicate, and again, I think
> you prevent that from happening.  (But if it does, you
> silently ignore it...)
> 

I agree with this suggestion, no need to waste continue checking other 
tickets once we find the match. I'll move the "goto found" line.

[snip]

Thanks,
Elliot
