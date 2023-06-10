Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C572AC90
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjFJPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:25:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDCB1988;
        Sat, 10 Jun 2023 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686410748; x=1717946748;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=sBW4+6Xwmz1tUJ4hyw3yv8PPHPkrreh3aIBfnK6srdA=;
  b=m2SkwhTI/3XxNFnLn+uzPIupyUwU9EgRPu9e6MeVi010TWy8sX9CrSq2
   xvWHLLWuNyxyQ7LFZ9xZmcjsk8jeJv8/5oISwLupO1I93NdNvH9wLxDYq
   e9dYG9Rx+zf0CrXKpuz4G/pi9WhQWQZU1F7Sr5e9mK0SGvhQSGjHmt3ez
   lpO0AhpXi8ySjjW3A1Y6IsRnLfCuLcPYeRH/2GMMYYpBUP1K3sHsY5+lI
   7pWGSMSSmCsEXSKYB63o5R040eBca7ueyWyw+xsme0Ho7Y31gZPt2JEve
   7ZSOA/LirVh/uW1CEBXe1JOT2uB5G4bWosSbbNnaWhCgQZxHFLeAF9gqT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="342459577"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="342459577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 08:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="834956902"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="834956902"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2023 08:25:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 08:25:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 10 Jun 2023 08:25:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 10 Jun 2023 08:25:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 10 Jun 2023 08:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNqQLZmG2OymqoqZMgNhNyb8ZExB5aNbkdWOGCYmSpKbndxvByn7oF4KyPA00qZoxuzgdSlkngKBvZqV6F76RCanh3XZKQPOH2qrfOb4CBWaLcpgmx3byXByZAfPthw0Zi3vHHXibYwPOaW9j2wNC5I75M7lkGEuKB0oSScbRBZsgOkVVrrUjp1EY5XenrEzQ+pEjVujjbMLuWDKPhTNFUWe2HAH+G1ctdVY9PH4H2rkc4uVCPf7VwXtBBvyyb+YUD52XtBa/xn8U5UzpYXTPMpFuNR6lqVQv/LKrYRV2csFWR/Z46ldNOGdaSlRN6pDYhR+Y1K9ffn4+3ETbKaQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShW4pgVonvZ3uaHktfcnGHoZWiM+EhE/Waw1w/HqT9k=;
 b=UQNbCRjZf/t+ZeW2CRcjSRVwPjt97lW8b+IZvnbvJ0PZzr8T2omIzvfENHJy7Lnjd3FjUA2OTB+APxTRde4mOqEZunXuTbauGpTxuVktPDaaEjY1HsPkz+UcVdET5MWNk4LMwCeRFAaFSrvU41UATXoHkS3dRJu4eutxGFQGMUWFWqO65n5vuacYniXTRY06cFweugpYsm0fUzj9pXmXCerbt9ZZKt2TaTGWYsVFoAYFVp6iDdpeUva3kC1j1FgHWYk9s8qQU3d//08pM45ZdRxf67XzRVpkZUZInPrvSRLq1caAjhWEoNbjCJruyiXrZuwMdnTPqnunz+OlNYt0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 15:25:40 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Sat, 10 Jun 2023
 15:25:40 +0000
Date:   Sat, 10 Jun 2023 23:25:27 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ajay Kaher <akaher@vmware.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <namit@vmware.com>, <srivatsa@csail.mit.edu>,
        <amakhalov@vmware.com>, <vsirnapalli@vmware.com>,
        <tkundu@vmware.com>, <er.ajay.kaher@gmail.com>,
        Ajay Kaher <akaher@vmware.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 09/10] eventfs: moving tracing/events to eventfs
