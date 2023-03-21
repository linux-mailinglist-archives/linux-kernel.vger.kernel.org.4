Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA696C364F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCUP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB001BAD7;
        Tue, 21 Mar 2023 08:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D3B61D01;
        Tue, 21 Mar 2023 15:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF93C433D2;
        Tue, 21 Mar 2023 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679414188;
        bh=sV7yWhm3Wpc6nFVwU3vrMTTk99vkybjn2C9WDkFggrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnsWLAmSkFMbR0LuoyYJtoyF1Ta6jksja+T7KULFdiFB9ynKTKthvzoYLX+nehfVl
         ulZHzYQouqMU/ExfQs6vtclh56CrhDTiIRCJcs7fAarc3n7VxOXGS3I8mT/shIzKg0
         yq0jWOhI+5b8jSPxjZYX2J0wgljtW9/4Mzev8/shWrbpItY4PQXewJ69TKl33/UmAU
         TOTAOmM8YHE7zkHY5cqvsdDJwWZ1iBOY7aphlle7huHcUD0n5azpXCjBDueKiTxnBB
         Kd36MUA00Hypdw+QXgYbD/nDBL27H6rv6PpbbOh84etN/p7uX5eMgkfBWvMPSFEEK7
         1GsL9rzDhj2KA==
Date:   Tue, 21 Mar 2023 08:56:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
Message-ID: <20230321155626.GA3765079@dev-arch.thelio-3990X>
References: <CA+G9fYsTk0GPOTEMm1KG2iJvMLG0SqUfG0JSenRYFHuOQTpuxw@mail.gmail.com>
 <ZBl4Zi03pzURXkD9@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBl4Zi03pzURXkD9@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:27:02AM +0100, Petr Mladek wrote:
