Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DBC7417F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjF1SXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjF1SXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:23:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1C1BE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:23:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4007b5bafceso37451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687976586; x=1690568586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPkXg9N8uordavRnu+sW+s2rA54icvfoa0eXPe733lE=;
        b=e/sC/wzrODMZyH1LUlgz1RkukUwDNc0IyOAQ884BAaV51jTqGjTnfVwiUWjj4MFa17
         RUA8s+B9aeTgFdNUY9smcrhIU4ose2ju/aF//vByt3UxbuhwDrr8bFVzyLkcQfve87tq
         8n5wN5ASnj4ym6vkZ3E8hX+7Iz5HOz5ihmrF7T9OA7csd722/fZI1BfDErGOveB2QLe3
         pJc38aVccCcscKA65dHh7di7I7lN9VZsGYsXYV99fzEjFYOriEaEBmr7VclNHOS6K1ok
         HgbXxFcXIqKFDMD2j3xzJtirlR5E3vb74kgrpMgNRSCB9zGRqDA/ekjJD5ivvlfERIwd
         ipHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976586; x=1690568586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPkXg9N8uordavRnu+sW+s2rA54icvfoa0eXPe733lE=;
        b=VuOBFQYBBM+sXIKRlelBnV/FRBLmYhuQjm41J/NNhJsQrLH0iGGJo+BtoU98DAQPDW
         jze7odBKOYRNdY8++H68AW15F2u7PatqALXoeQs602q9fkTPVfc8AMFR9WFWpvsN5fsD
         2+e4ppvw1nJgfRIuNzQsGM7biFN/UbFzl1D+8n2Kr9Oo4bTzHhRiczSDjhyNY1oARFCi
         erWnpZ/j3QreSv/11AjsN5LreHaC3HUE9N9m5+gaG0ybQbESOzauRzY1+SVop5ehOVLe
         YCrpn7cApNBKwab50lqJZiTookJiju31huSIMqbRHTUAoIjfQIUj31FGQIEVkk+5W0fU
         MDTg==
X-Gm-Message-State: AC+VfDwAptrXziikWzGEM1C5K8YdoYQYt8WYq/livNdQP/9wR+KdWl8D
        c4UcLEsDVD7rwXTcuhrWVEXdqF/DX2XHCept+2XGZQ==
X-Google-Smtp-Source: ACHHUZ4hbXItb8GOuqNblEVMVXISZClDYDCEHKWd1Gm5zBV5kVAWf6j1zCi+uo+nUSTY0C4qp+7qnwYwHr1oOsp1ofA=
X-Received: by 2002:a05:622a:1b9f:b0:3fa:3c8f:3435 with SMTP id
 bp31-20020a05622a1b9f00b003fa3c8f3435mr199065qtb.27.1687976585898; Wed, 28
 Jun 2023 11:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <CAOUHufaUTbUw9MTzw8D=sVrEB+RP6LSBQVGn93TWk=ozV8XobA@mail.gmail.com>
 <CAOUHufa0S_ayrys0XzDbH8KJi5HxvbGCh_bSAhDpAgcmSJjFUQ@mail.gmail.com> <1fb0c4cb-a709-de20-d643-32ed43550059@arm.com>
In-Reply-To: <1fb0c4cb-a709-de20-d643-32ed43550059@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 28 Jun 2023 12:22:28 -0600
Message-ID: <CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] variable-order, large folios for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 3:59=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/06/2023 08:49, Yu Zhao wrote:
> > On Mon, Jun 26, 2023 at 9:30=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> >>
> >> On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>
> >>> Hi All,
> >>>
> >>> Following on from the previous RFCv2 [1], this series implements vari=
able order,
> >>> large folios for anonymous memory. The objective of this is to improv=
e
> >>> performance by allocating larger chunks of memory during anonymous pa=
ge faults:
> >>>
> >>>  - Since SW (the kernel) is dealing with larger chunks of memory than=
 base
> >>>    pages, there are efficiency savings to be had; fewer page faults, =
batched PTE
> >>>    and RMAP manipulation, fewer items on lists, etc. In short, we red=
uce kernel
> >>>    overhead. This should benefit all architectures.
> >>>  - Since we are now mapping physically contiguous chunks of memory, w=
e can take
> >>>    advantage of HW TLB compression techniques. A reduction in TLB pre=
ssure
> >>>    speeds up kernel and user space. arm64 systems have 2 mechanisms t=
o coalesce
> >>>    TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
> >>>
> >>> This patch set deals with the SW side of things only and based on fee=
dback from
> >>> the RFC, aims to be the most minimal initial change, upon which futur=
e
> >>> incremental changes can be added. For this reason, the new behaviour =
is hidden
> >>> behind a new Kconfig switch, CONFIG_LARGE_ANON_FOLIO, which is disabl=
ed by
> >>> default. Although the code has been refactored to parameterize the de=
sired order
> >>> of the allocation, when the feature is disabled (by forcing the order=
 to be
> >>> always 0) my performance tests measure no regression. So I'm hoping t=
his will be
> >>> a suitable mechanism to allow incremental submissions to the kernel w=
ithout
> >>> affecting the rest of the world.
> >>>
> >>> The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes()=
 series
