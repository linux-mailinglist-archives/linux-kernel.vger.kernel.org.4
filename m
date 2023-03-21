Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE156C3333
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCUNsD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 09:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:48:01 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0B43469;
        Tue, 21 Mar 2023 06:47:59 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id r11so59914962edd.5;
        Tue, 21 Mar 2023 06:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvR60g3tFXEBQYgwVwbIXJyQcGxQhx5VhvptYm3eERQ=;
        b=lB4+cmzGe4Aon1YQpwAZly0x5SkZfgvy92MYuRQPGOHlOM2cFx3UV+hlVJwCC+eSEH
         GsPkk29IE4lZPBXNbcz2aO5xMelb5G1tUOpX01AiV79BrF0Tsr4rS2PkmEIDeWe2WaP9
         nTcsx+lKyStaDpFNq/BwS2gw5b0vBFmnp3Sv0ufhJ28670+J63XjcMN8G++wbyt6N86t
         ivoiabKwxoOm6qt6uLLbhVScoyio/8IkDlf5xMWCwGBlyyONaScMh/4hD86Zol6vz75A
         EK4BOeUvUKN1/u3cR5oWsUUa8gtwWsQhiavz6Qil/2gOgAxXO24em3fvUti/IOEhBL7M
         mYHQ==
X-Gm-Message-State: AO0yUKVTIG1KBTkmgURRK0CemURiy55PC6PinoPZn36ClJVUEbf88lAj
        qfSup2aFhFBGRjvMinZ+yumyIBg+1aJupPWB+ag=
X-Google-Smtp-Source: AK7set/h/NZ/VGvn4gefABgUQDp9XIpghr+brUfqQ2nYQUkGxKqbJrSGm8oBcbUzqE6/gClu2VFHaojfHaqc9llz62M=
X-Received: by 2002:a50:cd1d:0:b0:4fc:8749:cd77 with SMTP id
 z29-20020a50cd1d000000b004fc8749cd77mr1690914edi.3.1679406477635; Tue, 21 Mar
 2023 06:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230316164257.42590-1-roger.pau@citrix.com>
In-Reply-To: <20230316164257.42590-1-roger.pau@citrix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Mar 2023 14:47:46 +0100
Message-ID: <CAJZ5v0jskeE8nJt04vyEkDO3rOwOHp36mcKcV=L9LGXD0HL6Mw@mail.gmail.com>
Subject: Re: [PATCH v4] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        josef@oderland.se, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
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

On Thu, Mar 16, 2023 at 5:43 PM Roger Pau Monne <roger.pau@citrix.com> wrote:
>
> In ACPI systems, the OS can direct power management, as opposed to the
> firmware.  This OS-directed Power Management is called OSPM.  Part of
> telling the firmware that the OS going to direct power management is
> making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
> methods must be evaluated for every processor object.  If these _PDC
> calls are not completed for every processor it can lead to
> inconsistency and later failures in things like the CPU frequency
> driver.
>
> In a Xen system, the dom0 kernel is responsible for system-wide power
> management.  The dom0 kernel is in charge of OSPM.  However, the
> number of CPUs available to dom0 can be different than the number of
> CPUs physically present on the system.
>
> This leads to a problem: the dom0 kernel needs to evaluate _PDC for
> all the processors, but it can't always see them.
>
> In dom0 kernels, ignore the existing ACPI method for determining if a
> processor is physically present because it might not be accurate.
> Instead, ask the hypervisor for this information.
>
> Fix this by introducing a custom function to use when running as Xen
> dom0 in order to check whether a processor object matches a CPU that's
> online.  Such checking is done using the existing information fetched
> by the Xen pCPU subsystem, extending it to also store the ACPI ID.
>
> This ensures that _PDC method gets evaluated for all physically online
> CPUs, regardless of the number of CPUs made available to dom0.
>
> Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Changes since v3:
>  - Protect xen_processor_present() definition with CONFIG_ACPI.
>
> Changes since v2:
>  - Extend and use the existing pcpu functionality.
>
> Changes since v1:
>  - Reword commit message.
> ---
>  arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
>  drivers/acpi/processor_pdc.c          | 11 +++++++++++
>  drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index 5fc35f889cd1..990a1609677e 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
>  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
>  #endif
>
> +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
> +bool __init xen_processor_present(uint32_t acpi_id);
> +#else
> +static inline bool xen_processor_present(uint32_t acpi_id)
> +{
> +       BUG();
> +       return false;
> +}
> +#endif
> +
>  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 8c3f82c9fff3..18fb04523f93 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -14,6 +14,8 @@
>  #include <linux/acpi.h>
>  #include <acpi/processor.h>
>
> +#include <xen/xen.h>

This along with the definition above is evidently insufficient for
xen_processor_present() to always be defined.  See
https://lore.kernel.org/linux-acpi/64198b60.bO+m9o5w+Hd8hcF3%25lkp@intel.com/T/#u
for example.

I'm dropping the patch now, please fix and resend.

> +
>  #include "internal.h"
>
>  static bool __init processor_physically_present(acpi_handle handle)
> @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
>                 return false;
>         }
>
> +       if (xen_initial_domain())
> +               /*
> +                * When running as a Xen dom0 the number of processors Linux
> +                * sees can be different from the real number of processors on
> +                * the system, and we still need to execute _PDC for all of
> +                * them.
> +                */
> +               return xen_processor_present(acpi_id);
> +
>         type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
>         cpuid = acpi_get_cpuid(handle, type, acpi_id);
>
> diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
> index fd3a644b0855..034d05e56507 100644
> --- a/drivers/xen/pcpu.c
> +++ b/drivers/xen/pcpu.c
> @@ -58,6 +58,7 @@ struct pcpu {
>         struct list_head list;
>         struct device dev;
>         uint32_t cpu_id;
> +       uint32_t acpi_id;
>         uint32_t flags;
>  };
>
> @@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
>
>         INIT_LIST_HEAD(&pcpu->list);
>         pcpu->cpu_id = info->xen_cpuid;
> +       pcpu->acpi_id = info->acpi_id;
>         pcpu->flags = info->flags;
>
>         /* Need hold on xen_pcpu_lock before pcpu list manipulations */
> @@ -381,3 +383,22 @@ static int __init xen_pcpu_init(void)
>         return ret;
>  }
>  arch_initcall(xen_pcpu_init);
> +
> +#ifdef CONFIG_ACPI
> +bool __init xen_processor_present(uint32_t acpi_id)
> +{
> +       struct pcpu *pcpu;
> +       bool online = false;
> +
> +       mutex_lock(&xen_pcpu_lock);
> +       list_for_each_entry(pcpu, &xen_pcpus, list)
> +               if (pcpu->acpi_id == acpi_id) {
> +                       online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
> +                       break;
> +               }
> +
> +       mutex_unlock(&xen_pcpu_lock);
> +
> +       return online;
> +}
> +#endif
> --
> 2.39.0
>
