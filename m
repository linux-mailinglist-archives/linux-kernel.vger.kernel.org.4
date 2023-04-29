Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C56F24F8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjD2OH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjD2OHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:07:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB951BF9;
        Sat, 29 Apr 2023 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682777263; x=1714313263;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=KOL2kT9rG7kLCApexysdAguxZ8FfaTg5wWeTi1xVU84=;
  b=h8exrfVNqYsNn5G3Rddczt6VMKXyBlj8aI9S1KjdR7SAUq40GxpTbvsu
   oTvtvYaNBLSGjpOLlyNd7CgU1YOXkTP4M25V502DKRwujP6b/Lm0ASkhe
   2Of2D2eF0+j0oZYhUPmfzDwwgJbsd0m632dbwV6tnoZe84RHiD3y9w0gt
   3epTbqFi+rrVTZWmaU3eN/LJrHEHS7v78YU4BvLniEvid77yBA4bmXt80
   pnbO57fGVY7e1ZgGLnl9S67GEZBNVqTtFBE4JDz/JXTBOiOHaamP1/q2N
   esb8oQg58CiGUmyPh0HZ90ric+Cq0DaBo5F118UJCUBpL8XSuIEtR5pAr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="328281437"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="328281437"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 07:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="784661048"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="784661048"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2023 07:07:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 29 Apr 2023 07:07:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 29 Apr 2023 07:07:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 29 Apr 2023 07:07:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 29 Apr 2023 07:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJpjkQ6oJLBicBUFQo/9Sw4xiFnbjszJkWn/8drlP4umHJAufpuOTaX95gHlnIUnend8RwTpJylbnOC6u6kD4iZkQJtbebQuOMRxTfJwynijADN6w3s5xQePZOXzR+3yaGk7hjgzEIKzHc6C3ZYPwfwgZfypDnbAIwi/PLwRuCsmFSYPVAwFk19+MyV1lXNzunsOmRmLTtMZnLh09ztw6Ju9tkyEMWlL0vWk0W0YCLC22V8u+eKmzQ8byi+ck5JDv6Cc41QXs8kSUFm7Msf5CqqEmaWpZYR10oqJk0ndIZ16GapL5ddOWVTJ2sKuADcYIo92hEk3ApcER2JN/RXBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi57O5VTgixz6uc0t7PLBzy4lnct/y7eLmt7+WFGFS8=;
 b=OsoE+jh4BenGCbYVHESYlEJ/FKMoiQg0weYyzgoQAnLx5us/Cg8Xwyi9qVaY9+aZaFs2/LeYZon7CMDiffbplPUtxT0fjbkFforbKY6kF5twsmw/slZwV6iAkiS0OngsVkLWYpoizPuAJXnR3LZuevw0vN6q99/x0FzPAUSKfgJ5LayiU4M/XHHgEMWdgjXvaFfDDZzV3jWdygJDyE0duZe6qCaLbO6rhCVouhCcqSWTNlRLRnUnMhOUewg7CJySf+1I8lvvUcvXZJ4eeHzCVeTy+SgWzBvTQjhGp+WrnFIePHMw+1Gkv9GvdjYSladk8qKcIrXTnuzI1S6KcpnzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Sat, 29 Apr
 2023 14:07:30 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6340.026; Sat, 29 Apr 2023
 14:07:30 +0000
Date:   Sat, 29 Apr 2023 22:07:15 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <markhemm@googlemail.com>,
        <viro@zeniv.linux.org.uk>, <david@redhat.com>,
        <mike.kravetz@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>,
        <andreyknvl@gmail.com>, <dave.hansen@intel.com>, <luto@kernel.org>,
        <brauner@kernel.org>, <arnd@arndb.de>, <ebiederm@xmission.com>,
        <catalin.marinas@arm.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <vasily.averin@linux.dev>,
        <xhao@linux.alibaba.com>, <pcc@google.com>, <neilb@suse.de>,
        <maz@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH RFC v2 4/4] mm/ptshare: Add page fault handling for page
 table shared regions
