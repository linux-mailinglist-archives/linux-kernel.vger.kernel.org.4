Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629825F9B76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJJIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJJIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31263F3E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665392138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7VBUmb4ja5WOJbdR8MKHyKOR+fG8UZ7OpOGyA2nFsWI=;
        b=JFb+5SrOyYkwx5ABUwSFcP+CFf7m8CZoH4UKvlKwSD4TrtdsjSQexci/eCLmUgsBZ/NyC7
        JxcvyBiz7/TRDMChG63M8acdoi5XPve+iwAWj8sPCu2tzjFfbipv2ViiD5FQXLVxPqS+MG
        UNRzSctLatxbk137CFhwGybrOsoQ/wE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-MA2UObCSO6aH5iX28EVrsw-1; Mon, 10 Oct 2022 04:55:36 -0400
X-MC-Unique: MA2UObCSO6aH5iX28EVrsw-1
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so6853428ioz.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VBUmb4ja5WOJbdR8MKHyKOR+fG8UZ7OpOGyA2nFsWI=;
        b=HUVWWJ01iPaxS2nu7kkwfl7ek77djsJLKFsEVlmSZWCzfAIUOUvftuAQOKoDMjslGk
         DMTk7jVDWK45GV7N2T/5N5bxzdWzecEfdjPY7TKug59iaJzggbGN1kPrltr2bfO5L7FR
         wn5vSXxvlkWmUhRQ1hPuk9ueq3Y0uOWKOynrLrUDq6sRgLC5APFiK4CbZHnH6e0ksrt+
         NkoayiGgw1e3gKR5BIEQFyYn4nbRMCK8+iX/HQ2BY2/Lk21XVBiKTYqFPU9cpTbtIZNn
         cisan+BLuSKFBERRAZSJ8dCduKUlMPtQDbFgFQlUn777luTCEWqjF8bpCgvLFmD/e4Ea
         Cevg==
X-Gm-Message-State: ACrzQf00DxThvFxtgxKZR0eofsgEvMBYcaOrsve69mJ7719iko6troBD
        x0vJc51njAeemUxFN8SNzF8pkKcRoT3EoNxRZMLkw11HYhKYAPcMc4DRhH2GfHUYOCzb1B8EsHn
        nyyynanal1Y/1aLDA9klMrIUwc9n0CqKywFC3C6GG
X-Received: by 2002:a05:6638:168a:b0:35a:6acf:f94 with SMTP id f10-20020a056638168a00b0035a6acf0f94mr8962195jat.106.1665392136092;
        Mon, 10 Oct 2022 01:55:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4PHdnCU+yVqYk4GQszXGKtAsj7Pa3fmjdjqARIJdJVw3uJqtDfqp9TnL+w+ERkrPwDqcN3at+nRjtLn8DTGag=
X-Received: by 2002:a05:6638:168a:b0:35a:6acf:f94 with SMTP id
 f10-20020a056638168a00b0035a6acf0f94mr8962164jat.106.1665392135182; Mon, 10
 Oct 2022 01:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <Y0HLPBTodPxVRbe4@octinomon>
In-Reply-To: <Y0HLPBTodPxVRbe4@octinomon>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 10 Oct 2022 10:55:24 +0200
Message-ID: <CAO-hwJJebdHvb-JA18XnLAP0LVfvZ6QvOVbskpJ0ZRxPCBmetw@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: roccat: Convert snprintf() to sysfs_emit()
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     erazor_de@users.sourceforge.net, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jules,

On Sat, Oct 8, 2022 at 9:11 PM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Coccinnelle reports a warning
> Warning: Use scnprintf or sprintf
>
> Following the advice on kernel documentation
> https://www.kernel.org/doc/html/latest/filesystems/sysfs.html
>
> For show(device *...) functions we should only use sysfs_emit() or sysfs_emit_at()
> especially when formatting the value to be returned to user space.
>
> Convert snprintf() to sysfs_emit()
>
> Signed-off-by: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>

Thanks for the submission, however I see that you sent 5 different
patches with the exact same commit messages, touching 4 different
files.
I suspect 3/3 and 2/2 are the same, so I am a little bit puzzled...

Would you mind sending a v2 with everything squashed into just one
patch targeting all of hid-roccat-*?

I think I'll empty the queue regarding all of those sysfs_emit
conversions in 6.2.

But please be aware that I can not apply anything 6.2 related right
now, we are in the merge window of 6.1 and I can not push anything to
for-next that is 6.2.

Cheers,
Benjamin

> ---
>  drivers/hid/hid-roccat-kone.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index 76da04801ca9..f0c35c05e702 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -403,7 +403,7 @@ static ssize_t kone_sysfs_show_actual_profile(struct device *dev,
>  {
>         struct kone_device *kone =
>                         hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -       return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_profile);
> +       return sysfs_emit(buf, "%d\n", kone->actual_profile);
>  }
>  static DEVICE_ATTR(actual_profile, 0440, kone_sysfs_show_actual_profile, NULL);
>
> @@ -412,7 +412,7 @@ static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
>  {
>         struct kone_device *kone =
>                         hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -       return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_dpi);
> +       return sysfs_emit(buf, "%d\n", kone->actual_dpi);
>  }
>  static DEVICE_ATTR(actual_dpi, 0440, kone_sysfs_show_actual_dpi, NULL);
>
> @@ -435,7 +435,7 @@ static ssize_t kone_sysfs_show_weight(struct device *dev,
>
>         if (retval)
>                 return retval;
> -       return snprintf(buf, PAGE_SIZE, "%d\n", weight);
> +       return sysfs_emit(buf, "%d\n", weight);
>  }
>  static DEVICE_ATTR(weight, 0440, kone_sysfs_show_weight, NULL);
>
> @@ -444,7 +444,7 @@ static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
>  {
>         struct kone_device *kone =
>                         hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -       return snprintf(buf, PAGE_SIZE, "%d\n", kone->firmware_version);
> +       return sysfs_emit(buf, "%d\n", kone->firmware_version);
>  }
>  static DEVICE_ATTR(firmware_version, 0440, kone_sysfs_show_firmware_version,
>                    NULL);
> @@ -454,7 +454,7 @@ static ssize_t kone_sysfs_show_tcu(struct device *dev,
>  {
>         struct kone_device *kone =
>                         hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -       return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.tcu);
> +       return sysfs_emit(buf, "%d\n", kone->settings.tcu);
>  }
>
>  static int kone_tcu_command(struct usb_device *usb_dev, int number)
> @@ -556,7 +556,7 @@ static ssize_t kone_sysfs_show_startup_profile(struct device *dev,
>  {
>         struct kone_device *kone =
>                         hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -       return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.startup_profile);
> +       return sysfs_emit(buf, "%d\n", kone->settings.startup_profile);
>  }
>
>  static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
> --
> 2.37.3
>

