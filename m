Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F671642D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjE3Oa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjE3O3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:29:52 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FCC10D;
        Tue, 30 May 2023 07:29:27 -0700 (PDT)
Received: from [192.168.178.25] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 742152FC0061;
        Tue, 30 May 2023 16:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1685456932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXOvqfx5EPoWy3M4w6NpHFRCYWVyI+dh3j+HZl5EGZc=;
        b=dcKMlKIuUuuB9sYxmVuyzspkyHBvshoP/HCEQWysEF24I+HRmUC0L1eJfYBJ1JP/QVmlff
        uPZCa0srxJKkrJ2wk8FGCbRQTIg+XX8tat+FgdgCi8GV+x8rs8S8DUXkoSqfdjXJ2T0U7T
        kKN2+trHzYJP1uVVFxQomzMuZ5ZOBUk=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <44574d05-3a2a-2249-b808-7e929feea36d@tuxedocomputers.com>
Date:   Tue, 30 May 2023 16:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] input: Add new keyboard backlight control keys to match
 modern notebooks
To:     Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530110550.18289-1-wse@tuxedocomputers.com>
 <d4d6eb1da42de6536e708331100fc33e9cfae140.camel@hadess.net>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <d4d6eb1da42de6536e708331100fc33e9cfae140.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 30.05.23 um 15:33 schrieb Bastien Nocera:
> On Tue, 2023-05-30 at 13:05 +0200, Werner Sembach wrote:
>> The old three KEY_KBDILLUM* keycodes don't reflect the current
>> situation
>> modern notebooks anymore. Especially the ones with RGB keyboards.
>>
>> e.g.
>> - Clevo NL50NU has a toggle, an up, a down and a color-cycle key
>> - TongFang PH4ARX1 doesn't have a toggle key, but one that cycles
>> through
>>    off, half-brightness, and full-brightness.
>>
>> Also, on some devices these keys are already implemented in firmware.
>> It
>> would still be nice if there is a way to let userspace know when one
>> of
>> these keys is pressed to display the OSD, but don't advice it to
>> actually
>> do anything. This is the intended purpose of the KEY_KBDILLUMCHANGE
>> define.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Can you please point to the user-space patches (or issues filed) that
> would integrate the support for those keycodes, and make the key
> presses do something?

I'm sorry to say that these don't exist yet. So I guess the process is similar 
to DRM uAPI additions? 
https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requirements

>
> Has anyone tested that those keycodes are fit for purpose when mixed
> with other brightness changes that don't happen through key presses?

Color control is not yet implemented in any DE afaik, so there is not yet a 
collision with the color cycle key.

For the brightness cycle key, I would assume that it functions the same as the 
brightness up key unless brightness == brightness max. In this case it sets 
brightness to 0. I don't see a logical collision here as brightness up and 
brightness down are already implemented just fine in most DEs

>
>> ---
>>   include/uapi/linux/input-event-codes.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/linux/input-event-codes.h
>> b/include/uapi/linux/input-event-codes.h
>> index 022a520e31fc2..05287bf9a77f7 100644
>> --- a/include/uapi/linux/input-event-codes.h
>> +++ b/include/uapi/linux/input-event-codes.h
>> @@ -803,6 +803,10 @@
>>   #define BTN_TRIGGER_HAPPY39            0x2e6
>>   #define BTN_TRIGGER_HAPPY40            0x2e7
>>   
>> +#define KEY_KBDILLUMCYCLE              0x2e8
>> +#define KEY_KBDILLUMCOLORCYCLE         0x2e9
>> +#define KEY_KBDILLUMCHANGE             0x2ea
>> +
>>   /* We avoid low common keys in module aliases so they don't get
>> huge. */
>>   #define KEY_MIN_INTERESTING    KEY_MUTE
>>   #define KEY_MAX                        0x2ff
