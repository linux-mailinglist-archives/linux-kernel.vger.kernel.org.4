Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16D36F7D81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjEEHK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEEHKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:10:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AB2D6D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683270654; x=1714806654;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CMRBUqJZn/UGfn2FdWjwZd7rb6hlKEw1gPAC/0zfjZg=;
  b=iEh6724VY40ZdWwMnQH60Y9DpNT0UhDgnk5/dU02qGBSPZFYFqN/lclg
   ZP975HghxacE6M6mpDQadbURZy2plpO/iQP2v8VF3SzxmV9+L9lP/rPH8
   EbbVUBxFcD/UjgjmKkV+7OIVBLmgrTw5U8+d4iPvZEokhtb5Nhffby9k8
   ZPKnUFFvXeqCM+EEgwYFQgTvu8SYNkzblHKDTgfqx9xNESXh293//tNTO
   88KXcDBvJPe7MfIlEZ7dZimeQ9loB+tNXsktMwTftUvCn7jZ0z1YzjwU4
   kQ9FUI3ffd/vhzFzAF4mPFfN13MKJ8Vq9quPFpvA/ti0wifXDN/e6wIcL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="351284973"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="351284973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 00:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="647705946"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="647705946"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2023 00:10:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 00:10:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 00:10:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 00:10:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 00:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d01ix7/DzgYKNstVpTa/QY7DUn6JYrn0B6MKVCIuTwRu6qZL44wcNW1PZ4I01zt+VKWfModBLPoX0mbgbfWVYONnIB1qbH6UMvZe70MQnNXzA63Jccn+jZdWBHAeXrixaDToJQhAMo5chIzUtk9UIDImZX3YvtSB6UFSmSsujUBYw+QFHJtxD6+bItyCvkVDa8HtvOq173pP02SFdYfocwjJVKYvM3+btbopiioctvKy0GGWXZAARv41VruJG03fBaPNDBHH9F1ncHDOk/nUCcHI33rJJhrh9T/eOI7h6GQ9rQMmiAGSDblTzACzIqfLJmMkyt7owEj0WrJjo6myNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7V4MjHeINe8jXTB2LClAYs1xykN2r5fCNLbOOkK/z0=;
 b=UT88Hy0zZkVzJjG3abm8Fcb0T4saUcr+V3Zfxe3SnPHgnbyAiYBSGaYKk/xUon34nKPiIOGL3BhcFe6TT9KGm7hUgllLPuZYIzlm7EbmFepvHNFMgPPhum1vy9pCz7uZ2ws+Ugh89AGseLnLShy/PA8dC/vcLulVFVDU1g0fvR3TK8OsUNo6gW44yo/bJZmlLIYg3Bfwzn7OnLKYU0zDMni4C8DDQSLr3vNOePA6aN9+UrLYLcdso2oCYTDr5MfUpTS9yYyKH8uF4dw3CHaN+d/AzNqCnRCns1/LDS67AjfVryGlEO7tMCiwI6s69s74slc0EsSmmBy/GCCMMv973A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB8542.namprd11.prod.outlook.com (2603:10b6:806:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 07:10:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 07:10:43 +0000
Date:   Fri, 5 May 2023 15:10:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        "Abhijeet Dharmapurikar" <adharmap@quicinc.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Message-ID: <ZFSr4Adtx1ZI8hoc@chenyu5-mobl1>
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230406155030.1989554-2-dietmar.eggemann@arm.com>
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8d011d-4a4b-4dc6-620d-08db4d37d742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f77b6NmZZtIOsvZWRHbbes3ygKYQu93/kxXZ5G89xfC7lBcB4bFng0L/bGk4v+9w5svtEpMbsCx7Jtw/QLo0ugzTrM6sBoAbzhIBweOF9rjH70YFeYG6eBfd3eTwy5ee0N5PoQ+gpRKq4cfQB/lLkc8gNj7TzGx0S8mDwDaQQn50KOsz4bxOcWKrS7VxY3ePLs6L17Csb01jJgBKboUTb6Fhn/exEX3zwS/PgibNqHRUzIvKsFBfO6fdOUZHyodRzy2pwOgROJrPYEc6m48h3Vfo4ygQYoMc2GZn4zS6U9VbjY3+8pwm3dqDs/TAUM6RPr+8Ra+z1AJ0nu4ng+Z5uCR19FkMkucqSIZpu0KV+Z2hVxxap2FNlDD66e6zTTvQwxPT2ko5n1UVs5i/O9CjU/cEgkoTwj7Sh3W3ADxv2YlrJGodY5NxpBf7GU9cnp2yFB85vVa6uU31GmcYD6oChIPKSMdgj7tvVJTxSCHgUFH1OXnxRaown/iHVCYTnKfc5Ojn57JWJ7yPbo1OsB5Qotejm3uMD9Usc6q4/m8t1/9GJbVKy+6EH6uHlR5Y9ABt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(6486002)(86362001)(54906003)(316002)(66556008)(66476007)(6916009)(4326008)(66946007)(6666004)(478600001)(41300700001)(33716001)(8936002)(5660300002)(8676002)(2906002)(7416002)(82960400001)(38100700002)(186003)(26005)(53546011)(9686003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bicjlivfNIEB0wN488yPx0LpaqHmcjC22adoAUCVBKLbCM7rRzWSfsx7dqR+?=
 =?us-ascii?Q?Gfr0Z6DuhQkU7DNakpR0pMVxQnGPt460tV2WXEpCiEWuzx+gpZU0c2EVpD/d?=
 =?us-ascii?Q?1WOqxh8vG4mvOxXpZ2M7EXQ9dQv9ErFxJd69yBFzkZiprbjQxGqMesow4eMn?=
 =?us-ascii?Q?vaR7iaFgpLQIUVa2o+Q3PlmTFbYjxvAy+6d3KNnOhRycwsALFFi6WjW+NVgo?=
 =?us-ascii?Q?6qmRNeTYD0Z3k1SP/j9mz2cl3kI700kgK0I4l+b/t5lQpGJEsR1BQdwrcI0A?=
 =?us-ascii?Q?/r+vesqtbtUVv05tN2xGKlc6dHQB7pWFnpIRqUYqJqkzjSHFZWEkpJsUJXab?=
 =?us-ascii?Q?9Md8sB8G+wTW6lCNyYfxgS1ZWDRXjnKAIwGjhwLfSkjADvgO4nhcSoH5ahma?=
 =?us-ascii?Q?OiuRwx17uf+BZzCED1ugLlcn5aSkpS69dce6UMIpDHtL8tUAXGFLIzetKRZx?=
 =?us-ascii?Q?PJm/GfzjYp+6/TVYuHKND9YrBMyb4xPR4QybCbfUMDDhyuPbJ2Ln8r2oQxay?=
 =?us-ascii?Q?ZkiVBKHiwH/H+udPg0BfWlcJSGcDhVQFHa5bwFJdKIbv7ncAmYyJ3wBD20PR?=
 =?us-ascii?Q?bs4DlFRx/mDCgqMYtskAY4TeXlDeMFljr0V8I96ZbnxM58KGKU7NPCt40fjg?=
 =?us-ascii?Q?gXBIC7N0lMLxm2ki8OlgKJdeCq+ZR6b44Q4nVG6WO+Erpg5Rl6O8JRE8a28W?=
 =?us-ascii?Q?lcHQiFyGqNUZdIkg4PCLKTGECUXSU1pchLqt9BMStSeRhiQCDrl5WDOhOJdM?=
 =?us-ascii?Q?0pv9gGHavg7sUMuiLGlReTYKZOyvveV6KZq4wfAr4Hz6F4puf2kvnvLt5+pb?=
 =?us-ascii?Q?MNghvFueEgDOjAZHyuH6YHYceKW9kHawiX39zsOj/gGoNjefjX+qHIFYlfLt?=
 =?us-ascii?Q?os60zqP7fsLO/CYMHjLhftQytSci728PMecwmEXIBINqwuJ3TnENHb64AFMg?=
 =?us-ascii?Q?DOcS1H9EmpzI4JAO2lO7YVnhuVTdYYjUTS8u6EwY8u+UFonLP1QvCwaqLh+z?=
 =?us-ascii?Q?llbi7ZkwZrkrAZEJ3tii6liK8YE1xwGZN5GWjf0JV5oa8yWIgRyxIBvJ+Gub?=
 =?us-ascii?Q?E9r+s3tIYEPp2k6Q8O8OB7vYJaIjRLPHPJaI688ugJMFVIoboICePtfIzopW?=
 =?us-ascii?Q?zpXh0RJt71WCAkP8uiu4HYQdMb95xlEzQmEGIKQKCV5lLZxOirPYNpdkQLoR?=
 =?us-ascii?Q?loGQWtmf9JG+KmY+d1thZ4ruz4pCZdVUEtFoIo4CpLPo4foiu3QKHzm8D/g3?=
 =?us-ascii?Q?YuKw74/ZdGtBRJHd8lxfc0NX3vB7HL89fwAkiCuHU3BTxqUldNVvT9VQK6xE?=
 =?us-ascii?Q?pnuP23j5Ei2Hj9IMGA5FQ0NAwPP+gP4US8vs8dVbg8Vyl6N79rQqesEFtOyq?=
 =?us-ascii?Q?qV6qf1NfqhNuPEgYQCaDmKZoNUumVThBkXN9GHusSs+JLp1BdYEelT7Dueku?=
 =?us-ascii?Q?LpBQWKifLu3qnzDaaYhwTjtpNJPLPii1uhdhLwwnz2ok1GbTQ0PpHDJM7Wpa?=
 =?us-ascii?Q?STrrfIEGp7P5ssktFK7dAzuuhgJWPpQBhEw6MCTyZ4LgdMBqdsY7oovk/crK?=
 =?us-ascii?Q?PZmibuF7JEVShhyfnGWTv7VvHN7fp1jQMU1TxhmN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8d011d-4a4b-4dc6-620d-08db4d37d742
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 07:10:43.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmJEcYbMFQsC2fX49oB/m/wUcwXHVhfN6XvpY9rh60wTVuAufYFvjPvuwq07cjoOpsDXz2Tfwr8Ya2MIk8SwgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 at 17:50:30 +0200, Dietmar Eggemann wrote:
> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
> 
> The former returns max(util_avg, runnable_avg) capped by max CPU
> capacity. CPU contention is thereby considered through runnable_avg.
> 
> The change in load-balance only affects migration type `migrate_util`.
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
Tested on Intel Sapphire Rapids which has 2x56C/112T = 224 CPUs.
The test tries to check if this is any impact on find_busiest_queue()
so it was tested with cpufreq governor performance.
The baseline is the 6.3 sched/core branch on top of
Commit 67fff302fc445a ("sched/fair: Introduce SIS_CURRENT to wake up"),
and compared to the code with current patch applied.

In summary no obvious difference and some small improvements on tbench
were observed so far:

schbench(latency)
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  0.00)   +1.75 (  1.26)
normal                  2-mthreads       1.00 (  5.84)   -5.41 (  2.09)
normal                  4-mthreads       1.00 (  2.59)   -3.67 (  1.25)
normal                  8-mthreads       1.00 (  2.46)   +3.48 (  0.00)

hackbench(throughput)
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  0.26)   +0.73 (  2.18)
process-pipe            2-groups         1.00 (  3.91)   +1.96 (  6.17)
process-pipe            4-groups         1.00 (  3.59)   -2.56 (  5.18)
process-sockets         1-groups         1.00 (  0.97)   +1.83 (  0.80)
process-sockets         2-groups         1.00 (  6.09)   +3.83 (  8.19)
process-sockets         4-groups         1.00 (  0.87)   -5.94 (  1.86)
threads-pipe            1-groups         1.00 (  0.44)   +0.23 (  0.17)
threads-pipe            2-groups         1.00 (  1.18)   +1.41 (  1.16)
threads-pipe            4-groups         1.00 (  2.40)   +1.34 (  1.86)
threads-sockets         1-groups         1.00 (  1.97)   -2.27 (  1.44)
threads-sockets         2-groups         1.00 (  3.85)   -2.44 (  2.42)
threads-sockets         4-groups         1.00 (  1.18)   -2.93 (  1.09)

