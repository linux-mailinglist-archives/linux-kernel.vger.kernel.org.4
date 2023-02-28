Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69596A5A58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjB1NuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjB1NuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:50:20 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A4B765;
        Tue, 28 Feb 2023 05:50:18 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id cq23so40363026edb.1;
        Tue, 28 Feb 2023 05:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677592217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCxnAj+Q7kSfLUaLTs010WnxrZ5KYykWmnNR3WSnBBw=;
        b=0GjdbvjV6brpNyr01lKd9RSO5ev+FlUQ50swllTlPaDHNeALybv+74eEX0H/+PsqEc
         bMsGgIobjd3JDUJIujdDKP2N2qDu+pKiOZIpDUqdKKThIqDOsn8l89qxeo8bX/h8BX8O
         IkgNImpRysfKHTLlxQrZeSQaYHPLXr4IT2R0cqWGF2XKWBLFdXMKvXbvX86Z2tHaQFNW
         ayW/e3ALMn2kQUTO28RrBGErD/bKJanpBCvNg6TpdUpQuTcRBZm3taxsMygr+p4qcItc
         Wsi+T+GFkrh5siwBKBkcVczXTQykXsSBV/vBTy53QdiFS0jLHWkmTS2h1xNsFj6HUHzq
         LYZQ==
X-Gm-Message-State: AO0yUKWQr6WQyEOhyBiNummfK41XYPIPHoMzoGMTGhuL65kYMg/IEoTL
        cC5ppoFVtn2T6Dztpq8Ezz3O5HYWDIkmpUr0WGE=
X-Google-Smtp-Source: AK7set8S5ezEf2wc4QyBDfF9GX0sz25bCIICWeEW9UY6IYdnuV9vR5N4xHqeSBuAbFFoX9z04lWsqtmBSYzEer3mD94=
X-Received: by 2002:a17:906:4bc8:b0:8ce:cb8f:3747 with SMTP id
 x8-20020a1709064bc800b008cecb8f3747mr1274124ejv.5.1677592216859; Tue, 28 Feb
 2023 05:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20230220143143.3492-1-petr.pavlu@suse.com> <CAJZ5v0jng3PDPnTKAov0m2KTYKaQuwOdi+jCVwc5BM5duct2Pg@mail.gmail.com>
 <a75a9e85-5682-1527-2e74-e1f7cf69132e@suse.com>
In-Reply-To: <a75a9e85-5682-1527-2e74-e1f7cf69132e@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Feb 2023 14:50:05 +0100
Message-ID: <CAJZ5v0hUh0oEK9DCD7SFWLrW0avfZ5JEgNhO=A1FaBZsOXKC9A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        viresh.kumar@linaro.org, pmladek@suse.com, mcgrof@kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
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

