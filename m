Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA883615FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKBJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKBJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:34:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977201F9FF;
        Wed,  2 Nov 2022 02:34:34 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A29XOvg023051;
        Wed, 2 Nov 2022 09:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xvhHTRLinGK22kcrKek3TiAroXbx/H/5wcK4HwrMd74=;
 b=nK+iJOCNjqHpUyHUUv2wlbaLGlvkvDkvY2vQxfC/HbqsnLcCenFbmf+SWGoWUYHjl7tK
 4bOQtVcDIXvShqCui/68nEewW8V8vBpTzOgyGX9dlGXguwdwSpu6FMsBKtJd+c5AjX0W
 jEsokuvE9gEmQ3LB/drUBZcQdfnoPeaSAiGALQNuRARCxqfwm27K2g1N/MCzilrHt0Ga
 DZXdCDvxMYtpRqRy/6GmAXZj51pp+RXLoJA7zmKZU8FwFj2JCagY+L0gk9MWOkfNcc80
 VqMArJwCwvEjszk/mAqThlC6/WHfoBJ7Iwv0kEs60NaziqOnEWgaNVhK3qC4ZzU6x44d Qw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7nfhtj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:34:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A29YLdn028484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 09:34:21 GMT
Received: from [10.253.74.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 02:34:18 -0700
Message-ID: <03d7c51d-4c86-ecab-d775-0e677ac73770@quicinc.com>
Date:   Wed, 2 Nov 2022 17:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] stm class: Fix double add issue when store source_link
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220418114658.6491-1-quic_jinlmao@quicinc.com>
 <61028345-234b-6e5e-6bd5-e10165dbdf52@quicinc.com>
In-Reply-To: <61028345-234b-6e5e-6bd5-e10165dbdf52@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vaaZ_6CauvEKzhEQiyw9yBhjGm9U6LNP
X-Proofpoint-GUID: vaaZ_6CauvEKzhEQiyw9yBhjGm9U6LNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please help to review this patch.

Thanks

Jinlong Mao

On 5/16/2022 3:14 PM, Jinlong Mao wrote:
> Hi Reviewers,
>
> Could you please help to review this patch ?
>
> Thanks
>
> Jinlong Mao
>
> On 4/18/2022 7:46 PM, Mao Jinlong wrote:
>> If two threads store the same stm device to stm_source_link
>> at the same time when stm->link_list is empty, it is possible
>> that stm_source_link_add will be called for both of these two
>> threads. Then double add issue below will happen. Add mutex
>> lock for stm_source_link drop and stm_source_link add to avoid
>> this race condition.
>>
>> [ 12.386579][ T1024] list_add double add: new=ffffff87b73ebd90,
>> prev=ffffff87b73ebd90, next=ffffffc012737700.
>> [ 12.386657][ T1024] -----------[ cut here ]-----------
>> [ 12.386671][ T1024] kernel BUG at lib/list_debug.c:31!
>> [ 12.388845][ T1024] CPU: 2 PID: 1024 Comm: sh
>> [ 12.389162][ T1024] Call trace:
>> [ 12.389174][ T1024] __list_add_valid+0x68/0x98
>> [ 12.389199][ T1024] stm_source_link_store+0xcc/0x314 [stm_core]
>> [ 12.389213][ T1024] dev_attr_store+0x38/0x8c
>> [ 12.389228][ T1024] sysfs_kf_write+0xa0/0x100
>> [ 12.389239][ T1024] kernfs_fop_write_iter+0x1b0/0x2f8
>> [ 12.389253][ T1024] vfs_write+0x300/0x37c
>> [ 12.389264][ T1024] ksys_write+0x84/0x12c
>>
>> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/stm/core.c | 7 ++++++-
>>   drivers/hwtracing/stm/stm.h  | 1 +
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
>> index 2712e699ba08..e73ac961acb2 100644
>> --- a/drivers/hwtracing/stm/core.c
>> +++ b/drivers/hwtracing/stm/core.c
>> @@ -1171,11 +1171,14 @@ static ssize_t stm_source_link_store(struct 
>> device *dev,
>>       struct stm_device *link;
>>       int err;
>>   +    mutex_lock(&src->link_mutex);
>>       stm_source_link_drop(src);
>>         link = stm_find_device(buf);
>> -    if (!link)
>> +    if (!link) {
>> +        mutex_lock(&src->link_mutex);
>>           return -EINVAL;
>> +    }
>>         pm_runtime_get(&link->dev);
>>   @@ -1185,6 +1188,7 @@ static ssize_t stm_source_link_store(struct 
>> device *dev,
>>           /* matches the stm_find_device() above */
>>           stm_put_device(link);
>>       }
>> +    mutex_unlock(&src->link_mutex);
>>         return err ? : count;
>>   }
>> @@ -1251,6 +1255,7 @@ int stm_source_register_device(struct device 
>> *parent,
>>         stm_output_init(&src->output);
>>       spin_lock_init(&src->link_lock);
>> +    mutex_init(&src->link_mutex);
>>       INIT_LIST_HEAD(&src->link_entry);
>>       src->data = data;
>>       data->src = src;
>> diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
>> index a9be49fc7a6b..60b814cc00e0 100644
>> --- a/drivers/hwtracing/stm/stm.h
>> +++ b/drivers/hwtracing/stm/stm.h
>> @@ -79,6 +79,7 @@ void stm_put_device(struct stm_device *stm);
>>   struct stm_source_device {
>>       struct device        dev;
>>       struct stm_source_data    *data;
>> +    struct mutex        link_mutex;
>>       spinlock_t        link_lock;
>>       struct stm_device __rcu    *link;
>>       struct list_head    link_entry;
