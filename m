Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004E692616
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBJTLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBJTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F95B95
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676056210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wlj+JXAcWLxYE86Ug6fMhTbOB35cUlXqEJcONrx83sg=;
        b=QpmNEeznljTQDa2Rs2hlc8xIDx/dVWOMfJwXq+RdiZbRTFL+oRn9atR4fTgUbG8XOCGi7v
        53m+nSLksgSPWJlz47fd19uG3EsppYErklaQNMYUIGKQz8x0PvXL609X1lc01cznDUIDIj
        L5aeWxRB4lr4deJKmZvmApXxYN4FcQg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-504-37YFCks5OSivINMJjor_bw-1; Fri, 10 Feb 2023 14:10:02 -0500
X-MC-Unique: 37YFCks5OSivINMJjor_bw-1
Received: by mail-ej1-f69.google.com with SMTP id fy3-20020a1709069f0300b008a69400909fso4099820ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wlj+JXAcWLxYE86Ug6fMhTbOB35cUlXqEJcONrx83sg=;
        b=33tQQwxj9ej0+1/pTywodsmxfp0kR49x0afD7B4NF/YHyPRcqP9c6vM6pG+AqDiVJt
         yro3YACKrLVTaoKoBVttUAIuiT9gA49bNedqKpSneCb7EgauJqOWQbz4TwQCbT4i6SCL
         0pUbB7+b8z3BD+lDbbRCCBuh46diftQLWLN/aqHzdupWVpkrwQ2e+4kO0StKhYY/zJWq
         pTW7ExBlJoNvRPG2CINB52zHfaN/8x0cL2sBO1m8WQ4L1HsycDEUmhZsMu45+7YP8rC0
         s+8DMSkiK+w3kXk3dihq4PuOwwRb4KfpB3ap8dqZr9fhBADyfshtpVT3P1bSgNFmzUpV
         rpww==
X-Gm-Message-State: AO0yUKXvW9XB+5m8e9uAmvcm0cy5BEQobZr4oSLkjSmbDeLDqFjaDtrU
        NCDIJhAihVlVhq17+0TSnOXTRaSQKVC6Df48V7zvMvpIcu3grP3oBNpbQSojK5kPhwaaK5g1Lvp
        UxMpYa55IOur4Acua4qSrdEmM
X-Received: by 2002:a17:906:308c:b0:889:14ec:21ae with SMTP id 12-20020a170906308c00b0088914ec21aemr16104695ejv.32.1676056200869;
        Fri, 10 Feb 2023 11:10:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/bQ30pqtJ+DR8BHDulCT6yJnSnGVJYAXD4vakdG0Yio03S4TdacumZBH+AU7G5YgQxaLn3ig==
X-Received: by 2002:a17:906:308c:b0:889:14ec:21ae with SMTP id 12-20020a170906308c00b0088914ec21aemr16104674ejv.32.1676056200632;
        Fri, 10 Feb 2023 11:10:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063a5700b0087bcda2b07bsm2697548ejf.202.2023.02.10.11.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:10:00 -0800 (PST)
Message-ID: <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
Date:   Fri, 10 Feb 2023 20:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
Content-Language: en-US, nl
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-2-orlandoch.dev@gmail.com>
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

On 2/10/23 05:48, Orlando Chamberlain wrote:
> Currently it manually flips the byte order, but we can instead use
> cpu_to_be32(val) for this.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 9333f82cfa8a..e8cb084cb81f 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -94,13 +94,7 @@ static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
>  static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
>  			     u32 val)
>  {
> -	int i;
> -	u8 tmpval;
> -
> -	for (i = 0; i < 4; i++) {
> -		tmpval = (val >> (i * 8)) & 0xff;
> -		outb(tmpval, gmux_data->iostart + port + i);
> -	}
> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
>  }
>  
>  static int gmux_index_wait_ready(struct apple_gmux_data *gmux_data)

The ioport / indexed-ioport accessed apple_gmux-es likely are (part of?)
LPC bus devices . Looking at the bus level you are now changing 4 io
accesses with a size of 1 byte, to 1 32 bit io-access.

Depending on the decoding hw in the chip this may work fine,
or this may work not at all.

I realized that you have asked for more testing, but most surviving
macbooks from the older apple-gmux era appear to be models without
a discrete GPU (which are often the first thing to break) and thus
without a gmux.

Unless we get a bunch of testers to show up, which I doubt. I would
prefer slightly bigger / less pretty code and not change the functional
behavior of the driver on these older models.

Regards,

Hans



> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct apple_gmux_data *gmux_data, int port)
>  static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>  			       u32 val)
>  {
> -	int i;
> -	u8 tmpval;
> -
>  	mutex_lock(&gmux_data->index_lock);
> -
> -	for (i = 0; i < 4; i++) {
> -		tmpval = (val >> (i * 8)) & 0xff;
> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE + i);
> -	}
> -
> +	outl(cpu_to_be32(val), gmux_data->iostart + GMUX_PORT_VALUE);
>  	gmux_index_wait_ready(gmux_data);
>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
>  	gmux_index_wait_complete(gmux_data);

