Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5D6ED10F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjDXPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDXPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:12:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F11BC;
        Mon, 24 Apr 2023 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682349163; x=1713885163;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=creu1FWEWXekS0GSi/hyE65nvjBle1W5o/SEndVTiPg=;
  b=gR1zjWVzvg5pFOyPG1ur6NKh/BnhDGNtac5xwXX63kLgTHD0Ofv1LCdi
   KcZrZU9iL/oI+kwZlnJZf7A4G5TWuhc+EHyP6/kszvaO0LkPtgQx7GDJ1
   7cVu6G0G92dKjH1mjXD6NizBcN6n4VQvkoIea0ODowhfdpcYkhPyKyJ4+
   zA1xelI4VlsNCXzpJIaJLyjRh3EeX3n9T1JR6ysTS1qflzbnogatwts+5
   axs+MqzX5XhRoGwv6xdHr1/QvlGH3dgl2Fd1r6uW9UzGo8HU5MnksmJe3
   YSCPCT5/rrvg6fo1ynwKx8p7wHmIi74Mtnacpvc+FLF2JaRldvTDAAv/4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="343965155"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="343965155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="867511061"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="867511061"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:12:33 -0700
Date:   Mon, 24 Apr 2023 18:12:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>
cc:     "corbet@lwn.net" <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
 debug option
In-Reply-To: <MW3PR12MB4553359D41816826AA001A1095609@MW3PR12MB4553.namprd12.prod.outlook.com>
Message-ID: <ff99af93-5121-5a27-e24f-6354b9dffa1f@linux.intel.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu> <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu> <56497126-8f60-e590-bb13-b3739114375@linux.intel.com> <933d8ae2-d8b7-7436-5918-f639405c9ecb@amd.com>
 <346622f4-3ea9-c19c-6175-3346ffc6016@linux.intel.com> <MW3PR12MB4553359D41816826AA001A1095609@MW3PR12MB4553.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-737270251-1682331682=:2038"
Content-ID: <8c5736a4-4c1a-25f2-44b6-83d2cd225350@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-737270251-1682331682=:2038
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <1685ac52-bb85-bc24-b4c-4c7e8bcec817@linux.intel.com>

