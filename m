Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E435731E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjFORCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjFORCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:02:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477A172A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686848531; x=1718384531;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dZZc8ZA+/eouhi6cyg7O0IFts/GOA/u2pZXopn0aCmY=;
  b=ATCdmPYqaWtAI7k7Cx5DJFE7W79iKbFD6YrlumhWhT+N+mq+Ydn5ExG1
   AT8IpjidBo3sNzAb1kM7n+sS2RTfUf+cWATEMnNnZmKV9mbMcToSuOptM
   /nkLXuTjihteMGniLqttKosjikLeVDSp/a4yiOFf1kZGi9bSvDiNBojz8
   3pbGoGb/S27sYF7iHQWvrAfBOAtPQ5MSk+3siIOGij8ZJQisN3QDUHXqm
   8NMbq0hFXncGqIDhLV5uPmz+3sc0lLVgV1X5bAvtxmkR/rcofO9snPTju
   2JbotzzFzZVc3a3wLChCSdmT8FfYOINGPlmAP8j4tnUKiYZCVP2Rt/9Ky
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="358974446"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="358974446"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689853548"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689853548"
Received: from izuyev-mobl.amr.corp.intel.com (HELO [10.212.240.92]) ([10.212.240.92])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:01:44 -0700
Message-ID: <5c6d48a26a805b3f3b4cee440b902211da3011b0.camel@linux.intel.com>
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
Date:   Thu, 15 Jun 2023 10:01:44 -0700
In-Reply-To: <20230615110730.GA1693932@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
         <ef2400ea29f0e00aed1e2d75c1a352e63349059e.1686263351.git.tim.c.chen@linux.intel.com>
         <20230612120528.GL4253@hirez.programming.kicks-ass.net>
         <321a474bfa562164a56f504144d6b33eb2f7acbd.camel@linux.intel.com>
         <20230615110730.GA1693932@hirez.programming.kicks-ass.net>
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

On Thu, 2023-06-15 at 13:07 +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 10:46:36AM -0700, Tim Chen wrote:
> > On Mon, 2023-06-12 at 14:05 +0200, Peter Zijlstra wrote:
>=20
> > > > +		/* Limit tasks moved from preferred group, don't leave cores idl=
e */
> > > > +		limit =3D busiest->sum_nr_running;
> > > > +		lsub_positive(&limit, ncores_busiest);
> > > > +		if (imbalance > limit)
> > > > +			imbalance =3D limit;
> > >=20
> > > How does this affect the server parts that have larger than single co=
re
> > > turbo domains?
> >=20
> > Are you thinking about the case where the local group is completely emp=
ty
> > so there's turbo headroom and we should move at least one task, even th=
ough
> > CPU in busiest group has higher priority?
>=20
> Something along those lines, I didn't think it through, just wondered
> about the wisdom of piling everything in the highest priority 'domain',
> which would depress the turbo range.
>=20
> Rjw said that on modern client the frequency domains are per-core, but
> that on server parts they are still wider -- or something long those
> lines. So it might make sense to consider some of that.
>=20

I see what you are saying. In that case, even for ASYM_PACKING, it probably
makes more sense to simply distribute tasks in proportion to number of core=
s
in sched group.  And pay attention that we do not let preferred sched group
be idle.=20

>=20
> > In other words, are you suggesting we should add
> >=20
> > 		if (imbalance =3D=3D 0 && busiest->sum_nr_running > 0 &&
> > 			local->sum_nr_running =3D=3D 0)
> > 			imbalance =3D 1;
>=20
> I didn't get that far; and I don't think we have the right topology
> information on the servers to even begin considering the effects of the
> turbo-range, so perhaps it all doesn't matter.
>=20
> Just wanted to raise the point for consideration.
>=20
> Because as-is, the policy of piling extra on the preferred group doesn't
> immediately make sense. IIRC the whole ITMT preferred core is mostly
> about an extra turbo bin, but if you pile on, the headroom evaporates --
> you'll never turbo that high anymore and special casing it doesn't make
> sense.
>=20
> So perhaps I'm not saying more code, but less code is better here.
>=20
> Dunno, is any of this measurable either way around?

As far as I know, only client CPUs have ITMT and asymmetric turbo.
So this behavior could only be approximated on a client's Atom clusters wit=
h
big cores turned off. =20

>=20
> > > > +
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	/* Take advantage of resource in an empty sched group */
> > > > +	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > > > +	    busiest->sum_nr_running > 1)
> > > > +		imbalance =3D 1;
> > > > +out:
> > > > +	return imbalance << 1;
> > > > +}
> > >=20
> > >=20
> > > But basically you have:
> > >=20
> > >         LcBn - BcLn
> > >   imb =3D -----------
> > >            LcBc
> > >=20
> > > Which makes sense, except you then return:
> > >=20
> > >   imb * 2
> > >=20
> > > which then made me wonder about rounding.
> > >=20
> > > Do we want to to add (LcBc -1) or (LcBc/2) to resp. ceil() or round()
> > > the thing before division? Because currently it uses floor().
> > >=20
> > > If you evaludate it like:
> > >=20
> > >=20
> > >         2 * (LcBn - BcLn)
> > >   imb =3D -----------------
> > >               LcBc
> > >=20
> > > The result is different from what you have now.
> >=20
> > If I do the rounding after multiplying imb by two (call it imb_new),
> > the difference with imb I am returning now (call it imb_old)
> > will be at most 1.  Note that imb_old returned is always a multiple of =
2.
> >=20
> > I will be using imb in calculate_imbalance() and divide it
> > by 2 there to get the number tasks to move from busiest group.
> > So when there is a difference of 1 between imb_old and imb_new,
> > the difference will be trimmed off after the division of 2.
> >=20
> > We will get the same number of tasks to move with either
> > imb_old or imb_new in calculate_imbalance() so the two
> > computations will arrive at the same result eventually.
> >=20
> > >=20
> > > What actual behaviour is desired in these low imbalance cases? and ca=
n
> > > you write a comment as to why we do as we do etc..?
> >=20
> > I do not keep imb as=20
> >=20
> >            2 * (LcBn - BcLn)
> >    imb =3D -----------------
> >                LcBc
> >=20
> > as it is easier to leave out the factor of 2
> > in the middle of sibling_imblalance() computation
> > so I can directly interpret imb as the number
> > of tasks to move, and add the factor of two
> > when I actually need to return the imbalance.
> >=20
> > Would you like me to add this reasoning in the comments?
>=20
> So if we want a multiple of 2, leaving that multiplication off makes
> sense, but I'm not sure I got the argument for or against the rounding.
>=20
> floor() gets us 1 task to move when there is at least a whole task's
> worth of imbalance, but less than 2.
>=20
> round() would get us 1 task to move when there's at least half a task's
> worth of imbalance but less than 1.5.
>=20
> ceil() will migrate on any imbalance, however small -- which will result
> in ping-pong I suppose, so let's disregard that.
>=20
> The difference, with the multiplcation later, is 0 or 2.
>=20
> Does the round() still result in ping-pong?

Will have to experiment to see whether round() is better.
I chose floor() on purpose in my initial implementation
to minimize migrations.

Tim

