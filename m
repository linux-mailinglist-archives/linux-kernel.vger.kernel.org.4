Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59E6375C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKXJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKXJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:59:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381822F3B1;
        Thu, 24 Nov 2022 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669283959; x=1700819959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vwfci9L8RiCJZJk4q1ZcbZBshRi/h91hw6qStmAse7s=;
  b=R8wTkFVnyKs8yYs/1DkEDVEwUUZoqM2JI4jRSCyL7GCHN59+UPnr5AJE
   f0+3ot8ixHiMxpGK5Z7UkJdNq8wBi330TKxFRNQxa6K/Dtzds3ZIvGFGF
   hGUJZ/Ler3MhuFOyxXYXkvsKkx4Z20Q6imSDW5YQukO0XimO/VRUxv3j6
   5UIDu5P55hVNDCh8G4nvDc+FrgjiNPRXzpJ8lyb0QuxSoi7QcRiBrindr
   /x8ctYURQq7C0hnDzbKrsBGE5Jt6hkGSZ5kBCgcD8Vzq2FMp0SIo7bpGC
   ekhkmOw2kPZbpBEsx42GL2I4HsLm9duoFnK+jXoHv8ee+oQ+MAg7KctoY
   g==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="188489524"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 02:59:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 02:59:14 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 02:59:11 -0700
Date:   Thu, 24 Nov 2022 09:58:53 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, <linux-mm@kvack.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        <linux-man@vger.kernel.org>, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y39AXYPFzSiBngwI@wendy>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y385rS/5zDaDJ3Os@vermeer>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:30:21AM +0100, Samuel Ortiz wrote:
> On Mon, Jun 13, 2022 at 02:46:35AM +0800, Hongren (Zenithal) Zheng wrote:
> > diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
> > index 46dc3f5ee99f..bfed3e5c338c 100644
> > --- a/arch/riscv/include/uapi/asm/hwcap.h
> > +++ b/arch/riscv/include/uapi/asm/hwcap.h
> > @@ -22,4 +22,26 @@
> >  #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
> >  #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
> >  
> > +/*
> > + * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
> > + *
> > + * As only 32 bits of elf_hwcap (in kernel) could be used
> > + * and RISC-V has reserved 26 bits of it, other caps like
> > + * bitmanip and crypto can not be placed in AT_HWCAP
> > + */
> 
> Have we agreed that multi-letter ISA extensions would use hwcap to be
> exposed to userspace? With so many potential extensions, we could
> quickly run out of space on AT_HWCAP2 as well.

Palmer whipped up a PoC hwprobe interface (during Plumbers I think) that
Heiko is currently looking into - I think his motivation is misaligned
access performance. There's a branch but I have no idea if it even
compiles... I'm mostly waiting for whatever Heiko comes up with ;)

https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-hwprobe-v1

This patchset seems to need a rebase anyway per your other reply, but I
guess that the new proposed interface would be preferable?

Thanks,
Conor.

