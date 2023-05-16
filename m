Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D1705459
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjEPQuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjEPQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:49:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801E5FCF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:49:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so25839546a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255792; x=1686847792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98jLZxl/wFD6yfWWHfXW+6rIWIRzQseh9ow23ZlMcPA=;
        b=sysycK1uXzo8V3zJTYQk8eZ47oUgTL3F1OkHqo+tSrZYvlHKeb51g9hhjxXZzW6bLD
         LPxA0z0NelQgHpvFyQEpK21qkwwKYYZWdQp/mVyfwuRlC5iLTMWQyN75MiVVSpOphBeg
         fg4iwktIy5YcxWWSp+KmLSeEmIE57zPtmxq126RlUymvN0os8MDMwD9BcHWpMglq1S4m
         Xktmc+r8Yx0q/08soQDNSMolDvw+zb3H14kjDQKVsToT63VqCJiHLevyebMK0RQqLTwB
         UVoPP4edmmV1xW/+tCw3J2tl7eehYJUEBssdtgG9vLAfzUD2pAXDTDMKdRhnlk30Urev
         J+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255792; x=1686847792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98jLZxl/wFD6yfWWHfXW+6rIWIRzQseh9ow23ZlMcPA=;
        b=e69s0mi/kyXSvp6+9QBY4jKbwpmngUR+ppH1Qk37HstoNi978cwuKSblqzouxS9I/k
         zOjljz7z56EtfCGNiWMhK/ymLdhp6RGz5bYwFZ/TznlCBjJE9/HuGRBxW3N2Qa4N4G3c
         bRfzmgsLGyJOT2dqJ1vEZnGNG/1HoIyLiPjyPRD2qliqStbgVL7S0UAOpZcfq5t4sKTF
         X5V4aoaoVPdDG3uLrQvaKnu7l+9uy1m6lX8ujeC/2l/10r0tC9QrQQCDbqvgFwMmNHxw
         cAwkvcLw8sDYVP/t9gEO0lggAdlmBLkGZ9gJCCZWkpb1Uy1ms27mRVgmJ4TE2luILK9y
         Iv3w==
X-Gm-Message-State: AC+VfDxjHeZN6SRY5ZSGHHuKwDvNqpP0c7yXvMr8Oo221SwcQpPxZSRD
        H0gwT4+eEi7cskwSsPymygvdJqyd6Twbg8BDVxQ=
X-Google-Smtp-Source: ACHHUZ4ErN4eI/lu4njr0LL5LOj72gRCNsNY1sqTAV2Hw850PpdLHswTuK3OU8/yaLKyE+7iwyPodQ==
X-Received: by 2002:a17:907:31c9:b0:94f:6627:22b5 with SMTP id xf9-20020a17090731c900b0094f662722b5mr33246490ejb.47.1684255792093;
        Tue, 16 May 2023 09:49:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090674d700b0096ac911ecb8sm5750079ejl.55.2023.05.16.09.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:49:51 -0700 (PDT)
Message-ID: <32dbdaa3-067b-c997-778f-4fc8dafbbd87@linaro.org>
Date:   Tue, 16 May 2023 18:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515191909.611241-1-afd@ti.com>
 <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
 <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
 <7d73a37f-80b7-b623-1b71-fa19bf379713@linaro.org>
 <558ebfaf-bd7e-1760-5799-8ed430acad7a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <558ebfaf-bd7e-1760-5799-8ed430acad7a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 18:29, Andrew Davis wrote:
> On 5/16/23 11:19 AM, Krzysztof Kozlowski wrote:
>> On 16/05/2023 17:18, Andrew Davis wrote:
>>> On 5/15/23 4:14 PM, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> 2023-05-15 at 21:19, Andrew Davis wrote:
>>>>> The DT binding for the reg-mux compatible states it can be used when the
>>>>> "parent device of mux controller is not syscon device". It also allows
>>>>> for a reg property. When the parent device is indeed not a syscon device,
>>>>> nor is it a regmap provider, we should fallback to using that reg
>>>>> property to identify the address space to use for this mux.
>>>>
>>>> We should? Says who?
>>>>
>>>> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
>>>> like to see an example where it matters. Or, at least some rationale for why
>>>> the code needs to change other than covering some case that looks like it
>>>> could/should be possible based on the binding. I.e., why is it not better to
>>>> "close the hole" in the binding instead?
>>>>
>>>
>>> Sure, so this all stated when I was building a checker to make sure that drivers
>>> are not mapping overlapping register spaces. I noticed syscon nodes are a source
>>> of that so I'm trying to look into their usage.
>>>
>>> To start, IHMO there is only one valid use for syscon and that is when more than
>>> one driver needs to access shared bits in a single register. DT has no way to
>>
>> It has... what about all existing efuse/nvmem devices?
>>
>>> describe down to the bit granular level, so one must give that register to
>>> a "syscon node", then have the device node use a phandle to the syscon node:
>>>
>>> common_reg: syscon@10000 {
>>> 	compatible = "syscon";
>>> 	reg = <0x10000 0x4>;
>>> };
>>>
>>> consumer@1 {
>>> 	syscon-efuse = <&common_reg 0x1>;
>>> };
>>>
>>> consumer@2 {
>>> 	syscon-efuse = <&common_reg 0x2>;
>>> };
>>>
>>> Something like that, then regmap will take care of synchronizing access.
>>
>> Syscon is not for this.
>>
> 
> That is how it is used today, and in 5 other ways too and there is
> no guidance on it. Let me know what syscon is for then.

Like described in its bindings (syscon.yaml). The main case is: some
part of address space (dedicated) for various purposes.

Secondary case is a device, with its address space, which has few
registers from other domain, so it needs to expose these to the other
devices.

efuse is not syscon, because it is not writeable. efuse has entirely
different purpose with its own defined purpose/type - efuse/OTP etc.

> 
>>>
>>
>> ...
>>
>>>
>>> Ideally DT nodes all describe their register space in a "reg"
>>> property and all the "large collection of devices" spaces become
>>> "simple-bus" nodes. "syscon" nodes can then be limited to only the
>>> rare case when multiple devices share bits in a single register.
>>>
>>> If Rob and Krzysztof agree I can send a patch with the above
>>> guidance to the Devicetree Specification repo also.
>>
>> Agree on what?
>>
> 
> That we should provide the above guidance on when and how to use syscon
> nodes. Right now it is a free for all and it is causing issues.

Sure, providing more guidance seems good. We already provide guidance
via review, but we can codify it more. Where? syscon.yaml? It's already
describing everything needed to know...

What particular problems do you see which need to be solved?

Best regards,
Krzysztof

