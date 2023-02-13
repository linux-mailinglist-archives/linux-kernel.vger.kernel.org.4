Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C557169488B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBMOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:47:57 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C04EF3;
        Mon, 13 Feb 2023 06:47:50 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id AB60FC80098;
        Mon, 13 Feb 2023 15:47:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HjuI5NuAG4NS; Mon, 13 Feb 2023 15:47:48 +0100 (CET)
Received: from [192.168.178.52] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 0D658C80095;
        Mon, 13 Feb 2023 15:47:47 +0100 (CET)
Message-ID: <97026dc5-e92e-62fe-43ae-33533125d900@tuxedocomputers.com>
Date:   Mon, 13 Feb 2023 15:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Raul E Rangel <rrangel@chromium.org>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
 <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com>
 <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
 <Y+pLLzLDotZQLpdA@smile.fi.intel.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Y+pLLzLDotZQLpdA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.02.23 um 15:37 schrieb Andy Shevchenko:
> On Mon, Feb 13, 2023 at 07:20:48AM -0600, Mario Limonciello wrote:
>> On 2/13/23 06:41, Andy Shevchenko wrote:
>>> On Mon, Feb 13, 2023 at 12:30:08PM +0100, Werner Sembach wrote:
>>>> Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
>>>>> On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
>>>>>> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
>>>>>> changed the policy such that I2C touchpads may be able to wake up the
>>>>>> system by default if the system is configured as such.
>>>>>>
>>>>>> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
>>>>>> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
>>>>>> ActiveLow and level triggered but connected to a pull up.
>>>>> I'm not sure I understand the issue here. From what you say here it seems
>>>>> correct ACPI description.
>>>> TBH I copied the commit description from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b
>>>> which is for a different device having the exact same problem.
>>> Yeah, and I reviewed that and seems paid no attention to this detail.
>>>
>>> So, ActiveLow + PullUp is the _right_ thing to do in ACPI.
>>> The problem seems somewhere else.
>>>
>>> Mario, can we have an access to the schematics of the affected pin to
>>> understand better what's going on?
>>>
>>> Or is that description missing some crucial detail?

Schematics for the NH5xAx can also be found on this unofficial clevo mirror 
(service manuals, scroll to end for schematics):

http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip

http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AF1.zip

User: repo

PW: repo

>> The schematics were shared by the reporter for the original issue which is
>> how we reached the conclusion there was a mistake.
>>
>> As they're both Clevo designs it's certainly possible they have the same
>> mistake in two systems.
> Thank you!
> I have looked at the schematics and read discussion.
>
> So, the conclusion that this is a BIOS bug is incorrect in my opinion.
> The problem is either in the PMIC/EC firmware that shouldn't shut down 3.3VS
> signal for a while or on the PCB level, so that pull up should be connected
> to another power source that stays on.
>
> This means the description on the initial patch with the same issue is
> incorrect.
>
> Do we know the power sequence on the suspend to see which and how on the
> time line the power sources are off/on?
>
>>>>>> As soon as the
>>>>>> system suspends the touchpad loses power and then the system wakes up.
>>>>>>
>>>>>> To avoid this problem, introduce a quirk for this model that will prevent
>>>>>> the wakeup capability for being set for GPIO 10.
>>>>> I'm not against fixing this, but wouldn't be better to actually target the root
>>>>> cause and have a different quirk? Or is it me who didn't get what is the root
>>>>> cause?
>>>>>
>>>> I missed to reference the original discussion while copying the description:
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that
>>>> it's a somewhat convoluted issue spanning multiple bugs when you scroll up
>>>> from that particular linked comment, which are however irrelevant for this
>>>> patch)
>>>>
>>>> I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me
>>>> summing it up, as I might have misunderstood parts of it ^^
>>> The GpioIo() and GpioInt() resources have gaps in them, due to this some
>>> additional information is required or some heuristics is used to deduct
>>> the settings.
>>>
>>> All this is described in
>>> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html
>>>
>>>> I added the other ones from there to the cc.
>>> Thank you.
