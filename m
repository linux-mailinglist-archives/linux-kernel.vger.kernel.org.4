Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEFA6E2549
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDNOI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:08:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A73A88
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681481306; x=1713017306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EFLijPFBtG3mUSmuaH9aDyMT6QOKXXk9Od/hHQ3hDIo=;
  b=H9v3T/VF1U3qwHjb+EXNgQDc7J8jrmvhmDTNjF5/10moxSUT7VZl7J3X
   eYmZV8fz6v3AXKhfOnhaJ6pm12btlToY4FParV94YXgswiI2ywmkZWZqc
   L7BW6CnYj06MQZoCTJAns+i2gJ3/YkgffMzNLSDRq+cqJdBw8C5fVf7l6
   2qujFiu6Mt18gu+iA4aKcUef1CMkxmE2EMrSHCfsmfg652W/8AiqNW/oh
   FTSGPMsCapRUpJuTflUEqlTVehGfpMGVmjuR2yp1ANRMFKMmn6ezijmoR
   8wvQT7F/Q8aoqLHGjZR4D9nDMWZQ7X7k59lG5yOhDcnx0aDTO/GZISOR1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="409672153"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="409672153"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 07:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="1019596859"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="1019596859"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 14 Apr 2023 07:08:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 07:08:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 07:08:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 07:08:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 07:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7g4ytUGTjvnP4mwZU3LHEei6u5JDMwIByG0VWR0PhwZMQU3j+5qpOysJBNzI4wlGQI5xPsdaHCrXoZSVMxDGpczOJkCf6u/QoHz71X5glj2ANVBJnX+JQizc611CysOqAz04P3WsmRhTwqYlNaPm4jD1BxAcx+vw4Hg9xDQhJRaPT2UZ6GW0vzHfxtti3S+uOyJsLSXImRcQf6N0p38I5J9tUH1DzxWFSYXP5x7igL4gW2lGyiKsmoTcBJnelarWBNrsIuShWOgLWaK9kf64a55Vv0e+ZiYr1xB5dLqtYcqn1sH/I+WfP8Kf+pGXpTrpZU0Gv622yuYVWsGltF3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk63PI3k2M5J3TCC/qwIXNsP16hh+xUYI0srmP9287w=;
 b=FJzr9Nnk2S6kADvYx38GZmMgbMYkQKVtIJvukKNPiW7aES33vfbNsdysj4HzxI61OM2KyEVtQZCVsRxLnL0Vl/F+7LFqEmzj86PhsThFo9N+vp7bItEawdI3wKk1nKBH5rPyk2Quhd6uVAzPbZNVu3UdxszkNBeKGulG+cKVImfSUJ2gJ4Yxk1alyx+JlVRdkkfv7T7cy9sfgSfdp2Vf8JURYHrzbP23iY0TAIsRRPTUTDDAPpAxCmDmyAh+ktsQ7H46ovyAn+AuDDUCy0ty1nmz8Wrf9JZ3qcxw85dbCNjUG/rcltvMBUBUUw9pppH/qmJc6GT2xssWLCjtVnbP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 14:08:03 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 14:08:03 +0000
