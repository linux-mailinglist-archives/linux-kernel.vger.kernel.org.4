Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9B61E0CF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKFIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKFIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:14:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF89BF71
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667722473; x=1699258473;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=67MYWoOQukfwrjUcN2nxpHXIGH+onDyeVgbcn/yUMxY=;
  b=F2W/QyXvJGkHOlpiavfQWtZQ9q+z8AIiBvOKCg6M7uc8+YtqUYeKYmB5
   SAQDxSddGkZMijNodpNYXfy8Mq+pluPO4EGIXOSbd78LSOcUDlYhhLKMI
   iqgyPScaitL3/tuu5lXYaNFnyTyHjYiD56JgVhN/xPIZS5qbR7fdrZv/w
   3yjGma+xrceoPr/PHGKrSdr8ynjyHUlaGiWKbPPCkqHDdzpGmwXvsDVVZ
   bkwrHhhEAGdxOZ317fUKTFl+t/4fhrxpptwWUJc9Ns90vyoNoJ+/r3j4Q
   E5dbjHiF7GO7U8MOH+s1Gw0upyxFb6eCIsEoSC6hmdeZKqkq8TqbnLSXR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="297717853"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="xz'?yaml'?scan'208";a="297717853"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 01:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="880739144"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="xz'?yaml'?scan'208";a="880739144"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2022 01:14:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 01:14:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 01:14:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 01:14:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 01:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy1K3zBVtf8DbUoo+TjE2QsE8emdoztUhwPbzgLsDsMw4RcdBWSq14HG2gb45zstQCl1jMUw3sPKETCVSbKfFEN0kc1vcXgks50T5B3uiZYcsgK1AmTbrVUsHB/8JVAh1Crd5hTtN7cGJTgDSomav3DbEmRLXYT4M4qz59wmqpMMKVwwOPVmD30AyAyIcVWXT1hVUqL/l1w/z+/6gyvf9eIPRl8Hsp52AjfpDkUKHwBL6j5kyObu0OTXfADAvKxYPYj+fk3hVnRnUrt3ZLESdUdcs5G58Wsr7TwNtDwfF5rOTNEW9ejWq0B+JBwlU9YPLcJXUkMZwiaacp0bPhXEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h20JCfGRfIEmk95s/CMFA5mfN2uDnZ/4oO1xPZ6icsw=;
 b=L9G9X4gBlH8583GgX4jH9K+HLAYn/ZYOxKMiR1oPD06uZud0PQa7QPayGc3iiIwcJecKftcwC/DQvGoM4gNtLynxPGnrev1ZAu/FhrpU75Upvx0luU3OmidL3wzMZJlNzQVcVi76N2LSmC6OW/WF9Kyaj9SFY3JEZmBFpgN8OeI+94YoT04lR8Q7F+tUbEHgbBIr8S4qqwq1zPL93XMX0wP9zKgMEAuXBzwLqaQj+CsWNB2xD/OAZcxo4HoJyLW7JgctvbgY6Pzww9Pgq/2EVVrMZXaaoohFF7appdLvYpGv4vGGvIUgNNsJBQPVmXREHTNZlvnnBG90iG0RPgtC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Sun, 6 Nov
 2022 08:14:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8%7]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 08:14:22 +0000
Date:   Sun, 6 Nov 2022 16:14:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <peterx@redhat.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe
Message-ID: <202211061521.28931f7-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="lO5Jvfks0vsTK8lU"
Content-Disposition: inline
In-Reply-To: <20221030212929.335473-6-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d18338-2093-4fb8-b0ac-08dabfcee8b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lH8kfLazvAnW9t+f3Ze8r6i7lNJx8MOrQBYjvGzjS68fQ6WNuzz6oMsPOW7Fg7mlMDwzi1HLHvAHf6l4eDm9sEgzzd7xrkpfN1elnmGdpeJf5oq9XRfS5sJHqRqNj1NZ9frjIY7NxeQcXWlF37X3FEeStg5UZeJlHY2KgaFip8/ea8Cg09+jhAwp9BTrB/jxhTlN0RFk3RbpYGTwW3kHCM32BqeeKuZpjepna3/iVwAIs+bQGUSWjRjVxi9FWdMMTuaKPXCRtWBNSjqREcrEzvCpOFNTzLVSApaIb+1RIJN2vjfKEj5dN3AqNgWWspmMVIbgjzz72/5TRLHU/9//vlKA5O2B5QjTsvTvgbkmr6lawHbH5isxlbIHF3qxxrwDWKKr9IWCeXq+Y3vdc2oh9kz/vLnrK18kFJTnrVCQUH9diAdTE36XLzSH01VAYonAIEC1ArPWc1P5IuZA2YpAx1qb46GpX5R5e7HYmu4zTmo0d0bEhR3lqGdVNHQuWO4l8JzJqDaGpgX1ib/34n/bTTffjz1fiAUMYsFnSEGodv08neG6TbytpWqP8k0aT3m4EBdAHjk2Hz7QHJWWAudhyhw8dvoQRw2U69oucw2Z1L5VBdqad5kIQ7ph3j6qD0PlVp4toRiR66WauE2qva8Zi3mEjZ9Xlzfy0dlp0blCzxVhjVMKffzLgcfB5v/HNDw8+So7UCQpvVJWdQ2G5R6GHqRBdf51uxl1RUjAbDht6yxNn3zz2FqgjVVchjWftGGHopBQsCJiHfFQN8ZkhHgRB/5Yeo+4zxjzuo2VALjIBsNAi8IEilZWA/lOez7QbaDcNzP+su+ljWRQrq3JfXn1qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(478600001)(6486002)(966005)(8936002)(7416002)(5660300002)(235185007)(36756003)(2906002)(316002)(54906003)(6916009)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(38100700002)(82960400001)(6506007)(6666004)(86362001)(44144004)(186003)(1076003)(21490400003)(6512007)(26005)(2616005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GHc8SY0+lH/s1XL2EV3cgi03tDFEmknQLx1zjQDaw44d81ccsQWmYaNtdo/o?=
 =?us-ascii?Q?1JcUv0a4MDV5H7uROyOL8vawxo7KCp9t5HFmblNXJoXPNFAVYDF5AO8K3Wp4?=
 =?us-ascii?Q?DCulHXvYuVgJiPIWdZn+J2YEtQghSHAdx8TI0TaPrmHTIxxnH6Tc3wb7KAPx?=
 =?us-ascii?Q?RaZtHYuvnGIPiD+qKbUu7nkU7hGtDgRFBUqDBendb8M9P54040vCOuC++c4f?=
 =?us-ascii?Q?e6CHs1xsNbpwqlPmFuCxbD1Z73+Dzge3MfuDMp4WBX40oCr9J5E2Q7wblXK9?=
 =?us-ascii?Q?GMmyX139uWws/vXNiwmn+ey8nZyUsSqT5eQCpW48NZM0USb/ZRAotPfdsSvy?=
 =?us-ascii?Q?Wqqt4AdAtyP1DY7YLrmiu+2Mj5eqGv72M1nS71YhR2LQ9lgPkqEgPsfMjfKM?=
 =?us-ascii?Q?iSDuJG1aFkC0My55w3qQ+3WH6Q+QQVBD2pg6v3aG1VRLolQLW60n5WUUAuJ/?=
 =?us-ascii?Q?erbP0lvRWuS/nmWC8xcfqNeFQJ6VP76if2Qtl6xzwrpFPIT6J9NEqk6m+gMn?=
 =?us-ascii?Q?ONmXFMbipEy2RnDSVCA7zSdz7mSxfjKLA0HXNVtEeTzxcqFyoPajhsbu1biP?=
 =?us-ascii?Q?WtXs+qZiXSHgHFSBv/0rKF9fOa0nKAr89GxJysggo/LvGOVvJ2mjAzrAtKHX?=
 =?us-ascii?Q?wUI9WqwnUnKhUfsyfOD6rnjMi51/4N4zmmNwWyAXSSzRhdlbLw6ldTKe1rVW?=
 =?us-ascii?Q?0+rns0L+XR1wKbyPwxUlA2hFe2Ky894TuZbFmPklFqDKJhJGGgqFKqk3pAnm?=
 =?us-ascii?Q?tHJ2PWjRU2ia8OnFtKYY7uMVTF0OXK9ZE5T65Uu9eDfVDcwFlDBejutX29fx?=
 =?us-ascii?Q?itXT42nWKCJGo3TLhQG2wstrgn8LaAkUVlp8piRiux8gj7nBfdR+IJ8VYVuT?=
 =?us-ascii?Q?qpoYPoWulFPVheYAYz0ld4x/A6wLewp01RlFL2BWw3gVMyzbYqafAlGwZ1SD?=
 =?us-ascii?Q?3VIDLZU94Ntm6sxzlEZb8CiMT8i91ksXFMNKBrKliCwkf0WpWbcOyvSAW+i2?=
 =?us-ascii?Q?tnfHykEyPsUReF+sV50kNYiRR1pxOhse0lgAeCvRv7Pbd/pnTT0wDrxO1SYY?=
 =?us-ascii?Q?GYMHHw2ksJo2x87eZUxYagq7GIYBhaxuflvT7KkSDHx96qlbaINQkmolNg4i?=
 =?us-ascii?Q?il6E+cQzFK53rNLxqjbbZHxfDdJByGfUnzn+wHL6Q8GSUXF+C2DMr0o0LK0T?=
 =?us-ascii?Q?zaJ6SvQjsFKMs1lEZ6ii535OWEgt5WI+eyh9u22y4qloTgR9nELIGC8WfGQS?=
 =?us-ascii?Q?VHqk002cx0IGHV/bPNHsI3wQg8lGGjJO4zlnIF9EB1bNVkTtEGhGUVFw3+j8?=
 =?us-ascii?Q?6+4s0FSDm1e+RLD9WlPDBK1VO5e06AoXiiP6yig22OWJ1MaHGIJxgd+rFjsZ?=
 =?us-ascii?Q?rAK0Trzz1z1corfu6sjr53jwxASRwqYlb9f+LtPqdpterZJs+Ib/KvxlDSVQ?=
 =?us-ascii?Q?9G3mSpOPmQshBW5E1d6MT1YEIlGoXWB+idzRnP9q5QSf5n05CSj+b8FWDIGk?=
 =?us-ascii?Q?kk9vX4twWWKr/P9lsOHnzSLV9Sp+4hO13iq2xJqsyibQZOE1ECk5AKG9MEUf?=
 =?us-ascii?Q?KWBQNWDjnxpsuBtuk2zyPhngtpR2jlIpmlxDkKC9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d18338-2093-4fb8-b0ac-08dabfcee8b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 08:14:22.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qAIy6YU4R+feq0+CWHLfpiMuzxFjnJxsWfjT8xXnq4ay2gbBXAwZOBas8HZIublTljcZfv4Ca3lIo8P8YIqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lO5Jvfks0vsTK8lU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:suspicious_RCU_usage due to commit (built with gcc-11):

