Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03900607A57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJUPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiJUPR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:17:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CF277099;
        Fri, 21 Oct 2022 08:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71972B82C87;
        Fri, 21 Oct 2022 15:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2210EC433D6;
        Fri, 21 Oct 2022 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666365441;
        bh=36H6jNpp/CigPLPijsRIzOpMDElCb4aP1b/ytKYGTxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rMna7h9xM+/QhQNkzNFpPShQ2uzLRF+rpVSO+HnvsmWJGz9/Qz13rL3G1COQLtYYS
         6IIE/lTTL6QP+717YWsuTlSTEOGEqO6jOPLczsQtaRlQzF+V4INmMTPA4b+Ylsf9TZ
         XIG/MU8CNh4YvusanrsQPQ3It4ty4HqjPwMBYPGVLzxgXmRhuOagVtI3A8I/mo+/9X
         TyICcxI1paELOkfNQEFxATbS94KA/TIWNGBAfkZjm4Qh4CEhZA8LewAlfNQd+HYjpz
         e5xyayjv9Z0CDnBKAymUdDKKJtWBGnORs013Z+jqJvkuJDWxzh1X0rjBFcJV/KSekq
         aAsJZRtoP3/pQ==
Message-ID: <389dc5e4-1785-80b3-3798-f54f4b51be81@kernel.org>
Date:   Fri, 21 Oct 2022 10:17:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv5 4/6] mmc: dw_mmc-pltfm: socfpga: add method to configure
 clk-phase
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221019170657.68014-1-dinguyen@kernel.org>
 <20221019170657.68014-5-dinguyen@kernel.org>
 <b74f37ba-d2e3-ab73-a035-739ffb2b0334@linaro.org>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <b74f37ba-d2e3-ab73-a035-739ffb2b0334@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/22 08:32, Krzysztof Kozlowski wrote:
> On 19/10/2022 13:06, Dinh Nguyen wrote:
>> The clock-phase settings for the SDMMC controller in the SoCFPGA
>> platforms reside in a register in the System Manager. Add a method
>> to access that register through the syscon interface.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v5: change error handling from of_property_read_variable_u32_array()
>>      support arm32 by reading the reg_shift
>> v4: no change
>> v3: add space before &socfpga_drv_data
>> v2: simplify clk-phase calculations
>> ---
>>   drivers/mmc/host/dw_mmc-pltfm.c | 43 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>> index 9901208be797..74421d13f466 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -17,10 +17,16 @@
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/mmc.h>
>>   #include <linux/of.h>
>> +#include <linux/mfd/altera-sysmgr.h>
>> +#include <linux/regmap.h>
>>   
>>   #include "dw_mmc.h"
>>   #include "dw_mmc-pltfm.h"
>>   
>> +#define SOCFPGA_DW_MMC_CLK_PHASE_STEP	45
>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel, reg_shift) \
>> +	((((smplsel) & 0x7) << reg_shift) | (((drvsel) & 0x7) << 0))
>> +
>>   int dw_mci_pltfm_register(struct platform_device *pdev,
>>   			  const struct dw_mci_drv_data *drv_data)
>>   {
>> @@ -62,9 +68,44 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>>   };
>>   EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>>   
>> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>> +{
>> +	struct device_node *np = host->dev->of_node;
>> +	struct regmap *sys_mgr_base_addr;
>> +	u32 clk_phase[2] = {0}, reg_offset, reg_shift;
>> +	int i, rc, hs_timing;
>> +
>> +	rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
>> +	if (rc < 0) {
>> +		dev_err(host->dev, "clk-phase-sd-hs not found!\n");
>> +		return rc;
>> +	}
>> +
>> +	sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
>> +	if (IS_ERR(sys_mgr_base_addr)) {
>> +		dev_err(host->dev, "failed to find altr,sys-mgr regmap!\n");
>> +		return -ENODEV;
> 
> Isn't this now an ABI break? I have an impression we talked about this...
> 

My fault, I'll make this optional.

Dinh
