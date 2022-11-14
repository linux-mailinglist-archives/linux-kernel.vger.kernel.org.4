Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307496285D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiKNQqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiKNQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:46:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2B2F02C;
        Mon, 14 Nov 2022 08:46:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id n20so9190222ejh.0;
        Mon, 14 Nov 2022 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kVfk9iOxCR/5AAUDXuX1JTXcnEKT9zRZYZEq/zn0mI=;
        b=VoH7Gqrmt/D1SiqudtHQ9uV+QqM9cPEZOsM5bQmL8o7hSpdo5FLEFaybHyPCO2na58
         QcIAzYy/EFwfvwRjshhHv7Xjhyss56bwlj11H35+TkU5xFfMK4Q7WbEdijnzsNOm6QK8
         j+uMJ/GkdorbthBu90IR87N5zcE4sX5kTZ5yE1uqdTPpTyMqqvKDEdlHBrmJoSzBxtu1
         X7vOmAhPaJ9OaW/jPwLjkiVci0Bqd1Z6uiUGJnlsNj1XLUyCjAGPx9Ql9XlO5zfGf02+
         8VEBqXmK3SZUwP4VTF1MiH/38Jqwt5dLzNgMUV+dnKHnANj64OxdVQ9fmRNpvKWd+ZOw
         JUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kVfk9iOxCR/5AAUDXuX1JTXcnEKT9zRZYZEq/zn0mI=;
        b=7Ms5lfayL87HsOH/AC7i5f+TwjWpwpglScOyKRGyuUIAe4XQZUt7ebX+Uvxfj/Oigu
         WbSLTQWGCZ7rFlV+GshYyCYOB5e+v5CgHWyTNHH+HCwJaqbgMYzUhoskebvV64xvLtSZ
         EsASxusLFQDl0IIk3c4JPM2dJrS86vDMzplScRuzU9eS1RgRpsMcIypNLpTzJFP5x4Tu
         tV6XmLfav+h/dTz38wGQK7n49AhARVcxtD5DT8aTThBokRZJs4QQClKGiv6dCkO/TDvn
         X7n/TDWjAKUVGFK3Urvy450I9xe1wYXRYSd/yKG82pm8yTdN0SHwegmoMw+PfbY9Od/s
         U3pg==
X-Gm-Message-State: ANoB5pkhmINdKSsOf62psTFR7xg86th5dSK2R9IgkE6kgjtGv7H2Mr2t
        hLee3W4Q0v2N7IG7uzaDqBU=
X-Google-Smtp-Source: AA0mqf4W69/VYs/D0BKB3i9BfY1aEYPlK0zhv/SK6keEEj+53h/u38atQzUZktzE3ZZcU/vTZjsDeg==
X-Received: by 2002:a17:906:6d52:b0:7ad:9673:8b73 with SMTP id a18-20020a1709066d5200b007ad96738b73mr11358757ejt.14.1668444376036;
        Mon, 14 Nov 2022 08:46:16 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id c20-20020a17090603d400b007417041fb2bsm4403671eja.116.2022.11.14.08.46.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:46:15 -0800 (PST)
Subject: Re: [PATCH] usb: phy: add dedicated notifier for charger events
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, felipe.balbi@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-usb@vger.kernel.org,
        tony@atomide.com
References: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <Y3JpfDU7T2Ks/H4m@kroah.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <ec4edd51-3915-a798-2310-8ceadcd8152f@gmail.com>
Date:   Mon, 14 Nov 2022 18:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Y3JpfDU7T2Ks/H4m@kroah.com>
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

Hi,

On 14.11.22 г. 18:14 ч., Greg KH wrote:
> On Mon, Nov 14, 2022 at 02:56:02PM +0200, Ivaylo Dimitrov wrote:
>> usb_phy::notifier is already used by various PHY drivers (including
>> phy_generic) to report VBUS status changes and its usage conflicts with
>> charger current limit changes reporting.
> 
> How exactly does it conflict?
> 

see below

>> Fix that by introducing a second notifier that is dedicated to usb charger
>> notifications. Add usb_charger_XXX_notifier functions. Fix charger drivers
>> that currently (ab)use usb_XXX_notifier() to use the new API.
> 
> Why not just set the notifier type to be a new one instead of adding a
> whole new notifier list?  Or use a real callback?  notifier lists are
> really horrid and should be avoided whenever possible.
> 

Not sure what you mean by "notifier type', but if that is that val 
parameter of atomic_notifier_call_chain(), the way it is used by usb 
charger FW:

https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy.c#L132

is not compatible with:

https://elixir.bootlin.com/linux/latest/source/drivers/usb/phy/phy-generic.c#L185

for example, IIUC.

The former wants to send max current as val, while latter sends event 
type as val. Sure, I may create some kind of hack, like using the MSB to 
denote charger events, but that doesn't feel right.

Or, shall I do something else and fix the usage all over the place? 
Please elaborate.

In regards to callback - I didn't want to come-up with a whole new API, 
but just fix the current one. Also, a single callback will not be enough 
- imagine a case with 2 batteries that have to be charged by a single 
USB port, so 2 separate charger devices, most-probably. We will have to 
keep a list of callback functions somehow. I admit my lack of knowledge, 
but, do we already have such API to use?

>> Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> 
> You can't have a blank line between there, checkpatch.pl should have
> complained.
> 

it didn't:

./scripts/checkpatch.pl 
0001-usb-phy-add-dedicated-notifier-for-charger-events.patch
total: 0 errors, 0 warnings, 90 lines checked

0001-usb-phy-add-dedicated-notifier-for-charger-events.patch has no 
obvious style problems and is ready for submission.

Will fix, if I am to send v2

Thanks,
Ivo

> thanks,
> 
> greg k-h
> 
