Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1A6CEC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjC2O4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjC2O4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:56:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6AC1FFB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680101768; x=1711637768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HI1RvG6giyuGOz1o5b0MMYRFkrXPhjsT979sDN3+zp4=;
  b=cg1XqYMD4+Mau6AFYwSTt7wy/C8/+ATHOJL2OlcSmOuMXyfhgDE/dWQJ
   xCDKzdJ/ffx/xy4XPxfetJe1tDoAXDEMGPkSZlgkTe53SW97vkHQyD+46
   +q5Y7cd5uQIEPDuPLo8kQeYH/CnLaopnPaOL3OceisdowS8duW2nsMhN+
   CYmm5UD6anJjs52thgk5wsSH7CoZJmP1b/2Ria9F7Ulfw4jC+kYfCV/dU
   4Qruqban0iZtX9zxmzm61VTbIzgUs5mbfufepi4rSek0DCm9o9ytmd/+V
   M+c42Tk9yQxGRpqZQeNPog00aZ2otFzigxON+0o9K4dtMaF9NEWVK6z0N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427172190"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427172190"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014045166"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="1014045166"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2023 07:56:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 07:56:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 07:56:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 07:56:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 07:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofg3CXHbBRIO5kJEenUWEwcg/Y9a17DxBm8JANhEGUrVYdPPhW6CWTtm8uDg4t12eOPtKPORWNxCTH0plh7K/zcDJ0u9uw3H2A/7wBYf1KRHMW3DnmfI7B1/cncCXAWBP7V4wB1wpWv2V17mKk8JflYZlJOgFL63JH4zhYM27uelI/4e01mtUCUAMG8kXuRWyFcziEwi71gdTEmPAoMvhA1u96ukfpclR2AAVcZKsprLh8Tulot021sqO8yxrSdkwF759zO0ne1ZH9KyAr4VmQvoqVrwvT0U2p31KAC2IIQfOJhXqYHuwpDgetuRsUBso8F9PFIG2jkEz1yYIo6yAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tG0CfUWqyLI7BRkxEH3hkCeITX7UUynS3X++CNXNnk=;
 b=Pz66QIl4K9rhxMDv0P9GhJb/6lGb+wn0GMK84YgVb0lRmtf6OXsNaQt5pDkgPWWcYDGQl9IqtOQm2ieQIMLAo3ESY/AvkUMIJxuhWYiKm90ArH8/8W7sEQEaAIgLtKfood4E06+J79GaUSJ6CDuu6vpDN8t73QosqFiT/Wu2fhSakjyJbJPw9SBkHMhcNBkWQXUK36vYVQ6RkTMldjoKY6v6zxASfhShmcp4tEmHqf6TMZreB2WZfPExp8eb8kCnSylAEEhzX1sAfgNZ2QkK3aQE5TLkFvDqRoRwWx6fB9K3im7DV2F958bMpXa2q/ZqcMiuOYuNMJ0Uub8yahM0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 14:55:59 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.038; Wed, 29 Mar 2023
 14:55:59 +0000
