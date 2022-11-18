Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98662FC62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiKRSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:20:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB39720B8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:20:12 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 205so6566618ybe.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzosd7qcit/DhyEuPxX/KZLd3/ECFAwDjLQ9cH17uEU=;
        b=tja3Im+sHNbkCzYvzc5/QMgdW/Eh9+LZUeZfRUzmCboWZ5Kc8v+XQAgKuFfWoNGIcM
         T5UogN+WYSyyfaR20AX1lTcBpc0A2YvCYz2+eKmBo3u55rD/CdvhFwjII+htdt9KiyZj
         o8G3J8R6+N0aDImMDY44r4bie21MMhxTzxDczyNc4amfN6yTMpTP45/eUcgS675TgzkW
         eytQ2K5WqVENdQHJdyFkLhPUdFbd/HZUmNdpgNIywvc2mXlegYbslYzgjzG1ye3qZTeS
         iRLOH6aU7Ea/R053GzTtjTDRqItFktWSgZ7SfdPJu22OTKqIfGLg52CGMrO4U2ipkXD3
         hQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzosd7qcit/DhyEuPxX/KZLd3/ECFAwDjLQ9cH17uEU=;
        b=WdnyQgeJjq0BRJzpHqsZLleNo6o/kUsFIqlRybchYB3WdGxs6e9tgH+1QrOu85epn1
         EaI+NC1O4I/k7rBly4ZxYHnFNra+h9pdFEcz8WD9+AJqwslFPjhKIr14zjj6bEydjBRF
         qLS4kToqUanwOa79UwVddDhVKIPFC368jvNspkrCdahTEzFIkN73Q/n9H8eArp3/NPEs
         GDE1TDvkbQJZyzLufKtwsnsrlIYTV940ne36kQtsyLHICRTAVUftidGONNmW1ypaB1WP
         gKu50upsGqpUBkCI9aLZCfJ+YaGIEq9HGbNt2YeAZEbIVSlvg+KeHl1k1ocypec2sXmx
         2H4Q==
X-Gm-Message-State: ANoB5pmdcfM3HiaL8L0aC/o1inYZHmC7vf5+hFOn0c5kVryTUOC6kijO
        s0YVtlXTDWju7nP35jaBA9zXXEOjhxHFGZakAOf37Q==
X-Google-Smtp-Source: AA0mqf4KgV+NlWgOQLG+Kxakm2AvlgiOEH1s2kDJ5cWonRTnrhodc89WAX4GL4t6LiA9DZd18KCquC3am6tnVQ/YEMI=
X-Received: by 2002:a25:6a07:0:b0:6d4:84c5:8549 with SMTP id
 f7-20020a256a07000000b006d484c58549mr7428459ybc.376.1668795610233; Fri, 18
 Nov 2022 10:20:10 -0800 (PST)
MIME-Version: 1.0
References: <Y3VEL0P0M3uSCxdk@sol.localdomain> <CAG_fn=XwRo71wqyo-zvZxzE021tY52KKE0j_GmYUjpZeAZa7dA@mail.gmail.com>
 <Y3b9AAEKp2Vr3e6O@sol.localdomain> <CAG_fn=Upw7AsM_wZq0ajPixbAKp-izC7LMxyN_5onfL=OBhRzA@mail.gmail.com>
In-Reply-To: <CAG_fn=Upw7AsM_wZq0ajPixbAKp-izC7LMxyN_5onfL=OBhRzA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Nov 2022 19:19:33 +0100
Message-ID: <CAG_fn=USmF4fm+CDgfwGtJU2XXT8fuKrYVFFdouYrh+zRmnFsQ@mail.gmail.com>
Subject: Re: KMSAN broken with lockdep again?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 2:39 PM Alexander Potapenko <glider@google.com> wrote:
>
> > > As far as I can tell, removing `KMSAN_SANITIZE_lockdep.o := n` does
> > > not actually break anything now (although the kernel becomes quite
> > > slow with both lockdep and KMSAN). Let me experiment a bit and send a
> > > patch.
>
> Hm, no, lockdep isn't particularly happy with the nested
> lockdep->KMSAN->lockdep calls:
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5508 check_flags+0x63/0x180
> ...
>  <TASK>
>  lock_acquire+0x196/0x640 kernel/locking/lockdep.c:5665
>  __raw_spin_lock_irqsave ./include/linux/spinlock_api_smp.h:110
>  _raw_spin_lock_irqsave+0xb3/0x110 kernel/locking/spinlock.c:162
>  __stack_depot_save+0x1b1/0x4b0 lib/stackdepot.c:479
>  stack_depot_save+0x13/0x20 lib/stackdepot.c:533
>  __msan_poison_alloca+0x100/0x1a0 mm/kmsan/instrumentation.c:263
>  native_save_fl ./include/linux/spinlock_api_smp.h:?
>  arch_local_save_flags ./arch/x86/include/asm/irqflags.h:70
>  arch_irqs_disabled ./arch/x86/include/asm/irqflags.h:130
>  __raw_spin_unlock_irqrestore ./include/linux/spinlock_api_smp.h:151
>  _raw_spin_unlock_irqrestore+0x60/0x100 kernel/locking/spinlock.c:194
>  tty_register_ldisc+0xcb/0x120 drivers/tty/tty_ldisc.c:68
>  n_tty_init+0x1f/0x21 drivers/tty/n_tty.c:2521
>  console_init+0x1f/0x7ee kernel/printk/printk.c:3287
>  start_kernel+0x577/0xaff init/main.c:1073
>  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:556
>  x86_64_start_kernel+0x114/0x119 arch/x86/kernel/head64.c:537
>  secondary_startup_64_no_verify+0xcf/0xdb arch/x86/kernel/head_64.S:358
>  </TASK>
> ---[ end trace 0000000000000000 ]---

In fact, this message is printed in both cases: with and without KMSAN
instrumenting kernel/locking/lockdep.c
I wonder if this is a sign of a real problem in KMSAN, or just an
unavoidable consequence of instrumented code calling lockdep when
taking the stackdepot lock...

> > > If this won't work out, we'll need an explicit call to
> > > kmsan_unpoison_memory() somewhere in lockdep_init_map_type() to
> > > suppress these reports.
>
> I'll go for this option.
>
> > Thanks.
> >
> > I tried just disabling CONFIG_PROVE_LOCKING, but now KMSAN warnings are being
> > spammed from check_stack_object() in mm/usercopy.c.
> >
> > Commenting out the call to arch_within_stack_frames() makes it go away.
>
> Yeah, arch_within_stack_frames() performs stack frame walking, which
> confuses KMSAN.
> We'll need to apply __no_kmsan_checks to it, like we did for other
> stack unwinding functions.

Sent the patch.
