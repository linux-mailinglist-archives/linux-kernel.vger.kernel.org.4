Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802DA618F69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKDEJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDEJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:09:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3001EC42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667534972; x=1699070972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NTMI4EzTtl0v0KByzQbDxoIquUcFiOYena6j9xTmvE0=;
  b=FwUZsIPEjfr/2c5R4Q1aPzTy5K6KdA7NnX6SPF0LAiacoHY2/SwLonPR
   8ikNExeSe2n6un7npC0rYGeH8rcUcYq8QTfcj6/sjAwB0HY+bXGqtOONU
   O9j2NOLE7E5Du5CPtxwZctV1q0GtM53cZ4a8nRXfJMnxuTmRA4A7+nuJW
   42ScXdNt1uFLtrQFzQBMB0imbugGirjZqFV84tbWuUEuMOJn7NZGFya4t
   Eu/wXvEuOKqZnM8RpbNJK1TEljlBuXui3q5Uf4sMLO5ZLknsFIdg97rYX
   Rrb+54IQcZiu7V7lOoZjW+1LlmX1CnwlhlNU8EhROR2mt3HKdmVUYhc1i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336574527"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="336574527"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 21:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="880154923"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="880154923"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2022 21:09:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 21:09:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 21:09:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 21:09:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 21:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeMmp51nChDPXpQw0LguP0hz4c+xM7luGPBmBf9I7f+R781w+h3LVbzddbE+OsITndXsH3CzN4hdjmX72m/bHwNNXY8WtkzIEOg6tpqddFnbaTinde1gXIIqtlAqkRg4WSxyPKN5M6yyrhkNviBRHtMqoAMfpuFcLG2c0OJrNZAr9BJXIjsO4sW7/3D5vtHHVmjQNlLihyFH9zbbGstDpXY7IIxcC54qvH/HfDZ/qEUVaA+dZ/SD67T8nrhSYOCKFC21JHZyD/pjQf/jlAi2B5l/C2LbrhYZd4H8m4nIZISLZBSHRMH7d+4zpHcJlAW2cwhIB07eq/Kre9cSGtDOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yuhr5urAVGz6CCQJFvWZNVBdxtF8+UB65Y76nWl85w=;
 b=cwc9LV+vAuQyz0dOejnjX4a3T73kGQ1KZdBgNg/iNZDO0pSMGnnZXkNkQNprNJrScNTA8fTOe7gZMldSbhQwCnRIne0nq+UB9Bd+HefdsyOjRgPAwPyXhPgjIVuuv2B0Gd7mdMNwOw7Plg96xWD6VGGdq+GpcikO5KNEl/1lHpvb2wtknHG01dsx5W5dKVncCOQ7xaD7DID08PFZFszgXxZrfrWd1MM/ih1Udow71f6R6LyaifFIQoAHQF+SdHvrbmd2wioMoVAacNzMjQlVX69at2nYCmYKhD08Am+Z1IrldrZsDqzYtA7XUVQP1xGHCNIWB+Zt1clJrqaHwWb7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 04:09:29 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%9]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 04:09:29 +0000
Date:   Fri, 4 Nov 2022 12:09:12 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce short duration task
 check
