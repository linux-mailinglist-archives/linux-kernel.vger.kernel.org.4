Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E1F6D98D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbjDFN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjDFN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:59:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC76976B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:59:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id cv11so13106110pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680789560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D62uxIrnRdLIJ/0FC1wLMU5NxXl2TZq4mxa+MvGVH2I=;
        b=ep4um+9SshODUF+wBrCFzrXH1dy9eFmb9qXjk/h54/YrbGpDP04/j7Oc4hs3985wzM
         3QeD+8vjiNdv/MwOB1yO8rN8BlCOdoI2WAAShmDhQ/1OWWsi1hzpaPItmeFvK99EGiiN
         gAPiYvfaB1UZyaQ041mZGeRPAmJ3YYu5xFMUuqT+3T+58FV0uBwpNTFfLFQ77AZe85er
         ERzx3znqXBUVdSpjGr4btsrEUuoYJ89RYaejHWSdwpkreSaB359Q2Rso+SRfAf0WsgVt
         BW2CX1PPYFKH2JRoIqgbg2/ag81DIVEK58CLUaRdsJeDk3KrHQnZPqsrWQtowqDh8pfb
         7GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D62uxIrnRdLIJ/0FC1wLMU5NxXl2TZq4mxa+MvGVH2I=;
        b=cxsCuDijO5Tis6z8Cjmas+hJ4GetoYfUZCyWybgepGGwoAjnOc57mu1XyQrz44mzLa
         kRaDULiVGfykIUlEmNukTFNDCr5mPLyGc0LGVX53LnkgdfpLE5zjXypWCnNhlZhYM/t3
         gDtfTKR6BssoDOqD2Cx67n9cyw+DlBQU/0KtBIhk1d+myvZDz5YV7jp3IFX57PUNBbSR
         AIyleKIoqEu+Gt+9D7Fr0qwq9kUqcEgD1O0YWdmsiTwem5Fwd2DZn0dcBmCCv9kxJJlq
         rWTGuX7OMML3QW8R6FOhI9QbX41r0yJAjYuUag64xXqfUPPmIvJn86bls5e8KcK/a3in
         7NPQ==
X-Gm-Message-State: AAQBX9effUUgFTWPVqUwvKk3V8klv2Mm0WfRyHmg6ngYubbWUjx5dm1u
        FLVQgKBsZu6rK8LJ0HA7UmTm9kpjOS2OcZjQeb4ojA==
X-Google-Smtp-Source: AKy350awhzhXo5L1KzV0UcjmcDPDHA0lMbG00SZClLPQXXYhpDBMAKS6jF2tBEd2EBkZ3sWL3hcPOLnpoD4HJQosRMw=
X-Received: by 2002:a63:d30b:0:b0:513:6f5:7dda with SMTP id
 b11-20020a63d30b000000b0051306f57ddamr3239284pgg.10.1680789560598; Thu, 06
 Apr 2023 06:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230213100921.268770-1-jaz@semihalf.com> <20230213100921.268770-2-jaz@semihalf.com>
 <CAH76GKOHMtwE7rLTPKUZJ_7xUUdHmHnGyZOsh8pFWoHCiWQynw@mail.gmail.com> <c5455226-1d51-1d3d-0b67-78a0473a9e8c@redhat.com>
In-Reply-To: <c5455226-1d51-1d3d-0b67-78a0473a9e8c@redhat.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Thu, 6 Apr 2023 15:59:09 +0200
Message-ID: <CAH76GKPkgUsXQpsBxgSaQ_qz+bGyZ-Sxu-xRMBJaQ67BZG4jsQ@mail.gmail.com>
Subject: Re: [RFCv3 1/1] platform/x86: Add virtual PMC driver used for S2Idle
To:     Hans de Goede <hdegoede@redhat.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, dmy@semihalf.com, tn@semihalf.com,
        dbehr@google.com, zide.chen@intel.corp-partner.google.com,
        seanjc@google.com, upstream@semihalf.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
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

+linux-acpi@vger.kernel.org

Hi Hans, Rafael

czw., 6 kwi 2023 o 12:53 Hans de Goede <hdegoede@redhat.com> napisa=C5=82(a=
):
>
> Hi Grzegorz,
>
> On 3/29/23 14:33, Grzegorz Jaszczyk wrote:
> > Hi Hans,
> >
> > Do you think that this RFC is in good enough state to start the ACPI
> > ID registration process so after it will be completed we could land
> > this solution? Or maybe we could land it (of course if there are no
> > other remarks) even before and adjust if needed?
>
> I see from the links in the cover-letter that most of
> the previous discussion has happened on the linux-pm list
> and I believe that the linux-pm folks are in a better place
> to answer this question then I am.
>
> I have no objections against the suggested approach,
> but I don't really feel that it is my call to make if
> we should move forward with this.

Hans: I see and thank you for your feedback.

Rafael: Could you please comment above?

Thank you in advance,
Grzegorz

