Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5E62B3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiKPHMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKPHMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:12:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963E1F9F2;
        Tue, 15 Nov 2022 23:12:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f18so8853529ejz.5;
        Tue, 15 Nov 2022 23:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64PHYzAaFNNc1OQHFrqI08dbrqVbheTU+HNpi6jOPKE=;
        b=K8fjKo3b50WStXGX7mS7x584mtPrnFCscjiMqZtbdNDvs+EUWuEpagbvbzQeuVR/99
         PozQqpXhxBTKv8iku5Qm5IdJzCo1d4boLB5pX3D6apTHqgdO++mRtU/TgAA3+5llB89V
         JNJOjttYkFoRTzyTJnFCNq48vaFLT7zdSTG6ARV/QPL5nI5YzlHA8eWCnYpy0752JLQZ
         40Wypbu41/Kz9WyxVdAYkAVJIRY63iuHWBeY8d9P/Dg6Jomi1l0yNanXgQJlHNnxdLns
         C0XLnaBM/INZ00UDm64e+4JGO0VLWlkjxxe30IHarlO1OlLf0DUX4xevrO9Q5I1u7Xw1
         vN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64PHYzAaFNNc1OQHFrqI08dbrqVbheTU+HNpi6jOPKE=;
        b=hhXFD6GmY/Hf/PuKDTftuHsGvdeEezDCQfXSmIDu2zYBt1BySpw3InSGgXvO3guion
         nyaXRb92mwrGeeATuQjHccX/eOUMGwsU6wixpDEEBFtuNPgDEByRtU+9dS9wfmxYS1l1
         4i/fBoVshQNm18Y0Z5hFY3c9sjIWjDInlepBNX0ebiQ82rp0/T+ukxjEBI3olD5TNEek
         2N+1XkrEhNW0Ol7WGbu874Pak7prtWA/rJQ/m3+uRijl6pzejqJzgmwyZDXaf+6lZlZB
         1EdBpuYsg6wnmH7C1jJeoXQJEg7p0oBuHYrmGJLvCPPjQKdGJlYUtl1ERsKQD2HzSU39
         Yagw==
X-Gm-Message-State: ANoB5pmZ2t6jyLhkj/0jqJzb2nLUG97tcd4wl6Pt7/sciajIPbu2jWAm
        IFJEsEIIJ9cp6R63ReX8vUohFY3nXw0=
X-Google-Smtp-Source: AA0mqf5bmMmMPcgQR1q13tr41JJouzX6gBWCVH/gNDDtSaMBVebkyEaMWaIi1BQWCaW+B94NTJN2QQ==
X-Received: by 2002:a17:907:1010:b0:78d:cd84:9a40 with SMTP id ox16-20020a170907101000b0078dcd849a40mr17044375ejb.167.1668582728066;
        Tue, 15 Nov 2022 23:12:08 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id j17-20020a17090623f100b0078d76ee7543sm6454091ejg.222.2022.11.15.23.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 23:12:07 -0800 (PST)
Subject: Re: [PATCH] usb: phy: add dedicated notifier for charger events
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, felipe.balbi@linux.intel.com
Cc:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-usb@vger.kernel.org, tony@atomide.com
References: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <Y3JpfDU7T2Ks/H4m@kroah.com> <ec4edd51-3915-a798-2310-8ceadcd8152f@gmail.com>
Message-ID: <590de096-5843-eab2-a48c-ca2742cb329b@gmail.com>
Date:   Wed, 16 Nov 2022 09:11:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ec4edd51-3915-a798-2310-8ceadcd8152f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.11.22 г. 18:46 ч., Ivaylo Dimitrov wrote:
> Hi,
> 
> On 14.11.22 г. 18:14 ч., Greg KH wrote:
>> On Mon, Nov 14, 2022 at 02:56:02PM +0200, Ivaylo Dimitrov wrote:
>>> usb_phy::notifier is already used by various PHY drivers (including
>>> phy_generic) to report VBUS status changes and its usage conflicts with
>>> charger current limit changes reporting.
>>
>> How exactly does it conflict?
>>
> 
> see below
> 
>>> Fix that by introducing a second notifier that is dedicated to usb 
>>> charger
>>> notifications. Add usb_charger_XXX_notifier functions. Fix charger 
>>> drivers
>>> that currently (ab)use usb_XXX_notifier() to use the new API.
>>
>> Why not just set the notifier type to be a new one instead of adding a
>> whole new notifier list?  Or use a real callback?  notifier lists are
>> really horrid and should be avoided whenever possible.
>>
> 
> Not sure what you mean by "notifier type', but if that is that val 
> parameter of atomic_notifier_call_chain(), the way it is used by usb 
> charger FW:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy.c#L132
> 
> is not compatible with:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy-generic.c#L185 
> 
> 
> for example, IIUC.
> 
> The former wants to send max current as val, while latter sends event 
> type as val. Sure, I may create some kind of hack, like using the MSB to 
> denote charger events, but that doesn't feel right.
> 
> Or, shall I do something else and fix the usage all over the place? 
> Please elaborate.
> 

Digging further into that, it seems phy-ab8500-usb.c is also using 
usb_phy::notifier in non-standard way, it sends events from 
ux500_musb_vbus_id_status instead of usb_phy_events. I don't know the 
history behind, but right now we have at least 3 incompatible usages of 
usb_phy::notifier:

1. Most of the phy and charger drivers use usb_phy_events as notifier type

2. phy-ab8500-usb.c uses ux500_musb_vbus_id_status as notifier type, I 
am not the only one to hit that it seems 
https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/power/supply/ab8500_charger.c#L3191

3. USB charger framework uses max charging current as notifier type.

Moreover, a charger driver in a system that has gadget drivers support 
and phy that has extcon charger cable detection support and registers to 
phy notifier, will inevitably receive (1) and (3) types of 
notifications, without any way to distinguish I was able to find.

I don't really see how those can be merged to use one notifier only, 
without fixing most of USB phy and gadget drivers and half of charger 
drivers. Not that I like adding the second notifier, I just don;t see 
other way.

Regards,
Ivo

> In regards to callback - I didn't want to come-up with a whole new API, 
> but just fix the current one. Also, a single callback will not be enough 
> - imagine a case with 2 batteries that have to be charged by a single 
> USB port, so 2 separate charger devices, most-probably. We will have to 
> keep a list of callback functions somehow. I admit my lack of knowledge, 
> but, do we already have such API to use?
> 
>>> Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
>>>
>>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>
>> You can't have a blank line between there, checkpatch.pl should have
>> complained.
>>
> 
> it didn't:
> 
> ./scripts/checkpatch.pl 
> 0001-usb-phy-add-dedicated-notifier-for-charger-events.patch
> total: 0 errors, 0 warnings, 90 lines checked
> 
> 0001-usb-phy-add-dedicated-notifier-for-charger-events.patch has no 
> obvious style problems and is ready for submission.
> 
> Will fix, if I am to send v2
> 
> Thanks,
> Ivo
> 
>> thanks,
>>
>> greg k-h
>>
