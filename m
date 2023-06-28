Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C183974131B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjF1Nya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:54:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:50774 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231499AbjF1Ny0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687960466; x=1719496466;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=D3LC7SH7XlTNN6haqZy2dIOvXd+CS9yTqOKC0avCkNs=;
  b=l/xEsU86rNl/+JIEmDQhFB5vZIRItmqO6dAhbtEvd8tYrcaEBqJ9lGMC
   5AgUCYokC8cMkHLUyL2KNapIgolrt669xYsmLpMq8O/d3YNDYH989EFYd
   8SuUAI7vuWIktv0tgMxr9y4tdsCGKEpdd6YLAqFoeBPsrdq6O1g/zrs1j
   ZY7iVWC1GORgWnY/RJpbpd/u68Xq9LT3CQ1hZGa0DluV/dOqpyqn7tCn0
   WTNdPYa7HVM22NuXIIxPZJm2vbXN6cqhV0YvbLuFhuoNLJhEiYdZrjFub
   ajhAc8QnqCIrvLWy0JRJpwuusCqOayPfdNaLF9ly4tIJjTIEHCT83gYj2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="346611152"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="xz'341?scan'341,208,341";a="346611152"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 06:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="746666249"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="xz'341?scan'341,208,341";a="746666249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2023 06:54:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 06:54:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 06:54:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 06:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJrstYPezol1qJG/AWP77Mxc/0KQtRAH/j/4aHEF9VfsH+Dm2thcX8AbYdFJLkBhJmDUMPbH2CsP8NCLbUkGrk7UkOfSqGd87sGpcFFrTtArWOxXmNVXHlmP41k7s40hIsvanhIPxbiy5/0lXBuQhH4adejfaO3gPeRs+cXIL93PoHeltzr4dCYOjgby/i8d2aV8WKYf93sI7HYowAeoG1kt8MfD9J+oES7T72fe8Sbg0wHgIx1Lzy6bpfbgKC7lDd0DGNw+60fPtH7N4Z73ZpBf/BAicTFgF77ZdXNtQsBMs+paySktSJutv3Q2t1jUs7t9NeU47kbW5TTNV0tUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B3LwSijkW2mLOxXqXV62RYoOFt1f7Sz3cPp5DAOn1w=;
 b=lLWkxPhvFcuqQn59WPTImv4XyB1Pk+HIGT+MM6Xic6Jiy0+7WKuIS2JRgv1MH1wW36OO+qt1Pj10DnlZ3YAL57YChcNdkUmrmX5xSwaXVCAnzf7XP/avFbkH4N8FUvwA3daR9A0JUzPyXawIBta36vqe5pIJn8SNCpcqh240ucikw6sN8dqi2ODlIBcdPEzP+mCpwX2XL+ATK3poPGtvXO7mXqel+WergE9sa4A3Qy5W8mDsAB/BjXyHV3QX8CTp5NHRyZT7bdNRfpH456TeBM7D9Fe4Ryo6PmOu/drSpIpTyjUXi911WTqb4VHmIizGFxJ4nKNumGHzBDllS9dz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB7723.namprd11.prod.outlook.com (2603:10b6:610:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Wed, 28 Jun
 2023 13:54:19 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%7]) with mapi id 15.20.6455.028; Wed, 28 Jun 2023
 13:54:19 +0000
