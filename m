Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6763969F757
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjBVPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBVPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:04:41 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098A40FD;
        Wed, 22 Feb 2023 07:04:38 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id b12so31562076edd.4;
        Wed, 22 Feb 2023 07:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDR4v8TjFA5wgCtE/oCu5MNbaltesnH6Ax0WsDRitKg=;
        b=rkLT4ULvUHRMAIqf372IP0pt5OsCb8iZCLWs9oRu93zD0wLu/m6hEs34ZK5Akc/5q2
         ESkPQfjP1CtjQ19Anfiq8rmt3G/W+wZchXnpMzkWokw+wTt6TCjYlIOuhtDpbyJOikdM
         Pkow4AHKr1nLoOXmW9mxuvkbGToGB/anNCPzceKs5N5KOBDV/zhSTr9XHD8ZnxGW9UJv
         1VC17UfnGdplv7PmujH6H+tggrwAVW1OUjfaoyzPbgDmfL0u1/Q+JtgbCwJmRYd8KslX
         3y/7iXOIPaY/VcIAFd8WPhcmh18+qtSezKPYyFcoIuR17mWT5LtgauPwIRgWPk0tYj5e
         E0Bw==
X-Gm-Message-State: AO0yUKVzitVwCfBYa8NJqQpDbAsATsS8ARoFFI4gHCogGenw+y3K7X1E
        lwDVM2pWmzFxi0QXN3CJkfkX+EROvNk91m45jkA=
X-Google-Smtp-Source: AK7set9FCqhtBZkMhiyjHV5GyPeOYhiFVM/ZWQFR3jAjziohLscVI9j4k3qG88r2ggZov5GP/2SOpRdXMSwWRNPM+vQ=
X-Received: by 2002:a17:907:c004:b0:8e5:1a7b:8ab2 with SMTP id
 ss4-20020a170907c00400b008e51a7b8ab2mr2393230ejc.4.1677078276884; Wed, 22 Feb
 2023 07:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220143143.3492-1-petr.pavlu@suse.com>
In-Reply-To: <20230220143143.3492-1-petr.pavlu@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 16:04:25 +0100
Message-ID: <CAJZ5v0jng3PDPnTKAov0m2KTYKaQuwOdi+jCVwc5BM5duct2Pg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        pmladek@suse.com, mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 20, 2023 at 3:32 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> The acpi-cpufreq and pcc-cpufreq drivers are loaded through per-CPU
> module aliases. This can result in many unnecessary load requests during
> boot if another frequency module, such as intel_pstate, is already
> active. For instance, on a typical Intel system, one can observe that
> udev makes 2x#CPUs attempts to insert acpi_cpufreq and 1x#CPUs attempts
> for pcc_cpufreq. All these tries then fail if another frequency module
> is already registered.

Well, that's not nice.

> In the worst case, without the recent fix in commit 0254127ab977e
> ("module: Don't wait for GOING modules"), these module loads occupied
> all udev workers and had their initialization attempts ran sequentially.
> Resolving all these loads then on some larger machines took too long,
> prevented other hardware from getting its drivers initialized and
> resulted in a failed boot. Discussion over these duplicate module
> requests ended up with a conclusion that only one load attempt should be
> ideally made.

Fair enough.

> Both acpi-cpufreq and pcc-cpufreq drivers have their platform firmware
> interface defined by ACPI. Allowed performance states and parameters
> must be same for each CPU.

This is not a requirement set by the ACPI specification, though, but
the assumption made by the drivers in question AFAICS.  It would be
good to clarify this here.

> This makes it possible to model these
> interfaces as platform devices.
>
> The patch extends the ACPI parsing logic to check the ACPI namespace if
> the PPC or PCC interface is present and creates a virtual platform
> device for each if it is available.

I'm not sure that this is the best approach.

The ACPI subsystem already walks the ACPI namespace twice when
enumerating devices and CPUs.  In particular, acpi_processor_add() is
invoked for each of them in the first on these walks, so it might as
well take care of creating the requisite platform device if _PCT is
present, can't it?

