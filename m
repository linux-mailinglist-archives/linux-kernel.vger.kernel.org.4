Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F79708631
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjERQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjERQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:47:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401CF0;
        Thu, 18 May 2023 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684428436; x=1715964436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eZIiTyret7MDus74XojVEWyZ/KiqME39bi31YIWnNnw=;
  b=FpD284i00jMAhHPpFqJE6HWk/5e/78BvJ4mL+gXbVgSgrYJDXSI5FDtA
   AIOVl8sw3PDusym5vDaKJWLh73qhPXK1hCg/RNJ4f8+6i+838p5NqpBRy
   xZbQgEef6jrylsFfwOUWtE6wgDv6ngg/Ypyj+jxyje8wGo5qDGYAA4QvF
   Ig5b5bTixORgCvpU3Fi1oyPkzye9WNzvQ7ZCvUXgopfZzFwl2pUlP/hSA
   DGBwduNKkoLgCNRPbIGlHLxrmDB6Ii+tLsQXI2EMVVW0kiz0AkasTJ41A
   B8cOtlBX82I3kYEOj+1wNgOJmieU5qdiNlJugn9fGdslRozDQLFmhHgsC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354457514"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="354457514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735164963"
X-IronPort-AV: E=Sophos;i="6.00,285,1681196400"; 
   d="scan'208";a="735164963"
Received: from nithinks-mobl1.amr.corp.intel.com (HELO [10.209.80.104]) ([10.209.80.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:47:13 -0700
Message-ID: <3fd73def-4765-d43c-4c2c-e0fb0e2e0516@linux.intel.com>
Date:   Thu, 18 May 2023 11:47:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
 <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
 <650012a3-b455-8be5-fd6d-d0775e718e6a@linux.intel.com>
 <049c2470-536a-1b1c-9828-7acb4d483309@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <049c2470-536a-1b1c-9828-7acb4d483309@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/23 11:15, Richard Fitzgerald wrote:
> 
> 
> On 18/05/2023 16:16, Pierre-Louis Bossart wrote:
>>
>>>>> +    ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
>>>>> +                    ARRAY_SIZE(cs42l43_reva_patch));
>>>>> +    if (ret) {
>>>>> +        dev_err(cs42l43->dev, "Failed to apply register patch:
>>>>> %d\n", ret);
>>>>> +        goto err;
>>>>> +    }
>>>>> +
>>>>> +    pm_runtime_mark_last_busy(cs42l43->dev);
>>>>> +    pm_runtime_put_autosuspend(cs42l43->dev);
>>>>> +
>>>>> +    ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
>>>>> +                   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
>>>>
>>>> I don't why adding devices is not in probe. They use the same regmap
>>>> right? So there will be no problem in probing them from MFD probe.
>>>
>>> Well except SoundWire is a bit of a special boy, the hardware is
>>> not necessarily available in probe, the hardware is only available
>>> at some point later when the device attaches. Doing it this way all
>>> of the attaching (and various detach/attach cycles the device needs
>>> during configuration) are over by the time the child drivers bind, so
>>> they don't all need special code to handle that.
>>
>> if the devices are added in the probe, then the regmap needs to be moved
>> to cache-only and another special API would be needed to tell the MFD
>> framework to turn the regmap cache-only off.
>>
>> But if it's the same regmap, the regmap cache is handled in the
>> SoundWire update_status callback so maybe  Krzysztof's proposal does
>> work?
> 
> But you still can't access the hardware in probe(). So you'd have all
> the child drivers probing but not able to talk to the hardware. The
> child drivers would have to hook into the update_status() somehow so
> they know when the peripheral has enumerated.
> It's simpler to add them after the hardware has enumerated - they will
> be able to access the hardware in their probe().

It depends on what you mean by 'access the hardware'. If the only
interface is regmap and regmap is in cache-only, then the child drivers
could "access the hardware" without anything happening until after
regmap is no longer cache-only.

But yeah, I realize it's a long shot.
