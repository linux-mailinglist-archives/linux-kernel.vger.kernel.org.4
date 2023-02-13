Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8E694F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjBMSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjBMSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:33:03 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8413DE1;
        Mon, 13 Feb 2023 10:33:01 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id d40so12965869eda.8;
        Mon, 13 Feb 2023 10:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCOwZ3PJTz/TYlI3e/xWEaAlHZ5jKi/xOzNSjCqqJlA=;
        b=XQGymBWg1yqfCdD2veGZJcLrcmw+wmQBh6H6zyBfjN3jyK3mwqLXOI7IUdeyhx0z6X
         l7jUGJU6r3k0vTgAmyu3oUnYgYy67cxiJ+Kd//gN8GbWGA6tiSYbsZ4sGlFC8FD0O17g
         Sn0B7H43vCtcZry/zRjGVPgrZr2/rf9vlinKto4+PvEQxzjMxm6axj2VlVNhfuoPgwPM
         6xdwoN4UYOBhNHTVP+4djcwTQ9ojjjbgrJIuIy2FUC7tbtBOt1cGkJFiirX8G7fibpHG
         fixLJBaXr+N1/VE81LlMEtgZZ6024O5VOmi8uQ5cdYKdUloNypTkY3iXpmHWL2f2UCri
         68VA==
X-Gm-Message-State: AO0yUKVKXRbeUiTmIntc3eUOk9OD0vJOuyT+uo9U9TGIUoFijSYb+fmK
        fKe1LtuvcXqtDwyexsMM4O1A6CgIlfSyHelWlp4=
X-Google-Smtp-Source: AK7set8dcv494iw1o904AMOIdM6+FAb/VU8nA9TV06pLrweb1zuOx3xcHp6RTxeaYGL98ibjI9b9XlTWcWvt7FBRpKU=
X-Received: by 2002:a50:d6c1:0:b0:4ac:c297:5520 with SMTP id
 l1-20020a50d6c1000000b004acc2975520mr2370636edj.6.1676313180405; Mon, 13 Feb
 2023 10:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20230213181653.587327-1-wse@tuxedocomputers.com>
In-Reply-To: <20230213181653.587327-1-wse@tuxedocomputers.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:32:49 +0100
Message-ID: <CAJZ5v0iM83dDX+92LKTcUvKo9rUaSf_av5WV4ri=Q8QHd1gkQw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on all TongFang GMxRGxx
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Feb 13, 2023 at 7:17 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> Apply
> commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> override for all vendors using this mainboard.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/acpi/resource.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 16dcd31d124fe..176e1f6684dc6 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -460,11 +460,10 @@ static const struct dmi_system_id lenovo_laptop[] = {
>         { }
>  };
>
> -static const struct dmi_system_id schenker_gm_rg[] = {
> +static const struct dmi_system_id tongfang_gm_rg[] = {
>         {
> -               .ident = "XMG CORE 15 (M22)",
> +               .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>                 .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>                 },
>         },
> @@ -485,7 +484,7 @@ static const struct irq_override_cmp override_table[] = {
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>         { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -       { schenker_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --

Applied as 6.3 material, thanks!
