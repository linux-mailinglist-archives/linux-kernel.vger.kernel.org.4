Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C40746129
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGCRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGCRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:07:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B9E5D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:07:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98377c5d53eso548016866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688404066; x=1690996066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59RY6T31JaaeIn9zrIInlgxL+/dnCv3eY7rcIrGNlMc=;
        b=MPn/1zc7TVZBMzUVi8vO6RbcGIWUoO+30fY2XSLb3KMon00ZY1vToCmexKBCJsk5Wb
         43vQl28IXjwSv0N5PCN7JtD8KaiunsB6/bw9dlSZWCZ9c58w2rF0dhtROqfkAS/Vb0LA
         ZrnP+QGwY2OtVprX19udzdVRerCpJcm6IvWY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404066; x=1690996066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59RY6T31JaaeIn9zrIInlgxL+/dnCv3eY7rcIrGNlMc=;
        b=I/rmnLU9YHSM3mK9phdIz64GWvFeyJtAjJLGCukPZ0gfaQK1V3THJQOkzoiqek87mD
         x0r6K6O/+Ha/ze4CW3HuPLU6fnhILTP6axOsIvQ3c7c+RYg7Z+B3tiNT4jbx2E0MzrZQ
         DSrZbjGdjyHk44H+Y4YPKKm5Yfp5cq8v3tilKS+qubrWnjfw5O8lp2D5giPFJ7/L6U6f
         lq3ohRDj9Trku7a2AGmtYwuRRwTKdURMr8u1hc1iLDAxQrSy6+8bV9J7gLcUNRkAL19T
         X7UBG//nQUMAyqIUvdRFXNOmpTkcn/Xc8OCM8Fyq5eHJ2NLIz5jUGw+wObaptoZEby+T
         w4dQ==
X-Gm-Message-State: ABy/qLYz/aDgaXpW62OrP75s4hn65cnofcKus3I+EDAEsixvH2xbpVdf
        iVF2j6Bf/Hjvz5hwjkMPHq2TwhTGSf5cWSeztXkchobj
X-Google-Smtp-Source: ACHHUZ5LldTza9S5eQVM1K0xhdifS56NBmilSgLN1f5FqFB0K7J6aZAGrQqrPgeLXnDjIec7Aio+vw==
X-Received: by 2002:a17:906:d9cf:b0:988:f2ad:73e9 with SMTP id qk15-20020a170906d9cf00b00988f2ad73e9mr7905988ejb.52.1688404066406;
        Mon, 03 Jul 2023 10:07:46 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id r21-20020a1709067fd500b009828e26e519sm12015965ejs.122.2023.07.03.10.07.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:07:45 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51d9890f368so5223177a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:07:45 -0700 (PDT)
X-Received: by 2002:a05:6402:605:b0:51d:e975:bea8 with SMTP id
 n5-20020a056402060500b0051de975bea8mr7636407edv.13.1688404065516; Mon, 03 Jul
 2023 10:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020> <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <20230703-dupe-frying-79ae2ccf94eb@spud>
In-Reply-To: <20230703-dupe-frying-79ae2ccf94eb@spud>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 10:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+jqA6nt36TxAfoqWskRAzhVfzBejcK6PNYXC+QcwyiA@mail.gmail.com>
Message-ID: <CAHk-=wg+jqA6nt36TxAfoqWskRAzhVfzBejcK6PNYXC+QcwyiA@mail.gmail.com>
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
To:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     lkp <oliver.sang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 10:00, Conor Dooley <conor@kernel.org> wrote:
>
> I'm not entirely sure if it is related, as stuff in the guts of mm like
> this is beyond me, but I've been seeing similar warnings on RISC-V.

No, that RISC-V warning is also about bad RCU usage, but that's a
different thing.

>         RCU used illegally from offline CPU!
>         rcu_scheduler_active = 1, debug_locks = 1
>         1 lock held by swapper/1/0:
>          #0: ffffffff8169ceb0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x32
>
>         stack backtrace:
>         CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-10173-ga901a3568fd2 #1
>         Hardware name: riscv-virtio,qemu (DT)
>         Call Trace:
>         [<ffffffff80006a20>] show_stack+0x2c/0x38
>         [<ffffffff80af3ee0>] dump_stack_lvl+0x5e/0x80
>         [<ffffffff80af3f16>] dump_stack+0x14/0x1c
>         [<ffffffff80083ff0>] lockdep_rcu_suspicious+0x19e/0x232
>         [<ffffffff80ad4802>] mtree_load+0x18a/0x3b6
>         [<ffffffff80091632>] __irq_get_desc_lock+0x2c/0x82
>         [<ffffffff80094722>] enable_percpu_irq+0x36/0x9e
>         [<ffffffff800087d4>] riscv_ipi_enable+0x32/0x4e
>         [<ffffffff80008692>] smp_callin+0x24/0x66

This is also triggering on the maple tree sanity checks, but it' sa
different maple tree, and a different code sequence.

And a different case of suspicious RCU usage - not a lack of locking,
but simply using RCU before marking the CPU online.

I suspect the riscv_ipi_enable() in the RISC-V version of smp_callin()
needs to be moved down to below the

        set_cpu_online(curr_cpuid, 1);

or was there some reason why it needed to be done quite _that_ early
in commit 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")?

Added guilty parties to the cc.

               Linus
