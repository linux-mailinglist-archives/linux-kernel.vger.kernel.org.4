Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5793361F200
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiKGLjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiKGLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:39:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D93917073
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:39:16 -0800 (PST)
Received: from [192.168.2.123] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77C1A6601FAA;
        Mon,  7 Nov 2022 11:39:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667821155;
        bh=I8DXdlPi9UbfKxSyEPU3xTALuZKpaODNsptb3jwRyak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Svd21x4kj6L2Ggai70WTI7KBeA1Smj1YXYgqRX0Y3ckaSXgZvt4x+7OcJl2Ol9P2z
         831YOtdLbYbr7kJc9Kf1YsNrcNghD0UbZlgAnKbH24w8H9rLAENyhBX8iUBP8R+BoX
         f8lQM/wcGBqPkd1BDPsLP7DKUOu/c/0/ceuZXTxThIeIp0xW4RoVVDeWHOktbvmz8X
         EoiG/L6raU5m0GTv1D8ysx89T2aui4ENbyJKtj/aEh0vEaVRlOqpm+IbrYyESF9aqk
         BR2tyVAiyvtLCmb6KF6KEKRiurCYwRsCA5evDCR27Z0VvHwF9Zv0BmmlxH2aQcjd3N
         AjcyMr1QJ6XSQ==
Message-ID: <ac5063a0-f03d-44ba-63a5-f55e9f2fd2de@collabora.com>
Date:   Mon, 7 Nov 2022 14:39:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mfd: axp20x: Do not sleep in the power off handler
To:     Lee Jones <lee@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20221105212909.6526-1-samuel@sholland.org>
 <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
 <Y2jSTotJgjUx1tHV@google.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <Y2jSTotJgjUx1tHV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 12:39, Lee Jones wrote:
> On Mon, 07 Nov 2022, Dmitry Osipenko wrote:
> 
>> On 11/6/22 00:29, Samuel Holland wrote:
>>> Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
>>> function axp20x_power_off() now runs inside a RCU read-side critical
>>> section, so it is not allowed to call msleep(). Use mdelay() instead.
>>>
>>> Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>>  drivers/mfd/axp20x.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>>> index 88a212a8168c..880c41fa7021 100644
>>> --- a/drivers/mfd/axp20x.c
>>> +++ b/drivers/mfd/axp20x.c
>>> @@ -842,7 +842,7 @@ static void axp20x_power_off(void)
>>>  		     AXP20X_OFF);
>>>  
>>>  	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
>>> -	msleep(500);
>>> +	mdelay(500);
>>>  }
>>>  
>>>  int axp20x_match_device(struct axp20x_dev *axp20x)
>>
>> ARM was doing local_irq_disable() on power-off before
>> do_kernel_power_off() was introduced, so this should've been incorrect
>> for a couple years at least. If I'm not missing anything.
> 
> Is that a review?  Care to provide a tag?

It's a review and my point was that the "Fixes" tag in this patch
doesn't look correct. But this is minor comment, otherwise patch looks
okay. Hope that the relevant I2C controller driver supports atomic
transfer that are required for power-off to work.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

