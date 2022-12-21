Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD26536F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLUTX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLUTX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:23:27 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE1B8C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:23:26 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j206so17657671ybj.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K/sXvFrmbYs7P7b0KiJPCWXouTslsk2Z93msc3M9Inc=;
        b=U0iRcNnOyVoyaix10c4Z9dXZ6zTE/yxFFRgQDw/I5CHvFZq8ZvjPbRznPLM+KTWoOQ
         rBsTvGszZA6257XmcY9ZiVocUVlc36TBRMNxrwWCu4fr2oH3GCVEETQWVVmVwD7ZiPhZ
         0LcdZ7xVV/7p3Twg2Ju0zrY+erD+tyF1NzPx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/sXvFrmbYs7P7b0KiJPCWXouTslsk2Z93msc3M9Inc=;
        b=hAci2kHOE2o7rTdtMzz2SjZvHNclNJGNZ/FT4yNxxrP9F04/yEuq1hKBUm8LFCdYvc
         KnNeTsSy0ziJesi6jWJQF3JEUtieGYIfiqeumiW9wWudi9hYXhoyDrZPdSZU/OqNQeqd
         v99KJ2rTuNkFcdgXL0ZPRfbypW/9HJB33O164F2GVmPZ2YcsOllOZEI0f45M/Ayqb1Fb
         egcRjb3bDZBR6SkJn0FMPLyuoz9P8ErW42FI7f8eNeEEcuWUZjoXiF2NGuvaKEj3VwfZ
         /xSsMhJZycfyr+SDxMsN26rXFUHea+VP+c+ATysqoVfgrb788p9tZ2mgVcYPNZg2MscT
         5hmA==
X-Gm-Message-State: AFqh2kpMnmYzG+NzCnM7Cwwn6P5d02PD4U9dUbRWOOz6j4CuWn7dvuam
        mQ5nV2e6SC3aFmJEQyGMIilfo1x3v7kPwvhsNGrrzw==
X-Google-Smtp-Source: AMrXdXuZORu9jTsPNLG+uGDrELKBm2RqdfngkRIY9XF0dFWhg3mxyRIAJwMaCdMkNmwhphndMXLlejioJgUHvu3ee1c=
X-Received: by 2002:a25:9a08:0:b0:740:b601:45e6 with SMTP id
 x8-20020a259a08000000b00740b60145e6mr261435ybn.121.1671650605658; Wed, 21 Dec
 2022 11:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20221221185540.2265771-1-robbarnes@google.com>
In-Reply-To: <20221221185540.2265771-1-robbarnes@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 21 Dec 2022 11:23:14 -0800
Message-ID: <CACeCKafZu=46NE--r9W-wtJWAhj8=s46yCBO4N4u5nt4COqYAQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Handle CrOS EC panics
To:     Rob Barnes <robbarnes@google.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I'd suggest using the commit title tag "platform/chrome: cros_ec: ..."
for commits which are "ChromeOS EC" wide. That's in line with
other recent commits in this directory.

On Wed, Dec 21, 2022 at 10:56 AM Rob Barnes <robbarnes@google.com> wrote:
>
> Add handler for CrOS EC panic events. When a panic is reported,
> poll EC log then force an orderly shutdown.
>
> This will preserve the EC log leading up to the crash.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> ---
>  drivers/platform/chrome/cros_ec_debugfs.c   | 24 +++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_lpc.c       | 10 +++++++++
>  include/linux/platform_data/cros_ec_proto.h |  9 ++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 21d973fc6be2..31637a4e4cf9 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -49,6 +49,7 @@ struct cros_ec_debugfs {
>         struct delayed_work log_poll_work;
>         /* EC panicinfo */
>         struct debugfs_blob_wrapper panicinfo_blob;
> +       struct notifier_block notifier_panic;
>  };
>
>  /*
> @@ -437,6 +438,23 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
>         return ret;
>  }
>
> +static int cros_ec_debugfs_panic_event(struct notifier_block *nb,
> +                                      unsigned long queued_during_suspend,
> +                                      void *_notify)
> +{
> +       struct cros_ec_debugfs *debug_info =
> +               container_of(nb, struct cros_ec_debugfs, notifier_panic);
> +
> +       if (debug_info->log_buffer.buf) {
> +               /* Force log poll work to run immediately */
> +               mod_delayed_work(debug_info->log_poll_work.wq, &debug_info->log_poll_work, 0);
> +               /* Block until log poll work finishes */
> +               flush_delayed_work(&debug_info->log_poll_work);
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
>  static int cros_ec_debugfs_probe(struct platform_device *pd)
>  {
>         struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> @@ -473,6 +491,12 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>         debugfs_create_u16("suspend_timeout_ms", 0664, debug_info->dir,
>                            &ec->ec_dev->suspend_timeout_ms);
>
> +       debug_info->notifier_panic.notifier_call = cros_ec_debugfs_panic_event;
> +       ret = blocking_notifier_chain_register(&ec->ec_dev->panic_notifier,
> +                                              &debug_info->notifier_panic);
> +       if (ret)
> +               goto remove_debugfs;
> +
>         ec->debug_info = debug_info;
>
>         dev_set_drvdata(&pd->dev, ec);
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7fc8f82280ac..21958c3b0c28 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
> +#include <linux/reboot.h>
>  #include <linux/suspend.h>
>
>  #include "cros_ec.h"
> @@ -332,6 +333,15 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
>
>         if (value == ACPI_NOTIFY_DEVICE_WAKE)
>                 pm_system_wakeup();
> +
> +       if (value == ACPI_NOTIFY_CROS_EC_PANIC) {
> +               dev_err(ec_dev->dev,
> +                       "CrOS EC Panic Reported. Shutdown is imminent!");
> +               blocking_notifier_call_chain(&ec_dev->panic_notifier, 0,
> +                                            ec_dev);
> +               /* Begin orderly shutdown. Force shutdown after 1 second. */
> +               hw_protection_shutdown("CrOS EC Panic", 1000);

I feel like this patch is doing 2 things: pulling the logs, and then
starting a shutdown.
This should be split into 2 patches.

> +       }
>  }

Line limits are now 100 chars[1], so most of these lines can fit on 1 line.

>
>  static int cros_ec_lpc_probe(struct platform_device *pdev)
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index e43107e0bee1..1c4487271836 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -41,6 +41,13 @@
>  #define EC_MAX_REQUEST_OVERHEAD                1
>  #define EC_MAX_RESPONSE_OVERHEAD       32
>
> +/*
> + * EC panic is not covered by the standard (0-F) ACPI notify values.
> + * Arbitrarily choosing B0 to notify ec panic, which is in the 84-BF
> + * device specific ACPI notify range.
> + */
> +#define ACPI_NOTIFY_CROS_EC_PANIC      0xB0

Can you provide a link (either in the commit, or here in the comment)
to the coreboot/BIOS code which uses this value? I feel this should
be documented in some form that correlates the caller and the callee.

> +
>  /*
>   * Command interface between EC and AP, for LPC, I2C and SPI interfaces.
>   */
> @@ -176,6 +183,8 @@ struct cros_ec_device {
>         /* The platform devices used by the mfd driver */
>         struct platform_device *ec;
>         struct platform_device *pd;
> +
> +       struct blocking_notifier_head panic_notifier;

Any reason we cannot use the existing event_notifier (with value argument)?
It's a system panic, so I doubt that computational overhead for other
notifier block
listeners is a concern.

BR,

-Prashant

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
