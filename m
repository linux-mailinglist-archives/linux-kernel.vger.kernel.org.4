Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330426B8834
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCNCOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCNCOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:14:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C4486DDF;
        Mon, 13 Mar 2023 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678760069; x=1710296069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FCXw75sdfX8lK3CjgNBW8ejx8nnjkMhyZZ7v2Zwz6iw=;
  b=Ekokk9jBKWdaUoTzKKfUqvgWBIQTEwyZa4KJfo1vEZRX7OWxQnqwzMQr
   OtWV1AyP4XcKz4WkLuZyjz92o1XzlGeYK0VjiPaBcjrYLcaqN+zgAeu3A
   ARTPCQjIy8dmbqgjh1pE119iOep6I+j5oWe1e2zg+r7NoZZ07oLrA3wAg
   xb7LEq5dmRgvVoNmvzuYoDcBWTizdpbfMLY9UnW+DCts+sg54WC8PWhfk
   v4SOaY50E//lJqw6y988IWwBoEeocNwmzDdBcr/VXLb2hlLwrQrd/XvC2
   BjiP0Oagsw2ifOwYq7jBx76GLA+yPhnmItjt/+/HWz+eg2osul9Sq+zt7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317693664"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="log'?scan'208";a="317693664"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="1008220938"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="log'?scan'208";a="1008220938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2023 19:14:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:14:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:14:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 19:14:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 19:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt/x3VMENr06CbQ9U674UOu5p6Jn22zg3tzybYqlf3Er0UR/gFxe8aV2jNlbaue6NsUHgBYwF9QcmcnI6MTmXcKfPhJzxZII1t9yZBc06xMAXH/uTZ4RH6MsdH1NNiX00+IOpQMgai48R6so/HiW8idRL6s8AjFsvAyqrMeL6hjbHXcvklnlHLazAk5VdgUrjFgojTZ3ur4ykIASVni7P1jguLWEPV3okqYWFeIZQaBC3/NJvUlR1vAB7RW+947zhYQrB5nBmdgcLJWAR2jJH2WpkDHhFU/G+FqMCLTgjgeJzvCKu1u1+Di+/qiDdqATnx2nUJ0J3R9lbmZus7IyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEHFdfew15Ixf1rQK14nZZ9TBlnk9NXBHsKNSByaHxA=;
 b=MWh8jJ1peGIzjQhWOI6rA/vUJCAlTroQTCPeKNejYom4bDdkawI88s7yzRyvQ66cBC2ATpKKY7GZdJFXZMUmdEZqAv2tqCs5ZLvJQOKsuOlNUPpl3CaLzmcDTRTRoHxxih1cjK38Lix4/ajw+BiN+WdXj24ZCbHuatq7IvUBzojTu7w3Gc3d/CgnuhLHA5db+1F74ldjJ9WZbQCwNuYWiJ3nZ1Hzd6weHNtiufWqS+Ep6+gENqht26xW1dw0xzu5zKL3RpbeFe+n1qbOtyHnO47subkJfTdM1pWEZRE86MrwYe9wcHSc7DayU5180uURt2/KszpC2D5BULKkLbJd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 02:14:19 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:14:19 +0000
Date:   Tue, 14 Mar 2023 10:15:43 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <dchinner@redhat.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, <lkp@intel.com>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is BUG: soft lockup in __cleanup_mnt
 in v6.3-rc1 kernel
Message-ID: <ZA/Yz6xvbnnLihQu@xpf.sh.intel.com>
References: <ZA1FIM2hG/ePMHYR@xpf.sh.intel.com>
 <20230314014543.GC11394@frogsfrogsfrogs>
