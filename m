Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9B6F8C6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEEWgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEEWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:36:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43363C1E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683326208; x=1714862208;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yrUrHGAR08VCKx2XjxffWEn1i/3fncQpBJAbR6qGobY=;
  b=kwhHjYshW0rqZrQShwho7JrR5i2BsIlVjj9ZXpX2YdbbKDj7sO9XC1of
   T/wJdKV+39RxuyS2i81k5SrAn/59PsKNNVsEI7HOGu0LdUZkFPsTzAWrV
   lkLOvT0pGAM/fHWOsTKc8H4TsFYYU5+44Z1kmXqmKWEy8EvGqzJ7MpPL2
   e0f/HuEgodkqkNe+DuvYIDrHKL03jsIk52GwHII84ux+ssGe3madARZA6
   z6up0NMC7H1s1gwys0WA5bd471ncxfxw9AXRAi8wx6GAP1oHJHFgobxu0
   stfrCpoAJ2dSnD6O36FM7I20ml3UW+jXbSgTFycOz+xcbzWuljUVMo1+J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="328931679"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="328931679"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="787321063"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="787321063"
Received: from rmarepal-mobl3.amr.corp.intel.com (HELO [10.255.231.148]) ([10.255.231.148])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:36:47 -0700
Message-ID: <1ac1f37ecccb23ec6abe07ef6a95fc1d61921436.camel@linux.intel.com>
Subject: Re: [PATCH 3/6] sched/fair: Fix busiest group selection for asym
 groups
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 05 May 2023 15:36:47 -0700
In-Reply-To: <20230505131903.GP83892@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
         <2e2e6844fb3ed28594d86c5e45295df7c4335c08.1683156492.git.tim.c.chen@linux.intel.com>
         <20230505131903.GP83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-05 at 15:19 +0200, Peter Zijlstra wrote:
>=20
> > =20
> >  	case group_has_spare:
> > +		/*
> > +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
> > +		 * as we do not want to pull task off half empty SMT core
> > +		 * and make the core idle.
> > +		 */
>=20
> Comment says what the code does; not why.

Good point, will make the comment better.

>=20
> > +		if (asymmetric_groups(sds->busiest, sg)) {
> > +			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
> > +				return true;
> > +			else
> > +				return false;
>=20
> 			return (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
> > +		}
>=20
> Also, should this not be part of the previous patch?

Sure, I can merge it with the previous patch.

Tim

