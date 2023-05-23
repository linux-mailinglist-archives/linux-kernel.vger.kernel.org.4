Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5970D303
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjEWFAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEWFAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:00:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E9FA;
        Mon, 22 May 2023 22:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684818034; x=1716354034;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4pLEWI7qb1t9YvFZKQTHziljH/fu8EbQo8km9zFYVVc=;
  b=DtlSC9tlw5hKyfVGlxxkHJgHB6BAej7NRYbM+2kbqadcSO9+/2Ocx9We
   /JGrlyPCnWj15SshRZsCdHlxlFC4oUsiasimpkt2RJl12nlG7Bs4auUuw
   uRkgYH2DlkEjJ4FUP7+XijXdXTog4/GfBWRtvM3Nkzh4ztos3CxmWQ2xb
   8UyrG8WUD/rIBBLHweOZHDEkmb9IXz5AXJYkhEw9eeQ6/E94za1owxAap
   yxwDubS2/Tg4/o4gKfj0xYHzVyQNj9aSDSZVSpLw88I5Xs76tsr5mRJ7X
   rdnWh/0bCTwY0bfJi5J879Zhu1yp/S8Tjq7K/xd67OqvuLsx0wGfyMFHa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418835558"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="xz'341?scan'341,208,341";a="418835558"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 22:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="878051201"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="xz'341?scan'341,208,341";a="878051201"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 May 2023 22:00:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 22:00:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 22:00:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 22:00:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 22:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3/AY2zWP7Cr+Pwd7cdHeB/CfBLEDyqJc0T+O/PJ7iN+Z9Rolh/cAl0VIMBNxCBaMsmQvWS6rnoENE0AU8BxLCnx/BtHNPlzwra7L/X6x9IlTxzB0fBYACgksgaZz6zUaP3zUCuH3YpILiJhqA07bzHZsyEx/QUwHt4ecCxP0zl0Kr2FVheWGiUgRHC9DqE+O7vsfQbOgNdJUW0x0/zSmZqdY98aNKECv8V27THCmAdGsN+CA+oNG7NZSzqRcct0K7N/HIRtKyVIMK9IYPx8SEUHNas8C2YaNGT73V/MEmtmiyf28GRh13G/MYo5eHeiPGNa4OYuoenxCDS+y4CteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCP3yhfuMVXGR+6NfYfHT0dYq/4ZbIQ8w/fvSy7XTd0=;
 b=nwdCHp9YOK/IO2buracyLREryyfMOJ4SAY1fmK1VjfYU900ynbBnWYf4xspNHbPqs9qvfKJFlMqwsbwYfX4K8W3pd5MWEh+TlJrcRYdKqeXMRvNo9px5tIaC1Kve5phQBa/gIkIYVMxbF5vJau/7OLXwTGE8IChXhyPjK3M7DNnSOgmDNM8vWf1k880mLZSEqGyYADbqbd7f+FQWg+ChCBIi/8TmVbRPAtX5I5bzbN65NU5+YY9q3WMjtbXt+UnoM7AwP4tvuA5/9XPq1+ClnITmxkW5XC2mKVX6+Op0vq/aAc10npySsmMEbGudddGE915wzhOO7tKJR+k+qU47ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 05:00:23 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 05:00:23 +0000
Date:   Tue, 23 May 2023 13:00:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Ackerley Tng <ackerleytng@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <willy@infradead.org>, <vannapurve@google.com>,
        <erdemaktas@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <stable@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()