Message-ID: <Y2SQaBDcq7AVPStq@chenyu5-mobl1>
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
 <Y2O3nDrvcy+KuGg1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2O3nDrvcy+KuGg1@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 29949f6a-4ccc-40d6-7bbd-08dabe1a5e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Psdw7DyeJR9PJWKPUiDU9dVTjwa8sX5FW61Gu4CuvSrpFBJrmrtt8e45Y6Udn2dtWJIE/ZmsAn1UrNe84FrFYn1iwCiO03U3iC6t7rHAywamprwgeMmtukoJgkzN4anzrkgY0Il/pferEnvt0RfvCVpq8SiFdFJ+nr24LjPCX5f7hkoB7wchd1VhyFGPru1wfoi6QyEfjptGJx9QQcKA24js9MCPelVzB1tdCTyd6PDskO3ziVxvEOuDsjXkVUPyuW1m52Rf3IiqS1WVgWqlrVDcVK9qGnx2G3F76lpHRnw6zQLMQMw5UXpy0OUdw/ysRd6Xt2+xDNoClY4vnMNqE+trTXjkXExj5vFe0SvEk662y5Q/D17+T4dRNlAhxWXIPyVCCrNRaw6UU+qJp0ZZgJ9JMrEUKSsSwHN/mbyKT6IgBK+ScJIskvaBZfEIHFUTygkRJBBKkD2jEOpi7C9FZZRxOs1FsoIWbAJ3bvbb0Rvar+axeLCY0iJl83ED4X3fmKSA0ZreiHF9654s4j08n5201ffVxOCSlU1ZyIJ3uJHx7tmnw2hFTc9ek0b3CNw/1gVP1SXndDcTjopGItm++KYoxzinG1emA2s5dpq7l+NIxzYxb05iJkXuZdfqk2po2QM5DILy6c5sUv1l8jjBIdAa2yaweXrwA5C/umkDs4FYhISpQnmwFJFGUTPMnatPQZyD6pnKptaZG7/4QqcKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(83380400001)(2906002)(26005)(54906003)(8676002)(53546011)(9686003)(6506007)(41300700001)(4326008)(6512007)(33716001)(7416002)(8936002)(86362001)(66556008)(316002)(38100700002)(82960400001)(5660300002)(6666004)(186003)(66946007)(66476007)(478600001)(6486002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0hzCAZJ5DgwHtp7R3gOco4d65o0dvtQIyPIEAoE6+c3XvcGGKY8paBEBbW9?=
 =?us-ascii?Q?m3zbrYsTmWDqOGDv8dANUb7ljzTfa6B9gkRK+Y13nz89f/leWgMT4Mhc2yKY?=
 =?us-ascii?Q?jzza1HpVIVIj1755qKKfdKnFrY1/cRbjrFZt/rq8bOJFP5a2jXnyeB8xPAnT?=
 =?us-ascii?Q?cpAntsdsh4Dd/5RTQ9tVj7iM2OHkcTe0QfyAbP/KDuHn3uVuCr1oWVRuLerR?=
 =?us-ascii?Q?yRyZbM2bzU6+WvbR6hOTbNf9jrtbR4VpEIQAo7NQK4xK4PFo6JzfgoWHflaG?=
 =?us-ascii?Q?ZdYey73WxK306Nnoj/qRLiE0DEwCmeIJs+tEvLM6soIHr0S2d/RA3EfgpVKw?=
 =?us-ascii?Q?ZDEyfV8aIHFzthRd5qFvpLXNfpE3RJuMAMvUl6Fks2kpB99b5LHcmOq53Cex?=
 =?us-ascii?Q?6zEUDVQvmkxWnKOghkQXKsoIAqPjsWNw/Kbd8yvB/mmfXzmj7bbJonF13qVb?=
 =?us-ascii?Q?POXwLDSkRre3OJdXvGjNFosBqyqvaikvYc6YDDeKQY5CzL9lOw5m8th1WRoS?=
 =?us-ascii?Q?u9zTUkWqZ0bcdnZw1ChBmI0qKS242PMSNcMgSr2HSZHzmKQUZ8G2EeigpjPZ?=
 =?us-ascii?Q?F8xc8Ujfnjr45WLeUIgtivuogBGUpA9y2yfRzyrQJ7kfvnL3TECVDdT1kinh?=
 =?us-ascii?Q?9CGGKPQGArwIUBXmQwMDaAkPB2N+mPwN/10m0A0566LqMkXGcg3nhnl3qUXv?=
 =?us-ascii?Q?nX3hV8s1mJYQZgbeb56HgKHNpj47YzaJihJ3XDloKclaLe/tMPjDCAaQo/KO?=
 =?us-ascii?Q?VCCqbKJy5hGSIUkI6PmMHJB5c/Ys57HyT/jntmvkqoxQ+DwtVhos9yGth2OL?=
 =?us-ascii?Q?WKpsBnG/iBTKfRfbw45PRWzidYfAoDJcRhC9KXFR+YebzAOsv1zC7+G6Oa6R?=
 =?us-ascii?Q?mrK2wiE02JRSN7eMukTpR9KQIxzbSxGuXlb6P84lMsCRMXZtQlxoQYhAx8Ov?=
 =?us-ascii?Q?ll3rgNHYEhijMzdWz86B8sSqJkkX9KxQ5moqJQ5mNZugpVMZZ1w/C4Lnu2tx?=
 =?us-ascii?Q?3rRDVVFh/TjFhqUPoOb8V5ZsAS9Kuvh7ntJ3RB0SjEnJrJj3pchisViv0/o0?=
 =?us-ascii?Q?dgkFY9Qip+Y7hfLk69t4K7aGDC8AirYCJstSBfcYWIET4h5xOxVcXMwboLJK?=
 =?us-ascii?Q?Y6wW11Mpkxl+LfM+1606e57yeFr0QMglw5Ea/Qo9hkpgPoI7WFv8mvwHVGME?=
 =?us-ascii?Q?JoPZlLEIKA8UoAInwr4KBkKUhHeEOGrxrEDvSL+Rglt6OdCU7PKnXLWNq4Fg?=
 =?us-ascii?Q?+xSsGwRM3LYPjpK5NPs21Xw7AjyUKfKTke2C9+BG0YdsXNxkHlqyb/uFbF2y?=
 =?us-ascii?Q?/kNTgV/ijJX8+Ziyx9RJ5bWSD2FVZ39Xw2M6zAYrz7n1PIqz7lcZqikVK3ra?=
 =?us-ascii?Q?mqs3oXMdNkVOt60eNqxAp6j4b7DAP6XgkCsI6zA3shg7xTQCvK0aULx4JxOu?=
 =?us-ascii?Q?m2+6cLAYZgcrmLaHCd1Pyntsg7UF9kzgZGmtRkZEoyhzmm+wT8JDNo7Q18Nd?=
 =?us-ascii?Q?qo30otPsL58gxrf/mKm0fZo53EVSAdoto4yH6cbLT250I/wOhQRwV22s9j5P?=
 =?us-ascii?Q?oJR740qgxrHzBvaAD/e7yi37htDi4/t7lOuQHC0S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29949f6a-4ccc-40d6-7bbd-08dabe1a5e74
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 04:09:29.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOF3q3EBw4ztyyjfS9bG+TPvVIC3bHilNfBhUqHZnodlfY3m822oz1ersWDPLw0LS4Ob3jlBpekxNfITqvoocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
thanks for your review,
On 2022-11-03 at 13:44:12 +0100, Peter Zijlstra wrote:
> On Sun, Oct 23, 2022 at 11:32:31PM +0800, Chen Yu wrote:
> 
> > +	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
> > +		/*
> > +		 * sum_exec_runtime has been updated in update_curr()
> > +		 * because we reach here via dequeue.
> > +		 */
> > +		this_dur_avg = se->sum_exec_runtime - se->prev_sum_runtime_vol;
> > +		/*
> > +		 * Record the accumulated runtime when task voluntarily
> > +		 * switches out. End of old duration period, a new period
> > +		 * starts.
> > +		 */
> > +		se->prev_sum_runtime_vol = se->sum_exec_runtime;
> > +
> > +		last_dur_avg = se->dur_avg;
> > +		delta = this_dur_avg - last_dur_avg;
> > +		/* consider large change to avoid frequent update */
> > +		if (abs(delta) >= sysctl_sched_min_granularity) {
> > +			/*
> > +			 * If it is the first time the task starts to
> > +			 * record dur_avg, discard the initial value 0.
> > +			 * Otherwise, calculate the EWMA.
> > +			 */
> > +			if (unlikely(!this_dur_avg))
> > +				se->dur_avg = this_dur_avg;
> > +			else
> > +				update_avg(&se->dur_avg, this_dur_avg);
> > +		}
> > +	}
> 
> This seems excessively convoluted; what's wrong with something like:
> 
> 	if (sched_feat(SIS_SHORT) && !prev->on_rq) {
> 		u64 this_dur = se->sum_exec_runtime - se->prev_sum_exec_runtime_vol;
> 		se->prev_sum_exec_runtime_vol = se->sum_exec_runtime;
> 
> 		update_avg(&se->dur_avg, this_dur);
> 	}
> 
> All that other stuff just makes it unreadable and probably slower.
OK, I'll try your suggestion in next version.

thanks,
Chenyu
