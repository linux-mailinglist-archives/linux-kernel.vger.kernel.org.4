Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91638691433
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBIXFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBIXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:05:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050D55EBD8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675983918; x=1707519918;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZnpWvhrsnOHWT2J4PDCH2JyXOHu3BBAJ/Ce+aCda5ww=;
  b=WJNkAjSUegaw3ucyrxuIgOTwji0wggP4jOAS5O6nBkeq34f9drZSXA5X
   MEj+u+Wm2oPUdkNSFYfya384vVx2sl5WYwAf1L/5RPLxhtpUgzPSW3Y+n
   9hhTe21oBy/kPiEwGavY82cSnH0PtI8zcWJ7Dyrs447iPcr6KcjX+GUej
   jAaF1Ry5Z4B4Qsqlu+k78pNtwNLkxmAwJz2cFECmi2rta2XLShYUTDW7b
   HCLbjY3k86kxRKTpTnQSakq7uXUG5sc3KWR54EoZkBrQorpBhxRf4Nzp5
   0ArOAA+cJrXQv/arVDGgcO8cR6chyq4GiViHyLI2EdTXbZEVX/awy9To7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="394871512"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="394871512"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:05:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="731512191"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="731512191"
Received: from bccrane-mobl.amr.corp.intel.com (HELO [10.209.107.113]) ([10.209.107.113])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:05:16 -0800
Message-ID: <fb63369b2fc686730adefb6800eae4877e62e3b6.camel@linux.intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Brown, Len" <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 09 Feb 2023 15:05:03 -0800
In-Reply-To: <DM6PR11MB4107F95164772B40B92F66A6DCD99@DM6PR11MB4107.namprd11.prod.outlook.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
         <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
         <Y+TyUZg86LYhtWeJ@chenyu5-mobl1>
         <DM6PR11MB4107F95164772B40B92F66A6DCD99@DM6PR11MB4107.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-09 at 20:00 +0000, Chen, Tim C wrote:
> > > =C2=A0static inline void update_sd_lb_stats(struct lb_env *env, struc=
t
> > > sd_lb_stats *sds)=C2=A0 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sched_domain *child=
 =3D env->sd->child;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sched_group *s=
g =3D env->sd->groups;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sg_lb_stats *l=
ocal =3D &sds->local_stat;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sg_lb_stats tm=
p_sgs;
> > > @@ -10045,9 +10044,11 @@ static inline void
> > > update_sd_lb_stats(struct
> > lb_env *env, struct sd_lb_stats *sd
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0sg =3D sg->next;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} while (sg !=3D env-=
>sd->groups);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Tag domain that child d=
omain prefers tasks go to
> > > siblings first */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sds->prefer_sibling =3D ch=
ild && child->flags &
> > > SD_PREFER_SIBLING;
> > > -
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Tag domain that @env::s=
d prefers to spread excess
> > > tasks among
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sibling sched groups.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sds->prefer_sibling =3D en=
v->sd->flags & SD_PREFER_SIBLING;
> > >=20
> > This does help fix the issue that non-SMT core fails to pull task
> > from busy SMT-
> > cores.
> > And it also semantically changes the definination of prefer
> > sibling. Do we also
> > need to change this:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((sd->flags & SD_ASYM_CPUCAPACI=
TY) && sd->child)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sd->child->flags &=3D ~SD_PREFER_SIBLING; might be:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((sd->flags & SD_ASYM_CPUCAPACI=
TY))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sd->flags &=3D ~SD_PREFER_SIBLING;
> >=20
>=20
> Yu,
>=20
> I think you are talking about the code in sd_init()=20
> where SD_PREFER_SIBLING is first set
> to "ON" and updated depending on SD_ASYM_CPUCAPACITY.=C2=A0 The intention
> of the code
> is if there are cpus in the scheduler domain that have differing cpu
> capacities,
> we do not want to do spreading among the child groups in the sched
> domain.
> So the flag is turned off in the child group level and not the parent
> level. But with your above
> change, the parent's flag is turned off, leaving the child level flag
> on.=20
> This moves the level where spreading happens (SD_PREFER_SIBLING on)=20
> up one level which is undesired (see table below).
>=20
>=20
Sorry got a bad mail client messing up the table format.  Updated below

			SD_ASYM_CPUCAPACITY	SD_PREFER_SIBLING after init            =20
						original code 	proposed
SD Level		 	=20
root			ON			ON		OFF      (note: SD_PREFER_SIBLING unused at this level)			=
=09
first level             ON			OFF		OFF
second level		OFF			OFF		ON
third level             OFF			ON		ON

Tim						=09
