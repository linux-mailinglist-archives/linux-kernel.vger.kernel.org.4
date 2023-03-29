Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125596CD961
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjC2MeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjC2MeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:34:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE8F46B7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:34:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y35so9166382pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680093242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpAhLQZY7Czy6y1NGq4c0NlbJ5rELrH1U8V8KvW/EPk=;
        b=Sfj6WKW6hh8yUQXVKEjK8xSx5KBZQTD5cOxgkAIdmAGHUF8bhz5dbFq5rfV0if5Mp3
         xVZhukgHYouNLZy0wtNQJV+oItOByU9iKgNPnOL4tItc27x5njR4QSWwV95MdirJnZYN
         Ns1L27ESYZE1wwIa7DUV5APwo0PwGa/vytK0zIGi5TSHv5XO52zn1zxLk+mDleOCdR/M
         0y/Av/LYhbYRiSzH/UvBsMW9lGUdfv32lktGOxGoVjioD7xHn27oN2/GZYW28lQbpOQN
         YMx2C1JQQmjTLgJ9GJC/SIg7LBiUfJsGrCXeWhRzlpCtSp/P5e2QnVKSMcyH6H+4Zmmg
         XR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680093242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpAhLQZY7Czy6y1NGq4c0NlbJ5rELrH1U8V8KvW/EPk=;
        b=UQJKscw8jHlE5exQdgL8d2EgnrpvUNQJQ7Q2euCxJrE9CDvFB1I8GhTefyeWL5RF/V
         LR6FJSX0v5w5bum4IswRY+3+Q0qWTSh4ECUWaiH7CNJtCQ+HhUwCe4erKLdVakGIH7c3
         WK77GDtD+PL4MLMqpZSXLWvHGaZyEtyMmNiMkYg3ZVqq6/7AhWQUkDmEMj0OUyGAa6M8
         RNYssNd5NRAIRO0FetaEAqT2VOAWWyRt7vTuN5Myu7VepyanqOte+u8OpmGaaYSlPtvJ
         6tyr0Qzua5KiRjVGirpGCIOqp/XfS2CamRXTI1T/RzwpjrH1PVWZAY2qIMLPAiB/6d75
         EfVg==
X-Gm-Message-State: AAQBX9frXzcxc6On6fG0G9UaTYfcPRJEhuSNqwt90/92QMoSXerWXGq7
        QpZg5czVf4Qa3F461JiVnm51KN+wEItHJ0z84M7dE2ctS9SlnfWO
X-Google-Smtp-Source: AKy350bTEBVu80afZUAhcU2LzPQOG5P0SyVmTgeRpn2R04YwhKA3Js3ITRxqXFZvg3eiiSVvj8UFkqJHFHeBZUQEyHE=
X-Received: by 2002:a63:c2:0:b0:513:5ac2:8e59 with SMTP id 185-20020a6300c2000000b005135ac28e59mr3176999pga.10.1680093242085;
 Wed, 29 Mar 2023 05:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230213100921.268770-1-jaz@semihalf.com> <20230213100921.268770-2-jaz@semihalf.com>
In-Reply-To: <20230213100921.268770-2-jaz@semihalf.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Wed, 29 Mar 2023 14:33:51 +0200
Message-ID: <CAH76GKOHMtwE7rLTPKUZJ_7xUUdHmHnGyZOsh8pFWoHCiWQynw@mail.gmail.com>
Subject: Re: [RFCv3 1/1] platform/x86: Add virtual PMC driver used for S2Idle
To:     linux-kernel@vger.kernel.org, hdegoede@redhat.com
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, markgross@kernel.org, dtor@google.com,
        mario.limonciello@amd.com, linux-pm@vger.kernel.org,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Do you think that this RFC is in good enough state to start the ACPI
ID registration process so after it will be completed we could land
this solution? Or maybe we could land it (of course if there are no
other remarks) even before and adjust if needed?

Thank you in advance,
Grzegorz





