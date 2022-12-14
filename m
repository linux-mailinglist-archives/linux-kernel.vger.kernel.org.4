Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9864C456
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiLNHUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLNHUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:20:40 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18DDF82
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:20:38 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id pv25so5991797qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1kPecuVdWywoBkxG3s2ePBzPOWd86Xbr7wKHuVDA9Q=;
        b=bA9Jj5CQVqu6BMXrira32fsmN0VQlDKgPPrwH94OpzryNdKQYtHQqAuSwoJEvKs+sd
         fkDPc+PoqNTqWAHOyfY3tQwRVKlyhPxuR9Y3oY+Zavw7Wkk1eTX7zEuaJsbUrYgTT8DN
         tO2zY5bITxxQDSdPk3En/CWeLqf+NaHyENN3Q+mmhKEl/O4PLh+ZZMf9XgGNS/nzwnZd
         eQNjIEl5V6SahWnmy9N5jBfCZMLn58w5ddKdP0oyGXZnCIYKdRnglElJm2oE/MXM1iOY
         dumhvP1mIVBmdvaICXjoomJSIWWNroW9pP7WWA+T8ZyNao+RCFw+a4EDH8ZSUcuEgvA3
         NEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1kPecuVdWywoBkxG3s2ePBzPOWd86Xbr7wKHuVDA9Q=;
        b=lFl5L+NRXrKJcQ7HfnfILRt+ll590WgOuIyC/4izRVqehFE35QaOmNMDXS1LiAIWYW
         jH+ZgP6FD6n60S2x7Cz5UapGnoAh9/KJTo8JPwcUnZnMee7foZQ0lwPuyl79nlI/OZMW
         kpuPlu0AQYyghwoWNZBZQeJ6jvkraV2tfeXNahFKVXhoHV/BG6LjjNF7ACuBlMkq4QED
         G1yim5HP64BdUaXFqAdEny73VcBDoyaJSu6JTsyLS52nNMmymtCtNnQgry7CkA292vVx
         BCdPNdHO5l+T7YsRjVh4UbE9JWS40mPvfJLU9WhhigpdFdjvdSZKXKp/EXcoTFT5D3vP
         0bFA==
X-Gm-Message-State: ANoB5pkGviGNI35WxqTBsLL9c+XQhuLKcHO0U/AObr1U5FY2tSTdgfFU
        AwQYbn86S676CAbQizDo5am/59tAzZn7CtyrjwLZGg==
X-Google-Smtp-Source: AA0mqf5mKg9Qxb4B5uucCuGfeKX0vxnRREsOHWvYdz6xCkzwfteCk8hfflXQhe8rH6XFj4ANbKvVdd/K98249qhyv3g=
X-Received: by 2002:a0c:d7c1:0:b0:4c7:305:178d with SMTP id
 g1-20020a0cd7c1000000b004c70305178dmr43553316qvj.50.1671002436948; Tue, 13
 Dec 2022 23:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20221214070650.703793-1-pumahsu@google.com> <20221214070650.703793-2-pumahsu@google.com>
In-Reply-To: <20221214070650.703793-2-pumahsu@google.com>
From:   Puma Hsu <pumahsu@google.com>
Date:   Wed, 14 Dec 2022 15:20:01 +0800
Message-ID: <CAGCq0LbRtpEZm2yseiAyTXApaArYvtx3q9KyJ6X+iiDGDpSMpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: core: add vendor hook for usb suspend and resume
To:     gregkh@linuxfoundation.org, mka@chromium.org, dianders@chromium.org
Cc:     albertccwang@google.com, raychi@google.com, howardyen@google.com,
        leejj@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 3:07 PM Puma Hsu <pumahsu@google.com> wrote:
>
> Add the hooks that vendor can design and bypass the suspend/resume.
> When the handled is set, skip the original suspend/resume process.
>
> In mobile, a co-processor can be used for USB audio. When the co-processor
> is working for USB audio, the co-processor is the user/owner of the USB
> driver, and the ACPU is able to sleep in such condition to improve power
> consumption. In original process, the ACPU will suspend/resume until the
> USB suspend/resume. We add the hooks, so we can control USB suspend/resume
> without affecting the ACPU.
>
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> ---
>  drivers/usb/core/Makefile |  2 +-
>  drivers/usb/core/driver.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.h    |  5 +++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> index 7d338e9c0657..f48f646cd874 100644
> --- a/drivers/usb/core/Makefile
> +++ b/drivers/usb/core/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for USB Core files and filesystem
>  #
>
> -usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
> +usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o usb-hooks-impl-goog.o
>  usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
>  usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>  usbcore-y += phy.o port.o

Sorry I should not add usb-hooks-impl-goog to the makefile.
I will upload a version2

> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 7e7e119c253f..3d2cfb6c2277 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -35,6 +35,25 @@
>  #include "usb.h"
>
>
> +static struct usb_device_vendor_ops *usb_dev_vendor_ops;
> +
> +int usb_dev_register_vendor_ops(struct usb_device_vendor_ops *vendor_ops)
> +{
> +       if (vendor_ops == NULL)
> +               return -EINVAL;
> +
> +       usb_dev_vendor_ops = vendor_ops;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_dev_register_vendor_ops);
> +
> +struct usb_device_vendor_ops *usb_vendor_get_ops(void)
> +{
> +       return usb_dev_vendor_ops;
> +}
> +EXPORT_SYMBOL_GPL(usb_vendor_get_ops);
> +
> +
>  /*
>   * Adds a new dynamic USBdevice ID to this driver,
>   * and cause the driver to probe for all devices again.
> @@ -1400,11 +1419,19 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
>         int                     status = 0;
>         int                     i = 0, n = 0;
>         struct usb_interface    *intf;
> +       bool                    handled;
> +       struct usb_device_vendor_ops *ops = usb_vendor_get_ops();
>
>         if (udev->state == USB_STATE_NOTATTACHED ||
>                         udev->state == USB_STATE_SUSPENDED)
>                 goto done;
>
> +       if (ops && ops->usb_dev_suspend) {
> +               handled = ops->usb_dev_suspend(udev, msg);
> +               if (handled)
> +                       goto done;
> +       }
> +
>         /* Suspend all the interfaces and then udev itself */
>         if (udev->actconfig) {
>                 n = udev->actconfig->desc.bNumInterfaces;
> @@ -1501,11 +1528,20 @@ static int usb_resume_both(struct usb_device *udev, pm_message_t msg)
>         int                     status = 0;
>         int                     i;
>         struct usb_interface    *intf;
> +       bool                    handled;
> +       struct usb_device_vendor_ops *ops = usb_vendor_get_ops();
>
>         if (udev->state == USB_STATE_NOTATTACHED) {
>                 status = -ENODEV;
>                 goto done;
>         }
> +
> +       if (ops && ops->usb_dev_resume) {
> +               handled = ops->usb_dev_resume(udev, msg);
> +               if (handled)
> +                       goto done;
> +       }
> +
>         udev->can_submit = 1;
>
>         /* Resume the device */
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 82538daac8b8..9ccb8683071d 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -220,3 +220,8 @@ extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
>  static inline int usb_acpi_register(void) { return 0; };
>  static inline void usb_acpi_unregister(void) { };
>  #endif
> +
> +struct usb_device_vendor_ops {
> +       bool (*usb_dev_suspend)(struct usb_device *udev, pm_message_t msg);
> +       bool (*usb_dev_resume)(struct usb_device *udev, pm_message_t msg);
> +};
> --
> 2.39.0.rc1.256.g54fd8350bd-goog
>
