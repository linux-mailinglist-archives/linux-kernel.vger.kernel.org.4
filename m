Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF86F1728
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345970AbjD1MFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbjD1MFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBEB5B86;
        Fri, 28 Apr 2023 05:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A817164342;
        Fri, 28 Apr 2023 12:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11923C433EF;
        Fri, 28 Apr 2023 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682683501;
        bh=oI4qwh6vPhdcG/dlVhK2Fk245tdN9D5ZpWq2ymG0G2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tnYTQulnZ/dZh6H/4wLI2c0g/tN8PusSZZPibQTXiu9+R7STTNm9UisFDypXrpC3U
         cdR7XLldhS/9/mbXLlqhglZwB6EyCQxmWSB8EyarSRr3r5QPK8OZnCRWQVyaDt63QL
         G//4yJxLnbPv+Zxi1Y3WtjRLqzV8B07HyQlo0M7BJ5r90Dx+D87b5qKpECy9Eki9Wg
         wmYVt5mVQ7N/yLDqUfMXKGDu4VlBpnIlDJ0O4CCJ7UKUo9lMvKS6enB7kwDE1VXG/c
         LvaDHTNn0G9DZi08FsWmNmMG7Xhj5unN2mH9Z4NxfBWoyMASesJp+epqbvSXyrQWK2
         mF4/A+TcJMWdA==
Message-ID: <83dfad53-b38e-54c9-0f90-8fe834a1bca6@kernel.org>
Date:   Fri, 28 Apr 2023 15:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: dwc3 gadget: controller stop times out on system sleep
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
 <20230426200140.xa4unnbaw2vog2je@synopsys.com>
 <dafed705-292e-6c03-7599-1b1374b95122@kernel.org>
 <20230427221315.nmvy32j6lfxlsmdk@synopsys.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230427221315.nmvy32j6lfxlsmdk@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2023 01:13, Thinh Nguyen wrote:
