Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EA6D61C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjDDNAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjDDM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B9E1722
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B306327D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A6FC433D2;
        Tue,  4 Apr 2023 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680613197;
        bh=fodprQ7jZamAExd0tbBd2YeF/mqBlgT3HS3YDEqP/l4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GsdaYq2XFlMx+HRvmxtB553rQGPAFzIitFwP2bR8792kgZHHJkKIDD1tuvAOo3mAq
         9G5Y6RynxSl++UooCpq+Rnwf7wHwZgkaruW/hmNK7CqH07UAEdkZFT2zgsJmQkZJdL
         uGYXGTgCHMnoTe6shJjfAY4kge5cr2rQHKbrCiWKGGXH310ZWRySsDTNEvi7Sdcf4t
         dmEj3sLy1XlR5OifDfOgkFItqtFvvVt26ulD1Bmj0NjETRNvw6e7S3+GwqkQzNZKB0
         ymTqu+9LLL/Jz9lZeliGLQ+3lqksloFK3c4mOmz3Z9wqFsuLEPaBtVXEoUTrxQgEek
         TJbj10D5cC+Dw==
Message-ID: <87cc8d92-0345-bc4b-60e8-1ca016691371@kernel.org>
Date:   Tue, 4 Apr 2023 15:59:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module
 instead of built-in
To:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230404084259.13752-1-rogerq@kernel.org>
 <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
 <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
 <076b5775-18eb-05b3-b803-c54420b3e5fe@kernel.org>
 <08b12571-5ca6-4e3d-8c56-5fc48827d17a@app.fastmail.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <08b12571-5ca6-4e3d-8c56-5fc48827d17a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2023 15:14, Arnd Bergmann wrote:
> On Tue, Apr 4, 2023, at 13:46, Roger Quadros wrote:
>> On 04/04/2023 13:01, Krzysztof Kozlowski wrote:
>>> On 04/04/2023 10:51, Arnd Bergmann wrote:
>>>> On Tue, Apr 4, 2023, at 10:42, Roger Quadros wrote:
>>>>> USB_DWC3 is not required for boot on most platforms make it
>>>>> as a module instead of built-in.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>> ---
>>>>
>>>> Does this save a significant amount of vmlinux size? Since this
>>
>> vmlinux size reduces by ~529KB
> 
> That seems really high, so I had a look at what's going on.

It was based on the configuration we are using at TI.

(as built-in)

$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
14616949	5285870	 491776	20394595	1373263	vmlinux
$ ls -l vmlinux
-rwxrwxr-x 1 roger roger 120866544 Apr  4 15:54 vmlinux

(as module)

$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
14550571	5258106	 491776	20300453	135c2a5	vmlinux
$ ls -l vmlinux
-rwxrwxr-x 1 roger roger 120324528 Apr  4 15:52 vmlinux


$ diff built-in-config module-config
5547c5547
< CONFIG_USB_XHCI_PLATFORM=y
---
> CONFIG_USB_XHCI_PLATFORM=m
5614c5614
< CONFIG_USB_DWC3=y
---
> CONFIG_USB_DWC3=m


> 
> Testing this on multi_v7_defconfig with gcc-13, I only see
> 163KB difference in (uncompressed) vmlinux file size, or 140KB
> in the output of 'size vmlinux'. This still seems high, and
> looking more closely I find that a lot of that is for either
> Gadget mode or debugfs, while the driver itself is not all
> that big (most of the host logic is in the xhci driver).
> 
> Turning off gadget mode altogether would save 248KB
> in 'size vmlinux' output, but would also prevent us
> from enabling gadget driver modules, which is not great
> either.
> 
> I tried setting CONFIG_USB_GADGET=m, but that makes
> DWC3 and DWC2 host-only and turns CHIPIDEA into a loadable
> module, so we probably don't want to do that either:
> 
> -CONFIG_USB_EHCI_HCD_OMAP=y
> +CONFIG_USB_EHCI_HCD_OMAP=m
> -CONFIG_USB_DWC3_DUAL_ROLE=y
> +CONFIG_USB_DWC3_HOST=y
> +CONFIG_USB_DWC2_HOST=y
> -CONFIG_USB_DWC2_DUAL_ROLE=y
> -CONFIG_USB_CHIPIDEA=y
> +CONFIG_USB_CHIPIDEA=m
> -CONFIG_USB_ISP1761_UDC=y
> -CONFIG_USB_ISP1760_DUAL_ROLE=y
> +CONFIG_USB_ISP1760_HOST_ROLE=y
> 
>     Arnd

cheers,
-roger
