Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850A4685CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBAByP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBAByN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:54:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9694A210
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:54:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 110B1B81FC9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D7C433A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675216449;
        bh=JlEbqXOJy9cLAn/e3yXkfKsfn9G5mHeLtTDvuLqbw64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t6uo6+11mU5CIsNSR4kobkwIQdLvaGpGC7/eWqtKFN0X/4J0izYcy5Xyn+0X6mG0R
         2fE8g7cITgUBF9ZWOKWZJ4dfAhvtRCbSc7f9aI4HQ+LfKXboLnAUcQBu/Pd+o7h382
         Vpu+B+rPdZdgtM+0YcFuoUtgHQ8qoO7wh4A2lNCFPznRmw4rfEtjzLt7GNKkMMN6zD
         CV6nppWa4rc2KJNNPyGZrA4tjONWLGMufWYlYXVU8XjzNKHH0912tISnUuCbUFa2SW
         D8Gn3SsXZdpnQ03914tTuqqaE1SHf1VVNaa1dVgECs7BDfCXOAXyvEiN0JMWeqTB3p
         MuE7qcsFf/9mg==
Received: by mail-ej1-f48.google.com with SMTP id qw12so31203972ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:54:09 -0800 (PST)
X-Gm-Message-State: AO0yUKUM1MhZcetxHtcj8M4/1kflo/Ew1XrWsG8rmHY+iluHVZPSo8tv
        pL2gtihgWUg/qVy8ualeyrkQeyZMmuixzPKuXk0=
X-Google-Smtp-Source: AK7set/R8MSbh/i8Z3UdUWDc3gbQZvMlilpqSSgOTvBYzAb9sWVGqcGQrcbLUMBu0h897PRabSFEGpZj2x0Kf3KsYEU=
X-Received: by 2002:a17:906:4c84:b0:887:2320:57e1 with SMTP id
 q4-20020a1709064c8400b00887232057e1mr139586eju.73.1675216447930; Tue, 31 Jan
 2023 17:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20230127050421.1920048-1-guoren@kernel.org> <20230127115714.467ymd5cpvi5h2ey@orel>
In-Reply-To: <20230127115714.467ymd5cpvi5h2ey@orel>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 1 Feb 2023 09:53:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSDDuEZGqsO8-TnXewMpkOuu1r3tXBtbz0dDJzmRstd3w@mail.gmail.com>
Message-ID: <CAJF2gTSDDuEZGqsO8-TnXewMpkOuu1r3tXBtbz0dDJzmRstd3w@mail.gmail.com>
Subject: Re: [PATCH -next V2] riscv: mm: hugetlb: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     tongtiangen@huawei.com, alexandre.ghiti@canonical.com,
        muchun.song@linux.dev, palmer@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 7:57 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Fri, Jan 27, 2023 at 12:04:21AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add HVO support for RISC-V; see commit 6be24bed9da3 ("mm: hugetlb:
> > introduce a new config HUGETLB_PAGE_FREE_VMEMMAP").
>
> I found Documentation/mm/vmemmap_dedup.rst even more enlightening
> about HVO than the commit message of 6be24bed9da3.
I've put that in v3 commit log.
>
> > This patch is
> > similar to commit 1e63ac088f20 ("arm64: mm: hugetlb: enable
> > HUGETLB_PAGE_FREE_VMEMMAP for arm64"), and riscv's motivation is the
> > same as arm64. The current riscv was ready to enable HVO after fixup,
> > ref commit d33deda095d3 ("riscv/mm: hugepage's PG_dcache_clean flag
> > is only set in head page").
> >
> > The HugeTLB VmemmapvOptimization (HVO) defaults to off in Kconfig.
> >
> > Here is the riscv test log:
> > cat /proc/sys/vm/hugetlb_optimize_vmemmap
> > echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > mount -t hugetlbfs none test/ -o pagesize=2048k
> > <Try some simple hugetlb test in test dir, no problem found.>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Link: https://lore.kernel.org/linux-riscv/1F5AF29D-708A-483B-A29F-CAEE6F554866@linux.dev/
> > Acked-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> > Changelog:
> > V2:
> >  - Optimize the commit log
> >  - Remove riscv page compound_head fixup which has been merged.
> >  - Rebase on riscv for-next (20230127)
> >  - Add HVO author's acked-by
> >
> > V1:
> > https://lore.kernel.org/linux-riscv/20221023133205.3493564-1-guoren@kernel.org/
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e2b656043abf..949974a38a41 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -46,6 +46,7 @@ config RISCV
> >       select ARCH_WANT_FRAME_POINTERS
> >       select ARCH_WANT_GENERAL_HUGETLB
> >       select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> > +     select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >       select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >       select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >       select BUILDTIME_TABLE_SORT if MMU
> > --
> > 2.36.1
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew



-- 
Best Regards
 Guo Ren
