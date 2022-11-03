Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA66188C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKCT3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKCT3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB2F4C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667503693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz4zS1KdXNqNJZTibUfSdn0hVdKZM6F53BZQrYWL0P8=;
        b=d4jrWySa7MQQEx8eu9Q6OUfoFMhEyOTFDschN+aj3vcArXWQ2RdO6h11K1djGKlPP+i824
        p91M6GR7++e2GW0haxv6y20dGP+oS9yzLjX1G+uTfr4TRigj6MomXodaDhoVQESwaldABV
        9WcGbDMscCzRT/OG+MfTjxOkHQSVmDc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-d2ypkRRHMKurNKp5h78r2w-1; Thu, 03 Nov 2022 15:28:12 -0400
X-MC-Unique: d2ypkRRHMKurNKp5h78r2w-1
Received: by mail-ed1-f72.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso2051744edc.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz4zS1KdXNqNJZTibUfSdn0hVdKZM6F53BZQrYWL0P8=;
        b=38JyX8M9hrbobVD5/D09UIGx+RDz8XakfSlk629aPhQJ60wBvopNRuw1dTMR/tXH+x
         4+HZqFOqedGbN/iSqi6utYfiY4ecrUePyr9kX6ypKltJBs77hg4jSJj0TrDOU6YtsCEK
         hGGgKr5HKA4G95JSoIH0nf7nC2+xl38WzqoX1CSprCHWOyZ36oyn8xgEw43mCIYUkJQd
         XHcRPcZhPJjK5QNF07zEmJFr7j2gjNSHwBVzKDsy/31ByVUqhhr1cq9pyEVCGM6LTwWN
         HTp1f0wTWQwB5RKUFqikDPh+om2NvcUadBDfFxyDD5jbih347yZKAt4Rph9zjrAkl6gF
         gSsw==
X-Gm-Message-State: ACrzQf3q/FBOwKWPH3XWeqbtRU2YJ0+TV2uHk3xu6SPGe3520eVY8a5t
        n0v4bUEgx3NUtOI/xBtatCgRQkFHk32IkWl5YNBTxBF3zTglogvkowhEhwR/hwFqyr1wpOd8nXc
        aCBQlZLyNtrtiVlZ0dYPcrOLw
X-Received: by 2002:a17:907:1c10:b0:791:a716:5089 with SMTP id nc16-20020a1709071c1000b00791a7165089mr30674795ejc.672.1667503691349;
        Thu, 03 Nov 2022 12:28:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4FFvhMMcWk6ugM5YzsdFgcwYIF01cv7PrvQbzStqZS4m950VhbZ7UFRMRaUZYFgCAHzSFMSQ==
X-Received: by 2002:a17:907:1c10:b0:791:a716:5089 with SMTP id nc16-20020a1709071c1000b00791a7165089mr30674767ejc.672.1667503691090;
        Thu, 03 Nov 2022 12:28:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b00770880dfc4fsm871702ejc.29.2022.11.03.12.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 12:28:10 -0700 (PDT)
Message-ID: <16c7f876-102c-60e1-4a81-3378b6c726fb@redhat.com>
Date:   Thu, 3 Nov 2022 20:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 1/7] Input: goodix - fix reset polarity
Content-Language: en-US, nl
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, hadess@hadess.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        heiko@sntech.de, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v1-1-87b49ae589f1@theobroma-systems.com>
 <1fa371bd-78a6-bb7c-4692-1d8132ec2ab1@redhat.com>
 <Y2P7SsPa04975Rkm@google.com>
 <692fd16e-4183-d58d-802e-2b83563aee4b@redhat.com>
 <267de96a-0129-a97d-9bf6-e1001b422a1a@theobroma-systems.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <267de96a-0129-a97d-9bf6-e1001b422a1a@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 11/3/22 19:41, Quentin Schulz wrote:
> Hi all,
> 
> On 11/3/22 18:45, Hans de Goede wrote:
>> Hi,
>>
>> On 11/3/22 18:32, Dmitry Torokhov wrote:
>>> Hi Hans,
>>>
>>> On Thu, Nov 03, 2022 at 03:58:47PM +0100, Hans de Goede wrote:
>>>> Hi Quentin,
>>>>
>>>> On 11/3/22 15:43, Quentin Schulz wrote:
>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>
>>>>> The reset line is asserted for selecting the I2C target address and then
>>>>> deasserted.
>>>>
>>>> It is not asserted/deasserted, asserted/deasserted is reset-controller/
>>>> reset-framework (drivers/reset/*) terminology.
>>>>
>>>> We are driving GPIOs here and those are driven low/high.
>>>
>>> Not quite. GPIOD API operates on a logival level (think of them as
>>> active/inactive) and allows platform/firmware to specify polarity from
>>> the AP point of view (as opposed to device). This important if the
>>> peripheral is not attached directly, but potentially through an inverter
>>> or something similar).
>>
>> Right and if a line runs through an inverting buffer then marking
>> the pin as active-low in the DT makes a lot of sense here.
>>
> 
> It doesn't to me. /me shrugs
> 
>> But as I mentioned before the datasheet spells out a very specific
>> init-sequence.
>>
> 
> As Dmitry pointed out, we're talking about logical vs physical level. The driver tries to enforce physical level (on the touchscreen controller side) by expecting the logical level (of the gpio controller) to match.
> 
>> By default marking all the direct-attached RST pin connections as
>> active-low (1) to then invert the value again in the driver
>> (from the datasheet init sequence specified values pov) IMHO
>> just makes the driver code harder to read when putting it side
>> to side by the init-sequence specified in the datasheet.
>>
> 
> When I want to put a device into reset mode, I activate/assert the line so that its logical state is "active". For Goodix, its reset line is active low. I do a "positive" action, so I activate something. If it was called nreset, that would be a different story. If it was named enable-gpios, I would understand. I just don't get the current implementation with reset-gpios in DT.
> 
> Reading:
> reset-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
> means that I need to set the logical output to HIGH to have a HW reset, which is not what happens for this driver.
> 
>> I don't see how playing this double-invert game is going to help
>> us / gives us any added value, in any way.
>>
> 
> The current implementation is playing the double-invert game for me.
> 
> So clearly, we do not agree on what, at least in the DT, the level of a reset gpio should mean.

It would seem that way. Anyways lets agree to disagree here.

It seems that Dmitry is in favor of the change you suggest, so
lets just focus on making sure these changes don't break AcPI
support.

>> And in all the ACPI tables the GPIOs are marked as active-high
>> so changing this to have the driver now all of a sudden expect
>> the reset-gpio to be marked as active-low at the gpio-subsys
>> level will be quite cumbersome since normally the active-low vs
>> -high info comes from the firmware-tables and now all of a sudden
>> we need to override this.
>>
> 
> We have the information from which standard we got the GPIO, so we could always invert the flag we get from DT to match whatever is in ACPI.
> 
> Blindly ignoring the DT flag is not an option since the HW design could actually require an inversion (GPIO connected to a transistor for example). I'm not sure what exactly could be done on the gpio-subsys level to deal with this. I think we just disagree on what the reset "active state" should mean and no amount of code would fix that?

I would prefer for the gpiod_direction_output(ts->gpiod_rst, x)
calls to have x actually matching the timing diagrams in
the datasheet.

At a minimum when you invert those from the datasheet, please
add a comment that the values are inverted from the timing
diagram because the GPIO is marked as active-low in their
gpio_desc ?

>> During all my work on the goodix driver I have always been very
>> careful to not introduce any behavior changes for the DT users
>> of the drivers. It would be nice if this courtesy could also
>> be extended in the other direction.
>>
> 
> This RFC is clearly breaking ACPI support. I have zero knowledge about ACPI and didn't know that devm_gpiod_get_optional fetches from OF or ACPI. It was not my intention to break ACPI, sorry if it came this way.
> 
> I frankly didn't expect this to be an easy discussion, since changing the DT is usually a no-go, but as is making the DT binding implementation-specific (which is the current state of affairs), e.g. we'll need U-Boot/BSD/whatever driver to also use the same logic. I want to be noted that I like none of the options I offered so far.

Yes breaking the existing DT bindings / existing DTB files is
probably also going to be a problem. I'm going to defer reviewing
that part of these changes to other people.

> As I was surprised by the (for me) inverted logic of the GPIO state, I preferred fixing the driver and DT to match what my expectations were.
> 
> I'm looking for guidance on how we can deal with this, I do not claim what I suggest is what we should absolutely go for.

Ok, so I've been taking a look at how we can invert the 'x' passed
to the gpiod_direction_output(ts->gpiod_rst, x) calls and not break
things with ACPI.

The rst pin is looked up through a acpi_gpio_mapping which
contains acpi_gpio_params as one of the per pin parameters
and that does have an active_low flag.

After (re)reading the gpiolib code to fresh up my memory
of how this all fits together that flag should do what it
says on the tin.

So if we want to revert the value of x for all the:

gpiod_direction_output(ts->gpiod_rst, x);

calls, then something like the following should work to get
gpiolib to invert that again to turn it into a no-op:

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index a33cc7950cf5..5c294c56a20d 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -797,23 +797,26 @@ static int goodix_reset(struct goodix_ts_data *ts)
 }
 
 #ifdef ACPI_GPIO_SUPPORT
-static const struct acpi_gpio_params first_gpio = { 0, 0, false };
-static const struct acpi_gpio_params second_gpio = { 1, 0, false };
+static const struct acpi_gpio_params int_first_gpio = { 0, 0, false };
+static const struct acpi_gpio_params int_second_gpio = { 1, 0, false };
+
+static const struct acpi_gpio_params rst_first_gpio = { 0, 0, true };
+static const struct acpi_gpio_params rst_second_gpio = { 1, 0, true };
 
 static const struct acpi_gpio_mapping acpi_goodix_int_first_gpios[] = {
-	{ GOODIX_GPIO_INT_NAME "-gpios", &first_gpio, 1 },
-	{ GOODIX_GPIO_RST_NAME "-gpios", &second_gpio, 1 },
+	{ GOODIX_GPIO_INT_NAME "-gpios", &int_first_gpio, 1 },
+	{ GOODIX_GPIO_RST_NAME "-gpios", &rst_second_gpio, 1 },
 	{ },
 };
 
 static const struct acpi_gpio_mapping acpi_goodix_int_last_gpios[] = {
-	{ GOODIX_GPIO_RST_NAME "-gpios", &first_gpio, 1 },
-	{ GOODIX_GPIO_INT_NAME "-gpios", &second_gpio, 1 },
+	{ GOODIX_GPIO_RST_NAME "-gpios", &rst_first_gpio, 1 },
+	{ GOODIX_GPIO_INT_NAME "-gpios", &int_second_gpio, 1 },
 	{ },
 };
 
 static const struct acpi_gpio_mapping acpi_goodix_reset_only_gpios[] = {
-	{ GOODIX_GPIO_RST_NAME "-gpios", &first_gpio, 1 },
+	{ GOODIX_GPIO_RST_NAME "-gpios", &rst_first_gpio, 1 },
 	{ },
 };
 
Note this is missing the actual inverting of the
gpiod_direction_output(ts->gpiod_rst, x) calls!

Regards,

Hans


