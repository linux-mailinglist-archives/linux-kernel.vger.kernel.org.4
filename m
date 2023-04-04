Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA946D630A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjDDNeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjDDNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:34:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED5468F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680615246; x=1712151246;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=72Ss3muHu5I0QauyhKoIaBgr/cVN/Jj8g8q5aKxzbE0=;
  b=Y0ZzsOuWcX3ymRvV8vPF2V7QGL4Tc4laGOoJnllDSqQzDRpNJm5ExviH
   8oAVVGnwTX68FHjqMS7uPlvLhPcP2ZJoRAHxj9RMfy+Rv96s/y8Cq//hG
   egdz4EZRG+qcFti4W3oWn75AWo/mDjQqcQ9hYPX9foVQTV+W4u5hBLREr
   Xgc5EW9k6B8pph5ncP1GF1Lf1CpWmZOEh4Xs98jdFMc4/hrYl0zA2NEah
   o4BK9uC177lyPFrckZ1rIHWW0qKqoVM5OwMe1bBzdqRvKtr4yvoe42FgP
   RO+Lbpd6c8WMBuZ7jg4oXhDNq924liqEntpryvYsl3OkEZ6ENrWcEA+GB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330769588"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330769588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 06:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="797519887"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="797519887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 04 Apr 2023 06:34:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 06:34:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 06:34:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 06:34:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 06:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLBXZPkAgcQXvxkRAyohrVURIByBar+BmFSUgxVyEAa+X9tgGqFzvG8mh1HRPPlChFb3MFNiBqNWV9PzdtUhN+QoolDCHetpcRtjJCpVTCMjWzRZzYy96VRwNlay6egSKpxE3AFKkgODOqYx+hTIIh5Nj3SHiBfhgLkpQ+l5+YIdvOOe0VsS4YRCe4i2wniMJXw5BhOHITMPmO/0zK0KteXOF933VVZUORqC4avsy4+oRev92rTwzuvoY2yw/gU2EPpl8d6oURcWKeJeiRvS92a9xMiIK7RpEfyIjb7L9qgYsIAdxGoOate5i9704ik9Ty7ZsGsudS2EtUB2iNP1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czB+1eMfXaTmTzoPRPx+Mc075oeYQD/62vtaE+UOTXs=;
 b=hMEw1W/OYi2YpLcxT7O7YvWFgeJO4x8MB/Yw8GVVrKfb9ENerwL9WzEHnnlbrTHXMexxVUvj1SZVXtG63z95L+J+h8OFDeEuI7VbZ0kA6UQP9x481qRnZIzMcMKwi9DHpgXDd8Hshc7tv+MRb6S0P8rLL8RPT7YMAq2s8jJDa4DEWdCoMooseB7yYruD5Lve3vYXNo/BRI5BZkTYPuEYIZ1ZwbXCMsb33F8JZ1A9ywPvepGWKa0MMALOEQwmQIlNEwPSwxQ7oYRWHGUl3Pj0mEnxCmYzJy1mB4pIqpqoBr4X+X8FZwebUGLXmUI9zhKTVIAoQs5Wlt6+YX+PuNOATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 13:34:01 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6254.034; Tue, 4 Apr 2023
 13:34:01 +0000
