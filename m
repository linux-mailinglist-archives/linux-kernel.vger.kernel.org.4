Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04E772DD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbjFMJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbjFMJPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:15:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC31A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:15:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f98276f89cso146011cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686647736; x=1689239736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQhxEt01WWC9jKURdXbeXoWofOugqPqfEcw3e/eZLi8=;
        b=lwHtXgHnxujXHCk/i19J0JxWSS5HphPQ+FwgkqQy5n723YZ8ANv3OyJu4OI7vq47sI
         Cpy8Ne9aOCsYvSqOOH4hMFhP1rcIujxp3V1iAOcGntZwaBkgCqJVWHzZ1tNwU9KGS4Hg
         vvayrKHGLNwvvDzczps4NEGkL0DcdPti74fU3mFKbMm+u8Ej8ZVieNmeC3J7ubaImzNs
         8DM17DZgHW7gK7/GXM9mSTj23j6yZosnBuWZRGHjpEDAS6bE/M6zV8lH4YVT6+YicYTd
         mnXNuPdOheOaLzUwVBM5ykUEuK3Wn02iCNaB3CdQnd+BnJ3NRthNiVVbD3p7iHCxT07u
         YMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647736; x=1689239736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQhxEt01WWC9jKURdXbeXoWofOugqPqfEcw3e/eZLi8=;
        b=AUj8GiO2cNMwAx3G5EA77sskBy4vJIUUJIdSW0xjFs13HWObl7IcxdSmMjO3OhUS+G
         KZEgvDRtIb5psGZM9O9qICoZBWP/besGERNvTrvBaNUgvU223kdqyiPTp/2WEYbvunPi
         yqU7jrMdzKWRK0g8Wb+u1ViP9TC1/IsAorMjgFgzl4DN6+w6k39xg/li+HZZsz7IRlfp
         K8B7X4KlNsjQ9Iq8FdDQiAvbzd651e52ViTXkjfrhg2OJxch50ISW0tHUYJ++E1m+1XS
         jQoANbPAw5ygRW+O067Xgy2/i2sF8BsFybtHhsVbLKFr7C8WO5pxdhbDNEdHTz7AQOZk
         TbRA==
X-Gm-Message-State: AC+VfDzgsK5rdlxRn51oKM/b5sJClgNxUJr4PiFwEybT9sPCbLDQMjuS
        L5pXY5HO3/bR9AA/qysRd6w6Wx8JlUootf5eMUzEcQ==
X-Google-Smtp-Source: ACHHUZ7yueJ0OvZrVyfHFtA6puhJYQ84pbRBIvxFiyNMFtow7MEXaV3yqC8CVtph+aOVcs/0QlNkNTyBWP94i0z2FSM=
X-Received: by 2002:ac8:7d4f:0:b0:3ef:343b:fe7e with SMTP id
 h15-20020ac87d4f000000b003ef343bfe7emr92897qtb.2.1686647735616; Tue, 13 Jun
 2023 02:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230525180209.19497-1-james.morse@arm.com> <20230525180209.19497-25-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-25-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 13 Jun 2023 11:15:24 +0200
Message-ID: <CALPaoCjxUMy_yW0+4MgssiisoDpeP8m62fP9nhTcse9nKiXM+A@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] x86/resctrl: Separate arch and fs resctrl locks
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi James,

On Thu, May 25, 2023 at 8:03=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
>
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against cpu hotplug. The cpu hotplug
> code already has a mechanism to do this using cpus_read_lock().
>
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.

I noticed there's also a call to get_domain_from_cpu() in
rdt_ctrl_update(), which is invoked by IPI when updating a schemata
file, but at least it's a blocking IPI and the caller holds the
rdtgroup_mutex, so the handler is serialized with CPU hotplug.

Taking a step back, I'm concerned about the scalability of searching
these linked-lists of domains in atomic contexts. We already have
machines where the list is 32 entries deep in L3, and much larger in
L2 CAT.

