Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62796A9A44
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjCCPKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCCPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:10:14 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83A5F51C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:10:13 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ks17so1922081qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677856212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3K61dE5nomeywLz6vauhVAzV3Wdf4h5MNa31LEC3mI=;
        b=A2iAFmBF6GeAOHaL/ol6tYHo1lJLr1gLyCEQ64/QtySMBv7uLh0so0wvh/bs6pqFOE
         kLzxiat8/Sv4Ap4NK5W90jlbwwc81HwHDinKDOOz9nEMFG34l6pZhGqftrcOYGwFToOX
         Yb6jueC8egrV1VOTe05TY5csaTo8hPZXET1a4H3/sd5iAh5BStH/5WBNx77zIk9RbfTq
         xfz7XJX4SdMNca0zXNGHWlC4ISUJTUKyakKMKRBw1fO4nyT3ZnYKw1DTYET5ZejX/Iyw
         3dF5wio/GxrpAtNrBfBlC6KTMNLKOlaSSxgtG1+MRdWm4UjO8XDN5ef2ZKTl8O+qkTWp
         ysyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3K61dE5nomeywLz6vauhVAzV3Wdf4h5MNa31LEC3mI=;
        b=2pUlPSsKQEW9Pg3b/tUJkRbgMiipHgJt2sOFtQERUrxiqCQVlKd2UluG8GogyMjYFg
         ZlSZqZOdT+ZF08ewXBOlT+WU7vVaL2SSIcpyyE4fyfHr465vgba/KYpu3eJom36Koj+S
         mQAIIPmSv9wYYuT3//zi9ld9EA1BaiNynjlpm8bxVl7puM2E/+pSi2fD//QTC1P0DY+E
         9urfFAbf4jpOVg3IbZVdrMvamqmJnPO9QQasSpWVY5RssmZ1hhfbDHYkWS/LPPJCqmrL
         HVp6e38QSAFG9gId2QntrKG59aVgw0RZFg93tQrBcXOhdaocacte+zr0PeVexkQ7UhVv
         FGvA==
X-Gm-Message-State: AO0yUKXqZS7jG/39hg9tZc4Wa+E9Wbr7fG0PENps8q5TbLmMZ52sW10d
        3WsedgGA7jkf3cxctZ4QbZD6YhnH0zt5c57bucCflQ==
X-Google-Smtp-Source: AK7set/2OQbOWM5fxFvyrF81w08vEPzVEmOMq9x2K5FdPFafIT1t0fjYhwSlbSETwpHNtgqfdBPfjGFtjbMNq7xo/wA=
X-Received: by 2002:ad4:56e1:0:b0:56e:a9aa:dbcc with SMTP id
 cr1-20020ad456e1000000b0056ea9aadbccmr586062qvb.5.1677856212187; Fri, 03 Mar
 2023 07:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20230125101334.1069060-1-peternewman@google.com>
 <20230125101334.1069060-4-peternewman@google.com> <b14598a8-2ab1-eda2-e1fb-a5f568e869d5@intel.com>
 <CALPaoCgnP0zU4fkDxst9pyY1FrxW2zT-VfMTnJbj_iytQxknjQ@mail.gmail.com> <2f0abf41-87ba-0eee-03d9-ec3e5062d595@intel.com>
In-Reply-To: <2f0abf41-87ba-0eee-03d9-ec3e5062d595@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 3 Mar 2023 16:10:01 +0100
Message-ID: <CALPaoCgZuHxfH-OEiXsCn0cxmUQygwCH5HOT0ka5OmxMX96Y8g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/resctrl: Implement rename op for mon groups
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, Babu.Moger@amd.com, bp@alien8.de,
        dave.hansen@linux.intel.com, eranian@google.com,
        gupasani@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, skodak@google.com,
        tony.luck@intel.com, tglx@linutronix.de, x86@kernel.org
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

Hi Reinette,

