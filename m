Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991F85BF275
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIUAwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIUAwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:52:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9279615
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:52:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4128125pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3bMimDjz3px5Pc4d83ZuYO87Es5kSsxKRVx/kGE+EAo=;
        b=CihjREPQawv4ZqGVydsRll7gkCs58YK4/ZMWCdGJRlURofP5hcnU7ROKjQPxjfHJul
         4JSRGOIpSA6lLW7imZO7kWqvJAAEtaljqZ2zrLM7bjriE/Ch2QUE0my+dEp80/8EVBVT
         5ju3sm1zeYYXM0JYPBNR+1v9EIM9qecAqaarj5fzXlH/EQ+dNF7rPpebHGiBzI3dcLUI
         90qt30yqHKlcsk8qBZQZIDFjrI6s45hK4PJVx/wdHI0ftXUX5G0I4ZKf8UHb29SiGCml
         brPj6DHgEagVA9pLM/cBTSY5WShLpY68Z1BZmtZHaUjzB52XSgLztcKvelx1ZDe9LNGj
         QPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3bMimDjz3px5Pc4d83ZuYO87Es5kSsxKRVx/kGE+EAo=;
        b=x9N3d/O8eLpE0lqqI9xMyEbk5eh3xSLH2qNwaYw4IIpxu23U7IXdT668P2pPDHPIey
         BLa1lXoLH1Glb92TRzfeOJSar22iBV+MAvJfld2dIY+XI9H1YUBGbqF0QIrP0lupreDi
         ouMBOdIZX4LxIEKrsYnZTB+B4w40n0GlXs73n5Ci2dmEgqPiFh8Q4nOWfR8cKlIloPyD
         q97K5J8KRscmG3qBGi0UxGp6lsYyVUU1J+oqL2ODJa9N0lEvoQ7e7x5UsT53ei19KzQo
         rg82YA2quZ7HYZ1we1dQsZ9zqtoY8ba/3kBHjUxx/6IsgaIq3SAMVe3TpG68LXKihZDw
         lp0g==
X-Gm-Message-State: ACrzQf37S+m2dtQoPpctqr2bd/E4t24dSiCRJYSV7mUDhpcDHwELrtxQ
        Tz2RamiSCcidojV6KBJdqj9OZ5dKWJwO+fXrh/g=
X-Google-Smtp-Source: AMsMyM4qeuLSKsvTSwQzcd0n+0IJ4or9LYG07qDt+28gIb+gHVVlDP73DdJojVy4WUsi/CojDAxk/LCCiro7zf42fJU=
X-Received: by 2002:a17:90b:1b4c:b0:202:c05f:6e7b with SMTP id
 nv12-20020a17090b1b4c00b00202c05f6e7bmr6617388pjb.200.1663721565004; Tue, 20
 Sep 2022 17:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220817081408.513338-1-ying.huang@intel.com> <20220817084833.b348d11eab362b2ac5a02259@linux-foundation.org>
 <87k05ypxy6.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87k05ypxy6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 20 Sep 2022 17:52:32 -0700
