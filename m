Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41A8744317
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjF3UOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjF3UN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DA268A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 024C561773
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 20:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB05C433C8;
        Fri, 30 Jun 2023 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688156036;
        bh=9GNb15ETaSBgvT30j9MS7caLifXtMu0PGBzMP0Nntfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqgkhHWQ+gP9YU/xZQo4rkL5KPghbqETljWSD5N7+MtUYMmgQyQW/d6nAJguRXcl0
         L+JRsQyrS106ED+rTW9qcBYQ+qTobp4bj56bRcFxrFyTYZJuFmGk2JVcdl8hft6Bfn
         z++jTrLxfKxtNS3k20nu1tf4jLuRd++R0rNsfeni8VJ4hOLqjhxedpEDVriBRha43W
         eGann6ZvZHN2aY4LTwfL96cmUvJi+7FVdCE4GjgfQDi5L1VqqEpjYGUAlr+Ggg6N1R
         V+Dswtxz0cQk0wEe057SU4yCG/MM3iNBpkLHZyLsJJ1Be+n/+ZPOGeVT00GPJaY6Gp
         6CSjJoiPiFWqA==
Date:   Fri, 30 Jun 2023 13:13:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] riscv: KCFI support
Message-ID: <20230630201354.GA3346845@dev-arch.thelio-3990X>
References: <20230629234244.1752366-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-8-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Thu, Jun 29, 2023 at 11:42:45PM +0000, Sami Tolvanen wrote:
> This series adds KCFI support for RISC-V. KCFI is a fine-grained
> forward-edge control-flow integrity scheme supported in Clang >=16,
> which ensures indirect calls in instrumented code can only branch to
> functions whose type matches the function pointer type, thus making
> code reuse attacks more difficult.
> 
> Patch 1 implements a pt_regs based syscall wrapper to address
> function pointer type mismatches in syscall handling. Patches 2 and 3
> annotate indirectly called assembly functions with CFI types. Patch 4
> implements error handling for indirect call checks. Patch 5 disables
> CFI for arch/riscv/purgatory. Patch 6 finally allows CONFIG_CFI_CLANG
> to be enabled for RISC-V.
> 
> Note that Clang 16 has a generic architecture-agnostic KCFI
> implementation, which does work with the kernel, but doesn't produce
> a stable code sequence for indirect call checks, which means
> potential failures just trap and won't result in informative error
> messages. Clang 17 includes a RISC-V specific back-end implementation
> for KCFI, which emits a predictable code sequence for the checks and a
> .kcfi_traps section with locations of the traps, which patch 5 uses to
> produce more useful errors.
> 
> The type mismatch fixes and annotations in the first three patches
> also become necessary in future if the kernel decides to support
> fine-grained CFI implemented using the hardware landing pad
> feature proposed in the in-progress Zicfisslp extension. Once the
> specification is ratified and hardware support emerges, implementing
> runtime patching support that replaces KCFI instrumentation with
> Zicfisslp landing pads might also be feasible (similarly to KCFI to
> FineIBT patching on x86_64), allowing distributions to ship a unified
> kernel binary for all devices.

I boot tested ARCH=riscv defconfig + CONFIG_CFI_CLANG=y with both clang
16.0.6 and a recent LLVM 17.0.0 from tip of tree and saw no issues while
booting. I can confirm that both kernels panic when running the
CFI_FORWARD_PROTO LKDTM test.

LLVM 17.0.0:

[  100.722815] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[  100.723061] lkdtm: Calling matched prototype ...
[  100.723217] lkdtm: Calling mismatched prototype ...
[  100.723861] CFI failure at lkdtm_indirect_call+0x22/0x32 (target: lkdtm_increment_int+0x0/0x18; expected type: 0x3ad55aca)
[  100.724191] Kernel BUG [#1]
[  100.724226] Modules linked in:
[  100.724343] CPU: 0 PID: 42 Comm: sh Not tainted 6.4.0-08887-ga68cded684a2 #1
[  100.724450] Hardware name: riscv-virtio,qemu (DT)
[  100.724552] epc : lkdtm_indirect_call+0x22/0x32
[  100.724586]  ra : lkdtm_CFI_FORWARD_PROTO+0x40/0x74
[  100.724603] epc : ffffffff805ee84c ra : ffffffff805ee6de sp : ff200000001a3cb0
[  100.724617]  gp : ffffffff8130ab70 tp : ff60000001b9d240 t0 : ff200000001a3b38
[  100.724631]  t1 : 000000003ad55aca t2 : 000000007e0c52a5 s0 : ff200000001a3cc0
[  100.724644]  s1 : 0000000000000001 a0 : ffffffff8130edc8 a1 : ffffffff805ee876
[  100.724658]  a2 : b5352d9a12ee0700 a3 : ffffffff8122e5c8 a4 : 0000000000000fff
[  100.724671]  a5 : 0000000000000004 a6 : 00000000000000b4 a7 : 0000000000000000
[  100.724683]  s2 : ff200000001a3e38 s3 : ffffffffffffffea s4 : 0000000000000012
[  100.724696]  s5 : ff6000000804c000 s6 : 0000000000000006 s7 : ffffffff80e8ca88
[  100.724709]  s8 : 0000000000000008 s9 : 0000000000000002 s10: ffffffff812bfd10
[  100.724722]  s11: ffffffff812bfd10 t3 : 0000000000000003 t4 : 0000000000000000
[  100.724735]  t5 : ff60000001858000 t6 : ff60000001858f00
[  100.724746] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[  100.724825] [<ffffffff805ee84c>] lkdtm_indirect_call+0x22/0x32
[  100.724886] [<ffffffff805ee6de>] lkdtm_CFI_FORWARD_PROTO+0x40/0x74
[  100.724898] [<ffffffff805eabbe>] lkdtm_do_action+0x22/0x32
[  100.724908] [<ffffffff805eab78>] direct_entry+0x124/0x136
[  100.724918] [<ffffffff8034af5a>] full_proxy_write+0x58/0xb2
[  100.724930] [<ffffffff801e139e>] vfs_write+0x14c/0x350
[  100.724941] [<ffffffff801e16fc>] ksys_write+0x64/0xd4
[  100.724951] [<ffffffff801e1782>] __riscv_sys_write+0x16/0x22
[  100.724961] [<ffffffff80005cec>] syscall_handler+0x4c/0x58
[  100.724973] [<ffffffff809355ac>] do_trap_ecall_u+0x3e/0x88
[  100.724996] [<ffffffff80003678>] ret_from_exception+0x0/0x64
[  100.725150] Code: 0513 5945 a303 ffc5 53b7 7e0c 839b 2a53 0363 0073 (9002) 9582
[  100.731204] ---[ end trace 0000000000000000 ]---
[  100.731327] Kernel panic - not syncing: Fatal exception in interrupt
[  100.731910] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

LLVM 16.0.6:

[   10.227530] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[   10.227755] lkdtm: Calling matched prototype ...
[   10.227900] lkdtm: Calling mismatched prototype ...
[   10.228721] Oops - illegal instruction [#1]
[   10.228856] Modules linked in:
[   10.228978] CPU: 0 PID: 1 Comm: sh Not tainted 6.4.0-08887-ga68cded684a2 #1
[   10.229077] Hardware name: riscv-virtio,qemu (DT)
[   10.229160] epc : lkdtm_indirect_call+0x2c/0x32
[   10.229242]  ra : lkdtm_CFI_FORWARD_PROTO+0x40/0x74
[   10.229259] epc : ffffffff805ef190 ra : ffffffff805ef018 sp : ff2000000000bcb0
[   10.229272]  gp : ffffffff8130a958 tp : ff600000018c8000 t0 : ff2000000000bb38
[   10.229285]  t1 : ff2000000000baa8 t2 : 0000000000000018 s0 : ff2000000000bcc0
[   10.229298]  s1 : 0000000000000001 a0 : 000000003ad55aca a1 : ffffffff805ef1b0
[   10.229310]  a2 : 000000007e0c52a5 a3 : ffffffff8122e548 a4 : 0000000000000fff
[   10.229322]  a5 : 0000000000000004 a6 : 00000000000000b4 a7 : 0000000000000000
[   10.229335]  s2 : ff2000000000be38 s3 : ffffffffffffffea s4 : 0000000000000012
[   10.229347]  s5 : ff6000000802f000 s6 : 0000000000000006 s7 : ffffffff80e8ca88
[   10.229360]  s8 : 0000000000000008 s9 : 0000000000000002 s10: ffffffff812bfc90
[   10.229372]  s11: ffffffff812bfc90 t3 : 0000000000000003 t4 : 0000000000000000
[   10.229385]  t5 : ff60000001858000 t6 : ff60000001858f00
[   10.229396] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000002
[   10.229478] [<ffffffff805ef190>] lkdtm_indirect_call+0x2c/0x32
[   10.229538] [<ffffffff805ef018>] lkdtm_CFI_FORWARD_PROTO+0x40/0x74
[   10.229550] [<ffffffff805eb4d4>] lkdtm_do_action+0x20/0x34
[   10.229560] [<ffffffff805eb490>] direct_entry+0x124/0x136
[   10.229570] [<ffffffff80349cf0>] full_proxy_write+0x56/0xb2
[   10.229582] [<ffffffff801e0620>] vfs_write+0x14a/0x34e
[   10.229593] [<ffffffff801e097e>] ksys_write+0x64/0xd4
[   10.229602] [<ffffffff801e0a04>] __riscv_sys_write+0x16/0x22
[   10.229611] [<ffffffff800056fe>] syscall_handler+0x4a/0x58
[   10.229622] [<ffffffff80936428>] do_trap_ecall_u+0x3e/0x88
[   10.229649] [<ffffffff80003678>] ret_from_exception+0x0/0x64
[   10.229860] Code: 00c5 1517 00d2 0513 c4a5 9582 60a2 6402 0141 8082 (0000) 52a5
[   10.235769] ---[ end trace 0000000000000000 ]---
[   10.235892] Kernel panic - not syncing: Fatal exception in interrupt
[   10.236488] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
