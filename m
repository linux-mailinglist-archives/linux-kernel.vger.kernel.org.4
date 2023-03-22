Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E496C53E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCVSkI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCVSj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:39:59 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE010F8;
        Wed, 22 Mar 2023 11:39:55 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id i5so29914333eda.0;
        Wed, 22 Mar 2023 11:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679510394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7rV+SRpydAcO3aF+tnR91nn7Q5fcg5T3XLPDHeJhik=;
        b=XfhmPjg+puhMqXTuzmKoK+oXeHJp8WxgJ6jt9516if2MtfJXRPLnIeKzfE9uksHWQA
         VigJsbN2Hm3t9W+4Bt1AM6rOHOkk+mivHFM8efDX1y5pt3CIoBKfuGIge4+8jKAxAoH9
         aY1lvRGW2a3ra97swIEbzogHg/1+AfkLZmepitaVnC8pUFNbgOYPXu4iZr5RWcjZ8j2c
         trmX1cilJ6rNoCX/ZYwX+2Li5dGlroPbX9dx2cuFCMGDg8r6wd4cLILRfjnhhHOBbY2g
         L+X85Xg+iNkvZqxsbVSjLv+RPy/1b8bOukcp3eEp5OmQxSouajPKSLU1KC0IFw1OHM+f
         92tg==
X-Gm-Message-State: AO0yUKXXnCBHef8zbNHDUe1u3M2EUnol4uUVUZM/7SEiRYHsx6TUQvtR
        quCkJKrlsgDjcKmKgXJn2DAyAiOValh74XpyWVU=
X-Google-Smtp-Source: AK7set8GTSoMTVUaheMEuVEUivJgOMkcKrAXGDPunim0E7Q4xVL8zvucT3EGhB3/pzUfwesiYc8Tqf8mCVJACUP5OQo=
X-Received: by 2002:a17:906:ca41:b0:939:a51a:dc30 with SMTP id
 jx1-20020a170906ca4100b00939a51adc30mr1794905ejb.2.1679510394073; Wed, 22 Mar
 2023 11:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230322111330.63651-1-roger.pau@citrix.com>
In-Reply-To: <20230322111330.63651-1-roger.pau@citrix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 19:39:43 +0100
Message-ID: <CAJZ5v0jRNHDsDwXPJa01x2t35vNboVxb4hysE4dfThrJs9kT7Q@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
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

On Wed, Mar 22, 2023 at 12:13 PM Roger Pau Monne <roger.pau@citrix.com> wrote:
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
> Changes since v5:
>  - Include bug.h header for the inline dummy helper.
>  - Constify pcpu local variable in xen_processor_present().
>
> Changes since v4:
>  - Move definition/declaration of xen_processor_present() to different
>    header.
>  - Fold subject edit.
>
> Changes since v3:
>  - Protect xen_processor_present() definition with CONFIG_ACPI.
>
> Changes since v2:
>  - Extend and use the existing pcpu functionality.
>
> Changes since v1:
>  - Reword commit message.
> ---
>  drivers/acpi/processor_pdc.c | 11 +++++++++++
>  drivers/xen/pcpu.c           | 20 ++++++++++++++++++++
>  include/xen/xen.h            | 11 +++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 8c3f82c9fff3..18fb04523f93 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -14,6 +14,8 @@
>  #include <linux/acpi.h>
>  #include <acpi/processor.h>
>
> +#include <xen/xen.h>
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
> index fd3a644b0855..b3e3d1bb37f3 100644
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
> @@ -381,3 +383,21 @@ static int __init xen_pcpu_init(void)
>         return ret;
>  }
>  arch_initcall(xen_pcpu_init);
> +
> +#ifdef CONFIG_ACPI
> +bool __init xen_processor_present(uint32_t acpi_id)
> +{
> +       const struct pcpu *pcpu;
> +       bool online = false;
> +
> +       mutex_lock(&xen_pcpu_lock);
> +       list_for_each_entry(pcpu, &xen_pcpus, list)
> +               if (pcpu->acpi_id == acpi_id) {
> +                       online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
> +                       break;
> +               }
> +       mutex_unlock(&xen_pcpu_lock);
> +
> +       return online;
> +}
> +#endif
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 7adf59837c25..0efeb652f9b8 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -71,4 +71,15 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
>  }
>  #endif
>
> +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
> +bool __init xen_processor_present(uint32_t acpi_id);
> +#else
> +#include <linux/bug.h>
> +static inline bool xen_processor_present(uint32_t acpi_id)
> +{
> +       BUG();
> +       return false;
> +}
> +#endif
> +
>  #endif /* _XEN_XEN_H */
> --

Applied as 6.4 material.

I've added the R-by from Juergen to it, because the difference between
it and the v4 for which the tag was provided is merely a build fix.
