Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A374655CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiLYJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 04:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLYJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 04:43:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDDB5F44
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 01:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671961391; x=1703497391;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bJmOG8dkvi/Y4l/eXvOhjJS97fET/01xrwRs1dizpcE=;
  b=NZ1AmSNrPERs4ipQRU4xgO98RmtxxaEDT/+uDKLud49X81m6jSRBacuv
   WVCR6d2NER50PdK91ZgUUhbQj6TMmeBOtSB5RemP1Taah4e+y2fi8V7R/
   0wIkERAWtWnxtTDUi2YTm22QXUyOU9Y7a8KfwXtDzQ3kyTr2J/40oTXYr
   YW1u9jVmmxi074knOoknRSXa45ZwyG7m8RXxF0FV0/C/PaQAbfUUCk1pZ
   NwJM4FsvPFTpQVbqA4amspSqQiSvQ+cZ2/0PVctm7LbZah/pqZW7gShS8
   jj1IGfjKegKrW+QTFTcXE2keE4NVJjM/WByBfspmVLJSaxoyA+Ns+D0aj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="318130964"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="xz'?scan'208";a="318130964"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 01:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="715848741"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="xz'?scan'208";a="715848741"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 25 Dec 2022 01:43:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 25 Dec 2022 01:43:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 25 Dec 2022 01:43:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 25 Dec 2022 01:43:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 25 Dec 2022 01:43:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afhTH3rXFhf82S/oA1G5TOLGyAah/MS+g5MRojB8Xg5GQ2W7oO8EIRIlr0i+CpfeWC/0umycgabZ/ECJ+61PVxQL87NFUUJB+G+N50uU7LHaE8DCCaWuHIh31DOtGA6VFURAWwFE27wExDaEbWq+Q3maTKI40bcM3UpNiWMudf7Gya5IF4WMvN0e7iD88Z480VRSNwFlpK0Wd2K/q7m7Hby8U86ddCWXlL3MnlSFnzt1llDKYf025rtKjUCqXzYv9QHhkKxWoC4GJZkWdZASnrZcX8O3uKYs+ismb09TcydVHIHGZP04R3bon+NEGIE6vh/7tNiPDPFs2VsbT3SLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Gj8u2AP41S8UGhuTFzEc4Pf12AsSaLi9UhuG5mZb4Q=;
 b=FcrmL6PAqWnn6As6MOzhodw4Go8/RC9pnLVq6g2Gy9s4qoNbilsC0gj+fhfxVxgS2aQ1TCBsF0rRgM7wo8MbbFruTeDseaRz+KNtkWp+AAW0tAFILZyBQ7jB+26cbmvt47JquCXTiv0DZnNZjxs7pFuGO/O3c9qQLBsvA5ZZdEPA1AYtILJg3YuX9PAeXoOHJhOapvaLXLODRtDUmfiQfu+R+pTHpq0Ik+v6QHTH5VpaXIZjc0J5X9YBQf0vNxYVuJ0nqt08g2M7MFRpV1dE75Atj8cUQG6/VuenufmvJ6KFvTEN+84mcnF6WAxjzdVH9N/bTezTlT53lHPpR+AeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Sun, 25 Dec 2022 09:42:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%7]) with mapi id 15.20.5944.013; Sun, 25 Dec 2022
 09:42:59 +0000
