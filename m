Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB11745FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGCPXC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGCPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:23:01 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDBE41;
        Mon,  3 Jul 2023 08:22:59 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98de322d11fso139521866b.1;
        Mon, 03 Jul 2023 08:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397778; x=1690989778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERY5PV5pCbuytfRjgkX+2Z64R3k3HF/gXkqzwLCPKzI=;
        b=Z8Gly/21a/zU1WE0fG8V+aygdNTYOOP2W+QunZld9m8NrUguoVMZADEp63avQKL24L
         HjuueK7gVciwb8NLhPP/gnPrcAnuRCRbyKtY7Yerx4MZxJ+GP726FSfHy5JQO/Udj6OY
         +g9f48/DPQE1NYbHFQ5pRbmrHXp9IfFKsKGW03WLHnSgrzfsbNpUsbgrL86KX1wPp5t/
         2C09HkT4DiSwbJgjFR/QKDbxiwvazp/LJchF9aY4XfiQCaDyhtofmTfR4oXLiwiLH4u9
         mopdx0HArrHhvAxku2gU+MpazRktYkAFbOH2sM3JkROo8FYaVjcg4rVXm9Cv8u2NluWZ
         GzHA==
X-Gm-Message-State: ABy/qLanglrHI5GB8qilETscRH7VmfXlrFiXo4WoVtRcZ/siJ//g3ShG
        XnHUqEfJBvwEVbb+FnbpcT4Jp+4vvqzGODopFUw=
X-Google-Smtp-Source: APBJJlHCwfla3u91upzUf7jJun8IXD1eAGcNyg9TnVB0nlGKd97C9WxAW3AeD70x2VoEyDyQnz4cBSOpTH8dvV1Mh08=
X-Received: by 2002:a17:906:ccc3:b0:98e:46f:3eab with SMTP id
 ot3-20020a170906ccc300b0098e046f3eabmr8659568ejb.6.1688397778159; Mon, 03 Jul
 2023 08:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
 <20230613161034.3496047-4-michal.wilczynski@intel.com> <CAJZ5v0j+Wz7366kLT3ez5TNoGWXvsa53hBYYeS=aHgbTJUqvKg@mail.gmail.com>
 <CAJZ5v0gWuU1JPbzYpDZ6YQ4YNydyELQ9tXKcJgmLwe_=fZ521A@mail.gmail.com>
 <e94c0d23-4873-5c34-be24-c2208d03043f@intel.com> <CAJZ5v0h3mNFa4P+5o=LtUvTW4VnJs=4SJxvjoYMKCeir4tXfpQ@mail.gmail.com>
 <ba919f97-894f-8fd3-fdda-1f170c2a6fe6@intel.com> <62790f91-db75-fb8c-dec0-7354e299c89b@intel.com>
In-Reply-To: <62790f91-db75-fb8c-dec0-7354e299c89b@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Jul 2023 17:22:42 +0200
Message-ID: <CAJZ5v0iO06oYfsFcv71H7ZshPgwEqYH+wxHrWTp=iOZ3bBOsQg@mail.gmail.com>
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

