Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF496380A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKXV1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKXV1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:27:14 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565F71F2A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:27:13 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i11so1521210vsr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28tlNzvFGezHHKEtEMJ65MUgCLg/C1dGauYsgv5qA68=;
        b=GbHa/hQqiNB8uEN5hR06CtMISUCk0+DFPYBaPzprj2cbOIt0q9mQGnPzI6StE+f+w1
         5gkxjit+Yafa9jRoElTfiGKyOiKEO/vCsLn9PbP+MJewxX+igI5Hq8C5sO6UE2CmxqWo
         Ea5ew7UUXgyzyiTntfH3siZuqb79Io8P7DAErhnMEby6tH/s4tXkgtmmvxESluGnKfqh
         k2Ny/v+BmhIFBaT70hqkodeJLCBf/3/GAwIwJDAwb/nk+oLNxgkYuXKuSgX5tb2VjSTP
         srWaNlgTbqqzm4yBJx95uLT7U6DhjRqNMja20tXksmMpNM7PCo9+yY0Xv6PJ5NHtsl21
         Zm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28tlNzvFGezHHKEtEMJ65MUgCLg/C1dGauYsgv5qA68=;
        b=bAz5vqHdYwQ3v4Q5cAvYuq04SMMZKzzy21oVDjmslanuIjq7odie3uP2UuH8x2Glyp
         JxchSiXnSafqC8tXx+hXPUU0rCrbt1K8UCa8RMLXYiKIBtMge5V+HeS9yqMfR/eNFsBk
         rU1XpRAe4x/yoflalnrQWccWdvoxvHPD/BqUZfb8SY+gKZ8G/yDMEFnUZLv+/0nsBNqZ
         IOMnljfi5m1i0Z+5Sgl7zFlnM/0ZoepyGzikGxk8RBoGujgB66aebw1aCVlVpBEHTUMr
         uLqDLTDLPWod0hLgNoKqPjcVKRDHjLs6L/9fR6Xcisduj92NJOi2MBnAmAst574/msbV
         FIeQ==
X-Gm-Message-State: ANoB5pnsuEVL6aNMuTDH51gGtA3UeqoZlLYVUfF43db6eWxDTX6Bn0Mr
        RRXpANc0XMF/fvsM+9+7TzX77QYVYkYKtEYOea/2Sg==
X-Google-Smtp-Source: AA0mqf43M80m/yI/Xb9LWXsijHcW8xT1p0hu/+Isbwt0GnHBzigxSsVOq2FF/RFZvI86YR5Y+v162KuSlAiV8o32+0g=
X-Received: by 2002:a67:fe01:0:b0:3af:5ff9:ed51 with SMTP id
 l1-20020a67fe01000000b003af5ff9ed51mr12230257vsr.46.1669325232670; Thu, 24
 Nov 2022 13:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20221123064510.16225-1-jgross@suse.com> <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>
 <fd3ac3cd-7349-6bbd-890a-71a9454ca0b3@suse.com>
In-Reply-To: <fd3ac3cd-7349-6bbd-890a-71a9454ca0b3@suse.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 24 Nov 2022 14:26:36 -0700
Message-ID: <CAOUHufa7L1y1FzKY9G7Hwah4rdJAJhE0KDR+FfSFVMHnbRdx9Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: introduce arch_has_hw_nonleaf_pmd_young()
To:     Juergen Gross <jgross@suse.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 24, 2022 at 7:30 AM Juergen Gross <jgross@suse.com> wrote:
>
> Hi,
>
> On 24.11.22 15:08, Geert Uytterhoeven wrote:
> > Hi J=C3=BCrgen,
> >
> > On Wed, Nov 23, 2022 at 7:53 AM Juergen Gross <jgross@suse.com> wrote:
> >> When running as a Xen PV guests commit eed9a328aa1a ("mm: x86: add
> >> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG") can cause a protection violation
> >> in pmdp_test_and_clear_young():
> >>
> >>   BUG: unable to handle page fault for address: ffff8880083374d0
> >>   #PF: supervisor write access in kernel mode
> >>   #PF: error_code(0x0003) - permissions violation
> >>   PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 801000000833706=
5
> >>   Oops: 0003 [#1] PREEMPT SMP NOPTI
> >>   CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr+ =
#1
> >>   RIP: e030:pmdp_test_and_clear_young+0x25/0x40
> >>
> >> This happens because the Xen hypervisor can't emulate direct writes to
> >> page table entries other than PTEs.
> >>
> >> This can easily be fixed by introducing arch_has_hw_nonleaf_pmd_young(=
)
> >> similar to arch_has_hw_pte_young() and test that instead of
> >> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG.
> >>
> >> Fixes: eed9a328aa1a ("mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG")
> >> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> Acked-by: Yu Zhao <yuzhao@google.com>
> >> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> >> ---
> >> V2:
> >> - correct function name in commit message to match patch
> >
> > Thanks for your patch, which is now commit 3f85e711d5af4fb4 ("mm:
> > introduce arch_has_hw_nonleaf_pmd_young()") in next-20221124.
> >
> > noreply@ellerman.id.au reported a build failure for m68k/allmodconfig,
> > which I have bisected to this commit.
> >
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >
> >> @@ -4073,14 +4073,14 @@ static void walk_pmd_range(pud_t *pud, unsigne=
d long start, unsigned long end,
> >>   #endif
> >>                  walk->mm_stats[MM_NONLEAF_TOTAL]++;
> >>
> >> -#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> >> -               if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
> >> +               if (arch_has_hw_nonleaf_pmd_young() &&
> >> +                   get_cap(LRU_GEN_NONLEAF_YOUNG)) {
> >>                          if (!pmd_young(val))
> >
> > mm/vmscan.c:4102:30: error: implicit declaration of function
> > 'pmd_young'; did you mean 'pte_young'?
> > [-Werror=3Dimplicit-function-declaration]
> >
> > pmd_young() seems to be defined only on a handful of architectures.
>
> What would be the preferred fix for that?
>
> I could offer:
>
> - use V1 of the patch
> - add the #ifdefs again to this patch (which would be kind of weird)
> - use the attached patch

Your patch looks good to me:

Acked-by: Yu Zhao <yuzhao@google.com>

Thanks.
