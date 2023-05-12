Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19170075E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjELL6W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbjELL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:58:19 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EFB1387B;
        Fri, 12 May 2023 04:57:48 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-559e2051d05so141794487b3.3;
        Fri, 12 May 2023 04:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683892667; x=1686484667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN/Va2a/0XZpcu/J5nl0GO9ah+0DnnvqSR5PD5GVAJs=;
        b=OH8CiS14wtPcHGAm6uof5P7Pz3CNMXdYSPSmfdOhidI0sNwgo5TQWr0wmdj8I1OYWP
         WyE0WZCfZ+YbUrJOFty5dqLRxPkzhklP8iP7S494aKvUk3EUKI72JT/6tRHXn4gBbkbb
         IxOuL9ee39y+08Uc+XmG2fayYscKXpit2Tb2TMUSNH6kQe6/CvqrtiPolfuLD/1eCnxK
         m7V5PxBCwQc+Re6mmVjUP9xDiRzX7rt0syxyxCp5WAJGFo8ih4uafEiAyGqVWj8pPEoW
         eLTg+ft0IYMDovARsYjCes58X0uPO6aF9F3doUAwAT7yul/5zlrcSP36uv6d0D+yDOZ0
         lqeg==
X-Gm-Message-State: AC+VfDzyOAfA6+eLogXIeukETgH3b5FEBY5jRXN0j+LjOqnaf5ww6Jzj
        xet0hD/Ier342EmfS55MVEA5uj04hm/Dzw==
X-Google-Smtp-Source: ACHHUZ7QbS7jniiZcnzeHwLxORtjZcFRXQiJCVkEpekYWQrOFmm1n7iChBtLiVsUnyNZX//7JOU8XA==
X-Received: by 2002:a81:a091:0:b0:55d:1c72:e1de with SMTP id x139-20020a81a091000000b0055d1c72e1demr24701409ywg.37.1683892667428;
        Fri, 12 May 2023 04:57:47 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id x186-20020a81a0c3000000b0054eff15530asm5635577ywg.90.2023.05.12.04.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 04:57:46 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b9d8e8898eeso12442332276.1;
        Fri, 12 May 2023 04:57:46 -0700 (PDT)
X-Received: by 2002:a81:b409:0:b0:541:694a:4c69 with SMTP id
 h9-20020a81b409000000b00541694a4c69mr24961103ywi.52.1683892666294; Fri, 12
 May 2023 04:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da2a8505fb71d81b@google.com> <CAMuHMdVVsWdwaAUZ4DTiLFxgVEETx=YwOnrZ6qeOyBWE8=tKQw@mail.gmail.com>
 <CANp29Y44p1GCe+NC_KhGGGNB+N2v0MHB+onHZ2rzP52AfZahDQ@mail.gmail.com>
In-Reply-To: <CANp29Y44p1GCe+NC_KhGGGNB+N2v0MHB+onHZ2rzP52AfZahDQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 13:57:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzcWjyx8xmjQwJh7r27RS-2p__X1cUFUWJVKmJM=AgeQ@mail.gmail.com>
Message-ID: <CAMuHMdUzcWjyx8xmjQwJh7r27RS-2p__X1cUFUWJVKmJM=AgeQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in gic_eoi_irq
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        magnus.damm@gmail.com, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksandr,

On Fri, May 12, 2023 at 1:30 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> On Fri, May 12, 2023 at 9:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, May 11, 2023 at 11:41 PM syzbot
> > <syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com> wrote:
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    ac9a78681b92 Linux 6.4-rc1
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=102a3f6a280000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cc86fee67199911d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=afc1d968649e7e851562
> > > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: arm
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-ac9a7868.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/c04bec59d77d/vmlinux-ac9a7868.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/070113b307f3/zImage-ac9a7868.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com
> > >
> > > 8<--- cut here ---
> > > Unable to handle kernel NULL pointer dereference at virtual address 000005f4 when read
> > > [000005f4] *pgd=80000080004003, *pmd=00000000
> > > Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> > > Modules linked in:
> > > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc1-syzkaller #0
> > > Hardware name: ARM-Versatile Express
> > > PC is at gic_eoi_irq+0x64/0x70 drivers/irqchip/irq-gic.c:228
> >
> > Why is this sent to the renesas-soc maintainers?
>
> The report was attributed to `drivers/irqchip/irq-gic.c` and
> `./scripts/get_maintainer.pl -f drivers/irqchip/irq-gic.c` gives
> linux-renesas-soc@vger.kernel.org (open list:ARM/RISC-V/RENESAS ARCHITECTURE)
> as one of the output results.

Oh, right, there's a small quirk for renesas,emev in the GIC driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
