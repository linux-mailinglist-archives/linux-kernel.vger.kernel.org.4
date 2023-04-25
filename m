Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F246EE67F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjDYRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjDYRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:18:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE13CC27;
        Tue, 25 Apr 2023 10:18:46 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PHIMgc093146;
        Tue, 25 Apr 2023 12:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682443102;
        bh=8UWEHdzwym7D2TJjdzjZDDZMXCWez9fzFsKRaVXXaTk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ptMS8rr2tUkkNzoEL2BE3fjKxpIgNRGOqhyglMx767ne6zjKBbPKhNFDqDQ3aFOqm
         2KgrL8RGpshIhbqFGKC6DnYhDzJvXssgYBML8J17kZ3nIDMBNVEI9w9/FeQQVTl4pI
         UDPwVN9U8w+dSfuFiblTyKfhNsAIx+liQhKRWsco=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PHIMtS087348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 12:18:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 12:18:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 12:18:21 -0500
Received: from [10.250.150.138] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PHIGaj024841;
        Tue, 25 Apr 2023 12:18:17 -0500
Message-ID: <602392dc-de1f-90bf-3deb-cb5cee81e41c@ti.com>
Date:   Tue, 25 Apr 2023 22:48:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Mark Brown <broonie@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
References: <20230420121615.967487-1-d-gole@ti.com>
 <8edb48ee-55a3-4cc2-9c81-514ec867b35c@roeck-us.net>
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <8edb48ee-55a3-4cc2-9c81-514ec867b35c@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/2023 8:38 PM, Guenter Roeck wrote:
> On Thu, Apr 20, 2023 at 05:46:15PM +0530, Dhruva Gole wrote:
>> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
>> it may introduce build issues with certain configs where it maybe disabled
>> This is because if above config is not enabled the suspend-resume
>> functions are never part of the code but the bcm63xx_spi_pm_ops struct
>> still inits them to non-existent suspend-resume functions.
>>
>> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
>>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> This patch results in:
>
> drivers/spi/spi-bcm63xx.c:632:12: error: 'bcm63xx_spi_resume' defined but not used [-Werror=unused-function]
>   632 | static int bcm63xx_spi_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~
> drivers/spi/spi-bcm63xx.c:620:12: error: 'bcm63xx_spi_suspend' defined but not used [-Werror=unused-function]
>   620 | static int bcm63xx_spi_suspend(struct device *dev)
>
> on architectures with no PM support (alpha, csky, m68k, openrisc, parisc,
> riscv, s390).

Thanks for pointing this out.

I could send a patch to address this as pointed here [0]

by adding a __maybe_unused.

However, do you think my other patch [1] could address this issue without the need for above?

I think it would because DEFINE_SIMPLE_DEV_PM_OPS doesn't seem to be under any conditional CONFIG_PM.

However, I may have missed something, please do let me know what's the best way to fix.

[0] https://lore.kernel.org/all/24ec3728-9720-ae6a-9ff5-3e2e13a96f76@gmail.com/

[1] https://lore.kernel.org/all/20230424102546.1604484-1-d-gole@ti.com/

>
> Guenter

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

