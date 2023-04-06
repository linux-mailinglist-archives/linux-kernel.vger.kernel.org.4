Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DD6D9699
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjDFMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjDFL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDF2A27F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680782137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQX3WRNMfPiogRsEsvl447G01+xH+aEMDKGl9bYOu6w=;
        b=eeEFe0qIuLUPncJBm9g9wrgbrdPkTBL2EjQtfo6kMlfWEAehkw0txjb7KwPnOalnJVft4L
        zLPJ4rywHrzTUvNqIKRKRb4QFswY5YKgIMkzSx4u7XUnPPwv5dIYmIoF45eRI6zr1VRnKP
        g40vRWlEr94UGfZXJE+9leVGZj7NEVM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-k4USPb7mPbiWOJuFvUCrTg-1; Thu, 06 Apr 2023 07:55:36 -0400
X-MC-Unique: k4USPb7mPbiWOJuFvUCrTg-1
Received: by mail-qt1-f197.google.com with SMTP id f36-20020a05622a1a2400b003deb2fa544bso26676685qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782135; x=1683374135;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQX3WRNMfPiogRsEsvl447G01+xH+aEMDKGl9bYOu6w=;
        b=zwoWgQddXfanc96Pnyc98kxM6PHpZ8OUjiG+zZY0xXALOb383aAYvLGHcLa3fj3PTd
         XjVVUw8+JdMLPvW48HIgBXGNPkg26QO23xlobOsKOZTFJm0TbIBuaAItk64xEtl4rSO+
         YnoppZjhUqODBlutwNzz9LdVGU2JujBBl2k4neAewIeZlm0YASrf1sXncLaVDf9eTguQ
         WnoYoBSsx+cYP9LR37lCBeAN0OVNeUG5YrRtAnaEijaNd6VX2g8mBq3eEwE//mqVjf9s
         yzswKsXCZfg2v25+b1y2U2axtXw4HOM9P4HaQeFPkYRiKrOiMFJVb/74zri1yEZLaldS
         lqHw==
X-Gm-Message-State: AAQBX9ccJf+rasSXt4UVeXFa40JGbiOOrwQrjxReqVTTy6bOeQ8YGYvO
        UHa39O6K85u8NcOaLuO+g/4sj7mU3DkTia8SClGdnygyYrvH3xmcPrdiK6vqf0J8u+MCR+TTRB6
        k98/heC11joTQBSL3QCaTIlro
X-Received: by 2002:a05:6214:27c6:b0:5e0:7ecb:8ffb with SMTP id ge6-20020a05621427c600b005e07ecb8ffbmr4106929qvb.8.1680782135686;
        Thu, 06 Apr 2023 04:55:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350axLgBh+5F7i2tKBHZrLQfjdNN72g86JtFocUjCBavyU/AXZ31bIqlgCaUxHt0tIMkEuBXRJg==
X-Received: by 2002:a05:6214:27c6:b0:5e0:7ecb:8ffb with SMTP id ge6-20020a05621427c600b005e07ecb8ffbmr4106912qvb.8.1680782135442;
        Thu, 06 Apr 2023 04:55:35 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id ob17-20020a0562142f9100b005e3d3cafc16sm457184qvb.73.2023.04.06.04.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:55:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH v8 1/2] sched/rt: fix bad task migration for rt tasks
