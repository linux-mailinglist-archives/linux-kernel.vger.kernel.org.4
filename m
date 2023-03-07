Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC16AE021
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCGNQD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 08:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCGNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:15:31 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC8182377;
        Tue,  7 Mar 2023 05:14:11 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id k10so28140041edk.13;
        Tue, 07 Mar 2023 05:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0kTh8GpSOrCD/QzZe6o1QalI7Guavzm9BMKg6WwDYY=;
        b=4Z8UQlOxQwJqhcA234Yfy0K9yeDa92gG1FWc6V8pNL8Ovava/pC8+uFtNjW4h8HTli
         Bhe4NA4doWdubf5eBzadrjP5+u83oRiQk9YV5oCy28lWPMK17wkK3QFcMZe6CR6GhlNJ
         8gCtQwGUKBdfcjKvf6nTe+a1/LuO8at8fbBUTL82jHonqG1SlLjn5Erb0rxljlMk99my
         DYCgWz/L2+ZUFoGwgfOxVZR+yFX/iVAHhrq4L59i0RfXFLjeeUutJiNIQI8J1ncxbSuW
         2s2+scYAsbTqt7TD6iZJ++yjcwqrbJku4FkzF16XwsQLMEjEXo9iT5fuKvWJgbt6G5Rp
         qVnw==
X-Gm-Message-State: AO0yUKWx0FRmLu3G/o/YSMr1wr/DA1tJ27zVGQii/CCa+neb+r7sDJdW
        F8GZS2YFfMYt/Z4GFI8TCWwNaCYSWp6IkWIv43c=
X-Google-Smtp-Source: AK7set+kfev+dzm2OeyflBAhH2bGsUKOJ4c9bABWt1mkXcoP4YWDWU9/CVezyRCraVM7zYHauTj3v57NpuUF6YV+vRw=
X-Received: by 2002:a17:906:a05a:b0:8b2:23fb:dfd1 with SMTP id
 bg26-20020a170906a05a00b008b223fbdfd1mr7236633ejb.2.1678194830511; Tue, 07
 Mar 2023 05:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20230302093300.62098-1-acelan.kao@canonical.com>
In-Reply-To: <20230302093300.62098-1-acelan.kao@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 14:13:39 +0100
Message-ID: <CAJZ5v0gDne=4SdMRzZw-r7jZ4rftXQ4XpVHVBytmJLotPy+azA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell
 Vostro 15 3535
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 10:33 AM AceLan Kao <acelan.kao@canonical.com> wrote:
>
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>
> Sometimes the system boots up with a acpi_video0 backlight interface
> which doesn't work. So add Dell Vostro 15 3535 into the
> video_detect_dmi_table to set it to native explicitly.
>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/acpi/video_detect.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 710ac640267d..14d6d81e536f 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -716,6 +716,13 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
>                 },
>         },
> +       {
> +        .callback = video_detect_force_native,
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
> +               },
> +       },
>
>         /*
>          * Desktops which falsely report a backlight and which our heuristics
> --

Applied as 6.3-rc material, thanks!
