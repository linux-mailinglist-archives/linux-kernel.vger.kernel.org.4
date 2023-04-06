Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA26D906D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjDFH2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjDFH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:28:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33E65BC;
        Thu,  6 Apr 2023 00:28:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3365ladV004117;
        Thu, 6 Apr 2023 09:28:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=LRhIg+JW6WykEoKgud9p5rkXeWZboEgKlQgR1PTLID8=;
 b=myszDPnrSAzEUrPzyJ+K/1wjtlccOlT9zw8CiajqtNOe45LFjEPR2qUmQ02MWqdUcDT4
 RbBZ7ngfHjfZn7AbFA+k9QD/o7cV2Up9JIxf/rP8M8zKDZONkfZIIHsiavjuJ1xuIpOb
 ubCR4WeL4gufTLzyQ0ThpoAamM2+car1+Qmmzsq87gdGBcaJdu/rxawYEwUnmFOseqmw
 snigfHZJa5qqvbSsCt8aQKL3DFe2mYBMXVLZwua1N7U9hRChnoh9+rO4O14nMIWU8ZYP
 CZlChQCiQAtNIfzpmCGSGVHWpVPCfyhhjJB9CdmECXpmPVuwbGQ4o8NZyiDhqPa9jEJv UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3prmnybtuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 09:28:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1A5B10002A;
        Thu,  6 Apr 2023 09:27:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 94B782128DC;
        Thu,  6 Apr 2023 09:27:59 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 6 Apr
 2023 09:27:58 +0200
Message-ID: <cd19fb5b-7c7e-a33c-9572-4ddbf9dce2d4@foss.st.com>
Date:   Thu, 6 Apr 2023 09:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
To:     Peng Fan <peng.fan@nxp.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB941747DDF6FD2F157A24183288939@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <6bfaef82-458e-256d-b9ba-d6d84c574d4b@foss.st.com>
 <DU0PR04MB94170A9BD5F46D4157196D0888919@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <DU0PR04MB94170A9BD5F46D4157196D0888919@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/6/23 07:16, Peng Fan wrote:
>> Subject: Re: [PATCH 4/5] remoteproc: stm32: Allow hold boot management
>> by the SCMI reset controller
>>
>>
>>
>> On 4/4/23 06:55, Peng Fan wrote:
>>>> Subject: [PATCH 4/5] remoteproc: stm32: Allow hold boot management
>> by
>>>> the SCMI reset controller
>>>>
>>>> The hold boot can be managed by the SCMI controller as a reset.
>>>> If the "hold_boot" reset is defined in the device tree, use it.
>>>> Else use the syscon controller directly to access to the register.
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>>   drivers/remoteproc/stm32_rproc.c | 34
>>>> ++++++++++++++++++++++++++-----
>>>> -
>>>>   1 file changed, 28 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/stm32_rproc.c
>>>> b/drivers/remoteproc/stm32_rproc.c
>>>> index 4be651e734ee..6b0d8f30a5c7 100644
>>>> --- a/drivers/remoteproc/stm32_rproc.c
>>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>>> @@ -78,6 +78,7 @@ struct stm32_mbox {
>>>>
>>>>   struct stm32_rproc {
>>>>   	struct reset_control *rst;
>>>> +	struct reset_control *hold_boot_rst;
>>>>   	struct stm32_syscon hold_boot;
>>>>   	struct stm32_syscon pdds;
>>>>   	struct stm32_syscon m4_state;
>>>> @@ -398,6 +399,14 @@ static int stm32_rproc_set_hold_boot(struct
>>>> rproc *rproc, bool hold)
>>>>   	struct stm32_syscon hold_boot = ddata->hold_boot;
>>>>   	int val, err;
>>>>
>>>> +	if (ddata->hold_boot_rst) {
>>>> +		/* Use the SCMI reset controller */
>>>> +		if (!hold)
>>>> +			return reset_control_deassert(ddata-
>>>>> hold_boot_rst);
>>>> +		else
>>>> +			return reset_control_assert(ddata->hold_boot_rst);
>>>> +	}
>>>> +
>>>>   	val = hold ? HOLD_BOOT : RELEASE_BOOT;
>>>>
>>>>   	err = regmap_update_bits(hold_boot.map, hold_boot.reg, @@ -
>>>> 693,16 +702,29 @@ static int stm32_rproc_parse_dt(struct
>>>> platform_device *pdev,
>>>>   		dev_info(dev, "wdg irq registered\n");
>>>>   	}
>>>>
>>>> -	ddata->rst = devm_reset_control_get_by_index(dev, 0);
>>>> +	ddata->rst = devm_reset_control_get(dev, "mcu_rst");
>>> [Peng Fan]
>>> This may break legacy device tree.
>>
>> That partially true by the fact that I impose the "reset-names" property (but
>> also suppress the "st,syscfg-tz" property)
>>
>> But this should not be the case as the arch/arm/boot/dts/stm32mp151.dtsi
>> is updated in patch 2/5. The DTS files associated to this chip include it.
> 
> DT  maintainers may comment, from my understanding is updating driver
> should not break legacy dts, saying 5.15, 5.10 dts.

An old DT should continue to work with a new kernel.

Alex

> 
> Regards,
> Peng.
> 
>>
>> Thanks,
>> Arnaud
>>
>>
>>>
>>> Regards,
>>> Peng.
>>>
>>>>   	if (IS_ERR(ddata->rst))
>>>>   		return dev_err_probe(dev, PTR_ERR(ddata->rst),
>>>>   				     "failed to get mcu_reset\n");
>>>>
>>>> -	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
>>>> -				     &ddata->hold_boot);
>>>> -	if (err) {
>>>> -		dev_err(dev, "failed to get hold boot\n");
>>>> -		return err;
>>>> +	ddata->hold_boot_rst = devm_reset_control_get(dev, "hold_boot");
>>>> +	if (IS_ERR(ddata->hold_boot_rst)) {
>>>> +		if (PTR_ERR(ddata->hold_boot_rst) == -EPROBE_DEFER)
>>>> +			return PTR_ERR(ddata->hold_boot_rst);
>>>> +		ddata->hold_boot_rst = NULL;
>>>> +	}
>>>> +
>>>> +	if (!ddata->hold_boot_rst) {
>>>> +		/*
>>>> +		 * If the hold boot is not managed by the SCMI reset
>>>> controller,
>>>> +		 * manage it through the syscon controller
>>>> +		 */
>>>> +		err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
>>>> +					     &ddata->hold_boot);
>>>> +		if (err) {
>>>> +			dev_err(dev, "failed to get hold boot\n");
>>>> +			return err;
>>>> +		}
>>>>   	}
>>>>
>>>>   	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
>>>> --
>>>> 2.25.1
>>>