Date:   Fri, 14 Apr 2023 22:07:53 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v6] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230414140753.GA279103@ziqianlu-desk2>
References: <20230413223356.17195-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413223356.17195-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a5b93d-b4b4-442a-a1c2-08db3cf1a998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgSTQvZ3YlnXNXq9NDxHXB+MIHrJEW4cEr8RLB+D3xk2Z6mmxhAMF0uQtUbtodJzByC2ecKbPZAY4DMhBz4uzy78iS4onoBilOXgNC4w8RFayWu2+B1nawP/rSxAJoJFiqSDfZL6ymGXnJbGIXdavxMGvF4p2/uNqydlZJoWtxWrYcoytsjDf2H963+s+zsO3nHzkSUl+DqDRA/Ps4qVcxR0khS3hZJaM+DPVo8kutg0hDjcUJbTgOxNsTXgc9wXgXUDBgdYIvAjvkXfhxhGj4qvWc+LI9g+fN6VK23CzLDSHSSONxG/nnGW57kJi2P+knpLwYA/07ukKj0KaWRmGFqa7mP/Am5YIVJC0Dod6iwXW8VQAR8CxzrdN6F6Oc8jLC+iaBkvY8P8G7z5mmo0w8vjE9eTM5z4R+67KuAPyWuUYdbIH8OSID+m+DywgH9kB5o3peiQkhylKFSSpxl+wXexYDzMEWUmNqFgU2lLcCA5IxybNZSbFhx4d6vIX6ODyK24jvH7VcgjlcD6dG0QFDcDINcx0SDpDHLzyTkKT6RQ1XhMV7rPvtUlF+HAZyCc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(478600001)(33656002)(83380400001)(82960400001)(38100700002)(6916009)(86362001)(2906002)(66556008)(1076003)(5660300002)(6512007)(6666004)(44832011)(6486002)(316002)(6506007)(9686003)(26005)(186003)(66476007)(41300700001)(8676002)(8936002)(33716001)(4326008)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?desvht5sX1k6QyfFayUwVzRaWFpoxG9aAHGBib/knCD3VdMhzVm6LZbAsO6U?=
 =?us-ascii?Q?MQoRsvg5p19xmpydhrIpvbm/0pCK1/o6mPRepQDUhAtZLr639NQMwzYMle9M?=
 =?us-ascii?Q?SysARqrWi5yYwOy/at1FyQnX+qwaumriN35WHIGYge+kOrFZgGReTCZNsqEQ?=
 =?us-ascii?Q?IDF9dJneKh+nnmSgqQxPlHE0vVOIZ9Aq2HjosP58QDkBxN4CeG+SDknKh1mF?=
 =?us-ascii?Q?0zFdAAHDeURgoVycye3LM3ByBE9YmTda2620XguOqpuyFzk7qeqr9UopMK7i?=
 =?us-ascii?Q?N2Ja6rqQRMnX9k0Z5hHLPknPlQmdPA2ZV/ieXqd8+CWp1voESam+0kMVhXIe?=
 =?us-ascii?Q?IOPJLL/Zjun/YPWkeOGW9C/ohy7e80AgeJ9ZgVgJcnZP/TN4FXFgTQPoG6Tc?=
 =?us-ascii?Q?g0NxXEEoFRSjFiZruguKsf5SyWlJ0Oz3r7gFb/u3E2Udr5JznZNWAVAT6GZb?=
 =?us-ascii?Q?oQC0LvKZXQ02cikstr2c1KzggO9UbiEMDaYlMa2WYoEmHtac3JfiBNTzgeuD?=
 =?us-ascii?Q?W/mtthOTh3k6HI7RtFcyCD/yVhVs1WTMLx3gAiw2cF2K4VJtogTKw2I47cMS?=
 =?us-ascii?Q?TDiNA5HVxyyLDgdmv96lBj8Foe1mCGOpK+/Ev+Pg44g/ZnHcF/3d5gqFJDfL?=
 =?us-ascii?Q?7GcElrG8m21eUK5OrtKSOvxkrHlJZmBE9VTp+L7SRINL9zgv4PPJjj/j4iT2?=
 =?us-ascii?Q?08HApOmD5+uafSwSJDe7pTHaztt0kQKs3Tccv4ccY1P/G5OAGxy3H+oL9t6K?=
 =?us-ascii?Q?G43yK++fZFR/a5PHIJFku8VfHvcVhvymZRbiZbvQ6HNDFaCExzwQqnj6WJdV?=
 =?us-ascii?Q?M+LrppBo+5zHZTQIot9xDEU/o78sZ6luUJNoCpiVfbMsc4ZoDTX1VrdI3W9x?=
 =?us-ascii?Q?ZUvl1I3yxcSZhUR6vW9x6R5AaSp8PsSKYhPsSDRs9tB7Yrh+P1AbyKJnsY/s?=
 =?us-ascii?Q?+0U1ZbHqGIHPDe28MAzW7e/siNCHNl8hWTZhdGAYS4hpj3ueXgHtlmTreG0i?=
 =?us-ascii?Q?4vV/mQbwKtVdtRLGbG2+jp1STIVNB2lWefO3d37KUoycsh4VQR/YZrXq/biz?=
 =?us-ascii?Q?BggbdoYEkckbVRUYVnBilpbTK5oexUEm1gFP9t3AcEKvCAlx9FPjmqqjZlGJ?=
 =?us-ascii?Q?SZCR8qQEQJFGT92yW+lESRxbTba5tOStXdrZFTIAlDWBquaOcdfFAGpIVXnc?=
 =?us-ascii?Q?58Dgbe06uzfNJpggWK1x7mfvCasjK0H+V+N20yB0xRVCakiibKddQQBJH2ke?=
 =?us-ascii?Q?MR00c35JSI4KhjpUetjHLYyvjrb350/+zNW3X/JzjxkuB17oAvh8rTyZPNwu?=
 =?us-ascii?Q?WdZ+NmAKuDlgA0RbxoxyQNYzInjD5Q+4nNoLqpIE4gy3U+HC+dh6b6UPORg6?=
 =?us-ascii?Q?7yGj8UUdivfN2Am7uwBhXEPbV2Kg+9uyjBkoacraVNnCBoGihrRczdCobm4K?=
 =?us-ascii?Q?RI2X6ebDOyOe5PcGAm+T1nbjhkA0MS+d/QhPWJ4cubEZ2ePw7+W0DJTUF6qd?=
 =?us-ascii?Q?5/DpGc6UD2RxFVzENpvxlmToku/GfFCSe+UPnNjhJqHgN2V9tzv2oFgRuPm5?=
 =?us-ascii?Q?QHa5c16lWLNBnYker0QTa679FehLDfzFfi/umOb9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a5b93d-b4b4-442a-a1c2-08db3cf1a998
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 14:08:03.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76vLScFqPFhWr0ENBJukiL+N7rf+Vi5+3dNe+RE/t7HxpH67osPB0Df+qMHz/CCtyM+l5ds8+SHaCBAX65ZP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 06:33:56PM -0400, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.
> 
> Keep track of the currently allocated mm_cid for each mm/cpu rather than
> freeing them immediately on context switch. This eliminates most atomic
> operations when context switching back and forth between threads
> belonging to different memory spaces in multi-threaded scenarios (many
> processes, each with many threads). The per-mm/per-cpu mm_cid values are
> serialized by their respective runqueue locks.
> 
> Thread migration is handled by introducing a task-work executed
> periodically, similarly to NUMA work, which delays reclaim of cid
> values when they are unused for a period of time.
> 
> Keep track of the allocation time for each per-cpu cid, and let the task
> work clear them when they are observed to be older than
> SCHED_MM_CID_PERIOD_NS and unused.
> 
> This fix is going for a task-work and delayed reclaim approach rather
> than adding hooks to migrate-from and migrate-to because migration
> happens to be a hot path for various real-world workloads.
> 
> Because we want to ensure the mm_cid converges towards the smaller
> values as migrations happen, the prior optimization that was done when
> context switching between threads belonging to the same mm is removed,
> because it could delay the lazy release of the destination runqueue
> mm_cid after it has been replaced by a migration. Removing this prior
> optimization is not an issue performance-wise because the introduced
> per-mm/per-cpu mm_cid tracking also covers this more specific case.

I was wondering, if a thread was migrated to all possible cpus in the
SCHED_MM_CID_PERIOD_NS window, its mm_cidmask will be full. For user
space, if cid can be the full set of cpus, then it will have to prepare
storage for the full set. Then what's the point of doing compaction? Or
do I understand it wrong?
