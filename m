Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66D6C44CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCVIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCVIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:22:19 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615BD5D255;
        Wed, 22 Mar 2023 01:22:18 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M4dEVn012467;
        Wed, 22 Mar 2023 09:21:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oWRoobCUf6mgMbXtM7QML+mXsPQj3dwmibLtZAppDpc=;
 b=1mGUtC7cfwlxfaoNdgCVxJv3T2QY5gZrFqXzS4LbFEqqY6KzbQvnSkdHjpefY7761lMX
 QQiLPh9pN7vUYlwHNyT39kwFslES2gwx3Ys1tYgcgX7tjAkXkGacstlINnRFvZF6m6Gx
 B8Q5pHn9oQrTaABAEy0/mSpmYFDbk8Muv6kEJ7y2U78pE7ofWR/J0oXZ8OGdOPwPbzwx
 cP76JRBRSbZcs0ypoG3fEEhIXSXp2SJeEe3JyvXOww8PeptcksjJlB9OpGCvN6Xupeeo
 HMiykvyu2P/TOxfktXm4bZGhMYOtyujDJO6J7+Sf4OdOJigjAzcDWR2zRyBH2irwa0p+ sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pf875yw7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:21:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 173F4100038;
        Wed, 22 Mar 2023 09:21:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0FE9B20E1FC;
        Wed, 22 Mar 2023 09:21:17 +0100 (CET)
Received: from [10.201.22.135] (10.201.22.135) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Mar
 2023 09:21:15 +0100
Message-ID: <104da4a2-a099-666e-b821-e8efe0901ce8@foss.st.com>
Date:   Wed, 22 Mar 2023 09:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] remoteproc: stm32: Call of_node_put() on iteration
 error
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <andersson@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <patrice.chotard@foss.st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <arnaud.pouliquen@st.com>,
        <hongxing.zhu@nxp.com>, <peng.fan@nxp.com>,
        <shengjiu.wang@nxp.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
 <20230320221826.2728078-2-mathieu.poirier@linaro.org>
 <e3644e19-7453-440b-00dc-781104ca83cf@foss.st.com>
 <20230321213250.GB2782856@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230321213250.GB2782856@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.135]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 22:32, Mathieu Poirier wrote:
> On Tue, Mar 21, 2023 at 10:00:03AM +0100, Arnaud POULIQUEN wrote:
>> Hi Mathieu,
>>
>> On 3/20/23 23:18, Mathieu Poirier wrote:
>>> Function of_phandle_iterator_next() calls of_node_put() on the last
>>> device_node it iterated over, but when the loop exits prematurely it has
>>> to be called explicitly> 
>>> Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>  drivers/remoteproc/stm32_rproc.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>>> index 7d782ed9e589..23c1690b8d73 100644
>>> --- a/drivers/remoteproc/stm32_rproc.c
>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>> @@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>>>  	while (of_phandle_iterator_next(&it) == 0) {
>>>  		rmem = of_reserved_mem_lookup(it.node);
>>>  		if (!rmem) {
>>> +			of_node_put(it.node);
>>>  			dev_err(dev, "unable to acquire memory-region\n");
>>>  			return -EINVAL;
>>>  		}
>>>  
>>>  		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
>>> +			of_node_put(it.node);
>>>  			dev_err(dev, "memory region not valid %pa\n",
>>>  				&rmem->base);
>>>  			return -EINVAL;
>>> @@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
>>>  							   it.node->name);
>>>  		}
>>>  
>>> -		if (!mem)
>>> +		if (!mem) {
>>> +			of_node_put(it.node);
>>>  			return -ENOMEM;
>>> +		}
>>
>> Good catch!
>>
>> Looking in code I don't see that we call of_node_put() when we release the
>> carveouts. 
>> Please tell me if I'm wrong but look to me that we should also call of_node_put()
>> in mem->release() op, in drivers. 
>>
> 
> Are you referring to entry->release(), which for stm32 is
> stm32_rproc_mem_release(), in rproc_resource_cleanup()?
> 
> If so then no, it is not needed since of_phandle_iterator_next() calls
> of_node_put() on the previous device_node with each iteration.
> 
> Otherwise I fail to understand the question and will ask you to clarify.

My apologize, I misread the of_phandle_iterator_next function. you can forget my
comment.

Regards,
Arnaud

> 
>> This one remains valid.
>> reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>
> 
> Ok
> 
>> Thanks,
>> Arnaud
>>
>>
>>>  
>>>  		rproc_add_carveout(rproc, mem);
>>>  		index++;