Message-ID: <202305231207.35d53791-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="xLgmAFTaR/jzHG3Q"
Content-Disposition: inline
In-Reply-To: <20230505185301.534259-1-sidhartha.kumar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 3749f202-4222-47d1-9aca-08db5b4a9d2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TN5Q3K6CU4OckGemyD/VWT8wYzBXQ4QPj9QecIel7lNMybGZM2uYBOWTHZK5RBggDY2rzF0tCbn6zVzT0FSa/Vl1+SLNlhSpN/ZRVqafhPZH540FZtVtq0Wc6nssfJA0YAdcVfTbBrX7lmw0FsfDr9HwAb0piX5YgSFXJ1FsjWD6ZFHkdxkCyRuH86RrDPc3trmBBSKiC8Su39dGmNEVhQKUTwIwDO45Bnj24Vmsb/Zuj4pt5xRtlPt30vZnNpifozHHYGxfqijlFv0qvrDhO6GE9SohBWk5rHuHxzeaZVmqtafg/nKCt3Dmf5wJNx0lWXVeUCql9QOo6sZEW0Z1AGIofPRCmAUQ0yrivPRAItfwVwo046a1ojZ4OOHFaSzYfWqxZ9OEXyDI1So9u7yGvNvd6b2/Y02phsEzD0naJyG47CMcSHZsFfYXahc7tH4fk60BfMyiYdvZBBMGyFpCn8Se7QWDmsFJZy00t0k20Aj4uQPreR26GK7S2J1fTbcJO6+KRMLg3qtlg0pVmYK1ymS3b0MP9IM1/14EgLiM7Vq7QmL72KJaNged1czPpMo3ReFpQjCPV/4NbZzBHQ+oNvFZwtHsKZ1IDdM2I6BNTbd3DRhQjdGTl17hyBTBCCOqiBLzB+XHn2G7kxXeASUEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(235185007)(7416002)(186003)(6512007)(6506007)(2616005)(86362001)(1076003)(26005)(38100700002)(82960400001)(83380400001)(107886003)(6666004)(41300700001)(6486002)(44144004)(966005)(66476007)(66556008)(66946007)(316002)(478600001)(6916009)(36756003)(4326008)(54906003)(2906002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PG2f0uVop2twke6OgeY3EVprRinCPSK9LsGMOiyYGMRjzXc2rgUgfTBU3RaT?=
 =?us-ascii?Q?G/1y2HMW54T9ffWJcwZIFM/EiJ3i/uApM+on3mWIr2u8rQSScvFnvwS+aY7S?=
 =?us-ascii?Q?jQZa3vzqpiGZjvFiHITU/6uYceIy9zJXTTq0ntKa5uK/AZp6rdc+ppSvkTS/?=
 =?us-ascii?Q?vBqGU/SKf69iBlYWsU9DI+sNfgKLGZ20TZ2b1ysH7PhpIPGy+pkbibToCDzu?=
 =?us-ascii?Q?se/18SlmCGYq/Z7NEUnnr+diW07YB7mrxBhKscLxDh0RSlV+4v/f3X+SM3SN?=
 =?us-ascii?Q?08Ikw2waNzSQpCeekqRuveioVeOq2EwwdKx7GGW0F2Nxysx6LgYCFgySKKGm?=
 =?us-ascii?Q?WbWLHGqWRmALcgAfdkzuKNKDT8APPTPR4DBwKNZPrD2EqllBPTAauh26pUqX?=
 =?us-ascii?Q?askpjyrT12OrjOvCqsW/r4VZTFJ7Lk+KGOPZssi57rGKidHeuWBzmi6bU5n/?=
 =?us-ascii?Q?in2RWaVjcY7++9UqWyY1ytG8DjyjBIPsTiRAapAswLAkPrGkrRe2xgPxNVJw?=
 =?us-ascii?Q?qnH0HGP4xuBEhr0y8Ah2OOQnVP6S7HQl957KsZizqgNGZpkxpJvIjJHlyGXn?=
 =?us-ascii?Q?wYw88mZ7wVBnfpLky3VaxjcVUmJl+G9X5tFwMgfZvrseWHFWoZmew3rrGw0e?=
 =?us-ascii?Q?QwCrFqLrCF/gtbzTdCm3Hv4uJeuLnOAg/ziJ0eZCX8qvI+nDlgM2wTVfSLxB?=
 =?us-ascii?Q?JvNCVD7Neg5ZCHIhIxlKALGcCCpM/solr1IheQ1G9YEC31HnRooqF7AQ/00f?=
 =?us-ascii?Q?GAUHE8F8pye5ypwa70EDD04rDh8lQkZR571o9QMaAiAri4D3UEGMh7Yd9ssF?=
 =?us-ascii?Q?LjXpV5fAmzZ8aCr5QxhrnGEeTW+sFrAghXDSq7Jy81oAqr6CSfLpwQS6vIw/?=
 =?us-ascii?Q?pcesZTcCYszWTq1nufaT9Et1KIrSWT6r4RqvHs2HHEIthh1vaZBxllZKKiMH?=
 =?us-ascii?Q?VhbZMOjxihrwaDZtRWcC4WxSI5U9cZbZYEwQHgRAaYa+6P2SwHJ8dmTeLTY7?=
 =?us-ascii?Q?S5cMk981+W4pKLH9uss42p1FYJDiulSl4WOydJ7D2GJHeIOrGh0Sgb4RrZa7?=
 =?us-ascii?Q?wqd+ySSLINY1Vs+fiWqZx1jPW6wnCjbZOwT5snXWn26fNZjpzzSKMTAu8bzj?=
 =?us-ascii?Q?o85atofVeqQsbhEkeudnHiHnWd5aiXjD9pfVk1TW/lEemeG//AFxfENN3fu1?=
 =?us-ascii?Q?D2Rof6GvXWq5YlP/1t3Gt06Esx5wRKKZF8bcNgLIMrRAdAr1HK9rn+gUFRl/?=
 =?us-ascii?Q?UFZ/OcMYt5MKTK3+59XXVGAS/jlYe7BWPedvi6NZyLzk7hJQiOMTYIUNRF9K?=
 =?us-ascii?Q?ADA3DLpOXUtfXKgDN0VIxlTsYQJ8WGrU4MHrdJ67x510uhlvESJn7Mx1swX+?=
 =?us-ascii?Q?edVv8SvvD00H+ejWjaBnnXXqOo9ckmVTIak7Ce1nQv5uTSV49L7b2YQT3WkF?=
 =?us-ascii?Q?yiU/JzeHo4+9kOYx4AxiD7KJGG0DitzdJqye4JBKgzTmYOsZd2VLJp3xVRYg?=
 =?us-ascii?Q?HEmtFnGt/R5FwnxNnTSUaEGE4CI45YAWQTIBnwahnycdDcYjI0Cp6K5fwMFC?=
 =?us-ascii?Q?5eV5Gaj//8vTrEZBt8oMbMoRGto7fbkKdr4rR7B+Bb66nMbOTgN23StnAysK?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3749f202-4222-47d1-9aca-08db5b4a9d2c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 05:00:23.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ymnp1z4xmMiwG1ldVSc1uHOPfIn1FlrWcCSjPd+YVTG/dbvlnybRFEQzQQTuKExInIL+qrG4rauQPUAKGvspOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xLgmAFTaR/jzHG3Q
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_hugetlbfs_fallocate" on:

commit: 1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1 ("[PATCH] mm/hugetlb: revert use of page_cache_next_miss()")
url: https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/mm-hugetlb-revert-use-of-page_cache_next_miss/20230506-025434
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 78b421b6a7c6dbb6a213877c742af52330f5026d
patch link: https://lore.kernel.org/all/20230505185301.534259-1-sidhartha.kumar@oracle.com/
patch subject: [PATCH] mm/hugetlb: revert use of page_cache_next_miss()

in testcase: trinity
version: trinity-x86_64-abe9de86-1_20230501
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: clang-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202305231207.35d53791-oliver.sang@intel.com


[ 144.098719][ T1547] BUG: KASAN: null-ptr-deref in hugetlbfs_fallocate (inode.c:?) 
[  144.099404][ T1547] Read of size 4 at addr 0000000000000032 by task trinity-c1/1547
[  144.100071][ T1547]
[  144.100282][ T1547] CPU: 0 PID: 1547 Comm: trinity-c1 Not tainted 6.3.0-13165-g1f944358dbb5 #1 1f0cfaa9708c3e99bb7e2ecf8f7fd22c51fc3e3b
[  144.101310][ T1547] Call Trace:
[  144.101602][ T1547]  <TASK>
[ 144.101858][ T1547] dump_stack_lvl (??:?) 
[ 144.102269][ T1547] print_report (report.c:?) 
[ 144.102655][ T1547] ? start_report (report.c:?) 
[ 144.103044][ T1547] ? hugetlbfs_fallocate (inode.c:?) 
[ 144.103497][ T1547] ? hugetlbfs_fallocate (inode.c:?) 
[ 144.103937][ T1547] kasan_report (??:?) 
[ 144.104270][ T1547] ? filemap_get_entry (??:?) 
[ 144.104656][ T1547] ? hugetlbfs_fallocate (inode.c:?) 
[ 144.105082][ T1547] kasan_check_range (??:?) 
[ 144.105503][ T1547] hugetlbfs_fallocate (inode.c:?) 
[ 144.105921][ T1547] vfs_fallocate (??:?) 
[ 144.106317][ T1547] ksys_fallocate (??:?) 
[ 144.106702][ T1547] __x64_sys_fallocate (??:?) 
[ 144.107121][ T1547] do_syscall_64 (??:?) 
[ 144.107521][ T1547] entry_SYSCALL_64_after_hwframe (??:?) 
[  144.108022][ T1547] RIP: 0033:0x7fedb9a039b9
[ 144.108398][ T1547] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54e1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54b7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  144.109953][ T1547] RSP: 002b:00007ffdf492f6a8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
[  144.110612][ T1547] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fedb9a039b9
[  144.111233][ T1547] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 000000000000011a
[  144.111870][ T1547] RBP: 00007fedb839a000 R08: 0000000000000020 R09: 0000000000000090
[  144.112514][ T1547] R10: 0000000000000800 R11: 0000000000000246 R12: 000000000000011d
[  144.113168][ T1547] R13: 00007fedb9ad1580 R14: 00007fedb839a058 R15: 00007fedb839a000
[  144.113814][ T1547]  </TASK>
[  144.114073][ T1547] ==================================================================
[  144.114752][ T1547] Disabling lock debugging due to kernel taint
[  144.115284][ T1547] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] KASAN
[  144.116161][ T1547] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[  144.116830][ T1547] CPU: 0 PID: 1547 Comm: trinity-c1 Tainted: G    B              6.3.0-13165-g1f944358dbb5 #1 1f0cfaa9708c3e99bb7e2ecf8f7fd22c51fc3e3b
[ 144.117939][ T1547] RIP: 0010:hugetlbfs_fallocate (inode.c:?) 
[ 144.118431][ T1547] Code: 84 9c 00 00 00 48 89 c5 48 8d 58 34 48 89 df be 04 00 00 00 e8 d5 83 ca ff 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <8a> 04 08 84 c0 0f 85 d8 01 00 00 83 3b 00 0f 84 3a 07 00 00 48 89
All code
========
   0:	84 9c 00 00 00 48 89 	test   %bl,-0x76b80000(%rax,%rax,1)
   7:	c5 48 8d             	(bad)  
   a:	58                   	pop    %rax
   b:	34 48                	xor    $0x48,%al
   d:	89 df                	mov    %ebx,%edi
   f:	be 04 00 00 00       	mov    $0x4,%esi
  14:	e8 d5 83 ca ff       	callq  0xffffffffffca83ee
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df 
  2a:*	8a 04 08             	mov    (%rax,%rcx,1),%al		<-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 d8 01 00 00    	jne    0x20d
  35:	83 3b 00             	cmpl   $0x0,(%rbx)
  38:	0f 84 3a 07 00 00    	je     0x778
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	8a 04 08             	mov    (%rax,%rcx,1),%al
   3:	84 c0                	test   %al,%al
   5:	0f 85 d8 01 00 00    	jne    0x1e3
   b:	83 3b 00             	cmpl   $0x0,(%rbx)
   e:	0f 84 3a 07 00 00    	je     0x74e
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[  144.120027][ T1547] RSP: 0018:ffff88812ba3fd48 EFLAGS: 00010206
[  144.120545][ T1547] RAX: 0000000000000006 RBX: 0000000000000032 RCX: dffffc0000000000
[  144.121198][ T1547] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8a927100
[  144.121864][ T1547] RBP: fffffffffffffffe R08: dffffc0000000000 R09: fffffbfff1524e21
[  144.122535][ T1547] R10: 0000000000000000 R11: dffff7fff1524e22 R12: 0000000000000000
[  144.123214][ T1547] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000fffffffc
[  144.123947][ T1547] FS:  00007fedb9ad1600(0000) GS:ffffffff87f0a000(0000) knlGS:0000000000000000
[  144.124701][ T1547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  144.125263][ T1547] CR2: 00007fedb95005fc CR3: 000000012dfd0000 CR4: 00000000000406f0
[  144.125925][ T1547] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  144.126601][ T1547] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  144.127277][ T1547] Call Trace:
[  144.127584][ T1547]  <TASK>
[ 144.127848][ T1547] vfs_fallocate (??:?) 
[ 144.128251][ T1547] ksys_fallocate (??:?) 
[ 144.128646][ T1547] __x64_sys_fallocate (??:?) 
[ 144.129072][ T1547] do_syscall_64 (??:?) 
[ 144.129460][ T1547] entry_SYSCALL_64_after_hwframe (??:?) 
[  144.129972][ T1547] RIP: 0033:0x7fedb9a039b9
[ 144.130359][ T1547] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54e1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d a7 54 0c 00 	mov    0xc54a7(%rip),%rcx        # 0xc54b7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


