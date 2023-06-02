Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731571FBB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjFBISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjFBISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:18:49 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DB19B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:18:47 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3942c6584f0so1285029b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685693927; x=1688285927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WuFjW+rBI4FJOn/xl8Ej34TchjKjmARvNqq7JfrSzXY=;
        b=pDILyxAWzHIq6sClcHEXCKzDiuEWJ570npSzgMbtkgtscD+VOSx04oyx/G7twfKtvz
         KzGOwIz7bIHo9/CmLBJYuIcN1dXwsrDdA0hIR/IXY0L/GDWgnletcgnEILcf1LUeD7Xj
         f6VgFmkhPSBc97KYLYI/qpO0WDQBHQiHWg5+ya//dLe+7p7HTL+CcKfmAbESH3vUQ0oS
         K+9ekTmxBtGOoDrCrYYyISLSupBKzeuZgYyYCiYlWT9FYOre5VEY8skVIBvVBMnyRAF1
         Yf00ACnPawUZkzi1Q4S3gM5mRanlQ9CtRztujKYxGCbQgz1oOnPFdlqtDh8xuaVEhvpf
         kqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685693927; x=1688285927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuFjW+rBI4FJOn/xl8Ej34TchjKjmARvNqq7JfrSzXY=;
        b=NKum9s3irkPtKn1x3n2ajhnwXuxFuwDDJkQRJeO36IWETspA4ySBepAxUD0grgPW5l
         5dTt0/Hfuqiiuy1I+G+g6PASStbineQSQ3F+1ZvcOhw5S8TjzxyCKkEter0uGrplGIrI
         4BlPIrCTUx1U9D3g5dXBe9aWzS+GJqtrWwL6DjpEDC0q3473giia5eTr6xj+3napmEZr
         edKwfBryUx8pt1ctL1PoOfV5HhH1uWhkl7i73N25vOV6uYkKjyrmGPQ/yFmpsuMmgSSg
         +6tXRQwuOe5vXGNKMzNFy3iVOu3HdL8UkGC1ygTL6g3bdSFkf1vvssFdMz4O3Y2lCsk4
         0G+A==
X-Gm-Message-State: AC+VfDya7jweFnhpk7gBFPo+mqEBuB0Jn47YM8r4ekZRvguee01Wxs8n
        rjfvN2G88HcQL+jtsiRAFGw4/EcbyrgC0sR8goM=
X-Google-Smtp-Source: ACHHUZ7xV4F8bc/jUSRXyumBAJKgVcf6F5r+1q4HwkiqkWFlKwVH9idi4LKwGyvh5r88hmLGIvIOu5PiKcq5k6yMXFQ=
X-Received: by 2002:a05:6808:3ae:b0:39a:427a:a315 with SMTP id
 n14-20020a05680803ae00b0039a427aa315mr1847163oie.2.1685693926793; Fri, 02 Jun
 2023 01:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <0329dbe3-c7a0-4dad-a244-14061168d7b7@paulmck-laptop>
In-Reply-To: <0329dbe3-c7a0-4dad-a244-14061168d7b7@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 2 Jun 2023 16:18:34 +0800
Message-ID: <CALm+0cWFjd6rMYVHxVnku39J+EW74igeCQbeQcMzwDPd_iV4og@mail.gmail.com>
Subject: Re: [BUG] wait_task_inactive() WARN_ON() in __kthread_bind_mask()
To:     paulmck@kernel.org
Cc:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hello!
>
> I just now saw this in SRCU-P rcutorture testing.  It might well be a
> one-off, but I thought I should pass it along in case someone else is
> seeing similar things.
>
> I don't immediately see how this would be related, but who knows?
>
> https://lore.kernel.org/lkml/20230524035339.25185-1-qiang.zhang1211@gmail.com/
>
> Thoughts?
>

Hi Paul

This looks like another problem.  syzbot seems to have reported
similar issues before:

https://lore.kernel.org/lkml/0000000000005ca92705d877448c@google.com/

I will also be doing the rcutorture testing

Thanks
Zqiang

>
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> [ 1726.040567] ------------[ cut here ]------------
> [ 1726.040569] WARNING: CPU: 3 PID: 2016 at kernel/kthread.c:515 __kthread_bind_mask+0x18/0x60
> [ 1726.040581] Modules linked in:
> [ 1726.040584] CPU: 3 PID: 2016 Comm: kworker/7:3 Not tainted 6.4.0-rc1-00072-g99f9f93c0bce #5209
> [ 1726.040588] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [ 1726.040594] RIP: 0010:__kthread_bind_mask+0x18/0x60
> [ 1726.040598] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 55 41 54 55 48 89 f5 89 d6 53 48 89 fb e8 8d 5a 01 00 48 85 c0 75 0d <0f> 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 4c 8d a3 00 09 00 00 4c 89
> [ 1726.040601] RSP: 0000:ffff97c7c1ecfe78 EFLAGS: 00010246
> [ 1726.040604] RAX: 0000000000000000 RBX: ffff90ce82918000 RCX: 0000000000000000
> [ 1726.040606] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff90ce82918000
> [ 1726.040607] RBP: ffff90ce81047248 R08: 0000000000000001 R09: ffffffff9cab5d97
> [ 1726.040609] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
> [ 1726.040610] R13: ffff90ce9f5ee460 R14: ffff97c7c1ecfea0 R15: ffff90ce812ef840
> [ 1726.040614] FS:  0000000000000000(0000) GS:ffff90ce9f4c0000(0000) knlGS:0000000000000000
> [ 1726.040616] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1726.040618] CR2: 0000000000000000 CR3: 0000000014648000 CR4: 00000000000006e0
> [ 1726.040619] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1726.040621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1726.040622] Call Trace:
> [ 1726.040624]  <TASK>
> [ 1726.040630]  create_worker+0xf1/0x220
> [ 1726.040637]  worker_thread+0x2e4/0x3b0
> [ 1726.040641]  ? __pfx_worker_thread+0x10/0x10
> [ 1726.040643]  kthread+0xe6/0x120
> [ 1726.040648]  ? __pfx_kthread+0x10/0x10
> [ 1726.040651]  ret_from_fork+0x2c/0x50
> [ 1726.040658]  </TASK>
> [ 1726.040659] irq event stamp: 34
> [ 1726.040661] hardirqs last  enabled at (33): [<ffffffff9da014ea>] asm_sysvec_call_function_single+0x1a/0x20
> [ 1726.040668] hardirqs last disabled at (34): [<ffffffff9d95cead>] __schedule+0x67d/0xd20
> [ 1726.040675] softirqs last  enabled at (0): [<ffffffff9ca82da8>] copy_process+0xb98/0x1f10
> [ 1726.040681] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 1726.040685] ---[ end trace 0000000000000000 ]---
