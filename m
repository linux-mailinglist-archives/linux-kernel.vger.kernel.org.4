Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77169617DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKCNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiKCNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:19:23 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712A22BE6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:19:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso938548otr.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ8PQVj82FaQ9LUd3o9QfAubExvzsF8Edqea9t2SIG8=;
        b=a4sRTXzkK9mF4OQewlFU3sQTKQzC+mDlvEiTdM1XHvOMXwPeRwDs+bfCvYwYbiVxfl
         p9Z9PEWlo6Y+o39oSTejZzgrz+UrIJd0GMxOi34rF8aHLRM2O17GZmRma8nBtBJI5TBU
         AxgwRByGV18v8HEC+nvBXCdXwhCv5HU7rT47jLNNyPDoD3rjhzvu2N6lzPkTyr/IMujp
         YWqVIxZRi6d1aAwBdadWgTH1s21On3muSijmVQNADKEX48eYKN/j5oq67HfVq1055mDb
         2WWaX/rjmrLwoC0uTjnthGlqr9kSJIXnSBdjNlJZEIIigGgurdUswULX6KUaCB6k9umR
         Y0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ8PQVj82FaQ9LUd3o9QfAubExvzsF8Edqea9t2SIG8=;
        b=E8dghU33KmmBK0OAUaptxZzZyTOIYlyBIEcR65g90RAX3T+scb5oHsfYai4w57YcDz
         gKFukea9YngRvV2F3LCP2butEEz1qk7LDXqVHJ5WiN9lz4d7JdnDdI+4207zj53AYONz
         Vna0a4JAxZNg/QHoWaj6D1eddOP+iNSHkmT7SaAwwJbAFDZy2HkHNktD+NUv+MVZEBP6
         z+xWJuEq2V62i7+yska+Hp+7C50jAkID5DrOsi9Hff7iFUluS42QQsV95cKE+wVZEeKY
         UFb/x/R3vhoFCuwu6CY64RsRSsJGrBG1Fv7G2w0fAU39eNzApDR2QeeI/waf9WMd2SAX
         zLMw==
X-Gm-Message-State: ACrzQf2P9ccs68iraEzfDprCdGtuA7B3HTCAzFr2ZVL5Pr3RTyBZDf9h
        ieL9hpdRRqMi7r8VkxSQn6MLAWIYu1MM/prkMQ==
X-Google-Smtp-Source: AMsMyM5At5QIXD+W1ctPricPlnnX9xjVg0QTOE8jZ8RNtVL0/JksfYeTA1uggniA1HiVbfFClLRC6HVvFPEErGKIMeg=
X-Received: by 2002:a05:6830:148a:b0:66c:7b8c:4598 with SMTP id
 s10-20020a056830148a00b0066c7b8c4598mr3443204otq.81.1667481560181; Thu, 03
 Nov 2022 06:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221103113636.25543-1-jgross@suse.com> <20221103113636.25543-5-jgross@suse.com>
In-Reply-To: <20221103113636.25543-5-jgross@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 3 Nov 2022 09:19:06 -0400
Message-ID: <CAMzpN2hynmZ39ByCRg4ibm=Mz+5LbLps77k9Vhb+c+VmVUO1=A@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: switch to cpu_feature_enabled() for X86_FEATURE_XENPV
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 8:37 AM Juergen Gross <jgross@suse.com> wrote:
>
> Convert the remaining cases of static_cpu_has(X86_FEATURE_XENPV) and
> boot_cpu_has(X86_FEATURE_XENPV) to use cpu_feature_enabled(), allowing
> more efficient code in case the kernel is configured without
> CONFIG_XEN_PV.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/kernel/cpu/amd.c    | 2 +-
>  arch/x86/kernel/cpu/bugs.c   | 2 +-
>  arch/x86/kernel/cpu/hygon.c  | 2 +-
>  arch/x86/kernel/process_64.c | 4 ++--
>  arch/x86/kernel/topology.c   | 2 +-
>  arch/x86/mm/cpu_entry_area.c | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 860b60273df3..697fe881e967 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -985,7 +985,7 @@ static void init_amd(struct cpuinfo_x86 *c)
>                         set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);
>
>         /* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
> -       if (!cpu_has(c, X86_FEATURE_XENPV))
> +       if (!cpu_feature_enabled(X86_FEATURE_XENPV))
>                 set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
>
>         /*
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index da7c361f47e0..7f78e1527c5e 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1302,7 +1302,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>                 return SPECTRE_V2_CMD_AUTO;
>         }
>
> -       if (cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_has(X86_FEATURE_XENPV)) {
> +       if (cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
>                 pr_err("%s selected but running as XenPV guest. Switching to AUTO select\n",
>                        mitigation_options[i].option);
>                 return SPECTRE_V2_CMD_AUTO;
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> index 21fd425088fe..1c27645fd429 100644
> --- a/arch/x86/kernel/cpu/hygon.c
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -339,7 +339,7 @@ static void init_hygon(struct cpuinfo_x86 *c)
>         set_cpu_cap(c, X86_FEATURE_ARAT);
>
>         /* Hygon CPUs don't reset SS attributes on SYSRET, Xen does. */
> -       if (!cpu_has(c, X86_FEATURE_XENPV))
> +       if (!cpu_feature_enabled(X86_FEATURE_XENPV))
>                 set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
>
>         check_null_seg_clears_base(c);
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 6b3418bff326..e2f469175be8 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -165,7 +165,7 @@ static noinstr unsigned long __rdgsbase_inactive(void)
>
>         lockdep_assert_irqs_disabled();
>
> -       if (!static_cpu_has(X86_FEATURE_XENPV)) {
> +       if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
>                 native_swapgs();
>                 gsbase = rdgsbase();
>                 native_swapgs();
> @@ -190,7 +190,7 @@ static noinstr void __wrgsbase_inactive(unsigned long gsbase)
>  {
>         lockdep_assert_irqs_disabled();
>
> -       if (!static_cpu_has(X86_FEATURE_XENPV)) {
> +       if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
>                 native_swapgs();
>                 wrgsbase(gsbase);
>                 native_swapgs();
> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index 8617d1ed9d31..1b83377274b8 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -106,7 +106,7 @@ int arch_register_cpu(int num)
>          * Xen PV guests don't support CPU0 hotplug at all.
>          */
>         if (c->x86_vendor != X86_VENDOR_INTEL ||
> -           boot_cpu_has(X86_FEATURE_XENPV))
> +           cpu_feature_enabled(X86_FEATURE_XENPV))
>                 cpu0_hotpluggable = 0;
>
>         /*
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index 6c2f1b76a0b6..c83799753d44 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -147,7 +147,7 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
>          * On Xen PV, the GDT must be read-only because the hypervisor
>          * requires it.
>          */
> -       pgprot_t gdt_prot = boot_cpu_has(X86_FEATURE_XENPV) ?
> +       pgprot_t gdt_prot = cpu_feature_enabled(X86_FEATURE_XENPV) ?
>                 PAGE_KERNEL_RO : PAGE_KERNEL;
>         pgprot_t tss_prot = PAGE_KERNEL;
>  #endif

This is another case that can be removed because it's for 32-bit.

--
Brian Gerst
