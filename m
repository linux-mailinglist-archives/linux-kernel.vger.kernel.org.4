Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F186F1367
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjD1Inr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjD1Inp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:43:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9108213A;
        Fri, 28 Apr 2023 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682671423; x=1714207423;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=g1U57HzzlE9m7pohxdMebOOit/K3zSKDTrHp0N5sVP8=;
  b=bY2DfnfCiGZNmebwUxi6dHhavwuHgZXRLY5fSUOQYFrWEzj5JIZ49WCY
   4GApHXWGSDzNf0lSVUT1T8juPxzL8K4OI4uSgPobEBcTe13wlrPeCocTd
   3h8bEhv8/oOPHq8QZ9MZB6ZeZ52EYbKjGdQtWVYGloU9B7QbBCWp82D2e
   PHv/9/KyI0xTnzuncWugPaV0+nwDIFO49aVBZEEXh78IHqWvkHqozmXfC
   ZO22slAEBz444wV9xv+sq1h9QwOmL/RY/EXFmdJGYD3vI4cTiqc/dowd3
   G0XXo4/vIgB1obvUAJmAOiJMRDz7JQ27bEn2F9+NPs2E8b58/A2eQReGc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336742718"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="336742718"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 01:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="688741405"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="688741405"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 28 Apr 2023 01:43:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 01:43:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 01:43:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 01:43:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 01:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfgkHoiiTfWoCKYYraMlfF0Ju6PA1rvqrGe3oXJ5CurZ+Lm84StnysmkZ8wA81Nqyw03lD3sI+nJ7owlIJ9wJdRXwf6YzplNPE/IB1L2Yilvl4XctvvEMgTQ8hfdOPnrVSwaDUxeCPpTeqRdINJWJ/1+DbJHkafPThTF7H+ljQIIqXLss0+be0lysKQBw8v8z986V8rT0zU9ZSBMz+0WimjjFRRdL200Azf/PHvLdZtr9WDa7EpT8ZxTMD4k0+uc1kqk9fy09tC9B+MiKfzw3yEIH9gq/+aROFae2KeBGtKHVaifi2ehpxC56MqiaMWmT1lwiMu5Dx7Lu9GVjCpEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3q6aFtwWA89VX1nK85UzH3EZcEuK+1XD+O2gpVXGGw=;
 b=J24ClHR1q7PVLJNtKgoTcSJvtiFuumRmje5IDIIlmHLcfOBeFr3hXXK/yVH5c5VtzdqdQt/TOaPQVl5grHLaV0DK0dOLYQOWGAjSOGRZVsM+nenJFUPy0B53Au8t0G+VjCvlkG6VAPEgM9KNWh8Q4D8obZKiHNY7r44iL1Q6kaxpBjS4KvdkfMXfUzXF+ZsI6xGAT52gVAN5xxRReSvfcv5KuMcmNVIqQA2+STNrNoKVg9X/X+ILdMf4WFHbasQCktLe7XbEb0l+Pnau12WhzcAIhMxtZtbFJERUzuCod08+1lqmX9b7ZfnOoHKrB/5OMzLD9HMZHJOScNBfj4XPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 08:43:39 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 08:43:39 +0000
Date:   Fri, 28 Apr 2023 16:40:39 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, <akpm@linux-foundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <hannes@cmpxchg.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <bfoster@redhat.com>, <willy@infradead.org>,
        <linux-api@vger.kernel.org>, <kernel-team@meta.com>
