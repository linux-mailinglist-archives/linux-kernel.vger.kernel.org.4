Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CE6B1DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCIIYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCIIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:23:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173C64B1E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350144; x=1709886144;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EbrOEhUWK3hZ3JLzDn+5z7YKm11oFz9lFmLsR6WPXIM=;
  b=du9VlT9xQG2QHu1SpvEQLod/eXHIgj3zoJB3EHJU0OeDmdbe23cSFgKp
   jEu2PraDNBuYOU6sox+Czcs59EnW2d3ojmCpzMiJ70bUKhUjJLwha3lBP
   RTQGlm4Ic6EXuTLY7Z+mCtExeQRJ/36y10louOGDVHGNOaHjgTd0I8uDp
   GlGsTnoN7Wb+86dC1LNMJ7wqQIeTddyj33h7epqumvHlLz8q5SjYMOiKC
   PJwDs2ft/BDNEdji85leKynbpUUDM0/5HZgD2mXEesX9Bnlrd4iTqKa6u
   rv90jxWtrKaxj8DXzgEzam+tnFQRkC+E55f5YBOwt4Bivd+bX9HU4W0Zf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364026094"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364026094"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787474001"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787474001"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:21:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 00:21:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 00:21:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 00:21:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 00:21:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYeBpHLXI9iuyYBMZlFFEBDMC8lh+23KTkLgvHQmf91WPnkfJxS28jMip1VgMdQGf2lzCp4T+ShaKXpGGPaO/yc93R6RKdPtTslIZ5BDL99/aFfdqdLclH+fWbottfS2QicJyXwXLwqpxNVHBYvTKACJQKlQhyWaTkVsMklZN15G6ZctinUAET4dELXIZtLKps4sTeUoaC1MkpMJYpHKpNtCo2ZclTXFR+vALly1kDt45f8iaQakLlfGYI75ye2PvQBJ85jWQWXW5bUwblC+9Tl89F2wJDmOMYFLoZLf3pcHuFPRZeoORtsLRgUYWXs62pqn2Y2G2kDgrneQ7Smegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZEEDY53Tf5gDKOvnez5Y2pdimRK7XqtD/GNR6Y2pNg=;
 b=icrzaHxPI2/Nf4q/zZw6Xj0zS5LYyUlQ91ONdLJZ4BkQ+eV/O2aXt+eqoF02xKkIeWMQa5N+FSNTPWWqJ5jMXLfJq+KFacBje6jnyPGvSVIFKEhwp7+rTMtOn1gAtCIdqzU0DTDew0uyorRxDBk6H7C1+NmnoF3kvelpAXbgCkhP492uKai8xGSzL9+6lYevqDUu4dDeSSV5mMknoNnv7hSqRpLVZl+eeLCBFcDKHqAGfACH8EHSouwnE56zdgcL8PzUxfDyJQ2X2QAeQYx+7Nhjv2rbrta5J1hKwE3wTXRv91/c9zzMGXo9QC7Nc6k2OKQ/CdQHUsz7KEHzM1piKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 08:21:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 08:21:35 +0000
Date:   Thu, 9 Mar 2023 16:21:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     kernel test robot <yujie.liu@intel.com>
CC:     Zhang Qiao <zhangqiao22@huawei.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Kagan <rkagan@amazon.de>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <fengwei.yin@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [linus:master] [sched/fair] 829c1651e9: hackbench.throughput
 -7.9% regression
