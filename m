Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769F2666BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjALHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjALHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:36:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859642ACF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673508965; x=1705044965;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q/HB8GfMZWxTg3MiOMrKTu40H1/0KLvsMNfoP0HlSVI=;
  b=Oc+uWCDAUKyV5uqk5XiipgDoDIOPf/CHNcvgjes6CyMDDTnCm022qugf
   QSL9Klek4cYYWgzoX/VmiODtyNGJ3z/5lNk13vy6Z25iy1WTaNfJypyM3
   ScHUn1Ez+um9l580VBn5bBc0RbRnj1kyGhXScoQdRIQAxB+xPi544Um2i
   JrEjg00AAACu/ibU4FPdKXuEhbpv95g7SrMGA8lionrEAj3K1AUHjIAuD
   GvEJexNLS22Vvm+Lf6aDJw4qinXy3rVNce1Lr9A0rneOBi/6CtXrv6aox
   pS/Uv59sOSSMiNcu0q6R6DlhWYp9VfBzTLz8sgbf/1NKT1HP69azKsZ28
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311458976"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="311458976"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:36:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800108593"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="800108593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2023 23:36:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 23:36:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 23:36:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 23:36:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 23:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW+Hc44hDveDxZrR8thFwCW/MITBsH3rUmpm9uDUZJkYftBErJJSR1FpvJOUpKHGFuS8fipOtsumiNoGybrNr9m40/xp5vSXy+ysBDyRPUm3JbOvovGCgNcsB4In1ZF9TYECmrSQf9s1qVrLcLZz0oMR4/hRWKnr7VdYYuBMWiVjjryYz3TTtqRStju5CxWKGk3oQQ5szyWgSJx59p+6pgpGVOP9IUKxvPFUHUV+EifWoBk/K+i3eNiteyDXkndILgLZvd19OWZZ9VrN/zMCqYtMXh8WxEvJSABNaAH5iQSEP8K5TcWftPiPt8JER6b1Hp3qdhI4BOadjwLetogeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePRwUr6V8DB0ueFXTly2rMHUsB9uhN1io/dsA42cgT8=;
 b=V8294PcnjHxV5KcrOVaQCRox316XlB2R99xREseVgCmFHKa5pEJUibVXRJT+zgdbR/60goBF+EHfKBSJWuJehVwUBzzCcPdjqFoKHzYqJWSoN/vkmcT2xgG2GP+B5IFi+joEQ6B+vms32CYzy0dt+soQCTFUV6fPg97NrBH0FjExt9AFPm237FJUYsTQDXLcYSCJy11veCU9kj8tcHPl7AQDO8eqAB74azhlr4KKkCTxq/x/y8NvUtUcNrUuhFCtPlkx1XHKmVg7c5U8F3YprqoLtzDIuXbNl5zZxikHWdKpp2Ff+0THJQKOfR4aOxKFprTxRhmNSPp0NCMyM5+RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:35:58 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 07:35:58 +0000