Date:   Tue, 4 Apr 2023 21:33:48 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230404133348.GA50663@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <ZCve4JaH8EhxBcwQ@chenyu5-mobl1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCve4JaH8EhxBcwQ@chenyu5-mobl1>
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: ab84b177-c683-4d6c-eaf2-08db35113fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UMOrN9sDF4J71lutO2VkwwhhUMCYtyMFSTtOI0NYWlB3Ok99L8mF4uZEypv7P6QjWt/o72TNQAgUzhtJ5XdkVxp1oveTyVfs/1hpxjy04JDOo4yqCdevUeUQrI7SivQnpydhVpe2MXDOF/k8FifZfz7b5ULTJu1CaIUFYPxICBU8qJtuCnLbf1d51W4R/Jw3fBgZlXPc5tsWE8gRpefThcEWS6q5JLwrST3wO3L94Y2A5g4P1BqL2oMkTejfb2hVwwjmuMGyZ4ixMzNUmfLhSw2APP0KLlLFxMun1BXMR4MP86C+Q09vrSzU8tObO99X+cQVTD8itKubkZSNAudXHPMTXAy92aF8inceaqr+K/SzsjH2C/zQn/zdwYWd3gTAIrTZcgaL6zpugtCf6Nsh2MfA1jsz5sX6lq2xhOpqZz6V5u+x/eo169ekxE+KjfHkbIbcBpKJ1BqjUaQ7amT28wHPQvCFz4LXJ7v0hgWsqMMpHb/OIeLSsrXr23/Dv5DQ4Gv4H9f17HSQRo4GN8X5SVLMRJncL6+vQ2V4kTY2Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(66476007)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(8936002)(6636002)(54906003)(6862004)(38100700002)(7416002)(41300700001)(44832011)(5660300002)(82960400001)(83380400001)(53546011)(6486002)(186003)(6666004)(6506007)(6512007)(9686003)(1076003)(26005)(86362001)(2906002)(33716001)(33656002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukrHD+/51Emi+kQxckXkZJ0+hWgz2ZjpLmqhI8+x1mLsbymsHDOFqtCl1COE?=
 =?us-ascii?Q?pE2WN4WUPQJaAlNsGuxh1br4T2VHdv/5XWkIBuF/0KR1SFRMSsuYAu67iCgE?=
 =?us-ascii?Q?pkRMY4myWDYT2PExUf7ivKa9KByDg6713q7+d2p4CrkKodQH5szCUH813Lvh?=
 =?us-ascii?Q?b3VDvwgjpWcimbFOAfashQFthTtUwzii5ZebWF2AfLSG6tLVX09ePv1z5V+K?=
 =?us-ascii?Q?bC31tswtYe/bY/vtz0mYUQvaNdYwUahUTLL+WleZH5mplf3iLlPix/iT0lSg?=
 =?us-ascii?Q?7Bz1B/DKYwlT0nXPzR2vbaj2uXyLdAoS/G3bOJbGl6T61ZQYHWUCRcUk+hT4?=
 =?us-ascii?Q?PJldiw7qXuhvLL6gH3XrXKXFoobrsQnDKCggtPqpl/93Vn/OPnob+tMIRx/3?=
 =?us-ascii?Q?De9AA9ePy6WrdSu+MUeauHLVawD/XG3rXmrikInRNRWL2Os+lVVQJDpGDvm0?=
 =?us-ascii?Q?qF5DmvsogrlWA6zIHJc/j+gSuYSdmR4WJfYkYVU3trU4Bn9DSQ2GEscZznQ2?=
 =?us-ascii?Q?Umkk5zHQMf34qEs5jHUKxPAMTatohEsZz8Ha4y17buJY1kwtp6BDvhYInNPa?=
 =?us-ascii?Q?mnumgfQqdQebK1/g8aDz3+3zIbulhjPzRRqt4sOAk3enAtvPokW4uywvU4Ja?=
 =?us-ascii?Q?YKv2P+nNOirYf80r6AdGILgAB8SyMlPthKXVAQe+uZz2R2Zcapf/VHR8qg95?=
 =?us-ascii?Q?Rl5T5lcppE6+RrUvhd5QPef3l3r0AT9vtI1fW5m7nHJszMIQjGCjVwa60Of1?=
 =?us-ascii?Q?BdcA65lW8l34Mtzq2698Gsmwi8qJa2UVxKxbvwllqwVuyZiQiduu+9THH+JU?=
 =?us-ascii?Q?X5XGnyjcj43lA4uOO9yEp4h2+erq7rqqEBnXlN4IChwlhC1hXDxhA14Ij4DN?=
 =?us-ascii?Q?On9o8G98bqJg0OcMLRCG9nWv9pMgiXn+OrC4SjMIuUYzLhmwEhabwQmduhli?=
 =?us-ascii?Q?YsG4sy83lT4+ebK6pDqjXofqqL67IGH1wxJEKLOYWsbeYPatOnyVoccfx0BC?=
 =?us-ascii?Q?EqgLWDCfPPWxrZeiTlBhkGBs3F5ZOCuZZpLzNC38Ok+eNQn8NCGpN0THwUPG?=
 =?us-ascii?Q?wtRjraMI4tPBe9s8GVQHs0rHjK9c0Hj9eSa41xxU4UqIGWp5nlL0mBZxl8FD?=
 =?us-ascii?Q?KA4p8VQ8ee9/fJVmn6px6/IFkhrOedHxH5nGEvM6unYKcKkA9UmjBuAU6kTH?=
 =?us-ascii?Q?C7XMnQ5+5K3kWeRTj0WtL0HjKw3BN05D3RnomkjwilFm+nCeZGtn87vbJVRy?=
 =?us-ascii?Q?SfRT/njAWuthNcgumVZ4YugVcS2R3pBIGrD1W/mVOKY8Srs0TySdWyt/wDsT?=
 =?us-ascii?Q?kXvwCPqunv8251CjKQIZuBBv4Bum13BryBxuzgIFAc48q8k29U8RYrXsICUC?=
 =?us-ascii?Q?YXs+E95nm1ssygD2J6xGrtIcS+ngnzv74NwlYTVD2A2enOLvpPQen4cBJA5W?=
 =?us-ascii?Q?7RJZMbkqci+HhesU2uuiyL2k6ERk26nI5n5oXCLpCG5g8OeXkVeRf35wctty?=
 =?us-ascii?Q?AyW5eXZtGhR2/vuye6u2SFMLVC5buMoeEVp82Cc7B59FK+8ueUlfon7Ex63a?=
 =?us-ascii?Q?sr8hpivmjr2j3MmEGolFIyR2ljBQeETEpxygngz2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab84b177-c683-4d6c-eaf2-08db35113fea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:34:01.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDnxOkTMhq34dF5Pfw7D8fdnsHNc9uDU/yaibkaNjNi/SAIwCbIaZdIg9Wr4Asvb9Nr49+UHZgLTK4iIYE1etQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:25:04PM +0800, Chen Yu wrote:
> On 2023-03-27 at 13:39:55 +0800, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > cpus of one node of a 2sockets/112core/224cpu Intel Sapphire Rapids:
> > 
> >     10.01%     9.86%  [kernel.vmlinux]        [k] update_cfs_group
> >      7.84%     7.43%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > While cpus of the other node normally sees a lower cycle percent:
> > 
> >      4.46%     4.36%  [kernel.vmlinux]        [k] update_cfs_group
> >      4.02%     3.40%  [kernel.vmlinux]        [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side.
> > 
> > The reason why only cpus of one node has bigger overhead is: task_group
> > is allocated on demand from a slab and whichever cpu happens to do the
> > allocation, the allocated tg will be located on that node and accessing
> > to tg->load_avg will have a lower cost for cpus on the same node and
> > a higer cost for cpus of the remote node.
> > 
> > Tim Chen told me that PeterZ once mentioned a way to solve a similar
> > problem by making a counter per node so do the same for tg->load_avg.
> > After this change, the worst number I saw during a 5 minutes run from
> > both nodes are:
> > 
> >      2.77%     2.11%  [kernel.vmlinux]        [k] update_load_avg
> >      2.72%     2.59%  [kernel.vmlinux]        [k] update_cfs_group
> >
> The same issue was found when running netperf on this platform.
> According to the perf profile:

Thanks for the info!

> 
> 11.90%    11.84%  swapper          [kernel.kallsyms]   [k] update_cfs_group
> 9.79%     9.43%  swapper           [kernel.kallsyms]   [k] update_load_avg
> 
> these two functions took quite some cycles.
> 
> 1. cpufreq governor set to performance, turbo disabled, C6 disabled

I didn't make any changes to the above and then tried netperf as you
described below, using UDP_RR, and the cycle percent of update_cfs_group
is even worse on my SPR system:

v6.3-rc5:
update_cfs_group()%: 27.39% on node0, 31.18% on node1

wakeups[0]: 5623199
wakeups[1]: 7919937
migrations[0]: 3871773
migrations[1]: 5606894

v6.3-rc5 + this_patch:
update_cfs_group()%: 24.12% on node0, 26.15% on node1
wakeups[0]: 13575203
wakeups[1]: 10749893
migrations[0]: 9153060
migrations[1]: 7508095

This patch helps a little bit, but not much. Will take a closer look.

> 2. launches 224 instances of netperf, and each instance is:
>    netperf -4 -H 127.0.0.1 -t UDP_RR/TCP_RR -c -C -l 100 & 
> 3. perf record -ag sleep 4
> 
> Also the test script could be downloaded via
> https://github.com/yu-chen-surf/schedtests.git

Thanks,
Aaron