Content-Type: multipart/mixed; boundary="4we8hwUSWyIdAmkm"
Content-Disposition: inline
In-Reply-To: <20230314014543.GC11394@frogsfrogsfrogs>
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA0PR11MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ecf6f0-3aa1-4838-11aa-08db2431d115
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1im6X00pEKwgTilbr44v1oKyn1qwPBH8b57riJ4RVQ8qsnQyPKDSXwqXVUxLG6SisdjXo+9y3CFP50Oe1yth9qZdGLC6JIEgMumWCrWsgaoVnGWYS3GZm2QLlmWHWeTj9LUEJIuZVsKc/hQAlwZDUtpc51hqODyxUB6boksf7TBCg0Np9yL6ruqiPt7K4UG4RQR5U5Hoted6F1n+H2MvB0yP86nIohfUU2joL2qApF6l+i84qjaUxxB7P8Wi3toCbcWPJb/9YA9GJPGWVmN8dPbXaVuHBskt8kG8Ieuz9aO7XP/ocsYdvyareQjCUcdBChKOK7L2rcN4m/smWuuav63D1VtNSxeSTVCgQoQayRqDacosJ3eTtK4kVaRmUpCnCffKm/3GwsyIiCtq90YunjvBWYLWqU4pcuMnMQNg3FgPjM/2uYY9dLcqml7PgqRb7++R8hK53PigJ4Sd22Dr9iuU9WvRW/hoNeQjgoa8/yNLcqaE+Ihg965b4weKajFFSURE+Xw76rxNLeYzD7ouvT0liaYhfOOCWKCwOJX0Iroq1XHX/FvZE7VpH+FMLif+B0q5WBETk1WLLzeNma01hOTLc1EIPyvbnELuPOELtdnE/cPahtOHmFTa8w2PVg8GJHXZ5OSgpgQHaMHNaxz5Wh8V9COTdd1vAqqP6L8ULNee1QxMHjc50YIOnNqqHgMzAyIQOk2X5QCSQ6NM5twMocYzppShmnghWtZvaTrO8aB7n5AuRn7tGHUFkpX3d2xVlwTPdDBL3Ypzc7OG1BfVbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(86362001)(6916009)(41300700001)(26005)(6512007)(6506007)(33964004)(21480400003)(53546011)(186003)(44144004)(5660300002)(4326008)(235185007)(8936002)(316002)(45080400002)(478600001)(966005)(8676002)(66556008)(66476007)(6486002)(66946007)(82960400001)(38100700002)(6666004)(2906002)(44832011)(30864003)(83380400001)(99710200001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xuiUILPTKyXbzheUjTHtRvrM89v6SABEl5FhWeOtDyyN/TmrfxL40taRpad2?=
 =?us-ascii?Q?DtHwiTVHODE+nMJRR0nEYDIp/SUZklTWpTXD4yOccJxoJiOrVrgM+kAnM24a?=
 =?us-ascii?Q?pf6gz9Wks8kwhzmC8FLN3iSpABptlCaq3fEm3F1gB//DaNojExgtZxOPMLvk?=
 =?us-ascii?Q?NWI7E12wenboOswxWGMH0Sh5HQWWJEPzJdhiziVaqlGvndzk3DyK8+wqv1lb?=
 =?us-ascii?Q?e2ZTQtUnlP1reYbRSxLYBgGjaDqxyLVHEoNVvAUqgZ5Du96nnjXL4ZHeR7wu?=
 =?us-ascii?Q?L5wmPudtXysoS/BpGO2WKAwK7Q+atKbAe171FQRFoxzv+FCEFOgsUFdNy6IR?=
 =?us-ascii?Q?fW1WOTI3tm7vRxg6U1fYZGHwvkC6qk/9qaRG8ZOmtdsbEMVakv72px2fUtcR?=
 =?us-ascii?Q?NuGBeazgFlP6DSi/+N+DtU9n61IlCutDHJRBtdgvHdgh1ZyO+svKUIxiXfoj?=
 =?us-ascii?Q?4IRpUMTULpgq34BSSMcuEFJqL3epC0+cJRlJN7Jpdh+9joNkkPCnE24uKlIJ?=
 =?us-ascii?Q?HZdsYHHjP+6AcMVvd0r5w4b9prGAaJLis81kbnsqsLOkmTiPt99sZf0Fs6af?=
 =?us-ascii?Q?xOgJbUEj9LmDzPLlHvNjjnzmqYwW0bwBGxVF3U9NnCQ+d/JOcm4DjKbp9otW?=
 =?us-ascii?Q?S/gNpZYSV7Rb903/g1vK2rc+cinVV75FQveWCYuREZmDWL9V7Ebvnim0hf5X?=
 =?us-ascii?Q?SP3nCLsh6p1RtPjXSJaxR61eo8Cd9+ClWWXPJxjzRCE1XaupTFj80tq6AhDu?=
 =?us-ascii?Q?2k0ku/DSu0P11uheZVPR9CVmNJViAgdzwqy72u0H1yxVr7KZeKpCtsdJaul/?=
 =?us-ascii?Q?KXHUukvNy27CP8q2O2vdKkGMCv0MKCOBt5qKljk/03VrHfDMXG/kQOpH0kiP?=
 =?us-ascii?Q?I9V+/JsqtS0U+WweTbwnKQM2InqMvqUAfgU9xs0aJP7C9FjxsesVd9l21sKD?=
 =?us-ascii?Q?HmgLKpsi4LF/ZRNdZ7jQ41aDqibJo5Gd+0Au0e/dUsfx5GGVGlao8Ji2E2b9?=
 =?us-ascii?Q?Zv4S15iK8GP8cuvP/aHN9wMb9RKRNCyykUe0qF8aYIA0MJvWLXUVG8A5qXor?=
 =?us-ascii?Q?GbUBzwoqGvJqnN0jhT8gm7GPbieY4bWKVySbp7/XOn1mwBp7pGQlQcT5YVRb?=
 =?us-ascii?Q?lZHK2igTHLGhsMY/COcW4t7WcCubbSvjqdwgfQkFDf9ll4oZEM+jBwANuLin?=
 =?us-ascii?Q?7ygAg/DZNOhSnQUHuUt8FR0ChPwY1sod7kivZDtmr5CCVKk8AE2OYjdjcWZl?=
 =?us-ascii?Q?wMijlFghHrvyoBuV8ezkskY2YkYhn/uK9+6rsEJiRczxMPfkkR9ca561/nvS?=
 =?us-ascii?Q?HwWOWWvXz3jjICM5mVCMKnYiqFjWZT8QSeq8CjbX9NoNPxxOjP57NkdoUYDu?=
 =?us-ascii?Q?ElrkvT8y0gDOpzgnN1IagDEN2GdYukpI/+RF/4ruVRljpuAIyFKanTM+Ej/l?=
 =?us-ascii?Q?wEgFv9TMChWJZjHKwG+IPaJtieKPThANVeMYJa+wR7AOboC8FDVHU/kLnGUD?=
 =?us-ascii?Q?t9gzwCROBEjgCk+/2cMkJVtTZFmb0vDyc4UXKbD6JqbgH4TtQPi/UMzWnoxJ?=
 =?us-ascii?Q?cqGa0wriAoG40dMVNir3cNAwY5QGxgYUwtao9IHGuJb1j5xL0myhRb9sYqsy?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ecf6f0-3aa1-4838-11aa-08db2431d115
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 02:14:18.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqetNMyue+izXLA5Bmcct9mZKtz0a22jc/SGnBHkKe7iO/Z0du7zyKBNeupSxqzB8Aai0CLXTAYFDFT5qwTdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4we8hwUSWyIdAmkm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Darrick,

On 2023-03-13 at 18:45:43 -0700, Darrick J. Wong wrote:
> On Sun, Mar 12, 2023 at 11:21:04AM +0800, Pengfei Xu wrote:
> > Hi Dave Chinner and kernel expert,
> > 
> > Greeting!
> 
> <cough> Please cc the xfs list with xfs bug reports.
> 
  Ah, will send the xfs issue to xfs list next time.

> Have you tried 6.3-rc2?
> 
 I tried v6.3-rc2 kernel, this issue could be reproduced in v6.3-rc2.
 Dmesg is in attached.
"
[  339.367548] XFS (loop0): Corruption of in-memory data (0x8) detected at _xfs_buf_ioapply+0x67d/0x690 (fs/xfs/xfs_buf.c:1553).  Shutting down filesystem.
[  339.368164] XFS (loop0): Please unmount the filesystem and rectify the problem(s)
[  364.436316] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [repro:405]
[  364.436724] Modules linked in:
[  364.436868] irq event stamp: 21510
[  364.437026] hardirqs last  enabled at (21509): [<ffffffff8300187e>] irqentry_exit+0x3e/0xa0
[  364.437406] hardirqs last disabled at (21510): [<ffffffff82fff863>] sysvec_apic_timer_interrupt+0x13/0xe0
[  364.437826] softirqs last  enabled at (8970): [<ffffffff83024a4c>] __do_softirq+0x31c/0x49c
[  364.438195] softirqs last disabled at (8897): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
[  364.438564] CPU: 0 PID: 405 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
[  364.438885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  364.439382] RIP: 0010:rcu_lockdep_current_cpu_online+0x5b/0x90
[  364.439657] Code: 5b 41 5c 5d c3 cc cc cc cc 65 ff 05 d7 bb e1 7e e8 fa 94 de 01 48 c7 c3 80 61 03 00 89 c0 48 03 1c c5 00 7b cb 83 48 8b 43 18 <48> 8b 40 70 48 84
[  364.440449] RSP: 0018:ffffc90000eb3ba8 EFLAGS: 00000282
[  364.440689] RAX: ffffffff83f64340 RBX: ffff88807dc36180 RCX: 0000000000000000
[  364.441003] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
[  364.441313] RBP: ffffc90000eb3bb8 R08: 0000000000000001 R09: 0000000000000000
[  364.441626] R10: ffff88800f7e30d8 R11: 0000000000000000 R12: 0000000000000001
[  364.441938] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  364.442248] FS:  00007f9db4acf740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[  364.442597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  364.442852] CR2: 00007f5e8f6f5518 CR3: 000000000f6da004 CR4: 0000000000770ef0
[  364.443169] PKRU: 55555554
[  364.443297] Call Trace:
[  364.443412]  <TASK>
[  364.443519]  rcu_read_lock_held_common+0x33/0x50
[  364.443741]  rcu_read_lock_sched_held+0x29/0x80
[  364.443956]  lock_acquire+0x2ad/0x320
[  364.444133]  ? lock_release+0x141/0x2e0
[  364.444313]  ? write_comp_data+0x2f/0x90
[  364.444507]  _raw_spin_lock+0x36/0x50
[  364.444681]  ? xfs_ail_push_all_sync+0x73/0x110
[  364.444893]  xfs_ail_push_all_sync+0x73/0x110
[  364.445097]  ? __pfx_autoremove_wake_function+0x10/0x10
[  364.445343]  xfs_reclaim_inodes+0xb8/0x140
[  364.445543]  xfs_unmount_flush_inodes+0x63/0x80
[  364.445757]  xfs_unmountfs+0x69/0x1f0
[  364.445939]  xfs_fs_put_super+0x5a/0x120
[  364.446130]  ? __pfx_xfs_fs_put_super+0x10/0x10
[  364.446356]  generic_shutdown_super+0xac/0x240
[  364.446573]  kill_block_super+0x43/0x80
[  364.446759]  deactivate_locked_super+0x52/0xb0
[  364.446966]  deactivate_super+0xb3/0xd0
[  364.447156]  cleanup_mnt+0x15e/0x1e0
[  364.447335]  __cleanup_mnt+0x1f/0x30
[  364.447513]  task_work_run+0xb6/0x120
[  364.447736]  exit_to_user_mode_prepare+0x200/0x210
[  364.448017]  syscall_exit_to_user_mode+0x2d/0x60
[  364.448293]  do_syscall_64+0x4a/0x90
[  364.448513]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  364.448809] RIP: 0033:0x7f9db4bfb7db
[  364.449033] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff f8
[  364.449954] RSP: 002b:00007fff5b16db78 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[  364.450376] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9db4bfb7db
[  364.450745] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff5b16dc20
[  364.451108] RBP: 00007fff5b16ec60 R08: 0000000001e88333 R09: 0000000000000009
[  364.451484] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
[  364.451847] R13: 00007fff5b16eda0 R14: 0000000000000000 R15: 0000000000000000
[  364.452195]  </TASK>
[  364.452301] Kernel panic - not syncing: softlockup: hung tasks
[  364.452562] CPU: 0 PID: 405 Comm: repro Tainted: G             L     6.3.0-rc2-eeac8ede1755+ #1
[  364.453010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  364.453551] Call Trace:
[  364.453701]  <IRQ>
[  364.453826]  dump_stack_lvl+0xa9/0x110
[  364.454057]  dump_stack+0x19/0x20
[  364.454262]  panic+0x4fd/0x520
[  364.454455]  ? watchdog_timer_fn+0x31e/0x390
[  364.454689]  watchdog_timer_fn+0x337/0x390
[  364.454886]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  364.455101]  __hrtimer_run_queues+0x2ed/0x820
[  364.455355]  hrtimer_interrupt+0x134/0x2d0
[  364.455604]  __sysvec_apic_timer_interrupt+0x9c/0x290
[  364.455902]  sysvec_apic_timer_interrupt+0xab/0xe0
[  364.456185]  </IRQ>
[  364.456314]  <TASK>
[  364.456441]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  364.456742] RIP: 0010:rcu_lockdep_current_cpu_online+0x5b/0x90
[  364.457067] Code: 5b 41 5c 5d c3 cc cc cc cc 65 ff 05 d7 bb e1 7e e8 fa 94 de 01 48 c7 c3 80 61 03 00 89 c0 48 03 1c c5 00 7b cb 83 48 8b 43 18 <48> 8b 40 70 48 84
[  364.457937] RSP: 0018:ffffc90000eb3ba8 EFLAGS: 00000282
[  364.458211] RAX: ffffffff83f64340 RBX: ffff88807dc36180 RCX: 0000000000000000
[  364.458613] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
[  364.459006] RBP: ffffc90000eb3bb8 R08: 0000000000000001 R09: 0000000000000000
[  364.459418] R10: ffff88800f7e30d8 R11: 0000000000000000 R12: 0000000000000001
[  364.459813] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  364.460213]  ? rcu_lockdep_current_cpu_online+0x46/0x90
[  364.460465]  rcu_read_lock_held_common+0x33/0x50
[  364.460743]  rcu_read_lock_sched_held+0x29/0x80
[  364.460980]  lock_acquire+0x2ad/0x320
[  364.461170]  ? lock_release+0x141/0x2e0
[  364.461391]  ? write_comp_data+0x2f/0x90
[  364.461590]  _raw_spin_lock+0x36/0x50
[  364.461804]  ? xfs_ail_push_all_sync+0x73/0x110
[  364.462018]  xfs_ail_push_all_sync+0x73/0x110
[  364.462228]  ? __pfx_autoremove_wake_function+0x10/0x10
[  364.462479]  xfs_reclaim_inodes+0xb8/0x140
[  364.462682]  xfs_unmount_flush_inodes+0x63/0x80
[  364.462933]  xfs_unmountfs+0x69/0x1f0
[  364.463112]  xfs_fs_put_super+0x5a/0x120
[  364.463304]  ? __pfx_xfs_fs_put_super+0x10/0x10
[  364.463522]  generic_shutdown_super+0xac/0x240
[  364.463741]  kill_block_super+0x43/0x80
[  364.463930]  deactivate_locked_super+0x52/0xb0
[  364.464154]  deactivate_super+0xb3/0xd0
[  364.464348]  cleanup_mnt+0x15e/0x1e0
[  364.464564]  __cleanup_mnt+0x1f/0x30
[  364.464787]  task_work_run+0xb6/0x120
[  364.465002]  exit_to_user_mode_prepare+0x200/0x210
[  364.465226]  syscall_exit_to_user_mode+0x2d/0x60
[  364.465449]  do_syscall_64+0x4a/0x90
[  364.465621]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  364.465861] RIP: 0033:0x7f9db4bfb7db
[  364.466065] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff f8
[  364.466917] RSP: 002b:00007fff5b16db78 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[  364.467262] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9db4bfb7db
[  364.467582] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff5b16dc20
[  364.467902] RBP: 00007fff5b16ec60 R08: 0000000001e88333 R09: 0000000000000009
[  364.468228] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
[  364.468605] R13: 00007fff5b16eda0 R14: 0000000000000000 R15: 0000000000000000
[  364.468992]  </TASK>
[  364.469185] Kernel Offset: disabled
[  364.469398] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
"

Thanks!
BR.

