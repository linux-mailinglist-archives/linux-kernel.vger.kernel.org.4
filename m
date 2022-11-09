Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE00622CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKINs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKINs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:48:57 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D819018;
        Wed,  9 Nov 2022 05:48:55 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A99RCxn017326;
        Wed, 9 Nov 2022 14:48:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=cDrNqqmthMwVZI1g/vQ96k/RiQCKxZZG2VRCp6nzpqw=;
 b=6BZ1fJ2La0R0u7d3rx4HFZakt9dvd6oBdIiXrc4kRm1Zhz+wLJPszP+d4LeUwiBJp5PX
 bpdNyI+HWSiI0mRp9LPQJyEzQ4d5MAVLSBLe45p5DEcHQA6grMfhg1iNjRQJ6VNALYOk
 kl9g6cAPftadVDl6VTcme78aELqsHqAkNKuwyVRM0yS1P7QEWCu2BTGauEZtQBkqxYl7
 78NPTvk9g6jdKAfXr+vA+/AT3nCSwW35uqud/MU7rkd/TnjoBr2ZdKquizY1wkFbYUg1
 vR6JyzOhGPF8W0C3BF00oxaSkU189kmWBAyVTP6rHLwIUh33ytRDKzDsEC206YYmxQXp QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kq0aq87j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:48:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E884810002A;
        Wed,  9 Nov 2022 14:48:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0A9D21D382;
        Wed,  9 Nov 2022 14:48:20 +0100 (CET)
Received: from [10.252.23.187] (10.252.23.187) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Wed, 9 Nov
 2022 14:48:19 +0100
Message-ID: <28c5e508-6893-8ca3-88cc-487a98871722@foss.st.com>
Date:   Wed, 9 Nov 2022 14:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [Linux-stm32] [PATCH 00/16] STM32 configure UART nodes for DMA
To:     Marek Vasut <marex@denx.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Erwan LE RAY <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
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
Content-Language: en-US
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <230c26ea-f7c5-2688-16fd-e4a91f421833@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.23.187]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 16:28, Marek Vasut wrote:
> On 11/8/22 12:59, Uwe Kleine-König wrote:
>> On Fri, Feb 04, 2022 at 04:41:55PM +0100, Erwan LE RAY wrote:
>>> On 2/4/22 2:22 PM, Alexandre TORGUE wrote:
>>>> Hi Ahmad
>>>>
>>>> On 2/3/22 18:25, Ahmad Fatoum wrote:
>>>>> Hello Erwan,
>>>>>
>>>>> On 03.02.22 18:10, Erwan Le Ray wrote:
>>>>>> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
>>>>>> remove it at board level to keep current PIO behavior when needed.
>>>>>> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
>>>>>> (no HW flow control pin available) are kept in PIO mode, while USART3
>>>>>> is now configured in DMA mode.
>>>>>> UART4 (console UART) has to be kept in irq mode, as DMA support for
>>>>>> console has been removed from the driver by commit e359b4411c28
>>>>>> ("serial: stm32: fix threaded interrupt handling").
>>>>>
>>>>> Do I understand correctly that your first patch breaks consoles of
>>>>> most/all boards, because they will briefly use DMA, which is refused
>>>>> by the stm32-usart driver and then you add a patch for each board
>>>>> to fix that breakage?
>>>>
>>>> We have two solutions and both have pro/drawbacks. The first one (Erwan
>>>> ones, can break the boot if the patch is taken "alone". Your 
>>>> proposition
>>>> avoids this breakage but deletes a non define property (which is a bit
>>>> weird). However I prefer to keep a functional behavior, and keep Ahmad
>>>> proposition. Ahmad, just one question, dt-bindings check doesn't
>>>> complain about it ?
>>>>
>>>> Cheers
>>>> Alex
>>>>
>>>>>
>>>>> Such intermittent breakage makes bisection a hassle. /delete-property/
>>>>> is a no-op when the property doesn't exist, so you could move the 
>>>>> first
>>>>> patch to the very end to avoid intermittent breakage.
>>>>>
>>>>> I also think that the driver's behavior is a bit harsh. I think it 
>>>>> would
>>>>> be better for the UART driver to print a warning and fall back to
>>>>> PIO for console instead of outright refusing and rendering the system
>>>>> silent. That's not mutually exclusive with your patch series here,
>>>>> of course.
>>>>>
>>>>> Cheers,
>>>>> Ahmad
>>>>>
>>>
>>> The driver implementation will consider the request to probe the UART
>>> console in DMA mode as an error (-ENODEV), and will fallback this 
>>> UART probe
>>> in irq mode.
>>
>>> Whatever the patch ordering, the boot will never be broken. The board dt
>>> patches aim to get a "proper" implementation, but from functional
>>> perspective the driver will manage a request to probe an UART console 
>>> in DMA
>>> mode as an error and fall it back in irq mode.
>>
>> I didn't debug this further yet, but my machine (with an out-of-tree
>> dts) fails to boot 6.1-rc4 without removing the dma properties from the
>> console UART. This is a bug isn't it? The same dts created a working
>> setup with stm32mp157.dtsi from 5.15 + kernel 5.15.

Hi Uwe,

Could you confirm earlycon is enabled on your setup?

Without earlycon, boot is ok, even with dma properties, at least on 
stm32mp157c-dk2.

>>
>> I can debug this further, but maybe you know off-hand what the problem
>> is?
> 
> +CC Amelie, as this might be related to the DMA series that landed 
> recently:
> 
> $ git log --oneline v5.18..v6.0 -- drivers/dma/stm32*

Hi Marek,

We haven't yet investigated the issue, and if latest DMA updates could 
explain why earlycon breaks the boot.


+TO Valentin, as he's now in charge of UART driver.
Valentin and I will investigate this issue.

Regards,
Amelie
