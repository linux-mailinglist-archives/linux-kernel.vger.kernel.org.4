Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365F72EA37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjFMRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:47:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34013E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686678461; x=1718214461;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=moJn4Wg/QkVVRa5xXN16iaIWdvxmWOJHmMLub2pzT1k=;
  b=d/8fjFgAHBqbLSPDgJa3IGcGGWFmam2pAoYHUcgZPI2qeXtmwezONOxv
   lQrJWoex/wj1w5De55QO//5ZesGHKOiy4wwnNwxBwyieG03GiSfVgSVxD
   vLsX/fWXKbDVAwIF8nzHZYkUqGE/vCS+L9qTmz4P6CWXbagMyOGmQcGTg
   q6Xn52cv6LYk43ZlZ59DaxAN7iaz/8DoioOmnjRdg97SgFQPe2LjtPpvz
   kb2TIO3nJjh2vArRAXZqMc1aJirpu2oK6GzRQtdZOgJ0k2c/OjZfP7poD
   etXaR3vxzB7iDrCrNxLeJ06iK1XNWJcSeRRjSeXyGcL0ghYnL304U7CfR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355908277"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355908277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 10:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711741019"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711741019"
Received: from srekam-mobl.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 10:46:37 -0700
Message-ID: <321a474bfa562164a56f504144d6b33eb2f7acbd.camel@linux.intel.com>
Subject: Re: [Patch v2 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
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
Date:   Tue, 13 Jun 2023 10:46:36 -0700
In-Reply-To: <20230612120528.GL4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
         <ef2400ea29f0e00aed1e2d75c1a352e63349059e.1686263351.git.tim.c.chen@linux.intel.com>
         <20230612120528.GL4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-12 at 14:05 +0200, Peter Zijlstra wrote:
> On Thu, Jun 08, 2023 at 03:32:29PM -0700, Tim Chen wrote:
>=20
> >=20
> > +	if (env->sd->flags & SD_ASYM_PACKING) {
> > +		int limit;
> > +
> > +		if (!busiest->sum_nr_running)
> > +			goto out;
>=20
> This seems out-of-place, shouldn't we have terminate sooner if busiest
> is empty?

Yes.  Should move this check to the beginning.

>=20
> > +
> > +		if (sched_asym_prefer(env->dst_cpu, sds->busiest->asym_prefer_cpu)) =
{
> > +			/* Don't leave preferred core idle */
> > +			if (imbalance =3D=3D 0 && local->sum_nr_running < ncores_local)
> > +				imbalance =3D 1;
> > +			goto out;
> > +		}
> > +
> > +		/* Limit tasks moved from preferred group, don't leave cores idle */
> > +		limit =3D busiest->sum_nr_running;
> > +		lsub_positive(&limit, ncores_busiest);
> > +		if (imbalance > limit)
> > +			imbalance =3D limit;
>=20
> How does this affect the server parts that have larger than single core
> turbo domains?

Are you thinking about the case where the local group is completely empty
so there's turbo headroom and we should move at least one task, even though
CPU in busiest group has higher priority?

In other words, are you suggesting we should add

		if (imbalance =3D=3D 0 && busiest->sum_nr_running > 0 &&
			local->sum_nr_running =3D=3D 0)
			imbalance =3D 1;
	=09

>=20
> > +
> > +		goto out;
> > +	}
> > +
> > +	/* Take advantage of resource in an empty sched group */
> > +	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > +	    busiest->sum_nr_running > 1)
> > +		imbalance =3D 1;
> > +out:
> > +	return imbalance << 1;
> > +}
>=20
>=20
> But basically you have:
>=20
>         LcBn - BcLn
>   imb =3D -----------
>            LcBc
>=20
> Which makes sense, except you then return:
>=20
>   imb * 2
>=20
> which then made me wonder about rounding.
>=20
> Do we want to to add (LcBc -1) or (LcBc/2) to resp. ceil() or round()
> the thing before division? Because currently it uses floor().
>=20
> If you evaludate it like:
>=20
>=20
>         2 * (LcBn - BcLn)
>   imb =3D -----------------
>               LcBc
>=20
> The result is different from what you have now.

If I do the rounding after multiplying imb by two (call it imb_new),
the difference with imb I am returning now (call it imb_old)
will be at most 1.  Note that imb_old returned is always a multiple of 2.

I will be using imb in calculate_imbalance() and divide it
by 2 there to get the number tasks to move from busiest group.
So when there is a difference of 1 between imb_old and imb_new,
the difference will be trimmed off after the division of 2.

We will get the same number of tasks to move with either
imb_old or imb_new in calculate_imbalance() so the two
computations will arrive at the same result eventually.

>=20
> What actual behaviour is desired in these low imbalance cases? and can
> you write a comment as to why we do as we do etc..?

I do not keep imb as=20

           2 * (LcBn - BcLn)
   imb =3D -----------------
               LcBc

as it is easier to leave out the factor of 2
in the middle of sibling_imblalance() computation
so I can directly interpret imb as the number
of tasks to move, and add the factor of two
when I actually need to return the imbalance.

Would you like me to add this reasoning in the comments?

Thanks.

Tim =20

