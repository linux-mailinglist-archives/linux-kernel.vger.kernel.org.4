Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4FA6435AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLEU3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiLEU3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:29:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE892A25A;
        Mon,  5 Dec 2022 12:29:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vp12so1278296ejc.8;
        Mon, 05 Dec 2022 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF8+b4oOLJzfCMJAyK34nfIu5+WDu75TlYxOjfJ4OOw=;
        b=lJlS2gST7Fd/dDSeFwi1xRtVoo19ol6NMhB/uPMdYM+JQasi25cOxfUiX4a1h7i3XR
         gebaHTDuVuHRz1NWePyu6ccKXDTxl9O59zBlWUykaQbBcHEPdYdmEUkTWoFWgr2+A/r3
         spYYr5+JjveEkW7P9JSZS001vD40Myl2qUrERo1unhEHH8f6ptj6Wb9ePMgF2OX1nvCs
         2DUADnqt0n8X1ZcHVY8+Bp/e4jrLgh3F6tYt7U4jgkg2Sq6Wq38XlLODXWQ8lIQDaJMi
         IMzKaA3n3rbIaJn8Glf5bLzgrcojlbYrmAwv5MNXF2nwExEfC8OmrRZUYS27H006hMZ2
         Awtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iF8+b4oOLJzfCMJAyK34nfIu5+WDu75TlYxOjfJ4OOw=;
        b=EIOVFGox12vC5G3LAH5mp88tMQuGDlkuqZrETNeGloF1fLNPRdVweLUbWuMUmGiGEc
         2Y0I/UF6oAe15iIjU6O8j6X38TI4LmrVwJZE59w2ING8g0RmzSvH0IspTztsbBc1meq8
         Gg1+hoCaYXAKrgHpHz5PWVxI58QdwaV9pYAfm+3VvvK1/Jy7DVnI2YTxA9HFL/zh6Sh7
         BnW7ZEnqvTlBA4aellOBgNW4/Pm385InnclqxhOKO7o0PasdlTqyDpcNmAg40i/6YAQE
         aT9Al5fAEbBxXOe0oPGr6piiML2fUIPUbMaCo6Zyx+4kFpgY1iPGgRBrf8FjNxyMWtuc
         Cy6Q==
X-Gm-Message-State: ANoB5pnD2kKevzBsTjwNaGFjJNaFIPMbx/AXY+kQ7yPW23aLXd7I4NYv
        6C/dhqytsX91DuVQ83C+GmU=
X-Google-Smtp-Source: AA0mqf5xGXWBdK2CtWvcPyPy+O0GCKJmvoVnT18A8LprlMrZPX6+a0B5znG1yBwpo7gVgZaSgECDUQ==
X-Received: by 2002:a17:906:d78d:b0:7c0:fa81:ac42 with SMTP id pj13-20020a170906d78d00b007c0fa81ac42mr4059147ejb.526.1670272170168;
        Mon, 05 Dec 2022 12:29:30 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id dy25-20020a05640231f900b004643f1524f3sm193986edb.44.2022.12.05.12.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:29:29 -0800 (PST)
Subject: Re: [PATCH] usb: phy: add dedicated notifier for charger events
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, felipe.balbi@linux.intel.com
Cc:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-usb@vger.kernel.org, tony@atomide.com,
        Pavel Machek <pavel@ucw.cz>
References: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <Y3JpfDU7T2Ks/H4m@kroah.com> <ec4edd51-3915-a798-2310-8ceadcd8152f@gmail.com>
 <590de096-5843-eab2-a48c-ca2742cb329b@gmail.com>
Message-ID: <af63dc7c-6641-13a3-067f-c58923ee510e@gmail.com>
Date:   Mon, 5 Dec 2022 22:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <590de096-5843-eab2-a48c-ca2742cb329b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 16.11.22 г. 9:11 ч., Ivaylo Dimitrov wrote:
> 
> 
> On 14.11.22 г. 18:46 ч., Ivaylo Dimitrov wrote:
>> Hi,
>>
>> On 14.11.22 г. 18:14 ч., Greg KH wrote:
>>> On Mon, Nov 14, 2022 at 02:56:02PM +0200, Ivaylo Dimitrov wrote:
>>>> usb_phy::notifier is already used by various PHY drivers (including
>>>> phy_generic) to report VBUS status changes and its usage conflicts with
>>>> charger current limit changes reporting.
>>>
>>> How exactly does it conflict?
>>>
>>
>> see below
>>
>>>> Fix that by introducing a second notifier that is dedicated to usb 
>>>> charger
>>>> notifications. Add usb_charger_XXX_notifier functions. Fix charger 
>>>> drivers
>>>> that currently (ab)use usb_XXX_notifier() to use the new API.
>>>
>>> Why not just set the notifier type to be a new one instead of adding a
>>> whole new notifier list?  Or use a real callback?  notifier lists are
>>> really horrid and should be avoided whenever possible.
>>>
>>
>> Not sure what you mean by "notifier type', but if that is that val 
>> parameter of atomic_notifier_call_chain(), the way it is used by usb 
>> charger FW:
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy.c#L132
>>
>> is not compatible with:
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy-generic.c#L185 
>>
>>
>> for example, IIUC.
>>
>> The former wants to send max current as val, while latter sends event 
>> type as val. Sure, I may create some kind of hack, like using the MSB 
>> to denote charger events, but that doesn't feel right.
>>
>> Or, shall I do something else and fix the usage all over the place? 
>> Please elaborate.
>>
> 
> Digging further into that, it seems phy-ab8500-usb.c is also using 
> usb_phy::notifier in non-standard way, it sends events from 
> ux500_musb_vbus_id_status instead of usb_phy_events. I don't know the 
> history behind, but right now we have at least 3 incompatible usages of 
> usb_phy::notifier:
> 
> 1. Most of the phy and charger drivers use usb_phy_events as notifier type
> 
> 2. phy-ab8500-usb.c uses ux500_musb_vbus_id_status as notifier type, I 
> am not the only one to hit that it seems 
> https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/power/supply/ab8500_charger.c#L3191 
> 
> 
> 3. USB charger framework uses max charging current as notifier type.
> 
> Moreover, a charger driver in a system that has gadget drivers support 
> and phy that has extcon charger cable detection support and registers to 
> phy notifier, will inevitably receive (1) and (3) types of 
> notifications, without any way to distinguish I was able to find.
> 
> I don't really see how those can be merged to use one notifier only, 
> without fixing most of USB phy and gadget drivers and half of charger 
> drivers. Not that I like adding the second notifier, I just don;t see 
> other way.
> 
> Regards,
> Ivo
> 
>> In regards to callback - I didn't want to come-up with a whole new 
>> API, but just fix the current one. Also, a single callback will not be 
>> enough - imagine a case with 2 batteries that have to be charged by a 
>> single USB port, so 2 separate charger devices, most-probably. We will 
>> have to keep a list of callback functions somehow. I admit my lack of 
>> knowledge, but, do we already have such API to use?
>>
>>>> Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
>>>>
>>>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>>
>>> You can't have a blank line between there, checkpatch.pl should have
>>> complained.
>>>
>>
>> it didn't:
>>
>> ./scripts/checkpatch.pl 
>> 0001-usb-phy-add-dedicated-notifier-for-charger-events.patch
>> total: 0 errors, 0 warnings, 90 lines checked
>>
>> 0001-usb-phy-add-dedicated-notifier-for-charger-events.patch has no 
>> obvious style problems and is ready for submission.
>>
>> Will fix, if I am to send v2
>>
>> Thanks,
>> Ivo
>>
>>> thanks,
>>>
>>> greg k-h
>>>
