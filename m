Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8F5FA9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJKBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKBJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:09:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54014DD6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665450579; x=1696986579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TwFeT9gVM8IQp8QRv6c0RfA8XO2E/wxTYAQgJ5fBbEw=;
  b=KyguosYGKqraLjeYYdVo0T1g6fEm7t/VHHdMgaEMEKrJqVEHhxRKEHPq
   SxmzOKL9zWr8zdMVcYwaIA4cisi9hwvnPgMRR9TLzXxp9LCrU3sfC+juK
   jsyurBXnoEWOyFHjBUvGmjrCKS6AuS0bbqcH2N05FujQV2KBebuy4p2ae
   XJF5loC+TBmdbPFgKbawo7incwFLszenCpuzhSh3CnJbDK3DiBZpyIswa
   jaSg+8d6KOqjtbawAf+m5PXlXnEdEMo2jvKcJTLngsFO+lHhFuELTRFWm
   MeGVd6zTrJaKCFxb9oWf6IZ5naQQkHC+NCjkhGVKfWMxR9Pie4Yl3DIzI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284105179"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284105179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 18:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="657149161"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="657149161"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2022 18:09:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:09:37 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:09:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 18:09:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 18:09:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Jc6boVqLA7Rh5SDC5BlufUi30+vn2bGXHxhJyjNFvwRHYVyOligrlL4tmAHwmyBaUZi3WmR6Y31zs2yrfqYZfMU0DrKQ6Rg1TBDFjJoC8vzgHVlYAHq4uQjnfVy5KPaUHLPPXMYa8rcQ5GigSKNAOD4EWk4m38q6Jx7dbuAVfTcSRmI0AmmC0uPffDTBlWa5zsvQF820BKxCD7dQXxbf5tvudjaZPqQQJui12AeRcX/jbONeh/wWA9SS+n5FNlK2HMzAqHZk8BoBf4IPJIuLS1Q/Adggls5tVzfkKUEPrjQJCelTXmKFOd6nXObSrCnNUXfElj4lCmuBXaxeOpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFE/X+O4dvsoA4wR8yXvPweX6Xey5onHDO/8tC/rHDY=;
 b=L1HgswWbBuFg2rwk8gnK3wPEbpxBXoLy2tMYdxIRzUe17kn1rbiPlExCS/3clE32HeSsDddNjzELhBXApW7i/RsERj+srmAiZufXK6rHs8AgIt7NbDwPBZ10XS0SOF9oTYBTdTQHDhLmMCkWuBfVXUsLxPoDaH48+94ctRLDIXkVRswlnsf2dcbC2F1yhaIf06TX6Wo8fJq9ytayJtDtK6AGWoDqOc8ya/+E2w46Ltt6tFbChMzJTlt7L+QQh2HvCsI/2NLyknYrsqapZHBNqePpGFA3Vlhz3u5/0i7QXmXumGs5zJf6xbMBmYwUPVnicqGxMOCRtnblBflojS80eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 01:09:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 01:09:34 +0000
