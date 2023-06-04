Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA3721868
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFDQEl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Jun 2023 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjFDQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:04:40 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2861DB;
        Sun,  4 Jun 2023 09:04:38 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94ea38c90ccso72840466b.1;
        Sun, 04 Jun 2023 09:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685894677; x=1688486677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+YdCv4qFRXvRPwOlYPYCldTcv+zkomgPih9OT+HI0Q=;
        b=JTxiD9YjEMeZsF2zB30w3UkShOmbnulZnlg5ozfuKDnuKzI8IC28DSKhO0hb++C6ss
         u/WNfW0WGgNbtEooZYgf7IrCopEJYOaSJzd3bQ67pH6Q+N4fjAgOT8fyb/8vpf9f+ldO
         awr2/AIZpiQFTkzXl3x696fB0YOz+CuhDl0H01irAYJI5tpa8cvBk4i403JqWkcPEpCW
         DybBRM32RCvsZpYgUDmkOeTsUu+aXDfbOaC8Ks5yvUxQNbexRc/x4e24Rb/uvRJ/v58Z
         6e8raM6LoFcOgBdJ9v282hKjn8NeZRKRkR4T8inO2p6Ru+WdQzmsr7e9Q4pEaHhzMgBc
         c9Kw==
X-Gm-Message-State: AC+VfDzrFefl4tflSrn29Rf8Iw/Uffu6ulC+pQ8DBUGP+5EaSACkSXX+
        nEC8C9ZKsUF1d9EIxzhDbngi3pSuE0qFsvuYx08=
X-Google-Smtp-Source: ACHHUZ54m+MFnHpOVzLiL4+gc3bnx2pXxkOS3iIdfMsHrkg4Cqnn+VVTZxb7UNWMN3kJHLXsnkA5+CIFhyzBn9ykFVI=
X-Received: by 2002:a17:906:6494:b0:965:9c7d:df96 with SMTP id
 e20-20020a170906649400b009659c7ddf96mr12977658ejm.1.1685894677361; Sun, 04
 Jun 2023 09:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073025.22884-1-mario.limonciello@amd.com> <20230602073025.22884-2-mario.limonciello@amd.com>
In-Reply-To: <20230602073025.22884-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 18:04:26 +0200
Message-ID: <CAJZ5v0jNn1wHtF7c0XYKpM=XzZasdu3OwksUdqRFO3TyZwrPOg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM
 state tracking
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael Wysocki <rafael@kernel.org>, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com
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

On Fri, Jun 2, 2023 at 9:32 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Enabling debugging messages for the state requires turning on dynamic
> debugging for the file. To make it more accessible, use
> `pm_debug_messages` and clearer strings for what is happening.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'm inclined to apply this one and the [1/4] at this point.

I can also apply the 2 remaining patches in this series if I get ACKs
for them from the respective subsystem maintainers.

> ---
>  drivers/acpi/x86/s2idle.c | 52 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index e499c60c4579..7681f6ecab67 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -59,6 +59,7 @@ static int lps0_dsm_func_mask;
>
>  static guid_t lps0_dsm_guid_microsoft;
>  static int lps0_dsm_func_mask_microsoft;
> +static int lps0_dsm_state;
>
>  /* Device constraint entry structure */
>  struct lpi_device_info {
> @@ -320,6 +321,44 @@ static void lpi_check_constraints(void)
>         }
>  }
>
> +static bool acpi_s2idle_vendor_amd(void)
> +{
> +       return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
> +}
> +
> +static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
> +{
> +       if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
> +               switch (state) {
> +               case ACPI_LPS0_SCREEN_OFF:
> +                       return "screen off";
> +               case ACPI_LPS0_SCREEN_ON:
> +                       return "screen on";
> +               case ACPI_LPS0_ENTRY:
> +                       return "lps0 entry";
> +               case ACPI_LPS0_EXIT:
> +                       return "lps0 exit";
> +               case ACPI_LPS0_MS_ENTRY:
> +                       return "lps0 ms entry";
> +               case ACPI_LPS0_MS_EXIT:
> +                       return "lps0 ms exit";
> +               }
> +       } else {
> +               switch (state) {
> +               case ACPI_LPS0_SCREEN_ON_AMD:
> +                       return "screen on";
> +               case ACPI_LPS0_SCREEN_OFF_AMD:
> +                       return "screen off";
> +               case ACPI_LPS0_ENTRY_AMD:
> +                       return "lps0 entry";
> +               case ACPI_LPS0_EXIT_AMD:
> +                       return "lps0 exit";
> +               }
> +       }
> +
> +       return "unknown";
> +}
> +
>  static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
>  {
>         union acpi_object *out_obj;
> @@ -331,14 +370,15 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
>                                         rev_id, func, NULL);
>         ACPI_FREE(out_obj);
>
> -       acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> -                         func, out_obj ? "successful" : "failed");
> +       lps0_dsm_state = func;
> +       if (pm_debug_messages_on) {
> +               acpi_handle_info(lps0_device_handle,
> +                               "%s transitioned to state %s\n",
> +                                out_obj ? "Successfully" : "Failed to",
> +                                acpi_sleep_dsm_state_to_str(lps0_dsm_state));
> +       }
>  }
>
> -static bool acpi_s2idle_vendor_amd(void)
> -{
> -       return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
> -}
>
>  static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
>  {
> --
> 2.34.1
>