On Mon, Jul 3, 2023 at 11:52 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/30/2023 11:23 AM, Wilczynski, Michal wrote:
> >
> > On 6/30/2023 11:10 AM, Rafael J. Wysocki wrote:
> >> On Fri, Jun 30, 2023 at 11:02 AM Wilczynski, Michal
> >> <michal.wilczynski@intel.com> wrote:
> >>>
> >>> On 6/29/2023 3:15 PM, Rafael J. Wysocki wrote:
> >>>> On Thu, Jun 29, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>>> I would just say "Introduce acpi_processor_osc()" in the subject and
> >>>>> then explain its role in the changelog.
> >>>>>
> >>>>> On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
> >>>>> <michal.wilczynski@intel.com> wrote:
> >>>>>> Currently in ACPI code _OSC method is already used for workaround
> >>>>>> introduced in commit a21211672c9a ("ACPI / processor: Request native
> >>>>>> thermal interrupt handling via _OSC"). Create new function, similar to
> >>>>>> already existing acpi_hwp_native_thermal_lvt_osc(). Call new function
> >>>>>> acpi_processor_osc(). Make this function fulfill the purpose previously
> >>>>>> fulfilled by the workaround plus convey OSPM processor capabilities
> >>>>>> with it by setting correct processor capability bits.
> >>>>>>
> >>>>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>>>> ---
> >>>>>>  arch/x86/include/asm/acpi.h   |  3 +++
> >>>>>>  drivers/acpi/acpi_processor.c | 43 ++++++++++++++++++++++++++++++++++-
> >>>>>>  include/acpi/pdc_intel.h      |  1 +
> >>>>>>  3 files changed, 46 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> >>>>>> index 6a498d1781e7..6c25ce2dad18 100644
> >>>>>> --- a/arch/x86/include/asm/acpi.h
> >>>>>> +++ b/arch/x86/include/asm/acpi.h
> >>>>>> @@ -112,6 +112,9 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
> >>>>>>         if (cpu_has(c, X86_FEATURE_ACPI))
> >>>>>>                 *cap |= ACPI_PDC_T_FFH;
> >>>>>>
> >>>>>> +       if (cpu_has(c, X86_FEATURE_HWP))
> >>>>>> +               *cap |= ACPI_PDC_COLLAB_PROC_PERF;
> >>>>>> +
> >>>>>>         /*
> >>>>>>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
> >>>>>>          */
> >>>>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> >>>>>> index 8c5d0295a042..0de0b05b6f53 100644
> >>>>>> --- a/drivers/acpi/acpi_processor.c
> >>>>>> +++ b/drivers/acpi/acpi_processor.c
> >>>>>> @@ -591,13 +591,54 @@ void __init processor_dmi_check(void)
> >>>>>>         dmi_check_system(processor_idle_dmi_table);
> >>>>>>  }
> >>>>>>
> >>>>>> +/* vendor specific UUID indicating an Intel platform */
> >>>>>> +static u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
> >>>>>>  static bool acpi_hwp_native_thermal_lvt_set;
> >>>>>> +static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
> >>>>>> +                                            void *context, void **rv)
> >>>>>> +{
> >>>>>> +       u32 capbuf[2] = {};
> >>>>>> +       acpi_status status;
> >>>>>> +       struct acpi_osc_context osc_context = {
> >>>>>> +               .uuid_str = sb_uuid_str,
> >>>>>> +               .rev = 1,
> >>>>>> +               .cap.length = 8,
> >>>>>> +               .cap.pointer = capbuf,
> >>>>>> +       };
> >>>>>> +
> >>>>>> +       if (processor_physically_present(handle) == false)
> >>>>> if (!processor_physically_present(handle))
> >>>>>
> >>>>>> +               return AE_OK;
> >>>>>> +
> >>>>>> +       arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
> >>>>>> +
> >>>>>> +       if (boot_option_idle_override == IDLE_NOMWAIT)
> >>>>>> +               capbuf[OSC_SUPPORT_DWORD] &=
> >>>>>> +                       ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> >>>>>> +
> >>>>>> +       status = acpi_run_osc(handle, &osc_context);
> >>>>>> +       if (ACPI_FAILURE(status))
> >>>>>> +               return status;
> >>>>>> +
> >>>>>> +       if (osc_context.ret.pointer && osc_context.ret.length > 1) {
> >>>>>> +               u32 *capbuf_ret = osc_context.ret.pointer;
> >>>>>> +
> >>>>>> +               if (!acpi_hwp_native_thermal_lvt_set &&
> >>>>>> +                   capbuf_ret[1] & ACPI_PDC_COLLAB_PROC_PERF) {
> >>>>> Checking it in capbuf_ret[] if it was not set in capbuf[] is sort of
> >>>>> questionable.
> >>>>>
> >>>>> Note that acpi_hwp_native_thermal_lvt_osc() sets it in capbuf[] before
> >>>>> calling acpi_run_osc().
> >>>> So you moved setting it to arch_acpi_set_proc_cap_bits(), but then it
> >>>> should also be checked by the arch code.  That is, add an arch
> >>>> function to check if a given bit is set in the returned capabilities
> >>>> buffer (passed as an argument).
> >>> Hmm, maybe that's true, but the only reason we check that is so we can print
> >>> a debug message
> >> No, it is not the only reason.  The more important part is to set
> >> acpi_hwp_native_thermal_lvt_set if it is still unset at that point.
> > Yeah, that too. Okay I'll modify the code
> >
> >>>  - that's pretty much a leftover after a workaround. Introducing
> >>> more arch code to accommodate this seemed wasteful, since in my understanding
> >>> all workarounds are meant to be removed at some point, even if it takes a long time
> >>> to do so.
> >> Not really, until the systems needing them are in use.
> > Yeah I suspect it might take a very long time, and I guess it's very hard to definitely
> > say that some piece of hardware is not used by **anyone**
> >
> >>>> Also it can be argued that ACPI_PDC_C_C2C3_FFH and ACPI_PDC_C_C1_FFH
> >>>> should be set by the arch code too.
> >>> That makes sense, but technically is also a workaround, since we're basically
> >>> checking for some specific DMI's and then we disable mwait for them.
> >> But boot_option_idle_override is set by the arch code, isn't it?
> >>
> >> So the arch code may as well do the quirk in accordance with it.
> > I think so, I'll modify the code to move setting those bits to the arch part
>
> I looked into that, and I'm still not sure whether setting those constants in arch
> specific code is a good idea. Basically OSC and PDC are supported on two architectures
> ia64 and x86, so that would introduce unnecessary code duplication, as this mechanic
> is present regardless of an architecture, and in this particular case boot_option_idle_override
> is set by acpi_processor.c function set_no_mwait().

Which is x86-specific AFAICS.

> One could argue theoretically that system defined in processor_dmi_table[] is an x86 so there
> is no need to add any logic to ia64,

Good observation!

> but to me this is confusing.

Why is it so?

> If we have a workaround in the acpi_processor, maybe entire workaround should stay there
> instead of dragging innocent arch code into it.

And maybe it would be better to move it to arch code as a whole.
