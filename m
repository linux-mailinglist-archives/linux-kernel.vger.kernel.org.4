Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D25EC3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiI0NPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiI0NPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D26C26F5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664284534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YG830RNjkEtnpnaFh8Xp0Sr5T2atOHoB+aLCGfBa7L4=;
        b=UR4IAhY6YOfYaHJo9oXI5c1qvl8Qz8C2u2d6wtFNBFsnFieinq4m7rTTLJheESOcynolZE
        zAhiNyjOCL05x/nCd5p44259MT7VBtaESsDj/xl2EQuzgalIK7XlrgMoa50iTBA+XsMoWN
        +RHp0E6fFd1wUcbR84e+N65YlhRDlpc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-OD4xnKYvP5eUsJcskh2ypg-1; Tue, 27 Sep 2022 09:15:33 -0400
X-MC-Unique: OD4xnKYvP5eUsJcskh2ypg-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so7716389edc.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YG830RNjkEtnpnaFh8Xp0Sr5T2atOHoB+aLCGfBa7L4=;
        b=Je63UgBdvbmoBgbt0RhTKU4a5jFmiyW5OgvpyE8PJWwM1k0rlnsQ+ir6ga98bb58bT
         tNGwylYWzkAqP9JvQMTN0KYZoqQpieGknr2gQ+FdYJmuZm1y2I4wGTXYzvJSanqu7fdh
         aozIcq8r4zd8JHFwU3u24v/DsbfySmIaJNVpOK5BhkcxrAHBx8iJl3vJZZJH/n+bdqbj
         2QQZrEvgT3lihkF4C0S8PGSefQwj/LLZb38T6JOum2/41uF+rNQ813iFq+wn/DWcMkYt
         vLR+Z2c1p/JBnBFU0atqGwXdfYOEtI8OYtMNBj18KNZFOqAtVw1cuMlVum8Bg/hT2uqt
         hf1w==
X-Gm-Message-State: ACrzQf3WqWHf7P4mSAljEe9oqJbve3zj+m1Xm5a8WvW21AWlPJtXVxLj
        gfJdbH33mWZejXdcxXQksiIUcsNVoPD4FBjOTM+IW818E7ppJsa3I8XKvovFG9kYmL5W8OgQxkF
        dyfl2Pm9G/6Dl13SCGzb7iKfP
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr27881450eda.214.1664284532185;
        Tue, 27 Sep 2022 06:15:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6WRE1um0JP7ZvO78Ux6QnKgEFnIaBzjBceT9Puib3zcNo/CSOhHzoREvV7PNzyjRN38Oa8NQ==
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr27881433eda.214.1664284531980;
        Tue, 27 Sep 2022 06:15:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906318200b0078116c361d9sm814628ejy.10.2022.09.27.06.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:15:31 -0700 (PDT)
Message-ID: <62b2133e-05ec-1a09-8214-b2b847c0e97e@redhat.com>
Date:   Tue, 27 Sep 2022 15:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] platform/surface: Split memcpy() of struct ssam_event
 flexible array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220927004011.1942739-1-keescook@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220927004011.1942739-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/22 02:40, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/surface_acpi_notify.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 44e317970557..50500e562963 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -355,7 +355,8 @@ static u32 san_evt_bat_nf(struct ssam_event_notifier *nf,
>  	INIT_DELAYED_WORK(&work->work, san_evt_bat_workfn);
>  	work->dev = d->dev;
>  
> -	memcpy(&work->event, event, sizeof(struct ssam_event) + event->length);
> +	work->event = *event;
> +	memcpy(work->event.data, event->data, event->length);
>  
>  	queue_delayed_work(san_wq, &work->work, delay);
>  	return SSAM_NOTIF_HANDLED;


