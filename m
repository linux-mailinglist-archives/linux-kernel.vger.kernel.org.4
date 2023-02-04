Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5EC68AB69
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 17:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjBDQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 11:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDQyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:54:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D82DE4C;
        Sat,  4 Feb 2023 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mtAU4WjAVO0TWvJMqe0ixXT1gJ7xSV6/kS2P8d/VJYQ=; b=36usuTuRmoMs3aWje7ufuTbBc0
        TY7XP/4PwOImo5G7W+rwnEphFMttIQGTcMoZFf3tLaiIXMe7BLPP3thu3UTQE3/NTlxiWn6Lninld
        equzVdw/8HOMN9ED7yJe/R7JdTQVAAkrVqoMabOahIzblNtMQEMKwUczTyajstqtfQAMIyV/H+40A
        J2NaEYRofOMe0nk6fTpGiCDdbyQDw6TBuGtJcNad+H9GbS/1MWnwlT1GuVS/eaMqYQQtA6VV6UPHA
        4TxKp8P6ioQBj8hnHIIWqTjQcrG7GeQ1nQtxx1GDQnzJRHFwDRaSSwwv6/MiUhNuTUZ+mnBlUUZc2
        m3zy07/A==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOLny-005POp-B4; Sat, 04 Feb 2023 16:54:22 +0000
Message-ID: <2d9a36e7-4518-a23f-9f0c-84b830e57d51@infradead.org>
Date:   Sat, 4 Feb 2023 08:54:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: sunxi: select CONFIG_PM
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        sparclinux <sparclinux@vger.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230130130453.379749-1-arnd@kernel.org>
 <46dafb64-81d2-c084-97c5-8d01e8b9785b@infradead.org>
 <e2c5a0db-aa25-496c-9a5e-4e996d908dc9@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e2c5a0db-aa25-496c-9a5e-4e996d908dc9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/23 02:38, Arnd Bergmann wrote:
> On Sat, Feb 4, 2023, at 08:47, Randy Dunlap wrote:
>> On 1/30/23 05:04, Arnd Bergmann wrote:
>>
>> Apparently sparc32 does not support PM (arch/sparc/Kconfig):
>>
>> if SPARC64
>> source "kernel/power/Kconfig"
>> endif
>>
>> so I think that SUN20I_PPU should also depend on !SPARC32.
>> Does that make sense?
> 
> I would suggest working around this in arch/sparc/ instead
> of every driver that uses 'select PM', perhaps something like
> 
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -283,7 +283,7 @@ config ARCH_FORCE_MAX_ORDER
>           This config option is actually maximum order plus one. For example,
>           a value of 13 means that the largest free memory block is 2^12 pages.
>  
> -if SPARC64
> +if SPARC64 || COMPILE_TEST
>  source "kernel/power/Kconfig"
>  endif
>

That looks good. Thanks.

> The issue does not happen anywhere else, as it's fine if
> kernel/power/Kconfig is not included at all. I'm also not too
> worried about random sparc32 configs since it's pretty much impossible
> to build a sparc32 allmodconfig or randconfig, with all the other
> bugs that runs into.

OK/ack.

-- 
~Randy
