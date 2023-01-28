Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A235B67F9DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjA1R1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjA1R1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:27:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A703622DF4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674926853; x=1706462853;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UHflJ+8HruyRq1EQ2e9B5yHUBgdp70kLq8pSud+Z8xI=;
  b=lmkzuTTnGEDuCMuhparS/1WxMF+8rsq2uFCGF5vyDrf0+LNPBVDheLT+
   SIkI2I9L5fR3eFD6IyZgYPlWTIif2NHil1eicwy2j7tZfpSCwdFaCsNQQ
   Mr7uZi+uGz6ZEStlcx51qCpEbMWOu7syQU0iIhNnX0WRPEiTO5EsudMuP
   443qdIasfiXhk24tKrjhKqoHYs0rwx3ly5WYAsg7gcjxt1nYQOjCDyLma
   5Ih1Lu34ownkTRRrYGDWQ+b2YE6sWQo+5nC9G2JVpS9Sz6rM+PkwpyH8S
   CtD986Y3LQapB+dzpee9wybrNdJUI84hh162RT9SGdGHaHtjuokhLjiJI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="354622479"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="354622479"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 09:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="641060830"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="641060830"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2023 09:27:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 09:27:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 09:27:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 28 Jan 2023 09:27:32 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 28 Jan 2023 09:27:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/ZOxqa+i1Tkz3V9lAhB+K4moj1Sb3HMgAMLfRfpg3D/z4YU0+dLPM7OCfzGFX8tQej8sVhO4SCqoznaARPxiNu1ECxygJq9U5Hsz3qx3IsA6Pe5zsvOy/W509kXBOD4njNWvxQyWcuTTYyzGOrw1oJLre1Y8YHfUgf7eCv9VFUu1IuZx+E67vdbdj/bYae26tbQIB9sCwutBbom5UXUO5ytGnqABnRPDDrNBBKRX+E6JVB1mwG5bPEEx0VbyqrW/wKHa6gEEhFSzW2M7e+PdzjpxRlRQlN8o1UnN7+3RHA2eXVF9GSdfEb1a/+Q/8XnL4EcYcPm2/VFkFYHbEcpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sBPCEsGnRkUkcQrA6yQbRy59TxtdCqIeTD2rBvzLxw=;
 b=ThVtGAsq1VuVJAhb0axWjMYX5CoT/41mpOOPIrGJToZUAbp0ew1LiyNcwqsKjE57nfWv40Vv0zUpIw2zxntAoMTShvLwSc8QrodqSfGZDc38YKZhFWze3Fp0suQQZnAZtsNJe0OnwqiNI2Kp74kRxfI9IWKqMJjoBPOgqjaB5lOb1A7ApLV3w5lwTpiGWjmNXAbvPzHKiR04rn06T2qs43oPNtmHxDazXJrmqsteLVmL08svAg2W5lsjT1WnF2vy71LSdehzNqkEqSRF8pJ2ms1p88qxbZH3x7GlUzJsk8WOJCxwKxX38aMBC6mbKKN0Me7xR4lXl3SzYZwJcAWlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Sat, 28 Jan
 2023 17:27:30 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 17:27:30 +0000
