Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD25F859F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJHOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJHOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48C46600
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 126BF601D9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE06C433C1;
        Sat,  8 Oct 2022 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665239885;
        bh=7gh7jA80+eK+tl/5lADk03GZFDCmBhSdLTKRqaKkCWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ge2t8CQAVOs9ivEc83/rm8JdY3YSJnSUpsp9yGlGVor+VvQ/6GQf4xriVZmMWCFZz
         JeONQfV8F2Ldx/OFINzQXFWmsGgAp/a7xSSv1NffFbS2DDXAGzcM3xTzTlCRK4xlki
         DxuKCSh0tQYwialobjEqPt+c/IjvigZM8nQsWGHr/kmcb8YX29dzUfncfLrvKuRSf7
         99byC8VXPFb+H84eKQ7Hs5aPLkjF+YdPN+8Ekqm0sQ9sxwIXfAO2w7+91yAxAzJMgc
         YAX6NmT5iOqjgPoJMqbJrET5p8DgGJSC7wN/bVV8W/DGIr+j+fc7W7WQX6HUMJOxJa
         bAL73cZjY4Ryg==
Date:   Sat, 8 Oct 2022 22:28:30 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        alexandre.ghiti@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 RESEND 0/2] use static key to optimize
 pgtable_l4_enabled
Message-ID: <Y0GJDqLXFU81UdfW@xhacker>
References: <20220821140918.3613-1-jszhang@kernel.org>
 <mhng-30c89107-c103-4363-b4af-7778d9512622@palmer-ri-x1c9>
 <Yz6T4EYKKns7OIVE@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz6T4EYKKns7OIVE@xhacker>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 04:37:57PM +0800, Jisheng Zhang wrote:
> On Wed, Oct 05, 2022 at 06:05:28PM -0700, Palmer Dabbelt wrote:
> > On Sun, 21 Aug 2022 07:09:16 PDT (-0700), jszhang@kernel.org wrote:
> > > The pgtable_l4|[l5]_enabled check sits at hot code path, performance
> > > is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
> > > boot, so static key can be used to solve the performance issue[1].
> > > 
> > > An unified way static key was introduced in [2], but it only targets
> > > riscv isa extension. We dunno whether SV48 and SV57 will be considered
> > > as isa extension, so the unified solution isn't used for
> > > pgtable_l4[l5]_enabled now.
> > > 
> > > patch1 fixes a NULL pointer deference if static key is used a bit earlier.
> > > patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
> > > 
> > > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> > > [2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t
> > > 
> > > Since v5:
> > >  - Use DECLARE_STATIC_KEY_FALSE
> > > 
> > > Since v4:
> > >  - rebased on v5.19-rcN
> > >  - collect Reviewed-by tags
> > >  - Fix kernel panic issue if SPARSEMEM is enabled by moving the
> > >    riscv_finalise_pgtable_lx() after sparse_init()
> > > 
> > > Since v3:
> > >  - fix W=1 call to undeclared function 'static_branch_likely' error
> > > 
> > > Since v2:
> > >  - move the W=1 warning fix to a separate patch
> > >  - move the unified way to use static key to a new patch series.
> > > 
> > > Since v1:
> > >  - Add a W=1 warning fix
> > >  - Fix W=1 error
> > >  - Based on v5.18-rcN, since SV57 support is added, so convert
> > >    pgtable_l5_enabled as well.
> > > 
> > > 
> > > Jisheng Zhang (2):
> > >   riscv: move sbi_init() earlier before jump_label_init()
> > >   riscv: turn pgtable_l4|[l5]_enabled to static key for RV64
> > > 
> > >  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
> > >  arch/riscv/include/asm/pgtable-32.h |  3 ++
> > >  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
> > >  arch/riscv/include/asm/pgtable.h    |  5 +--
> > >  arch/riscv/kernel/cpu.c             |  4 +-
> > >  arch/riscv/kernel/setup.c           |  2 +-
> > >  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
> > >  arch/riscv/mm/kasan_init.c          | 16 ++++----
> > >  8 files changed, 104 insertions(+), 66 deletions(-)
> > 
> > Sorry for being slow here, but it looks like this still causes some early
> > boot hangs.  Specifically kasan+sparsemem is failing.  As you can probably
> > see from the latency I'm still a bit buried right now so I'm not sure when
> > I'll have a chance to take more of a look.
> 
> Hi Palmer,
> 
> Before V4, there is a bug which can cause kernel panic when SPARSEMEM
> is enabled, V4 have fixed it by moving the riscv_finalise_pgtable_lx()
> after sparse_init(). And I just tested the riscv-pgtable_static_key
> branch in your tree, enabling KASAN and SPARSEMEM, system booted fine.
> I'm not sure what happened. Could you please send me your kernel
> config file? I want to fix any issue which can block this series being
> merged in 6.1-rc1.

Hi Palmer,

I know you are busy ;) Do you have time to send me your test kernel
config file so that I can reproduce the "early boot hang"?

Thanks
