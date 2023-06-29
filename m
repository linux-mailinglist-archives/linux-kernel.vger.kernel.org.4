Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488F742716
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjF2NQJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjF2NQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:16:07 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E82D7F;
        Thu, 29 Jun 2023 06:16:05 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98502b12fd4so17449566b.1;
        Thu, 29 Jun 2023 06:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044564; x=1690636564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vkSWvUrNl+oLJEnNoNMsdWAX2glN0vIGwzAPBB7JmU=;
        b=H9Q2Xkmx/4WnD/qzCGH5bcLF+BE0DZA37tNDz2hKb0P6T3bnXY8XYU+pnC8oc3lMsp
         /0Oq8kCFi1mLGuKlLldR+bs837kBlnTmr0DLYvFnem9vqw/tR2OE2cwaHpFZErpDxtuS
         bHEzuUKhMNNno5GHekv2oenfZ9JljcFkBv2yYhfR3d2Qfm1vFDF+pXs994fopwXMrrUy
         a80oUo7yDN4/bBQFWcuqH2VPT9MZ/sqyG6ZUITlhuUQlpU/zlIm8++ncSpKnK7ZQnSdl
         nhKIUH5pOecYmbYMUK2uGrlpQ9pxAeYd7L5UjGNjK/shZTLDhFnmCJDoSd8zcJxiLHCW
         At0w==
X-Gm-Message-State: AC+VfDynLypMLM0UyxWlmrh8Lad/ma8HznmzAIe4ROTr3t1cQWfGIFSG
        QzRJsyuPtY5Q/XhR+sNH4KwaZKuJB2PQvndIafw=
X-Google-Smtp-Source: APBJJlEGCVZZPs+CnpuUGaibrPAMixMScqEvN0TZv+J/uu9bMiRu80B4KzZ3qrUr1rooguaMPijtRYKIwM2OuAOU+xM=
X-Received: by 2002:a17:906:64d5:b0:982:9a08:60 with SMTP id
 p21-20020a17090664d500b009829a080060mr2007442ejn.3.1688044564098; Thu, 29 Jun
 2023 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com> <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 15:15:53 +0200
Message-ID: <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] acpi: Introduce new function callback for _OSC
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

On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> I would just say "Introduce acpi_processor_osc()" in the subject and
> then explain its role in the changelog.
>
> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
> >
> > Currently in ACPI code _OSC method is already used for workaround
> > introduced in commit a21211672c9a ("ACPI / processor: Request native
> > thermal interrupt handling via _OSC"). Create new function, similar to
> > already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
> > acpi_processor_osc(). Make this function fulfill the purpose previously
> > fulfilled by the workaround plus convey OSPM processor capabilities
> > with it by setting correct processor capability bits.
> >
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/include/asm/acpi.h   |  3 +++
> >  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
> >  include/acpi/pdc_intel.h      |  1 +
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index 6a498d1781e7..6c25ce2dad18 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
> >         if (cpu_has(c, X86_FEATURE_ACPI))
> >                 *cap |= ACPI_PDC_T_FFH;
> >
> > +       if (cpu_has(c, X86_FEATURE_HWP))
> > +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
> > +
> >         /*
> >          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
> >          */
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index 8c5d0295a042..0de0b05b6f53 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
> >         dmi_check_system(processor_idle_dmi_table);
> >  }
> >
> > +/* vendor specific UUID indicating an Intel platform */
> > +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
> >  static bool acpi_hwp_native_thermal_lvt_set;
> > +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
> > +                                            void *context, void **rv)
> > +{
> > +       u32 capbuf[2] = {};
> > +       acpi_status status;
> > +       struct acpi_osc_context osc_context = {
> > +               .uuid_str = sb_uuid_str,
> > +               .rev = 1,
> > +               .cap.length = 8,
> > +               .cap.pointer = capbuf,
> > +       };
> > +
> > +       if (processor_physically_present(handle) == false)
>
> if (!processor_physically_present(handle))
>
> > +               return AE_OK;
> > +
> > +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
> > +
> > +       if (boot_option_idle_override == IDLE_NOMWAIT)
> > +               capbuf[OSC_SUPPORT_DWORD] &=
> > +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> > +
> > +       status = acpi_run_osc(handle, &osc_context);
> > +       if (ACPI_FAILURE(status))
> > +               return status;
> > +
> > +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
> > +               u32 *capbuf_ret = osc_context.ret.pointer;
> > +
> > +               if (!acpi_hwp_native_thermal_lvt_set &&
> > +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
>
> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
> questionable.
>
> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
> calling acpi_run_osc().

So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
should also be checked by the arch code.  That is, add an arch
function to check if a given bit is set in the returned capabilities
buffer (passed as an argument).

Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
should be set by the arch code too.

>
> > +                       acpi_handle_info(handle,
> > +                                        "_OSC native thermal LVT Acked\n");
> > +                       acpi_hwp_native_thermal_lvt_set = true;
> > +               }
> > +       }
> > +       kfree(osc_context.ret.pointer);
> > +
> > +       return AE_OK;
> > +}
> > +
> >  static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
> >                                                           u32 lvl,
> >                                                           void *context,
> >                                                           void **rv)
> >  {
> > -       u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
> >         u32 capbuf[2];
> >         struct acpi_osc_context osc_context = {
> >                 .uuid_str = sb_uuid_str,
> > diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
> > index 967c552d1cd3..9427f639287f 100644
> > --- a/include/acpi/pdc_intel.h
> > +++ b/include/acpi/pdc_intel.h
> > @@ -16,6 +16,7 @@
> >  #define ACPI_PDC_C_C1_FFH              (0x0100)
> >  #define ACPI_PDC_C_C2C3_FFH            (0x0200)
> >  #define ACPI_PDC_SMP_P_HWCOORD         (0x0800)
> > +#define ACPI_PDC_COLLAB_PROC_PERF      (0x1000)
>
> I would call this ACPI_OSC_COLLAB_PROC_PERF to avoid confusion.
>
> It may also be a good idea to introduce ACPI_OSC_ symbols to replace
> the existing ACPI_PDC_ ones (with the same values, respectively) and
> get rid of the latter later.
>
> >  #define ACPI_PDC_EST_CAPABILITY_SMP    (ACPI_PDC_SMP_C1PT | \
> >                                          ACPI_PDC_C_C1_HALT | \
> > --