> On Thu, Apr 27, 2023, Roger Quadros wrote:
>> Hi,
>>
>> On 26/04/2023 23:01, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Wed, Apr 26, 2023, Roger Quadros wrote:
>>>> Hi Thinh,
>>>>
>>>> On Linux kernel v6.3
>>>> Test procedure: 
>>>>
>>>> - modprobe g_zero
>>>> - Connect to PC host
>>>> - systemctl suspend
>>>>
>>>> A large delay of 3 seconds is observed. The delay comes from dwc3_gadget_suspend()->dwc3_gadget_run_stop() waiting for DWC3_DSTS_DEVCTRLHLT to be set.
>>>> It returns -ETIMEDOUT.
>>>>
>>>> Are we missing something to do a clean stop during suspend?
>>>>
>>>> FYI. Unloading g_zero does not show this delay on stop.
>>>>
>>>> cheers,
>>>> -roger
>>>
>>> When clearing run_stop bit and the controller doesn't halt, that usually
>>> means there are active transfers/endpoints that aren't ended yet.
>>>
>>> The dwc3_gadget_suspend() doesn't properly do all the cleanup before
>>> clearing the run_stop bit. I think you just need to call
>>> dwc3_gadget_soft_disconnect() in dwc3_gadget_suspend() to fix this.
>>
>> That seems to do the trick.
>> How does this look?
>>
>> -------------------------- drivers/usb/dwc3/gadget.c --------------------------
>> @@ -4674,11 +4676,18 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>>  int dwc3_gadget_suspend(struct dwc3 *dwc)
>>  {
>>  	unsigned long flags;
>> +	int ret;
>>  
>> -	if (!dwc->gadget_driver)
>> +	if (!dwc->gadget_driver || !dwc->softconnect)
>>  		return 0;
>>  
>> -	dwc3_gadget_run_stop(dwc, false, false);
>> +	ret = dwc3_gadget_soft_disconnect(dwc);
>> +	if (ret)
>> +		goto err0;
>> +
>> +	ret = dwc3_gadget_run_stop(dwc, false, false);
>> +	if (ret)
>> +		goto err1;
>>  
> 
> We already clear run_stop in dwc3_gadget_soft_disconnect().
> 
> Can you try the following change (not tested):
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index c0ca4d12f95d..2996bcb4d53d 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2699,6 +2699,21 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>  	return ret;
>  }
>  
> +static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
> +{
> +	/*
> +	 * In the Synopsys DWC_usb31 1.90a programming guide section
> +	 * 4.1.9, it specifies that for a reconnect after a
> +	 * device-initiated disconnect requires a core soft reset
> +	 * (DCTL.CSftRst) before enabling the run/stop bit.
> +	 */
> +	dwc3_core_soft_reset(dwc);
> +
> +	dwc3_event_buffers_setup(dwc);
> +	__dwc3_gadget_start(dwc);
> +	return dwc3_gadget_run_stop(dwc, true);

return dwc3_gadget_run_stop(dwc, true, false);

> +}> +
>  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  {
>  	struct dwc3		*dwc = gadget_to_dwc(g);
> @@ -2737,21 +2752,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  
>  	synchronize_irq(dwc->irq_gadget);
>  
> -	if (!is_on) {
> +	if (!is_on)
>  		ret = dwc3_gadget_soft_disconnect(dwc);
> -	} else {
> -		/*
> -		 * In the Synopsys DWC_usb31 1.90a programming guide section
> -		 * 4.1.9, it specifies that for a reconnect after a
> -		 * device-initiated disconnect requires a core soft reset
> -		 * (DCTL.CSftRst) before enabling the run/stop bit.
> -		 */
> -		dwc3_core_soft_reset(dwc);
> -
> -		dwc3_event_buffers_setup(dwc);
> -		__dwc3_gadget_start(dwc);
> -		ret = dwc3_gadget_run_stop(dwc, true);
> -	}
> +	else
> +		ret = dwc3_gadget_soft_connect(dwc);
>  
>  	pm_runtime_put(dwc->dev);
>  
> @@ -4655,42 +4659,39 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>  int dwc3_gadget_suspend(struct dwc3 *dwc)
>  {
>  	unsigned long flags;
> +	int ret;
>  
>  	if (!dwc->gadget_driver)

We need to check for dwc->softconnect here. If it is not set that means
controller has already stopped so we can simply exit.

>  		return 0;
>  
> -	dwc3_gadget_run_stop(dwc, false);
> +	ret = dwc3_gadget_soft_disconnect(dwc);
> +	if (ret)
> +		goto err;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
>  	dwc3_disconnect_gadget(dwc);
> -	__dwc3_gadget_stop(dwc);
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  
>  	return 0;
> +
> +err:
> +	/*
> +	 * Attempt to reset the controller's state. Likely no
> +	 * communication can be established until the host
> +	 * performs a port reset.
> +	 */
> +	if (dwc->softconnect)
> +		dwc3_gadget_soft_connect(dwc);
> +
> +	return ret;
>  }
>  
>  int dwc3_gadget_resume(struct dwc3 *dwc)
>  {
> -	int			ret;
> -
>  	if (!dwc->gadget_driver || !dwc->softconnect)
>  		return 0;
>  
> -	ret = __dwc3_gadget_start(dwc);
> -	if (ret < 0)
> -		goto err0;
> -
> -	ret = dwc3_gadget_run_stop(dwc, true);
> -	if (ret < 0)
> -		goto err1;
> -
> -	return 0;
> -
> -err1:
> -	__dwc3_gadget_stop(dwc);
> -
> -err0:
> -	return ret;
> +	return dwc3_gadget_soft_connect(dwc);
>  }
>  
>  void dwc3_gadget_process_pending_events(struct dwc3 *dwc)

Everything else looks ok. I will send a patch soon.

--
cheers,
-roger
