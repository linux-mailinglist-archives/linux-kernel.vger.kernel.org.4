Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106E3713A69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjE1PsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE1PsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F15B1;
        Sun, 28 May 2023 08:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 823A560EE0;
        Sun, 28 May 2023 15:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355D7C433D2;
        Sun, 28 May 2023 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685288896;
        bh=LT1Xe7iHFZchKEqFyW0QdM2ZW1ST4BGs5srweFp+umI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eNfO+FM//NokA3vl5HXVZVWveaa1s9/He4xQBJMWPNm0mDBN3XiqckhALW7znzw+1
         1FUZfgS/4EQmqeDAg3ZX889OUvCJUNSyCGLgZeI+XTZeY6gu8yvYK5nYB5mwsu2AZ0
         2dNL6otOulPYgWsHO+HacBBFyUOe2+ROWSgQVi/f9/+k7QO8KGiRaRuRBW5WOwxB+7
         ob1rKmfDULB+QGqbYP37Uig5kmde054AZ18Ol9zVl8F4U8oMduWhFWK+QWWjQs3g03
         aqMqVOntDFTqN6RnNAdv3y9+pp7QRCo1cKY9VLZoI8uvbXdctF7SxcOMHz/5NVQdZZ
         SyM1w+fZofckg==
Message-ID: <f604f836-7858-6140-4ec1-9ba95cba6991@kernel.org>
Date:   Sun, 28 May 2023 18:48:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20230515123524.74e7bda3@canb.auug.org.au>
 <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
 <2023052846-surfer-spore-e873@gregkh>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2023052846-surfer-spore-e873@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 28/05/2023 17:28, Greg KH wrote:
> On Mon, May 15, 2023 at 02:01:08PM +0300, Roger Quadros wrote:
>> Hi Stephen,
>>
>> On 15/05/2023 05:35, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the usb tree got a conflict in:
>>>
>>>   drivers/usb/dwc3/gadget.c
>>>
>>> between commit:
>>>
>>>   c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
>>>
>>> from the usb.current tree and commit:
>>>
>>>   813f44d57e19 ("usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens")
>>>
>>> from the usb tree.
>>>
>>> I fixed it up (I think - see below) and can carry the fix as
>>> necessary. This is now fixed as far as linux-next is concerned, but any
>>> non trivial conflicts should be mentioned to your upstream maintainer
>>> when your tree is submitted for merging.  You may also want to consider
>>> cooperating with the maintainer of the conflicting tree to minimise any
>>> particularly complex conflicts.
>>>
>>
>>> diff --cc drivers/usb/dwc3/gadget.c
>>> index d831f5acf7b5,5965796bc5d5..000000000000
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@@ -2700,21 -2699,6 +2700,26 @@@ static int dwc3_gadget_soft_disconnect(
>>>   	return ret;
>>>   }
>>>   
>>>  +static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
>>>  +{
>>> ++	int	ret;
>>> ++
>>>  +	/*
>>>  +	 * In the Synopsys DWC_usb31 1.90a programming guide section
>>>  +	 * 4.1.9, it specifies that for a reconnect after a
>>>  +	 * device-initiated disconnect requires a core soft reset
>>>  +	 * (DCTL.CSftRst) before enabling the run/stop bit.
>>>  +	 */
>>>  +	dwc3_core_soft_reset(dwc);
>>
>> Please drop above call to dwc3_core_soft_reset().
>>
>>> ++	ret = dwc3_core_soft_reset(dwc);
>>> ++	if (ret)
>>> ++		return ret;
>>>  +
>>>  +	dwc3_event_buffers_setup(dwc);
>>>  +	__dwc3_gadget_start(dwc);
>>>  +	return dwc3_gadget_run_stop(dwc, true);
>>>  +}
>>>  +
>>>   static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>   {
>>>   	struct dwc3		*dwc = gadget_to_dwc(g);
>>
> 
> Can you verify I got this right in my usb-next branch now?

No, the end result is not correct.

Please apply the below patch to fix it. Thanks.

-- 
cheers,
-roger

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7d59e0f43fda..578804dc29ca 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2702,13 +2702,17 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 
 static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
 {
+	int ret;
+
 	/*
 	 * In the Synopsys DWC_usb31 1.90a programming guide section
 	 * 4.1.9, it specifies that for a reconnect after a
 	 * device-initiated disconnect requires a core soft reset
 	 * (DCTL.CSftRst) before enabling the run/stop bit.
 	 */
-	dwc3_core_soft_reset(dwc);
+	ret = dwc3_core_soft_reset(dwc);
+	if (ret)
+		return ret;
 
 	dwc3_event_buffers_setup(dwc);
 	__dwc3_gadget_start(dwc);
@@ -2753,25 +2757,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
-	if (!is_on) {
+	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
-	} else {
-		/*
-		 * In the Synopsys DWC_usb31 1.90a programming guide section
-		 * 4.1.9, it specifies that for a reconnect after a
-		 * device-initiated disconnect requires a core soft reset
-		 * (DCTL.CSftRst) before enabling the run/stop bit.
-		 */
-		ret = dwc3_core_soft_reset(dwc);
-		if (ret)
-			goto done;
-
-		dwc3_event_buffers_setup(dwc);
-		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true);
-	}
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
-done:
 	pm_runtime_put(dwc->dev);
 
 	return ret;