commit: 8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b ("[PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe")
url: https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-hugetlb-Make-huge_pte_offset-thread-safe-for-pmd-unshare/20221031-053221
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/lkml/20221030212929.335473-6-peterx@redhat.com
patch subject: [PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe

in testcase: kernel-selftests
version: kernel-selftests-x86_64-9313ba54-1_20221017
with following parameters:

	sc_nr_hugepages: 2
	group: vm

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211061521.28931f7-oliver.sang@intel.com


kern  :warn  : [  181.942648] WARNING: suspicious RCU usage
kern  :warn  : [  181.943175] 6.1.0-rc1-00309-g8b7e3b7ca389 #1 Tainted: G S
kern  :warn  : [  181.943972] -----------------------------
kern  :warn  : [  181.944526] include/linux/rcupdate.h:364 Illegal context switch in RCU read-side critical section!
kern  :warn  : [  181.945559]
other info that might help us debug this:

kern  :warn  : [  181.946625]
rcu_scheduler_active = 2, debug_locks = 1
kern  :warn  : [  181.947473] 2 locks held by hmm-tests/9934:
kern :warn : [  181.948016] #0: ffff8884325b2d18 (&mm->mmap_lock#2){++++}-{3:3}, at: dmirror_fault (test_hmm.c:?) test_hmm
kern :warn : [  181.949129] #1: ffffffff858a7860 (rcu_read_lock){....}-{1:2}, at: walk_hugetlb_range (pagewalk.c:?) 
kern  :warn  : [  181.950161]
stack backtrace:
kern  :warn  : [  181.950780] CPU: 9 PID: 9934 Comm: hmm-tests Tainted: G S                 6.1.0-rc1-00309-g8b7e3b7ca389 #1
kern  :warn  : [  181.951863] Hardware name: Dell Inc. Vostro 3670/0HVPDY, BIOS 1.5.11 12/24/2018
kern  :warn  : [  181.952709] Call Trace:
kern  :warn  : [  181.953070]  <TASK>
kern :warn : [  181.953403] dump_stack_lvl (??:?) 
kern :warn : [  181.953890] __might_resched (??:?) 
kern :warn : [  181.954403] __mutex_lock (mutex.c:?) 
kern :warn : [  181.954886] ? validate_chain (lockdep.c:?) 
kern :warn : [  181.955405] ? hugetlb_fault (??:?) 
kern :warn : [  181.955926] ? mark_lock+0xca/0xac0 
kern :warn : [  181.956450] ? mutex_lock_io_nested (mutex.c:?) 
kern :warn : [  181.957039] ? check_prev_add (lockdep.c:?) 
kern :warn : [  181.957580] ? hugetlb_vm_op_pagesize (hugetlb.c:?) 
kern :warn : [  181.958177] ? hugetlb_fault (??:?) 
kern :warn : [  181.958690] hugetlb_fault (??:?) 
kern :warn : [  181.959199] ? find_held_lock (lockdep.c:?) 
kern :warn : [  181.959709] ? hugetlb_no_page (??:?) 
kern :warn : [  181.960255] ? __lock_release (lockdep.c:?) 
kern :warn : [  181.960772] ? lock_downgrade (lockdep.c:?) 
kern :warn : [  181.961292] ? lock_is_held_type (??:?) 
kern :warn : [  181.961830] ? handle_mm_fault (??:?) 
kern :warn : [  181.962363] handle_mm_fault (??:?) 
kern :warn : [  181.962870] ? hmm_vma_walk_hugetlb_entry (hmm.c:?) 
kern :warn : [  181.963501] hmm_vma_fault (hmm.c:?) 
kern :warn : [  181.964096] walk_hugetlb_range (pagewalk.c:?) 
kern :warn : [  181.964639] __walk_page_range (pagewalk.c:?) 
kern :warn : [  181.965160] walk_page_range (??:?) 
kern :warn : [  181.965670] ? __walk_page_range (??:?) 
kern :warn : [  181.966213] ? rcu_read_unlock (main.c:?) 
kern :warn : [  181.966718] ? lock_is_held_type (??:?) 
kern :warn : [  181.967259] ? mmu_interval_read_begin (??:?) 
kern :warn : [  181.967855] ? lock_is_held_type (??:?) 
kern :warn : [  181.968400] hmm_range_fault (??:?) 
kern :warn : [  181.968911] ? down_read (??:?) 
kern :warn : [  181.969383] ? hmm_vma_fault (??:?) 
kern :warn : [  181.969891] ? __lock_release (lockdep.c:?) 
kern :warn : [  181.970416] dmirror_fault (test_hmm.c:?) test_hmm
kern :warn : [  181.971012] ? dmirror_migrate_to_system+0x590/0x590 test_hmm
kern :warn : [  181.971847] ? find_held_lock (lockdep.c:?) 
kern :warn : [  181.972355] ? dmirror_write+0x202/0x310 test_hmm
kern :warn : [  181.973069] ? __lock_release (lockdep.c:?) 
kern :warn : [  181.973586] ? lock_downgrade (lockdep.c:?) 
kern :warn : [  181.974107] ? lock_is_held_type (??:?) 
kern :warn : [  181.974641] ? dmirror_write+0x202/0x310 test_hmm
kern :warn : [  181.975355] ? lock_release (??:?) 
kern :warn : [  181.975845] ? __mutex_unlock_slowpath (mutex.c:?) 
kern :warn : [  181.976444] ? bit_wait_io_timeout (mutex.c:?) 
kern :warn : [  181.977008] ? lock_is_held_type (??:?) 
kern :warn : [  181.977547] ? dmirror_do_write (test_hmm.c:?) test_hmm
kern :warn : [  181.978185] dmirror_write+0x1bf/0x310 test_hmm
kern :warn : [  181.978881] ? dmirror_fault (test_hmm.c:?) test_hmm
kern :warn : [  181.979484] ? lock_is_held_type (??:?) 
kern :warn : [  181.980021] ? __might_fault (??:?) 
kern :warn : [  181.980523] ? lock_release (??:?) 
kern :warn : [  181.981019] dmirror_fops_unlocked_ioctl (test_hmm.c:?) test_hmm
kern :warn : [  181.981732] ? dmirror_exclusive+0x780/0x780 test_hmm
kern :warn : [  181.982485] ? do_user_addr_fault (fault.c:?) 
kern :warn : [  181.983042] ? __lock_release (lockdep.c:?) 
kern :warn : [  181.983562] __x64_sys_ioctl (??:?) 
kern :warn : [  181.984074] do_syscall_64 (??:?) 
kern :warn : [  181.984545] ? do_user_addr_fault (fault.c:?) 
kern :warn : [  181.985103] ? do_user_addr_fault (fault.c:?) 
kern :warn : [  181.985654] ? irqentry_exit_to_user_mode (??:?) 
kern :warn : [  181.986256] ? lockdep_hardirqs_on_prepare (lockdep.c:?) 
kern :warn : [  181.986945] entry_SYSCALL_64_after_hwframe (??:?) 
kern  :warn  : [  181.987569] RIP: 0033:0x7fac2f598e9b
kern :warn : [ 181.988047] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1b 48 8b 44 24 18 64 48 2b 04 25 28 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	31 c0                	xor    %eax,%eax
   8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
   d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	41 89 c0             	mov    %eax,%r8d		<-- trapping instruction
  2d:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
  32:	77 1b                	ja     0x4f
  34:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  39:	64                   	fs
  3a:	48                   	rex.W
  3b:	2b                   	.byte 0x2b
  3c:	04 25                	add    $0x25,%al
  3e:	28 00                	sub    %al,(%rax)

Code starting with the faulting instruction
===========================================
   0:	41 89 c0             	mov    %eax,%r8d
   3:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   8:	77 1b                	ja     0x25
   a:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   f:	64                   	fs
  10:	48                   	rex.W
  11:	2b                   	.byte 0x2b
  12:	04 25                	add    $0x25,%al
  14:	28 00                	sub    %al,(%rax)


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
https://01.org/lkp



--lO5Jvfks0vsTK8lU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc1-00309-g8b7e3b7ca389"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
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
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
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
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=y
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
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=21
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
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
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
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
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
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
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
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
CONFIG_ARCH_NR_GPIO=1024
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
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
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
CONFIG_PMIC_OPREGION=y
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
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_POWERNOW_K8=y
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
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

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
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
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
CONFIG_BLK_CGROUP_IOLATENCY=y
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
CONFIG_BINFMT_MISC=y
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

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
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
CONFIG_HWPOISON_INJECT=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
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
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
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
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
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
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
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
# CONFIG_DEFAULT_CUBIC is not set
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_TCP_CONG="reno"
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
CONFIG_IPV6_MIP6=y
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
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
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
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
CONFIG_NFT_OBJREF=m
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
CONFIG_NETFILTER_XT_MATCH_BPF=y
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
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
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
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
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
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
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
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
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
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
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
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
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
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
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
CONFIG_BPF_STREAM_PARSER=y
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
CONFIG_FAILOVER=y
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
CONFIG_PCI_MSI_IRQ_DOMAIN=y
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
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
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
# CONFIG_PARPORT_AX88796 is not set
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
# CONFIG_PARIDE is not set
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
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
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
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
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

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
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
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
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
CONFIG_MD_CLUSTER=m
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
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
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
CONFIG_BONDING=m
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
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
CONFIG_VETH=y
CONFIG_VIRTIO_NET=y
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
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
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
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
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
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
CONFIG_SERIAL_JSM=m
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
CONFIG_VIRTIO_CONSOLE=y
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
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
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
# CONFIG_PDA_POWER is not set
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
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
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
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
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
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
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
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
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
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
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
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
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
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
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
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
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
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
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
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
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
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

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
CONFIG_FB_MODE_HELPERS=y
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
# CONFIG_FB_INTEL is not set
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

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=y
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
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
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
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
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

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
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
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
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

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
# CONFIG_USB_ATM is not set

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
# CONFIG_MMC_REALTEK_PCI is not set
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
CONFIG_LEDS_TRIGGER_AUDIO=m
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
CONFIG_EDAC_I5000=m
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
CONFIG_RTC_DRV_V3020=m

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
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
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
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_EFI_SECRET is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
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
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
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
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
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
# CONFIG_INTEL_ISHTP_ECLITE is not set
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
CONFIG_HWSPINLOCK=y

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
CONFIG_IRQ_REMAP=y
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
CONFIG_GENERIC_PHY=y
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
# CONFIG_IDLE_INJECT is not set
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
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
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
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
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
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
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
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
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
CONFIG_NFSD_V2_ACL=y
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
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
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
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
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
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
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
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
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
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
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
CONFIG_CRYPTO_BLAKE2B=y
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
CONFIG_CRYPTO_XXHASH=y
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
CONFIG_CRYPTO_USER_API_HASH=y
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

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
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
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_UNFORCE_NR_CPUS=y
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
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_TER16x32 is not set
# CONFIG_FONT_6x8 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
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
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
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
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
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

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
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
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
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
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_FPROBE is not set
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
CONFIG_NOTIFIER_ERROR_INJECTION=y
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
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_FUNCTION=y
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
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
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
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
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--lO5Jvfks0vsTK8lU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export job_origin='kernel-selftests-vm.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-cfl-d1'
	export tbox_group='lkp-cfl-d1'
	export submit_id='6365015527b7706aa54dec03'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-d1/kernel-selftests-vm-2-debian-12-x86_64-20220629.cgz-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b-20221104-27301-1mqq9d8-4.yaml'
	export id='116d4585cc257c19962f3eb53ae9ad654c2a94a4'
	export queuer_version='/zday/lkp'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=12
	export memory='16G'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part5'
	export swap_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part3'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part4'
	export kernel_cmdline_hw='acpi_rsdp=0xb9e23000'
	export brand='Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz'
	export commit='8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b'
	export netconsole_port=6677
	export ucode='0xf0'
	export need_kconfig_hw='SATA_AHCI
{"R8169"=>"y"}
DRM_I915'
	export bisect_dmesg=true
	export need_kconfig=\{\"MEM_SOFT_DIRTY\"\=\>\"y,\ x86_64\"\}'
'\{\"GUP_BENCHMARK\"\=\>\"y,\ v4.15-rc1,\ \<\=\ v5.10\"\}'
'\{\"GUP_TEST\"\=\>\"y,\ v5.11-rc1\"\}
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2022-11-04 20:11:02 +0800'
	export _id='6365016e27b7706aa54dec04'
	export _rt='/result/kernel-selftests/vm-2/lkp-cfl-d1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='59c99a569b3b8d64ecca08ddb05bd2d0ebb8ad19'
	export base_commit='30a0b95b1335e12efef89dd78518ed3e4a71a763'
	export branch='linux-review/Peter-Xu/mm-hugetlb-Make-huge_pte_offset-thread-safe-for-pmd-unshare/20221031-053221'
	export result_root='/result/kernel-selftests/vm-2/lkp-cfl-d1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/3'
	export scheduler_version='/lkp/lkp/.src-20221104-135305'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/vm-2/lkp-cfl-d1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/vmlinuz-6.1.0-rc1-00309-g8b7e3b7ca389
branch=linux-review/Peter-Xu/mm-hugetlb-Make-huge_pte_offset-thread-safe-for-pmd-unshare/20221031-053221
job=/lkp/jobs/scheduled/lkp-cfl-d1/kernel-selftests-vm-2-debian-12-x86_64-20220629.cgz-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b-20221104-27301-1mqq9d8-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b
initcall_debug
acpi_rsdp=0xb9e23000
max_uptime=2100
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20221017.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-9313ba54-1_20221017.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20220629.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.0.0-05990-g32e91a7b118a'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/vmlinuz-6.1.0-rc1-00309-g8b7e3b7ca389'
	export dequeue_time='2022-11-04 20:24:19 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-d1/kernel-selftests-vm-2-debian-12-x86_64-20220629.cgz-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b-20221104-27301-1mqq9d8-4.cgz'

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

	run_test group='vm' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='vm' $LKP_SRC/stats/wrapper kernel-selftests
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

--lO5Jvfks0vsTK8lU
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--lO5Jvfks0vsTK8lU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b
2022-11-04 12:27:54 ln -sf /usr/bin/clang
2022-11-04 12:27:54 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2022-11-04 12:27:54 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2022-11-04 12:27:54 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2022-11-04 12:27:54 make -C vm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm'
/bin/sh ./check_config.sh gcc
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    madv_populate.=
c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/m=
adv_populate
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    soft-dirty.c v=
m_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/soft=
-dirty
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    split_huge_pag=
e_test.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftes=
ts/vm/split_huge_page_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    ksm_functional=
_tests.c vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftes=
ts/vm/ksm_functional_tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    anon_cow.c vm_=
util.c -lrt -lpthread  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/anon_=
cow
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    compaction_tes=
t.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b=
7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/compactio=
n_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    gup_test.c -lr=
t -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca=
3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/gup_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    hmm-tests.c -l=
rt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7c=
a3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/hmm-tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    hugetlb-madvis=
e.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b=
7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/hugetlb-m=
advise
hugetlb-madvise.c:20: warning: "__USE_GNU" redefined
   20 | #define __USE_GNU
      |=20
In file included from /usr/include/x86_64-linux-gnu/bits/libc-header-start.=
h:33,
                 from /usr/include/stdlib.h:26,
                 from hugetlb-madvise.c:16:
/usr/include/features.h:407: note: this is the location of the previous def=
inition
  407 | # define __USE_GNU      1
      |=20
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    hugepage-mmap.=
c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e=
3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/hugepage-mm=
ap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    hugepage-mrema=
p.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b=
7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/hugepage-=
mremap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    hugepage-shm.c=
 -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3=
b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/hugepage-shm
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    hugepage-vmemm=
ap.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8=
b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/hugepage=
-vmemmap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    khugepaged.c v=
m_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftes=
ts-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/khug=
epaged
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    map_fixed_nore=
place.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/map_f=
ixed_noreplace
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    map_hugetlb.c =
-lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b=
7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/map_hugetlb
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    map_populate.c=
 -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3=
b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/map_populate
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    memfd_secret.c=
 -lrt -lpthread -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/memfd_=
secret
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    migration.c -l=
rt -lpthread -lnuma -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8=
b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/migratio=
n
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    mlock-random-t=
est.c -lrt -lpthread -lcap -o /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/m=
lock-random-test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    mlock2-tests.c=
 -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3=
b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/mlock2-tests
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    mrelease_test.=
c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e=
3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/mrelease_te=
st
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    mremap_dontunm=
ap.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8=
b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/mremap_d=
ontunmap
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    mremap_test.c =
-lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b=
7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/mremap_test
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    on-fault-limit=
.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7=
e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/on-fault-l=
imit
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    thuge-gen.c -l=
rt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7c=
a3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/thuge-gen
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    transhuge-stre=
ss.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8=
b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/transhug=
e-stress
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    userfaultfd.c =
vm_util.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/use=
rfaultfd
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    ksm_tests.c -l=
rt -lpthread -lnuma -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8=
b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/ksm_test=
s
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie -m32 -mxsave  pro=
tection_keys.c -lrt -lpthread -lrt -ldl -lm -o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testi=
ng/selftests/vm/protection_keys_32
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie -m64 -mxsave  pro=
tection_keys.c -lrt -lpthread -lrt -ldl -o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/s=
elftests/vm/protection_keys_64
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    va_128TBswitch=
.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7=
e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/va_128TBsw=
itch
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    virtual_addres=
s_range.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselfte=
sts-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/vir=
tual_address_range
gcc -Wall -I /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca38=
97ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/../../.. -I /usr/src/=
perf_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6=
4056e3b/tools/testing/selftests/../../../usr/include  -isystem /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-8b7e3b7ca3897ebc4cb7b23c65a4618d6405=
6e3b/tools/testing/selftests/../../../usr/include -no-pie    write_to_huget=
lbfs.c -lrt -lpthread -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm/write_=
to_hugetlbfs

Warning: missing liburing support. Some COW tests will be skipped.

make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm'
2022-11-04 12:28:04 make quicktest=3D1 run_tests -C vm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftest=
s-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm'

Warning: missing liburing support. Some COW tests will be skipped.

TAP version 13
1..5
# selftests: vm: madv_populate
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
ok 1 selftests: vm: madv_populate
# selftests: vm: soft-dirty
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
ok 2 selftests: vm: soft-dirty
# selftests: vm: split_huge_page_test
# No THP is allocated
not ok 3 selftests: vm: split_huge_page_test # exit=3D1
# selftests: vm: ksm_functional_tests
# TAP version 13
# 1..3
# # [RUN] test_unmerge
# ok 1 Pages were unmerged
# # [RUN] test_unmerge_discarded
# ok 2 Pages were unmerged
# # [RUN] test_unmerge_uffd_wp
# ok 3 Pages were unmerged
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: vm: ksm_functional_tests
# selftests: vm: run_vmtests.sh
# running: ./hugepage-mmap
# -----------------------
# running ./hugepage-mmap
# -----------------------
# Open failed: No such file or directory
# [FAIL]
# running: ./hugepage-shm
# ----------------------
# running ./hugepage-shm
# ----------------------
# shmid: 0x0
# shmaddr: 0x7f1ac8400000
# Starting the writes:
# .........................................................................=
...........................................................................=
...........................................................................=
.................................
# Starting the Check...Done.
# [PASS]
# running: ./map_hugetlb
# ---------------------
# running ./map_hugetlb
# ---------------------
# Default size hugepages
# Mapping 256 Mbytes
# Returned address is 0x7fc8d9400000
# First hex is 0
# First hex is 3020100
# [PASS]
# running: ./hugepage-mremap
# -------------------------
# running ./hugepage-mremap
# -------------------------
# Map haddr: Returned address is 0x7eaa40000000
# Map daddr: Returned address is 0x7daa40000000
# Map vaddr: Returned address is 0x7faa40000000
# Address returned by mmap() =3D 0x7f1bc4600000
# Mremap: Returned address is 0x7faa40000000
# First hex is 0
# First hex is 3020100
# [PASS]
# running: ./hugepage-vmemmap
# --------------------------
# running ./hugepage-vmemmap
# --------------------------
# Returned address is 0x7fbc56400000 whose pfn is 227600
# [PASS]
# running: ./hugetlb-madvise
# -------------------------
# running ./hugetlb-madvise
# -------------------------
# Unexpected number of free huge pages line 207
# [FAIL]
# NOTE: These hugetlb tests provide minimal coverage.  Use
#       https://github.com/libhugetlbfs/libhugetlbfs.git for
#       hugetlb regression testing.
# running: ./map_fixed_noreplace
# -----------------------------
# running ./map_fixed_noreplace
# -----------------------------
# mmap() @ 0x7f8201d69000-0x7f8201d6e000 p=3D0x7f8201d69000 result=3DSucces=
s
# unmap() successful
# mmap() @ 0x7f8201d6a000-0x7f8201d6d000 p=3D0x7f8201d6a000 result=3DSucces=
s
# mmap() @ 0x7f8201d69000-0x7f8201d6e000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f8201d6b000-0x7f8201d6c000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f8201d6c000-0x7f8201d6e000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f8201d69000-0x7f8201d6b000 p=3D0xffffffffffffffff result=3DFi=
le exists
# mmap() @ 0x7f8201d69000-0x7f8201d6a000 p=3D0x7f8201d69000 result=3DSucces=
s
# mmap() @ 0x7f8201d6d000-0x7f8201d6e000 p=3D0x7f8201d6d000 result=3DSucces=
s
# unmap() successful
# OK
# [PASS]
# running: ./gup_test
# ---------------------
# running ./gup_test -u
# ---------------------
# GUP_FAST_BENCHMARK: Time: get:12580 put:304 us
# [PASS]
# running: ./gup_test
# ---------------------
# running ./gup_test -a
# ---------------------
# PIN_FAST_BENCHMARK: Time: get:14417 put:894 us
# [PASS]
# running: ./gup_test
# -----------------------------------------
# running ./gup_test -ct -F 0x1 0 19 0x1000
# -----------------------------------------
# DUMP_USER_PAGES_TEST: done
# [PASS]
# running: ./userfaultfd
# --------------------------------
# running ./userfaultfd anon 20 16
# --------------------------------
# nr_pages: 5112, nr_pages_per_cpu: 426
# bounces: 15, mode: rnd racing ver poll, userfaults: 386 missing (70+32+62=
+34+29+9+29+9+40+40+16+16+=08) 2748 wp (292+183+327+205+221+229+175+158+274=
+239+188+257+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 95 missing (27+15+14+13+9=
+2+4+3+3+1+3+1+=08) 937 wp (127+59+78+121+88+81+54+80+90+45+68+46+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 408 missing (73+79+71+27+19+=
19+16+10+30+34+23+7+=08) 2506 wp (305+303+319+139+213+182+171+124+187+226+2=
01+136+=08)=20
# bounces: 12, mode: ver poll, userfaults: 199 missing (38+28+12+25+29+27+1=
4+7+5+5+3+6+=08) 2739 wp (244+247+248+287+284+274+284+145+185+218+160+163+=
=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 382 missing (67+46+56+56+=
22+16+34+17+32+20+4+12+=08) 2524 wp (206+145+230+317+229+146+241+154+279+25=
4+136+187+=08)=20
# bounces: 10, mode: racing poll, userfaults: 124 missing (32+28+13+16+4+3+=
3+9+4+2+5+5+=08) 1261 wp (165+184+116+132+73+114+89+59+75+59+107+88+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 385 missing (54+59+72+47+22+38+21=
+6+2+39+21+4+=08) 2491 wp (188+195+331+248+210+229+173+124+172+298+153+170+=
=08)=20
# bounces: 8, mode: poll, userfaults: 140 missing (35+19+20+23+14+6+8+8+1+4=
+0+2+=08) 2883 wp (341+260+325+225+257+178+283+239+180+180+162+253+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 560 missing (69+62+97+=
65+43+85+41+34+20+34+3+7+=08) 3220 wp (299+276+356+350+294+376+237+228+203+=
283+175+143+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 258 missing (66+43+19+28+3=
1+13+24+23+2+4+4+1+=08) 1360 wp (186+128+115+139+131+109+117+145+60+94+74+6=
2+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 537 missing (124+56+47+63+51+=
37+37+74+29+8+11+0+=08) 3304 wp (424+221+254+242+299+238+384+328+348+187+22=
1+158+=08)=20
# bounces: 4, mode: ver read, userfaults: 183 missing (41+32+21+22+23+14+6+=
4+8+4+7+1+=08) 3600 wp (504+299+399+321+327+420+249+289+283+166+199+144+=08=
)=20
# bounces: 3, mode: rnd racing read, userfaults: 634 missing (89+85+115+68+=
55+64+54+36+24+29+9+6+=08) 3613 wp (353+295+485+357+309+328+268+283+253+340=
+177+165+=08)=20
# bounces: 2, mode: racing read, userfaults: 211 missing (38+34+14+25+9+37+=
6+2+12+21+11+2+=08) 1207 wp (152+142+87+131+71+133+90+67+100+85+98+51+=08)=
=20
# bounces: 1, mode: rnd read, userfaults: 509 missing (88+78+94+80+58+36+30=
+21+12+5+2+5+=08) 2410 wp (250+259+319+325+182+230+261+182+115+88+100+99+=
=08)=20
# bounces: 0, mode: read, userfaults: 73 missing (19+12+6+5+3+7+8+8+4+1+0+0=
+=08) 2842 wp (219+245+315+214+278+204+355+293+204+203+141+171+=08)=20
# testing uffd-wp with pagemap (pgsize=3D4096): done
# testing uffd-wp with pagemap (pgsize=3D2097152): done
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5112 missing (5112+=08)=
 5112 wp (5112+=08)=20