> --D
> 
> > Platform: x86 platforms
> > 
> > There is BUG: soft lockup in __cleanup_mnt in v6.3-rc1 kernel.
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230311_022102___cleanup_mnt
> > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/repro.c
> > v6.3-rc1 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/fe15c26ee26efa11741a7b632e9f23b01aca4cc6_dmesg.log
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/bisect_info.log
> > 
> > "
> > [   28.803497] XFS (loop0): Corruption of in-memory data (0x8) detected at _xfs_buf_ioapply+0x67d/0x690 (fs/xfs/xfs_buf.c:1553).  Shutting down filesystem.
> > [   28.804766] XFS (loop0): Please unmount the filesystem and rectify the problem(s)
> > [   56.372468] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [repro:523]
> > [   56.372847] Modules linked in:
> > [   56.372985] irq event stamp: 22822
> > [   56.373141] hardirqs last  enabled at (22821): [<ffffffff8300086e>] irqentry_exit+0x3e/0xa0
> > [   56.373512] hardirqs last disabled at (22822): [<ffffffff82ffe853>] sysvec_apic_timer_interrupt+0x13/0xe0
> > [   56.373923] softirqs last  enabled at (9032): [<ffffffff83023a3c>] __do_softirq+0x31c/0x49c
> > [   56.374276] softirqs last disabled at (8975): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
> > [   56.374623] CPU: 1 PID: 523 Comm: repro Not tainted 6.3.0-rc1-fe15c26ee26e+ #1
> > [   56.374924] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   56.375386] RIP: 0010:rcu_read_lock_sched_held+0x4b/0x80
> > [   56.375621] Code: 8d 7d f7 e8 c7 fe ff ff 84 c0 74 19 0f b6 45 f7 48 8b 4d f8 65 48 33 0c 25 28 00 00 00 75 38 c9 c3 cc cc cc cc be ff ff ff ff <48> c7 c7 20 3e f6 83 e8 89 ec de 01 89 c2 b8 01 00 00 00 85 d2 75
> > [   56.376376] RSP: 0018:ffffc9000102fbe0 EFLAGS: 00000246
> > [   56.376597] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > [   56.376891] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> > [   56.377192] RBP: ffffc9000102fbf0 R08: 0000000000000001 R09: 0000000000000000
> > [   56.377486] R10: ffff88800d01d418 R11: 0000000000000000 R12: ffff88800b0d1158
> > [   56.377780] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [   56.378082] FS:  00007fc887d10740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> > [   56.378414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   56.378655] CR2: 00007faaae519018 CR3: 000000000d3e2004 CR4: 0000000000770ee0
> > [   56.378950] PKRU: 55555554
> > [   56.379069] Call Trace:
> > [   56.379178]  <TASK>
> > [   56.379276]  lock_acquire+0x2ad/0x320
> > [   56.379444]  ? lock_release+0x141/0x2e0
> > [   56.379615]  ? write_comp_data+0x2f/0x90
> > [   56.379799]  _raw_spin_lock+0x36/0x50
> > [   56.379962]  ? xfs_ail_push_all_sync+0x73/0x110
> > [   56.380169]  xfs_ail_push_all_sync+0x73/0x110
> > [   56.380360]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   56.380591]  xfs_reclaim_inodes+0xb8/0x140
> > [   56.380779]  xfs_unmount_flush_inodes+0x63/0x80
> > [   56.380987]  xfs_unmountfs+0x69/0x1f0
> > [   56.381152]  xfs_fs_put_super+0x5a/0x120
> > [   56.381331]  ? __pfx_xfs_fs_put_super+0x10/0x10
> > [   56.381534]  generic_shutdown_super+0xac/0x240
> > [   56.381740]  kill_block_super+0x43/0x80
> > [   56.381917]  deactivate_locked_super+0x52/0xb0
> > [   56.382112]  deactivate_super+0xb3/0xd0
> > [   56.382282]  cleanup_mnt+0x15e/0x1e0
> > [   56.382451]  __cleanup_mnt+0x1f/0x30
> > [   56.382613]  task_work_run+0xb6/0x120
> > [   56.382783]  exit_to_user_mode_prepare+0x200/0x210
> > [   56.383000]  syscall_exit_to_user_mode+0x2d/0x60
> > [   56.383205]  do_syscall_64+0x4a/0x90
> > [   56.383368]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [   56.383593] RIP: 0033:0x7fc887e3c7db
> > [   56.383751] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
> > [   56.384500] RSP: 002b:00007ffc1a5bd1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> > [   56.384815] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc887e3c7db
> > [   56.385114] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc1a5bd290
> > [   56.385407] RBP: 00007ffc1a5be2d0 R08: 0000000001d0a333 R09: 0000000000000009
> > [   56.385700] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
> > [   56.385994] R13: 00007ffc1a5be410 R14: 0000000000000000 R15: 0000000000000000
> > [   56.386299]  </TASK>
> > [   56.386400] Kernel panic - not syncing: softlockup: hung tasks
> > [   56.386643] CPU: 1 PID: 523 Comm: repro Tainted: G             L     6.3.0-rc1-fe15c26ee26e+ #1
> > [   56.387000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   56.387461] Call Trace:
> > [   56.387569]  <IRQ>
> > [   56.387662]  dump_stack_lvl+0xa9/0x110
> > [   56.387834]  dump_stack+0x19/0x20
> > [   56.387980]  panic+0x4fd/0x520
> > [   56.388119]  ? watchdog_timer_fn+0x31e/0x390
> > [   56.388315]  watchdog_timer_fn+0x337/0x390
> > [   56.388497]  ? __pfx_watchdog_timer_fn+0x10/0x10
> > [   56.388710]  __hrtimer_run_queues+0x2ed/0x820
> > [   56.388924]  hrtimer_interrupt+0x134/0x2d0
> > [   56.389111]  __sysvec_apic_timer_interrupt+0x9c/0x290
> > [   56.389331]  sysvec_apic_timer_interrupt+0xab/0xe0
> > [   56.389535]  </IRQ>
> > [   56.389628]  <TASK>
> > [   56.389722]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> > [   56.389940] RIP: 0010:rcu_read_lock_sched_held+0x4b/0x80
> > [   56.390166] Code: 8d 7d f7 e8 c7 fe ff ff 84 c0 74 19 0f b6 45 f7 48 8b 4d f8 65 48 33 0c 25 28 00 00 00 75 38 c9 c3 cc cc cc cc be ff ff ff ff <48> c7 c7 20 3e f6 83 e8 89 ec de 01 89 c2 b8 01 00 00 00 85 d2 75
> > [   56.390909] RSP: 0018:ffffc9000102fbe0 EFLAGS: 00000246
> > [   56.391129] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > [   56.391422] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
> > [   56.391715] RBP: ffffc9000102fbf0 R08: 0000000000000001 R09: 0000000000000000
> > [   56.392009] R10: ffff88800d01d418 R11: 0000000000000000 R12: ffff88800b0d1158
> > [   56.392303] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [   56.392607]  lock_acquire+0x2ad/0x320
> > [   56.392773]  ? lock_release+0x141/0x2e0
> > [   56.392941]  ? write_comp_data+0x2f/0x90
> > [   56.393122]  _raw_spin_lock+0x36/0x50
> > [   56.393285]  ? xfs_ail_push_all_sync+0x73/0x110
> > [   56.393483]  xfs_ail_push_all_sync+0x73/0x110
> > [   56.393672]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   56.393900]  xfs_reclaim_inodes+0xb8/0x140
> > [   56.394087]  xfs_unmount_flush_inodes+0x63/0x80
> > [   56.394285]  xfs_unmountfs+0x69/0x1f0
> > [   56.394450]  xfs_fs_put_super+0x5a/0x120
> > [   56.394627]  ? __pfx_xfs_fs_put_super+0x10/0x10
> > [   56.394829]  generic_shutdown_super+0xac/0x240
> > [   56.395030]  kill_block_super+0x43/0x80
> > [   56.395207]  deactivate_locked_super+0x52/0xb0
> > [   56.395403]  deactivate_super+0xb3/0xd0
> > [   56.395574]  cleanup_mnt+0x15e/0x1e0
> > [   56.395739]  __cleanup_mnt+0x1f/0x30
> > [   56.395902]  task_work_run+0xb6/0x120
> > [   56.396071]  exit_to_user_mode_prepare+0x200/0x210
> > [   56.396282]  syscall_exit_to_user_mode+0x2d/0x60
> > [   56.396487]  do_syscall_64+0x4a/0x90
> > [   56.396648]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [   56.396865] RIP: 0033:0x7fc887e3c7db
> > [   56.397020] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
> > [   56.397761] RSP: 002b:00007ffc1a5bd1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> > [   56.398072] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc887e3c7db
> > [   56.398365] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc1a5bd290
> > [   56.398658] RBP: 00007ffc1a5be2d0 R08: 0000000001d0a333 R09: 0000000000000009
> > [   56.398951] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
> > [   56.399244] R13: 00007ffc1a5be410 R14: 0000000000000000 R15: 0000000000000000
> > [   56.399546]  </TASK>
> > [   56.399792] Kernel Offset: disabled
> > [   56.399972] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
> > "
> > 
> > I used the key word "__cleanup_mnt" to bisect, I knew there was other BUG
> > info in dmesg with "bisect good" commit log.
> > 
> > Anyway, just provided the bad commit and hope it's helpful:
> > "
> > bd4f5d09cc93c8ca51e4efea86ac90a4bb553d6e
> > xfs: refactor the filestreams allocator pick functions
> > "
> > It's just a suspected commit, reverted above commit on top of v6.3-rc1 and
> > no "__cleanup_mnt" related BUG but generated the other BUG info in dmesg.
> > 
> > There was no this issue report yet in syzbot:
> > https://syzkaller.appspot.com/upstream
> > 
> > I tried that, installed the xfs fixed patch for below issue on top of v6.3-rc1:
> > https://lore.kernel.org/lkml/20230226223403.GU360264@dread.disaster.area/
> > "__cleanup_mnt" BUG issue still existed.
> > Related dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/v6.3-rc1_xfs_patch_another_cleanup_mnt_issue.log
> > So it should be different than previous xfs related issue.
> > 

--4we8hwUSWyIdAmkm
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="v6.3-rc2_cleanup_mnt_issue.log"
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version rel-1.16.0-0-gd239552ce722-prebuilt=
.qemu.org)=0D


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+7FF91000+7FEF1000 CA00=
=0D
Press Ctrl-B to configure iPXE (PCI 00:03.0)...=0D                         =
                                                      =0D


Booting from ROM..=1Bc=1B[?7l=1B[2J[    0.000000] Linux version 6.3.0-rc2-e=
eac8ede1755+ (root@p-adls01) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18), =
GNU ld version 2.36.1-2.el8) #1 SMP PREEMPT_DYNAMIC Mon Mar 13 19:17:17 CST=
 2023=0D