Date:   Tue, 11 Oct 2022 09:09:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0TCOKc7n38341eJ@feng-clx>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
X-ClientProxiedBy: PS2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:300:5c::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MN2PR11MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: 676380d5-4588-4b94-0748-08daab25424f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DT/ArEI4eEv0YIQymuqJc/Lh7W6TTc/NPm6edfi67mRoX1/ZKVuIx3elKPsHwNsx4V+H8Gue9ZUw/IRiYHYOajYQYZWNf5UnuDNKhdTo/0qLbXk5W6sD1UgKAbzAKmUHjpM8A7X1phRt1Xa5dCV7YafwJjYMAvJm1SgILrY/w1uvsXq2cHz0NUpalHfP60SQuNc8vXOYY1qmQ4OTGkjQXXEkx5tEsO6dglF8MGxRJakAKyKrZ/935oJEkH6GK5qQazxUd490OoA2Lh+CIZecYjiLimXlkKvZc9c6ieZZUZY8cH4CxA9Nb/g+bjdKY64rPQzKoRh4msZGlmia0y42vqD6zHWgcSl4t3NQdSvMO7XWE291EqD8alZ74/v6rIOncAB0mvUu6IhLFIQWx39hGOOWKG4p5Zy8ycu6e4mb/E8reNjwNWJ9hmuzDzOCsbyNweUupUGp/g4k454QbIU5wKbiz+vhZmV/3BAWLkYlj2c3DRWqhFhlMmaezbjsTfad+whKO3hjAcgF31sSHPXfOb1AHU1KOYn/aO5YkLmrtVaAT+OyVSvLv+9qBAZwfh1uqlfa1xqaIDWI9c+9e0+PjZB2vmFjYq2WQcAybraEtGOUBVaOBtj1SSWzo/g9MrGobafLt64K+bH/gCanbXlbm0PzqpOgwkBHNFSN96ebU3i5JwG8HQ1W6/XkVhluWJOyJZftmB/LQT2qWC5LP4C3Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(5660300002)(53546011)(6666004)(8936002)(6862004)(6512007)(9686003)(26005)(2906002)(6506007)(44832011)(316002)(6636002)(186003)(33716001)(54906003)(83380400001)(41300700001)(478600001)(4326008)(86362001)(8676002)(66476007)(66556008)(6486002)(66946007)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+ktGocAHdzpV4kziDbOeo2wXZkQd4QgMOYAMd8yj+RBP5CtLicUC1WpiqJJ?=
 =?us-ascii?Q?c/sbjDxnNDdQtTYM3tNActYyDlWritz4O8inU4vAFkvtBqYL931nq1iCl7Qb?=
 =?us-ascii?Q?sInPJBKM13aISqV7CysQ9k/i5K4/tpenSQ20KfQa+i0iKbW2Oj/L/o5jJYc5?=
 =?us-ascii?Q?0KBXetuVZlDf9szd1Zc1bmFkDMuDSQ2UD//msFv75ht88glPVhATPOAp2qrh?=
 =?us-ascii?Q?Y8qZGm6SrdDKrPHyYRBZqbfmPFynpmyhdyBZoj1tfpTRSROGdloyb5pac+1/?=
 =?us-ascii?Q?Mb3n0uCtVWFsRyqZURWaw4b9NWs2SavcTa75JhcJlZ4Z/1loFGnUDZZBJcH6?=
 =?us-ascii?Q?CSh/tR0enKxF85w0RZBGiG8+xjmvCZtjZ7IiAF3MghKAgBJg9pCwRSNMLyJR?=
 =?us-ascii?Q?6Ou4eC4MxQ5voX0BD0Z1+PwMhNlyKkG9qKhGmLG9c4kpSPM358U8Z7BtAODM?=
 =?us-ascii?Q?8x32C6unEoxtklnGa7GsF+SvQEbzm9h1/9SRlqjjBB7xNzmPhIkOK15sq15Y?=
 =?us-ascii?Q?sNY44KzheDCHTasnUEEfECYxpBmnHMLn52YkRP4Ffj5/5OlKAD1l2J0KF7ZL?=
 =?us-ascii?Q?LUTruhTZsrX4ziVlNle/Ftx5FpOx861Y/jYKy6fT7GnF/jwFViHO0BWqq/Ri?=
 =?us-ascii?Q?Os05PJ1r3BpEujNIkUpdTmT17N9gNtqtjRHVeiNV4ioc2uyzzkezVsMEoem/?=
 =?us-ascii?Q?Jq0TzXQMslnBXNyRqKmB2XK2k1aupE7siJGgIjREdW6fEFKylf9YNSoC90cn?=
 =?us-ascii?Q?fw3kyaEA8aIWtfsSqjC5uuZ05N48oOKA9p7mJZ6H3pvvCVtiAST4rEypyyk3?=
 =?us-ascii?Q?IQsfmWDT9Z8pzDmKdxeQQShXlrPmS9ZzxmCcOdCmLJzG16k/sIi1PrHoSPYr?=
 =?us-ascii?Q?d4Kr1oDX3KHurRp2PsTUdVAlYGnEc4x7cSlnCgnaw6H0G4QWAZaqMgOlhIE5?=
 =?us-ascii?Q?BQ9mNrNQC93xmIRh8kTpCYpvTNp28ayhrDQRooPqxuiHAvmJN/3gjEItCVLA?=
 =?us-ascii?Q?Epxff0JkS0/vt2n0ZZzO9+5Oo30CkQPDESTk0+kOBuOxZKZKPpU4VMUDq4Wq?=
 =?us-ascii?Q?rNmR+jpFQlr3AwFX70a7/iTjpYHQJoNLsXVxMTPbiJkLL58UhLd/8ZAv7tBw?=
 =?us-ascii?Q?1LYBYoC1mEaWvZD1G/vpfGZSceMTV25cX9zrkrkt6uhEfaJ6kJbmz9layMLZ?=
 =?us-ascii?Q?CeWyB6KLXUcNvdbFTsibAdtxLn4zvjt8lYe7z6ptDSSH2+eaTGMmqXoFOEJ2?=
 =?us-ascii?Q?qKTdH6/8WkagN8Bp0c6K9hU8Lsd7YOw0Kau6FfAXr3Bm6N0QOgrQqHMJmuqA?=
 =?us-ascii?Q?/urFvjRS3eEnra0ZZi62a+lb2N2qnWYNB1HbUA6J3khIgdmgUSusgamJYf92?=
 =?us-ascii?Q?6t4A7qRDeloBT9dxTmAty4zrbxo9+tbvHcw5a0MDLZKUOAwBVfu8cOU3pxYO?=
 =?us-ascii?Q?Rzkmsq61C6NZbLT6WUttmxD9DtxhXUQ9iyOZj2t532C50i5GpA+L9CFyIztw?=
 =?us-ascii?Q?6xwkztzU117G5EE5n1Ee7liRzBRasGkknczoTaWz0hfwI8CVKvrGAMs+m+6G?=
 =?us-ascii?Q?pHdzDRZZ89AuHcZBDXgiuFmxUyPEUHhkX120V+bn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 676380d5-4588-4b94-0748-08daab25424f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 01:09:34.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXFn8vnZMNMv3GjojpdfMFys76TjP0lQLtoq0ZJqIWUeA1gQDJzDCWMs779akJSk3uCfVOjAaj5nGxC5E2fqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:23:10AM -0700, Dave Hansen wrote:
> On 10/9/22 18:23, Feng Tang wrote:
> >>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> >>> index cafacb2e58cc..b4ea79cb1d1a 100644
> >>> --- a/arch/x86/kernel/tsc.c
> >>> +++ b/arch/x86/kernel/tsc.c
> >>> @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> >>>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >>>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >>>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> >>> -	    nr_online_nodes <= 2)
> >>> +	    nr_online_nodes <= 8)
> >> So you're saying all 8 socket systems since Broadwell (?) are TSC
> >> sync'ed ?
> > No, I didn't mean that. I haven't got chance to any 8 sockets
> > machine, and I got a report last month that on one 8S machine,
> > the TSC was judged 'unstable' by HPET as watchdog.
> 
> That's not a great check.  Think about numa=fake=4U, for instance.  Or a
> single-socket system with persistent memory and high bandwidth memory.
> 
> Basically 'nr_online_nodes' is a software construct.  It's going to be
> really hard to infer anything from it about what the _hardware_ is.

You are right! How to get the socket number was indeed a trouble when
I worked on commit b50db7095fe0, the problem is related to the
initialization order. This tsc check needs to be done in tsc_init(),
while the node_stats[] get initialized in later's call of smp_init().

For the case you mentioned above, I dug out some old logs which showed
its init order:

  numa=fake=4 on a SKL desktop
  ================
  [    0.000066] [tsc_early_init()]: nr_online_nodes = 1
  [    0.000068] [tsc_early_init()]: nr_cpu_nodes = 0
  [    0.000070] [tsc_early_init()]: nr_mem_nodes = 0
  [    0.104015] [tsc_init()]: nr_online_nodes = 4
  [    0.104019] [tsc_init()]: nr_cpu_nodes = 0
  [    0.104022] [tsc_init()]: nr_mem_nodes = 4
  [    0.124778] smp: Brought up 4 nodes, 4 CPUs
  [    0.760915] [init_tsc_clocksource()]: nr_online_nodes = 4
  [    0.760919] [init_tsc_clocksource()]: nr_cpu_nodes = 4
  [    0.760922] [init_tsc_clocksource()]: nr_mem_nodes = 4
  
  QEMU with 2 CPU-DRAM nodes + 2 Persistent memory nodes 
  ========================================================
  [    0.066651] [tsc_early_init()]: nr_online_nodes = 1
  [    0.067494] [tsc_early_init()]: nr_cpu_nodes = 0
  [    0.068288] [tsc_early_init()]: nr_mem_nodes = 0
  [    0.677694] [tsc_init()]: nr_online_nodes = 4
  [    0.678862] [tsc_init()]: nr_cpu_nodes = 0
  [    0.679962] [tsc_init()]: nr_mem_nodes = 4
  [    1.139240] [init_tsc_clocksource()]: nr_online_nodes = 4
  [    1.140576] [init_tsc_clocksource()]: nr_cpu_nodes = 2
  [    1.141823] [init_tsc_clocksource()]: nr_mem_nodes = 4
  [    1.660100] [kernel_init()]: nr_online_nodes = 4
  [    1.661234] [kernel_init()]: nr_cpu_nodes = 2
  [    1.662300] [kernel_init()]: nr_mem_nodes = 4

The 'nr_online_nodes' was chosed in the hope of that, in worse case
the patch is just a nop and won't wrongly lift the check.

One possible solution for this problem is to leverage the SRAT table
early init which is called before tsc_init(), and can provide CPU
nodes info. Will try this way.

Thanks,
Feng



