Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE444730E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbjFOEXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFOEXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:23:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9DF1720
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5SnAUN5BUY1k/wrsUUDsx8RIqSiD0l0hqCjK4Q6QaGdx67vWjWdsZ+4ekv8aOvdTTUSeJ93g7CcKCXFtVZiTPgip0LlnC+9nIisz1K8DZUVrDpPedjdE93ezOZiwcrg20fjBJz0BgwqLiIe39Xz06s9pEJRMa585oBgimtKYlMgDLqRGYwvdT75IzB5XGlT3g1Reg+lM62o1K5YtHkgHegAxJfVEN8oNwJVj6ySDKg0S8uoH4ykjlNH1lumfRP0XWnfyCmwiOJGT9fkqLbm0ruZc/FYlq8hp5uToHhDjQ59a26IwajfN7EwfQV5+oVRCpsdoFVFV3NKXtG9/tYOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIHeMk2ixR4lvt5PI7Rkkx9i+oWsb2KXpWH3UMk5ZSs=;
 b=TZ1QIuNI7ecPT14YIFRVzWWVBUJlQhH80313vGLQlgAjnwt1zJm+JdVRFejJtcOf1+flOsdFxDFAzokG/l3p5IrskvuR5jBXGHc/362A/wLhFqoFppffUX50oMnitcaUZSZhBVDj7JZ6YsUIBaPYgYEtkgFhAxb2dS3JfBNYRXpgepAvO/UwdZn1T5hurZz0froRWENZyhwAIdhZzSM4CNh1lFb7VyfDH1BtIOQwdawNWYqwPtUeB9V5WZCPhXuSWhHS85o4Px9Ara0FBKvz2tfjhhGqcfRn3m4XfeUlFbkV/3qNliGECAbmSXKHxCxw8HMrR7zzqMWLTl3c+EJWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIHeMk2ixR4lvt5PI7Rkkx9i+oWsb2KXpWH3UMk5ZSs=;
 b=rlhGOadmJ6VJWczzv6uzi3vu5Fb60JcOfOGwSxvO+98fkXtC2UdAtKY6B1dbV0m8O75VyNQZkmECx2UHjQ7fDWdTQcU25tabvHVWlFyMfs1DRsJpfT75CafklvpYo3msdEJw2/8dHNEZ9cmMPvLV5vEhACnjkED/WcGu0S5YlLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 15 Jun
 2023 04:22:59 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 04:22:59 +0000
Date:   Thu, 15 Jun 2023 09:52:46 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Limit the scan depth to find the busiest sched
 group during newidle balance
