Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E056D26C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCaRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCaRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA641E71F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680284070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thdjmYdzdNUYYa5BUZs77ARM8oqqYSIUPVnIwxv8/Xo=;
        b=JNtlCOpXlCHfEADbl3mGv3BkMwOmJf7o1qBIn5yt/+4gjE7/UQ7IzfbUmoYa3sFlFCzIXQ
        1J0Cvul+ughrlSFb8k9oBSpEfCkoT86wma8R+JQ1hz7dfEOZBUmh4RiHpPJoB2Lt/JeQ2O
        PBEFxZFvG8veNu/NijHVh1QlDwwkw5k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Hg1GkxKSM4e41DQcL9cOAw-1; Fri, 31 Mar 2023 13:34:29 -0400
X-MC-Unique: Hg1GkxKSM4e41DQcL9cOAw-1
Received: by mail-ed1-f71.google.com with SMTP id x35-20020a50baa6000000b005021d1b1e9eso33150875ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thdjmYdzdNUYYa5BUZs77ARM8oqqYSIUPVnIwxv8/Xo=;
        b=lRg0AO0jAj69MlrbIn3wZghCsQwn1oko7JclYGDRtbwO3hzOwzCMTHgR7RkltRHW6/
         pJccNXNu5/+StAOhIS/2P91yVac9RDekiKSknRtv/fsQiM1Pc1ODR0s+Qfrqo+lKCotN
         aYVlSD9pKyOgIBlyzAd+vyinOH1yJkNg/tGtVzXsVSQmPfmE5WFo0lS1wFjcbnsl9Mkx
         uHRgamyjoD1PxhAC3iFgklz6t8CofPv2+uX8RLicNCWBIIFvWcT8nEgXGeLEPs3GcVL/
         8pnDSHmdx5ZDBnJ+bKQEEZoUKRRQecAFW5hAWR9N8KnE79fu5g2PNfHrZYltzIa1h7z3
         kRlQ==
X-Gm-Message-State: AAQBX9fEk0zxHVyy6VsGfea6aXMnT41E6B/5r4LzOfD9vu6VDioOx6tC
        rjGLlyM0G4152Xvc1AnuDJoqS2mdLc14g7OPY2xJ0cfmXyvmpCeuJ0gGHkSBixmG2aXU+mOzKvk
        VxWbwRJvnTyOo2VEl4TVd0tVK
X-Received: by 2002:aa7:cd12:0:b0:4fd:20ee:225d with SMTP id b18-20020aa7cd12000000b004fd20ee225dmr24750342edw.24.1680284068196;
        Fri, 31 Mar 2023 10:34:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+7N67YQnfQFTGBh2sNN+uqA26wkrpsm/usxs7lDNVehSW3Mu3K8zluwm8x/DugJ+LLodEgw==
X-Received: by 2002:aa7:cd12:0:b0:4fd:20ee:225d with SMTP id b18-20020aa7cd12000000b004fd20ee225dmr24750328edw.24.1680284067957;
        Fri, 31 Mar 2023 10:34:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b00930c7b642d0sm1166526eje.166.2023.03.31.10.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 10:34:27 -0700 (PDT)
Message-ID: <3a89c1f4-f876-3a5d-465c-6d374890b6e3@redhat.com>
Date:   Fri, 31 Mar 2023 19:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Add "X570S AORUS ELITE" to known working boards
Content-Language: en-US, nl
To:     linux@weissschuh.net, Brandon Nielsen <nielsenb@jetfuse.net>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331014902.7864-1-nielsenb@jetfuse.net>
 <2cf99af4-2d6c-44b6-a133-4ff0d94dca20@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2cf99af4-2d6c-44b6-a133-4ff0d94dca20@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/31/23 11:44, linux@weissschuh.net wrote:
> Hi,
> 
> thanks for the patch!
> 
> 
> Mar 31, 2023 04:01:37 Brandon Nielsen <nielsenb@jetfuse.net>:
> 
>> ---
>> drivers/platform/x86/gigabyte-wmi.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
>> index 4dd39ab6ecfa..ca5124e31d2c 100644
>> --- a/drivers/platform/x86/gigabyte-wmi.c
>> +++ b/drivers/platform/x86/gigabyte-wmi.c
>> @@ -160,6 +160,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>>     DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
>>     DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
>>     DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
>> +   DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570S AORUS ELITE"),
>>     DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z690M AORUS ELITE AX DDR4"),
>>     { }
>> };
>> -- > 2.39.2
> 
> 
> This patch is missing a proper subject line, a commit message and Signed-off-by.
> Please send a v2 and take a look how similar patches are structured.
> 
> https://lore.kernel.org/lkml/20220705184407.14181-1-parherman@gmail.com/

Since I'm preparing a fixes pull-req to send to Linus today
and since this is just a simple hw-id addition I have merged this now,
so that it can be included in the fixes pull-req.

I have fixed the subject and solved the missing Signed-off-by problem
by setting myself as author and crediting Brandon with a:

Reported-by: Brandon Nielsen <nielsenb@jetfuse.net>

Regards,

Hans