netperf(throughput)
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  56-threads       1.00 (  4.35)   +2.50 (  4.73)
TCP_RR                  112-threads      1.00 (  4.05)   +2.12 (  4.05)
TCP_RR                  168-threads      1.00 (  5.10)   +0.10 (  3.70)
TCP_RR                  224-threads      1.00 (  3.37)   +0.52 (  2.79)
TCP_RR                  280-threads      1.00 ( 10.04)   -0.36 ( 10.14)
TCP_RR                  336-threads      1.00 ( 17.45)   +0.07 ( 19.04)
TCP_RR                  392-threads      1.00 ( 27.89)   -0.00 ( 30.48)
TCP_RR                  448-threads      1.00 ( 38.99)   +0.29 ( 33.93)
UDP_RR                  56-threads       1.00 (  7.98)   -6.91 ( 13.97)
UDP_RR                  112-threads      1.00 ( 18.06)   +5.83 ( 27.46)
UDP_RR                  168-threads      1.00 ( 17.45)   -3.00 ( 29.40)
UDP_RR                  224-threads      1.00 ( 21.15)   -3.99 ( 28.64)
UDP_RR                  280-threads      1.00 ( 19.74)   -3.20 ( 29.57)
UDP_RR                  336-threads      1.00 ( 22.26)   -4.24 ( 32.35)
UDP_RR                  392-threads      1.00 ( 35.88)   -5.53 ( 35.76)
UDP_RR                  448-threads      1.00 ( 40.38)   -2.65 ( 48.57)

tbench(throughput)
======
case                    load            baseline(std%)  compare%( std%)
loopback                56-threads       1.00 (  0.74)   +2.54 (  0.84)
loopback                112-threads      1.00 (  0.37)   -2.26 (  1.01)
loopback                168-threads      1.00 (  0.49)   +1.44 (  3.05)
loopback                224-threads      1.00 (  0.20)   +6.05 (  0.54)
loopback                280-threads      1.00 (  0.44)   +5.35 (  0.05)
loopback                336-threads      1.00 (  0.02)   +5.03 (  0.06)
loopback                392-threads      1.00 (  0.07)   +5.03 (  0.04)
loopback                448-threads      1.00 (  0.06)   +4.86 (  0.22)

thanks,
Chenyu