Message-ID: <202304292108.f44daa45-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="GIq/wZkHImOzr4Om"
Content-Disposition: inline
In-Reply-To: <9edffd2a12a049a42d9a2c216e3f999aae7e65a4.1682453344.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d1302e-9baa-4ca6-18c2-08db48bb11a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hvpuuw3YJQ84mbfgpTfTGVUc1MgNAAf7mCnyKud0quUR4CMLWDsGBXLKdsqJTqtEu2nBgQDudCr7hpOjVOsqpLkfoaWDEGPhBhtxxquMM98UHoxprh4V2BxLiT6uPYuCc9+2FLphJgLMbIATz3YQjzG6hoVn1b9IIhGbTfrX44ruL8CWgMEofYG0BHyn4ZId9aG4ebxbG1Tyfr2sNq9oiEgZaF+4kj4UE4+t9PndQlAZlXlLwoJOLnwXtIGXaT55Od3d++Gqx7+raczq1ihItd6Iq7AREK0I0v28YUc/keU3bTdnOk9HTqYo8E2S3MWEwSXtotT+25eFzzCpDYi4F99sMk+WkCjPuMnnULeoDISgwyFTp7Ks3zWRMXAND0KVOodytcKz5ixzBXgVqxmw4vyrnKVLp3KDmYfKQNxxwnLn8W+nT6JTgJbJzyYvuszrpACy9ikwK/ZV/B0W1I5pwVNQNzbsHyizmNq0wpfRfuSmxr6JHFUkgavBngBqT71P9aRv63M8WVVIAnudng2NpQJTAy9JJDttQMg8w0JYF+cIwqaxJRPIpeYWq7qniVqocYqabQKduT5VSdv0QakyrUPDQisVBHPPQrqMqBcq0SjiDlPPIqQAX2mIiuVTo0YTVdpWqQvvjt6s7Db7dItF2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(38100700002)(21490400003)(82960400001)(6512007)(6506007)(1076003)(186003)(26005)(36756003)(86362001)(44144004)(33964004)(6486002)(6666004)(966005)(107886003)(2616005)(83380400001)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(5660300002)(478600001)(2906002)(30864003)(45080400002)(54906003)(235185007)(8676002)(8936002)(7416002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYWWkB3Oxjq5+GhPSDbLhbtV64JqcVR/+3oLf2Hm1v14JyXg0Lc4yWSXP/H7?=
 =?us-ascii?Q?6WkhJrZqOjkGR9wIr1knSHmG6M5icTQYTWlndEstcoNo/3kYyzj0O62NkOds?=
 =?us-ascii?Q?GzpEJI24v8X8CuB5BBY4tMReBJMzcUUqn/kTvxnrTwYaAek34u8Y/O7mLO8c?=
 =?us-ascii?Q?Z0lS5vItWdjvBH/i5G1KoNFo72sibdccDQJRwkGJffDp+QlCPnEkHvlf5Ffj?=
 =?us-ascii?Q?iC7QSjozNeEuM9ayDM7ehDdxafau8yKVEu99Gjglz+KPc/1or7/MR5Pap44B?=
 =?us-ascii?Q?6H1BMGGouDER4RzaqjSiIGeetDGW2D5ODhukuxkwdSNGbEGL1dtbtUA2Tafa?=
 =?us-ascii?Q?OrTt29ZesvbGuEtgnTpjpDMVqccTZODdG2Oxn3vs2eFXreovF2hhGaHgS10e?=
 =?us-ascii?Q?pDT4GiDNddjgLi7O4DBunkW3JFKr/1aDEbKRALtoVR1VMTkgBfWVpqq0l11w?=
 =?us-ascii?Q?7BpaDJWixmgn7Bw3Rgw13N7cMXnQKfNUwNjzV7RXFdiFySchvgWXLBXtlaRQ?=
 =?us-ascii?Q?aL3AbnIgpvZjrGS+2dSNq6zCK1XDO74LtbGJjZ5UKE1Gfay3fL67i52j+FDQ?=
 =?us-ascii?Q?ba6h8WDNcM3nZAn+dj6Yp0bi9c2Uekv1nqf3DXd0G9ThKyS+mfLkHUbixgi7?=
 =?us-ascii?Q?8cSepGdDQL/ygbWjtIoVE4/3+CtdO8UwCswYvLikCSyFPATbeqDbYtP2dI/P?=
 =?us-ascii?Q?pg59NhsxuyCTRlGHFXqRBJZLbefgaFpogoKJ3yXM12aKq36QcJREh/Cxer3V?=
 =?us-ascii?Q?ZZJBIB7XIASEJu1AWvwo7/YrOgJJV34v/cLK9TE8T2XNBc0SRdXlubGtZDHV?=
 =?us-ascii?Q?0iI0qktEgW0OhwWWEv4p23KYjz8LzykTCH8acxuADtZuvgjnMaAHnV+2LYcl?=
 =?us-ascii?Q?M3s8mETZXvEUic053taBQBbn7YERbQt94MBBKq4u0iIEhHO9Wroer7m4ZxAY?=
 =?us-ascii?Q?2ER0DdRUfP0JFDfOF4y52xCiwJ4clyhfpkSBTYOAWfLNLUHGaCqZ9Ag+Kyo6?=
 =?us-ascii?Q?kCp3A/gqG4zZU4g8X3puwfBljfiyBpzFPyUv3oU4G8y2DfRDY5wcfTRRJwtL?=
 =?us-ascii?Q?MhZZkrJUpv6DM/HaVuhYzBjkvFxDssR7IW60RBLcssDG2dQ2CdE2i8JdUvxI?=
 =?us-ascii?Q?Dq130vdlJ8sMI2OKKvWoPZpTk5fHx346QNuWc74Y3WpczLMOhEzvLdPc9G3u?=
 =?us-ascii?Q?JdpNhZdt5FlW7ZHBY3hdecpc9oblEmk7RzCu5gczgvr+L3rJ4/1GcN9ONNOP?=
 =?us-ascii?Q?XFcgzYTVuYJRfvWnzCR5lqPyXV1VnAo35po7lyd9lFupM6tiPaLOqRaM1vtY?=
 =?us-ascii?Q?I8IlGvODGQQn5VUbx77p8AKdysyhDWDnBUXt/JQKJPd5DD1Dj+pqDoKIIjwi?=
 =?us-ascii?Q?LUg4A/hYQwt1ONFI6vRB9FmIiYQuop6QWwBPj3ZvYeOac1zjPx0TyGmoFytt?=
 =?us-ascii?Q?i3a6G1WVUAjQB19GlZfRBbFOiD5QGv267xg32gbiVWPGJkeU7T38ihwM31Xw?=
 =?us-ascii?Q?+U0jWwkABQjxigsaz9hObuO0ozpA6JUMnMABlv9CuXSsfG9iSS0lPLqCDglL?=
 =?us-ascii?Q?QhTc6CtNyzgHitKo3qa92qEEsUeJS2mW53u/dcw0/eBfwYBEG/ZioY4Fp5Fz?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d1302e-9baa-4ca6-18c2-08db48bb11a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2023 14:07:30.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krqtc1KBKt86tPbP+Z7XWGD1uEEJB6k6IaZcithCfzGmNCnsE+KeX6MI8JgSoMEgCTGO6hJegcB9qG1QBgkf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--GIq/wZkHImOzr4Om
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:bad_unlock_balance_detected" on:

commit: a2eef9e49f572b7b2dfa23fc32567e83da9573d5 ("[PATCH RFC v2 4/4] mm/ptshare: Add page fault handling for page table shared regions")
url: https://github.com/intel-lab-lkp/linux/commits/Khalid-Aziz/mm-ptshare-Add-vm-flag-for-shared-PTE/20230427-005143
base: https://git.kernel.org/cgit/linux/kernel/git/arnd/asm-generic.git master
patch link: https://lore.kernel.org/all/9edffd2a12a049a42d9a2c216e3f999aae7e65a4.1682453344.git.khalid.aziz@oracle.com/
patch subject: [PATCH RFC v2 4/4] mm/ptshare: Add page fault handling for page table shared regions

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	sc_nr_hugepages: 2
	group: mm

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


compiler: gcc-11
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202304292108.f44daa45-oliver.sang@intel.com


[  183.878671][ T3695] WARNING: bad unlock balance detected!
[  183.884040][ T3695] 6.3.0-rc1-00015-ga2eef9e49f57 #1 Not tainted
[  183.890014][ T3695] -------------------------------------
[  183.895382][ T3695] userfaultfd/3695 is trying to release lock (&mm->mmap_lock) at:
[ 183.903000][ T3695] handle_mm_fault (mm/memory.c:5276) 
[  183.909324][ T3695] but there are no more locks to release!
[  183.914866][ T3695]
[  183.914866][ T3695] other info that might help us debug this:
[  183.922738][ T3695] no locks held by userfaultfd/3695.
[  183.927847][ T3695]
[  183.927847][ T3695] stack backtrace:
[  183.933560][ T3695] CPU: 7 PID: 3695 Comm: userfaultfd Not tainted 6.3.0-rc1-00015-ga2eef9e49f57 #1
[  183.942558][ T3695] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  183.950604][ T3695] Call Trace:
[  183.953730][ T3695]  <TASK>
[ 183.956510][ T3695] dump_stack_lvl (lib/dump_stack.c:108) 
[ 183.960845][ T3695] __lock_release (kernel/locking/lockdep.c:5346) 
[ 183.965354][ T3695] ? lock_downgrade (kernel/locking/lockdep.c:5321) 
[ 183.970032][ T3695] ? dump_stack_print_info (lib/dump_stack.c:70) 
[ 183.975231][ T3695] ? handle_mm_fault (mm/memory.c:5276) 
[ 183.979998][ T3695] lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5691) 
[ 183.984248][ T3695] up_read (kernel/locking/rwsem.c:1616) 
[ 183.987978][ T3695] handle_mm_fault (mm/memory.c:5276) 
[ 183.992571][ T3695] ? lock_is_held_type (kernel/locking/lockdep.c:5410 kernel/locking/lockdep.c:5712) 
[ 183.997424][ T3695] ? __handle_mm_fault (mm/memory.c:5201) 
[ 184.002364][ T3695] ? find_vma (mm/mmap.c:1854) 
[ 184.006459][ T3695] ? can_vma_merge_before+0x330/0x330 
[ 184.012283][ T3695] do_user_addr_fault (arch/x86/mm/fault.c:1407) 
[ 184.017146][ T3695] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1506 arch/x86/mm/fault.c:1554) 
[ 184.021496][ T3695] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[  184.026186][ T3695] RIP: 0033:0x403b2e
[ 184.029923][ T3695] Code: 89 75 e0 48 89 55 d8 48 c7 45 f8 00 00 00 00 eb 2c 48 8b 55 e8 48 8b 45 f8 48 01 d0 0f b6 10 48 8b 4d e0 48 8b 45 f8 48 01 c8 <0f> b6 00 38 c2 74 07 b8 01 00 00 00 eb 14 48 83 45 f8 01 48 8b 45
All code
========
   0:	89 75 e0             	mov    %esi,-0x20(%rbp)
   3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   e:	00 
   f:	eb 2c                	jmp    0x3d
  11:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  19:	48 01 d0             	add    %rdx,%rax
  1c:	0f b6 10             	movzbl (%rax),%edx
  1f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  27:	48 01 c8             	add    %rcx,%rax
  2a:*	0f b6 00             	movzbl (%rax),%eax		<-- trapping instruction
  2d:	38 c2                	cmp    %al,%dl
  2f:	74 07                	je     0x38
  31:	b8 01 00 00 00       	mov    $0x1,%eax
  36:	eb 14                	jmp    0x4c
  38:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	0f b6 00             	movzbl (%rax),%eax
   3:	38 c2                	cmp    %al,%dl
   5:	74 07                	je     0xe
   7:	b8 01 00 00 00       	mov    $0x1,%eax
   c:	eb 14                	jmp    0x22
   e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[  184.049280][ T3695] RSP: 002b:00007ffe05336170 EFLAGS: 00010206
