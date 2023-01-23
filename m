Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3367898B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjAWV2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjAWV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:28:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734629768;
        Mon, 23 Jan 2023 13:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=H3eXFipHsSf5mXLYhxHs1ARXh2uZcFDldjjmb+JSZds=; b=WxCR35uVG/MHKyfylbTGXofvgy
        KbP19KdHikwwEEKYXwzQ3wMqB4bG0r9Nszcz1IhUPbpC8z1BMf+Jl71dqO4u1XHpyB6tpN8U+Cev+
        APcUGdIdctJujiyDtiYCIiGINpouK+AR7O1OxlIqlUtW+QI9exsyVlC0/BGodgBT8TSwtPYNmW7D3
        +scgoI6ZLYMBbBD1vAwL1ZFlgcQ7cZoH+5NdNoF7E/jhOALR+S6PbW+s5PDNtNlLiK0Pgq714g21v
        w/nGJgxpfg5mbcoDZJhrvDEWn7DX7gDd7JpOLREDBZUEJSvbel3xmUL7wP2MSZRPWWa9UrxWtNS6+
        BYF5wWNQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK4MF-001VoA-PM; Mon, 23 Jan 2023 21:28:03 +0000
Message-ID: <678ad23e-e7b6-a570-897b-81f1f3ef7224@infradead.org>
Date:   Mon, 23 Jan 2023 13:28:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] printk: Document that CONFIG_BOOT_PRINTK_DELAY required
 for boot_delay=
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230123204419.GA980727@bhelgaas>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230123204419.GA980727@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 12:44, Bjorn Helgaas wrote:
> On Mon, Jan 23, 2023 at 06:18:26PM +0000, Matthew Wilcox wrote:
>> On Mon, Jan 23, 2023 at 12:04:40PM -0600, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Document the fact that CONFIG_BOOT_PRINTK_DELAY must be enabled for the
>>> "boot_delay" kernel parameter to work.  Also mention that "lpj=" may be
>>> necessary.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 6cfa6e3996cf..b0b40b6a765c 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -480,8 +480,9 @@
>>>  			See Documentation/block/cmdline-partition.rst
>>>  
>>>  	boot_delay=	Milliseconds to delay each printk during boot.
>>> -			Values larger than 10 seconds (10000) are changed to
>>> -			no delay (0).
>>> +			Enable CONFIG_BOOT_PRINTK_DELAY and also specify
>>> +			"lpj=".  Boot_delay values larger than 10 seconds
>>> +			(10000) are changed to no delay (0).
>>
>> That's counterintuitive.  I'd understand clamping it to 10 seconds,
>> but not setting it to zero.
> 
> I'm not opposed to setting it to 10 sec instead of 0, but that came
> from bfe8df3d314b ("slow down printk during boot"); added Randy in
> case he wants to comment.

I'm not opposed to a patch that clamps the max boot_delay to 10 seconds.
I expect that my thinking in 2007 was that any larger value was just some
random/garbage value so it should be ignored.

>> Also, there are two ways of reading this.  One is that by specifying
>> boot_delay=, lpj= is set to a sane value.  The other (intended?) is
>> that in order to use this option, you must also specify lpj=.

You probably should specify lpj= (e.g., from some previous boot log),
as indicated in the BOOT_PRINTK_DELAY Kconfig help text in
lib/Kconfig.debug.

> Maybe this is better?
> 
>  	boot_delay=	Milliseconds to delay each printk during boot.
> -			Values larger than 10 seconds (10000) are changed to
> -			no delay (0).
> +			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
> +			and you may also have to specify "lpj=".  Boot_delay
> +			values larger than 10 seconds (10000) are changed
> +			to no delay (0).
>  			Format: integer

That's fine with me.

-- 
~Randy
