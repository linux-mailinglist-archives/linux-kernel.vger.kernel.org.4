Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7FD650AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiLSLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiLSLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF522E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671449720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PTY5ap1jIE3gvJxbvgJcqBaMT685uN+MISB0lKtLQ8=;
        b=C5av6U6T6M7nUo1Xp73UFA4JQCIGXLrJZuQFMIcfG19q0QaTDTDRviJdOJJBCyMucUx0EV
        4PiIgdK7tQaYhuccqQf+p+3LBJwtZ/fj2yaPrPf0i6Rg61p6P16WgF3Ya/reoVzjGM9wg+
        ScAnTNS+6rm0kqrJI49W8jax3Vm4v4U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-601-O5lgRVkPMt2Z0lgZjWjZNQ-1; Mon, 19 Dec 2022 06:35:19 -0500
X-MC-Unique: O5lgRVkPMt2Z0lgZjWjZNQ-1
Received: by mail-ed1-f69.google.com with SMTP id z3-20020a056402274300b0046b14f99390so6272793edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 03:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PTY5ap1jIE3gvJxbvgJcqBaMT685uN+MISB0lKtLQ8=;
        b=F/yXCGFr7+g6KxNU4WszFZPGEgFp9VLPO7iS7J5l234CrRFbDm+m5qky2iNT13sbB+
         sLoZfuJIPvJ5kFJMM+bM+eUI6bCoyGq0KRYLPbOOpfdlRsKxDV9gNC2Z1dzsY72W2Ky5
         +/8DIbIx02oeemAvvvH5CUFpZUOhVF7AwGvIU3KgDhGwKxnI4ZaVZ8yJ5ff3nuEs6ZW3
         TVi0oedQgI/yhJL62twf6balY4IuPNZEyQ3pxhO5ANNqi6v4EYBkEyhyhVzu8pGoG4CV
         u6pdZ5Baf/T4wnucAgN+zgR546AeIflCCSUZLvtKFnesCFx4zVkpYd9zOnh714Sd3Nyi
         9GNg==
X-Gm-Message-State: ANoB5pkBKzQTKbXpdRpPkT91t7T2zWe4cqfZD4UOw3tVbL8u7oBZn9ln
        Ro6Ld6cSKdD98tJK+pVDo07bWHA136KJ3tgnJWp3Ntl+t1b3Q7APdG0mxax6N0OUgkWw+ZNHFMo
        8hVHTlYlx8ASIDVw1uR5ipU6Q
X-Received: by 2002:a17:907:11c8:b0:7c0:beee:2f06 with SMTP id va8-20020a17090711c800b007c0beee2f06mr33252793ejb.52.1671449718196;
        Mon, 19 Dec 2022 03:35:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6UrtfVi46Vgo8hEJYXLZ3rQPBNC7zQlw75rudldjlafEzJeNYwGGIkfH5NpPHe4WU6gpB7Vg==
X-Received: by 2002:a17:907:11c8:b0:7c0:beee:2f06 with SMTP id va8-20020a17090711c800b007c0beee2f06mr33252780ejb.52.1671449717970;
        Mon, 19 Dec 2022 03:35:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906311400b0073d81b0882asm4288633ejx.7.2022.12.19.03.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 03:35:17 -0800 (PST)
Message-ID: <491f2a01-c2ae-8508-effb-dfd89bfe22a1@redhat.com>
Date:   Mon, 19 Dec 2022 12:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3] i2c: designware: Fix unbalanced suspended flag
Content-Language: en-US, nl
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, jsd@semihalf.com, wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221219112019.882092-1-rf@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221219112019.882092-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/19/22 12:20, Richard Fitzgerald wrote:
> Ensure that i2c_mark_adapter_suspended() is always balanced by a call to
> i2c_mark_adapter_resumed().
> 
> dw_i2c_plat_resume() must always be called, so that
> i2c_mark_adapter_resumed() is called. This is not compatible with
> DPM_FLAG_MAY_SKIP_RESUME, so remove the flag.
> 
> Since the controller is always resumed on system resume the
> dw_i2c_plat_complete() callback is redundant and has been removed.
> 
> The unbalanced suspended flag was introduced by
> commit c57813b8b288 ("i2c: designware: Lock the adapter while setting the
> suspended flag")
> 
> Before that commit, the system and runtime PM used the same functions. The
> DPM_FLAG_MAY_SKIP_RESUME was used to skip the system resume if the driver
> had been in runtime-suspend. If system resume was skipped, the suspended
> flag would be cleared by the next runtime resume. The check of the
> suspended flag was _after_ the call to pm_runtime_get_sync() in
> i2c_dw_xfer(). So either a system resume or a runtime resume would clear
> the flag before it was checked.
> 
> Having introduced the unbalanced suspended flag with that commit, a further
> commit 80704a84a9f8 ("i2c: designware: Use the
> i2c_mark_adapter_suspended/resumed() helpers")
> 
> changed from using a local suspended flag to using the
> i2c_mark_adapter_suspended/resumed() functions. These use a flag that is
> checked by I2C core code before issuing the transfer to the bus driver, so
> there was no opportunity for the bus driver to runtime resume itself before
> the flag check.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: c57813b8b288 ("i2c: designware: Lock the adapter while setting the suspended flag")

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index ba043b547393..74182db03a88 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -351,13 +351,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  
>  	if (dev->flags & ACCESS_NO_IRQ_SUSPEND) {
>  		dev_pm_set_driver_flags(&pdev->dev,
> -					DPM_FLAG_SMART_PREPARE |
> -					DPM_FLAG_MAY_SKIP_RESUME);
> +					DPM_FLAG_SMART_PREPARE);
>  	} else {
>  		dev_pm_set_driver_flags(&pdev->dev,
>  					DPM_FLAG_SMART_PREPARE |
> -					DPM_FLAG_SMART_SUSPEND |
> -					DPM_FLAG_MAY_SKIP_RESUME);
> +					DPM_FLAG_SMART_SUSPEND);
>  	}
>  
>  	device_enable_async_suspend(&pdev->dev);
> @@ -419,21 +417,8 @@ static int dw_i2c_plat_prepare(struct device *dev)
>  	 */
>  	return !has_acpi_companion(dev);
>  }
> -
> -static void dw_i2c_plat_complete(struct device *dev)
> -{
> -	/*
> -	 * The device can only be in runtime suspend at this point if it has not
> -	 * been resumed throughout the ending system suspend/resume cycle, so if
> -	 * the platform firmware might mess up with it, request the runtime PM
> -	 * framework to resume it.
> -	 */
> -	if (pm_runtime_suspended(dev) && pm_resume_via_firmware())
> -		pm_request_resume(dev);
> -}
>  #else
>  #define dw_i2c_plat_prepare	NULL
> -#define dw_i2c_plat_complete	NULL
>  #endif
>  
>  #ifdef CONFIG_PM
> @@ -483,7 +468,6 @@ static int __maybe_unused dw_i2c_plat_resume(struct device *dev)
>  
>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>  	.prepare = dw_i2c_plat_prepare,
> -	.complete = dw_i2c_plat_complete,
>  	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>  	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend, dw_i2c_plat_runtime_resume, NULL)
>  };