Message-ID: <202306102230.b5aa258d-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="oytwxGynXvyo+ljz"
Content-Disposition: inline
In-Reply-To: <1685610013-33478-10-git-send-email-akaher@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SJ2PR11MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e93fe43-88e1-41cf-63e5-08db69c6f243
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mSPTl2jQ8obgQ3SLm0paQWsmn7qsbLtRs5OcPcfXgKioEzy3kqvYh7G9KMn8o4ONYmqZ5EG05vwc442kpeoCqHI0VfFBgrQ6AWwc3hZyGU5HMbQGK8RTxlk8IEoplbuiRYWpQw23Sfh1bklM9w9D4365umpr9ClqUfns/c1qX0yz3KHL7XAui2saX23kz01TAwM2PD0FtsjoLUinXpc19QAKPnXKBhB5AWBEqNt45xZJ493M9KUgQyBg+c8cfO/odXetisf/acbcv1xkczpyWZeFWxrGlDodotAnmKO+AlLnNdbZkW1xDve3gT1t6B9C9fIoHt7H2gAYcw3+wnDkleJ4ovXSzmPSENAjzx4Py9PULLH8kAg619IG43zCVwtLHXhFUgTyPTwGHU25JRAGhRjB/sl7ORub3e93+bCgAyZ/wqXBy84FaMs9mPD9xPtQ8myOqmb96ALjMygQHylLYtV1gQ8EecU62UMOlBDtcjDY69OUPhfinky9wxJn314R6DaEdied0vruX/Lxg0EDExzJzxvQ46siNCs0QLXFX43KNzj8yJ1VlYMy72tA9OGHjAlK/zOd1C9Fb+gzbSAyp4KGKngdrH35huSHF+A/yYW4OYZqrVccxlt5lJE3cBwFeN53h2IR/pulsmOPDcEUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(86362001)(44144004)(107886003)(7416002)(6486002)(316002)(8676002)(966005)(41300700001)(82960400001)(83380400001)(5660300002)(26005)(38100700002)(6512007)(1076003)(6506007)(6666004)(8936002)(36756003)(66476007)(235185007)(66556008)(4326008)(66946007)(6916009)(478600001)(186003)(21490400003)(54906003)(30864003)(2906002)(2616005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSe15alCZq4wI57TkFsmkZpCTBKPYujSYz6SMovGtDgQJHcFZR4MrimDPKHD?=
 =?us-ascii?Q?SnvzYVXWHxf9Yx+3bE9gRgS5HaK6ZlCOowLpZjmN2wXkskvT3cX+ubzlUcOR?=
 =?us-ascii?Q?QO5YxRJhoMTmDA9+r8NIUbmfLViyDTPFG1gECLfctR8nylIZouqiCbEXpqoq?=
 =?us-ascii?Q?NFLqbYPbP+JR7MPxxrID6eE8nDvpgcvwuV1evM9EOcLYZn+u7K4VUGE3VFDH?=
 =?us-ascii?Q?oG8xHgC4/06heFFvwP8lfX21zQsT4S34a0zblizAgemUH8GnpxSqMJsfJ6dq?=
 =?us-ascii?Q?LW3gN/PQSUza7IuFCTgbVMZEZz64Fv7ZWW0jTI1Pf+J779COTWhmOHfivdeq?=
 =?us-ascii?Q?28x58Ntd0DcqqCgG+5gNyMOASQcUEGfxwNExYRWN8puSJJwjOrftJjxPKz6e?=
 =?us-ascii?Q?dvNICQVxpJGPqMLuBaOTfxnh3WJJ/u43ABCRIRxBR5zfU8qfPBuceYrTir7h?=
 =?us-ascii?Q?Z9r3AfHLChR3RK9+atAiFxBrLTunYvrLIbZ++japM5hd0ld7uvASOAxifwti?=
 =?us-ascii?Q?bCq7JDAyPxmhLX3zcw1CX/YPS+SjaB4GfGgNxDFbeQ+PMfzwVh1HBmXYSuy8?=
 =?us-ascii?Q?UJSC5aP8Yt+D86BTczfqruggo8HaPp++yFz4hSy0BSZX/Arta1deprZnRhSQ?=
 =?us-ascii?Q?5aoFOC+/q5Bl4dI7HyOkphBNyGo5/LwSaVZTBv2t6jO/hAgH51DcS0JJDSPz?=
 =?us-ascii?Q?5/KKm8w1gGdVPy9e3MVZRN6G6TBJ0iJvnSOrlYsjVLLB5ekQXoXIesFPg0X8?=
 =?us-ascii?Q?H6ZLCHBEVMr6+RnyMj19TsJkvORFTP8jwsnS91ONedqQn4cW8kFKIRWa7faf?=
 =?us-ascii?Q?16QtmBdmVe0sWqsIwIzaflBhZ7kxSx/6o5bRFHJTkz9c3+T5RNATCrVYRH1J?=
 =?us-ascii?Q?eibD7zG6EqJAcGJF6DaU0EPCXtfBFTimpLDjA6mduXj+/rhx+g6VnD7ewuuU?=
 =?us-ascii?Q?oDJ5SlO8Gxyb9ntbG8tNvkO3qg1IvQ25uua/PQ43v53mUD6oITNe8UwwU0oa?=
 =?us-ascii?Q?z/P9hnowp8OwKyBEJJp4fibl09/s/cqAF5kaqJOKZKVepXTrsJf5muPcwkPu?=
 =?us-ascii?Q?G94vREgRRd68HkJlFFddhv+xsdLoNe4sSx0x1rSTfbTHcTVXnMRNQ2JHNDnP?=
 =?us-ascii?Q?5cR64bd7rgyFi3ordTtPUIybwAHUzlgl6bE6QFmVtkmtR+BRYM4gwJR65CDX?=
 =?us-ascii?Q?/zfXeBPJIrV0jZiHTknTiTM9mb8qsM96aIGhByPoeI/Z4PwxJYM4gbycoxfX?=
 =?us-ascii?Q?/ObEyv+GMVYlSOJ56aTqqyl5naTpCh3w6p5z40n2O3SuW1Yg+ATUmKmbMYDp?=
 =?us-ascii?Q?O6rcBQvupYD2HcsGrSVyB3oAGFk4DY5odj6r05/NdHWc3K18n5GLWB8HTWcv?=
 =?us-ascii?Q?y/L68mA9HpvQ0cgQ1BYcYtzx1BKAmeC9IpoF53MNEYoEIBJp6RbGwIZ8JG17?=
 =?us-ascii?Q?krw4TgXJWZlKO9T3NtwkDPITbA2VKiFvBhdeb68K9zq1UI655ex5yz7OOGR2?=
 =?us-ascii?Q?QwAy5eRvIjgIJcZT91Vrp6N/2iVaIbc7h5ICxNWJBEuA0zwSTmTh5MB0T+0j?=
 =?us-ascii?Q?7E47+yAS7D+2pbDyfbleWY0csRTb4d6o1MXpCSZQWqXR7UTZHAQiTvgkRy7j?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e93fe43-88e1-41cf-63e5-08db69c6f243
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 15:25:39.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylMWZiNkv7evddBTngwDxzKRCMf6Utznrb0hwuAbmVHU40pmYpJwAxurd18RsfGcCb4PSHCMH7WXVVp2O9ccDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--oytwxGynXvyo+ljz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: a3bb763435d444023d3bca5479da632c57724619 ("[PATCH v3 09/10] eventfs: moving tracing/events to eventfs")
url: https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/tracing-Require-all-trace-events-to-have-a-TRACE_SYSTEM/20230601-230657
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/1685610013-33478-10-git-send-email-akaher@vmware.com/
patch subject: [PATCH v3 09/10] eventfs: moving tracing/events to eventfs

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: ftrace

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202306102230.b5aa258d-oliver.sang@intel.com


kern  :warn  : [  173.884312] WARNING: possible circular locking dependency detected
kern  :warn  : [  173.884947] 6.4.0-rc1-00014-ga3bb763435d4 #1 Not tainted
kern  :warn  : [  173.885501] ------------------------------------------------------
kern  :warn  : [  173.886125] ftracetest/2186 is trying to acquire lock:
kern :warn : [  173.886665] ffff88810045d368 (&sb->s_type->i_mutex_key#5){++++}-{3:3}, at: dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373) 
kern  :warn  : [  173.887638]
but task is already holding lock:
kern :warn : [  173.888299] ffffffff84e6d640 (eventfs_rwsem/1){.+.+}-{3:3}, at: dcache_dir_open_wrapper (fs/tracefs/event_inode.c:364) 
kern  :warn  : [  173.889183]
which lock already depends on the new lock.

kern  :warn  : [  173.890101]
the existing dependency chain (in reverse order) is:
kern  :warn  : [  173.890898]
-> #1 (eventfs_rwsem/1){.+.+}-{3:3}:
kern :warn : [  173.891600] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5656) 
kern :warn : [  173.892066] down_read_nested (kernel/locking/rwsem.c:1263 kernel/locking/rwsem.c:1646) 
kern :warn : [  173.892553] eventfs_root_lookup (fs/tracefs/event_inode.c:283) 
kern :warn : [  173.893058] __lookup_slow (include/linux/dcache.h:359 include/linux/dcache.h:364 fs/namei.c:1691) 
kern :warn : [  173.893529] walk_component (include/linux/fs.h:790 fs/namei.c:1708 fs/namei.c:1998) 
kern :warn : [  173.894006] path_lookupat (fs/namei.c:2455 fs/namei.c:2479) 
kern :warn : [  173.894476] filename_lookup (fs/namei.c:2508) 
kern :warn : [  173.894974] vfs_statx (fs/stat.c:239) 
kern :warn : [  173.895410] vfs_fstatat (fs/stat.c:277) 
kern :warn : [  173.895851] __do_sys_newfstatat (fs/stat.c:447) 
kern :warn : [  173.896350] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
kern :warn : [  173.896815] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
kern  :warn  : [  173.897392]
-> #0 (&sb->s_type->i_mutex_key#5){++++}-{3:3}:
kern :warn : [  173.898158] check_prev_add (kernel/locking/lockdep.c:3109) 
kern :warn : [  173.898643] __lock_acquire (kernel/locking/lockdep.c:3228 kernel/locking/lockdep.c:3842 kernel/locking/lockdep.c:5074) 
kern :warn : [  173.899133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5656) 
kern :warn : [  173.899610] down_write (arch/x86/include/asm/preempt.h:80 kernel/locking/rwsem.c:1304 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
kern :warn : [  173.900054] dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373) 
kern :warn : [  173.900603] do_dentry_open (fs/open.c:920) 
kern :warn : [  173.901081] do_open (fs/namei.c:3636) 
kern :warn : [  173.901508] path_openat (fs/namei.c:3792) 
kern :warn : [  173.901963] do_filp_open (fs/namei.c:3818) 
kern :warn : [  173.902425] do_sys_openat2 (fs/open.c:1356) 
kern :warn : [  173.902902] __x64_sys_openat (fs/open.c:1383) 
kern :warn : [  173.903408] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
kern :warn : [  173.903864] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
kern  :warn  : [  173.904451]
other info that might help us debug this:

kern  :warn  : [  173.905372]  Possible unsafe locking scenario:

kern  :warn  : [  173.906049]        CPU0                    CPU1
kern  :warn  : [  173.906538]        ----                    ----
kern  :warn  : [  173.907027]   rlock(eventfs_rwsem/1);
kern  :warn  : [  173.907464]                                lock(&sb->s_type->i_mutex_key#5);
kern  :warn  : [  173.908171]                                lock(eventfs_rwsem/1);
kern  :warn  : [  173.908800]   lock(&sb->s_type->i_mutex_key#5);
kern  :warn  : [  173.909291]
*** DEADLOCK ***

kern  :warn  : [  173.910026] 1 lock held by ftracetest/2186:
kern :warn : [  173.910488] #0: ffffffff84e6d640 (eventfs_rwsem/1){.+.+}-{3:3}, at: dcache_dir_open_wrapper (fs/tracefs/event_inode.c:364) 
kern  :warn  : [  173.911413]
stack backtrace:
kern  :warn  : [  173.911955] CPU: 13 PID: 2186 Comm: ftracetest Not tainted 6.4.0-rc1-00014-ga3bb763435d4 #1
kern  :warn  : [  173.912777] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern  :warn  : [  173.913694] Call Trace:
kern  :warn  : [  173.914014]  <TASK>
kern :warn : [  173.914305] dump_stack_lvl (lib/dump_stack.c:108) 
kern :warn : [  173.914727] check_noncircular (kernel/locking/lockdep.c:2191) 
kern :warn : [  173.915199] ? print_circular_bug (kernel/locking/lockdep.c:2167) 
kern :warn : [  173.915676] ? mark_usage (kernel/locking/lockdep.c:4930) 
kern :warn : [  173.916100] check_prev_add (kernel/locking/lockdep.c:3109) 
kern :warn : [  173.916553] __lock_acquire (kernel/locking/lockdep.c:3228 kernel/locking/lockdep.c:3842 kernel/locking/lockdep.c:5074) 
kern :warn : [  173.917003] ? mark_usage (kernel/locking/lockdep.c:4930) 
kern :warn : [  173.917425] ? __lock_acquire (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3754 kernel/locking/lockdep.c:3810 kernel/locking/lockdep.c:5074) 
kern :warn : [  173.917889] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5656) 
kern :warn : [  173.918309] ? dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373) 
kern :warn : [  173.918822] ? lock_sync (kernel/locking/lockdep.c:5659) 
kern :warn : [  173.919253] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
kern :warn : [  173.919729] ? lock_sync (kernel/locking/lockdep.c:5659) 
kern :warn : [  173.920144] down_write (arch/x86/include/asm/preempt.h:80 kernel/locking/rwsem.c:1304 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574) 
kern :warn : [  173.920552] ? dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373) 
kern :warn : [  173.921064] ? down_write_killable_nested (kernel/locking/rwsem.c:1571) 
kern :warn : [  173.921599] ? __lock_release+0x111/0x440 
kern :warn : [  173.922097] ? do_dentry_open (fs/open.c:872) 
kern :warn : [  173.922540] dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373) 
kern :warn : [  173.923039] ? fsnotify_perm+0x13b/0x4a0 
kern :warn : [  173.923548] do_dentry_open (fs/open.c:920) 
kern :warn : [  173.923982] ? eventfs_create_dir (fs/tracefs/event_inode.c:349) 
kern :warn : [  173.924470] ? may_open (fs/namei.c:3265) 
kern :warn : [  173.924869] do_open (fs/namei.c:3636) 
kern :warn : [  173.925255] path_openat (fs/namei.c:3792) 
kern :warn : [  173.926598] ? path_lookupat (fs/namei.c:3773) 
kern :warn : [  173.927039] ? .slowpath (kernel/locking/qspinlock.c:317) 
kern :warn : [  173.927454] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5656) 
kern :warn : [  173.927889] ? __create_object (mm/kmemleak.c:678) 
kern :warn : [  173.928347] do_filp_open (fs/namei.c:3818) 
kern :warn : [  173.928768] ? may_open_dev (fs/namei.c:3812) 
kern :warn : [  173.929202] ? _raw_spin_unlock (arch/x86/include/asm/preempt.h:95 include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186) 
kern :warn : [  173.929651] ? alloc_fd (fs/file.c:555 (discriminator 10)) 
kern :warn : [  173.930060] ? getname_flags (fs/namei.c:206) 
kern :warn : [  173.930544] do_sys_openat2 (fs/open.c:1356) 
kern :warn : [  173.930979] ? build_open_flags (fs/open.c:1342) 
kern :warn : [  173.931460] __x64_sys_openat (fs/open.c:1383) 
kern :warn : [  173.931909] ? __ia32_compat_sys_open (fs/open.c:1383) 
kern :warn : [  173.932416] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4539) 
kern :warn : [  173.933016] ? syscall_enter_from_user_mode (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/entry/common.c:111) 
kern :warn : [  173.933552] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
kern :warn : [  173.933966] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
kern  :warn  : [  173.934500] RIP: 0033:0x7fc11f551e41
kern :warn : [ 173.934913] Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
All code
========
   0:	44 24 18             	rex.R and $0x18,%al
   3:	31 c0                	xor    %eax,%eax
   5:	41 83 e2 40          	and    $0x40,%r10d
   9:	75 3e                	jne    0x49
   b:	89 f0                	mov    %esi,%eax
   d:	25 00 00 41 00       	and    $0x410000,%eax
  12:	3d 00 00 41 00       	cmp    $0x410000,%eax
  17:	74 30                	je     0x49
  19:	89 f2                	mov    %esi,%edx
  1b:	b8 01 01 00 00       	mov    $0x101,%eax
  20:	48 89 fe             	mov    %rdi,%rsi
  23:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 3f                	ja     0x71
  32:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  37:	64 48 2b 14 25 28 00 	sub    %fs:0x28,%rdx
  3e:	00 00 

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 3f                	ja     0x47
   8:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
   d:	64 48 2b 14 25 28 00 	sub    %fs:0x28,%rdx
  14:	00 00 


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
https://github.com/intel/lkp-tests/wiki



