Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258F474D4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGJMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGJMFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:05:36 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A5F9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:05:34 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-47e3026ca12so1235495e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688990734; x=1691582734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDYHrn9uJVmchUYKfNAMpK44DIdutf+8mbG7kSKCyHQ=;
        b=C2n87o7xFK/QIjnAI7ZxwX68VB1g9r9Mr6WQR893wNyzvngnpk1s8px/pRLVpe2J5I
         9AUYOjPiAeicC2pVWyP7FLUkA/CmZmMNcSeiVzBKo9x8Zn3pXp5nuTTgSlp6Kt3EgZGd
         ASwLR/65p+CMGxunQsDf84txtkCwOkB5rNBAhcZUkCqRvjW+rY+N6fDGLcw0/YOVLbcn
         oiKUrmPb2Z2VGSXAPffjCX3KBW7BINkydYELi/WBEsU/ML6ZSY7qJev179GC9pfBf7qv
         UMC4N2HGOQVqOjDkt9NsjX8+ja5J1P1Z2L0pKsqxsra6sdcNPNeBKBhjIu/CgGLBSV66
         9N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688990734; x=1691582734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDYHrn9uJVmchUYKfNAMpK44DIdutf+8mbG7kSKCyHQ=;
        b=gjD7a3jWpj6UL2T0wrxqTlJJBfY9MXcULPWMWL3L2E/2s83v/Y6bh5YOssyJCjHVhX
         arqnVlNVl0WFDFHOPsAOSzVNMb07aDOM/qU6MEi0jjnifQOaVwb7eYnfk8iafZDFC13j
         KN2wlhvCVr66vI3reHtCeawcl9VDlO48LcIOKcxRlNVRTFnujDmn9CHUXNB8iXnkHhVF
         Rnv38uTFBxCqvtn+wtTiO/Ri2X/85ChXXYXdAslgk0MmOMzIKudBtQnxl/FtSr4jHoQ/
         Zg0zXMo4m9uuma36yIeqjGde116y7n6ssgi9K81PzTBWHLz9cvMO2R1TxuKmruJjIqRw
         JU4w==
X-Gm-Message-State: ABy/qLYnUxP9J0AKhXKrzpetcor1Ad2iVchGIWn2I68UPLk5gevx4hs4
        4KY3t3WpcXM1qzFFxP/3uI11L7CSXkAu8Qzh+B4=
X-Google-Smtp-Source: APBJJlFcpcn6a+jkB0efkIrWYsJYut1s5m0BWN87fnfuJ82GsdyH2apq9tPxJvL49xFC9T2bx2b4OZRBhIO7lF7yuak=
X-Received: by 2002:a1f:430e:0:b0:471:5427:39a4 with SMTP id
 q14-20020a1f430e000000b00471542739a4mr5183537vka.0.1688990733970; Mon, 10 Jul
 2023 05:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
In-Reply-To: <20230622144210.2623299-1-ryan.roberts@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 10 Jul 2023 20:05:19 +0800
Message-ID: <CAGsJ_4x4b5Qe2RNTHyR2MQqSkRxcuchrUgrap9WTaDtuMUttcA@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Transparent Contiguous PTEs for User Mappings
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:00=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Hi All,
>
> This is a series to opportunistically and transparently use contpte mappi=
ngs
> (set the contiguous bit in ptes) for user memory when those mappings meet=
 the