To reproduce:

        # build kernel
	cd linux
	cp config-6.3.0-13165-g1f944358dbb5 .config
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--xLgmAFTaR/jzHG3Q
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="config-6.3.0-13165-g1f944358dbb5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 14.0.6 (git://gitmirror/llvm_project f28c006a5895fc0e329fe15fead81e37457cb1d1)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=140006
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=140006
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=140006
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_FORCE is not set
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
CONFIG_RUST=y
CONFIG_RUSTC_VERSION_TEXT="rustc 1.62.0 (a8314ef7d 2022-06-27)"
CONFIG_BINDGEN_VERSION_TEXT="bindgen 0.56.0"
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
# CONFIG_EFI_MIXED is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
# CONFIG_EFI_RUNTIME_MAP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
# CONFIG_ADDRESS_MASKING is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_ACPI_FFH=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
# CONFIG_ACPI_PRMT is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_DMAPOOL_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_MAX_SKB_FRAGS=17
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_VMD=y
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_XILINX is not set

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCI_MESON=y
CONFIG_PCIE_INTEL_GW=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
# CONFIG_CXL_PCI is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_PMEM=y
CONFIG_CXL_PORT=y
# CONFIG_CXL_REGION is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_CACHE is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_FW_CS_DSP=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
# CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
CONFIG_EFI_DISABLE_RUNTIME=y
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_ZRAM=y
# CONFIG_ZRAM_DEF_COMP_LZORLE is not set
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP_842=y
CONFIG_ZRAM_DEF_COMP="842"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_ZRAM_MULTI_COMP=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_UBLK=y
CONFIG_BLKDEV_UBLK_LEGACY_OPCODES=y

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_SMPRO_ERRMON is not set
# CONFIG_SMPRO_MISC is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_GSC=y
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
CONFIG_PVPANIC_PCI=y
CONFIG_GP_PCI1XXXX=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=y
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
# CONFIG_MEGARAID_MAILBOX is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_FLASHPOINT is not set
CONFIG_SCSI_MYRB=y
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=y
CONFIG_SCSI_SNIC=y
CONFIG_SCSI_SNIC_DEBUG_FS=y
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_ISCI=y
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_DC395x=y
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_DWC=y
# CONFIG_AHCI_CEVA is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5520=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_APPLESPI=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PINEPHONE=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_IQS62X=y
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TC3589X=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MTK_PMIC=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_SSIF_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
# CONFIG_I2C_ALGOPCA is not set
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PCI1XXXX=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_FSI is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_CADENCE_QUADSPI=y
CONFIG_SPI_CADENCE_XSPI=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_FSI is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_INTEL=y
# CONFIG_SPI_INTEL_PCI is not set
CONFIG_SPI_INTEL_PLATFORM=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_MICROCHIP_CORE=y
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PCI1XXXX=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SN_F_OSPI=y
CONFIG_SPI_MXIC=y
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_LOCHNAGAR=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_OF_GPIO_MM_GPIOCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_FXL6408=y
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD71815=y
# CONFIG_GPIO_BD71828 is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_CRYSTAL_COVE=y
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TPS68470 is not set
CONFIG_GPIO_TQMX86=y
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WHISKEY_COVE is not set
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=y
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_AXP20X_POWER=y
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_RT9467=y
CONFIG_CHARGER_RT9471=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_RN5T618_POWER=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_SMPRO=y
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_GSC=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LOCHNAGAR is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2947_SPI=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MC34VR500=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC_P9_SBE=y
CONFIG_SENSORS_OCC=y
CONFIG_SENSORS_OXP=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_SENSORS_PECI_CPUTEMP is not set
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ACBEL_FSG032=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_BPA_RS600=y
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR36021=y
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LM25066_REGULATOR=y
CONFIG_SENSORS_LT7182S=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_MPQ7932_REGULATOR=y
CONFIG_SENSORS_MPQ7932=y
# CONFIG_SENSORS_PIM4328 is not set
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TDA38640=y
CONFIG_SENSORS_TDA38640_REGULATOR=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_TPS546D24 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_XDPE122_REGULATOR=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
# CONFIG_SENSORS_WM8350 is not set
CONFIG_SENSORS_XGENE=y
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_SENSORS_ASUS_WMI=y
CONFIG_SENSORS_ASUS_EC=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
CONFIG_CPU_FREQ_THERMAL=y
# CONFIG_CPU_IDLE_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=y
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=y
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
CONFIG_MFD_MAX597X=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_NTXEC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_SY7636A=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS65219=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_QCOM_PM8008=y
CONFIG_RAVE_SP_CORE=y
CONFIG_MFD_INTEL_M10_BMC_CORE=y
CONFIG_MFD_INTEL_M10_BMC_SPI=y
CONFIG_MFD_RSMU_I2C=y
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD71815=y
CONFIG_REGULATOR_BD71828=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_BD957XMUF=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LOCHNAGAR is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX597X=y
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8925=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX8998 is not set
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX20411=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
CONFIG_REGULATOR_MT6357=y
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=y
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PF8X00=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4803=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5120=y
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5739=y
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_SY7636A=y
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS65219=y
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TPS68470=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
# CONFIG_RC_MAP is not set
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=y
CONFIG_IR_FINTEK=y
# CONFIG_IR_GPIO_CIR is not set
CONFIG_IR_HIX5HD2=y
# CONFIG_IR_ITE_CIR is not set
CONFIG_IR_NUVOTON=y
# CONFIG_IR_SERIAL is not set
CONFIG_IR_WINBOND_CIR=y
CONFIG_RC_LOOPBACK=y
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
CONFIG_VIDEO_TW68=y
CONFIG_VIDEO_TW686X=y
CONFIG_VIDEO_ZORAN=y
# CONFIG_VIDEO_ZORAN_DC30 is not set
CONFIG_VIDEO_ZORAN_ZR36060=y
CONFIG_VIDEO_ZORAN_BUZ=y
CONFIG_VIDEO_ZORAN_DC10=y
# CONFIG_VIDEO_ZORAN_LML33 is not set
CONFIG_VIDEO_ZORAN_LML33R10=y
# CONFIG_VIDEO_ZORAN_AVS6EYES is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=y
# CONFIG_VIDEO_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=y
CONFIG_VIDEO_HEXIUM_ORION=y
# CONFIG_VIDEO_MXB is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CX18 is not set
CONFIG_VIDEO_CX23885=y
CONFIG_MEDIA_ALTERA_CI=y
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=y
CONFIG_VIDEO_CX88_ALSA=y
CONFIG_VIDEO_CX88_BLACKBIRD=y
CONFIG_VIDEO_CX88_DVB=y
# CONFIG_VIDEO_CX88_ENABLE_VP3054 is not set
CONFIG_VIDEO_CX88_MPEG=y
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
CONFIG_DVB_DDBRIDGE=y
CONFIG_DVB_DDBRIDGE_MSIENABLE=y
CONFIG_DVB_DM1105=y
CONFIG_MANTIS_CORE=y
CONFIG_DVB_MANTIS=y
# CONFIG_DVB_HOPPER is not set
CONFIG_DVB_NETUP_UNIDVB=y
# CONFIG_DVB_NGENE is not set
# CONFIG_DVB_PLUTO2 is not set
CONFIG_DVB_PT1=y
CONFIG_DVB_PT3=y
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_BUDGET_CORE is not set
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_IPU3_CIO2=y
CONFIG_CIO2_BRIDGE=y
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SAA7706H is not set
CONFIG_RADIO_SI4713=y
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
CONFIG_PLATFORM_SI4713=y
CONFIG_I2C_SI4713=y
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
CONFIG_VIDEO_CADENCE_CSI2TX=y

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEOBUF2_DVB=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
# CONFIG_VIDEO_IR_I2C is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_AR0521=y
CONFIG_VIDEO_HI556=y
CONFIG_VIDEO_HI846=y
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
CONFIG_VIDEO_IMX214=y
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX296=y
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
CONFIG_VIDEO_IMX335=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_IMX412=y
# CONFIG_VIDEO_IMX415 is not set
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
CONFIG_VIDEO_OG01A1B=y
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV08X40=y
CONFIG_VIDEO_OV13858=y
CONFIG_VIDEO_OV13B10=y
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
CONFIG_VIDEO_OV4689=y
CONFIG_VIDEO_OV5640=y
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
CONFIG_VIDEO_OV5670=y
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5693=y
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV6650=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7740 is not set
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV8858=y
CONFIG_VIDEO_OV8865=y
# CONFIG_VIDEO_OV9282 is not set
# CONFIG_VIDEO_OV9640 is not set
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV9734=y
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
CONFIG_VIDEO_ST_VGXY61=y
# CONFIG_VIDEO_CCS is not set
CONFIG_VIDEO_ET8EK8=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
# CONFIG_VIDEO_AK7375 is not set
CONFIG_VIDEO_DW9714=y
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV748X=y
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_ISL7998X=y
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_MAX9286 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TC358746 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_L64781=y
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_SP887X=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_VES1820 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_DIB8000 is not set
CONFIG_DVB_MB86A20S=y
# CONFIG_DVB_S921 is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
# CONFIG_DVB_LNBP22 is not set
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_TDA665x=y
# CONFIG_DVB_DRX39XYJ is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_DEBUG_GUC=y
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_MKSSTATS=y
CONFIG_DRM_GMA500=y
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ABT_Y030XX067A=y
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_AUO_A030JTN01=y
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_DSI_CM is not set
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_EDP=y
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
# CONFIG_DRM_PANEL_HIMAX_HX8394 is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9341=y
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_JDI_R63452=y
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NEWVISION_NV3051D=y
CONFIG_DRM_PANEL_NEWVISION_NV3052C=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35950=y
# CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set
CONFIG_DRM_PANEL_NOVATEK_NT36672A=y
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTA5601A=y
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
CONFIG_DRM_PANEL_SAMSUNG_DB7430=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6D27A1=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_SONY_TD4353_JDI is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
CONFIG_DRM_PANEL_TPO_TPG110=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=y
# CONFIG_DRM_PANEL_VISIONOX_VTDR6130 is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CHIPONE_ICN6211=y
CONFIG_DRM_CHRONTEL_CH7033=y
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
CONFIG_DRM_ITE_IT6505=y
CONFIG_DRM_LONTIUM_LT8912B=y
# CONFIG_DRM_LONTIUM_LT9211 is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=y
CONFIG_DRM_LVDS_CODEC=y
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NWL_MIPI_DSI=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_PARADE_PS8640 is not set
CONFIG_DRM_SAMSUNG_DSIM=y
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=y
CONFIG_DRM_TI_DLPC3433=y
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI83=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7511_AUDIO=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CDNS_DSI_J721E=y
CONFIG_DRM_CDNS_MHDP8546=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_LOGICVC=y
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_DRM_SIMPLEDRM=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=y
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_VBOXVIDEO=y
# CONFIG_DRM_SSD130X is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
# CONFIG_FB_CARILLO_RANCH is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_KTZ8866=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_CTL_FAST_LOOKUP is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_CTL_DEBUG=y
CONFIG_SND_JACK_INJECTION_DEBUG=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
# CONFIG_SND_SERIAL_GENERIC is not set
CONFIG_SND_MPU401=y
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_SCODEC_CS35L41=y
CONFIG_SND_HDA_CS_DSP_CONTROLS=y
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
CONFIG_SND_HDA_SCODEC_CS35L41_SPI=y
CONFIG_SND_HDA_CODEC_REALTEK=y
# CONFIG_SND_HDA_CODEC_ANALOG is not set
CONFIG_SND_HDA_CODEC_SIGMATEL=y
# CONFIG_SND_HDA_CODEC_VIA is not set
# CONFIG_SND_HDA_CODEC_HDMI is not set
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_CA0110=y
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
# CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
# CONFIG_SND_SPI is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_ADI=y
# CONFIG_SND_SOC_ADI_AXI_I2S is not set
CONFIG_SND_SOC_ADI_AXI_SPDIF=y
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_SOC_MIKROE_PROTO=y
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
# CONFIG_SND_SOC_FSL_MICFIL is not set
CONFIG_SND_SOC_FSL_XCVR=y
CONFIG_SND_SOC_FSL_UTILS=y
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SOC_INTEL_CATPT=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
CONFIG_SND_SOC_INTEL_SKYLAKE=y
CONFIG_SND_SOC_INTEL_SKL=y
CONFIG_SND_SOC_INTEL_APL=y
CONFIG_SND_SOC_INTEL_KBL=y
CONFIG_SND_SOC_INTEL_GLK=y
CONFIG_SND_SOC_INTEL_CNL=y
CONFIG_SND_SOC_INTEL_CFL=y
# CONFIG_SND_SOC_INTEL_CML_H is not set
CONFIG_SND_SOC_INTEL_CML_LP=y
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=y
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=y
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_AVS=y

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219=y
CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC=y
CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A=y
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT286=y
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=y
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=y
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=y
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=y
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=y
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=y
# CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH is not set
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=y
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=y
CONFIG_SND_SOC_MTK_BTCVSD=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
CONFIG_SND_SOC_SOF_ACPI=y
CONFIG_SND_SOC_SOF_ACPI_DEV=y
CONFIG_SND_SOC_SOF_OF=y
# CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
CONFIG_SND_SOC_SOF=y
CONFIG_SND_SOC_SOF_IPC3=y
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=y
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=y
CONFIG_SND_SOC_SOF_INTEL_COMMON=y
CONFIG_SND_SOC_SOF_BAYTRAIL=y
CONFIG_SND_SOC_SOF_BROADWELL=y
CONFIG_SND_SOC_SOF_XTENSA=y

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=y
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
# CONFIG_SND_SOC_ADAU1372_I2C is not set
CONFIG_SND_SOC_ADAU1372_SPI=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_AK4104=y
CONFIG_SND_SOC_AK4118=y
CONFIG_SND_SOC_AK4375=y
CONFIG_SND_SOC_AK4458=y
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_AW8738=y
CONFIG_SND_SOC_AW88395_LIB=y
CONFIG_SND_SOC_AW88395=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
# CONFIG_SND_SOC_CS35L41_SPI is not set
CONFIG_SND_SOC_CS35L41_I2C=y
CONFIG_SND_SOC_CS35L45=y
CONFIG_SND_SOC_CS35L45_SPI=y
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS35L56=y
CONFIG_SND_SOC_CS35L56_SHARED=y
CONFIG_SND_SOC_CS35L56_I2C=y
CONFIG_SND_SOC_CS35L56_SPI=y
CONFIG_SND_SOC_CS42L42_CORE=y
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS42L83=y
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS4271_SPI=y
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
# CONFIG_SND_SOC_ES7241 is not set
# CONFIG_SND_SOC_ES8316 is not set
CONFIG_SND_SOC_ES8326=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_HDAC_HDA=y
CONFIG_SND_SOC_HDA=y
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_IDT821034 is not set
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_LOCHNAGAR_SC=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98357A=y
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98520=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX98396=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM186X_SPI=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3060_SPI=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM3168A_SPI=y
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_PCM512x_SPI is not set
CONFIG_SND_SOC_PEB2466=y
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT286=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5663=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
CONFIG_SND_SOC_RT9120=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIMPLE_MUX=y
CONFIG_SND_SOC_SMA1303=y
# CONFIG_SND_SOC_SPDIF is not set
CONFIG_SND_SOC_SRC4XXX_I2C=y
CONFIG_SND_SOC_SRC4XXX=y
CONFIG_SND_SOC_SSM2305=y
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_SPI=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=y
CONFIG_SND_SOC_TAS2764=y
CONFIG_SND_SOC_TAS2770=y
CONFIG_SND_SOC_TAS2780=y
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=y
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TFA989X=y
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
CONFIG_SND_SOC_TLV320AIC3X=y
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X_SPI=y
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_WCD9335=y
CONFIG_SND_SOC_WCD_MBHC=y
CONFIG_SND_SOC_WCD934X=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8731_I2C=y
CONFIG_SND_SOC_WM8731_SPI=y
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8770=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8804_SPI=y
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8940=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_MAX9759=y
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=y
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8315=y
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
CONFIG_SND_SOC_LPASS_VA_MACRO=y
CONFIG_SND_SOC_LPASS_RX_MACRO=y
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_AUDIO_GRAPH_CARD2=y
CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=y
# CONFIG_SND_TEST_COMPONENT is not set
# CONFIG_SND_X86 is not set
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=y
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_AW2013=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2606MVV=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MAX77693=y
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_LEDS_SIEMENS_SIMATIC_IPC is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_DW_AXI_DMAC is not set
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IDXD_BUS=y
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IDXD_COMPAT=y
CONFIG_INTEL_IOATDMA=y
CONFIG_PLX_DMA=y
# CONFIG_XILINX_XDMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=y
CONFIG_LCD2S=y
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VBOXGUEST=y
CONFIG_EFI_SECRET=y
# CONFIG_TDX_GUEST_DRIVER is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Resolver to digital converters
#
CONFIG_AD2S1210=y
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
CONFIG_STAGING_BOARD=y
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
CONFIG_FB_TFT_BD663474=y
# CONFIG_FB_TFT_HX8340BN is not set
# CONFIG_FB_TFT_HX8347D is not set
CONFIG_FB_TFT_HX8353D=y
CONFIG_FB_TFT_HX8357D=y
# CONFIG_FB_TFT_ILI9163 is not set
CONFIG_FB_TFT_ILI9320=y
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
# CONFIG_FB_TFT_ILI9481 is not set
CONFIG_FB_TFT_ILI9486=y
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
# CONFIG_FB_TFT_S6D02A1 is not set
CONFIG_FB_TFT_S6D1121=y
CONFIG_FB_TFT_SEPS525=y
# CONFIG_FB_TFT_SH1106 is not set
# CONFIG_FB_TFT_SSD1289 is not set
# CONFIG_FB_TFT_SSD1305 is not set
# CONFIG_FB_TFT_SSD1306 is not set
CONFIG_FB_TFT_SSD1331=y
CONFIG_FB_TFT_SSD1351=y
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
CONFIG_FB_TFT_TLS8204=y
CONFIG_FB_TFT_UC1611=y
CONFIG_FB_TFT_UC1701=y
CONFIG_FB_TFT_UPD161704=y
# CONFIG_MOST_COMPONENTS is not set
CONFIG_GREYBUS_AUDIO=y
CONFIG_GREYBUS_AUDIO_APB_CODEC=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set
# CONFIG_PI433 is not set
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_ACPI_NOTIFY=y
CONFIG_SURFACE_AGGREGATOR_CDEV=y
CONFIG_SURFACE_DTX=y
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_SURFACE_AGGREGATOR=y
# CONFIG_SURFACE_AGGREGATOR_BUS is not set
# CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_HUAWEI_WMI=y
CONFIG_MXM_WMI=y
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
CONFIG_XIAOMI_WMI=y
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
CONFIG_ACER_WIRELESS=y
# CONFIG_ACER_WMI is not set
CONFIG_ADV_SWBUTTON=y
CONFIG_APPLE_GMUX=y
CONFIG_ASUS_LAPTOP=y
CONFIG_ASUS_WIRELESS=y
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_DCDBAS is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
CONFIG_DELL_WMI_AIO=y
CONFIG_DELL_WMI_DDV=y
CONFIG_DELL_WMI_LED=y
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=y
CONFIG_X86_PLATFORM_DRIVERS_HP=y
CONFIG_HP_ACCEL=y
CONFIG_HP_WMI=y
CONFIG_WIRELESS_HOTKEY=y
CONFIG_IBM_RTL=y
CONFIG_LENOVO_YMC=y
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_THINKPAD_LMI=y
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
CONFIG_INTEL_ATOMISP2_PM=y
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_SKL_INT3472=y
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TELEMETRY is not set
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=y
CONFIG_INTEL_WMI_THUNDERBOLT=y

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=y
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_INT0002_VGPIO=y
CONFIG_INTEL_BXTWC_PMIC_TMU=y
# CONFIG_INTEL_BYTCRC_PWRSRC is not set
CONFIG_INTEL_MRFLD_PWRBTN=y
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_WMI=y
CONFIG_PCENGINES_APU2=y
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_SAMSUNG_Q10=y
CONFIG_ACPI_TOSHIBA=y
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=y
# CONFIG_ACPI_CMPC is not set
CONFIG_LG_LAPTOP=y
CONFIG_PANASONIC_LAPTOP=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_SERIAL_MULTI_INSTANTIATE=y
CONFIG_MLX_PLATFORM=y
CONFIG_FW_ATTR_CLASS=y
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=y
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_SIEMENS_SIMATIC_IPC=y
CONFIG_WINMATE_FM07_KEYS=y
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_LMK04832=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_TPS68470 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_CLK_TWL6040 is not set
CONFIG_COMMON_CLK_AXI_CLKGEN=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_SI521XX=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
# CONFIG_INTEL_IOMMU is not set
CONFIG_IOMMUFD=y
CONFIG_IRQ_REMAP=y
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

