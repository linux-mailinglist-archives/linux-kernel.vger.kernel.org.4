Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A710560B3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiJXRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiJXRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24E187097
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666626609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=St4Oo1+ZOBe0lGhOZfdzJtwdKULc2yTF38gsrCy5cIs=;
        b=hB8c1OSRjCEv9KDBqzrnFqkidQMjM+tkDJ8Ga+AdswYMOEgTgCPJ1j6wsCo95b2Petvbej
        +7CUyUje5XBxdMwyaAa4xIwwyzwto5DXgDeI3NhaqCTZNDXwR60dZuAIcu7dMM7Na5kC3j
        BND2Qi3B9Jo2CIcJJBNgaUT0i0xFRhE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-lPmyy-T7PTisCUyRPOWjNg-1; Mon, 24 Oct 2022 10:32:42 -0400
X-MC-Unique: lPmyy-T7PTisCUyRPOWjNg-1
Received: by mail-ed1-f69.google.com with SMTP id h9-20020a05640250c900b00461d8ee12e2so2510123edb.23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=St4Oo1+ZOBe0lGhOZfdzJtwdKULc2yTF38gsrCy5cIs=;
        b=zVY4rzM5dElev7XPFRZZ4bn3raUGLZAi35eqcnc3fsEZRDJ4LLqYbqjRxYnolNYiH7
         f664OybVL3hNZMnHV8v6sqvdyH595/+Y9M0uIZ/ZYy5yxxz+kkA3cNWNbxuT8vOikHSJ
         ryCsJP9A3KvJ05xx1WNo9Wykz8R92IADKy901HKtU+kfIgEgXUKHNwKSS8J9wrtl2EE9
         R8JzfVZEjeFfRmZm0gMkv8JS1WcZ0jMLhZypYKwuNAVLd+udYRamOCInNi0jIVAkpJD1
         C5D3p62ZbYIfyzjByNLmbyd4sIxiD3yViwT7PGeE8KuhU5XyfkmbDlWMRJsl5rtvfW4i
         EJaw==
X-Gm-Message-State: ACrzQf1Bgv++yjNTIUetYujwNKoq7AqAqXd+WCQuk2r5ZO3ZrInH2RXl
        xGbnSiaPhK8Fv/dBKwfBU34U3dZOYoS8cCz/TGUjWeHmhgeM4FlMN2H8Xvk7+LJbIpL08bycfuA
        DxG0q/vNhKrxVpp0jOnfq8jAf
X-Received: by 2002:a05:6402:2710:b0:45c:d7b4:6948 with SMTP id y16-20020a056402271000b0045cd7b46948mr30996978edd.215.1666621960895;
        Mon, 24 Oct 2022 07:32:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7FteBuj1i+suD+fzUBHUwobCQ42/zPj3LuJ2XNuBwLGr/mL3KqKm8I/n6s3gjZh8Jv/+v1Ag==
X-Received: by 2002:a05:6402:2710:b0:45c:d7b4:6948 with SMTP id y16-20020a056402271000b0045cd7b46948mr30996964edd.215.1666621960720;
        Mon, 24 Oct 2022 07:32:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ed5-20020a056402294500b00461621cae1fsm4010174edb.16.2022.10.24.07.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:32:39 -0700 (PDT)
Message-ID: <dda4b024-69d2-1d1d-da23-e922e5b6128a@redhat.com>
Date:   Mon, 24 Oct 2022 16:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] ACPI: video: Fix missing native backlight on
 Chromebooks
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     kernel@collabora.com, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024141210.67784-1-dmitry.osipenko@collabora.com>
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

Hi,

On 10/24/22 16:12, Dmitry Osipenko wrote:
> Chromebooks don't have backlight in ACPI table, they suppose to use
> native backlight in this case. Check presence of the CrOS embedded
> controller ACPI device and prefer the native backlight if EC found.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native() helper")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> Changelog:
> 
> v2: - Added explanatory comment to the code and added check for the
>       native backlight presence, like was requested by Hans de Goede.

Thanks this version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, can you pick this up and send it in a fixes pull-req
for 6.1 to Linus? Or shall I pick this one up and include it
in my next pull-req?

Regards,

Hans





> 
>  drivers/acpi/video_detect.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 0d9064a9804c..9cd8797d12bb 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -668,6 +668,11 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  	{ },
>  };
>  
> +static bool google_cros_ec_present(void)
> +{
> +	return acpi_dev_found("GOOG0004");
> +}
> +
>  /*
>   * Determine which type of backlight interface to use on this system,
>   * First check cmdline, then dmi quirks, then do autodetect.
> @@ -730,6 +735,13 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>  			return acpi_backlight_video;
>  	}
>  
> +	/*
> +	 * Chromebooks that don't have backlight handle in ACPI table
> +	 * are supposed to use native backlight if it's available.
> +	 */
> +	if (google_cros_ec_present() && native_available)
> +		return acpi_backlight_native;
> +
>  	/* No ACPI video (old hw), use vendor specific fw methods. */
>  	return acpi_backlight_vendor;
>  }

