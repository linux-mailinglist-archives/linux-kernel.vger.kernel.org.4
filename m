Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209E86C378A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCUQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:59:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C87521CC;
        Tue, 21 Mar 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bsYvFZRC1l1mRKF8zyfpXpF1SJmmtGNcW5sRV3d5hkk=; b=GCVTHQezRqRcsVVVvIrbaTt/yT
        BJT5jUwrGLClyeLOLq4qr7qev15AItF0zaqWICUSwgCynez7ntPuyHVZWJDuzfd0r6xLRO8pulvXM
        5AHStIwpURNTrOmM6cETzQagUM8L5J5Ye/hSEcJrRkP+u+oPRHx42RE5ZaWOYX8dbpJs/3atLbCBe
        1YVMNcXsikjPztrMxDQnYBjslv42yo8EO2u2ePPYCMpWScmfzPq9Bu4ns9jyuO1bMfMpuAKBPGz4G
        O4JrbXFjHC/b9VzPDsLmRGOvwmtepBGeZgaJhar24bk08CdV8FuMGln0lxlfmdRd7VMGaJJwUYtVV
        swhE+/uA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pefKm-00D9Yk-26;
        Tue, 21 Mar 2023 16:59:40 +0000
Date:   Tue, 21 Mar 2023 09:59:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: next-20230321: arm64: Unable to handle kernel paging request at
 virtual address
Message-ID: <ZBnifM5B/E5weCnF@bombadil.infradead.org>
References: <CA+G9fYsTk0GPOTEMm1KG2iJvMLG0SqUfG0JSenRYFHuOQTpuxw@mail.gmail.com>
 <ZBl4Zi03pzURXkD9@alley>
 <20230321155626.GA3765079@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321155626.GA3765079@dev-arch.thelio-3990X>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:56:26AM -0700, Nathan Chancellor wrote:
> On Tue, Mar 21, 2023 at 10:27:02AM +0100, Petr Mladek wrote:
> > Hi,
> > 
> > I add Luis into Cc.
> > 
> > On Tue 2023-03-21 11:42:56, Naresh Kamboju wrote:
> > > The following kernel crash was noticed on arm64 Juno-r2 and Raspberry Pi 4
> > > Model B on Linux next-20230321.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > log:
> > > ----
> > > [    3.071500] Unable to handle kernel paging request at virtual
> > > address 0000000000001000
> > 
> > I guess that this is exactly PAGE_SIZE (4k).
> > 
> > > [    3.079432] Mem abort info:
> > > [    3.082225]   ESR = 0x0000000096000004
> > > [    3.085977]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [    3.091295]   SET = 0, FnV = 0
> > > [    3.094350]   EA = 0, S1PTW = 0
> > > [    3.097491]   FSC = 0x04: level 0 translation fault
> > > [    3.102373] Data abort info:
> > > [    3.105252]   ISV = 0, ISS = 0x00000004
> > > [    3.109089]   CM = 0, WnR = 0
> > > [    3.112055] [0000000000001000] user address but active_mm is swapper
> > > [    3.114230] usb 1-1: new high-speed USB device number 2 using ehci-platform
> > > [    3.118418] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > > [    3.118426] Modules linked in:
> > > [    3.134717] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> > > 6.3.0-rc3-next-20230321 #1
> > > [    3.142126] Hardware name: ARM Juno development board (r2) (DT)
> > > [    3.148052] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    3.155027] pc : string (lib/vsprintf.c:644 lib/vsprintf.c:726)
> > > [    3.158443] lr : vsnprintf (lib/vsprintf.c:2817)
> > > [    3.162196] sp : ffff80000b34b8f0
> > > [    3.165511] x29: ffff80000b34b8f0 x28: ffff800009d7b1ca x27: ffff80000b34bab0
> > > [    3.172666] x26: ffff800009d7b1ca x25: 0000000000000020 x24: 0000000000000008
> > > [    3.179820] x23: 00000000ffffffd8 x22: ffff8000099858a0 x21: ffff80000b34bc30
> > > [    3.186973] x20: ffff80000b34ba90 x19: ffff80000b34ba98 x18: 000000003c98bfdd
> > > [    3.194127] x17: 000000000000001c x16: 00000000eec48da2 x15: 00000000a9dbdd17
> > > [    3.201280] x14: ffff80000b0242e8 x13: 0000000057a049ef x12: 00000000cfa47237
> > > [    3.208433] x11: 0000000000000001 x10: 00000000bd5b8780 x9 : ffff80000812cbec
> > > [    3.215586] x8 : 00000000ffffffff x7 : 0000000000000002 x6 : ffff80000b34ba98
> > > [    3.222739] x5 : ffffffffffffffff x4 : 0000000000000000 x3 : ffff0a00ffffff04
> > > [    3.229891] x2 : 0000000000001000 x1 : 0000000000000000 x0 : ffff80000b34bab0
> > > [    3.237044] Call trace:
> > > [    3.239489] string (lib/vsprintf.c:644 lib/vsprintf.c:726)
> > 
> > This is the line where vsprintf() reads a string to be printed:
> > 
> > static char *string_nocheck(char *buf, char *end, const char *s,
> > 			    struct printf_spec spec)
> > {
> > 	int len = 0;
> > 	int lim = spec.precision;
> > 
> > 	while (lim--) {
> > ---->		char c = *s++;
> > 
> > 
> > > [    3.242551] vsnprintf (lib/vsprintf.c:2817)
> > > [    3.245954] vprintk_store (kernel/printk/printk.c:2200)
> > > [    3.249712] vprintk_emit (kernel/printk/printk.c:2297)
> > > [    3.253381] vprintk_default (kernel/printk/printk.c:2328)
> > > [    3.257137] vprintk (kernel/printk/printk_safe.c:50)
> > > [    3.260198] _printk (kernel/printk/printk.c:2341)
> > > [    3.263257] sysctl_err (fs/proc/proc_sysctl.c:1109)
> > > [    3.266577] __register_sysctl_table (fs/proc/proc_sysctl.c:1140
> > > fs/proc/proc_sysctl.c:1383)
> > > [    3.271202] __register_sysctl_init (fs/proc/proc_sysctl.c:1462)
> > 
> > The has been done some reractoring/modification of this code
> > by the patchset ("[PATCH 00/11] sysctl: deprecate
> > register_sysctl_paths()"), see
> > https://lore.kernel.org/lkml/20230302202826.776286-1-mcgrof@kernel.org/
> > 
> > Luis, does it trigger any bell, please?
> > Do you have an idea where this code could pass a pointer PAGE_SIZE
> > as string to printk("%s")?
> 
> My bisect actually landed on commit cfe7e6ea5ee2 ("mm: memory-failure:
> Move memory failure sysctls to its own file"). The new sysctl table is
> missing a sentinel. The following diff resolves it for me.
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 6367714af61d..b2377f12f062 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -143,6 +143,7 @@ static struct ctl_table memory_failure_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{ }
>  };

Thanks pushed this fix in to sysctl-next.

  Luis
