Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0AC708C93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjESAAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjESAAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:00:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E57EA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454439; x=1715990439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6P4k9NSWAM5cUfTH2rivkZplBzli7wzXPb3Fsq7Lqt8=;
  b=g3+cDp+w4CA3iKAkOS6ZMVfzEq8QEj2T3MBO4Vb8B6D5HnrjPb2oTCEI
   NGFPKpvWM6y3nL2y8YSvo8JkcrUVAjV8/yYZtcYw9JpwoG5zx6KxD5cy5
   d8wCpTOFtulG7zo+diGNTS3jyDuYmbTQ5xW2IbrV00EhSTqz36ugb1Jn6
   ttbqJY3X47QEresj7kPmtYORJ/VhchJVvCCOYPV2/0DLGpGT1ZCEyIgMi
   a1kVVuM55HDE5glG/8GVg9nJBbsaG0TVdT5m2n9TNQTql5kiECwEgERcF
   yuvKerW/NMncKt8vuj4AH9FGXN3hKr48QNn9lMxJoMq+mSrCzqrTpNKYZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351067124"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="351067124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735299611"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="735299611"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2023 17:00:38 -0700
Date:   Thu, 18 May 2023 17:03:35 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
Message-ID: <20230519000335.GB24449@ranerica-svr.sc.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
 <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
 <de79bd2c-42cb-23f2-a951-5a5caab0bacf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de79bd2c-42cb-23f2-a951-5a5caab0bacf@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:53:48PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 4/29/23 9:02 PM, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 01:31:36PM -0700, Ricardo Neri wrote:
> >> Hi,
> >>
> >> This is v4 of this series. Previous versions can be found here [1], [2],
> >> and here [3]. To avoid duplication, I do not include the cover letter of
> >> the original submission. You can read it in [1].
> >>
> >> This patchset applies cleanly on today's master branch of the tip tree.
> >>
> >> Changes since v3:
> >>
> >> Nobody liked the proposed changes to the setting of prefer_sibling.
> >> Instead, I tweaked the solution that Dietmar proposed. Now the busiest
> >> group, not the local group, determines the setting of prefer_sibling.
> >>
> >> Vincent suggested improvements to the logic to decide whether to follow
> >> asym_packing priorities. Peter suggested to wrap that in a helper function.
> >> I added sched_use_asym_prio().
> >>
> >> Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
> >> rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
> >> does not assume that all child domains have the requested flag.
> >>
> >> Tim found that asym_active_balance() needs to also check for the idle
> >> states of the SMT siblings of lb_env::dst_cpu. I added such check.
> >>
> >> I wrongly assumed that asym_packing could only be used when the busiest
> >> group had exactly one busy CPU. This broke asym_packing balancing at the
> >> DIE domain. I limited this check to balances between cores at the MC
> >> level.
> >>
> >> As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks()
> >> and placed its logic in sched_asym(). Also, sched_asym() uses
> >> sched_smt_active() to skip checks when not needed.
> >>
> >> I also added a patch from Chen Yu to enable asym_packing balancing in
> >> Meteor Lake, which has CPUs of different maximum frequency in more than
> >> one die.
> > 
> > Is the actual topology of Meteor Lake already public? This patch made me
> > wonder if we need SCHED_CLUSTER topology in the hybrid_topology thing,
> > but I can't remember (one of the raisins why the endless calls are such
> > a frigging waste of time) and I can't seem to find the answer using
> > Google either.
> > 
> >> Hopefully, these patches are in sufficiently good shape to be merged?
> > 
> > Changelogs are very sparse towards the end and I had to reverse engineer
> > some of it which is a shame. But yeah, on a first reading the code looks
> > mostly ok. Specifically 8-10 had me WTF a bit and only at 11 did it
> > start to make a little sense. Mostly they utterly fail to answer the
> > very fundament "why did you do this" question.
> > 
> > Also, you seem to have forgotten to Cc our friends from IBM such that
> > they might verify you didn't break their Power7 stuff -- or do you have
> > a Power7 yourself to verify and forgot to mention that?
> 
> Very good patch series in addressing asym packing. Interesting discussions as
> well. Took me quite sometime to get through to understand and do a little bit
> of testing.
> 
> Tested this patch a bit on power7 with qemu. Tested with SMT=4. sched domains
> show ASYM_PACKING present only for SMT domain.
> 
> We don't see any regressions/gain due to patch. SMT priorities are honored when
> tasks are scheduled and load_balanced.

Thank you very much for your review and testing! Would you mind sharing the
qemu command you use? I would like to test my future patches on power7.

BR,
Ricardo