Date:   Sun, 25 Dec 2022 17:42:50 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [linus:master] [kallsyms]  30f3bb0977:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/kallsyms.c
Message-ID: <202212251728.8d0872ff-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="yvuAPODNRlcJpI+v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aebdb6-10a4-4831-be49-08dae65c6816
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpVu9bEYWAxCDX18fWGyNQYEQcI/PBxUNbkNwisCeOrYcm12jkXly6Iep+R5JJbGq0hg8frVQ68HoyBmrgGcWDVcWC6dJXod9R8EAi5AhpRlSB1D/qpd3dsjzBh/qfRQG02aHTAvEWAAXyZ61zh9VY4hwrPOTPs5MSmNjDGzEyu8gR/Dwl/RvryqFZZvYFsGiMlhPsreIYFbme7K00YoAyaolcNelWFazbLY+g+puULhVzbyTDkQj6p4rDIjTfeseO+N2QLeP+5thdb+q3YRpbExo/TrYSHU2Tiizj90HE8Q4v8gzdKpimGcAaESFJrw9TsF7i1eXuiwl3kDXQvB/LLdaLXuuLcEkVHmGl1jt+SfHeYDREi3hCdQtaNMLROS3bM66SRxbdC2rdvzc4f0oZN3XVi7r0r9Om3se61s1Uab8gLZRhj5fHqveqAKoPkkhgky1i/F/ZdanI3ut5FAfL4JnX7+klGHfyL0uqEcJGBGSZbej6EnwubkD7RAgJ2dLGzSJUD21KFMGzie8hTNBtIrjNwnkSGNTH6lqF5176Cn6CCezhh12SXcPTc+naJE6qgDTn8qYQbiujoSBeJKMtvz4SFZ5zzrjsQ35PNVaL2ZoUUZzzi71aTRr/jxylvj9pDq14XDvY3M33mrMDIPd9mEOpfe+vl2O0iR2DxgdDS1p33tzm97IwyraxQH12mymQIc5z//pUk3S+slo9VH6LONbGsHTNtnAu/mKs9MdpxxES1jJ94p9GzHLDkewPY1gz4IgrEZFWDVJlpsGFG7xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6666004)(966005)(66556008)(478600001)(6486002)(66476007)(86362001)(316002)(26005)(186003)(45080400002)(6916009)(6512007)(2616005)(66946007)(6506007)(38100700002)(82960400001)(1076003)(8676002)(4326008)(41300700001)(2906002)(44144004)(30864003)(8936002)(83380400001)(36756003)(5660300002)(235185007)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CtJ/06BwMFaVHupmBT9tyw1dSn/dgSHfRkyZZKGYnXKgWS9Za00pQrm7Qftn?=
 =?us-ascii?Q?bhGfWjqPpl5cs5eyTR64+/yT4v8SrtPVOyk1yvGSPL2Rc7X70Ku5uzZe4LrV?=
 =?us-ascii?Q?TdV4xiR9YmdbRSZFrLZlYia5lKypKibipsRN6zHNPQnEo4OMXMOcJPd/QUz/?=
 =?us-ascii?Q?4OBVNOyDJ/oUhh62pXs0la88RgP5teO+5bTob8h/BJYh9y7nCDEZlBPkQ0Kj?=
 =?us-ascii?Q?6J71dxw89EBLPdd0PIsvnRWpGQP+94UkjymoEjA4QXXbv9j63Vmj0be0NVri?=
 =?us-ascii?Q?Gj97a5aqr2voBmYsCesOj/zghiIftBGZ7WSMvINACpv/B5MYoPXy4sxHiERV?=
 =?us-ascii?Q?7Rkev1H5GIXJw9INdtJYHJA5jy0npEQASy/P49L9u9zbGuhWDpXHPY+GFTj8?=
 =?us-ascii?Q?B63Qep95VYkyEanLjL/UerkSuKpaBUmxJIBYob8YC9uhnSm00MSwAB6yQLuO?=
 =?us-ascii?Q?6sAoXjGZa4wgTtf/QEngzvYtyrCAMFd8wywDGVCIAiGTt8dSo+VLWj/TKY8T?=
 =?us-ascii?Q?BCTY3j8y3m7GZw+4xUafL4LBvgLMYiRnsI6lSvVh4KKl/qTJiKrBUrji2OcC?=
 =?us-ascii?Q?4vq+OmuuV0f0rrSizL2fHFBZ7sQ61iWDmdhRm6pkKglKPiAjcBnF2prxvZKD?=
 =?us-ascii?Q?9is5gdqdBW212a/w5TRQxAyagK7ImB3brseeL2pJa5fuenqFqkP0gpXsilRm?=
 =?us-ascii?Q?0E9f6wBqvZP0gNKti+2FqoTJYT6q4X9gk7k3tu59olBn98mDxKniUB2k+5Cs?=
 =?us-ascii?Q?5yiHfOPpHTavGgI4c9F6iD5aWs42NxJDmFAcfVAzqlNB9XCPHbnL6I8UjuN5?=
 =?us-ascii?Q?D7U/mJNu6KaXXJGY69Ic/JOemxcZ0UWu5SvXZDWOe7NBHLZ1LMiSz6kXpRTG?=
 =?us-ascii?Q?gcWnSDWqxqydVCZy5s60qQFKJH+YonR5AkBwWKdJMvQr0dJ/kE4Bbet3lMu5?=
 =?us-ascii?Q?gk/AonqxYdcApFqBXFEhj6QVf8wYIC8nas1wQ88nDC99cchlUIQurZJVYzk0?=
 =?us-ascii?Q?VsojJ5bPhHyw1Yg5V7BVgTmCIU/g52fS1fl5q/qBPLpgizzbmyv+OhRBukoZ?=
 =?us-ascii?Q?fZp7YL/FVPJ3wffbWmwfkKdZRzzcBXJ8QAMxe68HnCktLaY0Ozs3A5Kw0bRU?=
 =?us-ascii?Q?EDz7UyEAlj6VpzuaRxmCBssRfNrOHCTk2jysxYM3RjdJoj4AUofCMTMsObp3?=
 =?us-ascii?Q?7FjFoei5rQZAEYMEThCXIxMGwHCwbUWW+D3tJqvy6NTW0uGxeidy6AWuamuK?=
 =?us-ascii?Q?sEXC+UILrNxSBnKXND9U2C1OHOB3jdcAm8NpfRjXagJcWpzTZhreHGl33J1X?=
 =?us-ascii?Q?rzWy7u0MS6SA37LWSiG7ZllqMwHt87RTZhcHtVCMjmV0RqV0lD8Q81qg3ldz?=
 =?us-ascii?Q?4OvdP/XZrAW2zXtMFOYf60K5+8J7zyRwal3dtDDXVmCqjNcO1KruYP1hAaOF?=
 =?us-ascii?Q?0L9g2qhu+aD29LYjBht2SJl2mQjwLhDEkuCWOI0c/bNEdLVqjCO89nLOfqWM?=
 =?us-ascii?Q?Lhqu9jlbVfrfAacyLOBIQ9LXPQJ2m+vqSP81HhSj3gdVfiuCb1+Jan3vE1Xu?=
 =?us-ascii?Q?DvK6K/QUv2mWkCmMQYlDwStpd9SzqzmjnsGCAd/GhzfzUOuDLHmbVeY7s2lk?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aebdb6-10a4-4831-be49-08dae65c6816
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 09:42:59.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMZcYzV6pgZ01voVC/9gmFsBI3P9JMDrBRTBAs383Lb7hF3Gzwq/8Lr6ssmDmP/N294AxPQPq7s42cpBGMnUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yvuAPODNRlcJpI+v
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:sleeping_function_called_from_invalid_context_at_kernel/kallsyms.c due to commit (built with gcc-11):

commit: 30f3bb09778de64ef9f23fb4bb5f868c4728a071 ("kallsyms: Add self-test facility")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master e45fb347b630ee76482fe938ba76cf8eab811290]

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202212251728.8d0872ff-oliver.sang@intel.com