Date:   Wed, 29 Mar 2023 22:55:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <ZCRRbljuZOZ0c/SQ@chenyu5-mobl1>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaf8428-91d5-4954-524b-08db3065b4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2rUlvsrVu2cPqALDUvIUwcfFmWZhTrBuIhX1Yelf757Am+XfUOEq5hZIGUzvWsiGYGzA1zjTWythCgbbHsc6OKgBf7TlzfpRb9OUdkoFn22AoU4RdLfdcTn1IsImJGge1RSZfyM8B1HREYYsOht6OImCThV0wrJrCY8N/v/wUvs1MjwzQh0vrbC0q8j4Se9BxRsf5ukAcdkfKKhCNia/XhWLamz7FYKl+c8Fiu3ONuvT8EwcMksjMlsJMXRR9xMVVUst7gCzdaibL+0BoNP384k0u9NfeK3pzhcPzBkX45noncZzJ5RR8MHAP7pwamLuKWojs4P+JqXmIktfEUZgXVk6+H0pJDeGNPAUOkxfuJ9g0QSKB9RVzizr4wspG5wBM+HGwMnoySC0zZYNv6UdlQ+H2f/EkHaQPqgtsskWJ+R0fBjxQSHMxBbXV7cLfgsYX9D2SA4vjhnoEmwst69NeppXyn4uXSjrSTguCXSXn16msS7yjr16r8zweXb1ygjmGbOPDF/Q5082FsYAiW6tjkQIbrdn8wl8J5UFbkEfxLbSNRn6VLsTDl+x7hBKz9bfA1J1DdPyI4XaPlvN+cT8EijcqGWqvczGkr4/X+3ctY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(2906002)(82960400001)(38100700002)(8936002)(4326008)(41300700001)(5660300002)(7416002)(86362001)(33716001)(478600001)(6916009)(54906003)(316002)(84970400001)(6666004)(66476007)(6486002)(26005)(966005)(9686003)(6512007)(53546011)(6506007)(66946007)(66556008)(8676002)(83380400001)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQEb+IDINqF5Mf98DF4z+N/nmOKOhaOFvZP2A+hFSq0eA09pPMn+xcuwg1+d?=
 =?us-ascii?Q?pSyeyEvgDk6vZuGPXcYICsifuzBP/6jtGeJPQyGdlmfreCbECExeDaTLCoV6?=
 =?us-ascii?Q?8t2+G4kUAr6lyEkWqip9J3kq+WdR2viKy8TGsByOq8rPs+oimjDYhIj9gkOK?=
 =?us-ascii?Q?ZhMMwtosrZ6aqfQr5eD2TZtQmUc2bqQENY0jyXzpmMO0qQviC5bGuiSsJ8S4?=
 =?us-ascii?Q?dS/Eg27xjS4xFltZR50SQOAhywknyW1Gy9aeSNmnOcdWqUTbnd4651KUijjf?=
 =?us-ascii?Q?YY76ee3bKadckW0eKn2kdCXJJvG3Iefr9ACzbJWS/eCx2WAvOMa3ux/cD3dj?=
 =?us-ascii?Q?1ADIgUKUXkadWTxG83t77mLmvj0H7UKEiR6qWeggCVVUcsYIt44z6lDadEYi?=
 =?us-ascii?Q?HOAVQE7QEN0oCpJcbY8HmO/Qor+rTLCy9LBhOXuvkZGFpX166FqYeywvgAK1?=
 =?us-ascii?Q?lnt4cKmadV2KD1lvduhDxvQZpHqMBla5b5faajOKneTdAzfjIIMuRQIJzcY+?=
 =?us-ascii?Q?6oFjxGrdunZYYkg/c6HNI1CZqvadC8HFbGp0HMAys4EgyP3XR9apKBvJJp9u?=
 =?us-ascii?Q?SvIYI7NSjcLMa3BNgKUnBMxt0QeBfvVwAxX8KQqAojY8Ga8mH2T7kutj6tJv?=
 =?us-ascii?Q?rV1NXVqe1aDAO2FHig1IDvYls9RcRlMB7zJ1a9ASfdo1XYL3rRlh9jVNH7Pr?=
 =?us-ascii?Q?JKj+YHIHYC+qflW+hOUdyZysFt4jXzL+DSt4qZRJoW3uslkqYOYrpsPwgexK?=
 =?us-ascii?Q?l44AH3B0+Xq2RTkfvE5nb+OVbkJLVtH0GDUxwZ7r67C7ORepL47S2rv2A3S0?=
 =?us-ascii?Q?afXvjEoWp9Sd3m97XgV0iIQbAnDCKL19lWpZxdgAmXQejrR/wEeSgc9+aaBe?=
 =?us-ascii?Q?0G6cRpSYVZX0Ih7DWJVuYIJigP5nuKjpFNLEu3X5gVlIIJbYgVcJ3Ry2Xz24?=
 =?us-ascii?Q?Ohq8hz7kW5Sn6OdbYhffk1pLwE4akxpGBvPiI+X/NUP6EfC1uAr2qFGJL97v?=
 =?us-ascii?Q?BMzYAL2+WGRGQbC8shp9D8XOImrPK4JW4aM7GbyyNwr9TemyZHRGOJlND3BA?=
 =?us-ascii?Q?M3sSTIwJKBtTbXTgM3XnG2fUN1vXHVy+xdecT63YJhiE2VeYUrTiGhROIL81?=
 =?us-ascii?Q?+ggAK0JZH64PU/AtvozwtrS2wpG5Z/Fx2/mY6S4X386ZFaDt7GT2+tEjFvUO?=
 =?us-ascii?Q?7rk+WYMkx/bOL+Quht1EsfuKqBn6GVaJz+iaTLUBY5epLHTn4uEKBsq5o2xx?=
 =?us-ascii?Q?o2Ea7V+Hri51gf2BmDNXfHTHzvo9Q7N8r31UWV/cjLvu261ypdCyqZ/cAXL9?=
 =?us-ascii?Q?Lo/v9Aij3g8wU3H/R7KnpSgl+7yBYMvku56lfnA9xfeIFOQZvnCAq/7OnM8W?=
 =?us-ascii?Q?/AFBEd/inmuSjQgqkpQ0y6UNu5/OB5lZwYOgSwKW/uoaxe44ZY8QWhr2twAg?=
 =?us-ascii?Q?bwz9J7hsguQJcai5B4qW0IZSGUT2NkV7gBnhUEnuaJhuzPasprUpeMMyTkv0?=
 =?us-ascii?Q?2cf4pOLOEX2VY1GTtL1o9U4i/Vn507FwSSMbCUGDSltedviV9PJ6n4Nk/8pY?=
 =?us-ascii?Q?koV+N/Gk27t6DcvCm4RUtAalYKIc0oVEy/CLlL7l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaf8428-91d5-4954-524b-08db3065b4f8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 14:55:59.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE0CbIonWwL6OemJHp9EDGqFM05NkFJNGYvyl7tK2GFpER1XXf+iVUT6s3YgkBFkdc++/d0QtZegSy+l1lFlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29 at 14:36:44 +0200, Dietmar Eggemann wrote:
