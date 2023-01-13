Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA166A388
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjAMTmC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Jan 2023 14:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjAMTlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:41:14 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F788DF1;
        Fri, 13 Jan 2023 11:40:28 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id tz12so54626283ejc.9;
        Fri, 13 Jan 2023 11:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FynnHHA+adKoY+qySCCuC0I0OWwcsOl+qYyvsB5YSU=;
        b=zP7FlaseX03BH5f2Jp9FNJA2yTzTFOoIsizCcGHqpm40U+/r5arIJwGd575Z/VX6Bo
         xDrE7rzETphapjeQ7300AenvUGJyHGL/dR60C3GdfFlJbYk+8Z+aWQe7LFYLOQNxjuCk
         hXIlsQjw0ggWE3Yo8NKEM0dW9J/4LyVpaNoQJOjhmGINCYSqBxkyHPSDSobeKscFEJ1Q
         Etp1CwsIoaiAZZZk3j2W8gRpq0X2OC86LyLWV6B3qsLkiodFQGYFXDoxdzXgICUPAT1/
         fvgSNhRtJPYYH/7YyN9ByM2s/2UME+UMe2AtpBQPUpy2FovHCrxxr2Q6LarBABLZPWuL
         ijaA==
X-Gm-Message-State: AFqh2kp/UnKnPwXh3x6iWUI4HnQG/CstwqsEzD5SmmScyWwZPhiiYJnV
        jajAE1Gw4aJYxv5BYR79O/4CctoKQaAykiG5bwTBhiut
X-Google-Smtp-Source: AMrXdXvn2X6x4HoxAN6K2w1MSEvmKDvbqX2OyOqsOjj0s6TYIEhLLev1mfoqRKdTYIEqIwH2b1rnxH1eGYQbqtwdUl8=
X-Received: by 2002:a17:907:29c3:b0:84d:4b8e:efc with SMTP id
 ev3-20020a17090729c300b0084d4b8e0efcmr1445143ejc.390.1673638826641; Fri, 13
 Jan 2023 11:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20230113140610.7132-1-jgross@suse.com>
In-Reply-To: <20230113140610.7132-1-jgross@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 20:40:15 +0100
Message-ID: <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 3:06 PM Juergen Gross <jgross@suse.com> wrote:
>
> Commit f1e525009493 ("x86/boot: Skip realmode init code when running as
> Xen PV guest") missed one code path accessing real_mode_header, leading
> to dereferencing NULL when suspending the system under Xen:
>
>     [  348.284004] PM: suspend entry (deep)
>     [  348.289532] Filesystems sync: 0.005 seconds
>     [  348.291545] Freezing user space processes ... (elapsed 0.000 seconds) done.
>     [  348.292457] OOM killer disabled.
>     [  348.292462] Freezing remaining freezable tasks ... (elapsed 0.104 seconds) done.
>     [  348.396612] printk: Suspending console(s) (use no_console_suspend to debug)
>     [  348.749228] PM: suspend devices took 0.352 seconds
>     [  348.769713] ACPI: EC: interrupt blocked
>     [  348.816077] BUG: kernel NULL pointer dereference, address: 000000000000001c
>     [  348.816080] #PF: supervisor read access in kernel mode
>     [  348.816081] #PF: error_code(0x0000) - not-present page
>     [  348.816083] PGD 0 P4D 0
>     [  348.816086] Oops: 0000 [#1] PREEMPT SMP NOPTI
>     [  348.816089] CPU: 0 PID: 6764 Comm: systemd-sleep Not tainted 6.1.3-1.fc32.qubes.x86_64 #1
>     [  348.816092] Hardware name: Star Labs StarBook/StarBook, BIOS 8.01 07/03/2022
>     [  348.816093] RIP: e030:acpi_get_wakeup_address+0xc/0x20
>
> Fix that by adding an indirection for acpi_get_wakeup_address() which
> Xen PV dom0 can use to return a dummy non-zero wakeup address (this
> address won't ever be used, as the real suspend handling is done by the
> hypervisor).

How exactly does this help?

> Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/acpi.h  | 2 +-
>  arch/x86/kernel/acpi/sleep.c | 3 ++-
>  include/xen/acpi.h           | 9 +++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 65064d9f7fa6..137259ff8f03 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -61,7 +61,7 @@ static inline void acpi_disable_pci(void)
>  extern int (*acpi_suspend_lowlevel)(void);
>
>  /* Physical address to resume after wakeup */
> -unsigned long acpi_get_wakeup_address(void);
> +extern unsigned long (*acpi_get_wakeup_address)(void);
>
>  /*
>   * Check if the CPU can handle C2 and deeper
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 3b7f4cdbf2e0..1a3cd5e24cd0 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -33,10 +33,11 @@ static char temp_stack[4096];
>   * Returns the physical address where the kernel should be resumed after the
>   * system awakes from S3, e.g. for programming into the firmware waking vector.
>   */
> -unsigned long acpi_get_wakeup_address(void)
> +static unsigned long x86_acpi_get_wakeup_address(void)
>  {
>         return ((unsigned long)(real_mode_header->wakeup_start));
>  }
> +unsigned long (*acpi_get_wakeup_address)(void) = x86_acpi_get_wakeup_address;
>
>  /**
>   * x86_acpi_enter_sleep_state - enter sleep state
> diff --git a/include/xen/acpi.h b/include/xen/acpi.h
> index b1e11863144d..7e1e5dbfb77c 100644
> --- a/include/xen/acpi.h
> +++ b/include/xen/acpi.h
> @@ -56,6 +56,12 @@ static inline int xen_acpi_suspend_lowlevel(void)
>         return 0;
>  }
>
> +static inline unsigned long xen_acpi_get_wakeup_address(void)
> +{
> +       /* Just return a dummy non-zero value, it will never be used. */
> +       return 1;
> +}
> +
>  static inline void xen_acpi_sleep_register(void)
>  {
>         if (xen_initial_domain()) {
> @@ -65,6 +71,9 @@ static inline void xen_acpi_sleep_register(void)
>                         &xen_acpi_notify_hypervisor_extended_sleep);
>
>                 acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
> +#ifdef CONFIG_ACPI_SLEEP
> +               acpi_get_wakeup_address = xen_acpi_get_wakeup_address;
> +#endif
>         }
>  }
>  #else
> --
> 2.35.3
>
