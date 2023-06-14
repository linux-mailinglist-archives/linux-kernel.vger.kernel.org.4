Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E86730291
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbjFNO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245659AbjFNO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:58:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB08198D;
        Wed, 14 Jun 2023 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686754735; x=1718290735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+KIL3DdEixfsiMEB2bpIpZjDzFJGUJ1IMBv7dXVXAE4=;
  b=erHkaSnp/LIqV56+CctPsElaCe0V12mBIW22TGj3NiSLQm30GBe/KdhW
   AIP1zNWk1v2v4ZhLmtlwPi3LdCU6IGvF82ACYP1uLHixVckQH03Cyeokw
   gpwQP9qgM0KYQ9fh+iHdfQByEtbjtG+FhaUBKrv7JOKqMlWWEsx1xVwaP
   SjxcLXDycgyXu5cYH+BtTN4SGUGzyHuETJkBO5AON+X5GnZ5EgbUAwC+V
   3YA5lWfHoa2B5u49Sy6QhPUaMnJ70LLWz5Yos+jfEusyjqvMooC1by+4o
   ltY9OXd9Z6u0CIIvUlfuHvNkUlMwbGe1zW73/y3zIEIfKh8LTfs8DrO0e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445003982"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="445003982"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 07:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="958825162"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="958825162"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2023 07:58:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 07:58:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 07:58:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 07:58:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 07:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs7Xi4kth1cjklHvFGOXx40ToWR4wJeSB+q2QokxZQPRK5BsLWAdn8ZshvIDJFIt1FPvO+KlJ1hD6Q0x3wBcTWPvIGakhfz15W+TKjCKUv79/bl3diJ8YyntYLg+5sgrx0aBxCnEEbth8Qx2TStl3JvKW4nQtGEd5biuPX3oOEK1iF9ANekfg/8SNseqO+bpSkXyBtsZ6efsabK+GUfJZ31YGZOAUwL8p6PBEV7FUNP22HtRfwJeSkctJT1YeBIDHJNNPXufjgq42II+eYSkj62m9gp56m4UDbeFfAVXXf1XV7+4ZfylgAS3vuiN+2LVPbtBpfF57DxOsXVm0kPrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0U4oPL/9jO90p3ulWxnFlCpx+yoZR8SktcvAqweWpA=;
 b=AcATm8VgbLm2YYp8Y5ss2cCS2KiS818Wi7tWnnkjrxl0KwMdeBvIX4VxYCzh+fa+/ZvyyyqkkZpPRv9YuIkf3gv2LTEs0YGjnoY/nTMZrIG5S9g4sQ0t5PQJdjxW7+9dT7V0sOf8k1KIryXje1tNGpKVGbgf3ZdyB2Q6oDxFJUKtW6jy9j217O0HPw3P6QA5ckR9ydDsZYyncEVhlo3yNyj598BIo7qV4avJ1boC78glI2cp+X+iKmpb0rAhRakSGSvu4D7ogH/HuPub3mmwFs1ijlIp/TnQxyuRQ0WYfT5iKK0k0HcRmsBTIeWQLr9XqSY+eoAohr9GwprsutpbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 14 Jun
 2023 14:58:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 14:58:35 +0000
