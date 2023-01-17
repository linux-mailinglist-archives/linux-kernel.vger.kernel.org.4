Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBD66E6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjAQTSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjAQTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:11:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17E37B55;
        Tue, 17 Jan 2023 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Fw8ToiXtlXOF2nBnzsWFVHyxc/MXeE65vU/PQZripck=; b=S+5wJzzZMBzIqx8qubJw7UJ7ri
        kcgS9JLFhwlxnYroTEQZrM2zugGlhdGdhGSmDgYMTebYMYdrha0PX78AvF0t3YVvgaU9qcAlk3Gs8
        V0nk641gnA+KaYcK31R6HDyOy1t54OhnVurSJzYLR+ffAghX6xNqgOCydlJFzs3CDrfV1S+56keaK
        gNhVIzFCQ7pAzo2aXblOpFEU6r1F0IIkVVf+4MyWad+XNTuMUOF7zj7krUpO+gLB3O9+ugtm/QzEn
        jt9geOtAsj0YFRs6EyZvFwrSvO8GC5bvPLxHiOL5z36Q+SgRIx57ybFYH9UBvwQrCFoL8QVUEtGSo
        sW9UtLYA==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqdf-00FQbU-15; Tue, 17 Jan 2023 18:24:51 +0000
Message-ID: <54f13745-bec5-8777-4212-6f093947f146@infradead.org>
Date:   Tue, 17 Jan 2023 10:24:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] rtc: sunplus: fix format string for printing resource
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117172450.2938962-1-arnd@kernel.org>
 <Y8bhApoC4Bmgtjoq@mail.local>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y8bhApoC4Bmgtjoq@mail.local>
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



On 1/17/23 09:55, Alexandre Belloni wrote:
> On 17/01/2023 18:24:44+0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> On 32-bit architectures with 64-bit resource_size_t, sp_rtc_probe()
>> causes a compiler warning:
>>
>> drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
>> drivers/rtc/rtc-sunplus.c:243:33: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>>   243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> The best way to print a resource is the special %pR format string,
>> and similarly to print a pointer we can use %p and avoid the cast.
>>
> 
> I got this one this morning, which one is more correct? :)
> https://lore.kernel.org/all/20230117054232.24023-1-rdunlap@infradead.org/

I prefer my handling of res->start and Arnd's no-cast handling of reg_base.
IMO using "%pR" prints too much info, but that's more up to the file's author
or maintainer...


How's that?  :)

>> Fixes: fad6cbe9b2b4 ("rtc: Add driver for RTC in Sunplus SP7021")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/rtc/rtc-sunplus.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-sunplus.c b/drivers/rtc/rtc-sunplus.c
>> index e8e2ab1103fc..4b578e4d44f6 100644
>> --- a/drivers/rtc/rtc-sunplus.c
>> +++ b/drivers/rtc/rtc-sunplus.c
>> @@ -240,8 +240,8 @@ static int sp_rtc_probe(struct platform_device *plat_dev)
>>  	if (IS_ERR(sp_rtc->reg_base))
>>  		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->reg_base),
>>  					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
>> -	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
>> -		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
>> +	dev_dbg(&plat_dev->dev, "res = %pR, reg_base = %p\n",
>> +		sp_rtc->res, sp_rtc->reg_base);
>>  
>>  	sp_rtc->irq = platform_get_irq(plat_dev, 0);
>>  	if (sp_rtc->irq < 0)
>> -- 
>> 2.39.0
>>
> 

-- 
~Randy
