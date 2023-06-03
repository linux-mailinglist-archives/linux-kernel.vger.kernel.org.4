Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C5720F0C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 11:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFCJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFCJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:54:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126D197;
        Sat,  3 Jun 2023 02:54:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76c64da0e46so91065139f.0;
        Sat, 03 Jun 2023 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685786052; x=1688378052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9xipDnELMe57gSqssIZi9FLmAA8jeVRZYMJPoPrxg4=;
        b=kkYOW1SzfgoWqKPdEgMSbmivVcpNOeio6G3ZuKksI5gE1blkS4pYhZX/4hmQPUNYCH
         QN8lITQ2kg/p5zud5rz0le8IOGz0EFh1IgL4iCaS+geQYF0BiEgUEefRvo9TUnbrodOU
         YxrKzjMx1/j5uC6WJfMo27KkpXH/jASq5UE0SffRauwtZcpJZcye9QuTmSZ9I8wZlIjK
         xg5v/DIHhuNBlbbuXI/WawHP8cr8yNELHvBM+xhrBjA9aTaWccgQWiKbniMxDHfiUVE4
         WIB/K733nIiI/lbjejVW06Ym7o+jiBW1i6KcYXlC5AY3QVV4TVSBCy3wN5cLoo2WdRWh
         EUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685786052; x=1688378052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9xipDnELMe57gSqssIZi9FLmAA8jeVRZYMJPoPrxg4=;
        b=WwdxIN2LZprqPDMK4/iz0W7oSO/pV4uSRRuSmhxOiOj2G6PTj0bYR7EvILbMyMjZtX
         nYf8O1gO9uSByaw4AOz45we2bzBvSY5YdQ/K27ZeA/GUgUCRwLmOHXtOMAh7AnXxlpBZ
         KgKY8YNRy03d7d6EkL36VUK0S53SdqiAkoM7Ff/Fo8hSNlTyRqneyL7iDZedylPMItxC
         DSw0uQW+yAS2EyJqiLqNOVRSnoA+i5jn4NsJGWVGsxmElY2TTBwcJgM29oKZtbligTEg
         Y/QGBhgfDUszUrN0pwBQSYpMon8iDojSPPm6LSsQ8xqbqL7GcJq+qd2ueF+3uyqpq16F
         Z2kQ==
X-Gm-Message-State: AC+VfDzQGKnHQD4rkJ1p4gftu10ASjuU5+LWstcV1MLGxh71UdlYIGAN
        5Tp82EixaDKv28okoKQcCfHAZG0U5EAzYaOnxtMg6C2g7xYlqQ==
X-Google-Smtp-Source: ACHHUZ5K1M1p621p0RZX4zAG24hSSGTbnRZFwB57yPelWOhodJUFzHVBb66cXKC7xkj2wubkpK2akuthLugiannw56E=
X-Received: by 2002:a92:280a:0:b0:33d:6536:46e1 with SMTP id
 l10-20020a92280a000000b0033d653646e1mr3261440ilf.23.1685786051898; Sat, 03
 Jun 2023 02:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230601221151.670-1-mario.limonciello@amd.com>
In-Reply-To: <20230601221151.670-1-mario.limonciello@amd.com>
From:   Nathan Schulte <nmschulte@gmail.com>
Date:   Sat, 3 Jun 2023 04:54:00 -0500
Message-ID: <CAO78Khpii4RxTdEdy22bzGzAwLYje3XnJWXfdHiLud9c1TuzgQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: resource: Remove "Zen" specific match and quirks
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, ofenfisch@googlemail.com,
        wse@tuxedocomputers.com, adam.niederer@gmail.com, adrian@freund.io,
        jirislaby@kernel.org, Renjith.Pananchikkal@amd.com,
        anson.tsao@amd.com, Richard.Gong@amd.com,
        Chuanhong Guo <gch981213@gmail.com>, evilsnoo@proton.me,
        ruinairas1992@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to work as well for the ASUS TUF Gaming A16 Advantage
Edition FA617XT; both Linux 6.3 and 6.4.  Disabling the ITE5570 EC
[I/O] is required for a "truly" functional experience, of course.

On Thu, Jun 1, 2023 at 5:12=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
>
> This turned out to be a bad assumption because several vendors
> add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
>
> Furthermore some vendors have used ActiveHigh for IRQ1.
> To solve this problem revert the following commits:
> * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7"=
)
> * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad=
")
> * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
> platforms")
>
> Cc: ofenfisch@googlemail.com
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Cc: Renjith.Pananchikkal@amd.com
> Cc: anson.tsao@amd.com
> Cc: Richard.Gong@amd.com
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217406
> Reported-by: nmschulte@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217336
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Adjust to drop heuristics entirely
>  * Drop tested tags
>  * Add more links and people to Cc
>  * Drop Fixes tag as this got a lot more risky
> v1->v2:
>  * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG=
 UltraPC 17U70P")
>  * Pick up tag
>
> Rafael,
> Please hold off on picking this up until the majority of those on CC
> have tested it on hardware they have and reported results.
>
> Everyone else,
> Please test. If you have problems with this applied, please share
> an acpidump and dmesg either on a bug or to me privately.
> ---
>  drivers/acpi/resource.c | 60 -----------------------------------------
>  1 file changed, 60 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 0800a9d77558..1dd8d5aebf67 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,52 +470,6 @@ static const struct dmi_system_id asus_laptop[] =3D =
{
>         { }
>  };
>
> -static const struct dmi_system_id lenovo_laptop[] =3D {
> -       {
> -               .ident =3D "LENOVO IdeaPad Flex 5 14ALC7",
> -               .matches =3D {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> -               },
> -       },
> -       {
> -               .ident =3D "LENOVO IdeaPad Flex 5 16ALC7",
> -               .matches =3D {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> -               },
> -       },
> -       { }
> -};
> -
> -static const struct dmi_system_id tongfang_gm_rg[] =3D {
> -       {
> -               .ident =3D "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Ste=
llaris 15 Gen4 AMD",
> -               .matches =3D {
> -                       DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
> -               },
> -       },
> -       { }
> -};
> -
> -static const struct dmi_system_id maingear_laptop[] =3D {
> -       {
> -               .ident =3D "MAINGEAR Vector Pro 2 15",
> -               .matches =3D {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"=
),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
> -               }
> -       },
> -       {
> -               .ident =3D "MAINGEAR Vector Pro 2 17",
> -               .matches =3D {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"=
),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
> -               },
> -       },
> -       { }
> -};
> -
>  static const struct dmi_system_id lg_laptop[] =3D {
>         {
>                 .ident =3D "LG Electronics 17U70P",
> @@ -539,10 +493,6 @@ struct irq_override_cmp {
>  static const struct irq_override_cmp override_table[] =3D {
>         { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, fal=
se },
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false=
 },
> -       { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, tru=
e },
> -       { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, tr=
ue },
> -       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, tru=
e },
> -       { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, tr=
ue },
>         { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false }=
,
>  };
>
> @@ -562,16 +512,6 @@ static bool acpi_dev_irq_override(u32 gsi, u8 trigge=
ring, u8 polarity,
>                         return entry->override;
>         }
>
> -#ifdef CONFIG_X86
> -       /*
> -        * IRQ override isn't needed on modern AMD Zen systems and
> -        * this override breaks active low IRQs on AMD Ryzen 6000 and
> -        * newer systems. Skip it.
> -        */
> -       if (boot_cpu_has(X86_FEATURE_ZEN))
> -               return false;
> -#endif
> -
>         return true;
>  }
>
> --
> 2.34.1
>
