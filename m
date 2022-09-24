Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA05E8EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiIXRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiIXRAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:00:34 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AB4F1B9;
        Sat, 24 Sep 2022 10:00:30 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id y2so1865949qkl.11;
        Sat, 24 Sep 2022 10:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Mv7RZGDha7iDmRE6av7uMPU/L2zibi5cjYqnmme1EJA=;
        b=78nzq/JUXqGFR5hKltSiykUmvR+PiN9kk7X9yZoKtKZ7NbfoiwBglg5JqzP0qPvhVu
         usb4KrEWEfCaT1oBp8zKpfbY/NMiJockJNweTUHJ4iIo8ELDYbFQsFguBYtBYgtCTnhX
         d9SGhRnLYDj9+c7z49V2wn3LTmplQgrro92hTlsHPIisVBh7Lpi6q8yr6wvQ+YYig7Jh
         Tm+kzZdTzaSh8xlPptFBC8PRjzdUQ8UXDDWsTY24vnVZoowiJy4Ii3W/zM0h1t7Fpxl9
         Dr+HztpEgcqHxeG3ceuBiw8ltQUEMCMYzZMAeWXVao14E2weI+nQKVkM4gxmpNSmkUNW
         bk2w==
X-Gm-Message-State: ACrzQf2xgVxsJcUwJyUwgu1rVOWxYTnTwRtoPAUg5tzIu8tBbpnSL3JS
        Z4ywjBXDRwTbaecRzROJ6y0gPMOw5HWtP+jeU1I=
X-Google-Smtp-Source: AMsMyM7V96vRbUfHtrdxXkPZ57kKXudE2UxOP+8P1vkzaxCCb++Gqh+e9RQQknQeG/HtvzrtMpfzD2UNNdNhMZXLZlw=
X-Received: by 2002:a05:620a:290d:b0:6b6:1a92:d88a with SMTP id
 m13-20020a05620a290d00b006b61a92d88amr9463711qkp.58.1664038829737; Sat, 24
 Sep 2022 10:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155205.1332614-1-rrangel@chromium.org> <20220921094736.v5.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
In-Reply-To: <20220921094736.v5.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:00:19 +0200
Message-ID: <CAJZ5v0g57mF-4ZC2ajL5+JE+q9y=fW1G-OXR8tuOk4TYxHPWtQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] ACPI: PM: Take wake IRQ into consideration when
 entering suspend-to-idle
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 5:52 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> This change adds support for ACPI devices that use ExclusiveAndWake or
> SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
> and also provide power resources. Previously the ACPI subsystem had no
> idea if the device had a wake capable interrupt armed. This resulted
> in the ACPI device PM system placing the device into D3Cold, and thus
> cutting power to the device. With this change we will now query the
> _S0W method to figure out the appropriate wake capable D-state.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
>
> Changes in v5:
> - Go back to using adev->wakeup.flags.valid to keep the diff cleaner
> - Fix a typo in comment
>
>  drivers/acpi/device_pm.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 9dce1245689ca2..3111fc426e04fd 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>                 d_min = ret;
>                 wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
>                         && adev->wakeup.sleep_state >= target_state;
> -       } else {
> -               wakeup = adev->wakeup.flags.valid;
> +       } else if (adev->wakeup.flags.valid) {
> +               /* ACPI GPE specified in _PRW. */
> +               wakeup = true;

I would retain the "else" clause as it was and just add a new "else
if" one before it.

> +       } else if (device_may_wakeup(dev) && dev->power.wakeirq) {
> +               /*
> +                * The ACPI subsystem doesn't manage the wake bit for IRQs
> +                * defined with ExclusiveAndWake and SharedAndWake. Instead we
> +                * expect them to be managed via the PM subsystem. Drivers
> +                * should call dev_pm_set_wake_irq to register an IRQ as a wake
> +                * source.
> +                *
> +                * If a device has a wake IRQ attached we need to check the
> +                * _S0W method to get the correct wake D-state. Otherwise we
> +                * end up putting the device into D3Cold which will more than
> +                * likely disable wake functionality.
> +                */
> +               wakeup = true;
>         }
>
>         /*
> --
