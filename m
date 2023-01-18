Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE2670F84
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjARBHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjARBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:06:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B33C288;
        Tue, 17 Jan 2023 16:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=i4RkttW8fJDbyZOT5cX4fAabf2Wi+aZdAXMv1JEZ7Hc=; b=NXLSsL9V7Bo6BKRF5Y9jfRUgrQ
        pdCFL6s8KfhkjazcKLSqN3u1CkBz9NhcL5GM5NW0EQ+djyO/iwuePSLZQild575wArFqbPjMZompR
        WH33mY7hWiO52lvdZ/OAf2WWLZKJpxh4UP/c289so17o7EycuDkdKK0wOKDZeTxhVOkm4oh9ExlNY
        bxg+1afaacpFIk8tP/AuMF5nYbEehFugAtZcopEm/zNFVZvNtPadNisTjH6jLW7UxLqaV0lEP5ysC
        wVpaagAKfTwOYFD5+lVEHhx0mu6LzWHbBrhVczSydBh9yBJMUIKAzxymYxNH5IurEOnjNZgyOD4oS
        mGUH9rFQ==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHwkp-00GNFP-E9; Wed, 18 Jan 2023 00:56:39 +0000
Message-ID: <19d40c05-4e97-a739-47b4-689b047841fc@infradead.org>
Date:   Tue, 17 Jan 2023 16:56:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] rtc: sunplus: fix format string for printing resource
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230117172450.2938962-1-arnd@kernel.org>
 <Y8bhApoC4Bmgtjoq@mail.local>
 <54f13745-bec5-8777-4212-6f093947f146@infradead.org>
 <589415b2-ddf2-44e5-bca5-5971f8ab9576@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <589415b2-ddf2-44e5-bca5-5971f8ab9576@app.fastmail.com>
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



On 1/17/23 11:36, Arnd Bergmann wrote:
> On Tue, Jan 17, 2023, at 19:24, Randy Dunlap wrote:
>> On 1/17/23 09:55, Alexandre Belloni wrote:
>>> On 17/01/2023 18:24:44+0100, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> On 32-bit architectures with 64-bit resource_size_t, sp_rtc_probe()
>>>> causes a compiler warning:
>>>>
>>>> drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
>>>> drivers/rtc/rtc-sunplus.c:243:33: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>>>>   243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
>>>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> The best way to print a resource is the special %pR format string,
>>>> and similarly to print a pointer we can use %p and avoid the cast.
>>>>
>>>
>>> I got this one this morning, which one is more correct? :)
>>> https://lore.kernel.org/all/20230117054232.24023-1-rdunlap@infradead.org/
> 
> Both are equally correct, it's just a preference.
> 
>> I prefer my handling of res->start and Arnd's no-cast handling of reg_base.
>> IMO using "%pR" prints too much info, but that's more up to the file's author
>> or maintainer...
> 
> Right, I could have equally well picked the %pap version, and just
> went for brevity in the source. It's only pr_debug(), so very few
> users are going to actually see the output.

Alexandre, sounds like you should just go with Arnd's patch.

-- 
~Randy
