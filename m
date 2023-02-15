Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F9697875
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjBOIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBOIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:46:44 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959414EAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:46:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b16so21302719ljr.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0NQp4OeQIj5XifqZfgHq0jDdROVEComQ2rxYyKysmk=;
        b=ISSZKB3WvKx76JDE//0Ys7Nv0uTUECeLpNx1dgu3yU0aaO3BMkmkSWIVYUdxvCunPg
         Awu5Z/LWXYspJyqyx8QYUD20lrnUVXOqEd4SR9cimGPruGPUlndvSuJmENPpsAw6kId0
         h1g6ru7FPJNN7w7u3czDcgEEJas5k4AKcz4sjEME6ogpTmIa8PcWF0zWrn6hPtyTbo6R
         S6pJ7Cq+VYmHQmbU9KqogAfM2Djxq8bmtY3DSAoIbhhqueYSPuHr3nlqoOzi2ymQ/VEx
         zto1CZm6XPXc4hGlpG5oWksSneusR/QLe6XXG/vhjAr/lUUzu5kaC0D7KyuJeTIZ86JO
         J5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0NQp4OeQIj5XifqZfgHq0jDdROVEComQ2rxYyKysmk=;
        b=T9Sns4Fb75Dru4O6xHHzOKRlftDrxCuR2hJz+aKN7cmKUVQW6ADQ9EoLc4guUK/+0e
         FUos00ZIQx+eL1tPsYvRW8YtZqL4jWnicscv9Mu/jzzbwt3+VZnrFeq5OTo8TOrTMKWG
         Wx1qQaLJEuY7RjrzNKbvj42tdX60seU2VaCYyqYbZHhABkHcEaFGceS4MTxppc3IeDnv
         HX2gSzv4/Apu0XjIu8fxi5YU0NGqffWd8uSxFE6Y7lihUO6NTkPBpOAVI6UqYcinmvMi
         T390M5yjJhbteerk0Sp6ZmJPDf90/yweZtKwVKtGGjhoZ8V9fEQUYG6sDL3phex7W7FR
         g2yA==
X-Gm-Message-State: AO0yUKWFtBWsiP6Fpx9NZSrDjS6rsPXDsCOD+FBMHwosvM2e44UVSUet
        7xOATsSEiyPSk+z2usu5gZ119P6jmAPKg/1SMOwY+w==
X-Google-Smtp-Source: AK7set+zAaq0R+h4suQYhgRgqk6hp+Y00FM/JX+gQBlUJH+0qaoAfYJNRMpvJDJLcqk3/XeUT5uF+bDh7lFBg+eQtoA=
X-Received: by 2002:a2e:a365:0:b0:293:261e:74ce with SMTP id
 i5-20020a2ea365000000b00293261e74cemr312503ljn.4.1676450801070; Wed, 15 Feb
 2023 00:46:41 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006bc5be05f4b21b7b@google.com>
In-Reply-To: <0000000000006bc5be05f4b21b7b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Feb 2023 09:46:28 +0100
Message-ID: <CACT4Y+Yv7nuPkoQtAqu05K30hiq45ZYjPy-q5PAUHjJutydKig@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: INFO: rcu detected stall in corrupted
To:     syzbot <syzbot+42670398d6ddb118138f@syzkaller.appspotmail.com>
Cc:     aou@eecs.berkeley.edu, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mgorman@suse.de, mingo@redhat.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        Alex Ghiti <alex@ghiti.fr>
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

On Wed, 15 Feb 2023 at 01:24, syzbot
<syzbot+42670398d6ddb118138f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    950b879b7f02 riscv: Fixup race condition on PG_dcache_clea..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=137aaec0c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b3cd714c8e9a6e01
> dashboard link: https://syzkaller.appspot.com/bug?extid=42670398d6ddb118138f
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+42670398d6ddb118138f@syzkaller.appspotmail.com
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    0-...0: (1 GPs behind) idle=36ec/1/0x4000000000000000 softirq=6589/6590 fqs=9960
>         (detected by 1, t=30504 jiffies, g=14713, q=4 ncpus=2)
> Task dump for CPU 0:
> task:cmp             state:R  running task     stack:0     pid:2746  ppid:2744   flags:0x00000008
> Call Trace:
> [<ffffffff834348b8>] context_switch kernel/sched/core.c:5244 [inline]
> [<ffffffff834348b8>] __schedule+0x624/0x1254 kernel/sched/core.c:6555
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    0-...0: (1 GPs behind) idle=36ec/1/0x4000000000000000 softirq=6589/6590 fqs=28261
>         (detected by 1, t=122009 jiffies, g=14713, q=4 ncpus=2)
> Task dump for CPU 0:
> task:cmp             state:R  running task     stack:0     pid:2746  ppid:2744   flags:0x00000008
> Call Trace:
> [<ffffffff834348b8>] context_switch kernel/sched/core.c:5244 [inline]
> [<ffffffff834348b8>] __schedule+0x624/0x1254 kernel/sched/core.c:6555

Humm... initially I thought this may be related to the riscv issue
with too short command line (commit "riscv: Bump COMMAND_LINE_SIZE
value to 1024").

But it seems this actually fired after 300 seconds, right? (300
seconds is the intended timeout on syzbot):

>         (detected by 1, t=30504 jiffies, g=14713, q=4 ncpus=2)