Will the overflow interrupt target a CPU in the correct domain? The
existing domain list search in rdt_ctrl_update() is for the current
CPU's domain, so an alternative there would be to store each CPU's
interrupt-relevant domain pointers in percpu data for quick lookup.

Also, how quickly does the overflow condition need to be serviced? On
Intel, overflow handling deadlines aren't even tight enough to warrant
an interrupt handler.

Thanks!
-Peter





>
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
>
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
>
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() can
> walk the domain list under rcu_read_lock(). The mon_config helpers
> send multiple IPIs, take the cpus_read_lock() in these cases.
>
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
>
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.
>
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Reworded a comment,
>  * Added a lockdep assertion
>  * Moved clear_closid_rmid() outside the locked region of cpu
>    online/offline
>
> Changes since v3:
>  * Added a header include
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 38 +++++++++-----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  4 ++
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 63 ++++++++++++++++++++---
>  include/linux/resctrl.h                   |  2 +-
>  6 files changed, 100 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/res=
ctrl/core.c
> index edc0dd123317..f106c68a9be8 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -25,8 +25,15 @@
>  #include <asm/resctrl.h>
>  #include "internal.h"
>
> -/* Mutex to protect rdtgroup access. */
> -DEFINE_MUTEX(rdtgroup_mutex);
> +/*
> + * rdt_domain structures are kfree()d when their last CPU goes offline,
> + * and allocated when the first CPU in a new domain comes online.
> + * The rdt_resource's domain list is updated when this happens. Readers =
of
> + * the domain list must either take cpus_read_lock(), or rely on an RCU
> + * read-side critical section, to avoid observing concurrent modificatio=
n.
> + * All writers take this mutex:
> + */
> +static DEFINE_MUTEX(domain_list_lock);
>
>  /*
>   * The cached resctrl_pqr_state is strictly per CPU and can never be
> @@ -508,6 +515,8 @@ static void domain_add_cpu(int cpu, struct rdt_resour=
ce *r)
>         struct rdt_domain *d;
>         int err;
>
> +       lockdep_assert_held(&domain_list_lock);
> +
>         d =3D rdt_find_domain(r, id, &add_pos);
>         if (IS_ERR(d)) {
>                 pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -541,11 +550,12 @@ static void domain_add_cpu(int cpu, struct rdt_reso=
urce *r)
>                 return;
>         }
>
> -       list_add_tail(&d->list, add_pos);
> +       list_add_tail_rcu(&d->list, add_pos);
>
>         err =3D resctrl_online_domain(r, d);
>         if (err) {
> -               list_del(&d->list);
> +               list_del_rcu(&d->list);
> +               synchronize_rcu();
>                 domain_free(hw_dom);
>         }
>  }
> @@ -556,6 +566,8 @@ static void domain_remove_cpu(int cpu, struct rdt_res=
ource *r)
>         struct rdt_hw_domain *hw_dom;
>         struct rdt_domain *d;
>
> +       lockdep_assert_held(&domain_list_lock);
> +
>         d =3D rdt_find_domain(r, id, NULL);
>         if (IS_ERR_OR_NULL(d)) {
>                 pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -566,7 +578,8 @@ static void domain_remove_cpu(int cpu, struct rdt_res=
ource *r)
>         cpumask_clear_cpu(cpu, &d->cpu_mask);
>         if (cpumask_empty(&d->cpu_mask)) {
>                 resctrl_offline_domain(r, d);
> -               list_del(&d->list);
> +               list_del_rcu(&d->list);
> +               synchronize_rcu();
>
>                 /*
>                  * rdt_domain "d" is going to be freed below, so clear
> @@ -594,30 +607,29 @@ static void clear_closid_rmid(int cpu)
>  static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>         struct rdt_resource *r;
> -       int ret;
>
> -       mutex_lock(&rdtgroup_mutex);
> +       mutex_lock(&domain_list_lock);
>         for_each_capable_rdt_resource(r)
>                 domain_add_cpu(cpu, r);
> +       mutex_unlock(&domain_list_lock);
> +
>         clear_closid_rmid(cpu);
>
> -       ret =3D resctrl_online_cpu(cpu);
> -       mutex_unlock(&rdtgroup_mutex);
> -
> -       return ret;
> +       return resctrl_online_cpu(cpu);
>  }
>
>  static int resctrl_arch_offline_cpu(unsigned int cpu)
>  {
>         struct rdt_resource *r;
>
> -       mutex_lock(&rdtgroup_mutex);
>         resctrl_offline_cpu(cpu);
>
> +       mutex_lock(&domain_list_lock);
>         for_each_capable_rdt_resource(r)
>                 domain_remove_cpu(cpu, r);
> +       mutex_unlock(&domain_list_lock);
> +
>         clear_closid_rmid(cpu);
> -       mutex_unlock(&rdtgroup_mutex);
>
>         return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/=
cpu/resctrl/ctrlmondata.c
> index 280d66fae21c..d8d7c127403b 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -209,6 +209,9 @@ static int parse_line(char *line, struct resctrl_sche=
ma *s,
>         struct rdt_domain *d;
>         unsigned long dom_id;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
>             (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE=
_SMBA)) {
>                 rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> @@ -313,6 +316,9 @@ int resctrl_arch_update_domains(struct rdt_resource *=
r, u32 closid)
>         struct rdt_domain *d;
>         u32 idx;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>                 return -ENOMEM;
>
> @@ -378,11 +384,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_f=
ile *of,
>                 return -EINVAL;
>         buf[nbytes - 1] =3D '\0';
>
> -       cpus_read_lock();
>         rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
>         if (!rdtgrp) {
>                 rdtgroup_kn_unlock(of->kn);
> -               cpus_read_unlock();
>                 return -ENOENT;
>         }
>         rdt_last_cmd_clear();
> @@ -444,7 +448,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_fi=
le *of,
>  out:
>         rdt_staged_configs_clear();
>         rdtgroup_kn_unlock(of->kn);
> -       cpus_read_unlock();
>         return ret ?: nbytes;
>  }
>
> @@ -464,6 +467,9 @@ static void show_doms(struct seq_file *s, struct resc=
trl_schema *schema, int clo
>         bool sep =3D false;
>         u32 ctrl_val;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         seq_printf(s, "%*s:", max_name_width, schema->name);
>         list_for_each_entry(dom, &r->domains, list) {
>                 if (sep)
> @@ -534,8 +540,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_=
resource *r,
>  {
>         int cpu;
>
> -       /* When picking a CPU from cpu_mask, ensure it can't race with cp=
uhp */
> -       lockdep_assert_held(&rdtgroup_mutex);
> +       /* When picking a cpu from cpu_mask, ensure it can't race with cp=
uhp */
> +       lockdep_assert_cpus_held();
>
>         /*
>          * setup the parameters to pass to mon_event_count() to read the =
data.
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/=
resctrl/monitor.c
> index ae02185f3354..41b4cd2c7d64 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -15,6 +15,7 @@
>   * Software Developer Manual June 2016, volume 3, section 17.17.
>   */
>
> +#include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -476,6 +477,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>
>         lockdep_assert_held(&rdtgroup_mutex);
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         idx =3D resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>
>         entry->busy =3D 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/=
cpu/resctrl/pseudo_lock.c
> index 460421051abf..fc3ed917d173 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -830,6 +830,9 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_d=
omain *d)
>         struct rdt_domain *d_i;
>         bool ret =3D false;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
>                 return true;
>
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index 3a8e2c98b611..9002ac728001 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -35,6 +35,10 @@
>  DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> +
> +/* Mutex to protect rdtgroup access. */
> +DEFINE_MUTEX(rdtgroup_mutex);
> +
>  static struct kernfs_root *rdt_root;
>  struct rdtgroup rdtgroup_default;
>  LIST_HEAD(rdt_all_groups);
> @@ -950,7 +954,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file=
 *of,