Date:   Sun, 29 Jan 2023 01:27:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Roman Kagan <rkagan@amazon.de>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being placed
Message-ID: <Y9Va5HJgEDteceg3@chenyu5-mobl1>
References: <20230127163230.3339408-1-rkagan@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230127163230.3339408-1-rkagan@amazon.de>
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bdc846-0ecf-4ed4-759f-08db0154ee9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gIWfeadtJDctVm55n7IPq1gzCT9uyfMUPh1djE5vZs4Bxf8c4BtRKGUvKpDhjUwYCQ0/2mQuzTOIK5qi0O1nyGYrqHo//P4wriBS34ZPCZh5xDYzWTCn6fCimtZY2cOL3hxOj0m5PnYvZ0douRAhGfwt/nkPtpknw4jB2jxeCU+Gvi/QXSNSFlHA8RSnEQcy1FQp8cm4IHxw+27N1E7y9wp30e5GcUYyTA/Q9CRCokOcRnDELLwWjIX0xpAZlQagLaKGfjQ5L/W46CbdJXTxyfU7HJQRgK1cPblnGIa14vp5yekE/+ft5oMSwImp5nV7dpBUUoFzl1hoL0IpuGf1jDmN+DaLUplbyKt4dIAvhMdfCnUjxPh16IgPLE3LwTkU1e59z9mDy9E8H1zWR1uBHdJvQjlalD9mjrWx/A/Fpsde5qPt3LKTIVQV/k4kCgM44H3B7C6p02TuKnl43mNxvGwW/rzdodvux9ccGBBWelun9fV3rkOzWrcbkAuVkE3k/LNVMZlar4F6DSp6CRIEEoyjZ4ct50rSbyAuKPcjRrV3S4OPb2ZwrIr50mFdKG/4xsIZ+5HRt8XECmtQs/C4dTm2FEKG0XK25AS5MCfCrDwesu7L6PE3iFZ6iaTmsArKkhLVxjaghMSDtFIeh0q4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(478600001)(6486002)(86362001)(7416002)(5660300002)(38100700002)(2906002)(6916009)(4326008)(8936002)(41300700001)(33716001)(66946007)(66556008)(66476007)(82960400001)(8676002)(9686003)(53546011)(6512007)(6666004)(26005)(186003)(6506007)(54906003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jXp6AFa6FrTSpwAg/Fknipw9x6S6pxClGBL/xTxMPsN9iH4uJ3x+vFhBgBdj?=
 =?us-ascii?Q?w3/3IJyZJwGJUV+brXbGH2e0Dwh/s6d+z2iRQbvRP1k6ZE58pHjYtC80QPzW?=
 =?us-ascii?Q?buXbaT6Yq7g/7f5wVPUWsVlHMphRB70e6RRU0i0OLEhTQU8xXunDIy73El2O?=
 =?us-ascii?Q?kbGB8HnNGlR+f0DISD0B+9qMkwTO8wV3a6k7z17vw4fm7zPZFNuHBiotC6HQ?=
 =?us-ascii?Q?hncHBLGWUi17lLDCEwDvLdsHEkhiqPxmaNSP0KW6Z2zI5NUgMyOQcn4l6wjW?=
 =?us-ascii?Q?tT1h5ts7/aT0vTzZoQrlYsv0SmDxCCHJ4HwsfcV7dS1weFA2LrLX7rWbJs0B?=
 =?us-ascii?Q?luXL0C9vD7Pwh9WdJPbxH/aLEiD3pYPugVCsxr0zmRnkEYogluvlM525M80f?=
 =?us-ascii?Q?vvLZYPpYgFEgUo4TVAFlSHUQr+YQreRKDCNDy7QMNd9JFz9/CuRr90JJ16Bu?=
 =?us-ascii?Q?SHWMytN1wegI2zpHcyuU6qVFpFAyYEUYCho0/3gdfYGxC1Wyw/hWh9VgFMmJ?=
 =?us-ascii?Q?EUK+aQXrjFp/twcsDzmhOCeQkl/PHrOYC0ITojwSEbcBPF7YOPP5pXQCe5oE?=
 =?us-ascii?Q?G5DjUUTH+U0OoDJy3k8bEybxPhLs/i539cV2/m1x73QtTCDoTDI5PLGQUeHp?=
 =?us-ascii?Q?NTBgiu3qr3rlh6msFmrA1yPMSLg4YAhtwIsSK4/F7V9cXVfhzV4VeBCJDu9m?=
 =?us-ascii?Q?p7uJnK3YeMWqeIUpPkQBIVYe3ZDQF0RybjGu8emjF5E9Hu7uwXbzFAYihl8Q?=
 =?us-ascii?Q?MyCFqi22nh4c6zYeuk0q3Ou3hrG961wyEvHkxT1cUtf19Jd9c8mMEpu8t5bi?=
 =?us-ascii?Q?INRyO7hTyyxnvaYKgBWUMMypMzdepUXCYSaX8Vt4Ylh2drDv0h4pYfikCkly?=
 =?us-ascii?Q?CaSBlgl/E25eGfJXOe25k9ZnueqiFu+2A6VOFT6cp/obURWxlcjSCj907AAD?=
 =?us-ascii?Q?9sgEbl9LNKkybUwRrIcGzpX00u7r3330Mr9/JfudfPEg1JLHf4pARFF10yv9?=
 =?us-ascii?Q?/o0MpLWy1FEXzQkB5RQTXN7fKZ+mZcvcB3JNLFtDI+NX6fcbrlweqqXkr3Za?=
 =?us-ascii?Q?QPKeKjxP4KNOy7hGqOAm///MdFgheqY6+nXheFkvJ05WNTNiKfnTCixIyPLe?=
 =?us-ascii?Q?ihhWkUiRQOo6Xk39YjifaPigF2HGBwtm+w5U3w44nMk/iwf7gR03qdH12B8V?=
 =?us-ascii?Q?mu8qP2NQogaIxNRAslQCkIGQ4Rs4P1RWohi5XeKCY5IqnRg/WWJ8ZlsOR1PQ?=
 =?us-ascii?Q?Mr4Q0GqK02dI2azOcbs89Y99h8Zmv4KUnIa4nZ7+lwdpzE0hGg6yW8reEj6Q?=
 =?us-ascii?Q?wI0KMFD70DK4FfkfnO5zLLQ/xgXCnOB9Tv+Inw9rAIGUPRnonUXI/2e9DK9t?=
 =?us-ascii?Q?qVMIRKj4s39kzZhfEJb01ESW2jaxgQP2GcRQK8ZK0tWVk/BifOkOncz+sm5Y?=
 =?us-ascii?Q?R5xu6LJXnbID/37hTiCMQ16LaNXCZQHviIgC025p2+JEo+vUxHo7Wnuo6jYc?=
 =?us-ascii?Q?DuPnoqsIUWmDqJ5EZef1U5+6gncRMMY16QZulnXxW9JE+LFVqZc5/IqQHNTq?=
 =?us-ascii?Q?3WjgrUbAmG/Ir71pmRC1iIQlXGYbOACz0JwdvhcO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bdc846-0ecf-4ed4-759f-08db0154ee9b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 17:27:29.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7wWAd7HzpAECFWNdleamYvDRyBQmiaCtzHns2CzeglJ1OdJhNPKfgYRLum4+JpLGfYBt6P3BkPevKpiMclRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
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

