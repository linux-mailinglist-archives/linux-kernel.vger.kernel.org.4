Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9886C1EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjCTSC6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCTSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:02:22 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D08305F5;
        Mon, 20 Mar 2023 10:56:43 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id cy23so49991684edb.12;
        Mon, 20 Mar 2023 10:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH/dUVL84WYXTsIKJr/MpnPHHXPnDWPTxGin3gsUTd4=;
        b=CDcX7Y7hCj85OZUJegAYjPKgW2gM8LOfTODgEj1nZNHmcuvPmnQhmU2WRqu60dmY/H
         lAYSn2ZDvFWbu2KsPLv68yp6gPSEKyPtSgtoXrI/Tgj/Y24bAHUmSn9pmgQOhI9eaphm
         FsqZVzs4z3cWbjAmXAZKe9EK5OQs6hf/WiYbZKxept8egKfa3i19KY3Rji/2+sy7WNav
         OKu8Lb6OZQobCPXErPIzRsLTpwVQNJ8ZvoU38GX2OpkcMVt0QIgn5qQtcpxbu8Mgqh7C
         O5n8DzkOQGivFjgprWSiCbgGWSRvGS/y0jTX4OLJYWHmBN5eVDc/K2iqbdOqygyvfd7y
         x0Kg==
X-Gm-Message-State: AO0yUKX+7PaXyUUVngDxnvVLLvSBTSgszn8yNQoJPG5upI0EApwd9b0p
        RvVbVxl+Q0b7UuqoDmUwrkGu1d2z18yt1doLgUi2Np0V
X-Google-Smtp-Source: AK7set9GB33dEf5AqRNDmBDQzksX22D7iEmA0hp1YQUbxqQYZLboTVW8QHTdH5ZweaR+eRwT8xcSfAGhXOiAERzfoFs=
X-Received: by 2002:a17:906:228b:b0:931:6921:bdbb with SMTP id
 p11-20020a170906228b00b009316921bdbbmr4143830eja.2.1679334954750; Mon, 20 Mar
 2023 10:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230316151036.10181-1-petr.pavlu@suse.com>
In-Reply-To: <20230316151036.10181-1-petr.pavlu@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:55:43 +0100
Message-ID: <CAJZ5v0izMYN7NfxeVpQnmQ-D8S+YJ0s5KiswnjNYuH2kO93SZQ@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        pmladek@suse.com, mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 4:10 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> The acpi-cpufreq and pcc-cpufreq drivers are loaded through per-CPU
> module aliases. This can result in many unnecessary load requests during
> boot if another frequency module, such as intel_pstate, is already
> active. For instance, on a typical Intel system, one can observe that
> udev makes 2x#CPUs attempts to insert acpi_cpufreq and 1x#CPUs attempts
> for pcc_cpufreq. All these tries then fail if another frequency module
> is already registered.
>
> In the worst case, without the recent fix in commit 0254127ab977e
> ("module: Don't wait for GOING modules"), these module loads occupied
> all udev workers and had their initialization attempts ran sequentially.
> Resolving all these loads then on some larger machines took too long,
> prevented other hardware from getting its drivers initialized and
> resulted in a failed boot. Discussion over these duplicate module
> requests ended up with a conclusion that only one load attempt should be
> ideally made.
>
> Both acpi-cpufreq and pcc-cpufreq drivers use platform firmware controls
> which are defined by ACPI. It is possible to treat these interfaces as
> platform devices.
>
> The patch extends the ACPI parsing logic to check the ACPI namespace if
> the PPC or PCC interface is present and creates a virtual platform
> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
> drivers are then updated to map to these devices.
>
> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
> boot and only if a given interface is available in the firmware.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>
> Changes since v3 [1]:
> - Mark acpi_pcc_cpufreq_init() as static.
>
> Changes since v2 [2]:
> - Remove mention about all CPUs needing same clocking parameters from the commit
>   message.
> - Integrate the new logic to detect presence of PPC and PCC with the current
>   ACPI processor code which avoids an additional scan of the ACPI namespace.
>
> Changes since v1 [3]:
> - Describe the worst case scenario without the recent fix 0254127ab977e
>   ("module: Don't wait for GOING modules") and refer to its discussion
>   in the commit message.
> - Consider ACPI processor device objects when looking for _PCT, in
>   addition to processor objects.
> - Add a few more comments explaining the code.
>
> [1] https://lore.kernel.org/lkml/20230301085717.10411-1-petr.pavlu@suse.com/
> [2] https://lore.kernel.org/lkml/20230220143143.3492-1-petr.pavlu@suse.com/
> [3] https://lore.kernel.org/lkml/20230131130041.629-1-petr.pavlu@suse.com/
>
>  drivers/acpi/acpi_processor.c  | 42 ++++++++++++++++++++++++++++++++--
>  drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++++++++++--------------
>  drivers/cpufreq/pcc-cpufreq.c  | 34 +++++++++++++++++++--------
>  3 files changed, 86 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 6737b1cbf6d6..9dbd8d855009 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>
>  #include <acpi/processor.h>
>
> @@ -148,6 +149,34 @@ static int acpi_processor_errata(void)
>         return result;
>  }
>
> +/* Create a platform device to represent a CPU frequency control mechanism. */
> +static void cpufreq_add_device(const char *name)
> +{
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL,
> +                                              0);
> +       if (IS_ERR(pdev))
> +               pr_err("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
> +}
> +
> +#ifdef CONFIG_X86
> +/* Check presence of Processor Clocking Control by searching for \_SB.PCCH. */
> +static void __init acpi_pcc_cpufreq_init(void)
> +{
> +       acpi_status status;
> +       acpi_handle handle;
> +
> +       status = acpi_get_handle(NULL, "\\_SB", &handle);
> +       if (ACPI_FAILURE(status))
> +               return;
> +       if (acpi_has_method(handle, "PCCH"))
> +               cpufreq_add_device("pcc-cpufreq");
> +}
> +#else
> +static void __init acpi_pcc_cpufreq_init(void) {}
> +#endif /* CONFIG_X86 */
> +
>  /* Initialization */
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  int __weak acpi_map_cpu(acpi_handle handle,
> @@ -280,14 +309,22 @@ static int acpi_processor_get_info(struct acpi_device *device)
>                 dev_dbg(&device->dev, "Failed to get CPU physical ID.\n");
>
>         pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
> -       if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
> +       if (!cpu0_initialized) {
>                 cpu0_initialized = 1;
>                 /*
>                  * Handle UP system running SMP kernel, with no CPU
>                  * entry in MADT
>                  */
> -               if (invalid_logical_cpuid(pr->id) && (num_online_cpus() == 1))
> +               if (!acpi_has_cpu_in_madt() && invalid_logical_cpuid(pr->id) &&
> +                   (num_online_cpus() == 1))
>                         pr->id = 0;
> +               /*
> +                * Check availability of Processor Performance Control by
> +                * looking at the presence of the _PCT object under the first
> +                * processor definition.
> +                */
> +               if (acpi_has_method(pr->handle, "_PCT"))
> +                       cpufreq_add_device("acpi-cpufreq");
>         }
>
>         /*
> @@ -686,6 +723,7 @@ void __init acpi_processor_init(void)
>         acpi_processor_check_duplicates();
>         acpi_scan_add_handler_with_hotplug(&processor_handler, "processor");
>         acpi_scan_add_handler(&processor_container_handler);
> +       acpi_pcc_cpufreq_init();
>  }
>
>  #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
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

Applied as 6.4 material under a slightly edited subject and with some
adjustments to the white space and error message log level.

Thanks!
