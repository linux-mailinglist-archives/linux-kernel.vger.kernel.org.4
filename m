Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5266D66FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjDDPPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDDPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:15:46 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B144A3;
        Tue,  4 Apr 2023 08:15:35 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334CS99Z019621;
        Tue, 4 Apr 2023 17:15:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=O4QAVAXtCfAM2YMeEv35i7sxiFxYCA1KFeyN8KIQ5+8=;
 b=nKSy0tX/2pG6fXNiReeUK1YeACTsHLeWuPfHA14D/QraNRiDwN5VUXBVofuvgmYF1DcP
 H3Ni8+rQVObaNqIHDKjReKaNALH7Geqggz/1Tm1symw/E0HAZisw2a8h8Sy9cHKeYX8B
 lP7CCk4OTfv+0HdaoAFQgdxmLcogndnxSVToL8OTGibH+wfwlBpvd+xzu4gY14G9ybnw
 sGcGTb1nzv3B18PFGK44xSCvA+rBgbM2tdZaIalDp0A6sKravxPNhKtDhVQil5/fHF7R
 y70XpE9An9zRs9DRnxUVgo3jVKI7MV/6Lxr1cZAfRjvoCrXYzwhhX45xu08C6FuKcGP9 cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pqunht0vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 17:15:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 399D910002A;
        Tue,  4 Apr 2023 17:15:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2002D2248B0;
        Tue,  4 Apr 2023 17:15:21 +0200 (CEST)
Received: from [10.252.11.89] (10.252.11.89) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 4 Apr
 2023 17:15:17 +0200
Message-ID: <6bfaef82-458e-256d-b9ba-d6d84c574d4b@foss.st.com>
Date:   Tue, 4 Apr 2023 17:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB941747DDF6FD2F157A24183288939@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <DU0PR04MB941747DDF6FD2F157A24183288939@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.11.89]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/23 06:55, Peng Fan wrote:
>> Subject: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by
>> the SCMI reset controller
>>
>> The hold boot can be managed by the SCMI controller as a reset.
>> If the "hold_boot" reset is defined in the device tree, use it.
>> Else use the syscon controller directly to access to the register.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  drivers/remoteproc/stm32_rproc.c | 34 ++++++++++++++++++++++++++-----
>> -
>>  1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/stm32_rproc.c
>> b/drivers/remoteproc/stm32_rproc.c
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
>> @@ -398,6 +399,14 @@ static int stm32_rproc_set_hold_boot(struct rproc
>> *rproc, bool hold)
>>  	struct stm32_syscon hold_boot = ddata->hold_boot;
>>  	int val, err;
>>
>> +	if (ddata->hold_boot_rst) {
>> +		/* Use the SCMI reset controller */
>> +		if (!hold)
>> +			return reset_control_deassert(ddata-
>>> hold_boot_rst);
>> +		else
>> +			return reset_control_assert(ddata->hold_boot_rst);
>> +	}
>> +
>>  	val = hold ? HOLD_BOOT : RELEASE_BOOT;
>>
>>  	err = regmap_update_bits(hold_boot.map, hold_boot.reg, @@ -
>> 693,16 +702,29 @@ static int stm32_rproc_parse_dt(struct platform_device
>> *pdev,
>>  		dev_info(dev, "wdg irq registered\n");
>>  	}
>>
>> -	ddata->rst = devm_reset_control_get_by_index(dev, 0);
>> +	ddata->rst = devm_reset_control_get(dev, "mcu_rst");
> [Peng Fan] 
> This may break legacy device tree.

That partially true by the fact that I impose the "reset-names" property
(but also suppress the "st,syscfg-tz" property)

But this should not be the case as the arch/arm/boot/dts/stm32mp151.dtsi
is updated in patch 2/5. The DTS files associated to this chip include it.

Thanks,
Arnaud


> 
> Regards,
> Peng.
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
>> +	if (!ddata->hold_boot_rst) {
>> +		/*
>> +		 * If the hold boot is not managed by the SCMI reset
>> controller,
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
> 