>
>         mutex_lock(&rdtgroup_mutex);
>         hw_shareable =3D r->cache.shareable_bits;
> -       list_for_each_entry(dom, &r->domains, list) {
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(dom, &r->domains, list) {
>                 if (sep)
>                         seq_putc(seq, ';');
>                 sw_shareable =3D 0;
> @@ -1006,8 +1011,10 @@ static int rdt_bit_usage_show(struct kernfs_open_f=
ile *of,
>                 }
>                 sep =3D true;
>         }
> +       rcu_read_unlock();
>         seq_putc(seq, '\n');
>         mutex_unlock(&rdtgroup_mutex);
> +
>         return 0;
>  }
>
> @@ -1250,6 +1257,9 @@ static bool rdtgroup_mode_test_exclusive(struct rdt=
group *rdtgrp)
>         struct rdt_domain *d;
>         u32 ctrl;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         list_for_each_entry(s, &resctrl_schema_all, list) {
>                 r =3D s->res;
>                 if (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_R=
ESOURCE_SMBA)
> @@ -1516,6 +1526,7 @@ static int mbm_config_show(struct seq_file *s, stru=
ct rdt_resource *r, u32 evtid
>         struct rdt_domain *dom;
>         bool sep =3D false;
>
> +       cpus_read_lock();
>         mutex_lock(&rdtgroup_mutex);
>
>         list_for_each_entry(dom, &r->domains, list) {
> @@ -1532,6 +1543,7 @@ static int mbm_config_show(struct seq_file *s, stru=
ct rdt_resource *r, u32 evtid
>         seq_puts(s, "\n");
>
>         mutex_unlock(&rdtgroup_mutex);
> +       cpus_read_unlock();
>
>         return 0;
>  }
> @@ -1623,6 +1635,9 @@ static int mon_config_write(struct rdt_resource *r,=
 char *tok, u32 evtid)
>         struct rdt_domain *d;
>         int ret =3D 0;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>  next:
>         if (!tok || tok[0] =3D=3D '\0')
>                 return 0;
> @@ -1664,6 +1679,7 @@ static ssize_t mbm_total_bytes_config_write(struct =
kernfs_open_file *of,
>         if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
>                 return -EINVAL;
>
> +       cpus_read_lock();
>         mutex_lock(&rdtgroup_mutex);
>
>         rdt_last_cmd_clear();
> @@ -1673,6 +1689,7 @@ static ssize_t mbm_total_bytes_config_write(struct =
kernfs_open_file *of,
>         ret =3D mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
>
>         mutex_unlock(&rdtgroup_mutex);
> +       cpus_read_unlock();
>
>         return ret ?: nbytes;
>  }
> @@ -1688,6 +1705,7 @@ static ssize_t mbm_local_bytes_config_write(struct =
kernfs_open_file *of,
>         if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
>                 return -EINVAL;
>
> +       cpus_read_lock();
>         mutex_lock(&rdtgroup_mutex);
>
>         rdt_last_cmd_clear();
> @@ -1697,6 +1715,7 @@ static ssize_t mbm_local_bytes_config_write(struct =
kernfs_open_file *of,
>         ret =3D mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
>
>         mutex_unlock(&rdtgroup_mutex);
> +       cpus_read_unlock();
>
>         return ret ?: nbytes;
>  }
> @@ -2149,6 +2168,9 @@ static int set_cache_qos_cfg(int level, bool enable=
)
>         struct rdt_domain *d;
>         int cpu;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         if (level =3D=3D RDT_RESOURCE_L3)
>                 update =3D l3_qos_cfg_update;
>         else if (level =3D=3D RDT_RESOURCE_L2)
> @@ -2337,6 +2359,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernf=
s_node *kn)
>         atomic_inc(&rdtgrp->waitcount);
>         kernfs_break_active_protection(kn);
>
> +       cpus_read_lock();
>         mutex_lock(&rdtgroup_mutex);
>
>         /* Was this group deleted while we waited? */
> @@ -2354,6 +2377,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
>                 return;
>
>         mutex_unlock(&rdtgroup_mutex);
> +       cpus_read_unlock();
>
>         if (atomic_dec_and_test(&rdtgrp->waitcount) &&
>             (rdtgrp->flags & RDT_DELETED)) {
> @@ -2651,6 +2675,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
>         struct rdt_domain *d;
>         int i;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>                 return -ENOMEM;
>
> @@ -2935,6 +2962,9 @@ static int mkdir_mondata_subdir_alldom(struct kernf=
s_node *parent_kn,
>         struct rdt_domain *dom;
>         int ret;
>
> +       /* Walking r->domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
>         list_for_each_entry(dom, &r->domains, list) {
>                 ret =3D mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>                 if (ret)
> @@ -3625,7 +3655,8 @@ static void domain_destroy_mon_state(struct rdt_dom=
ain *d)
>         kfree(d->mbm_local);
>  }
>
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d=
)
> +static void _resctrl_offline_domain(struct rdt_resource *r,
> +                                   struct rdt_domain *d)
>  {
>         lockdep_assert_held(&rdtgroup_mutex);
>
> @@ -3660,6 +3691,13 @@ void resctrl_offline_domain(struct rdt_resource *r=
, struct rdt_domain *d)
>         domain_destroy_mon_state(d);
>  }
>
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d=
)
> +{
> +       mutex_lock(&rdtgroup_mutex);
> +       _resctrl_offline_domain(r, d);
> +       mutex_unlock(&rdtgroup_mutex);
> +}
> +
>  static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_dom=
ain *d)
>  {
>         u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
> @@ -3691,7 +3729,7 @@ static int domain_setup_mon_state(struct rdt_resour=
ce *r, struct rdt_domain *d)
>         return 0;
>  }
>
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +static int _resctrl_online_domain(struct rdt_resource *r, struct rdt_dom=
ain *d)
>  {
>         int err;
>
> @@ -3727,12 +3765,23 @@ int resctrl_online_domain(struct rdt_resource *r,=
 struct rdt_domain *d)
>         return 0;
>  }
>
> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +       int err;
> +
> +       mutex_lock(&rdtgroup_mutex);
> +       err =3D _resctrl_online_domain(r, d);
> +       mutex_unlock(&rdtgroup_mutex);
> +
> +       return err;
> +}
> +
>  int resctrl_online_cpu(unsigned int cpu)
>  {
> -       lockdep_assert_held(&rdtgroup_mutex);
> -
> +       mutex_lock(&rdtgroup_mutex);
>         /* The cpu is set in default rdtgroup after online. */
>         cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +       mutex_unlock(&rdtgroup_mutex);
>
>         return 0;
>  }
> @@ -3753,8 +3802,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>         struct rdtgroup *rdtgrp;
>         struct rdt_resource *l3 =3D &rdt_resources_all[RDT_RESOURCE_L3].r=
_resctrl;
>
> -       lockdep_assert_held(&rdtgroup_mutex);
> -
> +       mutex_lock(&rdtgroup_mutex);
>         list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
>                 if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
>                         clear_childcpus(rdtgrp, cpu);
> @@ -3774,6 +3822,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>                         cqm_setup_limbo_handler(d, 0, cpu);
>                 }
>         }
> +       mutex_unlock(&rdtgroup_mutex);
>  }
>
>  /*
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index c4be3453b3ff..fe94ef3369fa 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -159,7 +159,7 @@ struct resctrl_schema;
>   * @cache_level:       Which cache level defines scope of this resource
>   * @cache:             Cache allocation related data
>   * @membw:             If the component has bandwidth controls, their pr=
operties.
> - * @domains:           All domains for this resource
> + * @domains:           RCU list of all domains for this resource
>   * @name:              Name to use in "schemata" file.
>   * @data_width:                Character width of data when displaying
>   * @default_ctrl:      Specifies default cache cbm or memory B/W percent=
.
> --
> 2.39.2
>
