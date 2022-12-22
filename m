Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F6654556
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLVQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiLVQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:44:27 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82D31DC4;
        Thu, 22 Dec 2022 08:44:27 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id c9so1170388qko.6;
        Thu, 22 Dec 2022 08:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzSv1M0mRMPSBdxi6t+CJYNzzqUMmEZSoWBDLVpDMUA=;
        b=OFve9IGXXQ4kutCAnCFSC8qOgPtJs8arzzrow45E/xS7ln+MD2lkkGlRb86zDfKqSC
         LwXxZAUlA3joWIBnjivTKV12zVkehQ4WNtkJLSpNv2D8jCSZ/k1/SirqbgfNOIwVIEUv
         6k/AMpJDnNH61yt8tw9LfNzrVy8L9xIf1bJrLhfYpez9ehtFN0CIA7Cp8SBD5SjL/pz0
         9Y/f2Gi3xaEQ8BFHcUIJj/5KU8Uv9HEGfIpMJidau9APX0pj9QDz0/a6mDzA5k1Kvjrk
         m9Fy4Fp5ijKelpDDHzUDZYJfZstKw0EWIxj+P2qWYCnw4Ky/jKCHUpWtCK1LIpA/nf5V
         W0BA==
X-Gm-Message-State: AFqh2kqXJB7hKlOyggpqjxgGJnFmCoXhRjggKNbWnM7RrppdYOkq+P87
        TPh59x6LT39DVv37p14nkFH4h3gE7VOAMNPmoEE=
X-Google-Smtp-Source: AMrXdXtjUH2bDS2lmacu96R7UH47UXC/phek0C+g3OrnDB3xI49gZlnh+H3uIne1VZthpcEguXr/rb6GcSLIIpoM/yM=
X-Received: by 2002:a05:620a:755:b0:6ec:fa04:d97c with SMTP id
 i21-20020a05620a075500b006ecfa04d97cmr306409qki.764.1671727466464; Thu, 22
 Dec 2022 08:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20221213201311.10022-1-adrian@freund.io>
In-Reply-To: <20221213201311.10022-1-adrian@freund.io>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:44:15 +0100
Message-ID: <CAJZ5v0hqfhTWjkMF+3iDL2BR=_nXVqfCK-CDMQrjoPqEhHyhEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: do IRQ override on Lenovo 14ALC7
To:     Adrian Freund <adrian@freund.io>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Tue, Dec 13, 2022 at 9:13 PM Adrian Freund <adrian@freund.io> wrote:
>
> Commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> added an override for Lenovo IdeaPad 5 16ALC7. The 14ALC7 variant also
> suffers from a broken touchscreen and trackpad.
>
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216804
> Signed-off-by: Adrian Freund <adrian@freund.io>
> ---
>  drivers/acpi/resource.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index f27914aedbd5..819390665da1 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -435,7 +435,14 @@ static const struct dmi_system_id asus_laptop[] = {
>         { }
>  };
>
> -static const struct dmi_system_id lenovo_82ra[] = {
> +static const struct dmi_system_id lenovo_laptop[] = {
> +       {
> +               .ident = "LENOVO IdeaPad Flex 5 14ALC7",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> +               },
> +       },
>         {
>                 .ident = "LENOVO IdeaPad Flex 5 16ALC7",
>                 .matches = {
> @@ -458,8 +465,8 @@ struct irq_override_cmp {
>  static const struct irq_override_cmp override_table[] = {
>         { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -       { lenovo_82ra, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -       { lenovo_82ra, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +       { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +       { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --

Applied as 6.2-rc material, thanks!
