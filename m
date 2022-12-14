Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4B64C7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiLNL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbiLNL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA643FAD9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671017333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XelnpOuY5/WYkqlV/X03EOrEyOH1/4r4MLd+9T0uOI=;
        b=SJlDy6mCyvJy5iuOW4xooP+23n8z8Kof3FpE9e3G8EJJTeqN5Rl1euka92GQdMUtdrhe/1
        W3g+BzOotQms0YsfFPamK4upI4gi1OHVMNR8N67i6sAuGLIIljQsqmacT3PgLeGG4b2N+3
        wnemdh5pXx9CjGu3rE92SeVGWz384+U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-XdAWSywyPbylqHvTG4tUoQ-1; Wed, 14 Dec 2022 06:28:52 -0500
X-MC-Unique: XdAWSywyPbylqHvTG4tUoQ-1
Received: by mail-ed1-f71.google.com with SMTP id q10-20020a056402518a00b00472a255eef7so591215edd.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XelnpOuY5/WYkqlV/X03EOrEyOH1/4r4MLd+9T0uOI=;
        b=TgO2Fk/qsvxZp6oZbYhXYE54Y+xFMxQL1az50xxqBZQ2uNjvQllL4sqRFYPLPWFUBh
         y3BWMqAgsQ3PFw6BxOr9GCAb9U3rbx5KDZbrDwkgtIQqR3jC++OODblJkS3uXT9F94lI
         83chJ7Yb/wyz/kkVLA0qTcL/hQJ6b+S3DfkldTs4We2gj1VHax8P1nbSZP8AAe2/WyYM
         l93mO5BvpcFyfsHKSYycHd6R5PmoEoJik2LVv2fIZ6EEjXYJmekYG/5HNiLx5iG1Mzix
         yVzwA/nmYFSwyTvH3umFJSIAoJGdZlSy9/JoIRGUdcXHeyHrLcnqk6/20Cf4PV5AtLva
         hHqA==
X-Gm-Message-State: ANoB5pmlh/wTeXJ9Wwc+n1znHYjNoM8HjnS1F6rG0/TBWeEVX83Kj1cj
        YGlOggcfreBhzI9EBw/F58clQMPx0BItQw6a2Xwaa9fB9NjQcJbeTtY1qUlBW5cR8fZhLlMNsAz
        fFP2CAPAUGomqHxa0mAwi0FU9
X-Received: by 2002:a17:907:2e01:b0:7c1:4785:d650 with SMTP id ig1-20020a1709072e0100b007c14785d650mr15753710ejc.26.1671017331311;
        Wed, 14 Dec 2022 03:28:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51zQh3SZbC7NTgw2aWPtw7FbZNJ77uN6cebDF0KH1vWAazOQTKapn1o/HoydATeVdIirBWLg==
X-Received: by 2002:a17:907:2e01:b0:7c1:4785:d650 with SMTP id ig1-20020a1709072e0100b007c14785d650mr15753699ejc.26.1671017331116;
        Wed, 14 Dec 2022 03:28:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id qx38-20020a170907b5a600b0078df3b4464fsm5815368ejc.19.2022.12.14.03.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:28:50 -0800 (PST)
Message-ID: <8cf30cb2-6dec-b21b-ba15-f21490546426@redhat.com>
Date:   Wed, 14 Dec 2022 12:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] i2c: designware: Fix unbalanced suspended flag
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, jsd@semihalf.com, wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221213144524.368297-1-rf@opensource.cirrus.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221213144524.368297-1-rf@opensource.cirrus.com>
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

Hi Richard,

On 12/13/22 15:45, Richard Fitzgerald wrote:
> Ensure that i2c_mark_adapter_suspended() is always balanced by a call to
> i2c_mark_adapter_resumed().
> 
> dw_i2c_plat_resume() must always be called, so that
> i2c_mark_adapter_resumed() is called. This is not compatible with
> DPM_FLAG_MAY_SKIP_RESUME.
> 
> The pairing of pm_runtime_force_suspend() and pm_runtime_force_resume()
> can replace this. If nothing is using the driver, and it is not currently
> suspended, it will be put into runtime-suspend and will be left in
> runtime-suspend during the system resume.
> 
> pm_runtime_force_suspend() is not compatible with DPM_FLAG_SMART_SUSPEND
> so this must also be removed. DPM_FLAG_SMART_SUSPEND will set the device
> back to pm_runtime_active() during resume_noirq if it cannot skip resume.
> This would lead to the inconsistent state where the driver runtime_suspend
> has been called (by force_suspend()) but it is marked active (by PM core).
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

Thank you. I like the new approach in this version.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 26 ++++++++++-----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index ba043b547393..590503e56bd0 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -349,17 +349,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	adap->dev.of_node = pdev->dev.of_node;
>  	adap->nr = -1;
>  
> -	if (dev->flags & ACCESS_NO_IRQ_SUSPEND) {
> -		dev_pm_set_driver_flags(&pdev->dev,
> -					DPM_FLAG_SMART_PREPARE |
> -					DPM_FLAG_MAY_SKIP_RESUME);
> -	} else {
> -		dev_pm_set_driver_flags(&pdev->dev,
> -					DPM_FLAG_SMART_PREPARE |
> -					DPM_FLAG_SMART_SUSPEND |
> -					DPM_FLAG_MAY_SKIP_RESUME);
> -	}
> -
> +	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
>  	device_enable_async_suspend(&pdev->dev);
>  
>  	/* The code below assumes runtime PM to be disabled. */
> @@ -453,10 +443,15 @@ static int dw_i2c_plat_runtime_suspend(struct device *dev)
>  static int __maybe_unused dw_i2c_plat_suspend(struct device *dev)
>  {
>  	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
>  
>  	i2c_mark_adapter_suspended(&i_dev->adapter);
>  
> -	return dw_i2c_plat_runtime_suspend(dev);
> +	return 0;
>  }
>  
>  static int dw_i2c_plat_runtime_resume(struct device *dev)
> @@ -474,8 +469,13 @@ static int dw_i2c_plat_runtime_resume(struct device *dev)
>  static int __maybe_unused dw_i2c_plat_resume(struct device *dev)
>  {
>  	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Resume if pm_runtime_force_suspend() suspended. */
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
>  
> -	dw_i2c_plat_runtime_resume(dev);
>  	i2c_mark_adapter_resumed(&i_dev->adapter);
>  
>  	return 0;