# [PASS]
# running: ./userfaultfd
# ------------------------------------
# running ./userfaultfd hugetlb 128 32
# ------------------------------------
# nr_pages: 60, nr_pages_per_cpu: 5
# bounces: 31, mode: rnd racing ver poll, userfaults: 44 missing (15+10+8+7=
+4+0+0+0+0+0+0+0+=08) 131 wp (36+25+20+16+10+9+7+7+0+1+0+0+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 26 missing (11+6+4+1+1+0+=
0+2+1+0+0+0+=08) 245 wp (35+38+46+35+26+19+21+17+4+2+0+2+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 45 missing (16+11+7+7+3+1+0+=
0+0+0+0+0+=08) 134 wp (22+35+15+18+17+10+3+5+4+4+0+1+=08)=20
# bounces: 28, mode: ver poll, userfaults: 28 missing (10+9+3+1+1+2+0+1+1+0=
+0+0+=08) 243 wp (50+35+39+36+15+25+13+15+6+7+2+0+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 43 missing (15+11+9+5+2+1=
+0+0+0+0+0+0+=08) 136 wp (31+26+15+18+17+12+2+4+5+4+2+0+=08)=20
# bounces: 26, mode: racing poll, userfaults: 28 missing (10+7+1+3+3+3+1+0+=
0+0+0+0+=08) 227 wp (41+31+36+29+26+20+15+15+4+6+3+1+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 42 missing (15+11+10+3+2+1+0+0+0=
+0+0+0+=08) 132 wp (26+26+22+15+10+8+7+8+5+1+3+1+=08)=20
# bounces: 24, mode: poll, userfaults: 29 missing (12+4+4+1+3+1+0+2+2+0+0+0=
+=08) 185 wp (35+31+28+17+20+15+12+13+8+3+2+1+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 42 missing (15+12+7+5=
+3+0+0+0+0+0+0+0+=08) 137 wp (32+19+24+14+16+12+6+5+5+0+1+3+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 39 missing (8+5+6+6+4+6+1=
+3+0+0+0+0+=08) 216 wp (34+34+36+29+20+15+14+16+7+5+2+4+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 46 missing (16+13+9+6+2+0+0+=
0+0+0+0+0+=08) 133 wp (30+21+19+15+17+8+10+4+2+3+2+2+=08)=20
# bounces: 20, mode: ver read, userfaults: 31 missing (9+6+6+6+3+0+0+0+0+1+=
0+0+=08) 235 wp (43+30+34+31+25+16+11+11+14+11+7+2+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 47 missing (15+10+12+5+5+=
0+0+0+0+0+0+0+=08) 131 wp (33+23+18+16+14+9+1+8+5+1+2+1+=08)=20
# bounces: 18, mode: racing read, userfaults: 35 missing (9+7+4+2+4+2+3+1+1=
+1+1+0+=08) 241 wp (41+31+38+25+20+22+22+13+11+8+7+3+=08)=20
# bounces: 17, mode: rnd read, userfaults: 46 missing (17+12+10+3+3+1+0+0+0=
+0+0+0+=08) 144 wp (26+22+20+22+16+14+7+6+6+4+1+0+=08)=20
# bounces: 16, mode: read, userfaults: 43 missing (15+4+6+5+3+1+4+0+2+1+1+1=
+=08) 219 wp (45+36+36+21+24+15+14+9+10+4+3+2+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 44 missing (15+12+6+6=
+4+1+0+0+0+0+0+0+=08) 151 wp (26+24+31+19+12+12+9+8+2+4+4+0+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 45 missing (14+12+3+6+1+2=
+3+1+3+0+0+0+=08) 245 wp (41+38+32+28+25+24+22+15+8+7+2+3+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 45 missing (17+13+7+5+3+0+0+=
0+0+0+0+0+=08) 143 wp (30+32+16+18+16+9+6+5+2+6+3+0+=08)=20
# bounces: 12, mode: ver poll, userfaults: 43 missing (15+7+9+2+3+3+0+1+0+2=
+1+0+=08) 225 wp (47+25+30+34+16+19+19+11+9+7+4+4+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 45 missing (12+13+10+6+3+=
1+0+0+0+0+0+0+=08) 138 wp (34+23+16+23+14+8+7+6+2+4+1+0+=08)=20
# bounces: 10, mode: racing poll, userfaults: 35 missing (12+9+4+2+3+1+2+1+=
1+0+0+0+=08) 248 wp (51+34+34+19+27+15+15+21+10+14+4+4+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 45 missing (13+13+11+4+3+1+0+0+0+=
0+0+0+=08) 140 wp (29+25+22+14+16+10+8+5+5+2+2+2+=08)=20
# bounces: 8, mode: poll, userfaults: 39 missing (8+11+2+5+3+3+3+2+1+1+0+0+=
=08) 245 wp (41+36+32+31+28+20+9+20+12+8+5+3+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 40 missing (17+11+7+4+=
1+0+0+0+0+0+0+0+=08) 138 wp (35+19+20+24+15+8+5+2+2+7+0+1+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 42 missing (17+7+7+3+3+1+0=
+1+3+0+0+0+=08) 254 wp (38+27+26+27+37+26+24+12+12+9+10+6+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 45 missing (18+11+7+5+3+1+0+0=
+0+0+0+0+=08) 135 wp (18+29+28+19+16+7+6+5+3+3+0+1+=08)=20
# bounces: 4, mode: ver read, userfaults: 49 missing (11+12+9+5+3+2+3+3+1+0=
+0+0+=08) 305 wp (39+32+35+32+27+37+32+29+10+9+8+15+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 45 missing (15+9+10+7+3+1+=
0+0+0+0+0+0+=08) 138 wp (25+31+21+16+15+12+4+5+4+3+1+1+=08)=20
# bounces: 2, mode: racing read, userfaults: 45 missing (8+9+8+6+3+4+1+3+1+=
1+1+0+=08) 301 wp (42+34+35+33+30+35+24+26+15+17+5+5+=08)=20
# bounces: 1, mode: rnd read, userfaults: 44 missing (15+10+9+6+3+1+0+0+0+0=
+0+0+=08) 131 wp (35+19+22+11+13+10+6+1+7+2+3+2+=08)=20
# bounces: 0, mode: read, userfaults: 52 missing (12+12+8+9+2+6+1+1+0+1+0+0=
+=08) 345 wp (50+42+43+33+32+40+14+16+18+18+22+17+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 60 missing (60+=08) 60 =
wp (60+=08)=20
# [PASS]
# running: ./userfaultfd
# -------------------------------------------
# running ./userfaultfd hugetlb_shared 128 32
# -------------------------------------------
# nr_pages: 60, nr_pages_per_cpu: 5
# bounces: 31, mode: rnd racing ver poll, userfaults: 38 missing (17+9+5+4+=
2+1+0+0+0+0+0+0+=08) 121 wp (23+23+20+15+11+8+7+4+2+5+2+1+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 13 missing (8+2+2+1+0+0+0=
+0+0+0+0+0+=08) 274 wp (42+41+36+35+26+28+11+21+14+10+5+5+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 45 missing (15+11+7+6+3+2+1+=
0+0+0+0+0+=08) 142 wp (27+29+24+13+12+13+10+5+4+1+3+1+=08)=20
# bounces: 28, mode: ver poll, userfaults: 12 missing (6+5+1+0+0+0+0+0+0+0+=
0+0+=08) 238 wp (42+29+34+32+24+28+9+17+9+8+4+2+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 40 missing (10+9+12+7+1+1=
+0+0+0+0+0+0+=08) 129 wp (26+20+23+14+16+14+7+4+4+0+1+0+=08)=20
# bounces: 26, mode: racing poll, userfaults: 25 missing (9+3+1+3+0+5+1+0+3=
+0+0+0+=08) 231 wp (44+41+29+37+21+19+11+10+5+8+5+1+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 39 missing (16+6+8+7+2+0+0+0+0+0=
+0+0+=08) 130 wp (27+29+18+11+14+11+4+6+6+2+1+1+=08)=20
# bounces: 24, mode: poll, userfaults: 14 missing (7+1+1+1+2+0+1+1+0+0+0+0+=
=08) 216 wp (35+29+32+24+25+20+13+15+12+5+4+2+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 39 missing (14+7+9+3+=
4+2+0+0+0+0+0+0+=08) 135 wp (21+24+14+23+12+7+9+8+8+6+2+1+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 27 missing (11+4+5+3+0+2+=
0+0+0+2+0+0+=08) 228 wp (44+38+29+26+19+21+14+13+12+8+1+3+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 42 missing (10+13+9+2+5+3+0+=
0+0+0+0+0+=08) 137 wp (22+35+16+12+12+9+9+11+5+2+2+2+=08)=20
# bounces: 20, mode: ver read, userfaults: 20 missing (8+4+3+2+0+0+1+0+1+0+=
1+0+=08) 225 wp (38+31+28+29+22+17+23+13+5+8+10+1+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 40 missing (12+9+9+3+4+3+=
0+0+0+0+0+0+=08) 149 wp (28+25+23+16+23+5+12+10+3+0+3+1+=08)=20
# bounces: 18, mode: racing read, userfaults: 21 missing (6+3+9+0+1+1+1+0+0=
+0+0+0+=08) 247 wp (46+30+36+26+27+21+16+9+11+10+10+5+=08)=20
# bounces: 17, mode: rnd read, userfaults: 44 missing (13+11+11+6+2+1+0+0+0=
+0+0+0+=08) 144 wp (25+31+17+14+12+13+10+9+6+5+0+2+=08)=20
# bounces: 16, mode: read, userfaults: 23 missing (8+4+3+1+1+2+2+0+2+0+0+0+=
=08) 265 wp (34+40+37+33+24+28+19+14+10+12+10+4+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 41 missing (11+7+6+6+=
6+4+1+0+0+0+0+0+=08) 143 wp (28+26+17+24+16+11+8+3+7+1+1+1+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 34 missing (8+9+4+5+2+1+1=
+3+0+1+0+0+=08) 246 wp (39+41+25+25+20+21+20+19+16+7+10+3+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 39 missing (13+6+8+6+2+4+0+0=
+0+0+0+0+=08) 128 wp (18+35+20+15+15+8+6+3+5+0+2+1+=08)=20
# bounces: 12, mode: ver poll, userfaults: 26 missing (7+12+4+1+0+0+1+1+0+0=
+0+0+=08) 252 wp (34+41+38+28+25+25+18+11+11+9+7+5+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 44 missing (14+14+5+5+4+1=
+1+0+0+0+0+0+=08) 140 wp (21+24+27+21+12+13+6+5+4+3+2+2+=08)=20
# bounces: 10, mode: racing poll, userfaults: 40 missing (15+5+7+1+3+6+0+1+=
2+0+0+0+=08) 257 wp (30+32+40+26+29+21+17+15+17+11+14+5+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 42 missing (13+15+7+5+2+0+0+0+0+0=
+0+0+=08) 125 wp (30+18+14+14+14+11+8+6+6+2+1+1+=08)=20
# bounces: 8, mode: poll, userfaults: 29 missing (7+11+3+1+2+1+2+1+0+1+0+0+=
=08) 218 wp (38+27+31+22+22+17+13+14+12+12+6+4+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 43 missing (14+9+9+5+3=
+3+0+0+0+0+0+0+=08) 153 wp (28+24+24+13+18+14+12+0+6+6+3+5+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 34 missing (8+10+7+3+1+1+2=
+0+0+2+0+0+=08) 288 wp (32+41+30+36+33+27+26+20+16+12+9+6+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 42 missing (15+10+8+5+3+1+0+0=
+0+0+0+0+=08) 129 wp (22+22+18+15+15+10+6+6+3+6+3+3+=08)=20
# bounces: 4, mode: ver read, userfaults: 40 missing (11+14+6+3+2+2+1+1+0+0=
+0+0+=08) 261 wp (37+38+33+29+25+19+20+16+21+15+5+3+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 41 missing (13+9+9+6+3+0+1=
+0+0+0+0+0+=08) 135 wp (34+23+19+17+7+12+9+7+3+0+3+1+=08)=20
# bounces: 2, mode: racing read, userfaults: 42 missing (10+9+4+4+5+3+2+1+2=
+2+0+0+=08) 260 wp (38+30+29+38+26+20+20+17+17+15+9+1+=08)=20
# bounces: 1, mode: rnd read, userfaults: 40 missing (13+9+7+5+4+0+2+0+0+0+=
0+0+=08) 136 wp (33+24+16+18+16+11+6+4+4+0+2+2+=08)=20
# bounces: 0, mode: read, userfaults: 38 missing (7+8+6+2+6+3+2+3+0+0+1+0+=
=08) 261 wp (36+34+31+26+29+17+26+16+21+8+13+4+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 60 missing (60+=08) 60 =
wp (60+=08)=20
# testing minor faults: userfaults: 60 minor (60+=08)
# [PASS]
# running: ./userfaultfd
# ---------------------------------
# running ./userfaultfd shmem 20 16
# ---------------------------------
# nr_pages: 5112, nr_pages_per_cpu: 426
# bounces: 15, mode: rnd racing ver poll, userfaults: 457 missing (96+62+49=
+32+32+23+50+42+15+32+20+4+=08) 5259 wp (561+538+493+380+323+355+478+516+28=
1+517+371+446+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 99 missing (31+14+13+21+8=
+4+1+1+2+4+0+0+=08) 2722 wp (349+302+216+256+263+223+213+171+146+220+158+20=
5+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 632 missing (65+54+102+65+49=
+40+45+51+42+67+9+43+=08) 5720 wp (497+453+589+332+449+421+499+449+533+551+=
422+525+=08)=20
# bounces: 12, mode: ver poll, userfaults: 157 missing (47+28+30+9+16+8+8+3=
+5+2+0+1+=08) 5073 wp (663+530+491+314+557+346+427+350+349+435+400+211+=08)=
=20
# bounces: 11, mode: rnd racing poll, userfaults: 353 missing (42+48+39+18+=
55+27+33+32+34+5+12+8+=08) 4940 wp (428+378+407+290+480+471+375+617+456+398=
+296+344+=08)=20
# bounces: 10, mode: racing poll, userfaults: 99 missing (21+22+11+21+4+3+2=
+10+2+3+0+0+=08) 3258 wp (280+338+355+260+246+298+203+346+184+246+228+274+=
=08)=20
# bounces: 9, mode: rnd poll, userfaults: 476 missing (39+97+36+47+54+28+42=
+60+30+18+15+10+=08) 4987 wp (292+505+390+406+471+442+428+517+337+448+369+3=
82+=08)=20
# bounces: 8, mode: poll, userfaults: 129 missing (32+21+16+19+14+9+7+2+3+3=
+3+0+=08) 4877 wp (471+578+403+406+439+434+466+421+367+392+235+265+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 547 missing (87+73+54+=
69+40+27+61+38+22+57+10+9+=08) 5470 wp (472+521+486+532+440+343+571+493+445=
+439+321+407+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 233 missing (37+46+15+9+22=
+23+21+14+13+13+8+12+=08) 4301 wp (473+522+274+347+447+326+323+356+268+423+=
283+259+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 580 missing (62+80+99+88+35+8=
7+35+44+14+12+12+12+=08) 5206 wp (579+393+440+617+544+438+462+371+339+331+3=
83+309+=08)=20
# bounces: 4, mode: ver read, userfaults: 270 missing (57+34+43+19+30+14+9+=
26+12+17+6+3+=08) 6541 wp (704+657+704+540+615+526+479+559+477+443+444+393+=
=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 412 missing (88+59+37+30+3=
3+60+27+34+11+16+14+3+=08) 5080 wp (523+476+402+418+540+501+366+420+363+380=
+426+265+=08)=20
# bounces: 2, mode: racing read, userfaults: 148 missing (28+19+22+15+18+13=
+3+6+8+9+1+6+=08) 4013 wp (261+374+436+351+389+315+256+367+302+313+266+383+=
=08)=20
# bounces: 1, mode: rnd read, userfaults: 577 missing (136+78+77+73+73+42+2=
6+24+10+19+8+11+=08) 5183 wp (549+462+359+513+506+373+496+426+359+497+312+3=
31+=08)=20
# bounces: 0, mode: read, userfaults: 66 missing (16+9+13+7+6+5+1+2+1+6+0+0=
+=08) 5945 wp (476+602+490+714+507+480+424+505+424+463+440+420+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5112 missing (5112+=08)=
 5112 wp (5112+=08)=20
# testing minor faults: userfaults: 5112 minor (5112+=08)
# [PASS]
# running: ./userfaultfd
# ------------------------------------
# running ./userfaultfd anon:dev 20 16
# ------------------------------------
# nr_pages: 5112, nr_pages_per_cpu: 426
# bounces: 15, mode: rnd racing ver poll, userfaults: 392 missing (55+57+88=
+31+30+38+15+16+18+15+29+0+=08) 2819 wp (269+220+327+222+239+272+168+183+28=
3+222+319+95+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 194 missing (42+25+15+11+=
7+25+12+20+10+9+14+4+=08) 1386 wp (177+144+127+85+82+143+128+135+107+56+101=
+101+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 364 missing (42+46+81+34+26+=
23+27+18+24+7+26+10+=08) 2271 wp (209+189+291+182+135+284+219+142+183+142+1=
82+113+=08)=20
# bounces: 12, mode: ver poll, userfaults: 166 missing (27+37+16+17+14+17+8=
+16+4+7+2+1+=08) 2972 wp (232+400+165+231+205+224+362+296+191+212+304+150+=
=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 369 missing (69+72+60+32+=
26+45+10+16+10+21+8+0+=08) 2510 wp (265+301+246+194+159+256+143+226+166+250=
+204+100+=08)=20
# bounces: 10, mode: racing poll, userfaults: 114 missing (12+29+16+16+12+1=
2+6+7+0+4+0+0+=08) 1187 wp (110+135+118+127+110+96+109+94+60+107+66+55+=08)=
=20
# bounces: 9, mode: rnd poll, userfaults: 324 missing (64+53+42+38+39+17+24=
+17+10+3+11+6+=08) 2326 wp (290+228+187+247+248+125+264+192+161+132+114+138=
+=08)=20
# bounces: 8, mode: poll, userfaults: 122 missing (37+24+18+5+10+8+3+7+5+1+=
2+2+=08) 2724 wp (312+347+303+213+139+165+181+254+193+261+228+128+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 647 missing (82+105+92=
+39+56+80+44+41+52+44+7+5+=08) 3974 wp (323+422+342+260+425+382+325+385+326=
+325+277+182+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 346 missing (81+54+36+52+2=
6+22+30+8+17+6+9+5+=08) 1433 wp (190+205+112+122+120+123+163+67+130+63+78+6=
0+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 525 missing (120+91+47+50+47+=
43+11+66+14+26+5+5+=08) 3767 wp (522+295+365+311+365+231+258+461+225+323+22=
6+185+=08)=20
# bounces: 4, mode: ver read, userfaults: 241 missing (40+38+22+32+16+22+21=
+19+12+9+8+2+=08) 4293 wp (372+479+369+496+303+308+394+368+397+277+259+271+=
=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 595 missing (115+62+104+87=
+79+38+41+28+17+14+5+5+=08) 3189 wp (398+261+382+326+388+272+268+215+180+18=
7+170+142+=08)=20
# bounces: 2, mode: racing read, userfaults: 266 missing (40+44+10+33+24+33=
+9+19+16+15+19+4+=08) 1628 wp (170+166+100+161+166+178+91+119+161+119+92+10=
5+=08)=20
# bounces: 1, mode: rnd read, userfaults: 591 missing (152+76+48+72+75+46+4=
9+43+13+12+2+3+=08) 3373 wp (530+324+278+298+363+216+341+396+148+191+126+16=
2+=08)=20
# bounces: 0, mode: read, userfaults: 52 missing (19+10+5+7+4+1+2+2+1+0+1+0=
+=08) 3183 wp (397+313+388+228+242+309+337+286+91+235+159+198+=08)=20
# testing uffd-wp with pagemap (pgsize=3D4096): done
# testing uffd-wp with pagemap (pgsize=3D2097152): done
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5112 missing (5112+=08)=
 5112 wp (5112+=08)=20
# [PASS]
# running: ./userfaultfd
# ----------------------------------------
# running ./userfaultfd hugetlb:dev 128 32
# ----------------------------------------
# nr_pages: 60, nr_pages_per_cpu: 5
# bounces: 31, mode: rnd racing ver poll, userfaults: 43 missing (14+12+6+5=
+4+2+0+0+0+0+0+0+=08) 136 wp (33+24+15+14+19+11+8+4+2+5+0+1+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 18 missing (5+7+4+0+1+0+1=
+0+0+0+0+0+=08) 235 wp (40+44+26+30+30+24+15+6+9+9+1+1+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 44 missing (15+11+9+5+3+1+0+=
0+0+0+0+0+=08) 138 wp (33+22+22+19+11+9+5+6+5+2+4+0+=08)=20
# bounces: 28, mode: ver poll, userfaults: 27 missing (10+2+4+5+2+1+1+1+0+1=
+0+0+=08) 214 wp (41+35+29+34+17+20+6+15+3+2+7+5+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 40 missing (16+9+7+5+3+0+=
0+0+0+0+0+0+=08) 127 wp (25+23+12+21+13+11+4+9+4+3+1+1+=08)=20
# bounces: 26, mode: racing poll, userfaults: 28 missing (7+11+2+2+1+3+1+1+=
0+0+0+0+=08) 219 wp (40+44+36+30+16+15+13+7+8+9+0+1+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 39 missing (12+10+8+5+4+0+0+0+0+=
0+0+0+=08) 141 wp (24+26+20+17+14+8+8+7+6+4+4+3+=08)=20
# bounces: 24, mode: poll, userfaults: 28 missing (9+5+3+1+4+4+1+0+1+0+0+0+=
=08) 222 wp (43+35+29+27+20+21+20+9+6+7+4+1+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 45 missing (18+11+12+=
2+2+0+0+0+0+0+0+0+=08) 133 wp (27+24+20+20+14+5+5+10+5+2+1+0+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 35 missing (10+4+7+3+5+4+=
1+0+0+1+0+0+=08) 253 wp (49+39+37+22+16+22+20+18+16+5+7+2+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 46 missing (17+12+8+8+0+1+0+=
0+0+0+0+0+=08) 146 wp (29+34+15+23+9+9+9+2+6+2+4+4+=08)=20
# bounces: 20, mode: ver read, userfaults: 38 missing (11+2+6+6+6+0+1+3+2+1=
+0+0+=08) 249 wp (38+43+28+32+24+19+20+17+17+7+3+1+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 43 missing (16+10+9+5+3+0=
+0+0+0+0+0+0+=08) 138 wp (24+27+23+20+14+9+4+6+3+5+1+2+=08)=20
# bounces: 18, mode: racing read, userfaults: 41 missing (10+7+5+8+1+2+4+1+=
2+1+0+0+=08) 224 wp (49+28+24+25+21+20+15+17+10+7+5+3+=08)=20
# bounces: 17, mode: rnd read, userfaults: 47 missing (17+12+9+5+4+0+0+0+0+=
0+0+0+=08) 153 wp (34+32+23+20+15+3+6+4+6+4+3+3+=08)=20
# bounces: 16, mode: read, userfaults: 43 missing (15+10+10+1+3+0+3+1+0+0+0=
+0+=08) 211 wp (32+30+34+29+19+17+12+15+12+8+3+0+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 47 missing (13+13+9+7=
+4+1+0+0+0+0+0+0+=08) 143 wp (25+29+24+17+19+8+6+3+6+4+0+2+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 38 missing (9+6+5+6+3+6+2=
+0+0+0+1+0+=08) 273 wp (49+32+38+26+28+31+17+19+14+9+6+4+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 44 missing (18+10+8+4+2+2+0+=
0+0+0+0+0+=08) 131 wp (31+26+11+13+16+14+9+2+4+2+0+3+=08)=20
# bounces: 12, mode: ver poll, userfaults: 39 missing (11+9+4+5+2+1+4+2+1+0=
+0+0+=08) 249 wp (47+28+28+23+23+22+26+17+18+13+3+1+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 42 missing (15+13+5+5+3+1=
+0+0+0+0+0+0+=08) 126 wp (25+25+23+17+13+7+6+1+6+1+2+0+=08)=20
# bounces: 10, mode: racing poll, userfaults: 34 missing (11+8+5+2+1+1+3+2+=
1+0+0+0+=08) 249 wp (32+35+24+32+25+25+19+17+17+11+10+2+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 41 missing (15+13+7+3+3+0+0+0+0+0=
+0+0+=08) 144 wp (35+23+24+15+16+10+6+6+4+3+1+1+=08)=20
# bounces: 8, mode: poll, userfaults: 35 missing (9+6+7+5+4+1+2+0+1+0+0+0+=
=08) 225 wp (37+37+39+20+23+24+14+8+9+9+2+3+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 42 missing (15+11+7+6+=
3+0+0+0+0+0+0+0+=08) 150 wp (21+28+25+20+20+9+4+6+7+6+3+1+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 43 missing (12+7+9+6+1+0+0=
+4+2+1+1+0+=08) 269 wp (45+40+33+27+25+26+17+22+13+10+7+4+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 44 missing (15+11+8+5+4+1+0+0=
+0+0+0+0+=08) 134 wp (25+25+22+25+12+8+0+5+2+4+1+5+=08)=20
# bounces: 4, mode: ver read, userfaults: 44 missing (12+5+12+2+6+2+3+1+1+0=
+0+0+=08) 303 wp (49+45+32+17+37+28+18+22+15+10+20+10+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 45 missing (16+12+8+6+3+0+=
0+0+0+0+0+0+=08) 144 wp (34+22+24+21+14+7+8+4+6+1+1+2+=08)=20
# bounces: 2, mode: racing read, userfaults: 44 missing (14+6+5+5+6+2+3+1+1=
+1+0+0+=08) 302 wp (48+32+34+34+33+27+22+17+14+12+19+10+=08)=20
# bounces: 1, mode: rnd read, userfaults: 44 missing (15+13+6+6+4+0+0+0+0+0=
+0+0+=08) 142 wp (26+21+23+25+10+13+3+5+3+3+7+3+=08)=20
# bounces: 0, mode: read, userfaults: 51 missing (13+10+7+3+5+3+5+0+4+1+0+0=
+=08) 423 wp (53+49+53+57+38+30+42+19+41+21+16+4+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 60 missing (60+=08) 60 =
wp (60+=08)=20
# [PASS]
# running: ./userfaultfd
# -----------------------------------------------
# running ./userfaultfd hugetlb_shared:dev 128 32
# -----------------------------------------------
# nr_pages: 60, nr_pages_per_cpu: 5
# bounces: 31, mode: rnd racing ver poll, userfaults: 41 missing (13+8+10+6=
+2+1+1+0+0+0+0+0+=08) 128 wp (29+22+19+7+20+11+7+5+3+3+1+1+=08)=20
# bounces: 30, mode: racing ver poll, userfaults: 15 missing (5+7+1+0+0+1+1=
+0+0+0+0+0+=08) 219 wp (35+35+35+22+29+13+9+19+10+6+4+2+=08)=20
# bounces: 29, mode: rnd ver poll, userfaults: 38 missing (11+10+7+5+4+1+0+=
0+0+0+0+0+=08) 135 wp (23+19+17+20+18+14+13+6+4+1+0+0+=08)=20
# bounces: 28, mode: ver poll, userfaults: 18 missing (9+5+3+0+0+1+0+0+0+0+=
0+0+=08) 215 wp (36+30+43+22+18+11+19+13+9+5+8+1+=08)=20
# bounces: 27, mode: rnd racing poll, userfaults: 39 missing (18+5+6+6+3+1+=
0+0+0+0+0+0+=08) 141 wp (27+28+20+18+18+9+8+3+5+0+4+1+=08)=20
# bounces: 26, mode: racing poll, userfaults: 21 missing (10+1+4+2+1+2+0+0+=
1+0+0+0+=08) 228 wp (45+35+37+29+22+13+19+11+7+8+2+0+=08)=20
# bounces: 25, mode: rnd poll, userfaults: 40 missing (12+13+5+4+3+3+0+0+0+=
0+0+0+=08) 145 wp (32+29+21+21+9+13+5+6+5+2+0+2+=08)=20
# bounces: 24, mode: poll, userfaults: 22 missing (5+3+3+4+2+3+1+0+1+0+0+0+=
=08) 207 wp (32+28+31+30+21+13+16+11+11+5+5+4+=08)=20
# bounces: 23, mode: rnd racing ver read, userfaults: 40 missing (11+10+7+8=
+3+1+0+0+0+0+0+0+=08) 140 wp (35+17+18+12+17+6+13+12+6+2+2+0+=08)=20
# bounces: 22, mode: racing ver read, userfaults: 25 missing (8+3+6+2+2+1+0=
+3+0+0+0+0+=08) 227 wp (43+40+33+19+17+26+8+12+13+9+3+4+=08)=20
# bounces: 21, mode: rnd ver read, userfaults: 43 missing (14+14+9+5+1+0+0+=
0+0+0+0+0+=08) 141 wp (31+27+20+19+5+14+10+5+4+3+1+2+=08)=20
# bounces: 20, mode: ver read, userfaults: 31 missing (10+3+8+4+0+2+2+1+1+0=
+0+0+=08) 221 wp (45+32+25+28+18+21+13+13+10+7+6+3+=08)=20
# bounces: 19, mode: rnd racing read, userfaults: 44 missing (17+6+8+3+6+1+=
3+0+0+0+0+0+=08) 133 wp (26+26+12+23+12+12+7+5+2+3+2+3+=08)=20
# bounces: 18, mode: racing read, userfaults: 16 missing (3+1+6+4+1+1+0+0+0=
+0+0+0+=08) 241 wp (42+34+37+30+26+24+15+13+9+5+4+2+=08)=20
# bounces: 17, mode: rnd read, userfaults: 44 missing (16+11+9+5+2+1+0+0+0+=
0+0+0+=08) 135 wp (24+24+18+21+16+8+9+8+2+3+1+1+=08)=20
# bounces: 16, mode: read, userfaults: 39 missing (13+6+5+5+2+5+0+1+1+0+1+0=
+=08) 214 wp (35+31+25+25+18+20+22+6+18+5+7+2+=08)=20
# bounces: 15, mode: rnd racing ver poll, userfaults: 42 missing (11+11+7+6=
+4+3+0+0+0+0+0+0+=08) 122 wp (28+19+17+12+12+15+5+4+5+3+2+0+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 24 missing (11+3+3+1+0+4+=
1+0+1+0+0+0+=08) 269 wp (44+30+30+28+27+26+23+18+18+13+6+6+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 42 missing (15+9+6+8+3+0+1+0=
+0+0+0+0+=08) 138 wp (26+25+21+11+21+10+7+4+6+3+2+2+=08)=20
# bounces: 12, mode: ver poll, userfaults: 23 missing (8+8+3+2+1+0+0+0+0+0+=
1+0+=08) 233 wp (31+38+32+25+26+20+18+9+12+9+8+5+=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 40 missing (9+11+6+8+3+3+=
0+0+0+0+0+0+=08) 128 wp (26+19+19+17+13+9+10+6+6+1+0+2+=08)=20
# bounces: 10, mode: racing poll, userfaults: 26 missing (7+7+4+1+1+2+3+0+1=
+0+0+0+=08) 247 wp (34+36+27+28+24+19+23+16+17+10+7+6+=08)=20
# bounces: 9, mode: rnd poll, userfaults: 41 missing (14+8+8+5+3+2+1+0+0+0+=
0+0+=08) 133 wp (23+30+21+14+15+10+8+3+4+2+2+1+=08)=20
# bounces: 8, mode: poll, userfaults: 32 missing (11+9+3+2+1+2+2+1+1+0+0+0+=
=08) 277 wp (42+33+29+38+27+26+23+24+13+12+6+4+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 43 missing (11+10+8+7+=
5+1+0+1+0+0+0+0+=08) 135 wp (24+23+15+13+19+17+9+3+4+1+4+3+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 37 missing (9+9+6+4+3+0+1+=
5+0+0+0+0+=08) 303 wp (35+36+43+32+29+35+24+22+13+14+10+10+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 41 missing (13+9+8+6+4+1+0+0+=
0+0+0+0+=08) 133 wp (28+23+19+20+13+13+5+4+4+0+2+2+=08)=20
# bounces: 4, mode: ver read, userfaults: 37 missing (7+13+6+4+1+4+1+1+0+0+=
0+0+=08) 266 wp (43+34+33+34+26+25+16+13+10+15+12+5+=08)=20
# bounces: 3, mode: rnd racing read, userfaults: 42 missing (14+9+8+6+3+2+0=
+0+0+0+0+0+=08) 138 wp (22+19+28+19+12+14+10+4+6+3+1+0+=08)=20
# bounces: 2, mode: racing read, userfaults: 36 missing (14+4+6+4+3+1+0+1+2=
+0+1+0+=08) 268 wp (38+37+33+36+24+23+21+17+13+11+7+8+=08)=20
# bounces: 1, mode: rnd read, userfaults: 44 missing (13+11+9+7+4+0+0+0+0+0=
+0+0+=08) 140 wp (20+22+31+14+18+14+2+7+4+4+2+2+=08)=20
# bounces: 0, mode: read, userfaults: 41 missing (8+6+6+6+5+5+0+2+0+3+0+0+=
=08) 255 wp (32+32+33+29+32+21+15+16+23+8+10+4+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 60 missing (60+=08) 60 =
wp (60+=08)=20
# testing minor faults: userfaults: 60 minor (60+=08)
# [PASS]
# running: ./userfaultfd
# -------------------------------------
# running ./userfaultfd shmem:dev 20 16
# -------------------------------------
# nr_pages: 5112, nr_pages_per_cpu: 426
# bounces: 15, mode: rnd racing ver poll, userfaults: 404 missing (55+38+35=
+62+32+46+53+17+29+35+2+0+=08) 5015 wp (424+404+475+540+398+573+452+395+348=
+490+271+245+=08)=20
# bounces: 14, mode: racing ver poll, userfaults: 87 missing (23+12+13+6+5+=
5+9+10+0+2+1+1+=08) 3685 wp (330+281+228+323+312+368+364+346+230+352+260+29=
1+=08)=20
# bounces: 13, mode: rnd ver poll, userfaults: 343 missing (55+46+32+57+43+=
16+32+21+18+9+12+2+=08) 4480 wp (324+492+368+340+357+458+439+397+371+322+38=
3+229+=08)=20
# bounces: 12, mode: ver poll, userfaults: 194 missing (37+34+35+23+13+5+16=
+7+7+10+7+0+=08) 5116 wp (441+543+480+525+378+482+298+312+423+464+457+313+=
=08)=20
# bounces: 11, mode: rnd racing poll, userfaults: 435 missing (62+59+73+62+=
28+50+21+28+29+13+5+5+=08) 4826 wp (383+461+463+405+427+496+371+368+427+342=
+333+350+=08)=20
# bounces: 10, mode: racing poll, userfaults: 99 missing (19+21+17+16+11+0+=
11+1+1+2+0+0+=08) 3002 wp (172+292+263+367+280+140+355+183+279+241+154+276+=
=08)=20
# bounces: 9, mode: rnd poll, userfaults: 396 missing (60+57+52+36+49+50+26=
+13+11+12+17+13+=08) 5396 wp (483+458+275+442+564+564+380+520+460+442+435+3=
73+=08)=20
# bounces: 8, mode: poll, userfaults: 113 missing (31+26+14+15+6+10+3+3+2+2=
+0+1+=08) 4779 wp (513+383+434+522+492+547+393+281+307+362+252+293+=08)=20
# bounces: 7, mode: rnd racing ver read, userfaults: 480 missing (103+68+59=
+58+35+52+18+48+12+24+2+1+=08) 5094 wp (439+600+342+534+377+569+362+519+234=
+491+305+322+=08)=20
# bounces: 6, mode: racing ver read, userfaults: 130 missing (39+14+25+13+8=
+11+12+1+4+3+0+0+=08) 4241 wp (488+347+345+276+317+280+420+334+352+382+338+=
362+=08)=20
# bounces: 5, mode: rnd ver read, userfaults: 594 missing (116+109+107+47+5=
1+44+51+27+11+7+14+10+=08) 4788 wp (488+497+452+397+362+398+405+380+322+309=
+418+360+=08)=20
# bounces: 4, mode: ver read, userfaults: 117 missing (35+27+21+12+8+6+2+2+=
2+1+1+0+=08) 5218 wp (489+766+623+554+485+382+301+400+517+278+257+166+=08)=
=20
# bounces: 3, mode: rnd racing read, userfaults: 418 missing (71+73+51+42+2=
2+37+49+25+7+19+14+8+=08) 5019 wp (491+529+464+402+408+456+465+391+268+413+=
322+410+=08)=20
# bounces: 2, mode: racing read, userfaults: 348 missing (53+31+14+49+36+32=
+37+11+29+25+30+1+=08) 4188 wp (334+323+252+384+408+383+399+268+424+360+362=
+291+=08)=20
# bounces: 1, mode: rnd read, userfaults: 642 missing (124+48+64+73+63+81+4=
8+48+34+48+11+0+=08) 5746 wp (576+409+439+525+474+521+574+523+569+468+342+3=
26+=08)=20
# bounces: 0, mode: read, userfaults: 120 missing (28+17+11+12+11+8+9+11+5+=
6+1+1+=08) 6743 wp (771+554+585+552+700+551+592+655+448+419+450+466+=08)=20
# testing UFFDIO_ZEROPAGE: done.
# testing signal delivery: done.
# testing events (fork, remap, remove): userfaults: 5112 missing (5112+=08)=
 5112 wp (5112+=08)=20
