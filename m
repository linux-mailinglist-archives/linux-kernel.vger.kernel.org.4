Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFAA60C329
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYFRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJYFRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:17:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0FC6976
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666675029; x=1698211029;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TTBeC+cb24rABMb+JUtzmENkGsAJKk2mplXafuTK4LE=;
  b=LMMSBzv9GGUKdPzNPnimlaP1UeNzZJQLEYnR6MI4sAhD0shDnM9CHXCc
   1zu08sE5tZMoZzln3o7fKQZVUD4daefEPIbQtQM5PqMIFr4t5WtOIdjqB
   QHcnM3kj9qZZQ+WITM5gnYjXQKfg3logZ4j495MQicVjFCoRnq4EsakL6
   8tsMfZqD3GZzH+mzO/14NMOAjHLPY9jwzDttHLSW5oVEQTTB6hH06lbyL
   RuWkxtRFC3Ai58NNsReWn6MxBZxVwujJx/caUCKMyyNOOqp5gDwkz/TWe
   KyXh3iLvJnZYqOelecjzBMNpv0gz+a8uKuOW0zUrFh3AaLIuOXx55CrNM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287986782"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="287986782"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 22:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720725192"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="720725192"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2022 22:17:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 22:17:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 22:17:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 22:17:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 22:17:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYeE+yXeMe7AwIcGR90y64ETqDlaNqexutSptelNhl0k8cDNAPmBJkl/Z1GcvjpUn5ZLG7DemltM830IlUeTNmcjoll9NfmTx8kuh9FoF/OsICy0xyku+3ryQ5pUe9IXefAW1SSgh0tQmcFHN5bcppkrVVuulJ/5Pv+8ZNWN9NajgTwIKFhtUu++mNiDjbRQeHMcveZdhl3e16vTOrCDZ7PX6LTimokemWizpPJZvXehzTF3lgJ0HKoVIXqnz1h6muvhIgOS8AQB8Vv9NaQuWSem0igBbfKOPWmRr7rmTP5RFGeg5Dj5n6qr5Xe3nRn2Y1Y1oGBqvduOLawP7vQ22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YVmcloS0aaB0dQcOdTAn3T2PX/oxGHsRWRiubxIl1g=;
 b=MRnMzKiaJ9hsKtcrbkBuI60EbuSHWSoz+j1GEOBjoCSRww6GcxErMlBdV4N/pHX2rdfBGLpOLJk07aqbXVLQjJCb9+IsXZMo5mq7KFv0BeCe0m46Ldnv4mc1r01LAwqOE/IYd8UNa8Xr29+3hHc78ldsudo7B9W4ahZvKWjqZQKVlh+dSXhhmNqEowYqiybIpX+93SfV/rgCMhDbI4PFIQF6icM+SS8RAm20nw4kk0a0B5XW7XXAR3mkroRSS5zcz5BuEJB+lRKq7s45WyPoA2U8ajDxvImPt/K+Ao1k0+jlxNuTXQysYdwEEIa7R9ILonv+JB9d/YMuVtZy2io2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 05:17:03 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%4]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 05:17:02 +0000