pon., 13 lut 2023 o 11:11 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=C5=82=
(a):
>
> Virtual PMC driver is meant for the guest VMs for the S2Idle
> notification. Its purpose is to register S2Idle dev ops check handler,
> which will evaluate ACPI _DSM just before the guest enters S2Idle power
> state.
>
> This allows to trap on MMIO access done as a consequence of _DSM
> evaluation and therefore notify the VMM about the guest entering S2Idle
> state.
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
> Changelog v1..v2:
> - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
>
> Changelog v2..v3:
> - Add MODULE_LICENSE
> - Remove "amd" prefixes
> - Be more verbose in VIRT_PMC config description and make it
>   HYPERVISOR_GUEST dependent
> - Add extra check ensuring that DSM method supports ACPI_VIRT_PMC_NOTIFY =
function
> ---
>  drivers/platform/x86/Kconfig    |  7 +++
>  drivers/platform/x86/Makefile   |  3 ++
>  drivers/platform/x86/virt_pmc.c | 83 +++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/platform/x86/virt_pmc.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5692385e2d26..837ce201b68b 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
>           buttons below the display. This module adds an input device
>           that delivers key events when these buttons are pressed.
>
> +config VIRT_PMC
> +       tristate "Virtual Power Management Controller"
> +       depends on ACPI && SUSPEND && HYPERVISOR_GUEST
> +       help
> +         The Virtual PMC driver is meant for the guest VMs and its main
> +         purpose is to notify about guest entering s2idle state.
> +
>  endif # X86_PLATFORM_DEVICES
>
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 1d3d1b02541b..c4d3056cf4ea 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -129,6 +129,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)         +=3D intel_scu_wd=
t.o
>  obj-$(CONFIG_INTEL_SCU_IPC_UTIL)       +=3D intel_scu_ipcutil.o
>  obj-$(CONFIG_X86_INTEL_LPSS)           +=3D pmc_atom.o
>
> +# Virtual PMC
> +obj-$(CONFIG_VIRT_PMC)                 +=3D virt_pmc.o
> +
>  # Siemens Simatic Industrial PCs
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)      +=3D simatic-ipc.o
>
> diff --git a/drivers/platform/x86/virt_pmc.c b/drivers/platform/x86/virt_=
pmc.c
> new file mode 100644
> index 000000000000..a5966bb9048f
> --- /dev/null
> +++ b/drivers/platform/x86/virt_pmc.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Virtual Power Management Controller Driver
> + *
> + * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +
> +#define ACPI_VIRT_PMC_DSM_UUID "9ea49ba3-434a-49a6-be30-37cc55c4d397"
> +#define ACPI_VIRT_PMC_NOTIFY 1
> +
> +static acpi_handle virt_pmc_handle;
> +
> +static void virt_pmc_s2idle_notify(void)
> +{
> +       union acpi_object *out_obj;
> +       guid_t dsm_guid;
> +
> +       guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
> +
> +       out_obj =3D acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
> +                                       0, ACPI_VIRT_PMC_NOTIFY, NULL);
> +
> +       acpi_handle_debug(virt_pmc_handle, "_DSM function %u evaluation %=
s\n",
> +                         ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful" : =
"failed");
> +
> +       ACPI_FREE(out_obj);
> +}
> +
> +static struct acpi_s2idle_dev_ops pmc_s2idle_dev_ops =3D {
> +       .check =3D virt_pmc_s2idle_notify,
> +};
> +
> +static int virt_pmc_probe(struct platform_device *pdev)
> +{
> +       int err =3D 0;
> +       guid_t dsm_guid;
> +
> +       virt_pmc_handle =3D ACPI_HANDLE(&pdev->dev);
> +
> +       guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
> +
> +       if (!acpi_check_dsm(virt_pmc_handle, &dsm_guid, 0,
> +                           1 << ACPI_VIRT_PMC_NOTIFY)) {
> +               dev_err(&pdev->dev, "DSM method doesn't support ACPI_VIRT=
_PMC_NOTIFY\n");
> +               return -ENODEV;
> +       }
> +
> +       err =3D acpi_register_lps0_dev(&pmc_s2idle_dev_ops);
> +       if (err)
> +               dev_err(&pdev->dev, "failed to register LPS0 sleep handle=
r\n");
> +
> +       return err;
> +}
> +
> +static int virt_pmc_remove(struct platform_device *pdev)
> +{
> +       acpi_unregister_lps0_dev(&pmc_s2idle_dev_ops);
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id virt_pmc_acpi_ids[] =3D {
> +       {"HYPE0001", 0}, /* _HID for XXX Power Engine, _CID PNP0D80*/
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, virt_pmc_acpi_ids);
> +
> +static struct platform_driver virt_pmc_driver =3D {
> +       .driver =3D {
> +               .name =3D "virtual_pmc",
> +               .acpi_match_table =3D ACPI_PTR(virt_pmc_acpi_ids),
> +       },
> +       .probe =3D virt_pmc_probe,
> +       .remove =3D virt_pmc_remove,
> +};
> +
> +module_platform_driver(virt_pmc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Virtual PMC Driver");
> --
> 2.39.1.581.gbfd45094c4-goog
>
