Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76B65FC34D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJLJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJLJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:53:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4563F05;
        Wed, 12 Oct 2022 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665568400; x=1697104400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OPG3s+9CXT0QwJB4pJ7tlvmxNG4ycLF3KJasH+oBYLY=;
  b=vyVh7AmQk47/jUbaWcfXwaQueqTteYbipCXKjQEOiBhzCceSCjr3gtqW
   /E0iweF/TcRgN11A/wtXnni1dBjbXmsi0awKo+oKiLVaeuvuMlxwatH92
   S+VRYjo1LEoZg99HfOkG0beMZgEM2WVpXZXuSH31wp7x3hKNbJbz1dD7+
   kRuSaIWGZWGaYjmu8reiQnL8uR0xyGxfV4ABWPbpCfbpr5bUV8PEy65b4
   qxeu51qHrS725HOlJ4zbj9CwUCkkAXJDiyRM0kn3qHLHv4Gs1nbYVfqlQ
   MABEH+F/BQfpxM26fQaEbELjH6jCdQIsV2YQo/ZA2DbaiRkUn+x8gvuX1
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="118161375"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2022 02:53:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 12 Oct 2022 02:53:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 12 Oct 2022 02:53:12 -0700
Date:   Wed, 12 Oct 2022 10:52:50 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>, <heiko@sntech.de>,
        <guoren@kernel.org>, <mick@ics.forth.gr>,
        <alexandre.ghiti@canonical.com>, <bhe@redhat.com>,
        <vgoyal@redhat.com>, <dyoung@redhat.com>, <corbet@lwn.net>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <heinrich.schuchardt@canonical.com>,
        <k-hagio-ab@nec.com>, <hschauhan@nulltrace.org>,
        <yixun.lan@gmail.com>
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Message-ID: <Y0aOcsf06a2+ExrU@wendy>
References: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014>
 <f8d3ae66-73a8-db89-c4c4-918610fb5f35@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8d3ae66-73a8-db89-c4c4-918610fb5f35@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 05:42:37PM +0800, Xianting Tian wrote:
> 
> 在 2022/8/12 上午12:17, Palmer Dabbelt 写道:
> > On Thu, 11 Aug 2022 00:41:44 PDT (-0700),
> > xianting.tian@linux.alibaba.com wrote:
> > > I ever sent the patch 1 in the link:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
> > > 
> > > And patch 2,3 in the link:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
> > > 
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
> > > 
> > > 
> > > This patch set just put these patches together, and with three new
> > > patch 4, 5, 6.
> > > these six patches are the fixups for machine_kexec, kernel mode PC
> > > for vmcore
> > > and improvements for vmcoreinfo, memory layout dump and fixup
> > > schedule out issue
> > > in machine_crash_shutdown().
> > > 
> > > The main changes in the six patchs as below,
> > > Patch 1: Fixup use of smp_processor_id() in preemptible context, to
> > > cleanup
> > >          the console prints.
> > > Patch 2: Fixup to get correct kernel mode PC for kernel mode regs
> > > for vmcore.
> > > Patch 3: Fixup schedule out issue in machine_crash_shutdown()
> > > Patch 4: Add modules to virtual kernel memory layout dump.
> > > Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can
> > > simplify
> > >          the development of crash tool as ARM64 already did
> > >          (arch/arm64/kernel/crash_core.c).
> > > Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.
> > > 
> > > With these six patches(patch 2 is must), crash tool can work well to
> > > analyze
> > > a vmcore. The patches for crash tool for RISCV64 is in the link:
> > > https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/
> > > 
> > > 
> > > ------
> > > Changes v1 -> v2:
> > >   1, remove the patch "Add a fast call path of crash_kexec()" from
> > > this series
> > >      of patches, as it already applied to riscv git.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
> > >   2, add 'Reviewed-by' based on the comments of v1.
> > > Changes v2 -> v3:
> > >   use "riscv" instead of "riscv64" in patch 5 subject line.
> > > Changes v3 -> v4:
> > >   use "riscv" instead of "riscv64" in the summary of patch 5 subject
> > > line.
> > > Changes v4 -> v5:
> > >   add a new patch "RISC-V: Fixup schedule out issue in
> > > machine_crash_shutdown()"
> > > Changes v5 -> v6:
> > >   1, move "fixup" patches to the start of the patch set.
> > >   2, change patch 1, 2, 6's subject to make it tell more what it's
> > > about.
> > >   3, add Fixes for patch 3.
> > >   4, adjuest the changes format for patch 6.
> > > 
> > > 
> > > Xianting Tian (6):
> > >   RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
> > >   RISC-V: Fixup get incorrect user mode PC for kernel mode regs
> > >   RISC-V: Fixup schedule out issue in machine_crash_shutdown()
> > >   RISC-V: Add modules to virtual kernel memory layout dump
> > >   RISC-V: Add arch_crash_save_vmcoreinfo support
> > >   Documentation: kdump: describe VMCOREINFO export for RISCV64
> > > 
> > >  .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
> > >  arch/riscv/kernel/Makefile                    |  1 +
> > >  arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
> > >  arch/riscv/kernel/crash_save_regs.S           |  2 +-
> > >  arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
> > >  arch/riscv/mm/init.c                          |  4 +++
> > >  6 files changed, 89 insertions(+), 6 deletions(-)
> > >  create mode 100644 arch/riscv/kernel/crash_core.c
> > 
> > Thank.  I've taken the first 4 onto for-next, which is still targeted
> > for 5.20, as they're fixes.  I'm not opposed to taking the documentation
> > patch for this cycle as well, it just needs some going-over as the
> > wording looks very odd (or at least it does to me right now, maybe I'm
> > just still half asleep).  Patch 5 is a new feature, and given that it's
> > being spun during the merge window it's too late.
> 
> Hi Palmer
> 
> Do you plan to merge the two patch to Linux 6.1 to support crash tool work? 
> thanks
> 
>   RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context

357628e68f5c ("RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context"

>   RISC-V: Fixup get incorrect user mode PC for kernel mode regs

59c026c359c3 ("RISC-V: Fixup get incorrect user mode PC for kernel mode regs")

Hey Xianting, those two commits already seem to have been applied, do
you perhaps instead mean the documentation patch and the addition of
support for arch_crash_save_vmcoreinfo? I recalled asking if you needed
to respin at the time, but do not see a response:
https://lore.kernel.org/linux-riscv/39fdc85e-b2d5-863c-4878-4b3380d76bc4@microchip.com/
IIRC Bagas had some outstanding comments on the documentation change
too. Was I incorrect?

Thanks,
Conor.

