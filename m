Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7AB6CB805
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjC1H2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1H2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:28:18 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7971999
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:28:16 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S7RoK2009859;
        Tue, 28 Mar 2023 09:27:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=tER8DK2g80BbazA5IW8lJic8DvTLqWiMH7DZgWU67KA=;
 b=LaSSkrgxKYR62xt2dSZVnmnYQylQRsr8RPrN9YToWUXC0eOeQ7J/ueRQfzuwAwfiRDjv
 Co3ADlYbfQSwtqySYkvpJk5g3bWVky5oAUxsgXNjBgtj4hWzEQUnpJ7LOdCL0F842ggo
 5EBufGbbpDcf7CP8iqopi/VFyDQnqEKkFqD5T1OelMVCr4tCyvuxB59kfK93tkFE/b5O
 /SB2fFOekZv2CSzKoSoBAZd9xeXUEdA57EitWrcitldESs/46iUJkXKx5eR0Z41OiwLl
 hLorusrlWkzoXigEIrAudgkIMITNOMpS4hTyetLYtJe90dEOKwh7/hQlav37zutwM82r 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsr5fydc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 09:27:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4B8A10002A;
        Tue, 28 Mar 2023 09:27:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9483020A76D;
        Tue, 28 Mar 2023 09:27:57 +0200 (CEST)
Received: from [10.48.0.175] (10.48.0.175) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 09:27:56 +0200
Message-ID: <6759a843-409b-d9fe-8a00-ed6d69144aaf@foss.st.com>
Date:   Tue, 28 Mar 2023 09:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] mtd: rawnand: stm32_fmc2: use timings.mode instead
 of checking tRC_min
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
 <20230327094742.38856-3-christophe.kerello@foss.st.com>
 <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
 <20230327124313.1ccd3d66@xps-13>
 <70d0a8b6-62c2-fa3e-df5c-f86ba75484d0@linaro.org>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <70d0a8b6-62c2-fa3e-df5c-f86ba75484d0@linaro.org>
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

Hello Miquel,

On 3/27/23 13:06, Tudor Ambarus wrote:
> 
> 
> On 3/27/23 11:43, Miquel Raynal wrote:
>> Hi Tudor,
>>
>> tudor.ambarus@linaro.org wrote on Mon, 27 Mar 2023 11:30:51 +0100:
>>
>>> On 3/27/23 10:47, Christophe Kerello wrote:
>>>> This patch is using timings.mode value instead of checking tRC_min timing
>>>> for EDO mode support.
>>>>    
>>>
>>> Fixes and Cc to stable here too, as you'd like to have this backported
>>> as well, don't you?
>>
>> Actually the reason why Christophe split this into two patches is
>> because timings.mode was introduced rather lately, he wanted the same
>> patch to apply on all stable kernels, he actually asked for that split
>> and I agreed (another solution would have been to send this current
>> patch to Linus and have the other version sent to stable, but it
>> requires a bit of scheduling on both ends).
>>
>> Link: https://lore.kernel.org/linux-mtd/20230327101156.0ec2816a@xps-13/T/#t
> 
> Right, I understood that from the beginning. If it were to me, I would
> Cc: stable@vger.kernel.org #v5.4+ for the first patch and
> Cc: stable@vger.kernel.org #v5.10+ for the second.
> 
> So first would be alone just in v5.4, and starting with v5.10 we'll have
> both and we'll mimic what we currently have in upstream mainline.
> 

I can send a V3 with cc tag added as per Tudor's suggestion.
Or cc tag will be added when the patches will be applied?

Regards,
Christophe Kerello.

>>
>>>
>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>>
>>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>
>>>> ---
>>>>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>> index 3abb63d00a0b..9e74bcd90aaa 100644
>>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>> @@ -1531,7 +1531,7 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>>>>   	if (IS_ERR(sdrt))
>>>>   		return PTR_ERR(sdrt);
>>>>   
>>>> -	if (sdrt->tRC_min < 30000)
>>>> +	if (conf->timings.mode > 3)
>>>>   		return -EOPNOTSUPP;
>>>>   
>>>>   	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>>
>>
>> Thanks,
>> Miquèl
