Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACD6493C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLKKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 05:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:54:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D6FAE1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 680A460A10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 10:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA19C433EF;
        Sun, 11 Dec 2022 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670756038;
        bh=XkNMpwy/87CeF1FK5TaclU8fX8nQmPRMYKk9Fu8hnbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1WVdgDq1VgFdgHzq9axxDp01F5qZry0NZRQwQ17tY1qqTlXYGdpuqudSiz/utboX
         B+u80X8zLbADRo0+0cTfgq3CCwh2IAGizL+bEO2w2Ct5i6krEQX9O/1gYNf21V4X4e
         rQxOrxIQ/r+FsHOd+gtT5QizAvu5sObNyaS4cojujZ2Yc5SAOhoMdgMW8c+zs6Xij6
         TBTlKesLgf0nyIgC0FzwprNHHjCSN4XG1N80ltB/bwLxnOJl3n79el4SJhqLwEKdEQ
         N9VowYbVSmoH+x58p9H2yzz1LSJpZ0snjT1mu063AZLunVBtpAABeXJqm/rM0FHKc9
         qVaXC0af/2ZCQ==
Date:   Sun, 11 Dec 2022 18:43:58 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        alexandre.ghiti@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 RESEND 0/2] use static key to optimize
 pgtable_l4_enabled
Message-ID: <Y5W0bv8Y/zCc+Fco@xhacker>
References: <20220821140918.3613-1-jszhang@kernel.org>
 <mhng-30c89107-c103-4363-b4af-7778d9512622@palmer-ri-x1c9>
 <Yz6T4EYKKns7OIVE@xhacker>
 <Y0GJDqLXFU81UdfW@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0GJDqLXFU81UdfW@xhacker>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 10:28:35PM +0800, Jisheng Zhang wrote:
> On Thu, Oct 06, 2022 at 04:37:57PM +0800, Jisheng Zhang wrote:
> > On Wed, Oct 05, 2022 at 06:05:28PM -0700, Palmer Dabbelt wrote:
> > > On Sun, 21 Aug 2022 07:09:16 PDT (-0700), jszhang@kernel.org wrote:
> > > > The pgtable_l4|[l5]_enabled check sits at hot code path, performance
> > > > is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
> > > > boot, so static key can be used to solve the performance issue[1].
> > > > 
> > > > An unified way static key was introduced in [2], but it only targets
> > > > riscv isa extension. We dunno whether SV48 and SV57 will be considered
> > > > as isa extension, so the unified solution isn't used for
> > > > pgtable_l4[l5]_enabled now.
> > > > 
> > > > patch1 fixes a NULL pointer deference if static key is used a bit earlier.
> > > > patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
> > > > 
> > > > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> > > > [2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t
> > > > 
> > > > Since v5:
> > > >  - Use DECLARE_STATIC_KEY_FALSE
> > > > 
> > > > Since v4:
> > > >  - rebased on v5.19-rcN
> > > >  - collect Reviewed-by tags
> > > >  - Fix kernel panic issue if SPARSEMEM is enabled by moving the
> > > >    riscv_finalise_pgtable_lx() after sparse_init()
> > > > 
> > > > Since v3:
> > > >  - fix W=1 call to undeclared function 'static_branch_likely' error
> > > > 
> > > > Since v2:
> > > >  - move the W=1 warning fix to a separate patch
> > > >  - move the unified way to use static key to a new patch series.
> > > > 
> > > > Since v1:
> > > >  - Add a W=1 warning fix
> > > >  - Fix W=1 error
> > > >  - Based on v5.18-rcN, since SV57 support is added, so convert
> > > >    pgtable_l5_enabled as well.
> > > > 
> > > > 
> > > > Jisheng Zhang (2):
> > > >   riscv: move sbi_init() earlier before jump_label_init()
> > > >   riscv: turn pgtable_l4|[l5]_enabled to static key for RV64
> > > > 
> > > >  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
> > > >  arch/riscv/include/asm/pgtable-32.h |  3 ++
> > > >  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
> > > >  arch/riscv/include/asm/pgtable.h    |  5 +--
> > > >  arch/riscv/kernel/cpu.c             |  4 +-
> > > >  arch/riscv/kernel/setup.c           |  2 +-
> > > >  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
> > > >  arch/riscv/mm/kasan_init.c          | 16 ++++----
> > > >  8 files changed, 104 insertions(+), 66 deletions(-)
> > > 
> > > Sorry for being slow here, but it looks like this still causes some early
> > > boot hangs.  Specifically kasan+sparsemem is failing.  As you can probably
> > > see from the latency I'm still a bit buried right now so I'm not sure when
> > > I'll have a chance to take more of a look.
> > 
> > Hi Palmer,
> > 
> > Before V4, there is a bug which can cause kernel panic when SPARSEMEM
> > is enabled, V4 have fixed it by moving the riscv_finalise_pgtable_lx()
> > after sparse_init(). And I just tested the riscv-pgtable_static_key
> > branch in your tree, enabling KASAN and SPARSEMEM, system booted fine.
> > I'm not sure what happened. Could you please send me your kernel
> > config file? I want to fix any issue which can block this series being
> > merged in 6.1-rc1.
> 
> Hi Palmer,
> 
> I know you are busy ;) Do you have time to send me your test kernel
> config file so that I can reproduce the "early boot hang"?
> 
> Thanks

Hi Palmer,

I think the early boot hangs maybe the same as the one which has been
fixed by commit 9f2ac64d6ca6 ("riscv: mm: add missing memcpy in
kasan_init"). Will you give this series another try for v6.2-rc1? If
the boot hang can still be reproduced, could you please send me your
.config file?

Thanks in advance
