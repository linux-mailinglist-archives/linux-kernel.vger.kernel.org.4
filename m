Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3FB659438
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 03:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiL3Cix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 21:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3Ciu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:38:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A914D2A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672367929; x=1703903929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wnBmYq2cQfF4042Mubv7A9SCHIQkgek9faDkJ3cVpiI=;
  b=HoLjnFVdCRT0L2Z2KZoOwR5e46bK0UJZtzk6K7A4qbiu7lvl/b2F/Fn+
   KeK0hw9jVRy5DrMMgvKB+C69RwVIaoG+tkEAEQo0DDEaxGgw0G/vhc40O
   XY+QpF+ESJGyIEZC036gscNt8ZTkt7GSGKhuQh1ha5ij78RmIQEbUb4pu
   ou7QH9KiVJQjYPnfIQSYZiZpl/4nMTu0z1sOv3gIJs16bx2Hiam4YP/13
   n2GKoPMPKZh00uWzjA5U60a7DysSK16N/e6TIzHGoIFwbdjiKQmVzyKdH
   JKvVkYzZgLRdvurdQ9mkv1O32Y2ENvzbGd9MyIE2IpY89KWtiVufyTOwV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="304649070"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="304649070"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 18:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="827844793"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="827844793"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 29 Dec 2022 18:38:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 18:38:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 18:38:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 18:38:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 18:38:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEB/tWdLLVAD+wbgwYpGQFAMbwhWffWw4x3LkbbRNgvsjVdxW2YwnZ9FboHFl2insQmJ0EXlQr0Z5S2AAl45nPiQZRkT/CCuNdBitP+WSBgLBBSvvnvFw1cLLKJ8BmCXqiUK4zl7Vmu5MzNroPWRmfzwA8IkevF2VyxSO0LWwAwz8a+6IEgC7NKmTSy8smXQGv7RDVaeAZfSxRqb+9C6GKRmYs/qmLiDur5RX4SA6yHbXtIHAplkC6DAjM7ba6B/8Ok8AWWVbaQJ77jZOAJW09+/XH5Xm8qiJxW9YHmdaSCL8VErq1TaWGRmbLUmm9vE/C5Xzs47HR5AcNlVfupZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkpyCkbTSt8AcNSW0X03tO9JxrYwb7RZrOe/DuCAJ+g=;
 b=DBWc/rtGebHokYfDuNsGL2JkLvKrTErQK9cQhzILVXzRIs96WE89wugN20WFRaLmqYOSEec81PX660tGA/8ewjE0826qYIZhN5+miuZWXvIzgX63RzkP8NY+3fzB2C5UsdxXDv49h1sx5LMj3VbC7GzI1JmF/iaQyndPejheajIGYl0MfxNlHVHj9dDeXT+MS3MTcIEJkLYcUw/A3uVKT3MDpPPBbGON058wC98CoO1PaoxEHlb965QuWEg8t002gZYFLmM+h3SWJ4JN6GLeToHJgROsFtHdDauvp4BfEO6jgN2y4Kytkwor1yU4KyvbbSt/xVCPJGfVaIGocaqngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17; Fri, 30 Dec
 2022 02:38:45 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::a95:5288:9215:a267]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::a95:5288:9215:a267%3]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 02:38:45 +0000
Date:   Fri, 30 Dec 2022 10:39:33 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: [syzkaller & bisect] There is "put_pmu_ctx" WARNING in v6.2-rc1
 kernel
