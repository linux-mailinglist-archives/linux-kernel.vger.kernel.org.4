Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA56FBFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjEIG4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjEIG4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:56:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E2A5F4
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683615361; x=1715151361;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FTpw8i8WzY19esPBXIN9TcafXUPqQ0xRwZEIHmLPY9w=;
  b=laMdASLLJk1M28xM7ftsOglAtzUozLoEALyybYWUgDfziNSG5gGbhUWf
   rWktnJ2NeaCemGemwbGUW1Vt4n49vfH33+yGP4qQmI/pFx8jCX5bGAJb1
   hhkenUmY+AOOZMCXg2niGZ9dcAVlnGUTWsJ19IQHnwYfl7GzALSb/4HEQ
   AVEkOqT1XMJ5FfceJhIF3NccBL+eSW0wRG+lECig8rHORaZJcHiBaiXWh
   eM5Dyy6+Y/8DX9mHw9DDNovajKOVUvSSmAK8j83BVcisC4lsKxgGGAitM
   560uymCNWJuJHQw9LDxk2KnF+fetfTzvNTqjfVhJ/j62NGt0PnRXt+RAq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347284370"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="347284370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 23:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945153336"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="945153336"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2023 23:56:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 23:56:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 23:55:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 23:55:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 23:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C14Zd8cyk1NSFxO46YbRXS+UdoXppRWcZhyXFyLk53TRqgTlFueOq/pTQeb7Pp2y8PzhQ4OWT/a59W2670d3SrT4hMDLHsEH0yKzEOOmpzGvZG0zYxc1yjuMJYH0/ZW7voX6KWmKaV1xOdNNarU0jRJBO57hiYCmGN/vLU+ZdNHnU2whSlxr26SmF1CmXRzLvxgugZDRZwRp0VCw4ZH2Suowx14YydbDKrEivaOrQFHV19TaMOJieHgj5k+nDtwOhzsydoq1uRXY5Rpb03fTsmWs5jjwPYYl4OQ9pM02uTp+leAVGZGoK2EWGgC2U4D/qoXRfJwuy9A4gFu01Ug05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jnrYXMuMqYHmeEeGi6bkCYD7MSnzz82xX/iiv0YpwI=;
 b=TSO0/vILrpPVHZYGA6bgs5Mnm2Ts2kN+JXIRY5p/W3pthOawWrnSn2oq4UEFl2Ar3ciIfI3JFj67XIyq452WUhJ6A1xPE8xS+I/RtJTD554xkWySP7xNiAsIHVYacOM9E0jt/G7u036lqGf0MDyqgcRNnM0kbNp5jZZg3UjcvlJ+xkvyzN3ZwtIxIPPt37+5Q06yVjWoICM+3SQduTrz52ctTBcTR8eanVc36gMa3ByTTDLx9WxPTFoWmBK9tC6c7OV/We920rcwlmtyo+jC0mFapobzaamCVSgk3wHANPQiCkJYI/vd0GEoDuiQvvJmRO0EWsLiFf0/GNxV5miSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 06:55:57 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d1a0:743b:4659:b72]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d1a0:743b:4659:b72%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 06:55:56 +0000
