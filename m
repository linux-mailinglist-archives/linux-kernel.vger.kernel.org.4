Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBB66E404
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAQQrr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Jan 2023 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjAQQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:47:31 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33686B3;
        Tue, 17 Jan 2023 08:47:26 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id v10so44693314edi.8;
        Tue, 17 Jan 2023 08:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW1lWHP2SnntF7BPwVjstED8maTOD84cMu75qGigYkU=;
        b=jV/SjsjtGYaBABWLA+XVvyGa6sZS18MD4qHR26c2hTLYFdj1TXK3+RWdfqJRVAH+lz
         pzspVbE8OaIweEwYyCN6VyPtMWm9Qv6xYX0Qix0VjvIyw8R6oT0pLJpvGp0m3UJRuz1J
         xSix9i+v8FIpB74TLA2E+2+oWOkObQMUkxYVlN69hQoWixmXlHmaPDmIKb0tAXaYuJ41
         DIssz/XOjuUi3Jy8BNIci01hddDx0cZoAHRxAThK3NTjR6b1pKRb/gWtKy/HlIYAwvNM
         A5ZUUUHc7NGmslRTFhYJWH/s977BRJqsi/i4qXVR9RGafLmveD/N/3RClajR4bZKKckZ
         /Jbg==
X-Gm-Message-State: AFqh2kpsMem6Gq5RFWLnLl5fHbkrTCm+r1WIgdRYBx3vXvPi1umSPUnd
        SIjyTW5MutWetbIybgI6OOEPKR0J+1oBlE/JR1s=
X-Google-Smtp-Source: AMrXdXs33uPygCWA6d+K8cs5n+Ubw1HA4Oysng1ssnvF0dYOab252cMqJ0bUWCEg6Ur3BYBJwOdSKL1TIESwydq5t9Y=
X-Received: by 2002:aa7:c3cb:0:b0:499:c651:625d with SMTP id
 l11-20020aa7c3cb000000b00499c651625dmr427388edr.413.1673974044780; Tue, 17
 Jan 2023 08:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20230117155724.22940-1-jgross@suse.com>
In-Reply-To: <20230117155724.22940-1-jgross@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 17:47:13 +0100
Message-ID: <CAJZ5v0iCAT2W-m1T-v1wSBw+GQerhMAp1hT6SioJ53RQY=oA3g@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: fix suspend with Xen PV
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
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

On Tue, Jan 17, 2023 at 4:57 PM Juergen Gross <jgross@suse.com> wrote:
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
> Fix that by adding an optional acpi callback allowing to skip setting
> the wakeup address, as in the Xen PV case this will be handled by the
> hypervisor anyway.
>
> Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new approach, avoid calling acpi_get_wakeup_address()

I'll queue this up for 6.3 if the x86 people don't object.

Thanks!

> ---
>  arch/x86/include/asm/acpi.h | 8 ++++++++
>  drivers/acpi/sleep.c        | 6 +++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 65064d9f7fa6..8eb74cf386db 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -14,6 +14,7 @@
>  #include <asm/mmu.h>
>  #include <asm/mpspec.h>
>  #include <asm/x86_init.h>
> +#include <asm/cpufeature.h>
>
>  #ifdef CONFIG_ACPI_APEI
>  # include <asm/pgtable_types.h>
> @@ -63,6 +64,13 @@ extern int (*acpi_suspend_lowlevel)(void);
>  /* Physical address to resume after wakeup */
>  unsigned long acpi_get_wakeup_address(void);
>
> +static inline bool acpi_skip_set_wakeup_address(void)
> +{
> +       return cpu_feature_enabled(X86_FEATURE_XENPV);
> +}
> +
> +#define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
> +
>  /*
>   * Check if the CPU can handle C2 and deeper
>   */
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 0b557c0d405e..4ca667251272 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -60,13 +60,17 @@ static struct notifier_block tts_notifier = {
>         .priority       = 0,
>  };
>
> +#ifndef acpi_skip_set_wakeup_address
> +#define acpi_skip_set_wakeup_address() false
> +#endif
> +
>  static int acpi_sleep_prepare(u32 acpi_state)
>  {
>  #ifdef CONFIG_ACPI_SLEEP
>         unsigned long acpi_wakeup_address;
>
>         /* do we have a wakeup address for S2 and S3? */
> -       if (acpi_state == ACPI_STATE_S3) {
> +       if (acpi_state == ACPI_STATE_S3 && !acpi_skip_set_wakeup_address()) {
>                 acpi_wakeup_address = acpi_get_wakeup_address();
>                 if (!acpi_wakeup_address)
>                         return -EFAULT;
> --