Date:   Tue, 25 Oct 2022 13:16:39 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rik van Riel" <riel@surriel.com>, Aaron Lu <aaron.lu@intel.com>,
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
Message-ID: <Y1dxN0fmNFB1y4ek@chenyu5-mobl1>
References: <cover.1666531576.git.yu.c.chen@intel.com>
 <6b81eea9a8cafb7634f36586f1744b8d4ac49da5.1666531576.git.yu.c.chen@intel.com>
 <20506673-cd33-c89c-75d9-89d2999432dc@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20506673-cd33-c89c-75d9-89d2999432dc@bytedance.com>
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bee306e-1610-4476-7e9e-08dab6482679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lneso+fjls5P+w4Q8q2t6nRMU7vL8SbzwgE49svaJHLvvN8iLvK5HATjNkroG5Rad1UvtM8r0/1QmK4uBfI6ySUp0FwrMwGtBON/LKrGX0+4xu1iMPYK3Mijlxo2vnUmZRA95EaZENgrPfg1VWf/I1rfnMDp3AP1AUnHmVJxwLRduvL6Bvg+sv/Q6MGKCkKLKy/Q8WGU2E6fsPJEoZGEP5ulWQV0LtqFlQA4aFKLhIU+v03fEXw/y1i26IuLOx9hs423VPBrii8I3cMgEah98Pk6cCEAKL6UEU7QL+VpMvKYUy3mrTiB6fKywWvaLWpUq9v9WA+w9NBXJqiHf9gBIxmbkpNaI1Os1Km5tho7Go5Q8EHKgVp0+TswuvyztDRv3eQhV5KDoK6hHcym3ZvwH/bPofUSXqir54a3FfSbBK9kxwt42Mhj9rFyXEwxK0iU8KDEW3I+N8AoqWFXrSrm0K+ONsaV2+HM0pO3I/o/WU4hIVJ/aLh/BVy3M6bz/jWfsaMsusalUfnVZ4qA7+S/7oRVhJGy49VRGPlvaEP2gFFGMYZ6+pT28X/DlbwwF/wKCoxEQxVCNfEEOgYXhvMf559Wl9ImHFQ0buiZyWS2XgxQe6oZq6w4uujoudAwGwpuhNKkpOM4ULqnb0P9ugtfY29NTblx2M0DdLNvhJ+G2cvCiiusi0LkEofTsZHarEK+jkbnUiYMqVKhN0e+E1vjfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(66899015)(38100700002)(5660300002)(7416002)(82960400001)(83380400001)(86362001)(186003)(6666004)(6512007)(26005)(9686003)(6506007)(53546011)(8936002)(478600001)(6486002)(316002)(54906003)(6916009)(8676002)(66476007)(2906002)(66556008)(4326008)(66946007)(4001150100001)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSQetQebIkG2wCKwBsFLxpWzvlLSeWESPQ5TeJJFB0GBdLMQkDq+tqyih75V?=
 =?us-ascii?Q?Oohjv979InmmnG11Dt7h1kdYVsW56yWiS1qlgLGA84NZBHkEYYtjfPtExuIt?=
 =?us-ascii?Q?X4T8fs5UllNTflJC5V4BbSZa2MNO+xAXPb/uaOlMn8dLuEsc0OMVpAgaifbq?=
 =?us-ascii?Q?M5yY59UB7JWk4zFAz+mLZCD3D5N3TE1ARoMx6Jab10Dw2QWcrpB3Gc+At7zA?=
 =?us-ascii?Q?YF+x/QZlwVBFaRRML+RgZC+DO5UnXFNnl8pMaSU+WRo0i0Henhj9Y4WOrfWU?=
 =?us-ascii?Q?g9D8HamQAL1eXeU/MlPP2qWPJFCL3K8ZjH6yO0dkkNFtm8/m6yWwuhwbeHdL?=
 =?us-ascii?Q?VsFkk3/OZfKpkE212bKKZciu+toC6QkxH1urqmvr+qu9aXhRLUIByyMthd0P?=
 =?us-ascii?Q?IVORi5ypOaP5sGqgAAlkz+oHacPISiOwV/6gUtAtazEg6HgaiCBDSvZkJD0K?=
 =?us-ascii?Q?Bw1Qoa741Qtt9ZJVOaneXvTIptyjUa+N4ce2jP4k0jIx+eLJEloBnSxN38Pp?=
 =?us-ascii?Q?+jPORpmcb9KqxeCiJYyxGp8HeqQ6tP0GbsiiVFta72MpVsq+IPXp/sjbNP0Z?=
 =?us-ascii?Q?kkdTEJYAPBAw4/GAqjIuZemjizTVnAJNgyyYK2/NE2f9KfI8FDZIWya3pa/H?=
 =?us-ascii?Q?7P8Cl1LAb9lq6ZXCPOzyWp+TMFFl3QroE3XbTO+8AlfnsKKhm2hb+RrhYiCq?=
 =?us-ascii?Q?P8t61uoShKWHduxCvrfwcADYsKoFMmzQzPuxjek8IoIesQODNlQnZ2o3TKVN?=
 =?us-ascii?Q?+ZLnWjXQ1UyLJwIWIrJ4kahaq5t9HglqziWR4cvBU4EMBnm5pfAtNXXsdS8B?=
 =?us-ascii?Q?HWB6c/kxrZmjY6u0ozJpUicSE82+M6Itp+6Qi94EbynogZsiliZVIVDt0bll?=
 =?us-ascii?Q?Hu5t4lsqSDyR284pXTciDTqiKwZX5QITx0HKrmpoOz9nwn8Y1o8klvU9rWTd?=
 =?us-ascii?Q?IbIX7ARG27FeBp0a4IvphSOTNhizySK6cxpPbs+9SS81mBTlV1buS3unzPf+?=
 =?us-ascii?Q?TXFa4EXZWkpF/oLkM+Fgm+6cWmpnU7MExf0bWqZScY5Jue48/oNE9g11Iril?=
 =?us-ascii?Q?awi4KtnvXo/ZXMr+ckQoKQJsoLgw0OJCCUGXe2Q3nxccLq0d9RcDQmWBb/0q?=
 =?us-ascii?Q?u/YUxofs9fAy5mXyUAs7mYS+cJ76jGjbSeKbGXwnlPHaua9rW4gAir2XyzaN?=
 =?us-ascii?Q?zQ8xdXsb7PZXoISkPQIcxQPyGEIApKr+hCrv0Os7skCeiDi9NVZjlXl6g2uK?=
 =?us-ascii?Q?u5HN/qHEDD55KSBIlmdS3dULFQZativZGPxwwkZB9EsY9mWB85fCUCJ3dS0h?=
 =?us-ascii?Q?b6RzvHtLfhm6HWhXT38PxKMrnIwsgZkXW7/rzdFUXQ1sBrltEyqdvKkfsbna?=
 =?us-ascii?Q?7Xaz4GSwhZ953O6z7eB6nFYPLpP/tMdZb165vX5Dj6qNg4+Z7bF/a8dZsFmH?=
 =?us-ascii?Q?zY76lpyz3kj3zuTTJsGXnYvtRAXhJtRV2cIErerx2A2l3UQ3tyAQOkKwBxVb?=
 =?us-ascii?Q?zF53ruqDEiwkdXc4Je77qMV3GI59xE7EBOeqB6V5PnAw7CXevxRwNyja3GF6?=
 =?us-ascii?Q?h896gL7rVHJbfxfbWBG4aXLgLwQ+yG979B46g37u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bee306e-1610-4476-7e9e-08dab6482679
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 05:17:02.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1BvZJEhM4HCQUPtOAsOPITj87tAWoMlIRG+Pi0WSi0WLQHlvnxKNMT5q1W+00QMUXe9r5yYLFR6I1gios8HoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,
On 2022-10-24 at 18:10:22 +0800, Abel Wu wrote:
> LGTM, and please check inline comments.
> 
> On 10/23/22 11:32 PM, Chen Yu wrote:
> > Introduce short-duration task checks, as there is a
> > requirement to leverage this attribute for better task placement.
> > 
> > There are several choices of metrics that could be used to
> > indicate if a task is a short-duration task.
> > 
> > At first thought the (p->se.sum_exec_runtime / p->nvcsw)
> > could be used to measure the task duration. However, the
> > history long past was factored too heavily in such a formula.
> > Ideally, the old activity should decay and not affect
> > the current status too much.
> > 
> > PELT could decay the runtime time, so maybe something like
> > se.util_avg could be used. But after a second thought, PELT
> > might not be appropriate to measure the duration:
> > 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
> >     one CPU, both p1 and p2 have a short duration, but the util_avg
> >     can be up to 50%.
> > 2. Suppose a task lasting less than 4ms is regarded as a short task.
> >     If task p3 runs for 6ms and sleeps for 32ms, it should not be a
> >     short-duration task. However, PELT would decay p3's accumulated
> >     running time from 6ms to 3ms, because 32ms is the half-life in PELT.
> >     As a result, p3 would be incorrectly treated as a short task.
> > 
> > It was found that there was once a similar feature to track the
> > duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
> > new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
> > was reverted because it was an experiment. So pick the patch up
> > again, by recording the average duration when a task voluntarily
> > switches out. The calculation of average duration is borrowed
> > from the idea of Exponential Weighted Moving Average (EWMA) in
> > util_est_update(). The effect is that the average task duration
> > is calculated by:
> > new_avg_duration = old_avg_duration * 0.875 + lastest_duration * 0.125;
> > which is what update_avg() does now.
> > 
> > Introduce SIS_SHORT to control this strategy.
> > 
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >   include/linux/sched.h   |  8 +++++
> >   kernel/sched/core.c     |  2 ++
> >   kernel/sched/fair.c     | 77 +++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/features.h |  1 +
> >   4 files changed, 88 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index ffb6eb55cd13..ff74301b1548 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -557,6 +557,14 @@ struct sched_entity {
> >   	u64				prev_sum_exec_runtime;
> >   	u64				nr_migrations;
> > +	/*
> > +	 * The 'snapshot' of sum_exec_runtime when task
> > +	 * voluntarily switches out. This is used to
> > +	 * calculate the average duration below.
> > +	 */
> > +	u64				prev_sum_runtime_vol;
> > +	/* average duration of a task */
> > +	u64				dur_avg;
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> >   	int				depth;
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5800b0623ff3..f5281fe7f8f0 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4330,6 +4330,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >   	p->se.prev_sum_exec_runtime	= 0;
> >   	p->se.nr_migrations		= 0;
> >   	p->se.vruntime			= 0;
> > +	p->se.dur_avg			= 0;
> > +	p->se.prev_sum_runtime_vol	= 0;
> >   	INIT_LIST_HEAD(&p->se.group_node);
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e4a0b8bd941c..8820d0d14519 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6200,6 +6200,19 @@ static int wake_wide(struct task_struct *p)
> >   	return 1;
> >   }
> > +/*
> > + * If a task switches in and then voluntarily relinquishes the
> > + * CPU quickly, it is regarded as a short duration task.
> > + * sysctl_sched_min_granularity is chosen as the threshold,
> > + * as this value is the minimal slice if there are too many
> > + * runnable tasks, see __sched_period().
> > + */
> > +static inline int is_short_task(struct task_struct *p)
> > +{
> > +	return sched_feat(SIS_SHORT) &&
> > +		(p->se.dur_avg <= sysctl_sched_min_granularity);
> 
> The min_granularity is default to 750us, and can be tuned higher on
> machines running batch workloads. So I'm not sure it is appropriate
> to define 'short' by min_granularity.
>
Yes, it seems that 'short' is a subjective term, different user/system
might have different defination of 'short' task. For a system that set
a high sysctl_sched_min_granularity, the admin might expect that most CFS
tasks should last longer. That is to say, if a task's duration is 1ms when
sysctl_sched_min_granularity is 750us, it is not a short task. But if we
enlarge the sysctl_sched_min_granularity to 2ms, this task becomes a short
one, when compared to other CFS tasks in the system. You are right binding
the 'short duration' with sysctl_sched_min_granularity might look subjective,
but I can not find other existing metrics(also configurable by userspace)
in the kernel to describe this.
> > +}
> > +
> >   /*
> >    * The purpose of wake_affine() is to quickly determine on which CPU we can run
> >    * soonest. For the purpose of speed we only consider the waking and previous
> > @@ -7679,6 +7692,70 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
> >   {
> >   	struct sched_entity *se = &prev->se;
> >   	struct cfs_rq *cfs_rq;
> > +	u64 this_dur_avg, last_dur_avg;
> > +	long delta;
> > +
> > +	/*
> > +	 * Calculate the task's average duration.
> > +	 *
> > +	 * Only consider that task voluntarily relinquishes the CPU.
> > +	 * For example, suppose on CPU1, task p1 and p2 runs
> > +	 * alternatively:
> > +	 *
> > +	 * --------------------> time
> > +	 *
> > +	 * | p1 runs 1ms | p2 preempt p1 | p1 runs 0.5ms and sleeps |
> > +	 * ^             ^               ^                          ^
> > +	 * |_____________|               |__________________________|
> > +	 *        |____________________________________|
> > +	 *                   p1's duration
> > +	 *
> > +	 *
> > +	 * The duration of p1 is 1.5ms rather than 0.5ms or 1ms
> > +	 * in above case. That is to say, the duration period starts
> > +	 * when task p1 switches in, ends when task p1 voluntarily
> > +	 * relinquishes the CPU. This duration descibes the "nature"
> > +	 * of a task: If a task is not preempted, how long it will
> > +	 * run.
> > +	 *
> > +	 * The Exponential Weighted Moving Average (EWMA)
> > +	 * is used to calculate the average duration.
> > +	 * Borrowed from util_est_update():
> > +	 *
> > +	 *  ewma(t) = w * this_dur_avg + (1-w) * ewma(t-1)
> > +	 *
> > +	 * When 'w' is 0.125, it becomes update_avg().
> > +	 * This indicates that we care about approximately
> > +	 * the recent 1 / 0.125 = 8 history duration.
> > +	 */
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
> 
> Would it better initialize to 'short' (min_granularity in this case)?
> So we can get rid of this check.
> 
Good suggestion, the task is initilized as 'non-short', and
is_short_task() needs to be modified from "<=" to "<".

thanks,
Chenyu
> > +			else
> > +				update_avg(&se->dur_avg, this_dur_avg);
> > +		}
> > +	}
> >   	for_each_sched_entity(se) {
> >   		cfs_rq = cfs_rq_of(se);
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index ee7f23c76bd3..efdc29c42161 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> >    */
> >   SCHED_FEAT(SIS_PROP, false)
> >   SCHED_FEAT(SIS_UTIL, true)
> > +SCHED_FEAT(SIS_SHORT, true)
> >   /*
> >    * Issue a WARN when we do multiple update_rq_clock() calls
