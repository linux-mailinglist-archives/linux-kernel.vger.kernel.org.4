Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085925BE6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiITNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiITNYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3BF18361;
        Tue, 20 Sep 2022 06:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB70629AC;
        Tue, 20 Sep 2022 13:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B6BC433C1;
        Tue, 20 Sep 2022 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680282;
        bh=P8w9xEeZCQCJEelVBdy5KY0M97AVuyQWsaYi1TaRIlk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=liY26gV71HkIqs1LexUW/uGh3nFLS2d3ERKPfMDtjxI5dbTXKDT0/idfrTlZ5a3hF
         /wWJkq2RWT4iWOAR1hFVqsMupUMNy67x1nH3BLVeFXU5l7rgY97HqCSpBnEkxAvc0W
         nzl3SeoHHPbJcKFFDVc2WRkhZEheb5Gsk7fBEwUL40BhNzTddNVt6ka+3t37XV60fm
         UDy63Zhmg2Z947//URn06EgWw39rWPAitzftYm3Xtg8Y3BfNR1Yi3WHbirAqnKE3rb
         dSe3LAxQKCLR2497vTT6SADG1qJMg69EQ4Da+lkiDLhHj6Y2tqkrCqlMPBg1EY4BNA
         1wmJpAqxNml7g==
Message-ID: <50c7d35b-f395-6421-1422-56e30a580318@kernel.org>
Date:   Tue, 20 Sep 2022 08:24:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure
 clk-phase
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220919181309.286611-1-dinguyen@kernel.org>
 <20220919181309.286611-2-dinguyen@kernel.org>
 <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ulf,

Thanks for the review!

On 9/20/22 07:17, Ulf Hansson wrote:
> On Mon, 19 Sept 2022 at 20:13, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>> The clock-phase settings for the SDMMC controller in the SoCFPGA
>> Strarix10/Agilex/N5X platforms reside in a register in the System
>> Manager. Add a method to access that register through the syscon
>> interface.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   drivers/mmc/host/dw_mmc-pltfm.c | 68 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>> index 9901208be797..9e3237c18a9d 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -17,10 +17,15 @@
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/mmc.h>
>>   #include <linux/of.h>
>> +#include <linux/mfd/altera-sysmgr.h>
>> +#include <linux/regmap.h>
>>
>>   #include "dw_mmc.h"
>>   #include "dw_mmc-pltfm.h"
>>
>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
>> +       ((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
>> +
>>   int dw_mci_pltfm_register(struct platform_device *pdev,
>>                            const struct dw_mci_drv_data *drv_data)
>>   {
>> @@ -62,9 +67,70 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>>   };
>>   EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>>
>> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>> +{
>> +       struct device_node *np = host->dev->of_node;
>> +       struct regmap *sys_mgr_base_addr;
>> +       u32 clk_phase[2] = {0}, reg_offset;
>> +       int i, rc, hs_timing;
>> +
>> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> 
> This needs to be documented through updated DT bindings.

Ok, but it looks like clk-phase-sd-hs is already documented in 
Documentation/devicetree/bindings/mmc/mmc-controller.yaml

Should I create a specific documentation just for
"altr,socfpga-dw-mshc" and document "clk-phase-sd-hs"?

> 
>> +       if (rc) {
>> +               sys_mgr_base_addr =
>> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> 
> DT bindings?

"altr,sysmgr-syscon" has already been documented in
Documentation/devicetree/bindings/net/socfpga-dwmac.txt

>> +               if (IS_ERR(sys_mgr_base_addr)) {
>> +                       pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
>> +                       return 1;
>> +               }
>> +       } else
>> +               return 1;
>> +
>> +       of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
> 
> DT bindings?

Same...

> 
>> +
>> +       for (i = 0; i < ARRAY_SIZE(clk_phase); i++) {
>> +               switch (clk_phase[i]) {
>> +               case 0:
>> +                       clk_phase[i] = 0;
>> +                       break;
>> +               case 45:
>> +                       clk_phase[i] = 1;
>> +                       break;
>> +               case 90:
>> +                       clk_phase[i] = 2;
>> +                       break;
>> +               case 135:
>> +                       clk_phase[i] = 3;
>> +                       break;
>> +               case 180:
>> +                       clk_phase[i] = 4;
>> +                       break;
>> +               case 225:
>> +                       clk_phase[i] = 5;
>> +                       break;
>> +               case 270:
>> +                       clk_phase[i] = 6;
>> +                       break;
>> +               case 315:
>> +                       clk_phase[i] = 7;
>> +                       break;
>> +               default:
>> +                       clk_phase[i] = 0;
>> +                       break;
>> +               }
>> +       }
> 
> In my opinion, it looks like converting to use
> mmc_of_parse_clk_phase() should be able to avoid some of the open
> coding above.
> 
> If you need some inspiration of how to implement this, you may have a
> look at drivers/mmc/host/sdhci-of-aspeed.c
> 

Got it.

>> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
>> +       regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dw_mci_drv_data socfpga_drv_data = {
>> +       .init           = dw_mci_socfpga_priv_init,
>> +};
>> +
>>   static const struct of_device_id dw_mci_pltfm_match[] = {
>>          { .compatible = "snps,dw-mshc", },
>> -       { .compatible = "altr,socfpga-dw-mshc", },
>> +       { .compatible = "altr,socfpga-dw-mshc", .data = &socfpga_drv_data, },
>>          { .compatible = "img,pistachio-dw-mshc", },
>>          {},
>>   };
>> --
>> 2.25.1
>>
> 
> Kind regards
> Uffe

Dinh