# testing minor faults: userfaults: 5112 minor (5112+=08)
# [PASS]
# running: ./compaction_test
# -------------------------
# running ./compaction_test
# -------------------------
# No of huge pages allocated =3D 2500
# [PASS]
# running: sudo
# ---------------------------------------
# running sudo -u nobody ./on-fault-limit
# ---------------------------------------
# [PASS]
# running: ./map_populate
# ----------------------
# running ./map_populate
# ----------------------
# [PASS]
# running: ./mlock-random-test
# ---------------------------
# running ./mlock-random-test
# ---------------------------
# [PASS]
# running: ./mlock2-tests
# ----------------------
# running ./mlock2-tests
# ----------------------
# [PASS]
# running: ./mrelease_test
# -----------------------
# running ./mrelease_test
# -----------------------
# process_mrelease with wrong pidfd: Function not implemented
# [SKIP]
# running: ./mremap_test
# ---------------------
# running ./mremap_test
# ---------------------
# # Test configs:
# 	threshold_mb=3D4
# 	pattern_seed=3D1667564931
#=20
# 1..14
# # mremap failed: Invalid argument
# ok 1 # XFAIL mremap - Source and Destination Regions Overlapping
# 	Expected mremap failure
# # mremap failed: Invalid argument
# ok 2 # XFAIL mremap - Destination Address Misaligned (1KB-aligned)
# 	Expected mremap failure
# # Failed to map source region: Invalid argument
# ok 3 # XFAIL mremap - Source Address Misaligned (1KB-aligned)
# 	Expected mremap failure
# ok 4 8KB mremap - Source PTE-aligned, Destination PTE-aligned
# 	mremap time:       104212ns
# ok 5 2MB mremap - Source 1MB-aligned, Destination PTE-aligned
# 	mremap time:       130698ns
# ok 6 2MB mremap - Source 1MB-aligned, Destination 1MB-aligned
# 	mremap time:       134469ns
# ok 7 4MB mremap - Source PMD-aligned, Destination PTE-aligned
# 	mremap time:       145593ns
# ok 8 4MB mremap - Source PMD-aligned, Destination 1MB-aligned
# 	mremap time:       154008ns
# ok 9 4MB mremap - Source PMD-aligned, Destination PMD-aligned
# 	mremap time:       205255ns
# ok 10 2GB mremap - Source PUD-aligned, Destination PTE-aligned
# ok 11 2GB mremap - Source PUD-aligned, Destination 1MB-aligned
# ok 12 2GB mremap - Source PUD-aligned, Destination PMD-aligned
# ok 13 2GB mremap - Source PUD-aligned, Destination PUD-aligned
# not ok 14 mremap expand merge
# # Totals: pass:10 fail:1 xfail:3 xpass:0 skip:0 error:0
# [PASS]
# running: ./thuge-gen
# -------------------
# running ./thuge-gen
# -------------------
# Found 1024MB
# Found 2MB
# Not enough huge pages for page size 1024 MB, need 4
# [PASS]
# running: ./virtual_address_range
# -------------------------------
# running ./virtual_address_range
# -------------------------------
# [PASS]
# running: ./va_128TBswitch.sh
# ---------------------------
# running ./va_128TBswitch.sh
# ---------------------------
# mmap(ADDR_SWITCH_HINT - PAGE_SIZE, PAGE_SIZE): 0x7fc8d754f000 - OK
# mmap(ADDR_SWITCH_HINT - PAGE_SIZE, (2 * PAGE_SIZE)): 0x7fc8d754e000 - OK
# mmap(ADDR_SWITCH_HINT, PAGE_SIZE): 0x7fc8d754f000 - OK
# mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FA=
ILED
# mmap(NULL): 0x7fc8d754d000 - OK
# mmap(LOW_ADDR): 0x40000000 - OK
# mmap(HIGH_ADDR): 0x7fc8d754d000 - OK
# mmap(HIGH_ADDR) again: 0x7fc8d754b000 - OK
# mmap(HIGH_ADDR, MAP_FIXED): 0xffffffffffffffff - FAILED
# mmap(-1): 0x7fc8d7549000 - OK
# mmap(-1) again: 0x7fc8d7340000 - OK
# mmap(ADDR_SWITCH_HINT - PAGE_SIZE, PAGE_SIZE): 0x7fc8d7548000 - OK
# mmap(ADDR_SWITCH_HINT - PAGE_SIZE, 2 * PAGE_SIZE): 0x7fc8d7340000 - OK
# mmap(ADDR_SWITCH_HINT - PAGE_SIZE/2 , 2 * PAGE_SIZE): 0x7fc8d733e000 - OK
# mmap(ADDR_SWITCH_HINT, PAGE_SIZE): 0x7fc8d7548000 - OK
# mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FA=
ILED
# [FAIL]
# running: ./test_vmalloc.sh
# -------------------------------
# running ./test_vmalloc.sh smoke
# -------------------------------
# Run smoke test. Note, this test provides basic coverage.
# Please check ./test_vmalloc.sh output how it can be used
# for deep performance analysis as well as stress testing.
# Done.
# Check the kernel ring buffer to see the summary.
# [PASS]
# running: ./mremap_dontunmap
# --------------------------
# running ./mremap_dontunmap
# --------------------------
# OK
# [PASS]
# running: ./test_hmm.sh
# ---------------------------
# running ./test_hmm.sh smoke
# ---------------------------
# Running smoke test. Note, this test provides basic coverage.
# TAP version 13
# 1..56
# # Starting 56 tests from 5 test cases.
# #  RUN           hmm.hmm_device_private.open_close ...
# #            OK  hmm.hmm_device_private.open_close
# ok 1 hmm.hmm_device_private.open_close
# #  RUN           hmm.hmm_device_private.anon_read ...
# #            OK  hmm.hmm_device_private.anon_read
# ok 2 hmm.hmm_device_private.anon_read
# #  RUN           hmm.hmm_device_private.anon_read_prot ...
# #            OK  hmm.hmm_device_private.anon_read_prot
# ok 3 hmm.hmm_device_private.anon_read_prot
# #  RUN           hmm.hmm_device_private.anon_write ...
# #            OK  hmm.hmm_device_private.anon_write
# ok 4 hmm.hmm_device_private.anon_write
# #  RUN           hmm.hmm_device_private.anon_write_prot ...
# #            OK  hmm.hmm_device_private.anon_write_prot
# ok 5 hmm.hmm_device_private.anon_write_prot
# #  RUN           hmm.hmm_device_private.anon_write_child ...
# #            OK  hmm.hmm_device_private.anon_write_child
# ok 6 hmm.hmm_device_private.anon_write_child
# #  RUN           hmm.hmm_device_private.anon_write_child_shared ...
# #            OK  hmm.hmm_device_private.anon_write_child_shared
# ok 7 hmm.hmm_device_private.anon_write_child_shared
# #  RUN           hmm.hmm_device_private.anon_write_huge ...
# #            OK  hmm.hmm_device_private.anon_write_huge
# ok 8 hmm.hmm_device_private.anon_write_huge
# #  RUN           hmm.hmm_device_private.anon_write_hugetlbfs ...
# #            OK  hmm.hmm_device_private.anon_write_hugetlbfs
# ok 9 hmm.hmm_device_private.anon_write_hugetlbfs
# #  RUN           hmm.hmm_device_private.file_read ...
# #            OK  hmm.hmm_device_private.file_read
# ok 10 hmm.hmm_device_private.file_read
# #  RUN           hmm.hmm_device_private.file_write ...
# #            OK  hmm.hmm_device_private.file_write
# ok 11 hmm.hmm_device_private.file_write
# #  RUN           hmm.hmm_device_private.migrate ...
# #            OK  hmm.hmm_device_private.migrate
# ok 12 hmm.hmm_device_private.migrate
# #  RUN           hmm.hmm_device_private.migrate_fault ...
# #            OK  hmm.hmm_device_private.migrate_fault
# ok 13 hmm.hmm_device_private.migrate_fault
# #  RUN           hmm.hmm_device_private.migrate_release ...
# #            OK  hmm.hmm_device_private.migrate_release
# ok 14 hmm.hmm_device_private.migrate_release
# #  RUN           hmm.hmm_device_private.migrate_shared ...
# #            OK  hmm.hmm_device_private.migrate_shared
# ok 15 hmm.hmm_device_private.migrate_shared
# #  RUN           hmm.hmm_device_private.migrate_multiple ...
# #            OK  hmm.hmm_device_private.migrate_multiple
# ok 16 hmm.hmm_device_private.migrate_multiple
# #  RUN           hmm.hmm_device_private.anon_read_multiple ...
# #            OK  hmm.hmm_device_private.anon_read_multiple
# ok 17 hmm.hmm_device_private.anon_read_multiple
# #  RUN           hmm.hmm_device_private.anon_teardown ...
# #            OK  hmm.hmm_device_private.anon_teardown
# ok 18 hmm.hmm_device_private.anon_teardown
# #  RUN           hmm.hmm_device_private.mixedmap ...
# #            OK  hmm.hmm_device_private.mixedmap
# ok 19 hmm.hmm_device_private.mixedmap
# #  RUN           hmm.hmm_device_private.compound ...
# #            OK  hmm.hmm_device_private.compound
# ok 20 hmm.hmm_device_private.compound
# #  RUN           hmm.hmm_device_private.exclusive ...
# #            OK  hmm.hmm_device_private.exclusive
# ok 21 hmm.hmm_device_private.exclusive
# #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
# #            OK  hmm.hmm_device_private.exclusive_mprotect
# ok 22 hmm.hmm_device_private.exclusive_mprotect
# #  RUN           hmm.hmm_device_private.exclusive_cow ...
# #            OK  hmm.hmm_device_private.exclusive_cow
# ok 23 hmm.hmm_device_private.exclusive_cow
# #  RUN           hmm.hmm_device_private.hmm_gup_test ...
# #            OK  hmm.hmm_device_private.hmm_gup_test
# ok 24 hmm.hmm_device_private.hmm_gup_test
# #  RUN           hmm.hmm_device_private.hmm_cow_in_device ...
# #            OK  hmm.hmm_device_private.hmm_cow_in_device
# ok 25 hmm.hmm_device_private.hmm_cow_in_device
# #  RUN           hmm.hmm_device_coherent.open_close ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.open_close
# ok 26 hmm.hmm_device_coherent.open_close
# #  RUN           hmm.hmm_device_coherent.anon_read ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_read
# ok 27 hmm.hmm_device_coherent.anon_read
# #  RUN           hmm.hmm_device_coherent.anon_read_prot ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_read_prot
# ok 28 hmm.hmm_device_coherent.anon_read_prot
# #  RUN           hmm.hmm_device_coherent.anon_write ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_write
# ok 29 hmm.hmm_device_coherent.anon_write
# #  RUN           hmm.hmm_device_coherent.anon_write_prot ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_write_prot
# ok 30 hmm.hmm_device_coherent.anon_write_prot
# #  RUN           hmm.hmm_device_coherent.anon_write_child ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_write_child
# ok 31 hmm.hmm_device_coherent.anon_write_child
# #  RUN           hmm.hmm_device_coherent.anon_write_child_shared ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_write_child_shared
# ok 32 hmm.hmm_device_coherent.anon_write_child_shared
# #  RUN           hmm.hmm_device_coherent.anon_write_huge ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_write_huge
# ok 33 hmm.hmm_device_coherent.anon_write_huge
# #  RUN           hmm.hmm_device_coherent.anon_write_hugetlbfs ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_write_hugetlbfs
# ok 34 hmm.hmm_device_coherent.anon_write_hugetlbfs
# #  RUN           hmm.hmm_device_coherent.file_read ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.file_read
# ok 35 hmm.hmm_device_coherent.file_read
# #  RUN           hmm.hmm_device_coherent.file_write ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.file_write
# ok 36 hmm.hmm_device_coherent.file_write
# #  RUN           hmm.hmm_device_coherent.migrate ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.migrate
# ok 37 hmm.hmm_device_coherent.migrate
# #  RUN           hmm.hmm_device_coherent.migrate_fault ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.migrate_fault
# ok 38 hmm.hmm_device_coherent.migrate_fault
# #  RUN           hmm.hmm_device_coherent.migrate_release ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.migrate_release
# ok 39 hmm.hmm_device_coherent.migrate_release
# #  RUN           hmm.hmm_device_coherent.migrate_shared ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.migrate_shared
# ok 40 hmm.hmm_device_coherent.migrate_shared
# #  RUN           hmm.hmm_device_coherent.migrate_multiple ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.migrate_multiple
# ok 41 hmm.hmm_device_coherent.migrate_multiple
# #  RUN           hmm.hmm_device_coherent.anon_read_multiple ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_read_multiple
# ok 42 hmm.hmm_device_coherent.anon_read_multiple
# #  RUN           hmm.hmm_device_coherent.anon_teardown ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.anon_teardown
# ok 43 hmm.hmm_device_coherent.anon_teardown
# #  RUN           hmm.hmm_device_coherent.mixedmap ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.mixedmap
# ok 44 hmm.hmm_device_coherent.mixedmap
# #  RUN           hmm.hmm_device_coherent.compound ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.compound
# ok 45 hmm.hmm_device_coherent.compound
# #  RUN           hmm.hmm_device_coherent.exclusive ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.exclusive
# ok 46 hmm.hmm_device_coherent.exclusive
# #  RUN           hmm.hmm_device_coherent.exclusive_mprotect ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.exclusive_mprotect
# ok 47 hmm.hmm_device_coherent.exclusive_mprotect
# #  RUN           hmm.hmm_device_coherent.exclusive_cow ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.exclusive_cow
# ok 48 hmm.hmm_device_coherent.exclusive_cow
# #  RUN           hmm.hmm_device_coherent.hmm_gup_test ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.hmm_gup_test
# ok 49 hmm.hmm_device_coherent.hmm_gup_test
# #  RUN           hmm.hmm_device_coherent.hmm_cow_in_device ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm.hmm_device_coherent.hmm_cow_in_device
# ok 50 hmm.hmm_device_coherent.hmm_cow_in_device
# #  RUN           hmm2.hmm2_device_private.migrate_mixed ...
# #            OK  hmm2.hmm2_device_private.migrate_mixed
# ok 51 hmm2.hmm2_device_private.migrate_mixed
# #  RUN           hmm2.hmm2_device_private.snapshot ...
# #            OK  hmm2.hmm2_device_private.snapshot
# ok 52 hmm2.hmm2_device_private.snapshot
# #  RUN           hmm2.hmm2_device_private.double_map ...
# #            OK  hmm2.hmm2_device_private.double_map
# ok 53 hmm2.hmm2_device_private.double_map
# #  RUN           hmm2.hmm2_device_coherent.migrate_mixed ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm2.hmm2_device_coherent.migrate_mixed
# ok 54 hmm2.hmm2_device_coherent.migrate_mixed
# #  RUN           hmm2.hmm2_device_coherent.snapshot ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm2.hmm2_device_coherent.snapshot
# ok 55 hmm2.hmm2_device_coherent.snapshot
# #  RUN           hmm2.hmm2_device_coherent.double_map ...
# could not open hmm dmirror driver (/dev/hmm_dmirror2)
# #      SKIP      DEVICE_COHERENT not available
# #            OK  hmm2.hmm2_device_coherent.double_map
# ok 56 hmm2.hmm2_device_coherent.double_map
# # PASSED: 56 / 56 tests passed.
# # Totals: pass:56 fail:0 xfail:0 xpass:0 skip:0 error:0
# [PASS]
# running: ./madv_populate
# -----------------------
# running ./madv_populate
# -----------------------
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
# [PASS]
# running: ./memfd_secret
# ----------------------
# running ./memfd_secret
# ----------------------
# page_size: 4096, mlock.soft: 8388608, mlock.hard: 8388608
# TAP version 13
# 1..4
# ok 2 # SKIP memfd_secret is not supported
# # Planned tests !=3D run tests (4 !=3D 1)
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
# [SKIP]
# running: ./ksm_tests
# ----------------------------
# running ./ksm_tests -M -p 10
# ----------------------------
# OK
# [PASS]
# running: ./ksm_tests
# ----------------------
# running ./ksm_tests -U
# ----------------------
# OK
# [PASS]
# running: ./ksm_tests
# ---------------------------------
# running ./ksm_tests -Z -p 10 -z 0
# ---------------------------------
# OK
# [PASS]
# running: ./ksm_tests
# ---------------------------------
# running ./ksm_tests -Z -p 10 -z 1
# ---------------------------------
# OK
# [PASS]
# running: ./ksm_tests
# ---------------------------
# running ./ksm_tests -N -m 1
# ---------------------------
# At least 2 NUMA nodes must be available
# [SKIP]
# running: ./ksm_tests
# ---------------------------
# running ./ksm_tests -N -m 0
# ---------------------------
# At least 2 NUMA nodes must be available
# [SKIP]
# running: ./ksm_functional_tests
# ------------------------------
# running ./ksm_functional_tests
# ------------------------------
# TAP version 13
# 1..3
# # [RUN] test_unmerge
# ok 1 Pages were unmerged
# # [RUN] test_unmerge_discarded
# ok 2 Pages were unmerged
# # [RUN] test_unmerge_uffd_wp
# ok 3 Pages were unmerged
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# [PASS]
# running: ./protection_keys_32
# ----------------------------
# running ./protection_keys_32
# ----------------------------
# has pkeys: 0
# running PKEY tests for unsupported CPU/OS
# [PASS]
# running: ./protection_keys_64
# ----------------------------
# running ./protection_keys_64
# ----------------------------
# has pkeys: 0
# running PKEY tests for unsupported CPU/OS
# [PASS]
# running: ./soft-dirty
# --------------------
# running ./soft-dirty
# --------------------
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
# [PASS]
# running: ./anon_cow
# ------------------
# running ./anon_cow
# ------------------
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# ok 27 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out THP
# ok 28 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with P=
TE-mapped THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# ok 27 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out THP
# ok 28 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with P=
TE-mapped THP
# ok 29 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out, PTE-mapped THP
# ok 30 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# ok 27 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out THP
# ok 28 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with P=
TE-mapped THP
# ok 29 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out, PTE-mapped THP
# ok 30 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of THP
# ok 31 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of swapped-out THP
# ok 32 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially mremap()'ed THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# ok 27 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out THP
# ok 28 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with P=
TE-mapped THP
# ok 29 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out, PTE-mapped THP
# ok 30 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of THP
# ok 31 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of swapped-out THP
# ok 32 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially mremap()'ed THP
# ok 33 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially shared THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# ok 27 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out THP
# ok 28 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with P=
TE-mapped THP
# ok 29 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out, PTE-mapped THP
# ok 30 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of THP
# ok 31 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of swapped-out THP
# ok 32 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially mremap()'ed THP
# ok 33 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially shared THP
# # [INFO] detected THP size: 2048 KiB
# # [INFO] detected hugetlb size: 2048 KiB
# # [INFO] detected hugetlb size: 1048576 KiB
# TAP version 13
# 1..120
# # [RUN] Basic COW after fork() ... with base page
# ok 1 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped out base page
# ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with THP
# ok 3 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out THP
# ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with PTE-mapped THP
# ok 5 No leak from parent into child
# # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
# ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with single PTE of THP
# ok 7 No leak from parent into child
# # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP
# ok 8 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] Basic COW after fork() ... with partially mremap()'ed THP
# ok 9 No leak from parent into child
# # [RUN] Basic COW after fork() ... with partially shared THP
# ok 10 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (2048 kB)
# ok 11 No leak from parent into child
# # [RUN] Basic COW after fork() ... with hugetlb (1048576 kB)
# ok 12 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in child ... with base page
# ok 13 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped out base page
# ok 14 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with THP
# ok 15 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out THP
# ok 16 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP
# ok 17 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
# ok 18 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with single PTE of THP
# ok 19 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with single PTE of swapped-out TH=
P
# ok 20 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in child ... with partially mremap()'ed THP
# ok 21 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with partially shared THP
# ok 22 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
# not ok 23 No leak from parent into child
# # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
# ok 24 # SKIP need more free huge pages
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with b=
ase page
# ok 25 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped out base page
# ok 26 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with T=
HP
# ok 27 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out THP
# ok 28 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with P=
TE-mapped THP
# ok 29 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
wapped-out, PTE-mapped THP
# ok 30 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of THP
# ok 31 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with s=
ingle PTE of swapped-out THP
# ok 32 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially mremap()'ed THP
# ok 33 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with p=
artially shared THP
# ok 34 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (2048 kB)
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# ok 58 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (2048 kB)
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# ok 58 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (2048 kB)
# ok 59 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (1048576 k=
B)
# ok 60 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with base page
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# ok 58 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (2048 kB)
# ok 59 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (1048576 k=
B)
# ok 60 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with base page
# ok 61 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped out b=
ase page
# ok 62 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# ok 58 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (2048 kB)
# ok 59 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (1048576 k=
B)
# ok 60 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with base page
# ok 61 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped out b=
ase page
# ok 62 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with THP
# ok 63 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped-out T=
HP
# ok 64 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with PTE-mapped TH=
P
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# ok 58 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (2048 kB)
# ok 59 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (1048576 k=
B)
# ok 60 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with base page
# ok 61 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped out b=
ase page
# ok 62 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with THP
# ok 63 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped-out T=
HP
# ok 64 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with PTE-mapped TH=
P
# ok 65 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped-out, =
PTE-mapped THP
# ok 66 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with single PTE of=
 THP
