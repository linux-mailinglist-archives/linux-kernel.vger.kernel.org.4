Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F3701911
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEMSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjEMSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:13:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3125B6
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:13:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so19785737a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684001615; x=1686593615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdRy69fIEsxIBR9NIDENofSkdxQv1jnZ0R7WuYlxvmg=;
        b=fG7X2cweCveW7n+4bMveSLZAY+WLuu6MfImoFYDYCOebl0M6BCZjEb+aiyOxjkSRfz
         djPrd428AaZ8hdcS8NEPC2/El40d021+XTvUr9HbbOZzH5LL9pGLWm6mxX7eMZfZSWOY
         aMH4bkWd84g59FNyiQ0Rt68bhv9BeoT4S/RbNu81Kp8Fuz9CF/BXeiJ4M37IziD8UMSX
         BALo0ar12xrY38/boKGtsQXOXHwK1iy6ozrXNNDetwO8m9GKaAp9G4rRPHvJ3Bp6C1Pj
         0SUKUBtbomo6wQCJTAptVBvQGt7yvnNXCkErybKFw1OyLDb9pGp5kfXLVnItzLSYUZhd
         HR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001615; x=1686593615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdRy69fIEsxIBR9NIDENofSkdxQv1jnZ0R7WuYlxvmg=;
        b=Z29iG91Yl6cE1eAR7UrPDiDBY4gl+uJipxCHrIpX9/ou3b+AhFnSvP+KnTaKoW02/V
         wQ3Xn/P/Ulqrui9Asq5/1zoRtdNOIp4zdKFlh2l+nI9x3uXYyX4lh5SzxokavldMgNfn
         757535K4BuRTGIiYMu+m5ITwkE8nKUj9osOAz2lfUWP38o7/lu5o7jDXXBtXw4a+Ck4r
         0oAYcOhZ743qU9NizQRFxdob3IgwBWS9jWJRWf6oqbuoC2lx97EJ5JQSTCvTdUHOxfeb
         Dg9mQXxGK6kkteJKmHKvADcFFm+ThnpL1wHGF8uWgy+kUHVkxj8SVGkPQMK4438ZO158
         5IzQ==
X-Gm-Message-State: AC+VfDyyXkHePHO4mqme0gyprFAtDUoh/DTSCP5Qarn085CS6UnDZGv6
        4jjmdJ05YPkIaumf3KAYcnakJTwWoU/1p6rBuqFIaQ==
X-Google-Smtp-Source: ACHHUZ4m7lCl8p2Q7EHaoUU/9iQg5m8GgeAPaGDj82d7+DhAw/jzqEtERboZRuZ59/7bEz4RKl+kkg==
X-Received: by 2002:a17:907:7f94:b0:969:e9ec:9a0 with SMTP id qk20-20020a1709077f9400b00969e9ec09a0mr20377665ejc.77.1684000807359;
        Sat, 13 May 2023 11:00:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402111800b0050bc4eb9846sm5105168edv.1.2023.05.13.11.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:00:06 -0700 (PDT)
Message-ID: <633b305e-a311-3334-3d4e-30d5d09ebb6a@linaro.org>
Date:   Sat, 13 May 2023 20:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
 <9591999e-9d7f-2a4a-29df-d9c42dfa736b@linaro.org>
 <20230512155426.GJ68926@ediswmail.ad.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512155426.GJ68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 17:54, Charles Keepax wrote:
> On Fri, May 12, 2023 at 05:30:37PM +0200, Krzysztof Kozlowski wrote:
>> On 12/05/2023 14:28, Charles Keepax wrote:
>>> +	priv->gpio_chip.fwnode = dev_fwnode(cs42l43->dev);

What's also a bit confusing is that gpio_chip is the parent's node, but
pinctrl is not...

>>> +
>>> +	if (is_of_node(dev_fwnode(cs42l43->dev))) {
>>> +		device_set_node(priv->dev,
>>> +				fwnode_get_named_child_node(dev_fwnode(cs42l43->dev),
>>> +							    "pinctrl"));
>>
>> That's something unusual. It seems you want to bind to a DT node because
>> you miss compatible in DT node?
>>
> 
> Kinda, I don't really want to add multiple compatibles for the
> device. This is just a CODEC device, even in device tree it
> seems a little weird to have multiple compatibles for a single
> I2C device. On ACPI I am pretty sure it would be considered flat
> out right wrong. The fact Linux supports the device using multiple
> drivers is seemed to be a Linux implementation detail, rather than
> describing the hardware.
> 

I think if you do not have compatible, then the device node should be
rather the parent (so the main node with compatible), not the child.
Child is just a wrapper for pinctrls, but not something representing a
device.

Best regards,
Krzysztof

