Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6DA6E7A28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjDSM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjDSM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:58:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716959D7;
        Wed, 19 Apr 2023 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681909119; x=1713445119;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kHCtTrMakUKm93V29cpT/FOERYkY1HGbzu5MDvGCI4Y=;
  b=SCnx0qRHJ1gxVdo45Fa7gJYIZqVDeBSNi+wJC/q0V4Bm9vINBMe2GsUl
   SlfcUUxKAMRYGE8V55Ob0Tk6ZSz7ZCJ1TKxB5fhlvlC2l3AsSdEpusEGM
   ybJMkorJXCDoUulDCaPL0p+AjLOzgEa4Kn/a8/9QkEzA+ZDBUYphsIqmW
   9sIQhm9GsyFZQTBE+4vxNqxFFZVw2QVjuCwCAGOlIKOLRQppyoYMfpkEn
   ljeY56XOWodGsbJ41PlROnBydbHdMUesmA6MWuviicf5bpHojNYINYuhz
   Bfsj+vu0shj33KysIjtgSF8F/BR+ILXyfZ6YOKdVoSiiLzZPUXCtgJsLL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344189324"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="344189324"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="802912479"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="802912479"
Received: from hbourgeo-mobl2.ger.corp.intel.com ([10.249.34.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 05:58:30 -0700
Date:   Wed, 19 Apr 2023 15:58:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, pawan.kumar.gupta@linux.intel.com,
        jarkko@kernel.org, adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
In-Reply-To: <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
Message-ID: <d046eebf-15b-2d23-b8f6-5dd06b49d0d3@linux.intel.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu> <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Babu Moger wrote:

> The resctrl task assignment for MONITOR or CONTROL group needs to be
> done one at a time. For example:
> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/clos1
>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>   $echo 789 > /sys/fs/resctrl/clos1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> It can be improved by supporting the multiple task id assignment in
> one command with the tasks separated by commas. For example:
> 
>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |    9 ++++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 ++++++++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 387ccbcb558f..f28ed1443a6a 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -292,7 +292,14 @@ All groups contain the following files:
>  "tasks":
>  	Reading this file shows the list of all tasks that belong to
>  	this group. Writing a task id to the file will add a task to the
> -	group. If the group is a CTRL_MON group the task is removed from
> +	group. Multiple tasks can be added by separating the task ids
> +	with commas. Tasks will be assigned sequentially in the order it
> +	is entered.

"Tasks ... it is ..." doesn't sound correct.

> Failures while assigning the tasks will be aborted
> +	immediately and tasks next in the sequence will not be assigned.
> +	Users may need to retry them again. Failure details possibly with
> +	pid will be logged in /sys/fs/resctrl/info/last_cmd_status file.
> +
> +	If the group is a CTRL_MON group the task is removed from
>  	whichever previous CTRL_MON group owned the task and also from
>  	any MON group that owned the task. If the group is a MON group,
>  	then the task must already belong to the CTRL_MON parent of this
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6ad33f355861..df5bd13440b0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -696,18 +696,41 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  				    char *buf, size_t nbytes, loff_t off)
>  {
>  	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>  	int ret = 0;
>  	pid_t pid;
>  
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> +	if (nbytes == 0)
>  		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
>  		return -ENOENT;
>  	}
> +
> +next:
> +	if (!buf || buf[0] == '\0')
> +		goto unlock;
> +
>  	rdt_last_cmd_clear();
>  
> +	pid_str = strim(strsep(&buf, ","));
> +
> +	if (kstrtoint(pid_str, 0, &pid)) {
> +		rdt_last_cmd_printf("Task list parsing error\n");
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	if (pid < 0) {
> +		rdt_last_cmd_printf("Invalid pid %d value\n", pid);
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>  	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = -EINVAL;
> @@ -716,6 +739,12 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  	}
>  
>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +	if (ret) {
> +		rdt_last_cmd_printf("Error while processing task %d\n", pid);
> +		goto unlock;
> +	} else {
> +		goto next;
> +	}

Why is this not changed into a while () loop??

>  
>  unlock:
>  	rdtgroup_kn_unlock(of->kn);
> 
> 


-- 
 i.