Date:   Wed, 28 Jun 2023 21:54:08 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     You Kangren <youkangren@vivo.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <opensource.kernel@vivo.com>, <youkangren@vivo.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] posix-timers: Release the acquired lock before returning
Message-ID: <202306282154.58062c2f-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="v55j5F79nlS0HElD"
Content-Disposition: inline
In-Reply-To: <20230626120017.3030-1-youkangren@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0450f5f4-a837-4b51-eabc-08db77df2aca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBpEvbdHyIQuOvEi+/OzcfMMimRvRz1LGPzNmuAgDerxxKSGov2WgGWMd052x0gtqXG7V6tvwiENDCzQWef9xulOsG6ullnja2PIsyT++T42269Wjx8ncq8Lo7CW4HYywQ6QywJ4kU8py6NYtO87Cr8xbHumqx4Ah0scpoENbRXfF9EJE/Ef51tnsLWzfP9WKQ8Ye4jIDC61itlsRlx8PXfewA5EaZFH942Re59QfiEl9WFN2JO/HpgCf75ek8NBvsXJKTKme8XbDWH9W8Ewn4MRZHjTnEl/3mDgQdDjGmIga+nvzWVCGo+gzzTNDSJ0jWU1mSeHAv6SLFTm8Wr+LySeNbP6gqpcuD4RXCjpYIgP29N0uAFLd4yaK+TVO4aqDKK8i79nO+Lqn8UvVkDjnJuxVQZwqbBzi/8pHu9AYAYqknrfp97vEccGxEraWzIktxtiHE8CFMBvOmL0jAEyHlvJBSOpE7XXHA74T7HgdCGZ6hTlxkK3a+54lxjmQfoozXdjKZsdumufTg6EaJ3uUHqqGRzelDEvx+/ZkH2hlJ3c3uJXwRjXoqLASsEU3M1n/xJuKYaA4tFmNqH1jbLPxBgYFoNny/f6rWJl9kxK50NuBVchvbsjbMDj0OWfZGTA5jA2JcssIyC12fxAeln/Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(5660300002)(8676002)(8936002)(235185007)(41300700001)(86362001)(6666004)(6486002)(2616005)(4326008)(6916009)(316002)(966005)(66556008)(83380400001)(66476007)(2906002)(478600001)(36756003)(30864003)(66946007)(45080400002)(82960400001)(44144004)(38100700002)(6512007)(1076003)(6506007)(66574015)(107886003)(186003)(26005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZM9EBm/h2fcyDmwjohWP0BPyTqDjurBB0iq8pVPAzsvG7MwdleIoVJXWTLQI?=
 =?us-ascii?Q?2P+BGXNutsMxk+vKjYHXaUsECVf8qh7MhNyusL6DRPBnvANufvxlPf+F2Aic?=
 =?us-ascii?Q?wvw9ee2vRUi7XSbQBBnrza/Zfxa9YGO+/AEd2pVRUq3XdGiEAiDQmmdcM5Uu?=
 =?us-ascii?Q?K88bUfxNRvQHx2NOf2ngmI0OIHa+8czczayFfxRYu/SoYDNSQRqWdTUp2H8c?=
 =?us-ascii?Q?JY3PHX5jGHd+Ao+S7RsRv6Vfn4MQpD2bgV7E6BVawRjG4tV60unNLvXWDH2u?=
 =?us-ascii?Q?v77oIUp0yCSt5L4rshw4lS8Max6lSWBWQcGOjgSJI/xZYDzlfXqw38HjlvRA?=
 =?us-ascii?Q?X83FyjLXsWQJzVwlsAZfF4Ht+7KlIZBs5v4gdd1gLhBhoZrOb+TEi9PMjCfM?=
 =?us-ascii?Q?6kNLsc9AS57oGtCohFEuj//LB07vcCWS5mHIF7fAWG8lUNOnFu8GKFp7C6Ic?=
 =?us-ascii?Q?bVZYwDYNzkX1C4CZ1pomDzC5FJjVDHr/nfeYJ4kvwe23mOULA1qJxepnZNup?=
 =?us-ascii?Q?NfceVsa0ds9mizoNySF0gls13OB2oW5v9n6Ao55v6HiFkJXObrubznUHn4qJ?=
 =?us-ascii?Q?WtOu3hMynFQxbBYIPcvzXn6VbuZAQ6TDrKxQAJvW739NknZCs7w32zVUUZyp?=
 =?us-ascii?Q?bypRjcpmAIGzpkHfbcn+CPhnyz18DaxZ32t0trnOxRXg5+hgf1ma6t0ovk/A?=
 =?us-ascii?Q?Z3ISePGYP2/uhQ/UQAT8yfmbJBFveIwJl6zsVGEv8XU3FPBTlePu20zyGieT?=
 =?us-ascii?Q?Kb4WKltZi6Z0Md9ecJ10i1jbXLrzsjRIjWxSRf/GNMqA5/5pJDOmfIrbf38d?=
 =?us-ascii?Q?bEyXmYnX3Fjo9+xMwGFrVze5kpwYKa82bEFbfvEIH8G4djyO61Oiwy/M5qis?=
 =?us-ascii?Q?jrDqrn5JDbXzAD4+/kNMLqsVYobNRzG8WtFCVfmpcUXo5/+TtR8lqsfXPtVo?=
 =?us-ascii?Q?GhzIJQ4Tv4Y2WZOZyaU3b769aWvcdvIhrw51cIK7uYTROznk5OIzKp+oTG/1?=
 =?us-ascii?Q?bEy3VqKJyvjZ34b4y60hefp/qcJTdB6pXj1rklR0cjSh0dDlh4B1aQGleleK?=
 =?us-ascii?Q?p8ngkG94iMCUi1tCEG+QJ2j5OIxQp0424b/68P5sBYQ1t/iZyu0Hl6RtOrWx?=
 =?us-ascii?Q?pg3w6qTLqtwbc1YKiDi7S6H/JDMFCsB5XhspPGcD1Yh6CpWjzkS5AkAEyCbl?=
 =?us-ascii?Q?M9R3OikzsWsobhKrxoqcsgFguw+04W3FY34fFzirmQNsF8DLLpjBW5Yzl69h?=
 =?us-ascii?Q?Nbs2KCr1fbMa+1YITLmcO2vwMgjvvbRtJrBqFj13kMu+Rf+xTcj83UgdUncX?=
 =?us-ascii?Q?IPwlgWnA6+tduUFGcm7bIao3unPRdKskTNuHDGs1RDj8tn0t1z44pCb0LfjC?=
 =?us-ascii?Q?Dbs83LP+OzSyZGVADxtHNjvhbQiLbEMrT43BvrcpqputBYSVtgmK7DhUmczV?=
 =?us-ascii?Q?T690DNsKVTsh7YxrwwaFLBbX3TsFOcyJKvCYoFbfybMVoMNIHN5QEJb4L+Zc?=
 =?us-ascii?Q?NJ+lU/QaXACuftbsKSlBril1AuVzfbrUhqfd3l7x9vGWWg8+jXBn+/w31mVA?=
 =?us-ascii?Q?QRFDalIw/wVTq3yAxR9Zj7+gnOd8ye99nQUQeuXSUBbZPM06nNZcLdv7XAan?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0450f5f4-a837-4b51-eabc-08db77df2aca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:54:18.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXTlK0z0CHKuovqPcQCJyrxhCQVqtTPgb6E63zzbroMAQUqgTyXS1tsf2Z4CrbLl5g8qiEJt/kiGR3bZcKDC9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7723
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v55j5F79nlS0HElD
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:bad_unlock_balance_detected" on:

commit: a33a94dbedf738c4e9e4b264883fbfd9a01b1e29 ("[PATCH] posix-timers: Release the acquired lock before returning")
url: https://github.com/intel-lab-lkp/linux/commits/You-Kangren/posix-timers-Release-the-acquired-lock-before-returning/20230626-200132
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git d2b32be7debd6c0deeae95844997bd89fbe4769d
patch link: https://lore.kernel.org/all/20230626120017.3030-1-youkangren@vivo.com/
patch subject: [PATCH] posix-timers: Release the acquired lock before returning

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202306282154.58062c2f-oliver.sang@intel.com


[   40.691875][  T648] WARNING: bad unlock balance detected!
[   40.692294][  T648] 6.4.0-rc4-00041-ga33a94dbedf7 #17 Not tainted
[   40.692764][  T648] -------------------------------------
[   40.693174][  T648] trinity-c1/648 is trying to release lock (&posix_cpu_timers_key) at:
[ 40.693798][ T648] do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[   40.694256][  T648] but there are no more locks to release!
[   40.694687][  T648]
[   40.694687][  T648] other info that might help us debug this:
[   40.695297][  T648] no locks held by trinity-c1/648.
[   40.695683][  T648]
[   40.695683][  T648] stack backtrace:
[   40.696130][  T648] CPU: 1 PID: 648 Comm: trinity-c1 Not tainted 6.4.0-rc4-00041-ga33a94dbedf7 #17 52a599974c7ffcbcfb7dedc40a8a8b5005ce7907
[   40.697075][  T648] Call Trace:
[ 40.697333][ T648] dump_stack_lvl (kbuild/src/rand-4/lib/dump_stack.c:107 (discriminator 4)) 
[ 40.697681][ T648] dump_stack (kbuild/src/rand-4/lib/dump_stack.c:114) 
[ 40.697992][ T648] print_unlock_imbalance_bug (kbuild/src/rand-4/kernel/locking/lockdep.c:5145 kbuild/src/rand-4/kernel/locking/lockdep.c:5121) 
[ 40.698432][ T648] ? do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[ 40.698806][ T648] ? do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[ 40.699182][ T648] ? do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[ 40.699555][ T648] __lock_release+0x61/0x111 
[ 40.699955][ T648] ? do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[ 40.700334][ T648] lock_release (kbuild/src/rand-4/kernel/locking/lockdep.c:467 kbuild/src/rand-4/kernel/locking/lockdep.c:5727) 
[ 40.700667][ T648] _raw_spin_unlock_irqrestore (kbuild/src/rand-4/include/linux/spinlock_api_smp.h:150 kbuild/src/rand-4/kernel/locking/spinlock.c:194) 
[ 40.701104][ T648] do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[ 40.701460][ T648] __ia32_sys_timer_gettime32 (kbuild/src/rand-4/kernel/time/posix-timers.c:741 kbuild/src/rand-4/kernel/time/posix-timers.c:735 kbuild/src/rand-4/kernel/time/posix-timers.c:735) 
[ 40.701881][ T648] __do_fast_syscall_32 (kbuild/src/rand-4/arch/x86/entry/common.c:112 kbuild/src/rand-4/arch/x86/entry/common.c:178) 
[ 40.706369][ T648] do_fast_syscall_32 (kbuild/src/rand-4/arch/x86/entry/common.c:203) 
[ 40.706751][ T648] do_SYSENTER_32 (kbuild/src/rand-4/arch/x86/entry/common.c:247) 
[ 40.707100][ T648] entry_SYSENTER_32 (kbuild/src/rand-4/arch/x86/entry/entry_32.S:867) 
[   40.707473][  T648] EIP: 0x37f7256d
[ 40.707755][ T648] Code: c4 01 10 03 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	c4 01 10 03          	(bad)  
   4:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   8:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b87411
   e:	10 06                	adc    %al,(%rsi)
  10:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  14:	10 07                	adc    %al,(%rdi)
  16:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  1a:	10 08                	adc    %cl,(%rax)
  1c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76
[   40.709247][  T648] EAX: ffffffda EBX: 00000000 ECX: 369e1000 EDX: 000000c8
[   40.709776][  T648] ESI: fffffffe EDI: 0000cfa5 EBP: 0000d3ee ESP: 3ffe77cc
[   40.710325][  T648] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000216
[   40.710964][  T648] ------------[ cut here ]------------
[   40.711429][  T648] raw_local_irq_restore() called with IRQs enabled
[ 40.711945][ T648] WARNING: CPU: 1 PID: 648 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore (kbuild/src/rand-4/kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[   40.712739][  T648] Modules linked in: rose mpls_router phonet bluetooth ecdh_generic rfkill can_raw cn scsi_transport_iscsi scsi_mod atm netrom appletalk ax25 evbug crc32c_intel input_leds evdev button fuse autofs4
[   40.714207][  T648] CPU: 1 PID: 648 Comm: trinity-c1 Not tainted 6.4.0-rc4-00041-ga33a94dbedf7 #17 52a599974c7ffcbcfb7dedc40a8a8b5005ce7907
[ 40.715159][ T648] EIP: warn_bogus_irq_restore (kbuild/src/rand-4/kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 40.715579][ T648] Code: 5b 89 fa 5e 5f 5d 8d 67 f8 5f 31 c9 c3 80 3d ab 1d 1b 42 00 75 1b 55 89 e5 c6 05 ab 1d 1b 42 01 68 28 1a bc 41 e8 a5 b7 82 ff <0f> 0b 58 c9 31 c0 c3 31 c0 c3 55 89 e5 56 53 64 8b 1d 80 d2 2a 42
All code
========
   0:	5b                   	pop    %rbx
   1:	89 fa                	mov    %edi,%edx
   3:	5e                   	pop    %rsi
   4:	5f                   	pop    %rdi
   5:	5d                   	pop    %rbp
   6:	8d 67 f8             	lea    -0x8(%rdi),%esp
   9:	5f                   	pop    %rdi
   a:	31 c9                	xor    %ecx,%ecx
   c:	c3                   	retq   
   d:	80 3d ab 1d 1b 42 00 	cmpb   $0x0,0x421b1dab(%rip)        # 0x421b1dbf
  14:	75 1b                	jne    0x31
  16:	55                   	push   %rbp
  17:	89 e5                	mov    %esp,%ebp
  19:	c6 05 ab 1d 1b 42 01 	movb   $0x1,0x421b1dab(%rip)        # 0x421b1dcb
  20:	68 28 1a bc 41       	pushq  $0x41bc1a28
  25:	e8 a5 b7 82 ff       	callq  0xffffffffff82b7cf
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	58                   	pop    %rax
  2d:	c9                   	leaveq 
  2e:	31 c0                	xor    %eax,%eax
  30:	c3                   	retq   
  31:	31 c0                	xor    %eax,%eax
  33:	c3                   	retq   
  34:	55                   	push   %rbp
  35:	89 e5                	mov    %esp,%ebp
  37:	56                   	push   %rsi
  38:	53                   	push   %rbx
  39:	64 8b 1d 80 d2 2a 42 	mov    %fs:0x422ad280(%rip),%ebx        # 0x422ad2c0

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	58                   	pop    %rax
   3:	c9                   	leaveq 
   4:	31 c0                	xor    %eax,%eax
   6:	c3                   	retq   
   7:	31 c0                	xor    %eax,%eax
   9:	c3                   	retq   
   a:	55                   	push   %rbp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %rsi
   e:	53                   	push   %rbx
   f:	64 8b 1d 80 d2 2a 42 	mov    %fs:0x422ad280(%rip),%ebx        # 0x422ad296
[   40.717015][  T648] EAX: 00000000 EBX: 531a37e0 ECX: 00000000 EDX: 00000000
[   40.717541][  T648] ESI: 00000202 EDI: bec97f78 EBP: bec97f30 ESP: bec97f2c
[   40.718085][  T648] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[   40.718678][  T648] CR0: 80050033 CR2: 00ef2f74 CR3: 7e6d5ac0 CR4: 000406b0
[   40.719224][  T648] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   40.719766][  T648] DR6: fffe0ff0 DR7: 00000400
[   40.720126][  T648] Call Trace:
[ 40.720383][ T648] ? show_regs (kbuild/src/rand-4/arch/x86/kernel/dumpstack.c:479 kbuild/src/rand-4/arch/x86/kernel/dumpstack.c:465) 
[ 40.720707][ T648] ? warn_bogus_irq_restore (kbuild/src/rand-4/kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 40.721129][ T648] ? __warn (kbuild/src/rand-4/kernel/panic.c:673) 
[ 40.721436][ T648] ? report_bug (kbuild/src/rand-4/lib/bug.c:201 kbuild/src/rand-4/lib/bug.c:219) 
[ 40.721769][ T648] ? warn_bogus_irq_restore (kbuild/src/rand-4/kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 40.722178][ T648] ? exc_overflow (kbuild/src/rand-4/arch/x86/kernel/traps.c:337) 
[ 40.722519][ T648] ? handle_bug (kbuild/src/rand-4/arch/x86/kernel/traps.c:324) 
[ 40.722847][ T648] ? exc_invalid_op (kbuild/src/rand-4/arch/x86/kernel/traps.c:345 (discriminator 1)) 
[ 40.723198][ T648] ? handle_exception (kbuild/src/rand-4/arch/x86/entry/entry_32.S:1083) 
[ 40.723575][ T648] ? exc_overflow (kbuild/src/rand-4/arch/x86/kernel/traps.c:337) 
[ 40.723915][ T648] ? warn_bogus_irq_restore (kbuild/src/rand-4/kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 40.724309][ T648] ? exc_overflow (kbuild/src/rand-4/arch/x86/kernel/traps.c:337) 
[ 40.724647][ T648] ? warn_bogus_irq_restore (kbuild/src/rand-4/kernel/locking/irqflag-debug.c:10 (discriminator 3)) 
[ 40.725053][ T648] _raw_spin_unlock_irqrestore (kbuild/src/rand-4/arch/x86/include/asm/irqflags.h:42 kbuild/src/rand-4/arch/x86/include/asm/irqflags.h:77 kbuild/src/rand-4/arch/x86/include/asm/irqflags.h:135 kbuild/src/rand-4/include/linux/spinlock_api_smp.h:151 kbuild/src/rand-4/kernel/locking/spinlock.c:194) 
[ 40.725483][ T648] do_timer_gettime (kbuild/src/rand-4/kernel/time/posix-timers.c:716) 
[ 40.725842][ T648] __ia32_sys_timer_gettime32 (kbuild/src/rand-4/kernel/time/posix-timers.c:741 kbuild/src/rand-4/kernel/time/posix-timers.c:735 kbuild/src/rand-4/kernel/time/posix-timers.c:735) 
[ 40.726271][ T648] __do_fast_syscall_32 (kbuild/src/rand-4/arch/x86/entry/common.c:112 kbuild/src/rand-4/arch/x86/entry/common.c:178) 
[ 40.726656][ T648] do_fast_syscall_32 (kbuild/src/rand-4/arch/x86/entry/common.c:203) 
[ 40.727024][ T648] do_SYSENTER_32 (kbuild/src/rand-4/arch/x86/entry/common.c:247) 
[ 40.727370][ T648] entry_SYSENTER_32 (kbuild/src/rand-4/arch/x86/entry/entry_32.S:867) 
[   40.727741][  T648] EIP: 0x37f7256d
[ 40.728023][ T648] Code: c4 01 10 03 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	c4 01 10 03          	(bad)  
   4:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   8:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b87411
   e:	10 06                	adc    %al,(%rsi)
  10:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  14:	10 07                	adc    %al,(%rdi)
  16:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  1a:	10 08                	adc    %cl,(%rax)
  1c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76


To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-rc4-00041-ga33a94dbedf7 .config
	make HOSTCC=gcc-12 CC=gcc-12 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-12 CC=gcc-12 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
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



--v55j5F79nlS0HElD
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc4-00041-ga33a94dbedf7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.4.0-rc4 Kernel Configuration
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
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

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
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
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

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

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_GOLDFISH=y
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
CONFIG_X86_32_NON_STANDARD=y
# CONFIG_STA2X11 is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_MVIAC7=y
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
# CONFIG_CPU_SUP_VORTEX_32 is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
# CONFIG_EFI_RUNTIME_MAP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_STRICT_SIGALTSTACK_SIZE=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=0
CONFIG_FUNCTION_PADDING_BYTES=4
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_RETPOLINE=y
# CONFIG_RETHUNK is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=m
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
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

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_ALIX=y
CONFIG_NET5501=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
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
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
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
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_SECCOMP_CACHE_DEBUG=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
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
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
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
# CONFIG_GCC_PLUGINS is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT=4
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
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
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_IOCOST=y
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
# end of IO Schedulers

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

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_GUP_GET_PXX_LOW_HIGH=y
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# CONFIG_SECRETMEM is not set
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
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
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=m
CONFIG_PHONET=m
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=y
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
# CONFIG_NET_NSH is not set
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=m
# CONFIG_BAYCOM_SER_FDX is not set
# CONFIG_BAYCOM_SER_HDX is not set
# CONFIG_BAYCOM_PAR is not set
# CONFIG_BAYCOM_EPP is not set
# CONFIG_YAM is not set
# end of AX.25 network device drivers

CONFIG_CAN=y
CONFIG_CAN_RAW=m
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=m
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM4377 is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
CONFIG_BT_MTKSDIO=m
# CONFIG_BT_MTKUART is not set
# CONFIG_BT_VIRTIO is not set
CONFIG_BT_NXPUART=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
# CONFIG_NET_9P_FD is not set
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
# CONFIG_ETHTOOL_NETLINK is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# Cadence-based PCIe controllers
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
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
CONFIG_PCCARD=y
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
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
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_CBMEM=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=m
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
CONFIG_GOOGLE_VPD=y

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
# CONFIG_EFI_TEST is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
# CONFIG_GNSS_MTK_SERIAL is not set
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_RAW_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_AUTH=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SMPRO_ERRMON=y
CONFIG_SMPRO_MISC=y
CONFIG_HI6421V600_IRQ=m
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
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
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_UACCE=m
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_ENCLOSURE is not set
# CONFIG_SCSI_CONSTANTS is not set
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
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
CONFIG_AHCI_CEVA=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
# CONFIG_ISCSI_TARGET is not set
# CONFIG_REMOTE_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
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
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_VSOCKMON is not set
# CONFIG_MHI_NET is not set
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
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
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
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=y
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
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
# CONFIG_PCMCIA_RAYCS is not set
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
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADC=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_232=m
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=m
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_JOYSTICK_SENSEHAT=m
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F54 is not set
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
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
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
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DFL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
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
# CONFIG_IPWIRELESS is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C=y
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
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
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=m
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
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_TANGIER=m
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=m
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_FXL6408=m
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD71815=m
CONFIG_GPIO_BD71828=m
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_ELKHARTLAKE=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TPS68470=m
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_TWL6040=m
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_CHARGER_88PM860X is not set
CONFIG_BATTERY_RX51=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX77976=m
# CONFIG_CHARGER_MAX8998 is not set
CONFIG_CHARGER_MP2629=m
CONFIG_CHARGER_MT6360=m
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=m
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_RK817 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_RT9467=y
CONFIG_CHARGER_RT9471=y
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_CROS_PCHG=m
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_CHARGER_WILCO is not set
# CONFIG_RN5T618_POWER is not set
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_SMPRO=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=m
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DRIVETEMP=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MC34VR500=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_OCC_P9_SBE=m
CONFIG_SENSORS_OCC=m
CONFIG_SENSORS_OXP=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ACBEL_FSG032=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LM25066_REGULATOR is not set
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX15301=m
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_MP5023=m
# CONFIG_SENSORS_MPQ7932_REGULATOR is not set
CONFIG_SENSORS_MPQ7932=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=m
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TDA38640=m
# CONFIG_SENSORS_TDA38640_REGULATOR is not set
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_TPS546D24=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE152=m
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA238=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_WM8350 is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_SENSORS_ASUS_WMI=m
CONFIG_SENSORS_ASUS_EC=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=y
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=m
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=y
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
CONFIG_ADVANTECH_EC_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
CONFIG_TQMX86_WDT=m
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=y
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_MAX597X is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=m
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=m
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_NTXEC=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS65219=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=m
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=m
CONFIG_MFD_WCD934X=m
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=m
CONFIG_MFD_INTEL_M10_BMC_CORE=m
CONFIG_MFD_INTEL_M10_BMC_PMCI=m
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_AS3722=m
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BD71815=m
CONFIG_REGULATOR_BD71828=m
# CONFIG_REGULATOR_BD718XX is not set
# CONFIG_REGULATOR_CROS_EC is not set
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9121 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_HI6421V600=m
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LOCHNAGAR=m
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=m
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX20411=y
CONFIG_REGULATOR_MAX77686=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6331=m
# CONFIG_REGULATOR_MT6332 is not set
CONFIG_REGULATOR_MT6357=m
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6359=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PF8X00 is not set
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=m
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT4803=y
# CONFIG_REGULATOR_RT4831 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5739=y
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_SY8827N=m
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS6286X=m
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS65219=m
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TPS68470=m
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=m
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8350=m
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_CROS_EC=m
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
CONFIG_VIDEO_AR0521=y
# CONFIG_VIDEO_HI556 is not set
CONFIG_VIDEO_HI846=y
CONFIG_VIDEO_HI847=m
# CONFIG_VIDEO_IMX208 is not set
CONFIG_VIDEO_IMX214=m
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=m
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=m
# CONFIG_VIDEO_IMX296 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
CONFIG_VIDEO_IMX335=m
CONFIG_VIDEO_IMX355=y
# CONFIG_VIDEO_IMX412 is not set
CONFIG_VIDEO_IMX415=y
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
CONFIG_VIDEO_MT9T112=m
# CONFIG_VIDEO_MT9V011 is not set
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_OG01A1B=m
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV08X40=m
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=m
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=m
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV4689=m
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=y
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5670 is not set
CONFIG_VIDEO_OV5675=m
CONFIG_VIDEO_OV5693=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV6650=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9282 is not set
# CONFIG_VIDEO_OV9640 is not set
CONFIG_VIDEO_OV9650=m
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_ST_VGXY61=y
# CONFIG_VIDEO_CCS is not set
CONFIG_VIDEO_ET8EK8=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_SONY_BTF_MPX=m
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_ISL7998X=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_MAX9286=m
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=m
# CONFIG_VIDEO_THS8200 is not set
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
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_ST_MIPID02 is not set
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
# CONFIG_MEDIA_TUNER_MT20XX is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=y
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18212=m
# CONFIG_MEDIA_TUNER_TDA18218 is not set
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
# CONFIG_DRM_PANEL_DSI_CM is not set
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_EBBG_FT8719=m
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_HIMAX_HX8394=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_JDI_R63452=m
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_NEWVISION_NV3051D=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
CONFIG_DRM_PANEL_SONY_TD4353_JDI=m
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CHIPONE_ICN6211=m
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=m
CONFIG_DRM_ITE_IT6505=m
CONFIG_DRM_LONTIUM_LT8912B=m
# CONFIG_DRM_LONTIUM_LT9211 is not set
CONFIG_DRM_LONTIUM_LT9611=m
CONFIG_DRM_LONTIUM_LT9611UXC=y
CONFIG_DRM_ITE_IT66121=y
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NWL_MIPI_DSI=m
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SAMSUNG_DSIM=y
CONFIG_DRM_SIL_SII8620=m
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358762=m
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=y
CONFIG_DRM_TI_DLPC3433=m
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI83 is not set
CONFIG_DRM_TI_SN65DSI86=y
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_ANX7625=m
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7511_CEC is not set
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_KTZ8866=m
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_AAT2870=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_RAVE_SP is not set
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_DRM_ACCEL=y
# CONFIG_DRM_ACCEL_QAIC is not set
# CONFIG_SOUND is not set
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
CONFIG_MMC=m
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_LITEX=m
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFS_BSG=y
# CONFIG_SCSI_UFS_CRYPTO is not set
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_CDNS_PLATFORM=m
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_NET48XX is not set
# CONFIG_LEDS_WRAP is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA903X=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2606MVV is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=m
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=m
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=m
# CONFIG_LEDS_LM36274 is not set
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MAX77693=y
# CONFIG_LEDS_MT6360 is not set
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_DFL=m
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
# CONFIG_VMGENID is not set
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
CONFIG_VDPA=y
CONFIG_VDPA_USER=m
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_STEERING_DEBUG=y
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_TASK=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST_VDPA=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
# CONFIG_COMEDI_NI_MIO_CS is not set
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_ACPI=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=m
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_UART is not set
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_USBPD_NOTIFY=m
CONFIG_CHROMEOS_PRIVACY_SCREEN=y
CONFIG_WILCO_EC=m
CONFIG_WILCO_EC_DEBUGFS=m
# CONFIG_WILCO_EC_EVENTS is not set
CONFIG_WILCO_EC_TELEMETRY=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=m
# CONFIG_SURFACE_ACPI_NOTIFY is not set
CONFIG_SURFACE_AGGREGATOR_CDEV=m
# CONFIG_SURFACE_DTX is not set
CONFIG_SURFACE_HOTPLUG=m
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_SURFACE_AGGREGATOR=m
# CONFIG_SURFACE_AGGREGATOR_BUS is not set
# CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
# CONFIG_MXM_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
CONFIG_XIAOMI_WMI=m
CONFIG_GIGABYTE_WMI=m
CONFIG_YOGABOOK_WMI=m
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
# CONFIG_ACER_WMI is not set
CONFIG_ADV_SWBUTTON=m
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=y
# CONFIG_DCDBAS is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_WMI is not set
CONFIG_DELL_SMO8800=y
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_DDV=m
CONFIG_DELL_WMI_LED=m
# CONFIG_AMILO_RFKILL is not set
CONFIG_FUJITSU_LAPTOP=m
# CONFIG_FUJITSU_TABLET is not set
CONFIG_GPD_POCKET_FAN=y
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
CONFIG_WIRELESS_HOTKEY=m
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_LENOVO_YMC=m
# CONFIG_SENSORS_HDAPS is not set
CONFIG_THINKPAD_LMI=m
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_SKL_INT3472=y
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_OAKTRAIL is not set
CONFIG_INTEL_MRFLD_PWRBTN=m
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=m
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_LAPTOP is not set
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=m
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_MLX_PLATFORM=y
CONFIG_FW_ATTR_CLASS=m
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=y
CONFIG_INTEL_SCU_IPC_UTIL=m
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=m
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=m
CONFIG_COMMON_CLK_CDCE925=m
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_LOCHNAGAR=m
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_SI521XX=y
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_VC7=m
CONFIG_COMMON_CLK_BD718XX=m
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=m
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
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
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

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
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
# CONFIG_EXTCON_INTEL_MRFLD is not set
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=m
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_GTS_HELPER=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL367=m
CONFIG_ADXL367_I2C=m
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
# CONFIG_DA280 is not set
CONFIG_DA311=m
CONFIG_DMARD06=y
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_FXLS8962AF=m
CONFIG_FXLS8962AF_I2C=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_KX022A=y
CONFIG_IIO_KX022A_I2C=y
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=y
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MSA311=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=m
CONFIG_AD7291=m
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD799X=y
# CONFIG_ADI_AXI_ADC is not set
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HX711=y
# CONFIG_INA2XX_ADC is not set
CONFIG_INTEL_MRFLD_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
CONFIG_MCP3422=y
CONFIG_MEDIATEK_MT6360_ADC=m
CONFIG_MEN_Z188_ADC=m
CONFIG_MP2629_ADC=m
CONFIG_NAU7802=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_RN5T618_ADC=m
CONFIG_RICHTEK_RTQ6056=y
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STMPE_ADC=m
CONFIG_TI_ADC081C=y
CONFIG_TI_ADS1015=m
# CONFIG_TI_ADS7924 is not set
# CONFIG_TI_ADS1100 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=y
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_STX104 is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
# CONFIG_PMS7003 is not set
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
CONFIG_SCD30_SERIAL=m
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=m
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
# CONFIG_IIO_CROS_EC_SENSORS is not set
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

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
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=y
CONFIG_DPOT_DAC=m
# CONFIG_DS4424 is not set
CONFIG_M62332=m
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=m
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=m
CONFIG_HDC2010=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_BOSCH_BNO055=y
# CONFIG_BOSCH_BNO055_SERIAL is not set
CONFIG_BOSCH_BNO055_I2C=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM9DS0=m
CONFIG_IIO_ST_LSM9DS0_I2C=m
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=m
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_AS73211=m
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_IQS621_ALS=m
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
# CONFIG_JSA1212 is not set
CONFIG_ROHM_BU27034=y
# CONFIG_RPR0521 is not set
CONFIG_LTR501=m
# CONFIG_LTRF216A is not set
CONFIG_LV0104CS=m
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=y
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=y
CONFIG_TSL2591=y
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=y
CONFIG_VEML6070=m
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_TI_TMAG5273=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=y
# CONFIG_DS1803 is not set
CONFIG_MAX5432=y
CONFIG_MCP4018=y
CONFIG_MCP4531=m
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
CONFIG_ABP060MG=m
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_DLHL60D is not set
CONFIG_DPS310=m
# CONFIG_HP03 is not set
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=y
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_CROS_EC_MKBP_PROXIMITY=m
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=m
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
CONFIG_SX9360=m
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=m
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
CONFIG_MAX30208=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_XILINX_INTC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=m
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
CONFIG_NVMEM_LAYOUT_ONIE_TLV=y
# end of Layout Types

# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_SPMI_SDAM=m
CONFIG_NVMEM_U_BOOT_ENV=m

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=y
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
# CONFIG_FPGA_DFL_FME_MGR is not set
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
CONFIG_FPGA_DFL_FME_REGION=m
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FPGA_M10_BMC_SEC_UPDATE=m
CONFIG_FSI=m
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_MASTER_ASPEED=m
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
CONFIG_104_QUAD_8=m
# CONFIG_INTEL_QEP is not set
CONFIG_INTERRUPT_CNT=m
CONFIG_MOST=m
# CONFIG_MOST_CDEV is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=m
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_SUPPORT_ASCII_CI is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZORLE=y
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_ERROR_INJECTION=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
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
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=m
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=m
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=m
CONFIG_EROFS_FS_DEBUG=y
CONFIG_EROFS_FS_XATTR=y
# CONFIG_EROFS_FS_POSIX_ACL is not set
CONFIG_EROFS_FS_SECURITY=y
# CONFIG_EROFS_FS_ZIP is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_TRUSTED_KEYS_TPM=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
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
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ARIA=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_HCTR2=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XCTR=m
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=m
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
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TWOFISH_586=m
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
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
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
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
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
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
CONFIG_BCH=m
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
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
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
# CONFIG_CPUMASK_OFFSTACK is not set
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=m

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
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
# CONFIG_DEBUG_INFO_COMPRESSED_NONE is not set
CONFIG_DEBUG_INFO_COMPRESSED_ZLIB=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
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
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
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
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
CONFIG_NET_NS_REFCNT_TRACKER=y
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
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
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
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

CONFIG_DEBUG_TIMEKEEPING=y

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
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
CONFIG_DEBUG_IRQFLAGS=y
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
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
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
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
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
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_KPROBE_EVENTS is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
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
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--v55j5F79nlS0HElD
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
	export branch='linux-review/You-Kangren/posix-timers-Release-the-acquired-lock-before-returning/20230626-200132'
	export commit='a33a94dbedf738c4e9e4b264883fbfd9a01b1e29'
	export kconfig='i386-randconfig-i011-20230626'
	export nr_vm=300
	export submit_id='649abf38b7103301455480e5'
	export job_file='/lkp/jobs/queued/validate/vm-snb/trinity-600s-debian-11.1-i386-20220923.cgz-i386-randconfig-i011-20230626-a33a94dbedf7-20230627-325-ygs4hd-11.yaml'
	export id='a8400a6305b7fe6aadcb60b4866262130f9a54fd'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-12'
	export enqueue_time='2023-06-27 18:51:36 +0800'
	export _id='649abf3bb7103301455480ea'
	export _rt='/result/trinity/600s/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-i011-20230626/gcc-12/a33a94dbedf738c4e9e4b264883fbfd9a01b1e29'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/.src-20230625-101604'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/600s/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-i011-20230626/gcc-12/a33a94dbedf738c4e9e4b264883fbfd9a01b1e29/8
BOOT_IMAGE=/pkg/linux/i386-randconfig-i011-20230626/gcc-12/a33a94dbedf738c4e9e4b264883fbfd9a01b1e29/vmlinuz-6.4.0-rc4-00041-ga33a94dbedf7
branch=linux-review/You-Kangren/posix-timers-Release-the-acquired-lock-before-returning/20230626-200132
job=/lkp/jobs/scheduled/vm-meta-261/trinity-600s-debian-11.1-i386-20220923.cgz-i386-randconfig-i011-20230626-a33a94dbedf7-20230627-325-ygs4hd-11.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-i011-20230626
commit=a33a94dbedf738c4e9e4b264883fbfd9a01b1e29
mem=4G
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
	export modules_initrd='/pkg/linux/i386-randconfig-i011-20230626/gcc-12/a33a94dbedf738c4e9e4b264883fbfd9a01b1e29/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz,/osimage/pkg/debian-11.1-i386-20220923.cgz/trinity-i386-abe9de86-1_20230429.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-261/trinity-600s-debian-11.1-i386-20220923.cgz-i386-randconfig-i011-20230626-a33a94dbedf7-20230627-325-ygs4hd-11.cgz'
	export repeat_to=14
	export stop_repeat_if_found='dmesg.is_trying_to_release_lock(&posix_cpu_timers_key)at'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/i386-randconfig-i011-20230626/gcc-12/a33a94dbedf738c4e9e4b264883fbfd9a01b1e29/vmlinuz-6.4.0-rc4-00041-ga33a94dbedf7'
	export result_root='/result/trinity/600s/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-i011-20230626/gcc-12/a33a94dbedf738c4e9e4b264883fbfd9a01b1e29/8'
	export meta_host='vm-meta-261'

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

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
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
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--v55j5F79nlS0HElD
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
BOMAPBaxxGf7AgAAAAAEWVo=

--v55j5F79nlS0HElD--