Subject: Re: [PATCH v12 2/3] cachestat: implement cachestat syscall
Message-ID: <202304230337.Qd5oUtzU-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230421231421.2401346-3-nphamcs@gmail.com>
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ea6977-81bb-44b3-28e4-08db47c4a984
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vf96FiECH02swau7G+BFw313I/IREtlkHyld6wP1MeVt4vOqf+l+bhtFXR1EXQ2kltpoJqS1WuIoz3Qunihqn3fleEuyVotfZhl11Ra9/N3Yc93s1J7V4K64810k3Qi+BYnSB6xFYjT/lzlNpQvPkcR/KK/nimLr2vbvI6TWRq4SwQTXq/zJ/fAabY1m/UBc3xgaCwHSHkqhgq0GiARnetCwVAURo0OICRKwJNw3bHTGDULDDtoDc40c/cpmWYJJa364XYJLNu77kSX/f8G42h+0Lo7+/dBGIVD7Q77XUrI8xevpjEa9VFn1Rl1zkMY6ZJZgqWi5/gBY1S/FZlAcbBxWQPl872fiFBbiUPdUUQafc6pywu05XtZlYqhw6eARnOcWITQI9Fy7DSltfoSESMZvvXe3wveZDGLdzhyph0CMrlwKZ7q2lTKqztV3OV2Y8C8dxqlvNHfDk7gHVOuBvGkB0Y/wklkEI5+5x5q4c9MrWefxJdHw5097qiaMrIO/93XG+Dbf1iy2pfuwdAnG5jl8KAQaAGIlNS+A/5o+ttKY4/kQNBks4BPjfoprd8jR+0ZNtRwMmNnwCmHjzS0weQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(2616005)(41300700001)(38100700002)(5660300002)(26005)(6512007)(6506007)(1076003)(82960400001)(8676002)(8936002)(83380400001)(7416002)(4001150100001)(2906002)(4326008)(316002)(66476007)(66946007)(66556008)(186003)(36756003)(478600001)(86362001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSVUNO+FRRXy835ydy+5lb3Cz4w4xz2yIn1vF4QV/7NkKkYbzqCmAS1oX8x3?=
 =?us-ascii?Q?BCIRt+mV/GyzjGSkCp/tK4XJLuaYOWDO+oTcqZyK/y+L6RTmFDpgJkc1iGEV?=
 =?us-ascii?Q?PmX++Key4oRWdaFy+1HNOIo1pSHz7ZNwObiAbl+jC1Kj1AbPTRQoxwNW8vni?=
 =?us-ascii?Q?63nVRCW1Mzbs4Sfx15lHHVGiEI7QJH+CHWE+HNowAipZ7pUMsKdDMgQIihpT?=
 =?us-ascii?Q?WEQx3fxdJQSCNDRHCMokDmXzkT8KgbwjEC5YlgGrGjfDhXb9htsFPGtb6QPT?=
 =?us-ascii?Q?IGsPCwhX9LsazcW002xxBSVL/xVA+cpNktzAUHZNB48Wx/5Uy4g8OHAKFqJx?=
 =?us-ascii?Q?yy6K27voRE+nqtAZIEXmVF7QLy0x5BdRB8OMJp3fQT/pN4SIvmtYvYGYyLH6?=
 =?us-ascii?Q?LvNzgb/2pjev7b0W21rlRRnePgYX1hwGUMpaB5hov65/dSORp1sDDOUfwU1T?=
 =?us-ascii?Q?wSJ+K7bmcTJAW92O7MzBHavlKx3ikpr7z9yRorcmLGR+epmnO5a1bqky66cA?=
 =?us-ascii?Q?gl1I2i4F9YByhnH/gCfcLfIVff7Hd5tPUQlVOmqp+DVIsiHAt3COvRINhVMd?=
 =?us-ascii?Q?WZ/tpXSqQBmbqC/NY7j09KfoafiJUPkS3ip0wSb6jxLVNAd8ZZ/dXVi52weN?=
 =?us-ascii?Q?HIfxMHJejILYLVz93CmUZwsbZ3b6GgcgCtJufRynkP9iJPivGn4hzLxDebmR?=
 =?us-ascii?Q?6s6HlZg7gJsGUH92nXeh+Y6AgIh/VWFJa5n0kfjApklHr1u1WnDzqimZC7Fq?=
 =?us-ascii?Q?U6e2Mfr0nGR8G7WXGSBpUICdwK90KATAO4Yy55O2q/6eNAs4W+46QjLHVpco?=
 =?us-ascii?Q?fXJeCGa7HiQOp8lF2X1slBASKUns3K5gafPr8m/BpGxRDnAIRI2OPJP1qrvC?=
 =?us-ascii?Q?j5N2AZU0zHPrj+VuFhb+ftoxgwpNQ6/MD9N6KqOncz//oq4NjoPOdjjgbRHw?=
 =?us-ascii?Q?QK8FibOF7rbllOUFOaVy0LPCld8tA8TxpkDIyVKUmD1ZJiPt6ipAPvMvBjjm?=
 =?us-ascii?Q?2X2NvxpJX5OCUQJ4S4AiVTHy9Jds/FshKdX7zq6R50kXNzK8ywbnePs/Le39?=
 =?us-ascii?Q?c1DV8UzDAZqlvLyXwGny1uwXNmVQAujkA9nu/+mGUehyn1f7ODMQpId1DQ7X?=
 =?us-ascii?Q?0QZJlln/s/wZpkf0kFQDNuSwVsOeUuAc0vnbq+bRQnEeKt4qHgsi4Bpx5zoL?=
 =?us-ascii?Q?irIWeqyshvuyGIyfvr5qb4Q+7M+9A4xmcHMDsligad12KNcc6F/NYoLiNjDp?=
 =?us-ascii?Q?uMgx1RiC2vs0iL2BmfDIuTpMdgO9fieAGQ7/tphBUmc3tjL8tF2LKbaiUiH6?=
 =?us-ascii?Q?5+xphy/sYTVP1d++Qz2CmNn4vgd/3VbHlMPL+vW+LXv/8Bkw4+2i+WzOTFKa?=
 =?us-ascii?Q?lEBffoUtlOYUXlS2yWO558Fib25wyNdyvSS4KZkwwUY1D2L6LLS5vlyxtk5d?=
 =?us-ascii?Q?ja7oWDNuqxf2HGt4xLYKCJUNr8Al8/3W5rfoMvmIFDkqHCNVYXp6Sz5D82gq?=
 =?us-ascii?Q?5G5XbSZi4UcHAHHggWTHgkK++4Zhllhgz2VSBVPBjlIwgkcEMSduK/O8Xnyx?=
 =?us-ascii?Q?5vzu7p5wI4xeGsdzNNFLIfQqYxAfq03/osSED11G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ea6977-81bb-44b3-28e4-08db47c4a984
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:43:39.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wb/+4vh57xIa/LXjUBm70e2p2h9WUDHJpwBYMVJXbDDY4jojtb4Pe0GVy0n8FjePO2ptQyzKK/WkNUOtRS7Khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes linus/master tip/x86/asm v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230422-071625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230421231421.2401346-3-nphamcs%40gmail.com
patch subject: [PATCH v12 2/3] cachestat: implement cachestat syscall
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/r/202304230337.Qd5oUtzU-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> mm/filemap.c: linux/mman.h is included more than once.

ffa65753c4314 (Alistair Popple         2022-01-21 22:10:46 -0800   24) #include <linux/swapops.h>
9691e4430fbb5 (Nhat Pham               2023-04-21 16:14:20 -0700   25) #include <linux/syscalls.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700  @26) #include <linux/mman.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   27) #include <linux/pagemap.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   28) #include <linux/file.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   29) #include <linux/uio.h>
cfcbfb1382dba (Josef Bacik             2019-05-13 17:21:04 -0700   30) #include <linux/error-injection.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   31) #include <linux/hash.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   32) #include <linux/writeback.h>
53253383fde9e (Linus Torvalds          2007-10-18 14:47:32 -0700   33) #include <linux/backing-dev.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   34) #include <linux/pagevec.h>
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   35) #include <linux/security.h>
44110fe385af2 (Paul Jackson            2006-03-24 03:16:04 -0800   36) #include <linux/cpuset.h>
00501b531c472 (Johannes Weiner         2014-08-08 14:19:20 -0700   37) #include <linux/hugetlb.h>
8a9f3ccd24741 (Balbir Singh            2008-02-07 00:13:53 -0800   38) #include <linux/memcontrol.h>
c7df8ad2910e9 (Mel Gorman              2017-11-15 17:37:41 -0800   39) #include <linux/shmem_fs.h>
f1820361f83d5 (Kirill A. Shutemov      2014-04-07 15:37:19 -0700   40) #include <linux/rmap.h>
b1d29ba82cf2b (Johannes Weiner         2018-10-26 15:06:08 -0700   41) #include <linux/delayacct.h>
eb414681d5a07 (Johannes Weiner         2018-10-26 15:06:27 -0700   42) #include <linux/psi.h>
d0e6a5821cdf0 (Ben Dooks               2019-10-18 20:20:20 -0700   43) #include <linux/ramfs.h>
b9306a796cad8 (Yang Shi                2020-08-06 23:19:55 -0700   44) #include <linux/page_idle.h>
ffa65753c4314 (Alistair Popple         2022-01-21 22:10:46 -0800   45) #include <linux/migrate.h>
07073eb01c5f6 (David Howells           2023-02-14 15:01:42 +0000   46) #include <linux/pipe_fs_i.h>
07073eb01c5f6 (David Howells           2023-02-14 15:01:42 +0000   47) #include <linux/splice.h>
f9ce0be71d1fb (Kirill A. Shutemov      2020-12-19 15:19:23 +0300   48) #include <asm/pgalloc.h>
de591a82f41b6 (Will Deacon             2021-02-10 11:15:11 +0000   49) #include <asm/tlbflush.h>
0f8053a509ceb (Nicholas Piggin         2006-03-22 00:08:33 -0800   50) #include "internal.h"
0f8053a509ceb (Nicholas Piggin         2006-03-22 00:08:33 -0800   51)
fe0bfaaff8442 (Robert Jarzmik          2013-04-29 15:06:10 -0700   52) #define CREATE_TRACE_POINTS
fe0bfaaff8442 (Robert Jarzmik          2013-04-29 15:06:10 -0700   53) #include <trace/events/filemap.h>
fe0bfaaff8442 (Robert Jarzmik          2013-04-29 15:06:10 -0700   54)
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   55) /*
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   56)  * FIXME: remove all knowledge of the buffer layer from the core VM
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   57)  */
148f948ba877f (Jan Kara                2009-08-17 19:52:36 +0200   58) #include <linux/buffer_head.h> /* for try_to_free_buffers */
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   59)
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   60) #include <asm/mman.h>
9691e4430fbb5 (Nhat Pham               2023-04-21 16:14:20 -0700  @61) #include <linux/mman.h>
9691e4430fbb5 (Nhat Pham               2023-04-21 16:14:20 -0700   62)
9691e4430fbb5 (Nhat Pham               2023-04-21 16:14:20 -0700   63) #include "swap.h"


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