CONFIG_WPCM450_SOC=y

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_INTEL_MRFLD is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_GTS_HELPER=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL355_SPI=y
CONFIG_ADXL367=y
# CONFIG_ADXL367_SPI is not set
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
# CONFIG_ADXL372_SPI is not set
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_FXLS8962AF_SPI=y
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_SCA3300=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD4130=y
CONFIG_AD7091R5=y
# CONFIG_AD7124 is not set
CONFIG_AD7192=y
CONFIG_AD7266=y
CONFIG_AD7280=y
CONFIG_AD7291=y
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=y
CONFIG_AD7768_1=y
# CONFIG_AD7780 is not set
CONFIG_AD7791=y
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
CONFIG_AD7949=y
CONFIG_AD799X=y
# CONFIG_AD9467 is not set
CONFIG_ADI_AXI_ADC=y
# CONFIG_AXP20X_ADC is not set
# CONFIG_AXP288_ADC is not set
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_INTEL_MRFLD_ADC=y
# CONFIG_LP8788_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
CONFIG_LTC2496=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
# CONFIG_MAX11205 is not set
CONFIG_MAX11410=y
CONFIG_MAX1241=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=y
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_RN5T618_ADC=y
CONFIG_RICHTEK_RTQ6056=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STMPE_ADC=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7924=y
CONFIG_TI_ADS1100=y
CONFIG_TI_ADS7950=y
CONFIG_TI_ADS8344=y
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_ADS131E08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_LMP92064=y
CONFIG_TI_TLC4541=y
CONFIG_TI_TSC2046=y
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74115=y
CONFIG_AD74413R=y
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# CONFIG_ADA4250 is not set
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
# CONFIG_SCD30_CORE is not set
CONFIG_SCD4X=y
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
# CONFIG_SPS30_SERIAL is not set
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD3552R=y
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
# CONFIG_AD5380 is not set
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
# CONFIG_LTC2688 is not set
CONFIG_AD5686=y
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
CONFIG_AD5766=y
CONFIG_AD5770R=y
# CONFIG_AD5791 is not set
CONFIG_AD7293=y
# CONFIG_AD7303 is not set
CONFIG_AD8801=y
CONFIG_CIO_DAC=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=y
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5522=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
CONFIG_ADMV8818=y
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
CONFIG_ADF4371=y
CONFIG_ADF4377=y
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV1014 is not set
CONFIG_ADMV4420=y
CONFIG_ADRF6780=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS290=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=y
CONFIG_HDC2010=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=y
# CONFIG_FXOS8700_I2C is not set
CONFIG_FXOS8700_SPI=y
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=y
# CONFIG_IIO_ST_LSM6DSX is not set
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
CONFIG_AS73211=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_ROHM_BU27034=y
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LTRF216A=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_IIO_ST_MAGN_SPI_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
CONFIG_TI_TMAG5273=y
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=y
CONFIG_DPS310=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
CONFIG_TMP117=y
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_MAX30208=y
CONFIG_MAX31856=y
CONFIG_MAX31865=y
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_ATMEL_TCB=y
CONFIG_PWM_CLK=y
# CONFIG_PWM_CRC is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_NTXEC=y
CONFIG_PWM_PCA9685=y
CONFIG_PWM_STMPE=y
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
# CONFIG_BTT is not set
# CONFIG_OF_PMEM is not set
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=y
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