--oytwxGynXvyo+ljz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc1-00014-ga3bb763435d4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
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

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
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
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
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
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
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
CONFIG_ACPI_HMAT=y
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
# CONFIG_MODULE_DEBUG is not set
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
CONFIG_BLK_CGROUP_PUNT_BIO=y
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
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
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
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

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
CONFIG_NET_HANDSHAKE=y
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
CONFIG_NETFILTER_BPF_LINK=y
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
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

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
CONFIG_OPENVSWITCH_VXLAN=m
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
CONFIG_MAX_SKB_FRAGS=17
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
CONFIG_PAGE_POOL_STATS=y
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
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
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
CONFIG_FW_LOADER_DEBUG=y
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
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
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
CONFIG_EFI_SOFT_RESERVE=y
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
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
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
CONFIG_VXLAN=m
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
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
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
# CONFIG_SERIAL_8250_PCI1XXXX is not set
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
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
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
# CONFIG_GPIO_FXL6408 is not set
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
# CONFIG_GPIO_ELKHARTLAKE is not set
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
CONFIG_VIDEO_CMDLINE=y
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
CONFIG_DRM_VIRTIO_GPU_KMS=y
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
# CONFIG_I2C_HID_OF is not set

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
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
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
# CONFIG_LEDS_BD2606MVV is not set
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
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
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
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
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
# CONFIG_LENOVO_YMC is not set
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
# CONFIG_MSI_EC is not set
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
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
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
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
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
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
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
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
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
CONFIG_IMA_LSM_RULES=y
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
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
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
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_PER_VMA_LOCK_STATS is not set
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
# CONFIG_DEBUG_PREEMPT is not set

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
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
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
# CONFIG_USER_EVENTS is not set
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
# CONFIG_SAMPLE_FPROBE is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_KMEMLEAK is not set
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
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
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

