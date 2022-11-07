Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AD61EE04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiKGJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:01:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34612AFA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BBD60F1C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF63C433D6;
        Mon,  7 Nov 2022 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811699;
        bh=SPtH20/96GdEvJGs3c70fuLCrm80coIng1kX3ldY4a0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YmhjOp9cdbqjRcY6UGQnj8sR06ymK0olBJdZz81umlUEkTpCg+qydNcahxqIfbJjn
         neDY9uWn5nVGhAW1RdREC/5ZWtCuZCrHnllqe2M+yWElig/4Qwd3ygJ2pl+uFP0NSR
         66J9gLXXw3jFXm42ZgFFFHKaF5ksrxJ4yeFb/eXvd2tqT2dw+qXsz4408twr3ayQlh
         b0gMKTGB3mQdBxhcW3syOQaixNgpfzuemJNOLjK3Qiwg8sGsUO+dG48q3RPabai63m
         ZnfAIrLkP76QHagXzfHbJ4SNGQ/sKXjf57BZCOH+wYsP3Ls+8Zoaw4lcWqKSa/rlSQ
         Z6lT3tFIsprwA==
Message-ID: <f5645515-ccc2-2fd9-8943-f514b20e0c98@kernel.org>
Date:   Mon, 7 Nov 2022 11:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mtd: onenand: omap2: add dependency on GPMC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20221104194934.384371-1-krzysztof.kozlowski@linaro.org>
 <eef60a26-ef23-1b79-22f7-adaee3be9360@kernel.org>
 <742d9ff1-8af8-8fa1-4f37-4b50bd874e82@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <742d9ff1-8af8-8fa1-4f37-4b50bd874e82@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 10:55, Krzysztof Kozlowski wrote:
> On 07/11/2022 09:44, Roger Quadros wrote:
>> Hello Krzysztof,
>>
>> On 04/11/2022 21:49, Krzysztof Kozlowski wrote:
>>> OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
>>> OMAP GPMC driver, so the latter cannot be module if OneNAND driver is
>>> built-in:
>>>
>>>   /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
>>>   onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/mtd/nand/onenand/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
>>> index 34d9a7a82ad4..fa94c514626d 100644
>>> --- a/drivers/mtd/nand/onenand/Kconfig
>>> +++ b/drivers/mtd/nand/onenand/Kconfig
>>> @@ -26,6 +26,7 @@ config MTD_ONENAND_OMAP2
>>>  	tristate "OneNAND on OMAP2/OMAP3 support"
>>>  	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
>>>  	depends on OF || COMPILE_TEST
>>> +	depends on OMAP_GPMC || !OMAP_GPMC
>>
>> Why did you add !OMAP_GPMC?
>>
>> If OMAP_GPMC is not set we don't want to be able to build this driver correct?
> 
> It will build fine because of stubs, so building is not a problem. We
> just want to forbid having this built-in if OMAP_GPMC is a module. The
> question is whether this is a runtime dependency as well?

Yes, there is a runtime dependency. Without the OMAP_GPMC driver
this MTD_ONENAND_OMAP2 will not work.

cheers,
-roger