CONFIG_NVMEM_RAVE_SP_EEPROM=y
CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_ASPEED=y
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_INTEL_QEP=y
CONFIG_INTERRUPT_CNT=y
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
CONFIG_MOST_SND=y
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_64BIT_CLUSTER=y
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SM3_AVX_X86_64=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
# CONFIG_KASAN_STACK is not set
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
CONFIG_HAVE_KMSAN_COMPILER=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_NMI_CHECK_CPU=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_DA_MON_EVENTS=y
CONFIG_DA_MON_EVENTS_ID=y
CONFIG_RV=y
CONFIG_RV_MON_WWNR=y
CONFIG_RV_REACTORS=y
CONFIG_RV_REACT_PRINTK=y
CONFIG_RV_REACT_PANIC=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_FTRACE_DIRECT is not set
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
CONFIG_SAMPLE_FTRACE_OPS=y
# CONFIG_SAMPLE_TRACE_ARRAY is not set
CONFIG_SAMPLE_KOBJECT=y
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_FPROBE is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_HIDRAW is not set
CONFIG_SAMPLE_LANDLOCK=y
CONFIG_SAMPLE_PIDFD=y
# CONFIG_SAMPLE_TIMER is not set
CONFIG_SAMPLE_UHID=y
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_ANDROID_BINDERFS is not set
# CONFIG_SAMPLE_VFS is not set
CONFIG_SAMPLE_INTEL_MEI=y
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
# CONFIG_SAMPLE_KMEMLEAK is not set
CONFIG_SAMPLES_RUST=y
CONFIG_SAMPLE_RUST_MINIMAL=y
CONFIG_SAMPLE_RUST_PRINT=y
CONFIG_SAMPLE_RUST_HOSTPROGS=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
CONFIG_RUST_DEBUG_ASSERTIONS=y
CONFIG_RUST_OVERFLOW_CHECKS=y
# CONFIG_RUST_BUILD_ASSERT_ALLOW is not set
# end of Rust hacking
# end of Kernel hacking

