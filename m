Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27C6C815D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCXPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCXPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:36:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDB212AC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:36:04 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id fjSTpBhedqHjrfjSTp1Ery; Fri, 24 Mar 2023 16:36:02 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 24 Mar 2023 16:36:02 +0100
X-ME-IP: 86.243.2.178
Message-ID: <cf18bc52-af25-8ce0-3536-202ea3c6e86d@wanadoo.fr>
Date:   Fri, 24 Mar 2023 16:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] leds: max597x: Add support for max597x
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <20230323194550.1914725-2-Naresh.Solanki@9elements.com>
 <d6463018-ebdf-30b2-ce0e-f2b5198847f1@wanadoo.fr>
 <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/03/2023 à 11:54, Naresh Solanki a écrit :
> Hi,
> 
> On 24-03-2023 01:48 am, Christophe JAILLET wrote:
>> Le 23/03/2023 à 20:45, Naresh Solanki a écrit :
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> max597x is hot swap controller with indicator LED support.
>>> This driver uses DT property to configure led during boot time &
>>> also provide the LED control in sysfs.
>>>

[...]


>>> +static int max597x_led_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device_node *np = dev_of_node(pdev->dev.parent);
>>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>> +    struct device_node *led_node;
>>> +    struct device_node *child;
>>> +    int ret = 0;
>>> +
>>> +    if (!regmap)
>>> +        return -EPROBE_DEFER;
>>> +
>>> +    led_node = of_get_child_by_name(np, "leds");
>>> +    if (!led_node)
>>> +        return -ENODEV;
>>> +
>>> +    for_each_available_child_of_node(led_node, child) {
>>> +        u32 reg;
>>> +
>>> +        if (of_property_read_u32(child, "reg", &reg))
>>> +            continue;
>>> +
>>> +        if (reg >= MAX597X_NUM_LEDS) {
>>> +            dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
>>> +                MAX597X_NUM_LEDS);
>>> +            continue;
>>> +        }
>>> +
>>> +        ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
>>> +        if (ret < 0)
>>> +            of_node_put(child);
>>
>> This of_node_put() looks odd to me.
> Not sure if I get this right but if led setup fails of_node_put should 
> be called.

My understanding is that this of_node_put() is there in case of error, 
to release what would otherwise never be released by 
for_each_available_child_of_node() if we exit early from the loop.

If the purpose is to release a reference taken in max597x_setup_led() in 
case of error:
    - this should be done IMHO within max597x_setup_led() directly
    - there should be a of_node_get() somewhere in max597x_setup_led()
      (after:
	if (of_property_read_string(nc, "label", &led->led.name))
		led->led.name = nc->name;
       + error handling path,  *or*
      just before the final return ret; when we know that everything is 
fine,
      if I understand correctly the code)

Is the reference taken elsewhere?
Did I miss something obvious?


>> "return ret;" or "break;" missing ?
>>
> Didn't add a break so that it can continue initializing remaining led if 
> any.

Ok. Don't know the code enough to see if correct or not, but based on my 
comment above, I think that something is missing in max597x_setup_led() 
and that errors should be silently ignored here.

CJ

>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +

[...]