On Fri, 21 Apr 2023, Moger, Babu wrote:
> > -----Original Message-----
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Thursday, April 20, 2023 3:59 AM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: corbet@lwn.net; Reinette Chatre <reinette.chatre@intel.com>;
> > tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; fenghua.yu@intel.com;
> > dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> > paulmck@kernel.org; akpm@linux-foundation.org; quic_neeraju@quicinc.com;
> > rdunlap@infradead.org; damien.lemoal@opensource.wdc.com;
> > songmuchun@bytedance.com; peterz@infradead.org; jpoimboe@kernel.org;
> > pbonzini@redhat.com; chang.seok.bae@intel.com;
> > pawan.kumar.gupta@linux.intel.com; jmattson@google.com;
> > daniel.sneddon@linux.intel.com; Das1, Sandipan <Sandipan.Das@amd.com>;
> > tony.luck@intel.com; james.morse@arm.com; linux-doc@vger.kernel.org;
> > LKML <linux-kernel@vger.kernel.org>; bagasdotme@gmail.com;
> > eranian@google.com; christophe.leroy@csgroup.eu; jarkko@kernel.org;
> > adrian.hunter@intel.com; quic_jiles@quicinc.com; peternewman@google.com
> > Subject: Re: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
> > debug option
> > 
> > On Wed, 19 Apr 2023, Moger, Babu wrote:
> > 
> > >
> > >
> > > On 4/19/23 08:20, Ilpo Järvinen wrote:
> > > > On Mon, 17 Apr 2023, Babu Moger wrote:
> > > >
> > > >> Add the debug files to the resctrl hierarchy.
> > > >>
> > > >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > >> ---
> > > >>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
> > > >>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   54
> > +++++++++++++++++++++++++++++++-
> > > >>  2 files changed, 54 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> > > >> b/arch/x86/kernel/cpu/resctrl/internal.h
> > > >> index 1eac07ebc31b..855109abb480 100644
> > > >> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > > >> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > > >> @@ -288,6 +288,7 @@ struct rdtgroup {
> > > >>  #define RFTYPE_TOP			BIT(4)
> > > >>  #define RFTYPE_RES_CACHE		BIT(5)
> > > >>  #define RFTYPE_RES_MB			BIT(6)
> > > >> +#define RFTYPE_DEBUG			BIT(7)
> > > >>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO |
> > RFTYPE_CTRL)
> > > >>  #define RFTYPE_MON_INFO			(RFTYPE_INFO |
> > RFTYPE_MON)
> > > >>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO |
> > RFTYPE_TOP)
> > > >> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > >> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > >> index 15ded0dd5b09..1ec4359348c2 100644
> > > >> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > >> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > >> @@ -1880,6 +1880,7 @@ static struct rftype res_common_files[] = {
> > > >>  		.mode		= 0444,
> > > >>  		.kf_ops		= &rdtgroup_kf_single_ops,
> > > >>  		.seq_show	= rdtgroup_rmid_show,
> > > >> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
> > > >>  	},
> > > >>  	{
> > > >>  		.name		= "schemata",
> > > >> @@ -1909,6 +1910,7 @@ static struct rftype res_common_files[] = {
> > > >>  		.mode		= 0444,
> > > >>  		.kf_ops		= &rdtgroup_kf_single_ops,
> > > >>  		.seq_show	= rdtgroup_closid_show,
> > > >> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> > > >>  	},
> > > >>
> > > >>  };
> > > >> @@ -2420,6 +2422,49 @@ static int mkdir_mondata_all(struct
> > kernfs_node *parent_kn,
> > > >>  			     struct rdtgroup *prgrp,
> > > >>  			     struct kernfs_node **mon_data_kn);
> > > >>
> > > >> +static void resctrl_add_debug_files(void) {
> > > >> +	struct rftype *rfts, *rft;
> > > >> +	int len;
> > > >> +
> > > >> +	rfts = res_common_files;
> > > >> +	len = ARRAY_SIZE(res_common_files);
> > > >> +
> > > >> +	lockdep_assert_held(&rdtgroup_mutex);
> > > >> +
> > > >> +	for (rft = rfts; rft < rfts + len; rft++) {
> > > >> +		if (rft->fflags & RFTYPE_DEBUG) {
> > > >> +			rft->fflags &= ~RFTYPE_DEBUG;
> > > >
> > > > I don't fully follow why you need to play with ->fflags like this.
> > > >
> > > > Is it for the ->fflags test in rdtgroup_add_files()? Can't you just
> > > > do some extra masking there for RFTYPE_DEBUG based on resctrl_debug
> > > > which you already keep?
> > >
> > > Actually with this change, I can remove all these tricks here.
> > > I don't have to change the check "if (rft->fflags && ((fflags &
> > > rft->fflags) == rft->fflags)) {"
> > >
> > > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > index 1ec4359348c2..b560c44817bb 100644
> > > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > @@ -1925,6 +1925,9 @@ static int rdtgroup_add_files(struct kernfs_node
> > > *kn, unsigned long fflags)
> > >
> > >         lockdep_assert_held(&rdtgroup_mutex);
> > >
> > > +       if (resctrl_debug)
> > > +               fflags |= RFTYPE_DEBUG;
> > 
> > Yes, looks good.
> > 
> > It matches to the idea I had in my mind but doesn't require putting it 
> > into the if condition itself.
>
> Without if condition?  How?  Let me know.

I was referring to the if condition within the loop, not to doing it
without some conditional (I had an (resctrl_debug ? RFTYPE_DEBUG : 0)
construct in my mind).

To remove if, it would, of course, be possible to use another static 
file-level variable but it doesn't seem justified. I think what you 
proposed is fine for this use and looks clean.

-- 
 i.
--8323329-737270251-1682331682=:2038--
