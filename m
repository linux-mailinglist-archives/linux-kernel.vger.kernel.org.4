Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02F632F83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKUWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKUWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:03:47 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83065F41;
        Mon, 21 Nov 2022 14:03:46 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALM3f9g092186;
        Mon, 21 Nov 2022 16:03:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669068221;
        bh=yLIraiDAl3fRDr2IzQO3j1XUEWsnoJbe0Ih/sVCEK8M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WyYKdWmDSfCDwabxNFeEt5074Z9t+ryw68M4JAa0DTrn464jlrSYbnsQ6mRwDQDdX
         /Zw/hPjyiNqa3FYu4Sivg8O8Bhftb5G/eL7zZ7qClpVFnE90fCE0eyX/UOvayPOsvu
         HBKc+st9sAgLiI0kpxxiKtz2HXQi20SLbLu3Oaws=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALM3fQI010970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 16:03:41 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 16:03:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 16:03:40 -0600
Received: from [10.250.135.52] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALM3XMN105468;
        Mon, 21 Nov 2022 16:03:34 -0600
Message-ID: <533bfed1-40da-58a0-de02-6a0161bceaa7@ti.com>
Date:   Tue, 22 Nov 2022 00:03:31 +0200
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
 <20221121185627.lysq4u7guiprclxt@surviving>
From:   Georgi Vlaev <g-vlaev@ti.com>
In-Reply-To: <20221121185627.lysq4u7guiprclxt@surviving>
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

On 11/21/22 20:56, Nishanth Menon wrote:
> On 20:13-20221116, Georgi Vlaev wrote:
>> +	/*
>> +	 * Attempt to call prepare_sleep, this will be NAK'd if suspend is not
>> +	 * supported by firmware in use, in which case we will not attempt to
>> +	 * init suspend.
>> +	 */
>> +	ret = ti_sci_cmd_prepare_sleep(&info->handle, 0,
>> +				       (u32)(info->ctx_mem_addr & 0xffffffff),
>> +				       (u32)((u64)info->ctx_mem_addr >> 32), 0);
>> +
> 
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-prepare-sleep
> "Prepare the SOC for entering into a low power mode."
> 
> But we are in the init process here. From the documentation, firmware
> does'nt seem to guarantee it would do something unexpected (like setup
> io daisy chain or something like that which normal LP entry state
> would have to do) - How is it safe to use it as a discovery of
> capability API?
> 
> 

Well, you're correct, there's no guarantee. It is safe to call it now on AM62x
in both places we actually use it. However, this may change in the future
and it's not a good idea to misuse that API. We'll switch the detection part
to a more appropriate message, that's better suited for this purpose on all
K3 platforms.

-- 
Regards,
Georgi
