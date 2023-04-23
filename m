Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60EE6EBE22
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDWI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97E2700
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 01:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA05360F1E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C779C433D2;
        Sun, 23 Apr 2023 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682240215;
        bh=EuVQevi3GafI4guHg34N0jSUyUsuS4brrJy72U2kSX8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=U4peiDlBgQu1fr6J+U0F9kUpkTf3TGEZ72jIjpDRI3+NvvHDqeNLUNHDsPBSyBMsP
         n36eUg50v/iJCJXx9JSt69JEVqPVscQm8tnClEDFC4QvoRlSrBcegfqdJWe6x602ch
         jfNgneYXy5D3Q5mylsfEqNuGoT8KLDaxUgBR5kFaGQDnv9TNLqpjCYKxrubWlOPkaF
         U3HiL0+GVLuvnbCBc4fadWOIzh5KGRChiqS6ok2Zu3FtNT0X14Tk4Xur461J7ny75s
         DZwZod8HD0snECK7V2G76n5TZyzpeaS8EutC+vvVaz2eO2dgv/U3xZ701Kaw7rbyZM
         TQlFdIsY8phZA==
Date:   Sun, 23 Apr 2023 09:56:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     ruanjinjie <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
CC:     ruanjinjie@huawei.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND=5D_riscv=3A_fix_kprobe?= =?US-ASCII?Q?_=5F=5Fuser_string_arg_print_fault_issue?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230423012912.890965-1-ruanjinjie@huawei.com>
References: <20230423012912.890965-1-ruanjinjie@huawei.com>
Message-ID: <F17EE38C-5C44-411B-BAFA-B71EEAAC0BDA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 April 2023 02:29:12 IST, ruanjinjie <ruanjinjie@huawei=2Ecom> wrote:
>On riscv qemu platform, when add kprobe event on do_sys_open() to show
>filename string arg, it just print fault as follow:
>
>echo 'p:myprobe do_sys_open dfd=3D$arg1 filename=3D+0($arg2):string flags=
=3D$arg3
>mode=3D$arg4' > kprobe_events
>
>bash-166     [000] =2E=2E=2E1=2E   360=2E195367: myprobe: (do_sys_open+0x=
0/0x84)
>dfd=3D0xffffffffffffff9c filename=3D(fault) flags=3D0x8241 mode=3D0x1b6
>
>bash-166     [000] =2E=2E=2E1=2E   360=2E219369: myprobe: (do_sys_open+0x=
0/0x84)
>dfd=3D0xffffffffffffff9c filename=3D(fault) flags=3D0x8241 mode=3D0x1b6
>
>bash-191     [000] =2E=2E=2E1=2E   360=2E378827: myprobe: (do_sys_open+0x=
0/0x84)
>dfd=3D0xffffffffffffff9c filename=3D(fault) flags=3D0x98800 mode=3D0x0
>
>As riscv do not select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
>the +0($arg2) addr is processed as a kernel address though it is a
>userspace address, cause the above filename=3D(fault) print=2E So select
>ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to avoid the issue, after that the
>kprobe trace is ok as below:
>
>bash-166     [000] =2E=2E=2E1=2E    96=2E767641: myprobe: (do_sys_open+0x=
0/0x84)
>dfd=3D0xffffffffffffff9c filename=3D"/dev/null" flags=3D0x8241 mode=3D0x1=
b6
>
>bash-166     [000] =2E=2E=2E1=2E    96=2E793751: myprobe: (do_sys_open+0x=
0/0x84)
>dfd=3D0xffffffffffffff9c filename=3D"/dev/null" flags=3D0x8241 mode=3D0x1=
b6
>
>bash-177     [000] =2E=2E=2E1=2E    96=2E962354: myprobe: (do_sys_open+0x=
0/0x84)
>dfd=3D0xffffffffffffff9c filename=3D"/sys/kernel/debug/tracing/events/kpr=
obes/"
>flags=3D0x98800 mode=3D0x0
>
>Signed-off-by: ruanjinjie <ruanjinjie@huawei=2Ecom>
>---
> arch/riscv/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>index eb7f29a412f8=2E=2Ec51f0d3227af 100644
>--- a/arch/riscv/Kconfig
>+++ b/arch/riscv/Kconfig
>@@ -26,6 +26,7 @@ config RISCV
> 	select ARCH_HAS_KCOV
> 	select ARCH_HAS_MMIOWB
> 	select ARCH_HAS_PMEM_API
>+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE

Please add this in alphabetical order, thanks=2E

> 	select ARCH_HAS_PTE_SPECIAL
> 	select ARCH_HAS_SET_DIRECT_MAP if MMU
> 	select ARCH_HAS_SET_MEMORY if MMU