On Thu, Mar 2, 2023 at 11:27=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 3/2/2023 6:26 AM, Peter Newman wrote:
> > On Sat, Feb 11, 2023 at 12:21=E2=80=AFAM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >
> >> On 1/25/2023 2:13 AM, Peter Newman wrote:
> >>> +     for_each_process_thread(p, t) {
> >>> +             if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdt=
grp))
> >>> +                     rdt_move_one_task(t, new_prdtgrp->closid, t->rm=
id,
> >>> +                                       cpus);
> >>> +     }
> >>> +     read_unlock(&tasklist_lock);
> >>
> >> Can rdt_move_group_tasks() be used here?
> >
> > As it is today, rdt_move_group_tasks() would move too many tasks.
> > mongrp_move() needs both the CLOSID and RMID to match, while
> > rdt_move_group_tasks() only needs 0-1 of the two to match.
> >
> > I tried adding more parameters to rdt_move_group_tasks() to change the
> > move condition, but I couldn't make the resulting code not look gross
> > and after factoring the tricky stuff into rdt_move_one_task(),
> > rdt_move_group_tasks() didn't look interesting enough to reuse.
>
> Could it be made readable by adding a compare function as parameter to
> rdt_move_group_tasks() that is used to determine if a task should be move=
d?

Yes, I think that would be ok in this case. That shouldn't have any
cost if these are all static functions.

As long as we have an rdt_move_group_tasks() function, it's a liability
to have a separate task-moving loop for someone to miss in the future.

Should I still bother with factoring out rdt_move_one_task() in the
parent patch? It was motivated by my creating a new task-moving loop
in this patch.


> >>> +
> >>> +     rdtgrp =3D kernfs_to_rdtgroup(kn);
> >>> +     new_prdtgrp =3D kernfs_to_rdtgroup(new_parent);
> >>> +     if (!rdtgrp || !new_prdtgrp) {
> >>> +             free_cpumask_var(tmpmask);
> >>> +             return -EPERM;
> >>> +     }
> >>> +
> >>
> >> How robust is this against user space attempting to move files?
> >
> > I'm not sure I understand the question. Can you be more specific?
>
> This commit adds support for rename to resctrl. I thus expect this
> function to be called when user space attempts to move _any_ of
> the files and/or directories within resctrl. This could be out of
> curiosity, buggy, or maliciousness. I would like to understand how
> robust this code would be against such attempts because I do not see
> much checking before the preparation to do the move is started.

Now I see, thanks.

kernfs_to_rdtgroup() will return the parent rdtgroup when
kn or new_parent is a file, which will lead to kernfs_rename() moving
a file out of a group or clobbering another file node. I'll need to
enforce that kn and new_parent are rdtgroup directories and not file
nodes.

Assuming that the paths of kn and new_parent exactly match their
rdtgroup directories, I believe the checks below are sufficient to
constrain the operation to only moving MON groups to existing
mon_groups directories.


> >> Should in-place moves be allowed?
> >
> > I don't think it's useful in the context of the intended use case.
> > Also, it looks like kernfs_rename() would fail with EEXIST if I tried.
> >
>
> From what I can tell kernfs_rename() will return EEXIST if there
> is an attempt to create file/directory with the same name at the same pla=
ce.
> What I am asking about is if user space requests to change the name
> of a monitoring group without moving it to a new resource group. This see=
ms
> to be supported by this code but if it is supported it could likely be
> done more efficiently since no tasks need to be moved because neither
> closid nor rmid needs to change.

Yes, I see now. I'll try skipping the mongrp_move() call below when
new_parent is already the parent of rdtgrp to optimize the simple
rename use case.


> >> Can tmpmask allocation/free be done in mongrp_move()?
> >
> > Yes, but it looked like most other functions in this file allocate the
> > cpumask up front before validating parameters. If you have a preference
> > for internalizing its allocation within mongrp_move(), I can try it.
>
> Could you please elaborate what the concern is? From what I can tell
> mongrp_move() is the only user of the cpumask so it is not clear to
> me why it cannot take care of the allocation and free.
>
> When referring to existing code I assume you mean rdtgroup_rmdir(). This
> is the only code I could find in this file with this pattern. I looked
> back at the history and indeed the cpumask was allocated where it was
> used but the flow was changed to the current when support for monitoring
> groups were added. See f9049547f7e7 ("x86/intel_rdt: Separate the ctrl bi=
ts from rmdir")
> I do not see a requirement for doing the allocations in that way.

I looked over this again in more detail...

I need to choose whether to call kernfs_rename() or mongrp_move() first.
If the second call fails, the first needs to be reverted. It's feasible
to ensure that a mongrp_move() call will be successful before calling
kernfs_rename(), but not the other way around.

If I allow mongrp_move() to fail, kernfs_rename() should be reversible
thanks to the prior checks validating this use case, but I would prefer
to eliminate the need for a revert on cleanup entirely.

-Peter
