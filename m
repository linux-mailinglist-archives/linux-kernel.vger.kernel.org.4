Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B726B75D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCMLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCMLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:20:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6213846149
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:20:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e11so4853954ioe.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678706413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f14X/ekEJo+asb6jqyI54N+VrZQu/Re9k1fW8wvqQYw=;
        b=dDpkCQjCEQNLOe06vuZIhG37ptpxvNEUZQX95Els71aXO1uScK4eIp9QUYf47WPtfj
         L4EnyXa1Q2WnUe7pCwNgxarswcrSCsCsAqQz7qfbSDcnVQyq9FebFAuuj+HECheDiAM8
         mnb5bdkOgHxfZxrnrCG7vwlcqZGk1OZX2aMcegehjp59Uhfs6I39miG8qefiWdOtMOJG
         sRdyu3hkkBOBaFYSllNatGNxcLFqYbNsNzIyZFei/okKCcaZtbNhsWkg7t8o4LKEHdAU
         ppihNtmO5JPQEQmLwgdwjU6R+YBufoTQDvGiyW+z46nWoJkAalwRCaAVUpHnUk/hFVfd
         fAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f14X/ekEJo+asb6jqyI54N+VrZQu/Re9k1fW8wvqQYw=;
        b=FIgH01QBg+t7+cCB0kaOS8771qq3/OmgBTov7w0yZAj8Fcjl2BzexuuCMCEj8cp/eT
         CYP55qstAy+IqbYPfdEWHFVt/lTV2FON+glJpE/r7xSM3gisbZ24VHj5LqoMDJvVOKFt
         1kNYVqh5670PzauVrk9VI2/lT2V4Y1TSTAgkM8VV9oDjT7uFkLMIuAFRHyuswU6EP2iZ
         m7v0Bk31c3wQwBgU/z3eB1nB2DAyC5vMQYrHIBVJdiso1QKcMZP7bTceQyKQmPtjF+vj
         BDbRidH0tp0devwmieyaeWW9mH86UBrzSfw9lFfAdRXJdB7DCxhswLG9AJtBRrADNImT
         8agQ==
X-Gm-Message-State: AO0yUKWEhuLJqglFcim7iz0G3Av/Co3XVN/NJIzgeUfGMcOR1mokuFNZ
        0/CY9kfmK1R5oVpipR2Zvea5bEb0ClVoiAxYMaQBgw==
X-Google-Smtp-Source: AK7set8eVMHzIuMBDjI5u2wavk90AJblFVUQXM4XRES39Jwqll7FfoTGU6xf4sNQgbJqww9hGeqGmIlJI1wpe42oA+c=
X-Received: by 2002:a02:634e:0:b0:3e5:a7d9:17f0 with SMTP id
 j75-20020a02634e000000b003e5a7d917f0mr15783958jac.4.1678706413368; Mon, 13
 Mar 2023 04:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <bc919c144f8684a7fd9ba70c356ac2a75e775e29.1678491668.git.andreyknvl@google.com>
 <59f433e00f7fa985e8bf9f7caf78574db16b67ab.1678491668.git.andreyknvl@google.com>
