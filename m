Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67D636286
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiKWO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiKWO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:56:56 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40FF6F36D;
        Wed, 23 Nov 2022 06:56:50 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANAZ3fN023248;
        Wed, 23 Nov 2022 15:56:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=weaOU0SozUctuAREeQGQtG6MoT2/RGoboxfxxM4u9+w=;
 b=C5LetEJn6bSyKN0f7vxOZTU4GI23flPFdezNz4vMYbyrSmZ3k/DgzlFHZeSxGc0Vi31G
 jtZc6rnMZ1/8rP44ELmT1KCepuXSqthGJYHs/G/TJn2+PMtTMDcXRaBhZNUKij6xzzjF
 HOPXV16YfmurCzdQflzsSgkGcmT85s+GzBq7cJx41lupf9pug03dsgnweAVnCbumz2L7
 s+6jDaYiNMb5BhXJGFErtNC/pUIreou92pcqRJCalra1tbXzuUTkom4v93Bz/dUc3qg+
 TvIXSjBD87unttgu1H67QWTixAYcM6uSdYZ5nUKZ/JSe0NGDYMag2YZDPGvtT4F3/kxy vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m10c4fbry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 15:56:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0ECE6100039;
        Wed, 23 Nov 2022 15:56:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4BAED229A70;
        Wed, 23 Nov 2022 15:56:34 +0100 (CET)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 15:56:33 +0100
Message-ID: <c4792fd3-73e3-20ee-cd7a-a8d00eb877f9@foss.st.com>
Date:   Wed, 23 Nov 2022 15:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix the check on arr and cmp
 registers update
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     <jic23@kernel.org>, <alexandre.torgue@foss.st.com>,
        <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
 <Y3x59hNekCDuOFXT@fedora> <Y3x7YIBDT3xTeqtk@fedora>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <Y3x7YIBDT3xTeqtk@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 08:33, William Breathitt Gray wrote:
> On Tue, Nov 22, 2022 at 02:27:50AM -0500, William Breathitt Gray wrote:
>> On Wed, Nov 23, 2022 at 02:36:09PM +0100, Fabrice Gasnier wrote:
>>> The ARR (auto reload register) and CMP (compare) registers are
>>> successively written. The status bits to check the update of these
>>> registers are polled together with regmap_read_poll_timeout().
>>> The condition to end the loop may become true, even if one of the register
>>> isn't correctly updated.
>>> So ensure both status bits are set before clearing them.
>>>
>>> Fixes: d8958824cf07 ("iio: counter: Add support for STM32 LPTimer")
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
>>> index d6b80b6dfc28..8439755559b2 100644
>>> --- a/drivers/counter/stm32-lptimer-cnt.c
>>> +++ b/drivers/counter/stm32-lptimer-cnt.c
>>> @@ -69,7 +69,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
>>>  
>>>  	/* ensure CMP & ARR registers are properly written */
>>>  	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
>>> -				       (val & STM32_LPTIM_CMPOK_ARROK),
>>> +				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
>>
>> This is a reasonable fix, but I don't like seeing so much happening in
>> an argument list -- it's easy to misunderstand what's going on which can
>> lead to further bugs the future. Pull out this condition to a dedicated
>> bool variable with a comment explaining why we need the equivalence
>> check (i.e. to ensure both status bits are set and not just one).
>>
>> William Breathitt Gray
> 
> Alternatively, you could pull out just (val & STM32_LPTIM_CMPOK_ARROK)
> to a separate variable and keep the equivalence condition inline if you
> think it'll be clearer that way.

Hi William,

I'm not sure to fully understand your proposal here.
Could you clarify ?

regmap_read_poll_timeout() macro requires:

 * @val: Unsigned integer variable to read the value into
 * @cond: Break condition (usually involving @val)

So do you wish I introduce a macro that abstracts the condition check ?
(val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK


Best regards,
Fabrice

> 
> William Breathitt Gray
