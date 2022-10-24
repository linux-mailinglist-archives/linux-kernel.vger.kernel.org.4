Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91CB609E16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJXJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJXJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE158517
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666604056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYiZhVus/a6yFTpNh/BXjTb7tVXNxU/01uNCth7CTZI=;
        b=ibX7KnIb41N3vcIhax3Pcww90qPP6S4P+hULCTNeX1XuQoECLkm0iyZrO7fwOujqq4bOmx
        sAx2/Hw/ZBFd1nYiysGMw1+C84CzR2Yo7u4z476aNmCdtvC3VnlPh/mzzA0a8FY1hbcaWQ
        qltYxBUqJ8hg4uzUFAFyDKfUsUu7rws=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-H9nz4tVIOhSqrYl7P5a3JA-1; Mon, 24 Oct 2022 05:34:13 -0400
X-MC-Unique: H9nz4tVIOhSqrYl7P5a3JA-1
Received: by mail-ed1-f70.google.com with SMTP id f16-20020a056402355000b00461cf923fdcso1801501edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYiZhVus/a6yFTpNh/BXjTb7tVXNxU/01uNCth7CTZI=;
        b=h/UcTZOnNxZjmwmCaD5bZ0Wk2jW8SG09OyI5KS1FzQzDBM6rnTWXg6DF6e1YOl0+gx
         jCqoLmmbFvXUf+MgQtAr4O8qhyR6ZfbctOk3pZ1yR6It5L8u7gIqljJ/eQzTTasZPlA+
         aUVTU+w9WjbT3DDYM3TF6bw17ftko5kzjAGKnfhj+AUSaMwa3EMfhosPLUfivr/+VyRG
         ev53JnOe2rnZUDArrK83SBi63/cF678ph4lFUbdG3MnIsDi6SNXIFWV1heE7xeUq6wJg
         PKGi61tjR53MyeavVutwmCpKyvkuU9Kcy7D5d1HTwibA7aMoWSNWmc2b1DSfUw43R26f
         PpWA==
X-Gm-Message-State: ACrzQf1C7SScIuK55QpAqjGAohgjaVun25B+pr4rreGIrFUOrNlXL4jp
        eid6xgwScwXgXaMistof1o+G/1ObCjo/vKRFlmMvmO7eKv9c3EKGTsx6NBDecP+9e/lU6jZ1ePb
        VHlGnov37raol4K1+vkgpKYDD
X-Received: by 2002:a05:6402:27c6:b0:461:e426:dc8b with SMTP id c6-20020a05640227c600b00461e426dc8bmr1443191ede.403.1666604051519;
        Mon, 24 Oct 2022 02:34:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4rZ54JzfS+4+30nlurPHA94oY42PLZUnu1Y3UGrNBBHaFn9/MGyKCgcI0JYZS19bexj5Nizw==
X-Received: by 2002:a05:6402:27c6:b0:461:e426:dc8b with SMTP id c6-20020a05640227c600b00461e426dc8bmr1443180ede.403.1666604051358;
        Mon, 24 Oct 2022 02:34:11 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b29-20020a170906729d00b00782ee6b34f2sm15257318ejl.183.2022.10.24.02.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 02:34:10 -0700 (PDT)
Message-ID: <28cea90f-d53b-0e28-9546-c36462cf0ceb@redhat.com>
Date:   Mon, 24 Oct 2022 11:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: fix incorrect LED to GPIO
 mapping
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024092027.4529-1-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024092027.4529-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henning,

On 10/24/22 11:20, Henning Schild wrote:
> For apollolake the mapping between LEDs and GPIO pins was off because of
> a refactoring when we introduced a new device model.
> In addition to the reordering the indices in the lookup table need to be
> updated as well.
> 
> Fixes: a97126265dfe ("leds: simatic-ipc-leds-gpio: add new model 227G")
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Thanks, since I've merged the original changes and since I'm preparing
a fixes pull-req for 6.1-rc3 anyways let me pick this one up and
get it on its way to Linus:

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
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> index b9eeb8702df0..07f0d79d604d 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> @@ -20,12 +20,12 @@ static struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
>  static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
>  	.dev_id = "leds-gpio",
>  	.table = {
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
>  	},