> The acpi-cpufreq and pcc-cpufreq
> drivers are then updated to map to these devices.
>
> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
> boot and only if a given interface is available in the firmware.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>
> Changes since v1 [1]:
> - Describe the worst case scenario without the recent fix 0254127ab977e
>   ("module: Don't wait for GOING modules") and refer to its discussion
>   in the commit message.
> - Consider ACPI processor device objects when looking for _PCT, in
>   addition to processor objects.
> - Add a few more comments explaining the code.
>
> [1] https://lore.kernel.org/lkml/20230131130041.629-1-petr.pavlu@suse.com/
>
>  drivers/acpi/Makefile          |  1 +
>  drivers/acpi/acpi_cpufreq.c    | 77 ++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c             |  1 +
>  drivers/acpi/internal.h        |  2 +
>  drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++--------
>  drivers/cpufreq/pcc-cpufreq.c  | 34 ++++++++++-----
>  6 files changed, 127 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/acpi/acpi_cpufreq.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index feb36c0b9446..880db1082c3e 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -57,6 +57,7 @@ acpi-y                                += evged.o
>  acpi-y                         += sysfs.o
>  acpi-y                         += property.o
>  acpi-$(CONFIG_X86)             += acpi_cmos_rtc.o
> +acpi-$(CONFIG_X86)             += acpi_cpufreq.o
>  acpi-$(CONFIG_X86)             += x86/apple.o
>  acpi-$(CONFIG_X86)             += x86/utils.o
>  acpi-$(CONFIG_X86)             += x86/s2idle.o
> diff --git a/drivers/acpi/acpi_cpufreq.c b/drivers/acpi/acpi_cpufreq.c
> new file mode 100644
> index 000000000000..4e4ceb7cd226
> --- /dev/null
> +++ b/drivers/acpi/acpi_cpufreq.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Registration of platform devices for ACPI Processor Performance Control and
> + * Processor Clocking Control.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +#include "internal.h"
> +
> +static void __init cpufreq_add_device(const char *name)
> +{
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL,
> +                                              0);
> +       if (IS_ERR(pdev))
> +               pr_err("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
> +}
> +
> +static acpi_status __init acpi_pct_match(acpi_handle handle, u32 level,
> +                                        void *context, void **return_value)
> +{
> +       bool *pct = context;
> +       acpi_status status;
> +       acpi_object_type acpi_type;
> +       struct acpi_device *acpi_dev;
> +
> +       static const struct acpi_device_id processor_device_ids[] = {
> +               { ACPI_PROCESSOR_OBJECT_HID, 0 },
> +               { ACPI_PROCESSOR_DEVICE_HID, 0 },
> +               { "", 0 },
> +       };
> +
> +       /* Skip nodes that cannot be a processor. */
> +       status = acpi_get_type(handle, &acpi_type);
> +       if (ACPI_FAILURE(status))
> +               return status;
> +       if (acpi_type != ACPI_TYPE_PROCESSOR && acpi_type != ACPI_TYPE_DEVICE)
> +               return AE_OK;
> +
> +       /* Look at the set IDs if it is really a one. */
> +       acpi_dev = acpi_fetch_acpi_dev(handle);
> +       if (acpi_dev == NULL ||
> +           acpi_match_device_ids(acpi_dev, processor_device_ids))
> +               return AE_OK;
> +
> +       /* Check if it has _PCT and stop the walk as all CPUs must be same. */
> +       *pct = acpi_has_method(handle, "_PCT");
> +       return AE_CTRL_TERMINATE;
> +}
> +
> +void __init acpi_cpufreq_init(void)
> +{
> +       bool pct = false;
> +       acpi_status status;
> +       acpi_handle handle;
> +
> +       /*
> +        * Check availability of the PPC by looking at the presence of the _PCT
> +        * object under the first processor definition.
> +        */
> +       acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
> +                           acpi_pct_match, NULL, &pct, NULL);
> +       if (pct)
> +               cpufreq_add_device("acpi-cpufreq");

It should be possible to combine this with CPU enumeration as stated above.

> +
> +       /* Check availability of the PCC by searching for \_SB.PCCH. */
> +       status = acpi_get_handle(NULL, "\\_SB", &handle);
> +       if (ACPI_FAILURE(status))
> +               return;
> +       if (acpi_has_method(handle, "PCCH"))
> +               cpufreq_add_device("pcc-cpufreq");

And the remaining part can be called acpi_pcc_cpufreq_init().

