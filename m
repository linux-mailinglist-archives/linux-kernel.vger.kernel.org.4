Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF56F35D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEASag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEASad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:30:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574EF12F
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682965832; x=1714501832;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kDbTngYnDmxyk2j9AFPm3Yqf919swPFUZIz4mggbY/c=;
  b=TQ2eZxVaggHZhjhAsk9zuXL3HDVcQZ9TVpi6uxAmGO6ZBcFZkcSz3BJO
   xLMCfPXLcuPSKxhCwsQmQvxJOSvsNvrF4LrKPCmKC7H3hPNwtiVHy2xHq
   8d5G4bi+3GDM7F972nbKfTSH6d2vtqdVE17/ZYSTqaGtp1l+NZKBAVz+4
   /gZaJ/PSJtQtSodAiMCtyE5qaVmaKimav5bKXsTt0kfGkbh6RQbebKpkd
   KGV+C/FYWKxUV+Xkd1WEMcRlTi1xWEe+XRWGBVKMZNifCVDrleu5NbVpK
   Uvg6Es7RO8V5IyM5T/C0WbAHPBDxrObtgt/IeUJmlEJFhZsKgv/AjE6Nj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="434525316"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="434525316"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 11:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="698628778"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="698628778"
Received: from srhill-mobl.amr.corp.intel.com (HELO [10.209.46.108]) ([10.209.46.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 11:30:30 -0700
Message-ID: <95c4ad1bdc6bed0278329994bb4f6a9203f0e1c3.camel@linux.intel.com>
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com
Date:   Mon, 01 May 2023 11:30:21 -0700
In-Reply-To: <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
         <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-04-29 at 17:32 +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 01:31:36PM -0700, Ricardo Neri wrote:
> > Hi,
> >=20
> > This is v4 of this series. Previous versions can be found here [1], [2]=
,
> > and here [3]. To avoid duplication, I do not include the cover letter o=
f
> > the original submission. You can read it in [1].
> >=20
> > This patchset applies cleanly on today's master branch of the tip tree.
> >=20
> > Changes since v3:
> >=20
> > Nobody liked the proposed changes to the setting of prefer_sibling.
> > Instead, I tweaked the solution that Dietmar proposed. Now the busiest
> > group, not the local group, determines the setting of prefer_sibling.
> >=20
> > Vincent suggested improvements to the logic to decide whether to follow
> > asym_packing priorities. Peter suggested to wrap that in a helper funct=
ion.
> > I added sched_use_asym_prio().
> >=20
> > Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
> > rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
> > does not assume that all child domains have the requested flag.
> >=20
> > Tim found that asym_active_balance() needs to also check for the idle
> > states of the SMT siblings of lb_env::dst_cpu. I added such check.
> >=20
> > I wrongly assumed that asym_packing could only be used when the busiest
> > group had exactly one busy CPU. This broke asym_packing balancing at th=
e
> > DIE domain. I limited this check to balances between cores at the MC
> > level.
> >=20
> > As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks=
()
> > and placed its logic in sched_asym(). Also, sched_asym() uses
> > sched_smt_active() to skip checks when not needed.
> >=20
> > I also added a patch from Chen Yu to enable asym_packing balancing in
> > Meteor Lake, which has CPUs of different maximum frequency in more than
> > one die.
>=20
> Is the actual topology of Meteor Lake already public? This patch made me
> wonder if we need SCHED_CLUSTER topology in the hybrid_topology thing,
> but I can't remember (one of the raisins why the endless calls are such
> a frigging waste of time) and I can't seem to find the answer using
> Google either.

There are a bunch of fixes that are needed for SCHED_CLUSTER to work
properly on hybrid_topology.  I'll clean them up and post them on
top of Ricardo's current patch set this week.

Tim

>=20
> > Hopefully, these patches are in sufficiently good shape to be merged?