> requirements. It is part of a wider effort to improve performance of the =
4K
> kernel with the aim of approaching the performance of the 16K kernel, but
> without breaking compatibility and without the associated increase in mem=
ory. It
> also benefits the 16K and 64K kernels by enabling 2M THP, since this is t=
he
> contpte size for those kernels.
>
> Of course this is only one half of the change. We require the mapped phys=
ical
> memory to be the correct size and alignment for this to actually be usefu=
l (i.e.
> 64K for 4K pages, or 2M for 16K/64K pages). Fortunately folios are solvin=
g this
> problem for us. Filesystems that support it (XFS, AFS, EROFS, tmpfs) will
> allocate large folios up to the PMD size today, and more filesystems are =
coming.
> And the other half of my work, to enable the use of large folios for anon=
ymous
> memory, aims to make contpte sized folios prevalent for anonymous memory =
too.
>
>
> Dependencies
> ------------
>
> While there is a complicated set of hard and soft dependencies that this =
patch
> set depends on, I wanted to split it out as best I could and kick off pro=
per
> review independently.
>
> The series applies on top of these other patch sets, with a tree at:
> https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/co=
ntpte-lkml_v1
>
> v6.4-rc6
>   - base
>
> set_ptes()
>   - hard dependency
>   - Patch set from Matthew Wilcox to set multiple ptes with a single API =
call
>   - Allows arch backend to more optimally apply contpte mappings
>   - https://lore.kernel.org/linux-mm/20230315051444.3229621-1-willy@infra=
dead.org/
>
> ptep_get() pte encapsulation
>   - hard dependency
>   - Enabler series from me to ensure none of the core code ever directly
>     dereferences a pte_t that lies within a live page table.
>   - Enables gathering access/dirty bits from across the whole contpte ran=
ge
>   - in mm-stable and linux-next at time of writing
>   - https://lore.kernel.org/linux-mm/d38dc237-6093-d4c5-993e-e8ffdd6cb6fa=
@arm.com/
>
> Report on physically contiguous memory in smaps
>   - soft dependency
>   - Enables visibility on how much memory is physically contiguous and ho=
w much
>     is contpte-mapped - useful for debug
>   - https://lore.kernel.org/linux-mm/20230613160950.3554675-1-ryan.robert=
s@arm.com/
>
> Additionally there are a couple of other dependencies:
>
> anonfolio
>   - soft dependency
>   - ensures more anonymous memory is allocated in contpte-sized folios, s=
o
>     needed to realize the performance improvements (this is the "other ha=
lf"
>     mentioned above).
>   - RFC: https://lore.kernel.org/linux-mm/20230414130303.2345383-1-ryan.r=
oberts@arm.com/
>   - Intending to post v1 shortly.
>
> exefolio
>   - soft dependency
>   - Tweak readahead to ensure executable memory are in 64K-sized folios, =
so
>     needed to see reduction in iTLB pressure.
>   - Don't intend to post this until we are further down the track with co=
ntpte
>     and anonfolio.
>
> Arm ARM Clarification
>   - hard dependency
>   - Current wording disallows the fork() optimization in the final patch.
>   - Arm (ATG) have proposed tightening the wording to permit it.
>   - In conversation with partners to check this wouldn't cause problems f=
or any
>     existing HW deployments
>
> All of the _hard_ dependencies need to be resolved before this can be con=
sidered
> for merging.
>
>
> Performance
> -----------
>
> Below results show 2 benchmarks; kernel compilation and speedometer 2.0 (=
a
> javascript benchmark running in Chromium). Both cases are running on Ampe=
re
> Altra with 1 NUMA node enabled, Ubuntu 22.04 and XFS filesystem. Each ben=
chmark
> is repeated 15 times over 5 reboots and averaged.
>
> All improvements are relative to baseline-4k. anonfolio and exefolio are =
as
> described above. contpte is this series. (Note that exefolio only gives a=
n
> improvement because contpte is already in place).
>
> Kernel Compilation (smaller is better):
>
> | kernel       |   real-time |   kern-time |   user-time |
> |:-------------|------------:|------------:|------------:|
> | baseline-4k  |        0.0% |        0.0% |        0.0% |
> | anonfolio    |       -5.4% |      -46.0% |       -0.3% |
> | contpte      |       -6.8% |      -45.7% |       -2.1% |
> | exefolio     |       -8.4% |      -46.4% |       -3.7% |

sorry i am a bit confused. in exefolio case, is anonfolio included?
or it only has large cont-pte folios on exe code? in the other words,
Does the 8.4% improvement come from iTLB miss reduction only,
or from both dTLB and iTLB miss reduction?

> | baseline-16k |       -8.7% |      -49.2% |       -3.7% |
> | baseline-64k |      -10.5% |      -66.0% |       -3.5% |
>
> Speedometer 2.0 (bigger is better):
>
> | kernel       |   runs_per_min |
> |:-------------|---------------:|
> | baseline-4k  |           0.0% |
> | anonfolio    |           1.2% |
> | contpte      |           3.1% |
> | exefolio     |           4.2% |

same question as above.

> | baseline-16k |           5.3% |
>
> I've also run Speedometer 2.0 on Pixel 6 with an Ubuntu SW stack and see =
similar
> gains.
>
> I've also verified that running the contpte changes without anonfolio and
> exefolio does not cause any regression vs baseline-4k.
>
>
> Opens
> -----
>
> The only potential issue that I see right now is that due to there only b=
eing 1
> access/dirty bit per contpte range, if a single page in the range is
> accessed/dirtied then all the adjacent pages are reported as accessed/dir=
tied
> too. Access/dirty is managed by the kernel per _folio_, so this informati=
on gets
> collapsed down anyway, and nothing changes there. However, the per _page_
> access/dirty information is reported through pagemap to user space. I'm n=
ot sure
> if this would/should be considered a break? Thoughts?
>
> Thanks,
> Ryan

Thanks
Barry