Date:   Wed, 14 Jun 2023 22:58:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        <x86@kernel.org>, Gautham Shenoy <gautham.shenoy@amd.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZInVjPRLsyaKksfZ@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com>
 <20230614081757.GA1639749@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230614081757.GA1639749@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c03f5e6-b526-4742-b026-08db6ce7d3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDbFkinzPxsZ6L/EHmtMWQlHxta1b7iw9KcUt/esIG22kw0EPvTeQE9DoNePqyP3A/7eCfx1i9FC8LZhh3XTZlJclop6Kbi+ltEIoVc6QaPsWF3QK8uh4tMHANRw6e46eQk3pMXx7mcct+2rKqX+VzUOZXqIG0yl1TABK9sbVTkjY8a7RC2Z7Vzjvm4/XwHXe9O2xRDVrC5y7bwcCALmsclXI1GK6T4jKaIkNRCex27xplLG1X37uZX9maAfQVfBO3tmy2GQHF9Rz3J6mfAieYvDDOpA5/FvCgN40+fFdhCXh+Mv9amwVbDOL+hIpWpPEiqqN4lXPFq5kV/BFlCM1c31/wbueOBBboeOHCe1L34n/L5qcVs2pZaV3ERKNIS2apWrTyovd4mbKgWncxs7K21CSVgYgdj+VK1nbdZ9ZhgIQqz3bo5yZYgWcOCwn6o9J105FqhzdodX1kS5PrK3CiDMXQaPLotL+wnz4wEo7WCcHXEVtvCWX3N0Y6Wte1u3Y1MUzlXoHapJn25IcNVveaVi2YMrJqyylcZalDY8oBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6486002)(6506007)(26005)(83380400001)(5660300002)(107886003)(53546011)(41300700001)(6512007)(186003)(8676002)(38100700002)(54906003)(82960400001)(8936002)(478600001)(66476007)(66946007)(4326008)(66556008)(6666004)(86362001)(316002)(2906002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a84knpMG7wZL+VTJgOcFZv/7Zpp3jH4iFrzPpj0I80LVNCcCnSH/F35mkBIg?=
 =?us-ascii?Q?S7rMHhlVF1nDYHRHnFhXUBlI38+7+Tll9BDiJybUIjxD8U2p2bjhCg6Lkb0Q?=
 =?us-ascii?Q?87mcvBmypq86az4zGe1ngwBTJ/8LPVEwBM3T010WWj8Rjvk9vCDqx3q6iJRA?=
 =?us-ascii?Q?Og7kCy6KAYZLUlXO46qq5nvDC4I7WRwHnLuW32vb0lNVEOdWcdFkEH7tOtjK?=
 =?us-ascii?Q?ax/in2RWH7Gkp3GCaEZg+c8zPrkaTFWOzxlCPAUN/XFkhtEKbhhKIbtuWZ9t?=
 =?us-ascii?Q?tZtS82GlXK+MtXK+bUn8MHzfXf23aQeLffwbtczRVEgF+SE+mkOmSF5JvNiN?=
 =?us-ascii?Q?+jljTj+PG7/Lk4b0+APsnS+VYtDsNvNI08YIUfU/9zawJI39MGEvJOXDkxHl?=
 =?us-ascii?Q?tkHmdRs/+6oPSjSadzqEQaJ3dvlU05y2kB9S8a5zEeI5sGapZeuAdp+U8VIf?=
 =?us-ascii?Q?PmNxQ6WyM25JGk/EL4NQMUgDHs5BAgrdDiIz2FvtVTztaDvy+SmTVV+Bc0Tl?=
 =?us-ascii?Q?wMaHf0AX5CGa3NP5vkCgPTf0blCQlJ5XfVK9+yJSBSnVjGM9e+BfcJtAzhMb?=
 =?us-ascii?Q?nCCS7sIZfmiWS3YEHKZimFPwJBRO4czUo0zAqRE4uWoYuHNeUXE/le2zpb6I?=
 =?us-ascii?Q?JTsCeyIem91OQNDGGr9MGLIX/elK91MtABSlwvUhDiNmOmJarSVuUq+XFfSw?=
 =?us-ascii?Q?/s4iNu1NQSJ2U9v8FyzZBkynnbXQNhbGqSM2XZjeSC0FO8RSY3p4b2iP+Wki?=
 =?us-ascii?Q?xaYzAVw7wOh5uy9P0OKonVujdM6SBVLwpPJ6Ura7cn0z4vpzEOu1fPTbEase?=
 =?us-ascii?Q?9YQ/rGz0ofAXYROUIHiBlwrGuv3bccMUJ9Ia7t/LqvGEJyWaEUlJB/0islGZ?=
 =?us-ascii?Q?gx88YzRzcBYEH1bIgj2XPq7yjJGoDKCy7GPpOS1U4r2EXEEMZ0RZ3BIb03Jq?=
 =?us-ascii?Q?v8cEvor/dt91IwRccOcxqd6I1ZTYVwnTgFm5uHsFxuRRFFxv4VsbXuiaFHi8?=
 =?us-ascii?Q?Zrc5MaOF5Qt/BWHSwc1L2UCPp34mep+q5mKEZacqLLjFlAyWF8mAB9jSXxCq?=
 =?us-ascii?Q?jEQXwy47XsLLt8v2MkN6HNRg8Q6jRSSIZwHcxSNE4ZCureACNaPqkxOCIB5U?=
 =?us-ascii?Q?/NQR6UFiwhLTSzshTm5HA4aW2FROHFa9O16+k+RGuJb811oSMZyY1/YWg/gw?=
 =?us-ascii?Q?t/MzI2/VROua/Ukw7WAc8+5qtg4S2Fo3gjq4+luExcWiz6/FgyZAkyQn7V4B?=
 =?us-ascii?Q?27GLOcUpW/pO9MoPRmiipKIlSL1JHL+QnrSm2pMhvUuvYR/OY09GAq+oa8DC?=
 =?us-ascii?Q?LymNUBC/fuyxoxhdt2Z94+ZCapgTGI/5wJH7OQky6pTY928T5zGrG1pH/+5w?=
 =?us-ascii?Q?MOKf25acwJdIHPq+UZkaitk8o3udu9snbCUKOogfZSpF4jeM2cLN9IcXUis6?=
 =?us-ascii?Q?2Ugb4WpiB5gzdDjNicTijQrXgu2V7zAbGlxOj/ffUrTIhXkpE31AKbli4+ts?=
 =?us-ascii?Q?DbLzPQ4GzzijZJKmHv1JJ5D77xQsoX/QXgZ/LGuUx2JPBAifG4rsNPO+DDMj?=
 =?us-ascii?Q?fsM/3PkX2wdAiNabgcS9N5mt1jLP2PBPIPBPpkO3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03f5e6-b526-4742-b026-08db6ce7d3b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 14:58:35.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM9PzClG2x0r+uueyGD7q/d7uWAp9llHKo1LCzV6Vpb01bXSxD+z8Tx321x6Ot1gOGhnQdnCC169Eoh58su0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 at 10:17:57 +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 04:00:39PM +0530, K Prateek Nayak wrote:
> 
> > >> - SIS_NODE_TOPOEXT - tip:sched/core + this patch
> > >>                      + new sched domain (Multi-Multi-Core or MMC)
> > >> 		     (https://lore.kernel.org/all/20230601153522.GB559993@hirez.programming.kicks-ass.net/)
> > >> 		     MMC domain groups 2 nearby CCX.
> > > 
> > > OK, so you managed to get the NPS4 topology in NPS1 mode?
> > 
> > Yup! But it is a hack. I'll leave the patch at the end.
> 
> Chen Yu, could we do the reverse? Instead of building a bigger LLC
> domain, can we split our LLC based on SNC (sub-numa-cluster) topologies?
>
Hi Peter,
Do you mean with SNC enabled, if the LLC domain gets smaller? 
According to the test, the answer seems to be yes.

SNC enabled:
 grep . /sys/kernel/debug/sched/domains/cpu0/domain*/{name,flags}
/sys/kernel/debug/sched/domains/cpu0/domain0/name:SMT
/sys/kernel/debug/sched/domains/cpu0/domain1/name:MC
/sys/kernel/debug/sched/domains/cpu0/domain2/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain3/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
/sys/kernel/debug/sched/domains/cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
/sys/kernel/debug/sched/domains/cpu0/domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA
/sys/kernel/debug/sched/domains/cpu0/domain3/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA

The MC domain1 has the SD_SHARE_PKG_RESOURCES flag, while
the sub-NUMA domain2 does not have it.

cat /proc/schedstat | grep cpu0 -A 4
cpu0 0 0 0 0 0 0 737153151491 189570367069 38103461
domain0 00000000,00000000,00000000,00010000,00000000,00000000,00000001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 00000000,00000000,00000fff,ffff0000,00000000,00000000,0fffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain2 00000000,000000ff,ffffffff,ffff0000,00000000,00ffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain3 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

SNC disabled:
grep . /sys/kernel/debug/sched/domains/cpu0/domain*/{name,flags}
/sys/kernel/debug/sched/domains/cpu0/domain0/name:SMT
/sys/kernel/debug/sched/domains/cpu0/domain1/name:MC
/sys/kernel/debug/sched/domains/cpu0/domain2/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
/sys/kernel/debug/sched/domains/cpu0/domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
/sys/kernel/debug/sched/domains/cpu0/domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA


cat /proc/schedstat | grep cpu0 -A 4
cpu0 0 0 0 0 0 0 1030156602546 31734021553 1590389
domain0 00000000,00000000,00000000,00010000,00000000,00000000,00000001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 00000000,000000ff,ffffffff,ffff0000,00000000,00ffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
cpu1 0 0 0 0 0 0 747972895325 29319670483 1420637

> Because as you know, Intel chips are having the reverse problem of the
> LLC being entirely too large, so perhaps we can break it up along the
> SNC lines.
> 
> Could you see if that works?
I think spliting LLC would help. Or do you mean even with SNC disabled, are
we able to detect the SNC border? Currently the numa topo is detected from ACPI
table, not sure if SNC is disabled in BIOS, can the OS detect that. I'll have
a check.

thanks,
Chenyu
