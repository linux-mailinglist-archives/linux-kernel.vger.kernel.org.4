Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9A6FD30C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjEIXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjEIXfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:35:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CE4237
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683675346; x=1715211346;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9YDk6K+0TSjW+JmvB86RBy3NK4xK4wRgz3RtGONU/+8=;
  b=hqzlTdJFOyhoRjM3D+la0h38HSltq1VdeafOImrxNC1D8J9maYV8UPV0
   gygksh84F+7oe7lEFtLihyBpknVQHreCwB/S/DRvw00lnW+4WYA4SdDCp
   euUZm3IV8K6Vmw8TP+jkRZ1cphY0TkrORCdQOlpFFPPuIcJ1yHffltOBs
   vTEglLTZgaY1rdQYDEi2pL7tsZ6gM+C0GiGvWWVPivv7eZJeEzIhvVIzj
   qhcrpcWrEpV+s1JZjzHvnyVUkwcTfshD7yvxjFJG6YMt69WPFMFw4Atyi
   lW5YRT8cBOnD680J+fsQ4czUV/PnRW9ubMXOZ9jQ1eoV1KqQUV7+7RN/F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="350116484"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="350116484"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 16:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="945471840"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="945471840"
Received: from kunalkul-mobl.amr.corp.intel.com (HELO [10.212.181.145]) ([10.212.181.145])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 16:35:45 -0700
Message-ID: <f8b9c9c6ac533c03edf16cc322069b3670992584.camel@linux.intel.com>
Subject: Re: [PATCH 4/6] sched/fair: Skip prefer sibling move between SMT
 group and non-SMT group
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
Date:   Tue, 09 May 2023 16:35:44 -0700
In-Reply-To: <CAKfTPtBU1Jehye1bY5Ve0hC9_oGKL=SoVRar3Kbs5rhGcEEnAw@mail.gmail.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
         <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
         <CAKfTPtBU1Jehye1bY5Ve0hC9_oGKL=SoVRar3Kbs5rhGcEEnAw@mail.gmail.com>
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

On Tue, 2023-05-09 at 15:36 +0200, Vincent Guittot wrote:
> On Thu, 4 May 2023 at 18:11, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >=20
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a325db34b02..58ef7d529731 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10411,8 +10411,12 @@ static struct sched_group *find_busiest_group(=
struct lb_env *env)
> >         /*
> >          * Try to move all excess tasks to a sibling domain of the busi=
est
> >          * group's child domain.
> > +        *
> > +        * Do not try to move between non smt sched group and smt sched
> > +        * group. Let asym active balance properly handle that case.
> >          */
> >         if (sds.prefer_sibling && local->group_type =3D=3D group_has_sp=
are &&
> > +           !asymmetric_groups(sds.busiest, sds.local) &&
>=20
> Can't you delete SD_PREFER_SIBLING flags when building topology like
> SD_ASYM_CPUCAPACITY does ?

The sched domain actually can have a mixture of sched groups with Atom modu=
les
and sched groups with SMT cores.  When comparing sched group of Atom core c=
luster
and Atom core cluster, or SMT core with SMT core, I think we do want the pr=
efer sibling logic.
It is only when we are comparing SMT core and Atom core cluster we
want to skip this. Ricardo, please correct me if I am wrong.

>=20
> Generally speaking  SD_ASYM_CPUCAPACITY and SD_ASYM_PACKING are doing
> quite similar thing, it would be good to get one common solution
> instead 2 parallel paths

Okay. I'll see what I can do to merge the handling.

Tim


>=20
> >             busiest->sum_nr_running > local->sum_nr_running + 1)
> >                 goto force_balance;
> >=20
> > --
> > 2.32.0
> >=20

