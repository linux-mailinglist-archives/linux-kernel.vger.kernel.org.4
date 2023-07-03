Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3A745FAD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGCPUw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGCPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:20:51 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCC114;
        Mon,  3 Jul 2023 08:20:49 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98dfd15aae1so136986266b.0;
        Mon, 03 Jul 2023 08:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397648; x=1690989648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfQmrdtiRaV3YOxAhu0dmvHAsxNJkBOfrxaE2K4st3E=;
        b=Ey/jQLgGpP+eldlqdBcf5uq0cAC8mp0o/6pGohItvF7xzAZFVXwDJJR+BuNCPU2pFq
         E7P9G/F/PbrKWelqJvbDeavIEnLNP4cdF8hPFBBOIwc439T9KGddj6cVk4moZTIFs4HH
         krQAqIzdkAQFsPdQJ9VF+LswpZGfhEZo5lWfA+fiQ8hSf1NVRNXc35t5PFhbz9mugJ5Q
         IbDKxWSg0ybvJf3KZYCOLUaQZZlo2gWh1sWstVilo/yPaYHD7yfqddKLdQU/JA1jVrou
         zETyOP+m5/EgAcCqqAQgy/CpvkjGsarZXhRiBu6ix3tk1cm4pnhridIZOSPW7LPPomPW
         2Kdg==
X-Gm-Message-State: ABy/qLZghZNVA/9gyOune0B7QTp5VnY8WRlz3ds2CXl8r9dYsBE1fY1t
        jcEeaqenB1fAHQu/P4fCoZYUOlNF8Saxm9u5ud+Nrl9M
X-Google-Smtp-Source: APBJJlFHLq8qnrjQ7Dyl45jE5tn08oL3qdtceY3KcjCAkXDDByUPOOODjbnHiIkb2KO0m372669bXlvodp2Sb7J7Y3I=
X-Received: by 2002:a17:906:eb15:b0:988:73e4:b781 with SMTP id
 mb21-20020a170906eb1500b0098873e4b781mr7392870ejb.2.1688397648123; Mon, 03
 Jul 2023 08:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com> <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <72ed8f32-8bfd-2d25-a377-9adbacdc8c61@intel.com> <527766ea-4d01-25e4-6e9a-42dd5bbaf650@intel.com>
In-Reply-To: <527766ea-4d01-25e4-6e9a-42dd5bbaf650@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Jul 2023 17:20:32 +0200
Message-ID: <CAJZ5v0j945mvukeBkYzT=twbz2tagtMUSWgZkAfvhEkeGOHMeQ@mail.gmail.com>
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

On Mon, Jul 3, 2023 at 10:54 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/30/2023 10:46 AM, Wilczynski, Michal wrote:
> > Hi,
> > Thanks for the review !
> >
> > On 6/29/2023 1:04 PM, Rafael J. Wysocki wrote:
> >> I would just say "Introduce acpi_processor_osc()" in the subject and
> >> then explain its role in the changelog.
> > Sure,
> >
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
> > Sure,
> >
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
> >> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
> >> calling acpi_run_osc().
> > We can add condition before checking capbuf_ret i.e
> >
> > if (capbuf[OSC_SUPPORT_DWORD] & ACPI_PDC_COLLAB_PROC_PERF &&
> >     osc_context.ret.pointer && osc_context.ret.length > 1)
> >
> >
> >>> +                       acpi_handle_info(handle,
> >>> +                                        "_OSC native thermal LVT Acked\n");
> >>> +                       acpi_hwp_native_thermal_lvt_set = true;
> >>> +               }
> >>> +       }
> >>> +       kfree(osc_context.ret.pointer);
> >>> +
> >>> +       return AE_OK;
> >>> +}
> >>> +
> >>>  static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
> >>>                                                           u32 lvl,
> >>>                                                           void *context,
> >>>                                                           void **rv)
> >>>  {
> >>> -       u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
> >>>         u32 capbuf[2];
> >>>         struct acpi_osc_context osc_context = {
> >>>                 .uuid_str = sb_uuid_str,
> >>> diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
> >>> index 967c552d1cd3..9427f639287f 100644
> >>> --- a/include/acpi/pdc_intel.h
> >>> +++ b/include/acpi/pdc_intel.h
> >>> @@ -16,6 +16,7 @@
> >>>  #define ACPI_PDC_C_C1_FFH              (0x0100)
> >>>  #define ACPI_PDC_C_C2C3_FFH            (0x0200)
> >>>  #define ACPI_PDC_SMP_P_HWCOORD         (0x0800)
> >>> +#define ACPI_PDC_COLLAB_PROC_PERF      (0x1000)
> >> I would call this ACPI_OSC_COLLAB_PROC_PERF to avoid confusion.
> >>
> >> It may also be a good idea to introduce ACPI_OSC_ symbols to replace
> >> the existing ACPI_PDC_ ones (with the same values, respectively) and
> >> get rid of the latter later.
> > Sure I can do that, most likely in a separate commit preceeding this one, so
> > it's easier to explain and review,
>
> Actually on a second thought, maybe instead of creating _OSC specifc constants it would
> be better to just generalize constant names ?

Yes, that would work too.

> As they're the same for both methods, they
> are not really method specific and could be called as follows:
>
> ACPI_PROC_CAP_C_C1_FFH
> ACPI_PROC_CAP_C_C2C3_FFH
>
> So instead of using OSC, or PDC, we just use PROC_CAP, which better explain what those bits
> mean at the end, and removes the hassle of removing those PDC specifc constants in some far
> away future.
>
> Please let me know your thoughts,

Yes, you can do that as far as I am concerned.