On Tue, Feb 28, 2023 at 11:05 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> On 2/22/23 16:04, Rafael J. Wysocki wrote:
> > On Mon, Feb 20, 2023 at 3:32 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
> >> Both acpi-cpufreq and pcc-cpufreq drivers have their platform firmware
> >> interface defined by ACPI. Allowed performance states and parameters
> >> must be same for each CPU.
> >
> > This is not a requirement set by the ACPI specification, though, but
> > the assumption made by the drivers in question AFAICS.  It would be
> > good to clarify this here.
>
> I can simplify this paragraph to:
> Both acpi-cpufreq and pcc-cpufreq drivers use platform firmware controls
> which are defined by ACPI. It is possible to treat these interfaces as
> platform devices.
>
> >> This makes it possible to model these
> >> interfaces as platform devices.
> >>
> >> The patch extends the ACPI parsing logic to check the ACPI namespace if
> >> the PPC or PCC interface is present and creates a virtual platform
> >> device for each if it is available.
> >
> > I'm not sure that this is the best approach.
> >
> > The ACPI subsystem already walks the ACPI namespace twice when
> > enumerating devices and CPUs.  In particular, acpi_processor_add() is
> > invoked for each of them in the first on these walks, so it might as
> > well take care of creating the requisite platform device if _PCT is
> > present, can't it?
>
> Makes sense, I see that acpi_processor_get_info() has some logic for handling
> the first CPU so that looks to me as a good place to hook a check for _PCT.
>
> >> The acpi-cpufreq and pcc-cpufreq
> >> drivers are then updated to map to these devices.
> >>
> >> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
> >> boot and only if a given interface is available in the firmware.
> >>
> >> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> >> ---
> >>
> >> Changes since v1 [1]:
> >> - Describe the worst case scenario without the recent fix 0254127ab977e
> >>   ("module: Don't wait for GOING modules") and refer to its discussion
> >>   in the commit message.
> >> - Consider ACPI processor device objects when looking for _PCT, in
> >>   addition to processor objects.
> >> - Add a few more comments explaining the code.
> >>
> >> [1] https://lore.kernel.org/lkml/20230131130041.629-1-petr.pavlu@suse.com/
> >>
> >>  drivers/acpi/Makefile          |  1 +
> >>  drivers/acpi/acpi_cpufreq.c    | 77 ++++++++++++++++++++++++++++++++++
> >>  drivers/acpi/bus.c             |  1 +
> >>  drivers/acpi/internal.h        |  2 +
> >>  drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++--------
> >>  drivers/cpufreq/pcc-cpufreq.c  | 34 ++++++++++-----
> >>  6 files changed, 127 insertions(+), 27 deletions(-)
> >>  create mode 100644 drivers/acpi/acpi_cpufreq.c
> >>
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index feb36c0b9446..880db1082c3e 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -57,6 +57,7 @@ acpi-y                                += evged.o
> >>  acpi-y                         += sysfs.o
> >>  acpi-y                         += property.o
> >>  acpi-$(CONFIG_X86)             += acpi_cmos_rtc.o
> >> +acpi-$(CONFIG_X86)             += acpi_cpufreq.o
> >>  acpi-$(CONFIG_X86)             += x86/apple.o
> >>  acpi-$(CONFIG_X86)             += x86/utils.o
> >>  acpi-$(CONFIG_X86)             += x86/s2idle.o
> >> diff --git a/drivers/acpi/acpi_cpufreq.c b/drivers/acpi/acpi_cpufreq.c
> >> new file mode 100644
> >> index 000000000000..4e4ceb7cd226
> >> --- /dev/null
> >> +++ b/drivers/acpi/acpi_cpufreq.c
> >> @@ -0,0 +1,77 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Registration of platform devices for ACPI Processor Performance Control and
> >> + * Processor Clocking Control.
> >> + */
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#include <acpi/processor.h>
> >> +
> >> +#include "internal.h"
> >> +
> >> +static void __init cpufreq_add_device(const char *name)
> >> +{
> >> +       struct platform_device *pdev;
> >> +
> >> +       pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL,
> >> +                                              0);
> >> +       if (IS_ERR(pdev))
> >> +               pr_err("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
> >> +}
> >> +
> >> +static acpi_status __init acpi_pct_match(acpi_handle handle, u32 level,
> >> +                                        void *context, void **return_value)
> >> +{
> >> +       bool *pct = context;
> >> +       acpi_status status;
> >> +       acpi_object_type acpi_type;
> >> +       struct acpi_device *acpi_dev;
> >> +
> >> +       static const struct acpi_device_id processor_device_ids[] = {
> >> +               { ACPI_PROCESSOR_OBJECT_HID, 0 },
> >> +               { ACPI_PROCESSOR_DEVICE_HID, 0 },
> >> +               { "", 0 },
> >> +       };
> >> +
> >> +       /* Skip nodes that cannot be a processor. */
> >> +       status = acpi_get_type(handle, &acpi_type);
> >> +       if (ACPI_FAILURE(status))
> >> +               return status;
> >> +       if (acpi_type != ACPI_TYPE_PROCESSOR && acpi_type != ACPI_TYPE_DEVICE)
> >> +               return AE_OK;
> >> +
> >> +       /* Look at the set IDs if it is really a one. */
> >> +       acpi_dev = acpi_fetch_acpi_dev(handle);
> >> +       if (acpi_dev == NULL ||
> >> +           acpi_match_device_ids(acpi_dev, processor_device_ids))
> >> +               return AE_OK;
> >> +
> >> +       /* Check if it has _PCT and stop the walk as all CPUs must be same. */
> >> +       *pct = acpi_has_method(handle, "_PCT");
> >> +       return AE_CTRL_TERMINATE;
> >> +}
> >> +
> >> +void __init acpi_cpufreq_init(void)
> >> +{
> >> +       bool pct = false;
> >> +       acpi_status status;
> >> +       acpi_handle handle;
> >> +
> >> +       /*
> >> +        * Check availability of the PPC by looking at the presence of the _PCT
> >> +        * object under the first processor definition.
> >> +        */
> >> +       acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
> >> +                           acpi_pct_match, NULL, &pct, NULL);
> >> +       if (pct)
> >> +               cpufreq_add_device("acpi-cpufreq");
> >
> > It should be possible to combine this with CPU enumeration as stated above.
>
> Ack.
>
> >> +
> >> +       /* Check availability of the PCC by searching for \_SB.PCCH. */
> >> +       status = acpi_get_handle(NULL, "\\_SB", &handle);
> >> +       if (ACPI_FAILURE(status))
> >> +               return;
> >> +       if (acpi_has_method(handle, "PCCH"))
> >> +               cpufreq_add_device("pcc-cpufreq");
> >
> > And the remaining part can be called acpi_pcc_cpufreq_init().
>
> Ok. I guess it then makes sense to move both PPC and PCC checks to
> acpi_processor.c instead of adding a new file. Function
> acpi_pcc_cpufreq_init() can be called from acpi_processor_init().

That's correct.
