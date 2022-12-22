Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2733654553
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiLVQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiLVQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:43:45 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7731DC1;
        Thu, 22 Dec 2022 08:43:44 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id pj1so1175320qkn.3;
        Thu, 22 Dec 2022 08:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOgv50Lz+cfOVYt9nrtszbtiIPC0v7LKmXcP49AbpJM=;
        b=5mEQHBwYwvJmGXCfyncS1ZHPuCU17tqZxEx0M34NKc/U0AIraoGv9Ashq+vkuke4k9
         /E1pIxPMSP88H36TqhCg+SD7GqCMOJHeRie4feVlGfjk9jabO/NSWEGUBcgud3rghiHK
         0zeE84MrNmijX2daJGN/JE5d9wknZlQpwo9qUh9+APkeq6EsDFm5Jrmw1jVy9k2N6pVQ
         7KOWNnxD9IKaEkW+L+mWdvrxcgt31xELMnUfEag62GVW+Qt570e1UCjsBd5IxKJwSj9g
         ndl8E/wzthXCeXNP7g/aKoeb9FVNGhPUZTBXRfJ/biVx6W4X4f3UGOUofqfatESdfi5O
         mOSA==
X-Gm-Message-State: AFqh2krXz0mBu0jRD+Qf0904Bh67dF9MS8TY1zDhKm9gTbmJUK4zYmNu
        pGsp1tABV/zLURpx/lwN04M8gLthUgZT/53w3UY=
X-Google-Smtp-Source: AMrXdXvG4XZPErVQhTARsH/80vzfEInQwHenckBlF9u4IRAlZR9/5ShA0Y2tzKMW5ak3Pm/lzGmMD+r+/HScVRWRRo0=
X-Received: by 2002:a05:620a:50:b0:6fb:c38e:e5dd with SMTP id
 t16-20020a05620a005000b006fbc38ee5ddmr335441qkt.23.1671727423974; Thu, 22 Dec
 2022 08:43:43 -0800 (PST)
MIME-Version: 1.0
References: <ce1a70db-1b0b-ac9e-5829-8110b2ddbbd5@googlemail.com>
In-Reply-To: <ce1a70db-1b0b-ac9e-5829-8110b2ddbbd5@googlemail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:43:33 +0100
Message-ID: <CAJZ5v0imonunzhgYrjw+7pOm8j-YL6DWwZ387s-TeqtZ1BaYgQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: do IRQ override on XMG Core 15
To:     Erik Schumacher <ofenfisch@googlemail.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
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

On Sun, Dec 11, 2022 at 2:33 PM Erik Schumacher
<ofenfisch@googlemail.com> wrote:
>
> The Schenker XMG CORE 15 (M22) is Ryzen-6 based and needs IRQ overriding
> for the keyboard to work. Adding an entry for this laptop to the
> override_table makes the internal keyboard functional again.
>
> Signed-off-by: Erik Schumacher <ofenfisch@googlemail.com>
> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index f27914aed..037d1aa10 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -446,6 +446,17 @@ static const struct dmi_system_id lenovo_82ra[] = {
>         { }
>  };
>
> +static const struct dmi_system_id schenker_gm_rg[] = {
> +       {
> +               .ident = "XMG CORE 15 (M22)",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
> +               },
> +       },
> +       { }
> +};
> +
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
> @@ -460,6 +471,7 @@ static const struct irq_override_cmp override_table[] = {
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { lenovo_82ra, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>         { lenovo_82ra, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +       { schenker_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --

Applied as 6.2-rc material, thanks!