In-Reply-To: <59f433e00f7fa985e8bf9f7caf78574db16b67ab.1678491668.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 13 Mar 2023 12:19:30 +0100
Message-ID: <CANpmjNMpjREcMc2iUS2ycUih9SRbP93mUaNPXcDZAd-ZDT2d+g@mail.gmail.com>
Subject: Re: [PATCH 5/5] kasan: suppress recursive reports for HW_TAGS
To:     andrey.konovalov@linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 00:43, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> KASAN suppresses reports for bad accesses done by the KASAN reporting
> code. The reporting code might access poisoned memory for reporting
> purposes.
>
> Software KASAN modes do this by suppressing reports during reporting
> via current->kasan_depth, the same way they suppress reports during
> accesses to poisoned slab metadata.
>
> Hardware Tag-Based KASAN does not use current->kasan_depth, and instead
> resets pointer tags for accesses to poisoned memory done by the reporting
> code.
>
> Despite that, a recursive report can still happen:
>
> 1. On hardware with faulty MTE support. This was observed by Weizhao
>    Ouyang on a faulty hardware that caused memory tags to randomly change
>    from time to time.
>
> 2. Theoretically, due to a previous MTE-undetected memory corruption.
>
> A recursive report can happen via:
>
> 1. Accessing a pointer with a non-reset tag in the reporting code, e.g.
>    slab->slab_cache, which is what Weizhao Ouyang observed.
>
> 2. Theoretically, via external non-annotated routines, e.g. stackdepot.
>
> To resolve this issue, resetting tags for all of the pointers in the
> reporting code and all the used external routines would be impractical.
>
> Instead, disable tag checking done by the CPU for the duration of KASAN
> reporting for Hardware Tag-Based KASAN.
>
> Without this fix, Hardware Tag-Based KASAN reporting code might deadlock.
>
> Fixes: 2e903b914797 ("kasan, arm64: implement HW_TAGS runtime")
> Reported-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Considering that 1. the bug this patch fixes was only observed on faulty
> MTE hardware, and 2. the patch depends on the other patches in this series,
> I don't think it's worth backporting it into stable.
> ---
>  mm/kasan/report.c | 59 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 89078f912827..77a88d85c0a7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -72,10 +72,18 @@ static int __init kasan_set_multi_shot(char *str)
>  __setup("kasan_multi_shot", kasan_set_multi_shot);
>
>  /*
> - * Used to suppress reports within kasan_disable/enable_current() critical
> - * sections, which are used for marking accesses to slab metadata.
> + * This function is used to check whether KASAN reports are suppressed for
> + * software KASAN modes via kasan_disable/enable_current() critical sections.
> + *
> + * This is done to avoid:
> + * 1. False-positive reports when accessing slab metadata,
> + * 2. Deadlocking when poisoned memory is accessed by the reporting code.
> + *
> + * Hardware Tag-Based KASAN instead relies on:
> + * For #1: Resetting tags via kasan_reset_tag().
> + * For #2: Supression of tag checks via CPU, see report_suppress_start/end().

Typo: "Suppression"

>   */
> -static bool report_suppressed(void)
> +static bool report_suppressed_sw(void)
>  {
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         if (current->kasan_depth)
> @@ -84,6 +92,30 @@ static bool report_suppressed(void)
>         return false;
>  }
>
> +static void report_suppress_start(void)
> +{
> +#ifdef CONFIG_KASAN_HW_TAGS
> +       /*
> +        * Disable migration for the duration of printing a KASAN report, as
> +        * hw_suppress_tag_checks_start() disables checks on the current CPU.
> +        */
> +       migrate_disable();

This still allows this task to be preempted by another task. If the
other task is scheduled in right after hw_suppress_tag_checks_start()
then there won't be any tag checking in that task. If HW-tags KASAN is
used as a mitigation technique, that may unnecessarily weaken KASAN,
because right after report_suppress_start(), it does
spin_lock_irqsave() which disables interrupts (and thereby preemption)
anyway.

Why not just use preempt_disable()?

> +       hw_suppress_tag_checks_start();
> +#else
> +       kasan_disable_current();
> +#endif
> +}
> +
> +static void report_suppress_stop(void)
> +{
> +#ifdef CONFIG_KASAN_HW_TAGS
> +       hw_suppress_tag_checks_stop();
> +       migrate_enable();
> +#else
> +       kasan_enable_current();
> +#endif
> +}
> +
>  /*
>   * Used to avoid reporting more than one KASAN bug unless kasan_multi_shot
>   * is enabled. Note that KASAN tests effectively enable kasan_multi_shot
> @@ -174,7 +206,7 @@ static void start_report(unsigned long *flags, bool sync)
>         /* Do not allow LOCKDEP mangling KASAN reports. */
>         lockdep_off();
>         /* Make sure we don't end up in loop. */
> -       kasan_disable_current();
> +       report_suppress_start();
>         spin_lock_irqsave(&report_lock, *flags);
>         pr_err("==================================================================\n");
>  }
> @@ -192,7 +224,7 @@ static void end_report(unsigned long *flags, void *addr)
>                 panic("kasan.fault=panic set ...\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>         lockdep_on();
> -       kasan_enable_current();
> +       report_suppress_stop();
>  }
>
>  static void print_error_description(struct kasan_report_info *info)
> @@ -480,9 +512,13 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
>         struct kasan_report_info info;
>
>         /*
> -        * Do not check report_suppressed(), as an invalid-free cannot be
> -        * caused by accessing slab metadata and thus should not be
> -        * suppressed by kasan_disable/enable_current() critical sections.
> +        * Do not check report_suppressed_sw(), as an invalid-free cannot be
> +        * caused by accessing poisoned memory and thus should not be suppressed
> +        * by kasan_disable/enable_current() critical sections.
> +        *
> +        * Note that for Hardware Tag-Based KASAN, kasan_report_invalid_free()
> +        * is triggered by explicit tag checks and not by the ones performed by
> +        * the CPU. Thus, reporting invalid-free is not suppressed as well.
>          */
>         if (unlikely(!report_enabled()))
>                 return;
> @@ -517,7 +553,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
>         unsigned long irq_flags;
>         struct kasan_report_info info;
>
> -       if (unlikely(report_suppressed()) || unlikely(!report_enabled())) {
> +       if (unlikely(report_suppressed_sw()) || unlikely(!report_enabled())) {
>                 ret = false;
>                 goto out;
>         }
> @@ -549,8 +585,9 @@ void kasan_report_async(void)
>         unsigned long flags;
>
>         /*
> -        * Do not check report_suppressed(), as kasan_disable/enable_current()
> -        * critical sections do not affect Hardware Tag-Based KASAN.
> +        * Do not check report_suppressed_sw(), as
> +        * kasan_disable/enable_current() critical sections do not affect
> +        * Hardware Tag-Based KASAN.
>          */
>         if (unlikely(!report_enabled()))
>                 return;
> --
> 2.25.1
>
