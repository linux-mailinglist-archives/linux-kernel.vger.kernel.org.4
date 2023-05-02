Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD86F3D99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjEBGiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEBGiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:38:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE012D41
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:38:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4efea87c578so974e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683009527; x=1685601527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jBnKG88FbOtu4DyujgxvWWXru5qVkGeMGCnWkCLNuM4=;
        b=S2yk3LQbBnxcOzVurIfQwWTX+SaRIVWzrpyo1gXHhKp8RXjID11CwVMUz1vIueF0Vo
         MsaP/W/IOfubuAlMN5Khy4zssu0w997WqHSUB1KzLAguG3zySG920BPOm4V8uJuymARS
         mqyUXtP8/pCXEfkQDhlbKg6fDc7/jwbga6gRXzgkYOAzsAvoFH1FKpKWXxQnKnu7VNIR
         cFWMzG8p15cwp0YD6ramdAVC4BwCkTLPa/13AyKEIj+dmarFasViaFHby/9/MurBejKU
         by3f5nc81UyFiJ+/xm0gBFSy/ERVlm5Tycx3gAmk6PLLx/Qhayal11ULDGW04Ip74uED
         YtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009527; x=1685601527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBnKG88FbOtu4DyujgxvWWXru5qVkGeMGCnWkCLNuM4=;
        b=WOcPJKz3FrhpGbQ8OYNuW/jCO11Svzh8o+fSuEprN9/S4Lhq6FqAjCZE8601jwWFw9
         RSHqDiAXEKrWF5Y1D/3kzvNQd1UTJr7TbnAxrWR5y7WbQQXlACMgA497HsVzYyeq1Azy
         IPfieg8wcod90bMvmGusG6Qeip7yzNDJp6k5R+YKwgdoSyx9b+wAFGS11owvnmxmb1RE
         MErlrUztUQzPdTDD7cVST+cSCu8UUyweQ2RRWFk46R5PGEB11AEdloZGIFqkHvlWgswj
         zzXN9ggEqT0b3pALbigeiJM0Vq16g7TNQ0A3Ob+bPCfRitWzYHFgRLzcY2x2ccAVszS4
         nqKw==
X-Gm-Message-State: AC+VfDy93sPMqeGcvICdClUMT3v+fnqewiZHG2dRRYW6hseo/4Sew6me
        VJARhW7JozFTkaraQ5Gc/n9CrVvjRXuWDpLa0SXFqQ==
X-Google-Smtp-Source: ACHHUZ6/n9AVg/H9dSG2L8bTpRxnxtyZ6DmqZqsblEL9aNbQG6772mk7CDCWOIQp3YwUFxaEbf9kTWXrUQ98j0WBQSs=
X-Received: by 2002:a05:6512:3d90:b0:4ea:e5e2:c893 with SMTP id
 k16-20020a0565123d9000b004eae5e2c893mr79590lfv.1.1683009527427; Mon, 01 May
 2023 23:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000070ccd705fa79afe9@google.com>
In-Reply-To: <00000000000070ccd705fa79afe9@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 08:38:35 +0200
Message-ID: <CACT4Y+Y6qkdhEtTb1XNrhd759ybEHk6138o7yK7kr-+OKcDHKQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in gic_handle_irq
To:     syzbot <syzbot+4aee2040dfac273d198e@syzkaller.appspotmail.com>
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com,
        maz@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 at 15:37, syzbot
<syzbot+4aee2040dfac273d198e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cec24b8b6bb8 Merge tag 'char-misc-6.4-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11334c30280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c159a5b5ee7dcf56
> dashboard link: https://syzkaller.appspot.com/bug?extid=4aee2040dfac273d198e
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4aee2040dfac273d198e@syzkaller.appspotmail.com


+arm mailing list

Kernel started falling apart on arm during boot in various strange ways.

#syz set subsystems: arm

> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address df80a00c when read
> [df80a00c] *pgd=80000080007003, *pmd=82893003, *pte=80216680
> Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __raw_readl arch/arm/include/asm/io.h:113 [inline]
> PC is at gic_handle_irq+0x1c/0x7c drivers/irqchip/irq-gic.c:344
> LR is at generic_handle_arch_irq+0x60/0x80 kernel/irq/handle.c:238
> pc : [<8086e724>]    lr : [<817e3dd0>]    psr: 20000193
> sp : 82401e70  ip : 82401e90  fp : 82401e8c
> r10: 825dfffd  r9 : 8241ae40  r8 : 00000000
> r7 : df80a00c  r6 : 81f1590c  r5 : df80a000  r4 : 8240cde8
> r3 : 8086e708  r2 : 00904870  r1 : 81f4ff24  r0 : 82401eb8
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 80003000  DAC: fffffffd
> Register r0 information:
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address fffffff7 when read
> [fffffff7] *pgd=80000080007003, *pmd=deffd003, *pte=00000000
> Internal error: Oops: 207 [#2] PREEMPT SMP ARM
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000070ccd705fa79afe9%40google.com.
