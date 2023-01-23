Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFD67809A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjAWPzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjAWPzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:55:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7FC30E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:55:16 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s3so9085594pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sbuQ2eAJkHwKWpK2Z21TvfvZZsWUOmsMIR9vvLknpYs=;
        b=WQmjabEAtB9BEkpn55XmcV9lxKiEMGiQ+erS4aRFrM/SvbEcUDMMvtLfa8JNjKhq/j
         pAu0hnQtQSxV77MQTroBJpAM9Y+91ykFFaiXqzt4CXi/ulQIQJzKiYdMxm+AeACmyUhj
         baNW0OfSe+Btw2l9eujUITCmMxR4YswB66UkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbuQ2eAJkHwKWpK2Z21TvfvZZsWUOmsMIR9vvLknpYs=;
        b=nRj1Uyrcvu+qdlV/72Y75NAirwMdiOkwWF4P9tSA0tUOvHsvGxejlCUB1Hb58DWu/B
         O6AGu+tSksORu4KJdD46WR/ZnCgSD1wzD9eBN3mNwoPr/S6TBe+1RcXn1g/0rYaSgmCP
         489B5RInziSF7EGYe0EMhXILOAn94Cc4budhUtqD8unlK3HEB8Kba8fOAIjsgG/x+lIh
         BNkVBtwWtiKhU7UIzVWKr2S511Zh02AodGAgVYD73aDT1pf/2UJMloTqtBJFzuvZDvzH
         Wcd+a4IsKAb8L4kb804wyiC7hr5S0Ya4Pi8YKirCPzRp5bcJ9+oqkZzlTBzY7YdLJpwU
         tdJQ==
X-Gm-Message-State: AFqh2kq41BUSwA8RlxOB9goOmoxpRq20dXqk8/oqAdygWs72sYxSm39A
        KW5uGdSlrgo0l0RkNGd4oVl+vpGkhDa8xTRT
X-Google-Smtp-Source: AMrXdXsYF8pnS1Oc+L6hPOadVYAGJNXB7Ax/UA1bbadINLSBVjkFUQxNHuo2V1NUKNhamb5yQAPGtw==
X-Received: by 2002:a62:830d:0:b0:58d:94f4:a8b9 with SMTP id h13-20020a62830d000000b0058d94f4a8b9mr28179365pfe.11.1674489316479;
        Mon, 23 Jan 2023 07:55:16 -0800 (PST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id k17-20020aa79731000000b0058d97b624f0sm15895176pfg.75.2023.01.23.07.55.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:55:16 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso7002613pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:55:16 -0800 (PST)
X-Received: by 2002:a17:90a:1:b0:225:cb85:673d with SMTP id
 1-20020a17090a000100b00225cb85673dmr2482344pja.184.1674489315288; Mon, 23 Jan
 2023 07:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com> <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
In-Reply-To: <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 23 Jan 2023 08:55:02 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
Message-ID: <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 8:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > adjusted the policy to enable wakeup by default if the ACPI tables
> > indicated that a device was wake capable.
> >
> > It was reported however that this broke suspend on at least two System76
> > systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
> > When the machines are set to s2idle, wakeup behaves properly.
> >
> > Configuring the GPIOs for wakeup with S3 doesn't work properly, so only
> > set it when the system supports low power idle.
> >
> > Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to set wake_irq")
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2162013
> > Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
> > Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
> > Suggested-by: Raul Rangel <rrangel@chromium.org>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpio/gpiolib-acpi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index 9ef0f5641b521..17c53f484280f 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
> >                                 dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
> >                         }
> >
> > -                       if (wake_capable)
> > +                       /* avoid suspend issues with GPIOs when systems are using S3 */
> > +                       if (wake_capable && acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> >                                 *wake_capable = info.wake_capable;
> >
> >                         return irq;
> > --
> > 2.34.1
> >
>
> Applied, thanks!
>
> Bart


We still need to figure out a proper fix for this. If you read my post
here: https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1732372
I think we misinterpreted what the SharedAndWake bit is used for. To
me it sounds like it's only valid for HW Reduced ACPI platforms, and
S0ix. My changes made it so we call `dev_pm_set_wake_irq` when the
Wake bit is set. Does anyone have any additional context on the Wake
bit? I think we either need to make `dev_pm_set_wake_irq` (or a
variant) only enable the wake on S0i3, or we can teach the ACPI
subsystem to manage arming the IRQ's wake bit. Kind of like we already
manage the GPE events for the device.
