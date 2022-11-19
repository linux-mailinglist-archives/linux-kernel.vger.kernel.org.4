Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DFE630B39
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiKSDh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKSDhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:37:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E69BBDF6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:37:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD63262835
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22546C4314B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668829073;
        bh=jdtEd1yJuImh5kI6vRvy1ZCkO2ErZlB1ed7aIMIbf3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSW/aJ1EU21gpHZec0YPncXqSCPnAX4jgNloFfLtj9tOavGrHuYtOUMZDzrEHrl92
         1c+3V556KQ8GguTIzpWmc6VpHOyk2BhxjuCl/dg+NIYfywczmwc6rHQ0Bs0WzgN8Ub
         4ckHd793ZnBu/EUA1+jyXqQCao33O8q6/ylkT7iouCJ4GX09cZx7C0+BH4GmswJpJu
         oEV1Ra08t1E2wMI353Fwj8PXZYy4EUZT5qJ9tvHWQqtwu67FdWKkidtnegRRQT34zi
         Dy+DkFh2WgnWKW10QeVwyxLi0dxPCRM5D0+ZtoOW6nMj6L1lnDxA+q+gPSEORkLZcQ
         Yd4y0LNhb6Z5Q==
Received: by mail-ej1-f43.google.com with SMTP id vv4so8085618ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:37:53 -0800 (PST)
X-Gm-Message-State: ANoB5plVxCHGoXA1m2Lms8z1wP7/Dpy+WnJ7zhLmtceUp0lj695VyJBC
        BXJREYzXYkrCrAbKgJB9atPp+TiHBnisKqCEsW0=
X-Google-Smtp-Source: AA0mqf6/nFnovDVdY+ezojw/XN96ryAKiLKFYZme8d3Jy1z86DjgSZwwmF8tpmL1GF38JbkynkwXxPj57zeHvWTxbmI=
X-Received: by 2002:a17:907:9856:b0:780:8144:a41f with SMTP id
 jj22-20020a170907985600b007808144a41fmr8499669ejc.189.1668829071133; Fri, 18
 Nov 2022 19:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20221111075902.798571-1-guoren@kernel.org> <Y3fxsWPLPlKGfMBj@curiosity>
In-Reply-To: <Y3fxsWPLPlKGfMBj@curiosity>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 19 Nov 2022 11:37:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQgqRwjOYKB9Z6OdYoogsHWWVTw5anwNqoQjhmK_A41g@mail.gmail.com>
Message-ID: <CAJF2gTRQgqRwjOYKB9Z6OdYoogsHWWVTw5anwNqoQjhmK_A41g@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 4:57 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> Hi Guo Ren,
>
>
> > After use_asid_allocator is enabled, the userspace application will
> > crash by stale TLB entries. Because only using cpumask_clear_cpu without
> > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > Then set_mm_asid would cause the user space application to get a stale
> > value by stale TLB entry, but set_mm_noasid is okay.
>
> ... [snip]
>
> > +     /*
> > +      * The mm_cpumask indicates which harts' TLBs contain the virtual
> > +      * address mapping of the mm. Compared to noasid, using asid
> > +      * can't guarantee that stale TLB entries are invalidated because
> > +      * the asid mechanism wouldn't flush TLB for every switch_mm for
> > +      * performance. So when using asid, keep all CPUs footmarks in
> > +      * cpumask() until mm reset.
> > +      */
> > +     cpumask_set_cpu(cpu, mm_cpumask(next));
> > +     if (static_branch_unlikely(&use_asid_allocator)) {
> > +             set_mm_asid(next, cpu);
> > +     } else {
> > +             cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > +             set_mm_noasid(next);
> > +     }
> >  }
>
> I observe similar user-space crashes on my SMP systems with enabled ASID.
> My attempt to fix the issue was a bit different, see the following patch:
>
> https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
>
> In brief, the idea was borrowed from flush_icache_mm handling:
> - keep track of CPUs not running the task
> - perform per-ASID TLB flush on such CPUs only if the task is switched there
>
> Your patch also works fine in my tests fixing those crashes. I have a
> question though, regarding removed cpumask_clear_cpu. How CPUs no more
> running the task are removed from its mm_cpumask ? If they are not
> removed, then flush_tlb_mm/flush_tlb_page will broadcast unnecessary
> TLB flushes to those CPUs when ASID is enabled.
A task would be migrated to any CPU by the scheduler. So keeping TLB
contents synced with cpumask_set/clear needs additional tlb_flush just
like noasid, and your patch still follows that style. The worth of
ASID is avoiding tlb_flush during the context switch. Yes, my patch
would increase some tlb_flush IPI costs. But when mapping is stable,
no tlb_flush is needed during the switch_mm (Hackbench would be
beneficiary because no more TLB flush is needed at his hot point
path). Here are my points:
 - We copied the arm64 globally unique asid mechanism into riscv,
which depends on hardware broadcast TLB flush. My fixup patch is
closer to the original principle design, proven in the arm64 world.
 - If riscv continues local TLB flush hw design in ISA spec, please
try x86's per-CPU array of ASID. But that is a significant change;
let's fix the current issue with the smallest patch first.

In the end, thx your review and test.
--
Best Regards
 Guo Ren