# with hugetlb (2048 kB)
# not ok 35 No leak from child into parent
# # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with h=
ugetlb (1048576 kB)
# ok 36 # SKIP need more free huge pages
# # [RUN] vmsplice() + unmap in parent after fork() ... with base page
# ok 37 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped out ba=
se page
# ok 38 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with THP
# ok 39 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out TH=
P
# ok 40 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with PTE-mapped THP
# ok 41 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with swapped-out, P=
TE-mapped THP
# ok 42 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
THP
# ok 43 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with single PTE of =
swapped-out THP
# ok 44 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially mrem=
ap()'ed THP
# ok 45 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with partially shar=
ed THP
# ok 46 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 =
kB)
# not ok 47 No leak from child into parent
# # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (10485=
76 kB)
# ok 48 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with base page
# ok 49 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped out base p=
age
# ok 50 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with THP
# ok 51 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out THP
# ok 52 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with PTE-mapped THP
# ok 53 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-m=
apped THP
# ok 54 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of THP
# ok 55 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with single PTE of swap=
ped-out THP
# ok 56 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially mremap()=
'ed THP
# ok 57 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with partially shared T=
HP
# ok 58 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (2048 kB)
# ok 59 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped shared page ... with hugetlb (1048576 k=
B)
# ok 60 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with base page
# ok 61 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped out b=
ase page
# ok 62 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with THP
# ok 63 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped-out T=
HP
# ok 64 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with PTE-mapped TH=
P
# ok 65 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with swapped-out, =
PTE-mapped THP
# ok 66 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with single PTE of=
 THP