Date:   Thu, 12 Jan 2023 15:35:39 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andrei Vagin <avagin@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
Message-ID: <Y7+4S9umCo5I+Ty7@chenyu5-mobl1>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-3-avagin@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230110213010.2683185-3-avagin@google.com>
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f484ad7-cf76-4a4a-39a9-08daf46fa54a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Nq4GyJuPPEN8yi8eUMFyDzb1oh0jWNAOwp+M7cDU7whvPWrd5tx7Em4+Ykx3zYUwJPq2BqM5LUgi8nTiwG3Tdb996qJlm8Cu0gia+rKXFSCqIUURfly/j7z+Unxk9pNznSwRy3sSlv/vlIcV2RGfreSnSK0XAVbbV+LkUdVTvjdW+8vAXOueqwcmKJPnDd3TmJowiqF77wFLB+a0fCFnCXBu3ND1PbuzE7q6KsPbxie9P496PRQWK4MVamZelmV1qwefEx/umZsJYJkXlyK3WsGlgCkBxYlzE0gI2DuWnU6SQNZ6evT0khqBnY99s0pGlINmO1FmndzAsgSW9qAFFPxZFysda2/5NGSTQhifxQoS0wODP4c9H7jLJpQY0MLXxNFaibhP3O2NpeBA2IdqJYaJKr8Wd3Tk5cdohKA05FLLFaG2Lq/QIMcO/ysKZI93E2GsE+IelRwgeHPOXvuXHhxfdOHCB0CUCD2dR7HLFdu1PYiKKbTWN5lxxYvEHk1U6RrebqU97T2F/+/dXatSduAWAHPIqbwnGJW5sGsdO9YAVgKWMME0EX4053sN/FmOU8f4WOgRTGf4Qas3ksgbnH0HumDTcqD71n7LWqXIlZ6utoPO/artBx5Q/us4fOkDgjw8mH5hRRUw++A55s7NoQXXSDGZ4eT1XvXaJd7Tr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(6666004)(6506007)(86362001)(41300700001)(53546011)(66899015)(478600001)(8676002)(966005)(33716001)(5660300002)(82960400001)(6512007)(9686003)(8936002)(6486002)(38100700002)(186003)(26005)(7416002)(66946007)(6916009)(4326008)(2906002)(66556008)(66476007)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7TaCULjzTSZtCuqPgY4dvvFs0pl5rSRIJlSHynBgHbSJ1f4PhJgW1l43mJRm?=
 =?us-ascii?Q?2vVCSB43SBm4R8dMB1TF87N1PO7COiiwdDF8NbilpKcVroFHFdXMxOt/yY6p?=
 =?us-ascii?Q?jSBBlyLoQmWKesMAeXEOu4sLI3XxPUOcrYIa9rM0ggDVnENwv6y55gf2EWgv?=
 =?us-ascii?Q?/PEncCoE9220WxU7Ak4JzaK2LYwEnZt3pBXK7CYFcmz4OdT6UAqq2QPZzS81?=
 =?us-ascii?Q?g9tjMXwJ4enWdoVkhAZigDVSyNvX0xgRlVUrjba1GadZjpBtbJRR9ptkHRhO?=
 =?us-ascii?Q?vybu/dw4qQhLgnzUkX90QiT2eIk0B8YBlP8ldrmzozvMcRUSsA1V3etV9y4K?=
 =?us-ascii?Q?TRn11ThNKZaQoqgpbW/kFA3qK5Ub3pd7mRtgIBDeqZXBHwHtp9B1LVug8XiI?=
 =?us-ascii?Q?B/br9mD7gsvENPutRT2m36T9c/dxf9a/ckn5EgFxy4rYYp3QKheNbP8mG0l5?=
 =?us-ascii?Q?bOktjPAbr3Ww7mikdW8ytCr4w803K7yjXg8kIXU0vFrsjanKNGoA6qURVmld?=
 =?us-ascii?Q?mIdtf+hnQmDjvMytIW4W+4PsSg2Mu5rP97417rb3gsh1BtARUWdlIrorrxG0?=
 =?us-ascii?Q?+05N1/GPMd2+uq7iZ3RYHv+qDv2W+opZprPfJzB411g+ilKSg0UTWZGa4T9+?=
 =?us-ascii?Q?+em4hR0Tcj27wIoq3nLCFp7sY3udUVAxz7BBWZvB6HRlY7bgcQsVzW/pAm/u?=
 =?us-ascii?Q?nJfrKzHt1O2KUGR6GkqUk1bggIUfdskTKq3spcnuwFbfdqFS4Id8GwRqcTuf?=
 =?us-ascii?Q?gsXFo7MCFzHDFdx9WyhbtKx57ALfGMzGYYL8BzZkakYrjPrWFyh4S1hAW92z?=
 =?us-ascii?Q?C//2DTV+bUsfVjgTkjYKFB+/WKgSOjpKMa66rDELbFTSY0Car5GvSmOu1wEI?=
 =?us-ascii?Q?UgDgL43HFqmt6TI85W55143Sdz2sviNkkz6rE0WhwLjHdT+FHVHEioBECanX?=
 =?us-ascii?Q?Iw8q+3T6mLSQtEABjqn2XGewIvGbXhheo+VB3AHqaS0A2n4i873/vkCkP1yR?=
 =?us-ascii?Q?sx5LRxf/vDPzqeFc0vUqfdeVKXk84JHf+tmlOqNZQn2P1geSt88SZvwrURgw?=
 =?us-ascii?Q?q5B7xCjq4Q3VjIndU+3MtNegw9uHp0voeyogVMixbV5PzLgfwb+U7YoHVopq?=
 =?us-ascii?Q?5mJge5hVVpslk53dRGr0APKBXhA1QuATbY9ovx2xa5Q7YvsZinWZnP4WOCLP?=
 =?us-ascii?Q?sypCK//FGy5eH/7oppo2cfPuaOz36ndWh2vv4mm3yOYknpsrC/oSIzacSPi5?=
 =?us-ascii?Q?1XQfpM2LMpOxsSK55W5k08jXxTA8yKCO/ww56Sxx3EzycXZ/zqCXZxcxYAnK?=
 =?us-ascii?Q?xRon9J2YSiZaFQML70E6V3Zc16Sh2/fL1hWZj7CpdaobGwRlak3Nk9iI27dI?=
 =?us-ascii?Q?xVEOh2f18bmExzAtFlxc8T/5VJRdn4W2ZNovwdAHPOLSNAemaEYSE3WkGXwD?=
 =?us-ascii?Q?z5q0199kDB4jdaY0RCyRNTFqYAY5vNwMEpHcdvJ2iVJD9SAtzhiTlcHlxCwS?=
 =?us-ascii?Q?HFFfj8AhxDm6Gs8grzsEtxvDY34EtkIjbFENbe0m9wkOAIUP0EhhFA2sLXhE?=
 =?us-ascii?Q?QHIhKbxLYxGoQ7dV4MCH/FJIa29p/tGSRTeZpu4l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f484ad7-cf76-4a4a-39a9-08daf46fa54a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:35:58.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMHGb3JTiyetHumJQ4Kl+V8ExAHShy98OWwf8N69Hd3mOymdjoamc5+n5N3XeEqgpfDkxFmfePHsP6NPyqi9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-10 at 13:30:07 -0800, Andrei Vagin wrote:
> From: Peter Oskolkov <posk@google.com>
> 
> Add WF_CURRENT_CPU wake flag that advices the scheduler to
> move the wakee to the current CPU. This is useful for fast on-CPU
> context switching use cases.
> 
> In addition, make ttwu external rather than static so that
> the flag could be passed to it from outside of sched/core.c.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> @@ -7380,6 +7380,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	if (wake_flags & WF_TTWU) {
>  		record_wakee(p);
>  
> +		if ((wake_flags & WF_CURRENT_CPU) &&
> +		    cpumask_test_cpu(cpu, p->cpus_ptr))
> +			return cpu;
I agree that cross-CPU wake up brings pain to fast context switching
use cases,  especially on high core count system. We suffered from this
issue as well, so previously we presented this issue as well. The difference
is that we used some dynamic "WF_CURRENT_CPU" mechanism[1] to deal with it.
That is, if the waker/wakee are both short duration tasks, let the waker wakes up
the wakee on current CPU. So not only seccomp but also other components/workloads
could benefit from this without having to set the WF_CURRENT_CPU flag.

Link [1]:
https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/

thanks,
Chenyu