[  296.591291][   T94] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
[  296.593681][   T94] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 94, name: kallsyms_test
[  296.596102][   T94] preempt_count: 0, expected: 0
[  296.598141][   T94] no locks held by kallsyms_test/94.
[  296.600262][   T94] irq event stamp: 3417486
[ 296.602249][ T94] hardirqs last enabled at (3417485): __up_console_sem (printk.c:?) 
[ 296.604738][ T94] hardirqs last disabled at (3417486): test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?) 
[ 296.607395][ T94] softirqs last enabled at (3417468): __do_softirq (??:?) 
[ 296.609876][ T94] softirqs last disabled at (3417445): call_on_stack (irq_32.c:?) 
[  296.612357][   T94] CPU: 0 PID: 94 Comm: kallsyms_test Not tainted 6.1.0-rc4-00305-g30f3bb09778d #1 3b214fee31cbe937ecaf44a673d9d82d04570a37
[  296.615262][   T94] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[  296.617998][   T94] Call Trace:
[ 296.620022][ T94] dump_stack_lvl (??:?) 
[ 296.622163][ T94] dump_stack (??:?) 
[ 296.624205][ T94] __might_resched (??:?) 
[ 296.626329][ T94] ? lookup_name (kallsyms_selftest.c:?) 
[ 296.628326][ T94] kallsyms_on_each_symbol (??:?) 
[ 296.630531][ T94] ? desc_read (printk_ringbuffer.c:?) 
[ 296.632566][ T94] ? desc_read_finalized_seq (printk_ringbuffer.c:?) 
[ 296.634809][ T94] ? mark_lock+0x2f/0x10f 
[ 296.636894][ T94] ? lock_is_held (signal.c:?) 
[ 296.638951][ T94] ? rcu_read_lock_any_held (??:?) 
[ 296.641070][ T94] ? lookup_chain_cache (lockdep.c:?) 
[ 296.642990][ T94] ? validate_chain (lockdep.c:?) 
[ 296.644899][ T94] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 296.646928][ T94] ? desc_read (printk_ringbuffer.c:?) 
[ 296.648772][ T94] ? desc_read_finalized_seq (printk_ringbuffer.c:?) 
[ 296.650719][ T94] ? prb_read (printk_ringbuffer.c:?) 
[ 296.652544][ T94] ? desc_read (printk_ringbuffer.c:?) 
[ 296.654362][ T94] ? _prb_read_valid (printk_ringbuffer.c:?) 
[ 296.656271][ T94] ? prb_read_valid (??:?) 
[ 296.658113][ T94] ? console_unlock (??:?) 
[ 296.660000][ T94] ? irq_work_queue (??:?) 
[ 296.661824][ T94] ? __wake_up_klogd+0x30/0x40 
[ 296.663825][ T94] ? wake_up_klogd (??:?) 
[ 296.665652][ T94] ? vprintk_emit (??:?) 
[ 296.667406][ T94] ? vprintk_default (??:?) 
[ 296.669131][ T94] ? vprintk (??:?) 
[ 296.670713][ T94] ? kvm_clock_read (kvmclock.c:?) 
[ 296.672390][ T94] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?) 
[ 296.674225][ T94] test_entry (kallsyms_selftest.c:?) 
[ 296.675660][ T94] kthread (kthread.c:?) 
[ 296.677142][ T94] ? find_symbol (kallsyms_selftest.c:?) 
[ 296.678689][ T94] ? kthread_complete_and_exit (kthread.c:?) 
[ 296.680299][ T94] ret_from_fork (??:?) 
[  296.808624][   T94] ------------[ cut here ]------------
[  296.810326][   T94] raw_local_irq_restore() called with IRQs enabled
[ 296.812238][ T94] WARNING: CPU: 0 PID: 94 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore (??:?) 
[  296.814348][   T94] Modules linked in: input_leds crc32_pclmul floppy evdev qemu_fw_cfg
[  296.816465][   T94] CPU: 0 PID: 94 Comm: kallsyms_test Tainted: G        W          6.1.0-rc4-00305-g30f3bb09778d #1 3b214fee31cbe937ecaf44a673d9d82d04570a37
[  296.819114][   T94] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 296.821303][ T94] EIP: warn_bogus_irq_restore (??:?) 
[ 296.823022][ T94] Code: 00 10 00 00 31 d2 31 c9 e9 5b b4 00 00 80 3d 1f 8c b0 c2 00 75 1f 55 89 e5 68 66 c0 1f c2 c6 05 1f 8c b0 c2 01 e8 c7 68 fe ff <0f> 0b 58 c9 31 c0 e9 33 b4 00 00 31 c0 e9 2c b4 00 00 55 89 e5 56
All code
========
   0:	00 10                	add    %dl,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	31 d2                	xor    %edx,%edx
   6:	31 c9                	xor    %ecx,%ecx
   8:	e9 5b b4 00 00       	jmpq   0xb468
   d:	80 3d 1f 8c b0 c2 00 	cmpb   $0x0,-0x3d4f73e1(%rip)        # 0xffffffffc2b08c33
  14:	75 1f                	jne    0x35
  16:	55                   	push   %rbp
  17:	89 e5                	mov    %esp,%ebp
  19:	68 66 c0 1f c2       	pushq  $0xffffffffc21fc066
  1e:	c6 05 1f 8c b0 c2 01 	movb   $0x1,-0x3d4f73e1(%rip)        # 0xffffffffc2b08c44
  25:	e8 c7 68 fe ff       	callq  0xfffffffffffe68f1
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	58                   	pop    %rax
  2d:	c9                   	leaveq 
  2e:	31 c0                	xor    %eax,%eax
  30:	e9 33 b4 00 00       	jmpq   0xb468
  35:	31 c0                	xor    %eax,%eax
  37:	e9 2c b4 00 00       	jmpq   0xb468
  3c:	55                   	push   %rbp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	58                   	pop    %rax
   3:	c9                   	leaveq 
   4:	31 c0                	xor    %eax,%eax
   6:	e9 33 b4 00 00       	jmpq   0xb43e
   b:	31 c0                	xor    %eax,%eax
   d:	e9 2c b4 00 00       	jmpq   0xb43e
  12:	55                   	push   %rbp
  13:	89 e5                	mov    %esp,%ebp
  15:	56                   	push   %rsi
