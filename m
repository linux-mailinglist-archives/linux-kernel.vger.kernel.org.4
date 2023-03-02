Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D86A841E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCBO06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:26:55 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC753457FF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:26:54 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id bo10so11714469qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4syLPvnUliFAB7Ucku786LYGOKX0G187dZUp8aM8GCE=;
        b=tMzDhXz9XiSvrraYBZ5vg81vqX/2Ei96b99h6vbLIXurOBhpA4p0J1DO3KZtgxUon7
         JiOC7usX6xidgZKjdJTgra3t0vvZV2bmF7E6uZXEx3Q/z94+KdVJDnenPsztRmzlwo7y
         j3GdyMZWG0o3tsPeuquyxB8LvmWlwLLL+dYJEEHl5Uf76LHDziLYdp4R00uvYbjKZ1UB
         To2srwOjxjjXCP8/ZwchBDD1FLFPuGpKjwKp4ltbX4RG553kyDwFtQf9PoR1AOL0GqRD
         Eg0z60u9VhGqu1Gc4UpfzZ/52EWUq9d8rqIT5ZgZ7fppb7/JOwzXIws042gFpwPHjZF4
         4FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4syLPvnUliFAB7Ucku786LYGOKX0G187dZUp8aM8GCE=;
        b=eAHYX8ncOZMf60HkS4I2cxy8Q8+S0DiShltHc7jKp/YRPYdO2tO02p3UHEiwn4q9vK
         1sGfr9yix3jDF9loPDLuCCncVBglA1K+tpgdHkYCTCLXsUsrDR30f1EXYe0anIGHeTp5
         sknMQVzWlF0/fxeb3w8mVPjTDY7Annv/vRrkVexVCnQsxKfPSTLtHqGY+fYJaG+x2AGX
         6w1CTmbVuIvuR6D5XiGHKljJWMaz/9rwJy52NHyOyJeSOiVQ7g/QBgHT/5U4jDh44ad5
         n7pqtLIp4MtIJ+eKUBmkHLKDkjFyXbHTD+B6uwvMrHnqd22rxuac9jz1D940LCL/V2hU
         R71Q==
X-Gm-Message-State: AO0yUKXgFhQCLFxczNRcEp3PQYZr3HllYBUe4Pv49SL0GL3QINjClWtz
        g/xwiVq9LjsLFy+dRj4E90VqRZvn3Ij8NWIUJl596Q==
X-Google-Smtp-Source: AK7set+aKtHT47VRH8DyIdNfx/f0hKmLdFyN9NvIV/CDk2z+2C0a9NSIthao7zDuaBAZvdv19L5hsP3F8x0bactMoJQ=
X-Received: by 2002:ad4:5911:0:b0:56e:9f6c:c266 with SMTP id
 ez17-20020ad45911000000b0056e9f6cc266mr2757975qvb.5.1677767213798; Thu, 02
 Mar 2023 06:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20230125101334.1069060-1-peternewman@google.com>
 <20230125101334.1069060-4-peternewman@google.com> <b14598a8-2ab1-eda2-e1fb-a5f568e869d5@intel.com>
In-Reply-To: <b14598a8-2ab1-eda2-e1fb-a5f568e869d5@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 2 Mar 2023 15:26:43 +0100
Message-ID: <CALPaoCgnP0zU4fkDxst9pyY1FrxW2zT-VfMTnJbj_iytQxknjQ@mail.gmail.com>
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

On Sat, Feb 11, 2023 at 12:21=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:

> On 1/25/2023 2:13 AM, Peter Newman wrote:

> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -3238,6 +3238,80 @@ static int rdtgroup_rmdir(struct kernfs_node *kn=
)
> >       return ret;
> >  }
> >
> > +static void mongrp_move(struct rdtgroup *rdtgrp, struct rdtgroup *new_=
prdtgrp,
> > +                     cpumask_var_t cpus)
>
> Could you please add some function comments on what is moved and how it i=
s accomplished?

Sure, I think I should also make the name more descriptive. I think
"move" is too high-level here.


