Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97462F670
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiKRNkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiKRNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:39:44 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212DB5FE9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:39:40 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-376596ae449so49787267b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKwPWOIei0ORF4YEoW2azGGh2uCAPxfNzIEZVLw0jwE=;
        b=fetFG9vb9oDky8QdSGpLBfutVlrtudcdGypf4aJjtSuCL6JFvwgaKtvU27hb+sIGKq
         DzSkU5loX9JmPIYx1qfBTuk0zVWGs53vd20g78Cwcjzb4VMhe9RZT/vu3ratGXW/hxKA
         yD+EtuQ1QzjSt4Dxv1rQSgHUh8GHi29i91ZM250PwIa4NG6DXya5jod5zasNFV6+y5aP
         vfLNR6vawYQzz+G+FQ6SQcWQ7JSImaJGCLhzuiTCA2r5X7DUYShKFzs8pjS49q5OAq0z
         QIqbere9zeRl0OcD/nTUdbQo0BpljDw9028Ki5kzxc99XePNk5/XVLQFC7s6HLfNuXMw
         h8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKwPWOIei0ORF4YEoW2azGGh2uCAPxfNzIEZVLw0jwE=;
        b=8Ok64RqREBE2MN2G7Y6Tj8GPShXd7JoZ/QdeJenIII6irUSoH9U4LUHWHSU290+fbJ
         vYYteuVC3u1gU8orFGc2E5vaKB7xGgfSCzjJSlNyGQY/gz/EMg0qbi5EzKoRRALml159
         hUHzJy9rLLMHU3rckhDpCUG2DnC1ijYrTKR8UsSluC1Ssj1L4iAmJ84Sxze0OOhQEgJb
         SlDloW7pLxwgMzlQIem8zG35CRuoo+HFDM6F6Pzwlug3WepsLomdhZyi5kfWWn8YHLGp
         X1LiR4d3XrDbFoyLrH1dGDytFMEopc8L+D4uMPUiC8QU4O/t9iZfgHy0eQF45GSXmqNb
         ujTg==
X-Gm-Message-State: ANoB5pm49Iw3R4GiGjXIpFfV/PIRfc/1KChc9p8E9WN6ejO2IaJ0FUh6
        N52+eq/d/T/k56uD3rOhHHxeLjSdvPW1EgZbHEMerQ==
X-Google-Smtp-Source: AA0mqf5sNuS/4nvSYw6W6u8u7JOORRs6zds70QaxItmPsTI2PIAhzA0+xwk61rB4CFzXVW8Vii8YnADenM5oj81sVqk=
X-Received: by 2002:a81:dd05:0:b0:36e:8228:a127 with SMTP id
 e5-20020a81dd05000000b0036e8228a127mr6571943ywn.299.1668778779156; Fri, 18
 Nov 2022 05:39:39 -0800 (PST)
MIME-Version: 1.0
References: <Y3VEL0P0M3uSCxdk@sol.localdomain> <CAG_fn=XwRo71wqyo-zvZxzE021tY52KKE0j_GmYUjpZeAZa7dA@mail.gmail.com>
 <Y3b9AAEKp2Vr3e6O@sol.localdomain>
In-Reply-To: <Y3b9AAEKp2Vr3e6O@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Nov 2022 14:39:02 +0100
Message-ID: <CAG_fn=Upw7AsM_wZq0ajPixbAKp-izC7LMxyN_5onfL=OBhRzA@mail.gmail.com>
Subject: Re: KMSAN broken with lockdep again?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> > As far as I can tell, removing `KMSAN_SANITIZE_lockdep.o :=3D n` does
> > not actually break anything now (although the kernel becomes quite
> > slow with both lockdep and KMSAN). Let me experiment a bit and send a
> > patch.

Hm, no, lockdep isn't particularly happy with the nested
lockdep->KMSAN->lockdep calls:

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5508 check_flags+0x63/0x=
180
...
 <TASK>
 lock_acquire+0x196/0x640 kernel/locking/lockdep.c:5665
 __raw_spin_lock_irqsave ./include/linux/spinlock_api_smp.h:110
 _raw_spin_lock_irqsave+0xb3/0x110 kernel/locking/spinlock.c:162
 __stack_depot_save+0x1b1/0x4b0 lib/stackdepot.c:479
 stack_depot_save+0x13/0x20 lib/stackdepot.c:533
 __msan_poison_alloca+0x100/0x1a0 mm/kmsan/instrumentation.c:263
 native_save_fl ./include/linux/spinlock_api_smp.h:?
 arch_local_save_flags ./arch/x86/include/asm/irqflags.h:70
 arch_irqs_disabled ./arch/x86/include/asm/irqflags.h:130
 __raw_spin_unlock_irqrestore ./include/linux/spinlock_api_smp.h:151
 _raw_spin_unlock_irqrestore+0x60/0x100 kernel/locking/spinlock.c:194
 tty_register_ldisc+0xcb/0x120 drivers/tty/tty_ldisc.c:68
 n_tty_init+0x1f/0x21 drivers/tty/n_tty.c:2521
 console_init+0x1f/0x7ee kernel/printk/printk.c:3287
 start_kernel+0x577/0xaff init/main.c:1073
 x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:556
 x86_64_start_kernel+0x114/0x119 arch/x86/kernel/head64.c:537
 secondary_startup_64_no_verify+0xcf/0xdb arch/x86/kernel/head_64.S:358
 </TASK>
---[ end trace 0000000000000000 ]---

> > If this won't work out, we'll need an explicit call to
> > kmsan_unpoison_memory() somewhere in lockdep_init_map_type() to
> > suppress these reports.

I'll go for this option.

> Thanks.
>
> I tried just disabling CONFIG_PROVE_LOCKING, but now KMSAN warnings are b=
eing
> spammed from check_stack_object() in mm/usercopy.c.
>
> Commenting out the call to arch_within_stack_frames() makes it go away.

Yeah, arch_within_stack_frames() performs stack frame walking, which
confuses KMSAN.
We'll need to apply __no_kmsan_checks to it, like we did for other
stack unwinding functions.


> - Eric

T




--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
