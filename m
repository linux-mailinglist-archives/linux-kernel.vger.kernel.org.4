Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E9677E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjAWPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAWPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:03:14 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33D27D55
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:03:11 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id i185so13163327vsc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vdEP1orVhR0RezSlr+Bk5SknaVZLercEc+OaPdFHTB0=;
        b=UkrdsVI9+Jmy6yBulcAjFXOa5KDLNt/K+pp4xMPlyl5pSnX4DoDs1z82Meacrkv1pE
         AT4wL/LSLxoKdBmTZF1FqwsffWcr8EewFmsU1pTtmwBBHF7yHH8TohJ9+6nJmyirc35j
         49pOFcFtURN9yj/jwldEWNC1ztl62Pr7F5QV+JQ+omBLu/sxlOmPV+USO5KUQzL9nVNG
         XZErEluGyIRGLpRedCyQ03HA+9WignWPryAcjLu4ML5ZjjTnu3xERVz83LMqb2lgz+kM
         qgLWpEDmWpBb53fn7689wUfDrYAkXgsJoZaLiTD/YrnJbn+4PZ56X3TICuZxkggIaau2
         KeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdEP1orVhR0RezSlr+Bk5SknaVZLercEc+OaPdFHTB0=;
        b=yJ1BGFJB10tf37T4dfsRrglAVsK8l2P1n6yc/TaTkEaCzsQZ1O3YxlOdC12ftE4/2/
         XD4XVOpHQJ2pG2ozz2bUT8VKkDxe1A64eUA6QIfQu4ZtQ9hMCJciALm9WmYJsV6Py6z3
         Q1M60XsILYDBMRc4IUVV0yKLgyLFINu/4qGjfpV90A78e8V+hYsDdzaZjuo/skkCSgTR
         sNApAhLPksrRxS2q/OmV1yDTtyOlM8eESQQmQaBbJxGRt7FuHIfrccKEHn+vfo3A9zVa
         yGSCihemt/0S//r0t53v5sd6D+dB/sXzuSlbjnPL6hwAykxDEqo/+p3rInaNK0tsL5nK
         mjww==
X-Gm-Message-State: AFqh2kp8UvHZEGoDNhhrZmz2XK0sN5aDJHJs9a7T+RgU+bCyB7/ZADIZ
        aoaPLHB2aNMFWiaC4zNq3SzLXd1+KUKzgvc8WkY/Ig==
X-Google-Smtp-Source: AMrXdXtwrxv8GFdwtYOtaBTUCUyCHU2NPO8kUqVB15LrUE9fQKrc2O3kqc84mU9/kRL6M3zEdf5Ohtuo880V42lOx/I=
X-Received: by 2002:a05:6102:3e08:b0:3c5:1ac1:bf38 with SMTP id
 j8-20020a0561023e0800b003c51ac1bf38mr3656737vsv.78.1674486190097; Mon, 23 Jan
 2023 07:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20230121134812.16637-1-mario.limonciello@amd.com> <20230121134812.16637-3-mario.limonciello@amd.com>
In-Reply-To: <20230121134812.16637-3-mario.limonciello@amd.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Jan 2023 16:02:59 +0100
Message-ID: <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> adjusted the policy to enable wakeup by default if the ACPI tables
> indicated that a device was wake capable.
>
> It was reported however that this broke suspend on at least two System76
> systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
> When the machines are set to s2idle, wakeup behaves properly.
>
> Configuring the GPIOs for wakeup with S3 doesn't work properly, so only
> set it when the system supports low power idle.
>
> Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to set wake_irq")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2162013
> Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
> Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
> Suggested-by: Raul Rangel <rrangel@chromium.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 9ef0f5641b521..17c53f484280f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
>                                 dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
>                         }
>
> -                       if (wake_capable)
> +                       /* avoid suspend issues with GPIOs when systems are using S3 */
> +                       if (wake_capable && acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>                                 *wake_capable = info.wake_capable;
>
>                         return irq;
> --
> 2.34.1
>

Applied, thanks!

Bart
