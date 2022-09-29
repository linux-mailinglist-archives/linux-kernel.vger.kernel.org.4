Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95915EFD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiI2THN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiI2THJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:07:09 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDF914DAD0;
        Thu, 29 Sep 2022 12:07:08 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id c11so1378123qtw.8;
        Thu, 29 Sep 2022 12:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/e4BN6wCiFfjQq1fb+urfl5niKh5OtFO/d3wsAnUbtU=;
        b=zWnOPQvvRpMvWMn0D/sw5LUl3JPKhfw1TyEP4hiuqaje/RhohgUu/Q44D8SJuMQXJ7
         X0rdEFhiTXtTd/xrK4UqQWBu4H40MaGh66fRpE5bOlDnQa3IolC8i+Mpm+50hBP/H3Ls
         on1cUtK/KLJoO5mfyEebeFC3E4iod6T/Y4UDJRs3wF42aU9VdLbeId8UYmu+CSqpLyam
         sD8bbD8ZZcigDhrHzW6nso+4xdvmcBxx16vJlCmZop7vneaY57JsRJ1a97hZKYdbCNe/
         kGOI5XuoPfMGkhWJ8adzfcvNzev0CC8pj5RW6rwh0Z1K0St0CePDmfch92Qe7hD7v3Ig
         3PUQ==
X-Gm-Message-State: ACrzQf0xU4C1ZtiuLZajmEBCCSKAp8N/uDqfc6sGGqCSaLzP7r0wC2u7
        EgU7QqV6HKaI8MzsX8rHvSUe3ClVVff4Mlm5C3k=
X-Google-Smtp-Source: AMsMyM7SWRiJu4fwFCzxYZvchqkbXcYT6R1hZ7xU9OCAzc1yovGJAYl3+iJMAUHVCSCSsqTzX1uEVwquv9bBsmTimAA=
X-Received: by 2002:a05:622a:64e:b0:35d:5213:284f with SMTP id
 a14-20020a05622a064e00b0035d5213284fmr3737115qtb.49.1664478427856; Thu, 29
 Sep 2022 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org> <20220929093200.v6.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
In-Reply-To: <20220929093200.v6.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Sep 2022 21:06:56 +0200
Message-ID: <CAJZ5v0ho2vwoUDk_CFRi3ztA8mz3pWWY1OqwLK4NdXrHSbKjmw@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] ACPI: PM: Take wake IRQ into consideration when
 entering suspend-to-idle
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>, Len Brown <lenb@kernel.org>,
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

On Thu, Sep 29, 2022 at 6:19 PM Raul E Rangel <rrangel@chromium.org> wrote:
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
> Changes in v6:
> - Refactored to leave else clause
>
> Changes in v5:
> - Go back to using adev->wakeup.flags.valid to keep the diff cleaner
> - Fix a typo in comment
>
>  drivers/acpi/device_pm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 9dce1245689ca25..b657998ce728e4c 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -681,7 +681,22 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>                 d_min = ret;
>                 wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
>                         && adev->wakeup.sleep_state >= target_state;
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
>         } else {
> +               /* ACPI GPE is specified in _PRW. */
>                 wakeup = adev->wakeup.flags.valid;
>         }
>
> --

I can apply this one readily if that helps.

It doesn't depend on anything else in the series AFAICS.

It looks like patch [01/13] could also be applied right away, but
probably it is not for the ACPI tree.

I have a small comment to patch [06/13], and after that is addressed
it could be applied right away too I suppose, but the rest of the
patches need ACKs from the respective maintainers.
