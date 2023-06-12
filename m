Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCA72D03D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjFLUMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjFLUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:12:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E51B4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686600748; x=1718136748;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QOA2isvCKOWOA1WSnCIQ1SVooDORDWrcDc1dFgH63Uc=;
  b=Ac/ZYmibyTfbQ5L9oZG37DoGeQgerFTSFoCi5t0sUnq4f6IY1cf+VFvz
   7CS+cbPYM64EtQ2vR6hgVoC5wTb9ni8vtP38YO1iXl5fOjPwjNL6IBYrF
   /2V85oaybNgIYOvWUmtSsYUX+GDnAy2SEo1CeqBBsgZX+HcxisCyvLtQr
   dmoP68zoMBiwb54Tx96ivOk4Vvs8gyKhBfyFYVt/yKzK7eck/bl5Ri4xv
   HGtSRn6WTGxSJAxMUdeTofvN0Re++Z1E8dtJguyNA1+ydko9iTBsws6wg
   uI1Oq4fFkFtLbgxCgouqOCs1uKKk5/83NjMx2UaUJ5kSXLjKhIc48cGkt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="357037937"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="357037937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835615986"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835615986"
Received: from fwbrewes-mobl.amr.corp.intel.com (HELO [10.255.230.147]) ([10.255.230.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:12:10 -0700
Message-ID: <f7dc49b5fb80b25ad1f3968a623f993da29c0526.camel@linux.intel.com>
Subject: Re: [Patch v2 1/6] sched/fair: Determine active load balance for
 SMT sched groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Date:   Mon, 12 Jun 2023 13:12:10 -0700
In-Reply-To: <20230612111359.GI4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
         <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
         <20230612111359.GI4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-12 at 13:13 +0200, Peter Zijlstra wrote:
>=20
>=20
>=20
> > @@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct lb_env=
 *env,
> >  		break;
> > =20
> >  	case group_has_spare:
> > +		/*
> > +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
> > +		 * as we do not want to pull task off half empty SMT core
> > +		 * and make the core idle.
> > +		 */
> > +		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> > +			if (sg->flags & SD_SHARE_CPUCAPACITY)
> > +				return false;
> > +			else
> > +				return true;
> > +		}
>=20
> However, here I'm not at all sure. Consider SMT-4 with 2 active CPUs, we
> still very much would like to pull one task off if we have an idle core
> somewhere, no?
>=20

How about making this modification to take care of SMT-4 case?

Tim

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33246dce10db..e2261c24e536 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9642,11 +9642,11 @@ static bool update_sd_pick_busiest(struct lb_env *e=
nv,
        case group_has_spare:
                /*
                 * Do not pick sg with SMT CPUs over sg with pure CPUs,
-                * as we do not want to pull task off half empty SMT core
+                * as we do not want to pull task off SMT core with one tas=
k
                 * and make the core idle.
                 */
                if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
-                       if (sg->flags & SD_SHARE_CPUCAPACITY)
+                       if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_=
nr_running <=3D 1)
                                return false;
                        else
                                return true;

	=09
