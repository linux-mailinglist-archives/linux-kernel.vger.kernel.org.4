Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E26FE4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEJUG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEJUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:06:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6A3A9D;
        Wed, 10 May 2023 13:06:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf7067647so53763085ad.0;
        Wed, 10 May 2023 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683749211; x=1686341211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkpyzTcfz/0gK2sWaltTXYjh46EOLZQsy8Ul9ZDhlc4=;
        b=DP2fwsfhxDe+COOTKm+ROY0Yt6tAxkejEnIoI2l4NeJAJY93xl/d7iYYhXgR23uL48
         RkU6yoplaZADy7qWBxagy6peCU7mVH1LXvu/m+lXBg0LeBlCDZNbyVaFygWdZKPRsODU
         CX3220Oux6UpKdfTdSXEsxgjF6g0p5EK67glWddDKBZyrLVvP7lf+hYhFkeN6ZDKy6CX
         FdELqacby3QbNVNlIvw1qej2yP83hAupRKkxR7iEP45H2I/WVu747nji14XIXrANvJSK
         RFD8meugT3sWUJmk+KwWFa04MmQn3HMwUBQXaMG7ol3V/CdIEVSfaH4usJsCr9yVmxAJ
         zKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683749211; x=1686341211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkpyzTcfz/0gK2sWaltTXYjh46EOLZQsy8Ul9ZDhlc4=;
        b=QAQBSgcjgxhlwFxPG8I23o4r8zCMo1WwFQcCCzhdgRyTFA5LMEynrr/V5rKCfai7NI
         3FkFSxCR0/qYByCU6vbhAd1PyT7YFDxFQUBfyDBgPTNR+cEu063rdt+m/tOjIer3b8/b
         rCgs06gQQ394rUskhZJW5XFVhVKCIqDx4rVkDlW0iky+3Y0vwEeU+I/O7rIb8FhKH9jp
         HHsqrHU7wVJyKQYjnWsS7GXgUFNZgb9D7kBaLqENwokGcvqIapyUyjmUtKbSl6UiShIO
         Y6VVaBO1JpC7k0aD2HusiPR4qaBbIz8YVmgoML6kI4nyAJKGWXEwwsMsuIBL2vG3LOsr
         YXGw==
X-Gm-Message-State: AC+VfDz61Ao7ejO5Q0YnBrXP2bYQuP3mLdKFotV8NVDaaLDs2Qgl/8W4
        5wIy7wS0EQFB1FN4Le87xqQ=
X-Google-Smtp-Source: ACHHUZ7uv06gxhZetAr5owAuzqyVYaqyKJsM/q3DTfba20TgJMG8cablnbTC0JVu0+pqLKJ20EsZ4g==
X-Received: by 2002:a17:902:da89:b0:1ac:acb5:4336 with SMTP id j9-20020a170902da8900b001acacb54336mr6735465plx.33.1683749210482;
        Wed, 10 May 2023 13:06:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f65a:fd28:e01b:3900])
        by smtp.gmail.com with ESMTPSA id jg22-20020a17090326d600b001a66c4afe0asm4174622plb.255.2023.05.10.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:06:49 -0700 (PDT)
Date:   Wed, 10 May 2023 13:06:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeffery Miller <jefferymiller@google.com>
Cc:     Andrew Duggan <andrew@duggan.us>,
        Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Lyude Paul <lyude@redhat.com>, loic.poulain@linaro.org,
        benjamin.tissoires@redhat.com,
        Andrew Duggan <aduggan@synaptics.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - retry reading SMBus version on
 resume
Message-ID: <ZFv5VkIzTEVwo2PI@google.com>
References: <20230510192731.300786-1-jefferymiller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510192731.300786-1-jefferymiller@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 07:27:22PM +0000, Jeffery Miller wrote:
> On resume there can be a period of time after the
> preceding serio_resume -> psmouse_deactivate call
> where calls to rmi_smb_get_version fail with
> -ENXIO.
> 
> The call path in rmi_smb_resume is rmi_smb_resume -> rmi_smb_reset ->
> rmi_smb_enable_smbus_mode -> rmi_smb_get_version where
> this failure would occur.
> 
> Adding a retry loop ensures that after rmi_smb_reset returns
> the following rmi_driver_resume calls in rmi_smbus_resume can
> succeed.
> 
> This behavior was seen on a Lenovo T440p machine that required
> a delay of approximately 7-12ms.
> The retry limit of 5 is chosen to be larger than
> this observed delay.
> 
> With this patch the trimmed resume logs look similar to:
> ```
> psmouse serio1: PM: calling serio_resume+0x0/0x8c @ 5399, parent: i8042
> [5399] libps2:__ps2_command:316: psmouse serio1: f5 [] - 0/00000000 []
> psmouse serio1: PM: serio_resume+0x0/0x8c returned 0 after 3259 usecs
> ...
> rmi4_smbus 0-002c: PM: calling rmi_smb_resume ... @ 5454, parent: i2c-0
> ...
> [5454] i2c_i801:i801_check_post:414: i801_smbus 0000:00:1f.3: No response
> smbus_result: i2c-0 a=02c f=0000 c=fd BYTE_DATA rd res=-6
> rmi4_smbus 0-002c: failed to get SMBus version number!
> rmi4_smbus 0-002c: sleeping to retry getting the SMBus version number
> ...
> rmi4_smbus 0-002c: PM: rmi_smb_resume ... returned 0 after 21351 usecs
> ```
> 
> Signed-off-by: Jeffery Miller <jefferymiller@google.com>
> ---
> 
> Early boot dmesg include:
> ```
> rmi4_smbus 0-002c: registering SMbus-connected sensor
> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM2722-001, fw id: 0
> ```
> 
> The resume order looks correct. The `psmouse serio1` resume returns
> before the rmi_smb_resume is called showing the patch from
> https://lore.kernel.org/all/89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com/
> is applied and working for that ordering.
> 
> I attempted to try to rule out some interaction between the concurrent
> input resume calls for other i8042 devices.
> Adding a 7ms delay after psmouse_deactivate which is called in the
> preceding psmouse serio1 serio_resume function also allows
> this version call to succeed.

I am not really fond of adding random repeats in the code base. Andrew,
do you know if the Synaptics device needs certain delay when switching
to SMbus mode?

Thanks.

-- 
Dmitry
