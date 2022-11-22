Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19CF633B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKVL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiKVL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:26:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF31606AC;
        Tue, 22 Nov 2022 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669116007; x=1700652007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yEGM0bLZYKdCMc87oRno0uNXS7/YK4qufWtxP5E5skc=;
  b=CBCsRCweb9MFgVf6IhejmV0hpipPIr4jFX5CRB58vPSn+5sLmNFJYZUi
   OOE42Dl76XVwFrd3wAcdLDJzPczjWKF36l0eDS1t9K/m3IktbUKbBuFj7
   RCKpbIG3hiC24YCjkmWlXA/xG3DlwHfSChXmSxsxwzQ5eilji5Syb9fE6
   6yk12jbYwPEl6ZGB/5vcB1wCypk/T47PhbSKn8T5ffNNFo4dTnix0RoWy
   V7tCr4wTDJlIEv9NtONBguSwtQSjHo/yLRyi28vVJOd3CFbdeSdMlFYS4
   elU87pwqW4gW/MCWC8215nsJSBVIDpOHBk1xyLDkFFaetFEg6eC0NWOfH
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="188128298"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 04:20:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 04:20:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 04:20:01 -0700
Date:   Tue, 22 Nov 2022 11:19:43 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>, <anup@brainfault.org>,
        Conor Dooley <conor@kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-pm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux@rivosinc.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
Message-ID: <Y3ywTzv3vbgRXQGG@wendy>
References: <CAAhSdy0Fs9ZVoRgtz92RgLnFPvgwUzCP_KpK9SCOiVsA-t3p3Q@mail.gmail.com>
 <mhng-3f44cc1f-7305-41c5-a1cf-dfed096bd364@palmer-ri-x1c9>
 <CAK9=C2USZHdfBQrrgd2Rs3u3_gTyscpRgxvPU5P6ptOPu1+Axg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK9=C2USZHdfBQrrgd2Rs3u3_gTyscpRgxvPU5P6ptOPu1+Axg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:06:15AM +0530, Anup Patel wrote:
> On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
> > > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > >>
> > >> From: Palmer Dabbelt <palmer@rivosinc.com>
> > >>
> > >> As per [1], whether or not the core can wake up from non-retentive
> > >> suspend is a platform-specific detail.  We don't have any way to encode
> > >> that, so just stop using them until we've sorted that out.
> > >>
> > >> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> > >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> > >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > >
> > > This is just unnecessary maintenance churn and it's not the
> > > right way to go. Better to fix this the right way instead of having
> > > a temporary fix.
> > >
> > > I had already sent-out a patch series 5 months back to describe
> > > this in DT:
> > > https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
> > >
> > > No one has commented/suggested anything (except Samuel
> > > Holland and Sudeep Holla).
> >
> > I see some comments from Krzysztof here
> > <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
> > as well.  Looks like everyone is pointing out that having our CPU nodes
> > encode timers is a bad idea, my guess is that they're probably right.
> 
> Adding a separate timer DT node, creates a new set of compatibility
> issues for existing platforms. I am fine updating my series to have
> separate timer DT node but do we want to go in this direction ?

I don't really follow. How is there a compatibility issue created by
adding a new node that is not added for a new property? Both will
require changes to the device tree. (You need not reply here, I am going
to review the other thread, it's been on my todo list for too long. Been
caught up with non-coherent stuff & our sw release cycle..)

> Even if ARM has a separate timer DT node, the timers are still part
> of the CPU. It depends on how we see the DT bindings aligning with
> actual HW.
> 
> >
> > > Please review this series. I can quickly address comments to
> > > make this available for Linux-6.2. Until this series is merged,
> > > the affected platforms can simply remove non-retentive suspend
> > > states from their DT.
> >
> > That leaves us with a dependency between kernel versions and DT
> > bindings: kernels with the current driver will result in broken systems
> > with the non-retentive suspend states in the DT they boot with when
> > those states can't wake up the CPU.

Can someone point me at a (non D1 or virt) system that has suspend
states in the DT that would need fixing?

> This is not a new problem we are facing. Even in the ARM world,
> the DT bindings grew organically over time based on newer platform
> requirements.
> 
> Now that we have a platform which does not want the time
> C3STOP feature, we need to first come-up with DT bindings
> to support this platform instead of temporarily disabling
> features which don't work on this platform.

It's the opposite surely? It should be "now that we have a platform that
*does want* the C3STOP feature", right?

> > > With all due respect, NACK to this patch from my side.

As Samuel pointed out that the D1 doesn't actually use the timer in
question, I think we are okay here?

> > >>
> > >> ---
> > >>
> > >> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
> > >> Events are stopped during CPU suspend"), which fixes suspend on the D1
> > >> but breaks timers everywhere.
> > >> ---
> > >>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
> > >>  1 file changed, 11 insertions(+)
> > >>
> > >> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > >> index 05fe2902df9a..9d1063a54495 100644
> > >> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > >> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > >> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
> > >>         if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
> > >>             state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
> > >>                 return false;
> > >> +
> > >> +       /*
> > >> +        * Whether or not RISC-V systems deliver interrupts to harts in a
> > >> +        * non-retentive suspend state is a platform-specific detail.  This can
> > >> +        * leave the hart unable to wake up, so just mark these states as
> > >> +        * unsupported until we have a mechanism to expose these
> > >> +        * platform-specific details to Linux.
> > >> +        */
> > >> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
> > >> +               return false;
> > >> +
> > >>         return true;
> > >>  }
> > >>
> > >> --
> > >> 2.38.1
> > >>