Message-ID: <Y65PZS4jTj9mXLev@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA2PR11MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af576cc-6d22-4dfd-fd82-08daea0ef939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/PPO7+QGQkVqQZ3g+vY3gksGlHraWYlPskRH6XViNhSPeSH3bzv8ihoyinEtmoxfOTL96T3FQG/uh9I6/RryQt0wS6wX3jMmdODvU3cZzjn3Fw9bZjeG3U83PohyQmmgS17uPJQDm44NukukWlhuJ7xH92rEkHaP+v+/v2FbVx4dX5S98l1+LuOAmjm2bvySTrbjJkkXASh73LXWO6I3iXBXD9mrc4GEBh9hW/3PrPsj/Px77W7rtuAlociA4GBXpL4Zsy/00pFuDAkMKqNs6Px/HLyvHYFUFnFXW22ZhRpACOOh3ufBDlIqE4mix8DUhqDLxoy1Tk0Nm1MNNgT7NhezV0D/rYS/XEkpdAOjc9CGtZ/1rsXNKjrLMCSC5dD2uDQu9RDYNAQJw2VKHAAgy+aGBMiawf1uWNunWARv/fVsBH5UeJjNHT/tM96IiNtYHPrduECnj5Olqp3OmV/9OpQZPpFD4nebA4/UgDDCA9mw/c/20Lakei5/7LhxKICTxR4wdgdvfVHz0Jk60Bdm8MVxWvG3e6WmEiU6DXH+G3MbbpuCQhm2iEdJz+WsmY9fB8uZvonMvJd6T/65L/6rYQL2qn+tMc0sncNDF87qzB9i2hjPELcKezBbgK/4jDrWZQ3XhK+iZ9LDx2oxl3I4rwZx1rWbgxSaQOiXhXv/aY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(38100700002)(41300700001)(8936002)(4326008)(83380400001)(8676002)(66476007)(66556008)(5660300002)(66946007)(82960400001)(6512007)(186003)(44832011)(478600001)(6486002)(26005)(966005)(6506007)(45080400002)(2906002)(6666004)(6916009)(86362001)(316002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgg0+ZpyK4sol7U/sSe+BY8IpS9XzMdyBd+Ix4/Tq4lebb4z4Sli9/rEtTye?=
 =?us-ascii?Q?daFjTBAkzS8i9ciwr6YfV70FvZXXz2joeIEvDsEf26v4IzIfXIfLpCCVuozg?=
 =?us-ascii?Q?TXAu+YQlhEHObEZzBzbjLUzsVbZGSkVKIbdlHAuhsi0/EFIHxI1/G89LWUNj?=
 =?us-ascii?Q?Ef9hzyF6DPCmuTX2CeCGxSNdW+IPbL4w+fhZhqf5p7Wn3xQvQQLSsWkeJizP?=
 =?us-ascii?Q?51V4DOKtwXoL3OASLt3hkWdojvBSmDAtnk3tJy7+qL9VTHsDcxdt6vUcyLgQ?=
 =?us-ascii?Q?Rtg0lnJ0KD7Yk6WusoujzbzrT/7IaZ7siSRYNpqaFzHAXWhmy4nyrDQEdN8E?=
 =?us-ascii?Q?RxCO1kozNDTSAXmPk2ZIGrnGhOr9ig9BS/iTNRPhrmBUhC2MruaDGIdrsIga?=
 =?us-ascii?Q?MzdApdEvHetoThnRdPfZLVGD0S+MLMMZXwaSJyptgnI87R8o6tK1juF2WVJP?=
 =?us-ascii?Q?l6ljXXF5zkWXF2ODCAlDf7XmBkWsy9LT1QOBYaszzu6xDh3xNYwbaBsyEqi5?=
 =?us-ascii?Q?SpJ3nltFe7OFXba6xsXB7vqMdDBBGUA29ixWmhd9D+PElAOgust6YSFBSQ2e?=
 =?us-ascii?Q?jTKNiH2IaXwPCD90uuXv41cjtufx3mOjXJdiI/O/zn3JyhoHg9S1WcCPc1By?=
 =?us-ascii?Q?OFdaKdU3kMo+i9IStn1oip+2+fscen12rfD4/mNFyEfhV+pco/4PC0pkMVlp?=
 =?us-ascii?Q?tMkumoBUrNrlChljDOpjvbxqfxZ1wdp6tKr/nRbE+0H5JvMCwNyI8AyUzmcd?=
 =?us-ascii?Q?awCvnrFDEngbTeY68zCpEfNFB+iHc7/Nj9g+sgi4zzKnTq1G/po/tO9Ao7Ow?=
 =?us-ascii?Q?k2ebI6j/HnoNIeJ9dzHEqcZE+Qeb50ZxqDAMfGsUrsahGMtLuZ504H86X7aa?=
 =?us-ascii?Q?sCZqCn2e+RD2CT3SWWB1QXFj4fBfrvxqu3Ez1YatjE2isz8b8wkG5w5wBlGG?=
 =?us-ascii?Q?rgrC87ykscE9/rSO0gV+frOgVxAUApJ42ipDT5JQBDC7QqrlgE8tvKEth22J?=
 =?us-ascii?Q?JCMhpSwfpIg0IXMYhnT50W9Bub2Uqpjy4o2UADDB1EvP6DV5BCEnbk0ENcGi?=
 =?us-ascii?Q?YIhAj3WyEd61rdytDsa89qwCfIKTPz1cQjsi10v9V9E1H7wL/V5HO6DzTnJ8?=
 =?us-ascii?Q?al0W+3y8l/veArkknytFpLHHh04TF+8uaalU02BF7SrD5Es8NumdWFUMsIM9?=
 =?us-ascii?Q?VbPDgcF6sllCuPdAjWoNzNqki3UwWEcZiwdStS5hXwmre8552aL2x8VSWgxE?=
 =?us-ascii?Q?7FiMqG/BGESip+zd0R+WwVbdnbTEBELP2HnF3ZwlFekdiT1PXSyCD0lvg00d?=
 =?us-ascii?Q?eqGkgK6VkEtvIfVSb2Ptisf/Wo6mFTb0j0OzTi3kJrkjclkUDiErC3ErXW94?=
 =?us-ascii?Q?BO7/lm79THs92Cex2iq+XT/dI0spwYPlHCj87P5aNcrZCzt3MoO7Xeu0wwgu?=
 =?us-ascii?Q?lSVK2ib6dl+/Wya7WqBGNASbpBqnbN+NrSumE3uOltEd9mDElRHsbbzRlch1?=
 =?us-ascii?Q?CvTKVIxP9x94+jKKsRG71q6w07kaF9QM9bvbiG8EzYOAA7Tzxbi3AROBRzF0?=
 =?us-ascii?Q?DynHDE1IomvEklRs/pEOo46r6n8t8zZlhVRFza+zd50I91ElsG3n8PZcOETR?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af576cc-6d22-4dfd-fd82-08daea0ef939
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 02:38:45.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWHLgJERaBnjFvVFCuSykZbnjlKYNJS/XEvSaQQkrxRlQPTOkc2hA3GN8hPQ8xzpTluexntsdMTBNBzLXxTV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

There is "put_pmu_ctx" WARNING in v6.2-rc1.
"
[   41.406655] ------------[ cut here ]------------
[   41.407205] WARNING: CPU: 1 PID: 13365 at kernel/events/core.c:4920 put_pmu_ctx+0x107/0x120
[   41.408077] Modules linked in:
[   41.408411] CPU: 1 PID: 13365 Comm: repro Not tainted 6.2.0-rc1-1b929c02afd3 #1
[   41.409187] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   41.410332] RIP: 0010:put_pmu_ctx+0x107/0x120
[   41.410891] Code: e8 fe 5b e9 ff 48 8d 7b 50 48 c7 c6 00 84 42 81 e8 3e 78 dd ff e8 e9 5b e9 ff 5b 41 5c 41 5d 5d c3 cc cc cc cc e8 d9 5b e9 ff <0f> 0b eb a5 e8 d0 5b e9 ff 0f 0b eb 8a e8 c7 5b e9 ff 0f 0b e9 35
[   41.412900] RSP: 0018:ffffc90004073cd0 EFLAGS: 00010246
[   41.413431] RAX: 0000000000000000 RBX: ffff88807dc3cd00 RCX: 0000000000000001
[   41.414373] RDX: 0000000000000000 RSI: ffff8880170fc680 RDI: 0000000000000002
[   41.415548] RBP: ffffc90004073ce8 R08: 0000000000000001 R09: 0000000000000001
[   41.417042] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807dc2ed40
[   41.417801] R13: ffff88807dc3cd10 R14: 0000000000000000 R15: 0000000000000001
[   41.418526] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   41.419349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.419935] CR2: 00007fff5123a918 CR3: 000000000d890001 CR4: 0000000000770ee0
[   41.420666] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   41.422020] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   41.423292] PKRU: 55555554
[   41.423633] Call Trace:
[   41.423883]  <TASK>
[   41.424116]  _free_event+0x18f/0x800
[   41.424561]  put_event+0x3c/0x50
[   41.425021]  perf_event_release_kernel+0x2de/0x360
[   41.425954]  ? __pfx_perf_release+0x10/0x10
[   41.426776]  perf_release+0x22/0x30
[   41.427378]  __fput+0x11f/0x450
[   41.427728]  ____fput+0x1e/0x30
[   41.428077]  task_work_run+0xb6/0x120
[   41.428560]  do_exit+0x521/0x1340
[   41.428924]  ? lockdep_hardirqs_on+0x8a/0x110
[   41.429397]  ? trace_hardirqs_on+0x3f/0x100
[   41.429856]  do_group_exit+0x5e/0xf0
[   41.430231]  __x64_sys_exit_group+0x25/0x30
[   41.430661]  do_syscall_64+0x3b/0x90
[   41.431024]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   41.431559] RIP: 0033:0x7f64e31ffcf6
[   41.431949] Code: Unable to access opcode bytes at 0x7f64e31ffccc.
[   41.432591] RSP: 002b:00007fff5123a8d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   41.433368] RAX: ffffffffffffffda RBX: 00007f64e330a490 RCX: 00007f64e31ffcf6
[   41.434240] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   41.435001] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[   41.435748] R10: 0000000000000004 R11: 0000000000000246 R12: 00007f64e330a490
[   41.436460] R13: 0000000000000001 R14: 00007f64e330de88 R15: 0000000000000000
[   41.437174]  </TASK>
[   41.437432] irq event stamp: 2811
[   41.437824] hardirqs last  enabled at (2819): [<ffffffff811d48f1>] __up_console_sem+0x91/0xb0
[   41.438692] hardirqs last disabled at (2826): [<ffffffff811d48d6>] __up_console_sem+0x76/0xb0
[   41.439644] softirqs last  enabled at (2480): [<ffffffff82f9b213>] __do_softirq+0x323/0x48a
[   41.440499] softirqs last disabled at (2353): [<ffffffff811231a2>] irq_exit_rcu+0xd2/0x100
[   41.441352] ---[ end trace 0000000000000000 ]---
"

[bd27568117664b8b3e259721393df420ed51f57b] perf: Rewrite core context handling

All reproduced code and bisect info is in link:
https://github.com/xupengfe/syzkaller_logs/blob/main/221229_114350_put_pmu_ctx/bisect_info.log

I hope it's helpful.

Thanks!
BR.
