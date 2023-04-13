Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6A6E126E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDMQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDMQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A709753;
        Thu, 13 Apr 2023 09:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A775663FE5;
        Thu, 13 Apr 2023 16:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D79C4339E;
        Thu, 13 Apr 2023 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681403801;
        bh=zpXOE8O6tskJByG5O5xUZJa+iFGZLEGodc5DA9SzF90=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pTBQfrdmKxrEodLYWrlZETofTOnwil+BcO8ESlnogLiYI3w7Zy6/7iKTKGxO4CD5v
         W+8Mw27ujy/nsj3gWOV0eBZzrR3a9pnsuJyyp3lbfeMSlPJ1cL0DZF+JJooheUwCwN
         6Zi4a/++kltwjfPk4I6jUu/YnCH5ABzzZgbS8p6gTF7BfjkkrkliVZVMsmQX34iBC/
         pbKdJb3CK1/Mdqe04S0SxQoOZWqSfYec7mBl+cH/ItR4tprgiqmDLZIKRWdSq18ONH
         mpOhh0dMw8XnzluvCIQYwJEZosS/lTqaSQHVXJf31pjNg65AJpBTYhwJpvtdMhe5vP
         ILyEZDQKswo4g==
Message-ID: <19946f94-db48-fe0d-722c-cbb45b8bd0ba@kernel.org>
Date:   Thu, 13 Apr 2023 18:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20230412033006.10859-2-stanley_chang@realtek.com>
 <20230413042503.4047-1-stanley_chang@realtek.com>
 <167e4a8c-3ebd-92b7-1481-947f08901f97@kernel.org>
 <9f6abbe7a6fd479c98e2fd6c1080ad8a@realtek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <9f6abbe7a6fd479c98e2fd6c1080ad8a@realtek.com>
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

On 13/04/2023 16:58, Stanley Chang[昌育德] wrote:
>> On 13/04/2023 06:25, Stanley Chang wrote:
>>> Add a new 'snps,global-regs-starting-offset' DT to dwc3 core to remap
>>> the global register start address
>>>
>>> The RTK DHC SoCs were designed the global register address offset at
>>> 0x8100. The default address is at DWC3_GLOBALS_REGS_START (0xc100).
>>> Therefore, add the property of device-tree to adjust this start address.
>>>
>>> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
>>> ---
>>>  v1 to v2 change:
>>> 1. Change the name of the property "snps,global-regs-starting-offset".
>>> ---
>>
>> Didn't you got already comment for this patch? How did you implement it?
>>
>> Also, I asked you multiple times:
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC.  It might happen, that command when run on an older kernel, gives
>> you outdated entries.  Therefore please be sure you base your patches on
>> recent Linux kernel.
>>
>> I don't understand why you ignore this.
>>
>> NAK, patch is not correct.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thank you for your patient guidance.
> Because I'm not familiar with the review process and didn't use scripts/get_maintainers.pl properly in the initial email thread.
> Therefore, this series of errors was caused. Sorry for the confusion.
> Now I know how to use the script properly.
> After correcting the maintainer's suggestion, I'll restart a new email thread and review again.

Did you respond to feedback you got about the property? Did reviewer
agreed on your view after your feedback?

If not, then why resending this patch?

Best regards,
Krzysztof