[  184.055169][ T3695] RAX: 00007f57bde00000 RBX: 00007ffe05336340 RCX: 00007f57bde00000
[  184.062955][ T3695] RDX: 00000000000000ff RSI: 00007f57bde00000 RDI: 00007f57ce000000
[  184.070742][ T3695] RBP: 00007ffe05336170 R08: 00000000ffffffff R09: 0000000000000000
[  184.078528][ T3695] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
[  184.086315][ T3695] R13: 00007ffe05336560 R14: 000000000040be00 R15: 00007f57e6668020
[  184.094107][ T3695]  </TASK>
[  184.096984][ T3695] ------------[ cut here ]------------
[  184.102287][ T3695] DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff888160af9d28, owner = 0x1, curr 0xffff8881b2dc8040, list empty
[ 184.116154][ T3695] WARNING: CPU: 7 PID: 3695 at kernel/locking/rwsem.c:1348 __up_read (kernel/locking/rwsem.c:1348 (discriminator 15)) 
[  184.125073][ T3695] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common btrfs x86_pkg_temp_thermal intel_powerclamp blake2b_generic coretemp xor raid6_pq zstd_compress kvm_intel libcrc32c kvm i915 sd_mod t10_pi irqbypass crct10dif_pclmul crc64_rocksoft_generic crc32_pclmul drm_buddy crc64_rocksoft crc32c_intel intel_gtt crc64 ghash_clmulni_intel drm_display_helper sha512_ssse3 sg rapl drm_kms_helper ipmi_devintf ipmi_msghandler mei_wdt wmi_bmof intel_cstate syscopyarea ahci libahci i2c_i801 i2c_designware_platform sysfillrect mei_me intel_uncore i2c_smbus idma64 i2c_designware_core sysimgblt libata ttm mei video wmi intel_pmc_core acpi_pad binfmt_misc fuse drm ip_tables
[  184.190695][ T3695] CPU: 7 PID: 3695 Comm: userfaultfd Not tainted 6.3.0-rc1-00015-ga2eef9e49f57 #1
[  184.199697][ T3695] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[ 184.207763][ T3695] RIP: 0010:__up_read (kernel/locking/rwsem.c:1348 (discriminator 15)) 
[ 184.212637][ T3695] Code: 3c 02 00 0f 85 61 03 00 00 53 48 8b 55 00 4d 89 e9 4d 89 f8 4c 89 f1 48 c7 c6 40 70 c9 83 48 c7 c7 a0 6e c9 83 e8 11 15 e9 ff <0f> 0b 5a e9 0e ff ff ff 48 89 44 24 38 e9 db fd ff ff be 08 00 00
All code
========
   0:	3c 02                	cmp    $0x2,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 61 03             	test   %esp,0x3(%rcx)
   7:	00 00                	add    %al,(%rax)
   9:	53                   	push   %rbx
   a:	48 8b 55 00          	mov    0x0(%rbp),%rdx
   e:	4d 89 e9             	mov    %r13,%r9
  11:	4d 89 f8             	mov    %r15,%r8
  14:	4c 89 f1             	mov    %r14,%rcx
  17:	48 c7 c6 40 70 c9 83 	mov    $0xffffffff83c97040,%rsi
  1e:	48 c7 c7 a0 6e c9 83 	mov    $0xffffffff83c96ea0,%rdi
  25:	e8 11 15 e9 ff       	callq  0xffffffffffe9153b
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	5a                   	pop    %rdx
  2d:	e9 0e ff ff ff       	jmpq   0xffffffffffffff40
  32:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  37:	e9 db fd ff ff       	jmpq   0xfffffffffffffe17
  3c:	be                   	.byte 0xbe
  3d:	08 00                	or     %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	5a                   	pop    %rdx
   3:	e9 0e ff ff ff       	jmpq   0xffffffffffffff16
   8:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
   d:	e9 db fd ff ff       	jmpq   0xfffffffffffffded
  12:	be                   	.byte 0xbe
  13:	08 00                	or     %al,(%rax)
	...
[  184.232027][ T3695] RSP: 0000:ffffc9000b6ffd48 EFLAGS: 00010286
[  184.237919][ T3695] RAX: 0000000000000000 RBX: ffffffff83c96de0 RCX: fffff520016dff6e
[  184.245734][ T3695] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffff88878c7ac38c
[  184.253611][ T3695] RBP: ffff888160af9d28 R08: ffffffff821fca01 R09: ffffc9000b6ffb6f
[  184.261422][ T3695] R10: fffff520016dff6d R11: 0000000000000001 R12: 1ffff920016dffad
[  184.269254][ T3695] R13: ffff8881b2dc8040 R14: ffff888160af9d28 R15: 0000000000000001
[  184.277051][ T3695] FS:  00007f57e6448740(0000) GS:ffff88878c780000(0000) knlGS:0000000000000000
[  184.285796][ T3695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  184.292208][ T3695] CR2: 00007f57bde00000 CR3: 0000000100e30004 CR4: 00000000003706e0
[  184.300016][ T3695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  184.307809][ T3695] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  184.315616][ T3695] Call Trace:
[  184.318762][ T3695]  <TASK>
[ 184.321563][ T3695] ? up_write (kernel/locking/rwsem.c:1339) 
[ 184.325575][ T3695] ? lock_release (kernel/locking/lockdep.c:5693) 
[ 184.330105][ T3695] handle_mm_fault (mm/memory.c:5276) 
[ 184.334721][ T3695] ? lock_is_held_type (kernel/locking/lockdep.c:5410 kernel/locking/lockdep.c:5712) 
[ 184.339595][ T3695] ? __handle_mm_fault (mm/memory.c:5201) 
[ 184.344556][ T3695] ? find_vma (mm/mmap.c:1854) 
[ 184.348651][ T3695] ? can_vma_merge_before+0x330/0x330 
[ 184.354479][ T3695] do_user_addr_fault (arch/x86/mm/fault.c:1407) 
[ 184.359351][ T3695] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1506 arch/x86/mm/fault.c:1554) 
[ 184.363707][ T3695] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[  184.368408][ T3695] RIP: 0033:0x403b2e
[ 184.372145][ T3695] Code: 89 75 e0 48 89 55 d8 48 c7 45 f8 00 00 00 00 eb 2c 48 8b 55 e8 48 8b 45 f8 48 01 d0 0f b6 10 48 8b 4d e0 48 8b 45 f8 48 01 c8 <0f> b6 00 38 c2 74 07 b8 01 00 00 00 eb 14 48 83 45 f8 01 48 8b 45
All code
========
   0:	89 75 e0             	mov    %esi,-0x20(%rbp)
   3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   e:	00 
   f:	eb 2c                	jmp    0x3d
  11:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  19:	48 01 d0             	add    %rdx,%rax
  1c:	0f b6 10             	movzbl (%rax),%edx
  1f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  27:	48 01 c8             	add    %rcx,%rax
  2a:*	0f b6 00             	movzbl (%rax),%eax		<-- trapping instruction
  2d:	38 c2                	cmp    %al,%dl
  2f:	74 07                	je     0x38
  31:	b8 01 00 00 00       	mov    $0x1,%eax
  36:	eb 14                	jmp    0x4c
  38:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	0f b6 00             	movzbl (%rax),%eax
   3:	38 c2                	cmp    %al,%dl
   5:	74 07                	je     0xe
   7:	b8 01 00 00 00       	mov    $0x1,%eax
   c:	eb 14                	jmp    0x22
   e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[  184.391546][ T3695] RSP: 002b:00007ffe05336170 EFLAGS: 00010206
