Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8A72D03E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbjFLUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjFLUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:12:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92351B4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686600756; x=1718136756;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KZBpXSbCEtcAE+AtxkuR8CLnrIRSlgwKX0XeROD5w/c=;
  b=JdYRub38utdbRxqI/fyQaRknDKruhNG1TFmPD/AI2KMCKJelDU7m/Jhg
   yXgy1TSu4kh6zyCvK8Swqk9y0YB8xOorZK9ELOJBCY32s9Xnl5x7Cy2lz
   LUk3Lc2f3wkR6/xPnjKc9J5cWWjGPEw9wMMt3HiUY7u4eK0p9GEcDJbiF
   xnUgj8Ki+XgFIyekXsykKbJieTPjER64ivnyE4tKgQ8id79tpQAtBNUFZ
   Nug2D367OplKyk5+qbRUPgxfeM6sBKbcrOjMqPh+hF2eCooQtiLcXRg/G
   FxXLaVpQAcP33Ba/Rmb9USiQbM8Rnu/4/lHtragzPKlgWYrAHSut8DL3g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358148616"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="358148616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="705523616"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705523616"
Received: from fwbrewes-mobl.amr.corp.intel.com (HELO [10.255.230.147]) ([10.255.230.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:12:35 -0700
Message-ID: <d5c4af97791e12a3431556fce1c9ec1de066c597.camel@linux.intel.com>
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
Date:   Mon, 12 Jun 2023 13:12:35 -0700
In-Reply-To: <20230612111602.GJ4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
         <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
         <20230612111602.GJ4253@hirez.programming.kicks-ass.net>
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

On Mon, 2023-06-12 at 13:16 +0200, Peter Zijlstra wrote:
> On Thu, Jun 08, 2023 at 03:32:27PM -0700, Tim Chen wrote:
> > @@ -10371,6 +10436,11 @@ static struct sched_group *find_busiest_group(=
struct lb_env *env)
> >  			 */
> >  			goto out_balanced;
> > =20
> > +		if (busiest->group_type =3D=3D group_smt_balance &&
> > +		    smt_vs_nonsmt_groups(sds.local, sds.busiest))
> > +			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
> > +			goto force_balance;
> > +
> >  		if (busiest->group_weight > 1 &&
> >  		    local->idle_cpus <=3D (busiest->idle_cpus + 1))
> >  			/*
>=20
> Could you please add {} for all of them? The comment makes them all
> multi-line.

Will do.

Tim
