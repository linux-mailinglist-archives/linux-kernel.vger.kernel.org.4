Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769846F54B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjECJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjECJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8103420B;
        Wed,  3 May 2023 02:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D19D624A7;
        Wed,  3 May 2023 09:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62E9C4339B;
        Wed,  3 May 2023 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683106120;
        bh=V9DDV7moq2wHtgkb8sfDxNs+j6hMw3KHukTGnMgB2/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BPwQCmCj9mzoyUbBF0MpnyMU7qpxwdPH/c+ifwjsk82jthdrv615dxdZnEr43SC8w
         XkWwI0XyImsqmjnYap1n6Is7EmnDWSfR6Mu+z0n00vDBFMRy0Z5UOj76GBzgoyWf7D
         W5IAuh3EYqmgOAssbdzNizOcQfKuGYnkM9QEYu5xnpW8+2lKYgi4wUaWtR8UPh72FR
         iY2FnLMIqezSIu1W7ElvEidk7Jr0hDFTwTkYSheCLOnUFFFU4cVbEfuQD1Kb+3cVS2
         YAlCKAUxffF0gRflIYwbT7J73Y536RlPTGKSAJWZvmcX8SzvuUekBKq6isVAAPFY2b
         vbv6x56QRBDVA==
Message-ID: <0cf14563-d536-c384-e8e0-2e3fe2e9e877@kernel.org>
Date:   Wed, 3 May 2023 12:28:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Avoid controller stop in
 .suspend if !softconnect
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "wcheng@codeaurora.org" <wcheng@codeaurora.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230502162133.148821-1-rogerq@kernel.org>
 <20230502162133.148821-2-rogerq@kernel.org>
 <20230502211749.jbo45lgccs346mjf@synopsys.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230502211749.jbo45lgccs346mjf@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2023 00:17, Thinh Nguyen wrote:
> On Tue, May 02, 2023, Roger Quadros wrote:
>> If softconnect is not set it means the controller has not started,
>> so no point in stopping it in dwc3_gadget_suspend()
>>
>> Cc: stable@vger.kernel.org # 5.16
>> Fixes: 8217f07a5023 ("usb: dwc3: gadget: Avoid starting DWC3 gadget during UDC unbind")
> 
> If the reason for this patch is as mentioned in the commit message, then
> I don't think this is a fix patch that needs to be backported to stable.
> The reason why we needed to check both dwc->gadget_driver and
> dwc->softconnect is because of a potential race between resume and
> unbind. Would there be a similar case in dwc_gadget_suspend where a
> potential race may occur? If not, I don't think we need this patch.

OK. I agree.

> 
> Thanks,
> Thinh
> 
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/usb/dwc3/gadget.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index c0ca4d12f95d..b5170374cd18 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4656,7 +4656,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>>  {
>>  	unsigned long flags;
>>  
>> -	if (!dwc->gadget_driver)
>> +	if (!dwc->gadget_driver || !dwc->softconnect)
>>  		return 0;
>>  
>>  	dwc3_gadget_run_stop(dwc, false);
>> -- 
>> 2.34.1

cheers,
-roger