> Hi,
> 
> I add Luis into Cc.
> 
> On Tue 2023-03-21 11:42:56, Naresh Kamboju wrote:
> > The following kernel crash was noticed on arm64 Juno-r2 and Raspberry Pi 4
> > Model B on Linux next-20230321.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > log:
> > ----
> > [    3.071500] Unable to handle kernel paging request at virtual
> > address 0000000000001000
> 
> I guess that this is exactly PAGE_SIZE (4k).
> 
> > [    3.079432] Mem abort info:
> > [    3.082225]   ESR = 0x0000000096000004
> > [    3.085977]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    3.091295]   SET = 0, FnV = 0
> > [    3.094350]   EA = 0, S1PTW = 0
> > [    3.097491]   FSC = 0x04: level 0 translation fault
> > [    3.102373] Data abort info:
> > [    3.105252]   ISV = 0, ISS = 0x00000004
> > [    3.109089]   CM = 0, WnR = 0
> > [    3.112055] [0000000000001000] user address but active_mm is swapper
> > [    3.114230] usb 1-1: new high-speed USB device number 2 using ehci-platform
> > [    3.118418] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > [    3.118426] Modules linked in:
> > [    3.134717] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> > 6.3.0-rc3-next-20230321 #1
> > [    3.142126] Hardware name: ARM Juno development board (r2) (DT)
> > [    3.148052] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    3.155027] pc : string (lib/vsprintf.c:644 lib/vsprintf.c:726)
> > [    3.158443] lr : vsnprintf (lib/vsprintf.c:2817)
> > [    3.162196] sp : ffff80000b34b8f0
> > [    3.165511] x29: ffff80000b34b8f0 x28: ffff800009d7b1ca x27: ffff80000b34bab0
> > [    3.172666] x26: ffff800009d7b1ca x25: 0000000000000020 x24: 0000000000000008
> > [    3.179820] x23: 00000000ffffffd8 x22: ffff8000099858a0 x21: ffff80000b34bc30
> > [    3.186973] x20: ffff80000b34ba90 x19: ffff80000b34ba98 x18: 000000003c98bfdd
> > [    3.194127] x17: 000000000000001c x16: 00000000eec48da2 x15: 00000000a9dbdd17
> > [    3.201280] x14: ffff80000b0242e8 x13: 0000000057a049ef x12: 00000000cfa47237
> > [    3.208433] x11: 0000000000000001 x10: 00000000bd5b8780 x9 : ffff80000812cbec
> > [    3.215586] x8 : 00000000ffffffff x7 : 0000000000000002 x6 : ffff80000b34ba98
> > [    3.222739] x5 : ffffffffffffffff x4 : 0000000000000000 x3 : ffff0a00ffffff04
> > [    3.229891] x2 : 0000000000001000 x1 : 0000000000000000 x0 : ffff80000b34bab0
> > [    3.237044] Call trace:
> > [    3.239489] string (lib/vsprintf.c:644 lib/vsprintf.c:726)
> 
> This is the line where vsprintf() reads a string to be printed:
> 
> static char *string_nocheck(char *buf, char *end, const char *s,
> 			    struct printf_spec spec)
> {
> 	int len = 0;
> 	int lim = spec.precision;
> 
> 	while (lim--) {
> ---->		char c = *s++;
> 
> 
> > [    3.242551] vsnprintf (lib/vsprintf.c:2817)
> > [    3.245954] vprintk_store (kernel/printk/printk.c:2200)
> > [    3.249712] vprintk_emit (kernel/printk/printk.c:2297)
> > [    3.253381] vprintk_default (kernel/printk/printk.c:2328)
> > [    3.257137] vprintk (kernel/printk/printk_safe.c:50)
> > [    3.260198] _printk (kernel/printk/printk.c:2341)
> > [    3.263257] sysctl_err (fs/proc/proc_sysctl.c:1109)
> > [    3.266577] __register_sysctl_table (fs/proc/proc_sysctl.c:1140
> > fs/proc/proc_sysctl.c:1383)
> > [    3.271202] __register_sysctl_init (fs/proc/proc_sysctl.c:1462)
> 
> The has been done some reractoring/modification of this code
> by the patchset ("[PATCH 00/11] sysctl: deprecate
> register_sysctl_paths()"), see
> https://lore.kernel.org/lkml/20230302202826.776286-1-mcgrof@kernel.org/
> 
> Luis, does it trigger any bell, please?
> Do you have an idea where this code could pass a pointer PAGE_SIZE
> as string to printk("%s")?

My bisect actually landed on commit cfe7e6ea5ee2 ("mm: memory-failure:
Move memory failure sysctls to its own file"). The new sysctl table is
missing a sentinel. The following diff resolves it for me.

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6367714af61d..b2377f12f062 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -143,6 +143,7 @@ static struct ctl_table memory_failure_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{ }
 };
 
 static int __init memory_failure_sysctl_init(void)

Cheers,
Nathan

# bad: [f3594f0204b756638267242e26d9de611435c3ba] Add linux-next specific files for 20230321
# good: [7d31677bb7b1944ac89e9155110dc1b9acbb3895] gpu: host1x: fix uninitialized variable use
git bisect start 'f3594f0204b756638267242e26d9de611435c3ba' '7d31677bb7b1944ac89e9155110dc1b9acbb3895'
# good: [454faa8515d7c7b90b3e291bc7cc1a84697a23d9] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 454faa8515d7c7b90b3e291bc7cc1a84697a23d9
# good: [9bfa51aa7b4f87fe6215a200cca280ebd1c111b4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 9bfa51aa7b4f87fe6215a200cca280ebd1c111b4
# good: [c637c9b5d4540e07ed95698a67770c5fd2241d7e] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
git bisect good c637c9b5d4540e07ed95698a67770c5fd2241d7e
# good: [f1fb10a55d81bc43b7c16e96122c8611e0131ca2] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
git bisect good f1fb10a55d81bc43b7c16e96122c8611e0131ca2
# good: [d3294413e4518ef8b31ee46535c873ef0b8a1d1a] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect good d3294413e4518ef8b31ee46535c873ef0b8a1d1a
# good: [009e0171be8db0a77624899623fadcb59fc40a12] Merge branch 'main' of git://git.infradead.org/users/willy/xarray.git
git bisect good 009e0171be8db0a77624899623fadcb59fc40a12
# bad: [cfe7e6ea5ee2149cf2dfc69d3f8a220ab00cb65d] mm: memory-failure: Move memory failure sysctls to its own file
git bisect bad cfe7e6ea5ee2149cf2dfc69d3f8a220ab00cb65d
# good: [2e88a8303d02ff107fd6aa5041f9def177483956] proc_sysctl: enhance documentation
git bisect good 2e88a8303d02ff107fd6aa5041f9def177483956
# good: [8869a82dcbbf6fbe584ffff16b620b68281b3180] ntfs: simplfy one-level sysctl registration for ntfs_sysctls
git bisect good 8869a82dcbbf6fbe584ffff16b620b68281b3180
# good: [7385b7cb60e030f0041c8c83d17d3c63e598c77d] ppc: simplify one-level sysctl registration for nmi_wd_lpm_factor_ctl_table
git bisect good 7385b7cb60e030f0041c8c83d17d3c63e598c77d
# good: [36657db1c77c1539812cc1303119cf4ad2e8f34a] x86: simplify one-level sysctl registration for itmt_kern_table
git bisect good 36657db1c77c1539812cc1303119cf4ad2e8f34a
# good: [0234a6faf178985c74806e33bde8a9e3052d3555] arm: simplify two-level sysctl registration for ctl_isa_vars
git bisect good 0234a6faf178985c74806e33bde8a9e3052d3555
# first bad commit: [cfe7e6ea5ee2149cf2dfc69d3f8a220ab00cb65d] mm: memory-failure: Move memory failure sysctls to its own file
