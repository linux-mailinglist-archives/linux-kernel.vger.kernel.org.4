Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D768C692673
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjBJTe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjBJTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBC7E030
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676057611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgPGguAIupQ40Gj3yYs0g6D0wN93UBUjTZwAvya27/Q=;
        b=LysO3tFreq2lLJs7lF4Pyba6fmHTT0Xq5kBx/hF5uvbIZVrPxuflV6CHZsko/hXDhE5zs1
        3HgzQ77hfsT81TkWSQJCgzc2Zg7r/Lkpi4LUWFdy5XjP5drAGJDAQqDqBlLxg45gBOwnVe
        L8jj1nqw6to4um94c4p8dsZPL/ZNcnQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-M1iq3bjLM8Cqn_fjK7OBOw-1; Fri, 10 Feb 2023 14:33:29 -0500
X-MC-Unique: M1iq3bjLM8Cqn_fjK7OBOw-1
Received: by mail-ej1-f71.google.com with SMTP id fy3-20020a1709069f0300b008a69400909fso4128847ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgPGguAIupQ40Gj3yYs0g6D0wN93UBUjTZwAvya27/Q=;
        b=R8pHYX8/zXuNCegzzWKF5mbNrJKW+Sdmj8IycqdthFeXMokyj3Ahu3raPGM82f8haI
         EODhDQBu/bZhgy4Y9l4LnlnQvZCI8fppjT5NhiL194VQfBDwnYf0Ua4Y/Rs7M0A5UWWw
         V0x85CoB8LO/Mw4gg8j4VUr7R79gqPMo6H25g9veZudwFqFqKGvR13k6qK4hMAluQdnQ
         74S6pWUY0krrnillgnsRiSdU7EqBmD5h909mMECLttqfmqrpN5gcyJGXdoSqN3Jf7HJ0
         rvIsGg9szcv7jDLj9hKgNS0L/QXByliVKfx6F19mh2N8H1BZo57MdAAN/dHEWCCDgeyg
         H4/A==
X-Gm-Message-State: AO0yUKWctP8VmdhTOdsDTcuZdc+I2abs7DNDd3ym76Oy6uiT8dip591G
        k0zzAwZWXMEnVCmEsStZX8Rl0ejlKyHuizYv9owfaUCeW7HpHpoD2/tuoO8lNGFYPWv2qKIh7VN
        Jgz4ah8Uc/dNZNVhsMeLX9RbH
X-Received: by 2002:a50:a45a:0:b0:472:1436:73ab with SMTP id v26-20020a50a45a000000b00472143673abmr17550385edb.28.1676057608629;
        Fri, 10 Feb 2023 11:33:28 -0800 (PST)
X-Google-Smtp-Source: AK7set9lIWI+15QivdoTZK+NEIYP5AV1VIY+nIPcZiME3QwhYRDhgoA8GEIQ9OR9X+Zok/bVlZR+qw==
X-Received: by 2002:a50:a45a:0:b0:472:1436:73ab with SMTP id v26-20020a50a45a000000b00472143673abmr17550370edb.28.1676057608402;
        Fri, 10 Feb 2023 11:33:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b2-20020a50b402000000b004a245d70f17sm2701859edh.54.2023.02.10.11.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:33:27 -0800 (PST)
Message-ID: <990b254c-b55f-539d-d6b5-fa4499078527@redhat.com>
Date:   Fri, 10 Feb 2023 20:33:26 +0100
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Correction to myself, re-reading the LPC specification, then
if I'm right and this is a LPC device then all IO in/out accesses
are always 1 byte accesses. Since the LPC bus only supports 16 / 32
bit accesses for DMA cycles.

So presumably the outl() would get split into 4 separate 8 bit
(port) IO accesses.

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

