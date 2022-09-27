Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD005EC5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiI0ONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiI0ONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444DC1BB6D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664288018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKGdAdKWhJTx/Xv7Sz8bsLwa+ZuDoj3wym0zFd3EU8g=;
        b=AyNNojJ0eoOt7rQLaW3WHDjkBsaqNTO9bsb0qtKP2XPBwf0zemwrm1d7u4srCSuuOwfjMe
        NV6EivZwXnj0cRHzw5OHJ7P0tCd+/GPNnu2mbCIQlXLCdupCWYc7J4jGItGVNionjR0GQX
        34u4Px79cm21QW9HRhchQkq7PLBww/U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-IoxBtaHZPFug6w7-MIzwog-1; Tue, 27 Sep 2022 10:13:37 -0400
X-MC-Unique: IoxBtaHZPFug6w7-MIzwog-1
Received: by mail-ed1-f70.google.com with SMTP id c6-20020a05640227c600b004521382116dso8033322ede.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HKGdAdKWhJTx/Xv7Sz8bsLwa+ZuDoj3wym0zFd3EU8g=;
        b=ytvZHjf5UVNIsuvT/ilFifkswlgczkVJtRLgyNJmsw5GPuQKK1BV1qm9toTy/i+gUq
         SfeTS90KM978BGRF+MDKfJ5v7efvb8Jx1Dzk+Nh2Ew4MKD5VlRmSlo9RwVmuEV4sb2Q/
         YA9Q++jNVqXZgLFWZiQhlxAFIIQEcqRp0vb4143V3aXsGFscQsShg7ylm3FNpeG6fYNy
         GTs3w3SkYZ8/pq8hVLLnK5OczIx8cse4Go/KgycJw/PLLR+h8P6UgqFxyE5/hrXKcX6I
         T/VkuahCy/+Tqqi+DVVPsDO502ku2GW4PPDVsMJ2aEet4bN1DoD/dwGDVHjclkdCVvVX
         gvaQ==
X-Gm-Message-State: ACrzQf3CmHcl33P5OnK1AzQGg+I70ZCKGxGLym8ypoG5WJ6+UeoNQFzT
        kQYYEdR9L5hm4hFN7N6TjQwDNO+OKvIrs9kcR9PUbyYxTiR8vz2hDH1wMdj0PoutnIb8tge2I4V
        ULebBAx/gHP4VjdYLsv2cHTBw
X-Received: by 2002:a05:6402:849:b0:453:10c3:2ee3 with SMTP id b9-20020a056402084900b0045310c32ee3mr28141358edz.339.1664288015987;
        Tue, 27 Sep 2022 07:13:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM48+iUYPej+zslJBIkvtvG5lG69A/kb6fiPhXTmUhm+OZkn3tzqFE7c8bbmgOMXiyaun4ITGg==
X-Received: by 2002:a05:6402:849:b0:453:10c3:2ee3 with SMTP id b9-20020a056402084900b0045310c32ee3mr28141345edz.339.1664288015785;
        Tue, 27 Sep 2022 07:13:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906369a00b0077fc47605b4sm857235ejc.217.2022.09.27.07.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:13:35 -0700 (PDT)
Message-ID: <04a42b71-27ad-7bcd-a270-5c342f764b77@redhat.com>
Date:   Tue, 27 Sep 2022 16:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 0/9] pwm: lpss: Clean up and convert to a pure library
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 9/8/22 15:56, Andy Shevchenko wrote:
> First of all, a set of cleanups and code deduplications (for better
> maintenance) to the PWM LPSS driver.
> 
> Second, we may (re-)use the core part as a library in the future in
> the devices that combine the same PWM IP in their address space. So
> convert the core file to be a pure library which doesn't require any
> special resource handling or alike.
> 
> Changelog v2:
> - replace patch 1 by Uwe's version (Uwe)
> - update NS patch to have a default namespace defined (Uwe)
> - describe all changes done in patch 4 (Uwe)
> 
> Andy Shevchenko (8):
>   pwm: lpss: Move exported symbols to PWM_LPSS namespace
>   pwm: lpss: Move resource mapping to the glue drivers
>   pwm: lpss: Include headers we are direct user of
>   pwm: lpss: Use device_get_match_data to get device data
>   pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
>   pwm: lpss: Make use of bits.h macros for all masks
>   pwm: lpss: Add a comment to the bypass field
>   pwm: lpss: Allow other drivers to enable PWM LPSS
> 
> Uwe Kleine-König (1):
>   pwm: lpss: Deduplicate board info data structures
> 
>  drivers/pwm/pwm-lpss-pci.c                 | 48 +++++-----------------
>  drivers/pwm/pwm-lpss-platform.c            | 40 +++++-------------
>  drivers/pwm/pwm-lpss.c                     | 46 ++++++++++++++++++---
>  drivers/pwm/pwm-lpss.h                     | 22 ++++------
>  include/linux/platform_data/x86/pwm-lpss.h | 33 +++++++++++++++
>  5 files changed, 101 insertions(+), 88 deletions(-)
>  create mode 100644 include/linux/platform_data/x86/pwm-lpss.h

Uwe, thank you for Cc-ing me.

Andy, thank you for the patches.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

