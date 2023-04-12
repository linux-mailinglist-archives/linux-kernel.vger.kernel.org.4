Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C24E6DF820
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjDLONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDLONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE924206;
        Wed, 12 Apr 2023 07:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A993629E8;
        Wed, 12 Apr 2023 14:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797AC433D2;
        Wed, 12 Apr 2023 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681308805;
        bh=aysN1vMj95ISrHdotkHfG0MPT0pCGrmJ6IToXbJxmUg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ux4LjwKR04QMVbl40gx9Y+GSWgEs/0F/kO8IUjSm1ATbXmHFQ4JfLTCGmbQlYDfXC
         AdPvlF3rlOPkBCuwElDryoC70Zh072ihO9z7iMEZNSSC6PmEUE05Wl+tn/S13pXzm5
         uM6ufF2QCBg2RJ+4ZI9Zsrt5Nd39iMbeyl7lvKKeGet7Uh6FZszm9dZHqmc0IqTQ4o
         D0zm/qnwVbVKhA+uLbTA6DwBhJBYmZU5dKXPI4cIKT9kkWVU18vvRQoVpUNOl97xFb
         RO2krU/HwnThxlVIn0b1xn9vKLH1Bz3g8Bs7mQYqqUW5rWLs1s+B/xF/yWWnXQZuXF
         MvB2gSeuwu/DQ==
Message-ID: <b64773af-e197-1799-e805-7051356fa78b@kernel.org>
Date:   Wed, 12 Apr 2023 16:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
 <20230412033006.10859-2-stanley_chang@realtek.com>
 <955cc334-eaac-5880-51cf-8ab171f0ef48@kernel.org>
 <aa52c3b14b3b4f8dbf3c5403392dac42@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <aa52c3b14b3b4f8dbf3c5403392dac42@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:11, Stanley Chang[昌育德] wrote:
>> On 12/04/2023 05:30, Stanley Chang wrote:
>>> Add a new 'snps,global-regs-starting-offset' DT to dwc3 core to remap
>>> the global register start address
>>>
>>> The RTK DHC SoCs were designed the global register address offset at
>>> 0x8100. The default address is at DWC3_GLOBALS_REGS_START (0xc100).
>>> Therefore, add the property of device-tree to adjust this start address.
>>>
>>> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC.  It might happen, that command when run on an older kernel, gives
>> you outdated entries.  Therefore please be sure you base your patches on
>> recent Linux kernel.
>>
>> Since you skipped lists used in automated check, that's
>> unfortunately: NAK
>>
>>
>>> ---
>>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>> Best regards,
>> Krzysztof
>>
>>
> CC more maintainers by using scripts/get_maintainers.pl

This does not work like this. It has to appear in the patchwork and be
tested by automated tools. Please resend.

Best regards,
Krzysztof

