Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C916374A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKXJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:59:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E907EBB9CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669280394; x=1700816394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SYMn1xjyNPJRlpfzzjpdSX05OnXmyIiSsLWKetV8rHk=;
  b=ww/WBPwqFgt66dcjS4xXW8l5B75j7OSpgaDrm0GT8DHwJXcmmpAzc6PW
   y5k/31TGcSxqDyEbBxkRQIvToWWqNTs72xvsQXG8eC9/C9lIQ6Gd+9jfQ
   2dsV+fOfu3UHVAquRfoD7I37QeTRnRRsCztT+SxSBa1qvWYyq34xlhiJk
   s7g2xv2qrDTigE05Qpf/adZAH5Vj4SWLXELikUG/7oWUAuiKSx/gAIn+i
   3R1xZqX1mptJXVMqkUsWk4C8I+Hw1gKfXhHOe3PHsotb1TBRHWQgFreis
   mWzrbI0Ct8M/GTr7Fg3yVSXD/AGIjm9BNmi833VgwsWAQvVBb5ZrZTjaT
   w==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="124918613"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 01:59:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 01:59:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 01:59:50 -0700
Date:   Thu, 24 Nov 2022 08:59:32 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Deepak Gupta <debug@rivosinc.com>
CC:     Guo Ren <guoren@kernel.org>, <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <paul.walmsley@sifive.com>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <Y38ydMoqmqOPfBs0@wendy>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <CAJF2gTQ=Vr6neABtz9JSCei6oPEsyWTpb-Y=Rxt5jy6n1VEtGA@mail.gmail.com>
 <CAKC1njRfxNx8r5SP7qsbouCFfb1L4w63paQibb=cFCBhWDXNXA@mail.gmail.com>
 <CAJF2gTRC-qm76=aaLh75amO0JJLO2P4eZaJXH-TBSV0c7iqUBA@mail.gmail.com>
 <20221124071022.GA1149630@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221124071022.GA1149630@debug.ba.rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:10:22PM -0800, Deepak Gupta wrote:
> On Thu, Nov 24, 2022 at 02:31:25PM +0800, Guo Ren wrote:
> > On Thu, Nov 24, 2022 at 1:57 PM Deepak Gupta <debug@rivosinc.com> wrote:

> > > On Wed, Nov 23, 2022 at 5:28 PM Guo Ren <guoren@kernel.org> wrote:

> > > > On Thu, Nov 24, 2022 at 8:50 AM Deepak Gupta <debug@rivosinc.com> wrote:

> > > >> Fixes: 31da94c25aea835ceac00575a9fd206c5a833fed
> > > >
> > > > The patch gives more significant change than the Fixes, and Fixes would expand to the previous stable versions. Please don't set it as a Fixes, but an improved OVERSTACK dead path performance feature.
> > > >
> > > 
> > > Not a performance feature but more like correctness.
> > > If kernel died and two CPUs raced to kernel stack overflow,
> > > death post-mortem should be straightforward.
> > We already have had a fixup, and your patch likes a feature with a
> > significant change.
> > https://lore.kernel.org/linux-riscv/20221030124517.2370-1-jszhang@kernel.org/
> > If it is for correctness, the simple lock is enough.
> 
> Sure lock is enough. It's different way to solve the problem. But I don't
> think it qualifies as significant change.

Something to bear in mind is where in the cycle we are - there's likely
just over a week left before v6.1.
Since the lock is sufficient to fix the problem for v6.1, it's easy to
view this patch as an optimisation or improvement that should go on top
of that, smaller, patch.
Especially when you have some questions yourself about the correctness
for 32 bit!
I've got no technical comment to make about the discussion here, but
looking in from the "outside", that's the easy conclusion to jump to.


>	REG_S x31, TASK_TI_SPILL_REG(tp)
>	asm_per_cpu sp, overflow_stack, x31
>	li x31, OVERFLOW_STACK_SIZE
>	add sp, sp, x31
>	REG_L x31, TASK_TI_SPILL_REG(tp)

btw, for this sort of thing, could you please use some whitespace to
align the operands? Makes things significantly more readable.

Thanks,
Conor.

