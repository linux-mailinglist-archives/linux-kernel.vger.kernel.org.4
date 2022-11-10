Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB4624285
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKJMpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKJMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:45:29 -0500
Received: from radex-web.radex.nl (smtp.radex.nl [178.250.146.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C18EF3E084;
        Thu, 10 Nov 2022 04:45:28 -0800 (PST)
Received: from [192.168.1.35] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 2DAA4240A8;
        Thu, 10 Nov 2022 13:45:28 +0100 (CET)
Message-ID: <e0545783-0a8f-3cb7-2cae-ced85c91e51d@gmail.com>
Date:   Thu, 10 Nov 2022 13:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
 <20221110000643.xdoav4c4653x3tjd@synopsys.com>
Content-Language: en-US
In-Reply-To: <20221110000643.xdoav4c4653x3tjd@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NICE_REPLY_A,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry sent html with previous attempt)

On 10-11-2022 01:06, Thinh Nguyen wrote:
> Hi Ferry,
>
> On Wed, Nov 09, 2022, Ferry Toth wrote:
>> Since commit 0f010171
>> Dual Role support on Intel Merrifield platform broke due to rearranging
>> the call to dwc3_get_extcon().
>>
>> It appears to be caused by ulpi_read_id() on the first test write failing
>> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy via
>> DT when the test write fails and returns 0 in that case even if DT does not
>> provide the phy. Due to the timeout being masked dwc3 probe continues by
>> calling dwc3_core_soft_reset() followed by dwc3_get_extcon() which happens
>> to return -EPROBE_DEFER. On deferred probe ulpi_read_id() finally succeeds.
>>
>> This patch changes ulpi_read_id() to return -ETIMEDOUT when it occurs and
>> catches the error in dwc3_core_init(). It handles the error by calling
>> dwc3_core_soft_reset() after which it requests -EPROBE_DEFER. On deferred
>> probe ulpi_read_id() again succeeds.
>>
>> Signed-off-by: Ferry Toth<ftoth@exalondelft.nl>
>> ---
>>   drivers/usb/common/ulpi.c | 5 +++--
>>   drivers/usb/dwc3/core.c   | 5 ++++-
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
> Can you split the dwc3 change and ulpi change to separate patches?

Thanks for your comments.

I will send v2

>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>> index d7c8461976ce..d8f22bc2f9d0 100644
>> --- a/drivers/usb/common/ulpi.c
>> +++ b/drivers/usb/common/ulpi.c
>> @@ -206,8 +206,9 @@ static int ulpi_read_id(struct ulpi *ulpi)
>>   
>>   	/* Test the interface */
>>   	ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
>> -	if (ret < 0)
>> -		goto err;
>> +	if (ret < 0) {
>> +		return ret;
>> +	}
>>   
>>   	ret = ulpi_read(ulpi, ULPI_SCRATCH);
>>   	if (ret < 0)
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 648f1c570021..e293ef70039b 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1106,8 +1106,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   
>>   	if (!dwc->ulpi_ready) {
>>   		ret = dwc3_core_ulpi_init(dwc);
>> -		if (ret)
>> +		if (ret) {
>> +			dwc3_core_soft_reset(dwc);
> We shouldn't need to do soft reset here. The controller shouldn't be at
> a bad/incorrect state at this point to warrant a soft-reset. There will
> be a soft-reset when it goes through the initialization again.

It doesn't go through the initialization again unless we set 
-EPROBE_DEFER. And when we make ulpi_read_id() return -EPROBE_DEFER it 
will goto err0 here, so skips dwc3_core_soft_reset.

Do you mean you prefer something like:

if (ret) {

     if (ret == -ETIMEDOUT) ret = -EPROBE_DEFER;

     else goto err0;

}

>> +			ret = -EPROBE_DEFER;
> We shouldn't automatically set every error status to correspond to
> -EPROBE_DEFER. Check only the approapriate error codes (-ETIMEDOUT +
> any other?).
Other could be -ENOMEM. I think no need to do any new handling for that.
>>   			goto err0;
>> +		}
>>   		dwc->ulpi_ready = true;
>>   	}
>>   
>> -- 
>> 2.34.1
>>
> Thanks,
> Thinh
