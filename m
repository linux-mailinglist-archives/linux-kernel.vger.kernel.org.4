Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301FA67838C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjAWRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0F2F7A3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674496009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSpU8Fnu44BAO8XQCUCc7Ds/9nau4mzqfKlC4gjcApM=;
        b=EjO5uBdHV1wUxb+4J5vtK3VGpr+JZZCRwt5QmIvxZXsuu3yUtR9854s4GArhz0HB9RQ1Wj
        rj3nGVmFwv0X7ccrw2X71dJ2iyt5H7zNVquL6u1enhczmSOYcVJbIzGnHfDgngqS63EHs5
        fYUdYb/bO49aUH5JSTIehFhC5cUwyaI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-pOAgZCbZOIe6OI7emPUiOA-1; Mon, 23 Jan 2023 12:46:47 -0500
X-MC-Unique: pOAgZCbZOIe6OI7emPUiOA-1
Received: by mail-ed1-f69.google.com with SMTP id t17-20020a056402525100b0049e0d2dd9b1so8973399edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSpU8Fnu44BAO8XQCUCc7Ds/9nau4mzqfKlC4gjcApM=;
        b=HhyYHjU4ZuJpR/7QfRZfUwmclozwHl5pamlsDgCrv/gJiWON5uQDbKhBq3n1zmgD02
         fMNmqX3RSpaq99ztdN5dAnn9v8bg95vZBMQ6AqUtvq7YutBldhKSr6E4MtkI8UZtLDAY
         QNCN0YWU7qpEY8nBy9ScDxoGxWAQskB2Y5UG1/QjqGMy8isaCj0PXPiG5B5jdX9LzBPs
         CG5R8cvL7RucUJm60TxaM5124q2olqospRifyYJAl3/coIJ+fgBNMLrCd9/QTKMQ+ARF
         v7hJVWBMYpCYqc9HExiP/Dae3duUg5Enj6+9kElsgnaEl0IumjbbS0IuRJ0v/8AcGavY
         RU3Q==
X-Gm-Message-State: AFqh2kqNrCw0O+EJgzrl8NazacpsH4u0ZgmDbv/dro/1CGMo26nVRtfk
        8/zWX6PVAo2268NCJgsW00JacVvElMGyzV06k1+wWfbuqzIYQ6HgVHnT1e+IGzEXS0v9tO6CdUs
        tfYyhCfg5LGpDlgtAW+tBMiPj
X-Received: by 2002:a17:907:1710:b0:86f:64bb:47eb with SMTP id le16-20020a170907171000b0086f64bb47ebmr26993342ejc.3.1674496006112;
        Mon, 23 Jan 2023 09:46:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsIwMltMSsN1RlXrtbK0LRNbScrIKxzHCR+mdiNjOIZw8eCVzkKtNZ1KY3fs7AU9On1Bf69vA==
X-Received: by 2002:a17:907:1710:b0:86f:64bb:47eb with SMTP id le16-20020a170907171000b0086f64bb47ebmr26993331ejc.3.1674496005968;
        Mon, 23 Jan 2023 09:46:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k22-20020a17090632d600b00780982d77d1sm10669603ejk.154.2023.01.23.09.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:46:45 -0800 (PST)
Message-ID: <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
Date:   Mon, 23 Jan 2023 18:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/3] ACPI: video: Fix refcounting in
 apple_gmux_backlight_present()
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
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

On 1/23/23 18:10, Andy Shevchenko wrote:
> acpi_dev_get_first_match_dev() gets ACPI device with the bumped
> refcount. The caller must drop it when it's done.
> 
> Fix ACPI device refcounting in apple_gmux_backlight_present().
> 
> Fixes: 3cf3b7f012f3 ("ACPI: video: Fix Apple GMUX backlight detection")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your work on this, much appreciated and I like
the new acpi_get_first_match_physical_node().

But I don't think this patch is a good idea. There is a
regression related to apple_gmux_backlight_present()
with a patch-set fixing it pending.

And that patch-set actually removes this function. Adding
a fix for this real, but not really important leak now,
will just make backporting the actual fix harder.

So I would prefer for this patch to not go in and to
go for (a to be submitted v2) of the patch-set fixing
the regression right away instead.

Regards,

Hans



> ---
>  drivers/acpi/video_detect.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 65cec7bb6d96..0ccde0d4c527 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -114,12 +114,14 @@ static bool apple_gmux_backlight_present(void)
>  {
>  	struct acpi_device *adev;
>  	struct device *dev;
> +	bool ret;
>  
>  	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
>  	if (!adev)
>  		return false;
>  
> -	dev = acpi_get_first_physical_node(adev);
> +	dev = get_device(acpi_get_first_physical_node(adev));
> +	acpi_dev_put(adev);
>  	if (!dev)
>  		return false;
>  
> @@ -127,7 +129,9 @@ static bool apple_gmux_backlight_present(void)
>  	 * drivers/platform/x86/apple-gmux.c only supports old style
>  	 * Apple GMUX with an IO-resource.
>  	 */
> -	return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> +	ret = pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> +	put_device(dev);
> +	return ret;
>  }
>  
>  /* Force to use vendor driver when the ACPI device is known to be

