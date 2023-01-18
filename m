Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058BF671A96
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjARLaU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Jan 2023 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjARL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:29:52 -0500
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61BA125BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:49:05 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id bp15so51116174lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNJOWHq+We13SH7/7e+I5fS8M1OBmfqEsNTjgJP5AnE=;
        b=T/kzo3eSyhYOqPubySsXPqyVkDUpj5nuR2jRv76nAinhVs6kn/qJXJLxSzzbh/xiXK
         X8Sd0rB2zlJM9W/4r0D0SOOum4m76DIPJ33RLGIWj8bZOlSLkH5wq8nXCs2bl4VfzlOO
         cJdXRfSSMMemvQcaSJtRgGRA/Ocqu5/F/zCJ/q8oduVSuQfadTO3oKaXUdYFqZVMXBhr
         yJLJubUricGiGsLdOEE/8bzUQ7v3u4FixDIZQ6vyEO5CV+8fXlxQaMzfboUitAFRYF09
         9fs7IEYMtQ+vteZNtlp/rI34iygxMeLSqCL5+Ts6AuizzbJjDUz8UQzzPpEElN8zUpqp
         9l3g==
X-Gm-Message-State: AFqh2kptm+fX1vo1oc505CrjCSUW1JQ/C9kkpf/EkSKS1ruqoI8nyr5r
        fE4l1fm9FvvX1gGQEsABA1vKVvnSEIL40syR
X-Google-Smtp-Source: AMrXdXvXEX2apJTSsh1b8R6BD5XYE6mdkrG4KhS9jxqQkvSNLS8owK2FV61uqs2gckSWoAp0uS2nqw==
X-Received: by 2002:ac2:5474:0:b0:4cc:68bd:28d5 with SMTP id e20-20020ac25474000000b004cc68bd28d5mr5816176lfn.57.1674038942190;
        Wed, 18 Jan 2023 02:49:02 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p19-20020a056512235300b004cf646911easm2281525lfu.57.2023.01.18.02.48.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 02:48:59 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id a11so11014645lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:48:57 -0800 (PST)
X-Received: by 2002:a05:6512:1153:b0:4b6:eaec:f7a6 with SMTP id
 m19-20020a056512115300b004b6eaecf7a6mr364384lfg.586.1674038937447; Wed, 18
 Jan 2023 02:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20230116073834.333129-1-bjorn@kernel.org> <20230116073834.333129-2-bjorn@kernel.org>
In-Reply-To: <20230116073834.333129-2-bjorn@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jan 2023 11:48:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXi7yEiS73YhQAQKqj+3rTCNmuRrdnNKS4prvG96Xgqog@mail.gmail.com>
Message-ID: <CAMuHMdXi7yEiS73YhQAQKqj+3rTCNmuRrdnNKS4prvG96Xgqog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: Add instruction dump to RISC-V splats
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

On Mon, Jan 16, 2023 at 8:41 AM Björn Töpel <bjorn@kernel.org> wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> Add instruction dump (Code:) output to RISC-V splats. Dump 16b
> parcels.
>
> An example:
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   Oops [#1]
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3-00302-g840ff44c571d-dirty #27
>   Hardware name: riscv-virtio,qemu (DT)
>   epc : kernel_init+0xc8/0x10e
>    ra : kernel_init+0x70/0x10e
>   epc : ffffffff80bd9a40 ra : ffffffff80bd99e8 sp : ff2000000060bec0
>    gp : ffffffff81730b28 tp : ff6000007ff00000 t0 : 7974697275636573
>    t1 : 0000000000000000 t2 : 3030303270393d6e s0 : ff2000000060bee0
>    s1 : ffffffff81732028 a0 : 0000000000000000 a1 : ff60000080dd1780
>    a2 : 0000000000000002 a3 : ffffffff8176a470 a4 : 0000000000000000
>    a5 : 000000000000000a a6 : 0000000000000081 a7 : ff60000080dd1780
>    s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
>    s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>    s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
>    s11: 0000000000000000 t3 : ffffffff81186018 t4 : 0000000000000022
>    t5 : 000000000000003d t6 : 0000000000000000
>   status: 0000000200000120 badaddr: 0000000000000000 cause: 000000000000000f
>   [<ffffffff80003528>] ret_from_exception+0x0/0x16
>   Code: 862a d179 608c a517 0069 0513 2be5 d0ef db2e 47a9 (c11c) a517
>   ---[ end trace 0000000000000000 ]---
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>   SMP: stopping secondary CPUs
>   ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Thanks for your patch!

> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -29,6 +29,27 @@ int show_unhandled_signals = 1;
>
>  static DEFINE_SPINLOCK(die_lock);
>
> +static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
> +{
> +       char str[sizeof("0000 ") * 12 + 2 + 1], *p = str;
> +       unsigned long addr = regs->epc;

Given you never use this as an unsigned long, what about

    const u16 *insns = (u16 *)instruction_pointer(regs);

so you no longer need casts below?

> +       long bad;
> +       u16 val;
> +       int i;
> +
> +       for (i = -10; i < 2; i++) {
> +               bad = get_kernel_nofault(val, &((u16 *)addr)[i]);
> +               if (!bad) {
> +                       p += sprintf(p, i == 0 ? "(%04hx) " : "%04hx ", val);
> +               } else {
> +                       printk("%sCode: Unable to access instruction at 0x%lx.\n",

%px, so you can drop the cast to long below.

> +                              loglvl, (long)&((u16 *)addr)[i]);
> +                       return;
> +               }
> +       }
> +       printk("%sCode: %s\n", loglvl, str);
> +}
> +
>  void die(struct pt_regs *regs, const char *str)
>  {
>         static int die_counter;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