[  184.397460][ T3695] RAX: 00007f57bde00000 RBX: 00007ffe05336340 RCX: 00007f57bde00000
[  184.405251][ T3695] RDX: 00000000000000ff RSI: 00007f57bde00000 RDI: 00007f57ce000000
[  184.413057][ T3695] RBP: 00007ffe05336170 R08: 00000000ffffffff R09: 0000000000000000
[  184.420863][ T3695] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
[  184.428670][ T3695] R13: 00007ffe05336560 R14: 000000000040be00 R15: 00007f57e6668020
[  184.436482][ T3695]  </TASK>
[  184.439365][ T3695] irq event stamp: 368859
[ 184.443530][ T3695] hardirqs last enabled at (368859): finish_task_switch+0x21c/0x910 
[ 184.453841][ T3695] hardirqs last disabled at (368858): __schedule (kernel/sched/core.c:6521 (discriminator 1)) 
[ 184.462946][ T3695] softirqs last enabled at (368830): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
[ 184.472118][ T3695] softirqs last disabled at (368825): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650) 
[  184.481495][ T3695] ---[ end trace 0000000000000000 ]---
[  184.486819][ T3695] VM_SHARED_PT vma with NULL ptshare_data
[  184.486823][ T3695] CPU: 3 PID: 3695 Comm: userfaultfd Tainted: G        W          6.3.0-rc1-00015-ga2eef9e49f57 #1
[  184.502865][ T3695] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--GIq/wZkHImOzr4Om
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc1-00015-ga2eef9e49f57"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
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
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
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
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
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
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
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
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
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
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_HOTPLUG_SMT=y
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
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
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
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
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
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
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

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

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
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
CONFIG_CAVIUM_PTP=y
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
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
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
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_PCI1XXXX=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

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
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
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

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_EFI_SECRET is not set
CONFIG_TDX_GUEST_DRIVER=m
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD=m
CONFIG_IOMMUFD_TEST=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
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
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
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
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
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
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
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

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
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
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
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
# CONFIG_LOCK_STAT is not set
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
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
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
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_FTRACE_OPS is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

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
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
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
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--GIq/wZkHImOzr4Om
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export job_origin='kernel-selftests-mm.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-kbl-d01'
	export tbox_group='lkp-kbl-d01'
	export submit_id='644cac97a89e786f61aa12ae'
	export job_file='/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-mm-2-debian-12-x86_64-20220629.cgz-a2eef9e49f572b7b2dfa23fc32567e83da9573d5-20230429-28513-1ykqh3r-4.yaml'
	export id='682ffbaf2ce200da6071b95d4aed99e7b160dead'
	export queuer_version='/zday/lkp'
	export model='Kaby Lake'
	export nr_node=1
	export nr_cpu=8
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*'
	export ssd_partitions='/dev/disk/by-id/ata-CT1000BX500SSD1_2203E5FF08F0-part1'
	export rootfs_partition='/dev/disk/by-id/ata-CT1000BX500SSD1_2203E5FF08F0-part2'
	export brand='Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz'
	export commit='a2eef9e49f572b7b2dfa23fc32567e83da9573d5'
	export ucode='0xf0'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI'
	export need_kernel_version='>= v6.3-rc1, gcc