>
> Regards,
>
> Hans
>
>
>
> > pon., 13 lut 2023 o 11:11 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=
=C5=82(a):
> >>
> >> Virtual PMC driver is meant for the guest VMs for the S2Idle
> >> notification. Its purpose is to register S2Idle dev ops check handler,
> >> which will evaluate ACPI _DSM just before the guest enters S2Idle powe=
r
> >> state.
> >>
> >> This allows to trap on MMIO access done as a consequence of _DSM
> >> evaluation and therefore notify the VMM about the guest entering S2Idl=
e
> >> state.
> >>
> >> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> >> ---
> >> Changelog v1..v2:
> >> - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
> >>
> >> Changelog v2..v3:
> >> - Add MODULE_LICENSE
> >> - Remove "amd" prefixes
> >> - Be more verbose in VIRT_PMC config description and make it
> >>   HYPERVISOR_GUEST dependent
> >> - Add extra check ensuring that DSM method supports ACPI_VIRT_PMC_NOTI=
FY function
> >> ---
> >>  drivers/platform/x86/Kconfig    |  7 +++
> >>  drivers/platform/x86/Makefile   |  3 ++
> >>  drivers/platform/x86/virt_pmc.c | 83 ++++++++++++++++++++++++++++++++=
+
> >>  3 files changed, 93 insertions(+)
> >>  create mode 100644 drivers/platform/x86/virt_pmc.c
> >>
> >> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconf=
ig
> >> index 5692385e2d26..837ce201b68b 100644
> >> --- a/drivers/platform/x86/Kconfig
> >> +++ b/drivers/platform/x86/Kconfig
> >> @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
> >>           buttons below the display. This module adds an input device
> >>           that delivers key events when these buttons are pressed.
> >>
> >> +config VIRT_PMC
> >> +       tristate "Virtual Power Management Controller"
> >> +       depends on ACPI && SUSPEND && HYPERVISOR_GUEST
> >> +       help
> >> +         The Virtual PMC driver is meant for the guest VMs and its ma=
in
> >> +         purpose is to notify about guest entering s2idle state.
> >> +
> >>  endif # X86_PLATFORM_DEVICES
> >>
> >>  config P2SB
> >> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Make=
file
> >> index 1d3d1b02541b..c4d3056cf4ea 100644
> >> --- a/drivers/platform/x86/Makefile
> >> +++ b/drivers/platform/x86/Makefile
> >> @@ -129,6 +129,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)         +=3D intel_scu=
_wdt.o
> >>  obj-$(CONFIG_INTEL_SCU_IPC_UTIL)       +=3D intel_scu_ipcutil.o
> >>  obj-$(CONFIG_X86_INTEL_LPSS)           +=3D pmc_atom.o
> >>
> >> +# Virtual PMC
> >> +obj-$(CONFIG_VIRT_PMC)                 +=3D virt_pmc.o
> >> +
> >>  # Siemens Simatic Industrial PCs
> >>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)      +=3D simatic-ipc.o
> >>
> >> diff --git a/drivers/platform/x86/virt_pmc.c b/drivers/platform/x86/vi=
rt_pmc.c
> >> new file mode 100644
> >> index 000000000000..a5966bb9048f
> >> --- /dev/null
> >> +++ b/drivers/platform/x86/virt_pmc.c
> >> @@ -0,0 +1,83 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Virtual Power Management Controller Driver
> >> + *
> >> + * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
> >> + */
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#define ACPI_VIRT_PMC_DSM_UUID "9ea49ba3-434a-49a6-be30-37cc55c4d397"
> >> +#define ACPI_VIRT_PMC_NOTIFY 1
> >> +
> >> +static acpi_handle virt_pmc_handle;
> >> +
> >> +static void virt_pmc_s2idle_notify(void)
> >> +{
> >> +       union acpi_object *out_obj;
> >> +       guid_t dsm_guid;
> >> +
> >> +       guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
> >> +
> >> +       out_obj =3D acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
> >> +                                       0, ACPI_VIRT_PMC_NOTIFY, NULL)=
;
> >> +
> >> +       acpi_handle_debug(virt_pmc_handle, "_DSM function %u evaluatio=
n %s\n",
> >> +                         ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful"=
 : "failed");
> >> +
> >> +       ACPI_FREE(out_obj);
> >> +}
> >> +
> >> +static struct acpi_s2idle_dev_ops pmc_s2idle_dev_ops =3D {
> >> +       .check =3D virt_pmc_s2idle_notify,
> >> +};
> >> +
> >> +static int virt_pmc_probe(struct platform_device *pdev)
> >> +{
> >> +       int err =3D 0;
> >> +       guid_t dsm_guid;
> >> +
> >> +       virt_pmc_handle =3D ACPI_HANDLE(&pdev->dev);
> >> +
> >> +       guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
> >> +
> >> +       if (!acpi_check_dsm(virt_pmc_handle, &dsm_guid, 0,
> >> +                           1 << ACPI_VIRT_PMC_NOTIFY)) {
> >> +               dev_err(&pdev->dev, "DSM method doesn't support ACPI_V=
IRT_PMC_NOTIFY\n");
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       err =3D acpi_register_lps0_dev(&pmc_s2idle_dev_ops);
> >> +       if (err)
> >> +               dev_err(&pdev->dev, "failed to register LPS0 sleep han=
dler\n");
> >> +
> >> +       return err;
> >> +}
> >> +
> >> +static int virt_pmc_remove(struct platform_device *pdev)
> >> +{
> >> +       acpi_unregister_lps0_dev(&pmc_s2idle_dev_ops);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static const struct acpi_device_id virt_pmc_acpi_ids[] =3D {
> >> +       {"HYPE0001", 0}, /* _HID for XXX Power Engine, _CID PNP0D80*/
> >> +       { }
> >> +};
> >> +MODULE_DEVICE_TABLE(acpi, virt_pmc_acpi_ids);
> >> +
> >> +static struct platform_driver virt_pmc_driver =3D {
> >> +       .driver =3D {
> >> +               .name =3D "virtual_pmc",
> >> +               .acpi_match_table =3D ACPI_PTR(virt_pmc_acpi_ids),
> >> +       },
> >> +       .probe =3D virt_pmc_probe,
> >> +       .remove =3D virt_pmc_remove,
> >> +};
> >> +
> >> +module_platform_driver(virt_pmc_driver);
> >> +
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_DESCRIPTION("Virtual PMC Driver");
> >> --
> >> 2.39.1.581.gbfd45094c4-goog
> >>
> >
>