--oytwxGynXvyo+ljz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-csl-d01'
	export tbox_group='lkp-csl-d01'
	export submit_id='6482520285d26b04b9617e91'
	export job_file='/lkp/jobs/scheduled/lkp-csl-d01/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-a3bb763435d444023d3bca5479da632c57724619-20230609-1209-1pwrz0w-5.yaml'
	export id='65a0f4bc8b0acb0fd3ffdb37dd800af36c8daf60'
	export queuer_version='/zday/lkp'
	export model='Cascade Lake'
	export nr_node=1
	export nr_cpu=36
	export memory='32G'
	export nr_ssd_partitions=1
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPEKNW010T8_PHNH119301NW1P0B-part3'
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPEKNW010T8_PHNH119301NW1P0B-part4'
	export brand='Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz'
	export commit='a3bb763435d444023d3bca5479da632c57724619'
	export ucode='0x5003303'
	export need_kernel_version=
	export need_kconfig=\{\"FTRACE\"\=\>\"y\"\}'
'\{\"KPROBES\"\=\>\"y\"\}'
'\{\"FUNCTION_PROFILER\"\=\>\"y\"\}'
'\{\"TRACER_SNAPSHOT\"\=\>\"y\"\}'
'\{\"STACK_TRACER\"\=\>\"y\"\}'
'\{\"HIST_TRIGGERS\"\=\>\"y\"\}'
'\{\"SCHED_TRACER\"\=\>\"y\"\}'
'\{\"IRQSOFF_TRACER\"\=\>\"y\"\}'
'\{\"PREEMPTIRQ_DELAY_TEST\"\=\>\"m\"\}'
'\{\"MODULES\"\=\>\"y\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"SAMPLES\"\=\>\"y\"\}'
'\{\"SAMPLE_FTRACE_DIRECT\"\=\>\"m\"\}'
'\{\"SAMPLE_TRACE_PRINTK\"\=\>\"m\"\}'
'\{\"KALLSYMS_ALL\"\=\>\"y\"\}
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-06-09 06:11:14 +0800'
	export _id='6482521885d26b04b9617e94'
	export _rt='/result/kernel-selftests/ftrace/lkp-csl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619'
	export user='lkp'
	export compiler='gcc-12'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='1808b253fcf7d40338347fce28bc66a1ad7b5db3'
	export base_commit='7877cb91f1081754a1487c144d85dc0d2e2e7fc4'
	export branch='linux-review/Ajay-Kaher/tracing-Require-all-trace-events-to-have-a-TRACE_SYSTEM/20230601-230657'
	export result_root='/result/kernel-selftests/ftrace/lkp-csl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-csl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/vmlinuz-6.4.0-rc1-00014-ga3bb763435d4
branch=linux-review/Ajay-Kaher/tracing-Require-all-trace-events-to-have-a-TRACE_SYSTEM/20230601-230657
job=/lkp/jobs/scheduled/lkp-csl-d01/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-a3bb763435d444023d3bca5479da632c57724619-20230609-1209-1pwrz0w-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=a3bb763435d444023d3bca5479da632c57724619
kvm-intel.unrestricted_guest=0
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.4.0-rc4'
	export repeat_to=6
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/vmlinuz-6.4.0-rc1-00014-ga3bb763435d4'
	export dequeue_time='2023-06-09 08:27:12 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-d01/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-a3bb763435d444023d3bca5479da632c57724619-20230609-1209-1pwrz0w-5.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='ftrace' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='ftrace' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--oytwxGynXvyo+ljz
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--oytwxGynXvyo+ljz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-a3bb763435d444023d3bca5479da632c57724619
2023-06-09 00:30:34 ln -sf /usr/bin/clang
2023-06-09 00:30:34 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-06-09 00:30:34 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-06-09 00:30:34 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP WARN miss config CONFIG_PREEMPT_TRACER= of ftrace/config
2023-06-09 00:30:36 make -j36 -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a3bb763435d444023d3bca5479da632c57724619/tools/testing/selftests/ftrace'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a3bb763435d444023d3bca5479da632c57724619/tools/testing/selftests/ftrace'
2023-06-09 00:30:36 make quicktest=1 run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a3bb763435d444023d3bca5479da632c57724619/tools/testing/selftests/ftrace'
TAP version 13
1..1
# selftests: ftrace: ftracetest
# === Ftrace unit tests ===
# [1] Basic trace file check	[PASS]
# [2] Basic test for tracers	[PASS]
# [3] Basic trace clock test	[PASS]
# [4] Basic event tracing check	[PASS]
# [5] Change the ringbuffer size	[PASS]
# [6] Snapshot and tracing setting	[PASS]
# [7] trace_pipe and trace_marker	[PASS]
# [8] Test ftrace direct functions against tracers	[PASS]
# [9] Test ftrace direct functions against kprobes	[PASS]
# [10] Generic dynamic event - add/remove eprobe events	[PASS]
# [11] Generic dynamic event - add/remove kprobe events	[PASS]
# [12] Generic dynamic event - add/remove synthetic events	[PASS]
# [13] Generic dynamic event - selective clear (compatibility)	[PASS]
# [14] Event probe event parser error log check	[PASS]
# [15] Generic dynamic event - generic clear event	[PASS]
# [16] Generic dynamic event - check if duplicate events are caught	[PASS]
# [17] event tracing - enable/disable with event level files	[PASS]
# [18] event tracing - restricts events based on pid notrace filtering	[PASS]
# [19] event tracing - restricts events based on pid	[PASS]
# [20] event tracing - enable/disable with subsystem level files	[PASS]
# [21] event tracing - enable/disable with top level files	[PASS]
# [22] Test trace_printk from module	[PASS]
# [23] event filter function - test event filtering on functions	[PASS]
# [24] ftrace - function graph filters with stack tracer	[PASS]
# [25] ftrace - function graph filters	[PASS]
# [26] ftrace - function glob filters	[PASS]
# [27] ftrace - function pid notrace filters	[PASS]
# [28] ftrace - function pid filters	[PASS]
# [29] ftrace - stacktrace filter command	[PASS]
# [30] ftrace - function trace with cpumask	[PASS]
# [31] ftrace - test for function event triggers	[PASS]
# [32] ftrace - function trace on module	[PASS]
# [33] ftrace - function profiling	[PASS]
# [34] ftrace - function profiler with function tracing	[PASS]
# [35] ftrace - test reading of set_ftrace_filter	[PASS]
# [36] ftrace - Max stack tracer	[PASS]
# [37] ftrace - test for function traceon/off triggers	[PASS]
# [38] ftrace - test tracing error log support	[PASS]
# [39] Test creation and deletion of trace instances while setting an event	[PASS]
# [40] Test creation and deletion of trace instances	[PASS]
# [41] Kprobe dynamic event - adding and removing	[PASS]
# [42] Kprobe dynamic event - busy event check	[PASS]
# [43] Kprobe dynamic event with arguments	[PASS]
# [44] Kprobe event char type argument	[FAIL]
# [45] Kprobe event with comm arguments	[PASS]
# [46] Kprobe event string type argument	[FAIL]
# [47] Kprobe event symbol argument	[PASS]
# [48] Kprobe event argument syntax	[PASS]
# [49] Kprobes event arguments with types	[PASS]
# [50] Kprobe event user-memory access	[PASS]
# [51] Kprobe event auto/manual naming	[PASS]
# [52] Kprobe dynamic event with function tracer	[PASS]
# [53] Kprobe dynamic event - probing module	[PASS]
# [54] Create/delete multiprobe on kprobe event	[PASS]
# [55] Register/unregister optimized probe	[PASS]
# [56] Kprobe event parser error log check
--oytwxGynXvyo+ljz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: ftrace
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-csl-d01
tbox_group: lkp-csl-d01
submit_id: 64822bd785d26b1d22df8ac3
job_file: "/lkp/jobs/scheduled/lkp-csl-d01/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-a3bb763435d444023d3bca5479da632c57724619-20230609-72994-rtosqc-0.yaml"
id: ff51fa43e8618c19e3da66357b34d404a036375d
queuer_version: "/zday/lkp"

#! /db/releases/20230605181737/lkp-src/hosts/lkp-csl-d01
model: Cascade Lake
nr_node: 1
nr_cpu: 36
memory: 32G
nr_ssd_partitions: 1
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPEKNW010T8_PHNH119301NW1P0B-part3"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPEKNW010T8_PHNH119301NW1P0B-part4"
brand: Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz

#! /db/releases/20230605181737/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:
kmemleak:

#! /db/releases/20230605181737/lkp-src/include/queue/cyclic
commit: a3bb763435d444023d3bca5479da632c57724619

#! /db/releases/20230605181737/lkp-src/include/testbox/lkp-csl-d01
ucode: '0x5003303'

#! /db/releases/20230605181737/lkp-src/include/kernel-selftests
need_kernel_version:
need_kconfig:
- FTRACE: y
- KPROBES: y
- FUNCTION_PROFILER: y
- TRACER_SNAPSHOT: y
- STACK_TRACER: y
- HIST_TRIGGERS: y
- SCHED_TRACER: y
- IRQSOFF_TRACER: y
- PREEMPTIRQ_DELAY_TEST: m
- MODULES: y
- MODULE_UNLOAD: y
- SAMPLES: y
- SAMPLE_FTRACE_DIRECT: m
- SAMPLE_TRACE_PRINTK: m
- KALLSYMS_ALL: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-06-09 03:28:24.834909639 +08:00
_id: 64822bd785d26b1d22df8ac3
_rt: "/result/kernel-selftests/ftrace/lkp-csl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619"

#! schedule options
user: lkp
compiler: gcc-12
LKP_SERVER: internal-lkp-server
head_commit: 1808b253fcf7d40338347fce28bc66a1ad7b5db3
base_commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
branch: linux-devel/devel-hourly-20230604-090848
result_root: "/result/kernel-selftests/ftrace/lkp-csl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-csl-d01/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/vmlinuz-6.4.0-rc1-00014-ga3bb763435d4
- branch=linux-devel/devel-hourly-20230604-090848
- job=/lkp/jobs/scheduled/lkp-csl-d01/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-a3bb763435d444023d3bca5479da632c57724619-20230609-72994-rtosqc-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=a3bb763435d444023d3bca5479da632c57724619
- kvm-intel.unrestricted_guest=0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230605181737/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.4.0-rc4

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-12/a3bb763435d444023d3bca5479da632c57724619/vmlinuz-6.4.0-rc1-00014-ga3bb763435d4"
dequeue_time: 2023-06-09 04:28:05.874109169 +08:00

#! /db/releases/20230608210739/lkp-src/include/site/inn

--oytwxGynXvyo+ljz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -j36 -C ftrace
make quicktest=1 run_tests -C ftrace

--oytwxGynXvyo+ljz--
