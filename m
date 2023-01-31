Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80290682C97
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjAaMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAaMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:32:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB786728F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:32:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A26DB81BF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F3DC433EF;
        Tue, 31 Jan 2023 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675168371;
        bh=XMt8AVXDCOd/Rs6vc6kQue3V5MV99U//73gnlqRozJ8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NtoDolA9YmbmzDvm8CPAiURc5XXn4kDciE21UhO5RAUKwKWv3Z6dFb9Uj/nl+YnZp
         3LxpXYCT87RzLo1V/ym9bgvNEjQu5FPLt24BbFTCcEeEOmcpbmeLNPVjeK5VR+/a2J
         7/tRu3UAn6ic2BtQfhSI4vPEsFWMY5gYmCdIJMkbZd+C7W6rT7varD/XT3EPwSBL1J
         YKJCuLdqcj0+CQxOFJqHuuq9RyuKih84QTeyTY5vyAPWE83v87+gDeYOYqC5uCj2c+
         XvvLf6nz0kjfVTaBTQ1eaupt6g27W0edoqCYVGtgS5xxMK8K0ogcg7OE1fJviBrxXg
         U33ZJFCwAYS4g==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, guoren@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, liaochang (A) <liaochang1@huawei.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an
 illegal position
In-Reply-To: <20230126130509.1418251-1-guoren@kernel.org>
References: <20230126130509.1418251-1-guoren@kernel.org>
Date:   Tue, 31 Jan 2023 13:32:48 +0100
Message-ID: <878rhig9zj.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> The kernel would panic when probed for an illegal position. eg:
>
> (CONFIG_RISCV_ISA_C=3Dn)
>
> echo 'p:hello kernel_clone+0x16 a0=3D%a0' >> kprobe_events
> echo 1 > events/kprobes/hello/enable
> cat trace
>
> Kernel panic - not syncing: stack-protector: Kernel stack
> is corrupted in: __do_sys_newfstatat+0xb8/0xb8
> CPU: 0 PID: 111 Comm: sh Not tainted
> 6.2.0-rc1-00027-g2d398fe49a4d #490
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff80007268>] dump_backtrace+0x38/0x48
> [<ffffffff80c5e83c>] show_stack+0x50/0x68
> [<ffffffff80c6da28>] dump_stack_lvl+0x60/0x84
> [<ffffffff80c6da6c>] dump_stack+0x20/0x30
> [<ffffffff80c5ecf4>] panic+0x160/0x374
> [<ffffffff80c6db94>] generic_handle_arch_irq+0x0/0xa8
> [<ffffffff802deeb0>] sys_newstat+0x0/0x30
> [<ffffffff800158c0>] sys_clone+0x20/0x30
> [<ffffffff800039e8>] ret_from_syscall+0x0/0x4
> ---[ end Kernel panic - not syncing: stack-protector:
> Kernel stack is corrupted in: __do_sys_newfstatat+0xb8/0xb8 ]---
>
> That is because the kprobe's ebreak instruction broke the kernel's
> original code. The user should guarantee the correction of the probe
> position, but it couldn't make the kernel panic.
>
> This patch adds arch_check_kprobe in arch_prepare_kprobe to prevent an
> illegal position (Such as the middle of an instruction).

Nice!

@liaochang Will you remove your patch from the OPTPROBE series?

> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index f21592d20306..475989f06d6d 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -48,6 +48,21 @@ static void __kprobes arch_simulate_insn(struct kprobe=
 *p, struct pt_regs *regs)
>  	post_kprobe_handler(p, kcb, regs);
>  }
>=20=20
> +static bool __kprobes arch_check_kprobe(struct kprobe *p)
> +{
> +	unsigned long tmp  =3D (unsigned long)p->addr - p->offset;
> +	unsigned long addr =3D (unsigned long)p->addr;
> +
> +	while (tmp <=3D addr) {
> +		if (tmp =3D=3D addr)
> +			return true;
> +
> +		tmp +=3D GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);

kprobe_opcode_t is u32; This can trigger a misaligned load, right?

> +	}
> +
> +	return false;
> +}
> +
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr =3D (unsigned long)p->addr;
> @@ -55,6 +70,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	if (probe_addr & 0x1)
>  		return -EILSEQ;
>=20=20
> +	if (!arch_check_kprobe(p))
> +		return -EILSEQ;
> +
>  	/* copy instruction */
>  	p->opcode =3D *p->addr;

Not related to your patch, but this can also trigger a misaligned load.


Bj=C3=B6rn
