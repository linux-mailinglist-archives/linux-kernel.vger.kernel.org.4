Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57263FA44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiLAWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLAWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:04:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFBA95A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:04:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669932242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWyfQfBvJlKEv85Xvl8Hcsl6+t600l8V7S2CJ9Tej3Q=;
        b=FFeZuBwGAak1IUnRrgIZuB2NJjAXg/zpDsqK3Vx2uspoyjWvquwM47UQ+wijwJFZ4LuSkf
        AuN19mSLcob+4ZrRrt+Pe2O87bbyISQ4lXkVwi4uEazpUQq1Morhqwb0zcGNkM4qmK4M/h
        5Qnz5YW4jkxDJbG6sRx6KCkHp7tazCcrBwH3JIT+VtGMdAb78FEW5IZew8OGJm66Wvlm6e
        +s1Pzg2dFNBgxNJWTAgBbod/kDasbvTS+8jQQM+0OGjxQp0VEZ5jtMvU5Wiz6VGda/e9W2
        YyACG4nCyj6FTO6SCeuxMF7YjxPgXLxFi73IoXi40GPFchzudzOsmic0SNiHAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669932242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWyfQfBvJlKEv85Xvl8Hcsl6+t600l8V7S2CJ9Tej3Q=;
        b=fkQdvnKcG4daZlF67c1ZeqYe4iculEHfAuT0LvzFIcaRhfSIIW7/pG31p3aQbNokn+eX3M
        /7cTdmWKEILZOqDQ==
To:     Wei Chen <harperchen1110@gmail.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     Andrei Vagin <avagin@gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 posix_get_monotonic_timespec
In-Reply-To: <CAO4mrffT8wbtjSR9gEwcdK8TZTK6g0TiS7vgSqbAFVRf=Romag@mail.gmail.com>
References: <CAO4mrffT8wbtjSR9gEwcdK8TZTK6g0TiS7vgSqbAFVRf=Romag@mail.gmail.com>
Date:   Thu, 01 Dec 2022 23:04:01 +0100
Message-ID: <87pmd2rdbi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2022 at 22:38, Wei Chen wrote:

> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered.
>
> HEAD commit: d418a331631b v6.1.0-rc5
> git tree: kmsan
> compiler: gcc 8.4.0
> console output:
> https://drive.google.com/file/d/1F6xY7LF5H9Lki9m769N_9ickBdGwaXIo/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1qltDw7jrn7_DnXvhf7MgsxO08nqGSCDe/view?usp=share_link
>
> Unfortunately, I didn't have a reproducer for this bug.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> BUG: kernel NULL pointer dereference, address: 0000000000000050
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 1a089067 P4D 1a089067 PUD 1a08a067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 6355 Comm: syz-executor.1 Not tainted
> 6.1.0-rc5-63183-gd418a331631b #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> Ubuntu-1.8.2-1ubuntu1 04/01/2014
> RIP: 0010:timespec64_add include/linux/time64.h:73 [inline]

That's the timespec64_add() in:

> RIP: 0010:timens_add_monotonic include/linux/time_namespace.h:69 [inline]

	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;

	*ts = timespec64_add(*ts, ns_offsets->monotonic);

> RIP: 0010:posix_get_monotonic_timespec+0x40/0x80 kernel/time/posix-timers.c:200
> Code: 89 45 f0 31 c0 e8 a0 ce 05 00 48 89 df e8 98 5c ff ff 48 8d 7d
> e0 65 48 8b 04 25 c0 ad 01 00 48 8b 80 d8 07 00 00 48 8b 40 30 <48> 8b
> 50 30 48 8b 70 28 48 03 53 08 48 03 33 e8 9c 89 fe ff 48 8b

   0:	89 45 f0             	mov    %eax,-0x10(%rbp)
   3:	31 c0                	xor    %eax,%eax
   5:	e8 a0 ce 05 00       	callq  0x5ceaa
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 98 5c ff ff       	callq  0xffffffffffff5caa
  12:	48 8d 7d e0          	lea    -0x20(%rbp),%rdi
  16:	65 48 8b 04 25 c0 ad 	mov    %gs:0x1adc0,%rax     // rax = current
  1d:	01 00 
  1f:	48 8b 80 d8 07 00 00 	mov    0x7d8(%rax),%rax     // rax = nsproxy
  26:	48 8b 40 30          	mov    0x30(%rax),%rax      // rax = time_ns
  2a:*	48 8b 50 30          	mov    0x30(%rax),%rdx		<-- trapping instruction

> RAX: 0000000000000020 RBX: ffff88800e0d7f00 RCX: ffff888042696480

time_ns == 0x20 !?!?! How can that happen?

Thanks,

        tglx