[  296.827435][   T94] EAX: 00000000 EBX: 00000200 ECX: 00000000 EDX: 00000000
[  296.829481][   T94] ESI: 1ba482a7 EDI: 00000045 EBP: ec7b5e44 ESP: ec7b5e40
[  296.831524][   T94] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
[  296.833568][   T94] CR0: 80050033 CR2: b7f9b178 CR3: 2b828000 CR4: 00040690
[  296.835567][   T94] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  296.837569][   T94] DR6: fffe0ff0 DR7: 00000400
[  296.839224][   T94] Call Trace:
[ 296.840731][ T94] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?) 
[ 296.842731][ T94] test_entry (kallsyms_selftest.c:?) 
[ 296.844314][ T94] kthread (kthread.c:?) 
[ 296.845867][ T94] ? find_symbol (kallsyms_selftest.c:?) 
[ 296.847545][ T94] ? kthread_complete_and_exit (kthread.c:?) 
[ 296.849401][ T94] ret_from_fork (??:?) 
[  296.851088][   T94] irq event stamp: 3417903
[ 296.852761][ T94] hardirqs last enabled at (3417915): __up_console_sem (printk.c:?) 
[ 296.854950][ T94] hardirqs last disabled at (3417928): __up_console_sem (printk.c:?) 
[ 296.856940][ T94] softirqs last enabled at (3417888): __do_softirq (??:?) 
[ 296.859047][ T94] softirqs last disabled at (3417879): call_on_stack (irq_32.c:?) 
[  296.861227][   T94] ---[ end trace 0000000000000000 ]---
[  296.863011][   T94] kallsyms_selftest: kallsyms_on_each_symbol() traverse all: 217308966 ns
[  296.865205][   T94] kallsyms_selftest: kallsyms_on_each_match_symbol() traverse all: 30537 ns
[  296.867362][   T94] kallsyms_selftest: finish
[  298.261272][   T39] rcu-torture: rcu_torture_read_exit: Start of episode
[  302.550643][   T39] rcu-torture: rcu_torture_read_exit: End of episode
[  307.941285][   T35] rcu-torture: rtc: c337bcc4 ver: 9533 tfle: 0 rta: 9534 rtaf: 0 rtf: 9524 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1612 barrier: 0/0:0 read-exits: 272 nocb-toggles: 0:0
[  307.946249][   T35] rcu-torture: Reader Pipe:  697782 0 0 0 0 0 0 0 0 0 0
[  307.948593][   T35] rcu-torture: Reader Batch:  697782 0 0 0 0 0 0 0 0 0 0
[  307.950927][   T35] rcu-torture: Free-Block Circulation:  9533 9532 9531 9530 9529 9528 9527 9526 9525 9524 0
[  316.367995][   T39] rcu-torture: rcu_torture_read_exit: Start of episode
[  316.383065][   T39] rcu-torture: rcu_torture_read_exit: End of episode
[  329.674553][   T39] rcu-torture: rcu_torture_read_exit: Start of episode
[  329.688244][   T39] rcu-torture: rcu_torture_read_exit: End of episode
[  343.088028][   T39] rcu-torture: rcu_torture_read_exit: Start of episode
[  343.105552][   T39] rcu-torture: rcu_torture_read_exit: End of episode
[  354.021259][   T38] rcu_torture_fwd_prog n_max_cbs: 1667
[  354.023716][   T38] rcu_torture_fwd_prog: Starting forward-progress test 0
[  354.026110][   T38] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
[ 354.049763][ T38] rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x32() 0 
[  354.061725][   T38] rcu_torture_fwd_prog_cr Duration 6 barrier: 4 pending 104 n_launders: 1480 n_launders_sa: 103 n_max_gps: 100 n_max_cbs: 1350 cver 0 gps 0
[  354.065954][   T38] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 11 jiffies): 1s/10: 2830:0

Kboot worker: lkp-worker64
Elapsed time: 360

kvm=(
qemu-system-x86_64
-enable-kvm
-cpu SandyBridge
-kernel $kernel
-initrd initrd-vm-meta-259.cgz
-m 16384
-smp 2
-device e1000,netdev=net0
-netdev user,id=net0,hostfwd=tcp::32032-:22
-boot order=nc
-no-reboot
-device i6300esb
-watchdog-action debug
-rtc base=localtime
-serial stdio
-display none
-monitor null
)

append=(
ip=::::vm-meta-259::dhcp
root=/dev/ram0
RESULT_ROOT=/result/boot/300/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/3
BOOT_IMAGE=/pkg/linux/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/vmlinuz-6.1.0-rc4-00305-g30f3bb09778d
branch=linus/master
job=/job-script
user=lkp
ARCH=i386
kconfig=i386-randconfig-a001-20221219
commit=30f3bb09778de64ef9f23fb4bb5f868c4728a071
vmalloc=256M
initramfs_async=0
page_owner=on
initcall_debug
max_uptime=600
result_service=tmpfs
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
rw
rcuperf.shutdown=0
watchdog_thresh=240
)

