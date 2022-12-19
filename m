Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE315651104
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiLSRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiLSRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:11:03 -0500
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 09:11:00 PST
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2358413DE2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:10:59 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B3F23A0047;
        Mon, 19 Dec 2022 18:01:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B3F23A0047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1671469279; bh=gOcbNBGz+ANluLxaB4+FuyF+gaxrZE+jftjvvZfCJWA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QYhB8taCi8E+kQKiQhN+21vd98T5h+UvNvyTbkbE3m9TU2+PKE+UJSa7r4R7VgLyj
         bc3bQKXYrh30oQE/yzJKYm+Qg5e8mjB2DCGEOX5knDwYTo7Wv1AxWwuJguKgHamesi
         n46IxOq3P3Urk19OvefKnezPXFV0J3vt3TiOpiBo=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 19 Dec 2022 18:01:10 +0100 (CET)
Message-ID: <7ab2be50-11c6-f79f-e3f5-a5dc5ec41708@perex.cz>
Date:   Mon, 19 Dec 2022 18:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: =?UTF-8?Q?Re=3a_=5bregression=5d_Bug=c2=a0216818_-_The_microphone_m?=
 =?UTF-8?Q?ute_led_not_working_after_linux_6?=
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     sonic82003@gmail.com, plum <plumerlis@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
References: <bf52f4c5-5cca-26d7-7fb2-ac8ecb5b24c5@leemhuis.info>
 <572159b3-a1a4-8735-d435-ea574c07851f@redhat.com>
 <9f0e95d1-5057-93f0-ad9e-985eaeed0226@leemhuis.info>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <9f0e95d1-5057-93f0-ad9e-985eaeed0226@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 12. 22 11:27, Thorsten Leemhuis wrote:
> On 19.12.22 11:00, Hans de Goede wrote:
>> On 12/19/22 10:17, Thorsten Leemhuis wrote:
>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>> kernel developer don't keep an eye on it, I decided to forward it by
>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216818 :
>>>
>>>>   sonic82003@gmail.com 2022-12-18 08:52:32 UTC
>>>>
>>>> The mic mute led of my ThinkPad X1 Carbon Gen 9 doesn't work anymore after updating linux to version 6.
>>>> I can still turn it on by  running
>>>>
>>>> echo 1 > /sys/class/leds/platform::micmute/brightness
>>>>
>>>> With linux-lts it still works fine.
>>>
>>> See the ticket for more details.
>>>
>>> Note, I found a similar report that (despite my attempts to prevent
>>> things like this from happening) fell through the cracks here:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216355
>>>
>>>>   plum 2022-08-13 02:11:01 UTC
>>>>
>>>> I upgrade to kernel 5.19.1 but found my thinkpad x1 carbon 2021's mute led stop working.
>>>>
>>>> Function is okay but LED won't light up.
>>>>
>>>> Back to kernel 5.18 and it's normal and working again.
>>>>
>>>> Fedora 36 64 bit
>>>> Gnome-shell 42
>>>
>>>  From a quick research it looks to me like this is an issue for the
>>> sounds maintainers, as the LED itself apparently works. If that is
>>> something for the platform people instead please speak up.
>>
>> Thanks for bringing this up, we recently hit this in Fedora too
>> and we have a fix/workaround there. Let me copy and paste what
>> I just added to bko216355 :
> 
> Many thx for sharing these details, really helpful.
> 
>> This is caused by a behavior change of the kernel code controlling the LED to only turn on the LED when all inputs, including e.g. the jack mic input are turned off in the alsa-mixer settings.
>>
>> But most userspace code only turns the mic which it is actually using on/off when you hit the mic-mute hotkey.
>>
>> Also see: https://bugzilla.redhat.com/show_bug.cgi?id=2134824
> 
> Ahh, lot's of helpful information and even a bisect there. :-D
> 
> #regzbot introduced: 9b014266ef8ad0159

It's not a regression from my view.

>> Which is the same bug.
>>
>> There is a set of fixes available in the form of an alsa-ucm update which tells the kernel to ignore the state of the jack mic input restoring the old behavior:
>>
>> https://git.alsa-project.org/?p=alsa-ucm-conf.git;a=commitdiff;h=79a8ec44d3dcf097f4a4492c506cbcf338324175
>> https://git.alsa-project.org/?p=alsa-ucm-conf.git;a=commitdiff;h=9ce9ddb4a84fb467602b716575ea1d8f2bab0c39
> 
> Hmmm, that's nice, but well, by Linux' "no regressions rule" the issue
> is caused by kernel change and thus must be fixed in the kernel, e.g.
> without forcing users to update anything in userspace.
> 
> Jaroslav, are there any plans to do that?

I wrote all relevant information to https://bugzilla.redhat.com/show_bug.cgi?id=2134824 . The problem exists from the initial microphone LED support in the SOF HDA driver, because two drivers control the microphone LED simultaneously (sof-hda-dsp + hda-intel). My recent update just made this thing more visible - the LED state may be updated wrongly in all previous kernels. Original behavior: last write wins. New behavior: all off = LED ON. The UCM fix (update the default kernel runtime configuration from the user space) is sufficient in my eyes for now because even the use case when the microphone LED follows the state when all internal inputs are turned off makes sense.

I think that the sof-hda-dsp driver maintainer may decide to change the default settings in the HDA driver when the digital microphone is detected. Adding Pierre-Louis to the chain.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
