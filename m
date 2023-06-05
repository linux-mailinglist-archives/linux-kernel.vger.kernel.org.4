Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77888722D97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFERY0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFERYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:24:23 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53118F;
        Mon,  5 Jun 2023 10:24:22 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso110068366b.0;
        Mon, 05 Jun 2023 10:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985861; x=1688577861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZX4YXUI4QUBjByQbWnWWQdoVhxwyG+GkAtY1iSLqRQ=;
        b=J4a/GbLhYKx2xKspCiPpiK7iW2kSoZqBX7wkhjlgkRWiccGMHTocAgvthfNOI4kgXg
         jlwBdWsYiToRhb1TpNTeq6oNRRCnWP9ZrjCi0riY85noyPQHe2r1W1M8UEsGvluNtq2n
         G8QZ6QErSefoErw/u1EcfrskV0pI64yWvGOl36TIQXbLodEppQSfIq5wvxDZN3QsnZZl
         cHflnAwnCf0yeL5PGt/811wFWfdA8o59jbY/9hzHor9L8/Irja19D6rwWX9iU/X7i8p7
         N+TVtjfKd34K4UdecwHwaQVbZpSIlQuvlyfvkwF+iaGN1KzZL47f43NrpPkcLwXsNJxh
         P9hw==
X-Gm-Message-State: AC+VfDy8lVodnSl28nyqooHTzkdd9UiQUpDTFw+3nMK+XU96w/B0MIS+
        YiOo+kH24vOhK9ciniCvAy2CSv8DoHxNsa05cLU=
X-Google-Smtp-Source: ACHHUZ4Mf76qX3IRznSCdoHjEa7PMoevNhJaoIjOTt73B2ax8a3Vz034qKKGO+TCjlySoVjI9l56lhy1h6tSggPnJJU=
X-Received: by 2002:a17:906:2cf:b0:976:7c67:4bf8 with SMTP id
 15-20020a17090602cf00b009767c674bf8mr6643728ejk.5.1685985861163; Mon, 05 Jun
 2023 10:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230601233953.1332-1-mario.limonciello@amd.com>
In-Reply-To: <20230601233953.1332-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 19:24:09 +0200
Message-ID: <CAJZ5v0i6kJtPkDjP1_+Vbp06q729P_TDvZrj8hFcLyDxwAehpA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Fri, Jun 2, 2023 at 1:40 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> In Windows the Microsoft _DSM doesn't call functions 3->5->7 for suspend
> and 8->6->4 for resume like Linux currently does.
>
> Rather it calls 3->7->5 for suspend and 6->8->4 for resume.
> Align this calling order for Linux as well.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index e499c60c4579..7214197c15a0 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -485,11 +485,11 @@ int acpi_s2idle_prepare_late(void)
>                                         ACPI_LPS0_ENTRY,
>                                         lps0_dsm_func_mask, lps0_dsm_guid);
>         if (lps0_dsm_func_mask_microsoft > 0) {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>                 /* modern standby entry */
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>         }
>
>         list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> @@ -524,11 +524,6 @@ void acpi_s2idle_restore_early(void)
>                 if (handler->restore)
>                         handler->restore();
>
> -       /* Modern standby exit */
> -       if (lps0_dsm_func_mask_microsoft > 0)
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -
>         /* LPS0 exit */
>         if (lps0_dsm_func_mask > 0)
>                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> @@ -539,6 +534,11 @@ void acpi_s2idle_restore_early(void)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>
> +       /* Modern standby exit */
> +       if (lps0_dsm_func_mask_microsoft > 0)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +
>         /* Screen on */
>         if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> --

Applied as 6.5 material, thanks!
