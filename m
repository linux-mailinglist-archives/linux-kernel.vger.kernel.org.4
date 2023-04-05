Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C06D85C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjDESMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjDESMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:12:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BA72AE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:12:14 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d3so15710142ybu.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680718333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6Pry4pnx6T0Rh2iyz0LFzPUOm+SG3X585FahTXWqMA=;
        b=RSQcjQKvrB51Wu6LP5qpBbWrEpXPZLwAMc5n+F73LMsXOKDuaIg63rDtodk2BTJ9Fw
         hE8F3Y8iYI151CocFhQamQWQzdsf0NEtcISSmQxmUdM1Ig6NBoVEeBSZwc0n1w+tFRa/
         rxZ3tdMBkR8VgyR6ZKkph/Q6CjZO7l6uOii3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680718333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6Pry4pnx6T0Rh2iyz0LFzPUOm+SG3X585FahTXWqMA=;
        b=dEavj/A8NsjuWamJYun1swcknjDPNL1I2gGKv77aaEJ+GpqEyxaSO+jIw8xsfoUPeM
         H2E2aJ8wo2OwvyBwwNWypZKjpxSH5ptOU1BGFgKNkXgCnalNo39O58v7j5dbO9wRqC9u
         SPmXfj3Gkh/N5rL9WOXEM5AXwaUPNjT8360qZ8QfqgsZLz6RjAEFsZ6jRUZ3Ce/NcQ32
         JAlBUEipZ38xKsOkECfqsh5KHI4yjM4Qc57iZMsvsRDsUM65GqrVf8nrn3pFFgASVvNl
         ytgigD1Vdn2y0NQdD8L9719BbMM2R8E5Irve+HSRpMZatbN7ziVmIk9UZAuc7lgsTiZr
         wZVA==
X-Gm-Message-State: AAQBX9e4aL9gxcEjmVk/p4DxZBObNHS3/u4z2d92ngRfPiWV3+pS6nTo
        YUQQ4zJUnqMa5ZKXl4ScQ/vZiqWLv9MrQz5AOuvbpw==
X-Google-Smtp-Source: AKy350bVmJCCCb4dEsaJ3tRfC2sjGTjefR4bw717419PMRYtgEikmUqUCKYuz4F5PGvdId7xoPjmRf1+stX/j75no4o=
X-Received: by 2002:a25:ccc4:0:b0:b8a:5fd7:5180 with SMTP id
 l187-20020a25ccc4000000b00b8a5fd75180mr152195ybf.2.1680718333506; Wed, 05 Apr
 2023 11:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com> <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
In-Reply-To: <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 5 Apr 2023 14:12:02 -0400
Message-ID: <CAEXW_YRtV7pAYR-UyVNNsgPJ2dmBGrV+DkNROOivXj3MChDgGw@mail.gmail.com>
Subject: Re: [PATCH V2] rcu: Make sure new krcp free business is handled after
 the wanted rcu grace period.
To:     Ziwei Dai <ziwei.dai@unisoc.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuang.wang@unisoc.com,
        yifan.xin@unisoc.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com,
        zhiguo.niu@unisoc.com, zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 1:39=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Fri, Mar 31, 2023 at 8:43=E2=80=AFAM Ziwei Dai <ziwei.dai@unisoc.com> =
wrote:
> >
> > In kfree_rcu_monitor(), new free business at krcp is attached to any fr=
ee
> > channel at krwp. kfree_rcu_monitor() is responsible to make sure new fr=
ee
> > business is handled after the rcu grace period. But if there is any non=
e-free
> > channel at krwp already, that means there is an on-going rcu work,
> > which will cause the kvfree_call_rcu()-triggered free business is done
> > before the wanted rcu grace period ends.
> >
> > This commit ignore krwp which has non-free channel at kfree_rcu_monitor=
(),
> > to fix the issue that kvfree_call_rcu() loses effectiveness.
> >
> > Below is the css_set obj "from_cset" use-after-free case caused by
> > kvfree_call_rcu() losing effectiveness.
> > CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes,
> > the task is schedule out.
> > CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" afte=
r new gp.
> > But "from_cset" is freed right after current gp end. "from_cset" is rea=
llocated.
> > CPU 0 's task arrives back, references "from_cset"'s member, which caus=
es crash.
> >
> > CPU 0                                   CPU 1
> > count_memcg_event_mm()
> > |rcu_read_lock()  <---
> > |mem_cgroup_from_task()
> >  |// css_set_ptr is the "from_cset" mentioned on CPU 1
> >  |css_set_ptr =3D rcu_dereference((task)->cgroups)
> >  |// Hard irq comes, current task is scheduled out.
> >
> >                                         cgroup_attach_task()
> >                                         |cgroup_migrate()
> >                                         |cgroup_migrate_execute()
> >                                         |css_set_move_task(task, from_c=
set, to_cset, true)
> >                                         |cgroup_move_task(task, to_cset=
)
> >                                         |rcu_assign_pointer(.., to_cset=
)
> >                                         |...
> >                                         |cgroup_migrate_finish()
> >                                         |put_css_set_locked(from_cset)
> >                                         |from_cset->refcount return 0
> >                                         |kfree_rcu(cset, rcu_head) // m=
eans to free from_cset after new gp
> >                                         |add_ptr_to_bulk_krc_lock()
> >                                         |schedule_delayed_work(&krcp->m=
onitor_work, ..)
> >
> >                                         kfree_rcu_monitor()
> >                                         |krcp->bulk_head[0]'s work atta=
ched to krwp->bulk_head_free[]
> >                                         |queue_rcu_work(system_wq, &krw=
p->rcu_work)
> >                                         |if rwork->rcu.work is not in W=
ORK_STRUCT_PENDING_BIT state,
> >                                         |call_rcu(&rwork->rcu, rcu_work=
_rcufn) <--- request a new gp
> >
> >                                         // There is a perious call_rcu(=
.., rcu_work_rcufn)
> >                                         // gp end, rcu_work_rcufn() is =
called.
> >                                         rcu_work_rcufn()
> >                                         |__queue_work(.., rwork->wq, &r=
work->work);
> >
> >                                         |kfree_rcu_work()
> >                                         |krwp->bulk_head_free[0] bulk i=
s freed before new gp end!!!
> >                                         |The "from_cset" is freed befor=
e new gp end.
> >
> > // the task is scheduled in after many ms.
> >  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css=
_set_ptr is freed.
> >
> > v2: Use helper function instead of inserted code block at kfree_rcu_mon=
itor().
> >
> > Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of kfree_rcu(=
) work")
> > Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
>
> Please update the fixes tag to:
> 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")

Vlad pointed out in another thread that the fix is actually to 34c881745549=
.

So just to be sure, it could be updated to:
Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")

thanks,

 - Joel