# ok 67 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with single PTE of=
 swapped-out THP
# ok 68 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially mre=
map()'ed THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ok 89 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out, PTE-mapped THP
# ok 90 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ok 89 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out, PTE-mapped THP
# ok 90 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of THP
# ok 91 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of swapped-out THP
# ok 92 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially mremap()'ed THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ok 89 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out, PTE-mapped THP
# ok 90 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of THP
# ok 91 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of swapped-out THP
# ok 92 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially mremap()'ed THP
# ok 93 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially shared THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ok 89 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out, PTE-mapped THP
# ok 90 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of THP
# ok 91 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of swapped-out THP
# ok 92 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially mremap()'ed THP
# ok 93 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially shared THP
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ok 89 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out, PTE-mapped THP
# ok 90 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of THP
# ok 91 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of swapped-out THP
# ok 92 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially mremap()'ed THP
# ok 93 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially shared THP
# ok 94 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with hu=
getlb (2048 kB)
# ared page ... with partially mremap()'ed THP
# ok 69 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with partially sha=
red THP
# ok 70 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (2048=
 kB)
# ok 71 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped shared page ... with hugetlb (1048=
576 kB)
# ok 72 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with base pa=
ge
# ok 73 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
 out base page
# ok 74 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with THP
# ok 75 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out THP
# ok 76 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with PTE-map=
ped THP
# ok 77 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with swapped=
-out, PTE-mapped THP
# ok 78 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of THP
# ok 79 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with single =
PTE of swapped-out THP
# ok 80 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly mremap()'ed THP
# ok 81 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with partial=
ly shared THP
# ok 82 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (2048 kB)
# ok 83 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped previously-shared page ... with hugetlb=
 (1048576 kB)
