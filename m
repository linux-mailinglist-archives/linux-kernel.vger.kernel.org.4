Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177A5B3408
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiIIJdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiIIJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:32:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B9139882
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662715831; x=1694251831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P2uJueihAVUXTak/n47GkFPQj2pRm4YXRE3uOXR2bRI=;
  b=EpAdTFljj+4JF2unx+dXTp7Xb7cJeU716OEvBGWkvEEl7qxb1bmYwmxz
   CPfFlr5T5Ig7js1BzbVpn06jB8qqIyPoMQghdrID3Ck/LmGLu9D65U6LX
   JUKZkTo2qFi03Sf3lf+N5m3j5XZTUczBJB7W4oNzBav+GdV7rU00fniYb
   Tfw46r+V5mQ/EeFU0FJcXP4FWp5kriVm2svH092SVD3kGXITXo9pTccte
   65bqbBI6U09xJxJVZNMe4wsSGm3NNlojhVIs4WPBA87clwmBTrsfBFNIH
   GxlqHFft0UJPJnrTspB2e1QcF1fV+hkBOj72uljzAlu+9cf6YgMmnBkcP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359161827"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="359161827"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 02:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="611004853"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2022 02:30:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 02:30:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 02:30:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 02:30:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 02:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT7Oq3Mjjh8mhzwhKOcsQ9PzvHNEHS5+TxVUNJp3AO6Yz/haEt8ZQlcfqHkFrjYdb2U28H36UZPVHm1fgvFzKgAUdj7E7w0QQ2nbwxfL5eQeH+Wzz8jNEAHqz+9zF/eWfAUddx2uXrAsLRsBVR84ZW9vCfIYPHKmm0bLcrozkQSr5//V+W8NmyYlzAumfelP1VbYmy4/UKblqDXUMzLRf+kjgOSv9CXILPFXneY48PM/1pd2PcjxkoYUF7vqkKxu4IMbC2waJOxc1ZzhT9omrGqQsPrm0uIYwPmDxGHK/82pdWRyHwIQ9Mtw76vmlUwZFh1EhNCJ0HAs7oJQJrh/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5U22XJqWlFlzpACjGSxILPOwBKUDbryrTQy3XT4lkE=;
 b=mD18WfV2NBqLyTQ+zT10X90fCer6RWmtm/o4S5h3tyAy77vdobZNqWPpEbm5LcbTCwsYgsYq7znYlvy+affQ6uRGGqCD8iRt6xnMpTgCkRfCphmpSTVh7tHzDrvKqMsZFtgPUoTD5w99JwnMQ4U2yHgZ/TP7ZU4JQUySGe3I/Xjct8w2SKwar0pUYrof4sV07Yv9g74TIG8NALRjxO9Y+GbUMjmmm6FLEIAwBPUjxBR9sAmlg+qko3fafdCkIUrsUb/jTiQUGS/EbdvUWLrPT8mZiFw7cWbWZW7uo471W7wLeLPLexkJUrcZgZYzAeJ86TDMB9nlehULZpzmEzbthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Fri, 9 Sep
 2022 09:30:11 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c%6]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:30:11 +0000
Date:   Fri, 9 Sep 2022 17:29:58 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v5 2/5] sched/fair: Limited scan for idle cores when
 overloaded