Message-ID: <57453f01-ac47-b683-7296-2e6b7275edd1@intel.com>
Date:   Tue, 9 May 2023 14:56:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [linus:master] [mm/mmap] 28c5609fb2: aim9.page_test.ops_per_sec
 -10.8% regression
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202305061457.ac15990c-yujie.liu@intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <202305061457.ac15990c-yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ded1066-e76b-45ac-921a-08db505a6fc5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmaoZt1WLWP5jyJdUx2tz9KjBC5RNTPJDbVP4JlGCnCD4gZepSGyiZqAWI5nU+6MmmfcSt7kDmn5JJp/XpU+5o9tWecRoXXgTf0jxhu18iwV55e8nmPVsfc1ZbaVfqmk1+Sv2vhmZ6TlnDOQPYzhGWb9WO6LgsjXDA5CCtaunlSaLkKNJFZvtWGwjSuiNfxB2h816V6bxEqRVYVFrlNPHCcAdcMy8lHdsY/IADBhr1ZSc//WLmyiMHFUd/ysizK6xw6327n7wv1zn1lV41ksk7GvbNhAf8h6kaiAZa67STYVg+4Qg3VSO3mKIOmpVs4C51eyaLmPExqPFpT/7klHg9bIQrILHAcWv0hHhKw9yAXKYp2QeZVU+hD9CcPcZh6AJAQEJIwE7O/gdxQxvvv1J2x9fcTSAXUtfGfIxabuptrB0qvksX4utb7+JT/Xx/yYM5c9SdXbaVF6EARB6Xbqfldx2gKai+zYPyJDmZxU5fq48lGs5erleB333BysG/Z2FK9gKrmXnSIShpbwnVFUXVmqIWq/n5uKYUfHHDbVuMmlnWkd8qVAHZaofRur0uvahKONIb9ksa7bPdVQrmEwWG7cVKrtqQ4s6dmzzuZd9X83HyyKu5ZvCdoXZbfXsoe/CpJ8KVZzD2SPHrlGEjP05o0VSHeBHrJi1suL4jXB8R4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(31686004)(54906003)(4326008)(2906002)(8936002)(478600001)(316002)(66476007)(5660300002)(66556008)(8676002)(41300700001)(110136005)(66899021)(66946007)(6486002)(966005)(6506007)(6512007)(53546011)(26005)(107886003)(186003)(82960400001)(2616005)(36756003)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2o5SWhpbFZaSG9aQU9VRllDNjIxcXpmK1gzZVY1NGtDMlBmNkNVQk1lWWtT?=
 =?utf-8?B?dzNXVGpmZ0QrSGRSc0lqUkIySXBQZkVHL0RZTHloL29Ub0gxMEw1Rmd6Nkt2?=
 =?utf-8?B?aWd0cnRJYzQ3NEttM2RuZG1LVDZ6ZENOL1cwOFZ3VDdhM2FjWDZEenZSYU95?=
 =?utf-8?B?V2lVUHNYcmRpK202aml4UWwwbkxwUkxBK2ZldTdWdEFMcTJkVXErZ2gwNjFh?=
 =?utf-8?B?bTdhanhMazNBRXhCa3BqUFVPdDZuUlR1ZjRsSTl1WXZiYUtnRnBkbnc0WEhw?=
 =?utf-8?B?eTVGZmd4M1V6M1VFMTdnR3h5TEJ1ZmxlTlZxb0RjdTNoek1WeXFoeFJOUHJv?=
 =?utf-8?B?YjFLM08wUGZMbXdQL1ZLYUpBVzQ3SG5iK2pKSndKZDFFeEZjdVhERC9OUFhl?=
 =?utf-8?B?WDk3a0UzZ1hsVFZmSDEzbEwyaUUyVjVndEFpY2RYeXdZQ1haU1RlSVdORkox?=
 =?utf-8?B?UXdLSW1iQXYyR1FlcWtYb1VJeXZqdUlaQ3Y1TTM4YmdKbmRsWk90eWlaREV2?=
 =?utf-8?B?cWF0ZFlHT2NSeTgzcDgrMWZQOXZmZ1U0WlR5ZkxtYzlyeUFxQXdpbmxTVWJR?=
 =?utf-8?B?ZTV2M2JYMndHK0cvN1ByUU91Q1h1SStIcU5COGhvRlE2NWxCbERjbTBSdUlv?=
 =?utf-8?B?M0tPMEJxUzc2SkVrTmJlUFl1ZUh0TjY2T1F6dURXN245M3lwbEdPZG1mc2g2?=
 =?utf-8?B?Y0F5MnFCbURNVDRXbENSazY1Z0ZaZjYrendxbU9aSEo3a2M1R0U5Vk5tZDZw?=
 =?utf-8?B?T3RhNW8vMDMyTTg3RkJVVmJ2VGRyUnV5RktTNnEvNVdHWWsrR0hpbkxqSXkx?=
 =?utf-8?B?RisxcWs2VXR0Y25sTUhhZ3FadXl1eUJua0N1QTJtNkRSMzV4c0xDek5yenlu?=
 =?utf-8?B?eVltbWc5OE1Ca01kUGF0UFlOUEpVSDNWanNDb2U0RWcrQXQvN1hZZFJFWSto?=
 =?utf-8?B?aXZOcWR6cUVPODJJUkRsMWdIak84NkpQSUcwZWdMLzRDeWxRWXJxazY4V2Zy?=
 =?utf-8?B?R1dlK0pRcmxtbnFkeG1MMUlrSHV4UDdtQ0VBczV5OU1KTzZqL2Yzdzg5UFFi?=
 =?utf-8?B?L0VBUG9nUHFsMDV0eGw5NVp5R0lVTXQ4M2xTR3ducU5QWFh1RW55SUJFS2hi?=
 =?utf-8?B?UzRvVVNSYXgwZER3bzdadTJKT25PbnRPc2ZzMGNPd0s1MmJISlpyUUN5TDJZ?=
 =?utf-8?B?NTlGaDJaTTgrZ21aZHJ0M2Ywc0xoa3duNXhKZVd0NmlmaDhUbHlPRm5aRWJI?=
 =?utf-8?B?VU1LUDN1MUtTNlUzZEhOMmlpalhtaHJFZ0NnMklrWUo5TkNoVUcvY1UvRjdu?=
 =?utf-8?B?UmQzWUttaVJiWFJYMy9EVXVucjQ4UkRxNGF3NXVxVzJMVkxXWmd2UlZkcnBQ?=
 =?utf-8?B?RVpSS1hubG5IRU53cUJEMXJCcndRc3FyWENJMXljRU9Helo2Vy9GWEp0eEtq?=
 =?utf-8?B?RjBTVUhzdVY4RnNZck1WRmtNNzZKVkNpcktEWHlqb1ZMYzROOTRSdUxtYjF5?=
 =?utf-8?B?NlZWVHRWMlQzQ05rOTJQTkVvNzUwTnhRTEdBMklEd3lMWXVEbHJuV2sybER1?=
 =?utf-8?B?eUtoOTd1V1huSjM0ZFJIVytZR2J5dnZmeW9MZkJQVU94eVdMQ21TcWZHSDRp?=
 =?utf-8?B?YlJqYjBMZDY4QzExTjM0aFpKblltcGV2N0htZFhkUEgweFN2cU1mUjZ4Njk4?=
 =?utf-8?B?enJnc1pkYVBUaFB2TTZFUjhYWi9VajBHakpKbGhKODBkL3J3VFFUcEloM0Fo?=
 =?utf-8?B?K09yVFVmRHMyRnZkbjQvK0hHZEFVMC9CZkRPZ000VUFBeUhnNlp1MjlLM04x?=
 =?utf-8?B?TjZ6MnEyTkJjWG9XTVMxeitpS25xdkpteDFjdENMYWNTVmdtY0NGNkptNW80?=
 =?utf-8?B?eDlMQ0dZWUJvcGtIUG5JQm9UZVhINVRMd0FNOFdqYU80eXVEWUtTNktMZmwv?=
 =?utf-8?B?ZlZib0NpSFRjRTBDT1hUbTJMUTlrVFdOSnFIMm1mVVh0V0tGU05RUEh6QzhI?=
 =?utf-8?B?ZnB4L1NJQkUvcEwzS1ZBaWwyQ2lBSnlmMEEzMDg5cGVxRlVoRkdnKzd0VTA0?=
 =?utf-8?B?NnNtb05vRXU0ejdDeis1M3ZoZlhuRGhaeUxFbEVTOExQOUF6Qkkyc2ZueEQ2?=
 =?utf-8?Q?ogSevF7DbWw4fGVUAWJggbBsA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ded1066-e76b-45ac-921a-08db505a6fc5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 06:55:55.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X3wvg0v3rMiWBm7sydUc1NlXEpFMz8ycVmgkvsmfU5vpMI40U1qdOmVVy2wJPvayufQ4ulJ90NmFhw1Q8149w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On 5/6/23 14:20, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed a -10.8% regression of aim9.page_test.ops_per_sec on:
