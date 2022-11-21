Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB0632F33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiKUVqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKUVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:45:58 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC92E8;
        Mon, 21 Nov 2022 13:45:57 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALLjlUi089236;
        Mon, 21 Nov 2022 15:45:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669067147;
        bh=9nmkt/fM+sdQIIViulu9vtC5+7HYjTlTa5MRtxWn4fM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AFFIzrXQpKWA+1SJ2QgnDZmJkQXNfbg6UBSM33x9qLaiiHnkpoVwRX2SzfzVNcyL1
         oODPrznms/e76ti3FTrvJ6Hh12jth7NxNBfkcb1LqFs6yAcaR5nS5rKJlvrm9ySkCg
         9e+j2PvlnE8KTzxpcyuYLZx8C6J49LMOuR0b5vZY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALLjli0017320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 15:45:47 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 15:45:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 15:45:47 -0600
Received: from [10.250.135.52] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALLjbIn102805;
        Mon, 21 Nov 2022 15:45:39 -0600
Message-ID: <2558a8fd-68c0-1a3e-61d1-57d032024f5f@ti.com>
Date:   Mon, 21 Nov 2022 23:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 3/5] firmware: ti_sci: Allocate memory for the LPM
 modes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20221116181307.198209-1-g-vlaev@ti.com>
 <20221116181307.198209-4-g-vlaev@ti.com>
 <20221121184435.btehz6dzliz3lizk@scuba>
From:   Georgi Vlaev <g-vlaev@ti.com>
In-Reply-To: <20221121184435.btehz6dzliz3lizk@scuba>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 11/21/22 20:44, Nishanth Menon wrote:
> On 20:13-20221116, Georgi Vlaev wrote:
> [...]
> 
>> +static int ti_sci_init_suspend(struct platform_device *pdev,
>> +			       struct ti_sci_info *info)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +	info->ctx_mem_buf = dma_alloc_coherent(info->dev, LPM_CTX_MEM_SIZE,
>> +					       &info->ctx_mem_addr,
>> +					       GFP_KERNEL);
>> +	if (!info->ctx_mem_buf) {
>> +		dev_err(info->dev, "Failed to allocate LPM context memory\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/*
>> +	 * Attempt to call prepare_sleep, this will be NAK'd if suspend is not
>> +	 * supported by firmware in use, in which case we will not attempt to
>> +	 * init suspend.
>> +	 */
>> +	ret = ti_sci_cmd_prepare_sleep(&info->handle, 0,
>> +				       (u32)(info->ctx_mem_addr & 0xffffffff),
>> +				       (u32)((u64)info->ctx_mem_addr >> 32), 0);
>> +
>> +	if (ret)
>> +		goto err;
>> +
>> +	return 0;
>> +err:
>> +	dma_free_coherent(info->dev, LPM_CTX_MEM_SIZE,
>> +			  info->ctx_mem_buf,
>> +			  info->ctx_mem_addr);
>> +	return ret;
>> +}
>> +
>>  /* Description for K2G */
>>  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>>  	.default_host_id = 2,
>> @@ -3639,6 +3682,14 @@ static int ti_sci_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> +	ret = ti_sci_init_suspend(pdev, info);
>> +	if (ret)
>> +		dev_warn(dev,
>> +			 "ti_sci_init_suspend failed, mem suspend will be non-functional.\n");
>> +
>> +	/* Suspend is an optional feature, reset return value and continue. */
>> +	ret = 0;
> 
> We end up getting this warning on all platforms with TISCI - even if
> LPM sequence is capable or not - what does the message mean? firmware is
> not capable of supporting sleep or it is a firmware capable of
> supporting, but failed to allocate LPM context memory?
> 
> If it is optional (since it is probing to see if it has functionality),
> then do we need a dev_warn - maybe a softer of form?
> 

Yeah, I agree, the message looks confusing. In both cases we can't enter suspend-to-ram,
but we consider that an optional feature, so a softer message will be more appropriate.


> [...]
> 

-- 
Regards,
Georgi
