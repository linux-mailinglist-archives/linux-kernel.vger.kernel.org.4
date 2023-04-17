Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD86E4570
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDQKmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDQKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:42:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB2900B;
        Mon, 17 Apr 2023 03:41:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 276C824E289;
        Mon, 17 Apr 2023 18:06:31 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 18:06:31 +0800
Received: from [192.168.125.87] (183.27.97.249) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 18:06:30 +0800
Message-ID: <83c5a35a-c646-cbc7-83f9-c02fcb24e069@starfivetech.com>
Date:   Mon, 17 Apr 2023 18:06:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/2] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be
 selected in a specified case
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@kvack.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "Necip Fazil Yildiran" <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230417074115.30786-1-hal.feng@starfivetech.com>
 <20230417074115.30786-2-hal.feng@starfivetech.com>
 <20230417-buckwheat-wilt-92a4e85a5ca0@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230417-buckwheat-wilt-92a4e85a5ca0@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 10:54:09 +0100, Conor Dooley wrote:
> On Mon, Apr 17, 2023 at 03:41:14PM +0800, Hal Feng wrote:
>> When (ARCH_STARFIVE [=n] && COMPILE_TEST [=y] && RESET_CONTROLLER [=n]),
>> RESET_STARFIVE_JH7110 can't be selected by CLK_STARFIVE_JH7110_SYS
>> and CLK_STARFIVE_JH7110_AON.
>> 
>> Considering RESET_STARFIVE_JH7110 is not a necessary option for compilation
>> test, we should select it only if ARCH_STARFIVE=y. Also, delete redundant
>> selected options of CLK_STARFIVE_JH7110_AON because these options are
>> already selected by the dependency.
>> 
>> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
>> Fixes: b2ab3c94f41f ("clk: starfive: Add StarFive JH7110 always-on clock driver")
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  drivers/clk/starfive/Kconfig | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
>> index 71c1148ee5f6..3fad4adee841 100644
>> --- a/drivers/clk/starfive/Kconfig
>> +++ b/drivers/clk/starfive/Kconfig
>> @@ -26,7 +26,7 @@ config CLK_STARFIVE_JH7110_SYS
>>  	depends on ARCH_STARFIVE || COMPILE_TEST
>>  	select AUXILIARY_BUS
>>  	select CLK_STARFIVE_JH71X0
>> -	select RESET_STARFIVE_JH7110
>> +	select RESET_STARFIVE_JH7110 if ARCH_STARFIVE
> 
> Hmm, I don't really follow the logic above.
> Why not just make the if be `if RESET_CONTROLLER` rather than
> ARCH_STARFIVE?
> I'm probably missing some obvious reason why not.

Note that RESET_CONTROLLER is selected by ARCH_STARFIVE. Thanks.

Best regards,
Hal
