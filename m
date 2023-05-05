Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A16F8C8B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjEEWvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjEEWvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:51:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF0A527E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683327097; x=1714863097;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MLjQ9s2IYfiXfAtWDLAFaH8aZnQga2eI5OjXYPJ03XI=;
  b=WcZLCkkMESJ7xGpsmoF4wHXsKQozaeXJnj92J6k3mEXr+Xg6qjf9VPGB
   Zz4XhCT1lFDTVdD8BKyxtFWGRlaO0PWxhD9ruE27qJW/gxZm+azhSw1gd
   i3Wb3krd9Sl3lYB+qFeXlz2p6nl4Yo7YBU+3eK+sQTfbTX5tR+KwdODg2
   YanNmEXLrD+Vcze1N9/Omiy8ZmmqzjkUvGOPpvp6M3N4zTUZa44odsmnn
   nYrDKG/TiTvesa3YAvv4H7uwlLZmSFAeMqfjQkXwq28AP9A+4LrfEn8tW
   Tbj48tHpcS+l2HxQXt1A89vPiA2wnRtKR2+SRkLvKjl290oa7VCB3GlVK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="352363531"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="352363531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="809444087"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="809444087"
Received: from rmarepal-mobl3.amr.corp.intel.com (HELO [10.255.231.148]) ([10.255.231.148])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:51:35 -0700
Message-ID: <4dd1d0f44fc4ae9d7b1b918fd4aeb52601669ace.camel@linux.intel.com>
Subject: Re: [PATCH 5/6] sched/fair: Consider the idle state of the whole
 core for load balance
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Barry Song <v-songbaohua@oppo.com>
Date:   Fri, 05 May 2023 15:51:35 -0700
In-Reply-To: <20230505132347.GR83892@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
         <849d3fee51d218de71ecc9d557667ff6b137ac2d.1683156492.git.tim.c.chen@linux.intel.com>
         <20230505132347.GR83892@hirez.programming.kicks-ass.net>
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

On Fri, 2023-05-05 at 15:23 +0200, Peter Zijlstra wrote:
> On Thu, May 04, 2023 at 09:09:55AM -0700, Tim Chen wrote:
>=20
> > @@ -10709,11 +10709,26 @@ static int should_we_balance(struct lb_env *e=
nv)
> >  	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
> >  		if (!idle_cpu(cpu))
> >  			continue;
> > +		else {
> > +			/*
> > +			 * Don't balance to idle SMT in busy core right away when
> > +			 * balancing cores, but remember the first idle SMT CPU for
> > +			 * later consideration.  Find CPU on an idle core first.
> > +			 */
> > +			if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu))=
 {
> > +				if (idle_smt =3D=3D -1)
> > +					idle_smt =3D cpu;
> > +				continue;
> > +			}
> > +		}
>=20
> Not only does that bust CodingStyle, it's also entirely daft. What
> exactly is the purpose of that else statement?
>=20
>=20

Yeah, that's a dumb "else" statement.  Will remove that.

Tim