[    0.000000] Command line: console=3DttyS0 root=3D/dev/sda earlyprintk=3D=
serial net.ifnames=3D0 thunderbolt.dyndbg=0D
[    0.000000] KERNEL supported cpus:=0D
[    0.000000]   Intel GenuineIntel=0D
[    0.000000]   AMD AuthenticAMD=0D
[    0.000000]   Hygon HygonGenuine=0D
[    0.000000]   Centaur CentaurHauls=0D
[    0.000000]   zhaoxin   Shanghai  =0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'=0D
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256=0D
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8=0D
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 =
bytes, using 'compacted' format.=0D
[    0.000000] signal: max sigframe size: 3632=0D
[    0.000000] BIOS-provided physical RAM map:=0D
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved=0D
[    0.000000] printk: bootconsole [earlyser0] enabled=0D
[    0.000000] NX (Execute Disable) protection: active=0D
[    0.000000] SMBIOS 2.8 present.=0D
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0=
-0-gd239552ce722-prebuilt.qemu.org 04/01/2014=0D
[    0.000000] Hypervisor detected: KVM=0D
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000003] kvm-clock: using sched offset of 482927573 cycles=0D
[    0.000452] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.001814] tsc: Detected 3609.600 MHz processor=0D
[    0.004000] last_pfn =3D 0x7ffe0 max_arch_pfn =3D 0x400000000=0D
[    0.004000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =0D
[    0.004000] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]=0D
[    0.004000] Using GB pages for direct mapping=0D
[    0.004000] ACPI: Early table checksum verification disabled=0D
[    0.004000] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )=0D
[    0.004000] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.004000] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.004000] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.004000] ACPI: FACS 0x000000007FFE0000 000040=0D
[    0.004000] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.004000] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.004000] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.004000] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1=
870]=0D
[    0.004000] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe1=
7fc]=0D
[    0.004000] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe0=
03f]=0D
[    0.004000] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe1=
8f0]=0D
[    0.004000] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1=
928]=0D
[    0.004000] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1=
950]=0D
[    0.004000] No NUMA configuration found=0D
[    0.004000] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]=
=0D
[    0.004000] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]=0D
[    0.004000] Zone ranges:=0D
[    0.004000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0D
[    0.004000]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]=0D
[    0.004000]   Normal   empty=0D
[    0.004000]   Device   empty=0D
[    0.004000] Movable zone start for each node=0D
[    0.004000] Early memory node ranges=0D
[    0.004000]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0D
[    0.004000]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]=0D
[    0.004000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdf=
fff]=0D
[    0.004000] On node 0, zone DMA: 1 pages in unavailable ranges=0D
[    0.004000] On node 0, zone DMA: 97 pages in unavailable ranges=0D
[    0.004000] On node 0, zone DMA32: 32 pages in unavailable ranges=0D
[    0.004000] ACPI: PM-Timer IO Port: 0x608=0D
[    0.004000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])=0D
[    0.004000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23=0D
[    0.004000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0D
[    0.004000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)=
=0D
[    0.004000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=
=0D
[    0.004000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level=
)=0D
[    0.004000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level=
)=0D
[    0.004000] ACPI: Using ACPI (MADT) for SMP configuration information=0D
[    0.004000] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.004000] TSC deadline timer available=0D
[    0.004000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs=0D
[    0.004000] kvm-guest: KVM setup pv remote TLB flush=0D
[    0.004000] kvm-guest: setup PV sched yield=0D
[    0.004000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]=0D
[    0.004000] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]=0D
[    0.004000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000effff]=0D
[    0.004000] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0=
x000fffff]=0D
[    0.004000] [mem 0x80000000-0xfeffbfff] available for PCI devices=0D
[    0.004000] Booting paravirtualized kernel on KVM=0D
[    0.004000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns=0D
[    0.004000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr=
_node_ids:1=0D
[    0.004000] percpu: Embedded 65 pages/cpu s229376 r8192 d28672 u1048576=
=0D
[    0.004000] kvm-guest: PV spinlocks enabled=0D
[    0.004000] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, =
linear)=0D
[    0.004000] Fallback order for Node 0: 0 =0D
[    0.004000] Built 1 zonelists, mobility grouping on.  Total pages: 51580=
8=0D
[    0.004000] Policy zone: DMA32=0D
[    0.004000] Kernel command line: net.ifnames=3D0 console=3DttyS0 root=3D=
/dev/sda earlyprintk=3Dserial net.ifnames=3D0 thunderbolt.dyndbg=0D
[    0.004000] random: crng init done=0D
[    0.004000] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)=0D
[    0.004000] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)=0D
[    0.004000] mem auto-init: stack:off, heap alloc:off, heap free:off=0D
[    0.004000] Memory: 1964888K/2096632K available (36864K kernel code, 457=
8K rwdata, 9848K rodata, 10508K init, 31780K bss, 131488K reserved, 0K cma-=
reserved)=0D
[    0.004000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1=0D
[    0.004000] kmemleak: Kernel memory leak detector disabled=0D
[    0.004000] ftrace: allocating 68737 entries in 269 pages=0D
[    0.004000] ftrace: allocated 269 pages with 4 groups=0D
[    0.004000] Dynamic Preempt: voluntary=0D
[    0.004000] Running RCU self tests=0D
[    0.004000] Running RCU synchronous self tests=0D
[    0.004000] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.004000] rcu: 	RCU lockdep checking is enabled.=0D
[    0.004000] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D2.=0D
[    0.004000] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.004000] 	Rude variant of Tasks RCU enabled.=0D
[    0.004000] 	Tracing variant of Tasks RCU enabled.=0D
[    0.004000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.004000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2=0D
[    0.004000] Running RCU synchronous self tests=0D
[    0.004000] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16=0D
[    0.004000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.004000] Console: colour VGA+ 80x25=0D
[    0.004000] printk: console [ttyS0] enabled=0D
[    0.004000] printk: console [ttyS0] enabled=0D
[    0.004000] printk: bootconsole [earlyser0] disabled=0D
[    0.004000] printk: bootconsole [earlyser0] disabled=0D
[    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0D
[    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.004000] ... MAX_LOCK_DEPTH:          48=0D
[    0.004000] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.004000] ... CLASSHASH_SIZE:          4096=0D
[    0.004000] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.004000] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.004000] ... CHAINHASH_SIZE:          32768=0D
[    0.004000]  memory used by lock dependency info: 6365 kB=0D
[    0.004000]  memory used for stack traces: 4224 kB=0D
[    0.004000]  per task-struct memory footprint: 1920 bytes=0D
[    0.004000] ACPI: Core revision 20221020=0D
[    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns=0D
[    0.004000] APIC: Switch to symmetric I/O mode setup=0D
[    0.004000] x2apic enabled=0D
[    0.004000] Switched APIC routing to physical x2apic.=0D
[    0.004000] kvm-guest: setup PV IPIs=0D
[    0.004000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1=0D
[    0.004000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x3407c077a8d, max_idle_ns: 440795342283 ns=0D
[    0.192321] Calibrating delay loop (skipped) preset value.. 7219.20 Bogo=
MIPS (lpj=3D14438400)=0D
[    0.193054] pid_max: default: 32768 minimum: 301=0D
[    0.193518] LSM: initializing lsm=3Dcapability,yama,integrity=0D
[    0.194005] Yama: becoming mindful.=0D
[    0.194479] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)=0D
[    0.195118] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)=0D
[    0.198537] x86/cpu: User Mode Instruction Prevention (UMIP) activated=
=0D
[    0.199561] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.200061] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=0D
[    0.200379] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization=0D
[    0.201093] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[    0.202025] Spectre V2 : Mitigation: Enhanced / Automatic IBRS=0D
[    0.202501] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch=0D
[    0.203168] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT=0D
[    0.203774] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier=0D
[    0.204313] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl=0D
[    0.310709] Freeing SMP alternatives memory: 56K=0D
[    0.311300] Running RCU synchronous self tests=0D
[    0.311751] Running RCU synchronous self tests=0D
[    0.312688] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-12700K (family:=
 0x6, model: 0x97, stepping: 0x2)=0D