"${kvm[@]}" -append "${append[*]}"


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc4-00305-g30f3bb09778d .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--yvuAPODNRlcJpI+v
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc4-00305-g30f3bb09778d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.1.0-rc4 Kernel Configuration
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
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_BZIP2=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
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
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
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
CONFIG_KALLSYMS_SELFTEST=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
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
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_QUARK=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
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
# CONFIG_MVIAC7 is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_TOSHIBA=y
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_USERSPACE_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=m
# CONFIG_ACPI_DOCK is not set
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=m
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_CONFIGFS=m
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
# CONFIG_BXT_WC_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_APM is not set

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
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=m
CONFIG_CPUFREQ_DT_PLATDEV=y
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_GX_SUSPMOD=y
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_OLPC=y
# CONFIG_OLPC_XO1_PM is not set
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
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

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
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
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
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
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
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
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="842"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
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
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
# CONFIG_BOUNCE is not set
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ZONE_DMA=y
CONFIG_GET_FREE_REGION=y
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
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
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
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
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
CONFIG_PCIE_CADENCE_PLAT_EP=y
CONFIG_PCI_J721E=y
# CONFIG_PCI_J721E_HOST is not set
CONFIG_PCI_J721E_EP=y
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=m
# CONFIG_CXL_MEM is not set
CONFIG_CXL_PORT=m
CONFIG_CXL_REGION=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
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
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=m
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=m
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
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_SMI=y
CONFIG_GOOGLE_COREBOOT_TABLE=m
CONFIG_GOOGLE_MEMCONSOLE=m
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
# CONFIG_GOOGLE_VPD is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
# CONFIG_GNSS_UBX_SERIAL is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_ZSTD=y
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="zstd"
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_UBLK=y

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_AUTH=y
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
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_CS5535_MFGPT is not set
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_OPEN_DICE=m
CONFIG_VCPU_STALL_DETECTOR=m
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_GSC=m
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_INTEL_MEI_PXP=y
CONFIG_VMWARE_VMCI=y
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
# CONFIG_PVPANIC_PCI is not set
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
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_DWC=y
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_INIC162X=m
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=m
# CONFIG_TCM_PSCSI is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NET is not set
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
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
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
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
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
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
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
# CONFIG_QCA7000_SPI is not set
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
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
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
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
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
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
CONFIG_KEYBOARD_ADP5588=m
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_APPLESPI=m
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PINEPHONE=y
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_IQS62X=m
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=y
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_CAP11XX=y
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_CYPRESS_SF=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=y
CONFIG_TOUCHSCREEN_ADS7846=y
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_ADC is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMA140=m
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=m
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_HTCPEN is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
# CONFIG_TOUCHSCREEN_PCAP is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_STMPE=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
CONFIG_TOUCHSCREEN_SX8654=m
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_88PM80X_ONKEY is not set
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ATC260X_ONKEY=m
CONFIG_INPUT_ATMEL_CAPTOUCH=m
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_MAX77650_ONKEY=m
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_CPCAP_PWRBUTTON=m
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_TPS65218_PWRBUTTON=m
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA7280_HAPTICS=y
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_PCAP=y
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IBM_PANEL=m
CONFIG_INPUT_IQS269A=m
CONFIG_INPUT_IQS626A=y
CONFIG_INPUT_IQS7222=y
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_INPUT_RT5120_PWRKEY=m
CONFIG_INPUT_STPMIC1_ONKEY=m
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
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
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
CONFIG_HYPERV_KEYBOARD=m
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
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
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=m
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_SPRD=m
CONFIG_SERIAL_LITEUART=m
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_DTLK is not set
CONFIG_APPLICOM=m
CONFIG_SONYPI=m
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
# CONFIG_XILLYBUS_OF is not set
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
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=m
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PCI1XXXX=y
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
CONFIG_MIPI_I3C_HCI=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_ALTERA_CORE=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
CONFIG_SPI_CADENCE_XSPI=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_FSI=m
CONFIG_SPI_NXP_FLEXSPI=m
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_INTEL=y
CONFIG_SPI_INTEL_PCI=y
CONFIG_SPI_INTEL_PLATFORM=y
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_MICROCHIP_CORE=y
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
CONFIG_SPI_LANTIQ_SSC=m
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=m
CONFIG_SPI_MXIC=m
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=m

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
# CONFIG_PTP_1588_CLOCK_PCH is not set
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
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AS3722=m
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MAX77620=m
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_RK805=m
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_LOCHNAGAR is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_METEORLAKE is not set
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
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_ICH=m
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=y
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD71815=m
CONFIG_GPIO_BD71828=m
# CONFIG_GPIO_BD9571MWV is not set
# CONFIG_GPIO_CS5535 is not set
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_MAX77650=m
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_WHISKEY_COVE=m
CONFIG_GPIO_WM8350=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=m
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
# CONFIG_GPIO_MOXTET is not set
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_ATC260X=m
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_REGULATOR=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_TPS65086=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CPCAP=m
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_OLPC=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
# CONFIG_CHARGER_88PM860X is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_BATTERY_RX51=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=m
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=m
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_MT6370=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_RK817 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_RN5T618_POWER=m
CONFIG_BATTERY_UG3105=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=m
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=y
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DRIVETEMP=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX31760=y
CONFIG_SENSORS_MAX6620=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=m
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_SENSORS_PECI=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=m
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX15301=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=m
CONFIG_SENSORS_PIM4328=m
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
# CONFIG_SENSORS_STPDDC60 is not set
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_TPS546D24=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE152=m
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC2305=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=m
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM8350 is not set
# CONFIG_SENSORS_XGENE is not set
# CONFIG_SENSORS_INTEL_M10_BMC_HWMON is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_SENSORS_ASUS_WMI=m
CONFIG_SENSORS_ASUS_EC=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
# CONFIG_CPU_FREQ_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=m
CONFIG_MAX77620_THERMAL=y
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set
CONFIG_INTEL_QUARK_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=m
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=y
CONFIG_RETU_WATCHDOG=m
CONFIG_STPMIC1_WATCHDOG=y
CONFIG_ACQUIRE_WDT=m
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=y
# CONFIG_SCx200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=m
CONFIG_SBC7240_WDT=m
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
CONFIG_NI903X_WDT=m
# CONFIG_NIC7018_WDT is not set
# CONFIG_SIEMENS_SIMATIC_IPC_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=m
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=m
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77714=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6370=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_OCELOT=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=m
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RT5120=m
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
CONFIG_STMPE_SPI=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=m
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD71828=m
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
CONFIG_MFD_QCOM_PM8008=m
CONFIG_RAVE_SP_CORE=m
CONFIG_MFD_INTEL_M10_BMC=y
CONFIG_MFD_RSMU_I2C=m
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=m
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_BD71815=m
CONFIG_REGULATOR_BD71828=m
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CPCAP is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9121 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=m
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
# CONFIG_REGULATOR_MAX77650 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX8998 is not set
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=m
CONFIG_REGULATOR_MPQ7920=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6370=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
CONFIG_REGULATOR_RK808=m
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT4801=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5120=m
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=m
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM8350=y
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_SECO=y
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

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
# CONFIG_VIDEO_DEV is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
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

