Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEAA6DF8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjDLOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjDLOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:40:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E47ED4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681310398; x=1712846398;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FU4kTqGnaTviXyl8H66MKaUYe3ZucUF1Ah0fO5Pf1p8=;
  b=YefmWNNrwC7hxhWGCs0Um36gKHiP+dJVYb4hauV/4+a+5GSyWpa0tlTe
   dl6Me4yyEMOxeDyWW9ZlkDFqVXrcEWzkEGi47oUMfByJ+YVU+mERTvXV1
   PTHXbNMbOXB2qZrhIV+WgUj/7veY8uwzsLnCO7MPgIg6R1eJEdd/YsmXF
   us2PKGpekZX97WYX4282Cgl0kCPDGg3aAtNVoWSmAR3qMaeiy0ev1SJVF
   SXkj7WvrejynQ6Zw31YQuC1tQ+TJrRZ67p3xAwOPJnHxULKM69z/kSi6F
   99JoN4/aSJf9oSAqvHg4daHRGs/+X8tI4ChXDFIhJtIFrsm93ZMb8c/xN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324277395"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324277395"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:39:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639258263"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639258263"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2023 07:39:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:39:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:39:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 07:39:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 07:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgazwrexehV/E5N0KR/hafSMXQukPcpLyE4ecJ3LQeunNeT6iGdWpHpQk44A2evLNjHHPtShPkzSt68EfUC86d+dfpxmYygZWOs5u+ZsuQ993rj4xI0J1N0O7Q2TOa3Fzca8jTPs0aIEgvnOSGdsh1SR7LRGtii3xFPofGz5yu4ZFm5C6B1iXIODOnbUPNElzH165HxIsi2vO0VDkce5Y8cJ2UkFjKHH4szMV5wGjp0W1+89FbNK8lTJoVyWrv02wMlUj2xk7rgG9ml+jUhyoFf8d3d9hNuOpBXHGUfYjZz0yunXAwg04ak3rmfVd0huaAbersXS2rSPFgnmeJCZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfKFhW+kftuaZNMjgMGJTJEZ0aN9huOLAcmw4bBjwy4=;
 b=B05mMo44WouP8TLqcjpswt14PPhCqb+nZyMqs/UTzRtQjziWnNab/mhWjl4A6vWoQ/O/t0miP4Fpef2moGOet/0kQEXnpYgTBh2y9IJANWisGzIeuuFD1va0aJv0AoYc7XGR6VUa6uIc9YJJiw+0XZcdp1CIa2dgWC76iGW1y+SVu4ZCERPnc3+oVt/UVkxwapr9i7jpvqrGAmyxwpJYHyuAqWg8UcRVZw0F+cAMGbJNnEPyZfJ4XWgaA4KOajMtqNU1P0ZBVef+hM3m51Vujt7vWwEBHPMpJIwRN75uPPS21KjpNN6ugMfWcPx+5SMjPWd/BRz1ccYG6Jo1tHML5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB7088.namprd11.prod.outlook.com (2603:10b6:806:2b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 14:39:43 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Wed, 12 Apr 2023
 14:39:43 +0000
Date:   Wed, 12 Apr 2023 22:39:34 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230412143934.GB162902@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
 <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
 <20230412114240.GA155547@ziqianlu-desk2>
 <20230412142616.GI628377@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230412142616.GI628377@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA1PR11MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a65875-b377-4822-36b9-08db3b63c14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wDV0e1t39V/oHy+rQR3W6cI8h06hx3OKSr3lPFdjl9vug17iIkltYwQ8Xu+jw2aKIjdHYIgS8iUb7Zt3onKwDK24kp2J2yDzyhEtHTEffkA6vIxM3zPDAcFLCie9LxX8jUJyxh70w4B6yC8ARLRjBeh5bhKWa7SiumHj/lb/GNxUEsBZA17RM7H/Euef+UnE/7bGNQDF+NsMRs9xGREWyC+07ef9chyMEOOBok9VyVC8lbNWq4yRwt7gkfaUCGGlFtUKrsZbmw+UJ3KBzkDK/Ow1Ppjrk8LAme2iBXF66b4mFPU/uJ1JKc9LgXq0tKw4dZOi0gPRXCktQkP8PLZ0/czsAjOqQFfjH/bNRrKMzEOKFa3MCIovZMYqCeBfJMH/7HZrcU8Dkkm32TJ/wrcuILMUbj+08tSN70xpefldP/inG6w4gxFImU/mxjv1xNi/docTEDKvx+RndvW//opXdCCIoztWYWsUa2f8uBK/LcP2+n+1r1qycwuHCg1D1/dMLlxkJrxFA5t+ml953njHtWkUzXP1klQylF00NETDggZuM84FkLwKSb/yuE8uG5j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(26005)(6916009)(1076003)(4326008)(66946007)(86362001)(6512007)(66476007)(6506007)(316002)(66556008)(9686003)(186003)(6666004)(6486002)(33716001)(54906003)(478600001)(8936002)(8676002)(38100700002)(33656002)(41300700001)(5660300002)(4744005)(2906002)(44832011)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NHgp7oyEUH8A0cxPu6P3X//dJQYTC7MBQDv3M27ZngKSuq5zZVa5oN8jEU4G?=
 =?us-ascii?Q?8nCnMG3JTGKcqHKsRKd7GjnJDCl+Sv8p++RJJ/wPKXmzxoii8cN/qm09Azui?=
 =?us-ascii?Q?8gjWQnf4UzTbHWRFvVhRVYyn0MPjwV4YJlmmEeILQA+faijvpQqsygIJ0ff4?=
 =?us-ascii?Q?YySC2A6J2QA1Z3a9AwgdckPVtu1TkWkeOK1wkcLmIn0YQqgyPofZWswEOZIr?=
 =?us-ascii?Q?o4QOvcUozIlw1MBnNEf/2NEZ5L/7a1s61uCwMNF2Gg1sv4w22P9QPhhjXtQ2?=
 =?us-ascii?Q?0GzQjw+HmazDVMozvLtBZQU7GYr6UoQ6B1QnVP5atls7c46igbcdgW9d5nzG?=
 =?us-ascii?Q?1NFujEem30PdME5Zi5KGPCzvUDd82pAIrE0Qv9+MrEgOqooymEcHVf/zPkYK?=
 =?us-ascii?Q?BtXXKZP4yJ0VlcvMp7Z+v9ulHBqytjKO30jYLFebuXewpl9V6kdEH4gtqG8G?=
 =?us-ascii?Q?XUsSqHtEnTDTXRqlSuc8LjxK0ZEc7Zqg0Qkbo+ajxLq3tm9+EEvL0c2pLSOn?=
 =?us-ascii?Q?MquWAYl297XRD9qEZI8ea8CIN1h7kGiXfPTGxtGqOTdItVf2vokW4jZtUkuE?=
 =?us-ascii?Q?xHPprYDXet8qYCCC2CbuSJqXyP5po8bSZc2SHMljJOyptO/Jor5Wh7b8D/ot?=
 =?us-ascii?Q?idxAANRxUQSQZW8A2GPqm3J2EdxPWVfXx17zuyHcaBvwbmxLvxLmJPdhQnZO?=
 =?us-ascii?Q?nCRkIkS4Eq5tb3ALZ6+NbfFnp3AxgyxxgvKWur0qVePGoKtrCaO+gGzR8ogb?=
 =?us-ascii?Q?81Ywa5+ynRk2lD4k1pAdbnhsUDddkw68AejtwuzOKVQbtg03RV5FGBAPW7If?=
 =?us-ascii?Q?B85dVv17GkjNayeswKfZu4dGDofO5/mJE9BPNsy8T8ekrJiMF7Ou0FaGBtbM?=
 =?us-ascii?Q?ODYBIQ6vI6+MRk6ydli7vUMt5V4baVHNBUNJgV9aljV+rvwHZhjxaTayMY5b?=
 =?us-ascii?Q?PyqrH+JpUECR/UjlzRnEywQfdA86DPvp7NaWcoWGMuGQJ2gwvr45j9sprM8m?=
 =?us-ascii?Q?RmQ6FR1WcogV6QBE7x4EwkM/3KewwkcP8Grdi2RWzUma7Ij4NbjibsKlkfTr?=
 =?us-ascii?Q?3B1UYHqV77/s8z1vkdNlzUwDrzCM7jwaREIqkYKhomqh1Sgk8bp03ASXek1W?=
 =?us-ascii?Q?exvzDx8ZPfkM+QMKP+IJC2vkHereUlkcI+kzkFbS1C6NiPUDpW5wBXpJ+emJ?=
 =?us-ascii?Q?BtrqvKf1nbYxmzU+A/TL+p1VTVxaatG4KkdfMFbol3iFqLAivvUuAJPO4PDI?=
 =?us-ascii?Q?J/ApXJwsJIxVEVSUMPj8AjlnC3QsnzLm/K6vxl1L002vNxHuoJvGhF7v3KdL?=
 =?us-ascii?Q?YEg9LK9kUqYNbtZw0ZnQmy9MBIeEu4H2T3wSfjie0FN0726neTD0GpJwxcaN?=
 =?us-ascii?Q?8ha3vcApPSmDvVrgUmeW04rkpE5i8yPLIviaYOyRcFa5jTvnxLmfcL77OoQv?=
 =?us-ascii?Q?hL3+J4fNZ1UP9tps8+hawERu1dD0OC5XHi9kChq6wV485pA4NXEhj95momTQ?=
 =?us-ascii?Q?CQGeWf61eWa7PjZiWoLvurM8OxBwu1UTzwXydL1kmDhGEramrzOGOCEDBdTf?=
 =?us-ascii?Q?q0RNFij2CH0jEHYAupt0PhVASCHI+S+6/LkUdCni?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a65875-b377-4822-36b9-08db3b63c14f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:39:43.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoPoelAf4rhO/oGQAD1n3ZidbozNiVivUDBCWTM/VnhpO3d2vfLGY7QU85k9xxl8rwXbzon74WOeiUuvWKF6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:26:16PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 07:42:40PM +0800, Aaron Lu wrote:
> 
> > I *guess* you might be able to see some contention with hackbench on
> > that HSW-EX system with v4.
> 
> Indeed! Notably it seems to be the wakeup from idle that trips it
> hardest:

Could it because for idle cpus, the per-cpu/mm cid is no longer valid for
the sake of compacting and when task wakes there, it will have to
re-allocate a new cid through mm_get_cid() which needs to acquire
mm->cid_lock?

> 11.31%     0.03%  swapper          [kernel.vmlinux]            [k] schedule_idle
>         |
>         --11.28%--schedule_idle
>                   |
>                   --11.27%--__schedule
>                             |
>                             |--8.61%--mm_cid_get
>                             |          |
>                             |           --5.78%--_raw_spin_lock
>                             |                     |
>                             |                      --5.56%--native_queued_spin_lock_slowpath
>                             |
>                             |--0.81%--finish_task_switch.isra.0
>                             |          |
>                             |           --0.69%--asm_sysvec_call_function_single
>                             |                     |
>                             |                      --0.58%--sysvec_call_function_single
>                             |
>                             --0.57%--switch_mm_irqs_off
>                     
>                     
> 
