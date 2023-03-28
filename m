Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BD6CBB37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC1JjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjC1JjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:39:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1C5B99
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:39:08 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S8TEUN024888;
        Tue, 28 Mar 2023 11:38:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OYiJ//G5VBRLV8o+Mq0MH5geZvdUpWk4yWOPx1fr6wY=;
 b=FViwJHg88F706F2Xm2584pc0apTKG8Lwk7DEyTKg0t+GCkBBZC1q1byehgjuhDB3kWNy
 BRamH0hv0rw3pKM8FgUMWp+E8HvXTqrdbFg7/3Oc1RZqnDw2/XKifLQURRCrzlY7YI7L
 V+ZPuYOkS4hQ2lnUOTB2+hlM9XIq16yKXWAAmBRv0OdUF7IrEolqL2AjPoJH427jPpCo
 HuUeXZzoicYb1t+u9LC7wMzU7wMOvFMFLZqa+0wpzvcsrz0xPBAvklnn+bG38H8anPkW
 YkCG3LYbeXj5/pgx9vaHRSdIKg3/BhnyRauGpGBxQI0XNLjhNqszZvJlA0w8i4fwVqTp Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkvs4rhgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:38:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1855310002A;
        Tue, 28 Mar 2023 11:38:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 112BE21160E;
        Tue, 28 Mar 2023 11:38:55 +0200 (CEST)
Received: from [10.48.0.175] (10.48.0.175) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 11:38:54 +0200
Message-ID: <4fa90fd4-c8c3-6621-4aed-51f916fbddc8@foss.st.com>
Date:   Tue, 28 Mar 2023 11:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] mtd: rawnand: stm32_fmc2: use timings.mode instead
 of checking tRC_min
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@linaro.org>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
 <20230327094742.38856-3-christophe.kerello@foss.st.com>
 <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
 <20230327124313.1ccd3d66@xps-13>
 <70d0a8b6-62c2-fa3e-df5c-f86ba75484d0@linaro.org>
 <6759a843-409b-d9fe-8a00-ed6d69144aaf@foss.st.com>
 <20230328095633.188aff27@xps-13>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20230328095633.188aff27@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 3/28/23 09:56, Miquel Raynal wrote:
> Hi Christophe,
> 
> christophe.kerello@foss.st.com wrote on Tue, 28 Mar 2023 09:27:55 +0200:
> 
>> Hello Miquel,
>>
>> On 3/27/23 13:06, Tudor Ambarus wrote:
>>>
>>>
>>> On 3/27/23 11:43, Miquel Raynal wrote:
>>>> Hi Tudor,
>>>>
>>>> tudor.ambarus@linaro.org wrote on Mon, 27 Mar 2023 11:30:51 +0100:
>>>>   
>>>>> On 3/27/23 10:47, Christophe Kerello wrote:
>>>>>> This patch is using timings.mode value instead of checking tRC_min timing
>>>>>> for EDO mode support.
>>>>>>     >>>
>>>>> Fixes and Cc to stable here too, as you'd like to have this backported
>>>>> as well, don't you?
>>>>
>>>> Actually the reason why Christophe split this into two patches is
>>>> because timings.mode was introduced rather lately, he wanted the same
>>>> patch to apply on all stable kernels, he actually asked for that split
>>>> and I agreed (another solution would have been to send this current
>>>> patch to Linus and have the other version sent to stable, but it
>>>> requires a bit of scheduling on both ends).
>>>>
>>>> Link: https://lore.kernel.org/linux-mtd/20230327101156.0ec2816a@xps-13/T/#t
>>>
>>> Right, I understood that from the beginning. If it were to me, I would
>>> Cc: stable@vger.kernel.org #v5.4+ for the first patch and
>>> Cc: stable@vger.kernel.org #v5.10+ for the second.
>>>
>>> So first would be alone just in v5.4, and starting with v5.10 we'll have
>>> both and we'll mimic what we currently have in upstream mainline.
>>>    
>>
>> I can send a V3 with cc tag added as per Tudor's suggestion.
>> Or cc tag will be added when the patches will be applied?
> 
> I'll handle it, no problem. Is it fine if I send this as part of the
> next merge window or do you expect this fix to be applied earlier? I
> just sent my fixes PR on Monday morning.
> 

Yes, it is fine. This patch set can be applied on next merge window.

Regards,
Christophe Kerello.

>>
>> Regards,
>> Christophe Kerello.
>>
>>>>   
>>>>>   
>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>>>>
>>>>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>>>   
>>>>>> ---
>>>>>>    drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>>>> index 3abb63d00a0b..9e74bcd90aaa 100644
>>>>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>>>> @@ -1531,7 +1531,7 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>>>>>>    	if (IS_ERR(sdrt))
>>>>>>    		return PTR_ERR(sdrt);
>>>>>>    >>>> -	if (sdrt->tRC_min < 30000)
>>>>>> +	if (conf->timings.mode > 3)
>>>>>>    		return -EOPNOTSUPP;
>>>>>>    >>>>   	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>>>>
>>>>
>>>> Thanks,
>>>> Miquèl
> 
> 
> Thanks,
> Miquèl