> On 28/03/2023 14:56, Aaron Lu wrote:
> > Hi Dietmar,
> > 
> > Thanks for taking a look.
> > 
> > On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> >> On 27/03/2023 07:39, Aaron Lu wrote:
> 
> [...]
> 
> > Did you test with a v6.3-rc based kernel?
> > I encountered another problem on those kernels and had to temporarily use
> > a v6.2 based kernel, maybe you have to do the same:
> > https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
> 
> No, I'm also on v6.2.
> 
> >> Is your postgres/sysbench running in a cgroup with cpu controller
> >> attached? Mine isn't.
> > 
> > Yes, I had postgres and sysbench running in the same cgroup with cpu
> > controller enabled. docker created the cgroup directory under
> > /sys/fs/cgroup/system.slice/docker-XXX and cgroup.controllers has cpu
> > there.
> 
> I'm running postgresql service directly on the machine. I boot now with
> 'cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1' so I can add the
> cpu controller to:
> 
>   system.slice/system-postgresql.slice/postgresql@11-main.service
> 
> where the 96 postgres threads run and to
> 
>   user.slice/user-1005.slice/session-4.scope
> 
> where the 96 sysbench threads run.
> 
> Checked with systemd-cgls and `cat /sys/kernel/debug/sched/debug` that
> those threads are really running there.
> 
> Still not seeing `update_load_avg` or `update_cfs_group` in perf report,
> only some very low values for `update_blocked_averages`.
> 
> Also added CFS BW throttling to both cgroups. No change.
> 
> Then I moved session-4.scope's shell into `postgresql@11-main.service`
> so that `postgres` and `sysbench` threads run in the same cgroup.
> 
> Didn't change much.
> 
> >> Maybe I'm doing something else differently?
> > 
> > Maybe, you didn't mention how you started postgres, if you start it from
> > the same session as sysbench and if autogroup is enabled, then all those
> > tasks would be in the same autogroup taskgroup then it should have the
> > same effect as my setup.
> 
> This should be now close to my setup running `postgres` and `sysbench`
> in `postgresql@11-main.service`.
> 
> > Anyway, you can try the following steps to see if you can reproduce this
> > problem on your Arm64 server:
> > 
> > 1 docker pull postgres
> > 2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
> > 3 go inside the container
> >   sudo docker exec -it $the_just_started_container_id bash
> > 4 install sysbench inside container
> >   apt update and apt install sysbench
> > 5 prepare
> >   root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
> > 6 run
> >   root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=224 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run
> 
> I would have to find time to learn how to set up docker on my machine
> ... But I use very similar values for the setup and sysbench test.
> 
> > Note that I used 224 threads where this problem is visible. I also tried
> > 96 and update_cfs_group() and update_load_avg() cost about 1% cycles then.
> 
> True, I was hopping to see at least the 1% ;-)
According to Aaron's description, the relatively high cost of update_load_avg() was
caused by cross-node access. If the task group is allocated on node0, but some tasks
in this task group are load balanced to node1, the issue could be triggered
easier? echo 0 > /sys/kernel/debug/sched/numa_balancing

thanks,
Chenyu
