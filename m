Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1174E969
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGKIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGKIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:52:29 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92591AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:52:28 -0700 (PDT)
Received: from 82-132-229-125.dab.02.net ([82.132.229.125] helo=[192.168.252.81])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qJ96f-007H2X-LE; Tue, 11 Jul 2023 09:52:25 +0100
Message-ID: <eb115b92-35f7-2ea7-0cd2-b825e769186e@codethink.co.uk>
Date:   Tue, 11 Jul 2023 09:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 5/5] i3c: dw; add print if cannot get resources
Content-Language: en-GB
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
 <20230621162005.473049-6-ben.dooks@codethink.co.uk>
 <2023070421375530819b2c@mail.local>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <2023070421375530819b2c@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 22:37, Alexandre Belloni wrote:
> Hello,
> 
> Please fix the typo in the subject.
> 
> On 21/06/2023 17:20:05+0100, Ben Dooks wrote:
>> The devm_reset_control_get_optional_exclusive() call does
>> not print any errors, neiterh does the clk_prepare_enable
> Also fix this one.
> 
>> or devm_request_irq() call.
>>
>> Add some basic error printing to make the probe failures
>> easier to debug.
> 
> I guess all those dev_err could be dev_dbg so we don't litter the driver
> with strings that will only ever be useful during bring up.

I think dev_err_probe() is probably the right one as we aren't going
to want to warn on any sort of probe defer errors. However most drivers
are printing errors if there are resources missing so I think an error
is the best way to report issues.

I'll correct the spelling when the discussions about the correct way to
print errors is.

>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   drivers/i3c/master/dw-i3c-master.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
>> index 9332ae5f6419..ffc84ff6225c 100644
>> --- a/drivers/i3c/master/dw-i3c-master.c
>> +++ b/drivers/i3c/master/dw-i3c-master.c
>> @@ -1429,12 +1429,16 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>>   
>>   	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>>   								    "core_rst");
>> -	if (IS_ERR(master->core_rst))
>> +	if (IS_ERR(master->core_rst)) {
>> +		dev_err(&pdev->dev, "cannot get core_rst\n");
>>   		return PTR_ERR(master->core_rst);
>> +	}
>>   
>>   	ret = clk_prepare_enable(master->core_clk);
>> -	if (ret)
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "cannot enable core_clk\n");
>>   		goto err_disable_core_clk;
>> +	}
>>   
>>   	reset_control_deassert(master->core_rst);
>>   
>> @@ -1446,8 +1450,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>>   	ret = devm_request_irq(&pdev->dev, irq,
>>   			       dw_i3c_master_irq_handler, 0,
>>   			       dev_name(&pdev->dev), master);
>> -	if (ret)
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "cannot get irq\n");
>>   		goto err_assert_rst;
>> +	}
>>   
>>   	platform_set_drvdata(pdev, master);
>>   
>> -- 
>> 2.40.1
>>
> 

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