Message-ID: <ZAmW99UdQQEncV2l@chenyu5-mobl1>
References: <202303091155.672f546a-yujie.liu@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202303091155.672f546a-yujie.liu@intel.com>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: afdc193c-e026-4845-f4ad-08db20774bea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TnBXlfgimyKdCkRYlMQs1bX3LGyOHT9roACEt1Pz60FoZQrO+x6Dpy3M5/AQ6x5jBPiHke2YOuN4GGsaaPLr2sXe+dwMlKJBBqH2dP2kYxhgSDCy57EzMTqdRb4KeV9QrwUYl+YuIfyi79sDaNjjlDNxYjxPQLVJ7nynpWjTDDwUTCHNhL97Eecary6D3FkKwiM/LYcL57S2jrYpXCF3wRs+xV8J8VkBOuDnSbd4grBTY7NvE6zZVwNzbQ5bg8iE2J2OqMopkyD/Gl4FUnSnsHXvMBfYouGnIiODEJ6V1Gp+BSqTPibcEUKoLKWelLadTJPIMLeMmx+LVZiPYmeoQ93dDnRbaOtDRvBNfRd+kvxn7BmTpA3lIaxaYgj8g4NcspZJBxfUiDijRVOuL1+8liwc/WaYP9h2sKyd/6wabGNIpuJWV/WgW3s5wXsPOE4NZQZg/R47uDLVHp/I3bPuNfcwOWNrHDr4J0dJobI/XhricxrlfDcO53tJkljYb14Q0Ddc+CeYPbxvl5y286EL0AhodrFmUCNXGwARAcXzZ3rMixxu8mc3G2oy07EdvO7usYPeM1Sz0LNlLIPy3En/3UEC6gRymC2ktk1jqVQ0fw3EFVM7jbl7qNGJ13oCzPhVRy7AR+m2Vpgpu8NX9B3H246/z77NQS6jqBBfRUr37g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199018)(66899018)(33716001)(6666004)(82960400001)(83380400001)(6636002)(478600001)(54906003)(38100700002)(316002)(6486002)(966005)(9686003)(186003)(53546011)(6512007)(26005)(5660300002)(6506007)(41300700001)(86362001)(66556008)(8936002)(6862004)(66476007)(2906002)(4326008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?taoL2nrSXcjyISYB2INoVIhP4wXwEkHPMIJ61SF3+r7M8bsgQAjHZufuqk?=
 =?iso-8859-1?Q?eMqjOavwN6OqpSTTu0OM5RlW1o9M8pEJGy56OXNwmb2YXIl/ZSH8dzRfQe?=
 =?iso-8859-1?Q?S4acH6SDkoZaHzkGKV5H3/7+rlskgQOY9MQu0V6dqIzzuEQKik54PXP8hw?=
 =?iso-8859-1?Q?CKwmZ+QbZk7LVW6n77dpMmV4lgqBV6hptY8gi1OYPUw6vq70Q2ah0LUDqx?=
 =?iso-8859-1?Q?e4QU2KxQoC+2gVpxU94JnUsbcocI5e94eWYvDdvN7SuRaJY6uSehDT2J+D?=
 =?iso-8859-1?Q?HuU63+1iYbuWU/PDGbvqr8I48SMgo+PPoP06c124VxmCEU/BilECHLC0vh?=
 =?iso-8859-1?Q?Idfx+lZoHas6aZgLfyAXZYQ42o5r/48r42tLqo25opExaNU89WqWDnL7q3?=
 =?iso-8859-1?Q?BuqqxIiL8mnwB33Bk/8Iab0UKGEKxAIHc3wJaARKHQ1ZZAoZFFgyAJGhjt?=
 =?iso-8859-1?Q?BC8NB8NlSjo4q1kgbQ4syuKmv9HzD5KWUz3UMOfSLcItPfHDwTzNDe1X5I?=
 =?iso-8859-1?Q?ZY118M3Ib//2PEX4RPxaBrzszdvxEFWqjBwvqHpDuqIDTr7eutimef2uX+?=
 =?iso-8859-1?Q?QLZEK27zAPqZmVEyY6QdikHpQkeXEPR7YsX/xCRjqzRko3ZZowjB/gVrYC?=
 =?iso-8859-1?Q?bIKlQIKUVuGuApQwiXLP42OdYqCX3fhAnYifzweGW4/MMIRQZTsoqwBfqp?=
 =?iso-8859-1?Q?038tRtPsiDr++lGl1Y6HiQ6iSG6fYJcgD8afGDiHKSQfx3u/l2B/vZV6Ab?=
 =?iso-8859-1?Q?HzBI17JzVNyzM1WjYDSEvH3oTFqrkM9cd2jUIT1HknNw4Os5lkcZJY7fUq?=
 =?iso-8859-1?Q?iXH+f2mVW7PGrJ0AcRG7h6Uq5Mm8fGiJbfKBzU/qVeB/CdEbjikx7183Fa?=
 =?iso-8859-1?Q?Rqjb3Z4w8uBm5thlLAvjSKwjetvR1nVltQn5Jnp50Kd4S+WEkyYHRrCDj4?=
 =?iso-8859-1?Q?mVlPYO8qOXBffJWapBBLmVQZFSqm01y6CS3XARFks+piCQ77TLc3rV0ZUb?=
 =?iso-8859-1?Q?poxcn0Lv6WFGrTKfIRfiVrWZfRAfu4c4JjcnsxTUiyPmzFFieCpJIM/h/X?=
 =?iso-8859-1?Q?jAcGcZNUJGaFht5TeQXA011i5da72DnpTa7xMMfOYWdBwUw0OamPgb5NMj?=
 =?iso-8859-1?Q?jgM7z+86iAg/MeBuOyP3Hf2PzClRMDPAP57F+TjoBKhbvpBQp/NSZ0Bi8o?=
 =?iso-8859-1?Q?wxgXg97RPBZaBjBHbpN3CtFoFN3shYpIvjDD3YP6wbR7daMFxyRO9F8qAB?=
 =?iso-8859-1?Q?hmN4eTjIlUADK9dDBm1mL6sbG0qjHdtSP/Gb59f6G/LaUP74PSGH3sIyk9?=
 =?iso-8859-1?Q?/4+dkCQhEVjIPnactGKcljxxNfxhfMD/XtS1Rif8L1hjUPdOyoAf8VGO3C?=
 =?iso-8859-1?Q?KgQ1h3kaWgo0q2jSrBpDY+2tfsooV+jlz5zePL3+STwdRcztn2L1AA1fmV?=
 =?iso-8859-1?Q?rAJsLjvGH5mBry0+U93KXcgpCTn/lRV3tHLMSaj14Oocq+m5CiEKforFaS?=
 =?iso-8859-1?Q?hwP+0q3aLLO/WmkUrbOuALVOP24ArqqzMeBFHkK8V6H+N4Oz9lOR+pexr7?=
 =?iso-8859-1?Q?Ltwcuva7YRX7gIOxlmtOR/e0oWJVioNcP3hdRgjbmd6LAYo+zI9P6nWdw7?=
 =?iso-8859-1?Q?0hq9F/vcHgc7Lo59OUVkOKPppIuxhSBx9M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afdc193c-e026-4845-f4ad-08db20774bea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 08:21:35.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYhYP6IwEFfh1dynZIzuBcSpNh4rwMRsqaIN0w6Di7o1hwMVCLf/WDHDjc9n7o2tYQxoNlTstMaNrm0OUaagag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
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

On 2023-03-09 at 11:46:50 +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -7.9% regression of hackbench.throughput due to commit:
> 
> commit: 829c1651e9c4a6f78398d3e67651cef9bb6b42cc ("sched/fair: sanitize vruntime of entity being placed")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: hackbench
> on test machine: 104 threads 2 sockets (Skylake) with 192G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	iterations: 4
> 	mode: process
> 	ipc: socket
> 	cpufreq_governor: performance
>
In theory the patch deals with a corner case that the task sleeps for more than 1 minute,
but this is not the case for hackbench, and it did increase the preemption:

 1.08e+08 ±  2%    +648.7%  8.084e+08 ±  5%  hackbench.time.involuntary_context_switches 

It might be an issue described and fixed here:
https://lore.kernel.org/lkml/20230306132418.50389-1-zhangqiao22@huawei.com/
https://lore.kernel.org/lkml/ZAiFxWLSb9HDazSI@vingu-book/
I'll check if above patch helps.

thanks,
Chenyu
