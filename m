Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C06A6066
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjB1UbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1UbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:31:17 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589632E61;
        Tue, 28 Feb 2023 12:31:16 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id i34so45187077eda.7;
        Tue, 28 Feb 2023 12:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677616275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkKHLm84xA9OfJ0fe4uBQT0llbNEG486m7fc4TEK1cU=;
        b=hfW+RNiIBH/L50kWQfnvtvFjWx8rufyoliWIx7U7poAG7HnmI0ul1Mwj+xLGnl9dO2
         gM1tZhUmwFXUweDFj6r4b4e05AffTNOH+kogOObaniLR2cenw8DYdW6yUaRFXCGwNVwV
         vP17kGheGDw0GDleSvcI9dqmnzoy8KmEIaPkm6C54PNX3FZdqvPxrbpPdHEZy0ABNwcw
         7fKfD9qsUINDfXk2ymyqPcswtiw7lY5vXpm1M9eQLKOgy9KGMfXw2BV4AvL7XtRxaTWq
         v2a4Zmju5n606IKXcNqdIqWWoB9GIlEA4OUcrvgwvQSLUREkSQtTBHf8ccut0Mysabqh
         J5MQ==
X-Gm-Message-State: AO0yUKXLxWiaKAy5Qz0XLBPSgTVzZKcM2rdt2FnhUZ/Phf0T6g5J/2Qa
        FgapCnNDch/jQFPnjHKY/KgJuKlncIqdbqGPjQQ=
X-Google-Smtp-Source: AK7set/nQHwyFKdx6Zs6LmJxOCOcl5ShielM6Po/FS5rHEmqstafd1qK30+kJ46joRvZHHsO1X6KZjF+ZLo48SN8uR4=
X-Received: by 2002:a50:cc93:0:b0:4ad:7482:cd3b with SMTP id
 q19-20020a50cc93000000b004ad7482cd3bmr2500271edi.6.1677616275163; Tue, 28 Feb
 2023 12:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20230223202622.9023-1-mario.limonciello@amd.com> <20230223202622.9023-2-mario.limonciello@amd.com>
In-Reply-To: <20230223202622.9023-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Feb 2023 21:31:04 +0100
Message-ID: <CAJZ5v0j0oWmu1X8HND1xfisdkAey89huM+CtLuPYuA3svD3Tew@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: x86: Drop quirk for HP Elitebook
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        anson.tsao@amd.com, Kalle Valo <kvalo@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
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

On Thu, Feb 23, 2023 at 9:26 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> There was a quirk in `acpi/x86/s2idle.c` for an HP Elitebook G9
> platforms to force AMD GUID codepath instead of Microsoft codepath.
>
> This was due to a bug with WCN6855 WLAN firmware interaction with
> the system.
>
> This bug is fixed by WCN6855 firmware:
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Remove the quirk as it's no longer necessary with this firmware.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=c7a57ef688f7d99d8338a5d8edddc8836ff0e6de
> Tested-by: Anson Tsao <anson.tsao@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index c7afce465a07..e499c60c4579 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -384,29 +384,6 @@ static const struct acpi_device_id amd_hid_ids[] = {
>         {}
>  };
>
> -static int lps0_prefer_amd(const struct dmi_system_id *id)
> -{
> -       pr_debug("Using AMD GUID w/ _REV 2.\n");
> -       rev_id = 2;
> -       return 0;
> -}
> -static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
> -       {
> -               /*
> -                * AMD Rembrandt based HP EliteBook 835/845/865 G9
> -                * Contains specialized AML in AMD/_REV 2 path to avoid
> -                * triggering a bug in Qualcomm WLAN firmware. This may be
> -                * removed in the future if that firmware is fixed.
> -                */
> -               .callback = lps0_prefer_amd,
> -               .matches = {
> -                       DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "8990"),
> -               },
> -       },
> -       {}
> -};
> -
>  static int lps0_device_attach(struct acpi_device *adev,
>                               const struct acpi_device_id *not_used)
>  {
> @@ -586,7 +563,6 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>
>  void __init acpi_s2idle_setup(void)
>  {
> -       dmi_check_system(s2idle_dmi_table);
>         acpi_scan_add_handler(&lps0_handler);
>         s2idle_set_ops(&acpi_s2idle_ops_lps0);
>  }
> --

Applied as 6.3-rc material, thanks!