[    0.314249] cblist_init_generic: Setting adjustable number of callback q=
ueues.=0D
[    0.314987] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.315668] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.316308] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.316380] Running RCU-tasks wait API self tests=0D
[    0.420613] Performance Events: Alderlake Hybrid events, full-width coun=
ters, Intel PMU driver.=0D
[    0.422632] core: cpu_core PMU driver: =0D
[    0.423110] ... version:                2=0D
[    0.423576] ... bit width:              48=0D
[    0.424043] ... generic registers:      6=0D
[    0.424322] ... value mask:             0000ffffffffffff=0D
[    0.424921] ... max period:             00007fffffffffff=0D
[    0.425520] ... fixed-purpose events:   3=0D
[    0.425977] ... event mask:             0001000f0000003f=0D
[    0.426930] rcu: Hierarchical SRCU implementation.=0D
[    0.427484] rcu: 	Max phase no-delay instances is 1000.=0D
[    0.428364] Callback from call_rcu_tasks_trace() invoked.=0D
[    0.433102] unchecked MSR access error: WRMSR to 0x38f (tried to write 0=
x0001000f0000003f) at rIP: 0xffffffff810e0c2c (native_write_msr+0xc/0x30)=
=0D
[    0.434612] Call Trace:=0D
[    0.434904]  <TASK>=0D
[    0.435161]  __intel_pmu_enable_all.constprop.49+0xb5/0x140=0D
[    0.435824]  intel_pmu_enable_all+0x1e/0x30=0D
[    0.436308]  x86_pmu_enable+0x46d/0x5a0=0D
[    0.436308]  ? write_comp_data+0x2f/0x90=0D
[    0.436308]  perf_pmu_enable+0x53/0x70=0D
[    0.436308]  ctx_resched+0x14d/0x1e0=0D
[    0.436308]  __perf_install_in_context+0x2f7/0x470=0D
[    0.436308]  ? lock_is_held_type+0xe6/0x140=0D
[    0.436308]  ? __pfx_remote_function+0x10/0x10=0D
[    0.436308]  remote_function+0x80/0xa0=0D
[    0.436308]  ? __pfx_remote_function+0x10/0x10=0D
[    0.436308]  generic_exec_single+0x124/0x190=0D
[    0.436308]  smp_call_function_single+0x11c/0x240=0D
[    0.436308]  ? __pfx_remote_function+0x10/0x10=0D
[    0.436308]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[    0.436308]  ? write_comp_data+0x2f/0x90=0D
[    0.436308]  perf_install_in_context+0x2d8/0x300=0D
[    0.436308]  ? __pfx___perf_install_in_context+0x10/0x10=0D
[    0.436308]  perf_event_create_kernel_counter+0x284/0x2b0=0D
[    0.436308]  ? __pfx_watchdog_overflow_callback+0x10/0x10=0D
[    0.436308]  hardlockup_detector_event_create+0x46/0xd0=0D
[    0.436308]  hardlockup_detector_perf_init+0x18/0x80=0D
[    0.436308]  watchdog_nmi_probe+0x17/0x20=0D
[    0.436308]  lockup_detector_init+0x40/0xb0=0D
[    0.436308]  kernel_init_freeable+0x37e/0x8c0=0D
[    0.436308]  ? __pfx_kernel_init+0x10/0x10=0D
[    0.436308]  kernel_init+0x24/0x1e0=0D
[    0.436308]  ? __pfx_kernel_init+0x10/0x10=0D
[    0.436308]  ret_from_fork+0x29/0x50=0D
[    0.436308]  </TASK>=0D
[    0.436679] smp: Bringing up secondary CPUs ...=0D
[    0.438504] x86: Booting SMP configuration:=0D
[    0.439019] .... node  #0, CPUs:      #1=0D
[    0.439397] smp: Brought up 1 node, 2 CPUs=0D
[    0.440327] smpboot: Max logical packages: 1=0D
[    0.440824] smpboot: Total of 2 processors activated (14438.40 BogoMIPS)=
=0D
[    0.445947] devtmpfs: initialized=0D
[    0.445947] x86/mm: Memory block size: 128MB=0D
[    0.450648] Running RCU synchronous self tests=0D
[    0.450648] Running RCU synchronous self tests=0D
[    0.452373] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0D
[    0.453522] futex hash table entries: 512 (order: 4, 65536 bytes, linear=
)=0D
[    0.454706] pinctrl core: initialized pinctrl subsystem=0D
[    0.456155] =0D
[    0.456318] ************************************************************=
*=0D
[    0.457103] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.457888] **                                                         *=
*=0D
[    0.458668] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  *=
*=0D
[    0.459447] **                                                         *=
*=0D
[    0.460230] ** This means that this kernel is built to expose internal *=
*=0D
[    0.460317] ** IOMMU data structures, which may compromise security on *=
*=0D
[    0.461100] ** your system.                                            *=
*=0D
[    0.461883] **                                                         *=
*=0D
[    0.462666] ** If you see this message and you are not debugging the   *=
*=0D
[    0.463455] ** kernel, report this immediately to your vendor!         *=
*=0D
[    0.464235] **                                                         *=
*=0D
[    0.464317] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.465105] ************************************************************=
*=0D
[    0.465993] PM: RTC time: 01:57:17, date: 2023-03-14=0D
[    0.471145] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0D
[    0.472712] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions=0D
[    0.473559] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations=0D
[    0.474480] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations=0D
[    0.475493] audit: initializing netlink subsys (disabled)=0D
[    0.476377] audit: type=3D2000 audit(1678759038.458:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1=0D
[    0.477352] thermal_sys: Registered thermal governor 'fair_share'=0D
[    0.477365] thermal_sys: Registered thermal governor 'bang_bang'=0D
[    0.478086] thermal_sys: Registered thermal governor 'step_wise'=0D
[    0.478794] thermal_sys: Registered thermal governor 'user_space'=0D
[    0.479565] cpuidle: using governor ladder=0D
[    0.480344] cpuidle: using governor menu=0D
[    0.481235] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5=0D
[    0.482463] PCI: Using configuration type 1 for base access=0D
[    0.484376] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.=0D
[    0.777280] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s=0D
[    0.778069] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page=
=0D
[    0.778813] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s=0D
[    0.779571] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page=0D
[    0.784909] ACPI: Added _OSI(Module Device)=0D
[    0.785434] ACPI: Added _OSI(Processor Device)=0D
[    0.785959] ACPI: Added _OSI(3.0 _SCP Extensions)=0D
[    0.786509] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    0.794119] ACPI: 1 ACPI AML tables successfully acquired and loaded=0D
[    2.971040] Callback from call_rcu_tasks_rude() invoked.=0D
[    3.018033] ACPI: Interpreter enabled=0D
[    3.018624] ACPI: PM: (supports S0 S3 S4 S5)=0D
[    3.019130] ACPI: Using IOAPIC for interrupt routing=0D
[    3.020374] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug=0D
[    3.020963] PCI: Using E820 reservations for host bridge windows=0D
[    3.022084] ACPI: Enabled 2 GPEs in block 00 to 0F=0D
[    3.037588] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])=0D
[    3.038140] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I EDR HPX-Type3]=0D
[    3.038816] acpi PNP0A03:00: _OSC: not requesting OS control; OS require=
s [ExtendedConfig ASPM ClockPM MSI]=0D
[    3.039725] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge=0D
[    3.042706] acpiphp: Slot [3] registered=0D
[    3.043108] acpiphp: Slot [4] registered=0D
[    3.043502] acpiphp: Slot [5] registered=0D
[    3.043908] acpiphp: Slot [6] registered=0D
[    3.044301] acpiphp: Slot [7] registered=0D
[    3.044376] acpiphp: Slot [8] registered=0D
[    3.044762] acpiphp: Slot [9] registered=0D
[    3.045155] acpiphp: Slot [10] registered=0D
[    3.045553] acpiphp: Slot [11] registered=0D
[    3.045953] acpiphp: Slot [12] registered=0D
[    3.046359] acpiphp: Slot [13] registered=0D
[    3.046759] acpiphp: Slot [14] registered=0D
[    3.047160] acpiphp: Slot [15] registered=0D
[    3.047555] acpiphp: Slot [16] registered=0D
[    3.047874] acpiphp: Slot [17] registered=0D
[    3.048193] acpiphp: Slot [18] registered=0D
[    3.048376] acpiphp: Slot [19] registered=0D
[    3.048697] acpiphp: Slot [20] registered=0D
[    3.049016] acpiphp: Slot [21] registered=0D
[    3.049334] acpiphp: Slot [22] registered=0D
[    3.049658] acpiphp: Slot [23] registered=0D
[    3.049984] acpiphp: Slot [24] registered=0D
[    3.050326] acpiphp: Slot [25] registered=0D
[    3.050653] acpiphp: Slot [26] registered=0D
[    3.050980] acpiphp: Slot [27] registered=0D
[    3.051311] acpiphp: Slot [28] registered=0D
[    3.051652] acpiphp: Slot [29] registered=0D
[    3.052013] acpiphp: Slot [30] registered=0D
[    3.052384] acpiphp: Slot [31] registered=0D
[    3.052748] PCI host bridge to bus 0000:00=0D
[    3.053094] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]=0D
[    3.053663] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]=0D
[    3.054236] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]=0D
[    3.054894] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f window]=0D
[    3.055521] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17ffff=
fff window]=0D
[    3.056160] pci_bus 0000:00: root bus resource [bus 00-ff]=0D
[    3.056447] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=0D
[    3.059658] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=0D
[    3.060897] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=0D
[    3.062714] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]=0D
[    3.063760] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]=0D
[    3.064317] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]=
=0D
[    3.064873] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]=0D
[    3.065469] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]=
=0D
[    3.066410] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=0D
[    3.067242] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI=0D
[    3.067848] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB=0D
[    3.068612] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=0D
[    3.071286] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]=
=0D
[    3.074098] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]=0D
[    3.078832] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]=
=0D
[    3.079991] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]=0D
[    3.084588] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000=0D
[    3.085925] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]=0D
[    3.087238] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]=0D
[    3.090796] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]=
=0D
[    3.092390] Callback from call_rcu_tasks() invoked.=0D
[    3.103286] ACPI: PCI: Interrupt link LNKA configured for IRQ 10=0D
[    3.104186] ACPI: PCI: Interrupt link LNKB configured for IRQ 10=0D
[    3.104659] ACPI: PCI: Interrupt link LNKC configured for IRQ 11=0D
[    3.105645] ACPI: PCI: Interrupt link LNKD configured for IRQ 11=0D
[    3.106320] ACPI: PCI: Interrupt link LNKS configured for IRQ 9=0D
[    3.108626] iommu: Default domain type: Translated =0D
[    3.108938] iommu: DMA domain TLB invalidation policy: lazy mode =0D
[    3.114018] SCSI subsystem initialized=0D
[    3.114523] ACPI: bus type USB registered=0D
[    3.114523] usbcore: registered new interface driver usbfs=0D
[    3.114523] usbcore: registered new interface driver hub=0D
[    3.114523] usbcore: registered new device driver usb=0D
[    3.114523] pps_core: LinuxPPS API ver. 1 registered=0D
[    3.114523] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>=0D
[    3.115157] PTP clock support registered=0D
[    3.116419] EDAC MC: Ver: 3.0.0=0D
[    3.121041] NetLabel: Initializing=0D
[    3.121348] NetLabel:  domain hash size =3D 128=0D
[    3.121723] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0D
[    3.122263] NetLabel:  unlabeled traffic allowed by default=0D
[    3.122870] PCI: Using ACPI for IRQ routing=0D
[    3.122870] pci 0000:00:02.0: vgaarb: setting as boot VGA device=0D
[    3.122870] pci 0000:00:02.0: vgaarb: bridge control possible=0D
[    3.122870] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone=0D
[    3.124322] vgaarb: loaded=0D
[    3.125003] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0D
[    3.125041] hpet0: 3 comparators, 64-bit 100.000000 MHz counter=0D
[    3.128369] clocksource: Switched to clocksource kvm-clock=0D
[    3.285611] VFS: Disk quotas dquot_6.6.0=0D
[    3.286152] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0D
[    3.287454] pnp: PnP ACPI init=0D
[    3.289639] pnp: PnP ACPI: found 6 devices=0D
[    3.302470] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns=0D
[    3.303810] NET: Registered PF_INET protocol family=0D
[    3.304568] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)=0D
[    3.306210] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4,=
 73728 bytes, linear)=0D
[    3.307109] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)=0D
[    3.307946] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)=0D
[    3.309030] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes,=
 linear)=0D