> 
> commit: 28c5609fb236807910ca347ad3e26c4567998526 ("mm/mmap: preallocate maple nodes for brk vma expansion")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: aim9
> test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
> parameters:
> 
> 	testtime: 5s
> 	test: all
> 	cpufreq_governor: performance
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202305061457.ac15990c-yujie.liu@intel.com
> 

Some finding related:
   eBPF funclatency tool says the latency of function do_brk_flags() doubles
   with the patch 28c5609fb2.

   With the patch 28c5609fb2, the mas_alloc_nodes() is called much more than
   without the patch.

   In my local debugging env, I can see around 17009999 times call to 
   mas_alloc_nodes(). The number is zero without the patch 28c5609fb2.
So we are kind of sure the regression is connected to the patch.


The page_test of AIM9 is doing following work with single thread:
        newbrk = sbrk(1024 * 1024);     /* move up 1 megabyte */                
        while (true) {                   /* while not done */                    
                newbrk = sbrk(-4096 * 16);      /* deallocate some space */     
                for (i = 0; i < 16; i++) {      /* now get it back in pieces */
                        newbrk = sbrk(4096);    /* Get pointer to new space */ 
		}
	}

Is it possible that the sbrk pattern triggers the corner case? Thanks.


Regards
Yin, Fengwei

