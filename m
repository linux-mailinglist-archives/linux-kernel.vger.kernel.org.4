Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45C1631BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKUItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKUItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:49:08 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB12233B6;
        Mon, 21 Nov 2022 00:49:06 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL6P494022120;
        Mon, 21 Nov 2022 09:48:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YN687U0kxELSCHXgysLfYlUDondN7TTlf1RFw+IfXPI=;
 b=QxieuqCz19jVxKrtPIJIwIMSIb6rtxG0/lssSSYcs+XcDYAdj0IFvDrm9GmCNednIdaj
 u4UnDhJsETw2RNIJqKMTF6ySSj+Ow0eWfPOYdKmGZqeeUQCs1aeoP/93VFQ2yXSuAtFR
 6Wvopp+g6LSorzmxCWN0rC+VrHB9ov09ksxzjKNd0GTTvDBiEiqz0R7uQfyFaXKbUV8M
 r1rmj0aGq/bmmXFjQasstpPBDynrHqAUxGiWNmFU6elnqEd+Bl+jMYlpU+sGdYEV2tN4
 sxgfX6pdA+jXa2+9uI+WTG8yPtwn7aZ/CkGBV21XEXRu6W4zPBYWMZ9TBVePWn+zVAxu Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kxrcgrwgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 09:48:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D27810003A;
        Mon, 21 Nov 2022 09:48:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3C5821515A;
        Mon, 21 Nov 2022 09:48:33 +0100 (CET)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 21 Nov
 2022 09:48:33 +0100
Message-ID: <7a4b85f9-8d23-57de-c09d-d586bf63fb3f@foss.st.com>
Date:   Mon, 21 Nov 2022 09:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Linux-stm32] [PATCH 00/16] STM32 configure UART nodes for DMA
Content-Language: en-US
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Erwan LE RAY <erwan.leray@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        Amelie DELAUNAY <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <cc7633c5-de5f-0abf-4ac8-64a74633dfcc@pengutronix.de>
 <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
 <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
 <20221108115916.hlmbvyrnmkxymeed@pengutronix.de>
 <230c26ea-f7c5-2688-16fd-e4a91f421833@denx.de>
 <28c5e508-6893-8ca3-88cc-487a98871722@foss.st.com>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <28c5e508-6893-8ca3-88cc-487a98871722@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_05,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

We found the issue, thank you to have reported it.

stm32-usart driver was not tolerant to a probe defer from DMA when the 
earlycon is active.

You can find the patch here:
https://lore.kernel.org/lkml/20221118170602.1057863-1-valentin.caron@foss.st.com/

Valentin

On 11/9/22 14:48, Amelie Delaunay wrote:
> On 11/8/22 16:28, Marek Vasut wrote:
>> On 11/8/22 12:59, Uwe Kleine-König wrote:
>>> On Fri, Feb 04, 2022 at 04:41:55PM +0100, Erwan LE RAY wrote:
>>>> On 2/4/22 2:22 PM, Alexandre TORGUE wrote:
>>>>> Hi Ahmad
>>>>>
>>>>> On 2/3/22 18:25, Ahmad Fatoum wrote:
>>>>>> Hello Erwan,
>>>>>>
>>>>>> On 03.02.22 18:10, Erwan Le Ray wrote:
>>>>>>> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
>>>>>>> remove it at board level to keep current PIO behavior when needed.
>>>>>>> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
>>>>>>> (no HW flow control pin available) are kept in PIO mode, while 
>>>>>>> USART3
>>>>>>> is now configured in DMA mode.
>>>>>>> UART4 (console UART) has to be kept in irq mode, as DMA support for
>>>>>>> console has been removed from the driver by commit e359b4411c28
>>>>>>> ("serial: stm32: fix threaded interrupt handling").
>>>>>>
>>>>>> Do I understand correctly that your first patch breaks consoles of
>>>>>> most/all boards, because they will briefly use DMA, which is refused
>>>>>> by the stm32-usart driver and then you add a patch for each board
>>>>>> to fix that breakage?
>>>>>
>>>>> We have two solutions and both have pro/drawbacks. The first one 
>>>>> (Erwan
>>>>> ones, can break the boot if the patch is taken "alone". Your 
>>>>> proposition
>>>>> avoids this breakage but deletes a non define property (which is a 
>>>>> bit
>>>>> weird). However I prefer to keep a functional behavior, and keep 
>>>>> Ahmad
>>>>> proposition. Ahmad, just one question, dt-bindings check doesn't
>>>>> complain about it ?
>>>>>
>>>>> Cheers
>>>>> Alex
>>>>>
>>>>>>
>>>>>> Such intermittent breakage makes bisection a hassle. 
>>>>>> /delete-property/
>>>>>> is a no-op when the property doesn't exist, so you could move the 
>>>>>> first
>>>>>> patch to the very end to avoid intermittent breakage.
>>>>>>
>>>>>> I also think that the driver's behavior is a bit harsh. I think 
>>>>>> it would
>>>>>> be better for the UART driver to print a warning and fall back to
>>>>>> PIO for console instead of outright refusing and rendering the 
>>>>>> system
>>>>>> silent. That's not mutually exclusive with your patch series here,
>>>>>> of course.
>>>>>>
>>>>>> Cheers,
>>>>>> Ahmad
>>>>>>
>>>>
>>>> The driver implementation will consider the request to probe the UART
>>>> console in DMA mode as an error (-ENODEV), and will fallback this 
>>>> UART probe
>>>> in irq mode.
>>>
>>>> Whatever the patch ordering, the boot will never be broken. The 
>>>> board dt
>>>> patches aim to get a "proper" implementation, but from functional
>>>> perspective the driver will manage a request to probe an UART 
>>>> console in DMA
>>>> mode as an error and fall it back in irq mode.
>>>
>>> I didn't debug this further yet, but my machine (with an out-of-tree
>>> dts) fails to boot 6.1-rc4 without removing the dma properties from the
>>> console UART. This is a bug isn't it? The same dts created a working
>>> setup with stm32mp157.dtsi from 5.15 + kernel 5.15.
>
> Hi Uwe,
>
> Could you confirm earlycon is enabled on your setup?
>
> Without earlycon, boot is ok, even with dma properties, at least on 
> stm32mp157c-dk2.
>
>>>
>>> I can debug this further, but maybe you know off-hand what the problem
>>> is?
>>
>> +CC Amelie, as this might be related to the DMA series that landed 
>> recently:
>>
>> $ git log --oneline v5.18..v6.0 -- drivers/dma/stm32*
>
> Hi Marek,
>
> We haven't yet investigated the issue, and if latest DMA updates could 
> explain why earlycon breaks the boot.
>
>
> +TO Valentin, as he's now in charge of UART driver.
> Valentin and I will investigate this issue.
>
> Regards,
> Amelie
