Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D736E75E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjDSJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjDSJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:00:52 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E4B5B9D;
        Wed, 19 Apr 2023 02:00:43 -0700 (PDT)
Received: from [192.168.1.103] (178.176.73.14) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 19 Apr
 2023 12:00:35 +0300
Subject: Re: [PATCH] usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Li Yang <lidaxian@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Dongliang Mu <dzm91@hust.edu.cn>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230418090758.18756-1-lidaxian@hust.edu.cn>
 <96c7edf5-e1cc-03f6-ee52-ef373ae9d820@omp.ru>
Organization: Open Mobile Platform
Message-ID: <eb33b694-b422-a9d5-35dc-2f8af79d47f1@omp.ru>
Date:   Wed, 19 Apr 2023 12:00:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <96c7edf5-e1cc-03f6-ee52-ef373ae9d820@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.73.14]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 04/19/2023 08:49:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 176827 [Apr 19 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 509 509 b12bcaa7ba85624b485f2b6b92324b70964a1c65
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.14 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.14 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;178.176.73.14:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.14
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2023 08:53:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/19/2023 6:14:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 2:17 PM, Sergey Shtylyov wrote:
[...]
>> Smatch reports:
>> drivers/usb/phy/phy-tahvo.c: tahvo_usb_probe()
>> warn: missing unwind goto?
>>
>> After geting irq, if ret < 0, it will return without error handling to
>> free memory.
>> Just add error handling to fix this problem.
> 
>    Oops, I'm sorry for missing that one...
> 
>> Fixes: 0d45a1373e66 ("usb: phy: tahvo: add IRQ check")
>> Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> The issue is found by static analysis, and the patch remains untest.
>> ---
>>  drivers/usb/phy/phy-tahvo.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
>> index f2d2cc586c5b..184a5f3d7473 100644
>> --- a/drivers/usb/phy/phy-tahvo.c
>> +++ b/drivers/usb/phy/phy-tahvo.c
>> @@ -390,8 +390,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>>  	dev_set_drvdata(&pdev->dev, tu);
>>  
>>  	tu->irq = ret = platform_get_irq(pdev, 0);
>> -	if (ret < 0)
>> -		return ret;
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "could not get irq: %d\n",
>> +				ret);
> 
>    Adding the error message needs another patch, strictly speaking...

   And if you look at platform_get_irq(), you'll see that it prints an error msg
itself...

[...]

MBR, Sergey
