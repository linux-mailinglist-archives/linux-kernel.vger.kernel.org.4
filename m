Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9316C9D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjC0ICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjC0ICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:02:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF61421C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:02:47 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R6sWV4013750;
        Mon, 27 Mar 2023 10:02:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=8SOh+0CZP8Ph/v0q/dPQLROo4mWgelJIRrYo46gyeXw=;
 b=Whce/u/tZ96+3XJoc3pFU2ncJhNj2fofHNy3trM2ByPAayNltmwndj5UbiTugaO5KhCU
 Z9odsqiDCDgqLUiKufHNu/ThRwb00J4RLZu/nC8+KsE9uav3mv8evTPKsJTaE0F5aZVx
 58mvTYN/7EeE/hL+Saf9d2Af2Q2qmuHmM5lQA3D83F427VXh9HHfsVSCp7kuhuXV8qO3
 WGTyQKsX0PprWLllH4+srQmDtL7kz102ElDknqTQizpM9K6lVyFayrg/MKlLKQ9Janv0
 +lZL+Ttz4g5sLcIHKXJOclnXFQpbdA+5/66TTr87sz+vV4VzBYSYDY3ojAoDxHqaVdu1 fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsqw911s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:02:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C992510003A;
        Mon, 27 Mar 2023 10:02:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A50352115E2;
        Mon, 27 Mar 2023 10:02:14 +0200 (CEST)
Received: from [10.48.0.175] (10.48.0.175) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 27 Mar
 2023 10:02:14 +0200
Message-ID: <fcb600af-88dc-55a7-917e-4cf4673c2973@foss.st.com>
Date:   Mon, 27 Mar 2023 10:02:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: do not support EDO mode
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230324160918.826452-1-christophe.kerello@foss.st.com>
 <20230324172528.4d3ccd4b@xps-13>
 <f4c32aa5-e5b1-6465-7708-ef0281baf0af@foss.st.com>
Content-Language: en-US
In-Reply-To: <f4c32aa5-e5b1-6465-7708-ef0281baf0af@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquel,

On 3/24/23 17:34, Christophe Kerello wrote:
> Hello Miquel,
> 
> On 3/24/23 17:25, Miquel Raynal wrote:
>> Hi Christophe,
>>
>> christophe.kerello@foss.st.com wrote on Fri, 24 Mar 2023 17:09:18 +0100:
>>
>>> FMC2 controller does not support EDO mode (timings mode 4 and 5).
>>>
>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND 
>>> flash controller driver")
>>> ---
>>>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c 
>>> b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>> index 5d627048c420..3abb63d00a0b 100644
>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>> @@ -1531,6 +1531,9 @@ static int 
>>> stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>>>       if (IS_ERR(sdrt))
>>>           return PTR_ERR(sdrt);
>>> +    if (sdrt->tRC_min < 30000)
>>
>> When introducing NV-DDR support we as well added a timings.mode field,
>> perhaps you could use it?
> 
> Yes, I can use it. It will be done in V2.
> 
> Regards,
> Christophe Kerello.
> 

I had a look at Kernel LTS, and timings.mode was introduced on Kernel 
LTS 5.10. As this patch has also to be applied on Kernel LTS 5.4, my 
proposal is to send a new patch set. The first patch will be the current 
patch (fix for all Kernel LTS) and the second patch will use 
timings.mode instead of checking tRC_min timings for next Kernel 
delivery. Is this proposal acceptable?

Regards,
Christophe Kerello.

>>
>>> +        return -EOPNOTSUPP;
>>> +
>>>       if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>>>           return 0;
>>
>>
>> Thanks,
>> Miquèl
