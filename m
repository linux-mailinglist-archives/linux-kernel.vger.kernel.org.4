Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555A62A1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKOTY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKOTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:23:51 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88C28E03;
        Tue, 15 Nov 2022 11:23:47 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id w4so9401827qts.0;
        Tue, 15 Nov 2022 11:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj9GT3yeaJ+1l8EwvP38304uvjF7UaH6epnhsrImyBY=;
        b=yk74h5LC5OZuwYn5LTJK3ymrP5413A5FV6c07aBSbgZE5OS06qCTbftLWaK8XI4UHO
         r6qCzIEjEn1R3te167JVeC+isaUVywBGddMHhrP2Jd0/8Gt9i82o0dzi1ZmrE1bg5Fd4
         NspX2Nfy+z86WvfEcSUQFUXuqHL5A5EmReLT5wLdsEsYdd4penwi1loqyQzRN8ZvYToN
         BZRgdJTyjaf51HgekvsflIl3hH/x/itx5mpM11QIpiW9zvd4IrlDQocybE2+Pn0Nrr2J
         Aer5d3IvtXebO+70W9l8zl7rhev3Ziv320Svr3ECYwDZqcDLWfU9K/8Rla3WnbE/vB3W
         MYIQ==
X-Gm-Message-State: ANoB5pljMyqTiScWfI8PZkrfpuACuv7tnR6mdjeNb6XreTMcl2mmkn1v
        +4DOoQ8o35m1XQzbwteMQhwSp2mqqaR4LNPz2/U=
X-Google-Smtp-Source: AA0mqf5fmuFpnTx06WSKdRXpsiE8iuVJpR7CUUyVfcwKM3VifMDMHVWO3vjKKsgJ5S88U/x1SZ9Wchp97do3sl99ESA=
X-Received: by 2002:ac8:5198:0:b0:3a5:1e6f:7e05 with SMTP id
 c24-20020ac85198000000b003a51e6f7e05mr18074256qtn.357.1668540226845; Tue, 15
 Nov 2022 11:23:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668539735.git.pawan.kumar.gupta@linux.intel.com> <c24db75d69df6e66c0465e13676ad3f2837a2ed8.1668539735.git.pawan.kumar.gupta@linux.intel.com>
In-Reply-To: <c24db75d69df6e66c0465e13676ad3f2837a2ed8.1668539735.git.pawan.kumar.gupta@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Nov 2022 20:23:35 +0100
Message-ID: <CAJZ5v0j6GBAx-UTTx2Oe1Y+bwpRuqifoNx4vBu1Vi9K93TS9JA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>, thomas.lendacky@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>, hdegoede@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David.Kaplan@amd.com, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 8:17 PM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> pm_save_spec_msr() keeps a list of all the MSRs which _might_ need to be
> saved and restored at hibernate and resume.  However, it has zero
> awareness of CPU support for these MSRs.  It mostly works by
> unconditionally attempting to manipulate these MSRs and relying on
> rdmsrl_safe() being able to handle a #GP on CPUs where the support is
> unavailable.
>
> However, it's possible for reads (RDMSR) to be supported for a given MSR
> while writes (WRMSR) are not.  In this case, msr_build_context() sees a
> successful read (RDMSR) and marks the MSR as 'valid'.  Then, later, a
> write (WRMSR) fails, producing a nasty (but harmless) error message.
> This causes restore_processor_state() to try and restore it, but writing
> this MSR is not allowed on the Intel Atom N2600 leading to:
>
>   unchecked MSR access error: WRMSR to 0x122 (tried to write 0x0000000000000002) \
>      at rIP: 0xffffffff8b07a574 (native_write_msr+0x4/0x20)
>   Call Trace:
>    <TASK>
>    restore_processor_state
>    x86_acpi_suspend_lowlevel
>    acpi_suspend_enter
>    suspend_devices_and_enter
>    pm_suspend.cold
>    state_store
>    kernfs_fop_write_iter
>    vfs_write
>    ksys_write
>    do_syscall_64
>    ? do_syscall_64
>    ? up_read
>    ? lock_is_held_type
>    ? asm_exc_page_fault
>    ? lockdep_hardirqs_on
>    entry_SYSCALL_64_after_hwframe
>
> To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
> trying to manipulate the MSR when the feature bit is clear. This
> required adding a X86_FEATURE bit for MSRs that do not have one already,
> but it's a small price to pay.
>
> Fixes: 73924ec4d560 ("x86/pm: Save the MSR validity status at context setup")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: stable@kernel.org

Fine with me:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/power/cpu.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 4cd39f304e20..11a7e28f8985 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -511,18 +511,27 @@ static int pm_cpu_check(const struct x86_cpu_id *c)
>         return ret;
>  }
>
> +struct msr_enumeration {
> +       u32 msr_no;
> +       u32 feature;
> +};
> +
>  static void pm_save_spec_msr(void)
>  {
> -       u32 spec_msr_id[] = {
> -               MSR_IA32_SPEC_CTRL,
> -               MSR_IA32_TSX_CTRL,
> -               MSR_TSX_FORCE_ABORT,
> -               MSR_IA32_MCU_OPT_CTRL,
> -               MSR_AMD64_LS_CFG,
> -               MSR_AMD64_DE_CFG,
> +       struct msr_enumeration msr_enum[] = {
> +               {MSR_IA32_SPEC_CTRL,    X86_FEATURE_MSR_SPEC_CTRL},
> +               {MSR_IA32_TSX_CTRL,     X86_FEATURE_MSR_TSX_CTRL},
> +               {MSR_TSX_FORCE_ABORT,   X86_FEATURE_TSX_FORCE_ABORT},
> +               {MSR_IA32_MCU_OPT_CTRL, X86_FEATURE_SRBDS_CTRL},
> +               {MSR_AMD64_LS_CFG,      X86_FEATURE_LS_CFG_SSBD},
> +               {MSR_AMD64_DE_CFG,      X86_FEATURE_LFENCE_RDTSC},
>         };
> +       int i;
>
> -       msr_build_context(spec_msr_id, ARRAY_SIZE(spec_msr_id));
> +       for (i = 0; i < ARRAY_SIZE(msr_enum); i++) {
> +               if (boot_cpu_has(msr_enum[i].feature))
> +                       msr_build_context(&msr_enum[i].msr_no, 1);
> +       }
>  }
>
>  static int pm_check_save_msr(void)
> --
> 2.37.3
>
