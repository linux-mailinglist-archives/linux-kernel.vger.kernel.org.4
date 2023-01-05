Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64665F268
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAERR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjAERRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:17:34 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064726C11E;
        Thu,  5 Jan 2023 09:10:12 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id x22so91471780ejs.11;
        Thu, 05 Jan 2023 09:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/BBQ+OPgvYUKXce2y29vr0ZH4HpWLk2tV8gs/xaSNg=;
        b=PHxx42S5qwOs5QJUigFbwPIUrDHofqsN+r3FkGec9ZulreOWVNHcKO+Cr4SKvAup+P
         2QNvrppTdDEhp+ZYMTzilzCHGx0zFbBqVV4rqtLA/+2mQ3QqpGJofEVlC/wlz8knvIwL
         5fu8A/YRUpwArQkuy0DSO4PIOYoUJo8VEiXTpYWeu75PWlNhr6Lgs1oI9a7mpctZN5vZ
         vOjMt+hid/iXbSehZdG+gUySRKpjI3GMH+nZT9gugLMZzPzMkdVNWgyamdjH76V+TthH
         dCeRftiH35CPF/btNd9rcLnhq4t/qngW/3NwTYCzP4ll0ilquj2X4SSRfnBwZtI7yhFD
         cbww==
X-Gm-Message-State: AFqh2krbYFNCRZ51PhMMJ1G9xs8u3J6shSZ2I0jo71sRnAmYflAbptf4
        gO6yc1N/qwiK3mpAi1c1GRmDhWq2SmTwqZk3F4E=
X-Google-Smtp-Source: AMrXdXu73bgFfbjER4ngLAu94zLLsU74bQE1340TgBNQOo3hhRlDLQUN8GaWP0URpOHlBHtGV9UxVWKctXVu+bazkwM=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr3688622ejc.246.1672938610886; Thu, 05
 Jan 2023 09:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20230105041059.39366-1-kvijayab@amd.com>
In-Reply-To: <20230105041059.39366-1-kvijayab@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jan 2023 18:09:59 +0100
Message-ID: <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
To:     Kishon Vijay Abraham I <kvijayab@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>
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

On Thu, Jan 5, 2023 at 5:11 AM Kishon Vijay Abraham I <kvijayab@amd.com> wrote:
>
> Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.5
> spec mandates that both "enabled" and "online capable" Local APIC Flags
> should be used to determine if the processor is usable or not.
>
> However, Linux doesn't use the "online capable" flag for x2APIC to
> determine if the processor is usable. As a result, cpu_possible_mask has
> incorrect value and results in more memory getting allocated for per_cpu
> variables than it is going to be used.
>
> Make sure Linux parses both "enabled" and "online capable" flags for
> x2APIC to correctly determine if the processor is usable.
>
> Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reported-by: Leo Duran <leo.duran@amd.com>
> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes from v1:
> 1) Changed the ACPI spec version to 6.5 in the commit log
> 2) Changed the Fixes tag to point to commit aa06e20f1be6
> 3) Added "Reported-by: Leo Duran <leo.duran@amd.com>"
>  arch/x86/kernel/acpi/boot.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 907cc98b1938..518bda50068c 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -188,6 +188,17 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
>         return cpu;
>  }
>
> +static bool __init acpi_is_processor_usable(u32 lapic_flags)
> +{
> +       if (lapic_flags & ACPI_MADT_ENABLED)
> +               return true;
> +
> +       if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +               return true;
> +
> +       return false;
> +}
> +
>  static int __init
>  acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>  {
> @@ -212,6 +223,10 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>         if (apic_id == 0xffffffff)
>                 return 0;
>
> +       /* don't register processors that cannot be onlined */
> +       if (!acpi_is_processor_usable(processor->lapic_flags))
> +               return 0;
> +
>         /*
>          * We need to register disabled CPU as well to permit
>          * counting disabled CPUs. This allows us to size
> @@ -250,9 +265,7 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
>                 return 0;
>
>         /* don't register processors that can not be onlined */
> -       if (acpi_support_online_capable &&
> -           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
> -           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +       if (!acpi_is_processor_usable(processor->lapic_flags))
>                 return 0;
>
>         /*
> --
> 2.34.1
>
