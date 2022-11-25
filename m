Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC40638302
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKYEHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:07:18 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE2265
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 20:07:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VVdQFMm_1669349229;
Received: from 30.25.220.133(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VVdQFMm_1669349229)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 12:07:12 +0800
Message-ID: <7c889a9f-49b2-4d36-866a-4398d92dc763@linux.alibaba.com>
Date:   Fri, 25 Nov 2022 12:07:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        Jamie Iles <quic_jiles@quicinc.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com, peternewman@google.com
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-2-james.morse@arm.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20221021131204.5581-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/21 下午9:11, James Morse 写道:
> x86's RMID are independent of the CLOSID. An RMID can be allocated,
> used and freed without considering the CLOSID.
>
> MPAM's equivalent feature is PMG, which is not an independent number,
> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
> 'RMID' can be allocated for a single CLOSID.
> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
> monitor groups.
>
> To allow rescrl to disambiguate RMID values for different CLOSID,
> everything in resctrl that keeps an RMID value needs to know the CLOSID
> too. This will always be ignored on x86.
>
> Signed-off-by: James Morse <james.morse@arm.com>
>
> ---
> Is there a better term for 'the unique identifier for a monitor group'.
> Using RMID for that here may be confusing...
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 54 +++++++++++++----------
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++---
>   include/linux/resctrl.h                   | 11 ++++-
>   5 files changed, 49 insertions(+), 34 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5f7128686cfd..4b243ba88882 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -519,7 +519,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>   int closids_supported(void);
>   void closid_free(int closid);
>   int alloc_rmid(void);
> -void free_rmid(u32 rmid);
> +void free_rmid(u32 closid, u32 rmid);
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
>   void mon_event_count(void *info);
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..f1f66c9942a5 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -25,6 +25,7 @@
>   #include "internal.h"
>   
>   struct rmid_entry {
> +	u32				closid;

We had better add some comments there for closid variable.

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

>   	u32				rmid;
>   	int				busy;
>   	struct list_head		list;
> @@ -136,7 +137,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>   	return val;
>   }
>   
> -static inline struct rmid_entry *__rmid_entry(u32 rmid)
> +static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>   {
>   	struct rmid_entry *entry;
>   
> @@ -166,7 +167,8 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
>   }
>   
>   void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> -			     u32 rmid, enum resctrl_event_id eventid)
> +			     u32 closid, u32 rmid,
> +			     enum resctrl_event_id eventid)
>   {
>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>   	struct arch_mbm_state *am;
> @@ -185,7 +187,8 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>   }
>   
>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -251,9 +254,9 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   		if (nrmid >= r->num_rmid)
>   			break;
>   
> -		entry = __rmid_entry(nrmid);
> +		entry = __rmid_entry(~0, nrmid);	// temporary
>   
> -		if (resctrl_arch_rmid_read(r, d, entry->rmid,
> +		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>   					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>   			rmid_dirty = true;
>   		} else {
> @@ -308,7 +311,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	cpu = get_cpu();
>   	list_for_each_entry(d, &r->domains, list) {
>   		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(r, d, entry->rmid,
> +			err = resctrl_arch_rmid_read(r, d, entry->closid,
> +						     entry->rmid,
>   						     QOS_L3_OCCUP_EVENT_ID,
>   						     &val);
>   			if (err || val <= resctrl_rmid_realloc_threshold)
> @@ -332,7 +336,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   		list_add_tail(&entry->list, &rmid_free_lru);
>   }
>   
> -void free_rmid(u32 rmid)
> +void free_rmid(u32 closid, u32 rmid)
>   {
>   	struct rmid_entry *entry;
>   
> @@ -341,7 +345,7 @@ void free_rmid(u32 rmid)
>   
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
> -	entry = __rmid_entry(rmid);
> +	entry = __rmid_entry(closid, rmid);
>   
>   	if (is_llc_occupancy_enabled())
>   		add_rmid_to_limbo(entry);
> @@ -349,15 +353,16 @@ void free_rmid(u32 rmid)
>   		list_add_tail(&entry->list, &rmid_free_lru);
>   }
>   
> -static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> +static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   {
>   	struct mbm_state *m;
>   	u64 tval = 0;
>   
>   	if (rr->first)
> -		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> +		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>   
> -	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
> +	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> +					 &tval);
>   	if (rr->err)
>   		return rr->err;
>   
> @@ -400,7 +405,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>    * __mon_event_count() is compared with the chunks value from the previous
>    * invocation. This must be called once per second to maintain values in MBps.
>    */
> -static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> +static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   {
>   	struct mbm_state *m = &rr->d->mbm_local[rmid];
>   	u64 cur_bw, bytes, cur_bytes;
> @@ -430,7 +435,7 @@ void mon_event_count(void *info)
>   
>   	rdtgrp = rr->rgrp;
>   
> -	ret = __mon_event_count(rdtgrp->mon.rmid, rr);
> +	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
>   
>   	/*
>   	 * For Ctrl groups read data from child monitor groups and
> @@ -441,7 +446,8 @@ void mon_event_count(void *info)
>   
>   	if (rdtgrp->type == RDTCTRL_GROUP) {
>   		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->mon.rmid, rr) == 0)
> +			if (__mon_event_count(rdtgrp->closid, entry->mon.rmid,
> +					      rr) == 0)
>   				ret = 0;
>   		}
>   	}
> @@ -571,7 +577,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	}
>   }
>   
> -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
> +static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
> +		       u32 closid, u32 rmid)
>   {
>   	struct rmid_read rr;
>   
> @@ -586,12 +593,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   	if (is_mbm_total_enabled()) {
>   		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>   		rr.val = 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>   	}
>   	if (is_mbm_local_enabled()) {
>   		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>   		rr.val = 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>   
>   		/*
>   		 * Call the MBA software controller only for the
> @@ -599,7 +606,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   		 * the software controller explicitly.
>   		 */
>   		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
> +			mbm_bw_count(closid, rmid, &rr);
>   	}
>   }
>   
> @@ -656,11 +663,11 @@ void mbm_handle_overflow(struct work_struct *work)
>   	d = container_of(work, struct rdt_domain, mbm_over.work);
>   
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
>   
>   		head = &prgrp->mon.crdtgrp_list;
>   		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
>   
>   		if (is_mba_sc(NULL))
>   			update_mba_bw(prgrp, d);
> @@ -703,10 +710,11 @@ static int dom_data_init(struct rdt_resource *r)
>   	}
>   
>   	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> +	 * RMID 0 is special and is always allocated. It's used for the
> +	 * default_rdtgroup control group, which will be setup later. See
> +	 * rdtgroup_setup_root().
>   	 */
> -	entry = __rmid_entry(0);
> +	entry = __rmid_entry(0, 0);
>   	list_del(&entry->list);
>   
>   	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index d961ae3ed96e..4d3706f71ee3 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -738,7 +738,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>   	 * anymore when this group would be used for pseudo-locking. This
>   	 * is safe to call on platforms not capable of monitoring.
>   	 */
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	ret = 0;
>   	goto out;
> @@ -773,7 +773,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>   
>   	ret = rdtgroup_locksetup_user_restore(rdtgrp);
>   	if (ret) {
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   		return ret;
>   	}
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..f3b739c52e42 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2422,7 +2422,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>   
>   	head = &rdtgrp->mon.crdtgrp_list;
>   	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> -		free_rmid(sentry->mon.rmid);
> +		free_rmid(sentry->closid, sentry->mon.rmid);
>   		list_del(&sentry->mon.crdtgrp_list);
>   
>   		if (atomic_read(&sentry->waitcount) != 0)
> @@ -2462,7 +2462,7 @@ static void rmdir_all_sub(void)
>   		cpumask_or(&rdtgroup_default.cpu_mask,
>   			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>   
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   		kernfs_remove(rdtgrp->kn);
>   		list_del(&rdtgrp->rdtgroup_list);
> @@ -2955,7 +2955,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   	return 0;
>   
>   out_idfree:
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   out_destroy:
>   	kernfs_put(rdtgrp->kn);
>   	kernfs_remove(rdtgrp->kn);
> @@ -2969,7 +2969,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>   {
>   	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->mon.rmid);
> +	free_rmid(rgrp->closid, rgrp->mon.rmid);
>   	rdtgroup_remove(rgrp);
>   }
>   
> @@ -3118,7 +3118,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	update_closid_rmid(tmpmask, NULL);
>   
>   	rdtgrp->flags = RDT_DELETED;
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	/*
>   	 * Remove the rdtgrp from the parent ctrl_mon group's list
> @@ -3164,8 +3164,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>   	update_closid_rmid(tmpmask, NULL);
>   
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   	closid_free(rdtgrp->closid);
> -	free_rmid(rdtgrp->mon.rmid);
>   
>   	rdtgroup_ctrl_remove(rdtgrp);
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 0cf5b20c6ddf..641aea580a1f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -225,6 +225,8 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    *			      for this resource and domain.
>    * @r:			resource that the counter should be read from.
>    * @d:			domain that the counter should be read from.
> + * @closid:		closid that matches the rmid. The counter may
> + *			match traffic of both closid and rmid, or rmid only.
>    * @rmid:		rmid of the counter to read.
>    * @eventid:		eventid to read, e.g. L3 occupancy.
>    * @val:		result of the counter read in bytes.
> @@ -235,20 +237,25 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    * 0 on success, or -EIO, -EINVAL etc on error.
>    */
>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val);
> +
>   
>   /**
>    * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
>    *			       and eventid.
>    * @r:		The domain's resource.
>    * @d:		The rmid's domain.
> + * @closid:	The closid that matches the rmid. Counters may match both
> + *		closid and rmid, or rmid only.
>    * @rmid:	The rmid whose counter values should be reset.
>    * @eventid:	The eventid whose counter values should be reset.
>    *
>    * This can be called from any CPU.
>    */
>   void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> -			     u32 rmid, enum resctrl_event_id eventid);
> +			     u32 closid, u32 rmid,
> +			     enum resctrl_event_id eventid);
>   
>   extern unsigned int resctrl_rmid_realloc_threshold;
>   extern unsigned int resctrl_rmid_realloc_limit;

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

