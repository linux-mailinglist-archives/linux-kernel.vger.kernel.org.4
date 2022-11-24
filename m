Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE330637B17
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKXOI5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Nov 2022 09:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKXOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:08:56 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA6317F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:08:55 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id n12so998514qvr.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VObI5tLBfN6ga4cHicIqOhPYeWo9pWJ78AZx786RS9g=;
        b=f9JEj5ajokPfA90CkwYYgAKlM/CyEhMgT9nj38heqI5fqxVPhmSnrw1SYFrEoUnP5m
         yZXhfvScBaMkkxKmICdFmtseUh4QHTqczFwDrZxi3kr6ixqlSleqmN+JOfdvV3e+B/aJ
         g8SswLnbZNzmj2prOV6yWb4S3uurqBGhfTO0l1YaKsycn6oQFbfEB7J/p8OOmop+fS0j
         VNovi2VzDeNes2vGqHED2zsbj0lrJW7Wvj0BIfcziaTsjLfD0gLaQYTs0nnRPKyaPflR
         F8EPu9yUxEG8EqX4iCEg6pjN6g8c3WapIRyVbFbzMiY4wo9Ldr1DEANof0nSkAyHWd8Y
         T7XA==
X-Gm-Message-State: ANoB5pkNuhvLKcT725FBhTt4Zp4T8zNgr+udrw5wjyjlwWnPGCsDZ1Ym
        mEES7ltJfShcmepUx6K5rLQc35BtHGq0cQ==
X-Google-Smtp-Source: AA0mqf78LgbkY4GhP9cEzZvey3csfsiONSo/q97cPpNR8b6KEfkR99JWRkz8UkY+kaYsbnBzv7r7XA==
X-Received: by 2002:a05:6214:2b99:b0:4c6:d6cf:e06b with SMTP id kr25-20020a0562142b9900b004c6d6cfe06bmr5229582qvb.9.1669298934104;
        Thu, 24 Nov 2022 06:08:54 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id bn31-20020a05620a2adf00b006b95b0a714esm908743qkb.17.2022.11.24.06.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:08:52 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3876f88d320so16555187b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:08:50 -0800 (PST)
X-Received: by 2002:a0d:dc87:0:b0:370:61f5:b19e with SMTP id
 f129-20020a0ddc87000000b0037061f5b19emr30399460ywe.316.1669298930583; Thu, 24
 Nov 2022 06:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20221123064510.16225-1-jgross@suse.com>
In-Reply-To: <20221123064510.16225-1-jgross@suse.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Nov 2022 15:08:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>
Message-ID: <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: introduce arch_has_hw_nonleaf_pmd_young()
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jürgen,

On Wed, Nov 23, 2022 at 7:53 AM Juergen Gross <jgross@suse.com> wrote:
> When running as a Xen PV guests commit eed9a328aa1a ("mm: x86: add
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG") can cause a protection violation
> in pmdp_test_and_clear_young():
>
>  BUG: unable to handle page fault for address: ffff8880083374d0
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0003) - permissions violation
>  PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 8010000008337065
>  Oops: 0003 [#1] PREEMPT SMP NOPTI
>  CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr+ #1
>  RIP: e030:pmdp_test_and_clear_young+0x25/0x40
>
> This happens because the Xen hypervisor can't emulate direct writes to
> page table entries other than PTEs.
>
> This can easily be fixed by introducing arch_has_hw_nonleaf_pmd_young()
> similar to arch_has_hw_pte_young() and test that instead of
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG.
>
> Fixes: eed9a328aa1a ("mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG")
> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> ---
> V2:
> - correct function name in commit message to match patch

Thanks for your patch, which is now commit 3f85e711d5af4fb4 ("mm:
introduce arch_has_hw_nonleaf_pmd_young()") in next-20221124.

noreply@ellerman.id.au reported a build failure for m68k/allmodconfig,
which I have bisected to this commit.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

> @@ -4073,14 +4073,14 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
>  #endif
>                 walk->mm_stats[MM_NONLEAF_TOTAL]++;
>
> -#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> -               if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
> +               if (arch_has_hw_nonleaf_pmd_young() &&
> +                   get_cap(LRU_GEN_NONLEAF_YOUNG)) {
>                         if (!pmd_young(val))

mm/vmscan.c:4102:30: error: implicit declaration of function
'pmd_young'; did you mean 'pte_young'?
[-Werror=implicit-function-declaration]

pmd_young() seems to be defined only on a handful of architectures.

>                                 continue;
>
>                         walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
>                 }
> -#endif
> +
>                 if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq, pmd + i))
>                         continue;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