>= v6.3-rc1, clang'
	export need_kconfig=\{\"MEM_SOFT_DIRTY\"\=\>\"y,\ x86_64\"\}'
'\{\"GUP_BENCHMARK\"\=\>\"y\"\}'
'\{\"GUP_TEST\"\=\>\"y\"\}
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-04-29 13:35:20 +0800'
	export _id='644cacafa89e786f61aa12af'
	export _rt='/result/kernel-selftests/mm-2/lkp-kbl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='c18fbf63a1f0325db317c3f6b7b8973baac57bfe'
	export base_commit='457391b0380335d5e9a5babdec90ac53928b23b4'
	export branch='linux-review/Khalid-Aziz/mm-ptshare-Add-vm-flag-for-shared-PTE/20230427-005143'
	export result_root='/result/kernel-selftests/mm-2/lkp-kbl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/mm-2/lkp-kbl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/vmlinuz-6.3.0-rc1-00015-ga2eef9e49f57
branch=linux-review/Khalid-Aziz/mm-ptshare-Add-vm-flag-for-shared-PTE/20230427-005143
job=/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-mm-2-debian-12-x86_64-20220629.cgz-a2eef9e49f572b7b2dfa23fc32567e83da9573d5-20230429-28513-1ykqh3r-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=a2eef9e49f572b7b2dfa23fc32567e83da9573d5
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.3.0-12095-gc18fbf63a1f0'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.WARNING:bad_unlock_balance_detected'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/vmlinuz-6.3.0-rc1-00015-ga2eef9e49f57'
	export dequeue_time='2023-04-29 13:52:34 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-mm-2-debian-12-x86_64-20220629.cgz-a2eef9e49f572b7b2dfa23fc32567e83da9573d5-20230429-28513-1ykqh3r-4.cgz'

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

	run_setup sc_nr_hugepages=2 $LKP_SRC/setup/sysctl

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='mm' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='mm' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--GIq/wZkHImOzr4Om
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
rgCxxGf7AgAAAAAEWVo=

--GIq/wZkHImOzr4Om
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="kernel-selftests"
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5
2023-04-29 05:55:13 ln -sf /usr/bin/clang
2023-04-29 05:55:13 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-04-29 05:55:13 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-04-29 05:55:13 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2023-04-29 05:55:14 make -j8 -C mm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm'
/bin/sh ./check_config.sh gcc
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mad=
v_populate.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/sel=
ftests/mm/madv_populate
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     sof=
t-dirty.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selfte=
sts/mm/soft-dirty
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     spl=
it_huge_page_test.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/test=
ing/selftests/mm/split_huge_page_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     ksm=
_functional_tests.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/test=
ing/selftests/mm/ksm_functional_tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mdw=
e_test.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/mdwe=
_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     cow=
.c vm_util.c -lrt -lpthread  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kse=
lftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm=
/cow
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     com=
paction_test.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-ks=
elftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/m=
m/compaction_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     gup=
_test.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/gup_t=
est
mdwe_test.c: In function =E2=80=98mdwe_mmap_FIXED=E2=80=99:
mdwe_test.c:166:19: warning: variable =E2=80=98p2=E2=80=99 set but not used=
 [-Wunused-but-set-variable]
  166 |         void *p, *p2;
      |                   ^~
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     hmm=
-tests.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/hmm-=
tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     hug=
etlb-madvise.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-ks=
elftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/m=
m/hugetlb-madvise
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     hug=
epage-mmap.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-ksel=
ftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/=
hugepage-mmap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     hug=
epage-mremap.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-ks=
elftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/m=
m/hugepage-mremap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     hug=
epage-shm.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/h=
ugepage-shm
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     hug=
epage-vmemmap.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/=
mm/hugepage-vmemmap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     khu=
gepaged.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selfte=
sts/mm/khugepaged
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     map=
_fixed_noreplace.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftes=
ts/mm/map_fixed_noreplace
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     map=
_hugetlb.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/ma=
p_hugetlb
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     map=
_populate.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/m=
ap_populate
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mem=
fd_secret.c -lrt -lpthread -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftest=
s/mm/memfd_secret
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mig=
ration.c -lrt -lpthread -lnuma -o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/=
mm/migration
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mlo=
ck-random-test.c -lrt -lpthread -lcap -o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/sel=
ftests/mm/mlock-random-test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mlo=
ck2-tests.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/m=
lock2-tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mre=
lease_test.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-ksel=
ftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/=
mrelease_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mre=
map_dontunmap.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/=
mm/mremap_dontunmap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     mre=
map_test.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/mr=
emap_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     on-=
fault-limit.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kse=
lftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm=
/on-fault-limit
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     thu=
ge-gen.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm/thug=
e-gen
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     tra=
nshuge-stress.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/=
mm/transhuge-stress
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     use=
rfaultfd.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selft=
ests/mm/userfaultfd
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     ksm=
_tests.c -lrt -lpthread -lnuma -o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
selftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/=
mm/ksm_tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie  -m32 -=
mxsave  protection_keys.c -lrt -lpthread -lrt -ldl -lm -o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/=
tools/testing/selftests/mm/protection_keys_32
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie  -m64 -=
mxsave  protection_keys.c -lrt -lpthread -lrt -ldl -o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tool=
s/testing/selftests/mm/protection_keys_64
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     va_=
128TBswitch.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kse=
lftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm=
/va_128TBswitch
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     vir=
tual_address_range.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selft=
ests/mm/virtual_address_range
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f5=
72b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/../../..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a2eef9e49f572b7b2dfa23fc32=
567e83da9573d5/tools/testing/selftests/../../../usr/include -no-pie     wri=
te_to_hugetlbfs.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kselftests-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftest=
s/mm/write_to_hugetlbfs

Warning: missing liburing support. Some COW tests will be skipped.

make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm'
2023-04-29 05:55:21 make quicktest=3D1 run_tests -C mm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-a2eef9e49f572b7b2dfa23fc32567e83da9573d5/tools/testing/selftests/mm'

Warning: missing liburing support. Some COW tests will be skipped.

TAP version 13
1..6
# selftests: mm: madv_populate
# TAP version 13
# 1..21
# # [RUN] test_prot_read
# ok 1 MADV_POPULATE_READ with PROT_READ
# ok 2 MADV_POPULATE_WRITE with PROT_READ
# # [RUN] test_prot_write
# ok 3 MADV_POPULATE_READ with PROT_WRITE
# ok 4 MADV_POPULATE_WRITE with PROT_WRITE
# # [RUN] test_holes
# ok 5 MADV_POPULATE_READ with holes in the middle
# ok 6 MADV_POPULATE_WRITE with holes in the middle
# ok 7 MADV_POPULATE_READ with holes at the end
# ok 8 MADV_POPULATE_WRITE with holes at the end
# ok 9 MADV_POPULATE_READ with holes at the beginning
# ok 10 MADV_POPULATE_WRITE with holes at the beginning
# # [RUN] test_populate_read
# ok 11 range initially not populated
# ok 12 MADV_POPULATE_READ
# ok 13 range is populated
# # [RUN] test_populate_write
# ok 14 range initially not populated
# ok 15 MADV_POPULATE_WRITE
# ok 16 range is populated
# # [RUN] test_softdirty
# ok 17 range is not softdirty
# ok 18 MADV_POPULATE_READ
# ok 19 range is not softdirty
# ok 20 MADV_POPULATE_WRITE
# ok 21 range is softdirty
# # Totals: pass:21 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: mm: madv_populate
# selftests: mm: soft-dirty
# TAP version 13
# 1..15
# ok 1 Test test_simple
# ok 2 Test test_vma_reuse dirty bit of allocated page
# ok 3 Test test_vma_reuse dirty bit of reused address page
# ok 4 Test test_hugepage huge page allocation
# ok 5 Test test_hugepage huge page dirty bit
# ok 6 Test test_mprotect-anon dirty bit of new written page
# ok 7 Test test_mprotect-anon soft-dirty clear after clear_refs
# ok 8 Test test_mprotect-anon soft-dirty clear after marking RO
# ok 9 Test test_mprotect-anon soft-dirty clear after marking RW
# ok 10 Test test_mprotect-anon soft-dirty after rewritten
# ok 11 Test test_mprotect-file dirty bit of new written page
# ok 12 Test test_mprotect-file soft-dirty clear after clear_refs
# ok 13 Test test_mprotect-file soft-dirty clear after marking RO
# ok 14 Test test_mprotect-file soft-dirty clear after marking RW
# ok 15 Test test_mprotect-file soft-dirty after rewritten
# # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: mm: soft-dirty
# selftests: mm: split_huge_page_test
# No THP is allocated
not ok 3 selftests: mm: split_huge_page_test # exit=3D1
# selftests: mm: ksm_functional_tests
# TAP version 13
# 1..3
# # [RUN] test_unmerge
# ok 1 Pages were unmerged
# # [RUN] test_unmerge_discarded
# ok 2 Pages were unmerged
# # [RUN] test_unmerge_uffd_wp
# ok 3 Pages were unmerged
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: mm: ksm_functional_tests
# selftests: mm: mdwe_test
# TAP version 13
# 1..22
# # Starting 22 tests from 4 test cases.
# #  RUN           global.prctl_flags ...
# #            OK  global.prctl_flags
# ok 1 global.prctl_flags
# #  RUN           mdwe.stock.mmap_READ_EXEC ...
# #            OK  mdwe.stock.mmap_READ_EXEC
# ok 2 mdwe.stock.mmap_READ_EXEC
# #  RUN           mdwe.stock.mmap_WRITE_EXEC ...
# #            OK  mdwe.stock.mmap_WRITE_EXEC
# ok 3 mdwe.stock.mmap_WRITE_EXEC
# #  RUN           mdwe.stock.mprotect_stay_EXEC ...
# #            OK  mdwe.stock.mprotect_stay_EXEC
# ok 4 mdwe.stock.mprotect_stay_EXEC
# #  RUN           mdwe.stock.mprotect_add_EXEC ...
# #            OK  mdwe.stock.mprotect_add_EXEC
# ok 5 mdwe.stock.mprotect_add_EXEC
# #  RUN           mdwe.stock.mprotect_WRITE_EXEC ...
# #            OK  mdwe.stock.mprotect_WRITE_EXEC
# ok 6 mdwe.stock.mprotect_WRITE_EXEC
# #  RUN           mdwe.stock.mmap_FIXED ...
# # mdwe_test.c:177:mmap_FIXED:Expected p (140692474019840) =3D=3D self->p =
(140692474015744)
# # mmap_FIXED: Test failed at step #2
# #          FAIL  mdwe.stock.mmap_FIXED
# not ok 7 mdwe.stock.mmap_FIXED
# #  RUN           mdwe.stock.arm64_BTI ...
# #      SKIP      HWCAP2_BTI not supported
# #            OK  mdwe.stock.arm64_BTI
# ok 8 # SKIP HWCAP2_BTI not supported
# #  RUN           mdwe.enabled.mmap_READ_EXEC ...
# #            OK  mdwe.enabled.mmap_READ_EXEC
# ok 9 mdwe.enabled.mmap_READ_EXEC
# #  RUN           mdwe.enabled.mmap_WRITE_EXEC ...
# #            OK  mdwe.enabled.mmap_WRITE_EXEC
# ok 10 mdwe.enabled.mmap_WRITE_EXEC
# #  RUN           mdwe.enabled.mprotect_stay_EXEC ...
# #            OK  mdwe.enabled.mprotect_stay_EXEC
# ok 11 mdwe.enabled.mprotect_stay_EXEC
# #  RUN           mdwe.enabled.mprotect_add_EXEC ...
# #            OK  mdwe.enabled.mprotect_add_EXEC
# ok 12 mdwe.enabled.mprotect_add_EXEC
# #  RUN           mdwe.enabled.mprotect_WRITE_EXEC ...
# #            OK  mdwe.enabled.mprotect_WRITE_EXEC
# ok 13 mdwe.enabled.mprotect_WRITE_EXEC
# #  RUN           mdwe.enabled.mmap_FIXED ...
# # mdwe_test.c:175:mmap_FIXED:Expected p (140692474019840) =3D=3D MAP_FAIL=
ED (18446744073709551615)
# # mmap_FIXED: Test failed at step #4
# #          FAIL  mdwe.enabled.mmap_FIXED
# not ok 14 mdwe.enabled.mmap_FIXED
# #  RUN           mdwe.enabled.arm64_BTI ...
# #      SKIP      HWCAP2_BTI not supported
# #            OK  mdwe.enabled.arm64_BTI
# ok 15 # SKIP HWCAP2_BTI not supported
# #  RUN           mdwe.forked.mmap_READ_EXEC ...
# #            OK  mdwe.forked.mmap_READ_EXEC
# ok 16 mdwe.forked.mmap_READ_EXEC
# #  RUN           mdwe.forked.mmap_WRITE_EXEC ...
# #            OK  mdwe.forked.mmap_WRITE_EXEC
# ok 17 mdwe.forked.mmap_WRITE_EXEC
# #  RUN           mdwe.forked.mprotect_stay_EXEC ...
# #            OK  mdwe.forked.mprotect_stay_EXEC
# ok 18 mdwe.forked.mprotect_stay_EXEC
# #  RUN           mdwe.forked.mprotect_add_EXEC ...
# #            OK  mdwe.forked.mprotect_add_EXEC
# ok 19 mdwe.forked.mprotect_add_EXEC
# #  RUN           mdwe.forked.mprotect_WRITE_EXEC ...
# #            OK  mdwe.forked.mprotect_WRITE_EXEC
# ok 20 mdwe.forked.mprotect_WRITE_EXEC
# #  RUN           mdwe.forked.mmap_FIXED ...
# # mdwe_test.c:175:mmap_FIXED:Expected p (140692474019840) =3D=3D MAP_FAIL=
ED (18446744073709551615)
# # mmap_FIXED: Test failed at step #5
# #          FAIL  mdwe.forked.mmap_FIXED
# not ok 21 mdwe.forked.mmap_FIXED
# #  RUN           mdwe.forked.arm64_BTI ...
# #      SKIP      HWCAP2_BTI not supported
# #            OK  mdwe.forked.arm64_BTI
# ok 22 # SKIP HWCAP2_BTI not supported
# # FAILED: 19 / 22 tests passed.
# # Totals: pass:16 fail:3 xfail:0 xpass:0 skip:3 error:0
not ok 5 selftests: mm: mdwe_test # exit=3D1
# selftests: mm: run_vmtests.sh
# Warning: file run_vmtests.sh is not executable
# -----------------------
# running ./hugepage-mmap
# -----------------------
# Returned address is 0x7f4203e00000
# First hex is 0
# First hex is 3020100
# [PASS]
# ----------------------
# running ./hugepage-shm
# ----------------------
# shmid: 0x0
# shmaddr: 0x7f43a1000000
# Starting the writes:
# .........................................................................=
...........................................................................=
...........................................................................=
.................................
# Starting the Check...Done.
# [PASS]
# ---------------------
# running ./map_hugetlb
# ---------------------
# Default size hugepages
# Mapping 256 Mbytes
# Returned address is 0x7f2880000000
# First hex is 0
# First hex is 3020100
# [PASS]
# -------------------------
# running ./hugepage-mremap
# -------------------------
# Map haddr: Returned address is 0x7eaa40000000
# Map daddr: Returned address is 0x7daa40000000
# Map vaddr: Returned address is 0x7faa40000000
# Address returned by mmap() =3D 0x7fb5d5ca6000
# Mremap: Returned address is 0x7faa40000000
# First hex is 0
# First hex is 3020100
# [PASS]
# --------------------------
# running ./hugepage-vmemmap
# --------------------------
# Returned address is 0x7fe635800000 whose pfn is 170200
# [PASS]
# -------------------------
# running ./hugetlb-madvise
# -------------------------
# [PASS]
# NOTE: These hugetlb tests provide minimal coverage.  Use
#       https://github.com/libhugetlbfs/libhugetlbfs.git for
#       hugetlb regression testing.
# -----------------------------
# running ./map_fixed_noreplace
# -----------------------------
# mmap() @ 0x7faadb2a6000-0x7faadb2ab000 p=3D0x7faadb2a6000 result=3DSucces=
s
# unmap() successful
# mmap() @ 0x7faadb2a7000-0x7faadb2aa000 p=3D0x7faadb2a7000 result=3DSucces=
s
# mmap() @ 0x7faadb2a6000-0x7faadb2ab000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7faadb2a8000-0x7faadb2a9000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7faadb2a9000-0x7faadb2ab000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7faadb2a6000-0x7faadb2a8000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7faadb2a6000-0x7faadb2a7000 p=3D0x7faadb2a6000 result=3DSucces=
s
# mmap() @ 0x7faadb2aa000-0x7faadb2ab000 p=3D0x7faadb2aa000 result=3DSucces=
s
# unmap() successful
# OK
# [PASS]
# ---------------------
# running ./gup_test -u
# ---------------------
# GUP_FAST_BENCHMARK: Time: get:18254 put:343 us
# [PASS]
# ---------------------
# running ./gup_test -a
# ---------------------
# PIN_FAST_BENCHMARK: Time: get:20032 put:80 us
# [PASS]
# -----------------------------------------
# running ./gup_test -ct -F 0x1 0 19 0x1000
# -----------------------------------------
# DUMP_USER_PAGES_TEST: done
# [PASS]
# --------------------------------
# running ./userfaultfd anon 20 16
# --------------------------------
# nr_pages: 5120, nr_pages_per_cpu: 640
# bounces: 15, mode: rnd racing ver poll, userfaults: 314 missing (62+59+42=
+35+36+30+44+6+=08) 1701 wp (222+249+227+242+206+186+207+162+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 135 missing (32+35+12+33+=
12+11+0+0+=08) 1649 wp (280+264+182+248+216+250+139+70+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 311 missing (48+56+57+44+54+=
31+4+17+=08) 1731 wp (278+255+170+130+339+248+100+211+=08)=20
# bounces: 12, mode: ver poll, userfaults: 131 missing (42+32+25+12+4+8+6+2=
+=08) 2096 wp (281+267+300+210+262+306+293+177+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 335 missing (80+63+52+51+=
29+43+5+12+=08) 2141 wp (281+275+296+292+335+278+196+188+=08)=20
# bounces: 10, mode: racing poll, userfaults: 59 missing (20+12+12+6+3+4+2+=
0+=08) 2048 wp (291+156+342+328+210+272+227+222+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 334 missing (58+72+60+19+65+38+15=
+7+=08) 1975 wp (313+332+255+165+358+222+202+128+=08)=20
# bounces: 8, mode: poll, userfaults: 142 missing (38+35+17+7+13+10+14+8+=
=08) 2239 wp (283+321+310+266+280+289+273+217+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 461 missing (111+76+75=
+81+21+34+19+44+=08) 2258 wp (439+335+267+313+222+238+276+168+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 174 missing (54+28+13+11+2=
4+22+10+12+=08) 1760 wp (241+219+296+214+264+194+151+181+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 505 missing (142+139+60+83+26=
+28+17+10+=08) 2612 wp (504+431+339+269+293+285+262+229+=08)=20
# bounces: 4, mode: ver read, userfaults: 120 missing (34+33+15+11+12+5+8+2=
+=08) 2779 wp (401+466+410+322+292+311+274+303+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 345 missing (95+53+44+79+2=
7+21+10+16+=08) 2161 wp (335+283+336+332+172+244+187+272+=08)=20
# bounces: 2, mode: racing read, userfaults: 264 missing (92+63+56+23+12+4+=
8+6+=08) 1936 wp (238+401+231+294+234+143+197+198+=08)=20
# bounces: 1, mode: rnd read, userfaults: 448 missing (113+73+53+100+44+53+=
8+4+=08) 2381 wp (439+344+332+405+286+255+219+101+=08)=20
# bounces: 0, mode: read, userfaults: 121 missing (28+24+12+25+3+20+6+3+=08=
) 3016 wp (519+469+355+425+270+348+324+306+=08)=20
# testing uffd-wp with pagemap (pgsize=3D4096): done
# testing uffd-wp with pagemap (pgsize=3D2097152): done
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5120 missing (5120+=08)=
 5120 wp (5120+=08)=20
# [PASS]
# ------------------------------------
# running ./userfaultfd hugetlb 128 32
# ------------------------------------
# nr_pages: 64, nr_pages_per_cpu: 8
# bounces: 31, mode: rnd racing ver poll, userfaults: 36 missing (14+9+6+5+=
2+0+0+0+=08) 116 wp (31+28+16+20+8+7+2+4+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 29 missing (7+5+7+2+4+1+1=
+2+=08) 148 wp (20+20+30+22+23+13+14+6+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 37 missing (14+9+7+4+3+0+0+0=
+=08) 118 wp (25+34+16+17+11+10+3+2+=08)=20
# bounces: 28, mode: ver poll, userfaults: 27 missing (11+7+5+3+1+0+0+0+=08=
) 208 wp (40+46+42+31+30+7+9+3+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 38 missing (15+8+9+4+2+0+=
0+0+=08) 115 wp (26+24+23+14+12+11+4+1+=08)=20
# bounces: 26, mode: racing poll, userfaults: 24 missing (14+1+2+3+1+1+1+1+=
=08) 101 wp (21+19+15+16+6+7+9+8+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 41 missing (13+11+8+6+3+0+0+0+=
=08) 120 wp (26+25+26+18+12+10+3+0+=08)=20
# bounces: 24, mode: poll, userfaults: 23 missing (10+8+3+2+0+0+0+0+=08) 18=
8 wp (36+39+36+29+21+14+9+4+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 42 missing (15+12+7+5=
+3+0+0+0+=08) 116 wp (30+24+20+16+8+11+5+2+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 21 missing (7+9+2+2+1+0+0=
+0+=08) 152 wp (31+25+22+18+22+6+18+10+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 39 missing (15+9+8+4+2+1+0+0=
+=08) 122 wp (30+25+20+18+15+8+3+3+=08)=20
# bounces: 20, mode: ver read, userfaults: 22 missing (10+6+3+2+1+0+0+0+=08=
) 197 wp (43+42+34+30+20+17+2+9+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 44 missing (16+13+9+6+0+0=
+0+0+=08) 130 wp (22+34+30+21+10+8+5+0+=08)=20
# bounces: 18, mode: racing read, userfaults: 17 missing (12+4+0+1+0+0+0+0+=
=08) 207 wp (42+25+31+20+24+26+26+13+=08)=20
# bounces: 17, mode: rnd read, userfaults: 41 missing (12+15+9+3+2+0+0+0+=
=08) 127 wp (36+21+32+19+5+9+2+3+=08)=20
# bounces: 16, mode: read, userfaults: 34 missing (25+7+0+2+0+0+0+0+=08) 19=
4 wp (60+34+27+29+20+15+5+4+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 36 missing (11+12+5+7=
+1+0+0+0+=08) 122 wp (27+30+24+19+9+9+3+1+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 13 missing (8+2+3+0+0+0+0=
+0+=08) 222 wp (52+32+43+34+30+16+9+6+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 41 missing (16+10+6+6+3+0+0+=
0+=08) 114 wp (33+25+20+19+11+4+2+0+=08)=20
# bounces: 12, mode: ver poll, userfaults: 19 missing (10+6+1+0+2+0+0+0+=08=
) 185 wp (46+40+31+16+21+13+7+11+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 39 missing (13+10+9+4+3+0=
+0+0+=08) 112 wp (36+20+17+21+10+5+2+1+=08)=20
# bounces: 10, mode: racing poll, userfaults: 41 missing (11+24+3+1+0+2+0+0=
+=08) 219 wp (57+54+38+24+22+15+7+2+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 37 missing (13+10+6+6+2+0+0+0+=08=
) 119 wp (34+28+18+16+10+5+0+8+=08)=20
# bounces: 8, mode: poll, userfaults: 15 missing (7+5+2+1+0+0+0+0+=08) 171 =
wp (37+33+23+26+18+12+11+11+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 37 missing (13+10+8+4+=
2+0+0+0+=08) 121 wp (29+27+21+19+12+9+4+0+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 13 missing (5+2+3+0+2+1+0+=
0+=08) 196 wp (43+50+38+25+16+15+8+1+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 40 missing (15+12+9+4+0+0+0+0=
+=08) 120 wp (30+30+21+18+11+6+1+3+=08)=20
# bounces: 4, mode: ver read, userfaults: 21 missing (8+7+3+2+1+0+0+0+=08) =
174 wp (39+42+28+22+17+11+5+10+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 39 missing (11+10+9+7+2+0+=
0+0+=08) 120 wp (28+22+26+21+13+5+3+2+=08)=20
# bounces: 2, mode: racing read, userfaults: 21 missing (5+3+9+2+1+1+0+0+=
=08) 193 wp (51+42+34+24+15+10+11+6+=08)=20
# bounces: 1, mode: rnd read, userfaults: 38 missing (15+9+8+5+1+0+0+0+=08)=
 120 wp (29+31+24+15+11+4+2+4+=08)=20
# bounces: 0, mode: read, userfaults: 47 missing (26+6+6+3+3+2+1+0+=08) 165=
 wp (46+30+25+16+22+15+10+1+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 64 missing (64+=08) 64 =
wp (64+=08)=20
# [PASS]
# -------------------------------------------
# running ./userfaultfd hugetlb_shared 128 32
# -------------------------------------------
# nr_pages: 64, nr_pages_per_cpu: 8
# bounces: 31, mode: rnd racing ver poll, userfaults: 34 missing (12+11+3+5=
+2+1+0+0+=08) 108 wp (20+22+24+17+12+8+4+1+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 24 missing (13+3+4+0+2+1+=
1+0+=08) 107 wp (18+14+19+15+12+11+8+10+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 31 missing (12+5+9+4+1+0+0+0=
+=08) 108 wp (23+22+20+11+16+8+6+2+=08)=20
# bounces: 28, mode: ver poll, userfaults: 27 missing (14+6+5+2+0+0+0+0+=08=
) 157 wp (24+31+30+23+16+7+17+9+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 34 missing (11+9+6+4+3+1+=
0+0+=08) 113 wp (25+20+26+20+9+6+5+2+=08)=20
# bounces: 26, mode: racing poll, userfaults: 22 missing (9+5+4+2+1+0+1+0+=
=08) 117 wp (20+17+14+20+16+14+7+9+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 32 missing (11+6+6+4+4+1+0+0+=08=
) 116 wp (25+23+16+11+16+12+10+3+=08)=20
# bounces: 24, mode: poll, userfaults: 23 missing (10+7+5+1+0+0+0+0+=08) 22=
1 wp (43+37+32+37+31+20+12+9+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 36 missing (11+9+7+7+=
1+1+0+0+=08) 113 wp (20+25+24+19+14+7+3+1+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 21 missing (10+5+4+2+0+0+=
0+0+=08) 145 wp (25+23+17+21+22+17+16+4+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 31 missing (9+10+6+5+1+0+0+0=
+=08) 103 wp (21+14+14+19+13+13+6+3+=08)=20
# bounces: 20, mode: ver read, userfaults: 19 missing (10+4+4+1+0+0+0+0+=08=
) 214 wp (34+46+28+28+19+23+19+17+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 32 missing (13+9+1+4+2+2+=
1+0+=08) 111 wp (23+19+26+13+13+8+7+2+=08)=20
# bounces: 18, mode: racing read, userfaults: 17 missing (8+2+2+3+2+0+0+0+=
=08) 153 wp (27+21+16+23+20+15+19+12+=08)=20
# bounces: 17, mode: rnd read, userfaults: 36 missing (12+9+9+3+2+1+0+0+=08=
) 117 wp (26+23+14+21+15+9+6+3+=08)=20
# bounces: 16, mode: read, userfaults: 15 missing (9+3+3+0+0+0+0+0+=08) 201=
 wp (36+34+35+24+25+22+18+7+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 34 missing (12+9+6+3+=
3+1+0+0+=08) 111 wp (24+25+18+13+10+13+8+0+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 13 missing (6+2+5+0+0+0+0=
+0+=08) 158 wp (31+25+28+20+26+13+9+6+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 39 missing (12+10+8+6+1+2+0+=
0+=08) 118 wp (24+25+19+18+14+14+3+1+=08)=20
# bounces: 12, mode: ver poll, userfaults: 11 missing (6+4+1+0+0+0+0+0+=08)=
 182 wp (34+33+34+27+16+16+17+5+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 36 missing (9+9+11+3+1+3+=
0+0+=08) 119 wp (24+26+13+21+16+9+4+6+=08)=20
# bounces: 10, mode: racing poll, userfaults: 9 missing (4+3+2+0+0+0+0+0+=
=08) 165 wp (31+33+25+23+17+18+13+5+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 36 missing (13+9+4+5+5+0+0+0+=08)=
 110 wp (16+22+25+12+16+12+7+0+=08)=20
# bounces: 8, mode: poll, userfaults: 10 missing (5+2+2+1+0+0+0+0+=08) 191 =
wp (44+39+31+24+23+13+11+6+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 33 missing (14+8+5+3+3=
+0+0+0+=08) 116 wp (25+22+24+19+8+10+2+6+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 33 missing (10+13+3+4+2+0+=
1+0+=08) 254 wp (60+50+56+40+18+15+10+5+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 37 missing (14+7+8+3+2+3+0+0+=
=08) 114 wp (26+27+25+12+13+7+4+0+=08)=20
# bounces: 4, mode: ver read, userfaults: 17 missing (8+3+2+3+1+0+0+0+=08) =
154 wp (38+33+22+20+13+14+10+4+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 32 missing (12+11+4+4+1+0+=
0+0+=08) 112 wp (26+23+18+20+10+9+2+4+=08)=20
# bounces: 2, mode: racing read, userfaults: 3 missing (2+1+0+0+0+0+0+0+=08=
) 202 wp (43+39+34+33+18+17+11+7+=08)=20
# bounces: 1, mode: rnd read, userfaults: 35 missing (14+11+4+3+2+1+0+0+=08=
) 118 wp (23+16+23+18+11+12+12+3+=08)=20
# bounces: 0, mode: read, userfaults: 19 missing (8+3+4+0+2+2+0+0+=08) 164 =
wp (28+35+26+24+18+12+11+10+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 64 missing (64+=08) 64 =
wp (64+=08)=20
# testing minor faults: =

--GIq/wZkHImOzr4Om
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-mm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
sysctl:
  sc_nr_hugepages: 2
kernel-selftests:
  group: mm
job_origin: kernel-selftests-mm.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-kbl-d01
tbox_group: lkp-kbl-d01
submit_id: 644c27ba2035bf566584990f
job_file: "/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-mm-2-debian-12-x86_64-20220629.cgz-a2eef9e49f572b7b2dfa23fc32567e83da9573d5-20230429-22117-n37r92-0.yaml"
id: 7573686df2d9235a3bb700a8e096ee44c2704d49
queuer_version: "/zday/lkp"

#! /db/releases/20230427145618/lkp-src/hosts/lkp-kbl-d01
model: Kaby Lake
nr_node: 1
nr_cpu: 8
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*"
ssd_partitions: "/dev/disk/by-id/ata-CT1000BX500SSD1_2203E5FF08F0-part1"
rootfs_partition: "/dev/disk/by-id/ata-CT1000BX500SSD1_2203E5FF08F0-part2"
brand: Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz

#! /db/releases/20230427145618/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:

#! /db/releases/20230427145618/lkp-src/include/queue/cyclic
commit: a2eef9e49f572b7b2dfa23fc32567e83da9573d5

#! /db/releases/20230427145618/lkp-src/include/testbox/lkp-kbl-d01
ucode: '0xf0'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI

#! /db/releases/20230427145618/lkp-src/include/kernel-selftests
need_kernel_version:
- ">= v6.3-rc1, gcc"
- ">= v6.3-rc1, clang"
need_kconfig:
- MEM_SOFT_DIRTY: y, x86_64
- GUP_BENCHMARK: y
- GUP_TEST: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-04-29 04:08:27.146527019 +08:00
_id: 644c27ba2035bf566584990f
_rt: "/result/kernel-selftests/mm-2/lkp-kbl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: c18fbf63a1f0325db317c3f6b7b8973baac57bfe
base_commit: 457391b0380335d5e9a5babdec90ac53928b23b4
branch: linux-devel/devel-hourly-20230427-015640
result_root: "/result/kernel-selftests/mm-2/lkp-kbl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/mm-2/lkp-kbl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/vmlinuz-6.3.0-rc1-00015-ga2eef9e49f57
- branch=linux-devel/devel-hourly-20230427-015640
- job=/lkp/jobs/scheduled/lkp-kbl-d01/kernel-selftests-mm-2-debian-12-x86_64-20220629.cgz-a2eef9e49f572b7b2dfa23fc32567e83da9573d5-20230429-22117-n37r92-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=a2eef9e49f572b7b2dfa23fc32567e83da9573d5
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230427180344/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.3.0-rc1
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a2eef9e49f572b7b2dfa23fc32567e83da9573d5/vmlinuz-6.3.0-rc1-00015-ga2eef9e49f57"
dequeue_time: 2023-04-29 04:39:27.393959818 +08:00

#! /db/releases/20230428163404/lkp-src/include/site/lkp-wsx01
job_state: soft_timeout
loadavg: 1.01 1.04 0.92 1/180 8174
start_time: '1682714534'
end_time: '1682715739'
version: "/lkp/lkp/.src-20230427-110942:7223d8995176:4ad6dc681a48"

--GIq/wZkHImOzr4Om
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

echo '2' > '/proc/sys/vm/nr_hugepages'
ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -j8 -C mm
make quicktest=1 run_tests -C mm

--GIq/wZkHImOzr4Om--
