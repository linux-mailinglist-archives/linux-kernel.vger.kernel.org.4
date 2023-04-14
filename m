Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54C6E1F08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDNJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDNJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906B59FF;
        Fri, 14 Apr 2023 02:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02982645AC;
        Fri, 14 Apr 2023 09:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B10C433D2;
        Fri, 14 Apr 2023 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681463331;
        bh=NxHhNyO59Sno8DPKEVsgy8IRR2jb7JLYYAGWJQ0o1jk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S22X7WQPAuZ12nmRcg3Rf64pzpx51yTVa48kdudRbsLtAFON2ElyZv/Jdpzu3CEr0
         tDC9sJAinjGmM8lE7s31slyQktikjbZ/BKnvpMaZ8+OsMrFHIHQnqiHn/fQpaTHj0z
         wL62Y83dOd0OUBafpwSmf8+R/eyQsRq83qznv9mR8MvLcW9wSsVhIIM+DQ6szqW43s
         axWSeEOn6HbmekoQHUBb9ECjnoTIzuHTT7PF1vTivE1hBPm8EQ7FCHQsGLBXWXgsj0
         9KAitdl1eOcXV9Gdr5zlaH+DO+Xruae/vy+R5dDpZQ3VRtwRRXnVXDNO1V3qRxk5ds
         WFZMi6Anbthhg==
Message-ID: <94db291f-6d93-548b-92ad-3a9f480783e2@kernel.org>
Date:   Fri, 14 Apr 2023 11:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
 <20230412033006.10859-2-stanley_chang@realtek.com>
 <CAL_JsqLqTHbHjB1qiLduhzvTaO7EBMgL6KYqZJtgStGVGtX1vQ@mail.gmail.com>
 <5ae89b563e234acdb36a4ae253cec869@realtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <5ae89b563e234acdb36a4ae253cec869@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 04:53, Stanley Chang[昌育德] wrote:
> 
>>
>> On Tue, Apr 11, 2023 at 10:30 PM Stanley Chang
>> <stanley_chang@realtek.com> wrote:
>>>
>>> Add a new 'snps,global-regs-starting-offset' DT to dwc3 core to remap
>>> the global register start address
>>>
>>> The RTK DHC SoCs were designed the global register address offset at
>>> 0x8100. The default address is at DWC3_GLOBALS_REGS_START (0xc100).
>>> Therefore, add the property of device-tree to adjust this start address.
>>>
>>> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index be36956af53b..5cbf3b7ded04 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -359,6 +359,13 @@ properties:
>>>      items:
>>>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>>>
>>> +  snps,global-regs-starting-offset:
>>> +    description:
>>> +      value for remapping global register start address. For some dwc3
>>> +      controller, the dwc3 global register start address is not at
>>> +      default DWC3_GLOBALS_REGS_START (0xc100). This property is
>> added to
>>> +      adjust the address.
>>
>> We already have 'reg' or using a specific compatible to handle differences. Use
>> one of those, not a custom property. Generally, properties should be used for
>> things that vary per board, not fixed in a given SoC.
>>
>> Rob
>>
> 
> The default offset is fixed by macro DWC3_GLOBALS_REGS_START, and it is not specified by reg.

Are you saying that reg points to XHCI registers and the gap between
them and DWC3_GLOBALS_REGS_START is different on some implementations of
this IP?

> The dwc3/core is a general driver for every dwc3 IP of SoCs,
> and vendor's definition and compatible should specify on its parent.

Not entirely. It's how currently it is written, but not necessarily
correct representation. The parent is only glue part which for some
non-IP resources.

> If we add a specific compatible to dwc3/core driver, then it will break this rule.

What rule? The rule is to have specific compatibles, so now you are
breaking it.

> Therefore, I use a property to adjust this offset. 
> If no define this property, it will use default offset. So it will not affect other board.


Best regards,
Krzysztof

