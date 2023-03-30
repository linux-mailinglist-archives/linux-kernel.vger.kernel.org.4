Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C506D0DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjC3SXz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 14:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjC3SXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:23:52 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48FE072;
        Thu, 30 Mar 2023 11:23:51 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id h8so80064264ede.8;
        Thu, 30 Mar 2023 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j0TodEruv5k2n+iGGvRH1vWLP1TxquIM08eT58r8/Q=;
        b=5UvL5CP/I7WM9GYFG43B89kFuu0ZP/q30aTUBJiMeli/BjR3km4YNxFw+1IMT/EyOT
         oNijtVWs2IHGKpXrz59rj7wT1ZIGt+/2kmam5nRpR1CCvI8AdDD6znH0djVB4allHigz
         aPmdFFNQfnEVZ8FdARLNrJPpa9PbMoAtQRzkoFE0f8VxE7Y6u0bpU8bcubuU5aD5qG1D
         Lq1tjXrMmnODtdHpx34goP1IkikzbQ/z8vHaeJnq9goJoFpmun+NYtz9lcoPGEZV/JBD
         KM+ZVtWmOhPoOig3Jm3TwWGgO3yn3G7nw99NcZGGCx3sSUl65uE3Di+Q5uh8NjAGYvrj
         jsGg==
X-Gm-Message-State: AAQBX9fJU85XgF13Ow2LFPj7d+cQb6sHAw5FoXVuqH//sYHZZUctK9Vj
        ToCdh8efsdjjYJ4qpzUSV3UzrsJh5DxQSMn3eoo=
X-Google-Smtp-Source: AKy350YUmI7pvkib+YOeWqKmPdNHv1IjhaEHQ3mMtxgcVfxAUucYlvMka6PCp1v3i7+U+XfRFPV6J+bmBvYrlk88s4c=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr11209201ejc.2.1680200629495; Thu, 30
 Mar 2023 11:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230329174536.6931-1-mario.limonciello@amd.com>
In-Reply-To: <20230329174536.6931-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 20:23:38 +0200
Message-ID: <CAJZ5v0i-ypLb9oPO8RqdQ6Vm3yD1ohP1sFei_BPNgiHZibdoQg@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
To:     Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Borislav Petkob <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 7:46 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> ACPI 6.3 introduced the online capable bit, and also introduced MADT
> version 5.
>
> This was used to distinguish whether the offset storing online capable
> could be used. However ACPI 6.2b has MADT version "45" which is for
> an errata version of the ACPI 6.2 spec.  This means that the Linux code
> for detecting availability of MADT will mistakingly flag ACPI 6.2b as
> supporting online capable which is inaccurate as it's an ACPI 6.3 feature.
>
> Instead use the FADT major and minor revision fields to distingush this.
>
> Reported-by: Eric DeVolder <eric.devolder@oracle.com>
> Reported-by: Borislav Petkob <bp@alien8.de>

s/Petkob/Petkov/ I suppose?

Would have been nice to CC this to linux-acpi (done now).

Anyway, x86 guys, are you going to handle this or do you want me to do that?

> Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1c38174b5f01..e92e3292fef7 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -146,7 +146,10 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
>
>                 pr_debug("Local APIC address 0x%08x\n", madt->address);
>         }
> -       if (madt->header.revision >= 5)
> +
> +       if (acpi_gbl_FADT.header.revision > 6 ||
> +           (acpi_gbl_FADT.header.revision == 6 &&
> +            acpi_gbl_FADT.minor_revision >= 3))
>                 acpi_support_online_capable = true;
>
>         default_acpi_madt_oem_check(madt->header.oem_id,
> --
> 2.34.1
>
