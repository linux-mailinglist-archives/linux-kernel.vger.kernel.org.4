Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBB5FE67D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJNBPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNBPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:15:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B212633
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665710101; x=1697246101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CSCsm8tKicbGqoTU+EK9OPLuQ3+39YFGyxoINxu0aWk=;
  b=S0I3cavORQXKenMei4Wc3svUmVqYiZHeV/lTsyDKCsCL3QRPXgZuCFbd
   u/yojSnAYhwF3YMhyEGYPuGXS2aPowR1jLDuXxcYGmxPRQ+N/u52ejSOr
   cwBEteMqAkEv20KShbmgAwMQfSgNtMMDlEP8T7Kh1bggoIHX+pVXJecZK
   CilRSbto4uBcNZKeOg9tExNcx5dmi+tZOKRum0zaBA8WJaDIDoI+4XcJC
   qqwULoG+JTq7BI7z7RCatczde38YTCKChWLyOiXA74Fcr1DQ3cN5O/gks
   BtHvHtL1lQz2aHR7/DGutqCs3y8cIS1EGfAwAQKnGA5rF5sc5DsYz6IAu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="284974161"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="284974161"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627392739"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627392739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2022 18:15:00 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 18:14:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 18:14:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 18:14:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 18:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWguMug1JyUHDnXNEfhyPA1i8h4hJuJXcLzZvX9EmTVEEjtIpw3SXkLok9dY26nTOoQ4TUzX+L3oB3zPDPqFAVBants6xJQsvzGjg0dGurKG7gJjs0VSUY8Pzw3QToALAWiJZVpLiit+wlqcEC+dgwfQorM9eNGVTVoo2YxvZZiLKEbIZvCUAZJUy0VTyNy4D+rRkgvVvqf70v+q0zauEVFoptvWUk2zVN/lCaEsZsYBhUkvMox4r8Ucu4mHUDJ6Mn2jxhcu1IZFMxg3PioXNLu0EhkCiuF2nyx1IEho8DU3ZOd7fSDPl9P+HOYljdH9qNgP76esVRePALv+E2OUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujPG1QVGjiDb8QIbPFbybxPZtbrl0QBISdtIfsyDn7I=;
 b=ZL6QUUygcBnLKrhaRoiFiPkoj0D8nUAe/SfrsbhNY6UPxqRllA/olawbMVABgyAYZ77sCOMIi3adavyHqOMzyCGmMV/9UepjTHrkSzsyRnyVm+uLCzyepsqc5nW/slQzG7yObMlVOrUjS1jKOry/qJQ4pnYXZHxgqbBIwQQxJKceWKI5cH76Wf8Srtctnu6FVqcypqkrIsp3oSCTX32I8VakKmgfyOkldcQvhqV7YJRqKQVlI94DpCVG+B6FYuEBmkqi6RUqYLJlqKvP6j0Gc9vaXwlkM5UPikA1FbdPHJjkbrPuF5vAO9fgZ/Sc0N8wndX+VD6Wgb09sz/4JbxCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 01:14:57 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.022; Fri, 14 Oct 2022
 01:14:55 +0000
Date:   Fri, 14 Oct 2022 09:14:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH v2] x86/tsc: Extend watchdog check exemption to 4-Sockets
 platform
