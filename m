Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB6677C96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjAWNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C32F4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674480895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUT6/zGIPc3GwuNn3l/4iMhblSRDyrBxcho5VS5gv14=;
        b=BVY/GRlJAKgfMMKEyunvoiYjbpHKkNpWWoA0ktMytNJ23t+yY3ECAaTtJnjY7EJgaErO20
        EltdBCc9KpKbgTSg59OgQgbGjwauRbEuv3xD+1eDRkytUyPOfWj53impdaXo0QkF6Urp+R
        iW4QC9LAczhnC/1/RupBBbudjhKIMY0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-_h_yZyCaMwmE2vdevXvctA-1; Mon, 23 Jan 2023 08:34:54 -0500
X-MC-Unique: _h_yZyCaMwmE2vdevXvctA-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640240d400b0049e1b5f6175so8416140edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUT6/zGIPc3GwuNn3l/4iMhblSRDyrBxcho5VS5gv14=;
        b=y+1sLaduwYEltOuL48OixJm7CMlOBP5eptDFDrEXg6xvTLZ+S3P/QlSb4P325IsVsR
         PvfKiWyp/LKOovif7cHcE1wJt53z5oAmOAbdGtakVIdf4C2dIoTPR1wcJk0Y2NhayAdf
         GGGAjodLdKrW5TqAKXInwHlRz9W1F25dml2f8H5fN6AfIPypc4PaZYiIYu7GqUsK2+qc
         qSVKUNAwYPkb8VExmlq3gd9DA31z/C2f6PxtAScWCt4XEiQSwOovJU+Hx5YnSR0qPGA6
         pYjk/5BS8xysoy2U2AmTMVnKxIZJU0qo3rMN3iW/JPtcGaap/CodJElyiUFiQDvRHFHD
         OkNQ==
X-Gm-Message-State: AFqh2krx93ioOJnypp5ljlkPLAYB82WCJPfergzyPXnPf/O3eu+b91r3
        hfHv517+9B1nIkA3I7fDlu5Z+nmpy6lZJr3C8gWv10RYCSg3ZG8jymjJ3IFcylAOe19Cl5FSxb5
        ea2QG0jdFExc/QjtOnrPOAC2Q
X-Received: by 2002:a17:907:1a46:b0:84c:e89e:bb4c with SMTP id mf6-20020a1709071a4600b0084ce89ebb4cmr19026952ejc.49.1674480892237;
        Mon, 23 Jan 2023 05:34:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvVz1e+IQ7iriHxvELemZZDhErW9+SvqO4YhjbKOhGN5N4jCrBvnY+J4tjbGuXWBBj3uSFYyg==
X-Received: by 2002:a17:907:1a46:b0:84c:e89e:bb4c with SMTP id mf6-20020a1709071a4600b0084ce89ebb4cmr19026938ejc.49.1674480892013;
        Mon, 23 Jan 2023 05:34:52 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x3-20020a170906b08300b007c0688a68cbsm22600614ejy.176.2023.01.23.05.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:34:51 -0800 (PST)
Message-ID: <1d75815a-d3a4-0b82-5f4a-02caa01ba35a@redhat.com>
Date:   Mon, 23 Jan 2023 14:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: hp-wmi: Handle Omen Key event
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y8cjgu1ql+5+/NST@rishit-OMEN-Laptop-15-en0xxx>
 <919e1992-e1ca-cc7f-fcc1-23a01993b4b8@redhat.com>
In-Reply-To: <919e1992-e1ca-cc7f-fcc1-23a01993b4b8@redhat.com>
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

On 1/23/23 14:32, Hans de Goede wrote:
> Hi,
> 
> On 1/17/23 23:38, Rishit Bansal wrote:
>> Add support to map the "HP Omen Key" to KEY_PROG2. Laptops in the HP
>> Omen Series open the HP Omen Command Center application on windows. But,
>> on linux it fails with the following message from the hp-wmi driver:
>>
>> [ 5143.415714] hp_wmi: Unknown event_id - 29 - 0x21a5
>>
>> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

I just noticed you send out a v2. I'll replace the patch in my
branch with v2 instead.

Regards,

Hans


>> ---
>>  drivers/platform/x86/hp/hp-wmi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>> index 0a99058be813..d8ba3c483901 100644
>> --- a/drivers/platform/x86/hp/hp-wmi.c
>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>> @@ -91,6 +91,7 @@ enum hp_wmi_event_ids {
>>  	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>>  	HPWMI_SANITIZATION_MODE		= 0x17,
>>  	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>> +	HPWMI_OMEN_KEY				= 0x1D,
>>  };
>>  
>>  /*
>> @@ -219,6 +220,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>>  	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>>  	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>>  	{ KE_KEY, 0x231b,  { KEY_HELP } },
>> +	{ KE_KEY, 0x21a5,  { KEY_PROG2 }}, /* HP Omen Key */
>>  	{ KE_END, 0 }
>>  };
>>  
>> @@ -810,6 +812,7 @@ static void hp_wmi_notify(u32 value, void *context)
>>  	case HPWMI_SMART_ADAPTER:
>>  		break;
>>  	case HPWMI_BEZEL_BUTTON:
>> +	case HPWMI_OMEN_KEY:
>>  		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
>>  		if (key_code < 0)
>>  			break;

