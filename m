Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C926273EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiKNAsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiKNAsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:48:46 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74795A9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:48:45 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.52]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpUlO-1pJZWl3Bds-00pxsB; Mon, 14 Nov 2022 01:48:15 +0100
Message-ID: <b49a242f-dc85-171d-1f0c-93b9099712a3@i2se.com>
Date:   Mon, 14 Nov 2022 01:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/vc4: hdmi: Enforce the minimum rate at
 runtime_resume
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech>
 <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
 <737e7e23-1bc5-eaf3-2d15-5498fc5b0415@i2se.com>
Content-Language: en-US
In-Reply-To: <737e7e23-1bc5-eaf3-2d15-5498fc5b0415@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YS07FkhVr3OfGmnW5zQVJs+UtG1HE1PhzcW8TJ2mq+y5yxUQiu3
 xx1jlgi/+t/chVeyciJYmF/3/jjEaxpvEaY0sVHhVuC0tTAIDiSWdYO/LhhVtQjv9Hgc/RP
 Qr3lwUItjIT836nqIJe9n7xV091CqulOT6vskjrgjqcg+i/VhmMDh/5qgkOrdO4GgObGf3h
 XBzv5IX5s49SzCUjl+H+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WtGh1L4o654=:yveJNpSn5Wmm2Ra1Qj7NN/
 FyMOJBpwzlDE6XNo/nsBjnpaEtXekZnwgaVfkP4/EV/5trTZaHYxeksa1ypZTbfCi+Ja7nqJS
 EAzlSX36PB8Kr0kGEu2bumAwU5jSqGXKvOOQdqs2IZNGMczxANcAQ7aR928DT07qB2FubPOKg
 fRIWhzDNdnST7cMMjAVy2hPA4XE5dLWtofGKHDQUjKKRFCm2ZMia8oX/FDByouj3axSDijXRg
 fLEw6pYis3rB8K+WMbI1TelLui6jiHUY/y3L6pMb8JRLeZSxEZHKaIidFGU/9BMAYuHQsbSD/
 MqSDMjJaUeNC7Oux6Rqx/8A8VORvFB7xbkDf+tzR2PxLGKwKXzdS5FxfTD0yOOtdDV+f08sXd
 i07C92mIqodf4B/nl5zFYaExX8rArFHS5xYYmw0ka+VEI59Q4u/zJKaBitSZJoh0yINv/P3OJ
 6VNn/sT4KBDIo7wArGbD6NqXdEnq8YN1qhUZ/MQv++9dUA4R+ErgcEmta4v1TWWtd0zXdkGje
 4llJwjvEqxjqD2j9Ely19v4CFUyuvMIu4ew7srpD7+7Lp/9rS2C70Y6wB27ELBMhU//f+y4Eq
 mBBk1+Kbja7GFCwLiFxq6KKTKWNAq3Gcr/Eh8k7ksk7w90UE4BmtqtqXSPddpNTfleUcwW4iy
 SR2fCBg0ATJDSbxkvx9iekfrr/yv1vVzhdRYeiiivsTkzjaAtuyOzibJn6ldR03hPeQg+3uP9
 zD+tkgyckBOnIaZ/ulWyHNtYkn/OhOK6CnKEEY7Kzp6I92Adn3k9u3+JkI5odShoWsg7P/She
 8uITY4Byf5SjvYzubXXaXC/BrraPQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.11.22 um 22:08 schrieb Stefan Wahren:
> Hi Maxime,
>
> Am 29.09.22 um 11:21 schrieb Maxime Ripard:
>> This is a revert of commit fd5894fa2413 ("drm/vc4: hdmi: Remove clock
>> rate initialization"), with the code slightly moved around.
>>
>> It turns out that we can't downright remove that code from the driver,
>> since the Pi0-3 and Pi4 are in different cases, and it only works for
>> the Pi4.
>>
>> Indeed, the commit mentioned above was relying on the RaspberryPi
>> firmware clocks driver to initialize the rate if it wasn't done by the
>> firmware. However, the Pi0-3 are using the clk-bcm2835 clock driver that
>> wasn't doing this initialization. We therefore end up with the clock not
>> being assigned a rate, and the CPU stalling when trying to access a
>> register.
>>
>> We can't move that initialization in the clk-bcm2835 driver, since the
>> HSM clock we depend on is actually part of the HDMI power domain, so any
>> rate setup is only valid when the power domain is enabled. Thus, we
>> reinstated the minimum rate setup at runtime_suspend, which should
>> address both issues.
>>
>> Link: 
>> https://lore.kernel.org/dri-devel/20220922145448.w3xfywkn5ecak2et@pengutronix.de/
>> Fixes: fd5894fa2413 ("drm/vc4: hdmi: Remove clock rate initialization")
>> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>> ---
>>   drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c 
>> b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> index 199bc398817f..2e28fe16ed5e 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -2891,6 +2891,15 @@ static int vc4_hdmi_runtime_resume(struct 
>> device *dev)
>>       u32 __maybe_unused value;
>>       int ret;
>>   +    /*
>> +     * The HSM clock is in the HDMI power domain, so we need to set
>> +     * its frequency while the power domain is active so that it
>> +     * keeps its rate.
>> +     */
>> +    ret = clk_set_min_rate(vc4_hdmi->hsm_clock, HSM_MIN_CLOCK_FREQ);
>> +    if (ret)
>> +        return ret;
>> +
>
> unfortunately this breaks X on Raspberry Pi 4 in Linux 6.0.5 
> (multi_v7_defconfig + LPAE). Today i saw this report [1] and bisected 
> the issue down to this patch. Shame on me that i only tested this 
> patch with Rpi 3B+ :-(
Looks like "drm/vc4: hdmi: Fix HSM clock too low on Pi4" addresses this 
issue ...
>
> Best regards
>
> [1] - https://bugzilla.suse.com/show_bug.cgi?id=1205259
>
>>       ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
>>       if (ret)
>>           return ret;
>>
