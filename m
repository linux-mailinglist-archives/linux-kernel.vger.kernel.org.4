Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA66A35AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBZXtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBZXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:49:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0686BC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9PejPGTxL25SJB36o+PnBSWRHGUsacmQ1zn1iBthv50=; b=Xcc8YhLeAEHdmGwUj6CbVT4PU3
        1sQtfKK2JApbNilAsDLUWQvhueBdGvVBEGLaFFYs6/F6EjDZk/IWB5lB2ChZRKmmBSbM+M4evUqBN
        FjQJh6FBswFW9nj6FPGDWcJFyjwEaEX1/thgbpch0r97l523IiYypAt+ZD379ofurD3aFbTcpQVdg
        ErAnBOtHrKV6wbfDKR6isL61SRJhb5fe7C28MI5qLMkyhhTXZYDoJZJuyPso4PjspSGn65Vby0MfS
        gf6JUHqCxyASswJ5aLyfOGLKGkg9BPkOvYIUr87yQ4xEfDxhAsdMD5zqNt5govwxAPmiy3vl4PwRr
        Ft+iNiPQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWQlj-0081vD-MH; Sun, 26 Feb 2023 23:49:28 +0000
Message-ID: <daa6520c-a009-a68e-42c8-6f690b02a7cd@infradead.org>
Date:   Sun, 26 Feb 2023 15:49:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead
 of depending on it
Content-Language: en-US
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-2-rdunlap@infradead.org> <Y/vkOCLCeubl6B34@minyard.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y/vkOCLCeubl6B34@minyard.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/23 14:59, Corey Minyard wrote:
> On Sat, Feb 25, 2023 at 09:39:46PM -0800, Randy Dunlap wrote:
>> REGMAP is a hidden (not user visible) symbol. Users cannot set it
>> directly thru "make *config", so drivers should select it instead of
>> depending on it if they need it.
>>
>> Consistently using "select" or "depends on" can also help reduce
>> Kconfig circular dependency issues.
>>
>> Therefore, change the use of "depends on REGMAP_MMIO" to
>> "select REGMAP_MMIO", which will also set REGMAP.
> 
> This seems reasonable.  I can take it into my tree, or..

Just take it, please. I expect that each subsystem maintainer
will take their respective patches.

> Acked-by: Corey Minyard <cminyard@mvista.com>
> 
>>
>> Fixes: eb994594bc22 ("ipmi: bt-bmc: Use a regmap for register access")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: Corey Minyard <minyard@acm.org>
>> Cc: openipmi-developer@lists.sourceforge.net
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  drivers/char/ipmi/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff -- a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
>> --- a/drivers/char/ipmi/Kconfig
>> +++ b/drivers/char/ipmi/Kconfig
>> @@ -162,7 +162,8 @@ config IPMI_KCS_BMC_SERIO
>>  
>>  config ASPEED_BT_IPMI_BMC
>>  	depends on ARCH_ASPEED || COMPILE_TEST
>> -	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
>> +	depends on MFD_SYSCON
>> +	select REGMAP_MMIO
>>  	tristate "BT IPMI bmc driver"
>>  	help
>>  	  Provides a driver for the BT (Block Transfer) IPMI interface

-- 
~Randy
