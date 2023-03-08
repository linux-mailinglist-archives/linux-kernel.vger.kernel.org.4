Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB166AFDA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCHDvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHDvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:51:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C63A8382;
        Tue,  7 Mar 2023 19:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/mWTJhwI3ECRxvq10RxYV3el2FK8VbqEYNOHUpoMPMY=; b=WIRvsl3sDr6h2G0SCbUzG7iFV7
        qXyrs1OZayoRULdN+H3BtXEX1TnDJZOkuSUMvZmFaQsH0ZjBsF54inCPOFR7y81EAxUpCGyl5a5Pz
        R4l/XPTZsaaymXgRrkL0nuc7lQFL0mWOgvBtWXdCIeyOw7F69tWfbg+nwuOWqjmafCPbEU4hEvD8z
        zAfHHClKQWTywyopTX/D7uGR221oE+b5KDq4TaFgVJYoIzYgR1A7SdqQqjiPFtbXNP6W0Who1D7t0
        dLXgsSm7TR9WY7tsHmTBuETwJysHVzyOfPdmX9mzan6ZY3TbLDzg/E8sB6kyIcag06PRSgFD9tmk3
        D20mZYyw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZkq4-003Nu7-GL; Wed, 08 Mar 2023 03:51:40 +0000
Message-ID: <e7a4c583-c6ad-b1f6-c6fc-f770f9184b64@infradead.org>
Date:   Tue, 7 Mar 2023 19:51:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org>
 <556ce787-80eb-dc48-f8d6-83e415538e36@opensource.wdc.com>
 <f8f291d9-2723-4ab8-3020-49018757d470@gmail.com>
 <62852ee1-3763-3323-c3a8-f1e84f70204a@infradead.org>
 <c7941231-8ebd-dea5-81f8-3180cfc3f286@gmail.com>
 <1d858dbb-ae85-95a0-3e46-b67017733c04@infradead.org>
 <db3b3412-9616-d13c-3374-48647325e057@infradead.org>
 <7280914e-59e3-ba6d-4324-a29c1c0b4ce8@gmail.com>
 <2ebe4bc5-c11c-89b1-2644-358dc12bdfa5@infradead.org>
 <d3fb242e-646e-50b5-7dba-17b228bb32aa@opensource.wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d3fb242e-646e-50b5-7dba-17b228bb32aa@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 19:42, Damien Le Moal wrote:
> On 3/8/23 12:23, Randy Dunlap wrote:
>>>> OK, I don't know how it happened. I cannot reproduce it now.
>>>> The failing .config files has CONFIG_MMU is not set (for RV32I), which
>>>> appears to be impossible.
>>> These patches add `CONFIG_MMU is not set` (for RV32I).
>>> But no worries it seems to be a non issue  now.
>>>
>>> Your thoughts Damien?
>>>
>>
>> Thanks for reminding me.
>>
>> With these 3 patches applied to linux-next-20230307,
>> I still get this build error.
> 
> Does this help ?
> 
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 2527cf5757ec..7796c5f1d109 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -4,7 +4,8 @@ config SOC_K210_SYSCTL
>         bool "Canaan Kendryte K210 SoC system controller"
>         depends on RISCV && SOC_CANAAN && OF
>         default SOC_CANAAN
> -        select PM
> -        select MFD_SYSCON
> +       select COMMON_CLK_K210
> +       select PM
> +       select MFD_SYSCON
>         help
>           Canaan Kendryte K210 SoC system controller driver.
> 
> (just noticed that there are whitespace errors here...)

Yes, this patch allows it to build cleanly.
Thanks.

I didn't test any of the below changes.

> Note that both the sysctl and clk driver depend on RISCV. I think these should
> probably also depend on 64BIT, and eventually add a "|| COMPILE_TEST" as well.
> So something like this:
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index b6c5bf69a2b2..657a36d2640d 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -431,7 +431,7 @@ config COMMON_CLK_FIXED_MMIO
> 
>  config COMMON_CLK_K210
>         bool "Clock driver for the Canaan Kendryte K210 SoC"
> -       depends on OF && RISCV && SOC_CANAAN
> +       depends on OF && RISCV && SOC_CANAAN && (64BIT || COMPILE_TEST)
>         default SOC_CANAAN
>         help
>           Support for the Canaan Kendryte K210 RISC-V SoC clocks.
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 2527cf5757ec..1745a614d2a7 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -2,9 +2,10 @@
> 
>  config SOC_K210_SYSCTL
>         bool "Canaan Kendryte K210 SoC system controller"
> -       depends on RISCV && SOC_CANAAN && OF
> +       depends on RISCV && SOC_CANAAN && OF && (64BIT || COMPILE_TEST)
>         default SOC_CANAAN
> -        select PM
> -        select MFD_SYSCON
> +       select COMMON_CLK_K210
> +       select PM
> +       select MFD_SYSCON
>         help
>           Canaan Kendryte K210 SoC system controller driver.
> 
> COMPILE_TEST is optional though, but I do not see any reason why not eventhough
> in practice these drivers will likely never end up in 32-bits SoC.
> 
> 

-- 
~Randy
