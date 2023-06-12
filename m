Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD872D053
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjFLURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFLURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:17:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780511BF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686601015; x=1718137015;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jJcLMAcSmqVtvgK1Jq9rsW+3+3BxRpUOu7dfbaj6WLw=;
  b=bZMi5fel2G9HcR9lbvgucvLpBOA2MSoehIyF6BMhUpkeXOSup5a/Rk/q
   0azwsXYAZ1krWAFsB7MkIelk3GpPlCYktZoXPnLGSzQnEQbrd6cDIedl9
   oJ+gH0h5DxV1SRaURAv1nODTKFeVeJmhDwwoAmj+R0eEMU1QjxPb51/ZX
   KvmWyygL2eHHlsyS+auiYBFOBkB2vH1AzgN8hIxICYBWtIg44J8N2yxw/
   Qp5dLgTa/dpPneC+KWw/qGzk7sf3hBYqoIxEwzENv/kHuUHaMi1sbdEgf
   ZzdS2MRI35xjA7hf6yn5K4iKpDEkSnh/gLWGHUrBuHODyGmuojFePtJA8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361516777"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="361516777"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041479391"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="1041479391"
Received: from fwbrewes-mobl.amr.corp.intel.com (HELO [10.255.230.147]) ([10.255.230.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:16:53 -0700
Message-ID: <f493a770e15a81aaad2e13d8afe1daf939b8267a.camel@linux.intel.com>
Subject: Re: [Patch v2 2/6] sched/topology: Record number of cores in sched
 group
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
Date:   Mon, 12 Jun 2023 13:16:52 -0700
In-Reply-To: <20230612112945.GK4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
         <a8acc91631a1c044ee16081bc80c1b044827c7b2.1686263351.git.tim.c.chen@linux.intel.com>
         <20230612112945.GK4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-12 at 13:29 +0200, Peter Zijlstra wrote:
> On Thu, Jun 08, 2023 at 03:32:28PM -0700, Tim Chen wrote:
> >=20
> >  		sg->group_weight =3D cpumask_weight(sched_group_span(sg));
> > =20
> > +		cpumask_copy(mask, sched_group_span(sg));
> > +		for_each_cpu(cpu, mask) {
> > +			cores++;
> > +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
> > +		}
> > +		sg->cores =3D cores;
> > +
> >  		if (!(sd->flags & SD_ASYM_PACKING))
> >  			goto next;
>=20
> Just a note; not sure we want or can do anything about this, but
> consider someone doing partitions like:
>=20
> 	[0,1] [2,3] [3,6]
> 	[------] [------]
>=20
> That is, 3 SMT cores, and 2 partitions splitting an SMT core in two.
>=20
> Then the domain trees will see either 2 or 3 but not the fully core.
>=20
> I'm perfectly fine with saying: don't do that then.

I also can't see a reason to split SMT between two domains.

Tim
