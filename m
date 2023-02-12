Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050516936B7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 10:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBLJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 04:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBLJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 04:28:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3110A8E;
        Sun, 12 Feb 2023 01:28:44 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADB976600014;
        Sun, 12 Feb 2023 09:28:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676194122;
        bh=UPHSay6GRJctXqWjosSC9IO7+yLvYxLbQJrN+e7kbGc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nW4RNGEafAD9F6Y2qJQXNM3Zxaqs7CSgWW3b+6C7EiSFia5bkAxhRDhdVvV42KVGz
         v1Al/nmU8xLnpTj3ArCmyHoMSAg0vNdJuYVw/atEwoXeXbPkvfHH/CUdmwG4t+4WqF
         fvvg5Z9Id1vD2NvY9SMlL7OqvMEZfV5KMpIH4Zi4om5fQ5WjLMiGLxPZpCC6bDwgdZ
         b4fvL9D1CPEcrt4wqRF51rgbeNqGIbWuuaHhwIzes4NwOFi4x7dco6ehuCu0XmwW9B
         Dp0dHKVsGgzBn+YTqSqtwoAmWLCwtlCSsyFIcXj8fl6wAb3trgXG/6nSebYaM+pVJM
         qFJE6+thJhUQA==
Message-ID: <1e3ef067-9b39-dc19-5fbc-75436c67f206@collabora.com>
Date:   Sun, 12 Feb 2023 09:28:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 3/4] ALSA: cs35l41: Add shared boost feature
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
 <20230210091942.10866-4-lucas.tanure@collabora.com>
 <20230210134341.GF68926@ediswmail.ad.cirrus.com>
 <cfacc3d6-2daa-6aa3-ba19-281b7e48bb47@collabora.com>
 <20230211170638.GG68926@ediswmail.ad.cirrus.com>
Content-Language: en-US
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <20230211170638.GG68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-2023 17:06, Charles Keepax wrote:
> On Fri, Feb 10, 2023 at 02:39:56PM +0000, Lucas Tanure wrote:
>> On 10-02-2023 13:43, Charles Keepax wrote:
>>> On Fri, Feb 10, 2023 at 09:19:41AM +0000, Lucas Tanure wrote:
>>>> +	{CS35L41_MDSYNC_EN,        0x00001000},
>>> David's internal patch appears to set 0x3000 on the active side,
>>> not sure where that difference snuck in, or which is the correct
>>> value. Your settings appear to make logical sense to me though, TX
>>> on the active side, RX on the passive side.
>> And as the patch sets TX and RX in the same chip I changed to follow
>> the documentation.
> 
> Yeah I mean I suspect this is sensible, unless there is some
> reason the controller side also needs to have RX enabled. Perhaps
> for feedback or something from the passive side, but I imagine
> this is just a typo in the original patch.

Ok, but the other side doesn't have both RX and TX enabled.
If the active side needed RX to receive information for the other side, 
the passive one would need TX enabled too.
So if a feedback is necessary, both channels on both sides would be 
enabled, not one channel in one side and both on the other.


> 
>>>> +	/* BST_CTL_SEL = CLASSH */
>>>> +	{CS35L41_BSTCVRT_VCTRL2,    0x00000001},
>>> BST_CTL_SEL is in BSTCVRT_VCTRL1 (or BOOST_VOLTAGE_CFG, as it
>>> is called in the datasheet, yay us for using the same names).
>>> That does not mean this write is wrong, could just be the
>>> comment, but what this does write is a bit odd so I would like
>>> David to confirm this isn't some typo in his original patch.
>> I can't find BOOST_VOLTAGE_CFG on my datasheet, but BST_CTL_SEL is
>> at 0x00003804 ( BSTCVRT_VCTRL2 / VBST_CTL_2 ).
>> This write here is to select the boost control source, which for the
>> active should be "Class H tracking value".
>> So I still think this is correct.
> 
> Yeah this one is a mistake on my part, I was reviewing some
> patches on another amp just before I think I have looked at the
> wrong datasheet here. You are correct those bits are infact
> BST_CTL_SEL. So ignore this one.
> 
>>>> +		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
>>>> +		regmap_read(regmap, CS35L41_GPIO_PAD_CONTROL, &pad_control);
>>>> +
>>>> +		pwr_ctrl3 &= ~CS35L41_SYNC_EN_MASK;
>>>> +		pwr_ctrl1 = enable << CS35L41_GLOBAL_EN_SHIFT;
>>>
>>> Are you sure this is what you want? In the case of powering up,
>>> the sequence would end up being:
>>>
>>> mdsync_down
>>>   -> sets GLOBAL_EN on
>>> mdsync_up
>>>   -> sets GLOBAL_EN off
>>>   -> sets GLOBAL_EN on
>>>
>>> Feels like mdsync_down should always turn global_enable off? But
>>> again I don't know for sure. But then I guess why is there the
>>> extra write to turn it off in mdsync_up?
>>
>> For the disable case (DAPM turning everything off) SYNC and Global
>> enable are off and the code hits
>>
>> if (!enable)
>> 	break;
> 
> Yes, so the disable flow makes perfect sense here it is the
> enable flow that seemed odd.
> 
>> But for for enable case (DAPM turning everything On) the code
>> continues enabling SYNC_EN, and turning off Global enable, as
>> requested by
>> "4.10.1 Multidevice Synchronization Enable" page 70.
>> But as it is a enable path Global should be enabled again.
>>
>> I can't see any sign of
>>> GLOBAL_EN bouncing in David's internal patch.
>>
>> Yes, but it is required by :
>> "4.10.1 Multidevice Synchronization Enable" page 70.
> 
> Hmm... yes that does appear to suggest bouncing the global
> enable. Kinda weird, I can't help but wonder if the turning
> global enable off is actually needed, but I guess it does say
> that so probably safest. It is also rather unclear on who that
> sequence should be performed on it says:
> 
> "When powering up a second (and each subsequent) CS35L41B onto a
> shared MDSYNC bus, the following protocol must
> be followed"
> 
> But very unclear if that sequence should be followed on only the
> new device, the master device, or on all devices. I will try to
> find some time to chase some apps guys next week see if anyone
> has any ideas.
I had long talks with apps guys on this when I was at Cirrus.
And my understanding is:
A new CS35L41 can misunderstand the information on MDSYNC bus if a 
communication is already in place, between another pair of CS35L41, so 
to avoid that, any CS35L41 being turn on in a already active MDSYNC bus, 
must execute those steps.

We could move the active amp up in DAPM graph so its enabled before all 
passive ones, but we would still need to execute that for all passive 
amps. So there is not much point in that.

Here I can see that if I enable SYNC_EN during probe without clocks the 
device becomes unresponsive, at least with the current code.
So following the datasheet and enabling SYNC_EN only after clocks seems 
to resolve Steam decks issue.

Questions I never got an answer from APPS guys:

- Can we enable SYNC_EN during probe if we know there is no playback
happening, no clocks and Global enable off? Steam decks seem to answer 
no here. If yes, why having pm_runtime features makes the device become 
unresponsive?

- Can we leave SYNC_EN enabled during Global enable off and no clocks?

- If SYNC_EN is enabled and we only set Global enable on after the PLL 
lock happened, do we still need to execute those steps? I mean, if the 
driver only deals with Global enable and leaves shared boost configured 
since boost, will MDSYNC bus work?

Thanks
Lucas

> 
> Thanks,
> Charles