> > +     for_each_process_thread(p, t) {
> > +             if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdtgr=
p))
> > +                     rdt_move_one_task(t, new_prdtgrp->closid, t->rmid=
,
> > +                                       cpus);
> > +     }
> > +     read_unlock(&tasklist_lock);
>
> Can rdt_move_group_tasks() be used here?

As it is today, rdt_move_group_tasks() would move too many tasks.
mongrp_move() needs both the CLOSID and RMID to match, while
rdt_move_group_tasks() only needs 0-1 of the two to match.

I tried adding more parameters to rdt_move_group_tasks() to change the
move condition, but I couldn't make the resulting code not look gross
and after factoring the tricky stuff into rdt_move_one_task(),
rdt_move_group_tasks() didn't look interesting enough to reuse.


>
> > +
> > +     update_closid_rmid(cpus, NULL);
> > +}
>
> I see the tasks in a monitor group handled. There is another way to creat=
e/manage
> a monitor group. For example, by not writing tasks to the tasks file but =
instead
> to write CPU ids to the CPU file. All tasks on a particular CPU will be m=
onitored
> by that group. One rule is that a MON group may only have CPUs that are o=
wned by
> the CTRL_MON group.
> It is not clear to me how such a group is handled in this work.

Right, I overlooked this form of monitoring.

I don't think it makes sense to move such a monitoring group, because a
CPU can only be assigned to one CTRL_MON group. Therefore a move of a MON
group with an assigned CPU will always violate the parent CTRL_MON group
rule after the move.

Based on this, I think rename of a MON group should fail when
rdtgrp->cpu_mask is non-zero.

>
>
> > +
> > +static int rdtgroup_rename(struct kernfs_node *kn,
> > +                        struct kernfs_node *new_parent, const char *ne=
w_name)
> > +{
> > +     struct rdtgroup *new_prdtgrp;
> > +     struct rdtgroup *rdtgrp;
> > +     cpumask_var_t tmpmask;
> > +     int ret;
> > +
> > +     if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> > +             return -ENOMEM;
> > +
> > +     rdtgrp =3D kernfs_to_rdtgroup(kn);
> > +     new_prdtgrp =3D kernfs_to_rdtgroup(new_parent);
> > +     if (!rdtgrp || !new_prdtgrp) {
> > +             free_cpumask_var(tmpmask);
> > +             return -EPERM;
> > +     }
> > +
>
> How robust is this against user space attempting to move files?

I'm not sure I understand the question. Can you be more specific?


>
> > +     /* Release both kernfs active_refs before obtaining rdtgroup mute=
x. */
> > +     rdtgroup_kn_get(rdtgrp, kn);
> > +     rdtgroup_kn_get(new_prdtgrp, new_parent);
> > +
> > +     mutex_lock(&rdtgroup_mutex);
> > +
> > +     if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DE=
LETED)) {
> > +             ret =3D -ESRCH;
> > +             goto out;
> > +     }
> > +
> > +     /* Only a mon group can be moved to a new mon_groups directory. *=
/
> > +     if (rdtgrp->type !=3D RDTMON_GROUP ||
> > +         !is_mon_groups(new_parent, kn->name)) {
> > +             ret =3D -EPERM;
> > +             goto out;
> > +     }
> > +
>
> Should in-place moves be allowed?

I don't think it's useful in the context of the intended use case.
Also, it looks like kernfs_rename() would fail with EEXIST if I tried.

If it were important to someone, I could make it succeed before calling
into kernfs_rename().


>
> > +     ret =3D kernfs_rename(kn, new_parent, new_name);
> > +     if (ret)
> > +             goto out;
> > +
> > +     mongrp_move(rdtgrp, new_prdtgrp, tmpmask);
> > +
>
> Can tmpmask allocation/free be done in mongrp_move()?

Yes, but it looked like most other functions in this file allocate the
cpumask up front before validating parameters. If you have a preference
for internalizing its allocation within mongrp_move(), I can try it.

Thank you for your review.

-Peter