> >>> [2], which is a hard dependency. I'm not sure of Matthew's exact plan=
s for
> >>> getting that series into the kernel, but I'm hoping we can start the =
review
> >>> process on this patch set independently. I have a branch at [3].
> >>>
> >>> I've posted a separate series concerning the HW part (contpte mapping=
) for arm64
> >>> at [4].
> >>>
> >>>
> >>> Performance
> >>> -----------
> >>>
> >>> Below results show 2 benchmarks; kernel compilation and speedometer 2=
.0 (a
> >>> javascript benchmark running in Chromium). Both cases are running on =
Ampere
> >>> Altra with 1 NUMA node enabled, Ubuntu 22.04 and XFS filesystem. Each=
 benchmark
> >>> is repeated 15 times over 5 reboots and averaged.
> >>>
> >>> All improvements are relative to baseline-4k. 'anonfolio-basic' is th=
is series.
> >>> 'anonfolio' is the full patch set similar to the RFC with the additio=
nal changes
> >>> to the extra 3 fault paths. The rest of the configs are described at =
[4].
> >>>
> >>> Kernel Compilation (smaller is better):
> >>>
> >>> | kernel          |   real-time |   kern-time |   user-time |
> >>> |:----------------|------------:|------------:|------------:|
> >>> | baseline-4k     |        0.0% |        0.0% |        0.0% |
> >>> | anonfolio-basic |       -5.3% |      -42.9% |       -0.6% |
> >>> | anonfolio       |       -5.4% |      -46.0% |       -0.3% |
> >>> | contpte         |       -6.8% |      -45.7% |       -2.1% |
> >>> | exefolio        |       -8.4% |      -46.4% |       -3.7% |
> >>> | baseline-16k    |       -8.7% |      -49.2% |       -3.7% |
> >>> | baseline-64k    |      -10.5% |      -66.0% |       -3.5% |
> >>>
> >>> Speedometer 2.0 (bigger is better):
> >>>
> >>> | kernel          |   runs_per_min |
> >>> |:----------------|---------------:|
> >>> | baseline-4k     |           0.0% |
> >>> | anonfolio-basic |           0.7% |
> >>> | anonfolio       |           1.2% |
> >>> | contpte         |           3.1% |
> >>> | exefolio        |           4.2% |
> >>> | baseline-16k    |           5.3% |
> >>
> >> Thanks for pushing this forward!
> >>
> >>> Changes since RFCv2
> >>> -------------------
> >>>
> >>>   - Simplified series to bare minimum (on David Hildenbrand's advice)
> >>
> >> My impression is that this series still includes many pieces that can
> >> be split out and discussed separately with followup series.
> >>
> >> (I skipped 04/10 and will look at it tomorrow.)
> >
> > I went through the series twice. Here what I think a bare minimum
> > series (easier to review/debug/land) would look like:

=3D=3D=3D

> > 1. a new arch specific function providing a prefered order within (0,
> > PMD_ORDER).
> > 2. an extended anon folio alloc API taking that order (02/10, partially=
).
> > 3. an updated folio_add_new_anon_rmap() covering the large() &&
> > !pmd_mappable() case (similar to 04/10).
> > 4. s/folio_test_pmd_mappable/folio_test_large/ in page_remove_rmap()
> > (06/10, reviewed-by provided).
> > 5. finally, use the extended anon folio alloc API with the arch
> > preferred order in do_anonymous_page() (10/10, partially).

=3D=3D=3D

> > The rest can be split out into separate series and move forward in
> > parallel with probably a long list of things we need/want to do.
>
> Thanks for the fadt review - I really appreciate it!
>
> I've responded to many of your comments. I'd appreciate if we can close t=
hose
> points then I will work up a v2.

Thanks!

Based on the latest discussion here [1], my original list above can be
optionally reduced to 4 patches: item 2 can be quashed into item 5.

Also please make sure we have only one global (apply to all archs)
Kconfig option, and it should be added in item 5:

  if TRANSPARENT_HUGEPAGE
    config FLEXIBLE/VARIABLE_THP # or whatever name you see fit
  end if

(How many new Kconfig options added within arch/arm64/ is not a concern of =
MM.)

And please make sure it's disabled by default, because we are still
missing many important functions, e.g., I don't think we can mlock()
when large() && !pmd_mappable(), see mlock_pte_range() and
mlock_vma_folio(). We can fix it along with many things later, but we
need to present a plan and a schedule now. Otherwise, there would be
pushback if we try to land the series without supporting mlock().

Do you or Fengwei plan to take on it? (I personally don't.) If not,
I'll try to find someone from our team to look at it. (It'd be more
scalable if we have a coordinated group of people individually solving
different problems.)

[1] https://lore.kernel.org/r/b2c81404-67df-f841-ef02-919e841f49f2@arm.com/