--xLgmAFTaR/jzHG3Q
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=600
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-review/Sidhartha-Kumar/mm-hugetlb-revert-use-of-page_cache_next_miss/20230506-025434'
	export commit='1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1'
	export kconfig='x86_64-randconfig-x075-20230515'
	export nr_vm=300
	export submit_id='64675cbbb30c03bfc0fca99f'
	export job_file='/lkp/jobs/scheduled/vm-meta-1/trinity-600s-debian-11.1-x86_64-20220510.cgz-1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1-20230519-49088-1km78kz-5.yaml'
	export id='e5c86e3269139f7221e2cb7c8377f19df0ae006f'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='clang-14'
	export enqueue_time='2023-05-19 19:25:48 +0800'
	export _id='64675cbcb30c03bfc0fca9a1'
	export _rt='/result/trinity/600s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-x075-20230515/clang-14/1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/600s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-x075-20230515/clang-14/1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/600s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-x075-20230515/clang-14/1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-x075-20230515/clang-14/1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1/vmlinuz-6.3.0-13165-g1f944358dbb5
branch=linux-review/Sidhartha-Kumar/mm-hugetlb-revert-use-of-page_cache_next_miss/20230506-025434
job=/lkp/jobs/scheduled/vm-meta-1/trinity-600s-debian-11.1-x86_64-20220510.cgz-1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1-20230519-49088-1km78kz-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-x075-20230515
commit=1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1
initcall_debug
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-x075-20230515/clang-14/1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/trinity-x86_64-abe9de86-1_20230501.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=6
	export stop_repeat_if_found='dmesg.BUG:KASAN:null-ptr-deref_in_hugetlbfs_fallocate'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-1'
	export kernel='/pkg/linux/x86_64-randconfig-x075-20230515/clang-14/1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1/vmlinuz-6.3.0-13165-g1f944358dbb5'
	export dequeue_time='2023-05-19 19:26:15 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-1/trinity-600s-debian-11.1-x86_64-20220510.cgz-1f944358dbb5e9a6493fd7b1f77ee64376d2bdf1-20230519-49088-1km78kz-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--xLgmAFTaR/jzHG3Q
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
BwAB7ewDovQcSagzKLHEZ/sCAAAAAARZWg==

--xLgmAFTaR/jzHG3Q--
