Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E367742A39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjF2QGN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjF2QGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:06:08 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73C10D5;
        Thu, 29 Jun 2023 09:06:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b588fa06d3so2391711fa.1;
        Thu, 29 Jun 2023 09:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054766; x=1690646766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntbPBy9hL81QsIqvjwYhJyNuvTZOUVlNvwxpzjeFHfM=;
        b=KOwrQmAB9b1MljFinBbwIAvP4V5hXH9V7T5HxNfedwcHYd6gMNrOHiU+Rmi4HUUJwM
         i/a3yel4U7OwYkxjmOfX/SAOUNzZp+eJK4L6ORgCOit1sPLp9slFIoyOJvgBuzH/BmBl
         oGrzt8aOa2AtteiXpPEQGpSUOUGHdQ36+buRjoPxQjZ58SHeg5ePBfU1X85hhdcLpBuR
         pM3xkWPeLFLTJoPETNa/iNdLHEi4+0pb9Bb4EYYG7XkTiFY019DvC2krmskPDtiffwd7
         oZNJMp5rwr+OOJJJwZwsiZxbXGSYVpn53ySdHTTo7Ebirl8EHVtq/gp6U5fLbDcSHP9y
         md7A==
X-Gm-Message-State: ABy/qLZvK5Zu0Ky/qWHVOQCeYPj2Op+a0etNl5HZAfLDqD++oEzZhdhs
        +NUIeD8xjitcB/K5ailr3hl2nBiux5DSUv94774XEuUA
X-Google-Smtp-Source: APBJJlEBeNzBQoTEpcMIau50F2Gui9AM3lBLb2enorCyrJ6R7CueEN1gDl0LhpN3gVgaDLrcFOBjIILOG0ucvKIjtRY=
X-Received: by 2002:a2e:9844:0:b0:2b6:a882:129c with SMTP id
 e4-20020a2e9844000000b002b6a882129cmr210688ljj.0.1688054765305; Thu, 29 Jun
 2023 09:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com> <20230616165034.3630141-6-michal.wilczynski@intel.com>
In-Reply-To: <20230616165034.3630141-6-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 18:05:54 +0200
Message-ID: <CAJZ5v0i1-7p-V0nFHoNWHDXRZ-xvVwTXJKM387PTP1d4k7Wrdg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] acpi/battery: Move handler installing logic to driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
>
> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify function to match with
> what's required by acpi_install_notify_handler(). Remove .notify
> callback initialization in acpi_driver.
>
> While at it, fix lack of whitespaces in .remove() callback.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/battery.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 9c67ed02d797..6337e7b1f6e1 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1034,11 +1034,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
>  }
>
>  /* Driver Interface */
> -static void acpi_battery_notify(struct acpi_device *device, u32 event)
> +static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       struct acpi_battery *battery = acpi_driver_data(device);
> +       struct acpi_device *device = data;
> +       struct acpi_battery *battery;
>         struct power_supply *old;
>
> +       battery = acpi_driver_data(device);
> +
>         if (!battery)
>                 return;
>         old = battery->bat;
> @@ -1212,13 +1215,23 @@ static int acpi_battery_add(struct acpi_device *device)
>
>         device_init_wakeup(&device->dev, 1);
>
> -       return result;
> +       result = acpi_dev_install_notify_handler(device,
> +                                                ACPI_ALL_NOTIFY,
> +                                                acpi_battery_notify);
> +       if (result)
> +               goto fail_deinit_wakup_and_unregister;

You could call the label "fail_pm", for example, which would be more
concise and so slightly easier to follow, without any loss of clarity
AFAICS.

> +
> +       return 0;
>
> +fail_deinit_wakup_and_unregister:
> +       device_init_wakeup(&device->dev, 0);
> +       unregister_pm_notifier(&battery->pm_nb);
>  fail:
>         sysfs_remove_battery(battery);
>         mutex_destroy(&battery->lock);
>         mutex_destroy(&battery->sysfs_lock);
>         kfree(battery);
> +
>         return result;
>  }
>
> @@ -1228,10 +1241,17 @@ static void acpi_battery_remove(struct acpi_device *device)
>
>         if (!device || !acpi_driver_data(device))
>                 return;
> -       device_init_wakeup(&device->dev, 0);
> +
>         battery = acpi_driver_data(device);
> +
> +       acpi_dev_remove_notify_handler(device,
> +                                      ACPI_ALL_NOTIFY,
> +                                      acpi_battery_notify);
> +
> +       device_init_wakeup(&device->dev, 0);
>         unregister_pm_notifier(&battery->pm_nb);
>         sysfs_remove_battery(battery);
> +
>         mutex_destroy(&battery->lock);
>         mutex_destroy(&battery->sysfs_lock);
>         kfree(battery);
> @@ -1264,11 +1284,9 @@ static struct acpi_driver acpi_battery_driver = {
>         .name = "battery",
>         .class = ACPI_BATTERY_CLASS,
>         .ids = battery_device_ids,
> -       .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>         .ops = {
>                 .add = acpi_battery_add,
>                 .remove = acpi_battery_remove,
> -               .notify = acpi_battery_notify,
>                 },
>         .drv.pm = &acpi_battery_pm,
>  };
> --
> 2.41.0
>
