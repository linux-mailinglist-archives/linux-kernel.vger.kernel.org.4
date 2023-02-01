Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91A26866F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBANby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBANbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:31:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D065F18
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 351CAB82188
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC88C433A0;
        Wed,  1 Feb 2023 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258230;
        bh=d3pYOO3WhZ4razYpGLFPieZwkLG3TuflhMepgqXStp0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OrON3B4WzY+JaJAZKOsjE7fOvkaVs3DQs68nylArJjdAvMIuuv6TRaga8Zh1uC+t8
         U6yeW1xm37y92xUf2ELhSUlAcMeN3brCSd4J5i1GNy63+0oSFUg0zqJPRAsxH3O+Vq
         b7IDvPlkHv72vUXbua+1kek5X1yaBxTRyRHzBuIgPxLkZmV9QgcdHSommViZBq7VSd
         R7tBhIjT9QwVO+nVAlnQzMzbL0PR+qXBeMT3REW41G7hiQp0gTUb9r23J5FbfJd++G
         igxx683+UGcQt/R6feIXHNfpzEMXSrGRKxFF+UJXPjjtTZznrBwRd/vfrbLWHXUqWW
         nJsddATgYntVA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v6 07/13] riscv/kprobe: Prepare detour buffer for
 optimized kprobe
In-Reply-To: <20230127130541.1250865-8-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-8-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:30:28 +0100
Message-ID: <87v8kltswb.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/op=
t.c
> index d84aa1420fa2..a47f7d2bf3a6 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c
> @@ -11,9 +11,32 @@
>  #include <linux/kprobes.h>
>  #include <asm/kprobes.h>
>  #include <asm/patch.h>
> +#include <asm/asm-offsets.h>
>=20=20
>  #include "simulate-insn.h"
>  #include "decode-insn.h"
> +#include "../../net/bpf_jit.h"
> +
> +static void optimized_callback(struct optimized_kprobe *op,
> +			       struct pt_regs *regs)
> +{
> +	if (kprobe_disabled(&op->kp))
> +		return;
> +
> +	preempt_disable();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(&op->kp);
> +	} else {
> +		__this_cpu_write(current_kprobe, &op->kp);
> +		/* Save skipped registers */
> +		instruction_pointer_set(regs, (unsigned long)op->kp.addr);
> +		get_kprobe_ctlblk()->kprobe_status =3D KPROBE_HIT_ACTIVE;
> +		opt_pre_handler(&op->kp, regs);
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +	preempt_enable();
> +}
> +NOKPROBE_SYMBOL(optimized_callback)
>=20=20
>  static int in_auipc_jalr_range(long val)
>  {
> @@ -30,6 +53,11 @@ static int in_auipc_jalr_range(long val)
>  #endif
>  }
>=20=20
> +#define DETOUR_ADDR(code, offs) \
> +	((void *)((unsigned long)(code) + (offs)))
> +#define DETOUR_INSN(code, offs) \
> +	(*(kprobe_opcode_t *)((unsigned long)(code) + (offs)))

Can this cause a misaligned u32 load exception?


Bj=C3=B6rn