[    3.311519] TCP: Hash tables configured (established 16384 bind 16384)=
=0D
[    3.312379] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear=
)=0D
[    3.313214] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, l=
inear)=0D
[    3.314175] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    3.315283] RPC: Registered named UNIX socket transport module.=0D
[    3.315802] RPC: Registered udp transport module.=0D
[    3.316204] RPC: Registered tcp transport module.=0D
[    3.316639] RPC: Registered tcp NFSv4.1 backchannel transport module.=0D
[    3.317345] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]=0D
[    3.317898] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]=0D
[    3.318481] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]=0D
[    3.319088] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff windo=
w]=0D
[    3.319714] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff win=
dow]=0D
[    3.320618] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    3.321116] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=0D
[    3.321707] PCI: CLS 0 bytes, default 64=0D
[    3.322127] ACPI: bus type thunderbolt registered=0D
[    3.322944] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x340=
7c077a8d, max_idle_ns: 440795342283 ns=0D
[    3.327239] Initialise system trusted keyrings=0D
[    3.327730] Key type blacklist registered=0D
[    3.328398] workingset: timestamp_bits=3D36 max_order=3D19 bucket_order=
=3D0=0D
[    3.329284] zbud: loaded=0D
[    3.330576] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0D
[    3.332084] NFS: Registering the id_resolver key type=0D
[    3.332755] Key type id_resolver registered=0D
[    3.333256] Key type id_legacy registered=0D
[    3.333785] nfs4filelayout_init: NFSv4 File Layout Driver Registering...=
=0D
[    3.334604] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...=0D
[    3.335753] fuse: init (API version 7.38)=0D
[    3.336609] SGI XFS with ACLs, security attributes, realtime, quota, no =
debug enabled=0D
[    3.337974] 9p: Installing v9fs 9p2000 file system support=0D
[    3.344358] Key type asymmetric registered=0D
[    3.344805] Asymmetric key parser 'x509' registered=0D
[    3.345422] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)=0D
[    3.346399] io scheduler mq-deadline registered=0D
[    3.347035] io scheduler bfq registered=0D
[    3.348051] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=
=0D
[    3.349544] IPMI message handler: version 39.2=0D
[    3.350162] ipmi device interface=0D
[    3.352225] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0=0D
[    3.353273] ACPI: button: Power Button [PWRF]=0D
[    3.354713] ERST DBG: ERST support is disabled.=0D
[    3.356058] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled=0D
[    3.357246] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A=0D
[    3.366709] Linux agpgart interface v0.103=0D
[    3.368057] ACPI: bus type drm_connector registered=0D
[    3.382853] brd: module loaded=0D
[    3.390151] loop: module loaded=0D
[    3.395504] scsi host0: ata_piix=0D
[    3.396649] scsi host1: ata_piix=0D
[    3.397035] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 1=
4=0D
[    3.397477] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 1=
5=0D
[    3.399183] tun: Universal TUN/TAP device driver, 1.6=0D
[    3.399778] e100: Intel(R) PRO/100 Network Driver=0D
[    3.400085] e100: Copyright(c) 1999-2006 Intel Corporation=0D
[    3.400494] e1000: Intel(R) PRO/1000 Network Driver=0D
[    3.400821] e1000: Copyright (c) 1999-2006 Intel Corporation.=0D
[    3.556448] ata1: found unknown device (class 0)=0D
[    3.557083] ata2: found unknown device (class 0)=0D
[    3.558281] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100=0D
[    3.558795] ata1.00: 16777216 sectors, multi 16: LBA48 =0D
[    3.559438] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100=0D
[    3.561619] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    3.564240] scsi 0:0:0:0: Attached scsi generic sg0 type 0=0D
[    3.566257] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.=
5+ PQ: 0 ANSI: 5=0D
[    3.568699] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB=
/8.00 GiB)=0D
[    3.569652] sd 0:0:0:0: [sda] Write Protect is off=0D
[    3.570300] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    3.571403] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes=0D
[    3.581200] ACPI: \_SB_.LNKC: Enabled at IRQ 11=0D
[    3.589488] sd 1:0:0:0: Attached scsi generic sg1 type 5=0D
[    3.590950] sd 0:0:0:0: [sda] Attached SCSI disk=0D
[    3.905049] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:5=
6=0D
[    3.905917] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connectio=
n=0D
[    3.906849] e1000e: Intel(R) PRO/1000 Network Driver=0D
[    3.907440] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0D
[    3.908232] igb: Intel(R) Gigabit Ethernet Network Driver=0D
[    3.908905] igb: Copyright (c) 2007-2014 Intel Corporation.=0D
[    3.909712] PPP generic driver version 2.4.2=0D
[    3.910951] VFIO - User Level meta-driver version: 0.3=0D
[    3.912157] usbcore: registered new interface driver uas=0D
[    3.912881] usbcore: registered new interface driver usb-storage=0D
[    3.913794] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12=0D
[    3.915709] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    3.916401] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    3.917901] mousedev: PS/2 mouse device common for all mice=0D
[    3.919740] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1=0D
[    3.920589] rtc_cmos 00:05: RTC can wake from S4=0D
[    3.922212] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input4=0D
[    3.922655] rtc_cmos 00:05: registered as rtc0=0D
[    3.923839] rtc_cmos 00:05: setting system clock to 2023-03-14T01:57:21 =
UTC (1678759041)=0D
[    3.923980] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input3=0D
[    3.925988] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, =
hpet irqs=0D
[    3.926904] i2c_dev: i2c /dev entries driver=0D
[    3.927486] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.=0D
[    3.928934] device-mapper: uevent: version 1.0.3=0D
[    3.929829] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised:=
 dm-devel@redhat.com=0D
