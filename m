Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40556F3D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjEBGjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:39:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C530EF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:39:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4edc63e066fso962e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683009550; x=1685601550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=au3eKKzHx4Go9iUOEDbwGiArL8HoyA4SVyzOfBFC4mM=;
        b=bpxi+0PawxKDUHRFLnweiOS5i05e0axEbXglY31c5QVDqmNBiWXZSfnLbgkjvlh35K
         HCaZNj4sguxV687eFJiDGF3SwMcrDE/YvPS/ASEejtpNLxftpym/+8rPFOjTClGjU9h1
         EjbBP2RW5J2T1JkEeAKwtqtE82TNtGNy4hSi6RVqRsPICmmeRc9J8CHT2Mnw78DJq2g9
         J0f/B0UOhnt2fjhSIY8VsoGTL1JQqdiyvgjviEix7izMUKFxXVa8BrGcP5vdhe2hVg67
         g0AXipx6zPfeDozLCh+239/7iwX/tsGSDcGX0dJyDe3gT5KiLQiadHV4sIV+NBMTPlEf
         2vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009550; x=1685601550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au3eKKzHx4Go9iUOEDbwGiArL8HoyA4SVyzOfBFC4mM=;
        b=OHmNuJOxEIl8e5MT8K1cbJ+j8WLYYsU7fAfm8s+3bvPadMqY1eGXkDXeojBrTUz+CH
         cv0etzYrRP+BInVbTitN5oP+p0mNI8Ovju9dgOvINYW5WO3Ff1+abtBGqgWOYsgn0z97
         v0xrjx97PVpEoahDVR9cMlqL7zdXtdt6hwEypl28K0FGAo89JoMNkPDogIdXQVTTambr
         pTIvhhZNtTCdf2BH45Zq3uCbgDOoqAWBwzosua2haau3cr2uF24qCjfFRtetIYIojvLA
         B8B9Wd4qwkKpBMomU+7QMquudzZYsoamYTOpFXk7C1Hd2qtbuTfPQvbU0HY1em3/qPhr
         2cQA==
X-Gm-Message-State: AC+VfDy9XU0v2MFlUAZ4bFgQsf+Sdi5kkjYqIrrASjoNna4jqedzHbSx
        SiAU4Iesrx2Nm87ZNLtIO09T5kep3nK9cDeJ7VEaCw==
X-Google-Smtp-Source: ACHHUZ519qgzpkJVOVBOgOo7g2j+fy9Qqiww63yyKlyajFaFzMQejhw9/+S5kWDtksgMqVAu4UzI+qFKcA0cKSaxZgc=
X-Received: by 2002:a05:6512:3d90:b0:4f1:21a2:901f with SMTP id
 k16-20020a0565123d9000b004f121a2901fmr76774lfv.3.1683009549595; Mon, 01 May
 2023 23:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006c30a305fa79afe5@google.com>
In-Reply-To: <0000000000006c30a305fa79afe5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 08:38:56 +0200
Message-ID: <CACT4Y+Yt-k6vFm0ZT5TPjsJ-Sd1C_YOki8oEESyD_TjHV4r09w@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in __irq_resolve_mapping
To:     syzbot <syzbot+bf1c5e262f97aca4bc88@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
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
<syzbot+bf1c5e262f97aca4bc88@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    36006b1d5c04 Merge tag 'ata-6.4-rc1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1014285fc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fdfddd4c38713bb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=bf1c5e262f97aca4bc88
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bf1c5e262f97aca4bc88@syzkaller.appspotmail.com

+arm mailing list

Kernel started falling apart on arm during boot in various strange ways.

#syz set subsystems: arm

> vkms_vblank_simulate: vblank timer overrun
> vkms_vblank_simulate: vblank timer overrun
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address 000c019f when read
> [000c019f] *pgd=80000080004003, *pmd=00000000
> Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at irq_data_to_desc include/linux/irqdesc.h:124 [inline]
> PC is at __irq_resolve_mapping+0x40/0x90 kernel/irq/irqdomain.c:968
> LR is at rcu_read_lock include/linux/rcupdate.h:771 [inline]
> LR is at __irq_resolve_mapping+0x20/0x90 kernel/irq/irqdomain.c:960
> pc : [<802bd68c>]    lr : [<802bd66c>]    psr: 200c0193
> sp : 82401e40  ip : 82401e40  fp : 82401e5c
> r10: 825df6a1  r9 : 8241ae40  r8 : 00000000
> r7 : df80a00c  r6 : 00000000  r5 : 0000001b  r4 : 82894000
> r3 : 8021666c  r2 : 8241ae40  r1 : 0000001b  r0 : 000c0193
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 840da040  DAC: fffffffd
> Register r0 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
> Register r1 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
> Register r2 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
> Register r3 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
> Register r4 information: slab kmalloc-1k start 82894000 pointer offset 0 size 1024
> Register r5 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
> Register r6 information: 2-page vmalloc region starting at 0xffffffff allocated at kernel_clone+0x9c/0x3d4 kernel/fork.c:2774
> Register r7 information:
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address fffffff7 when read
> [fffffff7] *pgd=80000080007003, *pmd=deffd003, *pte=00000000
> Internal error: Oops: 207 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2571 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> pc : [<8046b3a8>]    lr : [<817ddddc>]    psr: a00c0193
> sp : 82401cd0  ip : 82401cb8  fp : 82401ce4
> r10: 8241ae40  r9 : 8241c964  r8 : 8264d41c
> r7 : 600c0193  r6 : 00000008  r5 : df80b000  r4 : ffffffff
> r3 : 80216684  r2 : 00001dd7  r1 : 00000000  r0 : 00000001
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: 840da040  DAC: fffffffd
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000006c30a305fa79afe5%40google.com.
