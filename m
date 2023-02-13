Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B962469448B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBMLal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjBMLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:30:33 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4719F2F;
        Mon, 13 Feb 2023 03:30:14 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 21E22C80098;
        Mon, 13 Feb 2023 12:30:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QE8ircAh1K_g; Mon, 13 Feb 2023 12:30:09 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 4A15DC80095;
        Mon, 13 Feb 2023 12:30:09 +0100 (CET)
Message-ID: <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
Date:   Mon, 13 Feb 2023 12:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Raul E Rangel <rrangel@chromium.org>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
> On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
>> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
>> changed the policy such that I2C touchpads may be able to wake up the
>> system by default if the system is configured as such.
>>
>> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
>> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
>> ActiveLow and level triggered but connected to a pull up.
> I'm not sure I understand the issue here. From what you say here it seems
> correct ACPI description.
TBH I copied the commit description from 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b 
which is for a different device having the exact same problem.
>
>> As soon as the
>> system suspends the touchpad loses power and then the system wakes up.
>>
>> To avoid this problem, introduce a quirk for this model that will prevent
>> the wakeup capability for being set for GPIO 10.
> I'm not against fixing this, but wouldn't be better to actually target the root
> cause and have a different quirk? Or is it me who didn't get what is the root
> cause?
>
I missed to reference the original discussion while copying the description: 
https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that 
it's a somewhat convoluted issue spanning multiple bugs when you scroll up from 
that particular linked comment, which are however irrelevant for this patch)

I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me 
summing it up, as I might have misunderstood parts of it ^^

I added the other ones from there to the cc.

