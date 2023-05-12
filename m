Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255E70020A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjELIAD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 04:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjELH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:59:56 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B01BCA;
        Fri, 12 May 2023 00:59:49 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so12446999276.2;
        Fri, 12 May 2023 00:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878388; x=1686470388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtW83Y+m5xLXXaQjQs9WIAKFJ8f7EcydpaDqhfcPeeY=;
        b=kAdvvmcZephp/4Ct2GQ7iMra27TJxNA5OidUfsexF86L4ZnIy2+xIOAL1Z+ZOZ1LlF
         S9NPwBwsSiMVZfK25k7Rs9/wCZXSV8f5v8IXkBnb5Mnmwg0EouljsYqNzjDynhQrX/bw
         fVms2n1TBG5p0uNJLWhB2MK8YyOEn3Tqrfn2uH1d4nA8s4FDPZr7fWMmYFC/JQoROT4m
         x7KEdHxdXfW8A5+gDSYG5ppC81NJsVUB1Snu2X+Z66r15XMrCoI2RcaGmFYM3ggrFJop
         Ieoyp2lGcYeidI+RsdjqeIwPIxBzmGYnAiGZZqZykdsXoQXt8kjw13/l1RUyLDtsDVK3
         Dhjw==
X-Gm-Message-State: AC+VfDw61OyBf0fPAb+UTEs85yj1oWAim0tu2Z91fip0P5rjbhEvtpOX
        BtUDQxbIp11cofPL2KVG5+TBbBFg+TKEY1dE
X-Google-Smtp-Source: ACHHUZ5gJ6pS5BzG1V6rCRbA8+uRAtCvqZnXa2PjQB6N94o2VTsGaaqpDxLdiEHSo1RGg1cucuzYZg==
X-Received: by 2002:a25:ad19:0:b0:b9e:6c59:aa0b with SMTP id y25-20020a25ad19000000b00b9e6c59aa0bmr21082448ybi.13.1683878388016;
        Fri, 12 May 2023 00:59:48 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id y187-20020a0dd6c4000000b0054fdb1dad0fsm5478024ywd.43.2023.05.12.00.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:59:47 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-55af4277904so146186797b3.1;
        Fri, 12 May 2023 00:59:47 -0700 (PDT)
X-Received: by 2002:a0d:d643:0:b0:561:1812:4d11 with SMTP id
 y64-20020a0dd643000000b0056118124d11mr1532909ywd.3.1683878386953; Fri, 12 May
 2023 00:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da2a8505fb71d81b@google.com>
In-Reply-To: <000000000000da2a8505fb71d81b@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 09:59:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVsWdwaAUZ4DTiLFxgVEETx=YwOnrZ6qeOyBWE8=tKQw@mail.gmail.com>
Message-ID: <CAMuHMdVVsWdwaAUZ4DTiLFxgVEETx=YwOnrZ6qeOyBWE8=tKQw@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in gic_eoi_irq
To:     syzbot <syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Thu, May 11, 2023 at 11:41 PM syzbot
<syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com> wrote:
> syzbot found the following issue on:
>
> HEAD commit:    ac9a78681b92 Linux 6.4-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=102a3f6a280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cc86fee67199911d
> dashboard link: https://syzkaller.appspot.com/bug?extid=afc1d968649e7e851562
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-ac9a7868.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c04bec59d77d/vmlinux-ac9a7868.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/070113b307f3/zImage-ac9a7868.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afc1d968649e7e851562@syzkaller.appspotmail.com
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 000005f4 when read
> [000005f4] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc1-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at gic_eoi_irq+0x64/0x70 drivers/irqchip/irq-gic.c:228

Why is this sent to the renesas-soc maintainers?

> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)

While I see the list of subsystems there, how do I find out the (wrong?)
current bug's subsystem?

Thanks for fixing!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
