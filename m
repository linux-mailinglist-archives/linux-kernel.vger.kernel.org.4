Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F75F8A2C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJIIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJIIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:38:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F82D1F2;
        Sun,  9 Oct 2022 01:38:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mlb2c3ZRQzpVck;
        Sun,  9 Oct 2022 16:35:04 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 16:38:12 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 16:38:11 +0800
Subject: Re: [PATCH -next 1/3] remoteproc: qcom: wcss: check return value
 after calling platform_get_resource_byname()
To:     <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>, <bjorn.andersson@linaro.org>
References: <20220826014511.2270433-1-yangyingliang@huawei.com>
 <63f86e67-23ce-0c53-e2dd-d7937584508b@quicinc.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <31e30a15-d48e-e900-2842-34f2b87c57a8@huawei.com>
Date:   Sun, 9 Oct 2022 16:38:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <63f86e67-23ce-0c53-e2dd-d7937584508b@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Are these patches good for merge or any more suggestion ?

Thanks,
Yang
On 2022/8/26 13:33, Mukesh Ojha wrote:
>
>
> On 8/26/2022 7:15 AM, Yang Yingliang wrote:
>> If platform_get_resource_byname() fails, 'res' will be set to null 
>> pointer,
>> it will cause null-ptr-deref when it used in devm_ioremap(), so we 
>> need check
>> the return value.
>>
>> Fixes: 0af65b9b915e ("remoteproc: qcom: wcss: Add non pas wcss Q6 
>> support for QCS404")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5_wcss.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c 
>> b/drivers/remoteproc/qcom_q6v5_wcss.c
>> index bb0947f7770e..017ee225dc32 100644
>> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
>> @@ -827,6 +827,8 @@ static int q6v5_wcss_init_mmio(struct q6v5_wcss 
>> *wcss,
>>       int ret;
>>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, 
>> "qdsp6");
>> +    if (!res)
>> +        return -EINVAL;
>
> LGTM.
>
> Reviewed-by:Mukesh Ojha <quic_mojha@quicinc.com>
>
> -Mukesh
>
>>       wcss->reg_base = devm_ioremap(&pdev->dev, res->start,
>>                         resource_size(res));
>>       if (!wcss->reg_base)
> .
