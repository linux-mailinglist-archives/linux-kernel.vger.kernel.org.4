Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA0676339
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjAUDAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAUDAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:00:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C40FF3F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47794B829E4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 03:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB55EC433EF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674270005;
        bh=WUO2zgwHSs1XEO3//QO+1eCwnBhiuBAw5jtF+7photc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DDXLHrEPfwZLwblYMlY+8CnroYsa9xB/le8AfSfjZstFhGesVEIHGF/pb1mqvoxXp
         zzWam57IvweuK0vdTZdeCIYCTeWUfrDcjQLjJVRAOKMkOcnFGrdloKbP6Q+xchI3Z2
         WbBnraSrKm08rCmzOJIRaLarxL20Um7B5J7Yl7OhfXJRnX6m5rS/Fi5QxVSgnPos2K
         BoQWsnqdZ57cr+aKIl3qCNDQEc62qIQXeBg9hgzcbxtZIA+W+2E65rHXDU5if8QZbH
         5EUwG3QTdAOWkq2c7Olct9PUYt2XD39ik4x1ayvwXI+DtMhw18haFKKAJ2iI5+hmFp
         1DCc+fnBm0C5A==
Received: by mail-ej1-f52.google.com with SMTP id az20so18441705ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:00:04 -0800 (PST)
X-Gm-Message-State: AFqh2kqWnV51jg+OiZ2L5264cI0b/EQyqDRVhuOr2FeirCl/vdeCqibB
        DlrCBuepjOaVbMvqxNZSQLcNKsSAXulvTJ5U9jA=
X-Google-Smtp-Source: AMrXdXvxTH60ikgGr5f+HcLRAkIyFIAkW9m1OSZJIKCctpbhshR4Z6KR6ZIoKFiy+D68T00Xva/Se8NSD6gXWHoAJNI=
X-Received: by 2002:a17:906:3487:b0:861:7caf:c252 with SMTP id
 g7-20020a170906348700b008617cafc252mr1662752ejb.212.1674270003199; Fri, 20
 Jan 2023 19:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20230116064342.2092136-1-liaochang1@huawei.com>
In-Reply-To: <20230116064342.2092136-1-liaochang1@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 21 Jan 2023 10:59:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQifm_uJ4pEFTZdfj2NWbNA1Xr3s7iT=drDhk_BQfTbBg@mail.gmail.com>
Message-ID: <CAJF2gTQifm_uJ4pEFTZdfj2NWbNA1Xr3s7iT=drDhk_BQfTbBg@mail.gmail.com>
Subject: Re: [PATCH] riscv/kprobe: Fix instruction simulation of JALR
To:     Liao Chang <liaochang1@huawei.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, me@packi.ch,
        penberg@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, bjorn@kernel.org, chenlifu@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 2:46 PM Liao Chang <liaochang1@huawei.com> wrote:
>
> Set kprobe at 'jalr 1140(ra)' of vfs_write results in the following
> crash:
>
> [   32.092235] Unable to handle kernel access to user memory without uaccess routines at virtual address 00aaaaaad77b1170
> [   32.093115] Oops [#1]
> [   32.093251] Modules linked in:
> [   32.093626] CPU: 0 PID: 135 Comm: ftracetest Not tainted 6.2.0-rc2-00013-gb0aa5e5df0cb-dirty #16
> [   32.093985] Hardware name: riscv-virtio,qemu (DT)
> [   32.094280] epc : ksys_read+0x88/0xd6
> [   32.094855]  ra : ksys_read+0xc0/0xd6
> [   32.095016] epc : ffffffff801cda80 ra : ffffffff801cdab8 sp : ff20000000d7bdc0
> [   32.095227]  gp : ffffffff80f14000 tp : ff60000080f9cb40 t0 : ffffffff80f13e80
> [   32.095500]  t1 : ffffffff8000c29c t2 : ffffffff800dbc54 s0 : ff20000000d7be60
> [   32.095716]  s1 : 0000000000000000 a0 : ffffffff805a64ae a1 : ffffffff80a83708
> [   32.095921]  a2 : ffffffff80f160a0 a3 : 0000000000000000 a4 : f229b0afdb165300
> [   32.096171]  a5 : f229b0afdb165300 a6 : ffffffff80eeebd0 a7 : 00000000000003ff
> [   32.096411]  s2 : ff6000007ff76800 s3 : fffffffffffffff7 s4 : 00aaaaaad77b1170
> [   32.096638]  s5 : ffffffff80f160a0 s6 : ff6000007ff76800 s7 : 0000000000000030
> [   32.096865]  s8 : 00ffffffc3d97be0 s9 : 0000000000000007 s10: 00aaaaaad77c9410
> [   32.097092]  s11: 0000000000000000 t3 : ffffffff80f13e48 t4 : ffffffff8000c29c
> [   32.097317]  t5 : ffffffff8000c29c t6 : ffffffff800dbc54
> [   32.097505] status: 0000000200000120 badaddr: 00aaaaaad77b1170 cause: 000000000000000d
> [   32.098011] [<ffffffff801cdb72>] ksys_write+0x6c/0xd6
> [   32.098222] [<ffffffff801cdc06>] sys_write+0x2a/0x38
> [   32.098405] [<ffffffff80003c76>] ret_from_syscall+0x0/0x2
>
> Since the rs1 and rd might be the same one, such as 'jalr 1140(ra)',
> hence it requires obtaining the target address from rs1 followed by
> updating rd.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/kernel/probes/simulate-insn.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
> index d73e96f6ed7c..02aa262fb2ac 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -71,17 +71,13 @@ bool __kprobes simulate_jalr(u32 opcode, unsigned long addr, struct pt_regs *reg
>         u32 rd_index = (opcode >> 7) & 0x1f;
>         u32 rs1_index = (opcode >> 15) & 0x1f;
>
> -       ret = rv_insn_reg_set_val(regs, rd_index, addr + 4);
> -       if (!ret)
> -               return ret;
> -
>         ret = rv_insn_reg_get_val(regs, rs1_index, &base_addr);
>         if (!ret)
>                 return ret;
Ah, thank you, If rd == rs1,  the regs-><rs1> got a overwritten value,
my mistake. We should read rs1 firstly.

But for the patch, just exchanging the position is enough; keep the
original sequence for coding convention.
eg:
@@ -71,11 +71,11 @@ bool __kprobes simulate_jalr(u32 opcode, unsigned
long addr, struct pt_regs *reg
        u32 rd_index = (opcode >> 7) & 0x1f;
        u32 rs1_index = (opcode >> 15) & 0x1f;

-       ret = rv_insn_reg_set_val(regs, rd_index, addr + 4);
+       ret = rv_insn_reg_get_val(regs, rs1_index, &base_addr);
        if (!ret)
                return ret;

-       ret = rv_insn_reg_get_val(regs, rs1_index, &base_addr);
+       ret = rv_insn_reg_set_val(regs, rd_index, addr + 4);
        if (!ret)
                return ret;

Then:
Reviewed-by: Guo Ren <guoren@kernel.org>



>
>         instruction_pointer_set(regs, (base_addr + sign_extend32((imm), 11))&~1);
>
> -       return ret;
> +       return rv_insn_reg_set_val(regs, rd_index, addr + 4);
>  }
>
>  #define auipc_rd_idx(opcode) \
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