#
# Media capture/analog TV support
#

#
# Media capture/analog/hybrid TV support
#

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
# CONFIG_DVB_DDBRIDGE is not set
# CONFIG_DVB_NGENE is not set
# CONFIG_DVB_PLUTO2 is not set
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set

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

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
# CONFIG_MEDIA_TUNER_XC5000 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
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
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_PXP=y
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
CONFIG_DRM_VMWGFX_MKSSTATS=y
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
CONFIG_DRM_RCAR_USE_MIPI_DSI=y
CONFIG_DRM_QXL=y
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_DSI_CM=m
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_EDP=y
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9341=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
CONFIG_DRM_PANEL_JDI_R63452=m
CONFIG_DRM_PANEL_KHADAS_TS050=y
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=m
CONFIG_DRM_PANEL_NEWVISION_NV3052C=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35950=y
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6D27A1=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=y
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
CONFIG_DRM_PANEL_TPO_TPG110=y
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHIPONE_ICN6211=y
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
CONFIG_DRM_LONTIUM_LT9211=m
CONFIG_DRM_LONTIUM_LT9611=y
CONFIG_DRM_LONTIUM_LT9611UXC=m
# CONFIG_DRM_ITE_IT66121 is not set
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=m
# CONFIG_DRM_NXP_PTN3460 is not set
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=m
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=m
CONFIG_DRM_TOSHIBA_TC358775=y
CONFIG_DRM_TI_DLPC3433=m
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI83=y
CONFIG_DRM_TI_SN65DSI86=m
# CONFIG_DRM_TI_TPD12S015 is not set
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7511_CEC is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_IMX_LCDIF=y
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_PANEL_MIPI_DBI is not set
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9163=y
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_SSD130X is not set
CONFIG_DRM_HYPERV=m
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
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_GEODE=y
# CONFIG_FB_GEODE_LX is not set
CONFIG_FB_GEODE_GX=y
# CONFIG_FB_GEODE_GX1 is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_HYPERV is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_MT6370 is not set
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=m
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
CONFIG_HID_VIVALDI_COMMON=m
CONFIG_HID_VIVALDI=m
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NINTENDO=m
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=m
# CONFIG_PLAYSTATION_FF is not set
CONFIG_HID_PXRC=m
CONFIG_HID_RAZER=m
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=m
CONFIG_HID_SEMITEK=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_TOPRE=y
CONFIG_HID_THINGM=m
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=m
CONFIG_I2C_HID_OF=m
CONFIG_I2C_HID_OF_ELAN=m
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=m
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
# CONFIG_MMC_BLOCK is not set
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set
CONFIG_MMC_CRYPTO=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=m
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_SDHCI_MILBEAUT=m
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MMC_SDHCI_OMAP=m
CONFIG_MMC_SDHCI_AM654=m
CONFIG_MMC_LITEX=m
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_CRYPTO is not set
CONFIG_SCSI_UFS_HPB=y
CONFIG_SCSI_UFS_FAULT_INJECTION=y
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_CDNS_PLATFORM=m
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AN30259A=y
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=m
CONFIG_LEDS_CR0014114=m
CONFIG_LEDS_EL15203000=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77650=m
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MT6360=m
CONFIG_LEDS_RT4505=m
CONFIG_LEDS_RT8515=m
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_LEDS_SIEMENS_SIMATIC_IPC=y
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SERIALIO=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=y
CONFIG_SPEAKUP_SYNTH_ACNTPC=y
CONFIG_SPEAKUP_SYNTH_APOLLO=y
CONFIG_SPEAKUP_SYNTH_AUDPTR=y
# CONFIG_SPEAKUP_SYNTH_BNS is not set
CONFIG_SPEAKUP_SYNTH_DECTLK=y
CONFIG_SPEAKUP_SYNTH_DECEXT=y
# CONFIG_SPEAKUP_SYNTH_DECPC is not set
CONFIG_SPEAKUP_SYNTH_DTLK=m
# CONFIG_SPEAKUP_SYNTH_KEYPC is not set
CONFIG_SPEAKUP_SYNTH_LTLK=y
CONFIG_SPEAKUP_SYNTH_SOFT=y
CONFIG_SPEAKUP_SYNTH_SPKOUT=m
# CONFIG_SPEAKUP_SYNTH_TXPRT is not set
CONFIG_SPEAKUP_SYNTH_DUMMY=m
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
CONFIG_EDAC_E752X=m
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
# CONFIG_RTC_DRV_88PM80X is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_AS3722=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8998=y
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_MAX77686=m
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RK808=m
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=m
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BD70528=m
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=m
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_RC5T619=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=m
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_PCF50633=m
CONFIG_RTC_DRV_ZYNQMP=m
# CONFIG_RTC_DRV_NTXEC is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_PCAP=y
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_R7301=m
CONFIG_RTC_DRV_CPCAP=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=m
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_IMG_ASCII_LCD=m
CONFIG_HT16K33=y
CONFIG_LCD2S=y
# CONFIG_PARPORT_PANEL is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=m
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
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
CONFIG_ADIS16203=m
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=m
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set
# CONFIG_ADE7854_SPI is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=m
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m
CONFIG_STAGING_MEDIA=y
# CONFIG_INTEL_ATOMISP is not set
CONFIG_STAGING_MEDIA_DEPRECATED=y
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_FB_TFT=y
# CONFIG_FB_TFT_AGM1264K_FL is not set
CONFIG_FB_TFT_BD663474=m
CONFIG_FB_TFT_HX8340BN=m
CONFIG_FB_TFT_HX8347D=y
CONFIG_FB_TFT_HX8353D=m
CONFIG_FB_TFT_HX8357D=m
CONFIG_FB_TFT_ILI9163=m
CONFIG_FB_TFT_ILI9320=m
CONFIG_FB_TFT_ILI9325=y
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
CONFIG_FB_TFT_ILI9481=m
CONFIG_FB_TFT_ILI9486=m
# CONFIG_FB_TFT_PCD8544 is not set
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=m
CONFIG_FB_TFT_S6D1121=m
CONFIG_FB_TFT_SEPS525=m
CONFIG_FB_TFT_SH1106=m
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=m
CONFIG_FB_TFT_SSD1331=m
CONFIG_FB_TFT_SSD1351=y
# CONFIG_FB_TFT_ST7735R is not set
CONFIG_FB_TFT_ST7789V=y
# CONFIG_FB_TFT_TINYLCD is not set
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=m
CONFIG_FB_TFT_UC1701=m
# CONFIG_FB_TFT_UPD161704 is not set
CONFIG_MOST_COMPONENTS=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_FIRMWARE is not set
CONFIG_GREYBUS_HID=m
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
# CONFIG_GREYBUS_PWM is not set
CONFIG_GREYBUS_SDIO=m
CONFIG_GREYBUS_SPI=m
# CONFIG_GREYBUS_UART is not set
CONFIG_PI433=m
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=m
CONFIG_SURFACE_HOTPLUG=m
CONFIG_SURFACE_PRO3_BUTTON=y
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
CONFIG_HUAWEI_WMI=m
CONFIG_MXM_WMI=m
CONFIG_PEAQ_WMI=y
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=y
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=m
# CONFIG_ACER_WMI is not set
CONFIG_AMD_PMF=m
# CONFIG_AMD_PMC is not set
CONFIG_ADV_SWBUTTON=y
# CONFIG_APPLE_GMUX is not set
CONFIG_ASUS_LAPTOP=y
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=y
# CONFIG_ASUS_NB_WMI is not set
CONFIG_ASUS_TF103C_DOCK=m
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
CONFIG_WIRELESS_HOTKEY=m
# CONFIG_HP_WMI is not set
# CONFIG_TC1100_WMI is not set
# CONFIG_IBM_RTL is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_THINKPAD_ACPI=y
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_THINKPAD_LMI=m
CONFIG_INTEL_ATOMISP2_PDX86=y
# CONFIG_INTEL_ATOMISP2_LED is not set
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_INTEL_SAR_INT1092=y
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=m
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=y
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_BXTWC_PMIC_TMU=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_VSEC=m
CONFIG_MSI_WMI=m
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=m
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SYSTEM76_ACPI=y
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_SERIAL_MULTI_INSTANTIATE=m
CONFIG_MLX_PLATFORM=y
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_X86_ANDROID_TABLETS is not set
CONFIG_FW_ATTR_CLASS=m
CONFIG_INTEL_IMR=y
CONFIG_INTEL_IPS=m
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_INTEL_SCU_IPC_UTIL is not set
CONFIG_SIEMENS_SIMATIC_IPC=y
CONFIG_WINMATE_FM07_KEYS=m
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_RS9_PCIE=m
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=m
CONFIG_COMMON_CLK_BD718XX=m
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
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
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL355=m
CONFIG_ADXL355_I2C=m
CONFIG_ADXL355_SPI=m
CONFIG_ADXL367=m
CONFIG_ADXL367_SPI=m
CONFIG_ADXL367_I2C=m
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA220=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMA400_SPI=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MSA311=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
CONFIG_SCA3300=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7091R5 is not set
CONFIG_AD7124=m
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
CONFIG_AD7280=m
# CONFIG_AD7291 is not set
CONFIG_AD7292=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
CONFIG_AD7766=m
# CONFIG_AD7768_1 is not set
CONFIG_AD7780=m
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
CONFIG_AD7949=m
# CONFIG_AD799X is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_CPCAP_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_LP8788_ADC=m
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=m
CONFIG_LTC2496=m
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=m
CONFIG_MAX11100=m
# CONFIG_MAX1118 is not set
# CONFIG_MAX11205 is not set
CONFIG_MAX1241=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
CONFIG_MCP3422=m
CONFIG_MCP3911=m
CONFIG_MEDIATEK_MT6360_ADC=m
CONFIG_NAU7802=m
# CONFIG_PALMAS_GPADC is not set
CONFIG_RN5T618_ADC=m
CONFIG_RICHTEK_RTQ6056=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STMPE_ADC=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8344 is not set
CONFIG_TI_ADS8688=m
CONFIG_TI_ADS124S08=m
CONFIG_TI_ADS131E08=m
CONFIG_TI_TLC4541=m
# CONFIG_TI_TSC2046 is not set
CONFIG_TWL4030_MADC=m
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=m
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=m
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
CONFIG_ADA4250=m
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_PMS7003=m
# CONFIG_SCD30_CORE is not set
CONFIG_SCD4X=m
CONFIG_SENSIRION_SGP30=m
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
CONFIG_SPS30_SERIAL=m
CONFIG_SENSEAIR_SUNRISE_CO2=m
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD3552R=m
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
# CONFIG_LTC2688 is not set
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
CONFIG_AD5696_I2C=m
CONFIG_AD5755=m
CONFIG_AD5758=m
# CONFIG_AD5761 is not set
CONFIG_AD5764=m
# CONFIG_AD5766 is not set
CONFIG_AD5770R=m
CONFIG_AD5791=m
CONFIG_AD7293=m
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
CONFIG_LTC1660=m
# CONFIG_LTC2632 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=m
CONFIG_TI_DAC7612=m
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
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
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
CONFIG_ADF4371=m
# CONFIG_ADMV1013 is not set
CONFIG_ADMV4420=m
CONFIG_ADRF6780=m
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
CONFIG_ADXRS290=m
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
# CONFIG_IIO_ST_GYRO_SPI_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
CONFIG_ADIS16475=m
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_SERIAL=m
CONFIG_BOSCH_BNO055_I2C=m
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=m
CONFIG_AL3010=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_AS73211=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
CONFIG_IQS621_ALS=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_LTRF216A=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_MAX44009=m
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2591=m
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
CONFIG_YAMAHA_YAS530=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
CONFIG_MCP4018=m
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=m
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_IIO_ST_PRESS_SPI is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
CONFIG_PING=m
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX_COMMON=m
# CONFIG_SX9310 is not set
CONFIG_SX9324=m
CONFIG_SX9360=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
CONFIG_LTC2983=m
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TMP117 is not set
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=m
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_NTXEC is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_XILINX_INTC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_TI_SYSCON is not set
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
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=m
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_CADENCE_SALVO=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=m
CONFIG_USB4_DEBUGFS_WRITE=y
# CONFIG_USB4_DEBUGFS_MARGINING is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RAVE_SP_EEPROM=m
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
# CONFIG_FSI_SBEFIFO is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_ADGS1408=m
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=m
CONFIG_MOST=y
CONFIG_MOST_CDEV=m
CONFIG_PECI=m
CONFIG_PECI_CPU=m
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
CONFIG_EROFS_FS_XATTR=y
# CONFIG_EROFS_FS_POSIX_ACL is not set
# CONFIG_EROFS_FS_SECURITY is not set
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
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
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_UNICODE=m
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ARIA=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=m
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
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

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_SERPENT_SSE2_586=m
# CONFIG_CRYPTO_TWOFISH_586 is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=y
CONFIG_CRYPTO_DEV_HIFN_795X=m
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_4XXX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
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
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
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
CONFIG_CORDIC=m
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
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
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
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=m
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
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
CONFIG_SIGNATURE=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_MEMREGION=y
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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
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
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
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
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
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
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
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
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
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
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_LATENCYTOP is not set
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
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FPROBE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
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
CONFIG_EFI_PGT_DUMP=y
CONFIG_DEBUG_TLBFLUSH=y
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
# CONFIG_DEBUG_IMR_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_TEST_DYNAMIC_DEBUG=y
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--yvuAPODNRlcJpI+v
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot-300s.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='30f3bb09778de64ef9f23fb4bb5f868c4728a071'
	export kconfig='i386-randconfig-a001-20221219'
	export repeat_to=6
	export nr_vm=300
	export submit_id='63a2b7a52228061c0c77b585'
	export job_file='/lkp/jobs/scheduled/vm-meta-259/boot-300-debian-11.1-i386-20220923.cgz-30f3bb09778de64ef9f23fb4bb5f868c4728a071-20221221-7180-9sbwm5-4.yaml'
	export id='f660bafa15868b8198e26b0548c9292ac0a87ddf'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-12-21 15:37:09 +0800'
	export _id='63a2b7be2228061c0c77b586'
	export _rt='/result/boot/300/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/300/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/3'
	export scheduler_version='/lkp/lkp/.src-20221220-161748'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/300/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/3
BOOT_IMAGE=/pkg/linux/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/vmlinuz-6.1.0-rc4-00305-g30f3bb09778d
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-259/boot-300-debian-11.1-i386-20220923.cgz-30f3bb09778de64ef9f23fb4bb5f868c4728a071-20221221-7180-9sbwm5-4.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a001-20221219
commit=30f3bb09778de64ef9f23fb4bb5f868c4728a071
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
max_uptime=600
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
	export modules_initrd='/pkg/linux/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.EIP:warn_bogus_irq_restore'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-259'
	export kernel='/pkg/linux/i386-randconfig-a001-20221219/gcc-11/30f3bb09778de64ef9f23fb4bb5f868c4728a071/vmlinuz-6.1.0-rc4-00305-g30f3bb09778d'
	export dequeue_time='2022-12-21 15:37:48 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-259/boot-300-debian-11.1-i386-20220923.cgz-30f3bb09778de64ef9f23fb4bb5f868c4728a071-20221221-7180-9sbwm5-4.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 300
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--yvuAPODNRlcJpI+v
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAAAARZWg==

--yvuAPODNRlcJpI+v--
