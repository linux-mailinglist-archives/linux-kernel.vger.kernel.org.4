Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28212739666
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFVE02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFVE01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8419F;
        Wed, 21 Jun 2023 21:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AB061758;
        Thu, 22 Jun 2023 04:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5276EC433C8;
        Thu, 22 Jun 2023 04:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687407985;
        bh=wbSerNWu2OAwv80OHJmGq194acVpz6OdwYe2sfJ0nX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sQ5WM1lYl9VmXRoERRZDKqzBakqeClJxd+kHFI7V9CaGlWmDl4d/ex8LiwcUlqHSV
         BZ0xwUvJkqxaZE3ZPtn9IWLoGXZvxQDnjU+/oPMmu5o1zebbIT82I8scGbYwwWqzv4
         LOz79xnYWXwu6gBb8WEwY7fKTTN5iouT4PuOA4m0mwiJnCFtGGhK5sCQVMeIztNEAL
         va2JI4lz5BEhtqRmDxsXSeHKPtqh9pLY9W8GwPp56rkNGhxpCoIwDSuekZFyto7aPQ
         JTXvSO0YrDJFAO1OrV0Q1q2HNEurNuo4femNHW7V1JtS8fJ150RPCZA4Xr7B22R4U/
         ewODsf3tiyWhw==
Message-ID: <78cce73d-16d1-e357-bee7-2176479604f4@kernel.org>
Date:   Thu, 22 Jun 2023 13:26:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
 <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
 <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
 <167e83a0-8666-27af-5e2c-4ddda917795a@roeck-us.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <167e83a0-8666-27af-5e2c-4ddda917795a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 12:01, Guenter Roeck wrote:
> On 6/21/23 17:57, Damien Le Moal wrote:
>> On 6/22/23 01:51, Guenter Roeck wrote:
>>> On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
>>>> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
>>>> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
>>>> so other arches can't be enabled.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>> Tested on allmodconfig build. Not sure if there's other MIPS configs
>>>> where this doesn't work. We'll see what 0-day says.
>>>
>>> Odd, in next-20230621 I get:
>>>
>>> Building mips:allmodconfig ... failed
>>
>> Indeed odd. Given that this is an allmodconfig, I would assume that
>> CONFIG_CAVIUM_OCTEON_SOC is set ?
>>
> 
> No, it is not. CONFIG_CAVIUM_OCTEON_SOC is a choice option,
> meaning only one of the choices can be set, and mips:allmodconfig
> selects a different choice.

OK. Then I think I need to drop this patch as I do not see how to allow
COMPILE_TEST without CONFIG_CAVIUM_OCTEON_SOC being set.

Rob ?

> 
> Guenter
> 
>>> --------------
>>> Error log:
>>> ERROR: modpost: "__udivdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
>>> ERROR: modpost: "octeon_get_io_clock_rate" [drivers/ata/pata_octeon_cf.ko] undefined!
>>> ERROR: modpost: "__tracepoint_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
>>> ERROR: modpost: "__traceiter_ata_bmdma_stop" [drivers/ata/pata_octeon_cf.ko] undefined!
>>> ERROR: modpost: "__divdi3" [drivers/ata/pata_octeon_cf.ko] undefined!
>>> make[2]: [scripts/Makefile.modpost:144: Module.symvers] Error 1 (ignored)
>>> make[2]: *** No rule to make target 'kernel/locking/locktorture.ko', needed by '__modfinal'.  Stop.
>>> make[1]: [Makefile:1933: modules] Error 2 (ignored)
>>>
>>> Guenter
>>
> 

-- 
Damien Le Moal
Western Digital Research

