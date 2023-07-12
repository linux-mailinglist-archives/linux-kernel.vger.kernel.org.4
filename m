Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84D750C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGLPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjGLPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8ED1BFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689175141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCzMnIk4EUAlNIXsbTPgnejSeR7W3lLfeJIjDNvrQT4=;
        b=CblmdDBJNYg56C3Th8glB4qo24IrSeHcRVln+V2p1mHxUc7KNeq+dXVHgSX132KuIE14kT
        R/TUgZ9ihgZ5OS6MhsHovAqHuyiJ0WzFLv2Psr+VgNiIeSO3QSJgmzRvIPJEa8LXlQbnV/
        +IoJ4PMiDS+RVFqdArPmlateQCek5is=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-cUgcfBMsNM2TEGD8_wlozg-1; Wed, 12 Jul 2023 11:18:59 -0400
X-MC-Unique: cUgcfBMsNM2TEGD8_wlozg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993dc6fbdaaso286200066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175137; x=1691767137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCzMnIk4EUAlNIXsbTPgnejSeR7W3lLfeJIjDNvrQT4=;
        b=bktKjXFnuqqaEkcHQf4g4DNCuH2uRFW2sq71msctllBR0Md3PJ27P9n3OQVjKQIoAo
         dXuofik46p7gdA11kJSw1O1i0EvkenOYxZzLVa7+UhcUO8ZmUYq49vZVgdS1Xu4kvdUG
         gvhAnfHch4N8v1b7LloQGvChIYGjiugJirJbU1jDTI8AjY0YlSq/b9i0P62fRV+D0SS/
         kYqog3UBugIHxpiKF1EdJytxdeJP+JXheTMudWtbCC6GXBBBm1ftaZTkp/GYyotuoC4F
         T6dOF9ShJ5iQJIy/BT8l2h/CuUkiFqDA7Ja+2IUqYCGAUbY6lyTtxPXUl+X5zLEevG5X
         wR9g==
X-Gm-Message-State: ABy/qLaR1BndIwmJSZmkIOC0W+BOvGty4n/lVqSBJLhBjTxFbLvCR2WQ
        6HGxykW9uW2lZkr9ZkrCbW5en4fsozv79ayKLuBk72/Gqvpg8MXIksO4MAdSUJD7vw5FxtW2cGc
        PgvolOtGcCNXLuvW+vwyVyGmA
X-Received: by 2002:a17:906:7a4c:b0:993:d617:bdc5 with SMTP id i12-20020a1709067a4c00b00993d617bdc5mr15974674ejo.37.1689175137746;
        Wed, 12 Jul 2023 08:18:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcNAAKYJsGE//IOnyL66tt6b+ZlctKs3M4YV0iRoylH/+zyuyjTaePkU8BFtzDx/53R0C8HQ==
X-Received: by 2002:a17:906:7a4c:b0:993:d617:bdc5 with SMTP id i12-20020a1709067a4c00b00993d617bdc5mr15974659ejo.37.1689175137468;
        Wed, 12 Jul 2023 08:18:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906614600b00993a508b818sm2729216ejl.1.2023.07.12.08.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:18:56 -0700 (PDT)
Message-ID: <365026b2-86a1-3984-e602-c818a9739df3@redhat.com>
Date:   Wed, 12 Jul 2023 17:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/8] platform/x86: asus-wmi:
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630053552.976579-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230630053552.976579-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/23 07:35, Luke D. Jones wrote:
> This patch series adds or exposes more features that are available in the ROG
> laptop series.
> 
> - expose dGPU and CPU tunables for ROG
>   - These are things like GPU boost, CPU Pl1 and PL2, package power limits
> - support setting mini-LED mode
>   - Some newer laptops have a screen that can toggle between regular style
>     backlight and using mini-LED backlight
> - add WMI method to show if egpu connected
>   - This WMI method can be monitored/queried to see if it is possible to begin
>     the change-over to eGPU
> - support middle fan custom curves
>   - Some newer laptops have a center/middle fan which blows across the CPU and GPU
> - add support for showing middle fan RPM
> - add support for showing charger mode (AC, USB-C, both plugged)
> - add additional checks to GPU switching code
>   - These try to prevent a sceanrio such as the user disabling the dGPU while it
>     is driving the internal panel via MUX, resulting in no output at all.
>     There are no checks in the ACPI code for this, but on some newer models ASUS
>     did finally add a switch in the BIOS menu. It is best to try and prevent this
>     at the kernel level rather than userland level.
> 
> All patches pass ./scripts/checkpatch.pl

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> Changelog:
> - v2-0008-platform-x86-asus-wmi-expose-dGPU-and-CPU-tunable.patch
> 	- Rename the WMI defs to match what ASUS supplied as names
> 	- Remove EDC and TDC exposure (unsafe)
> 	- Slight change to formatting
> 	- Add better notes to documentation
> 		
> 
> Luke D. Jones (8):
>   platform/x86: asus-wmi: add support for showing charger mode
>   platform/x86: asus-wmi: add support for showing middle fan RPM
>   platform/x86: asus-wmi: support middle fan custom curves
>   platform/x86: asus-wmi: add WMI method to show if egpu connected
>   platform/x86: asus-wmi: don't allow eGPU switching if eGPU not
>     connected
>   platform/x86: asus-wmi: add safety checks to gpu switching
>   platform/x86: asus-wmi: support setting mini-LED mode
>   platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG
> 
>  .../ABI/testing/sysfs-platform-asus-wmi       |  86 +++
>  drivers/platform/x86/asus-wmi.c               | 605 +++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h    |  19 +-
>  3 files changed, 707 insertions(+), 3 deletions(-)
> 

