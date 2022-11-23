Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0846359DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiKWK2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiKWK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:27:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B14E1201;
        Wed, 23 Nov 2022 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669198215; x=1700734215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+TpboofMEOuW566fs/EUm7LVwp3TsGK1qTspl5yq6EM=;
  b=Nw2KUAJZxpKLHs+mq5v4zuEb6vH9wli7azI0Nrhr5NqmIeg0lTNaWsFY
   dduTaPtS7QVCzlnMHb1ctXKobhXiLgStnAIO8+MK5AtFWK4ReAADuxfr8
   yYPdXjNp+bVn7eCREyE8DpdF9W2kAb4DzXqs/fjJJOonnmiueeXWmoJ1/
   rn9qRObn1gEi+4MswCiwIrFWNUO8a/1jYjv80i5TMUVUectjCyo1jtYjS
   FQQcUnjVWtCBcOV5Way5jK8mIlk5TfwZwYZqKVtDjbG5CzHoh4PtdHNSm
   WmV9Of1KhwbuT30IQx2DB3YBBwEYIHDC2Z7v5XEBpFun0RKy1znL498T6
   g==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="188305129"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 03:10:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 03:10:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 03:10:09 -0700
Date:   Wed, 23 Nov 2022 10:09:51 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-pm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux@rivosinc.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
Message-ID: <Y33xb0jxZqdexzRc@wendy>
References: <CAAhSdy0Fs9ZVoRgtz92RgLnFPvgwUzCP_KpK9SCOiVsA-t3p3Q@mail.gmail.com>
 <mhng-3f44cc1f-7305-41c5-a1cf-dfed096bd364@palmer-ri-x1c9>
 <CAK9=C2USZHdfBQrrgd2Rs3u3_gTyscpRgxvPU5P6ptOPu1+Axg@mail.gmail.com>
 <Y3ywTzv3vbgRXQGG@wendy>
 <CAAhSdy1UwBQwX2jnmJXUAAjFL5TZXTUrs9yf9DRMSH=GV4BcHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAhSdy1UwBQwX2jnmJXUAAjFL5TZXTUrs9yf9DRMSH=GV4BcHg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

On Wed, Nov 23, 2022 at 09:56:31AM +0530, Anup Patel wrote:
> On Tue, Nov 22, 2022 at 4:50 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > On Tue, Nov 22, 2022 at 11:06:15AM +0530, Anup Patel wrote:
> > > On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > > >
> > > > On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
> > > > > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > > > >>
> > > > >> From: Palmer Dabbelt <palmer@rivosinc.com>
> > > > >>
> > > > >> As per [1], whether or not the core can wake up from non-retentive
> > > > >> suspend is a platform-specific detail.  We don't have any way to encode
> > > > >> that, so just stop using them until we've sorted that out.
> > > > >>
> > > > >> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> > > > >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> > > > >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > >
> > > > > This is just unnecessary maintenance churn and it's not the
> > > > > right way to go. Better to fix this the right way instead of having
> > > > > a temporary fix.
> > > > >
> > > > > I had already sent-out a patch series 5 months back to describe
> > > > > this in DT:
> > > > > https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
> > > > >
> > > > > No one has commented/suggested anything (except Samuel
> > > > > Holland and Sudeep Holla).
> > > >
> > > > I see some comments from Krzysztof here
> > > > <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
> > > > as well.  Looks like everyone is pointing out that having our CPU nodes
> > > > encode timers is a bad idea, my guess is that they're probably right.
> > >
> > > Adding a separate timer DT node, creates a new set of compatibility
> > > issues for existing platforms. I am fine updating my series to have
> > > separate timer DT node but do we want to go in this direction ?
> >
> > I don't really follow. How is there a compatibility issue created by
> > adding a new node that is not added for a new property? Both will
> > require changes to the device tree. (You need not reply here, I am going
> > to review the other thread, it's been on my todo list for too long. Been
> > caught up with non-coherent stuff & our sw release cycle..)
> 
> Adding a new timer DT node would mean, the RISC-V timer driver
> will now be probed using the compatible to the new DT node whereas
> the RISC-V timer driver is currently probed using CPU DT nodes.

Ahh, that is what I have missed. I'll continue my thoughts on this in
the dt-binding thread.

> > > Even if ARM has a separate timer DT node, the timers are still part
> > > of the CPU. It depends on how we see the DT bindings aligning with
> > > actual HW.
> > >
> > > >
> > > > > Please review this series. I can quickly address comments to
> > > > > make this available for Linux-6.2. Until this series is merged,
> > > > > the affected platforms can simply remove non-retentive suspend
> > > > > states from their DT.
> > > >
> > > > That leaves us with a dependency between kernel versions and DT
> > > > bindings: kernels with the current driver will result in broken systems
> > > > with the non-retentive suspend states in the DT they boot with when
> > > > those states can't wake up the CPU.
> >
> > Can someone point me at a (non D1 or virt) system that has suspend
> > states in the DT that would need fixing?
> 
> For the QEMU virt machine, the default non-retentive suspend state was
> tested using a temporary DTB provided separately via QEMU command
> line. The QEMU virt machine does not have its own HART suspend
> states so OpenSBI will functionally emulate default retentive/non-retentive
> suspend states.

So since I asked for non D1 or virt systems, that's a no & no DTs
actually needs to be fixed :)

> > > This is not a new problem we are facing. Even in the ARM world,
> > > the DT bindings grew organically over time based on newer platform
> > > requirements.
> > >
> > > Now that we have a platform which does not want the time
> > > C3STOP feature, we need to first come-up with DT bindings
> > > to support this platform instead of temporarily disabling
> > > features which don't work on this platform.
> >
> > It's the opposite surely? It should be "now that we have a platform that
> > *does want* the C3STOP feature", right?
> 
> Yes, we can think this way as well.

No, there's no "thinking" involved here from what I can tell. Pre-D1
systems do not seem to need the flag and the D1 does want that flag for
its riscv,timer. We have to operate with respect to hardware timelines
& the corresponding software implementations, not specs in this context.

If it was the case that you proposed, there would be no chance for
regressions if someone updates their kernel but not their DT.

> > > > > With all due respect, NACK to this patch from my side.
> >
> > As Samuel pointed out that the D1 doesn't actually use the timer in
> > question, I think we are okay here?
> 
> Yes, that's why D1 needs the C3STOP flag.

I don't understand what you mean here, you don't appear to be replying
to what I said.

I was saying that the current D1 configuration does not actually use
the timer-riscv driver as there's another one that has a higher rating
& therefore we are okay to not apply this patch as my revert will not
cause it to be put into sleep states that it cannot return from.

Your reply makes no sense to me in that context.

Thanks,
Conor.

