Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5732C6C2E29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCUJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCUJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19FC39296;
        Tue, 21 Mar 2023 02:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB01961AAD;
        Tue, 21 Mar 2023 09:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E331EC433D2;
        Tue, 21 Mar 2023 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679391881;
        bh=4y+jXrbZ1bwtYeyd/jWXn/dcnAO7cq768MGFDANWHkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L6HCpffsLA9OJA1sfIuIL7YvwpZ91R8vkJr4iPuvRfYbUFjlCO+r3fp4TQ1qHtnu6
         9eE2cOWxhtweB7phbEkyScFa69OavRx3HHRhP3vbYPYbmxPBxkOZQR67snvduKArMX
         p30idcwiMDOfSPE2+DDYCaJEi5vYpQxH4WxGWUZIKLOnedd6e0X2LpIxr06vJIPq7D
         EEpo7f1J3MAbxUzBAZVgwBvO8D3Y93r14BpX1sRmGhCBfhb8XIiRE5BD0Sz7ZgQOmI
         bxJIoi4yIzDBFdRq6WoUHy35RWE+yg2cTEghwngWIYHCm505V/3bSLLX6CURfSNkLC
         tdqqTpE2jnJcQ==
Message-ID: <0f0382f0-26d0-c217-93d2-c436c5209a2b@kernel.org>
Date:   Tue, 21 Mar 2023 11:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: usb: snps,dwc3: Add
 'snps,gadget-keep-connect-sys-sleep'
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-2-rogerq@kernel.org>
 <20230320132252.GA1440894-robh@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230320132252.GA1440894-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2023 15:22, Rob Herring wrote:
> On Mon, Mar 20, 2023 at 11:34:46AM +0200, Roger Quadros wrote:
>> The current USB gadget driver behaviour is to stop the controller
>> and disconnect from the bus during System sleep.
> 
> What's USB gadget? ;)

:)

> 
>> The 'snps,gadget-keep-connect-sys-sleep' property can be used to
>> change this behaviour and keep the controller active and connected
>> to the bus during System sleep. This is useful for applications
>> that want to enter a low power state when USB is suspended but
>> remain connected so they can resume activity on USB resume.
>>
>> This feature introduces a new constraint if Gadget driver is connected
>> to USB host: i.e.  the gadget must be in USB suspend state to allow
>> a System sleep as we cannot process any USB transactions
>> when in System sleep.
>>
>> The system hardware is responsible to detect the end of USB suspend
>> and wake up the system so we can begin processing the USB transactions
>> as soon as possible.
> 
> Sounds like something the user/OS would want to choose rather than fixed 
> by your board's firmware.

Yes.

> 
> Is this somehow DWC3 specific? If not, why a DWC3 specific property?

This is not DWC3 specific. 

Should we make this a UDC class device's sysfs attribute instead?
Only concern is that in dual-role case, if a role switch from
device mode to host mode and back to device mode happens, we loose
the UDC device's attributes as we re-init the UDC device.

Or should we make it a udc_core module parameter? This should be
persistent between role switches.

> 
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index be36956af53b..1ce8008e7fef 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -262,6 +262,11 @@ properties:
>>        asserts utmi_sleep_n.
>>      type: boolean
>>  
>> +  snps,gadget-keep-connect-sys-sleep:
>> +    description:
>> +      If True then gadget driver will not disconnect during system sleep.
>> +      System sleep will not be allowed if gadget is not already in USB suspend.
> 
> 'gadget' is a Linuxism.

Got it. Will avoid using it ;)

> 
>> +
>>    snps,hird-threshold:
>>      description: HIRD threshold
>>      $ref: /schemas/types.yaml#/definitions/uint8
>> -- 
>> 2.34.1
>>

cheers,
-roger