Message-ID: <CAHbLzkpvCC4h6ku6-Yc3YZHJhXHjYTOyofdi6SsYtrgAChUMkQ@mail.gmail.com>
Subject: Re: [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 7:44 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> > On Wed, 17 Aug 2022 16:14:00 +0800 Huang Ying <ying.huang@intel.com> wrote:
> >
> >> error-inject.patch, test-migrate.c, and test-migrate.sh are as below.
> >> It turns out that error injection is an important tool to fix bugs in
> >> error path.
> >
> > Indeed, and thanks for doing this.
> >
> > Did you consider lib/*inject*.c?  If so, was it unsuitable?
>

Thanks, Ying. Great tips!

> I have done some experiments to use some existing error injection
> mechanisms in kernel to test the error path of migrate_pages().  After
> some googling, I found that the BPF based error injection described in
> the following URL is most suitable for my purpose.
>
> https://lwn.net/Articles/740146/
>
> Because the BPF seems quite flexible to satisfy various requirements of
> error injection.  With it, the execution of some functions can be
> skipped and some specified error code can be returned instead.
>
> Works out of box
> ================
>
> Some error injection functionality just works out of box.  For example,
> inject some page allocation error in some path.  Firstly,
> CONFIG_BPF_KPROBE_OVERRIDE needs to be enabled in kernel config.  Then,
> a simple bpftrace script as follows can be used to inject page
> allocation error during migrate_pages().
>
> --------------------ENOMEM-----------------------
> kprobe:migrate_pages { @in_migrate_pages++; }
> kretprobe:migrate_pages  { @in_migrate_pages--; }
> kprobe:should_fail_alloc_page / @in_migrate_pages > 0 / {
>         override(1);
> }
> -------------------------------------------------
>
> The call chain of error injection is specified via the first 2 lines.  I
> copied the methods used in BCC inject script.  Is there any better
> method to specify the call chain?
>
> We can inject error only for THP page allocation too.
>
> --------------------ENOMEM THP-------------------
> kprobe:migrate_pages { @in_migrate_pages++; }
> kretprobe:migrate_pages  { @in_migrate_pages--; }
> kprobe:should_fail_alloc_page / @in_migrate_pages > 0 && arg1 == 9 / {
>         override(1);
> }
> -------------------------------------------------
>
> Use some hack to override any function
> ======================================
>
> The in-kernel BPF based error injection mechanism can only override
> function return value for the functions in the whitelist, that is,
> functions marked with ALLOW_ERROR_INJECTION().  That is quite limited.
> The thorough error path testing needs to override the return value of
> arbitrary function.  So, I use a simple hack patch as follows for that.
>
> -----------------------8<---------------------------------
> From 3bcd401a3731bc7316d222501070a2a71fdf7170 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Tue, 20 Sep 2022 09:08:25 +0800
> Subject: [PATCH] dbg: allow override any function with bpf_error_injection
>
> ---
>  lib/error-inject.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index 1afca1b1cdea..82a402e0f15c 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -21,6 +21,7 @@ struct ei_entry {
>         void *priv;
>  };
>
> +#if 0
>  bool within_error_injection_list(unsigned long addr)
>  {
>         struct ei_entry *ent;
> @@ -36,6 +37,12 @@ bool within_error_injection_list(unsigned long addr)
>         mutex_unlock(&ei_mutex);
>         return ret;
>  }
> +#else
> +bool within_error_injection_list(unsigned long addr)
> +{
> +       return true;
> +}
> +#endif
>
>  int get_injectable_error_type(unsigned long addr)
>  {
> --
> 2.35.1
> ----------------------------------------------------------
>
> With this debug patch, most error path can be tested.  For example,
>
> --------------------ENOSYS THP + EAGAIN----------
> #include <linux/mm.h>
> kprobe:migrate_pages { @in_migrate_pages++; }
> kretprobe:migrate_pages  { @in_migrate_pages--; }
> kprobe:unmap_and_move / @in_migrate_pages > 0 / {
>         if (((struct page *)arg3)->flags & (1 << PG_head)) {
>                 override(-38);
>         } else {
>                 override(-11);
>         }
> }
> -------------------------------------------------
>
> With this, unmap_and_move() will return -ENOSYS (-38) for THP, and
> -EAGAIN (-11) for normal page.  This can be used to test the
> corresponding error path in migrate_pages().
>
> I think that it's quite common for developers to inject error for
> arbitrary function to test the error path.  Is it a good idea to turn on
> the arbitrary error injection if a special kernel configuration
> (e.g. CONFIG_BPF_KPROBE_OVERRIDE_ANY_FUNCTION) is enabled for debugging
> purpose only?
>
> Some hacks are still necessary for complete coverage
> ====================================================
>
> Even if we can override the return value of any function.  Some hacks
> are still necessary for complete coverage.  For example, some functions
> may be inlined, if we want to override its return value, we need to mark
> it with "noinline".  And some error cannot be injected with return value
> overridden directly.  For example, if we want to test when THP split
> isn't allowed condition in migrate_pages().  Then, some hack patch need
> to be used to do that.  For example, the below patch can do that.
>
> -----------------------8<---------------------------------
> From ca371806dc7f96148cbdf03fdf8f92309306a325 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Tue, 20 Sep 2022 09:37:53 +0800
> Subject: [PATCH] dbg: inject nosplit
>
> ---
>  mm/migrate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 571d8c9fd5bc..d4ee76c285b2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -57,6 +57,11 @@
>
>  #include "internal.h"
>
> +static noinline bool error_inject_nosplit(void)
> +{
> +       return false;
> +}
> +
>  int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  {
>         const struct movable_operations *mops;
> @@ -1412,6 +1417,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>         bool nosplit = (reason == MR_NUMA_MISPLACED);
>         bool no_subpage_counting = false;
>
> +       if (error_inject_nosplit())
> +               nosplit = true;
> +
>         trace_mm_migrate_pages_start(mode, reason);
>
>  thp_subpage_migration:
> --
> 2.35.1
> ----------------------------------------------------------
>
> With the help of the above patch, the following bpftrace script can
> inject the expected error,
>
> --------------------ENOMEM THP + nosplit---------
> kprobe:migrate_pages { @in_migrate_pages++; }
> kretprobe:migrate_pages  { @in_migrate_pages--; }
> kprobe:should_fail_alloc_page / @in_migrate_pages > 0 && arg1 == 9 / {
>         override(1);
> }
> kprobe:error_inject_nosplit / @in_migrate_pages > 0 / {
>         override(1);
> }
> -------------------------------------------------
>
> Although some hack patches are needed.  This is still simpler than my
> original hand-made error injection solution.  So I will recommend
> developers to use it in the error path testing in the future.
>
> Best Regards,
> Huang, Ying
