Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F56780A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjAWP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjAWP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A816592
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674489320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCAD4d47/BHFzPuHYVMhr0BvGhmMwApgFifpM3vZL8Q=;
        b=fxIPcO1qqMVO7209VHb59Qvacf97v8lYdjqifUUuXzpGgS1pLvrF5LJ1VUZhXq1EMmZkMs
        UM4q9+Auew9Wuxxorn6XFpN+MiUhL3hka+JTjXfbnRaNCEtkXBTN0fCdZAZNuYJtbitARZ
        4w6tG5ECUv0SblYHpU3sfKxr3LWu514=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477--gSX5ra0OeuRADtWOW0gyQ-1; Mon, 23 Jan 2023 10:55:18 -0500
X-MC-Unique: -gSX5ra0OeuRADtWOW0gyQ-1
Received: by mail-ed1-f72.google.com with SMTP id f11-20020a056402354b00b0049e18f0076dso8764579edd.15
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCAD4d47/BHFzPuHYVMhr0BvGhmMwApgFifpM3vZL8Q=;
        b=r+fRXiRFtRJKFglY4yM2oPcALZu9CosgOwuWx7ETpN9pVRjCsdSlh1j5x+mf+6rYRJ
         GvMat0Dub4wRkbStipsMlMQbTgFYcHsOTY1l4I6I7kcK8fKQkq+5nA92C3syTOsFsdMT
         VkpYZ4BM3sJEPdE0p1Wbf1vhHg8eKvrNc3emp+qsDke8hSn11yU8q1ZivVbicts0btzQ
         IGABkXVPZzFs8P1mlPigL+bv6YPY6CFugG3Gi0qGOe07ce9xuX4DtNKVyWzx8X1VDwbp
         rIvqBnlMNGBevYrN7jPqbPPQCrW8C6tYxxVt0B3ieQgCgB1mxq1lyi1YMCwSky9U4yS2
         9uSg==
X-Gm-Message-State: AFqh2kpBTTpekz6SxwKyK6iQTjdqpUImOx91xsNiS97aMw9+5/XZMe1v
        FyMguzF20s0XWebAd8l0BCbZskVeCzrfn4nlLqg0aWHCdAFVDK8hE1qGpTyb7YFRpCq3uBYOS1t
        6r+ylnAdObsSspcTYddIiCyHR
X-Received: by 2002:aa7:c6d9:0:b0:497:233d:3ef4 with SMTP id b25-20020aa7c6d9000000b00497233d3ef4mr24123950eds.22.1674489317262;
        Mon, 23 Jan 2023 07:55:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVeO/dcvWK52S6F3pLlXPbt0ufj0yLiui/5X5gLEcz4UVQceMWRf5bZ0OWMJ4nR/4Iu2j48w==
X-Received: by 2002:aa7:c6d9:0:b0:497:233d:3ef4 with SMTP id b25-20020aa7c6d9000000b00497233d3ef4mr24123940eds.22.1674489317090;
        Mon, 23 Jan 2023 07:55:17 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906308b00b007c0f217aadbsm22068428ejv.24.2023.01.23.07.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:55:16 -0800 (PST)
Message-ID: <b2d42cec-4ef8-2032-dad0-13ee49f05784@redhat.com>
Date:   Mon, 23 Jan 2023 16:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/1] platform/surface: Switch to use
 acpi_evaluate_dsm_typed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>
References: <20230118093823.39679-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230118093823.39679-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 1/18/23 10:38, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for the 3 patches switching to acpi_evaluate_dsm_typed().
I have added all 3 to my review-hans  branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Regards,

Hans


> ---
>  drivers/platform/surface/surface_hotplug.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_hotplug.c b/drivers/platform/surface/surface_hotplug.c
> index f004a2495201..7b6d887dccdb 100644
> --- a/drivers/platform/surface/surface_hotplug.c
> +++ b/drivers/platform/surface/surface_hotplug.c
> @@ -101,18 +101,12 @@ static void shps_dsm_notify_irq(struct platform_device *pdev, enum shps_irq_type
>  	param.type = ACPI_TYPE_INTEGER;
>  	param.integer.value = value;
>  
> -	result = acpi_evaluate_dsm(handle, &shps_dsm_guid, SHPS_DSM_REVISION,
> -				   shps_dsm_fn_for_irq(type), &param);
> -
> +	result = acpi_evaluate_dsm_typed(handle, &shps_dsm_guid, SHPS_DSM_REVISION,
> +					 shps_dsm_fn_for_irq(type), &param, ACPI_TYPE_BUFFER);
>  	if (!result) {
>  		dev_err(&pdev->dev, "IRQ notification via DSM failed (irq=%d, gpio=%d)\n",
>  			type, value);
>  
> -	} else if (result->type != ACPI_TYPE_BUFFER) {
> -		dev_err(&pdev->dev,
> -			"IRQ notification via DSM failed: unexpected result type (irq=%d, gpio=%d)\n",
> -			type, value);
> -
>  	} else if (result->buffer.length != 1 || result->buffer.pointer[0] != 0) {
>  		dev_err(&pdev->dev,
>  			"IRQ notification via DSM failed: unexpected result value (irq=%d, gpio=%d)\n",
> @@ -121,8 +115,7 @@ static void shps_dsm_notify_irq(struct platform_device *pdev, enum shps_irq_type
>  
>  	mutex_unlock(&sdev->lock[type]);
>  
> -	if (result)
> -		ACPI_FREE(result);
> +	ACPI_FREE(result);
>  }
>  
>  static irqreturn_t shps_handle_irq(int irq, void *data)

