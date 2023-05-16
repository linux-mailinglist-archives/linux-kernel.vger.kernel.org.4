Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9708704AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEPKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:44:15 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92689D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:44:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id EAAD21863DAE;
        Tue, 16 May 2023 13:44:09 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9VESRIB6IE8L; Tue, 16 May 2023 13:44:09 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 647B81863DA7;
        Tue, 16 May 2023 13:44:09 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HuHyhYPGR5Z8; Tue, 16 May 2023 13:44:09 +0300 (MSK)
Received: from [192.168.0.144] (host-189-99.skynet-msk.ru [91.227.189.99])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 3243C1863D9B;
        Tue, 16 May 2023 13:44:07 +0300 (MSK)
Message-ID: <ba0ad96d-6515-66e3-e140-cd7c3999577e@astralinux.ru>
Date:   Tue, 16 May 2023 13:44:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10] staging: gasket: interrupt: Clean interrupt_data
 after free
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230515122950.100564-1-eesina@astralinux.ru>
 <2023051546-churn-obstinate-20af@gregkh>
From:   Ekaterina Esina <eesina@astralinux.ru>
In-Reply-To: <2023051546-churn-obstinate-20af@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 16:02, Greg Kroah-Hartman wrote:
> On Mon, May 15, 2023 at 03:29:50PM +0300, Esina Ekaterina wrote:
>> Add interrupt_data = NULL after kfree(interrupt_data) in
>> gasket_interrupt_init. It is needed to avoid double free
>> in gasket_interrupt_cleanup, there is a check for NULL
>> before kfree(interrupt_data).
>>
>> Found by Astra Linux on behalf of Linux Verification Center
>> (linuxtesting.org) with SVACE.
>>
>> Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
>> Signed-off-by: Esina Ekaterina <eesina@astralinux.ru>
>> ---
>>   drivers/staging/gasket/gasket_interrupt.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
>> index 864342acfd86..48b664b9134a 100644
>> --- a/drivers/staging/gasket/gasket_interrupt.c
>> +++ b/drivers/staging/gasket/gasket_interrupt.c
>> @@ -337,6 +337,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>>   			sizeof(*interrupt_data->eventfd_ctxs), GFP_KERNEL);
>>   	if (!interrupt_data->eventfd_ctxs) {
>>   		kfree(interrupt_data);
>> +		interrupt_data = NULL;
>>   		return -ENOMEM;
>>   	}
>>   
>> @@ -346,6 +347,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>>   	if (!interrupt_data->interrupt_counts) {
>>   		kfree(interrupt_data->eventfd_ctxs);
>>   		kfree(interrupt_data);
>> +		interrupt_data = NULL;
>>   		return -ENOMEM;
>>   	}
>>   
>> -- 
>> 2.40.1
> 
> Also, your tool is wrong, this is not a correct fix at all.
> 
> How did you test it?  Why is your tool spitting out incorrect code?  Why
> are you not verifying it's output before asking others to do so?
> 
> Please don't do this anymore, it's wasteful on our side, right?  Please
> take the time to review existing changes for problems, that would be
> more useful overall to everyone.
> 
> thanks,
> 
> greg k-h

I apologize, there is a mistake. It should've been 
gasket_dev->interrupt_data = NULL istead of interrupt_data = NULL

Best regards,
Ekaterina Esina
