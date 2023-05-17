Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DADC706AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjEQOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjEQOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:11:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C4876AC;
        Wed, 17 May 2023 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684332679; x=1715868679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V85zZU9K+ebn9I4WS/QhOULxzw4WjXXhE4w7yyJEDSA=;
  b=M4BLUXjQ/GGB18T3SomBZl4NIcr87elm2Qmfk4i1AwjxJh8cRQ3Lvfcn
   je1kJDzuAQxMj9cEnDHZ2AljOKuOtFM9kp3SpLSurYmepHzpV9h/mSpTQ
   kCG5IcFUF7IqIWf2e3U8ebWTD/J5M937JD+CnNNIIVmqW7PwA7F9jPNv9
   q70GKOQlwXxqeXAlrQ+anDmou2po0IddmQ1gqeQKlJTENJaU7B1Kzngyo
   6D3Pgx27qbHfu2RQa+++0QQ/UP0HqudlV1CaCIPUO0Vgef4y4iSB6YYt4
   JiPnnDFXzZcPvi4jRx11mhbPMRLBBh1JABQlFnpHAc13a++Wx00K8IgT9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349273294"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="349273294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734709640"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="734709640"
Received: from rdealba-mobl.amr.corp.intel.com (HELO [10.209.16.101]) ([10.209.16.101])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:17 -0700
Message-ID: <4aae458b-6919-2999-9293-028737c9a6e1@linux.intel.com>
Date:   Wed, 17 May 2023 09:11:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
 <ZF6RMqElYZVMpWRt@surfacebook>
 <20230515101350.GS68926@ediswmail.ad.cirrus.com>
 <CAHp75Vcizrucc-2KFdFNeHNrxCzz4GwX1OzZYyjPH7P9RgnKYQ@mail.gmail.com>
 <20230517101301.GV68926@ediswmail.ad.cirrus.com>
 <CAHp75VchpbiYcd2yaP1WTjX17P0hg3qON5JGAXu08aDVw6Ydkw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAHp75VchpbiYcd2yaP1WTjX17P0hg3qON5JGAXu08aDVw6Ydkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 08:59, Andy Shevchenko wrote:
> On Wed, May 17, 2023 at 1:13 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
>> On Tue, May 16, 2023 at 10:03:45PM +0300, Andy Shevchenko wrote:
>>> On Mon, May 15, 2023 at 1:13 PM Charles Keepax
>>> <ckeepax@opensource.cirrus.com> wrote:
>>>> On Fri, May 12, 2023 at 10:19:14PM +0300, andy.shevchenko@gmail.com wrote:
>>>>> Fri, May 12, 2023 at 01:28:36PM +0100, Charles Keepax kirjoitti:
>>>>>> +   if (!of_property_read_bool(dev_of_node(cs42l43->dev), "gpio-ranges")) {
>>>>>> +           ret = gpiochip_add_pin_range(&priv->gpio_chip, priv->gpio_chip.label,
>>>>>> +                                        0, 0, CS42L43_NUM_GPIOS);
>>>>>> +           if (ret) {
>>>>>> +                   dev_err(priv->dev, "Failed to add GPIO pin range: %d\n", ret);
>>>>>> +                   goto err_pm;
>>>>>> +           }
>>>>>> +   }
>>>>>
>>>>> Besides the fact that we have a callback for this, why GPIO library can't
>>>>> handle this for you already?
>>>>
>>>> Apologies but I am not quite sure I follow you, in the device
>>>> tree case this will be handled by the GPIO library. But for ACPI
>>>> this information does not exist so has to be called manually, the
>>>> library does not necessarily know which values to call with,
>>>> although admittedly our case is trivial but not all are.
>>>
>>> Why can't the firmware provide this information? _DSD() is a part of
>>> ACPI v5.1 IIRC.
>>
>> I am very very far from confident we can guarantee that will be
>> present in the ACPI. The ACPI is typically made for and by the
>> Windows side.
> 
> Why? You may insist firmware vendors / OEMs to use that as a
> requirement to the platforms that would like to use your chip. The
> _DSD() is part of the specification, I don't see how the above can be
> an argument.
> 
> The times when ACPI == Windows are quite behind.

This is one of those Yogi Berra-isms: In theory, there is no difference
between theory and practice. In practice there is.

DSD is not really used indeed for audio devices. Even for SoundWire
where we inked the requirement to use DSD in a MIPI standardization
document, the only _DSD properties are for the manager side, the
peripheral side information is not populated or mostly
useless/incorrect. Most codec drivers hard-code the properties that were
intended to be set in the DSDT.

Unless there is firm evidence that the firmware does provide the
required DSD properties we can assume it does not. We can't force the
ecosystem to use DSD, even if it makes sense. it's frustrating but it is
what it is.
