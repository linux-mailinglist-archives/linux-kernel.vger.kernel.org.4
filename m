Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B3742837
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjF2OXh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2OXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:23:34 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA919B6;
        Thu, 29 Jun 2023 07:23:33 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5183075a5ecso160833a12.0;
        Thu, 29 Jun 2023 07:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688048612; x=1690640612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t2sj2EnTBCeFQLO+MHGaPquq5tYOPX5k9B7//thqBU=;
        b=l1RzkMa0QOQ1e/yUvmxFcEW2sNioMY41yUhn/8oHKj04lex07rfYbFvmZr/Kcbka4x
         1OtLt5OkfXBOVGwtWghg37ttb7+WVB8iQnlkLbOb5+EQzaztONm/PYtBzDnToWhTWxrN
         mDPqySZh0fzWRQVnJlho0w8pCIV9QjJnodghydCOCTz09Med4YHk56DM+peC1XwiN0G8
         8dosH4UBa1K+Tvo+0zyaZtPIhKLT/Mq0I23uGlZ+ht3/6hsgKSkDCQMp0jJn3oOj3tqE
         9F2vyTiDJK9HG8+nZDgNgx72acUfGe4GJb7Vww2rBKIt0hJVLkqCZ69RY037KDqdnlq4
         WYMA==
X-Gm-Message-State: AC+VfDzdNC9UrYKBKSwWqnT5zccLG0MhibPu24LFtcW3WA9ssJtYjhgi
        qtBLu6OUixfHkbTJ0jTKmvQo5kgVJMi9+SVt2gY=
X-Google-Smtp-Source: APBJJlG1hEfWlocReUOy4iTNw80tkCq6V8nDSYyR6op1kRhKf7PJkUYwVDMuIaE+yHpDyJlE3k6+PuTSbNQ8jwD0kxI=
X-Received: by 2002:a17:906:7796:b0:974:5de8:b5ce with SMTP id
 s22-20020a170906779600b009745de8b5cemr2187490ejm.2.1688048612025; Thu, 29 Jun
 2023 07:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230613161034.3496047-1-michal.wilczynski@intel.com> <20230613161034.3496047-5-michal.wilczynski@intel.com>
In-Reply-To: <20230613161034.3496047-5-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 16:23:20 +0200
Message-ID: <CAJZ5v0ig9=5wgQbH__q6BJU=p2uryReS_Lmq7s7HdWoDX6eXsQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] acpi: Use _OSC method to convey processor OSPM capabilities
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
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

On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Change acpi_early_processor_osc() to return value in case of the failure.
> Make it more generic - previously it served only to execute workaround
> for buggy BIOS in Skylake systems. Now it will walk through ACPI
> namespace looking for processor objects and will convey OSPM processor
> capabilities using _OSC method.
>
> Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
> case of the failure of the _OSC, try using  _PDC as a fallback.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_processor.c | 23 +++++++++++++----------
>  drivers/acpi/bus.c            | 13 +++++++++----
>  drivers/acpi/internal.h       |  9 +--------
>  3 files changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 0de0b05b6f53..8965e01406e0 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -669,17 +669,20 @@ static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
>         return AE_OK;
>  }
>
> -void __init acpi_early_processor_osc(void)

I would rename this to something like
acpi_early_processor_control_setup() and would make it attempt to call
_PDC if _OSC doesn't work.

Then it could remain void and it could be put under a
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC #ifdef.

> +acpi_status __init acpi_early_processor_osc(void)
>  {
> -       if (boot_cpu_has(X86_FEATURE_HWP)) {
> -               acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
> -                                   ACPI_UINT32_MAX,
> -                                   acpi_hwp_native_thermal_lvt_osc,
> -                                   NULL, NULL, NULL);
> -               acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
> -                                acpi_hwp_native_thermal_lvt_osc,
> -                                NULL, NULL);
> -       }
> +       acpi_status status;
> +
> +       processor_dmi_check();
> +
> +       status = acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
> +                                    ACPI_UINT32_MAX, acpi_processor_osc, NULL,
> +                                    NULL, NULL);
> +       if (ACPI_FAILURE(status))
> +               return status;
> +
> +       return acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_osc,
> +                               NULL, NULL);
>  }
>  #endif
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index d161ff707de4..e8d1f645224f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1317,9 +1317,6 @@ static int __init acpi_bus_init(void)
>                 goto error1;
>         }
>
> -       /* Set capability bits for _OSC under processor scope */
> -       acpi_early_processor_osc();
> -
>         /*
>          * _OSC method may exist in module level code,
>          * so it must be run after ACPI_FULL_INITIALIZATION
> @@ -1335,7 +1332,15 @@ static int __init acpi_bus_init(void)
>
>         acpi_sysfs_init();
>
> -       acpi_early_processor_set_pdc();
> +#ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
> +       status = acpi_early_processor_osc();
> +       if (ACPI_FAILURE(status)) {
> +               pr_err("_OSC methods failed, trying _PDC\n");
> +               acpi_early_processor_set_pdc();
> +       } else {
> +               pr_info("_OSC methods ran successfully\n");
> +       }
> +#endif
>
>         /*
>          * Maybe EC region is required at bus_scan/acpi_get_devices. So it
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f979a2f7077c..e7cc41313997 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -151,17 +151,10 @@ int acpi_wakeup_device_init(void);
>     -------------------------------------------------------------------------- */
>  #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>  void acpi_early_processor_set_pdc(void);
> +acpi_status acpi_early_processor_osc(void);
>
>  void processor_dmi_check(void);
>  bool processor_physically_present(acpi_handle handle);
> -#else
> -static inline void acpi_early_processor_set_pdc(void) {}
> -#endif
> -
> -#ifdef CONFIG_X86
> -void acpi_early_processor_osc(void);
> -#else
> -static inline void acpi_early_processor_osc(void) {}
>  #endif
>
>  /* --------------------------------------------------------------------------
> --
