Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8469304F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBKL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D040CC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676114842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TWzbGwMUNW+n8L9sktXtMN7s4j2QAb4DRV1g3S7J38=;
        b=bu8Dmz7z3uYl5g+DMcdGoOP4fnNBbFsp5gzAXtJ4J26NXu0mYNONW1zlpggu2WRWils9nL
        /r0ZuL+j43xMsHL4QuKUNxGoB6G/4iqT79dXcfhQ0ytkPCoHtDi4cZ4mVj1L8J1FU2blG7
        p7cQMliqhaUuU1WP22r3Apd1oWJwivw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-2qRRMwiIPu6FVGugOhJT1g-1; Sat, 11 Feb 2023 06:27:21 -0500
X-MC-Unique: 2qRRMwiIPu6FVGugOhJT1g-1
Received: by mail-ej1-f69.google.com with SMTP id qk8-20020a1709077f8800b008af3fb43869so4440867ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TWzbGwMUNW+n8L9sktXtMN7s4j2QAb4DRV1g3S7J38=;
        b=cXTfYoMhihgCTMsHf7jSPaYsDmlBxiVKWohdQf5/bcrEZYMRlL/93OxOxdPvZ/Gj3X
         2A4OcjvQM3OW3SLbOUnSRUnuFZ5A/mo9Bu3SdfKsZnCrTb0DmPVOlG93NT4WqoiHM8TB
         yYEgV4ymTswsqQr6AclEmSWbxTSCWsMX30rznU1sQEhBM8HYMx89abe9tt5aOvEa3KWa
         gfWKvDz9Jo487gwo3Di+rwRx0Ih0NMFdwM+NVdEHq6mJihiwDNkwUCHf+9y4cLdblqsl
         bSupIF6mF0O+8mH3yBChCIsQqbkkyY4XNhtB3owihjTgv8MmQswhCRCeCJHe1NIMQPJy
         LrTg==
X-Gm-Message-State: AO0yUKVGVgRkI0xodEcoVYork0Dbr3kp/yKkWCOMqvfDGqdoZd4RmWz+
        u7Cle2WyRAS16E1LwffoRLn5CGBt3sY/J5rPgaxOzj1YBHHqLzoIkYvcagKNlfDa2ycRiNXQXzY
        iS2WvAslw+slP/n3NljXLVahG
X-Received: by 2002:a17:906:6a15:b0:895:58be:94d with SMTP id qw21-20020a1709066a1500b0089558be094dmr27969773ejc.3.1676114840055;
        Sat, 11 Feb 2023 03:27:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+CyhHdGJQxbppC+Q3hsT5VQygsBF0ob0PfWcSKa7EUj25Mb49WmvY947P55TtHbER842rQYw==
X-Received: by 2002:a17:906:6a15:b0:895:58be:94d with SMTP id qw21-20020a1709066a1500b0089558be094dmr27969751ejc.3.1676114839857;
        Sat, 11 Feb 2023 03:27:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906490b00b0084d4b8f5889sm3715458ejq.102.2023.02.11.03.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 03:27:19 -0800 (PST)
Message-ID: <3b6f8d89-f803-ace8-a3ae-ed9870f22b37@redhat.com>
Date:   Sat, 11 Feb 2023 12:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-2-orlandoch.dev@gmail.com>
 <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
 <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
 <20230211103024.2a204487@redecorated-mbp>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230211103024.2a204487@redecorated-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/23 00:30, Orlando Chamberlain wrote:
> On Fri, 10 Feb 2023 20:19:27 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 2/10/23 20:09, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/10/23 05:48, Orlando Chamberlain wrote:  
>>>> Currently it manually flips the byte order, but we can instead use
>>>> cpu_to_be32(val) for this.
>>>>
>>>> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
>>>> ---
>>>>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
>>>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/apple-gmux.c
>>>> b/drivers/platform/x86/apple-gmux.c index
>>>> 9333f82cfa8a..e8cb084cb81f 100644 ---
>>>> a/drivers/platform/x86/apple-gmux.c +++
>>>> b/drivers/platform/x86/apple-gmux.c @@ -94,13 +94,7 @@ static u32
>>>> gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
>>>> static void gmux_pio_write32(struct apple_gmux_data *gmux_data,
>>>> int port, u32 val) {
>>>> -	int i;
>>>> -	u8 tmpval;
>>>> -
>>>> -	for (i = 0; i < 4; i++) {
>>>> -		tmpval = (val >> (i * 8)) & 0xff;
>>>> -		outb(tmpval, gmux_data->iostart + port + i);
>>>> -	}
>>>> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
>>>>  }
>>>>  
>>>>  static int gmux_index_wait_ready(struct apple_gmux_data
>>>> *gmux_data)  
>>>
>>> The ioport / indexed-ioport accessed apple_gmux-es likely are (part
>>> of?) LPC bus devices . Looking at the bus level you are now
>>> changing 4 io accesses with a size of 1 byte, to 1 32 bit io-access.
>>>
>>> Depending on the decoding hw in the chip this may work fine,
>>> or this may work not at all.
>>>
>>> I realized that you have asked for more testing, but most surviving
>>> macbooks from the older apple-gmux era appear to be models without
>>> a discrete GPU (which are often the first thing to break) and thus
>>> without a gmux.
>>>
>>> Unless we get a bunch of testers to show up, which I doubt. I would
>>> prefer slightly bigger / less pretty code and not change the
>>> functional behavior of the driver on these older models.  
>>
>> A quick follow up on this, I just noticed that only the pio_write32
>> is doing the one byte at a time thing:
>>
>> static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int
>> port) {
>>         return inl(gmux_data->iostart + port);
>> }
>>
>> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
>> port, u32 val)
>> {
>>         int i;
>>         u8 tmpval;
>>
>>         for (i = 0; i < 4; i++) {
>>                 tmpval = (val >> (i * 8)) & 0xff;
>>                 outb(tmpval, gmux_data->iostart + port + i);
>>         }
>> }
>>
>> And if you look closely gmux_pio_write32() is not swapping
>> the order to be32 at all, it is just taking the bytes
>> in little-endian memory order, starting with the first
>> (index 0) byte which is the least significant byte of
>> the value.
>>
>> On x86 the original code is no different then doing:
>>
>> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
>> port, u32 val)
>> {
>>         u8 *data = (u8 *)&val;
>>         int i;
>>
>>         for (i = 0; i < 4; i++)
>>                 outb(data[i], gmux_data->iostart + port + i);
>> }
>>
>> So yeah this patch is definitely wrong, it actually swaps
>> the byte order compared to the original code. Which becomes
>> clear when you look the weird difference between the read32 and
>> write32 functions after this patch.
>>
>> Presumably there is a specific reason why gmux_pio_write32()
>> is not already doing a single outl(..., val) and byte-ordering
>> is not the reason.
>>
>> Regards,
>>
>> Hans
> 
> Sounds like it may be better to just drop this patch as there's very
> little benefit for the risk of causing a regression.

Yes if it is easy to drop this please drop this.

And the same more or less applies to 2/9. I would rather have
an extra "if () ... else ..."  in the code in a couple of places
then change behavior on old hw where we cannot get proper test
coverage (but will likely eventually get regressions reports
if we break things).

Thanks & Regards,

Hans



>>>> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct
>>>> apple_gmux_data *gmux_data, int port) static void
>>>> gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>>>> u32 val) {
>>>> -	int i;
>>>> -	u8 tmpval;
>>>> -
>>>>  	mutex_lock(&gmux_data->index_lock);
>>>> -
>>>> -	for (i = 0; i < 4; i++) {
>>>> -		tmpval = (val >> (i * 8)) & 0xff;
>>>> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE
>>>> + i);
>>>> -	}
>>>> -
>>>> +	outl(cpu_to_be32(val), gmux_data->iostart +
>>>> GMUX_PORT_VALUE); gmux_index_wait_ready(gmux_data);
>>>>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
>>>>  	gmux_index_wait_complete(gmux_data);  
>>>   
>>
> 

