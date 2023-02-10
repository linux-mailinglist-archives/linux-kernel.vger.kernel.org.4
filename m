Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F544692635
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjBJTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjBJTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC07BFFD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676056771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwSrY4DltmA/yFlYQvFrP0zXeruXNly6+GpVcGdaJm4=;
        b=OFJRyp+mo5iG8+V2PlHtSve8YNPOj7jEw4aUkdR+0LjWm20RBoZBe9sRlgCy8pb3t7gKGO
        2cDw8xUZcRYOwhMCtfV5atokPZVx5HHyNWGY2TUAwMgrpKpqYPuuaWww1Ay503nHmRKD8M
        DazlLL4vKR8TxjDyrU1gr2W/YQVuKyQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-b8wH1pUTOIO_KJsuFce06A-1; Fri, 10 Feb 2023 14:19:30 -0500
X-MC-Unique: b8wH1pUTOIO_KJsuFce06A-1
Received: by mail-ed1-f72.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso4136580edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwSrY4DltmA/yFlYQvFrP0zXeruXNly6+GpVcGdaJm4=;
        b=iGraWecyQHkdCwfT4sPi48e+k8zDPT9AFHbXTQpAevNILEHrXUs+lJBcdgxpvwH9CN
         Rad7pWqSeOGe6l9yiMF4EeY3rvnIdX7V+sCCPcsrG3iqE4G7gzv9NHyjSGTwAGg1q7mK
         iha5ik8BjT1W2OlTTPXEu4OAZqQVX+XG727ZVbswfUyKCAgOvvVdyztpQ2/rZEXrjMCM
         nPzdLlXlwHkZBBQdRGc43N4ARKbVVuze+O8GCVeks0Kr6YK3bzPHHHZuUcfC4nmUBbEt
         kHCfIeI33y1PpPVCA7krgySWIBv6vbliEombmX2rtB3CkeaQDgG7OTjQ/aJoT7sOmZCO
         d6OQ==
X-Gm-Message-State: AO0yUKVbWmbnA84960A4DhfE4Hm34YVJWiBm10O5gI8rhXYiEwZm+0Uu
        idBnR2unqirVtLROW8My/NLxh5fnBdBhAUHrG74cWv5+1BLuREmRwsvLOdQTzpMJnHbKES3SuP4
        TIKuNRwg/1fHvCk+hBfwa/TS3
X-Received: by 2002:a17:906:308e:b0:88a:da35:dd51 with SMTP id 14-20020a170906308e00b0088ada35dd51mr16539097ejv.14.1676056769345;
        Fri, 10 Feb 2023 11:19:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/LjslSqRW4K+lvECJSA5kEr2lyEGJrPcE6CF5MmtIxPBIdllG3b8htAgAt5ndbUDTe3go1qA==
X-Received: by 2002:a17:906:308e:b0:88a:da35:dd51 with SMTP id 14-20020a170906308e00b0088ada35dd51mr16539083ejv.14.1676056769183;
        Fri, 10 Feb 2023 11:19:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090634ce00b00877e1bb54b0sm2770373ejb.53.2023.02.10.11.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:19:28 -0800 (PST)
Message-ID: <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
Date:   Fri, 10 Feb 2023 20:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
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
In-Reply-To: <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
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

On 2/10/23 20:09, Hans de Goede wrote:
> Hi,
> 
> On 2/10/23 05:48, Orlando Chamberlain wrote:
>> Currently it manually flips the byte order, but we can instead use
>> cpu_to_be32(val) for this.
>>
>> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
>> ---
>>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index 9333f82cfa8a..e8cb084cb81f 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -94,13 +94,7 @@ static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
>>  static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
>>  			     u32 val)
>>  {
>> -	int i;
>> -	u8 tmpval;
>> -
>> -	for (i = 0; i < 4; i++) {
>> -		tmpval = (val >> (i * 8)) & 0xff;
>> -		outb(tmpval, gmux_data->iostart + port + i);
>> -	}
>> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
>>  }
>>  
>>  static int gmux_index_wait_ready(struct apple_gmux_data *gmux_data)
> 
> The ioport / indexed-ioport accessed apple_gmux-es likely are (part of?)
> LPC bus devices . Looking at the bus level you are now changing 4 io
> accesses with a size of 1 byte, to 1 32 bit io-access.
> 
> Depending on the decoding hw in the chip this may work fine,
> or this may work not at all.
> 
> I realized that you have asked for more testing, but most surviving
> macbooks from the older apple-gmux era appear to be models without
> a discrete GPU (which are often the first thing to break) and thus
> without a gmux.
> 
> Unless we get a bunch of testers to show up, which I doubt. I would
> prefer slightly bigger / less pretty code and not change the functional
> behavior of the driver on these older models.

A quick follow up on this, I just noticed that only the pio_write32
is doing the one byte at a time thing:

static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
{
        return inl(gmux_data->iostart + port);
}

static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
                             u32 val)
{
        int i;
        u8 tmpval;

        for (i = 0; i < 4; i++) {
                tmpval = (val >> (i * 8)) & 0xff;
                outb(tmpval, gmux_data->iostart + port + i);
        }
}

And if you look closely gmux_pio_write32() is not swapping
the order to be32 at all, it is just taking the bytes
in little-endian memory order, starting with the first
(index 0) byte which is the least significant byte of
the value.

On x86 the original code is no different then doing:

static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
                             u32 val)
{
        u8 *data = (u8 *)&val;
        int i;

        for (i = 0; i < 4; i++)
                outb(data[i], gmux_data->iostart + port + i);
}

So yeah this patch is definitely wrong, it actually swaps
the byte order compared to the original code. Which becomes
clear when you look the weird difference between the read32 and
write32 functions after this patch.

Presumably there is a specific reason why gmux_pio_write32()
is not already doing a single outl(..., val) and byte-ordering
is not the reason.

Regards,

Hans



>> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct apple_gmux_data *gmux_data, int port)
>>  static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>>  			       u32 val)
>>  {
>> -	int i;
>> -	u8 tmpval;
>> -
>>  	mutex_lock(&gmux_data->index_lock);
>> -
>> -	for (i = 0; i < 4; i++) {
>> -		tmpval = (val >> (i * 8)) & 0xff;
>> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE + i);
>> -	}
>> -
>> +	outl(cpu_to_be32(val), gmux_data->iostart + GMUX_PORT_VALUE);
>>  	gmux_index_wait_ready(gmux_data);
>>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
>>  	gmux_index_wait_complete(gmux_data);
> 