Message-ID: <YxsHljS5uwt+cNF2@chenyu5-mobl1>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220909055304.25171-3-wuyun.abel@bytedance.com>
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e36ce9d-4a00-4065-927a-08da9245e4bc
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rk3z+ecuG3gcca3cazqSC8l7ZEwxHRen7N4AfLMmOXkBJKoHtuj+Ko0hOReroJIYLIc7m9cSuFG7dbGqWqDH69jkz7uHCk0S4yrGmKGkI4gBXf4b7XUsmP3YoOAK+bgJoGxGdpR0EuJJ5JLylIKpNkFmVNApxkA/muajfGZgEyPYeBCq+k8Z2TAZj8NiJbEGOa5IsEMA4Pwe0H71OmKY6IcFVCb/peM86ZW4oQPCh665Pj5UCqUCfNP9rP4mdcjOHQEj4yfXEyVfb39xsZq6O/Jkix+62PMN+fGuDP3P8h4vEPD++umP/bTPFRkHuaP6ve1eHX8JyFRFbR3MS+DAomPO+J6X6YrXwpFDbBbYaGCHYlYII64WqwFw3+NN0/Uv5BU2RACJuhEm4xrZV2ri3eufijWEgawdSBPlXVL7D7cznvpGdxc4AgMDqkfUK/BqT3j+/t9Qrzx8BJwUqsjhtPfOpCr2OoQ4/gthfjTSpC6duLCg4/BdOhZaUkFGXo+k6pgBN0TgfiKybQPEK4LnXDM0xgPITr6YWKnBHkBmKAXABqg19bLQx+3fp8+cDc/AEx5AlK1X9/6aFOjDVWlJem3oMLUneW7gTuxuslUBFGgwiSYJhTej8+ZuLQlqijuo6ZLRrlaDfgpeUDK6l3ZVP9YWUxwtVU3pHvgmIlQ5rYrFzIZoqBsD4gxPX33O6UFkhvu1EH4LToitt4/Tw1FY5I9qzc8Id6OhsrXB0c+ssWsXWaETlSc/EHyYU8CgIvXh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(38100700002)(186003)(66946007)(83380400001)(66556008)(8936002)(5660300002)(8676002)(4326008)(66476007)(7416002)(33716001)(2906002)(6666004)(41300700001)(478600001)(9686003)(26005)(54906003)(6512007)(53546011)(6506007)(6916009)(6486002)(316002)(86362001)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4hnQ0Ym85HBmo1xe0792j6D0Z7K7TYzauPRl2BTSKQEncXzwky1eptoyN7C?=
 =?us-ascii?Q?sPYf6rkgnZUREtyZDbduRzwHTKh37OzXTcwc4wIXUJvZVsr8VB8ytJBZZC45?=
 =?us-ascii?Q?/djJApyTEaq6Kjd4PjnxCFDV7vjdBoqwNVXn5A+B50kFhNACmezgDyTcWT1L?=
 =?us-ascii?Q?a2IMFgHU230BVji/7YKxsHkQpVZYJX/z38SnkFSpbqVrNpP5UVz+JXf1hK4q?=
 =?us-ascii?Q?nVuWhCfkLts2HuMOio9jvlLXDSUuoRxVe5ww/JDAg+YO3Ri7jP+umDycCoCj?=
 =?us-ascii?Q?0p9NR5bjEdRj/fbw2WL6xHVnFcUetlMKxemzOjcua6in5Tl0NtJxjfhBXAD3?=
 =?us-ascii?Q?rkF6NuZ99JtW+jlRDiD/IGIEpXCs2Xc8N60FbsUyq+yumdhaEkyKUSx+OGLf?=
 =?us-ascii?Q?ZTIslvHhTDDA3bEFBuflDNLLboa3aWXCCWfDCThaD/BT7+qC7mKghhboRREh?=
 =?us-ascii?Q?+uOIR0vftiat+sgA4bhq8wDCyM4VJxuJRfZNI/yPRypDpEb1gOH7jqk+UJdk?=
 =?us-ascii?Q?7Lo005cv/3NcvG3OhKE8mrSA1J8Si8YdRTL9bUqCJugBQDQemtBgD3e+RXLC?=
 =?us-ascii?Q?S12AYbADoAHB79Fv5as9LCwGkCIDPVmJwiZlMfNy69mFX5rTuxIn1pwM+/c8?=
 =?us-ascii?Q?aKGho8d1K4Qf6VEwyMO1YoWQlCyeM5B4viFbWhtVu+SnWZoxKhWMumoXvKBM?=
 =?us-ascii?Q?CL45EGc5n0ZkUk5MCsN+dQA/6w7TlSdY7N6XfIxqdAWSL2A67FC6C1bzAMvW?=
 =?us-ascii?Q?O2hr7h+FeLT0nhdgfouSSqiqkwbFTiX82XuX5gmTlLwVTrPFWPczlNu7LhbD?=
 =?us-ascii?Q?O7VNQh+HQTs4mevhG4KJJNIJsrtkeLrKMwQiXNJtOOZsjsg/EwvJn2R1VN85?=
 =?us-ascii?Q?laIgDtSjmOcFIne8enJXqWwf/F4o4uAlF146T3Bdd2CpwJ13A1ggOQzqVAj4?=
 =?us-ascii?Q?RxlGF3VYSuJfA8QxAaQ1RNb/7xpNS9qSBCJg6YZ9vO6h8eO8a6nBtVJmKlcX?=
 =?us-ascii?Q?XlfSTe4/hmv4H/ts0ldrSwu5BuTrKuUNFCkTs7wT5g5+HE9rIKAQnHIY+khN?=
 =?us-ascii?Q?2u/3Tgc3Pf6MVO2SjxaHFww/aUi2GjF2Qp/nJjr+p26tO34WJncbjvQGBIGN?=
 =?us-ascii?Q?gmt9FMG498xRFDIGPCnhoV2mk9vvmq+nxtUEQI7fGU/TZwB2K8GzeIX+655q?=
 =?us-ascii?Q?uQYWfyLRPDWq9jw5IF6AjBuyQGg29Q4xGDYzsXvyDQ6fIZvGpdPt9hb8lZNM?=
 =?us-ascii?Q?yijaC8zrOB/IGHeDwj2+Uwp4I8x0osw9WXOpW2VoOKzoX2NBM/cSTxZtaDy4?=
 =?us-ascii?Q?sjSezBIRT+n5oA01FLB2LaUUhNuoZQ2osO/26AG/PJVeEt9b6sQtmrdFc2gd?=
 =?us-ascii?Q?cg3/tvSzLxC50Xh9l2zUvG4rpSB3tp1xhtAGCSoASeoQ4DEryNtBxiLKi35Q?=
 =?us-ascii?Q?86vJ+HXx0dUsh8weO3mF6ZoAWsJLTpM0ELNM/KUA/n7/ryU1vcI58ZOMU9CY?=
 =?us-ascii?Q?R0XT8Lo5IoQc8q5YI95kGPOXDBCQxNJj1qwlM/8KOKTjkFBCfM5yOpuLIU8j?=
 =?us-ascii?Q?ciLFwInROgR1UPWAnaJ2ebh6YTYLbtCIe6L7QiyV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e36ce9d-4a00-4065-927a-08da9245e4bc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:30:11.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r9eCcbpC/vCLL4yyTX+UleEMBr7v4yTTzShMnKnqQIqgDcdOKg0LA/XQs0+N9AUhR65O4E+/1+NwjlJOyTPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-09 at 13:53:01 +0800, Abel Wu wrote:
> The has_idle_cores hint could be misleading due to some kind of
> rapid idling workloads, especially when LLC is overloaded. If this
> is the case, then there will be some full scan cost incurred that
> often fails to find a core.
> 
> So limit the scan depth for idle cores in such case to make a
> speculative inspection at a reasonable cost.
> 
> Benchmark
> =========
> 
> Tests are done in a dual socket (2 x 24C/48T) machine modeled Intel
> Xeon(R) Platinum 8260, with SNC configuration:
> 
> 	SNC on:  4 NUMA nodes each of which has 12C/24T
> 	SNC off: 2 NUMA nodes each of which has 24C/48T
> 
> All of the benchmarks are done inside a normal cpu cgroup in a clean
> environment with cpu turbo disabled.
> 
> Based on tip sched/core 0fba527e959d (v5.19.0) plus previous patches
> of this series.
> 
> Results
> =======
> 
> hackbench-process-pipes
>                          unpatched		  patched
> (SNC on)
> Amean     1        0.4470 (   0.00%)      0.4557 (  -1.94%)
> Amean     4        0.5947 (   0.00%)      0.6033 (  -1.46%)
> Amean     7        0.7450 (   0.00%)      0.7627 (  -2.37%)
> Amean     12       1.1053 (   0.00%)      1.0653 (   3.62%)
> Amean     21       1.9420 (   0.00%)      2.0283 *  -4.45%*
> Amean     30       2.9267 (   0.00%)      2.9670 (  -1.38%)
> Amean     48       4.7027 (   0.00%)      4.6863 (   0.35%)
> Amean     79       7.7097 (   0.00%)      7.9443 *  -3.04%*
> Amean     110     10.0680 (   0.00%)     10.2393 (  -1.70%)
> Amean     141     12.5450 (   0.00%)     12.6343 (  -0.71%)
> Amean     172     15.0297 (   0.00%)     14.9957 (   0.23%)
> Amean     203     16.8827 (   0.00%)     16.9133 (  -0.18%)
> Amean     234     19.1183 (   0.00%)     19.2433 (  -0.65%)
> Amean     265     20.9893 (   0.00%)     21.6917 (  -3.35%)
> Amean     296     23.3920 (   0.00%)     23.8743 (  -2.06%)
> (SNC off)
> Amean     1        0.2717 (   0.00%)      0.3143 ( -15.71%)
> Amean     4        0.6257 (   0.00%)      0.6070 (   2.98%)
> Amean     7        0.7740 (   0.00%)      0.7960 (  -2.84%)
> Amean     12       1.2410 (   0.00%)      1.1947 (   3.73%)
> Amean     21       2.6410 (   0.00%)      2.4837 (   5.96%)
> Amean     30       3.7620 (   0.00%)      3.4577 (   8.09%)
> Amean     48       6.7757 (   0.00%)      5.5227 *  18.49%*
> Amean     79       8.8827 (   0.00%)      9.2933 (  -4.62%)
> Amean     110     11.0583 (   0.00%)     11.0443 (   0.13%)
> Amean     141     13.3387 (   0.00%)     13.1360 (   1.52%)
> Amean     172     15.9583 (   0.00%)     15.7770 (   1.14%)
> Amean     203     17.8757 (   0.00%)     17.9557 (  -0.45%)
> Amean     234     20.0543 (   0.00%)     20.4373 *  -1.91%*
> Amean     265     22.6643 (   0.00%)     23.6053 *  -4.15%*
> Amean     296     25.6677 (   0.00%)     25.6803 (  -0.05%)
> 
> Run to run variations is large in the 1 group test, so can be safely
> ignored.
> 
> With limited scan for idle cores when the LLC is overloaded, a slight
> regression can be seen on the smaller LLC machine. It is because the
> cost of full scan on these LLCs is much smaller than the machines with
> bigger LLCs. So when comes to the SNC off case, the limited scan can
> provide obvious benefit especially when the frequency of such scan is
> relatively high, e.g. <48 groups.
> 
> It's not a universal win, but considering the LLCs are getting bigger
> nowadays, we should be careful on the scan depth and limited scan on
> certain circumstance is indeed necessary.
> 
> tbench4 Throughput
>                          unpatched		  patched
> (SNC on)
> Hmean     1        309.43 (   0.00%)      301.54 *  -2.55%*
> Hmean     2        613.92 (   0.00%)      607.81 *  -0.99%*
> Hmean     4       1227.84 (   0.00%)     1210.64 *  -1.40%*
> Hmean     8       2379.04 (   0.00%)     2381.73 *   0.11%*
> Hmean     16      4634.66 (   0.00%)     4601.21 *  -0.72%*
> Hmean     32      7592.12 (   0.00%)     7626.84 *   0.46%*
> Hmean     64      9241.11 (   0.00%)     9251.51 *   0.11%*
> Hmean     128    17870.37 (   0.00%)    20620.98 *  15.39%*
> Hmean     256    19370.92 (   0.00%)    20406.51 *   5.35%*
> Hmean     384    19413.92 (   0.00%)    20312.97 *   4.63%*
> (SNC off)
> Hmean     1        287.90 (   0.00%)      292.37 *   1.55%*
> Hmean     2        575.52 (   0.00%)      583.29 *   1.35%*
> Hmean     4       1137.94 (   0.00%)     1155.83 *   1.57%*
> Hmean     8       2250.42 (   0.00%)     2297.63 *   2.10%*
> Hmean     16      4363.41 (   0.00%)     4562.44 *   4.56%*
> Hmean     32      7338.06 (   0.00%)     7425.69 *   1.19%*
> Hmean     64      8914.66 (   0.00%)     9021.77 *   1.20%*
> Hmean     128    19978.59 (   0.00%)    20257.76 *   1.40%*
> Hmean     256    20057.49 (   0.00%)    20043.54 *  -0.07%*
> Hmean     384    19846.74 (   0.00%)    19528.03 *  -1.61%*
> 
> Conclusion
> ==========
> 
> Limited scan for idle cores when LLC is overloaded is almost neutral
> compared to full scan given smaller LLCs, but is an obvious win at
> the bigger ones which are future-oriented.
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5af9bf246274..7abe188a1533 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6437,26 +6437,42 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		time = cpu_clock(this);
>  	}
>  
> -	if (sched_feat(SIS_UTIL) && !has_idle_core) {
> +	if (sched_feat(SIS_UTIL)) {
[1/5] patch added !has_idle_core, but this patch removes the check.
I'm trying to figure out the reason. Is it to better illustrating the
benchmark difference?

thanks,
Chenyu
