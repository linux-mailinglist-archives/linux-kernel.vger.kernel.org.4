Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C11745CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGCNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGCNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:02:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AA80CA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:02:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C57542F4;
        Mon,  3 Jul 2023 06:02:48 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B5D3F73F;
        Mon,  3 Jul 2023 06:02:04 -0700 (PDT)
Date:   Mon, 3 Jul 2023 14:01:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: qemu-arm64: Unexpected kernel BRK exception at EL1 - WARNING:
 CPU: 3 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop
Message-ID: <ZKLGtXXlOhjYSww1@FVFF77S0Q05N>
References: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
 <d41a6d08-981b-481b-9108-fe91afaa0f82@app.fastmail.com>
 <CA+G9fYt0Sh-0vFQSWjJz0di-vAc-Ke-bwjqyGM=d_M==x6OnOg@mail.gmail.com>
 <ZKKaOeRj5Quf00S2@FVFF77S0Q05N>
 <cd9d8682-08b6-4307-9eb7-9ac838d62eb2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9d8682-08b6-4307-9eb7-9ac838d62eb2@app.fastmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:03:38PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 3, 2023, at 11:51, Mark Rutland wrote:
> > On Mon, Jul 03, 2023 at 12:02:22PM +0530, Naresh Kamboju wrote:
> >> On Sun, 2 Jul 2023 at 13:56, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Sat, Jul 1, 2023, at 10:42, Naresh Kamboju wrote:
> >> >
> >> 
> >> Here is the build artifacts location with kselftest merge configs.
> >> https://storage.tuxsuite.com/public/linaro/lkft/builds/2Rum1V78RQJMftEanwtN28dApDO/
> >
> > In your .config here, I note you have:
> >
> > | CONFIG_UBSAN_TRAP=y
> >
> > Can you try this with CONFIG_UBSAN_TRAP=n ?
> >
> >> [   56.150153] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> >> sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
> >> [   56.151781] CPU: 0 PID: 438 Comm: seccomp_bpf Not tainted 6.4.0 #1
> >> [   56.152043] Hardware name: linux,dummy-virt (DT)
> >> [   56.152396] pstate: 41400005 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> >> [   56.152667] pc : alloc_pid+0x3b4/0x3c8
> >> [   56.154243] lr : alloc_pid+0x140/0x3c8
> >
> > Looking at objdump, that's:
> >
> > | ffff8000800d73b0 <alloc_pid>:
> > | ...
> > | ffff8000800d7764:       d4207d00        brk     #0x3e8
> >
> > ... and addr2line fingers this as:
> >
> > | [mark@lakrids:~/tmp-naresh-kamboju]% usekorg 10.3.0 
> > aarch64-linux-addr2line -ife vmlinux ffff8000800d7764                   
> >        
> > | alloc_pid
> > | /builds/linux/kernel/pid.c:244
> >
> > ... which appears to be:
> >
> > | 244                 pid->numbers[i].nr = nr;
> >
> > Full objdump of the function below; as above I suspect this is UBSAN triggering
> > a __builtin_trap() on an out-of-range access.
> 
> It looks like a fix has already made it into mainline now, so it
> should be fixed on the latest linux-next:
> 
> https://lore.kernel.org/lkml/20230630180418.gonna.286-kees@kernel.org/

Thanks for the pointer!

Mark.
