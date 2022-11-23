Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656B635ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiKWK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiKWK4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:56:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249B26AD4;
        Wed, 23 Nov 2022 02:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669200415; x=1700736415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ExYIHLvCt5/rD5+mucH1shR+P7Rdt20GrJ8oCYWI4Bo=;
  b=F3UKxWJhaMKqmur6G8txAnfnguBXeaCQZSSy23irKaZxbee+zyC0i18p
   6tfNC/xp5w33fFn5n5bQRzN8sJf0QuKhpk8BmckTyPLOvdZ8yV0doWAvt
   gOvs7HE+Na0FpagnGK+KaVxjCamGfzEpeppHnpTUQuV+376q37O8xZOxY
   ZfHhAk5kNDfmuCxTjGxornvxucIftacEfRzZKBTD9hsl/J7JjebQ8wf1K
   /PO6vFZX3bndWlNeV60m2/G/CT+Tz1APWr1HNuxpBwOGxYcqDrC9Zbe1C
   MQF3tnb1h70qt3u1zQRtIl9kthhAXmy6QmKOm5x41jTn8S5Xsx9sfm5hT
   A==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="188309618"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 03:46:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 03:46:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 03:46:51 -0700
Date:   Wed, 23 Nov 2022 10:46:33 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, <anup@brainfault.org>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@rivosinc.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
Message-ID: <Y336CQ81NFv7Ev7n@wendy>
References: <20221121205647.23343-1-palmer@rivosinc.com>
 <bf6d3b1f-f703-4a25-833e-972a44a04114@sholland.org>
 <Y3ytSj6NEeU54z7m@wendy>
 <2309d3e5-0e37-c77b-1c0b-610abf0af62d@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2309d3e5-0e37-c77b-1c0b-610abf0af62d@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Samuel,

>On Tue, Nov 22, 2022 at 09:42:24PM -0600, Samuel Holland wrote:
> On 11/22/22 05:06, Conor Dooley wrote:
> > On Mon, Nov 21, 2022 at 06:45:25PM -0600, Samuel Holland wrote:
> > > On 11/21/22 14:56, Palmer Dabbelt wrote:

> > > > As per [1], whether or not the core can wake up from non-retentive
> > > > suspend is a platform-specific detail.  We don't have any way to encode
> > > > that, so just stop using them until we've sorted that out.
> > >
> > > We do have *exactly* a way to encode that. Specifically, the existence
> > > or non-existence of a non-retentive CPU suspend state in the DT.
> > >
> > > If a hart has no way of resuming from non-retentive suspend (i.e. a
> > > complete lack of interrupt delivery in non-retentive suspend), then it
> > > makes zero sense to advertise such a suspend state in the DT.
> > 
> > I would have to agree with that. I think the sprawling conversation has
> > confused us all at this point, I (prior to reading this mail) thought
> > that suspend was borked on the D1. I don't think anyone is advertising
> > specific states in the DT at the moment though, I had a check in the D1
> > patchset and didn't see anything there - unless you're adding it
> > dynamically from the bootloader?
> 
> The availability and latency properties of idle states depend on the SBI
> implementation, so yes, they need to be added dynamically.

Right, thanks for clarifying.

> > > I do not have any functioning RISC-V
> > > hardware with SMP, so it is hard for me to help debug the root issue in
> > > the Linux timer code. I do not know why turning on the C3STOP flag
> > > breaks RCU stall detection or clock_nanosleep(), but I agree that
> > > breakage should not happen.
> > >
> > > So while I still think 232ccac1bd9b is the right change to make from a
> > > "following the spec" standpoint
> > 
> > Right, so the spec says:
> > Request the SBI implementation to put the calling hart in a platform
> > specific suspend (or low power) state specified by the suspend_type
> > parameter. The hart will automatically come out of suspended state and
> > resume normal execution when it receives an interrupt or platform
> > specific hardware event.
> > 
> > That, as we have discussed a bunch of times, does not say whether a
> > given interrupt should actually arrive during suspend. The correct
> > behaviour, to me, is to assume that no events arrive during suspend.
> 
> Are you suggesting that we need some property to declare the delivery of
> each kind of interrupt (software, timer, external, PMU)? 

I'm possibly taking things to an extreme, since if we're having a
discussion that covers what the spec does and does not allow I see no
harm in going down the rabbit hole!

Obviously, some sort of event must get the CPU out of suspend - what I
meant was more like "The correct (software) behaviour, to me, is to
assume that, when looking at an individual source, its events may not
arrive during suspend."

I've not looked at the relevant specs to see if they specify whether
their interrupts *must* arrive, just the SBI one that the issue was
created against.

> I assumed that
> external interrupt delivery would be required to consider an idle state
> "viable", but I suppose it would be _possible_ to have a state where
> only timer interrupts are deliverable.

Who knows what some hardware folks will come up with! Maybe I am being
pretty <whatever the modern version of black & white> is here, but I
fear for a repeat whenever someone does something "creative".

I know I've not answered your question about other kinds of properties
but I am well outside my comfort zone here.

Thanks,
Conor.

