Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10483623192
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiKIRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKIRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:35:23 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703418E15
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:35:22 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EbRxo009344;
        Wed, 9 Nov 2022 18:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=manLfjXzj5s48sIJkGm/nLiI9zKQBYo8xV/KO74LDpQ=;
 b=OlYL2etVZBTAUmCTR6/9ASWaTC/hPGRZrW7qiiB4gT0LwN+NMMmxwj/Gf6rW4Z04Kp/i
 3+4WW63WwD2dKWmscGUQU39zicv1LSifa89SU9cZuPpw3Otx/38+m7NFEmMoTZ/Bs+e7
 DJxQ8FB6+JgnVcKeh5MEi0GIDF7DzosvZz92Pcf9i2fLpl5fl6SB3q1B8ChQNHiJNohM
 Gg8xUVNYtVTxlpKyYZ+S2zrH7KqJVXFcw/e+4yesdTtrAyJsRtLe9aT4OnWjHhrvRx62
 w0DxWY/RMwDU5IE/64xjSnQcY5Q3vRGLT78eeO2SMC1yi5BBeelJq8Vr6k1WT1ekoOsh FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kra52313v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 18:35:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01ED210002A;
        Wed,  9 Nov 2022 18:35:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0E30229A7D;
        Wed,  9 Nov 2022 18:35:07 +0100 (CET)
Received: from [10.252.15.206] (10.252.15.206) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Wed, 9 Nov
 2022 18:35:06 +0100
Message-ID: <6df7b823-463b-d6fa-9662-54f39463a894@foss.st.com>
Date:   Wed, 9 Nov 2022 18:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
 <20221028165150.3.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
 <99a8d093-13f3-9ff8-6d87-d4aecaec1566@linaro.org>
 <a4ae3648-2943-55e0-243f-71a3c5f71ad8@foss.st.com>
 <4789703d-0434-2e72-0001-5a7e1014f816@linaro.org>
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <4789703d-0434-2e72-0001-5a7e1014f816@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.15.206]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
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

Hi,

On 11/8/22 11:03, Srinivas Kandagatla wrote:
>
>
> On 02/11/2022 10:59, Patrick DELAUNAY wrote:
>> Hi,
>>
>> On 11/1/22 08:26, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 28/10/2022 15:52, Patrick Delaunay wrote:
>>>> For boot with OP-TEE on STM32MP13, the communication with the secure
>>>> world no more use STMicroelectronics SMC but communication with the
>>>> BSEC TA, for data access (read/write) or lock operation:
>>>> - all the request are sent to OP-TEE trusted application,
>>>> - for upper OTP with ECC protection and with word programming only
>>>>    each OTP are permanently locked when programmed to avoid ECC error
>>>>    on the second write operation
>>>>
>>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>> ---
>>>
>>> For some reason I pushed this patch without a full review, This is 
>>> now reverted from nvmem-next.
>>
>>
>> Ok
>>
>>
>>>
>>> Why not add TEE client based new driver instead of ifdefing around 
>>> this driver? Also I see there is not much common across both drivers 
>>> anyway.
>>
>>
>> I hesitate between the 2 solutions. I choose this update to handle 
>> the STM32MP15 support with OP-TEE.
>
> How are you to handing this?
>
>>
>> For backward compatibility reason the same driver STM32 ROMEM 
>> associated to compatible "st,stm32mp15-bsec" should be kept.
>>
>> - the lower OTP can directly accessible by Linux (the IP is not 
>> secured) => boot with SPL
>
> Can we determine this at runtime?


Not directly with IP register, but we detect the OP-TEE support at runtime.


>
>>
>> - the upper OTP and the write operation are requested by 
>> STMicroelectronics SMCs
>>
>>     => boot with TF-A SPMIN and old OP-TEE (before migration to STM32 
>> BSEC PTA)
>>
>>
>> But in the future OP-TEE the access to OTP should be also done with 
>> STM32 BSEC PTA...
>
> Given that we have only one compatible for these two type of 
> combinations how are you planning to deal with both the cases and 
> still be backward compatible?


yes, as it is the SOC dtsi, I don't want change the IP compatible

but I will handle in this driver probe to be backward compatible: 
detection of OP-TEE presence and SMC/PTA support.


only the STM32MP13 SoC only use the PTA, as we have no backward 
compatibility issue.


I will include this STM32MP15 patch in the serie for V2, it should be 
mode clear for the review.


>
> --srini
>>
>>
>> I can manage this compatibility by detection in STM32 romem driver if 
>> the booth access are managed in the same driver.
>
>
>
>>
>> This patch can be added in the serie to understood the detection 
>> mechanism.
>>

Regards

Patrick