# ok 84 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with ba=
se page
# ok 85 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped out base page
# ok 86 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with TH=
P
# ok 87 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out THP
# ok 88 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with PT=
E-mapped THP
# ok 89 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with sw=
apped-out, PTE-mapped THP
# ok 90 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of THP
# ok 91 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with si=
ngle PTE of swapped-out THP
# ok 92 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially mremap()'ed THP
# ok 93 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with pa=
rtially shared THP
# ok 94 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with hu=
getlb (2048 kB)
# ok 95 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped previously-shared page ... with hu=
getlb (1048576 kB)
# ok 96 # SKIP need more free huge pages
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with base page
# ok 97 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with swapped out bas=
e page
# ok 98 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with THP
# ok 99 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with swapped-out THP
# ok 100 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with PTE-mapped THP
# ok 101 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with swapped-out, PT=
E-mapped THP
# ok 102 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with single PTE of T=
HP
# ok 103 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with single PTE of s=
wapped-out THP
# ok 104 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with partially mrema=
p()'ed THP
# ok 105 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with partially share=
d THP
#=20
# ok 101 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with swapped-out, PT=
E-mapped THP
# ok 102 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with single PTE of T=
HP
# ok 103 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with single PTE of s=
wapped-out THP
# ok 104 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with partially mrema=
p()'ed THP
# ok 105 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with partially share=
d THP
# ok 106 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with hugetlb (2048 k=
B)
# ok 107 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with hugetlb (104857=
6 kB)
# ok 108 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with base page
# ok 109 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped ou=
t base page
# ok 110 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with THP
# ok 111 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped-ou=
t THP
# ok 112 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with PTE-mapped=
 THP