Message-ID: <ZIqSFjOcDvD5WZ2F@BLR-5CG11610CF.amd.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686554037.git.yu.c.chen@intel.com>
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fd71c2-c164-4368-9915-08db6d583387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvT1Uiz6QADHv2AKhpxdDE+oYEaeH3kyKdEWkn/Fz53V2Nhg6lfG9+o3Pp6CeI335BvCKOvGHvhOa3BHpbYFOKE3q6DXbPN+bx/4kfk55KV7MCp+MXy/NTubiG81IUjRQYhCFoGSeyknp/9+t8XXZTI6mduT3f5nQ71dZEP49Ki/pa6x+vBA0O01CilwzXLruSt3d2/4IS6NsuUBTcSYd7j7W6p5vheYkeqG9XBZlppz1w2s5eKSSo7tams1YS8OjwJ4hnGHOIBXecmshtfawT23pFx6HeaZPY1we0Bvcohe9HlwJ3CtPIGwUTsczCEFIQ9VCbVhI5Pau7UIN8zySVyg/hoYnBpwlJoCL8WuVzw2w32XlXG9PoSUTx78EVHP32WWULh8PvWhHHXUUyUg7QGRQwbO/Dl/gKsODKP7APssgbW/j2nFOlnhDxpYlQGfmaxEN5BO2xmtdeErQ9sZPLCWduLPj1psgnvUa0m5KK6mvTslP2/rJSn1oXPEvhcPd2iCckeY/7O3CdY82LOD/+QNwOJoXgQTGQY0bccWqwjgqriukiYD8LwDIqck32eqT9W8Q6h+UfrlkpDCjBaHxL53isGO0IxIkCt0E3oUrGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(86362001)(2906002)(7416002)(6486002)(186003)(83380400001)(6666004)(26005)(6512007)(6506007)(54906003)(4326008)(6916009)(66556008)(66946007)(316002)(66476007)(38100700002)(478600001)(5660300002)(41300700001)(8676002)(8936002)(37363002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcG4AkopdiwdITJa573QHXITytNmr8xUNvyKEVbbWqZOR3oxEgss+KNMfarZ?=
 =?us-ascii?Q?cVHJTY4rJtI4hUPqZng1G/QVoYWGNGBISMlu6icI8fhQITOX83OZhC2J+Iu1?=
 =?us-ascii?Q?Fq1oKdaCR9bPqEV+lCMRk7mhGlfQMr7VMQtNGXIO6SLhBGaf0ch9V9HMaXPr?=
 =?us-ascii?Q?jRhJnZTynod8xpbD50lIsSHYr/D5bKhEaPGDarrFmKfx+DLQ8QnJ1WYN2JAv?=
 =?us-ascii?Q?ZSmn4JfVHL4DAHy4JoAL/5btN7PQcQH7jay8Hrggz87oR8KV/uav/uOw8tLs?=
 =?us-ascii?Q?Ie4E65+YOVuswj3GusIvBtIzauGRLx4uOKreGd5I8uQ0q/lfYsQYcrgwU8OZ?=
 =?us-ascii?Q?OI/bbo96GgGDgR4GbsXXfsEAsqWd8U4M6oruZkek5iW/ipWUyN5GkG0D4FJ7?=
 =?us-ascii?Q?PiU019nKdVx4V7/2iLqcSzIOLhFaQauqkKbpoGIWYbmRWg3vYbpsVYX2YlZ3?=
 =?us-ascii?Q?ZHfb+JzNBfgvrWo/C6IzJr77INqVAdYbR764c6Inwk2PjTeI5zQqI35yXSfa?=
 =?us-ascii?Q?lpGVizpukoEqf8HV75iqQIA+ZaVFjwU0tZ55hb5qZY+SDsplcHlL2MJ8rAHp?=
 =?us-ascii?Q?qL7MjSd0DvNe1SfC+W151MNcUTrk5/4GbK6jWO+o3Dl7pJfwc23qVXfLU74p?=
 =?us-ascii?Q?Fh07Dzf7TDjQ0/7kNbkrke4//VPYfQ+8QBPQMWVx31Q9uT7z17cM2Ssjnncr?=
 =?us-ascii?Q?/TJoGjzWNtz6P9A+PR6KSnz5p/UvEJ3XKwq5VrpCRPvTp9jkvUIulVPIS6WH?=
 =?us-ascii?Q?O7U6Qxu011d+HKFRFwZsQzYeVjzxDh9XCQ7kdAmPGTUY2IC3HEavHGVJJw+B?=
 =?us-ascii?Q?34WLk74uKFwUfDgBn07Caswiq9YRmUCUBzgTa2NExojTO4JqP4J1TLEUr0ar?=
 =?us-ascii?Q?PNa99pVl/XWuuNnbE+NVOi47fSq4IUaQHqYA2ughY6s3+K9t/ocZ9Q/x8c/+?=
 =?us-ascii?Q?uPqxlByeOYxg+PwLZkDevd5PIqrlueeaoRah6y21VIx854O6CN4EnuymYPT+?=
 =?us-ascii?Q?hQf3qu5BwNQjg9Da3toReGlSpvqQHkKX50ndsL7uGZYVw4rOCpp24WWPBiQT?=
 =?us-ascii?Q?+hnmjLyFx4dGIWM8shqt64Rbd7/F8U/Kr8VJ+zBb38wHPZoBJey6XMroBHHA?=
 =?us-ascii?Q?EEscOeaeczW3haFKQSYNobmmtGDkII5852xLWrdMweGDN5nj2ryXtB1Emt7K?=
 =?us-ascii?Q?URHJQH2IMzrOLophbAl5gIxAIpQ/MweD3ZItBzeP5TF7V+ewSZ8QbNyHIqB1?=
 =?us-ascii?Q?VqGjMRUYsPUxUueOV2BWizDGapWclRFG2nKT8lQxODm9JoIdRXjUGV9RQZGY?=
 =?us-ascii?Q?5uNdXHyQNGM06bbpr0/zh22kKB99qQoj26M6qRnUYOo11qYLHo2YeNW9C9Do?=
 =?us-ascii?Q?+KJbzGo9v08JOkr5HNPBkangGUNNOUhxQtVB5VsH2NgRec2OKt3M8+nkTv1n?=
 =?us-ascii?Q?qhhSoKCV8otfbNyIqboMnMttMPvwLNtEPeO0Piq09167W0h0FORx9Lqxi/QN?=
 =?us-ascii?Q?QDT0RT2dK6Mr2wEWI+cEzMBoD5I65AN6vaFgCo8/A0Ye/4rANnGsqPFsJgX2?=
 =?us-ascii?Q?pwzw70P9kclHIvM1mGDlkXbPxlOOXSgLizK0SaJk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fd71c2-c164-4368-9915-08db6d583387
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 04:22:59.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWA/an7WY1XVVa6bpLJjX56r00tPSNv+JG6jogQVgkNIEutZX0ycCn7/yxw1DNvkE39yWynS2A3L5ClckRmH6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen Yu,


On Tue, Jun 13, 2023 at 12:17:53AM +0800, Chen Yu wrote:
> Hi,
> 
> This is an attempt to reduce the cost of newidle balance which is
> found to occupy noticeable CPU cycles on some high-core count systems.
> 
> For example, by running sqlite on Intel Sapphire Rapids, which has
> 2 x 56C/112T = 224 CPUs:
> 
> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> 
> The main idea comes from the following question raised by Tim:
> Do we always have to find the busiest group and pull from it? Would
> a relatively busy group be enough?
> 
> The proposal ILB_UTIL mainly adjusts the newidle balance scan depth
> within the current sched domain, based on the system utilization in
> this domain. The more spare time there is in the domain, the more time
> each newidle balance can spend on scanning for a busy group. Although
> the newidle balance has per domain max_newidle_lb_cost to decide
> whether to launch the balance or not, the ILB_UTIL provides a smaller
> granularity to decide how many groups each newidle balance can scan.

Thanks for the patchset. This is an interesting approach to minimise
the time spent in newidle balance when the system is relatively
busy. In the past we have seen that newly idle CPUs whose avg idle
duration is slightly higher than the max_newidle_balance_cost spend
quite a bit of time trying to find a busiest group/cpu only to not
find any task to pull. But that's the opportunity lost to go idle. I
suppose this patch is targetted towards a SMT --> MC(DIE) kind of
topologies where we have a lot of groups in the DIE domain, but it
would be interesting to see if this can help when there are fewer
groups in each sched-domain.

Will try this on our setup.

> 
> patch 1/4 is code cleanup.
> 
> patch 2/4 is to introduce a new variable in sched domain to indicate the
>           number of groups, and will be used by patch 3 and patch 4.
> 
> patch 3/4 is to calculate the scan depth in each periodic load balance.
> 
> patch 4/4 is to limit the scan depth based on the result of patch 3,
>           and the depth will be used by newidle_balance()->
>           find_busiest_group() -> update_sd_lb_stats()
> 
> 
> According to the test result, netperf/tbench shows some improvements
> when the system is underloaded, while no noticeable difference from
> hackbench/schbench. While I'm trying to run more benchmarks including
> some macro-benchmarks, I send this draft patch out and seek for suggestion
> from the community if this is the right thing to do and if we are in the
> right direction.
> 
> [We also have other wild ideas like sorting the groups by their load
> in the periodic load balance, later newidle_balance() can fetch the
> corresponding group in O(1). And this change seems to get improvement
> too according to the test result].
> 
> Any comments would be appreciated.
> 
> Chen Yu (4):
>   sched/fair: Extract the function to get the sd_llc_shared
>   sched/topology: Introduce nr_groups in sched_domain to indicate the
>     number of groups
>   sched/fair: Calculate the scan depth for idle balance based on system
>     utilization
>   sched/fair: Throttle the busiest group scanning in idle load balance
> 
>  include/linux/sched/topology.h |  5 +++
>  kernel/sched/fair.c            | 74 +++++++++++++++++++++++++++++-----
>  kernel/sched/features.h        |  1 +
>  kernel/sched/topology.c        | 10 ++++-
>  4 files changed, 79 insertions(+), 11 deletions(-)
> 

--
Thanks and Regards
gautham.
