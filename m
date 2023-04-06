Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996776D94CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjDFLMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjDFLL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:11:59 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC347EE7;
        Thu,  6 Apr 2023 04:11:55 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336ATra9030223;
        Thu, 6 Apr 2023 13:11:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=lNXQl4ZV/6vn7r3pBuZewXxh3tYHi2TdmaJoMqkDndc=;
 b=30CchlbXohzL5uB7KQeLzo1CHO5Bh8K6Dl4BegGtjo6JcZ1qBrDYI2SVFeGEHThbKXK3
 oOgleTH1Y8ffgFwDZuhkXyAc/ARlhtZuWEYpFXJJBRQwcDgTYCiIXd4z626ZM7lko5TJ
 TH+dfe4GYpVHGiXXP8Zf48ogxNfMYQsw5o+zUAfGOAhT4omYDZJZOxz0BoOq2n9fIJr3
 yn+akJ9Mzg1ytnmIk+bdgfFyB9qLiunWZ4i6x0r+5XJLqQDztkNF0D416MnI1Z78BfGB
 9lfETUEMAn5IzK0DhCy9TzWLPROoLo+zYQQ7Dx9fvJVqR2LWypDZj4+ZiBnlUmIIZPo+ 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3psv5xrb6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 13:11:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A61010002A;
        Thu,  6 Apr 2023 13:11:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3596121BF53;
        Thu,  6 Apr 2023 13:11:40 +0200 (CEST)
Received: from [10.201.21.178] (10.201.21.178) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 6 Apr
 2023 13:11:37 +0200
Message-ID: <9c87443a-90e6-52d3-859f-2b2eb057049b@foss.st.com>
Date:   Thu, 6 Apr 2023 13:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
 <20230405180143.GD3812912@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230405180143.GD3812912@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_05,2023-04-06_01,2023-02-09_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/23 20:01, Mathieu Poirier wrote:
> On Fri, Mar 31, 2023 at 05:46:50PM +0200, Arnaud Pouliquen wrote:
>> The hold boot can be managed by the SCMI controller as a reset.
>> If the "hold_boot" reset is defined in the device tree, use it.
>> Else use the syscon controller directly to access to the register.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 34 ++++++++++++++++++++++++++------
>>  1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>> index 4be651e734ee..6b0d8f30a5c7 100644
>> --- a/drivers/remoteproc/stm32_rproc.c
>> +++ b/drivers/remoteproc/stm32_rproc.c
>> @@ -78,6 +78,7 @@ struct stm32_mbox {
>>  
>>  struct stm32_rproc {
>>  	struct reset_control *rst;
>> +	struct reset_control *hold_boot_rst;
>>  	struct stm32_syscon hold_boot;
>>  	struct stm32_syscon pdds;
>>  	struct stm32_syscon m4_state;
>> @@ -398,6 +399,14 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
>>  	struct stm32_syscon hold_boot = ddata->hold_boot;
>>  	int val, err;
>>  
>> +	if (ddata->hold_boot_rst) {
>> +		/* Use the SCMI reset controller */
>> +		if (!hold)
>> +			return reset_control_deassert(ddata->hold_boot_rst);
>> +		else
>> +			return reset_control_assert(ddata->hold_boot_rst);
>> +	}
>> +
>>  	val = hold ? HOLD_BOOT : RELEASE_BOOT;
>>  
>>  	err = regmap_update_bits(hold_boot.map, hold_boot.reg,
>> @@ -693,16 +702,29 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
>>  		dev_info(dev, "wdg irq registered\n");
>>  	}
>>  
>> -	ddata->rst = devm_reset_control_get_by_index(dev, 0);
>> +	ddata->rst = devm_reset_control_get(dev, "mcu_rst");
> 
> Peng is correct - newer kernels won't be able to boot with older DT.
> 
>>  	if (IS_ERR(ddata->rst))
>>  		return dev_err_probe(dev, PTR_ERR(ddata->rst),
>>  				     "failed to get mcu_reset\n");
>>  
>> -	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
>> -				     &ddata->hold_boot);
>> -	if (err) {
>> -		dev_err(dev, "failed to get hold boot\n");
>> -		return err;
>> +	ddata->hold_boot_rst = devm_reset_control_get(dev, "hold_boot");
>> +	if (IS_ERR(ddata->hold_boot_rst)) {
>> +		if (PTR_ERR(ddata->hold_boot_rst) == -EPROBE_DEFER)
>> +			return PTR_ERR(ddata->hold_boot_rst);
>> +		ddata->hold_boot_rst = NULL;
>> +	}
>> +
>> +	if (!ddata->hold_boot_rst) {Okay, I definitely need to rewrite the patchset.
> 
> Why another if() statement?  The code below should be in the above if()...
> 
> This patchset is surprizingly confusing for its size.  I suggest paying
> attention to the changelogs and adding comments in the code.

I definitely need to rewrite this patchset.

Thanks for all reviewers
Regards
Arnaud

> 
> Thanks,
> Mathieu
> 
>> +		/*
>> +		 * If the hold boot is not managed by the SCMI reset controller,
>> +		 * manage it through the syscon controller
>> +		 */
>> +		err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
>> +					     &ddata->hold_boot);
>> +		if (err) {
>> +			dev_err(dev, "failed to get hold boot\n");
>> +			return err;
>> +		}
>>  	}
>>  
>>  	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
>> -- 
>> 2.25.1
>>
