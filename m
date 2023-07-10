Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5B74D7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGJNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGJNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD8C170E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688996029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak9fRbxuixcIYTWvlnH4cZYdZvxzAVmoXYAJWfQ6iRg=;
        b=h+Z0sMJfmkmR0u/i9eqClIvtNUXjitjXAzijoVWuVAKYoNOn0vWqBzgjzSOIDpJng8ky3g
        I6cn4te35Lj0I37ruhKagCSDDrLqpKd7VhHXXxOaUorL876NaCawD7DscTZuQM0rDOHwka
        Gfng7CHmy1yhDlipFDcO6cUfKxBOFX4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-NggT6-l4PTuEHOQfqzb2Gw-1; Mon, 10 Jul 2023 09:33:48 -0400
X-MC-Unique: NggT6-l4PTuEHOQfqzb2Gw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e166a4087so2679204a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688996027; x=1691588027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ak9fRbxuixcIYTWvlnH4cZYdZvxzAVmoXYAJWfQ6iRg=;
        b=l1j52rEbrf98NvBPjeJSv8Net6Vq0wCOlK65qogM7PyzT8f8RlFiRRzipsxG7jul4Z
         1+jE7cta6YLbxNto1GV8cQVV0jsObvYaXeGKd3TeAj6lnUOhTYY6HkDVpKgxe35axSBL
         3s2PdXUGPv2N9UPwYp7DO/PcUvXcbDbQQwHhipHy0sPy0DfnMl9ouNZjvyrqP1ylV2Vc
         nXS0Ei/QNuuguz8e6XDh7h5GaF0uZ4fjw0+7OImjOBJxclaApbZEX83EzcvchKg1dUN1
         HBTwCSnd+RPSBEEfPXr0hdgyG1i8S0V2ypJjv0L+KHBClkrKJZMpvGqKG5Yn0wqpjZ52
         sMPg==
X-Gm-Message-State: ABy/qLZ2uR85d0EeYxmXcQ6ZXuZwcrVfylZV66LqMEZ4sPBFtzvsTdPQ
        70sFKhp/n588QVhWf2iuX7yoiknz5gVA+Zhae4ru8+d1sAUtlSr1kht6+2u7B5N/gPJmbSVY0Xg
        rYmsloXahFKqvHdl3wgYBywdV
X-Received: by 2002:a05:6402:1391:b0:51d:d48b:9978 with SMTP id b17-20020a056402139100b0051dd48b9978mr10787676edv.8.1688996027422;
        Mon, 10 Jul 2023 06:33:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwnIs3wUYSW3/n22GQIxO2F9IABGWqGeuoH+p/ffkYlO8rC66v0dSUKr9zH82kM+1IYioUig==
X-Received: by 2002:a05:6402:1391:b0:51d:d48b:9978 with SMTP id b17-20020a056402139100b0051dd48b9978mr10787639edv.8.1688996027023;
        Mon, 10 Jul 2023 06:33:47 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e16-20020a50ec90000000b0051e2a5d9290sm5781645edr.77.2023.07.10.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 06:33:46 -0700 (PDT)
Message-ID: <4a11393d-69bb-8e9d-3bfe-21aa7a7fb1e3@redhat.com>
Date:   Mon, 10 Jul 2023 15:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] watchdog: simatic-ipc-wdt: make IO region access of
 one model muxed
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Henning Schild <henning.schild@siemens.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20230706154831.19100-1-henning.schild@siemens.com>
 <20230706154831.19100-2-henning.schild@siemens.com>
 <876f6a08-1850-21cd-83d1-b309e7e1e912@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <876f6a08-1850-21cd-83d1-b309e7e1e912@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 7/6/23 18:03, Guenter Roeck wrote:
> On 7/6/23 08:48, Henning Schild wrote:
>> The IO region used for the watchdog also hold CMOS battery monitoring
>> information. Make the access muxed so that a hwmon driver can use the
>> region as well.
>>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thank you. Is it ok if I pick up his patch and merge it together with 2/2
through the pdx86 tree ?

Regards,

Hans


> 
>> ---
>>   drivers/watchdog/simatic-ipc-wdt.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
>> index 6599695dc672..cdc1a2e15180 100644
>> --- a/drivers/watchdog/simatic-ipc-wdt.c
>> +++ b/drivers/watchdog/simatic-ipc-wdt.c
>> @@ -155,9 +155,8 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
>>         switch (plat->devmode) {
>>       case SIMATIC_IPC_DEVICE_227E:
>> -        if (!devm_request_region(dev, gp_status_reg_227e_res.start,
>> -                     resource_size(&gp_status_reg_227e_res),
>> -                     KBUILD_MODNAME)) {
>> +        res = &gp_status_reg_227e_res;
>> +        if (!request_muxed_region(res->start, resource_size(res), res->name)) {
>>               dev_err(dev,
>>                   "Unable to register IO resource at %pR\n",
>>                   &gp_status_reg_227e_res);
>> @@ -210,6 +209,10 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
>>       if (wdd_data.bootstatus)
>>           dev_warn(dev, "last reboot caused by watchdog reset\n");
>>   +    if (plat->devmode == SIMATIC_IPC_DEVICE_227E)
>> +        release_region(gp_status_reg_227e_res.start,
>> +                   resource_size(&gp_status_reg_227e_res));
>> +
>>       watchdog_set_nowayout(&wdd_data, nowayout);
>>       watchdog_stop_on_reboot(&wdd_data);
>>       return devm_watchdog_register_device(dev, &wdd_data);
> 