In-Reply-To: <20220828170303.171400-1-schspa@gmail.com>
References: <20220828170303.171400-1-schspa@gmail.com>
Date:   Thu, 06 Apr 2023 12:55:31 +0100
Message-ID: <xhsmhile99qdo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/22 01:03, Schspa Shi wrote:
> Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
> allow find_lock_lowest_rq to pick a task with migration disabled.
> This commit is intended to push the current running task on this CPU
> away.
>
> There is a race scenario, which allows a migration disabled task to
> be migrated to another CPU.
>
> When there is a RT task with higher priority, rt sched class was
> intended to migrate higher priority task to lowest rq via push_rt_tasks,
> this WARNING will happen here.
>
> With the system running on PREEMPT_RT, rt_spin_lock will disable
> migration, this will make the problem easier to reproduce.
>
> I have seen this WARNING on PREEMPT_RT, from the logs, there is a race
> when trying to migrate higher priority tasks to the lowest rq.
>
> Please refer to the following scenarios.
>
>            CPU0                                  CPU1
> ------------------------------------------------------------------
> push_rt_task
>   check is_migration_disabled(next_task)
>                                         task not running and
>                                         migration_disabled == 0
>   find_lock_lowest_rq(next_task, rq);
>     _double_lock_balance(this_rq, busiest);
>       raw_spin_rq_unlock(this_rq);
>       double_rq_lock(this_rq, busiest);
>         <<wait for busiest rq>>
>                                             <wakeup>
>                                         task become running
>                                         migrate_disable();
>                                           <context out>
>   deactivate_task(rq, next_task, 0);
>   set_task_cpu(next_task, lowest_rq->cpu);
>     WARN_ON_ONCE(is_migration_disabled(p));
>       ---------OOPS-------------
>
> Crash logs are as follows:
> [123671.996430] WARNING: CPU: 2 PID: 13470 at kernel/sched/core.c:2485
> set_task_cpu+0x8c/0x108
> [123671.996800] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
> [123671.996811] pc : set_task_cpu+0x8c/0x108
> [123671.996820] lr : set_task_cpu+0x7c/0x108
> [123671.996828] sp : ffff80001268bd30
> [123671.996832] pmr_save: 00000060
> [123671.996835] x29: ffff80001268bd30 x28: ffff0001a3d68e80
> [123671.996844] x27: ffff80001225f4a8 x26: ffff800010ab62cb
> [123671.996854] x25: ffff80026d95e000 x24: 0000000000000005
> [123671.996864] x23: ffff00019746c1b0 x22: 0000000000000000
> [123671.996873] x21: ffff00027ee33a80 x20: 0000000000000000
> [123671.996882] x19: ffff00019746ba00 x18: 0000000000000000
> [123671.996890] x17: 0000000000000000 x16: 0000000000000000
> [123671.996899] x15: 000000000000000a x14: 000000000000349e
> [123671.996908] x13: ffff800012f4503d x12: 0000000000000001
> [123671.996916] x11: 0000000000000000 x10: 0000000000000000
> [123671.996925] x9 : 00000000000c0000 x8 : ffff00027ee58700
> [123671.996933] x7 : ffff00027ee8da80 x6 : ffff00027ee8e580
> [123671.996942] x5 : ffff00027ee8dcc0 x4 : 0000000000000005
> [123671.996951] x3 : ffff00027ee8e338 x2 : 0000000000000000
> [123671.996959] x1 : 00000000000000ff x0 : 0000000000000002
> [123671.996969] Call trace:
> [123671.996975]  set_task_cpu+0x8c/0x108
> [123671.996984]  push_rt_task.part.0+0x144/0x184
> [123671.996995]  push_rt_tasks+0x28/0x3c
> [123671.997002]  task_woken_rt+0x58/0x68
> [123671.997009]  ttwu_do_wakeup+0x5c/0xd0
> [123671.997019]  ttwu_do_activate+0xc0/0xd4
> [123671.997028]  try_to_wake_up+0x244/0x288
> [123671.997036]  wake_up_process+0x18/0x24
> [123671.997045]  __irq_wake_thread+0x64/0x80
> [123671.997056]  __handle_irq_event_percpu+0x110/0x124
> [123671.997064]  handle_irq_event_percpu+0x50/0xac
> [123671.997072]  handle_irq_event+0x84/0xfc
>
> To fix it, we need to check migration_disabled flag again to avoid
> bad migration.
>
> Fixes: 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
>
> CC: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>

Sorry, I lost track of that one, and ironically it looks like we've hit
this bug internally. I'm going to test whether this is the cure we need,
but even if this isn't the same issue, that patch looks good:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

I have some more comments on 2/2, but IMO this can go in on its own.

