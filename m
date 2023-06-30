Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C47437F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF3JLE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjF3JLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:11:02 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D456E5E;
        Fri, 30 Jun 2023 02:11:00 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-98dfd15aae1so46563466b.0;
        Fri, 30 Jun 2023 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688116259; x=1690708259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA/+650qKoq/WvgXW4KrtiCH77rUUc/hjHSHIGyfEeI=;
        b=dfROBLpBTg+RllV2t36keShlPqIKTI2MxRRgEHbo7WWJcxlvjf3Yv+VA6pYmRgdY7J
         UoxggmcduUYZi0TIK65uPYGVng0mXkVv0Tqcdp+WOEzzdht0aErQDYGe/iWd96GrVljY
         j3XPqAetmy3Z6+z7MYjGMMEm+lZ98G5/v3/vy7Y+ti1/Jpg2zdfXV50l360nCBUkl91g
         RctdFjSbrIoKitapBZNyFdDBr/xc+n4AP73dC09a/yuvUbZKfS3gOQI510YAZnNjboDp
         ORrqgHceSKTRj78rzdnig/SgyDCMrzG2JR6n2kIzgC84Wa+ybeEx5KBbiPmWwoNLwgNg
         1JTQ==
X-Gm-Message-State: ABy/qLbNVggN3OKOCvBLW6dThbtwVb6YyuS13AB9jYRstQ6H7w5V93ze
        r7DWBXc7YWPNdJKSaFeP4TH3ykqXjmdXuV/OSqc=
X-Google-Smtp-Source: APBJJlECWPV3oXE0dzFgSPDGYpfzaZyFgL26C7YGaERoNS6/Q2V8yHk3tBy6sz5oBftZqLnkEFTy4qUQIL6pMqU+j3w=
X-Received: by 2002:a17:907:119a:b0:987:6960:36c5 with SMTP id
 uz26-20020a170907119a00b00987696036c5mr1205763ejb.6.1688116258769; Fri, 30
 Jun 2023 02:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com> <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com> <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com>
In-Reply-To: <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 11:10:47 +0200
Message-ID: <CAJZ5v0h3mNFa4P+5o=LtUvTW4VnJs=4SJxvjoYMKCeir4tXfpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:02 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/29/2023 3:15 PM, Rafael J. Wysocki wrote:
> > On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> I would just say "Introduce acpi_processor_osc()" in the subject and
> >> then explain its role in the changelog.
> >>
> >> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
> >> <michal.wilczynski@intel.com> wrote:
> >>> Currently in ACPI code _OSC method is already used for workaround
> >>> introduced in commit a21211672c9a ("ACPI / processor: Request native
> >>> thermal interrupt handling via _OSC"). Create new function, similar to
> >>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
> >>> acpi_processor_osc(). Make this function fulfill the purpose previously
> >>> fulfilled by the workaround plus convey OSPM processor capabilities
> >>> with it by setting correct processor capability bits.
> >>>
> >>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>> ---
> >>>  arch/x86/include/asm/acpi.h   |  3 +++
> >>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
> >>>  include/acpi/pdc_intel.h      |  1 +
> >>>  3 files changed, 46 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> >>> index 6a498d1781e7..6c25ce2dad18 100644
> >>> --- a/arch/x86/include/asm/acpi.h
> >>> +++ b/arch/x86/include/asm/acpi.h
> >>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
> >>>         if (cpu_has(c, X86_FEATURE_ACPI))
> >>>                 *cap |= ACPI_PDC_T_FFH;
> >>>
> >>> +       if (cpu_has(c, X86_FEATURE_HWP))
> >>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
> >>> +
> >>>         /*
> >>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
> >>>          */
> >>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> >>> index 8c5d0295a042..0de0b05b6f53 100644
> >>> --- a/drivers/acpi/acpi_processor.c
> >>> +++ b/drivers/acpi/acpi_processor.c
> >>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
> >>>         dmi_check_system(processor_idle_dmi_table);
> >>>  }
> >>>
> >>> +/* vendor specific UUID indicating an Intel platform */
> >>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
> >>>  static bool acpi_hwp_native_thermal_lvt_set;
> >>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
> >>> +                                            void *context, void **rv)
> >>> +{
> >>> +       u32 capbuf[2] = {};
> >>> +       acpi_status status;
> >>> +       struct acpi_osc_context osc_context = {
> >>> +               .uuid_str = sb_uuid_str,
> >>> +               .rev = 1,
> >>> +               .cap.length = 8,
> >>> +               .cap.pointer = capbuf,
> >>> +       };
> >>> +
> >>> +       if (processor_physically_present(handle) == false)
> >> if (!processor_physically_present(handle))
> >>
> >>> +               return AE_OK;
> >>> +
> >>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
> >>> +
> >>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
> >>> +               capbuf[OSC_SUPPORT_DWORD] &=
> >>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> >>> +
> >>> +       status = acpi_run_osc(handle, &osc_context);
> >>> +       if (ACPI_FAILURE(status))
> >>> +               return status;
> >>> +
> >>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
> >>> +               u32 *capbuf_ret = osc_context.ret.pointer;
> >>> +
> >>> +               if (!acpi_hwp_native_thermal_lvt_set &&
> >>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
> >> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
> >> questionable.
> >>
> >> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
> >> calling acpi_run_osc().
> > So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
> > should also be checked by the arch code.  That is, add an arch
> > function to check if a given bit is set in the returned capabilities
> > buffer (passed as an argument).
>
> Hmm, maybe that's true, but the only reason we check that is so we can print
> a debug message

No, it is not the only reason.  The more important part is to set
acpi_hwp_native_thermal_lvt_set if it is still unset at that point.

>  - that's pretty much a leftover after a workaround. Introducing
> more arch code to accommodate this seemed wasteful, since in my understanding
> all workarounds are meant to be removed at some point, even if it takes a long time
> to do so.

Not really, until the systems needing them are in use.

> >
> > Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
> > should be set by the arch code too.
>
> That makes sense, but technically is also a workaround, since we're basically
> checking for some specific DMI's and then we disable mwait for them.

But boot_option_idle_override is set by the arch code, isn't it?

So the arch code may as well do the quirk in accordance with it.
