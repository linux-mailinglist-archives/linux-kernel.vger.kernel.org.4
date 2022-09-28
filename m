Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947965ED283
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiI1BME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiI1BMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:12:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293D3F962B;
        Tue, 27 Sep 2022 18:11:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e68so11200842pfe.1;
        Tue, 27 Sep 2022 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=p3eUKwIdS0Bq28zizpdjqkvTnJ0lK5EFcAaTI8E5ocE=;
        b=EQqnCP+Byb39ss9k7jjdAyjDPPsaSV1L+SpiiY6KhvAKU+xXLo33A3MjrlPgNMjEqS
         IEzNngKBGC+WYzB/ufJsm06VTYnqT48n4FB1WnSY6gUCftyE79vVT9IdXXg+TKTj91gn
         a6ZjSQHdAdhjSt9NQ0Zvl7kWUyEqC0J1WTFoB6pzngdERjlr2UV037uKthZJSZHBEjaG
         IIbtxQVUtDFBTwsd6+wZOU3qifVbtzncHSgDakGZ0lDejJ/GEjA9RNOC5+8XyhQYMtVT
         XIxg+JcuEB7pKd0cCk5HaKbT0xdyO4Fg8HlAsuVDxGHfzzc8oUsqc1O1hKXttM/tJ7Si
         aCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p3eUKwIdS0Bq28zizpdjqkvTnJ0lK5EFcAaTI8E5ocE=;
        b=ngsnn7+TPSyJcZL+gt9QOjZDf6+SJG7axljdIIHi04jYXgayEua9YcI/rbm0LYowUh
         9b7BnKxbWYOd85bGEl8lyBgeVyUG/bn+l/XGDvGKauv57KPTxHDRAL3l/WaD32kq5dLs
         Nx0+TXcK0WFNCYY3Sj38kt7seOVkTtKluPrisWgCkHVYXaRzWjKQrxXzoc2ibrO/HfsD
         WEG4n3P3iVu5mjWfLeIbHR0NnvofkQdw94k5tro7w+kTxHIAhE9FFI8jzpm4eIAnMK2l
         9NwKZO9SzMUk0dUvb1N/aWc1B4vIX2WuzGPal+9xxGANfoLf0TVMJL8jChNzY00z2Tnr
         y5Fw==
X-Gm-Message-State: ACrzQf1zMSIVk56byWEV+eQbBUEOElxSjH3bYdnkHI9fao6EIbbram7U
        8GSMn7dkWte75izP8Qc9o/4=
X-Google-Smtp-Source: AMsMyM5gwSSomcUAwgGXmL16kkiohAuqLVNsNyKMW1iSehHnUdSJ7WhAmpVqejH4e1Zf+tpimhq30Q==
X-Received: by 2002:a05:6a00:cd4:b0:541:3fff:35a4 with SMTP id b20-20020a056a000cd400b005413fff35a4mr31756202pfv.56.1664327516514;
        Tue, 27 Sep 2022 18:11:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hg9-20020a17090b300900b002008d0df002sm143062pjb.50.2022.09.27.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 18:11:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Sep 2022 18:11:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: twl4030_wdt: add missing
 mod_devicetable.h include
Message-ID: <20220928011154.GA1700137@roeck-us.net>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:46:09AM -0700, Dmitry Torokhov wrote:
> The driver is using of_device_id and therefore needs to include
> mod_devicetable.h header. We used to get this definition indirectly via
> inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> matrix_keypad.h from unnecessary includes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v2: changed from of.h to mod_devicetable.h per Andy Shevchenko
> 
>  drivers/watchdog/twl4030_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
> index 355e428c0b99..36b4a660928d 100644
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/watchdog.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/twl.h>
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
