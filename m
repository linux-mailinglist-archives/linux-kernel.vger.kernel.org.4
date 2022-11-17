Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B562D969
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiKQLbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKQLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:31:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926824B9A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668684698; x=1700220698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/MgVZA707SVuZgyM7DaFqQK7IOJQJ4dnjt1HSm+wGaE=;
  b=XNEEX5DQpU9WYRp5fSJGc9VC6Eoy8d9VtyOoUoI1AnOGCbvznbUQfeGz
   ulSJzXt8GR+5zDLaPlimod59/YgIUo16NDcTwVit4gRm3N56BOr2Fi8fe
   Aw/D6EVL31aeN4vZIxlEv+2jN/qet/hWXljh6J4JEhSqSBg/XPhdD8EXO
   xaaIaKzCwFM8FJDIN5yq+qaosuEDf5SDEV5CPysS44N5nfEwmY10fdriC
   3B4Ibu5eozLld+64Eauw0XdUfRxXARONAHqTGhzUKRIzMn/tBXvAaG7UE
   9TMaWb7i3HZvbY8u+D6yqTd/nV8dOjD+o+rdUqlh4Cku5nl1K8GOP7g5N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310457030"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="c'?log'?scan'208";a="310457030"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968847101"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="c'?log'?scan'208";a="968847101"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2022 03:31:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 03:31:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 03:31:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 03:31:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 03:31:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1aE6zyao15T/zWMsb1SoL1JqDuNnAcpNUqK4yq4XSY1o/Qn9FyiUBkYk6oYgNjEg99WUktYMYhjb9y9+6TJSDKW782SWJRSAx7JHfZS2BxibTx+s0gLulldpZylris3UTW2Pg7mtbcOjoII6wpOl16LwcNN9jwDI0VOcegf7kJD5zt0WuG0byDgzbLLDy87fxyiBwLbXEwft9sPsRchf0wHih2JCIqZxWm2L0fTmafMCJi1RbCO7uWNytJXWTcv8qrVeHbJtwHq45uwzQ5spcPenlAewifm2AbN4Uzol/7Iwrrcj/aCFcgvwjRBsGWs4qS9cfJaxt+30jDO+dIvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg0cZBYps6te8offrj/OQgjZa67+w4brT8Fcc69trpE=;
 b=b6BKBRCvgDEI7TiRsREqNerinhI0uUAjJ8SjsD2UrRujsS8bifI4VCT9UiiPQ7t46+c+T8egSAmnSAo/BGJ9chXOpEH5NzcvXSXyv0E56MYuRDdkeC8zAkptA8t+zsZk3ydBuZe5hhNuEZc+JN7B4rs2Qr05HVSVMo39ZztWUR32GYrZP0uNiUyQiGLqJJzATkBo5mB6CYazh2XBG5Bri6DgYbXrX0/0s9/SN38r8rKeirpqTNbIAttthkSnDiPhnQ5ny6tNpT1Dupppzh37aJAlmIVY2BIdGoEW0pst7FiWL7Uh9+1gQ53+7RmkbOGw44GTsdARwejVsTpBKpKNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 11:31:32 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%6]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 11:31:32 +0000
Date:   Thu, 17 Nov 2022 19:31:50 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <mszeredi@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <pengfei.xu@intel.com>,
        <heng.su@intel.com>
Subject: [Syzkaller & bisect] There is "notify_change" WARNING in v6.1-rc5
 kernel
Message-ID: <Y3Ybpuy67I0xlwLa@xpf.sh.intel.com>
Content-Type: multipart/mixed; boundary="KvahmxHLtCjAe3ik"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 726d9edd-d0ca-48d4-bc06-08dac88f45bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMNj+WvHKbjFnCT3YyPRz9f0WGyPUQR435w6xyQrZmCxADf3hGikr2IJTmuAIB3qVfXt3J0B1idhYrFpcHvq6RLZZg6m/KUN7kBX0u7H6WT93ERLYPKNlcyJIpoyx9ESC8xwdpdpHSdvbLGlXDAYGcyrJYwW01hLwnGl7C1J697JdqOvEAGSmCTtUOZRT1Oh3FueFUBraj5fGqPmPXcVRAFyjUOLt4E1Gl2rWExHXiPywwce0hbEFmHp6sMGq8FdUOnpUrlpjCHiQjwxgYp5YCrcDtssbzrnG481p1BgKF7Uqo0FqUR/ISi5Zdk3hMEojAPNxWay2Vn2e21CdvsKvzmOpGn69Bt7NGsnpVNz7X4INBmx0bVsWLny7RB62Y0sk9XNQB5nBPDoAQ495Nc6q5KR2I4uRsZJg/XB7OMmNLm6n9Lu96awLvlA0+HSSJLX1HngJ5yq13Ogz+gR+OUELrfwDXaECtMjL8llGHgcxp7pl9UagwQHbMP/lN0xrSg1svF0K6jpyxK8TuM5db19XruSjPcQhN+0kGAjaRtnnRgXPRcUfn9jEXxyWkOvt0xnlxz8mIr1BctCc2WM7JDasR0QfXYCkvqiDYjhHk7H3Jc/8JHS8tZoRtpP+nXlHn0OJG0M5LqTyIPAybPD1NqYSc9hu/jLnlM//ojpmvgiYuhioLLANRLjOycYQAJNy8SviLOXbybYihh7HDULBQwjJoXQyPT/Bd0xvEnYfi97uus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(83380400001)(21480400003)(2906002)(8936002)(82960400001)(478600001)(38100700002)(235185007)(966005)(5660300002)(44832011)(6486002)(186003)(6916009)(316002)(8676002)(66556008)(66946007)(4326008)(26005)(6512007)(6506007)(66476007)(6666004)(107886003)(45080400002)(41300700001)(86362001)(44144004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?63EViNLEJOz8wtbxqbNmT2ySB4gjoNCOUH4SfEsiml2SSTxOB8x4oQ7ok1W5?=
 =?us-ascii?Q?FWJQglGykJOr3+Py8k+cvZ/QYezTpwyZD81l2acVT87H2WFE2BmScubzb0w4?=
 =?us-ascii?Q?jGrkDgr0/nAH15Y3SwPvNDUO6oy34yD0hRg0YjMWOdvwgUCoCp6y23dkVv0C?=
 =?us-ascii?Q?D9FwhR/SZ12VmiPFJSF4ZfQ1ZzH3fNptHbXSoDQwIwP06dNfyIyyLG9gg2cI?=
 =?us-ascii?Q?xL3bJcMaSJtG+NYTN4oyEh4ByQrsvQ4i0Hd8/sa2urJrR8XqrG5zIwUhHRa1?=
 =?us-ascii?Q?cUpuF0yQwzqpnEeYI3lcZ+d5P9IJafGlwKCgCkIlNcX8G5d5PYWOsKNXp0Y4?=
 =?us-ascii?Q?aHw75GYDIISWh3ox/4eQekvknXkqPzsgI9sy/N+6xBLg1vqrsg4IklO4KQPH?=
 =?us-ascii?Q?0XegiS50/TrF3SvNERBtBItF6oHM+6hWAra6kBVt0z6XtbwKXZD62sasFwOf?=
 =?us-ascii?Q?fY+PU43YoES8asDcYDcT7KaY+TE6aUjWHctW9oURajzfQC7Mi236un/ghvWu?=
 =?us-ascii?Q?UmwxiwQ96+QMJpUoZEGNXvV2g2Q3dB4eD0XZ4HHl9fbpFi66c1eYZJMJLHrL?=
 =?us-ascii?Q?gg41HrSHRaLnT5RfkAT5uHQhRl5PwjfKQpzBX7TJ3ZPLSyEJhCLNDmjXq9zu?=
 =?us-ascii?Q?gXUTjVc5oBt7r7iKWjmdyBockrrDkhefSfcUugVg1LIx8t3Wj2JZZjniOEus?=
 =?us-ascii?Q?uiQaWkt0XDLkDdVP/MOYBETHtuw0jHI+2hNZK4x3KkjrFQ5wPNbjqdPXio1J?=
 =?us-ascii?Q?lNcyvYZS3DeF/18M3niAyfpdUVwe27i+LN+m9KAhmnEuTYHstIhgnG6A5ksL?=
 =?us-ascii?Q?tgrU83HGzY/tZkzIXMojs9gMIpL1+KTnV3hC77CKlniX14ff9ULdrXa4l7Lp?=
 =?us-ascii?Q?+xipIRbUFx/+KYZHPmYudpJjS0O3vVq+VTzJ27Y1vVOYO4ioLJkeinbk7oSp?=
 =?us-ascii?Q?9NLNBfhQaPQZLbXT5O7uojls5G/NeBGx07ouAK3P7QpavnkUGduGnf1STQrB?=
 =?us-ascii?Q?ZsmYsEK4rB5vgTweHEi83aiwc3/gy+4nfldSfVkDRpbso5RCgZZIQCTnwRdV?=
 =?us-ascii?Q?2wcOGzVe+UgNfUWjgfaepIUBUg/ZJkz/FbfzdmksTcUte/zKuQkEKgDd8ger?=
 =?us-ascii?Q?KP8GyLfj2conftb1+jRkygSXNvqEP2vk3+fqfgjxRoUsuHPP+s9vpLz1wQI0?=
 =?us-ascii?Q?tVhv9glikyqPgBDAw5bBkcfcgF5DEvoDAjQhaQCy0wQ2Y0ODJ6HxKgKiExh/?=
 =?us-ascii?Q?DfMrRgGsPgzWfTmguOVtCTePHi58CqkQdhdcv+avVS4acXlluDHKy59ZN4uZ?=
 =?us-ascii?Q?fD6aQb3LG3CH+mM2DLgN9vzVwHIVno83tjGkIKZ0Jo4ftRp94JLhLkzG0GhX?=
 =?us-ascii?Q?zkuvJPVW2h/BiUrSQ4sVV3vGr4Z4D5breum1pzZ8y7l5jUTkKm404yOvFgvZ?=
 =?us-ascii?Q?Qt8ofzRa2W8nwOlVgJJqdk2NbDal7Ai6uh6vvagNJZZ9nk6OpBZPXtEr+LCp?=
 =?us-ascii?Q?KeNNCN0CLplnHkxusfgrg/4cG72BxdHfMELKbdLY6W8MGePyAuEA1eV2kn1f?=
 =?us-ascii?Q?Lgdarq62bwJRl1mFutcEIZ20ms8ubP2i00VJTDH7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 726d9edd-d0ca-48d4-bc06-08dac88f45bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 11:31:32.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWP1wIjAZ/iEDeD3DAN8yhM0SyZNMSCDvKkpJz6QDPyRBmKayYSPbj/pX34frBle/jB9Cva9x+nirnBpQkM60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--KvahmxHLtCjAe3ik
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Miklos Szeredi and developer,

Greeting!

There is "notify_change" WARNING in v6.1-rc5:
[   45.378232] ------------[ cut here ]------------
[   45.378741] WARNING: CPU: 0 PID: 463 at fs/attr.c:327 notify_change+0x9a1/0xb50
[   45.379511] Modules linked in:
[   45.379868] CPU: 0 PID: 463 Comm: repro Not tainted 6.1.0-rc5-094226ad94f4 #1
[   45.380617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   45.381752] RIP: 0010:notify_change+0x9a1/0xb50
[   45.382234] Code: 44 89 f6 e8 81 2d cf ff 41 83 fe ff 74 0c c7 45 c4 00 00 00 00 e9 e1 fd ff ff 41 be b5 ff ff ff e9 ea fb ff ff e8 ef 2b cf ff <0f> 0b e9 c2 4
[   45.384114] RSP: 0018:ffffc90000ef3b30 EFLAGS: 00010246
[   45.384661] RAX: 0000000000000000 RBX: 0000000000004200 RCX: ffffffff8155b451
[   45.385389] RDX: 0000000000000000 RSI: ffff88800cd40000 RDI: 0000000000000002
[   45.386112] RBP: ffffc90000ef3b90 R08: ffff888009ed2f50 R09: 0101010101010101
[   45.386840] R10: ffffc90000ef3bb0 R11: 0000000000005c67 R12: ffffc90000ef3bb8
[   45.387568] R13: ffff88800af5ed80 R14: 0000000000000000 R15: ffffffff8385ff40
[   45.388312] FS:  00007f914d059700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   45.389142] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.389727] CR2: 0000000020006000 CR3: 000000000bfc0006 CR4: 0000000000770ef0
[   45.390458] PKRU: 55555554
[   45.390752] Call Trace:
[   45.391015]  <TASK>
[   45.391253]  ? write_comp_data+0x2f/0x90
[   45.391697]  __file_remove_privs+0x1de/0x240
[   45.392181]  ? __file_remove_privs+0x1de/0x240
[   45.392671]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   45.393181]  ? current_time+0x64/0xb0
[   45.393592]  file_modified_flags+0x51/0x160
[   45.394055]  file_modified+0x20/0x30
[   45.394462]  fuse_file_fallocate+0x53a/0x620
[   45.394928]  ? __schedule+0x2e6/0x8f0
[   45.395347]  ? fuse_copy_file_range+0xc0/0xc0
[   45.395835]  vfs_fallocate+0x336/0x690
[   45.396243]  ioctl_preallocate+0xdf/0x110
[   45.396677]  do_vfs_ioctl+0xaf9/0xc20
[   45.397080]  ? __fget_light+0xb0/0x220
[   45.397488]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   45.397993]  ? write_comp_data+0x2f/0x90
[   45.398419]  __x64_sys_ioctl+0xca/0x160
[   45.398836]  do_syscall_64+0x3b/0x90
[   45.399235]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   45.399788] RIP: 0033:0x7f914d17f59d
[   45.400182] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   45.402039] RSP: 002b:00007f914d058b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   45.402815] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f914d17f59d
[   45.403543] RDX: 00000000200001c0 RSI: 0000000040305828 RDI: 0000000000000004
[   45.404286] RBP: 00007f914d058e00 R08: 0000000100000001 R09: 0000000000000000
[   45.405023] R10: 0000000100000001 R11: 0000000000000246 R12: 00007fff22e7ec4e
[   45.405758] R13: 00007fff22e7ec4f R14: 00007fff22e7ece0 R15: 00007f914d059700
[   45.406496]  </TASK>
[   45.406736] ---[ end trace 0000000000000000 ]---

Bisected and found the first bad commit:
4a6f278d4827b59ba26ceae0ff4529ee826aa258
"fuse: add file_modified() to fallocate"

After only revert this commit, this issue was gone.

Kconfig, reproduced code from syzkaller, bisect info is in attached.

All detailed info is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221117_083125_notify_change

If you find this info is useful, please add the "Reviewed-by" tag from me.

Thanks!
BR.

--KvahmxHLtCjAe3ik
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="repro.c"

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <setjmp.h>
#include <signal.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>
#include <linux/loop.h>

static unsigned long long procid;

static __thread int skip_segv;
static __thread jmp_buf segv_env;

static void segv_handler(int sig, siginfo_t* info, void* ctx)
{
  uintptr_t addr = (uintptr_t)info->si_addr;
  const uintptr_t prog_start = 1 << 20;
  const uintptr_t prog_end = 100 << 20;
  int skip = __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) != 0;
  int valid = addr < prog_start || addr > prog_end;
  if (skip && valid) {
    _longjmp(segv_env, 1);
  }
  exit(sig);
}

static void install_segv_handler(void)
{
  struct sigaction sa;
  memset(&sa, 0, sizeof(sa));
  sa.sa_handler = SIG_IGN;
  syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
  syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
  memset(&sa, 0, sizeof(sa));
  sa.sa_sigaction = segv_handler;
  sa.sa_flags = SA_NODEFER | SA_SIGINFO;
  sigaction(SIGSEGV, &sa, NULL);
  sigaction(SIGBUS, &sa, NULL);
}

#define NONFAILING(...)                                                        \
  ({                                                                           \
    int ok = 1;                                                                \
    __atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST);                       \
    if (_setjmp(segv_env) == 0) {                                              \
      __VA_ARGS__;                                                             \
    } else                                                                     \
      ok = 0;                                                                  \
    __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST);                       \
    ok;                                                                        \
  })

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev)
{
  ev->state = 0;
}

static void event_reset(event_t* ev)
{
  ev->state = 0;
}

static void event_set(event_t* ev)
{
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

struct fs_image_segment {
  void* data;
  uintptr_t size;
  uintptr_t offset;
};

#define IMAGE_MAX_SEGMENTS 4096
#define IMAGE_MAX_SIZE (129 << 20)

#define sys_memfd_create 319

static unsigned long fs_image_segment_check(unsigned long size,
                                            unsigned long nsegs,
                                            struct fs_image_segment* segs)
{
  if (nsegs > IMAGE_MAX_SEGMENTS)
    nsegs = IMAGE_MAX_SEGMENTS;
  for (size_t i = 0; i < nsegs; i++) {
    if (segs[i].size > IMAGE_MAX_SIZE)
      segs[i].size = IMAGE_MAX_SIZE;
    segs[i].offset %= IMAGE_MAX_SIZE;
    if (segs[i].offset > IMAGE_MAX_SIZE - segs[i].size)
      segs[i].offset = IMAGE_MAX_SIZE - segs[i].size;
    if (size < segs[i].offset + segs[i].offset)
      size = segs[i].offset + segs[i].offset;
  }
  if (size > IMAGE_MAX_SIZE)
    size = IMAGE_MAX_SIZE;
  return size;
}
static int setup_loop_device(long unsigned size, long unsigned nsegs,
                             struct fs_image_segment* segs,
                             const char* loopname, int* memfd_p, int* loopfd_p)
{
  int err = 0, loopfd = -1;
  size = fs_image_segment_check(size, nsegs, segs);
  int memfd = syscall(sys_memfd_create, "syzkaller", 0);
  if (memfd == -1) {
    err = errno;
    goto error;
  }
  if (ftruncate(memfd, size)) {
    err = errno;
    goto error_close_memfd;
  }
  for (size_t i = 0; i < nsegs; i++) {
    if (pwrite(memfd, segs[i].data, segs[i].size, segs[i].offset) < 0) {
    }
  }
  loopfd = open(loopname, O_RDWR);
  if (loopfd == -1) {
    err = errno;
    goto error_close_memfd;
  }
  if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
    if (errno != EBUSY) {
      err = errno;
      goto error_close_loop;
    }
    ioctl(loopfd, LOOP_CLR_FD, 0);
    usleep(1000);
    if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
      err = errno;
      goto error_close_loop;
    }
  }
  *memfd_p = memfd;
  *loopfd_p = loopfd;
  return 0;

error_close_loop:
  close(loopfd);
error_close_memfd:
  close(memfd);
error:
  errno = err;
  return -1;
}

static long syz_mount_image(volatile long fsarg, volatile long dir,
                            volatile unsigned long size,
                            volatile unsigned long nsegs,
                            volatile long segments, volatile long flags,
                            volatile long optsarg)
{
  struct fs_image_segment* segs = (struct fs_image_segment*)segments;
  int res = -1, err = 0, loopfd = -1, memfd = -1, need_loop_device = !!segs;
  char* mount_opts = (char*)optsarg;
  char* target = (char*)dir;
  char* fs = (char*)fsarg;
  char* source = NULL;
  char loopname[64];
  if (need_loop_device) {
    memset(loopname, 0, sizeof(loopname));
    snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
    if (setup_loop_device(size, nsegs, segs, loopname, &memfd, &loopfd) == -1)
      return -1;
    source = loopname;
  }
  mkdir(target, 0777);
  char opts[256];
  memset(opts, 0, sizeof(opts));
  if (strlen(mount_opts) > (sizeof(opts) - 32)) {
  }
  strncpy(opts, mount_opts, sizeof(opts) - 32);
  if (strcmp(fs, "iso9660") == 0) {
    flags |= MS_RDONLY;
  } else if (strncmp(fs, "ext", 3) == 0) {
    if (strstr(opts, "errors=panic") || strstr(opts, "errors=remount-ro") == 0)
      strcat(opts, ",errors=continue");
  } else if (strcmp(fs, "xfs") == 0) {
    strcat(opts, ",nouuid");
  }
  res = mount(source, target, fs, flags, opts);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  res = open(target, O_RDONLY | O_DIRECTORY);
  if (res == -1) {
    err = errno;
  }

error_clear_loop:
  if (need_loop_device) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
    close(memfd);
  }
  errno = err;
  return res;
}

#define FUSE_MIN_READ_BUFFER 8192
enum fuse_opcode {
  FUSE_LOOKUP = 1,
  FUSE_FORGET = 2,
  FUSE_GETATTR = 3,
  FUSE_SETATTR = 4,
  FUSE_READLINK = 5,
  FUSE_SYMLINK = 6,
  FUSE_MKNOD = 8,
  FUSE_MKDIR = 9,
  FUSE_UNLINK = 10,
  FUSE_RMDIR = 11,
  FUSE_RENAME = 12,
  FUSE_LINK = 13,
  FUSE_OPEN = 14,
  FUSE_READ = 15,
  FUSE_WRITE = 16,
  FUSE_STATFS = 17,
  FUSE_RELEASE = 18,
  FUSE_FSYNC = 20,
  FUSE_SETXATTR = 21,
  FUSE_GETXATTR = 22,
  FUSE_LISTXATTR = 23,
  FUSE_REMOVEXATTR = 24,
  FUSE_FLUSH = 25,
  FUSE_INIT = 26,
  FUSE_OPENDIR = 27,
  FUSE_READDIR = 28,
  FUSE_RELEASEDIR = 29,
  FUSE_FSYNCDIR = 30,
  FUSE_GETLK = 31,
  FUSE_SETLK = 32,
  FUSE_SETLKW = 33,
  FUSE_ACCESS = 34,
  FUSE_CREATE = 35,
  FUSE_INTERRUPT = 36,
  FUSE_BMAP = 37,
  FUSE_DESTROY = 38,
  FUSE_IOCTL = 39,
  FUSE_POLL = 40,
  FUSE_NOTIFY_REPLY = 41,
  FUSE_BATCH_FORGET = 42,
  FUSE_FALLOCATE = 43,
  FUSE_READDIRPLUS = 44,
  FUSE_RENAME2 = 45,
  FUSE_LSEEK = 46,
  FUSE_COPY_FILE_RANGE = 47,
  FUSE_SETUPMAPPING = 48,
  FUSE_REMOVEMAPPING = 49,
  CUSE_INIT = 4096,
  CUSE_INIT_BSWAP_RESERVED = 1048576,
  FUSE_INIT_BSWAP_RESERVED = 436207616,
};
struct fuse_in_header {
  uint32_t len;
  uint32_t opcode;
  uint64_t unique;
  uint64_t nodeid;
  uint32_t uid;
  uint32_t gid;
  uint32_t pid;
  uint32_t padding;
};
struct fuse_out_header {
  uint32_t len;
  uint32_t error;
  uint64_t unique;
};
struct syz_fuse_req_out {
  struct fuse_out_header* init;
  struct fuse_out_header* lseek;
  struct fuse_out_header* bmap;
  struct fuse_out_header* poll;
  struct fuse_out_header* getxattr;
  struct fuse_out_header* lk;
  struct fuse_out_header* statfs;
  struct fuse_out_header* write;
  struct fuse_out_header* read;
  struct fuse_out_header* open;
  struct fuse_out_header* attr;
  struct fuse_out_header* entry;
  struct fuse_out_header* dirent;
  struct fuse_out_header* direntplus;
  struct fuse_out_header* create_open;
  struct fuse_out_header* ioctl;
};
static int fuse_send_response(int fd, const struct fuse_in_header* in_hdr,
                              struct fuse_out_header* out_hdr)
{
  if (!out_hdr) {
    return -1;
  }
  out_hdr->unique = in_hdr->unique;
  if (write(fd, out_hdr, out_hdr->len) == -1) {
    return -1;
  }
  return 0;
}
static volatile long syz_fuse_handle_req(volatile long a0, volatile long a1,
                                         volatile long a2, volatile long a3)
{
  struct syz_fuse_req_out* req_out = (struct syz_fuse_req_out*)a3;
  struct fuse_out_header* out_hdr = NULL;
  char* buf = (char*)a1;
  int buf_len = (int)a2;
  int fd = (int)a0;
  if (!req_out) {
    return -1;
  }
  if (buf_len < FUSE_MIN_READ_BUFFER) {
    return -1;
  }
  int ret = read(fd, buf, buf_len);
  if (ret == -1) {
    return -1;
  }
  if ((size_t)ret < sizeof(struct fuse_in_header)) {
    return -1;
  }
  const struct fuse_in_header* in_hdr = (const struct fuse_in_header*)buf;
  if (in_hdr->len > (uint32_t)ret) {
    return -1;
  }
  switch (in_hdr->opcode) {
  case FUSE_GETATTR:
  case FUSE_SETATTR:
    out_hdr = req_out->attr;
    break;
  case FUSE_LOOKUP:
  case FUSE_SYMLINK:
  case FUSE_LINK:
  case FUSE_MKNOD:
  case FUSE_MKDIR:
    out_hdr = req_out->entry;
    break;
  case FUSE_OPEN:
  case FUSE_OPENDIR:
    out_hdr = req_out->open;
    break;
  case FUSE_STATFS:
    out_hdr = req_out->statfs;
    break;
  case FUSE_RMDIR:
  case FUSE_RENAME:
  case FUSE_RENAME2:
  case FUSE_FALLOCATE:
  case FUSE_SETXATTR:
  case FUSE_REMOVEXATTR:
  case FUSE_FSYNCDIR:
  case FUSE_FSYNC:
  case FUSE_SETLKW:
  case FUSE_SETLK:
  case FUSE_ACCESS:
  case FUSE_FLUSH:
  case FUSE_RELEASE:
  case FUSE_RELEASEDIR:
  case FUSE_UNLINK:
  case FUSE_DESTROY:
    out_hdr = req_out->init;
    if (!out_hdr) {
      return -1;
    }
    out_hdr->len = sizeof(struct fuse_out_header);
    break;
  case FUSE_READ:
    out_hdr = req_out->read;
    break;
  case FUSE_READDIR:
    out_hdr = req_out->dirent;
    break;
  case FUSE_READDIRPLUS:
    out_hdr = req_out->direntplus;
    break;
  case FUSE_INIT:
    out_hdr = req_out->init;
    break;
  case FUSE_LSEEK:
    out_hdr = req_out->lseek;
    break;
  case FUSE_GETLK:
    out_hdr = req_out->lk;
    break;
  case FUSE_BMAP:
    out_hdr = req_out->bmap;
    break;
  case FUSE_POLL:
    out_hdr = req_out->poll;
    break;
  case FUSE_GETXATTR:
  case FUSE_LISTXATTR:
    out_hdr = req_out->getxattr;
    break;
  case FUSE_WRITE:
  case FUSE_COPY_FILE_RANGE:
    out_hdr = req_out->write;
    break;
  case FUSE_FORGET:
  case FUSE_BATCH_FORGET:
    return 0;
  case FUSE_CREATE:
    out_hdr = req_out->create_open;
    break;
  case FUSE_IOCTL:
    out_hdr = req_out->ioctl;
    break;
  default:
    return -1;
  }
  return fuse_send_response(fd, in_hdr, out_hdr);
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void loop(void)
{
  int i, call, thread;
  for (call = 0; call < 9; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      event_timedwait(&th->done, 50);
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call)
{
  intptr_t res = 0;
  switch (call) {
  case 0:
    NONFAILING(memcpy((void*)0x20002080, "./file0\000", 8));
    NONFAILING(syz_mount_image(0, 0x20002080, 0, 0, 0, 0, 0));
    break;
  case 1:
    NONFAILING(memcpy((void*)0x20002080, "/dev/fuse\000", 10));
    res = syscall(__NR_openat, 0xffffffffffffff9cul, 0x20002080ul, 2ul, 0ul);
    if (res != -1)
      r[0] = res;
    break;
  case 2:
    NONFAILING(memcpy((void*)0x200020c0, "./file0\000", 8));
    NONFAILING(memcpy((void*)0x20002100, "fuse\000", 5));
    NONFAILING(memcpy((void*)0x20002140, "fd", 2));
    NONFAILING(*(uint8_t*)0x20002142 = 0x3d);
    NONFAILING(sprintf((char*)0x20002143, "0x%016llx", (long long)r[0]));
    NONFAILING(*(uint8_t*)0x20002155 = 0x2c);
    NONFAILING(memcpy((void*)0x20002156, "rootmode", 8));
    NONFAILING(*(uint8_t*)0x2000215e = 0x3d);
    NONFAILING(sprintf((char*)0x2000215f, "%023llo", (long long)0x4000));
    NONFAILING(*(uint8_t*)0x20002176 = 0x2c);
    NONFAILING(memcpy((void*)0x20002177, "user_id", 7));
    NONFAILING(*(uint8_t*)0x2000217e = 0x3d);
    NONFAILING(sprintf((char*)0x2000217f, "%020llu", (long long)0));
    NONFAILING(*(uint8_t*)0x20002193 = 0x2c);
    NONFAILING(memcpy((void*)0x20002194, "group_id", 8));
    NONFAILING(*(uint8_t*)0x2000219c = 0x3d);
    NONFAILING(sprintf((char*)0x2000219d, "%020llu", (long long)0));
    NONFAILING(*(uint8_t*)0x200021b1 = 0x2c);
    NONFAILING(*(uint8_t*)0x200021b2 = 0);
    syscall(__NR_mount, 0ul, 0x200020c0ul, 0x20002100ul, 0ul, 0x20002140ul);
    break;
  case 3:
    NONFAILING(memcpy((void*)0x20000000, "./file0/file0\000", 14));
    res = syscall(__NR_creat, 0x20000000ul, 0ul);
    if (res != -1)
      r[1] = res;
    break;
  case 4:
    NONFAILING(memcpy(
        (void*)0x2000d540,
        "\x70\x90\xdb\xe2\x4f\x89\xc6\xc7\x68\x50\xb8\x5b\x4b\xc0\xf5\xfb\x24"
        "\x94\x7e\x2d\x18\x3a\x31\xfd\xff\x74\x69\x2b\x40\x9d\xae\xf3\xfd\x08"
        "\x39\x2c\x2c\xef\x49\x5b\x4d\x07\x9b\x03\xee\x27\x3a\x60\x7e\x54\x1f"
        "\x59\x00\x00\x2b\x69\x58\xd7\x89\xed\x1e\x3d\x4c\x2f\xa0\x48\xd5\xfd"
        "\x1a\x91\x8f\x8e\x95\xaf\xe6\x4b\x89\x71\xc3\xb4\x2c\x3e\x8e\x72\x32"
        "\xa2\x46\xa5\x0d\x1e\x22\xe9\x3c\x2f\xd7\x53\x00\x54\x6a\x72\x3e\x0f"
        "\x56\x58\x12\x21\x85\x27\xda\xf4\xcc\x56\x09\xe8\x72\x3f\x30\xea\xf4"
        "\x60\xea\xfb\xbc\xd7\xff\xdc\xf0\xbb\xcf\xcb\x11\x0e\xec\x32\x40\x24"
        "\xed\x60\x23\x6d\x80\x60\x65\xa9\x90\xed\x09\x74\x5e\x08\x54\xca\x55"
        "\x26\x38\x66\xf2\xfb\xad\x9c\x25\xc9\xd9\xb6\xc5\x84\x47\x87\x27\xd5"
        "\x41\xfb\x5f\x37\xbb\xa6\x90\xed\xed\xe9\x98\x5f\x12\xa2\xa1\x0d\x15"
        "\xdf\x5e\x74\xc9\x1a\x3c\xcd\x2e\x8b\x30\x4e\x1e\xcf\x10\x23\xcd\xce"
        "\x93\x1a\x5d\x0b\xf1\x4a\x4b\xb3\x68\x33\x54\x5b\x1d\x30\xae\x1b\xa0"
        "\x19\xed\xee\x8e\x4f\xc9\x66\x6d\xfb\x1c\x1c\x14\xf0\x44\x62\x75\x0c"
        "\x39\xa8\xd7\xc1\x66\xf5\xed\x82\x76\x63\xe9\xde\x9f\xb9\x10\x88\xd6"
        "\xda\xb3\xd3\x2e\xe8\x5c\x28\xdf\x04\x9f\x2e\x9c\x97\x76\x8c\x05\x27"
        "\xb7\x5b\x7a\x10\x31\xc6\x03\x95\xc7\xb6\xa3\x2e\x88\xdc\xb6\xc7\x6f"
        "\x12\xd9\x1c\x6b\x46\x9c\x33\x76\xa8\x0e\x8c\x2a\xcf\x57\x3b\x3b\xed"
        "\x0e\x16\x76\xda\x78\xe6\x0a\x57\xc9\xa4\x40\xbb\x39\xa1\xe0\x5f\x71"
        "\x9e\x7d\xdd\xb8\x77\x71\x6b\xb0\xbc\x07\x2e\x22\x63\xe4\x1d\xdb\xd6"
        "\xce\x68\x80\x40\x2c\x46\x08\x80\x2d\x36\x9a\x13\xc0\xb1\x1b\x44\x97"
        "\xc2\xf3\xcf\x7d\xf1\x6b\xaf\xfc\x3f\x2c\xfd\x01\x0a\x4b\xa9\xe2\x6e"
        "\xed\xa9\x93\xef\x14\xa7\xdc\xef\xbd\xca\xf4\x27\xcd\x09\x25\x12\x11"
        "\x99\xaf\xb7\x7a\xb1\xc7\x6f\xd6\x10\x7f\x63\xfe\xd1\xef\x77\x3f\xd2"
        "\x99\x74\x62\x6a\x5a\x18\xfc\xab\x11\xb7\x17\xd7\xe8\xc0\x49\x9b\x56"
        "\xf2\x5c\xdf\x91\x9e\xbb\x55\xd9\xa1\x5e\x29\xaa\x8a\x70\xed\xd9\x77"
        "\xa1\xc4\x2a\x0a\xcb\xb2\xe1\xc9\x05\x32\xe4\x23\x5a\x69\x4a\xfc\xa0"
        "\x54\xcb\x3d\x26\x01\xc3\x69\x04\x97\x64\x30\x66\x3c\xbf\x06\xf3\x1c"
        "\xd3\x1c\xb3\x59\x75\xd1\x96\x67\x3f\xfc\x1d\x14\xd6\x46\x61\x10\x9f"
        "\x3c\xe8\x44\x42\xf0\x86\x0e\xe4\xe2\x4e\xf4\xc4\xc5\x6e\x05\x55\xcb"
        "\xbc\x75\xa5\x06\x12\xc1\x24\x5a\x1a\xab\xc8\x1f\x1b\xf5\xc1\x9d\xed"
        "\xf7\xbb\x3a\xb2\x21\xec\x3a\x2b\x83\x35\x10\xbd\x6e\x3a\x72\x96\xa3"
        "\xce\x42\x91\x96\x2c\x31\x1e\x8c\xc5\x4f\xa7\x05\x46\x1d\x62\xaa\x28"
        "\x98\x73\xfa\x33\x81\x87\x8e\x87\x92\xb6\x02\xb4\x6b\x23\xc3\xed\xc8"
        "\xdd\x21\x89\xd1\x87\xd8\x5a\x69\xd0\x59\xea\x47\xee\x02\x31\x3f\x97"
        "\xb9\xd0\x10\xf5\xd4\x84\xc1\xc0\x09\x84\x4a\xf4\x92\xf4\xbf\x00\x2b"
        "\x60\x95\x30\xe9\x91\xe5\xa2\x54\x40\x23\x32\xbf\xa7\x3e\xdf\x34\x7e"
        "\xc9\xc0\xf2\x43\xe7\x1c\xab\x4c\xaa\x32\x2a\x05\x3b\x36\x78\x98\x2c"
        "\xc9\x3b\xb0\x2f\xf3\x03\xcf\x16\x50\x3c\x1f\x14\x81\xce\x0a\x50\x7b"
        "\x69\x70\x38\xa5\x98\xef\x13\x9f\x76\x58\x54\x60\x18\x62\x7e\x05\xd5"
        "\x82\x7f\xc0\xec\xdc\x1d\xcc\x29\xe9\x9f\x29\x4a\x79\x2e\x66\x56\xb9"
        "\x79\xdb\x99\x0e\x69\xf2\xbb\xaa\x44\x13\x9d\x39\x01\xe2\x82\x0f\x5f"
        "\x9e\x7c\xb9\xf7\x61\xd4\x9b\x53\x08\x35\x1c\xd9\x84\x45\x65\x07\xd3"
        "\xa0\x31\xbb\xf8\xf5\xcc\xd4\x77\xf1\xc9\xa5\x54\x53\x9d\xe2\x73\x73"
        "\x7c\x39\xc6\x43\x46\x7e\x46\xf5\x70\x93\xc7\x72\x3b\x0f\xac\x53\x0c"
        "\x4c\xd8\x0d\x0d\x1b\xa7\x4b\x93\x2c\x69\x75\xc9\x05\xc1\xcd\x3d\x10"
        "\x71\x4c\x62\x92\xef\xab\x20\x36\xfc\xbc\xb9\xdd\xfe\x7a\x6a\x8b\xb8"
        "\x2a\xc4\xea\xc5\xe2\x6f\x0b\x09\x3c\xa6\x02\xde\x50\x88\x97\x7d\x88"
        "\xee\x19\xf5\xfa\xc9\x80\x8c\x3b\xbc\x74\x6b\x47\x1f\x33\x0b\xf1\xf9"
        "\xf2\xff\xe0\xf5\x50\x9e\x9c\x7f\xcc\xf4\x2c\x0f\xee\x13\xfa\x85\x53"
        "\xbe\xcb\xa4\x00\x34\x71\xb6\xf9\x22\xe1\xe2\xc1\x21\xa1\xd6\x60\x27"
        "\xf3\xe2\xaf\x15\x94\x02\x20\x58\x36\x95\x8a\x71\xab\xee\x6f\xd0\x32"
        "\xf2\x63\x2a\xf8\x9f\x34\x13\x2a\x30\xf7\xea\xa1\xd1\x80\x5b\x4b\x7b"
        "\x1a\xfd\x36\x9b\x51\x73\x47\x7a\xa4\xe6\x6e\x18\x14\x51\xad\x52\x11"
        "\x12\xd3\x93\x79\xd4\x33\xbe\x08\xb8\x31\x9b\x90\xb2\xfe\xab\xc3\xc8"
        "\xed\xd5\x20\xf5\xad\xc7\x11\x77\x84\x94\x34\x2a\x2e\x81\xe3\xbf\x31"
        "\x1c\x8a\xff\xee\x23\x76\x31\x8c\xda\x05\xe3\xc1\x0c\x6d\xfe\xe3\x47"
        "\x25\x29\xd7\xd9\x3b\x66\xf4\xc6\xf6\xed\xf6\x0b\x27\xaa\x76\x72\x23"
        "\x06\x7a\x6b\x76\xc2\x55\xfc\x68\x5d\x2e\x47\x2d\x72\x33\xfd\xdf\xb9"
        "\x9a\x10\x07\xcc\x77\x59\xcb\xa6\x67\x68\x09\x77\xee\xc8\x00\x4d\xce"
        "\x8b\x79\xe4\xd7\xfb\x5d\x56\x2e\xb5\xb9\x2f\x1e\x65\x97\xee\x3e\xf2"
        "\xc8\xa2\xb2\xae\x6c\x45\x52\xd6\x04\x19\x42\xed\x6b\xc9\xec\xd8\x08"
        "\xc3\x53\x16\x67\xc5\xd4\xcf\x7b\x9f\x47\xb8\x5a\x31\xc9\xb7\x91\x8c"
        "\x7b\x93\xc9\x82\x2a\x13\xd6\x47\xc8\x42\x99\x1f\xb2\x6d\x3b\xf0\xf2"
        "\x5a\x84\x81\x34\xf7\xe7\x94\x63\x82\x1e\x85\x0a\x84\x08\x78\x4d\xe2"
        "\x80\x01\xe4\xc2\x43\x44\x62\x61\xed\xd2\x4a\xf8\xcc\x63\xb8\x01\x97"
        "\x14\xe2\x25\xbf\xac\xfc\x90\xd2\xef\xe3\x7f\xcf\xb9\xdd\xdc\x88\x81"
        "\x14\x2d\x0e\x32\x4a\xa5\xbf\x8f\x92\xa9\x2c\x2d\x40\xed\x80\x05\xfc"
        "\x63\x10\xf0\xef\x48\x46\x3a\x59\x47\x92\xa1\x13\x3a\x44\x7a\x8e\xcc"
        "\x02\xa9\x84\xc8\x51\x54\x28\xb2\x9e\x68\xd3\x37\xf5\x36\xdb\x7f\xda"
        "\xe9\x6c\x3c\x63\xd2\xbf\x7a\xac\x0b\xe9\x70\x33\x49\x82\x0f\xa1\x97"
        "\x4c\xae\x95\x29\x79\xf7\xbb\xa4\x6b\x43\x94\x60\x8a\xc3\xb1\xcc\x50"
        "\x17\xbe\xde\x40\x11\x56\x35\xd8\xcb\xba\x3a\x62\x8b\xcd\x5f\x41\xca"
        "\x63\xd0\x75\x82\x0c\x66\x6c\x2f\xfd\x6e\x86\x22\xd5\x62\x5a\xa6\x65"
        "\x26\xd5\x91\xbb\xb3\xe1\x6a\x7d\x36\x67\x7e\xc3\x97\xe3\x6c\xa3\x77"
        "\xa8\xae\xb0\x7e\x24\xcb\xb9\xe3\x08\xe6\x6e\xde\xf9\x6e\x89\xed\x29"
        "\xec\x57\xa2\xce\x77\x24\xa8\xcf\x5d\x1b\x0f\xe9\x97\x41\x31\xfd\xa7"
        "\xe5\x84\x4d\xf6\xc1\x09\x7e\x53\xb9\x86\x28\xa1\x8c\xe7\x83\xe3\x39"
        "\xdc\x5e\xa6\x1e\x9c\xe1\xae\x53\xc0\x04\x4f\x8c\xfb\x62\x85\xb0\x87"
        "\x59\x50\x0b\xbb\x4b\xcf\x68\x29\xe5\xab\xb6\x0d\x9c\xeb\x33\x7f\x36"
        "\x71\xa0\x79\xf2\xc8\xbe\x5a\xd0\x73\x2f\x72\x91\x57\x5c\x15\x86\x68"
        "\x89\xcc\x95\x10\x2b\xb9\x0e\x67\x23\xbb\x0f\x5b\x6a\x18\xc6\x4b\xf1"
        "\x43\x35\x19\x22\x7b\x65\xda\x8f\x4c\x5a\x6e\x37\xf9\x7e\xc7\xa2\x6b"
        "\xf0\x1f\x37\x4a\xd9\x4d\x83\x0f\x18\x2a\x26\xb4\x1c\x5a\xe3\x7a\xcf"
        "\x7c\xef\x4c\xac\x64\xb3\x8e\x5a\x8d\x53\x84\x9b\x05\x39\x24\x6f\xdf"
        "\x6b\x9f\x28\x51\xbd\x7e\x64\x16\xc5\x98\xed\x26\xf5\xc0\xda\xdc\xb3"
        "\x4b\x9f\x66\x5e\x45\xb4\x80\x9c\x4e\xe1\x49\x98\x26\x2c\x32\x24\x35"
        "\x9a\x6d\x07\xcb\xbf\x04\x69\x66\x92\xda\x14\xc7\x52\xee\xee\xaa\x6c"
        "\x85\x2a\xe8\x0f\x37\xfb\xf7\x07\x58\x26\x05\xb5\x7c\x88\x04\xfa\x93"
        "\x3e\xaa\x4b\x1a\x68\x7a\x7e\x80\x81\xab\xc1\x97\x34\xa9\xf5\xd4\x7a"
        "\x98\xe4\xde\x4a\xed\x4f\x71\x1c\x7c\xe2\x2a\x47\xb0\x6c\x03\x61\x50"
        "\x3e\xb9\x26\x34\x13\x59\xf6\xe7\x65\xeb\xa5\xa0\xfa\x84\x6e\x77\x10"
        "\xa0\x1d\xe4\x7d\xd4\x5b\xe6\xb4\x3c\x5b\xfe\x56\x0e\xc0\x18\x0a\x38"
        "\x0e\xd9\x4a\x43\xe4\xb8\x15\xa6\xfe\x2f\xf8\x4c\xa8\x06\x53\xf9\xa5"
        "\x8f\xd9\xc7\x03\x4d\xe4\x0e\x21\x86\xbe\xe3\x08\x27\x0b\x6a\x51\x27"
        "\xe0\x24\xf6\x72\x23\x55\x47\x56\xf2\xe5\xf8\x84\x98\x15\xcf\x0a\x7a"
        "\x94\xc7\xce\x2f\xac\xf7\xdd\xbf\x68\x61\x6e\x64\x5a\xfa\x0f\xc3\xf2"
        "\xad\xdb\xa3\x99\x2a\x6e\xa6\x7a\x31\x0f\x94\x17\x1f\xbd\x2e\x2e\x10"
        "\xc5\x12\xb0\xb8\x69\x34\xbf\x0c\x59\x03\xec\xfb\xb3\x8d\x47\x49\xcc"
        "\x7e\xc6\x67\x00\x8c\x73\x6c\x36\x7d\x54\x1a\x19\x0e\xa1\xdc\x18\x71"
        "\xb6\x11\x53\xce\xcb\xe9\xbe\x12\x62\x05\xa0\x66\x1c\x07\x1e\xe7\xb3"
        "\x23\xcd\x01\x15\x23\x07\x76\x30\x7a\x7d\x9a\x85\x3b\xd8\xe6\x9a\x88"
        "\xb0\xdc\x71\x55\x42\xc5\x84\x39\x7a\x2b\x6a\xcb\xac\x54\x3a\x64\x6e"
        "\xdb\x5a\xfc\x9a\x74\xeb\x32\xa9\x54\x12\xe0\x10\x2a\x62\xde\xdd\xf2"
        "\xb3\xc0\x83\x30\xa1\xd9\x0f\x31\x4b\xd3\xb5\xd2\xb8\x26\x0d\xcc\x4c"
        "\xe8\x66\x5c\xe9\x82\x3c\xb1\x73\xb6\x5c\x2a\x9b\x80\xa1\xe6\x59\xa6"
        "\x39\x13\x91\xe9\x33\x5d\x82\xbb\x9f\x8b\x83\xc2\x93\x5f\x01\x2d\xdb"
        "\x48\xfa\x5d\x91\x78\xa7\xb9\x81\xab\x17\xb8\xf6\xb7\xb8\x63\xae\x89"
        "\x67\xd6\xf5\xb0\x37\x0e\xbd\x72\x82\x9c\x9d\xc9\xba\xdf\x36\x9b\x16"
        "\x9e\x7a\x09\x48\xb2\x6b\xda\xeb\x08\x59\xd6\x5d\x72\x7d\x98\x0f\xad"
        "\x86\xf9\x57\xfe\x6b\xcb\xa7\xa5\x04\xf2\x61\x5b\xb0\xd5\xbc\xe9\x75"
        "\xf3\x99\x08\xff\x59\x92\x33\x40\xc4\x7b\xd2\x22\x70\xf0\xb8\x9e\x82"
        "\x9f\x3c\x97\x2b\x4a\xbb\xe1\x75\x00\x99\x5f\x15\x49\xde\x48\x05\x85"
        "\xfc\x2c\x2f\x5c\x1f\x53\x10\x33\x62\xb4\xf2\xcd\xf4\x7e\x64\x4d\xcb"
        "\xf1\x74\x65\x71\xbd\xb8\xc0\xba\x6f\xde\xb3\x73\x54\x04\x98\x02\x95"
        "\x9c\xe7\xf0\x4c\xab\x42\x80\x09\x21\xb0\xd3\x51\x8a\xaf\x1b\xce\xe0"
        "\x30\x11\xe1\xc6\xfe\x3d\x7a\x16\x6f\x78\x8c\x09\xef\xe9\x9c\x2e\x13"
        "\x6d\x32\x34\x24\xd1\x33\x62\xe0\x49\x40\xc8\x8b\xc8\x70\xf1\x08\x15"
        "\xed\x8b\x6b\xbd\xb0\xb1\xfd\x7e\xb8\x41\xce\xd6\xbc\xcb\x8b\x84\x3e"
        "\xbb\x5f\x6a\x14\xc4\x9b\x9f\x4e\x04\x37\x8d\xaf\x8d\x1a\xaf\x8b\x41"
        "\xa5\x41\x1a\x11\x83\x26\x75\x14\x6b\x70\x42\x94\x3d\x57\x4e\x5e\x8a"
        "\xca\x4d\x7d\x22\x82\x6f\x62\xa7\x34\x91\x39\xde\xe7\x20\x07\x45\x9f"
        "\x5b\xba\xaf\xdf\xcb\x7d\xf5\xa8\xe7\xd1\xaf\xb9\x5d\x00\x67\xcd\xec"
        "\xdf\xb1\x60\xf0\x6c\x8c\x6e\x0b\x6f\x99\xc1\x24\x7b\xe1\xa1\x72\xe5"
        "\x85\x5e\xde\x4e\xd7\x3d\xc4\x3a\xfa\x86\x97\x30\x08\x65\x2b\x50\x04"
        "\x91\x1d\xfb\x8a\xf3\x73\x02\x0f\x94\xfe\x2d\x50\xf6\x57\x5c\xe2\xfc"
        "\xfc\xf7\x16\xd3\xe1\x96\x13\x58\x12\x08\x53\xb2\x9a\x6a\xfb\xf0\xfc"
        "\xcf\xea\x81\x6d\xeb\xff\x32\x2d\xc5\x32\xf3\xe3\xc3\x8e\xd5\x36\x72"
        "\xdd\x85\xf1\xd4\x87\x49\x12\xef\x36\x19\xa3\x98\x23\x23\x29\x8c\xea"
        "\x3d\x12\xd2\x2d\x8c\x18\x9f\xb8\x3a\xb5\xae\x98\x5d\xcd\x45\x68\x9a"
        "\xaf\x00\x95\xeb\x2f\xa1\xc1\xe7\xc6\xda\x2f\xdb\x53\x78\xfb\x0b\x26"
        "\xeb\xe3\x3d\xe2\x32\xa4\xc7\x19\x1f\xf1\xbb\x4d\xe5\x52\x7d\x4a\x7a"
        "\xd8\x0d\xd1\x49\x28\x6c\xa2\xd5\x11\x7e\x3b\x7f\xb7\xcb\x8c\x35\x59"
        "\x81\x14\xac\x66\x33\x66\x4a\x82\x9d\x78\x6f\xd8\x50\xdb\x21\xaa\x72"
        "\x4a\xac\x98\xc4\xc1\x9c\xac\xb1\x0b\xff\x8b\x9a\x55\x82\x33\x8b\x11"
        "\xb1\x28\x95\xe7\x68\xdf\xb4\xae\xef\xe0\x50\xff\x66\x9e\x6d\x7d\x56"
        "\x2a\x64\x54\x7d\x17\x24\x8c\x91\x1c\x89\x57\xf6\xb8\x0a\x58\x64\x82"
        "\x91\x40\x7e\xf7\x9f\x1c\xf4\x9e\x80\x1a\x2b\xc1\x8e\xc3\x92\x5d\x87"
        "\x65\xdf\xf4\x29\x0b\x36\x49\xa2\xfc\x22\x36\x1e\x94\xb8\xfd\x01\x42"
        "\xd7\x11\x5b\xb5\x03\x4c\x9c\x99\x6e\x4d\x77\xb3\xd7\x3b\x65\xd1\x14"
        "\xbf\x94\x90\x29\x21\x8d\x0f\x7d\x60\x07\x53\xe3\x19\x6e\xc2\x15\xd2"
        "\x40\x42\x90\xb2\xe7\x1d\x0f\x83\xb0\x7a\x58\xd4\x8a\x09\xe8\x45\x16"
        "\x5a\x7e\xb3\xb6\x5f\x64\x59\xa6\xb7\x13\x35\x2e\xfa\x94\xc8\x8d\x68"
        "\xa4\x88\x6b\x2c\x85\xa3\xf5\xea\xe6\x28\xe1\x7c\x4a\x9a\x83\x86\x6d"
        "\x81\x9a\xf8\x73\x71\x24\x13\xcd\xcf\x6c\xb5\xb9\x37\x9e\x2c\x72\x3e"
        "\x55\x18\xfe\xdb\x87\x62\x76\x12\x36\xd2\xc5\x5b\x1e\x57\x24\x44\xd4"
        "\x66\x57\xa6\x99\xde\x90\xfc\x71\xbd\x82\xc3\xa5\xcf\xed\x81\xfa\x65"
        "\xb8\x1e\x24\x02\x5e\x04\xc7\x37\x0a\xd7\x8f\x3d\xec\x22\xe9\xa9\x94"
        "\x36\xba\x83\xd2\xe3\x87\x82\xeb\xb3\x59\x84\xc1\x7b\xe3\xfa\xe8\x55"
        "\xad\x91\x47\x0e\x1b\x26\x33\x3e\x00\x01\xc6\x3a\xca\xc5\x40\x92\x67"
        "\x2b\x0a\x67\x07\xa3\x75\x0f\x00\xb5\xa4\x02\x21\x37\x3c\x73\x7f\x37"
        "\x53\x31\x32\xb6\x98\x3b\x30\x3f\x5d\x0a\xaf\x31\x2f\x77\x80\x34\x7c"
        "\x94\xa5\x7a\xc3\xf5\xa3\x2d\x7c\x7a\xb8\xb8\x6a\x64\xea\x3f\x7d\x35"
        "\xb5\xf4\x20\xc7\x38\x68\xa7\xbd\x0e\x71\x23\x41\xae\x1a\x2e\x50\x0e"
        "\x38\x62\x5d\xac\x6b\xd9\x0c\x05\x6e\x88\xa6\x74\xda\xf4\x22\x11\xc6"
        "\xdd\x77\x5f\x5f\xec\x91\xfc\x29\xb3\x1d\xd8\xb9\x59\x19\x56\x76\x55"
        "\x3a\x34\xa9\xfc\x9a\x64\x22\x4d\xd4\xae\x66\xdd\xae\x66\xec\xe4\x97"
        "\x42\xa3\xea\xc5\x43\x20\xfc\xf6\xa4\xb8\xbf\xf7\x2f\x44\xb8\xc8\x11"
        "\x94\x50\x26\x9a\x87\x0f\x1e\xb7\xa7\x1e\xe0\x21\x0e\xab\xf5\xb8\xf9"
        "\xf5\x13\x94\xda\xc6\x46\xc7\x71\xcc\x88\x9a\xc7\x01\xa9\x78\xd2\x5e"
        "\xab\x46\xd4\xf2\xfa\x08\x55\x1b\x33\xfa\xbd\xb9\x4a\x54\x99\xb7\x65"
        "\xb1\x58\x27\x93\xd9\xb5\xb3\x6d\x6a\x92\xb5\xc1\x57\x16\x6e\xf8\x25"
        "\x6a\x79\xaf\xb8\xa2\x32\x43\x97\xdb\xb9\x72\xbf\x75\xb9\x6f\xef\xe5"
        "\x64\xeb\x4c\xe9\x35\x51\xe8\x8a\xc6\xe0\x0d\x02\x1a\x72\x13\xbe\x30"
        "\xdd\x49\xaa\xb9\xeb\x86\x1f\xa6\x0f\xdd\xe6\x6e\xff\x8e\xb6\x28\x75"
        "\x6e\x4d\x4a\x81\xc4\xc9\xbe\x91\x0c\x46\x69\x61\xea\xca\x5a\x2c\xc1"
        "\x08\xec\xf2\x2d\xe2\xd3\x51\x63\x79\xb0\xb0\x28\x0c\x1a\x7a\x56\xb2"
        "\xdc\x1a\x4a\x51\xa8\x53\x89\x16\x91\xdb\x54\x2a\x09\x3d\x48\xc9\x5c"
        "\xe9\x36\x7a\x8c\x42\x31\x22\xe4\x47\x06\xee\x12\xec\x78\x97\xa6\xb1"
        "\x9b\xff\x76\xbe\x40\xa7\x40\xf8\x98\x2f\x1c\x95\x8c\x5b\xb2\xf3\x11"
        "\xaa\xe4\x13\x69\xab\xf7\x74\x61\x88\xa1\x14\xb7\x26\x03\x89\x0a\x7a"
        "\xa5\x92\x25\x4f\x40\x3c\x90\x62\xc8\x21\x9b\x2f\xe4\xbd\x6d\xd4\x8e"
        "\x79\xc6\xc5\xc5\x85\xf2\x5b\xda\x58\x2d\x12\xe9\x6f\xee\xe4\xe3\x84"
        "\xb4\x37\x41\x6a\xdf\x6f\xe1\x8b\xb9\x36\x16\x47\x5c\x0f\x38\xe2\xd4"
        "\x47\xdd\xf2\x23\xbd\xbe\x2d\xb3\x6f\xa4\x20\x23\xf9\x1f\x07\xaa\xbc"
        "\x46\x92\xac\x02\x28\x3d\xfa\x9f\xad\x31\x59\xae\x86\x95\x3a\xa2\xf3"
        "\xeb\xbb\xc3\x34\xfa\x4d\xeb\x6e\x8a\xf5\x0f\x90\xfa\x8d\xe5\x4b\x9f"
        "\x83\xc0\xdb\xd8\x0e\x31\x89\x3d\x76\x53\xd8\xcb\x1b\xd5\xc9\x24\x57"
        "\x8a\xc4\x20\x67\xcb\xd7\x60\x3d\x2b\xa3\x47\xdb\x63\xfd\x25\x9c\x74"
        "\x88\x5a\xd5\x33\x11\x17\xcd\x33\x25\x4a\x66\x7b\x84\xb4\x6a\x87\x2f"
        "\x55\xf1\x16\x79\x25\xa1\x40\x57\x44\x3c\x4f\x24\xc3\x17\x8d\x92\xb0"
        "\xd7\xe5\x5f\x80\x54\x89\x25\xdd\xe8\x31\x8a\x3d\xc7\x41\x70\xf4\x0b"
        "\x52\x05\x5d\xb0\xb0\xa5\x78\x20\x51\xfa\xab\x15\xe1\x2b\x3e\x7d\xb5"
        "\xb6\xa3\x52\x55\x29\x38\x90\x76\x38\x7b\x85\xe9\x60\xc4\xc0\x1b\xac"
        "\xe4\x6b\x21\x2e\xe6\xc7\xf2\x9e\xc8\x42\xef\x44\xbf\x7e\xc0\xa5\xc1"
        "\xd7\xcf\x3e\x77\xc0\x06\xe1\x0b\xbd\xd9\xc2\x84\xc0\x96\xc3\xba\x97"
        "\x87\xba\xe5\xc9\x0d\xae\x19\xab\x9e\xfb\x21\x4b\x0b\x57\x35\x40\xa2"
        "\xb6\xd5\xd1\x83\x5a\xf0\x6d\xbf\xda\x48\x55\x17\xc3\x89\x38\x31\xc9"
        "\x31\xa7\x42\x40\x7e\x3e\x5c\xbf\xc5\x97\xaa\x48\x9e\x63\x0f\xac\x1b"
        "\xec\x5c\xf4\x50\xdc\x02\xb1\x90\xa5\xe8\x86\x25\x7f\xbf\x6d\xe5\x4d"
        "\xad\x54\xe3\x60\xab\x63\x33\x07\xa7\x92\xb6\xe6\x00\x71\x7f\x67\x97"
        "\x4d\x42\xbb\x5f\x20\x01\xf6\x53\xb8\x04\xa8\xaf\xe8\xba\x3e\x36\x3c"
        "\x57\x0d\x08\x98\xe2\x61\x2b\x9a\xd4\x76\xda\xa7\xd2\x9e\x78\xaa\x8f"
        "\xbf\x7f\xb7\x80\x90\xce\x29\xb9\x82\x2f\x1b\xe9\x60\x6b\xfc\x64\xac"
        "\x66\xa8\x7b\xc7\x85\xac\xf9\x6f\xe9\x20\x5c\x41\xd0\x76\x92\x00\x62"
        "\xba\x50\xcb\xa2\xbb\xac\xde\xcf\xdc\x9d\x1c\xc4\x27\xca\x89\x5d\x81"
        "\x37\xaa\x0c\x49\x74\xe3\x5b\x8b\xab\xdd\xf3\xb4\xd6\x1c\x3e\x20\x6b"
        "\x65\x8b\x52\xca\x12\x09\x4a\x7c\xf3\x56\x29\xb0\xa8\x41\xf1\x28\x96"
        "\x3d\x95\x9c\x39\x69\x22\x65\xed\xda\xc0\xea\x91\x79\xcd\x77\x28\xb2"
        "\x06\x9f\x2e\x19\x35\x37\x3a\xab\xe8\x4b\x3a\xb6\xc7\xaa\x6e\x79\x06"
        "\x33\x04\x11\x31\x0b\xcc\x36\xf1\x2c\x7f\x6a\x64\xb2\x0c\xc8\x42\x69"
        "\x8a\x96\x61\x4a\xbd\x2a\x67\xcc\xd5\x18\x06\x83\x8d\xad\x89\xf0\x9c"
        "\x6a\xd8\x1e\x5e\x7a\xbd\xd6\x26\xc6\x18\x52\xd3\x28\x26\xa2\x86\xe8"
        "\xf5\x3f\xeb\x63\x5e\xae\x1a\x77\xfd\x23\x12\xb2\x00\xf9\x04\xc4\x73"
        "\xfa\x53\x8c\x89\x47\x6c\x50\x49\x38\x5c\x3e\x5c\xe4\x9e\xda\xce\xec"
        "\xc3\x2d\x55\x8d\x7f\xf8\x98\x3d\xec\x58\xdc\x98\xd0\x64\xd2\xd6\x91"
        "\x45\x21\xb5\x6b\x02\xbf\x1b\x59\x0a\x30\x9c\x30\x8c\x93\x96\xce\xa8"
        "\xd4\xdd\xa5\x84\x81\xbb\x30\xda\x11\x25\xd8\x36\x28\xaf\x80\x04\xbc"
        "\x2e\xb2\xe8\x60\xc5\xf5\x4a\x9a\x89\xb8\x5a\x5e\x5c\x09\xdf\xe2\x8a"
        "\xff\xa1\x0a\x70\xb7\xa7\x15\x86\xc8\xba\x11\xef\x31\x3e\x5e\x1f\x21"
        "\x6a\x94\x5b\xea\x6c\xa6\xcf\xf3\x8e\xf0\xcb\x18\x87\x62\x23\x94\x28"
        "\x9f\xb4\xef\x78\xd3\x15\x5a\x64\x65\x17\x40\x0f\xb0\xe2\x8d\xbe\x57"
        "\xcf\x23\x18\x96\x3f\x84\x73\x55\x19\x90\x29\x93\x38\x97\xf7\x16\x2e"
        "\x9d\xee\xc8\xc8\x1d\xea\xd5\x66\x52\xbd\x7b\x81\x3b\x6d\x61\x58\xf4"
        "\x6e\x9e\xd3\xc8\xdd\xb0\xfe\xc9\xeb\xff\x5c\x5e\x19\xd3\xa3\xab\x39"
        "\xc9\xd4\xd2\x53\x63\x9b\xb3\xbf\x60\x53\xd3\x69\x0b\xb8\xc0\xe7\x9f"
        "\xa8\x74\x5b\x56\x6d\x5a\xf0\xf9\x08\xba\x11\x1b\x3c\x97\x6c\x48\x96"
        "\xf3\xb0\x74\x49\x7c\x48\x67\x2f\x0d\x46\x0d\x11\xd6\x92\x0a\x39\xa1"
        "\x42\xe3\xf9\x70\x59\x25\xd2\xb8\x51\x04\x95\x07\x8a\xcb\x79\xf7\xb0"
        "\x20\x86\xb5\x23\xdf\xe3\x98\x7b\x3b\xbd\x3e\xbf\x96\x6c\x1b\x32\xaa"
        "\x3b\xed\xf1\x54\xcc\x37\xb1\x10\xc7\xf9\x02\xff\x33\xb3\xdc\x51\x8e"
        "\xf2\xa5\x38\x13\x67\x41\x7d\x59\xd4\xaf\x12\x73\x1f\x8a\x49\x9b\xe3"
        "\x3f\x5e\xcd\x54\x67\x24\x0b\x27\xb1\x3f\x70\x3f\xe6\x62\x64\x1a\x28"
        "\x98\x41\x9d\x80\xcc\xd7\xd3\xf3\x64\x49\x56\xa1\x67\xcf\xf2\xc0\x82"
        "\xfb\x8b\x72\xad\xf8\x70\x3d\xe8\xfd\x98\x64\x75\x4b\xb8\xfe\x2f\xbf"
        "\x8d\xb1\x32\xb0\x59\x3e\xcc\x95\x45\x35\xa0\x5f\x9d\x85\x21\xbe\xcb"
        "\x85\x9e\x9b\x02\x7d\x22\x8d\xd0\x64\x0d\x57\x62\x65\xca\x1e\x83\xb5"
        "\x29\x96\x08\xa7\x7d\x7c\xc4\x43\x1e\xa4\x4d\x7c\x67\xbe\xea\x26\xa1"
        "\xb8\xfa\xbd\xec\x0d\x19\x2b\x46\xf3\x91\x3b\xb9\x52\xb8\x4e\x78\xa7"
        "\xfc\xc7\xa7\x4a\xf7\x38\xd4\x35\xd2\x4f\x22\x27\xe8\xe3\xe8\x29\xde"
        "\xa0\x67\x0d\xbc\xe9\x39\xf1\xcf\x3f\x7d\xff\xbe\x18\x6a\x9f\x45\x66"
        "\xe5\xa8\xa3\xaf\xf1\x7f\x60\xda\x89\xe9\xb1\x55\xa1\xb5\xc4\x0a\x5c"
        "\x82\x03\xff\x07\x33\x61\x0f\xc6\x16\x47\xda\x7d\x80\xc7\xea\x36\x5a"
        "\xa0\x3e\x2d\x67\xa0\xa5\xf9\x10\x70\xfe\x6e\xa3\x4f\x6c\x2f\x44\xa2"
        "\xc4\xa7\xd1\xd3\x30\x43\xb6\x4c\x85\xc9\x2c\x48\x0e\x2a\xfa\x92\x2c"
        "\xe7\x5b\x31\x9e\x6f\x19\x99\x5f\x25\xaa\x37\x45\xf2\x9b\x7e\x4c\x3e"
        "\x76\x71\xdf\x1e\xd4\x37\x9c\x64\x1d\x8f\x3b\x6c\x8a\xca\x14\x27\x0f"
        "\xb8\x5a\x71\x0e\x2b\x6e\xc5\x0a\x06\x5d\xa0\xae\xde\xf8\xa9\xa8\x16"
        "\xa1\x16\x84\x93\x6c\xba\xf8\x33\x4d\x53\xc6\x58\x35\x26\x4d\xc8\x79"
        "\xd7\xb3\xb9\x9a\xa3\xde\x89\xd4\xed\x69\x0e\xca\x9c\xbb\x5b\x7c\x08"
        "\xee\x4c\xd5\xab\x0a\x36\xcd\x21\x86\xd8\x67\x51\x39\x78\x0d\x8c\xaf"
        "\xb8\x25\xee\x1e\x08\x36\xd6\x9c\xf9\x18\x0b\x31\xa4\xbe\x3b\x8c\xc1"
        "\x8a\xa1\xf7\xa5\x32\x19\x53\x19\x63\xfa\xdb\xff\x36\x43\x70\xa2\x04"
        "\x70\x59\x71\x19\xcd\x55\xb3\xed\xf3\x9f\xa8\x0a\xab\x1a\xa6\x4b\xeb"
        "\x96\x03\x94\x47\xa5\x67\x78\x88\x50\xd3\x74\xc5\xb8\xf4\xc3\xbf\x2f"
        "\x4e\x12\x4d\x70\x05\x09\x28\x05\x74\x30\x6f\x44\x92\x7c\x3f\xd3\x95"
        "\x84\x70\x5a\x9b\xac\xb4\x52\x79\x31\x63\x12\x28\x5e\xcd\x59\x18\x19"
        "\x7b\x40\x0c\x08\xc6\x31\x8f\x11\xbc\x17\xa7\x09\x24\xc5\xcd\x5b\x49"
        "\xe0\xf6\x59\x19\x97\x5d\xf4\x48\x5d\x0d\x5d\x09\x1b\x6f\x90\xb2\x53"
        "\x45\x75\xa4\x7f\x25\x1b\x27\x34\x7d\xd2\x56\x63\x11\xed\x3f\xf7\x21"
        "\x53\xc2\x70\xbc\xd3\x8d\xa2\xd0\x20\x28\x74\x66\x12\xe2\xfc\x4d\xf5"
        "\xc8\x9a\x1a\x91\xf2\x43\x83\xa5\x17\xe6\x91\xd6\xed\x66\xf6\xd4\xba"
        "\x99\x67\x6b\xe8\xd8\xe5\x52\xd9\xfc\x89\xd8\xd2\x5f\x3a\x3e\x5e\xa3"
        "\x57\x20\x89\x7f\x54\x38\x80\x9c\x9d\x10\x96\x41\xf1\xc1\xf1\x19\x02"
        "\x3b\x74\xce\xd6\x98\x02\xc1\x82\xff\xc6\x4b\x76\x79\xbb\xdc\x71\xa7"
        "\x5d\x6f\x2f\xf5\x58\xe2\x9d\x20\x40\x09\x9c\xb9\x05\x89\xac\xb0\x48"
        "\x3f\x9f\x5c\x9c\xa4\x0c\x36\x00\xd5\x63\x29\xf5\x43\xde\xb1\x20\xf3"
        "\xf1\x35\x7e\xc3\xce\x1a\xaa\xf6\x27\x43\xb3\xef\x71\x03\x8c\x8f\xf4"
        "\xe5\x96\xc8\xa9\xe5\xa3\x59\x3a\x7b\xc8\x15\x04\x97\x78\xe0\xf0\x6f"
        "\xdb\x43\x4d\xd5\x63\x24\xf6\x1b\xbd\xe5\x60\x2a\x05\x37\x8d\x53\x44"
        "\x5c\xd3\xeb\x92\xe0\x0a\xdd\xc3\x40\x4f\x03\x34\x52\x69\x27\x73\x19"
        "\x6d\x1b\xa7\x93\xa5\xa5\x69\xc6\x8a\x95\xef\x3a\xc9\x30\x17\x41\x50"
        "\xb8\x12\x40\xbe\xa9\x03\x16\xb8\x43\x50\xe6\xc7\x51\xf5\xd5\x01\x95"
        "\x95\x40\x84\x2b\xac\x14\xae\xf7\xcf\xa7\x3d\x48\xc2\x1f\x83\xba\x69"
        "\x63\x0c\x3c\x4d\xaa\xd3\x16\x47\x00\xac\x86\x04\x06\xe2\x16\xda\xaa"
        "\x8c\x19\xab\x76\xcf\x47\x43\x0f\x17\x66\xfb\x35\x04\x79\xfa\xfc\xe0"
        "\x5b\x45\x91\xb0\x3a\xd3\x4c\xbb\x3b\xc0\x6d\xdb\x4c\xba\x86\xac\x3e"
        "\x75\x29\x74\xa3\x7b\xa3\x98\x25\x5a\xdc\xf0\xee\x59\xf1\x66\xfe\x08"
        "\x1b\xa8\x2e\x81\x2f\xb3\x62\xd2\xa0\xe6\xc0\x32\x72\x9d\x67\xa6\xff"
        "\x49\x51\x31\xfa\x7d\xc3\xdc\xcf\x09\xcc\x55\x39\x05\x98\x92\xc5\x4a"
        "\x46\xf2\xc1\x54\xa0\xc5\x4a\xcf\xac\xf9\x58\x78\x5e\xd4\xed\x7b\xe1"
        "\xc1\xf7\xcf\x54\x9f\x8f\x27\x90\xbb\xbe\x56\xda\x30\x77\x69\xcb\x84"
        "\x7f\xdb\x04\x79\x2c\xe0\x78\xc0\xcb\xea\x8b\x39\xae\x9e\x50\xbf\x4c"
        "\x61\xb6\x40\x84\x21\x6f\xc9\x88\xee\xd1\xec\xca\x90\x87\x88\x1f\xfc"
        "\xae\xdd\xca\x16\xfc\xac\xfc\x8e\x60\xc9\x91\x8e\xdb\x4b\x32\x7b\x93"
        "\x4e\x65\x17\x3b\x3f\x72\xee\x93\xd6\x18\x61\x68\x19\x51\x0c\x38\x5d"
        "\x7a\x29\xf5\x72\x6a\x47\x5b\x16\x3b\x4e\xdb\xb2\xec\x78\x58\x46\x7c"
        "\x4f\x44\xb8\xa0\xab\xb1\xd7\x0e\x84\xc6\x22\xb1\xc5\x6b\x28\xbd\x74"
        "\x6a\x0b\x2b\xa4\xb9\x85\x03\x4d\xfb\xb3\xf3\xea\x38\xab\x66\xef\xce"
        "\xea\x49\x2d\x77\xca\x55\x1e\x59\x12\x75\xf3\x29\xde\xc5\xb4\xca\x60"
        "\xd0\xdb\x94\x8c\x20\x1f\x98\xcf\x3c\xc3\x6b\xb5\x53\x18\x30\x87\xe0"
        "\xb4\xb5\x1f\x1f\xa7\x3e\x8b\xd5\x8c\x57\x3a\x91\xb9\x74\xd4\x96\xa8"
        "\x94\xad\xbe\xc3\x13\x4d\xfc\xab\x88\x94\xd8\x87\x56\x8c\xc7\x8f\x73"
        "\x70\x05\x3a\x31\xba\x22\xac\xbd\xea\x27\x38\x3a\xce\x4f\x4a\x7f\x95"
        "\x65\x10\xf0\x8b\x8f\x8c\xbc\x7e\x41\x31\x98\x14\x78\xe8\x42\xe7\xcb"
        "\x1b\x70\x85\xae\xcc\xd4\x26\xee\xbc\x49\xc3\x76\x8d\xc8\x09\x4f\x99"
        "\xd8\xe8\xc3\xe1\x7d\x14\x2b\x5c\xb2\xa9\x47\x4e\x40\xf8\xee\x7f\x6e"
        "\x25\x44\x9c\xe6\x3b\x31\x66\x15\xf7\xb2\x92\x10\x73\x97\xe2\x51\xa3"
        "\x6a\xd1\xb4\x00\x03\x04\xb2\xd8\xfb\x0a\x49\x2f\x91\xce\x27\xcf\x13"
        "\x85\xe1\x53\xdd\x95\xb8\xb1\xbb\x4a\xdf\xea\xee\x05\x05\x56\x5e\xb8"
        "\xfe\x70\x60\xc9\xdc\x48\x23\x75\x4a\x3d\x3b\x39\xeb\x4b\x7a\x27\xd3"
        "\x75\xeb\x85\x58\x44\xdb\x2c\xf4\x1d\x83\xc9\xa9\xa8\xb9\xae\xa9\xdd"
        "\x6a\xb1\x2a\xca\xd6\x94\x3d\x9f\xf5\xec\x6f\xcf\xa3\x22\xf7\x1c\x14"
        "\x96\xf9\x3a\xdf\xe4\x5f\xa0\x48\x11\x11\x55\x17\x96\x5b\x33\xd1\xa3"
        "\x18\xc3\x45\xa7\x6c\xce\x89\x9b\xc5\xdc\xa4\x62\xc6\x7b\xf9\x3c\x53"
        "\xf2\xe1\x64\xea\x5d\x2b\x7f\x24\x91\x9f\xc9\x37\x85\xb2\xb1\x46\xaa"
        "\x6a\xad\x9e\xd5\xdb\x24\x53\xeb\x39\x63\x37\x84\x23\x6e\xbf\xc3\x2d"
        "\x86\x1d\x7b\xaa\xb5\x96\x78\x55\x06\xa4\x98\x8b\x49\xcc\xb5\x93\x40"
        "\xac\xab\x65\x02\x14\xfa\x14\x4e\xa0\x5e\x96\x6e\x1c\x97\x11\xf2\x3c"
        "\x87\x1e\xfc\x0a\xd9\xf7\x6b\x6f\xdd\x6d\xe2\xa1\x9d\xda\x8b\x98\x2a"
        "\x69\x7c\x57\xf1\x38\x15\x91\xc2\x60\x58\x0c\x43\xa1\x92\x94\xb9\xb6"
        "\x13\x5e\x80\x9d\x15\xc8\x09\x2a\x68\xb7\x45\xa3\xd1\xd2\x5a\xb9\x8a"
        "\x6d\x24\xa3\xfe\xa1\xea\xef\x78\x17\x38\x56\x86\xc3\x6a\x6d\x92\xfa"
        "\x12\xbd\x6a\xf6\xc3\x2b\x1f\xbf\x06\x5d\xb0\x9a\x2c\x1c\xc6\x63\x80"
        "\x57\xcd\xa4\x55\xe6\xc4\x37\x25\x75\x63\xb0\x48\x79\xe2\xff\x21\x4d"
        "\xd6\x62\xb1\x5c\xa9\xea\xf1\xb7\x53\xdc\xa5\x35\x35\xf8\xc6\xaa\xfe"
        "\x7d\x48\x3f\x0d\xc2\x35\xc0\x81\x49\x37\xb8\x1d\xfa\xe2\x1a\xcf\xc7"
        "\x63\x9d\x7c\x41\x17\x9b\xb5\x5c\x6c\x86\x4e\x4e\x28\x84\xbd\x27\xd5"
        "\xbd\xe2\x72\xf6\xb5\x62\xce\xeb\x3e\x45\xac\xbc\x30\x5a\x62\x7b\x3d"
        "\x84\x60\x82\x29\xb0\xd0\x29\x31\xd0\x9a\x30\x52\xc5\x74\x25\x49\xce"
        "\x4f\x14\x51\xa6\x71\xfe\x5d\x65\xe6\xf7\x57\x38\xb0\x2b\x93\x35\x7b"
        "\xc5\xe1\x75\x3b\x03\xbe\x93\x99\x75\x9e\xd8\x27\xb2\xaf\xa8\x23\xb1"
        "\xf1\xc6\xc4\xda\x23\xb7\xd6\x40\x64\x92\xa9\xb3\xd4\x67\x27\x60\x6e"
        "\xde\x5d\x2c\x00\x70\xd8\x47\x3e\xc0\x2e\x61\x0d\xf6\x55\xf8\x59\x4c"
        "\xc5\xb0\xf8\x61\xb6\x07\xe5\x4c\xf9\x07\x4e\x64\x58\x65\xc5\x89\xbd"
        "\x91\xa6\x78\x0f\x80\xcc\x21\x4a\x34\x91\x38\x42\x71\x78\x6f\x18\xb9"
        "\x49\x01\x4b\x94\xb4\xa3\xcb\xe4\xda\x91\xdf\xec\xf7\x57\xb1\xb4\x60"
        "\xf4\x9f\x34\x0c\xf4\x4f\x5a\xc3\x9e\x3c\x4e\xee\x38\x7f\x90\x1e\xcd"
        "\xd7\x69\xd0\x2c\x93\x7a\x72\x46\x05\xde\xc7\xc9\xf6\xc8\xa5\x9f\x4c"
        "\x1d\xbf\x7b\x54\x1e\xfb\x66\xee\x0f\x51\xdd\x46\x00\x3c\x0c\x51\xf2"
        "\x0d\x13\x4b\xe5\x86\x7e\xd8\xaf\x0e\xb8\x4b\x7c\x63\xea\x68\xae\xee"
        "\x21\xfd\x51\x6e\xa6\x6d\x61\x7e\x7f\x5d\x2c\x3e\x0d\x1d\xbc\xa7\x27"
        "\x13\xa9\xa5\xf2\xb6\x09\x83\x01\x7a\x38\xb7\x27\x42\x3f\x7e\x01\x0a"
        "\xf9\xc9\xb2\x73\xf3\xaa\xab\x29\xf4\x4e\xd7\xf2\xb8\xfa\x39\xbd\x2b"
        "\xda\x6f\xba\x6e\x00\xfe\x92\x5f\xb9\x65\x14\xbf\x41\x12\xad\x3f\x11"
        "\xf5\x35\x1b\xcc\x09\x9b\xbf\x2f\x36\x26\xf9\xe8\x50\x35\xd4\xef\x26"
        "\x16\x72\x89\x9b\xe3\xac\x37\x48\xb1\x60\x1f\x2a\xad\x9c\xb1\xec\x7a"
        "\x56\xf1\xd6\x92\xbe\xcd\x68\x3c\x52\x23\x47\xb5\x91\x63\xda\x72\xfa"
        "\x46\x2f\x66\xb9\xc7\x92\x86\x7a\x62\x5b\xae\xbe\x4a\xcd\xa2\x07\x44"
        "\xcd\x7f\xa6\x3d\x11\xc6\xef\xde\x99\xf4\x00\x04\x25\xb9\x9a\x9f\xc6"
        "\x1b\x4f\x4b\xbe\x3d\x5a\x6a\xab\xc8\xf3\x43\xa1\x57\x3a\xca\xaf\xe6"
        "\xe8\x11\xca\x09\xae\x4a\x04\xa7\xfc\xe5\xd8\xe2\xad\x1f\x17\x44\xf4"
        "\xdd\x9d\xed\x85\xf7\xec\x28\xee\x53\x9a\x54\x0d\x72\x15\xd2\x5c\x69"
        "\xf7\x6d\xf5\x3a\xb0\x8d\xdb\xa3\x90\x54\xcf\x8e\x9b\xe3\xe4\x93\x32"
        "\xc7\xec\xb7\x71\x8a\x29\xe8\x8e\xde\x16\xd1\x03\x50\x14\xc5\xaf\x79"
        "\x44\x88\x2e\x59\xc2\x00\x9d\x03\xc8\x9a\xea\x07\xaf\x7c\x94\xfd\x8a"
        "\x08\x9e\xd6\xac\x3e\x93\xc2\x7a\x42\xa2\x71\x01\x90\xc2\x6a\x05\xc3"
        "\xb7\x2b\x27\xb9\x26\xeb\x11\x33\x51\xda\x16\xb6\xab\x32\xc1\xbb\x49"
        "\x12\x03\x21\xbc\x2a\x0d\x90\x47\x6b\xe8\xca\xb2\x39\xff\xa9\x75\xc5"
        "\x36\x19\x89\xb9\xd1\xa3\x45\xd8\x45\xba\xb1\x58\x49\x86\x9e\x8f\xa3"
        "\xef\x11\x95\x30\xd1\xb1\x46\x0c\x41\xb9\x87\x61\x96\xa4\xc4\x0a\xe9"
        "\xfc\xe7\xed\x6f\xa9\xae\xd0\xf4\x27\xfc\xd0\xf8\x66\x98\x75\xe2\xb2"
        "\x5b\xd7\xf3\xd3\xd3\x9c\xc9\x31\x2b\xcc\x30\xe7\x8e\x4b\x19\xf2\x03"
        "\x15\x0c\x4e\x42\x18\x0d\x1b\x90\xc0\x10\x4b\x1d\x72\x74\xd6\xd1\x28"
        "\x5d\x14\x1a\xa4\xff\x73\x4f\xb7\xd5\xc4\xd7\xec\x42\xaa\x4f\xcc\xb8"
        "\x15\xf7\xb1\x76\xd8\x42\x18\xb4\x53\xbf\x3d\xce\x54\x39\x0b\x41\x11"
        "\xc4\x79\xb4\x31\xb5\x94\x92\x1b\xd7\x5c\x28\xbe\x66\x38\xaf\x05\xb3"
        "\xa4\x7c\xaa\x40\xa7\x87\x71\xb6\x56\xa5\x09\x8a\xd4\x73\xe4\xf2\x67"
        "\xab\xb4\xdd\x51\x17\xa0\x9f\xfc\x56\x7b\xfa\xc3\xeb\xd0\x41\xd3\xcc"
        "\x41\x3f\xab\xb5\x69\x12\x9b\xd1\xf9\x88\xad\x1c\x54\x4b\xdc\x45\x49"
        "\x3a\xac\x39\xb1\x78\xd9\x8d\x41\xf4\xa3\x9f\x8e\x95\xf7\x8d\xd4\x30"
        "\x45\x65\xd3\x62\xeb\xfa\x42\x0f\x7c\x37\xb3\xa3\x51\xb1\xc8\x29\xb2"
        "\x2d\xd3\x83\xb1\x3d\x1e\x7f\xb9\xd1\xf3\x56\xd1\xf6\x30\xf6\x77\xfa"
        "\x13\x11\xef\xc6\xf5\x74\xda\x49\xb2\xe1\xf8\xe4\x8e\x14\x02\xee\x4e"
        "\xc4\x84\x4a\x26\x9a\xf2\xd6\x86\x10\x11\x87\x17\xcf\xf8\x7b\xfd\x93"
        "\xc1\x9c\x07\x98\x0a\xae\xea\x45\x15\x52\x0c\xa4\x65\x5d\xd1\x84\x16"
        "\x22\xc8\xc1\xa3\xe8\x1c\x2e\xaa\xf6\xaa\x67\x76\x83\x93\xf5\x32\xb0"
        "\x56\x5e\x66\x6c\xcc\xd5\xed\xde\x12\xe4\xa4\xf8\x0b\x0f\x3e\x67\x99"
        "\xbc\xdf\xd8\x6e\x0b\x8a\xc3\x0b\x71\xa9\xcd\x3a\xe0\x58\xfd\x8c\xe5"
        "\xae\xc0\x36\x42\x91\xf0\xff\xd4\x8a\xf9\xcd\x76\xf7\xe2\x2f\x44\xd2"
        "\x26\xef\x73\xd4\x0a\x14\x33\x90\xca\x83\x04\xe8\xe1\x78\xc6\x1b\xd5"
        "\x53\xd4\x26\xe8\x9c\xd1\x2b\x69\xea\x28\xaf\x64\xe5\xc6\xc3\xa7\x25"
        "\xbd\xfb\xc1\x65\x92\xd5\xbf\x40\xb8\x88\x49\xa3\x15\x58\x0f\x41\xc4"
        "\x81\x0c\xb8\xfc\x64\xef\x3c\x03\x1a\x31\x18\x03\xd1\x03\xda\x9e\xb9"
        "\xfa\x32\x2e\x3f\xad\xc6\x5f\xe9\xca\xf9\x82\x3f\x91\x6b\x76\x7f\xe5"
        "\x93\x30\x1e\x45\xaa\x69\x17\xc0\x8b\x94\x27\x74\x38\xa3\x96\x9a\x82"
        "\xa3\xa5\x58\x01\xa4\xbb\x7a\xe5\x7b\xbe\x53\x85\x77\xa6\xc2\x96\x83"
        "\x7a\x49\x0c\xcf\x47\xc4\xdc\xef\x2f\x93\x7b\xa7\x80\xee\x9f\x4d\x20"
        "\x9e\x56\xc2\xd7\x4b\x92\x2b\xf1\xcf\xa4\x50\xc0\xc9\x64\x25\x30\x27"
        "\x88\xee\xb5\x7f\x1a\xc5\x03\x75\x2d\x97\x74\x2a\xac\x7a\xcc\x73\x79"
        "\x78\xac\x13\x28\x3c\x6b\xf6\x27\x9b\xd6\xc1\x01\x5c\x58\x26\xd4\xbf"
        "\x93\x5e\x9f\xcf\x33\xf4\xb6\x9a\xc2\xaa\x50\x96\xac\x04\x33\x7d\xc2"
        "\xa9\xe5\x42\x03\x46\x5a\x1e\xbe\x6c\x60\xaf\x2b\x2d\xaf\xbb\xae\x58"
        "\x9c\x67\x91\xb7\x46\xe3\x8c\x98\x10\xd4\x9f\xee\x0a\x0f\x30\xfa\x92"
        "\xa6\x4c\x26\x44\x56\xd6\x3d\xfd\x0b\x1a\x1e\x93\x70\xf9\xe1\xb7\x5e"
        "\x89\xf3\x99\x7c\xfd\x42\x48\x49\x5a\x29\x88\x71\x66\x09\x78\x60\x15"
        "\x83\x6c\xfc\xb5\x8d\x92\x76\xc9\x35\x8e\x8d\xed\xe5\xc8\x65\x36\xc4"
        "\x84\x24\xc9\x4e\xe5\x6d\xc9\x91\x02\x5f\x0a\x61\xbf\xbc\xba\x96\x7b"
        "\xc1\x87\x2d\xec\x31\xc2\xbc\x4d\x8b\xd1\x7a\x4c\xb8\x22\xa6\x51\x5a"
        "\xd1\x9c\x9d\x79\x0c\xb0\x0d\xaf\x77\xf0\x02\x40\x61\xe5\x1e\x7f\x9d"
        "\x2d\x49\xe9\x03\x04\x84\xb2\xa2\x94\x19\xc5\x3a\x54\x88\x1c\xed\x57"
        "\x28\xac\xe5\x71\x05\xe8\x38\x6b\xfa\x96\xd5\x38\x38\xb1\x57\xc8\x50"
        "\x17\x36\xc0\x30\x5e\xcd\x7a\xe0\x1d\x2a\xc4\x06\x2a\xf3\x50\x02\x3e"
        "\x0a\xeb\x00\x63\x75\x50\x4e\xb1\x63\x13\x85\xe3\x53\x35\xcc\xf0\x65"
        "\xc1\x3e\x52\x18\x52\x45\x56\x17\xc2\x10\x78\x1d\x02\x08\x10\xdb\x99"
        "\x3a\x23\xc0\xae\x07\xc8\xe2\x57\xc0\x09\xdc\xbe\x65\x59\xb3\x7d\xec"
        "\x52\x06\xed\x07\xcb\xdc\xfa\x8b\x1e\x28\xaa\xf1\x46\xc2\x2b\x88\xbf"
        "\xba\xd6\x6d\x1b\x07\xe6\x98\x08\x4b\x8a\xd3\x03\xc4\x80\x87\xe4\xba"
        "\xe1\x28\x9e\x14\xf7\x9c\x2c\x15\xee\x63\xd8\xaa\x3f\x3f\x9f\x81\xa4"
        "\xcd\x76\xb1\x44\x99\x3e\xc8\x1a\xad\x13\xc2\xed\xb2\x8f\x59\x56\x95"
        "\x85\x7c\xd2\x37\x55\xde\xed\x0d\xf5\x87\x18\xb1\x54\x0c\x00\x7a\xc2"
        "\x0c\x73\x39\xae\xce\x09\xe7\xae\xa6\x2c\xad\x9e\x94\x2e\xca\x1b\x49"
        "\x32\xb1\x17\xf2\x5f\xf5\x09\xf9\x5d\x2a\xc0\x3e\x43\x43\x2e\xd2\x02"
        "\x9a\x71\x02\xdc\x32\x89\x65\xd5\xa1\x40\xc7\xa3\x1d\x9e\x95\x29\xa2"
        "\x06\x85\x92\x9e\x96\xff\xfc\x9d\xa5\x89\x5e\x60\xfb\x79\x58\xe8\xe2"
        "\x4b\xd0\x71\x28\x73\xda\x26\x05\x92\xa7\x34\xd4\x66\x51\x59\xf2\x8a"
        "\xb2\x61\xda\xb4\x86\x08\x6d\x94\x1b\x5b\x35\x9b\x8e\x29\xaf\x04\x89"
        "\x29\x53\x15\xcf\x99\xb4\x4c\x1d\x32\xbd\x3e\xfa\xf6\x34\x73\xbd\x5a"
        "\x25\xd6\x76\x79\xb8\xa7\x70\x90\x38\x2c\x6c\x88\x87\x36\xac\x4d\x67"
        "\x2e\x47\xef\x1a\x95\x8d\x54\x1f\xb5\x3e\xb1\x3f\xde\x85\x63\x0c\x9d"
        "\x2b\x20\x27\x1c\x12\xd4\x84\xe7\x82\x38\x90\x5d\xb0\x33\x27\x55\x85"
        "\x03\x51\xe3\x4b\x42\x2f\x3c\x1a\xfa\x56\xa3\x5f\x62\x0a\xb2\xb5\x22"
        "\xa7\xcc\xeb\x69\xc6\x1e\x61\x71\x32\xe0\xbe\x2e\x6b\x90\xcf\xfb\xd0"
        "\x83\x97\xc6\x9c\xaf\x83\x8e\x19\xf6\xea\xd8\xf3\xa2\x1a\x42\x5e\x30"
        "\x4d\x0c\x1a\x6e\xb8\x47\x5d\xf5\x79\x14\x94\xff\x32\x2e\xf4\x1f\x9c"
        "\x69\xd0\xeb\xde\xdb\x0e\x69\x74\x94\x79\x87\x3b\x66\x5f\xa2\x81\x93"
        "\x00\x7c\xa3\x6e\x0d\x16\xdf\x4a\x65\x1c\x5c\xd8\x45\xb2\xab\xd0\xae"
        "\xb6\xc3\x0d\xfb\x58\x1f\xa0\x94\xb2\xd9\xa9\x6f\x48\x79\x71\xce\x61"
        "\xa3\x50\x70\x84\x53\x0f\x21\x37\xa9\x18\xd8\x18\xda\xab\xd5\xe6\x19"
        "\xe6\x26\x0a\x13\xb0\xd1\x78\x70\xe4\xd1\x3b\x5a\x4a\x69\xc5\xd9\x7f"
        "\x78\x43\x82\x9e\xb9\xb4\x92\x6d\x97\x87\x40\xbc\xe9\xee\x12\xd4\xe6"
        "\x25\x94\x19\xcc\x51\xfc\x4b\x8d\x0e\x0a\x07\x49\x58\xd3\x4d\x0f\x7f"
        "\x1d\x28\x2a\x0f\x42\x14\xf6\x52\x5c\x80\x91\xfa\x20\xb2\xf3\xfd\xe9"
        "\xf7\xf2\xe5\x17\x2f\xa3\x16\x0b\xda\xed\x54\xb9\xbc\x7d\x62\x5f\xef"
        "\x1d\xe2\x23\x02\x4a\x33\xf4\x29\xb2\xde\x7e\xc6\x59\x24\xd4\x26\x5a"
        "\x17\x3b\xf6\x67\x0a\x98\xcd\xb6\x05\xd3\xbd\x4f\x6d\x28\x6f\x67\x10"
        "\x22\xde\xc3\xbc\x36\xd8\x0e\xd9\x70\x9f\x25\xe8\x85\x5d\x18\x98\x5b"
        "\x6d\x3b\xbd\xde\xe2\x17\x68\x75\xcc\x52\x1f\xf3\x76\x98\xca\xe2\x13"
        "\xef\x22\xac\x08\x94\x8b\x25\x8c\x65\x82\xe3\xfd\x39\x57\x90\x33\x70"
        "\x21\xd2\x48\x29\xb0\x35\x67\xe2\x4e\xc3\xdb\x3d\xb4\xe0\x6d\x5b\xb1"
        "\x75\xa3\x24\xdc\x7f\x30\x64\x5f\xfe\x89\xef\x2e\x3a\x55\xee\xa2\x27"
        "\x65\x4b\x28\xac\xe8\xb7\xcc\xce\xce\x47\xf7\x73\x8d\x6c\x4d\xaa\x4d"
        "\x6f\xfb\x08\xc2\x96\xb7\x08\x26\x0c\x91\xa4\x1b\x92\x1b\x20\xc7\xd8"
        "\x95\x4f\xcb\x59\x86\x2b\x23\x65\x14\x3a\xbe\x64\x51\x70\x18\x85\xc6"
        "\xfe\xcf\x65\x5f\xe7\x2b\xb9\x60\x76\x48\x9a\x7d\xe6\x51\x5c\x19\x7f"
        "\x58\xae\x41\xb7\x27\x73\xbf\x2b\x00\x3e\x28\xd0\xdf\xc6\x3c\xfc\x2f"
        "\x5e\x65\x50\x78\x26\xd1\x66\xe6\x79\x98\x02\x02\xc9\x5d\x27\xc0\xa3"
        "\xf0\x0d\x42\xc0\xf8\xfe\x9b\xe0\xbc\xd9\x25\x50\x7c\x0a\xea\x3f\x6f"
        "\x75\x26\x22\x87\x3a\x02\x53\x3a\x96\x8b\x53\x94\x94\x92\xb5\xcf\x2f"
        "\x73\x5d\xc8\x86\x58\xf6\x47\x33\xaa\x6f\x16\xf6\xc0\x42\x10\x00\xf6"
        "\xef\x1a\x7f\xc9\x8c\xa8\x93\xef\xa2\x0b\xc7\x61\x12\x2a\x96\xfc\x99"
        "\x34\x3e\x40\x88\x0e\x3e\x6d\x33\x07\x5f\xc5\x48\x01\xce\x02\x23\xee"
        "\x19\x8f\x72\xde\x17\x6c\x74\x9d\x02\x20\xa3\xaf\x11\xd9\x72\xe8\x31"
        "\x0f\xb9\x59\xef\x9c\x20\x12\x5f\xaa\x3f\x10\x79\x19\x4c\x0f\x44\x9a"
        "\xbb\x60\xb2\xe5\x35\x00\x13\xad\xc3\x12\xd0\x4a\x2b\x80\x46\xab\xc8"
        "\xfd\x76\xf2\xfe\x67\x62\x74\x45\x68\xb2\xcf\x79\x69\xd5\x08\x8a\x6d"
        "\x85\xfa\x8b\xa6\x15\x0f\x8e\x15\x92\x25\xdf\x74\x31\x8b\x39\x3a\xe5"
        "\x57\xa2\x66\x23\x03\x8c\x17\x2e\xd9\x80\xfc\x19\x1b\x59\x57\xb7\x71"
        "\x6c\xd1\x6c\x3a\xa2\x55\xe6\x74\xb7\xdb\x8d\x75\x9f\x29\xe1\xbd\x76"
        "\x5c\x24\x68\xc2\x44\x5f\x1f\xc5\x80\x56\x99\xef\xb1\x5e\x8a\x86\x3d"
        "\x0e\x5b\xc4\xdf\x73\x7b\x2b\xec\x8e\x6a\x67\x36\xe6\xb7\x3c\x3a\xf4"
        "\x8d\xc1\x23\xd5\x31\xaf\xae\x25\x8b\xa2\xc0\xbb\xd1\x5b\x6a\xaa\x09"
        "\x46\x3d\xb0\xb6\x94\x82\xaa\xac\x99\x25\x69\xb0\xb9\x8c\x6b\x23\x19"
        "\xc3\x90\xa1\xf5\x9a\xa2\x6e\xe3\x59\x2d\xa8\x87\xf4\xcc\x7b\x6e\x93"
        "\x7f\x96\x5d\xcb\xa0\x13\x1b\x2d\xe5\x6c\x72\x6c\x7b\xbb\x9c\xc9\x80"
        "\x01\xec\xce\xad\x58\x93\x51\x91\x9d\x70\x49\x96\x6e\x03\xc5\xaf\xba"
        "\xab\x82\x87\x17\x50\xcc\x65\x7d\xde\xb5\xe0\xae\x87\xa6\x44\x63\x4e"
        "\x96\x80\xcb\x4f\x92\x16\x88\xc5\x06\x54\x6e\x45\x65\x2a\xf9\x12\x66"
        "\x03\x10\xe2\xcf\x5f\xa9\x66\x94\x4f\xf5\x1d\x8d\xa7\x04\xbf\x8a\x18"
        "\xd5\x25\xc5\x34\xdc\xf0\xda\xce\xdd\x0c\x9e\x00\x97\xfb\x70\x12\x8e"
        "\xce\xb0\x8a\x65\xc4\xb4\xc7\x6d\xd2\x97\x38\x2a\x62\x67\x76\xae\xb5"
        "\x60\xca\x2c\xf7\xd1\x25\xb1\xe2\x6d\xd7\x19\xe0\x9b\x47\x98\xc5\xc1"
        "\x46\x94\xd3\xfb\x45\x3a\xf7\x13\x73\xab\xbd\x3a\xe2\x6d\x49\x17\x1c"
        "\xfd\xbf\x17\x32\x76\x22\x7f\x8d\xc7\xa4\x62\x10\x09\x3e\x06\x60\x4b"
        "\xfc\x92\x5d\xd2\xbd\x86\x52\x1f\xcb\x47\x0f\xfe\x97\x72\x72\x0b\x6d"
        "\xab\xc3\x06\xb6\x85\x1f\x9d\xd4\xa6\xee\xb1\x4a\x65\x55\x82\x67\x05"
        "\x6e\x73\xbb\xc3\x69\x62\xa9\x65\x41\x7d\x0d\x8e\x9c\x32\xdf\xe9\x23"
        "\xac\x5a\x90\xf1\x1d\x28\x23\x3c\x91\xd8\x4d\x0d\x2a\xcc\x63\x2c\x40"
        "\xc1\x4e\x64\xbc\x48\x39\x9e\x3c\xc8\xba\xed\x41\x45\x08\x58\xc5\xaa"
        "\x44\xe6\xf6\xb5\x2f\x58\x07\xbf\x53\x71\xb2\x6e\x86\xc3\x32\xda\x55"
        "\xbe\x39\xf6\xd3\x13\x3a\x90\x02\x7f\x41\x85\xf1\xc5\x29\xfc\x53\xf0"
        "\xf3\xc1\x17\xce\xeb\x80\x63\x30\x58\xda\x6c\x78\xf4\xd4\x54\x3d\xd5"
        "\x8b\x11\x69\x01\xaf\x52\xcf\x2e\xda\x06\x76\x84\x9e\x94\xe8\x04\x5c"
        "\x4c\x31\x60\x87\x28\xb8\x67\x04\xd0\xf0\x94\xde\xba\x8b\x4c\x81\x4c"
        "\x69\x56\x4a\x79\x5b\xb2\x3e\xfb\x26\x05\xc5\x4d\x01\x04\xcc\x46\xe3"
        "\x0e\x1d\x59\x6f\xa3\xf3\xe6\x9b\x11\xee\x0d\x95\xf0\xb1\x7b\x39\x9e"
        "\x37\x61\x9f\x2c\x71\x8c\x15\xd9\x97\x69\x94\xd2\x5e\xa0\xa7\xff\xbc"
        "\xf4\xcd\xfe\x33\x57\x97\x6d\xb3\xb0\x70\xfb\x08\xfa\x2a\xb9\x77\xdd"
        "\x2d\xba\x31\xd6\x1c\xe9\xea\x08\xed\xe5\x94\xef\x4a\x9c\xc6\x38\xb3"
        "\x3d\x0f\x1f\xc2\x71\x87\x9c\x99\xda\xd7\xe8\xfd\xcb\x6a\xf1\xec\x95"
        "\x4b\x10\x40\x20\xe5\x8d\xd1\x7e\x9f\x12\xf3\xd7\xfc\x0d\x64\x70\x73"
        "\xd0\x20\x09\x6e\x68\x55\x98\x06\xa9\xaf\x78\x1f\xd0\x5f\xe0\x29\x7c"
        "\x14\xfc\x88\x4e\xe8\x48\xd7\xda\xf1\x7a\xb7\xf3\xe5\x3e\x99\x03\xec"
        "\xaf\xc3\x89\x69\x71\x19\x41\x3f\x95\xe9\x8f\xbe\x79\xfb\x38\x9d\xce"
        "\x96\xa7\xc2\x1b\x98\xd5\xaf\x3d\x66\xa9\x77\x63\x9e\x69\x70\x1b\x09"
        "\x09\x64\xac\x76\x0b\xc8\x48\xb9\x1d\xde\xf8\xf0\x7c\xe2\x88\x12\x4e"
        "\xd1\xe9\x25\x85\x3e\x7b\x70\x77\xb9\xbc\x7c\x7a\x7f\x87\x4d\xd2\x85"
        "\xa0\xa2\xe6\xa3\x71\xab\x3b\x34\x8b\xc2\x85\x76\xbf\x32\x84\x0a\xd2"
        "\x57\x36\xbe\x02\x26\x18\x02\x88\xbb\x46\x29\x8f\x48\x2f\x35\xde\x9e"
        "\xff\xbb\x14\xba\xb4\xd0\x40\x5b\xd1\x4b\x5f\x27\x5d\x51\xe9\x17\x21"
        "\x5f\x85\x84\x2f\xe5\xcd\x1f\xb9\xb7\xc2\xce\x45\x4f\xee\xd3\x79\x9e"
        "\x76\x60\xae\xf7\xdf\xed\x89\x55\x9e\xd6\x9d\xc7\x40\x72\x38",
        8192));
    NONFAILING(*(uint64_t*)0x2000d4c0 = 0x20000140);
    NONFAILING(*(uint32_t*)0x20000140 = 0x50);
    NONFAILING(*(uint32_t*)0x20000144 = 0);
    NONFAILING(*(uint64_t*)0x20000148 = 0);
    NONFAILING(*(uint32_t*)0x20000150 = 7);
    NONFAILING(*(uint32_t*)0x20000154 = 0x22);
    NONFAILING(*(uint32_t*)0x20000158 = 0);
    NONFAILING(*(uint32_t*)0x2000015c = 0);
    NONFAILING(*(uint16_t*)0x20000160 = 0);
    NONFAILING(*(uint16_t*)0x20000162 = 0);
    NONFAILING(*(uint32_t*)0x20000164 = 0);
    NONFAILING(*(uint32_t*)0x20000168 = 0);
    NONFAILING(*(uint16_t*)0x2000016c = 0);
    NONFAILING(*(uint16_t*)0x2000016e = 0);
    NONFAILING(memset((void*)0x20000170, 0, 32));
    NONFAILING(*(uint64_t*)0x2000d4c8 = 0);
    NONFAILING(*(uint64_t*)0x2000d4d0 = 0);
    NONFAILING(*(uint64_t*)0x2000d4d8 = 0);
    NONFAILING(*(uint64_t*)0x2000d4e0 = 0);
    NONFAILING(*(uint64_t*)0x2000d4e8 = 0);
    NONFAILING(*(uint64_t*)0x2000d4f0 = 0);
    NONFAILING(*(uint64_t*)0x2000d4f8 = 0);
    NONFAILING(*(uint64_t*)0x2000d500 = 0);
    NONFAILING(*(uint64_t*)0x2000d508 = 0);
    NONFAILING(*(uint64_t*)0x2000d510 = 0);
    NONFAILING(*(uint64_t*)0x2000d518 = 0);
    NONFAILING(*(uint64_t*)0x2000d520 = 0);
    NONFAILING(*(uint64_t*)0x2000d528 = 0);
    NONFAILING(*(uint64_t*)0x2000d530 = 0);
    NONFAILING(*(uint64_t*)0x2000d538 = 0);
    NONFAILING(syz_fuse_handle_req(r[0], 0x2000d540, 0x2000, 0x2000d4c0));
    break;
  case 5:
    NONFAILING(memcpy(
        (void*)0x20007f80,
        "\x90\x2e\xf8\x51\x2b\x71\x7f\xaa\x84\x5e\xb2\x33\x0a\xee\x87\x72\xe8"
        "\x66\xa4\xe7\x9c\xa3\xf6\xd4\x55\xeb\x7d\x6e\x8e\xf3\x7b\xea\xcd\x61"
        "\xd8\xfd\x52\x66\x4d\x5c\x34\x3f\x14\xa3\x1a\x7c\x40\xd0\x35\x47\xc4"
        "\x76\xbd\x17\x5d\x99\x5f\x45\x01\x69\x80\xde\x01\x9e\x02\x18\x2b\xd7"
        "\x1c\x84\xc9\x3c\xd4\xc8\xf3\xce\x93\xdb\x4e\x95\xae\xb3\xfb\xc4\x43"
        "\x9a\xee\xc2\xe3\x3c\xfe\x64\x1b\x64\xb2\x30\x91\xda\xf5\x8f\x0c\xe2"
        "\x62\x68\x4d\xb8\x09\x33\xc8\xe9\x9c\x2b\x1f\x3f\xf7\x5a\x46\x11\x54"
        "\xbe\xf5\xd0\x34\x0e\xd8\x55\x34\x8b\x12\x0e\x04\x56\x0c\x53\xc9\x19"
        "\xdb\x5e\x28\xcc\x07\x01\x86\x98\x3c\x4a\x1d\x01\xbd\x1c\x58\xf2\xf5"
        "\x72\xcd\x9c\xbe\x55\x78\xf9\x0d\xba\x7a\x34\xaf\x64\xe9\x26\x78\xc6"
        "\xea\x27\xa6\x72\x4e\x41\xb2\x33\xeb\xb6\x05\x62\xa7\x94\xe2\xbf\x8b"
        "\x21\xa7\xa2\x6d\xaa\x80\xa4\x6c\xa8\x5a\xe1\x5c\x59\x9c\x97\x43\xb6"
        "\xf7\x93\x22\x0c\x6c\xe0\xf8\x55\xf4\x56\xf3\x10\x81\x61\x89\xe1\x79"
        "\xee\xd4\x1c\x68\xc0\xd7\x99\xea\xcc\x70\x87\x34\xb0\xde\x82\xeb\x82"
        "\xcf\x0c\x8f\xbf\xa3\x2b\xb0\xe6\xbe\xe6\x18\x93\xf9\x65\xd2\x6f\xfa"
        "\xb3\x1d\x46\x62\xed\x76\x5d\x4a\xa5\xb5\x54\x4b\x26\xec\xe1\xf5\xc7"
        "\xa2\x7d\x38\x88\x1f\x5a\x3a\xda\x72\xc5\x0e\xed\x72\x55\x92\xb0\xf0"
        "\xbf\x05\xcf\xca\x69\x2f\x8b\xcf\x7c\xf9\x8e\xe0\xf3\x77\x7a\x70\x49"
        "\x37\x11\xa8\xfb\xc9\x3f\x13\x3f\xdb\x54\x91\x62\x88\x0a\xbb\xdb\xdd"
        "\x93\x7e\x4b\x89\xfb\xf7\x43\x3a\x38\x5e\x8b\xd0\xce\x16\xd0\x42\xe7"
        "\xb5\xa9\x19\x0a\x09\x75\xc8\xf6\x29\xfa\xe6\xb0\x81\x98\xf9\x0b\xa4"
        "\xa7\x21\xaf\x1e\x48\x23\xa0\x81\xe4\xe9\x44\x81\xe8\xb4\x3a\x30\xf9"
        "\x39\xa4\x8b\x3a\xff\x9a\x16\xe4\x12\x11\x26\x88\x30\x86\x23\xc3\x88"
        "\xd9\xe4\x78\x16\xe0\xd1\x35\x1b\x46\x7c\xf8\x39\x65\xe2\x65\xe7\x9f"
        "\x29\xdf\xee\x8e\xba\x4d\x0b\x3f\x8f\xa1\x13\x6b\x34\xa0\x2c\xcf\xaf"
        "\xc4\xac\x86\xcf\xda\x2a\xc1\x4c\x05\xa0\x0e\x69\xe7\x51\x0e\x61\x4e"
        "\x3c\xa7\x9c\xb1\x75\x06\xc4\xf5\x2e\x40\xaf\x31\x10\x8e\x69\x7a\xc0"
        "\x0c\x9f\x24\xee\x02\xda\xcb\xf9\x52\xf4\x1f\x78\xd9\x07\x64\x79\xea"
        "\x51\xe9\xdc\x0b\x73\x23\x08\xaf\x9a\xac\x7a\x2a\x3a\x38\xf7\x8c\xc4"
        "\x08\x25\x7a\x30\xb8\x96\x04\xad\xa4\x02\xda\xcd\xc8\x3c\x12\xd1\x53"
        "\x0b\x3b\xa6\xbd\x13\xe6\x66\xee\x15\x58\xc9\x54\x92\x5a\x35\x8f\xc8"
        "\x44\x77\x5b\x8b\x23\x9b\x97\xd6\x65\xc9\x0c\xa8\xf9\x45\xec\x6b\x1c"
        "\x35\x20\xea\xcc\xea\x04\x7e\xc9\xfc\x4f\x5a\x1d\xaf\x90\x8b\xaa\x33"
        "\x24\x62\xcc\xdf\x38\xdd\x4b\x90\x80\x9a\x9f\x46\x07\x6d\xf1\x19\xeb"
        "\xea\x3c\x1b\x36\x44\xe6\x80\xd8\x51\x45\x23\x3d\x24\xdd\xbe\x5f\x46"
        "\xb7\x5c\x46\xa7\xb4\x2d\xe7\xc2\xee\x83\x9c\x53\x61\xfc\x0f\x21\x6d"
        "\x59\x35\x54\x9e\x68\xbb\xa8\xd2\xe4\xb1\x6d\xcf\x16\x26\x80\x96\xae"
        "\x9a\x7b\x77\x9b\x9b\xb6\xb1\x94\xfd\xcf\xb7\xa5\x59\xe6\x06\xa1\x7e"
        "\x56\x6e\xe3\xa0\xde\x1a\x17\x56\xb5\x47\x59\xea\xfe\xee\x9e\x80\x5c"
        "\xe7\x1e\xe5\xe1\x96\xbe\xd2\xd3\x1e\x5f\xa8\xd0\x56\xe9\xac\xa1\xbb"
        "\x68\x1d\xad\x82\x6a\x08\xe3\xb9\xf3\x8b\x66\x57\x06\x23\x63\x0f\x0b"
        "\xad\x28\xc7\xeb\x81\x0a\xbc\x9c\x41\x95\xac\xf1\xcb\x4f\x9f\xc7\x6a"
        "\x82\x04\x91\x39\xdd\x95\x46\xbb\x50\x74\x51\x03\xf0\x06\x5f\x9d\x89"
        "\x98\x62\xd3\xb0\x01\x10\xde\x22\x06\xa6\xbe\x39\x53\x38\x2f\x31\x81"
        "\xeb\xd8\x81\x18\x56\x91\x25\xc6\xcb\xf3\x9f\x70\x9c\x08\xd4\xb5\xe2"
        "\x3d\x01\x33\x35\xab\xec\x46\x68\x97\xcb\x7a\xa0\xb8\xf0\xe2\x84\x1f"
        "\x94\xbe\x6e\x92\x74\x19\x49\x0d\x82\xf7\x17\x55\x76\x3a\xfd\xa3\x3a"
        "\x49\xe9\xe3\x03\xe5\x04\xf7\xf1\x73\xfc\x0c\xc3\x9f\x8d\x67\xf9\xd7"
        "\xfc\x2d\x76\xde\x23\xdd\x15\x00\x2b\x86\x31\xd3\x0b\x83\xac\xf3\x6a"
        "\x0a\xbe\x4c\x99\x4f\xc0\x12\xfc\x6f\x02\x86\x22\x15\x13\xfd\xb1\xbc"
        "\x16\x9a\x23\xd9\x1d\x5c\x79\x7a\x3d\x23\xb5\x1d\xf0\x42\x24\x21\x4c"
        "\xbc\x15\xa7\xec\x5c\x09\x79\x0d\xaf\xcf\x79\x63\xf6\xdf\x35\x97\x41"
        "\xc8\x93\x0f\xc6\x63\x76\xa9\x1b\x28\x77\x62\x5d\x8e\x1c\xf5\x4b\xff"
        "\xde\x26\x4b\xf4\x95\x2a\x96\xa4\x0b\x77\x40\x00\xdd\x6b\x8e\x02\x6a"
        "\xbe\x69\xae\xbf\xf4\x70\x7d\xa0\x61\x70\x23\x37\x7d\x7d\x39\x27\x7c"
        "\x54\x2b\x58\x1d\x40\x22\x8e\xa1\xea\xee\xa1\x8f\x85\x00\x03\xb6\xaa"
        "\x31\x30\x13\xd7\x7c\x50\xb9\x65\x51\xed\x96\x0b\xfe\x28\xd3\x82\x57"
        "\x2e\x4e\xaa\xac\xd5\xc6\x8b\xa5\x50\x7c\xc5\xa6\x2b\x70\xdb\xda\xc7"
        "\x05\x98\xe9\xa3\x4b\x03\x1e\x76\x42\x74\x38\xd9\xdd\xd4\x7f\x75\x7d"
        "\x5a\xce\x7e\x1a\x2d\xf9\x4a\x44\x05\x6b\x8d\x5e\x63\x33\x27\xbe\xeb"
        "\xce\xf7\x18\x11\xba\x6a\xfc\x5a\x67\xf7\xc2\x4e\x35\x49\x8f\xa3\x8f"
        "\x0c\xfe\x4d\x38\xd6\xba\x56\x2e\xba\xa6\x2c\xc9\xdc\x5f\x8d\x94\xfa"
        "\x25\x59\xb3\x9c\xd2\x24\x4a\x5a\x9c\xeb\x72\xd7\x62\x16\x5f\xeb\xa5"
        "\x14\x14\xe2\x36\xf7\x05\x7d\xd1\xf8\xd7\x76\xf7\x15\x89\x69\x73\x6c"
        "\xfb\x05\xdc\x11\x8b\x9e\x07\x4f\x38\x22\x12\xf5\xdc\x31\xfe\xdd\xab"
        "\x01\x0f\x6c\xf0\x9b\x29\x8e\xda\x38\x82\xd3\xd9\x2e\x51\xba\xba\xc5"
        "\xa3\x7c\x88\x39\x32\xe6\xb1\x0c\xd4\x73\xb2\x7e\x62\x67\x9d\xaf\x45"
        "\xe7\x54\xeb\x0c\xb6\x69\xb1\x72\x52\x9c\x3a\x95\x98\x16\xc9\x02\x82"
        "\x46\x46\x5d\x0c\x16\xbe\x93\x58\xab\xb3\x21\x95\x81\xf1\xe9\xd4\x83"
        "\xdd\x29\xb7\xcb\x8f\x35\x70\x9e\x12\xfd\x90\x2b\xea\x1a\x86\xc5\x46"
        "\x50\x3e\x42\xff\x05\x18\xad\xa1\x7d\x1f\xcf\x69\xee\xda\xc4\xe0\xdc"
        "\xa9\x3b\xed\x47\xa1\xdc\x75\xf0\x9e\xf9\x10\x0f\xe9\xbb\x54\xa1\x1f"
        "\x66\xd9\x03\xf8\x89\xe9\x20\xcf\x8b\xd2\x83\x44\xa5\x7a\xa0\x6e\x1e"
        "\x0e\xe0\xe3\xa7\x7c\x8c\x6c\xe5\x8b\x57\x1d\x44\xfc\x99\x54\x7c\xb9"
        "\xe1\x1c\xef\x9e\xea\xa4\xee\x1d\x65\xe0\xf4\x94\xc1\xfb\xba\x61\x0b"
        "\x3c\x2d\xa1\x9c\x79\xd5\xc9\xa0\x2e\xb1\x0d\x49\xc6\x81\xe1\xa9\x28"
        "\xf4\xb2\xb0\x0b\x9c\x21\xc1\x03\x7d\xca\x06\xcd\xfc\x5e\x11\x7a\x25"
        "\x99\xc9\x9b\x8f\xce\x82\xab\x21\x7e\x5a\x6e\x96\x4b\xe1\xf0\xc6\x71"
        "\x90\x6b\x14\x04\x11\x24\x28\x3b\x60\xfb\x89\xfb\x70\xc4\xe9\x0f\xed"
        "\xb5\xf3\x36\xe8\xdc\xb5\x3e\xd0\x09\x28\x09\xf8\xe2\xed\x0b\x82\xca"
        "\xfd\x20\xcb\xa8\x04\x2a\x0e\xa4\x58\x0d\xd8\xf4\x32\xdd\x65\x33\x88"
        "\x98\x47\x78\x04\xbb\x16\xca\x46\xcb\x1b\x07\xf3\x6e\xec\xbf\x4c\x2f"
        "\xde\xec\x8a\x0b\x30\x4a\x3c\x28\x46\xd1\x17\xed\xc7\x4b\x4b\xa0\x95"
        "\x4a\xdf\x45\x5f\x09\xc3\x2c\x51\xff\xba\x95\x12\x92\xc6\x8c\xa8\x26"
        "\x60\x5b\x47\x88\x92\x47\x91\x9f\xdb\x58\xa6\x8c\xa0\x40\x3d\x82\x23"
        "\x44\xef\x25\x27\xce\x15\x58\x86\xb2\x0f\xaf\x4d\x41\x85\x3d\x60\xe2"
        "\xa3\xca\xb9\x80\x22\xba\x36\x9d\xe3\xa2\x41\x1c\x26\x03\x82\xb0\x3d"
        "\xe5\x23\x49\x9c\x16\x1b\x40\x6b\xcf\xd3\x91\x52\xd7\x7c\xcb\x1b\x05"
        "\x95\x0f\xf5\x2b\x6f\xeb\x47\xae\xec\x80\x1d\x83\x23\xcc\xc6\x94\x03"
        "\x48\xa5\x84\xee\x1f\xbc\x8d\x49\x51\x19\x59\x87\x02\x65\x47\x13\x71"
        "\x29\x5f\xbc\x50\x0e\x0e\xdb\x6c\x9a\x9f\x08\x70\xe8\xec\x54\xd8\xa1"
        "\x2e\xcb\xce\x8c\x8b\x1a\x65\x4f\xa0\x31\x68\xb8\x7b\xf7\x95\xb8\x26"
        "\x79\xad\x17\x02\xf8\x32\x2c\xc0\x2c\x50\x4d\x5e\xfc\x4b\x08\xbd\x4f"
        "\xeb\x25\x6e\xec\x0b\x93\x28\xd6\x92\x59\x35\x35\x9b\xe4\xca\x93\x12"
        "\x75\xae\xe2\x57\x78\x49\xfe\x05\x10\xe0\x71\x06\x56\x3e\x42\x03\x3d"
        "\xe6\x00\x38\x3b\x54\x6a\x13\xa2\x04\x30\xe6\xf5\xc7\xda\x06\x1c\x3c"
        "\x34\xfa\x7b\x32\xa0\xc6\x79\x44\xed\xe7\xb0\x68\x01\x31\x2b\x9e\x09"
        "\x43\xee\x76\x33\xaa\xe7\xdf\xa7\xa5\x58\xb0\x01\x19\xc7\xa0\x5c\x1f"
        "\x53\x29\x46\x27\xf7\xa3\x22\x9e\x3e\xa6\xbd\xbc\x01\xdb\x2d\x81\x98"
        "\x9b\xc7\xb0\x3e\x37\x7f\xba\x41\xda\x69\x2e\x02\x0d\x98\xa3\x9e\x33"
        "\xc4\x68\xab\x7f\xab\xa5\x3d\x6e\xd1\xda\x35\x52\x8e\xaf\xac\x2d\x1e"
        "\x4d\xd2\xca\x5e\xa9\xa2\xef\x86\xd7\x6c\xca\x74\xf0\xbe\x0d\x76\x93"
        "\xc8\x55\xd7\x8e\xf3\xd5\x39\x98\x04\x81\x52\x87\x04\x7a\xef\x8e\x66"
        "\xa6\x97\x95\x9c\x39\x51\xb1\xd9\x81\x98\xd5\x14\x98\x1e\xda\xd8\x31"
        "\xc3\x29\x68\xa0\xde\x91\x81\xc9\xa0\xd6\x55\xa1\x60\x4c\x84\x91\x23"
        "\x38\xb9\x43\x96\xec\xaf\xe8\x77\x63\xd8\xde\xa0\xd8\x41\xa7\x46\x19"
        "\x89\xd7\x00\x3a\x70\xde\x77\xc9\x46\x5e\x80\xe4\x1a\x24\xda\x9b\x79"
        "\x7e\xa3\xbb\x6d\x85\x9b\x29\x4e\x0a\xf5\xd3\x87\x1e\x55\xfa\x8d\x42"
        "\x10\x99\x7d\xa3\xd5\x7c\x77\xd2\x3b\xcc\xbf\x6c\x6c\xdc\x2e\xb0\x3a"
        "\xdc\x57\x0b\xfa\x44\x28\xd7\x25\x70\xe6\xd6\xee\x17\xb8\xd4\x68\x7e"
        "\xb6\x63\xcb\x48\x37\x6d\xde\xc0\x01\xca\x41\x7d\x43\x84\xe0\xde\x7d"
        "\x12\xb0\xa0\x66\xec\x62\xb3\xda\x23\xe5\xd9\x0f\xea\x79\x8b\x11\xb8"
        "\x5e\xf6\xfe\xf9\xfd\xa7\x94\x76\xa2\xfe\x62\xd6\x02\xcb\xcd\xbb\x6c"
        "\x8c\xee\x10\xf4\x8d\x18\x7e\x2b\x88\x96\x1f\x22\x92\x85\xdc\xa4\x6e"
        "\x43\x7b\x64\xa7\x23\x80\x9e\x92\x62\x28\xb6\xab\x72\xf5\x12\x16\x5d"
        "\x4e\xda\x98\xba\x66\x40\x77\x9d\x2f\xe6\xeb\xf8\x00\x2e\x63\x4c\xa2"
        "\x5e\xd3\x0c\x04\x8c\x83\x9a\x70\x4c\x36\x0d\xbe\xeb\xd6\x28\xb0\xe8"
        "\x34\x17\x18\x95\x7a\xb0\x96\x5e\x73\x97\xb8\xf9\x52\xdc\x49\x19\xa7"
        "\xdd\x04\x7d\x1e\x60\x0b\xc2\x00\xe3\x50\x22\xe7\xd1\xe3\xc0\x4e\x97"
        "\x2a\xd3\xe8\x95\x56\xce\x63\x43\xa0\x0e\x40\xfb\x74\xf4\x65\x62\x6b"
        "\x79\x55\xc8\x43\xf9\x85\x1e\x21\x09\xdd\x59\x79\xe5\x50\x72\xab\x60"
        "\x39\x90\x3f\xf5\xa6\x9b\xfc\x2a\xfc\xa0\x38\xc0\x43\xa3\xfa\x27\x68"
        "\xd4\xc0\x74\xe4\xdc\xb2\xfb\x9e\xcd\xc9\x0f\xbd\xc9\x3d\x6d\x76\xb2"
        "\x94\xbf\x0e\x8a\x40\x17\xed\x01\xcb\xd6\x10\xd8\x1c\x2e\x4a\x26\xfd"
        "\x2d\x57\x48\x6a\x24\xf2\xff\x9a\x9e\x01\x61\xc3\xb5\x11\x60\x1d\xcf"
        "\xf7\x69\xa0\x5d\x13\x9e\xb0\xda\x8a\xb7\xfa\x47\x18\x76\x74\x25\x77"
        "\x8c\x91\xd0\x66\xe7\x40\xde\xc7\xac\x55\xa2\xe3\xab\x0e\x53\x6c\x69"
        "\x97\x78\x00\x41\x98\x55\x1a\x2e\xd1\xb8\x9d\x00\x88\x97\x91\x8d\x09"
        "\xeb\x8a\xb7\x2a\x49\x4b\x06\x90\xc1\xab\xbc\xb2\xc1\x27\x39\xba\xc6"
        "\xff\xb5\xc5\xa2\x4e\xc3\x4e\x1a\x0f\x53\x2a\x31\x98\x41\x68\x33\x1d"
        "\xb7\x41\x81\x75\x87\x94\x87\xf5\xd1\xa5\x2c\xf3\x92\x72\x2d\x4d\x6b"
        "\xc7\x61\x7c\x9c\xeb\x4c\x35\x3f\x77\x35\x02\x27\x2d\xfa\xaa\x95\xec"
        "\x69\xd8\x17\xf9\xec\x3d\xec\x9c\xa1\x77\xd4\x17\x02\xda\x4c\x5b\x5b"
        "\xd0\x14\xbf\xbe\xee\x2b\xb2\xaf\x25\x13\xf3\xd8\x4d\x7c\x23\x70\x10"
        "\x4a\xff\xa3\xbc\xc4\x1d\xc7\xc4\xdc\x11\xd1\xba\x82\x99\x94\xfe\x85"
        "\x17\xe4\x15\xc3\xfe\x85\xd0\x71\xdc\x44\xac\x74\xc0\xdc\x9f\xe5\x0e"
        "\x10\xb7\xc3\x99\x1e\x2f\xd8\xad\xd1\xb6\x0a\x77\xc6\xb8\x1a\xd1\x54"
        "\x02\x29\x17\x16\x62\x70\x10\xed\xe8\x0a\x17\xcc\x89\x98\x7a\x88\x1b"
        "\x3d\x0d\x58\x79\x65\x2e\x39\xff\x19\xbc\x57\x75\x64\x60\xd3\x09\xaf"
        "\x03\x45\x99\x90\x23\x15\x2b\x86\x1f\xa5\xae\x42\x9c\x45\x96\xea\x05"
        "\x8f\xae\x20\xe8\x40\x79\x93\x60\xe7\x22\x93\x84\xfc\x6e\x55\xf7\x09"
        "\x7f\xdf\xe1\x04\x35\xf2\x3e\x89\x1b\x32\xfd\x13\xd1\xef\x76\xaf\x95"
        "\x56\x04\x5b\x17\xc5\x67\x24\xf8\xeb\x86\xf1\x1c\x62\x4e\xc9\xc0\xf2"
        "\x05\xc1\xc6\x0a\x37\x6b\xdc\x38\x83\xcb\x46\xe0\x10\x22\x15\x34\x63"
        "\x85\x62\x5d\xf2\xf7\x09\xb7\x72\x6c\xef\x5b\xf6\x8e\x19\x33\x34\xfe"
        "\xef\xd7\xda\x35\x89\x24\xb1\x65\xd3\xe4\xbc\xa9\xe7\xfc\x0c\xb0\x6b"
        "\x8a\x95\x02\x82\x3f\xc8\x11\xca\x79\xb2\x84\xa9\x06\x42\x13\x94\x3a"
        "\xcd\x7b\x3c\x9f\x81\xc5\x5c\x20\xb8\x02\x46\xbb\x86\x24\xf9\xa3\x93"
        "\x94\xfe\x4e\xba\xf8\x4e\x14\xee\x67\x6f\x32\x40\xa4\xf1\xea\x40\xe9"
        "\x74\x4f\x3f\x48\x55\x0d\x4e\x44\x35\x01\xb8\x62\x1b\xc9\xe1\xca\x93"
        "\x91\xe9\x92\x06\xe4\x7a\xc9\x3a\xb9\xee\x28\x2e\x08\x5c\x32\x4f\x64"
        "\xc6\x8f\x81\x44\xa9\xe9\x7d\xd0\xa0\x3f\x90\x4f\xd3\x94\xe8\xa3\x71"
        "\x92\xab\x27\x0f\xcf\x2b\xed\xc3\x83\xf9\x67\xf3\xac\xde\xd1\xb0\x4c"
        "\x05\x98\x87\x8a\xad\x1b\x69\x63\xc9\x32\x23\xbf\xa9\x8e\x15\x98\xe9"
        "\x26\x00\x0e\x3c\xc9\x87\x16\x0b\xe3\xd9\x0b\xef\x9f\x38\x49\x69\x60"
        "\x7e\x67\x89\x3a\x9f\x63\x11\xa0\x7a\x85\x08\x19\xbb\xf1\x0e\xda\xe3"
        "\x8a\xae\xd0\x2a\xc5\x99\xf2\x79\xb0\x5a\xce\xf3\xbe\x8d\xad\x4b\x9d"
        "\xa5\x7c\x09\xde\xa4\x6e\xb3\x82\x2c\x15\x59\x66\xe8\x92\x63\x5a\x8c"
        "\x48\x51\xa2\x29\xe0\xd4\x25\xee\x36\x59\xfd\xa4\xb1\x21\x5d\x54\x00"
        "\x0a\xf3\xc2\x91\xe0\x47\x44\xf9\x66\xcd\xf2\x44\x0d\x67\x6a\x7f\x59"
        "\x55\x85\xfd\xfb\xf3\x58\xcc\x6c\x84\xcd\x0c\x2b\xed\xf7\xb9\x90\x47"
        "\x9d\xa0\xb1\x65\xed\x83\x6c\xc9\xdb\x47\x09\x33\x35\x79\xcc\x73\x98"
        "\xab\x69\x5d\xae\xd8\xe2\xac\xbd\xd9\xcc\x1f\xee\x41\x7e\x42\x55\x2c"
        "\x8f\xe8\xa9\x0d\x58\x1f\xc5\xe4\xb8\x49\x90\x50\xa6\x10\xdb\x24\xed"
        "\xde\x9a\x8e\x0f\x65\xb4\x00\xd5\x16\xa1\x29\xf9\x3f\x59\xb6\x8d\x8f"
        "\xac\xc2\x6a\x4f\x9b\x7f\x3e\xe6\x86\x9d\x35\xd6\x19\x5d\x4a\x56\x52"
        "\x28\x18\xdf\x64\xab\x11\x6e\x5b\xad\xe7\x3b\x94\xf6\x6a\xd9\xce\x3a"
        "\xb1\xfc\xce\xf8\x7a\xab\x11\xab\xcb\x4a\xd5\x7d\xb8\xab\xab\xe2\x8f"
        "\xaf\x7e\x47\xc8\x87\xa3\x43\xf0\x9d\xd0\x55\xc2\xc4\xc0\x9d\x90\x9e"
        "\x77\xb8\x48\xad\x9e\xa1\xf3\xb7\xdf\xed\xa3\x34\x0a\xa9\x32\xd2\x5c"
        "\x07\xee\xc4\xea\x4e\x9a\x42\x99\xa5\x78\xd8\x91\x07\x84\x4d\x0c\x68"
        "\xe5\x4e\xd8\x65\x7e\x4c\xd8\xd1\x7c\x1a\x6a\x16\x2a\x72\xb5\xa7\xf8"
        "\x12\x63\x5b\xa2\xe0\xd0\x10\xb9\x31\xcb\x2b\x23\xf6\xe7\xa4\xc4\xad"
        "\x0d\xb5\x69\xf2\xe8\xbc\x3a\x3d\x1a\xa6\x9e\x75\xa4\xf5\xea\xdd\xc0"
        "\xbb\x82\x51\xbc\xe6\x37\x4a\x8a\x4e\x0a\x62\xad\xa7\xf7\xbb\xee\x77"
        "\x16\x36\x79\xe2\x37\x8f\x8a\xe0\x3f\xfd\xb8\xf7\xd4\xbc\x88\x52\xbf"
        "\xd2\xe9\xe5\xe4\x1e\x87\xdd\xc9\xdb\xda\xc5\x16\xab\xcd\xd9\xbd\xc6"
        "\x3a\xdb\x29\xcc\x97\xeb\x97\x3e\xb9\x52\xf7\x9e\x89\x3a\xd5\xe3\x38"
        "\x00\xcf\x61\x48\x35\xc9\xfe\x0e\x0c\xa3\x8c\x12\xf3\x03\x45\x4d\x8c"
        "\x98\x6b\x21\x2d\xd9\x9e\xff\xd5\x07\xcd\x7e\xf3\xd6\x08\x6d\xce\x1b"
        "\xf6\x95\x0d\xfb\xff\xc1\xab\x8f\xee\x49\xd5\x28\xe9\x17\x34\xec\x16"
        "\xb3\x5d\x27\x3d\x33\x57\x28\x26\xe2\x92\x4e\xa0\x61\xaf\x5f\xcc\x96"
        "\x1b\x3a\xe3\x58\x17\x2f\xba\x74\x9d\xc0\x7c\x75\x61\x71\xa6\x78\x50"
        "\xff\x0d\x1c\x87\xfa\xc1\x66\x97\xcf\xc5\xee\x68\x11\xb6\xf9\x66\xda"
        "\xde\xc3\x6c\xaf\x38\xba\xe3\xe7\xe1\x88\x11\x3e\x36\x13\x00\xe5\xe5"
        "\xab\xc5\xfd\x7d\xae\x56\x03\x0f\x80\xc0\xb7\x36\xc5\xf4\x3c\x38\xb7"
        "\xd6\xd0\x28\x7e\xd9\x77\xc9\x4a\xf6\xd7\xc7\x3c\x57\x96\x05\x92\xb6"
        "\x52\x63\x1f\x79\xa5\x0e\x9b\xab\x65\x65\xbe\xdc\xa8\xd5\x9a\xc5\x77"
        "\x23\x00\x26\xdf\x9c\x47\xc4\xbc\x97\x03\x7c\x77\x28\x8f\x6f\x2f\x72"
        "\xc8\x77\x18\x33\x24\x0c\x7b\xe4\xcc\x30\x3e\x88\x9b\xa5\x03\x27\xa7"
        "\x48\xd1\x8d\x34\x95\xf1\x27\xea\xc2\x98\x73\xc3\x2c\x0e\x81\xf5\x8e"
        "\xdb\x27\xd6\xf4\x67\x3f\xa8\x45\xd2\x4d\xd7\x9c\x82\x82\x8d\xb2\x18"
        "\x59\xc5\x62\x96\x3e\xed\x7b\x9b\x56\x88\x25\x63\xbb\x27\xd6\xb7\x62"
        "\x34\xee\x5d\x55\xe2\xf1\x51\x7f\xd0\x1d\xad\x83\xe7\xdb\xdd\xff\xc3"
        "\x0c\x25\xbd\x98\xa2\x33\x6e\xb0\x30\x69\xf7\x8c\x1c\xe7\xc5\xd7\x2e"
        "\xd4\xdc\x65\x88\xfb\xcb\xe3\x0d\x3d\x71\x4d\xd7\x48\x5b\x05\x69\xc2"
        "\x74\xc3\x02\x92\xc8\x0b\xec\x99\x87\xa8\xda\x1d\xc5\x89\xc8\x99\xd9"
        "\x99\x20\x27\x03\x85\x3c\x8b\x5e\xa0\xaf\x06\xe6\x4b\xca\x0d\x0e\xa4"
        "\x78\xc7\xf7\xbd\x25\x36\x1d\xfc\xf3\xe0\x16\xa9\x05\x4a\x1b\xb3\xd0"
        "\x70\xc5\xf2\xd4\xd1\x8a\x12\x0d\xa8\xab\xe9\xdb\x47\xab\x45\x09\xcb"
        "\x8f\xdf\x99\x82\x51\x61\xb4\x23\x40\x97\x15\xa0\xea\xf9\x7d\x50\x81"
        "\x65\xea\xac\x83\x1b\xe3\x2d\x1d\x6c\xcb\x17\x09\x5f\xde\xd3\xa1\xe3"
        "\xc8\x45\x2b\xd5\x66\x15\x0b\xc0\xb5\xcf\xa6\x02\xee\x53\x65\xfd\x0c"
        "\x62\x63\x0e\xeb\xc3\x7a\x8c\x54\x56\x11\x47\x4e\x8c\x27\x1d\x63\x4c"
        "\x1b\x67\xf0\xc4\xaf\xf1\x0a\x88\x7d\x35\x93\x1a\xef\xe0\xd8\x1c\xcd"
        "\x13\xbb\x2e\xf8\x20\xc7\x40\x86\x8d\xfe\x02\x9b\x8f\x8a\x69\xee\x76"
        "\x41\x8a\x6a\x32\xac\x6d\x82\x2e\x6e\x0f\xa5\xdb\xa8\x7b\xe7\xe7\x73"
        "\xda\xb4\xf9\x53\x0f\xd1\x56\xd2\xb8\x88\xf5\xcf\xaf\xe5\xde\x2f\x93"
        "\xe8\x69\x7e\x94\x62\x6a\x10\x71\x83\xfb\x4d\xd2\x71\x70\x91\xc8\x9f"
        "\x1f\x6f\x2b\x78\xfb\x81\x66\xf6\x74\xbb\xfa\x6d\x3e\x69\x2c\x99\xe5"
        "\xfb\x57\xb0\x0c\xa3\x05\xe1\x15\xa7\xeb\x58\x6f\xa2\x53\x60\xa8\x0e"
        "\xbd\x5e\xbd\xa4\x85\xb3\xc2\xb7\xca\xc6\xc4\x0d\xaa\x31\x41\xea\x88"
        "\x49\x51\x8c\xdd\x6c\x8e\x21\x97\x66\x60\x66\xa1\x57\xa1\xb2\x95\x31"
        "\xc4\x31\x5e\xe0\x55\x7c\xdb\x14\x98\x75\x92\x3f\xe6\x1b\x2c\x56\x44"
        "\x6e\x77\xd5\x03\x60\xb1\x49\x11\xff\x38\x2e\xa2\x41\x70\x6b\x49\x8c"
        "\x6f\x70\x9b\xf9\xa2\x4f\x7e\xe8\x15\x16\x79\x05\xd1\xdd\xb9\x41\x08"
        "\x8d\x3a\x6e\x88\xcc\x27\x89\x9d\x3a\x75\x84\x2c\x53\x48\x21\xba\x83"
        "\xd9\x8d\x10\x8e\x16\x69\x84\x8e\xcd\xcc\x97\xad\x24\x99\xc2\x2c\xb8"
        "\x13\x83\xba\xc9\x96\xe2\x8b\x6d\x31\x5b\x48\xf6\x02\xfc\x70\xec\xf8"
        "\xce\xc9\xfb\xde\xb0\xb2\xe3\x9d\x0b\x50\x77\x22\x2d\x4f\x93\xcd\x9b"
        "\x07\xfe\x4e\xd2\x4d\xc0\x2f\x41\x9c\x7e\x1a\x78\xc6\xb4\xde\x56\xcb"
        "\x24\x17\xca\xaf\xb9\xd8\xfe\x06\x7a\xca\x36\xb9\x73\x5f\xb3\xe7\xc8"
        "\xed\x0b\xd4\x61\x0a\x74\xaa\xda\xc5\x74\xa2\x5b\x2d\x0b\x9a\x60\x8c"
        "\x82\x76\x5f\x5f\xb8\xcd\xae\xff\xa7\x53\x4d\x6c\xf3\xb0\x0c\xbd\xcc"
        "\xdb\xac\x26\x16\x97\xde\xe2\x38\x01\xf2\x2a\xbf\x9b\xe8\x89\xc4\xec"
        "\xac\x9a\x53\xf7\xa8\x3a\x09\x02\x9b\x78\xe3\xa1\xb5\x10\xf7\x61\x2f"
        "\xd7\x22\x41\x72\xa4\x16\xc8\x0d\x24\x29\xe1\xe6\x4b\xca\x2a\x55\x10"
        "\x4e\x65\xa4\x90\xf1\x5c\x50\x45\x39\x57\x79\xdc\x66\x70\x94\xd8\x29"
        "\x75\xc4\xec\xe2\x66\x91\xf1\xdc\xbf\x3c\x17\xc9\xd5\x45\xff\x08\x78"
        "\x22\x16\xb0\x2e\xfd\x03\x00\xc2\xf0\x76\x75\x56\x4c\x0c\xd9\xc4\xf8"
        "\x77\xdc\x27\x05\x6d\x58\x3e\x66\xf8\xc5\x0f\x5c\x76\x1e\xd5\xf3\x44"
        "\x58\x52\x7d\xd8\x6b\xef\x27\xc7\x44\x1b\x80\x3b\x79\x95\xdf\x4b\x0a"
        "\x13\x79\xd3\xf6\x31\xa6\x44\x4e\x27\x03\x0e\x5d\xc6\x74\x6f\x24\x40"
        "\xc0\x64\xec\xb1\x3e\x1c\x50\xd0\x58\xda\xda\x3c\x25\xec\x90\x7f\x51"
        "\xef\x31\x7f\xad\xa9\xac\x8b\x90\xb7\x4d\x0f\x19\x66\xc7\xef\x45\xbd"
        "\x83\xe0\xd6\xa4\x89\x9a\x8d\x2a\x49\x51\x59\x43\xb1\x0c\xe9\x16\x1e"
        "\xfc\xbb\x22\x8f\x6a\x62\x60\x1a\x3a\x1a\xce\x9c\xdd\xb0\x61\x61\x71"
        "\xaf\x51\x35\x37\x7a\xd0\xe2\x5d\xe4\x4d\x6b\x1a\x82\xb9\x8a\x88\x4d"
        "\xdd\xf9\xcb\x8a\x30\xb0\x77\x99\x2e\x2a\x71\xaf\xbd\x91\x1a\x86\x24"
        "\x07\x0f\xcb\xb6\x70\x00\x1c\x3a\x26\xc5\xb6\x9a\x87\x5a\xa1\xd0\x6c"
        "\xbd\xe5\x35\xa4\x4b\x2a\xf9\xd1\x19\xd9\x0e\xf7\xd3\x57\x17\x82\xe5"
        "\xb4\xed\x21\xe1\xf6\xab\xd6\x98\x8c\x05\x67\x59\xe3\x40\x7b\x2a\x0e"
        "\x9c\x59\x51\xb0\x82\x4a\xf2\x70\x88\x0c\x10\x55\xc1\xff\xc3\x7d\x64"
        "\xe2\xa4\x38\x5d\x19\xe7\x2b\xff\x2a\x17\x87\x0c\xc5\xd0\xef\x28\x3b"
        "\x93\x85\x35\x6f\xdd\xb3\x64\x62\x4d\x50\x04\xb7\xe8\x44\x71\x77\x04"
        "\xf9\x88\x0d\x25\xe9\xf8\x70\x3f\x2b\x1c\x0f\x5a\x52\xa3\xbc\xe5\x67"
        "\xfd\x59\xf2\xcf\xf1\xc5\xc7\xe1\xb9\x59\x6d\x1e\x1a\xd4\xdc\x7a\x78"
        "\xf8\x1a\x0a\x48\x9e\x2f\xfc\xd2\xf9\x86\x06\x08\x84\xca\x21\xbd\xb7"
        "\x98\x35\x11\x39\x56\x98\x48\x9c\xef\xda\x99\x40\x22\xf7\xd2\x50\x7a"
        "\xbc\x9b\x79\x85\x27\xd0\x5b\x37\xeb\x84\x30\x1f\xab\x9d\xc2\x94\xdf"
        "\x03\x38\x43\x7f\xe6\xd7\x4f\xcd\x01\x22\x96\x9c\x88\xd6\x63\xe9\xe7"
        "\x0d\x01\xc9\xec\xbb\x03\x9f\x5f\x07\x03\x92\x61\xd0\xec\x7b\x72\xe2"
        "\x46\x85\x58\x5d\x04\xee\x8f\xb4\x62\x5b\xd5\x51\x75\x6b\xc1\xf0\x77"
        "\xdb\x33\xdf\x03\x04\x12\x7d\x07\xf7\xa6\x7a\x23\x2e\x05\x73\x53\x1f"
        "\x30\x68\x66\xfd\xe6\x78\xa6\x79\x96\x9e\x17\x6a\x7d\x86\x8d\xf8\x36"
        "\xd6\xeb\xad\xd6\x06\xe8\x22\x49\x8a\xba\x92\x51\xa1\x86\xa8\x73\x1e"
        "\x2c\xed\x27\xd1\x22\x66\xa2\xbf\x86\xf8\x2f\xd9\x1c\xea\x22\xc6\x3b"
        "\xbd\xb2\xf3\x9b\xab\x2d\x65\x49\xf8\x3f\xec\x2f\x47\xef\x15\xdc\x34"
        "\x82\x47\x34\x17\x24\x24\xa5\x20\x7c\x23\x6d\x9d\xd7\x37\x5f\x23\x35"
        "\x32\x90\xa3\xe0\xb0\x67\x54\x1e\xb0\x37\xd5\x53\xe8\x72\xf7\x05\xbf"
        "\x19\x76\xbe\x37\x61\x08\x72\xff\x4b\xd7\x15\xf1\x63\x83\x98\x69\x20"
        "\x3f\x03\x8b\xa8\x9e\xcc\x9a\x26\x4f\x23\x7d\x3e\x31\x74\xe5\x2e\x8a"
        "\x7e\xc5\x66\x17\xf8\xd2\xac\x13\xab\xe3\xae\x7e\x6c\x80\x79\x6d\x6c"
        "\xd5\x49\x5f\x44\x9f\x17\x0c\x63\x42\x8d\x5f\x2f\x7e\x49\xb6\x04\x23"
        "\x49\x89\x12\xd1\x76\x6e\x62\x1d\xe2\xef\xe2\x11\x62\x38\xa8\x01\x4e"
        "\x7d\xbc\x5e\x69\xfb\x9c\x27\xa7\x43\xc4\x49\x29\x97\x87\xc5\xc7\x01"
        "\x38\x41\x9e\x3b\x44\xf6\x34\xc6\xeb\xd7\x16\xdb\xf4\xdb\x54\x3b\x54"
        "\xd6\x35\xc9\x0d\x07\x3b\x3f\x18\xf4\xe7\x4e\x9c\x75\x4a\xbf\x71\xa3"
        "\x89\x8a\xd4\x80\x61\x13\x4c\x55\x28\xd2\x80\x15\x12\xd9\x57\x72\x2e"
        "\x94\x2b\x03\x37\xde\xdf\x4e\xa3\xf3\x88\x26\xcb\x13\x60\x85\x21\xfd"
        "\xcc\xbc\xf8\x1d\x4a\xf5\x91\x0d\x41\x85\xe4\xd5\xee\x5d\x5d\x32\x82"
        "\xd1\x64\x16\xf7\x28\x60\x2c\xd4\x56\x73\xd0\xb1\x4d\x5c\xa9\x38\xdd"
        "\x80\x8d\x08\x61\xec\xf0\x02\x80\x70\xe7\x59\xa1\x88\x6e\x20\x59\x41"
        "\x0b\xa0\x0f\xd8\xe9\x17\x48\xe7\x03\x82\xc8\x3a\x0d\x40\xba\x9f\x0c"
        "\xe4\xfa\xe1\x62\x42\x96\xd3\x63\xb2\x96\xa9\x92\xa5\xe7\x02\x15\x93"
        "\x35\x4f\xca\xca\xa5\x66\x01\xdc\x79\x51\x08\x41\x11\xce\xa8\x9b\x50"
        "\xe9\x12\x47\xd8\x10\x70\x00\x45\x56\x62\x59\xfb\xa5\x51\xa4\x79\x5f"
        "\xcb\x15\x9c\x18\xae\x06\x26\x7d\x66\xcb\x4d\x8c\xdb\x8b\xc6\x95\xb1"
        "\xd4\x71\x36\xef\x24\x09\x27\x6d\x12\x6f\x60\x13\x60\x10\xb8\xd6\x86"
        "\x53\x00\x49\x8a\x5b\x27\x24\xd2\x34\x31\xb5\x9a\xc3\x04\x7f\x26\xe1"
        "\xd7\xad\xec\x60\x21\x7a\x25\x4b\x62\x54\x66\xe6\x0b\xeb\x45\xcd\xea"
        "\x46\xee\xfc\x8a\x86\x0a\xf6\x79\x4b\x00\xaa\xb0\x26\xf0\x7a\x94\xb9"
        "\xc7\x00\x22\x57\x95\xb2\x14\x4e\x9b\xc8\x51\x8f\xd3\x0f\xe5\x9c\xda"
        "\x84\xd3\x07\xc2\x94\x0d\x44\xc4\xe2\x16\xa4\x05\x35\xab\x5c\xf9\xc8"
        "\x3c\xd1\x27\xc4\x5a\xfa\x53\x6e\x4d\xfb\x22\xfa\xd1\xad\x53\xdc\x99"
        "\xff\xef\x62\xee\xbc\x0f\xfe\xf9\x40\xb5\x1c\x06\xce\x4b\xa3\x04\x08"
        "\xd5\x1b\x89\xfa\x40\xe0\x92\x1a\xe4\xa4\x6f\xcb\xe3\xf0\x27\x49\xed"
        "\x85\x70\xc3\x1e\xfa\xba\xc2\xfc\xc0\xd1\xe5\xb2\xf7\xd3\xb5\x07\x3d"
        "\xcb\x10\x41\x6a\xbd\xc1\x42\x78\xeb\x31\xd7\xd1\x7c\xbb\x4d\x23\x5d"
        "\x53\x89\xa7\x06\x7f\x63\x3b\x76\xed\x76\xd6\xe8\x6a\x75\xa6\xb7\x85"
        "\x85\x8b\x73\x77\x01\x59\x00\x50\xea\x3f\x8f\xe0\x69\x90\x94\xd9\x1c"
        "\x7c\x58\x99\x54\x84\x38\xb7\xa3\x63\x21\xc4\x26\x6e\xff\xf5\x7a\xbe"
        "\xb6\x8c\xd2\xce\xd0\x40\x49\x1c\x30\x79\x29\x95\xb9\x57\x44\x40\x25"
        "\x8c\x30\x5f\x94\x57\x9a\x35\x6d\x6c\x7b\xa7\x81\x0e\x23\xbf\xdd\xb9"
        "\xd5\x7a\x91\xb2\x13\x92\xa6\xff\xa5\x71\x93\x96\x46\xf0\xb4\x98\x86"
        "\xed\xa7\x1f\xf9\xc1\x31\x7a\x0c\x45\x2b\x36\x75\xb3\x39\xc3\xb6\x88"
        "\xea\x4a\xad\x37\x37\x37\x6c\x89\xcf\xfb\xbd\x86\x25\x0e\x76\xee\x6b"
        "\xb7\xe0\x15\x4b\xad\x04\x49\x28\xee\x30\x2f\x35\x2f\xeb\x57\x92\x8d"
        "\x8c\x73\x13\xce\x3b\x44\x30\x80\xce\x14\x35\xbd\x64\x1c\x6f\x29\x3c"
        "\xf2\x91\x37\x49\x4f\xf3\x3c\xc3\x0d\x99\x1a\xc8\x4f\xbe\xbd\x2d\x6f"
        "\x36\x9e\xef\x0a\xb3\x3c\x0b\xb6\xa7\xf5\xfc\x71\x77\x8e\x0c\xbc\xd7"
        "\x35\x26\x97\xa6\xb3\x05\x38\x95\x81\x05\x7d\x1e\x3e\x10\xea\xdf\x48"
        "\xfe\x0a\xe1\x75\xd1\x56\xbc\x87\xf5\x38\xe0\xc3\xa2\x18\xb9\x35\x50"
        "\x29\xc4\x88\xb8\x05\x48\x57\x37\x47\x80\x43\x89\x3c\x82\xa7\x36\x68"
        "\x50\x18\x66\x6a\x3c\x3d\xd6\x54\x52\x43\xa4\x05\x65\xa8\xbf\x85\x01"
        "\x3c\xa1\x2c\x9a\x8f\xa5\x2e\x4e\xd6\x72\x98\xd4\xb4\x27\x6e\xc4\x02"
        "\x7b\x16\x98\xb5\xfd\xe5\x2f\xee\xae\x47\x72\x12\xb1\xcd\xa6\x8b\x01"
        "\x7d\xa8\x2c\xef\xc8\x55\xea\x04\x00\x0c\x5a\xa2\xa6\xfc\x07\x57\x66"
        "\xaf\xb9\x0d\x42\xb6\x2a\xe1\xd2\x8a\x50\xd2\x6a\xa1\x59\x67\x1c\x29"
        "\x3c\xd4\x17\x62\x17\x20\xd5\x43\xae\x27\x1b\xb4\x66\x09\x04\x22\x1f"
        "\x4f\xa9\xdd\x43\x49\xbc\x24\x4c\xe6\xa8\x87\x26\xcc\x95\xba\x7e\x3e"
        "\xec\xef\x84\x98\x4a\xc9\x73\x8c\xdb\xed\xc7\x87\x5f\xc6\x81\x9b\xc7"
        "\xf8\xea\x90\x04\x9a\x91\x32\x11\xda\x74\x75\x1c\x52\x3b\xab\x8e\x9c"
        "\x71\xde\x5e\x7b\x17\xfa\x90\x25\xb3\xb4\xc5\xe0\x0a\xa0\x21\x46\xb7"
        "\x97\xb3\xe0\x26\x3e\x9c\x58\x90\x91\x87\xea\xbc\x11\x65\x65\xfa\x85"
        "\x63\x16\x64\x6b\x7a\x05\x8d\x00\xc7\x8c\xbf\xfc\x9f\xfc\xab\x1d\x4f"
        "\xea\x5c\xe9\x52\x5e\x1a\x23\x17\xa1\xed\xc2\xe7\xb8\x66\x8b\x96\x42"
        "\xe2\x2c\x9f\xe2\xa7\x5e\xb6\x5e\x85\xfc\x9a\x36\xe5\x3e\x32\x42\x74"
        "\xfa\x12\x58\x7c\x3e\x22\xe5\x8f\x96\xdb\xd5\xba\x48\x75\x1f\x7b\xc9"
        "\x5e\x6d\x88\x6a\xce\xa9\x4e\x8c\xe3\xa3\x79\x0b\xc5\x0d\xaa\x6c\x90"
        "\x62\xa4\x86\xb3\x65\x5f\x37\xa8\x02\xa5\x1f\x3d\x05\x55\x0b\xae\x41"
        "\x11\x3b\x9b\x6d\x50\xab\xab\xfd\x9a\x7a\x77\xa0\xaa\xd0\xb1\x68\x04"
        "\xe3\x0d\x30\x7d\x5a\x6c\xb1\x12\xde\xd6\x90\x5f\x97\x21\x91\xc4\x86"
        "\xbc\x3f\xa5\xed\xc1\xad\x08\xe1\xd8\xb6\x13\x97\x6e\xb7\x3e\x71\x14"
        "\x27\xf2\x31\xf9\x73\x8e\xfb\x5d\x8e\xd8\x74\x30\xbe\x2a\x00\x6e\x9b"
        "\x8c\x77\x4b\x05\xd9\xed\x09\x40\xb8\x54\xde\xa0\x39\xf1\x7d\x7b\x24"
        "\x79\x50\xf9\xc7\x83\xd9\x9d\x8e\xdc\x7b\x81\xa4\xa3\x25\x2e\x0f\x03"
        "\x77\xa3\x92\xe7\xba\x0f\xef\xe1\x8b\xd0\x67\x86\x3d\xec\x98\x4f\x6c"
        "\x07\x42\x06\xc0\x7d\xc3\x26\xeb\x69\x1f\xb4\x9a\xa9\x83\x9b\x3f\xe6"
        "\x37\xa7\x4b\xcb\xf7\xbe\x7c\x9f\x48\x73\x92\x7e\xb6\x84\x31\xd4\x59"
        "\x49\x3e\xb3\x85\x97\xd1\x32\x9e\x80\x45\x1f\x70\xa9\xb8\x84\x5f\xbb"
        "\xb7\xde\x23\xa9\x96\xb1\x7a\x41\x39\x8a\x43\x47\xe6\xe9\xaa\xe2\x55"
        "\x86\x56\xe6\xb8\x4d\x1b\xa1\x49\x25\x17\xdc\x2e\x9e\x98\x7b\xd6\x44"
        "\x47\x2c\x54\x8e\x12\xd6\x93\xe5\x4a\xdc\x8e\x28\xc2\x58\x51\x01\x7d"
        "\xb9\x2a\x93\x27\x91\x73\xdf\x4a\xac\x06\x05\x11\xad\xd9\xad\x69\xca"
        "\xbc\x9b\x30\x96\x04\xe8\x72\x9d\x4b\xa0\xd0\xe8\x42\x64\xfd\xb4\x1f"
        "\xcd\x6e\x5a\x2d\xa8\x61\xd1\xaf\x37\x0f\x61\xf7\x73\x2b\xec\xb1\x61"
        "\x47\x49\xd0\x1c\x72\xcd\xc9\xe9\x0d\x84\x59\xc0\x9e\xb4\xb2\x26\x39"
        "\x5a\x9f\x94\x26\xb5\x3a\x30\x53\x2a\x97\x0b\xe1\x88\x5c\xaa\x49\xca"
        "\xce\x13\x77\xec\x6d\x04\x37\x44\x64\x80\xec\x7b\xe8\x86\x1d\xa8\xae"
        "\x52\xfe\x47\x83\x3c\x17\x94\x60\x06\x4d\x5e\x76\x6d\x5f\x57\x9a\xfd"
        "\x41\xbb\xc6\x22\x77\x71\xc2\xbe\x67\x27\x19\xe1\x1b\x4f\x8a\x32\x79"
        "\xeb\x4f\x5b\x83\x06\x83\x21\x4c\x51\x1e\xd7\x58\x61\xa8\x92\xf3\x14"
        "\xb2\x96\xde\x92\x27\xcd\x35\xf6\xf9\xdb\x05\x96\xe8\x15\x91\x11\x50"
        "\x2e\xc8\x44\xd1\x3c\xdd\xd7\x7e\x9b\xfe\x57\x07\x0d\xea\xfa\xf2\x12"
        "\x72\xe2\xa8\x4d\x96\xb2\xce\x5f\x62\x75\x1e\x16\x6d\x8a\x9a\x2d\x1f"
        "\xf8\xff\x34\x3b\xc4\x5e\x5d\x98\x3d\x1d\xa9\x85\x2a\x6b\xfe\x97\x5e"
        "\x38\xd9\x08\xba\x26\x0a\x40\xd0\x79\xae\x7d\xe6\xb9\x68\xc1\x2d\xc2"
        "\x38\xf3\x85\xd1\xa6\x79\xa0\x7c\xf7\xf7\xee\x3f\xd7\x51\x08\x42\xd8"
        "\xb6\x9e\x85\x6c\x23\x46\xbf\x76\x39\x77\x40\x1a\x11\xbb\x24\xae\x7b"
        "\x2f\xf0\xaf\x12\x00\x8b\x75\xc3\x3e\x18\xe4\xcf\x4a\x9b\xf8\x22\xc3"
        "\xe4\x11\x9a\xf6\xbe\x20\xd2\x9f\x4d\x4f\x13\x39\xf1\x85\xfc\x1b\x6b"
        "\x48\x89\x15\xc2\xa6\xa4\xda\x9f\xcb\xcf\x58\xbf\xfd\xa8\x55\x18\x0d"
        "\x04\xae\x28\x40\xc7\xce\xba\xb1\x0c\x2f\x64\x5c\x40\x2f\x2b\x01\x8b"
        "\xf5\x78\xc9\x4a\x13\xd4\x3f\xf6\xe5\x15\x17\x74\x1d\x9f\x5a\x90\xe6"
        "\x10\xfd\x51\x0e\xec\x7c\xde\x8c\x0c\xd0\x0e\x0e\x8a\xa7\x4a\x28\x5c"
        "\x55\x99\xb5\x11\xfb\xa0\x87\xa8\xfb\xc4\xea\xa9\xec\xb9\x60\x9c\xee"
        "\x11\x6c\x8e\x18\x90\x1d\xc4\x29\x80\x07\x8d\xe5\xbb\xbb\x1d\x7e\x9f"
        "\x55\x83\x71\xed\x48\x8c\x3f\x60\xf1\x3e\xdf\x84\x60\x43\x81\x48\x07"
        "\xab\x20\x4d\x1c\x04\x3c\xf5\x27\x28\xf2\x4e\x93\x91\x46\xa3\x6a\x86"
        "\x80\xec\xf3\x45\x3f\xd8\x6a\x4f\xc9\xa0\xd7\x45\x10\x4d\xa3\x4f\xd1"
        "\xb3\xac\xd3\x25\xc9\xbb\x2b\x1e\x59\x2a\xf8\xf7\xb4\xfc\x67\x15\xaf"
        "\xc3\x9c\x24\x63\x4a\xc7\xd6\x01\x2b\x24\xd8\xb9\x75\x0c\xf6\xcf\xff"
        "\xe4\x76\xc5\xa0\x09\x92\x11\x82\xd7\x3a\x2c\x40\x0d\xa5\xd1\xe1\xe1"
        "\x5d\xe2\x76\x20\x11\x8d\xb0\x47\xc8\xc2\xee\xac\xbb\x76\x9a\x7b\xd5"
        "\x56\x6d\x23\xb7\x40\x7d\x8f\xfd\x29\xbe\x0f\x11\x4d\xb0\x3b\x6a\xce"
        "\xeb\xd9\xa9\x34\x71\xbc\x42\x54\xe7\xe7\xaf\x95\x4a\x8b\xd4\x82\x65"
        "\x0b\xca\x99\xe7\x22\x91\x99\xea\xec\x06\xf4\x59\xe2\x2f\x53\xe2\xf2"
        "\x32\xa7\x35\xc7\x07\x79\x41\x45\x88\xe5\x44\x34\xc0\xd8\x3b\x8a\xdb"
        "\x31\x07\x9d\xa2\x52\x76\xb3\xdd\x91\xdb\x26\x7b\x19\x00\xe6\xbb\xeb"
        "\xfb\x60\xce\x52\x61\x4f\xc3\x0c\x4a\x4c\xe7\x3a\x79\x6f\xdf\x3a\xdf"
        "\x59\x8a\x54\xc9\xc4\xa2\xc3\x5d\xe7\xd1\x78\x17\x37\xb8\x72\xd6\xc6"
        "\xe5\xf6\xae\xaf\x20\x41\x3f\xca\x78\x63\xbd\xa6\xbd\xc7\x15\x0f\xe5"
        "\xb5\x8a\x81\xdd\xe0\x1b\x36\x12\x5b\x53\xd8\xde\xac\xe3\xbc\xa4\xa7"
        "\x01\x35\x82\x93\xa6\x6b\xc4\xb2\x8e\xf4\x6f\xac\x2f\x66\x27\xf2\x4c"
        "\xf1\xc8\xfc\xed\x4c\x4a\xe0\x3d\x19\x26\x15\xeb\x17\x49\x07\xcf\xb5"
        "\xcb\x68\xb2\xcf\xfb\x5e\x58\x42\xc6\xd4\x5d\x01\x39\xee\xe2\x04\x57"
        "\xea\x1c\x32\xe5\xe8\x76\x81\x21\x20\x37\xaa\xbe\x17\xec\x6b\x0b\xea"
        "\x88\xf7\xcc\x19\x6d\xbf\x7b\x0f\x29\xfa\x97\x68\x4c\x7c\x6f\xd5\xea"
        "\xa2\x1d\xbf\x34\x60\x11\x1f\x68\x94\xbd\x32\xc2\xb4\x01\x1f\x9d\x1f"
        "\xe8\x12\x87\x25\xcc\x85\x2c\x5e\x94\xfd\x88\xc4\xec\x2f\x0a\x4c\xe4"
        "\x76\x2e\x2c\x49\x72\xe6\x52\x1b\x41\x6c\xbf\xe6\x7f\x0d\xce\x24\x93"
        "\x8f\xa8\x70\x4b\x9a\x74\xf4\x56\xf9\x60\x90\x47\x33\x5f\x67\xce\xc0"
        "\x7c\xba\x70\x39\x64\x19\x88\x87\x2a\xc3\x58\xfc\x9c\xba\xe6\xf1\x68"
        "\x5f\x56\xed\xf4\x3d\x40\xf1\x81\x5f\x99\xa1\x68\xe2\x3b\x07\x2c\x3a"
        "\xed\x31\x93\x12\x66\x90\x8e\x97\xad\xdb\x76\x1e\x9e\xdc\xe4\xf8\x56"
        "\xe2\xb9\x80\xa1\xf2\xaf\x9e\xd6\x46\x3b\xd2\xe3\x55\xe4\xb8\x68\x4f"
        "\xa1\x00\x2f\x2e\x69\x8f\x72\x1c\x1d\xe4\x79\xce\x30\x45\xbc\x21\xfe"
        "\x06\xac\xc4\x69\x61\x2d\x70\xa4\x26\xb8\x92\xe8\xa8\x48\xbd\x8d\xd8"
        "\x30\xc9\x5e\xc1\xd4\xc5\x30\x4e\x87\x79\xf3\x32\x6e\x92\xf3\xb9\xf6"
        "\xb6\xee\xb1\x61\x20\xb3\x3b\xd2\xc1\x18\x9b\xb9\xd5\x8b\xbc\xc0\xa8"
        "\x5e\xed\x68\x84\x96\x47\x0f\xcb\xe6\x06\xdf\x76\x87\x06\x5a\x73\x5d"
        "\xcd\x5b\x85\x76\xf8\x7b\x66\xe5\x27\x82\x8f\x7b\x80\xd9\x43\x66\x75"
        "\x44\x33\xa9\x72\x45\xda\xb5\x60\xa6\x81\x7a\x2b\x07\x1e\x98\x8c\x59"
        "\x06\x8d\x33\xc2\x41\x95\xb1\xca\xa3\xba\x41\x3b\xd2\xd2\xfd\x5c\xc8"
        "\x2f\xe2\xf5\x2a\x84\x29\xb2\xf6\xad\xa5\x0b\xd6\x11\x85\xb5\xcb\x71"
        "\x44\xb1\xcd\xb3\x43\x25\xb0\x25\x56\x49\xf9\xef\xd9\x9c\xf3\xa6\x70"
        "\x48\xc1\xf6\x02\x4a\x9d\x0a\x2a\xd5\xb7\x78\xb6\xb6\x7e\xf1\x44\xea"
        "\x34\x98\x3b\x82\xce\x71\xaf\x20\x97\x07\x06\x62\x28\x15\xbd\x4a\x45"
        "\xe0\x8d\x47\x21\x81\x2c\xdb\x77\x34\xe5\x3a\xf3\x78\x71\x11\x53\x15"
        "\x20\x9f\xd3\x7d\xf2\x67\xff\x01\x93\xac\x49\xdc\xd2\xb0\x27\xe1\xd6"
        "\x6e\x5f\xee\xd5\x67\x4e\x78\x3e\x2d\xf8\x66\x4b\xa1\x04\xe7\xaf\xf3"
        "\x9b\xbb\xcc\x27\xca\x78\xb6\x3b\x05\x20\x76\x7d\xf7\x4c\x7e\xa0\x8a"
        "\xe0\x3b\xea\x1b\x35\x5d\xe9\x54\x4b\x70\xc7\x6c\x01\xd8\x7a\x83\x29"
        "\x78\x48\xf1\x4c\x4f\xa5\x61\x31\x7c\x62\x43\x6e\x19\xb0\xe5\x5f\xe0"
        "\x4e\xe3\xa6\xef\x9c\xfa\x41\x4a\x4e\x6d\x35\xde\x2d\xcf\x61\x46\x1b"
        "\x45\x79\xfa\xfc\xae\x07\xee\xb5\x42\xa0\x52\x7a\x13\x5f\xe0\x85\x85"
        "\x4a\x21\x4b\x50\x55\x0f\x5f\x47\x83\x59\xdc\xa6\x5b\x7d\xb5\x0a\x94"
        "\x9f\x0d\x25\xfd\xda\xb5\x22\x23\xac\x3d\x91\x75\x31\x0a\x5a\x21\x46"
        "\x91\x7b\x46\x05\xc5\x1d\xb8\x61\x44\x62\x26\x22\x2d\x3c\xa1\x2c\x32"
        "\xc5\xcb\x3f\xc2\xb7\xb0\x41\xe1\x31\xca\xad\x8e\x2d\x9a\xcf\xeb\xa8"
        "\x13\x0f\x1f\x0e\x50\x99\x15\xca\x40\xb4\x74\xc0\xa1\x79\x38\x84\xc7"
        "\xcf\x9c\xf4\x94\x87\xa1\x27\xea\x14\x38\x4d\x51\xda\xf5\xcf\xd8\x8e"
        "\xe7\xc9\xe2\x16\x3a\xf4\x5c\x22\x16\x41\xc3\x63\x3f\xad\x4b\x0b\xb1"
        "\xa9\xb0\xa8\x64\x7c\x65\xda\xfb\x9d\x06\xdd\xf0\x05\x46\xd4\xf2\xaa"
        "\x57\x00\xf6\xdc\xdf\xb4\xef\x90\x78\x53\x82\x59\xdb\x8b\xf9\x36\x1f"
        "\x9a\x4d\xfe\x68\x7a\x7a\x2b\xec\x30\x9d\xf8\x2e\x53\x01\xdd\x70\x53"
        "\xbd\xc0\x7a\x2f\x42\x27\x34\xf7\x4b\xfb\x1d\xfa\xda\x4a\x75\x33\x4a"
        "\x68\x90\x12\xc6\x88\x5b\xbf\xea\x9b\x6d\xef\x36\xf9\xb1\xbd\xb8\x04"
        "\xa4\x69\xc3\x15\xdf\x8e\x5a\x85\x0f\x31\x62\x30\xcc\x57\xc6\x6f\xc1"
        "\x6a\x69\xca\x51\xe6\xf0\x0e\x43\x6c\x84\x8e\x7d\x5c\x4b\x43\xf8\xc6"
        "\x71\xdd\x7b\x54\xcb\x13\x19\xe0\x26\x32\x65\x8b\xc0\xe6\x50\x02\x38"
        "\xca\xe4\x4f\x40\x37\x80\xeb\x43\x99\xfb\x08\xa2\x1c\x13\x8f\x0e\xee"
        "\x15\xbd\x3d\x68\x35\xcf\xdd\x90\x8c\x40\x7b\xdb\xad\x08\x42\x1f\x6b"
        "\xc1\x0f\xb1\x4b\xb5\x6d\x9e\xca\x6c\x6a\xcb\x69\xa5\xfa\x69\x1c\xf5"
        "\x0b\xc2\xc9\xcd\x7e\xb9\x50\x27\xf3\x37\x1c\x1c\xd8\x1b\xee\x03\x4c"
        "\xe6\x01\x9d\x00\xdb\x52\x6a\x16\x6c\xed\x8b\x55\xec\x1a\x03\x53\x81"
        "\xf0\x23\xda\x06\x14\x30\x0f\x9d\xd0\x9a\x28\xd2\x8e\xfc\xff\xae\x7d"
        "\x43\x35\x81\x1b\x16\x17\x1c\xa8\xc3\x57\x9e\xc2\x96\x0d\x9f\x41\x1e"
        "\x69\x9c\x2a\x88\x98\xb5\x1f\x63\x41\xaf\xcd\x1d\x69\xcc\xe0\x0d\x4d"
        "\x47\x5b\x7a\x4b\x1f\xbd\xa1\xac\xce\x9a\x63\xa5\x20\xe7\x3b\xff\x76"
        "\xd4\x09\xf6\xa3\x82\xea\x8a\x01\x16\x2e\x1f\xf4\x9d\x8d\x59\xad\x7a"
        "\x45\x4b\x73\x54\xb1\x74\x69\x05\x88\x23\x44\x69\x76\x14\xf7\xe0\xba"
        "\xf1\xc7\xea\x4f\xe7\xbb\xdd\xeb\x75\x3d\x3f\x07\x2e\x73\x85\xf7\x01"
        "\xbc\x17\xb0\xa9\xcd\x8e\xbd\xe8\xff\x58\xb7\x34\x17\x87\xf9\xde\x3a"
        "\x31\x80\xe0\xf7\xfa\x19\x81\xd3\xf7\x20\x85\x77\x50\x6c\x2b\x43\x62"
        "\x29\x69\x6a\x5d\xfd\x30\xcd\xe1\xf4\x94\x65\x65\xeb\xbb\x39\x18\x60"
        "\x14\xe9\x1b\xa8\x4d\x31\x5f\xba\xe5\x0e\xe2\x59\x27\x7c\xb3\x78\xcc"
        "\xb0\x80\x1f\x55\x61\xae\xfd\xe2\x90\x18\x9b\x93\x83\x58\xfe\xab\x44"
        "\x4c\xfe\x11\x88\xd8\xfc\x3c\xdf\x69\x07\xc4\xa4\x53\xf5\xfa\x8f\x6f"
        "\x11\x23\x40\x2e\xad\xf8\xdb\xb8\x7a\x52\xca\xab\xb8\x89\xa1\x59\xb8"
        "\x00\x4e\x0c\x17\x3a\xb3\x97\x7e\xf6\x54\x7e\x37\x62\x52\x16\xea\xb1"
        "\x54\xd4\xb6\xe0\xa1\x2d\xcd\x7d\x76\x4c\x73\x11\xa0\x0d\x65\x53\xa9"
        "\x90\x50\x6a\x5e\x5f\xf1\xd6\x6b\x1b\x86\xa5\xbd\x71\x9b\x22\xfc\x89"
        "\x33\x65\x59\x2e\x58\xa7\x8d\x4e\xb3\x1e\x79\xe4\x54\x11\x53\xa4\x07"
        "\x3c\x21\xfd\x6e\xeb\xbe\xd8\x4c\x9f\xe3\xdb\x00\xe2\x34\x0c\xa2\xc4"
        "\xfe\x88\x3d\xac\x16\xcc\x4c\xce\x47\x9d\x86\x0c\xb9\x30\x07\x4a\x4f"
        "\x0f\xe9\xd3\x36\x58\xf7\xaa\x2b\x7b\x4e\xb3\xe6\xc3\x3a\x81\xed\x35"
        "\x1b\x6c\x35\x87\x8d\xfe\xc5\x43\xfb\x57\xfb\xd3\x50\x40\xf7\x0e\x1b"
        "\xaf\x4d\xea\x01\x90\xaa\x1e\x1d\x98\xc0\x49\xf1\xb1\xdf\x1c\xea\x73"
        "\x67\x96\x13\x4e\xb0\xaa\x7f\xc2\x2e\xd4\x4b\x61\x8c\x17\x7d\xd6\xbd"
        "\xee\x20\x10\x59\x4b\x7d\x73\x5d\x5e\xf0\x57\xa4\x12\x9e\x6a\x94\xbe"
        "\xdc\x54\x55\x9b\xfb\xf6\x5e\x21\xe2\xd2\x05\xb8\x22\xac\x36\x69\x5b"
        "\x87\x49\xe0\x67\xa4\x6a\x2c\x39\x04\x5a\x42\x2c\xc1\xb7\x8e\x79\x00"
        "\x28\x70\x6a\xbb\xc2\x51\xe5\xf7\x94\x4e\xd0\x9f\x37\xec\x1b\x13\x8a"
        "\xd2\xa6\x83\x21\xba\x3b\x2d\x08\x37\x2f\x76\x85\x0e\xbd\xc0\x4b\x75"
        "\x60\x1f\x66\xad\xb2\x3c\x76\x37\x04\xbd\x4b\x90\x1c\x96\x04\xf6\x24"
        "\xcc\x09\x2e\x33\x4a\xa0\x3f\x58\x64\x47\x57\xb7\x01\x47\xa2\x56\x22"
        "\x31\x3f\x18\x4f\xdb\xaa\xd0\xea\x91\x06\x5b\x62\x26\x5d\x4b\xce\x88"
        "\x79\x6e\xe0\xf7\x9e\xda\xcd\x83\x73\x5d\xa6\x11\x7e\x81\x4d\x6e\xb2"
        "\xf6\xd1\x30\xc6\x98\x23\x11\x32\x48\x1c\x3a\x6e\xf0\x16\xda\x20\x23"
        "\xc0\x8c\x49\xf0\xa6\x07\xdb\xb1\x68\x8d\xe6\x28\xe6\xe3\xd2\x0d\x7d"
        "\x17\x69\x9f\xa9\x99\xa2\x21\x38\xe9\x4b\xf0\x08\xfc\xdc\x0b\x0d\x5f"
        "\x7f\x1f\x87\xa4\xd1\x81\xc9\x38\x28\x7a\xfd\x30\x29\xf9\xbc\x9d\x03"
        "\x4c\x38\x14\xf9\xde\x2c\xc1\x5b\x51\x9a\x99\x19\x3c\xec\x6a\x7f\xa7"
        "\xd0\xce\xb9\x2b\xb0\x5e\xc7\x87\xe9\x78\xce\x97\x38\x0d\x59\x67\x09"
        "\x31\x08\x43\xe1\xe9\x13\x50\x9f\xaa\x6a\xd3\xc1\x36\x95\x0e\x21\x58"
        "\xa7\x78\x22\x27\x87\x6b\x71\x11\xea\xb7\x9d\xd2\xe9\x5d\x11\xbf\x45"
        "\x32\x46\x5a\xde\xbe\x3f\x5f\xd5\x36\xda\xb2\xc0\xa9\xea\x97\x86\x50"
        "\x16\x65\x34\x55\xa5\xe4\x71\x5a\xad\x8a\x51\x43\xe8\xd9\x68\x38\x47"
        "\x8f\xe5\x59\x6a\x14\x7a\x85\xfc\x7f\x8e\x2c\x0a\xd0\xb7\xcc\x13\x0d"
        "\xa4\x53\x79\x7a\x42\x3f\xb2\x7e\x74\x63\x73\xd8\xae\x78\x28\x1d\x48"
        "\xa5\x2e\x00\x5b\x42\x18\xa1\x61\xf3\x3e\xd6\xab\xa5\x05\xb2\xad\x43"
        "\x56\x2b\xc4\x13\x42\x2d\xf9\x66\xd4\x18\xbf\x24\x68\x82\x66\xf7\xb8"
        "\xd0\x2f\x22\xa8\x68\x76\x3d\x54\x43\x8f\xb1\x9f\xae\x24\x6e\xd4\xa6"
        "\x85\xb6\x4e\x4a\xfe\x62\x7f\x20\x79\x6d\xed\x16\x22\xa2\xc1\x7b\x1c"
        "\xab\xd2\x8a\xab\x18\x63\xcf\xc9\xbc\xea\x75\xf3\x5e\x3e\x22\xf2\x5b"
        "\xd7\x58\x0a\x40\x45\x24\x3e\x3d\x03\x7e\x77\x97\x7c\xba\x99\xb2\xae"
        "\xab\xe5\xe6\x16\xf6\x0d\xb3\xc1\x45\x4f\x9e\x9a\x99\x4d\x47\x69\x6c"
        "\x51\x56\x8a\xa2\x2b\x77\x3e\x3b\xd4\x4a\x77\x86\x63\x8f\x53\xea\xf6"
        "\xab\xd9\x86\xc8\x17\x57\x11\x15\x6c\xa4\x3f\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
        8192));
    NONFAILING(*(uint64_t*)0x20001640 = 0);
    NONFAILING(*(uint64_t*)0x20001648 = 0);
    NONFAILING(*(uint64_t*)0x20001650 = 0);
    NONFAILING(*(uint64_t*)0x20001658 = 0);
    NONFAILING(*(uint64_t*)0x20001660 = 0);
    NONFAILING(*(uint64_t*)0x20001668 = 0);
    NONFAILING(*(uint64_t*)0x20001670 = 0);
    NONFAILING(*(uint64_t*)0x20001678 = 0);
    NONFAILING(*(uint64_t*)0x20001680 = 0);
    NONFAILING(*(uint64_t*)0x20001688 = 0);
    NONFAILING(*(uint64_t*)0x20001690 = 0);
    NONFAILING(*(uint64_t*)0x20001698 = 0x200008c0);
    NONFAILING(*(uint32_t*)0x200008c0 = 0x90);
    NONFAILING(*(uint32_t*)0x200008c4 = 0);
    NONFAILING(*(uint64_t*)0x200008c8 = 0);
    NONFAILING(*(uint64_t*)0x200008d0 = 0);
    NONFAILING(*(uint64_t*)0x200008d8 = 0);
    NONFAILING(*(uint64_t*)0x200008e0 = 0);
    NONFAILING(*(uint64_t*)0x200008e8 = 0);
    NONFAILING(*(uint32_t*)0x200008f0 = 0);
    NONFAILING(*(uint32_t*)0x200008f4 = 0);
    NONFAILING(*(uint64_t*)0x200008f8 = 0);
    NONFAILING(*(uint64_t*)0x20000900 = 0);
    NONFAILING(*(uint64_t*)0x20000908 = 0);
    NONFAILING(*(uint64_t*)0x20000910 = 0);
    NONFAILING(*(uint64_t*)0x20000918 = 0);
    NONFAILING(*(uint64_t*)0x20000920 = 0xfffffffffffffffc);
    NONFAILING(*(uint32_t*)0x20000928 = 0);
    NONFAILING(*(uint32_t*)0x2000092c = 0);
    NONFAILING(*(uint32_t*)0x20000930 = 0);
    NONFAILING(*(uint32_t*)0x20000934 = 0);
    NONFAILING(*(uint32_t*)0x20000938 = 0);
    NONFAILING(*(uint32_t*)0x2000093c = 0);
    NONFAILING(*(uint32_t*)0x20000940 = 0);
    NONFAILING(*(uint32_t*)0x20000944 = 0);
    NONFAILING(*(uint32_t*)0x20000948 = 0);
    NONFAILING(*(uint32_t*)0x2000094c = 0);
    NONFAILING(*(uint64_t*)0x200016a0 = 0);
    NONFAILING(*(uint64_t*)0x200016a8 = 0);
    NONFAILING(*(uint64_t*)0x200016b0 = 0);
    NONFAILING(*(uint64_t*)0x200016b8 = 0);
    NONFAILING(syz_fuse_handle_req(r[0], 0x20007f80, 0x2000, 0x20001640));
    break;
  case 6:
    NONFAILING(memcpy(
        (void*)0x200021c0,
        "\xb0\xd9\xe6\x98\x55\x47\xcf\xd2\x61\x69\x6a\x1a\xe6\xab\xd0\xea\xca"
        "\x09\x66\x64\x74\x47\x15\x3b\x21\xd3\xe1\x9c\x76\x95\x95\x6a\x5e\x86"
        "\xe4\x89\x9f\xa4\xaf\x80\xc8\x0d\xa3\x79\x72\x37\x4e\xf0\x19\xa6\x3c"
        "\x92\x4c\xf3\x24\x11\x55\x68\x6e\x3b\xe3\x7f\x92\xfc\xeb\x7b\x7d\x11"
        "\x7b\x61\x24\xc1\xc6\x0f\xef\xd5\xf6\xa3\x29\xa1\xac\xc8\x22\x87\x44"
        "\x76\x36\x4c\x08\x7e\x94\x96\xec\x7e\xc3\x2a\x59\x24\x5c\x4f\x87\x8a"
        "\xa7\x76\x06\xa6\x0f\x2e\x39\x5f\xb8\xd2\x9e\xdb\x29\xd9\x37\x9f\xb0"
        "\xe5\xa6\xb3\x3e\xfd\x19\x95\xa6\x8c\xf7\xea\x1f\x37\xfb\x0f\x8c\xcf"
        "\x11\x88\x1e\x09\x43\x3a\x46\xdb\x70\xb1\xfe\xe0\xa7\xcd\x20\x3c\xaa"
        "\x6a\xb9\x35\x56\x6d\x9a\xa4\x3d\x65\xa6\x80\x3c\x96\xd7\xff\xf7\x46"
        "\x9a\x77\xc4\xca\xa5\xad\x34\x1c\xd5\x54\x6e\x2c\xee\x99\xe2\x87\xcc"
        "\xea\x4a\x5b\x70\x16\xbe\xab\x00\xc2\xaa\xb7\x18\xa5\x2f\x9f\x75\xe8"
        "\x92\xad\x60\xa5\x63\xbf\x97\x11\x64\xcf\xae\xfc\x0a\xed\xa6\x97\xb7"
        "\x80\xa6\x7d\x39\x9b\x04\xd0\x72\x6f\xcd\x5b\xfa\xbc\x82\x86\xbb\xe5"
        "\xd7\x15\x54\x04\x01\x0c\xa7\x83\x45\xce\x3a\x95\x79\x55\x64\x4c\x78"
        "\x3a\x85\x60\xe2\xcf\xf1\x6d\x0e\x88\xaf\xb4\xd1\x1f\x68\x49\xae\x31"
        "\xe2\x35\xb6\xa4\x6d\xc9\xee\xbd\x10\x13\x29\xea\x38\xe3\x0d\x42\x81"
        "\x78\xc4\xcf\x41\x02\x0e\xe8\xbf\x99\x36\xd0\x69\xa1\xfd\x35\x17\x80"
        "\x1e\xb8\xf0\x1e\xc5\x13\x38\xb0\xd0\xd7\xe8\xbf\x3f\xe0\x04\x69\x85"
        "\xa5\x49\x13\x13\x61\x35\x88\xe1\xd6\x44\xb0\xc3\x2b\x9c\xf8\x94\xc4"
        "\x64\x81\x81\xdb\xe3\xb7\x20\xf6\x3a\x66\x1a\x69\xa8\x3c\x7b\xe1\x42"
        "\x70\x5e\x9c\x70\x23\xbc\x33\xcd\xda\x7e\x84\x51\x9d\x71\xdf\xad\xba"
        "\xcc\xe5\x1b\xc9\x3e\xb2\x19\x34\x27\xf4\x82\x76\x01\xc1\x78\xde\x52"
        "\x95\x6a\x67\x66\x28\x35\x3e\x11\x82\x80\x7d\xc2\x8f\x07\xa6\x89\x30"
        "\x33\x18\xa6\x3f\xeb\x06\x0c\x3a\xeb\xbf\x2b\xd0\xab\x72\xd4\xdc\x04"
        "\x7f\x24\xfd\x48\x80\xde\x07\xbe\x84\xe8\xb8\x76\x73\xd0\xec\x07\x57"
        "\xfb\x08\x0f\x4f\xbc\x87\xb1\xe4\x13\x78\x52\x1d\x11\x2f\x01\x58\x7a"
        "\x60\x49\x0c\x57\xca\x79\xac\x6c\x9e\xeb\x3d\x96\xa5\xe0\x3e\xdc\x90"
        "\x14\x69\x18\x75\x0f\x29\x1a\x25\x80\x8f\x48\x5b\x5b\x9f\xbe\xff\x49"
        "\x0b\xcd\x08\xec\x97\x64\xf0\xd3\x6b\x24\x03\xf8\x8f\xa3\xec\xe7\x42"
        "\xf2\x4a\xa1\x2f\x83\x54\xc9\x8e\xc0\x90\x7c\x47\x3e\x75\x0b\x87\x6c"
        "\x24\xdc\x0c\xc7\x06\x97\x0b\x94\xbd\x4c\xcd\x5a\xb6\x74\xbf\xf7\x56"
        "\xa7\xc9\x72\xe3\xa1\x3c\x28\xe1\xc3\xe4\x74\x8a\x8b\x31\x14\x49\x08"
        "\x6c\x80\x23\xfb\x92\xbe\x7c\xa8\xaa\x5c\xc6\x22\x76\x7f\x76\x00\xc9"
        "\xf3\x8c\xa3\x95\x07\xee\x91\x0d\xa0\xf5\x64\x61\xff\xb0\xd7\xce\x43"
        "\x38\xb5\x54\x5e\xc1\x92\x3c\xe1\x08\xe0\x26\xd7\x73\x04\x83\x90\xea"
        "\x0b\x34\x53\xe3\x45\x4e\xd2\x06\xa1\x0a\x51\xe5\x73\x0f\xa1\xef\x29"
        "\x57\xac\x7f\x6f\x52\xbf\x33\xc9\x62\x45\xdc\x0a\x35\x26\x10\x84\x5c"
        "\x3a\x94\xf2\xbe\x43\xb1\xea\x67\x24\x41\x9b\xbf\x09\x4d\xb4\x9c\xf0"
        "\xa8\xfe\xd8\xa3\x4a\xa7\xc7\x3a\xfc\xfd\xfd\x8f\x3e\xf1\x2c\x67\x4f"
        "\x3f\x23\xed\x9c\xe3\x14\xa7\xb8\x03\x0d\x47\x6f\x46\xe1\xbe\xdd\x5a"
        "\x98\x15\x10\x7b\x0c\xab\x37\x2c\x1a\xd4\x6f\x43\x1d\xe9\xd7\x92\x16"
        "\x86\x34\x67\xc7\x22\x5b\x63\xdb\xbe\x4a\x18\x03\x03\xb8\xe3\x3f\x55"
        "\x94\xf5\xef\x98\x4f\xb4\x99\xe3\x67\xad\x77\x0d\xa8\x2e\xff\x47\x20"
        "\xca\x5a\x45\x89\x27\x0e\x09\xc2\xf3\xa1\xcb\xf3\xc5\x14\xd4\x15\x6d"
        "\xe3\xaf\x0a\x6e\x92\x17\xa1\x87\xaa\x6b\x1b\x49\x92\x06\x68\xb6\x8c"
        "\xf0\x26\x67\x76\x84\xf1\x81\xb7\x28\xa2\x17\x49\x31\x89\xd1\x7b\x9d"
        "\x2a\xd0\xdc\xcf\x71\xbe\xaf\xb0\xc4\x5d\xc1\xb5\xec\x64\xd5\x64\x5a"
        "\x16\x3f\xdb\xd6\xb2\x4f\x39\x32\xcf\x69\x7c\x2b\x0b\x31\xae\x4e\xe4"
        "\x0c\x3d\xf2\x92\xc8\xed\xb9\x39\x2a\x31\x17\xab\xfa\x8b\xd4\x7b\x02"
        "\xd5\x9a\x0f\xe8\x63\x41\x83\x0a\x62\x04\x42\xdc\x9b\x85\x11\xb9\x9d"
        "\x34\xa5\xc3\xdd\x0d\x76\x63\x5c\x49\x7f\x00\x00\x00\xa9\xbb\x28\xfe"
        "\xb3\xf9\xf1\x64\xf6\x6e\x38\x0a\xe9\xaf\x4d\xd3\x5d\x38\xde\xe3\xf1"
        "\x37\x3f\x6b\x19\xa5\x22\x29\xd4\xc6\x98\x5c\x5d\x28\xed\x17\x2e\x49"
        "\x6f\x73\x45\xc3\x96\x2b\x70\x29\x48\x28\xaa\x21\x65\x52\x60\xc7\xfe"
        "\x26\x31\xdf\xaf\xe7\xfa\x6b\xf3\xd7\xf4\x92\xc1\xf4\xc0\x73\x07\x4b"
        "\x07\x60\x19\x27\x03\xfe\x7e\x50\xf5\x7e\xef\x89\xdf\xa5\x7d\x2f\x00"
        "\x17\xcc\xe2\xeb\xfa\x90\xfc\xd5\x9d\xfa\x82\x29\x0f\x02\x04\xa0\xd1"
        "\xc8\x9f\x68\x8f\xbc\xa5\xd2\x64\x9c\x37\x29\x6b\x98\x6d\x1f\x49\x68"
        "\x8a\xd2\x06\x72\x18\xcd\x77\x28\xeb\x0d\x37\xa8\x40\xc0\xd4\x3f\x33"
        "\x26\xd6\x94\x30\x48\x52\xdf\xb4\x35\xc8\x7d\xd0\x72\xea\x11\x1c\x95"
        "\x4b\xeb\x6d\x8e\x56\x4b\x8d\x15\x57\x96\x72\x73\x45\x9a\x16\xb7\x73"
        "\x13\xa2\x0b\x7b\xef\xd6\x0e\x92\xe7\x29\xfb\x92\xa9\x7a\x96\x29\x46"
        "\x17\xd6\x3c\x7b\xbb\xaf\x55\x55\x90\x02\x3a\x51\xc9\x56\x7c\x4a\x74"
        "\x84\x31\x65\x5b\x66\xfb\xab\x94\xd1\x8d\x69\xc5\x36\xd8\x3a\x9b\xe5"
        "\x49\xfd\x10\x5e\xb7\xcc\xe5\x48\xdc\x17\x18\x5a\x9e\x44\x2d\x03\xfe"
        "\x56\x9e\x29\xd0\x78\xe0\x89\xc2\x7f\x6e\x8b\xae\x01\x78\x91\xd8\xc0"
        "\x35\x3f\x3a\x81\x29\xda\xd0\x1a\xd0\x09\x49\xe5\xff\x84\x1b\x9e\xca"
        "\x3b\xdb\xdb\xb5\x48\x6a\xf9\xc4\x3b\xfe\xf8\x55\x40\xdd\x5b\xda\x75"
        "\xb0\xb4\xe7\x16\x75\x6b\x44\xa0\x54\x3d\x98\x25\x50\xb4\x90\xac\x35"
        "\x37\x00\x80\xe5\xb9\xfa\x8c\x6f\xd9\x1f\xf6\xed\x5a\x1a\xa7\xbe\x89"
        "\x90\x63\x12\xe7\x8f\x0e\xd2\xdf\xf7\x5b\x85\x7c\xcc\x28\x13\x56\x4c"
        "\x99\xd9\x66\xba\x32\x55\xe3\xf2\x5f\x96\x6d\x19\xe0\x8c\x25\xed\x81"
        "\xc0\x4a\x95\x45\x30\xd7\x9b\x31\xfc\xad\x7e\xde\x64\xa4\xf4\xc3\xe3"
        "\x82\xb3\x07\x8d\xd0\x58\x64\xdb\xb1\x50\xd4\x1a\x14\x96\x46\xc3\x93"
        "\x10\x52\x0c\x03\x6f\x15\x5c\xb5\x1a\x17\x74\x86\xe8\x64\xae\x70\x22"
        "\x48\xcd\x8f\x98\x3e\x8f\xc2\x26\x95\xf4\xa5\xd8\x68\x88\xfb\x8d\x29"
        "\x40\x83\x17\x88\x63\xc5\x8f\xaa\xfe\x2f\x29\x88\xfa\x7a\x02\xde\xda"
        "\xce\x76\x7d\xca\xc6\x07\xda\x12\x4a\xca\x68\x51\x26\x9f\x6a\x2e\x78"
        "\xfa\xb0\xba\xa3\x28\x33\xbc\xfd\x83\x90\x4a\x5a\x1c\x23\x9b\x06\x72"
        "\x82\x8d\xf4\x58\xfc\x31\xef\x71\xa8\xa6\xa2\xd6\xa8\xe6\xe2\xa8\x2e"
        "\xfd\xeb\x84\xba\xc9\xd3\x16\x77\x4f\x44\xcd\xa5\x4a\xc5\xac\xa4\x87"
        "\xf0\xd7\x56\x51\x73\x90\x29\xba\x4c\x51\xea\x29\xd9\xd1\x54\x61\x49"
        "\x7f\xe4\xef\xfe\xde\xea\x8f\xbc\x7e\xa6\x6e\xa3\xfb\x3e\x5f\xf1\x51"
        "\x1a\x74\x0e\xaa\x1f\xc4\x96\x04\xf5\xea\x4c\xdd\x62\x7d\xd0\xee\xa3"
        "\x62\x69\xed\x12\x47\x8d\x17\x3f\x2c\x28\xb9\x9b\xfb\xeb\xc4\x79\x10"
        "\x77\xbb\x0a\xe2\xea\xfb\xd7\x28\xf4\xeb\xd9\x94\x21\xff\xde\x84\xcc"
        "\xff\xf4\xbf\x5c\x39\x1e\x65\x8c\x88\xb2\x83\x83\x2f\xc6\x1a\x78\x4d"
        "\xbb\xd2\xe4\x50\x6a\x7f\x28\x40\x2a\x3e\x7a\x5f\x50\x1f\xf8\x3e\x93"
        "\xa4\xea\x1f\x5c\xde\x8d\x34\xc4\x1f\x13\xdb\xc8\x4e\xd7\xea\xb8\x59"
        "\x0e\xf3\xdc\x4f\xb5\x7a\x79\xca\x2d\x12\x18\xd2\x40\x45\x76\xf5\xaa"
        "\x8e\x7b\x45\xe4\xf8\x02\xd7\x50\x75\x8d\x1f\xc0\x8e\x48\x7e\xd5\x74"
        "\x20\xc6\x1d\x85\x16\x2e\x18\xa2\xcb\x13\x23\xa6\xef\x35\x6b\xe6\x87"
        "\xb9\x3c\x58\xb4\x83\xe5\xee\x9f\xac\x03\xcf\xfb\x51\x99\xe2\x91\x9b"
        "\x7f\xa0\xdb\x19\x01\xef\x73\x72\x7f\x6a\x14\xd1\xdc\xf9\xa6\xdc\x47"
        "\x46\x72\xd9\xa6\xb0\x5f\xdb\xfd\xbe\x58\xcf\x7d\x80\xf2\xb8\xcc\x4e"
        "\xc4\x62\x42\x29\x21\x7a\x01\x62\x5c\xb9\xc3\x38\x22\x93\x54\x71\xfe"
        "\x79\x8a\x00\xdc\x51\x3c\x47\x5b\x12\x66\xfc\x40\xb9\xec\xd0\x27\x93"
        "\x5e\xfe\x6a\x3d\x7a\x6e\x23\xd3\x35\xe2\x7a\x30\x41\xb0\x0d\xd0\x1c"
        "\xf9\xd4\x3a\x80\x01\x18\x3c\x58\x13\xfb\xf0\xe2\x27\x2c\xa3\xbb\x57"
        "\x4c\xc5\x08\xe0\x38\x89\x89\xcd\xdd\x2f\x85\x32\x26\x5f\x8d\x2e\xa5"
        "\x6f\x48\xb2\xca\x29\x60\xe7\xb5\x83\x5a\x2c\xb8\xf2\x9a\x14\x94\xf2"
        "\xf0\x01\x7e\x8a\x51\x75\xaa\xd8\xa0\x86\xc3\x9a\xc9\x60\x3a\x5f\xae"
        "\xa6\xcf\x0e\x90\x65\x82\x03\x65\x11\xa4\x51\x4e\xbe\x0b\xa2\xcf\xc0"
        "\xb8\xb4\x96\x20\x4e\x62\xd5\x68\x1e\x85\x18\xef\x0f\x04\x07\x0e\xb4"
        "\xfe\xe9\x8b\x73\x9a\x77\xb3\x84\x79\xaf\xc0\x11\x00\x4e\x57\xd0\x71"
        "\x54\x9b\x63\xb6\x6f\xac\x67\xd4\xe5\xd4\xd1\xa1\x63\xa3\x58\x5d\x85"
        "\xb9\x61\x5b\x3d\x3f\x7d\x7e\xa4\x79\x89\xe4\x6c\x5a\x68\xaf\x38\x08"
        "\xc9\x03\xb8\x7d\x1c\x84\x47\xf9\x2e\xf1\x01\xa5\x66\x3a\xcb\xb0\x17"
        "\x5e\x55\x6e\x54\x62\x02\xc4\x53\x43\xa1\xc6\xb3\x7e\x04\xa1\x70\x62"
        "\xf3\xe4\x7c\x8d\x69\xd5\x09\x87\x09\xc6\x2d\xa7\xe1\x2e\x05\xa9\x4c"
        "\x5d\xa2\x28\xf3\xbe\x25\xe6\xc4\x61\x6c\xc9\xf1\xc5\x4e\x82\x50\x0a"
        "\xde\x86\x88\xd8\x1d\xc6\x53\x6a\xea\x57\x46\xec\x79\xa5\xab\xdc\xd5"
        "\xc3\x09\x35\xfe\x0b\x7b\xc4\x41\xd5\x14\x44\xd6\x0f\x30\x69\x9a\xed"
        "\x9b\x39\x11\xb5\x08\xe3\xbf\x4a\x72\xa0\x11\xf3\x2b\xf2\x6a\xb1\xf8"
        "\x50\xb5\xd1\xbe\x10\x4b\x72\x58\x7c\xaf\x01\x63\x65\xb5\x21\xfc\xb8"
        "\x89\x3c\x37\xb0\x86\xdb\x5f\x32\xb3\xc0\xd8\xb4\x2f\x12\xe4\x47\xf8"
        "\x79\x85\xc0\x02\x0f\xf7\x05\x32\x7b\x30\xfe\xb3\xa8\xc9\xf0\x66\x08"
        "\x83\x1a\xbb\xcb\xdb\x3b\x9f\x83\xaa\xf5\xe8\x0d\x19\xae\x50\x38\x3e"
        "\x98\x35\x8b\x8d\x36\xd4\x26\xff\xa3\x71\x96\xa2\x68\x33\x19\x4c\xef"
        "\x84\x4f\xb9\x8c\x0a\x9b\x40\x37\xe6\xee\x74\xbb\x52\x78\xf2\x19\x56"
        "\x41\x16\x28\xb7\x9b\x53\x12\xae\x70\x3e\x29\xd0\x89\xbc\x59\x3a\xba"
        "\x6d\x2b\xc3\x58\xa1\x48\x41\x89\xd3\xc3\x59\x9d\xa0\x58\x62\xb5\x97"
        "\xa3\x1e\xee\xe4\xf0\xc3\x01\xae\x6b\x93\x01\x32\x27\x2d\x4c\x00\xa2"
        "\x88\xf1\x44\xe2\xbb\x96\xe3\x97\x19\x26\x2f\x94\x4a\x51\x5a\x27\x8f"
        "\xa5\x92\x19\x8d\x68\x3e\xcb\x12\x2a\x2e\x5a\x1f\xc2\x71\xe1\xf0\x25"
        "\xdc\x6d\xae\xa9\x9f\x82\xa8\x4a\xcd\x7f\xbc\xd8\x36\x5d\x74\xea\xa2"
        "\x4e\x34\xf3\x9e\x81\xdd\xe6\x75\x0d\xdf\x42\x3d\x12\x8c\x6c\x07\x67"
        "\x39\xf6\x28\x53\xeb\x41\x6d\x43\x9f\x55\x3d\xcd\xa6\xb5\xfd\x60\x60"
        "\xba\xb2\xa8\xe2\x01\xdb\x76\x16\xdb\xb8\xa6\xdf\x56\xb0\x0b\x83\x9c"
        "\xdd\x0e\xac\x91\x20\x1c\xb4\x9b\x43\x19\x7d\x59\x39\x9e\xcb\x11\x62"
        "\x58\x2c\xb3\x90\x16\xe0\xc9\xf3\x4b\x35\x7b\x50\x27\xc7\xf7\x4a\x1e"
        "\x33\x8b\x9e\x93\x6a\x4a\x13\x81\xc6\x07\x32\xd6\x2d\xb9\x12\xc1\x99"
        "\x34\xc0\xe1\xd2\x68\x0c\x38\xbe\x1f\x4b\x57\x92\x12\xa7\x34\x2e\xe0"
        "\x76\xa6\xed\xf0\xad\x56\x6c\xe0\x33\xb8\xc5\x05\x06\xed\xe9\xd1\x3a"
        "\x57\xd5\x8e\x9f\x89\x26\xb6\x4e\x2c\x47\x2c\xee\xef\x2d\x3b\xfa\x84"
        "\x78\x0e\x1c\x96\xbc\x90\xcd\x66\x97\x73\x1d\x1a\x2a\x9a\x2a\xbd\x43"
        "\xb7\x29\xcc\xab\x12\xc8\x0c\x04\x48\x85\xd3\x1b\xc0\x8a\x3a\xe3\x8b"
        "\x30\x17\x04\x63\xdf\x64\xe2\x0b\xe9\x0d\x23\x07\x44\x70\x67\xf3\x1b"
        "\x1a\xa6\x83\xff\x88\x41\x11\xc0\xba\x0d\x63\xc2\xea\xdc\xc4\x6d\x4e"
        "\x05\x5d\x5a\x63\x68\xd3\x85\xf3\x9c\x20\x35\xe4\x93\x33\xdc\xcd\xc2"
        "\x06\x58\x17\x93\x3d\x28\x50\xcb\x61\x82\xff\xcb\x74\x5d\xd5\x97\x5f"
        "\xd2\x44\x41\x93\x7e\x71\x24\x0c\xed\x26\xdd\x41\x91\x97\xb8\xb1\x2a"
        "\x1f\xcd\xd8\x6c\x28\x65\x4a\x40\xdd\xbd\x18\x4b\x07\x15\x45\xe9\x23"
        "\xec\x80\xf0\x57\x44\xec\xe7\xd3\x7d\x6a\x06\x55\x2c\xfb\x24\x52\xc2"
        "\x62\x7f\x05\xec\x83\xc8\x8f\xf4\x1b\x7c\x28\x09\xd2\x3b\x2c\x98\xec"
        "\x72\xe7\x96\xb5\x57\x4e\xc4\x95\xca\x49\xc3\xc9\xb6\xdc\xc6\xbf\xcf"
        "\x87\x3f\xf0\x14\xfd\xe0\xd1\x8f\x41\xce\x86\x86\x2e\xae\x50\xcf\x68"
        "\xe5\x86\xf6\x88\xea\xb0\x36\x8c\x27\x71\xe4\x07\x9a\x37\xef\x11\xcd"
        "\x14\xf9\x01\xb6\xe7\xad\xe2\x48\xee\x88\xe6\x45\x2e\x4b\xb8\xe9\x37"
        "\xc3\x36\xf1\x60\x91\xbf\x49\x97\xd2\x9e\x69\xbe\x55\xbc\xbf\xa7\xe1"
        "\x85\xc9\x2d\x0b\x4e\x8a\x8a\x1c\x03\x4d\x44\xe5\x77\x2b\x65\xec\x80"
        "\x60\xd7\x41\xd0\x57\x95\x44\xfc\x79\x7c\xbb\x16\x93\xb0\x5a\x2d\xcc"
        "\x3b\xbc\x5b\x47\xdc\x10\x7c\xb4\xce\x39\xeb\xdb\x9e\xdb\x46\x05\xbf"
        "\xc7\xcf\x9b\xae\x58\xc7\x72\xfb\xb9\x3a\x46\x61\xa0\x7a\xfb\xf4\x29"
        "\xef\x40\xa5\x27\x70\x1e\xe3\x79\xf3\xd4\x59\x52\x47\x39\x95\x50\x78"
        "\xea\x45\x95\x40\x52\xdd\x8f\xd7\x6b\x8f\x3a\x8c\x26\xa9\x5b\x94\x69"
        "\x16\x18\x07\x88\xd1\x66\xf8\xd9\x88\xbb\xbc\xb9\x39\xa0\x21\x2d\x38"
        "\xa8\x13\xcd\x14\x57\xd7\x0e\xc5\x64\x50\xdb\x75\xe4\xb0\x85\x9c\xa2"
        "\xed\x21\x7c\x43\x00\x29\x97\x72\x6d\x2a\xbd\xbb\xd3\xf9\x5a\x28\xa4"
        "\xb9\xd0\x18\x09\x7e\x74\x81\x31\x25\xd7\x92\x95\xfa\xbf\x15\xb1\xba"
        "\x00\x2e\x91\x30\x1a\xde\xe8\x51\x66\xfc\x6d\x4e\xe5\x40\xe9\xd6\x37"
        "\x6f\x1a\x31\x63\x35\x13\x26\xfa\xf2\x3f\x34\x65\x18\xeb\xcf\x64\x41"
        "\xad\x6e\xb4\xfe\xf4\x40\x1e\xe3\x1b\xae\xd6\xed\xbf\x25\xd7\xa3\xbb"
        "\xa9\x52\xc9\x95\xde\x28\x7e\xdd\x42\x24\xd1\x45\xc2\x4d\xdf\xd1\x13"
        "\xa9\x8a\x10\xdd\x6f\x8e\x8c\x39\xf8\xf9\x0b\x83\x22\x3c\xf7\x49\x0a"
        "\x53\x77\xd2\x35\x7a\x0e\x18\x82\x36\x9e\xaf\xcb\x16\x81\x6f\x4f\xbe"
        "\xc2\x4f\xbd\x79\x40\xc9\xda\xb1\xe4\xfa\x97\x63\x18\x03\xc9\xf8\x56"
        "\xcb\x73\x59\x07\xd8\x89\x6b\x72\xb6\x8b\x3d\x54\x4b\x53\x92\x2c\x95"
        "\xd8\x73\x7b\x7b\x93\x33\xa3\x8e\x5b\x02\x68\xcb\x51\x45\xc9\x37\xb3"
        "\x15\x33\xb0\xce\x66\x1e\xcc\x78\xe9\xa2\x0b\x80\xb8\x75\x08\x9b\x7d"
        "\x50\xa6\x8f\xd1\x6f\x9d\x0c\xd3\xa7\x2f\xce\xde\xca\x55\x56\x2c\x0d"
        "\x08\xb7\xac\x2c\xb4\x70\xf7\xb9\x72\x96\x4c\x7e\x43\x4f\x76\x07\xa6"
        "\x31\x22\x1d\x50\x0d\xa4\x81\xb9\x64\xc2\x9e\x48\xea\x51\xa4\x84\x0c"
        "\x9d\x8b\x1e\xb7\x22\x7b\xdf\x52\x35\xcb\x43\xf7\x8f\x8a\x34\x84\x25"
        "\xe3\xff\xe2\x36\x51\x63\xec\x82\x4e\x31\x97\x0c\xc1\x30\x53\xbd\x90"
        "\x78\x3f\xc3\xb4\x2a\xb3\x59\x14\x64\x01\xa5\x54\x9b\x53\xd7\xa8\xee"
        "\xe2\x51\xf9\xf3\xb2\x19\xaa\x5c\xaf\x3b\x93\xcd\x20\x2a\x81\x7d\x54"
        "\xa8\x93\x27\x1f\x89\x12\x55\xb8\x92\xab\xf1\x5e\x85\xe5\xc4\x3c\x8d"
        "\xa7\xf7\xae\x92\xbb\x0c\x8b\x25\xf9\x60\x97\xf9\xda\x3f\x15\x2f\xe8"
        "\xa8\x90\x26\x47\x00\xe4\x7e\xab\xd9\x66\x77\x94\xa7\x41\x53\xcc\x55"
        "\xdb\x38\x7f\x2b\x59\x97\x97\x5f\x74\x25\x92\xf8\xf5\x09\xd3\xad\xa1"
        "\x58\x17\x0d\x9c\x7f\x3d\xd8\xce\x5f\xfc\x5e\x7e\x53\x56\x72\x84\x4d"
        "\x9e\x94\xde\xff\x47\xc6\x50\x08\x60\x34\xca\xff\x48\x9e\xf9\x52\xe3"
        "\x07\x01\x00\x80\x79\xbd\x90\x06\xa9\xa5\x9c\x0b\x69\x44\x55\x48\x14"
        "\x42\xbb\xbb\x6a\x04\x7a\x78\xd1\xda\x14\xec\x9f\x8f\x88\x36\x29\xc8"
        "\x72\x5f\xcb\x83\x6c\xd0\xdc\x21\x35\xa8\x4a\xed\x06\x82\xa3\x13\xe9"
        "\x08\xda\xc2\x92\x1e\xb4\x82\x84\xfe\x0c\x1b\x4e\x3e\xa2\x97\x27\x83"
        "\xa2\x4d\xb3\x25\xa9\x70\x86\x8a\x6a\xcc\xc3\x18\xb9\x00\xab\xbd\xe3"
        "\xb7\xad\xd6\xec\x89\xf8\x7f\x1f\x94\xaa\xc8\x5e\x10\xb9\xec\x53\xdd"
        "\xd3\x0f\x87\xd8\xf1\x69\xdd\x7f\xcd\x31\xc0\x6d\xe6\xd0\x30\x5c\xf5"
        "\x44\xc7\x79\xd5\x0a\xaa\xb5\x33\xbc\xe3\x82\x0f\xf6\x07\xc6\x94\x10"
        "\x6d\x07\x17\x2e\x43\x64\x40\x7f\xbe\xbf\x95\x0e\x6a\xb4\x5a\x5f\x7a"
        "\x55\xdb\x2a\x81\xae\x6f\xd3\xe3\xfc\xd0\x69\xcc\x75\x33\xf8\x96\xd5"
        "\x2c\xb7\x59\x8b\x70\x65\x88\x39\x69\x17\x48\x93\x4c\xa6\x62\x08\x3d"
        "\xb7\x3e\x69\x1c\xbd\x78\xc8\x5f\x1e\x54\x88\x3c\xb3\xaa\x57\x1e\xad"
        "\x5d\x29\xc2\x4b\x1e\x93\x79\x78\x6a\xef\x18\x31\x95\xd6\xd3\x83\xe7"
        "\x33\xc3\x8a\xe6\x27\xc7\xe5\x7d\x9f\x5e\xfb\xca\x68\x10\x3a\x36\xe2"
        "\xb5\x7f\x12\x00\xdc\xb3\xa2\xf0\xba\x2f\x61\xa0\x2b\xc2\x0b\x70\x78"
        "\x8d\xbc\x77\xf9\xad\x1d\xb3\x0f\x2d\x38\xd8\x85\xa9\x9a\x68\x8f\x30"
        "\x0b\x86\xdf\x42\xa5\x4b\x02\x53\x53\x89\x76\xb0\xb4\xf4\x55\x32\xb8"
        "\xa2\xcf\xf4\xb4\x64\x0f\xfd\x9a\x0e\xd2\x5d\xf6\xf2\x06\x5a\x6c\xa4"
        "\xd6\x8b\xe2\x01\x22\x1c\x9c\xf3\xa3\xa5\xf8\x08\xaf\x56\x40\x1d\x54"
        "\xb2\xe2\x8c\xa7\x8d\xb6\x17\x9b\x87\xc8\x05\x72\x19\xb2\xfc\x9e\xff"
        "\x0c\x0e\xbf\x6a\xb1\xe7\xc5\xd1\xdd\xfc\xf9\x59\xf1\x2d\x7b\x26\x50"
        "\x17\x5a\x3c\x32\xef\xf1\xc3\xd1\x65\x5d\xe2\x7c\x74\x43\x6a\xba\xb9"
        "\xfc\xa0\x88\x70\x7b\xfc\xea\x96\xf5\xd5\xcc\x3d\xbd\x8c\x5f\x01\xcb"
        "\x92\x50\x9a\x21\x04\xd8\x89\x80\x89\x13\x0f\x90\x18\xae\xb3\xf2\x49"
        "\x80\x65\xc1\x89\xc5\x8f\xe2\x83\xcf\x34\xc6\x3c\x3f\x8d\xd1\xaa\x6c"
        "\x1e\xd6\x94\x8f\x44\x4d\xb8\xbd\x34\xa1\x55\x75\x69\x00\x51\xaf\xb9"
        "\x50\x0b\x0a\x8e\x57\xb4\x5c\x17\xc4\x9d\x9c\x6d\x76\x4b\x88\x98\x59"
        "\xa0\xa3\xc1\xb7\x4e\x55\x85\x89\x8f\x72\x12\x19\xb4\xf3\x6d\x0c\x48"
        "\x61\xb7\x3e\x26\x4c\xc3\xe8\x15\xcb\x41\x98\x06\x13\xe6\xcf\xc6\x36"
        "\x01\xdd\x20\x39\x22\xbb\x94\x06\xa7\x21\xdb\x50\x72\xfc\x37\x5a\xc0"
        "\xf5\x0a\x37\xa4\xab\xcd\x11\x27\xd6\x7e\x6b\xee\x47\x23\x70\x9e\x2b"
        "\x85\x18\xe1\x71\x5a\x44\x17\x8d\x4f\x43\x67\xc1\x2d\x3a\xc1\xaf\x90"
        "\x15\x89\x31\xb9\xa9\x1c\xdf\xaa\x94\xa6\x55\xcb\x8b\xec\x73\x80\x8c"
        "\x50\x39\x2e\x69\xd9\xf6\x08\xf2\xa4\xe1\x7f\xfe\x4f\x0a\x14\xf7\xeb"
        "\xe1\xae\x5a\x41\xfe\x81\x9a\xf0\x49\x15\x29\x45\xa7\x43\x34\x3f\x64"
        "\x1a\x02\xeb\xed\xdc\x57\xb5\x5f\x39\x80\x1b\xe8\x7a\x1b\xb2\x7d\x17"
        "\xbc\x9d\x14\x69\x0f\x4e\xf2\x2e\x16\x33\x45\x0d\x9b\xac\xe8\xe5\x2b"
        "\xcb\x8f\x2c\x16\x46\xdb\x91\x52\x59\x9b\x87\xaa\xef\xd4\x0f\xed\x27"
        "\x8a\xd8\xc2\xbd\x19\xc5\xea\xf1\x19\x98\xe9\xb5\x45\x97\x4f\xf1\x20"
        "\x80\x14\xd5\x99\x2e\x20\x27\xc8\x22\x20\x3a\x92\x33\x65\x61\xd9\x9c"
        "\xb9\x06\xef\x2c\x56\x89\xa8\x9b\x83\x7b\xf1\xaa\xf3\xed\x63\xbd\x34"
        "\x64\x9e\xf6\x28\x3a\x0d\xac\xc8\x77\x20\xf4\x33\x49\x78\x87\x29\xa1"
        "\x22\x2d\x8b\xd7\xbf\x17\x21\x42\xe8\xf4\xf9\x91\xb1\x3d\xc5\x5e\xa2"
        "\x04\x56\xd6\x7d\x9b\xd1\x65\x7b\x90\x55\x06\x22\x87\xbc\x0b\x9c\x4f"
        "\xad\xa1\x36\xfc\xe6\xe2\xd2\x53\xc9\x26\xa1\x12\x5b\xee\x11\x51\x75"
        "\xa6\xd4\xc0\x1c\x0a\x8b\x87\x0a\x39\xa0\xb7\xb0\x7c\x2a\x55\xc2\xca"
        "\x25\x7d\x43\xa0\xbc\xf3\x60\x5d\xce\x38\x86\xa8\xa5\x85\x8c\x8d\x5b"
        "\xa4\x4d\x77\x00\xc6\xe3\x81\xcb\x38\xa6\x62\x15\x1f\x57\xfc\x0c\xcd"
        "\x23\x8e\x02\x9c\xa8\xc1\x4e\x75\x80\x68\x2a\x3c\xfe\x4f\x76\x5a\xa8"
        "\x53\x36\xb6\xce\xc7\xd5\xc0\x71\x03\xdf\x18\x62\xb3\xce\x1c\x14\xd3"
        "\x9e\x83\x9f\x14\x70\x5f\x21\xc6\xb2\x54\x85\xa2\xd2\x64\xbb\x2e\xec"
        "\x82\xce\x12\x19\x25\xb4\xdd\x5e\xfa\xa2\x10\x4c\xf4\x00\xfb\xf5\x22"
        "\x62\xbe\xf0\x68\xf3\x85\xfe\xa6\x22\x6b\x66\xfd\xaf\x6b\xa1\x9d\x49"
        "\x3a\xc8\x2a\x3a\xe8\xa4\xd2\x83\x59\xb4\x07\x2b\x81\x7a\xb6\x11\x0f"
        "\x43\x26\xcb\x65\x63\x11\xce\x99\x47\x59\xb5\x3d\x68\x28\x24\xf7\x7f"
        "\xd6\x97\xb0\x5c\x62\x33\x92\x41\x7b\x1e\xbf\x39\x9f\x41\x25\xcc\x8a"
        "\x83\x7f\xd8\xcd\x28\x4f\xe2\x99\xc8\xff\xa2\x42\xc1\x4e\x29\x96\xac"
        "\x26\x28\x6f\x5b\x86\x1c\x89\x20\x0c\xe1\xdb\xae\x2f\xea\x01\xf8\xa5"
        "\x9e\x0d\xc3\x80\xad\x8b\x54\xde\xcf\x47\xf6\xc5\x24\x02\xd8\xe6\x63"
        "\x7a\x8d\xd6\x60\x90\xaa\x61\x7d\x29\x44\x48\x50\xa2\xec\x7e\x94\x62"
        "\xdf\x8f\x25\x05\x30\xad\x1f\x12\xe0\x9b\xd0\x0d\x30\x32\x83\xa1\x96"
        "\xc2\x5e\x92\xf5\xbe\x60\x00\xf0\x0b\x8b\x4f\x70\x01\x88\x35\xe3\x1a"
        "\x7e\x81\x95\x07\x3e\x58\x60\xd7\xa9\x57\xd0\xdf\x49\x48\x47\x44\xdb"
        "\xb0\x2a\xd7\x07\x72\xd8\xfd\x36\xbf\xa5\xb2\xab\x76\xd6\x95\x22\x59"
        "\x91\x0b\xa4\xce\xdd\x40\xc8\x62\x5b\x4f\x2e\x61\x3d\xdc\x6f\xb0\x7c"
        "\x63\xe7\x3c\x5e\xef\xa3\x25\x33\x6d\x3a\x39\xd8\x57\xbd\x05\xc1\xbf"
        "\xa0\xb0\xab\x75\x93\xdc\x4e\x68\xe9\x23\xf2\xb1\x27\xeb\x46\x2d\x89"
        "\x31\x9a\x5c\x61\x5c\x8d\x76\x0b\x99\xbb\x51\xa0\x61\x7e\x32\xb4\x9e"
        "\x3f\x42\x68\x85\x0f\x48\x51\x89\x93\x96\xec\xf2\x4e\xe8\x99\x0a\x77"
        "\x40\x43\xbb\xcf\x1c\x68\xa3\x21\x8e\x6e\xab\xf2\x0d\x30\xd4\xf8\x0f"
        "\x90\xde\x16\x14\x7b\x8c\x57\x75\xdd\x7b\x98\x1a\x57\x6b\x14\x11\xd3"
        "\xd7\x8c\xf7\xe9\xdd\x7d\x1c\x0d\x5d\x2d\x9b\xd6\xf6\x3d\x56\x8f\xdb"
        "\xd9\x75\xad\xef\x00\x6e\x5c\x7e\x45\xb1\xe4\xcd\x0d\x51\x7a\x3f\xdd"
        "\x88\xb7\x7b\xc9\xf7\x0e\xc7\x79\xf4\x1c\xcf\x02\x38\x07\xac\xbf\x11"
        "\x6a\x88\xfe\xdc\x19\x97\x41\x9a\x76\x1f\x39\x16\x45\x39\xd7\x71\x14"
        "\x83\xa2\x56\xf9\x80\xca\x3d\x94\xe3\x8b\x1e\xe4\x0a\xa8\xdc\xaa\xea"
        "\xeb\x88\x2b\xa9\x81\x22\x57\x13\xff\x44\x59\x05\x72\xce\x29\xac\xdb"
        "\xa4\x6e\x27\x09\x15\xb2\x93\x4a\x69\x93\xb5\xf1\x93\x2e\x14\x0d\xa3"
        "\x31\xa0\xc4\x7d\xfc\x38\xea\x12\x14\x6e\xb5\x73\xe3\xa0\x1f\xc4\xdf"
        "\xac\x15\xa5\x68\x5d\x79\xfb\x85\xf2\xca\x41\x02\x58\x18\x0c\x91\x09"
        "\x3c\x64\x5e\x6d\xf4\x7e\x52\x24\x50\x6c\xa1\xa4\x07\x12\x9c\x8c\xbb"
        "\x08\xea\xf1\x76\xfe\xa7\x54\xa2\x5e\xc2\xfd\x03\xfd\xd5\x01\xa6\x7d"
        "\xb2\x01\x0d\x7a\xae\x19\x85\xf4\xee\x76\xb0\x4e\x56\x75\x63\x46\xf3"
        "\x6c\xb2\x66\x94\x08\xbe\xa3\x95\x62\x95\xc8\x1f\xc3\xef\x80\xce\x5c"
        "\x60\x8d\xb7\xe8\xed\x39\x85\x50\xd9\x0a\xf0\x94\x45\x84\x9f\x68\xd2"
        "\x4c\x00\xb4\xbe\xae\x34\xca\x57\xef\xab\x82\x7f\x91\x91\xcf\xe9\x68"
        "\x6f\xb2\xa4\xc8\x69\x00\x2e\x2a\xd9\x98\xaa\x85\x9d\x25\x7d\x2d\x37"
        "\x88\xb4\xeb\xf2\x8b\xed\xc9\x10\x0d\x58\x23\xbe\x39\xb5\x2e\xbe\x82"
        "\x61\xd7\x1c\xd0\x5a\x66\x6c\x0c\xe9\xe7\x4f\x2e\x08\xd6\x7c\xb5\x28"
        "\x81\x5b\x3b\xd5\x7d\xff\x3a\x49\xf3\xab\x2d\xdf\x46\x5e\xd3\x12\x22"
        "\x23\x38\x22\x45\x36\xce\xd5\xa9\xc3\x9b\x16\xb8\xed\xdd\xe9\x34\xd3"
        "\x47\x16\xe3\xd1\x18\x40\x04\xdd\xd5\x08\x57\xa8\x68\x89\x81\xa9\xd3"
        "\x3a\xce\x21\xf4\xa8\x23\x65\x19\x61\x28\xda\x06\x2b\x9b\x3e\x84\x32"
        "\xf8\x2e\x8f\x33\xeb\xf1\x60\xc2\x34\x6a\x8b\x5a\x8f\xa0\xf2\x94\xba"
        "\x2e\x86\x7f\x93\xc4\xf3\xfd\x0e\x14\xec\x54\x18\xee\x71\x77\x80\x54"
        "\x8a\x0e\x93\xcf\xac\xa6\xc9\x9d\x72\x70\x5f\xa3\xe2\xe8\x3d\x12\xc2"
        "\xb6\x5b\x76\x3f\x09\xc5\x8c\x82\x57\xd4\x0d\x38\x66\x65\xa4\x92\x4a"
        "\x1b\x09\xdb\xfd\x02\x4e\x18\x55\x2a\x93\xa5\x17\x82\x7f\x6a\x09\xe5"
        "\xd6\x13\xd8\xb7\xd1\x7f\xf9\xce\x3c\x35\xba\x8c\xfe\x80\x4c\x6b\xb8"
        "\xcc\x6a\xe9\x26\x39\xba\x6a\x1a\x6c\xf7\xb8\x21\xb0\xcf\x93\x4f\xac"
        "\x9c\x28\xef\x13\x38\x1c\x9b\xc3\x2c\x48\xbb\x6d\xf7\x2d\xc0\xfd\x58"
        "\x76\x71\x33\x22\xf8\xe7\x0c\x21\x15\xf5\x6c\x42\x1f\x41\x3c\x45\x7c"
        "\x45\xbd\x1a\x8e\xeb\x5c\xb2\x56\x16\x1f\xc5\x33\xb7\x38\x81\xde\x8a"
        "\xc5\xfe\xbf\x84\xad\xdd\x8e\x2a\x8e\x40\x0c\xc2\xfe\x7c\x1e\xb3\xcd"
        "\xcb\xb2\x61\xb0\x66\x46\x59\xba\xf5\x83\xf1\xc6\x6e\x4c\x92\x4b\xd1"
        "\x90\x24\x7d\xca\x43\x28\xf1\x47\x79\xc8\xa3\x3c\x70\x25\x75\xe8\x8d"
        "\xaf\x7b\xad\xff\xc1\xce\xe8\x2c\x14\xd7\xac\xe9\x8f\x79\xd4\xd3\x11"
        "\x51\x64\x23\x40\xff\xb4\x16\xfb\x1b\x2c\x97\x33\x82\xde\x37\x70\xaa"
        "\x41\x97\x4d\x67\xa6\x8d\xf0\x73\x6a\xdc\x68\xb7\x8f\xe3\x17\x07\x7c"
        "\x41\xc0\xa7\x83\x50\xbb\xf4\x98\xca\xe1\x2a\x9d\xc5\x18\x9f\xce\xad"
        "\x52\x70\x21\xf5\xb3\xfe\x09\x43\x48\xec\x5e\x68\x9c\x90\xc8\x70\x01"
        "\x1f\xc7\xa2\x76\x5b\xca\x8b\xd4\x46\x4e\x1a\x49\x8f\x6b\x14\xe6\x94"
        "\xe5\x0e\x6e\x75\x83\x62\xcb\xff\x51\x80\x80\xe9\xdd\xd5\x8c\xae\xa7"
        "\xfc\xae\x53\x45\x90\xb8\x3f\xab\x84\x3f\xa0\x49\x48\x22\x43\xe8\x06"
        "\x1d\xc0\x26\xed\x25\x87\xf2\xdd\x6e\x5c\xf9\x9a\x39\x14\x26\xb4\xc9"
        "\x32\xc7\xef\xdb\xf0\x7b\xbd\xc2\x32\x79\x89\xc1\x5d\x15\x2e\x01\x44"
        "\x2b\xef\x4d\x40\x7f\xda\xc0\xa2\xd5\xc9\xd5\x76\x76\xe2\x1f\x37\xfb"
        "\xff\xca\x13\x91\xe4\xf5\xeb\x09\xf7\x16\x9c\xe9\xf5\x21\x4f\xb6\xf3"
        "\x95\xca\xb1\x08\x04\x9c\xaa\x08\xcb\x7a\x65\xb9\xa0\x6a\x9e\x16\xe6"
        "\x49\x68\x93\x21\x19\x76\xfc\x52\x1a\x0f\x0f\x69\x22\x8b\x34\x07\xa1"
        "\x07\x50\x02\x3a\xba\x57\xdb\x9e\x3e\x94\xec\xc4\x12\x6f\x00\x50\xf9"
        "\x05\x5a\x7b\x6d\x75\xc6\xa8\x83\xd8\x48\xb1\x0c\xab\x22\xc9\x3d\x51"
        "\x8e\xde\xa5\x87\x97\x6b\x54\x86\x52\x92\x04\xe3\x71\x44\x65\xc6\x5f"
        "\xff\x1a\x74\x31\x98\x22\x72\x50\xb0\x49\xea\x19\x94\x59\xfb\x07\xcb"
        "\x11\xad\xa3\x37\x4e\xf5\xbb\xf8\x4a\xe6\x92\x91\x39\xea\x1f\xec\x84"
        "\x7b\x7b\x09\x9a\x2e\x7d\x9a\x3a\xf7\x9d\xf4\x4c\xc1\xfd\x3a\xe4\x04"
        "\x7c\x27\x19\xe4\x91\xc9\xb7\xf7\x20\x31\x20\x31\xb0\xb3\x73\x99\x89"
        "\x41\x24\xa5\x78\x7e\xb3\x73\xf3\x5d\xc7\xf8\xed\x84\x5e\x8c\x08\x8f"
        "\xb7\x4a\x27\xd0\x9e\x5d\x68\xf7\x9a\x8f\x05\xb2\xe2\x0b\x64\xc0\x9a"
        "\x99\x5d\x71\x88\xb0\x1b\x12\xcf\x4c\x76\xd4\x5b\x78\xcf\xa1\xd7\xad"
        "\xf9\x1b\xcf\x3a\xda\x7a\x9f\xe0\x4e\xe6\xdc\x4e\x24\x47\xa7\xf5\x61"
        "\x6f\xfc\x65\x62\x4c\x4f\x1e\xa0\xab\x70\x8b\x4b\x78\xb9\x8b\x6d\x0a"
        "\x0a\xb8\x71\xa4\x14\x8d\x13\x27\x07\x7a\x5b\x20\x91\x7f\xbd\x1c\x39"
        "\x4a\x17\x20\x3e\x25\x8a\x0d\x6e\x89\x62\x20\x81\xbf\x08\xf9\x06\x88"
        "\x73\x8e\x99\xee\x3d\xbf\x28\xa9\x88\x18\xe5\x1e\x85\x0a\x53\xc5\x4f"
        "\xa1\xb3\x82\xff\x19\xd1\x97\xad\x21\xae\x5e\xbb\x06\x4b\x7b\x47\x40"
        "\xbd\xa2\x14\x2f\x83\x75\xc5\xd2\xcc\xff\x91\x44\x3a\x84\xa3\x23\x49"
        "\xe1\x11\x7c\x91\x63\xe1\x08\xc8\xc4\x15\x8e\x2d\x51\x69\x3c\x58\x29"
        "\xad\x41\x34\xbb\xa6\x5d\x9e\x0c\xbe\xd4\x71\x8f\xa9\x70\x03\xe9\x74"
        "\x3c\x8e\x45\x03\x72\xa5\xe5\x70\xcd\xce\xfd\xb8\xe4\x46\xba\xab\x6e"
        "\x12\x6a\x68\x98\xbb\x40\xbb\x2a\x44\xdc\x32\x64\x21\x5e\x68\xe9\x30"
        "\xad\x6d\xc2\x82\x62\xd2\xb9\x0a\x5f\x6c\x86\x82\xfb\x3c\xab\x39\xa5"
        "\xd3\x65\x54\x2e\xbb\x3d\xb3\x46\x71\xf5\x04\x32\x82\x15\xd7\xb4\x99"
        "\x3d\x58\x1f\xc0\xa4\x16\xe6\xf5\xd2\x95\x38\xa2\x2f\x1b\xab\xf4\xae"
        "\x1c\xa7\xbe\x92\xad\x07\x15\xf7\xda\xb1\x97\x81\xf3\xa2\xb2\xe7\x10"
        "\x55\x8d\xf5\x3c\x69\xda\xb9\xd8\xe7\xeb\x45\x81\xae\xe8\xf0\x97\x8b"
        "\xab\x02\x5f\x17\x26\x38\xe3\x3c\x71\x17\x56\xdd\x6e\xec\xea\x1e\x51"
        "\x2b\xfb\xd0\xab\xb0\x67\x99\xae\x0b\xbf\x57\x20\x30\x86\x27\x01\xf0"
        "\x6c\xd5\xb7\xc3\x24\x95\x77\xf0\xfc\x94\x29\x03\x1d\x40\xd3\x02\xac"
        "\xf1\x89\xc3\xa5\x7e\xc6\xd3\x56\x90\xcd\x4a\x26\x9f\x80\x2e\xe7\x2c"
        "\x0f\x65\x6b\x08\x4b\x37\x59\x62\xbd\xae\xcd\xaf\x50\x4d\xfa\x2f\xb5"
        "\xca\x5f\x76\xb5\x78\xa3\x93\xf5\xc2\x50\xaf\xa2\xe7\xf5\x99\xbc\xc6"
        "\x1a\x7e\x44\xea\xf8\x58\xec\x3b\xb4\xeb\x36\x8d\x43\x05\x98\x34\x07"
        "\x3f\xcd\x1b\x73\xa7\xff\xcb\xfd\xe9\x14\xcc\x81\xc3\x1b\x1b\x45\x5c"
        "\xc5\x58\x49\x00\x35\x0c\x17\x3e\x76\x5d\xeb\x57\xd8\x11\x03\x25\x02"
        "\xea\x38\xe0\x5f\x12\x81\x0e\x08\xfc\x01\xd6\x9e\xbf\x35\x49\xf5\x66"
        "\xc6\xed\x08\xa6\x2d\xa7\x05\xce\x99\x45\x2c\x2b\x69\x7c\xda\xd5\x5e"
        "\xf7\x55\xf0\x9b\xcb\x13\xde\x65\x2d\x29\xaa\xd7\x10\xda\xe1\x33\xd1"
        "\x11\x28\xeb\xa7\xc1\xc0\x21\x25\x8b\xd6\xbb\x63\x32\x9d\x89\x08\x4d"
        "\xbc\xaf\xa8\xd0\x09\x8f\x30\x7a\x4f\xcd\x9d\x03\xb3\xdd\xbf\xe2\x43"
        "\xa4\xd8\xa0\x08\x79\x40\x99\x4e\xe2\xf9\x9e\x1b\xfc\x6f\xac\x4d\x16"
        "\x8e\xf0\xc8\xed\xda\x5d\x27\x7a\xd6\x22\xd0\x4a\xfe\xd5\x02\xd5\x28"
        "\x54\x62\xfa\x7f\x49\x46\x6a\x94\xf0\xe5\xb0\xdf\x1f\x92\x91\x63\x9c"
        "\x04\x9f\xee\x2e\x73\xa8\x55\x1d\x0c\x98\xc7\xe6\xd7\x7b\xae\xf8\xa0"
        "\x4e\xd5\xcc\x52\x53\x2a\x48\x59\xfb\x60\x55\xc4\x9c\x7a\xb2\x5b\xb2"
        "\xc8\x04\x59\x10\x1c\x52\x22\x4b\x25\x32\xa5\xf7\x1f\xbb\x4f\x69\xc1"
        "\xa6\xaf\x46\xba\xee\x28\x85\x7d\xaa\x65\xa4\x2e\x1e\x4c\xb2\x5c\x7b"
        "\x05\xe9\x00\x21\x26\x04\xee\x0b\xae\x4d\xbd\xba\xac\x9f\x67\x3d\xd1"
        "\x54\x2e\xa5\x4c\x65\x53\x78\x7e\xba\x71\x07\x6f\xd7\x5b\x26\xd7\x5a"
        "\x92\x4c\x3b\xa5\xd6\xc7\x81\x8a\x06\xe3\x1a\x54\xf5\x51\xb5\x09\x82"
        "\x1b\xee\x01\xd2\x19\x1b\x2a\x9d\x49\xca\x22\x3a\xf9\x8c\x94\x03\x3f"
        "\xd4\x82\xe5\x02\x0d\x70\x3d\x15\x53\x78\x48\x16\x5c\x62\x49\x78\x78"
        "\xdc\x8b\xbf\xd4\xa6\xbf\xeb\x3f\x53\x3c\x69\x76\x0d\x7b\xf9\x6b\x38"
        "\x3f\xff\x1d\xb5\xb0\x59\x41\x2f\xcf\x6a\x82\xd3\x85\x51\x0e\x9d\xda"
        "\x2f\xaf\x34\xa9\x7c\x32\x50\xca\x95\x8f\xbf\x30\xa0\xc0\xe2\x8c\x7b"
        "\xf2\xa1\x20\x76\x9f\x07\x47\x14\xc1\x09\x78\x0b\x16\x1e\x45\x57\x9d"
        "\x84\x60\x02\xe5\xe4\xab\xa4\xba\xac\x4a\xe2\xcf\xc9\x69\x31\x2e\xb0"
        "\xe8\x47\xfb\x28\x59\x60\xdf\x22\xb6\x82\x5b\x75\x1e\x63\x2a\x31\x90"
        "\x66\x08\xa9\x6b\x74\x4e\x79\xed\xa9\xc7\x99\x4a\x1d\x77\xb2\x51\x07"
        "\xb3\xea\x94\xc1\xc3\xac\x4b\x84\x39\xb8\x8d\x76\x02\x7f\x39\x41\xa6"
        "\xa8\x63\xcd\xa7\x03\xea\xab\x3c\xfb\xae\x48\x65\x1a\x2a\x70\xee\xc5"
        "\x8d\x81\xdc\x40\xfb\x62\xd4\xd0\x34\x16\xca\x30\xa3\x22\x1a\x67\x90"
        "\xf9\x89\xeb\xb8\xd1\x45\x06\xf3\x69\x94\x83\xf5\x5a\x1a\x1d\x5e\x0d"
        "\xe2\x9f\x98\x0c\xe0\x7d\x24\x1f\x92\xd6\x4f\xae\x26\x82\x57\x2a\x62"
        "\x66\xcb\x1f\xa1\xe0\x8e\x57\x95\xbe\x8d\x74\xb4\x61\x61\x1f\xcc\x55"
        "\x20\x66\xa2\xcc\x72\x20\xee\x21\x0b\x35\xca\x46\x63\x5a\xbd\xbd\x55"
        "\xb9\x75\x50\xbf\x81\xe6\xcb\x7b\xea\x43\xf9\xd8\x05\x59\x02\x4a\x7c"
        "\xe2\x68\x77\xa8\x52\xbd\x13\x24\x0a\xed\x35\x0f\x31\xda\xa6\x33\x71"
        "\xd1\xc8\xc6\x74\xc0\xdc\x4c\x2f\x45\xeb\x71\x70\xb5\xda\x97\x6d\x12"
        "\x38\x0a\xfd\x07\xc9\x7d\xdb\x04\x4b\xea\xaf\xde\x99\xdd\x9b\x0f\xd3"
        "\xe6\x47\xee\xab\x06\x67\x89\x29\xdc\x99\xb4\xc2\x1b\xd9\xa0\x41\x9e"
        "\xfc\x01\xa9\x1d\x77\x75\xa5\x06\x4a\x0a\xfe\xdf\xd1\x03\x26\xec\x85"
        "\x45\x89\x2e\x9c\x2b\x10\xd7\x0e\x37\x86\x20\x40\xc6\x1f\x59\xcd\xfa"
        "\xc3\xc6\xad\x28\x52\x03\x38\xf0\xfd\x98\xb5\x2d\x87\x47\x4e\xd1\xf2"
        "\x51\x88\x2e\x34\x41\x30\xb2\xab\x8a\x32\xd0\xe6\x06\xcc\x20\x82\x5a"
        "\x96\xe3\x64\xe3\x8e\x60\xaf\xff\x61\xf8\x9b\xd1\x1a\xda\x20\x41\xba"
        "\xe6\x41\xb2\xb0\xa0\xa2\x06\xa7\xab\xa7\xfb\x5f\xf3\x0a\xf2\x5d\xc9"
        "\x22\xb4\xfb\xb2\x62\xcb\xad\xd2\xa6\x36\xeb\xf3\x85\x06\x1c\x99\xb1"
        "\xd7\x64\x1d\xdb\x9d\x82\x25\x25\x86\xfa\xf7\x20\xf9\xf9\x08\x4b\xd2"
        "\xb6\x38\xbd\xa4\xa4\xa7\x63\xfc\x9b\x41\xce\xef\xfd\xfc\x4f\xa9\x7d"
        "\x8c\xaf\x24\x1b\x02\x35\x53\xf3\x10\x70\xe9\x27\x7c\x65\xba\x2f\xe9"
        "\xa7\x43\xb1\xc8\xfe\x17\x18\x0d\xdc\x5b\x9e\x8c\xec\x12\xa1\x78\xac"
        "\x7d\x3f\xf2\xfa\x24\x26\x15\xe9\xc8\x9d\xa0\x74\xdd\xef\x59\x23\x70"
        "\x81\xd1\x73\x25\xf6\x10\x77\xc0\xc4\x71\x2a\x07\x64\x5f\x80\xf3\x98"
        "\xc4\x49\x46\x81\xe6\xc8\x4c\x24\x8a\x6c\xc3\xcc\x03\x01\x15\x3d\x43"
        "\xda\xb9\x95\x04\xea\xe4\xd1\xd0\x56\x00\xf4\x32\xfa\x87\xdf\x6e\x29"
        "\xef\x11\xe4\x38\x75\x29\xa1\x83\xb5\x70\x9d\xf4\x97\x9d\xbf\xa2\x4f"
        "\x0f\x39\x16\xfd\x96\xc0\x8b\x02\x69\x93\x83\x77\xbb\x5d\xc3\xfb\x92"
        "\x44\x30\xc9\x82\xd9\x94\x87\xe4\x8a\x30\xf1\x58\x80\xc5\x3d\x0e\x7e"
        "\x53\x05\xf6\x7c\x93\xd4\xd7\xbd\x42\x0b\x36\x8f\x5d\x36\x7c\xf8\x4d"
        "\x24\xa1\x52\xc4\xc3\x01\x60\x52\x6b\x6d\xbf\x4b\xd9\xa8\xed\x96\x21"
        "\x61\xdd\xf8\x25\xed\x07\x6c\xc5\x1d\xa7\x50\x38\x55\x7b\xdd\x05\x26"
        "\x65\x8a\xfc\x5f\xfa\x83\x71\xcf\x10\xdd\xd6\xab\x48\x3b\x06\x1b\xb7"
        "\x29\x02\xd7\xb2\x34\xbe\x41\xcc\x35\xd0\x67\x7c\x59\x8d\xaf\x88\x0e"
        "\xff\x50\x51\xc6\xa3\x36\xcd\x42\x9c\x38\x4c\xff\xd3\xe4\x8e\xca\x0f"
        "\x7e\x01\xbc\xf6\x5c\x32\x1e\x66\x7b\xd5\x82\x74\x97\x60\xc9\xf6\xad"
        "\x67\x37\xeb\x20\xc9\x4a\x9b\x6d\x1d\x80\x5f\xae\xb4\xfd\x41\xfb\x2a"
        "\x4b\x7b\x13\xe5\xde\xc8\x47\xbc\x30\xf6\xc2\x2f\x85\x76\xfe\x59\x4a"
        "\xf1\x83\x32\x5c\x8f\xa8\x1b\x70\x03\xe5\xfc\xad\x57\x7d\x87\x66\x03"
        "\xed\xa6\xf1\x06\xfb\x45\xbe\x9e\x42\x1b\x9c\x8d\x6e\x2f\x7e\x21\xd4"
        "\x27\x1b\xdf\x04\x0f\x5a\x7c\xad\x86\xa9\x38\x19\xed\x69\xa4\xe1\xaf"
        "\x64\xc9\xdb\xa0\x39\xb5\x2a\x35\x2b\x14\xbe\x49\xeb\x6f\xd8\x9e\xef"
        "\x10\xba\x8c\xcf\x7c\x6e\x01\xa7\xdd\xb8\xba\x1a\xd7\xff\x14\x67\xf5"
        "\x0d\x22\x5d\x20\xea\xcb\xd0\xbc\xdd\x0f\xc7\xf4\x48\x83\x24\x37\xbc"
        "\x6f\x91\x5f\x0f\x6e\x4b\x05\x3c\xbe\x21\x9e\x04\x90\x8b\xc3\x45\xd8"
        "\xfb\x2f\x09\x41\x67\x42\xb2\x70\x9b\xde\x1b\x0a\x75\xa4\x25\x27\xff"
        "\xb5\xad\xca\x2f\x5e\x78\xc3\x7b\x2b\x0b\xaf\x5e\x47\xda\x52\x0b\x0e"
        "\x96\x07\xe4\x42\x30\xec\xe6\x3e\xc9\x44\x94\xd5\x7d\xdf\xa9\x7a\x31"
        "\x37\x3c\x99\x33\xe5\x1a\xc4\x37\xef\x6a\xaa\xd0\x6f\x0f\xe9\x2f\x6d"
        "\xba\x61\xf3\xd4\x4b\xe9\xec\xc8\x13\x84\xa2\x59\xcd\xe1\xbc\xe4\xc9"
        "\x3f\xb1\xfb\xdc\xf9\x73\x1d\xd4\x0f\xbc\xba\xa6\x96\xb7\x49\x72\x58"
        "\x70\x2e\x00\x1e\xef\xf7\x03\x39\x41\x9b\x17\x3d\x5b\xd9\x13\x79\x97"
        "\x4f\x6e\xdf\x96\xc8\xc5\xa9\x8f\x78\x10\xdd\x28\xd0\x69\xf9\xf4\x5e"
        "\xf6\xf8\x4e\xba\x1c\xca\xbb\xcc\xc2\x4c\x90\x74\x06\xea\x94\xda\xf7"
        "\xcd\x16\xa8\xb8\x57\x87\xc8\x15\x69\x0c\x31\xce\x63\x8f\x3a\x2b\x0b"
        "\xab\x51\xa2\x8c\x48\xca\x35\xbc\x9a\x91\xc5\x1a\x1a\x1d\x54\x99\x23"
        "\x0a\x7a\x0f\xf0\x75\xf8\x82\xf8\x13\x40\xd8\x21\xc0\x30\x1b\x6c\xe0"
        "\xc7\x7c\xd6\xb7\xfb\xd8\x41\x17\x48\xcd\x8c\x6a\xc6\x2a\x62\xd3\xc3"
        "\x15\x25\xa4\x55\x6c\x1c\xe3\xde\x96\x36\xdb\x2a\x9b\xa8\x73\x3a\x5d"
        "\x05\x84\xe2\x22\x92\x15\xd2\x34\x1b\x5d\x03\x60\xb9\x92\xca\xa5\x1d"
        "\x84\xbc\xb6\xe9\x7b\x31\x17\x08\x3d\xd4\x5f\xe1\xdf\x4a\x20\xc7\x2f"
        "\xbc\xcd\x00\x5f\x42\x5b\x74\xad\xf7\x7b\x4c\x44\xf9\x87\x89\x5d\x9d"
        "\x28\x57\x31\x80\xa0\xfb\x6d\x5a\x19\xea\xae\xfe\x6d\x81\xf0\x4f\xa1"
        "\xce\x21\x0a\x4d\xd6\xb3\x63\xa1\x9b\x8c\x40\x26\x1a\xae\xa8\x2c\x53"
        "\xc5\xbe\x21\x23\x64\xd7\x73\x44\xfd\x2d\x79\x28\x24\x74\x05\x66\xc2"
        "\x41\x91\x1f\x35\xe0\x81\x79\x4a\xff\x8f\x7c\xf0\x7d\x6f\x34\x80\xa8"
        "\xca\xa0\x03\x66\x49\xb9\xbf\xf6\x7c\xfc\x52\xdc\x08\x74\xaf\x6f\x60"
        "\x60\xdc\xf4\x1d\xc6\x3f\x30\x59\xb4\x1e\xa1\x3d\xa3\xe6\xd5\x72\x74"
        "\x1a\xc1\x3e\xf0\x73\x9e\x71\xf1\xcb\x7e\x2b\x95\x51\xd3\x40\xac\x29"
        "\x1d\x37\xc5\x83\x8b\x83\x46\x15\x5a\x72\xd5\x9e\x73\x56\x3b\x5a\x7e"
        "\x2e\x9a\x58\x45\xf1\xa3\x86\x9c\xf9\xf8\xcd\x1c\x64\x88\x72\x82\x52"
        "\x08\x74\x63\x6e\xa5\xe8\x2d\x70\xd4\xa6\x37\xf6\x54\x3b\x03\x6d\x3c"
        "\x44\x01\x4b\xa9\x0f\x38\x07\xad\xbe\x07\xc7\x8e\x47\x26\xd6\x5b\x4a"
        "\x5d\xbf\x62\x6c\x31\x95\xa8\x3a\x69\xca\x3b\x5b\x1d\x9d\xdf\x18\x41"
        "\x9a\x79\x36\xa3\xc4\x22\x25\x3d\x2e\xa2\x41\x63\x9a\x7f\xd7\x87\xd5"
        "\x72\xcf\xb4\x78\x00\x6a\x3c\x93\xb3\x4a\x04\x72\xe1\xb5\x0e\x45\xa8"
        "\x26\xc1\x00\xe5\xe7\x03\x2b\x73\x01\xa4\x60\x1d\xcf\x19\x3c\x55\xb4"
        "\x14\x58\xd9\x0c\x29\xfe\x0e\x38\x5b\x15\x44\x5a\x2e\x51\xa3\x0b\x8f"
        "\xdf\x11\x3a\x6d\x9e\xde\xe7\x5d\x9e\xa7\xab\x25\xbf\xc3\xfc\x96\xab"
        "\x0d\xb7\x9a\x9e\xca\xfa\xdf\x45\x03\xdc\x04\xcf\xc0\x72\x51\x24\x54"
        "\x7e\x47\xcd\x04\xf4\x02\xba\x13\xfb\x8c\xef\xee\x25\xb7\x7c\xa5\x2b"
        "\x39\x63\xde\x21\x8e\x1c\x2f\x72\xf8\x17\x06\xd0\xcf\x08\x60\x72\x10"
        "\x59\xf2\x9f\x4c\x47\x1b\xbd\x61\x5a\x14\xae\x38\x5e\x98\xd2\x74\xe0"
        "\x7f\x09\x58\x8f\xdf\xf8\x2d\x5a\x1d\x6f\xe1\x00\xb4\xad\x98\x4f\xb3"
        "\xc6\x14\xf7\x13\x09\x00\xd8\x08\x2d\xdd\x14\xf7\x17\x57\x9e\xde\x24"
        "\x51\x17\x54\xf1\x4b\x6e\x67\x01\xac\x4a\x1d\x53\x42\x6b\x30\xb1\x7b"
        "\x65\x6b\x20\x80\x41\x03\xf8\xba\x79\x08\x9a\xa6\x30\xdd\x1f\xc2\xf0"
        "\x31\x9e\x3c\x29\x18\x35\x61\x3d\x4e\xfc\x77\xa0\xf0\x49\x99\xf9\x66"
        "\x8a\xfe\x1d\x15\x65\xdb\xfb\x54\x3e\x32\x0d\xb1\x22\x22\x1e\xa3\x72"
        "\xf3\x16\x17\xe9\x35\x46\xff\xb5\x6c\x37\x2e\xca\x96\x49\xa8\x8b\x69"
        "\xe4\x26\xc1\x01\xd8\x80\xbc\xb6\x02\x49\xbd\x5e\xb7\x34\xa3\xe1\x02"
        "\xe4\x62\x44\xac\xfa\xf9\x7d\x7c\x6b\xd5\x0b\x34\x8e\x4e\x96\xd6\xc2"
        "\x7f\xdd\xbc\xd9\x26\xfe\x4b\xf9\x00\x6b\x6b\x8b\x7f\xa2\xdd\x51\x7a"
        "\x59\x69\xc5\xf6\xef\x08\x95\x45\x14\x85\xb1\xed\xcd\x68\xaf\xa8\x90"
        "\x72\x01\xa3\x50\x40\xd2\xfa\x45\x61\xfe\x60\x3e\xef\x65\xe1\x80\x53"
        "\x62\xf7\x33\xcc\xb6\xd3\x38\xb4\xa4\xe4\xbb\x4f\xf0\x88\xa2\x0d\xf1"
        "\x54\xdd\x8a\x28\x79\xa2\xf9\x35\x60\x40\x86\x76\x77\x83\x55\xa4\xfc"
        "\x5d\xba\x04\xda\x8e\xe9\x35\x19\x20\xf6\x84\x87\xc1\x1f\xa9\x2f\x94"
        "\x1a\xa7\xc8\x52\xb0\xe9\xb7\x4a\xa1\x81\x2f\x5c\xe1\x8a\xec\x98\x32"
        "\x01\xa3\x6d\x30\x02\x24\xf6\x5a\xd3\x46\x94\x56\x06\x1b\x70\xda\xe1"
        "\xd2\xfc\xf4\x79\x8c\x53\x00\x68\x84\x1d\x5a\x83\x2c\x98\xff\x69\x7e"
        "\x28\xb8\x61\x0d\xb0\x42\xeb\x64\x53\x88\x53\x91\x03\xb1\xcb\x90\x8e"
        "\x6f\x83\x31\x5f\xb1\x9a\xb8\x17\x5b\xb6\xab\x81\x7b\xa2\x52\x3a\x83"
        "\x2e\x21\x11\xdb\x9a\x0a\x00\xdf\x68\xe3\x4e\x4a\xe0\x9c\x72\xb6\x31"
        "\x2b\x0e\x89\xa1\x5c\x7a\x36\x6d\x29\xdd\xa6\x64\xed\x7d\xa0\x4c\x3e"
        "\xca\x38\x07\xba\x70\xd1\x40\xf8\x8c\xac\x84\x93\x17\xc7\xd2\xe5\x56"
        "\x21\x02\x89\x8d\x40\xa6\x9d\x21\x3f\x75\xcb\x0f\x66\x2c\x97\x11\x87"
        "\xea\x11\xd2\x19\x53\x31\xf0\xd2\xb8\x6f\x42\x48\x78\x8f\x99\x3f\xe5"
        "\xfb\x86\x8b\x7b\xe0\xee\x8c\x93\x20\xd7\xc7\xb5\xe8\x3f\x05\x49\x83"
        "\x10\x01\xa4\x2e\xc0\x2b\x63\xb2\xe2\xf3\x9e\xf2\x87\x47\x9f\x53\x6d"
        "\xb2\x97\x3f\xd2\xf2\x81\x36\x94\xc4\x38\x85\x35\xb0\xbe\x19\x59\x81"
        "\xbd\x9e\x8a\xe6\x16\xba\x46\x1a\x6a\xb3\x2a\x64\x75\xb1\x89\x87\xf5"
        "\xf5\x80\x51\x8b\xcc\xd9\xbf\xc9\x4f\x9c\x95\x3a\x8a\xd0\x5c\x61\xcd"
        "\xfb\x6b\xf2\x5f\xf0\xd3\x44\x63\x6b\xc4\x02\x14\x66\xd3\x59\x17\xcd"
        "\x72\x02\x04\x67\xfa\x5c\x0e\x76\x0d\x9e\x17\xdb\x6a\x98\x25\x8b\x62"
        "\x2d\xe1\xe8\x70\x0c\x07\xf3\xb7\xcd\x25\x6a\xe8\xd4\x4d\xe8\x74\xce"
        "\xe3\x8d\x0f\xf0\x05\x7b\x42\x25\x20\x00\xc2\x85\xbd\x8f\x76\x21\xf8"
        "\x9a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
        8192));
    NONFAILING(*(uint64_t*)0x200013c0 = 0);
    NONFAILING(*(uint64_t*)0x200013c8 = 0);
    NONFAILING(*(uint64_t*)0x200013d0 = 0);
    NONFAILING(*(uint64_t*)0x200013d8 = 0);
    NONFAILING(*(uint64_t*)0x200013e0 = 0);
    NONFAILING(*(uint64_t*)0x200013e8 = 0);
    NONFAILING(*(uint64_t*)0x200013f0 = 0);
    NONFAILING(*(uint64_t*)0x200013f8 = 0);
    NONFAILING(*(uint64_t*)0x20001400 = 0);
    NONFAILING(*(uint64_t*)0x20001408 = 0);
    NONFAILING(*(uint64_t*)0x20001410 = 0);
    NONFAILING(*(uint64_t*)0x20001418 = 0);
    NONFAILING(*(uint64_t*)0x20001420 = 0);
    NONFAILING(*(uint64_t*)0x20001428 = 0);
    NONFAILING(*(uint64_t*)0x20001430 = 0x200012c0);
    NONFAILING(*(uint32_t*)0x200012c0 = 0xa0);
    NONFAILING(*(uint32_t*)0x200012c4 = 0);
    NONFAILING(*(uint64_t*)0x200012c8 = 0);
    NONFAILING(*(uint64_t*)0x200012d0 = 2);
    NONFAILING(*(uint64_t*)0x200012d8 = 0);
    NONFAILING(*(uint64_t*)0x200012e0 = 0);
    NONFAILING(*(uint64_t*)0x200012e8 = 0);
    NONFAILING(*(uint32_t*)0x200012f0 = 0);
    NONFAILING(*(uint32_t*)0x200012f4 = 0);
    NONFAILING(*(uint64_t*)0x200012f8 = 0);
    NONFAILING(*(uint64_t*)0x20001300 = 0);
    NONFAILING(*(uint64_t*)0x20001308 = 0);
    NONFAILING(*(uint64_t*)0x20001310 = 0);
    NONFAILING(*(uint64_t*)0x20001318 = 0);
    NONFAILING(*(uint64_t*)0x20001320 = 0);
    NONFAILING(*(uint32_t*)0x20001328 = 0);
    NONFAILING(*(uint32_t*)0x2000132c = 0);
    NONFAILING(*(uint32_t*)0x20001330 = 0);
    NONFAILING(*(uint32_t*)0x20001334 = 0x8000);
    NONFAILING(*(uint32_t*)0x20001338 = 0);
    NONFAILING(*(uint32_t*)0x2000133c = 0);
    NONFAILING(*(uint32_t*)0x20001340 = 0);
    NONFAILING(*(uint32_t*)0x20001344 = 0);
    NONFAILING(*(uint32_t*)0x20001348 = 0);
    NONFAILING(*(uint32_t*)0x2000134c = 0);
    NONFAILING(*(uint64_t*)0x20001350 = 0);
    NONFAILING(*(uint32_t*)0x20001358 = 0);
    NONFAILING(*(uint32_t*)0x2000135c = 0);
    NONFAILING(*(uint64_t*)0x20001438 = 0);
    NONFAILING(syz_fuse_handle_req(r[0], 0x200021c0, 0x2000, 0x200013c0));
    break;
  case 7:
    NONFAILING(memcpy(
        (void*)0x200041c0,
        "\xb5\xe3\xe0\xb7\x35\x67\xf0\xc5\x60\x31\x5e\xbf\xc1\xce\xf4\xe6\x87"
        "\xad\x6d\xb7\x0f\xf0\x7c\xb4\x23\xf1\xb0\x9d\xc5\xd8\xf0\xf3\x11\x59"
        "\xdc\x07\xb8\x12\x04\x24\x83\xa6\x5d\x2d\x00\xcb\x80\xdc\xbf\xcd\x93"
        "\x9d\xc9\xf7\x25\x2e\xd9\xf1\x65\xf8\xcf\x94\xfb\xed\xfd\x17\xb5\xec"
        "\x47\xdf\x85\x9c\xce\xd3\x24\xfa\xf4\x94\xd7\x32\x53\xda\x09\xf5\x0c"
        "\xa8\x78\xa2\xf4\xb6\x51\x6a\xbd\x37\x2e\xa1\x2c\x2c\xb5\x49\x61\x51"
        "\x1a\xf3\x74\x23\xff\x6c\x8b\xef\x16\x36\xe3\x9d\xf2\x18\xb9\x9b\x95"
        "\x9b\xb7\xef\xf8\x3f\x10\x44\xdf\x4e\xa3\xc8\xdf\x5d\x58\x57\x27\xe6"
        "\x58\x25\x76\xbb\x55\x4d\x90\xed\x3f\xd9\xce\x47\xf0\x65\x69\x24\x99"
        "\x90\xdd\x29\x5c\xb0\xf5\x11\xda\x85\x45\x2e\x8e\x8d\xe0\x4a\xbc\xeb"
        "\x43\x6d\x05\x6f\xfd\x2b\xac\x74\xd5\x86\x49\x8a\x52\xf8\x34\x14\x8f"
        "\x65\xde\x29\xcc\xc0\x02\x1a\x68\x07\x85\x96\x2f\x37\x72\xb1\x2e\xb1"
        "\x1e\xa8\xd7\x8f\x45\x4f\xde\x70\x9b\xf6\x6e\xfa\x42\xb1\x28\x64\x2e"
        "\x70\x13\x06\x76\xd8\xf8\x79\x32\xc0\x40\xbf\xa3\x51\x04\x2c\x38\xd8"
        "\x3a\x30\x50\xa0\x89\x2d\xfb\xc2\x86\xf9\xfe\x97\x6e\x9b\x5c\x7c\x53"
        "\x32\x26\xf9\x17\x5a\x25\x54\xcf\xe9\x81\x50\xf3\x7d\xbf\x4f\x58\xb9"
        "\xfb\x67\xb5\x1c\xe0\x71\x28\xb2\x0b\x42\xa3\x35\x4a\xe7\x05\xf2\xba"
        "\x01\x40\xd4\xc7\xa4\xa8\xae\x4e\x4e\xa5\x93\x34\x7e\x2b\xa0\x17\x9c"
        "\x48\x09\xa7\x5c\xae\xbc\x85\xfb\xda\xd7\xbe\x8c\x5b\xda\xe2\xe4\x66"
        "\x1e\xb8\x51\x36\xdb\x96\x94\xcb\x9f\xb2\x5c\x23\xdd\x11\xb3\x00\x1a"
        "\x24\x2b\xba\x79\xe4\x70\xd7\xb2\xd5\xc4\xea\xed\x83\x57\xe3\x93\xde"
        "\x9e\x45\x1e\x30\xed\xd5\x76\x2e\xe4\xbd\x90\xe9\x5a\x90\x3c\xda\xaa"
        "\x50\x5e\x7f\xcb\x9d\xc0\xe3\x1b\xcd\x58\x1e\xde\x2c\xc0\x63\x8b\xb7"
        "\x3f\xab\x8e\xaa\x13\x53\x5e\xe0\x7c\xa3\xf2\x6e\x01\xab\x48\x7e\x01"
        "\xda\x69\xb1\x1f\xbf\xef\x9f\x17\x4a\xe9\x12\x2e\xbf\x6f\xb2\xe3\x90"
        "\xde\x6d\xb2\x0a\x12\xfe\x1e\xc8\x0b\x67\x66\xec\x2b\xb5\x4b\xbc\x28"
        "\x8d\x09\xa5\xf1\x58\x17\xb1\x59\x6d\xa1\x8f\x55\x1b\x54\x83\xe3\xb7"
        "\x78\xdd\xd8\x7d\x62\xa3\xb6\x10\x12\x36\x79\xf0\xa7\xa4\xb1\x08\x2b"
        "\x85\x3e\xda\x85\xa3\xb1\x03\xb3\xe3\x02\x3c\x83\x70\xde\xa3\xe1\x7e"
        "\x79\x10\x1e\x6a\xa5\xbe\xfa\x9d\x01\x26\xa4\x46\x98\x2a\x6d\xdd\x7b"
        "\x66\xe8\xe6\x42\x9d\x7c\x15\xae\xdd\x87\xa8\x28\xce\xe1\x29\x5b\xa9"
        "\xb9\xbd\x4d\xbe\xb7\xdd\x99\xa9\x32\x15\x63\x46\x5f\x58\xb0\x0e\x09"
        "\x8a\x4e\x4b\xec\xd1\x29\x51\xdd\x64\x87\xc0\xf4\xf0\x7c\xc3\x15\xf5"
        "\x32\xce\xbf\xe8\xd7\x1d\x4a\xd8\x20\xc4\x97\x8e\x5d\x88\xab\x81\x8e"
        "\xc8\x1b\x7c\x9d\x5f\x5f\x75\xb8\x98\x88\xee\xc9\x7b\xb1\xd7\x31\x43"
        "\x2d\x22\x7e\x54\x0e\xa9\x60\x39\xd4\x09\x65\xb4\xd8\xc0\xf2\x6a\x36"
        "\x81\x14\xf1\x1b\xab\x43\x2f\x98\x81\xc9\xaa\x71\x9a\xf1\x0e\xf2\x84"
        "\x5a\x52\x68\x10\xe0\x8b\x9a\x4f\x1f\xd7\xce\xea\xc5\x61\x48\x4f\xde"
        "\xcf\xd3\x04\xdc\xf9\x9d\x8c\x63\xf7\x8c\x25\xb1\x7c\xf5\xb7\x89\xb9"
        "\x91\x30\x10\x86\x7a\xa7\x4f\x4c\xdd\x93\x59\xde\xb5\xe1\x31\xe4\x4d"
        "\xd5\xff\x63\xa6\xb4\x96\x21\xf2\xf1\x54\xdf\x1e\xd6\x37\x12\xa6\x99"
        "\xe1\x49\x2b\xe9\x38\xb4\x2a\x4b\x7d\x55\xc8\xb7\x06\x1e\x29\x6e\xbb"
        "\x94\x19\xf9\xbc\x28\x3c\xb5\xa4\x71\x26\x3d\x24\xf1\xd3\x43\x7c\x22"
        "\xc8\xbd\xbd\x26\x20\x2a\x82\x14\x69\x6a\x5d\x5f\x49\xcd\x1b\x6d\x5d"
        "\x78\x15\x2b\x19\x5f\x72\xf9\xf3\x19\x4c\x26\xd5\x13\x4e\x07\x00\x92"
        "\x74\x8b\xeb\xa4\xaf\xd4\x4d\x87\x7e\x4b\xe2\x8f\x8a\x05\x30\xdc\xda"
        "\xa6\x13\x5c\xbc\xc9\xe6\x06\x67\xa6\x12\x9b\x37\x8d\xac\x0a\xf6\x1c"
        "\xac\xd3\x26\x54\x43\x4d\x0c\xd1\x1b\xe4\x43\x15\x65\x07\x2f\x40\x53"
        "\x58\x68\xbe\xe7\xe3\x3f\x24\x94\x8e\x8c\xeb\xef\x64\x04\x82\x39\xed"
        "\xed\xac\x00\x7f\x29\x97\xc1\x9b\xdd\x4d\xfc\x6f\xc9\x8e\xd9\x4b\x0b"
        "\xbc\xc3\xdd\x02\x96\x5e\xf7\xe3\x53\xf5\x04\x42\xfc\xa2\xab\xee\x8b"
        "\x68\x81\xf2\x67\xd5\x5f\x9c\xdd\xf8\x24\x62\x1e\xaf\x40\x76\x0e\x4b"
        "\xa7\xaa\xc6\xfd\x5e\x4e\x78\x79\x80\x86\xbc\x64\x72\xdb\xc5\xd6\x97"
        "\x2c\x08\xa1\xb6\xb5\x73\xbf\x19\x7b\xbf\xef\x6b\x32\xcf\x08\xa5\xfe"
        "\x9a\x54\xce\xde\xb3\xb7\x29\xe8\x3e\xda\x71\x8c\xcf\x34\x47\xed\x65"
        "\x50\x25\xfb\xaf\x39\xd7\xcb\x2c\x5d\x91\x94\x73\x03\xe1\x9c\xaa\xc9"
        "\xbd\xac\xb1\x39\x6a\x9e\x83\xa5\x49\xd4\xe8\xbd\xbd\x1c\x56\x42\x94"
        "\x6f\x58\x78\x0f\xa6\xc9\x9d\x85\xdb\xba\x2f\x73\x07\x65\x9d\xf5\x0c"
        "\x7b\x78\x35\xc7\x15\x46\x1a\xe1\x64\xd5\xb2\xf5\x63\x9c\x61\xee\x8f"
        "\x76\x26\x9d\x3a\xca\x12\x98\x84\xbf\xb1\xe9\x5f\x3a\xb2\x7f\x3a\x2c"
        "\x4c\x18\x2c\x76\x03\x71\xa1\xb8\x62\xcb\x30\xb6\xb4\x81\x00\x11\x13"
        "\x90\x93\x53\xf6\x0b\x16\xc0\x78\x3d\xc9\x08\x0b\x1d\x93\xab\x22\x35"
        "\xf2\x57\x6d\xca\x5e\x58\x3c\x22\xbc\x2a\xf6\x53\xb0\x6b\x85\x87\x58"
        "\xbf\x63\xe4\x38\x8a\xbc\x3e\xb4\x75\xcd\xed\x6e\x9a\xa3\xe2\xb5\xe4"
        "\x04\x5b\x1c\xa1\xe9\x1f\xc2\x94\x73\x32\x6d\x6a\x69\x74\x23\xec\xdf"
        "\xab\xe8\x49\x01\xa5\xcd\xdd\x59\xc6\x4a\x2a\x77\xd6\xb1\x75\x1b\xe8"
        "\x87\xd2\x71\xbb\x8a\x3e\x87\xc5\xc4\x7d\x50\xae\xfb\xb9\xef\x69\xa5"
        "\x68\x02\x2b\x24\x7c\x39\xa5\xfc\x35\xa9\x32\x6b\xa8\xfd\x8c\x62\xdf"
        "\x74\xf9\x88\x2b\x84\x1e\x42\x69\xf6\x44\x9b\xb1\x97\x40\x9a\xae\xad"
        "\xb4\x77\xe1\xc1\x7b\x4c\x02\x1d\xa1\x26\x41\x7e\x33\x4d\x4b\xa5\x04"
        "\x5e\x10\x0c\x67\x67\xa2\x81\xa5\x99\x15\x0b\xb4\xb9\xf2\xb2\x9b\xfc"
        "\x0f\xb0\x5f\xd0\xb9\x9e\x8b\xa4\xed\x50\xfb\xca\xf5\x17\xd2\xb8\x56"
        "\x0c\xed\x45\x32\x03\x14\x10\x1e\x97\x58\xc7\x6d\x17\x10\x84\x66\x22"
        "\x1f\x0a\xa8\x97\xe7\x75\xb3\x63\xe6\x24\x09\x0e\x42\xdb\x69\x79\xee"
        "\xa9\x08\xdb\x2d\x53\x3b\xf7\x97\xd6\x1b\x5f\x6c\x87\x93\xad\xe7\x69"
        "\x37\xc5\x72\x7b\xce\x24\xf1\x4d\x66\xf0\x96\x36\x35\x39\x16\x25\xef"
        "\xc2\x6e\x0b\x1e\xca\xe2\x8f\x77\xef\x75\x72\xca\x98\xfd\xac\xea\x4a"
        "\xc7\xbb\xde\xd1\x4c\xd4\xcd\xc7\x96\x66\x38\xc3\x9f\x36\x8d\x67\x4a"
        "\x71\xa7\xfb\xdf\xf1\x9c\x7d\x2d\xf5\x00\xa7\x19\x1b\x6d\x29\xab\xa8"
        "\x83\x42\x77\x4e\xa3\xe8\x1b\x87\x81\x90\x3a\x4a\xe7\xb0\xce\xfc\x14"
        "\x56\xfd\x4f\x36\xee\x0f\xf4\xd5\xe3\x7a\x32\xff\xde\xf4\x5f\xc7\x9c"
        "\xb3\xf9\x70\xc8\x4d\x88\x5d\x68\x5f\xf6\x27\x05\x1e\xe9\x0e\x32\xe5"
        "\xcf\x8d\x3a\x18\xcd\x25\x76\x15\x72\xcf\x74\x6c\x5a\xcf\xe0\x43\xac"
        "\xf3\x75\xd3\x47\x09\xc0\x4f\x0b\x04\x65\xe9\x86\xc4\x11\xbb\x73\x46"
        "\x1e\x99\x8d\x17\xb7\x6f\x0e\xa6\x6d\x78\x7d\x89\x9f\x43\x41\x19\xd7"
        "\x44\x76\x13\xbf\x0f\x78\xbb\xcb\xab\x7a\x72\x4c\x3a\xf7\x2a\x4e\x3c"
        "\x63\x55\xf4\x60\x5c\x6c\xe4\x7d\x47\x45\x04\x97\x1d\x3b\xe4\x19\x71"
        "\x5b\xac\x8e\x57\xf4\x1c\xbc\x3a\xe5\x63\x5e\x46\x72\xa0\xde\xcf\x16"
        "\xa4\x85\x66\xc6\xb8\xc0\x79\x82\xf9\x5c\x2e\x5e\x9a\x20\xb1\x3b\x1b"
        "\x96\xdf\x23\x24\x57\xd7\xe1\xe5\x32\xef\xc9\x07\xa9\x96\xa9\x48\x2d"
        "\xa6\xd3\xf0\x1a\x07\xc5\xc7\xc7\xcb\x1d\x09\xc4\xbc\xac\x8f\x5d\x20"
        "\x40\x03\xf2\xd0\x0c\x62\x98\xf4\x2f\x03\x9b\x5f\xf3\xe1\xea\x4f\x8f"
        "\x8d\x46\x14\x55\xf3\xb3\x9f\x4d\x94\x45\xb7\x06\x3a\xf1\x76\xbc\x91"
        "\x13\x64\x40\xba\x8b\x7c\x47\xd4\x2c\x33\x5c\x44\x3f\x18\x6c\x54\x7d"
        "\x90\x8c\x88\x5f\xb4\xa3\x92\xe0\xca\x56\xef\x36\x8f\x42\x0b\x63\x76"
        "\xba\x1b\xc6\x37\x00\x8c\x48\x55\x3a\x00\xcb\x66\x97\xff\xdd\x45\xff"
        "\x86\xf7\xb6\xb2\x02\x1f\xc6\xa8\x57\xe4\x8c\x46\x90\x72\x48\x56\xd2"
        "\xb2\x74\x71\xad\x92\x55\x93\x7a\xfb\x0a\x19\x5c\xf7\x75\x57\xd8\x90"
        "\x3d\x0c\xaf\xf6\x43\xc3\x79\x26\x81\xf7\x56\xcc\x2c\xbd\xb4\x19\xce"
        "\x69\x31\x2a\x49\x14\xf6\x2f\xea\xae\xe6\x1b\xcd\x8b\x20\x2e\x5d\x5d"
        "\x65\xe1\x2e\x01\x49\x25\xd9\x77\x1b\x91\x65\x5d\x35\x87\x8c\x43\xbe"
        "\xa5\x22\xcf\xd9\x09\x39\xf0\x92\x7d\x20\x96\x5b\xd3\x0c\x69\xe5\xd8"
        "\x7a\xeb\x1b\xb8\xdd\xad\x1a\xdf\x37\x37\xae\xaa\x00\x1f\x66\x09\x96"
        "\xab\x01\xa8\xc3\x00\x26\x87\x65\x38\x71\xc6\x3e\xbb\x6c\x29\x09\x53"
        "\x35\xe7\xef\x5d\x0a\x54\x71\x10\xc3\x93\x0b\xdc\x13\x11\x02\x73\xb6"
        "\x68\x98\xfc\xc5\x4a\x98\x55\x15\x32\x7e\x95\xce\x65\xb9\xa2\x11\xb0"
        "\xcf\x28\x79\x8a\x30\x13\x79\x81\xb9\x7e\xb9\x05\xd3\x6d\x0c\x5f\x16"
        "\xbf\xcc\xa7\xdf\x20\x07\x2d\x8d\x0c\x02\xbb\xf1\x6c\xe1\x27\x1d\x53"
        "\xa4\x9e\x65\xab\xad\xba\x20\xb7\x5d\x18\xab\xd9\x26\x44\x99\x0d\xa4"
        "\x06\xc6\xc8\x26\xde\x94\x8a\x89\xaf\x95\xad\x4b\xee\x47\xf4\x99\xa8"
        "\xb8\x87\x23\x5f\x7b\x13\x0f\x19\x74\x77\x3e\x58\x6e\x55\xb5\x86\x31"
        "\x9a\xac\x69\x2d\x28\x96\xc2\x7d\x8f\x50\x26\xba\x28\x06\x0b\xfc\x10"
        "\xe1\x16\x6f\xa5\x27\x74\xe9\x5e\xa6\x03\xce\xd6\x0d\x4b\x50\x19\xa3"
        "\xa7\x7f\x3b\x08\x14\xca\x19\x33\xb1\x89\x72\x63\xcd\x9e\x71\x36\xc9"
        "\x2d\xba\x3a\xa5\xf7\xea\xdd\x95\x94\xaa\xa3\xfe\x4f\x6e\x35\x02\xbc"
        "\xb6\x84\xb8\xab\xd9\x4e\x41\x16\x9a\x7d\xe2\x2f\x24\x89\x70\x64\x4c"
        "\x6d\x5a\xb7\x11\x7b\x7c\x25\xb8\x6b\x7b\x58\x02\x11\x2e\xf7\x54\x90"
        "\x47\x02\x8a\x2f\xd0\x31\x3e\x0e\x7c\x8c\x53\x7b\x2a\x60\x46\x82\xb3"
        "\xfe\xf1\x00\x8d\x87\x51\x19\x75\xaf\x18\x7a\x5a\x9d\x76\xf3\xae\x12"
        "\x56\xfa\x0c\xad\x29\xea\xac\x4c\x77\xf3\xe5\x0c\x5d\x54\xf9\x40\xc1"
        "\xc3\x43\x8e\x5c\xd6\x88\xdd\x11\x53\x04\xad\xe3\x21\x89\x24\xc1\x82"
        "\x2f\x24\x64\xa7\x40\xbd\xe4\x8f\x0c\x5d\xcd\xd1\x32\xbb\xad\x02\x6d"
        "\x1c\xb3\xa6\xc1\xcf\x34\xaa\x96\xbc\x9d\x97\x2a\x61\x80\xfb\x63\x53"
        "\x33\x7b\x07\x8c\x43\x7f\x4e\xa0\x2e\xeb\xd2\xd2\x96\xf2\x47\xed\xd5"
        "\x13\x1d\x20\x5e\x07\xdc\x19\xba\xd8\x0e\x54\xc7\x70\x05\x68\xbd\x64"
        "\x7b\xe7\xac\xfa\x16\xa7\x9c\x34\x1f\x59\xde\xda\xf1\xc2\x38\x0e\xa1"
        "\x6d\x7f\x4e\xee\x7d\x85\xd8\xcc\xc6\x04\xd5\x5f\x99\x71\x47\x85\x93"
        "\x94\x32\xa1\x98\x30\xc4\xf6\xb6\x5f\x79\xa0\xb5\x48\x6f\x1a\x60\xef"
        "\xc3\x81\x63\x04\xeb\xde\x7b\x24\x4f\x1c\xc0\x5f\xea\x72\x8c\x0a\xa4"
        "\x1f\xee\x54\x67\x3c\x70\x0f\x59\x4b\x1d\xdd\xef\xf3\x59\x27\xd1\xeb"
        "\x6d\xbf\x9b\x04\xfc\xe6\x21\x6c\xd7\x9f\x0d\x19\xb9\x6b\x35\x6d\x02"
        "\x48\xfe\xda\xf2\xac\xa4\xb5\xd9\x16\x77\xc2\xe2\xb5\x1c\x3f\x22\x67"
        "\x6b\x33\x03\x0e\xf6\x08\xc2\xb5\x2a\xb3\xd1\x2b\xb5\x85\xa0\xa5\xe7"
        "\xe6\xdb\x7c\x86\x39\xe9\x8d\x36\x84\xd3\x64\xe3\xb9\x37\x10\x3d\xc5"
        "\x77\x78\x18\x81\x85\xde\x1e\x45\x33\x63\x31\x48\xc3\xce\xa0\x3c\xc2"
        "\x09\x85\xe4\xbb\x94\x44\xb7\x37\x6c\xa5\x51\x42\x72\x3e\x82\xfa\x8a"
        "\xe6\x9c\xba\xa9\xee\x3b\xe5\x12\x99\xe0\x47\x6c\x88\x43\x59\xfe\xcb"
        "\xbb\x1f\xb6\xe1\xc8\xd7\x18\xb8\x9c\x75\x43\xa5\x4c\x1d\xd6\x66\xe0"
        "\x1a\x37\x93\xdd\xf8\x7d\xde\xab\xb5\x23\xa6\x2d\xd5\x62\x29\xbf\x64"
        "\x7a\xba\xe1\x3f\xfe\x09\xbe\x09\x0c\x57\xf5\x25\x07\x7d\xe1\xa4\xf7"
        "\x2a\x85\x2e\xe3\xf2\x13\xb8\x2c\xcc\xdb\x81\x0b\x30\x08\x01\x2d\x08"
        "\xfd\xd0\xfc\xde\x79\xab\x75\x02\xed\xc2\x6a\x8e\xaa\x1a\x3c\xc2\x3e"
        "\xb5\xe6\x00\x07\x6c\x36\x8b\xac\x3a\xd2\x63\xec\x1e\x65\x19\x27\xa6"
        "\x9b\xc1\xc0\xae\x9a\xeb\xb6\x62\x97\x86\x97\xf3\x5a\xe6\xd4\xc5\x0e"
        "\xaa\xe4\x39\xc0\x1c\x97\xb8\xa1\x68\xe9\x2a\x65\x66\xb1\x3a\xb3\xe8"
        "\x39\xaa\x78\x04\xfd\xe9\xbb\xfe\xa1\x3f\xb7\x85\xa7\x7b\x7d\x86\x4d"
        "\xff\x7d\xd9\x10\x7c\x3a\x3e\x8f\xc1\x8c\x26\x3f\xb4\x66\xd4\x62\x96"
        "\x99\x0b\x7c\x69\x43\xd2\x5f\xde\xdf\x21\x73\xd2\xc4\xcb\x8b\xe5\x4a"
        "\xdb\x55\x92\xa9\x12\xc4\xdf\xcf\x01\x7b\xcd\x74\xd3\x35\xc0\xa8\xb9"
        "\xb1\xff\x0e\x2e\x0f\xab\x4c\x5b\xd4\xf6\x0a\x2e\x11\x74\x71\xb6\x34"
        "\xb0\x54\x0d\xac\x2c\x28\xdc\x6e\xb3\x69\x65\xed\xff\x48\x87\x4c\x16"
        "\x11\x4a\x9b\x7f\x38\x77\x74\xdc\xc0\xdc\x0a\x9d\xaf\xcc\xf5\x94\x76"
        "\x07\x0b\x55\x26\x24\x46\x3e\xf6\x41\x90\x35\xd8\xb3\x8b\xce\x88\xce"
        "\xfc\xfa\x2e\x32\x6d\x1b\x52\x43\x19\xe3\xf8\xf6\xa4\x3d\x1d\x64\xee"
        "\x31\x34\xad\x42\xf5\x73\xd8\x7b\x21\xa9\xd1\xb8\x83\xd0\x6f\xd6\xe9"
        "\x4e\x27\x07\x59\x33\xe3\x16\x1b\x5e\x06\x98\xb7\xe9\x4b\x0b\x3e\x7a"
        "\x80\x08\x96\x81\xe8\xa0\xf6\xd9\xb5\xf0\x9d\x03\x3a\x54\x6d\xa9\x6e"
        "\xc5\xe2\x60\x09\x3c\x46\x7c\xa7\xbd\x9b\xc4\xd7\xaa\x5e\xc0\xfd\x91"
        "\x72\x60\x7c\xbd\xa5\x04\x61\xec\x2c\x35\x36\xb7\x1f\x9a\x6d\xa6\x6a"
        "\x26\xe9\x62\xee\x9a\x6c\xbd\x4c\x54\xdf\x73\x6d\x07\x77\x06\x32\xcd"
        "\xea\xc3\x9f\x12\xcf\x70\x5f\x28\xa6\xd1\xa7\x8f\xe0\x4e\x5d\x35\xc9"
        "\x90\xd5\xde\x98\x5d\xdb\xc4\xad\xc1\xd9\x4e\x58\xf3\x27\xca\x6b\x04"
        "\xd2\xd7\x49\x9f\x14\x51\x99\xd8\x01\x09\x12\xb9\xd3\xe6\x07\x6d\x92"
        "\x5a\x8f\xc1\xdb\xe3\xe4\x88\xa7\x4d\xfa\x82\x63\x96\x45\x2f\x8f\xd0"
        "\x29\x56\x79\xe2\xc6\xd2\x24\xc9\x42\x8d\x86\x71\x94\xc1\x89\x28\xe4"
        "\x2a\xc1\x59\x5a\x4b\xed\x9a\x40\xb5\xfc\xc7\xf5\x9c\xd1\x10\x75\xb2"
        "\x1a\xd2\xc1\xe5\x4c\x3a\x41\x96\xd9\xe8\xd6\x68\x36\xfe\x23\x79\xf8"
        "\xba\xc6\x23\xb1\xf7\xfb\x59\x2a\xf8\x00\xff\x71\x09\xe3\xcf\x04\x8a"
        "\x7f\xca\xc1\x80\xda\xf6\x72\xf3\x7c\xe1\x36\x1c\xbe\x8e\x08\x55\xc1"
        "\xb8\x8a\x30\xb2\x06\xd2\xff\x0c\x7a\x29\x21\xbe\x6d\x1c\x55\x9f\xe9"
        "\xcd\x50\x79\xe0\xa6\x27\xbc\x9c\x4a\xc1\xe5\x94\xc2\x08\xb5\x2b\x6b"
        "\x2e\x06\x5f\x74\xfe\x84\x26\x88\x5a\xe1\x01\x22\x9d\x86\x06\xb5\x2c"
        "\xb6\x65\x1b\x2f\x62\x30\x0c\x7e\x1d\x0e\xee\x68\xbf\x5a\x0a\x4e\x72"
        "\x45\xdd\x9a\xfd\x7f\x7f\xec\xc9\xc4\x94\x02\xa4\xf2\xe2\xf1\x9e\xf6"
        "\x0f\x51\x0b\x32\xe0\x4b\x32\x37\x4f\x55\xf5\x9b\x31\xda\x7c\xac\xa4"
        "\x74\xe4\xf3\x6e\x46\x90\x92\xc5\xca\x36\x84\x6b\x97\x8c\xa6\xea\x25"
        "\xe0\xa3\xef\x6b\xed\x51\x7b\x8f\x31\xa7\xff\xb0\x8c\xb1\x4b\x3c\xae"
        "\x74\x05\xd8\xcc\x5a\xc8\x69\x6e\xc7\xfd\x9b\x8c\x0d\xd9\x28\xd2\xd8"
        "\x3b\x5e\x84\x83\x72\x78\x3d\xb8\x3e\x1a\x30\xb9\x54\x95\xa7\xb6\x08"
        "\x7d\x11\xf2\x59\x61\x7a\xd8\xe2\x8d\x21\xbf\x90\x0d\x7a\x7f\xef\xac"
        "\x67\xe2\xf8\xe2\xcb\xf0\x37\x8a\x7a\x7c\x40\x6f\xab\x3f\x3a\x8e\x25"
        "\xcd\xe6\xc0\xfa\x9a\x02\x73\x42\xbb\x32\x83\x15\xf4\x19\xaa\x20\xf1"
        "\xec\x59\x61\x82\x72\x73\x79\xf5\xfc\xae\x4a\x6d\x01\x41\x7a\x8c\xbd"
        "\xcb\x1a\xa4\x03\xd3\x6a\xce\x1e\xf6\x84\xe5\x4a\x4c\x5e\x75\x79\x16"
        "\x4f\x5e\x9a\xc2\xfb\xa7\x6a\x45\x29\x3d\x89\xef\xce\xbe\x9d\x36\x64"
        "\x6c\x04\xe5\x05\xa9\x10\x01\x11\x80\xeb\xe0\x55\x6e\xc2\x2a\x02\xcc"
        "\x11\xaa\xbe\x2d\x4a\x0b\x14\xbb\xe5\xd1\x0e\xfb\xa5\x0c\xa4\x34\x64"
        "\xe2\xa2\xe2\x20\x51\x09\x22\xd6\x55\x4f\x75\x78\x2a\xa9\xdb\x2d\xd9"
        "\x73\xf5\x5c\x5c\xc0\x97\x08\xbf\x0a\xec\x96\xbd\x65\xba\x88\x3d\xbc"
        "\x8e\x98\x21\xb3\xe0\x77\x76\x90\x07\xe2\xf9\xf1\xd6\x26\x8f\x34\x93"
        "\x69\xe7\xcd\x2c\xdc\xb2\x04\xb6\x07\xbf\x2c\xdf\xea\x59\xe1\xd5\xdf"
        "\x88\x8b\x00\x51\x74\xde\x47\x7c\x10\xd6\x74\xff\xeb\x9f\x22\x28\xd3"
        "\xc5\xd6\x7d\xa5\x5b\x8a\x55\xb6\xe3\x9e\x50\x6d\x75\x6e\x11\x54\x78"
        "\xf5\xf1\xac\x96\x68\x1e\xa0\x14\xcc\x87\xfb\x2d\xff\x6d\x56\xe6\x77"
        "\xdd\x9c\x4a\xb0\xb9\xa9\x2f\x5c\x52\xab\xc0\x9b\xdf\x3e\xf7\x95\x51"
        "\x74\x3b\x5d\x47\x38\xd5\xe7\xdf\x5a\x94\x54\x8d\x7b\xd1\x19\x91\xbf"
        "\x1d\xc6\x0a\x9e\xb3\x73\x7f\x18\xd9\xd7\xb1\x0a\xff\x81\x1d\xd2\xeb"
        "\x00\x92\x93\x82\xd3\xe9\x5b\x66\x6a\x86\x9e\x87\xe8\xcc\x63\x4a\x35"
        "\x43\x86\x32\x62\x8c\x85\x2c\x4d\xdc\x04\x1b\xdd\xc7\x91\x03\x56\x70"
        "\xa1\x54\xc1\xf1\xfd\x55\xce\x64\x64\x25\x14\xb5\x73\xa3\xd7\x57\x3f"
        "\xe9\x73\x28\xdc\x50\x81\x19\xff\x07\xb2\x65\x6d\x19\x8f\x18\xf8\x82"
        "\x52\x07\x45\x9a\x01\x71\x05\x9d\xe2\x91\x61\x92\x70\x40\x83\x0f\x4f"
        "\x06\x53\x40\x98\x16\x21\x74\x4b\xba\x08\x4b\x06\xb6\x6c\x30\x56\x2b"
        "\x5f\x3c\xcd\xda\x20\x50\x7a\x2b\xb9\x25\x54\x00\xf7\xf4\x6a\x5b\x07"
        "\xcf\xe5\xe8\xd9\x3d\xf6\xb3\xc7\x4d\x12\x41\x57\x75\xef\xeb\x3b\x43"
        "\x8f\x8e\xa4\x9b\xdd\x01\x35\xe3\xac\x5d\x82\xe2\xbe\x26\xa0\x70\xda"
        "\xbb\x25\x84\x17\xee\xc1\x47\xc6\xbf\xbc\xea\x97\x0d\xf0\xb8\x55\xd4"
        "\x64\xae\x13\x5a\x32\x76\x01\xe5\x02\x17\x8b\xa0\xb6\x51\xba\x52\x8a"
        "\x03\xd1\x55\x9b\xb3\x4a\xf3\x14\x10\xee\xed\xc3\xb3\x53\x08\x0f\xd4"
        "\xf8\xe1\xbb\x71\x2a\x6b\xc3\x92\xf6\xbe\x25\xf2\x3c\x51\x79\x89\xc6"
        "\xc2\x0f\xd4\x9a\x06\xaf\x44\x61\x37\xcf\x57\x65\x0f\xc4\x31\x66\xdc"
        "\xe1\x07\x00\x28\x7d\xbc\x40\x7f\x6b\x00\x7f\x79\x6e\x1e\xc1\x85\x7f"
        "\x10\x99\x56\x3c\x46\xb2\x23\x0b\xca\x24\x13\x60\x7e\x04\x59\xea\x2c"
        "\xb3\x6a\x00\x5b\x7f\x6f\x75\x69\x3f\x92\x58\x77\xc3\x46\x50\xe7\xbd"
        "\xad\x81\x3f\x70\x7d\xbd\x3e\x81\xe2\x83\xbb\x23\x5a\xd8\x83\x5c\xb8"
        "\xeb\x79\x36\x4f\x12\xbc\xe5\xdc\xde\xe3\x15\xc0\x1d\x55\x9b\xba\x23"
        "\x2f\x20\xfe\xa2\x58\x91\xf1\xc4\x3e\x42\x41\x8a\x3b\x00\x50\x12\x93"
        "\x84\xc5\x4a\x01\xcd\x84\x86\xfa\xb7\x8d\xb2\x53\x7f\xca\xa2\x06\x82"
        "\xc2\x7f\x49\x3d\x46\x61\x8e\x76\x8c\x35\x95\x08\xd2\xd1\x11\x33\x29"
        "\x96\x2d\x5a\xc3\x5e\x05\x9b\xc7\x8a\x2e\x9e\x6a\x4f\x55\x8e\x2d\x57"
        "\xaf\x3a\x2b\x12\x16\xc7\xe6\x81\x86\xeb\x49\xa6\xc4\x7a\xd5\xf0\xe4"
        "\x53\x90\x9f\x25\x87\xbd\x57\xa4\xa6\xd7\x5f\x4e\xf4\x68\xe5\xce\xba"
        "\xe6\xd0\xe1\x69\xe9\xfc\xbd\xed\xd3\x63\xf1\x4e\x7a\xb0\xd3\xd8\xa6"
        "\xdd\x87\x84\x69\xaa\xa8\xee\x2b\x8e\xde\x44\x65\x13\xab\xae\x17\x13"
        "\x21\x0c\x91\x60\x87\x4a\x07\x58\xcf\x98\x2c\xaa\x51\x4b\x75\xbc\xef"
        "\x4c\x6e\x71\xc2\x53\x23\x5c\x9a\xb9\x86\xf2\xb9\x5b\x24\x1e\xa6\x65"
        "\x79\xc7\xc5\xdc\x59\x32\x8e\x2e\xba\x18\xa4\x37\xed\x9a\xc4\x83\xdb"
        "\xbb\x28\x84\x11\xfe\xf1\xbc\x2c\x1f\x8e\x28\x52\x3f\x45\x9c\x66\xe1"
        "\x09\x65\x4f\x39\xda\x97\x1f\x99\x7a\xdc\x79\x8c\x55\x70\xb1\xef\x52"
        "\x4b\x54\x7f\xcd\xe3\x7b\x9c\x75\xd7\x96\x78\xcf\x54\x60\x90\x01\xa0"
        "\x66\xdd\xdd\x91\x1b\x3d\x58\x1e\xc0\xda\x19\x0c\x98\x95\x36\xca\x95"
        "\x8e\xd3\x58\x90\xe4\x67\x4a\x61\xad\xf8\x75\xd4\xde\xe4\x60\x3a\x6d"
        "\x96\xaf\x39\xd8\x7a\x09\x9b\xf0\x45\x5c\x14\x2c\x8b\xce\x93\xd2\xe6"
        "\x7c\xe0\x2b\xb4\x87\x6b\x0c\x6e\xc6\x1a\xd7\xe7\x96\x05\xfc\x05\x92"
        "\x07\xef\xcd\x25\x42\x61\x3e\x55\x07\x90\x8b\x06\xa9\x26\x92\x03\x30"
        "\x7f\x64\x92\xbe\xe8\x73\xbb\x0f\x6b\x62\x86\xdd\x53\xc3\x7d\x6a\x7d"
        "\xd9\xc8\x3a\x33\xc4\x7b\x35\x00\x11\x9e\xe3\xcb\xf8\xcc\xbf\x70\xf2"
        "\x55\x59\x2e\x81\xb7\xe8\x4f\xc8\xe5\x29\xe6\xae\x54\x47\xa8\x7d\xe5"
        "\xdb\x5a\x1b\x9b\x72\x34\x03\x74\x59\x03\xba\x1c\xae\xb7\x7d\xae\xf8"
        "\xf7\x58\xb3\x3e\x8e\xfe\xa8\xe5\x1f\xf9\x39\x4b\x34\xf9\x94\x87\x55"
        "\x09\xd4\xd4\xdf\x73\xc9\xa2\x7c\x48\xba\xd4\x6f\x39\xdf\xf0\x10\x99"
        "\xf1\x81\x51\x1e\x1f\xd6\x06\x1a\xc0\x5a\xf6\xcd\x75\x81\xa8\x36\x94"
        "\x27\xc0\x8e\x84\x98\x44\xca\x9b\x1f\x73\x6e\x79\x9c\x9c\xae\x1e\xb6"
        "\x51\xbc\x0d\x86\x28\x89\x92\x72\x7d\xda\xe1\xb2\x56\x11\x9a\x37\x1a"
        "\x2b\xfc\x7a\x60\x28\xc8\x5a\xd3\xed\x83\xeb\x4e\x84\x36\x2b\x22\x1a"
        "\xbd\x0e\xe6\x76\x8b\x09\x6d\xd8\xc6\x50\x1f\x3f\x92\x63\x34\x2b\x08"
        "\x50\xaa\x3f\x14\x60\x72\xa2\x68\xe2\xf1\x41\xf5\xed\xa0\x96\x5f\x48"
        "\x51\xce\x52\xc4\x91\x63\xe1\xb8\x7f\x6e\x7e\xf4\xe4\x77\x3a\x9c\x80"
        "\x20\xba\xbb\x03\xfd\x8e\x6a\x1a\xf5\x9f\x46\x41\xe0\xf6\xce\xef\x52"
        "\x56\xf2\x49\x6b\x46\xdf\xe2\xcf\xb4\x17\x01\x94\x95\x17\x45\x6d\x82"
        "\x4f\x45\x70\xb0\xa9\xfd\x84\x99\x2e\x8a\xec\x44\xf1\x23\x5d\xe2\x16"
        "\xed\x65\x41\x71\xa2\xfe\x33\xd8\x65\x07\x1c\xa9\x0d\x74\xc1\x20\xc2"
        "\x0f\xca\x8c\x78\x75\x06\x06\x71\x00\x61\xb1\x76\x50\xbe\x16\xc0\x3d"
        "\x77\xdb\x53\xe6\x0f\x69\x3b\xce\x93\x87\x2f\x68\x70\xd4\x91\xe6\xc3"
        "\x47\x69\xd1\xa8\xd0\x07\x3c\xd6\x45\x6b\x36\xe3\xb3\xdc\x12\x40\x0d"
        "\xfe\x93\x20\x3d\x6d\x2c\x68\xf7\x3b\xad\x27\x91\xfa\x6f\x25\xa6\x9d"
        "\x1c\xf0\x56\x5a\xca\xbc\x6f\x67\xf6\x1d\xab\xb8\xc3\xca\x7e\x16\x97"
        "\x57\x49\x26\xf7\xf6\x7f\x24\xfa\x82\xa6\x29\xb0\xb3\x45\x63\x12\x1f"
        "\x91\xe4\xad\x61\xe8\x8a\x92\x44\x4b\xf3\x4c\x15\x57\x23\x20\x18\xc8"
        "\x5e\x40\xe8\x9c\x65\x6d\xef\xa6\x1d\x2b\xf1\xf4\xd4\x62\xa3\xfb\xbe"
        "\x64\x33\x55\x49\xf8\x54\x72\xab\x1e\x62\x3f\xdb\x9a\xf2\xa8\xee\x76"
        "\x3d\x1a\xa8\xa0\xfc\x7e\xc2\xc9\xfd\xe5\xf6\x85\xb9\x59\x28\x10\x85"
        "\x3a\xde\xd9\xf9\x2d\x05\xaa\x90\x02\xa7\x75\x1c\xb1\x16\x24\xa7\x5d"
        "\x39\x0e\xfb\x72\x53\xb9\xb6\x20\xfd\x1b\xd5\x5f\xfe\x4a\xc7\x74\x77"
        "\x17\x40\x54\x35\xdf\x76\x1b\xbf\x8a\xa6\x8e\x99\x8c\x34\x75\x9c\xd2"
        "\xcd\xf2\x67\x21\x01\xbf\xaf\x37\x2f\x45\x19\xa2\xfb\x73\xf5\xd6\x88"
        "\xbf\xa8\x63\x31\x8a\xc2\x0a\x1c\x2f\x65\x55\x81\xd2\xc4\x7b\xed\xc6"
        "\x7d\x37\xc6\xee\x69\x17\xd2\x12\xbd\xc5\x41\x8a\x40\xbd\xad\x9a\x9a"
        "\xcc\xaa\xba\xd2\xd4\x89\x33\x92\x3f\x93\x34\x98\xf3\x30\xe9\xca\x48"
        "\xa9\x84\x4a\x1a\x00\xe6\x51\xd1\xd4\x90\x8c\xc2\x6f\x5f\xa2\xb6\x28"
        "\x25\x86\xbf\xd8\x38\x5c\x0d\xe6\xfc\xd8\x6e\x67\x63\x17\x6e\xd0\x29"
        "\x80\xb9\xa2\x8b\x9f\xf3\x0a\xbc\xba\xb8\x18\xa4\x6a\xc3\xaa\x58\x6b"
        "\x19\x51\xf0\x67\xf9\xae\x87\x68\x33\xb6\x8d\x9d\x0d\x1c\xf9\x00\xcd"
        "\x7f\xa6\x12\x0b\x21\xdc\x2d\x79\x42\x2b\x24\x0e\x8c\x0e\x60\xff\x84"
        "\x53\x94\x59\x07\x64\xa2\xa6\x40\xfb\xc9\xa1\x44\x0d\xaf\xd6\x5f\xa6"
        "\xc7\x06\x25\x08\x95\x9f\xb8\x23\x9f\xb1\xb2\x46\xfe\xa9\x36\x82\x6e"
        "\x87\x07\xaf\x9d\x03\xcd\xc4\xac\x8a\x0e\x73\xd8\xcd\x1c\x44\xc7\x0d"
        "\x4c\x43\x34\x69\xfa\xf2\x4c\x38\x4b\xa5\x1b\x8b\xac\x79\xe8\xad\xa9"
        "\xc9\x04\x7a\xf8\x6d\x9b\x7e\x46\x2c\xb1\xc5\x2b\x6e\x6e\x24\xab\xd0"
        "\xe7\xcc\x80\x78\x4c\x34\x6c\x0c\x32\x98\x52\xef\x8a\xfb\xc4\x27\x9c"
        "\x3f\x71\x13\x42\xb8\xcb\xc5\x9f\xf6\xb6\xc9\xa8\x57\x9b\x1b\xeb\x28"
        "\xdb\x3b\xcb\x2d\x71\x21\xff\x42\x9a\x64\x71\x21\xf3\xa5\xb2\x0a\x37"
        "\xfb\x62\x10\x46\x22\xcb\xb8\xf8\xbd\xc6\xc4\x9d\xd3\xa1\x17\x40\x7f"
        "\x29\x5e\xef\x45\x5d\xe8\x0c\xb7\x89\xf8\x62\xc1\xaa\xfb\x78\xb1\x97"
        "\x29\x36\xc4\xb0\x71\x1b\xca\x14\x89\x0e\x83\x86\xee\xe5\x7a\x55\x11"
        "\x28\x8c\x53\xff\x31\x02\x7b\xe7\xe9\x19\xfd\x0f\x11\xb5\xd0\x52\x60"
        "\x25\xaa\x20\xed\x62\x25\xa0\xff\x09\x59\xba\x85\x54\xc8\x58\xdf\x73"
        "\x27\xb4\x92\x07\x92\xbc\x9c\x18\x30\x7c\xd9\xda\xb4\x34\x50\x22\xcd"
        "\x71\x20\xc3\xf0\xc9\xaa\x25\xd7\x26\x4a\x77\xcb\x15\xe9\x70\xdf\x0f"
        "\x36\xbb\x75\xa5\x93\x50\x45\x9e\x4e\xd3\x11\xe8\x55\xf5\xdf\x08\xd0"
        "\x8c\x8f\x6b\x9f\x73\x9b\x85\x59\x1c\x0d\x09\xae\x42\xa0\xcf\x13\xcc"
        "\xd3\x30\xfe\x60\xb6\xbc\x30\xb3\x93\xc4\x57\x50\x63\xee\xff\x91\x4d"
        "\x2a\xf7\x6e\xa6\xba\xae\x85\x87\x76\x09\x25\x0b\x2f\x17\x42\x3c\xbd"
        "\x8c\x71\x3e\xb6\x10\x23\xa3\xff\x7d\xaf\xb8\x3a\x1c\x91\x27\x49\x95"
        "\x33\x5c\x49\xc6\xeb\xb9\xb0\xd5\x69\x4d\xc9\x8e\x89\xae\x56\xc0\x10"
        "\x3d\xd6\x72\x9d\xa4\x3d\x28\x40\x6f\xd5\x93\x11\x54\xbd\x50\x0d\x20"
        "\xf1\xb1\x1c\x31\xa4\xf8\xa6\x5f\x92\x9f\xa4\x3f\xe6\x71\x44\xbb\xe8"
        "\xa6\x9e\x05\xc8\x13\x68\xa6\xb8\x9c\xc3\x74\xf6\x5c\xd2\x7f\xac\x37"
        "\x3d\xa5\xf2\x13\xed\x98\xe8\x69\x0e\xe1\x6e\x21\xd6\xe1\x9c\x89\x93"
        "\x38\xe0\x7f\xed\x61\x32\x47\x0a\x01\x50\x6d\xd9\xd9\xea\x4f\xae\x91"
        "\x0e\x44\xf6\x4e\x56\x00\xb5\x57\x49\xfe\xaa\x55\x54\xe1\x4c\x9b\x56"
        "\xd0\xd7\xc3\x83\x45\x4b\xa5\x76\x5a\xde\xf0\x85\xce\xba\x19\x02\xdc"
        "\x22\x30\xc7\x4f\x53\xb8\xa7\x72\xc4\x85\x47\x81\x02\x8c\x8e\x47\x49"
        "\x8b\xfa\xc6\x50\xcd\xd4\x46\xdd\xd5\xde\x16\x74\xa7\x5e\xef\x22\xf7"
        "\x57\xa4\xb3\x02\x84\xfd\x42\x18\x08\x10\x15\xbf\x75\x99\x34\x8a\xe0"
        "\xf6\x88\x8c\x4a\x35\x20\x12\xb5\xfe\xf0\x8a\x39\x0d\xdc\xb5\xb8\x40"
        "\x2c\x9a\x75\x68\x77\xe1\x02\xe8\x71\x8b\xde\x33\x2e\xfc\x42\x5b\xb3"
        "\xbf\xde\xec\xb9\x19\xce\x61\x9a\x76\x3d\x1d\xc3\x6a\xb5\xde\x67\x8a"
        "\xfb\xb2\x5f\xa1\x5d\x48\x4c\x93\xa4\x70\x09\xf2\x8b\xd6\x29\x4e\x5d"
        "\x9a\xba\xea\x80\xe2\x34\x32\x2f\x0e\xdd\xae\x3c\x8e\xb1\xea\x2f\xae"
        "\x37\xda\x9d\x45\x8f\x8d\xfe\xbd\x85\x40\xac\x70\x56\x90\xd4\x5e\x55"
        "\xaf\xf6\xfa\x11\x4e\x57\x84\x27\xe9\xa6\x57\x01\x99\x5b\x6d\xed\x11"
        "\xed\xb5\x5d\xa7\x40\x18\xd0\x73\x7b\xd6\x66\xb2\x8c\x2a\xa6\xae\xb6"
        "\xda\xf2\xd6\x51\x6e\x2e\xf3\x52\x32\x84\x70\x1d\xbf\x60\x4c\x78\x19"
        "\xd3\xbc\xeb\x1e\xc4\xb3\xc3\x56\xd7\x33\x8c\x3e\x09\xa2\x62\x14\xd5"
        "\xc7\xa5\xec\xb1\x85\xb4\x22\xd1\x05\xc6\x78\x09\x19\x4a\xfd\x91\x67"
        "\x5c\xd3\xe3\xec\x05\x1f\xa9\x0c\xf2\x64\xea\xd2\x30\x90\xac\x7a\x0d"
        "\x78\xcf\x1a\x5e\xe7\xb6\x6c\x99\x1c\x0c\xe8\x28\x80\x31\xca\x5f\x24"
        "\xa8\xdb\x28\x84\x16\x17\x55\x7b\x14\xdb\xc5\xc7\xab\x60\x7b\xd4\xa5"
        "\x31\x97\xb2\x4f\x48\x30\x95\xf0\xd8\x4e\x90\xae\x9d\xde\x22\x9f\x94"
        "\x13\x21\xb8\x3c\x10\x07\x83\x30\xfe\x83\x65\x26\xe8\x01\xed\x33\xbc"
        "\xe3\x72\x6f\x76\x64\x32\x2f\x24\x6b\xcf\x42\xea\x5f\xb7\xfc\xa3\x1b"
        "\x65\xcd\x99\x7f\xc2\x32\x66\x57\xb1\xca\x6a\x52\x5b\xe2\x8e\x4a\xed"
        "\x6f\x5c\xf6\x1d\x36\xf3\xa9\x15\xce\xc7\x60\xea\x34\x8a\x78\xcf\x30"
        "\x35\x20\x89\x86\xec\xd4\x13\x62\x7d\x14\x4f\x19\x29\x46\x4c\xce\xe2"
        "\xae\xe0\x59\x38\x54\xf3\x1c\x88\x25\xee\xe5\x7f\xc9\x1d\x1c\x8a\xa2"
        "\x49\xbd\x33\xba\x53\x99\x3b\x41\x5e\x55\x54\x78\x43\x86\x8f\x34\x15"
        "\x12\xdf\xaa\x8e\xd6\xa6\xa7\xe7\x15\xe9\x37\xa4\x2b\x90\xc9\x14\xa8"
        "\xc0\x73\x3c\xd4\xb0\x65\x23\x00\x8a\xbe\x13\x24\x3f\xfd\x69\x5c\xbe"
        "\xda\x7e\xf2\x53\x00\x26\x69\x10\xe4\x59\xcd\x06\x51\x1c\xaa\x12\x64"
        "\xd3\x84\x92\x55\x6b\x8e\x42\x4d\x05\x2e\xf3\x9d\x7c\xe0\x15\xff\xb9"
        "\x13\xf0\xe6\x5b\x87\x18\xc6\x77\x8f\x56\xd4\x98\xfa\xcb\x67\x2f\x36"
        "\x5f\x03\x32\x76\x8b\xa9\x5f\x90\x7e\x36\x20\xd2\x79\xcf\x95\x75\x8d"
        "\x75\x1e\x88\xb6\x21\x5c\xac\xc8\x6b\x9b\xb8\x20\x66\x26\x23\xdd\x4c"
        "\xbc\x91\x45\x37\x65\x84\x39\x2c\x5d\xb0\x65\x58\x00\x8b\xe0\x68\x35"
        "\xd7\x78\xa2\xb4\xa0\xb5\x0a\x6f\xda\x27\xfd\x21\xbc\xe1\xd4\x71\xf6"
        "\x95\xc8\x78\x01\x3b\xba\x5d\xd8\x11\x4a\x1e\xbc\xf7\xc0\xc5\x71\x78"
        "\x07\x89\xe8\xc9\x54\x55\xb8\xfe\xde\x84\xd1\x1f\x0d\x90\x7e\x4b\xf6"
        "\xd3\x0c\x40\x5d\x04\x09\xb3\x69\xe3\x3f\x12\xb3\xdd\x56\xa9\xde\x18"
        "\xc1\xb5\x39\xcc\xfb\x4d\x67\x50\x73\xbe\xea\x58\x41\xd9\x3e\x7a\x54"
        "\x2e\x77\x39\x92\x96\x01\x94\x89\xfc\xb1\x9e\x30\x0f\xb2\xd3\x97\x04"
        "\x02\xc1\x95\x57\x29\xde\x2d\x29\x64\xdb\xa6\x26\xab\x63\x93\x84\x01"
        "\x84\x4c\xa6\xa5\x45\x32\xcd\x6a\x3d\xa0\xb0\x07\x38\x22\x72\x48\x4e"
        "\xe3\x74\x7a\x20\xcb\xf4\x6a\x11\x9c\xf4\x50\xc2\xa0\xde\xf0\x6b\x71"
        "\xf1\x0d\x06\xe1\x44\xba\x58\xae\xd7\xb3\x0d\x71\xbf\xfa\xe7\xea\x3f"
        "\xf2\x0c\xae\x01\x30\xaf\x63\xf7\xc2\xce\x89\x7b\x3d\x2b\xb9\xf0\xa2"
        "\xf1\xd1\x42\x17\x95\x18\xfe\x98\xdd\xd9\x8d\x49\x4c\x72\xda\x26\x4e"
        "\x10\x98\x18\xd0\x02\xdf\x19\x5f\xd2\xfd\x43\xe5\x86\xaf\x29\x0f\x6f"
        "\x4e\x30\x76\xae\x4d\xf2\x5c\xeb\xbb\x24\xe5\xd7\xad\x6c\xa5\xe7\xe4"
        "\xbc\x69\x71\xba\x3a\x92\x7a\x6c\x29\xb7\x13\xd1\xf3\x22\x11\x42\xa1"
        "\x00\x80\xe8\x1d\x6a\xf2\xc2\x42\xcf\xbf\xc5\x3b\x20\xa5\x77\x91\xee"
        "\xea\xfa\x4a\xa8\x7a\x18\xbf\x23\xba\xd7\xb9\x64\x7e\x8f\xc5\xc1\x76"
        "\x16\x3f\xd5\x6b\x66\x25\x8d\x8d\x68\xbe\xc5\x2c\x34\xc7\xda\x23\x59"
        "\x2e\x74\x22\x05\xd5\x3d\x7e\x38\x2f\xa9\xe3\xf6\xc7\xe8\xb8\x03\x62"
        "\x0d\x28\x87\x54\x39\xc9\xd0\x5e\xca\x5f\x13\xb7\xe4\x74\x08\xf8\x27"
        "\x48\x57\xa5\x11\x1b\x8b\xfb\x04\x2f\x96\x5d\x7f\x6b\x63\x91\x7a\x8a"
        "\x5b\xb2\xa8\x37\x15\xfb\x27\x7c\x8a\xe9\xe4\x5b\x13\x81\x21\x49\xfb"
        "\x37\x32\xe6\x00\x27\x6b\xc9\x8d\xe1\x60\x7e\xc2\x8c\x79\xfd\x13\x47"
        "\x34\xeb\xa4\x57\x6f\xaf\x84\x28\x4d\xcb\xeb\x9d\x77\x94\x19\x8f\x7f"
        "\x41\x8d\x89\x48\xe8\x2c\xdf\x9e\x9c\x15\xc4\x81\xf7\xc1\x67\x76\x57"
        "\x46\x05\x6f\x83\xf5\x94\xd3\x82\xf4\x23\x82\xef\x20\x9f\x53\x20\x3e"
        "\x33\x0f\x94\xd4\xef\x16\x2e\x2d\x15\xde\x59\x2c\xc5\xfa\x5f\x73\x43"
        "\x3b\x2d\x12\xa0\x6d\xea\x91\x42\x1e\x6d\x0e\xa2\x5c\x2c\x1c\x68\xfd"
        "\xf5\xb8\x80\x2e\xb9\x39\x84\x45\xf0\x9c\x11\xec\xa6\xf9\xec\xfe\xbf"
        "\xd5\x71\x31\x01\x6d\x60\x17\x9b\xe9\x24\x81\xa3\xb1\x2b\x5e\xf9\xe8"
        "\x0a\x25\x79\x55\x14\x07\x98\xcb\x88\xd4\xca\x78\xa5\x77\xb5\x67\xae"
        "\x30\x42\xcd\xed\x4b\x5e\x8f\x3f\x23\xe4\xbe\x7e\x4e\x11\x8b\xd3\x19"
        "\x06\xb1\x71\xd9\xfe\x4e\xb1\xba\xef\x21\x06\xef\xc4\x81\xc2\x3b\x4d"
        "\x20\x75\xcf\x53\xa2\x87\xf8\x06\x5d\xfd\x34\x53\xa1\x53\x4f\x90\x45"
        "\xb5\xdb\x3d\x8d\xa1\x8e\x5d\xe4\x5e\x52\x86\x2f\xb3\x59\x2e\xef\x68"
        "\xe6\x46\x55\xe4\x04\x9e\x22\xd0\xea\xaa\xc8\x49\x8f\x5d\x17\xbc\x99"
        "\xdd\x52\xc6\x80\x39\x18\xad\xb7\xe6\x03\x08\x53\x14\x34\xdc\x93\xb5"
        "\x45\xb8\x8a\xba\x82\x34\xb7\x1f\x3d\x4f\x5b\x5c\x63\x9d\x6a\xeb\x9d"
        "\x50\xef\x30\xc5\x84\xf8\x8a\xd6\x1d\x60\xac\x74\x95\x98\xb9\x5b\x17"
        "\x50\xe8\x54\x88\x96\x81\x63\x61\x7f\xf6\xaa\x03\x5f\x2d\xce\xe5\x8b"
        "\xcc\xa8\xde\xfd\x07\xd2\x84\x20\x77\xda\x8f\x18\xb0\x6f\xfb\xfa\x0c"
        "\x59\xda\x8e\x6b\x35\x94\xc5\xe3\x34\xc8\xba\x87\xf2\xe1\x35\xab\x49"
        "\x1d\x61\x38\xf8\xaf\x96\x3d\xda\x90\xa8\x63\x5a\xb0\x12\xa1\x04\xb8"
        "\x76\x09\x98\x4f\x41\x1d\xf2\xc9\x64\x91\xb6\x5c\x86\xd0\xa6\x3d\x34"
        "\xf2\x5f\xca\x1d\x23\x0a\xfc\x24\x23\xe0\x07\x82\xdd\xb3\x00\xcd\x42"
        "\x7a\x2e\x20\x08\xb5\x7a\xd2\xd6\x96\xd0\x0e\xc0\x96\xbd\xda\x60\x2a"
        "\x97\x6e\x1c\x3b\x24\x9d\x83\xd6\xf7\x41\xc4\x6d\x69\x76\xba\xcd\xfc"
        "\xc6\x2e\xda\xab\xc6\xd9\xa7\xdc\xb1\xfd\x0b\x0c\x8f\xe7\x2a\x5b\xd5"
        "\xf8\x20\x10\x44\xd6\x42\x34\x37\x6a\x18\x31\x76\x3d\xf5\xf8\x70\x89"
        "\x40\x7d\x61\x8b\x78\x87\x5e\xa5\x73\x03\xe5\x18\x0f\x0b\xc4\x09\xca"
        "\xd7\x2f\x48\x66\x45\xb5\x60\x51\x07\x70\x95\x28\x2f\x33\x41\x4b\x5a"
        "\x5b\xa9\x89\x24\xa4\xc9\xd9\x43\x76\x61\x3b\xb6\x33\x89\xa7\xbf\x37"
        "\xb2\x9c\x76\x81\x57\xf2\x7d\x2c\x46\xac\xc4\x7f\x6a\x54\x09\x47\xf9"
        "\xdb\xd3\x46\xf2\x79\x48\x60\xec\xe6\x17\x73\xb4\x8b\xd7\xbf\x6f\xc1"
        "\xdb\xce\x28\x5f\x6e\x68\xef\x52\xbf\xd6\x63\x0e\x82\xbe\x20\x0e\x94"
        "\xe1\x21\x46\x1e\xe7\xaa\x39\x48\xd6\x87\xef\xd1\x4b\xb7\xd3\xdf\x01"
        "\x17\xc7\xad\x0d\x94\x64\x51\xf0\x84\x09\x55\x1a\x74\x62\x17\x32\x0f"
        "\x08\x81\x57\x18\x55\x19\xef\xd8\x64\x55\x11\xb6\xbe\x24\xc8\x35\xd2"
        "\xb5\xe6\xee\x1a\x59\x2d\x58\xc9\x54\x8e\xbb\xaa\x8f\x9c\xb6\xf8\x74"
        "\x68\xfa\x31\xe5\x1b\x2c\xba\x69\x5e\x7d\x21\x35\x9e\x13\x59\xef\x25"
        "\x61\xd1\xfd\x66\x32\xe7\x8b\xf3\xe5\x8b\x57\x5f\xc9\xe3\x22\x83\xc3"
        "\xd7\x4d\xb0\x14\x2b\x38\x6a\xf2\x76\xe9\xf1\x4d\xf3\xa5\x52\xae\x4f"
        "\x41\xc6\x9b\x31\x1a\x7d\xca\x48\xd1\x56\xb5\x07\xa9\x96\x88\x5a\x3a"
        "\xe6\x58\x70\xf9\x18\xd5\x7b\x03\x08\xce\x66\x09\x02\x47\x67\x58\x15"
        "\x0f\x7c\x66\x01\xe0\xe8\x2e\xda\x30\x57\x16\xf1\x4c\xaf\x26\xf9\xde"
        "\xe9\x57\x19\x4a\xaf\xf9\x2a\x0f\xd1\xd2\xfc\xcd\x23\x34\x84\x1a\x1e"
        "\xd2\x70\xfb\xd0\x3a\x0f\x2d\x05\xc9\xbc\xd7\x43\x58\x72\x01\x2e\x96"
        "\xb8\xea\xe8\xac\x08\x62\x48\x28\x55\x02\x35\x55\xbd\xe4\xfb\x81\xbd"
        "\x85\x64\x57\x65\xa2\x5e\xe1\x42\xad\x09\xe7\x12\xa0\xdf\x23\x5d\xe9"
        "\x80\xd3\xda\xa4\xf0\xad\x9b\x01\x3f\x36\xa8\xb8\x69\x67\x14\x4c\x11"
        "\x4f\x38\xb3\x87\xb2\xf4\x97\xa2\xab\xed\xc6\xcc\xf4\xc8\x13\x05\x12"
        "\x33\x03\xf2\x31\xc9\xb0\xf3\xc8\xa5\xee\x44\x89\xae\x9e\x7e\x53\x18"
        "\x1a\xc5\x7e\x94\x11\x9c\xb8\x66\x24\x60\x9c\x0b\x60\x2c\xec\xd2\xb5"
        "\x43\xc0\xa0\x94\x68\xb0\x76\x52\x76\xcf\x40\xaf\x06\xae\x54\x8d\xba"
        "\xca\x40\xbd\x0c\x7b\x05\xa1\xee\x62\x0e\xe9\xd3\xfb\x77\xf1\x3e\x8f"
        "\xf6\xcb\x5c\xb0\xdc\xc6\x30\x1a\x96\x2c\x63\xad\x01\x47\xf1\x57\xf6"
        "\xf8\xe5\xf2\x75\x41\xc1\xff\x3b\x62\xe1\x85\x63\xb9\xa3\x71\x8d\xb8"
        "\x57\x9c\x30\xe4\xdc\xe6\xbf\x5c\xd4\xab\x94\x3b\x6a\x54\xde\x4b\x5e"
        "\xe6\x7e\xa1\x2c\xda\x7e\xd8\x7b\x5b\x72\x5b\x6e\x7e\xb2\x2e\xd8\x9b"
        "\x57\xd9\x21\xd5\x8b\xcf\x31\x01\xd3\xae\x0c\x9b\xfb\x61\x11\x84\x7b"
        "\x1f\x0c\xa0\x8a\xe1\xe8\x6a\x0c\x8d\x30\x24\x59\x6b\x7a\xcf\x2e\xaf"
        "\x58\xbc\x2e\xaf\x1b\xbe\xb9\xc1\xcd\xab\x32\x26\x65\x92\x50\xc0\x3e"
        "\xbb\x56\x46\xf2\x12\xff\x7c\x96\x7b\x83\x89\xd4\x0a\x86\x4d\xac\xf5"
        "\x6f\x60\xc7\x9a\xaa\x13\x6f\xd7\x0f\x7f\x5e\x0b\x4d\xdd\xf5\x3f\x58"
        "\xff\xb9\x9b\xc1\x7d\xd4\xd4\x1f\x37\xa6\x79\x71\x52\x1d\x41\xaf\xd5"
        "\x71\xde\x79\x4d\xa7\xd5\xc6\xaa\x0c\x03\x40\x73\x90\x99\xaf\x7b\x91"
        "\xc6\xaf\x89\xba\xf8\x48\x1c\xc7\xd5\xec\x38\x21\x27\x9d\x52\x38\xa9"
        "\xdc\x0d\x47\x69\x92\x05\x67\x27\x51\x4d\xad\x7b\x3c\x4b\x14\xff\xaa"
        "\x0a\x97\xf1\xc5\x40\xd5\x1b\x22\xba\x2d\xa8\x95\xe6\x33\x73\xdf\x4b"
        "\xfd\xa3\xac\x87\xac\xdc\x64\x02\x2a\x35\x3f\x02\x8a\xd5\xd7\xb4\xfb"
        "\x22\xb9\x92\x7c\xe3\xde\x14\x23\xad\x83\x1c\x7d\xb4\x1d\xbe\x10\x26"
        "\x39\x2f\x14\x33\x38\xcc\x97\x7c\xd1\x69\x0c\x64\xc4\xc9\xf5\xfe\xeb"
        "\x5b\x49\xd6\x76\x7e\x96\xdb\x74\x9e\x7a\x13\x95\x6c\x3a\xfb\x8a\xe2"
        "\xd2\x47\x75\x95\x3a\xee\x9c\x7e\x80\x9c\xe1\x66\xf0\x51\x43\xf8\xa4"
        "\x8b\x3f\x47\xf6\xba\x96\x29\x67\x17\x11\x6b\xd0\xd6\x78\xe3\x14\xf4"
        "\xc8\x12\x42\x80\x52\xad\x04\xd0\x15\x2d\x9d\x32\xfc\xcc\x5f\x78\xb6"
        "\x62\xab\xff\x86\x15\x39\x48\x34\xef\xaf\xb4\xe8\x30\xb8\x2a\xe4\x5a"
        "\xe7\xc2\xae\xa5\x98\x0d\x0b\xad\x66\x20\x5a\x82\x67\x2c\x2d\x82\xdb"
        "\xbc\x86\x9f\x17\x49\xc7\x07\x25\x2d\x04\xdd\xc3\xbb\x62\xf7\x46\xc5"
        "\xca\xeb\x63\xcf\x68\x11\x1c\x71\x1e\x76\xd7\x73\x1b\xc9\x43\xf6\x20"
        "\x40\x2d\x94\xcc\x18\x93\xc5\x21\xcf\x5e\xa0\x58\x5a\xaa\x36\x8c\x5e"
        "\xce\x9c\xee\x4a\x1f\xa3\xa3\xe9\xdf\x91\x1d\x5e\x45\x00\x95\x80\xb6"
        "\xa1\xf3\xb4\x53\x77\xd0\x8b\x74\x3a\xd6\x1b\xcf\xd9\x12\x85\xff\x40"
        "\x0c\x25\x35\x9c\x6b\xc8\x5a\x24\x0c\x4d\xcf\x6a\x01\xa0\xa2\x79\xa2"
        "\x09\xec\xda\x9f\xce\x28\xe8\xbb\x02\xde\x8b\x92\x16\xba\x0d\x17\xd0"
        "\xf9\x98\xa5\xeb\xbd\x54\x94\xce\x69\x3f\x82\x50\x51\xc3\x89\x5e\x67"
        "\xf0\xba\x5c\x3e\x69\xa9\xab\x08\xec\xc0\x88\x2e\xb1\xb8\x10\xef\xd9"
        "\xd7\x2c\xf7\xb9\x21\x7d\x56\x46\x1a\x4f\xbd\x25\x7e\x89\x48\x89\x0f"
        "\x88\x14\xaf\xfa\xd7\x1b\xa1\x3c\xa1\x8b\x4d\xc9\xd9\x2c\xdb\x90\xf2"
        "\x92\x49\x9a\xeb\x64\x7b\x9d\xa3\x2d\xd5\x2a\x9c\x31\x30\x0e\x50\x73"
        "\xaa\x2d\x2d\xa9\x04\xa3\x69\x25\xdf\x09\x50\xfa\xc6\xa2\xd5\x94\xf1"
        "\xba\xf8\x2c\xd9\xad\xb6\x5a\x06\x17\x06\x85\x94\x2a\xe2\xbe\xd4\xb9"
        "\x78\x62\xe6\x62\x67\x9b\x9c\x01\xd7\x60\x3d\x6d\x3f\xcd\xe9\x0f\xc1"
        "\x40\xa7\x1f\x82\x50\x2d\x48\x76\x02\x44\x6b\xb8\x68\xe6\xce\x5a\x5c"
        "\x59\x94\x01\xfa\x8a\xa4\x36\x85\xd7\x5c\xdd\x79\x1a\x94\x84\xcd\xd2"
        "\x94\xfc\xed\x37\x7e\x75\xac\x18\xd3\x30\xfb\x53\x92\x27\x6a\xce\xd8"
        "\x08\xab\x3a\x21\xfd\x3d\xed\x30\x9b\x9e\x8c\x4f\xb0\x17\xd8\xe5\xa7"
        "\x1d\x88\x5d\xbc\xf6\x52\xca\x08\x7b\x30\x51\x5c\x1a\x9c\x47\x87\x92"
        "\xb5\x1e\x8a\x30\xd6\x00\xa4\x96\xfb\x87\x83\x10\x3f\x39\xd9\x20\xaa"
        "\x54\x7b\xfc\x45\x1c\xc9\xd4\xa7\x02\x02\x8d\x27\x6a\xbb\x3c\x63\xf6"
        "\x76\xde\x0c\x11\x45\x48\x99\x3a\xd9\x44\x8d\x60\x03\xf4\x33\x5b\xbe"
        "\xa5\xbf\x43\xb2\xee\xfe\xc7\x25\x67\x18\xba\x14\x16\x01\x4d\x43\x57"
        "\xaf\x0d\x82\x32\x2b\xa2\xcb\xd3\xa6\x3f\xf9\x32\x0b\xbe\xff\x7a\x82"
        "\xde\x3f\x54\x49\x07\xcf\xf8\x92\x91\x2e\x4f\x67\x30\x16\x7b\x0d\xc9"
        "\xe5\xa4\x36\x69\x28\x80\xb0\x88\x6f\x14\x6a\x99\xc6\x7c\xd8\x62\x3c"
        "\xcf\xf7\x4b\xc5\x21\xa4\x7d\x28\x79\x04\x8a\x26\xbf\xeb\xc3\x8b\x33"
        "\x52\xbe\x51\xda\x2d\x20\x21\x1d\x43\x9d\x19\x77\x33\xf6\xb6\x08\xcd"
        "\xbd\x52\x75\xfe\x43\xba\x1a\x1e\xd0\x0c\x05\x71\xef\x74\xb8\x35\x53"
        "\x50\x53\xd7\x85\xdd\x7b\x31\x09\x3c\xd3\xea\x20\x40\x87\x43\x7f\x49"
        "\xaf\xdd\x25\x9f\x1f\x31\x94\x38\xc8\x46\x3d\x10\x44\xa7\x2d\xc4\x15"
        "\xf2\x83\xfc\x19\x0c\xf5\x74\x0c\xfd\xbb\x70\xd1\x41\x2c\xd7\x05\x1f"
        "\x7f\x99\xcc\x02\x65\x1b\xa7\xa9\xe4\x32\xa8\xb1\xb6\x3d\x27\xf1\xe3"
        "\x12\x51\xdf\x29\xd1\xb2\x25\x1e\xe9\xc6\x83\xe7\x36\x73\xc5\x7d\x7e"
        "\xb4\x28\x36\xc4\xdc\x51\xd4\x32\x34\xa9\xb2\x2d\x18\xa0\x3b\x5f\xd1"
        "\x5a\xbc\x44\xb7\x34\xb4\xc4\x60\xf9\xf3\xcd\x48\xda\x2a\x9d\xa9\x88"
        "\xbb\x71\xed\x1b\xbc\xf4\x3d\xef\x71\x46\xf9\xad\x67\x98\x4f\x08\x7c"
        "\x8a\x3b\xff\xdb\x70\xe5\xa0\xf4\xe4\x0f\xd0\xec\x2e\xa0\xe3\x7e\x7b"
        "\x62\x49\xa9\x23\x43\x0c\x5c\x0d\x26\xfd\x98\x70\xb6\x0a\xb5\xa0\xbb"
        "\x27\x3b\x82\xbc\x08\x46\x71\xa4\xe5\x2c\x3f\x3a\x3f\x30\xf3\x9c\xe5"
        "\x4b\x38\x63\x60\x97\xd6\x3a\xfa\x32\x34\xa8\xf1\x71\x1c\xf1\x1a\xdc"
        "\xf1\xcd\x60\x39\x48\xb3\x12\xc6\x42\x7d\x2c\x3a\x92\x5f\x22\xc3\x20"
        "\x91\x64\xc5\xb4\x04\xa3\xf4\xce\xeb\x02\x63\xf1\x16\x7a\x48\x01\xf5"
        "\xdd\xfe\xc7\x3e\x9b\xb6\x4e\xd2\xd5\x53\x8c\xf2\x4f\x60\xee\x70\x2a"
        "\x4a\x14\x99\x8f\x4e\x00\xdf\x99\xa8\x18\x96\x15\xfa\x03\x23\xb3\x0c"
        "\x6e\xf1\x90\x78\x10\x2a\x45\x0a\x35\x17\x63\xdd\xb3\x89\x22\x2f\xe4"
        "\xc5\x4d\x80\x53\x75\x4a\xce\xc5\x69\xd6\x96\xb1\xbb\x71\xd5\xd7\xc8"
        "\xb8\x5b\xa8\xdb\x22\x5c\xef\x3b\xae\xd3\x50\x61\x8c\x3a\x59",
        8192));
    NONFAILING(*(uint64_t*)0x20000c40 = 0);
    NONFAILING(*(uint64_t*)0x20000c48 = 0);
    NONFAILING(*(uint64_t*)0x20000c50 = 0);
    NONFAILING(*(uint64_t*)0x20000c58 = 0);
    NONFAILING(*(uint64_t*)0x20000c60 = 0x200002c0);
    NONFAILING(*(uint32_t*)0x200002c0 = 0x18);
    NONFAILING(*(uint32_t*)0x200002c4 = 0);
    NONFAILING(*(uint64_t*)0x200002c8 = 0);
    NONFAILING(*(uint32_t*)0x200002d0 = 9);
    NONFAILING(*(uint32_t*)0x200002d4 = 0);
    NONFAILING(*(uint64_t*)0x20000c68 = 0);
    NONFAILING(*(uint64_t*)0x20000c70 = 0);
    NONFAILING(*(uint64_t*)0x20000c78 = 0);
    NONFAILING(*(uint64_t*)0x20000c80 = 0);
    NONFAILING(*(uint64_t*)0x20000c88 = 0);
    NONFAILING(*(uint64_t*)0x20000c90 = 0);
    NONFAILING(*(uint64_t*)0x20000c98 = 0);
    NONFAILING(*(uint64_t*)0x20000ca0 = 0);
    NONFAILING(*(uint64_t*)0x20000ca8 = 0);
    NONFAILING(*(uint64_t*)0x20000cb0 = 0);
    NONFAILING(*(uint64_t*)0x20000cb8 = 0);
    NONFAILING(syz_fuse_handle_req(r[0], 0x200041c0, 0x2000, 0x20000c40));
    break;
  case 8:
    NONFAILING(*(uint16_t*)0x200001c0 = 0);
    NONFAILING(*(uint16_t*)0x200001c2 = 0);
    NONFAILING(*(uint64_t*)0x200001c8 = 0);
    NONFAILING(*(uint64_t*)0x200001d0 = 0x10001);
    NONFAILING(*(uint32_t*)0x200001d8 = 0);
    NONFAILING(*(uint32_t*)0x200001dc = 0);
    NONFAILING(memset((void*)0x200001e0, 0, 16));
    syscall(__NR_ioctl, r[1], 0x40305828, 0x200001c0ul);
    break;
  }
}
int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  install_segv_handler();
  loop();
  return 0;
}

--KvahmxHLtCjAe3ik
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="config-guest"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.18.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10)"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=80500
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23601
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23601
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=122
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION="-kvm"
# CONFIG_LOCALVERSION_AUTO is not set
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
CONFIG_DEFAULT_HOSTNAME="CannotLeaveINTEL"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
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
CONFIG_GENERIC_IRQ_CHIP=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
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
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
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
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
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
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=14
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
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
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
# CONFIG_BOOT_CONFIG is not set
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
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
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
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_NUMACHIP=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_XEN_DOM0=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
# CONFIG_INTEL_TDX_GUEST is not set
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
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
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
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_USER_INTERRUPTS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_X86_USER_SHADOW_STACK=y
CONFIG_INTEL_TDX_HOST=y
# CONFIG_INTEL_TDX_HOST_DEBUG is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
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
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="net.ifnames=0"
# CONFIG_CMDLINE_OVERRIDE is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

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
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
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
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
# CONFIG_CHTCRC_PMIC_OPREGION is not set
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_BXT_WC_PMIC_OPREGION=y
# CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

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
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
CONFIG_X86_SPEEDSTEP_CENTRINO=y
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
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
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
CONFIG_KVM_WERROR=y
CONFIG_KVM_INTEL=m
CONFIG_X86_SGX_KVM=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
# CONFIG_KVM_XEN is not set
CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y
CONFIG_KVM_MMU_PRIVATE=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

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
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
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
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
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
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
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
# CONFIG_SVOS is not set
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
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
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
CONFIG_ZSWAP=y
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
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVMAP_ACCESS_PROTECTION is not set
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_ARCH_HAS_SUPERVISOR_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_MEMFILE_NOTIFIER=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
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
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
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
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
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
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
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
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
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
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
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
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NFT_REJECT_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=m
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
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
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
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
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
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
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
CONFIG_IP_NF_TARGET_CLUSTERIP=m
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
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
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

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m
# end of DECnet: Netfilter Configuration

CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
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
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
CONFIG_RDS=m
CONFIG_RDS_RDMA=m
CONFIG_RDS_TCP=m
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_IB=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_NET_DSA=m
# CONFIG_NET_DSA_TAG_AR9331 is not set
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
# CONFIG_NET_DSA_TAG_HELLCREEK is not set
# CONFIG_NET_DSA_TAG_GSWIP is not set
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
# CONFIG_NET_DSA_TAG_KSZ is not set
# CONFIG_NET_DSA_TAG_OCELOT is not set
# CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set
CONFIG_NET_DSA_TAG_QCA=m
# CONFIG_NET_DSA_TAG_RTL4_A is not set
# CONFIG_NET_DSA_TAG_RTL8_4 is not set
CONFIG_NET_DSA_TAG_LAN9303=m
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=m
# CONFIG_NET_DSA_TAG_XRS700X is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
# CONFIG_IPDDP is not set
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
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
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
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
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
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
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
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
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
CONFIG_CAN_JANZ_ICAN3=m
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PCI=m
CONFIG_CAN_M_CAN_PLATFORM=m
# CONFIG_CAN_M_CAN_TCAN4X5X is not set
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_EMS_PCMCIA=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
CONFIG_CAN_MCP251X=m
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_ETAS_ES58X is not set
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=m
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_QCA=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_BCM=y
# CONFIG_BT_HCIUART_RTL is not set
CONFIG_BT_HCIUART_QCA=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_MTKUART is not set
CONFIG_BT_HCIRSI=m
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=m
CONFIG_NET_9P_RDMA=m
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=m
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
# CONFIG_NFC_VIRTUAL_NCI is not set
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
# CONFIG_NFC_PN532_UART is not set
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_UART=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_MRVL_SPI=m
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_ST_NCI_SPI=m
CONFIG_NFC_NXP_NCI=m
CONFIG_NFC_NXP_NCI_I2C=m
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
# CONFIG_NFC_S3FWRN82_UART is not set
CONFIG_NFC_ST95HF=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
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
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_EDR=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_XEN_PCIDEV_FRONTEND=m
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
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m
# CONFIG_PCIE_MICROCHIP_HOST is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCIE_DW_PLAT_EP is not set
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# CONFIG_PCI_J721E_HOST is not set
# CONFIG_PCI_J721E_EP is not set
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
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_CXL_REGION=m
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
# CONFIG_MHI_BUS is not set
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

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=m
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m

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
CONFIG_MTD_SWAP=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
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
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
CONFIG_MTD_PCI=m
CONFIG_MTD_PCMCIA=m
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=m
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
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
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=m
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_CADENCE is not set
# CONFIG_MTD_NAND_ARASAN is not set
# CONFIG_MTD_NAND_INTEL_LGM is not set

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
CONFIG_PARIDE=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=y
CONFIG_XEN_BLKDEV_BACKEND=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=y
CONFIG_NVME_TARGET_TCP=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HI6421V600_IRQ is not set
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_VMWARE_BALLOON=m
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_HISI_HIKEY_USB is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_BUS_DMA_TEST is not set
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_INTEL_MEI_GSC_PROXY=m
CONFIG_INTEL_MEI_IAF=m
CONFIG_VMWARE_VMCI=m
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
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
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=y
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
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_MPI3MR is not set
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_FLASHPOINT=y
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_XEN_SCSI_FRONTEND=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_QEDI=m
CONFIG_QEDF=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_EFCT is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
# CONFIG_PCMCIA_FDOMAIN is not set
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=3
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_INIC162X=m
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_DWC=m
CONFIG_SATA_DWC_OLD_DMA=y
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
CONFIG_PATA_CYPRESS=m
CONFIG_PATA_EFAR=m
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
CONFIG_PATA_NS87415=m
CONFIG_PATA_OLDPIIX=m
CONFIG_PATA_OPTIDMA=m
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
CONFIG_PATA_RADISYS=m
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=y
CONFIG_PATA_TOSHIBA=m
CONFIG_PATA_TRIFLEX=m
CONFIG_PATA_VIA=m
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PCMCIA=m
CONFIG_PATA_PLATFORM=m
# CONFIG_PATA_OF_PLATFORM is not set
CONFIG_PATA_RZ1000=m

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=y
CONFIG_PATA_LEGACY=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
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
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
CONFIG_SBP_TARGET=m
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_BAREUDP is not set
CONFIG_GTP=m
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_RIONET=m
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
CONFIG_TUN=y
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
CONFIG_SUNGEM_PHY=m
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=m
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=m
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E=m
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_ATM_SOLOS=m
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
# CONFIG_B53_SERDES is not set
# CONFIG_NET_DSA_BCM_SF2 is not set
# CONFIG_NET_DSA_LOOP is not set
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MV88E6060=m
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=m
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_MSCC_SEVILLE is not set
# CONFIG_NET_DSA_AR9331 is not set
# CONFIG_NET_DSA_SJA1105 is not set
# CONFIG_NET_DSA_XRS700X_I2C is not set
# CONFIG_NET_DSA_XRS700X_MDIO is not set
CONFIG_NET_DSA_QCA8K=m
# CONFIG_NET_DSA_REALTEK is not set
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
# CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_3C589=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=m
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_AMD_XGBE=m
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_CX_ECAT=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=m
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_THUNDER_NIC_PF=m
CONFIG_THUNDER_NIC_VF=m
CONFIG_THUNDER_NIC_BGX=m
CONFIG_THUNDER_NIC_RGX=m
CONFIG_CAVIUM_PTP=m
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4_DCB=y
CONFIG_CHELSIO_T4_FCOE=y
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_CHELSIO_IPSEC_INLINE=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=m
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=m
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_ICE_SWITCHDEV=y
CONFIG_ICE_HWTS=y
CONFIG_FM10K=m
CONFIG_IGC=m
CONFIG_JME=m
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
CONFIG_MLX5_ACCEL=y
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CLS_ACT=y
CONFIG_MLX5_TC_SAMPLE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
# CONFIG_MLX5_FPGA_IPSEC is not set
# CONFIG_MLX5_IPSEC is not set
CONFIG_MLX5_SW_STEERING=y
# CONFIG_MLX5_SF is not set
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=y
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=m
CONFIG_KS8851=m
CONFIG_KS8851_MLL=m
CONFIG_KSZ884X_PCI=m
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=m
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_ENCX24J600=m
CONFIG_LAN743X=m
# CONFIG_LAN966X_SWITCH is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
CONFIG_FEALNX=m
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=m
CONFIG_VXGE=m
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_PCMCIA_AXNET=m
CONFIG_NE2K_PCI=m
CONFIG_PCMCIA_PCNET=m
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_LL2=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_FCOE=y
CONFIG_QED_OOO=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=m
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
CONFIG_8139CP=m
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=m
CONFIG_SIS190=m
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=m
CONFIG_EPIC100=m
CONFIG_SMSC911X=m
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=m
# CONFIG_DWMAC_DWC_QOS_ETH is not set
CONFIG_DWMAC_GENERIC=m
# CONFIG_DWMAC_INTEL_PLAT is not set
CONFIG_DWMAC_INTEL=m
# CONFIG_DWMAC_LOONGSON is not set
CONFIG_STMMAC_PCI=m
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NIU=m
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=m
CONFIG_DWC_XLGMAC_PCI=m
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=m
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_VELOCITY=m
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=m
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
CONFIG_WIZNET_W5100_SPI=m
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=m
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=m
# CONFIG_MOTORCOMM_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
CONFIG_MICREL_KS8995MA=m
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_CAVIUM=m
CONFIG_MDIO_GPIO=m
# CONFIG_MDIO_HISI_FEMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_OCTEON is not set
# CONFIG_MDIO_IPQ4019 is not set
# CONFIG_MDIO_IPQ8064 is not set
CONFIG_MDIO_THUNDER=m

#
# MDIO Multiplexers
#
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
# end of PCS device drivers

CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
CONFIG_USB_NET_SR9800=m
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_CDC_PHONET=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_USB_RTL8153_ECM is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_ADM8211=m
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=m
# CONFIG_ATH5K_DEBUG is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_COMMON_DEBUG=y
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
CONFIG_ATH9K_DEBUGFS=y
CONFIG_ATH9K_STATION_STATISTICS=y
# CONFIG_ATH9K_DYNACK is not set
CONFIG_ATH9K_WOW=y
CONFIG_ATH9K_RFKILL=y
CONFIG_ATH9K_CHANNEL_CONTEXT=y
CONFIG_ATH9K_PCOEM=y
# CONFIG_ATH9K_PCI_NO_EEPROM is not set
CONFIG_ATH9K_HTC=m
CONFIG_ATH9K_HTC_DEBUGFS=y
CONFIG_ATH9K_HWRNG=y
CONFIG_ATH9K_COMMON_SPECTRAL=y
CONFIG_CARL9170=m
CONFIG_CARL9170_LEDS=y
# CONFIG_CARL9170_DEBUGFS is not set
CONFIG_CARL9170_WPC=y
CONFIG_CARL9170_HWRNG=y
CONFIG_ATH6KL=m
CONFIG_ATH6KL_SDIO=m
CONFIG_ATH6KL_USB=m
# CONFIG_ATH6KL_DEBUG is not set
# CONFIG_ATH6KL_TRACING is not set
CONFIG_AR5523=m
CONFIG_WIL6210=m
CONFIG_WIL6210_ISR_COR=y
CONFIG_WIL6210_TRACING=y
CONFIG_WIL6210_DEBUGFS=y
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
# CONFIG_ATH10K_AHB is not set
CONFIG_ATH10K_SDIO=m
CONFIG_ATH10K_USB=m
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=y
CONFIG_ATH10K_SPECTRAL=y
CONFIG_ATH10K_TRACING=y
CONFIG_WCN36XX=m
# CONFIG_WCN36XX_DEBUGFS is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_AT76C50X_USB=m
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_B43=m
CONFIG_B43_BCMA=y
CONFIG_B43_SSB=y
CONFIG_B43_BUSES_BCMA_AND_SSB=y
# CONFIG_B43_BUSES_BCMA is not set
# CONFIG_B43_BUSES_SSB is not set
CONFIG_B43_PCI_AUTOSELECT=y
CONFIG_B43_PCICORE_AUTOSELECT=y
# CONFIG_B43_SDIO is not set
CONFIG_B43_BCMA_PIO=y
CONFIG_B43_PIO=y
CONFIG_B43_PHY_G=y
CONFIG_B43_PHY_N=y
CONFIG_B43_PHY_LP=y
CONFIG_B43_PHY_HT=y
CONFIG_B43_LEDS=y
CONFIG_B43_HWRNG=y
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=m
CONFIG_B43LEGACY_PCI_AUTOSELECT=y
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
CONFIG_B43LEGACY_LEDS=y
CONFIG_B43LEGACY_HWRNG=y
# CONFIG_B43LEGACY_DEBUG is not set
CONFIG_B43LEGACY_DMA=y
CONFIG_B43LEGACY_PIO=y
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMSMAC=m
CONFIG_BRCMSMAC_LEDS=y
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
CONFIG_BRCM_TRACING=y
# CONFIG_BRCMDBG is not set
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_AIRO=m
CONFIG_AIRO_CS=m
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_IPW2100=m
CONFIG_IPW2100_MONITOR=y
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=m
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y

#
# Debugging Options
#
CONFIG_IWLWIFI_DEBUG=y
CONFIG_IWLWIFI_DEBUGFS=y
CONFIG_IWLWIFI_DEVICE_TRACING=y
# end of Debugging Options

# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
CONFIG_HOSTAP_FIRMWARE_NVRAM=y
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_HERMES=m
# CONFIG_HERMES_PRISM is not set
CONFIG_HERMES_CACHE_FW_ON_INIT=y
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_NORTEL_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_SPECTRUM=m
CONFIG_ORINOCO_USB=m
CONFIG_P54_COMMON=m
CONFIG_P54_USB=m
CONFIG_P54_PCI=m
CONFIG_P54_SPI=m
# CONFIG_P54_SPI_DEFAULT_EEPROM is not set
CONFIG_P54_LEDS=y
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=m
CONFIG_LIBERTAS_USB=m
CONFIG_LIBERTAS_CS=m
CONFIG_LIBERTAS_SDIO=m
CONFIG_LIBERTAS_SPI=m
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_LIBERTAS_MESH=y
CONFIG_LIBERTAS_THINFIRM=m
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=m
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
CONFIG_MWL8K=m
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=m
CONFIG_MT76_CORE=m
CONFIG_MT76_LEDS=y
CONFIG_MT76x02_LIB=m
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
CONFIG_MT76x2_COMMON=m
CONFIG_MT76x2E=m
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
# CONFIG_MT7921S is not set
# CONFIG_MT7921U is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WILC1000=m
CONFIG_WILC1000_SDIO=m
CONFIG_WILC1000_SPI=m
CONFIG_WILC1000_HW_OOB_INTR=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
CONFIG_RT2400PCI=m
CONFIG_RT2500PCI=m
CONFIG_RT61PCI=m
CONFIG_RT2800PCI=m
CONFIG_RT2800PCI_RT33XX=y
CONFIG_RT2800PCI_RT35XX=y
CONFIG_RT2800PCI_RT53XX=y
CONFIG_RT2800PCI_RT3290=y
CONFIG_RT2500USB=m
CONFIG_RT73USB=m
CONFIG_RT2800USB=m
CONFIG_RT2800USB_RT33XX=y
CONFIG_RT2800USB_RT35XX=y
CONFIG_RT2800USB_RT3573=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
# CONFIG_RT2X00_LIB_DEBUGFS is not set
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL8180=m
CONFIG_RTL8187=m
CONFIG_RTL8187_LEDS=y
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
CONFIG_RTL8XXXU=m
CONFIG_RTL8XXXU_UNTESTED=y
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=m
# CONFIG_RSI_DEBUGFS is not set
CONFIG_RSI_SDIO=m
CONFIG_RSI_USB=m
CONFIG_RSI_COEX=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_CW1200=m
CONFIG_CW1200_WLAN_SDIO=m
CONFIG_CW1200_WLAN_SPI=m
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WL1251=m
CONFIG_WL1251_SPI=m
CONFIG_WL1251_SDIO=m
CONFIG_WL12XX=m
CONFIG_WL18XX=m
CONFIG_WLCORE=m
# CONFIG_WLCORE_SPI is not set
CONFIG_WLCORE_SDIO=m
CONFIG_WILINK_PLATFORM_DATA=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_USB_ZD1201=m
CONFIG_ZD1211RW=m
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_WL3501=m
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_VIRT_WIFI is not set
CONFIG_WAN=y
CONFIG_LANMEDIA=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m
CONFIG_HDLC_X25=m
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300TOO=m
CONFIG_FARSYNC=m
CONFIG_LAPBETHER=m
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_AT86RF230=m
CONFIG_IEEE802154_AT86RF230_DEBUGFS=y
CONFIG_IEEE802154_MRF24J40=m
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ATUSB=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
CONFIG_IEEE802154_CA8210_DEBUGFS=y
CONFIG_IEEE802154_MCR20A=m
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
# CONFIG_WWAN_HWSIM is not set
# CONFIG_RPMSG_WWAN_CTRL is not set
# CONFIG_IOSM is not set
CONFIG_MTK_T7XX=m
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
CONFIG_XEN_NETDEV_BACKEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_USB4_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=m
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=m
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
CONFIG_KEYBOARD_SAMSUNG=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_CROS_EC=m
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
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
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADC is not set
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
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_UCB1400=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_PCAP=m
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
CONFIG_INPUT_ARIZONA_HAPTICS=m
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX77693_HAPTIC=m
CONFIG_INPUT_MAX8925_ONKEY=m
CONFIG_INPUT_MAX8997_HAPTIC=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_TWL4030_PWRBUTTON=m
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_TWL6040_VIBRA=m
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_PCAP=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=m
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
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
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
CONFIG_HYPERV_KEYBOARD=m
CONFIG_SERIO_GPIO_PS2=m
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
CONFIG_LEGACY_PTY_COUNT=0
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_KGDB_NMI=y
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_CONSOLE_POLL=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_APPLICOM=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
CONFIG_IPWIRELESS=m
# end of PCMCIA character devices

CONFIG_MWAVE=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
# CONFIG_TCG_TIS_SPI_CR50 is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_XEN=m
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
# CONFIG_XILLYBUS_OF is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_DEMUX_PINCTRL is not set
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
CONFIG_I2C_CCGX_UCSI=m
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
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
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=m
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
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=m
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_DMA is not set
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_DLN2=m
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=m
CONFIG_SPI_INTEL=m
CONFIG_SPI_INTEL_PCI=m
CONFIG_SPI_INTEL_PLATFORM=m
CONFIG_SPI_LM70_LLP=m
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
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

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_INTEL_PLATFORM is not set
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=m
CONFIG_PINCTRL_METEORPOINT=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
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
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=m
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_UCB1400=m
# CONFIG_GPIO_WHISKEY_COVE is not set
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=m
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=m
CONFIG_TEST_POWER=m
CONFIG_BATTERY_88PM860X=m
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_PCF50633=m
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_CROS_PCHG=m
# CONFIG_CHARGER_UCS1002 is not set
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
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
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
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
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
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
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
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LM25066_REGULATOR is not set
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
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
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
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
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m
CONFIG_SENSORS_XGENE=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC_LIB=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_BXT_PMIC_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
CONFIG_INTEL_MENLOW=m
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
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
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_MENZ069_WATCHDOG is not set
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
# CONFIG_MLX_WDT is not set
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=m
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=m
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_BLOCKIO=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_B43_PCI_BRIDGE=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_BLOCKIO=y
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
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_INTEL_PMC_BXT=m
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=m
# CONFIG_MFD_INTEL_M10_BMC is not set
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CROS_EC is not set
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX8998=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=m
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCAP=m
CONFIG_REGULATOR_PCF50633=m
# CONFIG_REGULATOR_PF8X00 is not set
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=m
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY7636A is not set
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_REDRAT3=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_SPI is not set
CONFIG_IR_STREAMZAP=m
# CONFIG_IR_TOY is not set
CONFIG_IR_TTUSBIR=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_RC_ATI_REMOTE=m
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_CROS_EC is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
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
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
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
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_VIDEO_CPIA2=m
CONFIG_USB_GSPCA=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
CONFIG_USB_GSPCA_DTCS033=m
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
CONFIG_USB_GSPCA_KINECT=m
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
CONFIG_USB_GSPCA_STK1135=m
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_GL860=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_USB_S2255=m
CONFIG_USB_STKWEBCAM=m
CONFIG_VIDEO_USBTV=m
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_ZR364XX=m

#
# Analog TV USB devices
#
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_STK1160_COMMON=m
CONFIG_VIDEO_STK1160=m

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
CONFIG_VIDEO_AU0828_RC=y
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_AS102=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
CONFIG_DVB_USB_ZD1301=m
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_VP7045=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
CONFIG_USB_MSI2500=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_MEYE=m
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=m
CONFIG_VIDEO_IVTV=m
CONFIG_VIDEO_IVTV_ALSA=m
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_MXB=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_COBALT=m
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_CX25821_ALSA=m
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7134_GO7007=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_DM1105=m
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NETUP_UNIDVB=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_PT1=m
CONFIG_DVB_PT3=m
CONFIG_DVB_SMIPCIE=m
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_VIDEO_IPU3_CIO2=m
# CONFIG_CIO2_BRIDGE is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_RADIO_SI4713=m
CONFIG_RADIO_SI476X=m
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_WL1273=m
CONFIG_USB_DSBR=m
CONFIG_USB_KEENE=m
CONFIG_USB_MA901=m
CONFIG_USB_MR800=m
CONFIG_USB_RAREMONO=m
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_USB_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
CONFIG_RADIO_WL128X=m
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
# CONFIG_VIDEO_MUX is not set

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
CONFIG_VIDEO_ASPEED=m

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#
CONFIG_VIDEO_CAFE_CCIC=m

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
# VIA media platform drivers
#
CONFIG_VIDEO_VIA_CAMERA=m

#
# Xilinx media platform drivers
#
# CONFIG_VIDEO_XILINX is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=m
# CONFIG_VIDEO_VICODEC is not set
# CONFIG_VIDEO_VIMC is not set
CONFIG_VIDEO_VIVID=m
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_TTPCI_EEPROM=m
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
CONFIG_SMS_SIANO_DEBUGFS=y
CONFIG_VIDEO_V4L2_TPG=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_IMX412 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9282 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
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
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_SONY_BTF_MPX=m
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_ISL7998X is not set
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_MAX9286=m
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
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
CONFIG_DVB_AS102_FE=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_GP8PSK_FE=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m
# CONFIG_DVB_CXD2880 is not set

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
CONFIG_DVB_AU8522_V4L=m
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
# CONFIG_DVB_MN88443X is not set
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
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
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
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_DP_HELPER=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_CMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DRM_AMD_DC_SI is not set
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

# CONFIG_HSA_AMD is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
# CONFIG_DRM_NOUVEAU_SVM is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE="*"
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

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
CONFIG_DRM_I915_PREEMPT_TIMEOUT=100
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_DSI_CM is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_EDP is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
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
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CHIPONE_ICN6211 is not set
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_CROS_EC_ANX7688 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NWL_MIPI_DSI is not set
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI83 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
CONFIG_TINYDRM_ILI9225=m
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
# CONFIG_DRM_XEN_FRONTEND is not set
CONFIG_DRM_VBOXVIDEO=m
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_BOOT_VESA_SUPPORT=y
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
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
CONFIG_FB_VGA16=m
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
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
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_HYPERV=m
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_BACKLIGHT_RAVE_SP is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
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
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_LOGO_LINUX_NEXT_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS300=m
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X_BOOL=y
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
# CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
CONFIG_SND_FIREWORKS=m
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
CONFIG_SND_FIREWIRE_MOTU=m
CONFIG_SND_FIREFACE=m
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_MQS is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_EASRC is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=m
# CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
# CONFIG_SND_SOC_INTEL_BYTCR_WM5102_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
# CONFIG_SND_SOC_INTEL_BXT_RT298_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
# CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH is not set
# CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH is not set
CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=m
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=m
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
CONFIG_SND_SOC_SOF_OF=m
CONFIG_SND_SOC_SOF_DEBUG_PROBES=m
CONFIG_SND_SOC_SOF_CLIENT=m
CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT=y
# CONFIG_SND_SOC_SOF_FORCE_PROBE_WORKQUEUE is not set
# CONFIG_SND_SOC_SOF_NOCODEC_SUPPORT is not set
# CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS is not set
CONFIG_SND_SOC_SOF_DEBUG=y
# CONFIG_SND_SOC_SOF_DEBUG_XRUN_STOP is not set
CONFIG_SND_SOC_SOF_DEBUG_VERBOSE_IPC=y
# CONFIG_SND_SOC_SOF_DEBUG_FORCE_IPC_POSITION is not set
CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE=y
CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE=y
# CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST is not set
# CONFIG_SND_SOC_SOF_DEBUG_IPC_MSG_INJECTOR is not set
# CONFIG_SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT is not set
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_INTEL_APL=m
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_INTEL_CNL=m
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE=m
CONFIG_SND_SOC_SOF_INTEL_ICL=m
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_JASPERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_TGL=m
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ALDERLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=y
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
CONFIG_SND_SOC_SOF_XTENSA=m

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
CONFIG_SND_SOC_AK4104=m
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=m
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_SPI is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
CONFIG_SND_SOC_INNO_RK3036=m
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM3168A_SPI=m
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
# CONFIG_SND_SOC_RT9120 is not set
CONFIG_SND_SOC_SDW_MOCKUP=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
# CONFIG_SND_SOC_TAS5805M is not set
CONFIG_SND_SOC_TAS6424=m
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=m
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
# CONFIG_SND_SOC_WM8904 is not set
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
CONFIG_SND_SOC_TPA6130A2=m
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
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
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
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
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
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
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=m
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
CONFIG_USBIP_VUDC=m
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC3_OF_SIMPLE=m
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_IMX=m
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_CHIPIDEA_TEGRA=m
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
# CONFIG_USB_SNP_UDC_PLAT is not set
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=m
CONFIG_USB_AMD5536UDC=m
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_NET2280=m
CONFIG_USB_GOKU=m
CONFIG_USB_EG20T=m
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_MAX3420_UDC is not set
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_NCM=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_PHONET=m
CONFIG_USB_F_EEM=m
CONFIG_USB_F_SUBSET=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_UAC1=m
CONFIG_USB_F_UAC1_LEGACY=m
CONFIG_USB_F_UAC2=m
CONFIG_USB_F_UVC=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=m
CONFIG_USB_CONFIGFS_SERIAL=y
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
CONFIG_USB_CONFIGFS_ECM_SUBSET=y
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
CONFIG_USB_CONFIGFS_PHONET=y
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
CONFIG_USB_CONFIGFS_F_MIDI=y
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
CONFIG_USB_AUDIO=m
CONFIG_GADGET_UAC1=y
# CONFIG_GADGET_UAC1_LEGACY is not set
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_ETH_EEM=y
CONFIG_USB_G_NCM=m
CONFIG_USB_GADGETFS=m
CONFIG_USB_FUNCTIONFS=m
CONFIG_USB_FUNCTIONFS_ETH=y
CONFIG_USB_FUNCTIONFS_RNDIS=y
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=m
CONFIG_USB_GADGET_TARGET=m
CONFIG_USB_G_SERIAL=m
CONFIG_USB_MIDI_GADGET=m
CONFIG_USB_G_PRINTER=m
CONFIG_USB_CDC_COMPOSITE=m
CONFIG_USB_G_NOKIA=m
CONFIG_USB_G_ACM_MS=m
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
CONFIG_USB_G_DBGP=m
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
CONFIG_USB_G_WEBCAM=m
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=m
CONFIG_TYPEC_CCG_HPI=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_WCOVE=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=m
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
CONFIG_TYPEC_MUX_INTEL_PMC=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SD8787 is not set
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_SDHCI_MILBEAUT is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=m
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA903X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MAX77693 is not set
# CONFIG_LEDS_RT4505 is not set
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_CXGB4=m
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_IRDMA is not set
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_QEDR=m
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_RDMA_RXE=m
# CONFIG_RDMA_SIW is not set
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
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
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
CONFIG_EDAC_IEH=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
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
CONFIG_RTC_DRV_88PM860X=m
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX8998=m
CONFIG_RTC_DRV_MAX8997=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_TWL4030 is not set
CONFIG_RTC_DRV_PALMAS=m
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_TPS65910=m
CONFIG_RTC_DRV_RC5T583=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=m
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_WM8350=m
CONFIG_RTC_DRV_PCF50633=m
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_PCAP=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IDXD_BUS=y
CONFIG_INTEL_IDXD=m
CONFIG_INTEL_IDXD_COMPAT=y
CONFIG_INTEL_IDXD_SVM=y
CONFIG_INTEL_IDXD_PERFMON=y
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=m
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=m
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
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=m
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_MLX5_VFIO_PCI is not set
CONFIG_VFIO_MDEV=y
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VBOXGUEST=m
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_ACRN_HSM is not set
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=m
CONFIG_XEN_GRANT_DEV_ALLOC=m
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCI_STUB=y
CONFIG_XEN_PCIDEV_BACKEND=m
CONFIG_XEN_PVCALLS_FRONTEND=m
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_SCSI_BACKEND=m
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=y
CONFIG_XEN_MCE_LOG=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_UNPOPULATED_ALLOC=y
# end of Xen driver support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
CONFIG_COMEDI_AIO_AIO12_8=m
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
CONFIG_COMEDI_ADDI_APCI_1564=m
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
CONFIG_COMEDI_RTD520=m
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
CONFIG_PRISM2_USB=m
CONFIG_RTL8192U=m
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
CONFIG_RTL8723BS=m
CONFIG_R8712U=m
CONFIG_R8188EU=m
CONFIG_RTS5208=m
CONFIG_VT6655=m
CONFIG_VT6656=m

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=m
CONFIG_ADIS16240=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=m
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=m
# end of Capacitance to digital converters

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
CONFIG_ADE7854_I2C=m
CONFIG_ADE7854_SPI=m
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
# CONFIG_VIDEO_MAX96712 is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_IPU3_IMGU is not set
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_SP8870=m
# CONFIG_STAGING_BOARD is not set
CONFIG_LTE_GDM724X=m
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORNIC=m
CONFIG_UNISYS_VISORINPUT=m
CONFIG_UNISYS_VISORHBA=m
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_FB_TFT is not set
# CONFIG_MOST_COMPONENTS is not set
CONFIG_KS7010=m
CONFIG_GREYBUS_AUDIO=m
# CONFIG_GREYBUS_AUDIO_APB_CODEC is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m
CONFIG_PI433=m
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
CONFIG_QLGE=m
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
CONFIG_MXM_WMI=m
CONFIG_PEAQ_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
CONFIG_ASUS_WIRELESS=m
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
CONFIG_GPD_POCKET_FAN=m
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
CONFIG_IBM_RTL=m
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_IFS=m
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m
CONFIG_INTEL_PMT_WATCHER=m

#
# Intel PnP excursion monitor
#
CONFIG_INTEL_TPMI_PEM=m
# end of Intel PnP excursion monitor

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_TPMI=m
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TELEMETRY is not set
CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=m
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
# CONFIG_INTEL_CHTWC_INT33FE is not set
# CONFIG_INTEL_ISHTP_ECLITE is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SDSI=m
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_INTEL_HPM_DIE_MAP=m
CONFIG_INTEL_TPMI=m
CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_VSEC=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_X86_ANDROID_TABLETS is not set
CONFIG_INTEL_IPS=m
CONFIG_INTEL_SCU_IPC=y
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_ISHTP is not set
# CONFIG_CROS_EC_SPI is not set
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_EC_TYPEC=m
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_WILCO_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE3_WMI=m
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=m
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=m
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=m
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
# CONFIG_AMD_IOMMU_DEBUGFS is not set
CONFIG_DMAR_TABLE=y
CONFIG_DMAR_PERF=y
CONFIG_DMAR_DEBUG=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_DEBUGFS=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
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
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m
# CONFIG_SOUNDWIRE_QCOM is not set
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m

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
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

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
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
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
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_AXP288=m
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
# CONFIG_EXTCON_USBC_TUSB320 is not set
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
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA220=m
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
# CONFIG_SCA3300 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
CONFIG_AD7192=m
CONFIG_AD7266=m
CONFIG_AD7280=m
CONFIG_AD7291=m
# CONFIG_AD7292 is not set
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
# CONFIG_AD7949 is not set
CONFIG_AD799X=m
# CONFIG_ADI_AXI_ADC is not set
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_DLN2_ADC=m
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
# CONFIG_MCP3911 is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
# CONFIG_TI_TSC2046 is not set
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VF610_ADC is not set
CONFIG_VIPERBOARD_ADC=m
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=m
# CONFIG_ADA4250 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=m
CONFIG_IAQCORE=m
# CONFIG_PMS7003 is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

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
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
# CONFIG_LTC2688 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=m
# CONFIG_AD5758 is not set
CONFIG_AD5761=m
CONFIG_AD5764=m
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
CONFIG_AD5791=m
# CONFIG_AD7293 is not set
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_CIO_DAC=m
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=m
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Filters
#
# CONFIG_ADMV8818 is not set
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
# CONFIG_ADF4371 is not set
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
# CONFIG_ADXRS290 is not set
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
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
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
# CONFIG_HDC2010 is not set
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_AS73211 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=m
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
# CONFIG_TSL2591 is not set
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
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
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=m
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=m
CONFIG_MCP4531=m
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=m
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
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_CROS_EC_MKBP_PROXIMITY is not set
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=m
CONFIG_SRF04=m
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=m
CONFIG_SRF08=m
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TMP117 is not set
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=m

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CRC is not set
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_DWC=m
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m
CONFIG_PWM_TWL=m
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_INTEL_RAPL_TPMI is not set
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_OF_PMEM=m
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
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

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
# CONFIG_FPGA_MGR_ICE40_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=m
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=m
# CONFIG_MOST_USB_HDM is not set
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_SND is not set
# CONFIG_PECI is not set
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
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
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
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=y
CONFIG_FUSE_DAX=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
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
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
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
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=y
CONFIG_PNFS_FLEXFILE_LAYOUT=y
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
CONFIG_NFS_V4_1_MIGRATION=y
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
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
CONFIG_NFSD_FLEXFILELAYOUT=y
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
CONFIG_CIFS_FSCACHE=y
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
CONFIG_CODA_FS=m
CONFIG_AFS_FS=m
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
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
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
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
CONFIG_NLS_UTF8=y
CONFIG_DLM=m
# CONFIG_DLM_DEBUG is not set
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
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=0
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
CONFIG_SECURITY_SMACK_NETFILTER=y
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
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
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_EVM_EXTRA_SMACK_XATTRS=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
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
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
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
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM3=m
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
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
CONFIG_XZ_DEC_TEST=m
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
CONFIG_BCH_CONST_PARAMS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
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
CONFIG_DMA_COHERENT_POOL=y
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
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
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
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=m
# end of Library routines

CONFIG_PLDMFW=y
CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
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
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_BTF is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
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
CONFIG_KGDB=y
CONFIG_KGDB_HONOUR_BLOCKLIST=y
CONFIG_KGDB_SERIAL_CONSOLE=y
# CONFIG_KGDB_TESTS is not set
CONFIG_KGDB_LOW_LEVEL_TRAP=y
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_KEYBOARD=y
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_SCF_TORTURE_TEST=m
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=100
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
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
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
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
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
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
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=m
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# CONFIG_PKS_TEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--KvahmxHLtCjAe3ik
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="bisect_info.log"

git bisect start
# bad: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
git bisect bad f0c4d9fc9cc9462659728d168387191387e903cc
# good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect good f40ddce88593482919761f74910f42f4b84c004b
# good: [4817c37d71b554fe46ea494f6b2c8562b26640bf] Merge tag 'drm-intel-gt-next-2021-12-23' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good 4817c37d71b554fe46ea494f6b2c8562b26640bf
# good: [c011dd537ffe47462051930413fed07dbdc80313] Merge tag 'arm-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good c011dd537ffe47462051930413fed07dbdc80313
# good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag 'mm-stable-2022-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
# good: [7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf] Merge tag 'drm-next-2022-10-05' of git://anongit.freedesktop.org/drm/drm
git bisect good 7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf
# good: [ef688f8b8cd3eb20547a6543f03e3d8952b87769] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good ef688f8b8cd3eb20547a6543f03e3d8952b87769
# good: [f311d498be8f1aa49d5cfca0b18d6db4f77845b7] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good f311d498be8f1aa49d5cfca0b18d6db4f77845b7
# good: [e97eace635a42da4644290179aea496178e64988] Merge tag 'iommu-fixes-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect good e97eace635a42da4644290179aea496178e64988
# good: [2eb824f68d8c33e05f2003773f44ae2eae5892d0] Merge tag 'mtd/fixes-for-6.1-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect good 2eb824f68d8c33e05f2003773f44ae2eae5892d0
# good: [f4298cac2bfcced49ab308756dc8fef684f3da81] Merge tag 'kvmarm-fixes-6.1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD
git bisect good f4298cac2bfcced49ab308756dc8fef684f3da81
# bad: [fde25beb382b7dd6f2eab8022ab017cbdfaa3ff6] Merge tag 'drm-fixes-2022-11-04-1' of git://anongit.freedesktop.org/drm/drm
git bisect bad fde25beb382b7dd6f2eab8022ab017cbdfaa3ff6
# good: [9521c9d6a53df9c44a5f5ddbc229ceaf3cf79ef6] Merge tag 'net-6.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 9521c9d6a53df9c44a5f5ddbc229ceaf3cf79ef6
# good: [980a2ff2cb987e2177a1bd02633f4259a0d1daab] Merge tag 'amd-drm-fixes-6.1-2022-11-02' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
git bisect good 980a2ff2cb987e2177a1bd02633f4259a0d1daab
# bad: [ee6050c8af96bba2f81e8b0793a1fc2f998fcd20] Merge tag 'ata-6.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
git bisect bad ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
# good: [eb81b682b131642405a05c627ab08cf0967b3dd8] btrfs: fix inode reserve space leak due to nowait buffered write
git bisect good eb81b682b131642405a05c627ab08cf0967b3dd8
# good: [f2f32f8af2b0ca9d619e5183eae3eed431793baf] Merge tag 'for-6.1-rc3-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good f2f32f8af2b0ca9d619e5183eae3eed431793baf
# bad: [7f7bac08d9e31cd6e2c0ea1685c86ec6f1e7e03c] Merge tag 'fuse-fixes-6.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
git bisect bad 7f7bac08d9e31cd6e2c0ea1685c86ec6f1e7e03c
# bad: [4a6f278d4827b59ba26ceae0ff4529ee826aa258] fuse: add file_modified() to fallocate
git bisect bad 4a6f278d4827b59ba26ceae0ff4529ee826aa258
# good: [9fa248c65bdbf5af0a2f74dd38575acfc8dfd2bf] fuse: fix readdir cache race
git bisect good 9fa248c65bdbf5af0a2f74dd38575acfc8dfd2bf
# first bad commit: [4a6f278d4827b59ba26ceae0ff4529ee826aa258] fuse: add file_modified() to fallocate
|1117_144354|/root/bzimage_bisect/make_bz.sh -k /root/os.linux.intelnext.kernel -m f0c4d9fc9cc9462659728d168387191387e903cc -b 4a6f278d4827b59ba26ceae0ff4529ee826aa258 -d /home/bzimage -o /tmp/kernel -f /home/bzimage/bzImage_f0c4d9fc9cc9462659728d168387191387e903cc_4a6f278d4827b59ba26ceae0ff4529ee826aa258_revert|
|1117_151825|/root/image/centos8_3.img -> /root/image/centos8_2.img|
|1117_151844|Run /home/bzimage/bzImage_f0c4d9fc9cc9462659728d168387191387e903cc_4a6f278d4827b59ba26ceae0ff4529ee826aa258_revert with image:/root/image/centos8_2.img in local port:10022|
|1117_151909|CMD=ssh -o ConnectTimeout=1 -o 'StrictHostKeyChecking no' -p 10022 localhost 'rm -rf file*'|
|1117_151909|CMD=scp -o 'StrictHostKeyChecking no' -P 10022 /root/bzimage_bisect/repro.sh root@localhost:/root/repro.sh|
|1117_151910|CMD=scp -o 'StrictHostKeyChecking no' -P 10022 /root/syzkaller/workdir/crashes/b9740c7ed8efbb38631af7d0d93ca3c778b2f53b/repro.cprog root@localhost:/root/repro.c|
|1117_151912|CMD=ssh -o ConnectTimeout=1 -o 'StrictHostKeyChecking no' -p 10022 localhost 'ls /root/repro.sh'|
|1117_152140|/home/bzimage/bzImage_f0c4d9fc9cc9462659728d168387191387e903cc_4a6f278d4827b59ba26ceae0ff4529ee826aa258_revert didn't contain notify_change: in dmesg, pass|
|1117_152140|Bisect successfully! f0c4d9fc9cc9462659728d168387191387e903cc_4a6f278d4827b59ba26ceae0ff4529ee826aa258_revert bzimage passed!|

--KvahmxHLtCjAe3ik--