> +}
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 0c05ccde1f7a..f1559e26d5ff 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1428,6 +1428,7 @@ static int __init acpi_init(void)
>         acpi_viot_init();
>         acpi_agdi_init();
>         acpi_apmt_init();
> +       acpi_cpufreq_init();
>         return 0;
>  }
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index ec584442fb29..c9b1a5f689fa 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -157,8 +157,10 @@ static inline void acpi_early_processor_set_pdc(void) {}
>
>  #ifdef CONFIG_X86
>  void acpi_early_processor_osc(void);
> +void acpi_cpufreq_init(void);
>  #else
>  static inline void acpi_early_processor_osc(void) {}
> +static inline void acpi_cpufreq_init(void) {}
>  #endif
>
>  /* --------------------------------------------------------------------------
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 78adfb2ffff6..e1a5384cf21c 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -965,7 +965,7 @@ static void __init acpi_cpufreq_boost_init(void)
>         acpi_cpufreq_driver.boost_enabled = boost_state(0);
>  }
>
> -static int __init acpi_cpufreq_init(void)
> +static int __init acpi_cpufreq_probe(struct platform_device *pdev)
>  {
>         int ret;
>
> @@ -1010,13 +1010,32 @@ static int __init acpi_cpufreq_init(void)
>         return ret;
>  }
>
> -static void __exit acpi_cpufreq_exit(void)
> +static int acpi_cpufreq_remove(struct platform_device *pdev)
>  {
>         pr_debug("%s\n", __func__);
>
>         cpufreq_unregister_driver(&acpi_cpufreq_driver);
>
>         free_acpi_perf_data();
> +
> +       return 0;
> +}
> +
> +static struct platform_driver acpi_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "acpi-cpufreq",
> +       },
> +       .remove         = acpi_cpufreq_remove,
> +};
> +
> +static int __init acpi_cpufreq_init(void)
> +{
> +       return platform_driver_probe(&acpi_cpufreq_platdrv, acpi_cpufreq_probe);
> +}
> +
> +static void __exit acpi_cpufreq_exit(void)
> +{
> +       platform_driver_unregister(&acpi_cpufreq_platdrv);
>  }
>
>  module_param(acpi_pstate_strict, uint, 0644);
> @@ -1027,18 +1046,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
>
> -static const struct x86_cpu_id __maybe_unused acpi_cpufreq_ids[] = {
> -       X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
> -       X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
> -       {}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
> -
> -static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
> -       {ACPI_PROCESSOR_OBJECT_HID, },
> -       {ACPI_PROCESSOR_DEVICE_HID, },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> -
> -MODULE_ALIAS("acpi");
> +MODULE_ALIAS("platform:acpi-cpufreq");
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 9f3fc7a073d0..0c362932ca60 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -384,7 +384,7 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
>         return ret;
>  }
>
> -static int __init pcc_cpufreq_probe(void)
> +static int __init pcc_cpufreq_evaluate(void)
>  {
>         acpi_status status;
>         struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -576,7 +576,7 @@ static struct cpufreq_driver pcc_cpufreq_driver = {
>         .name = "pcc-cpufreq",
>  };
>
> -static int __init pcc_cpufreq_init(void)
> +static int __init pcc_cpufreq_probe(struct platform_device *pdev)
>  {
>         int ret;
>
> @@ -587,9 +587,9 @@ static int __init pcc_cpufreq_init(void)
>         if (acpi_disabled)
>                 return -ENODEV;
>
> -       ret = pcc_cpufreq_probe();
> +       ret = pcc_cpufreq_evaluate();
>         if (ret) {
> -               pr_debug("pcc_cpufreq_init: PCCH evaluation failed\n");
> +               pr_debug("pcc_cpufreq_probe: PCCH evaluation failed\n");
>                 return ret;
>         }
>
> @@ -607,21 +607,35 @@ static int __init pcc_cpufreq_init(void)
>         return ret;
>  }
>
> -static void __exit pcc_cpufreq_exit(void)
> +static int pcc_cpufreq_remove(struct platform_device *pdev)
>  {
>         cpufreq_unregister_driver(&pcc_cpufreq_driver);
>
>         pcc_clear_mapping();
>
>         free_percpu(pcc_cpu_info);
> +
> +       return 0;
>  }
>
> -static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
> -       {ACPI_PROCESSOR_OBJECT_HID, },
> -       {ACPI_PROCESSOR_DEVICE_HID, },
> -       {},
> +static struct platform_driver pcc_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "pcc-cpufreq",
> +       },
> +       .remove         = pcc_cpufreq_remove,
>  };
> -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> +
> +static int __init pcc_cpufreq_init(void)
> +{
> +       return platform_driver_probe(&pcc_cpufreq_platdrv, pcc_cpufreq_probe);
> +}
> +
> +static void __exit pcc_cpufreq_exit(void)
> +{
> +       platform_driver_unregister(&pcc_cpufreq_platdrv);
> +}
> +
> +MODULE_ALIAS("platform:pcc-cpufreq");
>
>  MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
>  MODULE_VERSION(PCC_VERSION);
> --