# ok 113 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped-ou=
t, PTE-mapped THP
# ok 114 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with single PTE=
 of THP
# ok 115 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with single PTE=
 of swapped-out THP
# ok 116 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with partially =
mremap()'ed THP
# ok 117 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with partially =
shared THP
#=20
# ok 101 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with swapped-out, PT=
E-mapped THP
# ok 102 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with single PTE of T=
HP
# ok 103 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with single PTE of s=
wapped-out THP
# ok 104 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with partially mrema=
p()'ed THP
# ok 105 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with partially share=
d THP
# ok 106 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with hugetlb (2048 k=
B)
# ok 107 Longterm R/O pin is reliable
# # [RUN] R/O GUP pin on R/O-mapped exclusive page ... with hugetlb (104857=
6 kB)
# ok 108 # SKIP need more free huge pages
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with base page
# ok 109 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped ou=
t base page
# ok 110 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with THP
# ok 111 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped-ou=
t THP
# ok 112 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with PTE-mapped=
 THP
# ok 113 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped-ou=
t, PTE-mapped THP
# ok 114 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with single PTE=
 of THP
# ok 115 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with single PTE=
 of swapped-out THP
# ok 116 # SKIP MADV_PAGEOUT did not work, is swap enabled?
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with partially =
mremap()'ed THP
# ok 117 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with partially =
shared THP
# ok 118 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with hugetlb (2=
048 kB)
# ok 119 Longterm R/O pin is reliable
# # [RUN] R/O GUP-fast pin on R/O-mapped exclusive page ... with hugetlb (1=
048576 kB)
# ok 120 # SKIP need more free huge pages
# Bail out! 3 out of 120 tests failed
# # Totals: pass:67 fail:3 xfail:0 xpass:0 skip:50 error:0
# [FAIL]
not ok 5 selftests: vm: run_vmtests.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests=
-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/tools/testing/selftests/vm'

--lO5Jvfks0vsTK8lU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-vm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
sysctl:
  sc_nr_hugepages: 2
kernel-selftests:
  group: vm
job_origin: kernel-selftests-vm.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-cfl-d1
tbox_group: lkp-cfl-d1
submit_id: 6364a9a127b770600af71e36
job_file: "/lkp/jobs/scheduled/lkp-cfl-d1/kernel-selftests-vm-2-debian-12-x86_64-20220629.cgz-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b-20221104-24586-n0dmp-0.yaml"
id: 9ac018415f08ca261ed6c41b3b5ef46acd34b562
queuer_version: "/zday/lkp"

#! hosts/lkp-cfl-d1
model: Coffee Lake
nr_node: 1
nr_cpu: 12
memory: 16G
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part5"
swap_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part3"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006J800RGN-part4"
kernel_cmdline_hw: acpi_rsdp=0xb9e23000
brand: Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/queue/cyclic
commit: 8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b

#! include/testbox/lkp-cfl-d1
netconsole_port: 6677
ucode: '0xf0'
need_kconfig_hw:
- SATA_AHCI
- R8169: y
- DRM_I915
bisect_dmesg: true

#! include/kernel-selftests
need_kconfig:
- MEM_SOFT_DIRTY: y, x86_64
- GUP_BENCHMARK: y, v4.15-rc1, <= v5.10
- GUP_TEST: y, v5.11-rc1
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2022-11-04 13:56:50.118361522 +08:00
_id: 6364a9a127b770600af71e36
_rt: "/result/kernel-selftests/vm-2/lkp-cfl-d1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 59c99a569b3b8d64ecca08ddb05bd2d0ebb8ad19
base_commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
branch: linux-devel/devel-hourly-20221102-072652
result_root: "/result/kernel-selftests/vm-2/lkp-cfl-d1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/0"
scheduler_version: "/lkp/lkp/.src-20221104-135305"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/vm-2/lkp-cfl-d1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/vmlinuz-6.1.0-rc1-00309-g8b7e3b7ca389
- branch=linux-devel/devel-hourly-20221102-072652
- job=/lkp/jobs/scheduled/lkp-cfl-d1/kernel-selftests-vm-2-debian-12-x86_64-20220629.cgz-8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b-20221104-24586-n0dmp-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b
- initcall_debug
- acpi_rsdp=0xb9e23000
- max_uptime=2100
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20220629.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20221017.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-9313ba54-1_20221017.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20220629.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20221101191108/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.0.0-05990-g32e91a7b118a
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b/vmlinuz-6.1.0-rc1-00309-g8b7e3b7ca389"
dequeue_time: 2022-11-04 15:10:27.895107516 +08:00

#! /cephfs/db/releases/20221104143915/lkp-src/include/site/inn
job_state: wget_initrd

--lO5Jvfks0vsTK8lU
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

echo '2' > '/proc/sys/vm/nr_hugepages'
ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C vm
make quicktest=1 run_tests -C vm

--lO5Jvfks0vsTK8lU--