Message-ID: <Y0i3/yQSTdTeuIXv@feng-clx>
References: <20221013131200.973649-1-feng.tang@intel.com>
 <a4860054-0f16-6513-f121-501048431086@intel.com>
 <Y0ivPhN/BgLZXKmu@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0ivPhN/BgLZXKmu@feng-clx>
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: a80ffa15-5536-4836-9857-08daad818132
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /11mVAIHzLAlyH+AOXDZgbo1EQL+CCPIo7IvARcqGJrqXOf+QsnF2pjOHiHqcR1aPAXEQryR1IVWz5gf51mn4L+MvmCPKC/Zxv7wYE3S1/Q5y6C2uOrkJxaW+Cm4Gy8FYjkEj/iRW/Kary1CdJLSLKA3T1eRVTUN6OZMwkSZ99HthWHytyDcqrKw5/EhgK6+vaDAhFs2FiCEKC4/WD4WnkV9gVFw+tlEov6Dv7ay0LlFBWRigZfGCjO4n1rG3+ePB8o9ZyDG7F42L2/Ce9LkehlUi9l0FWqps0hVVMBl/OkYWlsPmo7eutqrAb06c+Ux3pzt/QmofUm0LBSzjuoaqiIzSE0q0SFfrpC8dzRBahLISS6XnKujyS01N8K6T/GcqPuEVRvfvdOsiTWKkJcwTQ25VcF0eK9CKIkjJk03CmsjdaJtFAcnjocjPJq15C2/CTCLPX5J79fWat0ZSgUhwj/9encU0rfVmRIJb2cOQuPZ4iVmU3Yfxb7IQ6c11LzRMy3XhdM9PDVJiTvl0fmasnuxLc5p4ScSf54YCFVpKiZbD//+xhr0Wh2GPs2T6/0Pwfmv1Lj7cTHflG5F50DDnPHV/BOwaPD1dPnkcOEpFaRaQjNuMe0///g6GY/cByQLP09YSX/lnxNG4uXx+o0Dd+pOR/xYMndOuvp4SqqLgQVFjgJKvITJYGAiUEMGEuhN7m6XIkh4AY9P682b15oFotCDeKv8aXMyRZhUvgTeqTwYqES46cZAq8e6yom8Ef0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(66476007)(5660300002)(6512007)(83380400001)(86362001)(9686003)(26005)(66946007)(66556008)(186003)(8936002)(4326008)(8676002)(6862004)(82960400001)(38100700002)(41300700001)(966005)(6666004)(2906002)(6486002)(53546011)(478600001)(6506007)(44832011)(316002)(6636002)(54906003)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhKG57z6+JIIvcMVwovK8oiOaHQ/NLDgnR57KhB5GenRXGKxL6XtOrYhdura?=
 =?us-ascii?Q?fKtyO6VGxx/lU/mEQKznu/gSf+vU4DSen+H17gaO+6LkP+P0QSuZ6aV0EkSv?=
 =?us-ascii?Q?w10+h+QlmIcxz+TlQEBjVxj7dyqdCCwYp7pb/bV/CJLME/wHiCBfuftge56q?=
 =?us-ascii?Q?DPUcgIG6lpdYiBrqlofo14OMVM1w2Mc4b7lhzCVCAUXCzqSOscJROW4pBxYX?=
 =?us-ascii?Q?EyrObOU3rfywnYy2eYJPaJ/nvzdhCHaIF5Z4rC/6oWVc8CUQxSSTT/z7sAvW?=
 =?us-ascii?Q?r84VkF+xTjA7o+O1il7FrorPVH1gKX4KB0zDEBArXSIuCB3ByNHtc1TUZ/FT?=
 =?us-ascii?Q?6f97pav6OU18riJlYcN5rvwUtscJgWYo8ja2QXtOh9Kq7Uyh+EtLV9LZeifQ?=
 =?us-ascii?Q?KjzlWIIGjtDjCCYEuHGcvYYT4lj5lWoElfxn8WevfBISTqgTWxFMu7uJiVBq?=
 =?us-ascii?Q?1e1K88FH669+4MigNj3wsV6JAs48hDmjSo2P0HnAKonz3DqRp5fUx+OVS0Lw?=
 =?us-ascii?Q?HZLdWFEZw8wGURIP1Ht1RBuJHLqh1wQpFxpEPble6DPsgupnh/3hXeeFAVMB?=
 =?us-ascii?Q?LWHaNkaNzMZ6vIt1vGjkPtZ96AEfeH2iJjGsEjT3OU+Mg/oGxYfpwqcoDm7G?=
 =?us-ascii?Q?kpvQ/upX1SKINkMpKlKsAqxtv15lpiNbqf7HnYdEjfXtDqfg+ehNKtaB3KK1?=
 =?us-ascii?Q?LDBuHv9zRHXHBkx+VajQpUmtMc9GO/MeNAxivjj88uY0z4SWmyuTSZOF1xxB?=
 =?us-ascii?Q?JhZB0uTl3+pLep5pG8+zcEqM9Hms7LUVgdMfusp9R6HSMounFwXCsD0jtCzh?=
 =?us-ascii?Q?6adqGobSSYdc5Gr8YtjEpG56pGEIehKdS+hUoi+KI7n3tIwu9ObIOZn4qZcA?=
 =?us-ascii?Q?UEljnyu8oMdJN5dAkKa57/KE1poOviqIhBA31D3CGStEJoGI6wRk7OIWHg/Z?=
 =?us-ascii?Q?lriKj7jI1LbGdVVF79MjGlWnO6i6QfPcJHh7Uh4CWPY8YLFC8rSOCVYwyOpF?=
 =?us-ascii?Q?5RX6NiLIoo/hCN5ejuezQ+Ja5Df6EbqzwAslQaSPQiIwJBdaGWhnAbgpHM3i?=
 =?us-ascii?Q?Ivoa3o5KnJjIc9lxDrU4VqFC3vcCUV5PbtdIkI7NTWmeG7wsydIpAZqIoP2L?=
 =?us-ascii?Q?FjStqunCUXRuXNUgRkIZuZ/CoWj6Boc6j85NRtRQ00sSiCQt4i1JOSOIi0ml?=
 =?us-ascii?Q?mtpl5n32W2YYT60Y2R9DYpQ4r1xtb03BpCvy1xnGyDn/ib6ULAeyk9kdf2Rh?=
 =?us-ascii?Q?U9X9uV/D+3VU1JUwOkSYuIVLBQR+Lep/nAS/nbWwPZteyk+ZKwYqBJUXb3rE?=
 =?us-ascii?Q?ZlDGbiSbO2nnJPG4RCWZsU5exWdUtOwAnot2cePH3eCMZhyHlr2P2cKZ6MOX?=
 =?us-ascii?Q?7yXDmAoi5o9CDoVCLeIM8MgCTmmhhYkWtTbFWIyHkrts9qaMxWSfrSh6KP6/?=
 =?us-ascii?Q?TrhSGqae6kp5ARc9hSQpAjnLxhExABnwMdHCHkFRYjGXcuyF60JNbM1ViIy6?=
 =?us-ascii?Q?5Cm6YR2VCLpMEeLd/WakUSStMDPEICrwRMowuhzPd3X7gcw5S0nzzdk09oQt?=
 =?us-ascii?Q?l8NaRIuuMJjLOGcE0O4nqenKIzG6YrsUdZOKTsfk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a80ffa15-5536-4836-9857-08daad818132
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 01:14:55.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XIrLy2CkXUIevNWLBXGlVs4xMijtqWZuMq4P7WhiIG2l/v0UcrJQorw7U/f6cQ+LkMPCcrQNN4hfr4RUAOGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 08:37:18AM +0800, Feng Tang wrote:
> On Thu, Oct 13, 2022 at 09:02:43AM -0700, Dave Hansen wrote:
> > On 10/13/22 06:12, Feng Tang wrote:
> > > @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> > >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > > -	    nr_online_nodes <= 2)
> > > +	    nr_online_nodes <= 4)
> > >  		tsc_disable_clocksource_watchdog();
> > 
> > I still don't think we should perpetuate this hack.
> > 
> > This just plain doesn't work in numa=off numa=fake=... or presumably in
> > cases where NUMA is disabled in the firmware and memory is interleaved
> > across all sockets.
> > 
> > It also presumably doesn't work on two-socket systems that have
> > Cluster-on-Die or Sub-NUMA-Clustering where a single socket is chopped
> > up into multiple nodes.
> 
> Yes, after you raised the 'nr_online_nodes' issue, Peter, Rui and I
> have discussed the problem, and plan to post a RFC patch as in 
>  https://lore.kernel.org/lkml/Y0UgeUIJSFNR4mQB@feng-clx/
> 
> Which can cover:
>  - numa=fake=... case
>  - platform has DRAM nodes and cpu-less HBM/PMEM nodes
> 
> and 'sub-numa-clustering' can't be covered, and the tsc will be
> watchdoged as before.
[...] 


> For numa=off case, there is only one CPU up, and I think lifting this
> watchdog for tsc is fine.

Sorry, I was wrong about this. 'numa=off' will still boot all CPUs up,
but skip SRAT table init and only show one node. so this is another
case that the fix patch can't cover.

Thanks,
Feng