[    3.930835] intel_pstate: CPU model not supported=0D
[    3.931517] sdhci: Secure Digital Host Controller Interface driver=0D
[    3.932225] sdhci: Copyright(c) Pierre Ossman=0D
[    3.932882] sdhci-pltfm: SDHCI platform and OF driver helper=0D
[    3.933621] ledtrig-cpu: registered to indicate activity on CPUs=0D
[    3.934848] drop_monitor: Initializing network drop monitor service=0D
[    3.935868] NET: Registered PF_INET6 protocol family=0D
[    3.940193] Segment Routing with IPv6=0D
[    3.940709] In-situ OAM (IOAM) with IPv6=0D
[    3.941233] NET: Registered PF_PACKET protocol family=0D
[    3.942013] 9pnet: Installing 9P2000 support=0D
[    3.942581] Key type dns_resolver registered=0D
[    3.944183] IPI shorthand broadcast: enabled=0D
[    3.963413] sched_clock: Marking stable (3780005895, 180308989)->(399582=
1597, -35506713)=0D
[    3.965266] registered taskstats version 1=0D
[    3.966072] Loading compiled-in X.509 certificates=0D
[    3.966860] zswap: loaded using pool lzo/zbud=0D
[    3.986503] Key type .fscrypt registered=0D
[    3.986833] Key type fscrypt-provisioning registered=0D
[    3.988220] Key type encrypted registered=0D
[    3.988659] ima: No TPM chip found, activating TPM-bypass!=0D
[    3.989084] ima: Allocated hash algorithm: sha1=0D
[    3.989488] ima: No architecture policies found=0D
[    3.989915] evm: Initialising EVM extended attributes:=0D
[    3.990328] evm: security.selinux=0D
[    3.990590] evm: security.SMACK64=0D
[    3.990847] evm: security.SMACK64EXEC=0D
[    3.991111] evm: security.SMACK64TRANSMUTE=0D
[    3.991415] evm: security.SMACK64MMAP=0D
[    3.991675] evm: security.apparmor=0D
[    3.991925] evm: security.ima=0D
[    3.992152] evm: security.capability=0D
[    3.992442] evm: HMAC attrs: 0x1=0D
[    3.993971] PM:   Magic number: 15:577:963=0D
[    3.994390] memory memory14: hash matches=0D
[    3.995061] RAS: Correctable Errors collector initialized.=0D
[    3.996097] md: Waiting for all devices to be available before autodetec=
t=0D
[    3.996475] md: If you don't use raid, use raid=3Dnoautodetect=0D
[    3.996792] md: Autodetecting RAID arrays.=0D
[    3.997033] md: autorun ...=0D
[    3.997193] md: ... autorun DONE.=0D
[    4.009456] EXT4-fs (sda): INFO: recovery required on readonly filesyste=
m=0D
[    4.010047] EXT4-fs (sda): write access will be enabled during recovery=
=0D
[    4.078758] EXT4-fs (sda): recovery complete=0D
[    4.085464] EXT4-fs (sda): mounted filesystem 23a53bb9-f815-47a5-b74c-5e=
08f7731193 with ordered data mode. Quota mode: none.=0D
[    4.086415] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.=
=0D
[    4.087687] devtmpfs: mounted=0D
[    4.094013] Freeing unused decrypted memory: 2036K=0D
[    4.101273] Freeing unused kernel image (initmem) memory: 10508K=0D
[    4.101825] Write protecting the kernel read-only data: 47104k=0D
[    4.104018] Freeing unused kernel image (rodata/data gap) memory: 392K=
=0D
[    4.190099] x86/mm: Checked W+X mappings: passed, no W+X pages found.=0D
[    4.190433] Run /sbin/init as init process=0D
[    4.333587] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.=0D
[    4.374155] systemd[1]: systemd 239 (239-49.el8) running in system mode.=
 (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP=
 +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +=
PCRE2 default-hierarchy=3Dlegacy)=0D
[    4.376168] systemd[1]: Detected virtualization kvm.=0D
[    4.376636] systemd[1]: Detected architecture x86-64.=0D
=0D
Welcome to =1B[0;31mCentOS Stream 8=1B[0m!=0D
=0D
[    4.440968] systemd[1]: Set hostname to <test>.=0D
[    4.706953] systemd[1]: Created slice system-getty.slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-getty.slice.=0D
[    4.708124] systemd[1]: Listening on multipathd control socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on multipathd control socket.=0D
[    4.709358] systemd[1]: Listening on LVM2 poll daemon socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on LVM2 poll daemon socket.=0D
[    4.710245] systemd[1]: Listening on udev Kernel Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Socket.=0D
[    4.711106] systemd[1]: Listening on Journal Socket (/dev/log).=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket (/dev/log).=0D
[    4.718780] systemd[1]: Listening on Process Core Dump Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Process Core Dump Socket.=0D
[=1B[0;32m  OK  =1B[0m] Created slice User and Session Slice.=0D
[=1B[0;32m  OK  =1B[0m] Reached target Swap.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-sshd\x2dkeygen.slice.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket.=0D
         Starting Setup Virtual Console...=0D
         Mounting Kernel Debug File System...=0D
         Starting Load Kernel Modules...=0D
         Mounting Huge Pages File System...=0D
[=1B[0;32m  OK  =1B[0m] Reached target Slices.=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Control Socket.=0D
[=1B[0;32m  OK  =1B[0m] Set up automount Arbitrary Executab=E2=80=A6rmats F=
ile System Automount Point.=0D
         Starting Journal Service...=0D
[=1B[0;32m  OK  =1B[0m] Listening on initctl Compatibility Named Pipe.=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Wall Directory=
 Watch.=0D
         Starting udev Coldplug all Devices...=0D
[=1B[0;32m  OK  =1B[0m] Listening on Device-mapper event daemon FIFOs.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-serial\x2dgetty.slice.=0D
         Mounting POSIX Message Queue File System...=0D
         Starting Remount Root and Kernel File Systems...=0D
[=1B[0;32m  OK  =1B[0m] Listening on RPCbind Server Activation Socket.=0D
[=1B[0;32m  OK  =1B[0m] Reached target RPC Port Mapper.=0D
         Starting Monitoring of LVM2 mirrors=E2=80=A6ng dmeventd or progres=
s polling...=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Debug File System.=0D
[=1B[0;1;31mFAILED=1B[0m] Failed to start Load Kernel Modules.=0D
See 'systemctl status systemd-modules-load.service' for details.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Huge Pages File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted POSIX Message Queue File System.=0D
         Mounting Kernel Configuration File System...=0D
         Mounting FUSE Control File System...=0D
         Starting Apply Kernel Variables...=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Configuration File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted FUSE Control File System.=0D
[=1B[0;32m  OK  =1B[0m] Started Setup Virtual Console.=0D
[=1B[0;32m  OK  =1B[0m] Started Apply Kernel Variables.=0D
[=1B[0;32m  OK  =1B[0m] Started Journal Service.=0D
[    5.299531] EXT4-fs (sda): re-mounted 23a53bb9-f815-47a5-b74c-5e08f77311=
93. Quota mode: none.=0D
[=1B[0;32m  OK  =1B[0m] Started Remount Root and Kernel File Systems.=0D
         Starting Flush Journal to Persistent Storage...=0D
         Starting Load/Save Random Seed...=0D
         Starting Create Static Device Nodes in /dev...=0D
[=1B[0;32m  OK  =1B[0m] Started Load/Save Random Seed.=0D
[=1B[0;32m  OK  =1B[0m] Started Flush Journal to Persistent Storage.=0D
[=1B[0;32m  OK  =1B[0m] Started Create Static Device Nodes in /dev.=0D
         Starting udev Kernel Device Manager...=0D
[=1B[0;32m  OK  =1B[0m] Started udev Coldplug all Devices.=0D
         Starting udev Wait for Complete Device Initialization...=0D
[=1B[0;32m  OK  =1B[0m] Started udev Kernel Device Manager.=0D
         Starting Show Plymouth Boot Screen...=0D
[=1B[0;32m  OK  =1B[0m] Started Show Plymouth Boot Screen.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local Encrypted Volumes.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Paths.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Plymouth Direc=
tory Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started udev Wait for Complete Device Initializatio=
n.=0D=0D
[=1B[0;32m  OK  =1B[0m] Found device /dev/ttyS0.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Monitoring of LVM2 mirrors,=E2=80=A6sing dm=
eventd or progress polling.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on Load/Save RF Kill Switch Status /dev/r=
fkill Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems.=0D=0D
         Starting Tell Plymouth To Write Out Runtime Data...=0D=0D
         Starting Create Volatile Files and Directories...=0D=0D
         Starting Restore /run/initramfs on shutdown...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Tell Plymouth To Write Out Runtime Data.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started Restore /run/initramfs on shutdown.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Create Volatile Files and Directories.=0D=
=0D
         Mounting RPC Pipe File System...=0D=0D
         Starting Security Auditing Service...=0D=0D
         Starting RPC Bind...=0D=0D
[=1B[0;32m  OK  =1B[0m] Mounted RPC Pipe File System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target rpc_pipefs.target.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started RPC Bind.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Security Auditing Service.=0D=0D
         Starting Update UTMP about System Boot/Shutdown...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Update UTMP about System Boot/Shutdown.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Reached target System Initialization.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on SSSD Kerberos Cache Manager responder =
socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Daily Cleanup of Temporary Directories.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started daily update of the root trust anchor for D=
NSSEC.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started dnf makecache --timer.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Timers.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on D-Bus System Message Bus Socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Sockets.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Basic System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Machine Check Exception Logging Daemon.=0D=
=0D
         Starting Auto-connect to subsystems=E2=80=A6-NVME devices found du=
ring boot...=0D=0D
         Starting Self Monitoring and Reporting Technology (SMART) Daemon..=
.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started irqbalance daemon.=0D=0D
         Starting Login Service...=0D=0D
         Starting NTP client/server...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started D-Bus System Message Bus.=0D=0D
         Starting Network Manager...=0D=0D
         Starting Authorization Manager...=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target sshd-keygen.target.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Self Monitoring and Reporting Technology (S=
MART) Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Auto-connect to subsystems =E2=80=A6FC-NVME=
 devices found during boot.=0D=0D
         Starting update of the root trust a=E2=80=A6or DNSSEC validation i=
n unbound...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Login Service.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started NTP client/server.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Network Manager.=0D=0D
         Starting Network Manager Wait Online...=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Network.=0D=0D
         Starting OpenSSH server daemon...=0D=0D
         Starting Dynamic System Tuning Daemon...=0D=0D
         Starting GSSAPI Proxy Daemon...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started update of the root trust an=E2=80=A6 for DN=
SSEC validation in unbound.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Authorization Manager.=0D=0D
         Starting Hostname Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started GSSAPI Proxy Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target NFS client services.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems.=0D=0D
         Starting Permit User Sessions...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started OpenSSH server daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Permit User Sessions.=0D=0D
         Starting Hold until boot process finishes up...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Command Scheduler.=0D=0D
         Starting Terminate Plymouth Boot Screen...=0D=0D
[    7.656613] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX=0D
[    7.657810] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=0D
[    7.905297] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[    7.905841] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
=0D=0D
CentOS Stream 8=0D
Kernel 6.3.0-rc2-eeac8ede1755+ on an x86_64=0D
=0D
test login: root=0D=0D
[   12.533569] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D3=
28 'systemd'=0D
Last login: Fri Mar 10 08:45:17 on ttyS0=0D
*******************************************************=0D
Welcome to the Embargoed Overlay on CentOS=0D
=0D
This content is for INTEL INTERNAL USE ONLY.=0D
=0D
For support issues, please submit a request:=0D
https://jira.devtools.intel.com/browse/LNXO=0D
*******************************************************=0D
[root@test ~]# =0D
[root@test ~]# =0D
[root@test ~]# ls=0D
anaconda-ks.cfg		   quick_test.c      syzkaller.9FSdCu  syzkaller.OjSrkA=0D
cet_ibt			   repro.c	     syzkaller.fIIL2o  syzkaller.Q5dMMG=0D
cpuid			   repro.sh	     syzkaller.G7vfvS  syzkaller.qCVHXV=0D
cpuid.c			   shadow_test_fork  syzkaller.IhmgVg  syzkaller.TRJkoZ=0D
file0			   shstk_cp	     syzkaller.iVVz3P  syzkaller.uq7iOt=0D
id_rsa.pub		   shstk_cp.c	     syzkaller.ju9NUO  syzkaller.uXhAhf=0D
Install_kernel_record.log  syzkaller.2e0D20  syzkaller.KfBl6t=0D
quick_test		   syzkaller.6TPmw0  syzkaller.mc3H24=0D
[root@test ~]# rm -rf repro=0D
[root@test ~]# ./re=07pro=0D
[  339.307328] loop0: detected capacity change from 0 to 65536=0D
[  339.307840] XFS: ikeep mount option is deprecated.=0D
[  339.310052] XFS (loop0): Mounting V5 Filesystem d408de26-55fb-48ab-a8ab-=
aacedb20f9dd=0D
[  339.315710] XFS (loop0): Ending clean mount=0D
[  339.316761] XFS (loop0): Quotacheck needed: Please wait.=0D
[  339.317833] XFS (loop0): Metadata CRC error detected at xfs_agf_read_ver=
ify+0x10e/0x140, xfs_agf block 0x1 =0D
[  339.318319] XFS (loop0): Unmount and run xfs_repair=0D
[  339.318534] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[  339.318812] 00000000: 58 41 47 46 00 00 00 01 00 00 00 00 00 00 40 00  X=
AGF..........@.=0D
[  339.319151] 00000010: 00 00 00 02 00 00 00 03 00 00 00 00 00 00 00 01  .=
...............=0D
[  339.319496] 00000020: 00 00 00 01 00 00 00 00 00 00 01 00 00 00 00 04  .=
...............=0D
[  339.319854] 00000030: 00 00 00 04 00 00 3f ca 00 00 3f c7 00 00 00 00  .=
.....?...?.....=0D
[  339.320193] 00000040: d4 08 de 26 55 fb 48 ab a8 ab aa ce db 20 f9 dd  .=
..&U.H...... ..=0D
[  339.320656] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.320998] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.321334] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.322361] XFS (loop0): metadata I/O error in "xfs_read_agf+0xd0/0x2c0"=
 at daddr 0x1 len 1 error 74=0D
[  339.323346] XFS (loop0): Quotacheck: Unsuccessful (Error -117): Disablin=
g quotas.=0D
[  339.341420] XFS (loop0): Metadata CRC error detected at xfs_agf_read_ver=
ify+0x10e/0x140, xfs_agf block 0x1 =0D
[  339.341888] XFS (loop0): Unmount and run xfs_repair=0D
[  339.342106] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[  339.342414] 00000000: 58 41 47 46 00 00 00 01 00 00 00 00 00 00 40 00  X=
AGF..........@.=0D
[  339.342760] 00000010: 00 00 00 02 00 00 00 03 00 00 00 00 00 00 00 01  .=
...............=0D
[  339.343105] 00000020: 00 00 00 01 00 00 00 00 00 00 01 00 00 00 00 04  .=
...............=0D
[  339.343534] 00000030: 00 00 00 04 00 00 3f ca 00 00 3f c7 00 00 00 00  .=
.....?...?.....=0D
[  339.343899] 00000040: d4 08 de 26 55 fb 48 ab a8 ab aa ce db 20 f9 dd  .=
..&U.H...... ..=0D
[  339.344248] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.344660] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.345010] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.347201] XFS (loop0): metadata I/O error in "xfs_read_agf+0xd0/0x2c0"=
 at daddr 0x1 len 1 error 74=0D
[  339.347823] XFS (loop0): page discard on page 000000007e0ebc83, inode 0x=
2b, pos 0.=0D
[  339.352925] XFS (loop0): Unmounting Filesystem d408de26-55fb-48ab-a8ab-a=
acedb20f9dd=0D
[  339.363249] XFS (loop0): SB summary counter sanity check failed=0D
[  339.363557] XFS (loop0): Metadata corruption detected at xfs_sb_write_ve=
rify+0x7d/0x180, xfs_sb block 0x0 =0D
[  339.363982] XFS (loop0): Unmount and run xfs_repair=0D
[  339.364203] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[  339.364652] 00000000: 58 46 53 42 00 00 04 00 00 00 00 00 00 00 80 00  X=
FSB............=0D
[  339.365004] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[  339.365343] 00000020: d4 08 de 26 55 fb 48 ab a8 ab aa ce db 20 f9 dd  .=
..&U.H...... ..=0D
[  339.365683] 00000030: 00 00 00 00 00 00 40 08 00 00 00 00 00 00 00 20  .=
.....@........ =0D
[  339.366030] 00000040: 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00 22  .=
......!......."=0D
[  339.366381] 00000050: 00 00 00 04 00 00 40 00 00 00 00 02 00 00 00 00  .=
.....@.........=0D
[  339.366722] 00000060: 00 00 04 98 b4 f5 02 00 02 00 00 02 00 00 00 00  .=
...............=0D
[  339.367062] 00000070: 00 00 00 00 00 00 00 00 0a 09 09 01 0e 00 00 14  .=
...............=0D
[  339.367548] XFS (loop0): Corruption of in-memory data (0x8) detected at =
_xfs_buf_ioapply+0x67d/0x690 (fs/xfs/xfs_buf.c:1553).  Shutting down filesy=
stem.=0D
[  339.368164] XFS (loop0): Please unmount the filesystem and rectify the p=
roblem(s)=0D
[  364.436316] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [repro:405=
]=0D
[  364.436724] Modules linked in:=0D
[  364.436868] irq event stamp: 21510=0D
[  364.437026] hardirqs last  enabled at (21509): [<ffffffff8300187e>] irqe=
ntry_exit+0x3e/0xa0=0D
[  364.437406] hardirqs last disabled at (21510): [<ffffffff82fff863>] sysv=
ec_apic_timer_interrupt+0x13/0xe0=0D
[  364.437826] softirqs last  enabled at (8970): [<ffffffff83024a4c>] __do_=
softirq+0x31c/0x49c=0D
[  364.438195] softirqs last disabled at (8897): [<ffffffff8112b5a4>] irq_e=
xit_rcu+0xc4/0x100=0D
[  364.438564] CPU: 0 PID: 405 Comm: repro Not tainted 6.3.0-rc2-eeac8ede17=
55+ #1=0D
[  364.438885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014=0D
[  364.439382] RIP: 0010:rcu_lockdep_current_cpu_online+0x5b/0x90=0D
[  364.439657] Code: 5b 41 5c 5d c3 cc cc cc cc 65 ff 05 d7 bb e1 7e e8 fa =
94 de 01 48 c7 c3 80 61 03 00 89 c0 48 03 1c c5 00 7b cb 83 48 8b 43 18 <48=
> 8b 40 70 48 85 43 20 74 10 65 ff 0d ac bb e1 7e 75 c0 0f 1f 44=0D
[  364.440449] RSP: 0018:ffffc90000eb3ba8 EFLAGS: 00000282=0D
[  364.440689] RAX: ffffffff83f64340 RBX: ffff88807dc36180 RCX: 00000000000=
00000=0D
[  364.441003] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00000=0D
[  364.441313] RBP: ffffc90000eb3bb8 R08: 0000000000000001 R09: 00000000000=
00000=0D
[  364.441626] R10: ffff88800f7e30d8 R11: 0000000000000000 R12: 00000000000=
00001=0D
[  364.441938] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000=0D
[  364.442248] FS:  00007f9db4acf740(0000) GS:ffff88807dc00000(0000) knlGS:=
0000000000000000=0D
[  364.442597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[  364.442852] CR2: 00007f5e8f6f5518 CR3: 000000000f6da004 CR4: 00000000007=
70ef0=0D
[  364.443169] PKRU: 55555554=0D
[  364.443297] Call Trace:=0D
[  364.443412]  <TASK>=0D
[  364.443519]  rcu_read_lock_held_common+0x33/0x50=0D
[  364.443741]  rcu_read_lock_sched_held+0x29/0x80=0D
[  364.443956]  lock_acquire+0x2ad/0x320=0D
[  364.444133]  ? lock_release+0x141/0x2e0=0D
[  364.444313]  ? write_comp_data+0x2f/0x90=0D
[  364.444507]  _raw_spin_lock+0x36/0x50=0D
[  364.444681]  ? xfs_ail_push_all_sync+0x73/0x110=0D
[  364.444893]  xfs_ail_push_all_sync+0x73/0x110=0D
[  364.445097]  ? __pfx_autoremove_wake_function+0x10/0x10=0D
[  364.445343]  xfs_reclaim_inodes+0xb8/0x140=0D
[  364.445543]  xfs_unmount_flush_inodes+0x63/0x80=0D
[  364.445757]  xfs_unmountfs+0x69/0x1f0=0D
[  364.445939]  xfs_fs_put_super+0x5a/0x120=0D
[  364.446130]  ? __pfx_xfs_fs_put_super+0x10/0x10=0D
[  364.446356]  generic_shutdown_super+0xac/0x240=0D
[  364.446573]  kill_block_super+0x43/0x80=0D
[  364.446759]  deactivate_locked_super+0x52/0xb0=0D
[  364.446966]  deactivate_super+0xb3/0xd0=0D
[  364.447156]  cleanup_mnt+0x15e/0x1e0=0D
[  364.447335]  __cleanup_mnt+0x1f/0x30=0D
[  364.447513]  task_work_run+0xb6/0x120=0D
[  364.447736]  exit_to_user_mode_prepare+0x200/0x210=0D
[  364.448017]  syscall_exit_to_user_mode+0x2d/0x60=0D
[  364.448293]  do_syscall_64+0x4a/0x90=0D
[  364.448513]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[  364.448809] RIP: 0033:0x7f9db4bfb7db=0D
[  364.449033] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e =
fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48=0D
[  364.449954] RSP: 002b:00007fff5b16db78 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000a6=0D
[  364.450376] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9db4b=
fb7db=0D
[  364.450745] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff5b1=
6dc20=0D
[  364.451108] RBP: 00007fff5b16ec60 R08: 0000000001e88333 R09: 00000000000=
00009=0D
[  364.451484] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004=
012c0=0D
[  364.451847] R13: 00007fff5b16eda0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[  364.452195]  </TASK>=0D
[  364.452301] Kernel panic - not syncing: softlockup: hung tasks=0D
[  364.452562] CPU: 0 PID: 405 Comm: repro Tainted: G             L     6.3=
.0-rc2-eeac8ede1755+ #1=0D
[  364.453010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014=0D
[  364.453551] Call Trace:=0D
[  364.453701]  <IRQ>=0D
[  364.453826]  dump_stack_lvl+0xa9/0x110=0D
[  364.454057]  dump_stack+0x19/0x20=0D
[  364.454262]  panic+0x4fd/0x520=0D
[  364.454455]  ? watchdog_timer_fn+0x31e/0x390=0D
[  364.454689]  watchdog_timer_fn+0x337/0x390=0D
[  364.454886]  ? __pfx_watchdog_timer_fn+0x10/0x10=0D
[  364.455101]  __hrtimer_run_queues+0x2ed/0x820=0D
[  364.455355]  hrtimer_interrupt+0x134/0x2d0=0D
[  364.455604]  __sysvec_apic_timer_interrupt+0x9c/0x290=0D
[  364.455902]  sysvec_apic_timer_interrupt+0xab/0xe0=0D
[  364.456185]  </IRQ>=0D
[  364.456314]  <TASK>=0D
[  364.456441]  asm_sysvec_apic_timer_interrupt+0x1f/0x30=0D
[  364.456742] RIP: 0010:rcu_lockdep_current_cpu_online+0x5b/0x90=0D
[  364.457067] Code: 5b 41 5c 5d c3 cc cc cc cc 65 ff 05 d7 bb e1 7e e8 fa =
94 de 01 48 c7 c3 80 61 03 00 89 c0 48 03 1c c5 00 7b cb 83 48 8b 43 18 <48=
> 8b 40 70 48 85 43 20 74 10 65 ff 0d ac bb e1 7e 75 c0 0f 1f 44=0D
[  364.457937] RSP: 0018:ffffc90000eb3ba8 EFLAGS: 00000282=0D
[  364.458211] RAX: ffffffff83f64340 RBX: ffff88807dc36180 RCX: 00000000000=
00000=0D
[  364.458613] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00000=0D
[  364.459006] RBP: ffffc90000eb3bb8 R08: 0000000000000001 R09: 00000000000=
00000=0D
[  364.459418] R10: ffff88800f7e30d8 R11: 0000000000000000 R12: 00000000000=
00001=0D
[  364.459813] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000=0D
[  364.460213]  ? rcu_lockdep_current_cpu_online+0x46/0x90=0D
[  364.460465]  rcu_read_lock_held_common+0x33/0x50=0D
[  364.460743]  rcu_read_lock_sched_held+0x29/0x80=0D
[  364.460980]  lock_acquire+0x2ad/0x320=0D
[  364.461170]  ? lock_release+0x141/0x2e0=0D
[  364.461391]  ? write_comp_data+0x2f/0x90=0D
[  364.461590]  _raw_spin_lock+0x36/0x50=0D
[  364.461804]  ? xfs_ail_push_all_sync+0x73/0x110=0D
[  364.462018]  xfs_ail_push_all_sync+0x73/0x110=0D
[  364.462228]  ? __pfx_autoremove_wake_function+0x10/0x10=0D
[  364.462479]  xfs_reclaim_inodes+0xb8/0x140=0D
[  364.462682]  xfs_unmount_flush_inodes+0x63/0x80=0D
[  364.462933]  xfs_unmountfs+0x69/0x1f0=0D
[  364.463112]  xfs_fs_put_super+0x5a/0x120=0D
[  364.463304]  ? __pfx_xfs_fs_put_super+0x10/0x10=0D
[  364.463522]  generic_shutdown_super+0xac/0x240=0D
[  364.463741]  kill_block_super+0x43/0x80=0D
[  364.463930]  deactivate_locked_super+0x52/0xb0=0D
[  364.464154]  deactivate_super+0xb3/0xd0=0D
[  364.464348]  cleanup_mnt+0x15e/0x1e0=0D
[  364.464564]  __cleanup_mnt+0x1f/0x30=0D
[  364.464787]  task_work_run+0xb6/0x120=0D
[  364.465002]  exit_to_user_mode_prepare+0x200/0x210=0D
[  364.465226]  syscall_exit_to_user_mode+0x2d/0x60=0D
[  364.465449]  do_syscall_64+0x4a/0x90=0D
[  364.465621]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[  364.465861] RIP: 0033:0x7f9db4bfb7db=0D
[  364.466065] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e =
fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48=0D
[  364.466917] RSP: 002b:00007fff5b16db78 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000a6=0D
[  364.467262] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9db4b=
fb7db=0D
[  364.467582] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff5b1=
6dc20=0D
[  364.467902] RBP: 00007fff5b16ec60 R08: 0000000001e88333 R09: 00000000000=
00009=0D
[  364.468228] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004=
012c0=0D
[  364.468605] R13: 00007fff5b16eda0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[  364.468992]  </TASK>=0D
[  364.469185] Kernel Offset: disabled=0D
[  364.469398] ---[ end Kernel panic - not syncing: softlockup: hung tasks =
]---=0D

--4we8hwUSWyIdAmkm--
