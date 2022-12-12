Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B38649A60
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiLLIv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiLLIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10DDFED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670835021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQ50d8UumI9ueJpEwOflt6TAhpxY1IdtCPs4SpFp+ys=;
        b=FFt60djhmRuPlmtiHmindGdDYVSEllt9mdifecDFH/nP6FcfU9nb9bkftopJyIfNct13Wh
        gqNxlGAEqibqdV0KoVW/XsqwSusf7po/lLnOoEOLyOP9iwZWKhthCvE6rotRCGKrGj78DH
        d2gOLvG3+TKAqv5PlqKxLHOoMIHpjhQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-K0WrgPwFOimyGe12QpD0Iw-1; Mon, 12 Dec 2022 03:50:20 -0500
X-MC-Unique: K0WrgPwFOimyGe12QpD0Iw-1
Received: by mail-wm1-f72.google.com with SMTP id g9-20020a7bc4c9000000b003d214cffa4eso1743628wmk.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ50d8UumI9ueJpEwOflt6TAhpxY1IdtCPs4SpFp+ys=;
        b=RATn9E/VOQjXKaixFGDaFCYvgmoSxG6csCQdU4NlQhj47ovMVaAlKMI9GSQHCtXS8K
         F0ffUCooRiWR8IKXM0xDeIlqBnX7ObqVXlLBpWXSApUpm0ptrCRNqzMEyjC8MyRYYtVG
         6nDTyuLkGg1ytkuTW+IEH4WynGmEcP7ORkHZoU7TqyjbHixqfDH5itX5c+ouU3fMvbh0
         yZtDpGJ4XUkGjA2U9aiyEwK2zihucI6H3OAgpUCyfFyEgVjddZiNjDSFNBEc/YR1dOJ5
         S8kcnOnnpjaspYdml2+tZKYl42uuGNxvt9xaBjAKpeSEGnNB1pGWNuk93kxLhfs5OLEN
         58ZQ==
X-Gm-Message-State: ANoB5pk29BrssswzpuVbkNadH0vvUnJ9dLZzm048HqVK18l+0e6oAvgC
        qKvBwqd39dTom4FI6vuKMDob3ByRU2IdHUAylzXiXaBjcGeOH7kNvBVS/3gwH/lsCBzt0E5n68l
        uzGEqkMI1vpTCRWRNRs47CuhL
X-Received: by 2002:a1c:f614:0:b0:3cf:5502:8a0 with SMTP id w20-20020a1cf614000000b003cf550208a0mr11802776wmc.27.1670835019072;
        Mon, 12 Dec 2022 00:50:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5LzC9pS4sHGm+Dp6NvZaYYWCLhmBeZhJRNbTAjUPxhj+YiexNiySqJFPuqRgC7vVOTWvawqA==
X-Received: by 2002:a1c:f614:0:b0:3cf:5502:8a0 with SMTP id w20-20020a1cf614000000b003cf550208a0mr11802769wmc.27.1670835018821;
        Mon, 12 Dec 2022 00:50:18 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id iw3-20020a05600c54c300b003d220ef3232sm5080177wmb.34.2022.12.12.00.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 00:50:18 -0800 (PST)
Message-ID: <549800ec-6da2-64ad-62a6-c8e4a35dc212@redhat.com>
Date:   Mon, 12 Dec 2022 09:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/4] driver core: Make driver_deferred_probe_timeout a
 static variable
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Robinson <pbrobinson@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116115348.517599-2-javierm@redhat.com>
 <CANDhNCoa+LRu8B4+M+uU4_m2kd=HriO0SyNP=n=XpXwXG2k9LA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CANDhNCoa+LRu8B4+M+uU4_m2kd=HriO0SyNP=n=XpXwXG2k9LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 11/17/22 20:14, John Stultz wrote:
> On Wed, Nov 16, 2022 at 3:54 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> It is not used outside of its compilation unit, so there's no need to
>> export this variable.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/base/dd.c             | 6 ++----
>>  include/linux/device/driver.h | 1 -
>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 3dda62503102..040b4060f903 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -257,13 +257,11 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>>  DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>>
>>  #ifdef CONFIG_MODULES
>> -int driver_deferred_probe_timeout = 10;
>> +static int driver_deferred_probe_timeout = 10;
>>  #else
>> -int driver_deferred_probe_timeout;
>> +static int driver_deferred_probe_timeout;
>>  #endif
>>
>> -EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
>> -
> 
> Yeah, I added the EXPORT for the regulator code to use it in
> dca0b44957e5 but that got backed out when setting
> driver_deferred_probe_timeout to 30s was reverted, and this bit was
> forgotten.
> 
> Thanks for catching this!
> 
> Acked-by: John Stultz <jstultz@google.com>
>

Could you please pick this patch? Is a fix independent of the other
patches in the series and it has already been acked by John.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

