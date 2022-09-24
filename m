Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB365E8E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiIXQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIXQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:19:14 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF0915E0;
        Sat, 24 Sep 2022 09:19:13 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id j10so1807330qtv.4;
        Sat, 24 Sep 2022 09:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=m/gPwTdrDhmWr+OoOgJB5rsgFJFWrrtfhqWn1O+Rq5Q=;
        b=So27BhsGxD1YZUpPwT3FyzcRtiE1k6o9kdNGVwi6iI5/dw/0ZTilXpIOFLrJwXpMqw
         +FneCI3wXXGFNOOGKfyVQXFL1KRAAF5jOQsQ3c6vFu7DZEtJyU3sbLBY6g3kUG+6Aotw
         aFHYd90Ghi5xt8Oez7sZMx9uQIWe68WP47SdO7xzfJH0dySLMM0J8tOHs9v1tXu8CZ73
         T9dYuzpENGMZM/yqRagVscM3zfhXhMxWBfzbsPwDYtMzhB7PBptf7FByLBo048QlQhhb
         ym8SVmO5HPAT1yMqHJq89n98O3ACIqa0pZFSDAHUBqGXMi3Ez1g11jaAVu4nElQw+S/K
         u9JA==
X-Gm-Message-State: ACrzQf1ncmb47HIjdrfeZ1eU6wcu+6k++tybb/CDz/xM9duzmzrawSHE
        75nx/bQML8EAEm6TsnHzN4eXDMcpOd6x+veCphgXLseD
X-Google-Smtp-Source: AMsMyM6pQKQTH8By7WFl/d3x994OKaVo1DXvhQBhuqjs8MpyZ5pV+IHpCI20wvhAJQt6W8gSGMRn01LI+LqZQfNFivo=
X-Received: by 2002:a05:622a:451:b0:35d:57:e1c9 with SMTP id
 o17-20020a05622a045100b0035d0057e1c9mr11747563qtx.49.1664036352635; Sat, 24
 Sep 2022 09:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220916043319.119716-1-kai.heng.feng@canonical.com> <20220916043319.119716-2-kai.heng.feng@canonical.com>
In-Reply-To: <20220916043319.119716-2-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:19:01 +0200
Message-ID: <CAJZ5v0gTEkZkyKkrjDZk0s+UVR9yPTtBJ_nzG40ZO9kgikFdqw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 6:33 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> PowerEdge r440 hangs at reboot.
>
> The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> system reboot to avoid triggering AER"), so use the new sysoff API to
> reinstate S5 for reboot on ACPI-based systems.
>
> Using S5 for reboot is default behavior under Windows, "A full shutdown
> (S5) occurs when a system restart is requested" [1].
>
> [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-state
>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4:
>  - Add comment and add more info to commit message.
> v3:
>  - Use new API to invoke ACPI S5.
> v2:
>  - Use do_kernel_power_off_prepare() instead.
>
>  drivers/acpi/sleep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index ad4b2987b3d6e..0b557c0d405ef 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -1088,6 +1088,14 @@ int __init acpi_sleep_init(void)
>                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
>                                          SYS_OFF_PRIO_FIRMWARE,
>                                          acpi_power_off, NULL);
> +
> +               /*
> +                * Windows uses S5 for reboot, so some BIOSes depend on it to
> +                * perform proper reboot.
> +                */
> +               register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
> +                                        SYS_OFF_PRIO_FIRMWARE,
> +                                        acpi_power_off_prepare, NULL);
>         } else {
>                 acpi_no_s5 = true;
>         }
> --

Applied as 6.1 material with some edits in the changelog, thanks!
