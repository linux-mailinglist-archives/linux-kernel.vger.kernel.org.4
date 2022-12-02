Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A6640E88
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiLBTcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiLBTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:31:56 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3EEF37E8;
        Fri,  2 Dec 2022 11:31:54 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id x28so5494145qtv.13;
        Fri, 02 Dec 2022 11:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR1JEnfLJLcZzEsPrUCLpHxX68Jt2T5dkbON0C5T4m4=;
        b=sph33/PCxbDDPjY1bJLrii5KkcAJLM+4G8M68JQbMOl9FFFt5E5WwSiLpqLkSKG5X4
         7DTglgx+IhWv1P1YmqX3CGrXPp0OLIvH9g4xsuqTQWf0t5tzZgJ85Q8WBKcpsUMymckc
         94f8l2z9adgZi0X27Zrpu7IHuZfH83RWBgzkU+OfDwtjWVsPktkJmqDCtqGCaDMsbW7z
         CvY4TmoiTrp11VTXpSH4v7oRUrdKtnU9nqZJD8qIkpzePp3oIxibz0JM1IYS7cPS7Ueq
         3Cd8raDBJvnVYNxMkTpSFyYluTrnnQOWmCS7YRRqCHoKkbCkhlVdm5H75iPqlDHpbNOC
         2h8w==
X-Gm-Message-State: ANoB5plKb7ViTMM1lo35ZLNTN7EXAvKNRyttfPd3ytFSCYffibj+36Ez
        DwX2CVz3fUSCpjSk8x05MSxL4kfC0fDxeK8YYaQ=
X-Google-Smtp-Source: AA0mqf7ZJtrfZdsToQVfdr2i579/xMmNC+JjxqSDATB1boQzliRr3/5+RJ93Evjm5F8moJid2bSqBybj0NPMFu3zxWo=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr67087753qtb.147.1670009514139; Fri, 02
 Dec 2022 11:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20221130184101.357899-1-W_Armin@gmx.de>
In-Reply-To: <20221130184101.357899-1-W_Armin@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:31:43 +0100
Message-ID: <CAJZ5v0gY5UrD9tmVUWQEKdCmGK+W-4XiZ_EgY9Dd7jEuY_zmww@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Call power_supply_changed() when adding hooks
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, hdegoede@redhat.com, lenb@kernel.org,
        markgross@kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 7:41 PM Armin Wolf <W_Armin@gmx.de> wrote:
>
> If a battery hook is added to a battery, userspace software
> is not informed that the available properties of the battery
> might have changed. This for example causes upower to react
> slowly if a new battery hook is added during runtime.
>
> Fix this by calling power_supply_changed() if a battery hook
> was successfully added/removed.
>
> Tested on a Dell Inspiron 3505.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 9482b0b6eadc..bf99053e5021 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -696,7 +696,8 @@ static void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
>         if (lock)
>                 mutex_lock(&hook_mutex);
>         list_for_each_entry(battery, &acpi_battery_list, list) {
> -               hook->remove_battery(battery->bat, hook);
> +               if (!hook->remove_battery(battery->bat, hook))
> +                       power_supply_changed(battery->bat);
>         }
>         list_del(&hook->list);
>         if (lock)
> @@ -735,6 +736,8 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>                         __battery_hook_unregister(hook, 0);
>                         goto end;
>                 }
> +
> +               power_supply_changed(battery->bat);
>         }
>         pr_info("new extension: %s\n", hook->name);
>  end:
> --

Applied as 6.2 material, but I had to rebase it, so please check the
result in my bleeding-edge branch.

Thanks!