Hi Roman, Qiao,
On 2023-01-27 at 17:32:30 +0100, Roman Kagan wrote:
> From: Zhang Qiao <zhangqiao22@huawei.com>
> 
> When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
> to the base level (around cfs_rq->min_vruntime), so that the entity
> doesn't gain extra boost when placed backwards.
> 
> However, if the entity being placed wasn't executed for a long time, its
> vruntime may get too far behind (e.g. while cfs_rq was executing a
> low-weight hog), which can inverse the vruntime comparison due to s64
> overflow.  This results in the entity being placed with its original
> vruntime way forwards, so that it will effectively never get to the cpu.
>
Looks interesting,
case 1:
  se->vruntime = 1, cfs_rq->min_vruntime = ULONG_MAX
  ==> max = 1
case 2:
  se->vruntime = 1, cfs_rq->min_vruntime = LONG_MAX
  ==> max = LONG_MAX

May I know if the issue you described above is in case 1? We want
the max to be ULONG_MAX but it returns 1 because of s64
comparison? Then max = 1 is incorrectly used as se's vruntime?
Could you please elaborate a little more about this issue?
> To prevent that, ignore the vruntime of the entity being placed if it
> didn't execute for much longer than the characteristic sheduler time
> scale.
> 
> [rkagan: formatted, adjusted commit log, comments, cutoff value]
> Co-developed-by: Roman Kagan <rkagan@amazon.de>
> Signed-off-by: Roman Kagan <rkagan@amazon.de>
> ---
> @zhangqiao22, I took the liberty to put you as the author of the patch,
> as this is essentially what you posted for discussion, with minor
> tweaks.  Please stamp with your s-o-b if you're ok with it.
> 
>  kernel/sched/fair.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f8736991427..d6cf131ebb0b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4656,6 +4656,7 @@ static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>  	u64 vruntime = cfs_rq->min_vruntime;
> +	u64 sleep_time;
>  
>  	/*
>  	 * The 'current' period is already promised to the current tasks,
> @@ -4685,8 +4686,18 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  		vruntime -= thresh;
>  	}
>  
> -	/* ensure we never gain time by being placed backwards. */
> -	se->vruntime = max_vruntime(se->vruntime, vruntime);
> +	/*
> +	 * Pull vruntime of the entity being placed to the base level of
> +	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> +	 * slept for a long time, don't even try to compare its vruntime with
> +	 * the base as it may be too far off and the comparison may get
> +	 * inversed due to s64 overflow.
> +	 */
> +	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
If I understand correctly, se->exec_start is just updated by enqueue_entity()->update_curr(cfs_rq),
then place_entity() in invoked here, I'm not sure if sleep_time above
could reflect the real sleep time. Maybe something like:
rq_clock_task(rq_of(cfs_rq)) - se->time_stamp_dequeued ?

thanks,
Chenyu
