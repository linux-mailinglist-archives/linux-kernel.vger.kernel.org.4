Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464D64C468
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiLNHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLNHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:35:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9017588
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671003358; x=1702539358;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BI0xnaBq4jMYAJDRLIfJyLzmxbgjXQHtrLZCWKQO8+Q=;
  b=UVhMTIcsQXqCbI0PiPXSPtq0FFnBQV1Og2t2U39+PRi6b5GN1b0mfoGY
   gYqP2OyTeULSBXiDFdBQ5F7QOITPotind2JMnGj8Kv6Q/+HJgDthz4bZK
   S1UzJBepVdjl365l1ST64gbmW1tmEGZFzk6BFkRHrC98sI2oqNTgjYmOZ
   yZKFsEHbUmI8qnxJX7XNzkoCdFN28YDxGexPPv/CDg8ZRnuM4VqFHBG/S
   zXyNl2amzDHCTEOHOLX9tze+NsONGhq0MbV9SfsHpSdteQeXd73Hg8TmP
   4daFtCFyuhFBOQE6KIsmZrW1wyQdccsrh1/W7yoeLZUKkc3G1bq+eBhXk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="317034379"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="317034379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823179331"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="823179331"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2022 23:35:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 23:35:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 23:35:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 23:35:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 23:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDB/RdFICI0Y7q3VtmGC6rJZnHWfatYDudWaf4jMuvc1CyaZ5r+VM6J409gfdllXUL2FBVLwKHn/0cm3lhg7RpdZ8gh8XTBnQmzaonoIAz4rzPKqsuY1xnhWFHD2etNsADRR4dJH15KAw79h72OBZOWMWgqEmPhhwKkSsHftOdgCzmNdVRoMVCVl3A9mwdcYb+xZeeeOgfTNx9DR+020NkGvj3GQLzZh/joSgOifcTWwu/Z2n7dLCwWM7i13hkb+HGu3dNY61sqD67ZlsKbGbBeRUtEdpY1W2rJE4Mv4JGS3C3IkTD34W9q5vAw8KmidmWs7hnxkRnhQaGrfX5vCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGTKVjoNcx6WqiusoKhyVXmtQWZRzozYUiwTowfeLA0=;
 b=hCy3fEPNZ1fBIyB8ab+CUq++snam1KMw9faBctwQiQSZrcougeGyGq7rRv5QG2s3DN+j+eJWZyNa/JVdhikVz6+uurG5GUTnB4qyZMXcbc0tRwBs+0DR0ekYLeG1i6yuz3dPgSjYn+5QEaYm+PC7mp9Kq5l9xar+9Y5k+w6GtUHDxapOQ19Zc9dUMek/VeZLo5jqSCL1KaOVdojc/eC+bSAS3inJUy9Q3qeQrAhISZ30QSiviSBB6FcZq83MA0uYoQ4Efv5s126VGRrhAEQ0iHAE+COBQe9sibQwiBOxT7BxysOm30Csh41TH/Rls/y8cIAB3Hkl1y9suZFp/XXg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 07:35:43 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 07:35:42 +0000
Date:   Wed, 14 Dec 2022 15:36:15 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>, <linux-mm@kvack.org>
Subject: [Syzkaller & bisect] There is "copy_page_range WARNING" in v6.1-rc8
 and v6.1
Message-ID: <Y5l871w6bwDnJ9HD@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe31df3-aeb0-4d14-9c2e-08dadda5cd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLALbSjgy0M1oA96dYG9OC+AFdgSR1uWiSv5AMb0+2HH0mDs/fenlVZ4Tlg+RBOfZRtCyhhcbDCL3fv/JJ1sC6c+eMhdv8AguztcQIJimec97Oi825D9qNN0WfA3UugQTgaGGjLYrWQgIcgk6UUqMZka8+M40fstxEQr72D08bcNAk8YoAOLjNeR71SFdAXz+LupQo6h8xImrjd2jS4TvP/Bh+h/TqUM4FJv850jZ/JMrV5XOUPDN9RgZpwxmjhiHjlg4vhRERcjxCQHshw2nqkZZrVNSOsG2hxVEv+aolgYtxusAd0o6Y69G0E6QuymwFMVRnx80130BAJfrTJBpVPST++Gzyo4k/5Um+oca8acZrbbHD6Jz4f265FGWbBSc4H9JIIfSL818xirzINkQPS4oTq5cQuVNT0mDp0HFKjOqFZTqqPmwdFAEEQJ8r9m4QdXOSblWWBfkrbwr4JOJHQiJf/GcsYDbPMglCwJRXOrrSzHT+2+0og1lqCg2dUlVSoXWkx7cOJ1L1I/c5dX6k6szVEk4e//NQD4J/dwXX1zaty7nCTEqolZTFuK5KKwcVWMuhkUnlPtcLcAC8tfaPjFKMt7AWpKaJrFZTd0HhSCGGycrstKoINwPkVG4vqFhrHOROw20vgE+3POMop3M8RQ9f4Vv0UwJcfKuseCxQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(82960400001)(6666004)(316002)(86362001)(38100700002)(4326008)(8676002)(66556008)(44832011)(6916009)(478600001)(5660300002)(66476007)(41300700001)(8936002)(2906002)(45080400002)(26005)(6486002)(186003)(966005)(83380400001)(6512007)(6506007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5uN4f6RPfYvX4Ix0Rc3ZofcyUwDgNjCwF4lw99YV4Szcrb1i93FHTYFQGlS?=
 =?us-ascii?Q?odvGgA96lkCtMd1fu61lIpw6auSy6aG5hz9BBQs2DQBxEbxQRLEkIMYcPCId?=
 =?us-ascii?Q?L9J5WMCXPtwVh8Fv2mOhklN6GpH9SycocBEa76cBv0AQdbc2uFzTzlCGTuG6?=
 =?us-ascii?Q?ryP9OfzdkctmiVCT/BKBcx5VzLBhXHOikU70CIbkpB5NsqPrBJnoleUv6aJy?=
 =?us-ascii?Q?vrDgc+hCdCSV5OaUzbJEoMGVpjpahFqaA0U3fzqskILcD0DBRUJvg8QgC01u?=
 =?us-ascii?Q?LMWSgrvhhD/ELd2xCWhVECxAiAM9ZhV1DkJLd6idUqmqWvYFZWOvkwDWkmfd?=
 =?us-ascii?Q?jOwRTCIOwzW7nv/rhMzyGCVclXaRbRmhBS1tgqDOR5GlqOFVjNCVobl2xQlN?=
 =?us-ascii?Q?mdMSX4SpjjHYefB8kP2ai190FdLIFLknX077axHpbc0ZMVNbDXsuRZLwWZVD?=
 =?us-ascii?Q?srCxYq1e1eNU2jrtz35mdB+Nk1CFwISzOcZsmNZQ882f7C+ya8wwZuYC7Mpf?=
 =?us-ascii?Q?jwxbtDiGAEh6TYcy8Gx1JOk1OALyz1dbMZ8wwQ/xXGumoTVYmVj0z2L9IS3O?=
 =?us-ascii?Q?e3PulzZmYxXjjLIFRqP7bF5lSwBGpPgaFOF5fAGKd7cOYiDEjQQVIrfQz/4X?=
 =?us-ascii?Q?eS/DXTWgrS+n6DV6q3JUmHcq8g6i5FdcSdTWchbjbnp1HsJ4DHershXDkxE/?=
 =?us-ascii?Q?XmipVaVVWzP52tH3EJlFr60KtnwggOnJ++FT/U8rekn/f9aboIomHa31z4rY?=
 =?us-ascii?Q?H9t+GbXyKNPp8k9sXk5s/rKVz7YUuqCSBhJh7WjGN6FB5TXfoLVGGaGW2PkK?=
 =?us-ascii?Q?RgK3+uNa3pzcw3sJxBb7wiVfl/DOFv1vcGyM0OiXjQrk6tZIYEwgM/VgWu64?=
 =?us-ascii?Q?2rLea9TbFsuF/H3XOf+hb7HSY7r89B8a+KLPdWzGkzGnHVFtJF1dpyxTVYj+?=
 =?us-ascii?Q?+NjPwO6KqzO4AOWLDU8+4DHL1pech+zNsvxv94AFRJf+YSpXXKP5NuAn7iYW?=
 =?us-ascii?Q?gfDY5YEi9akBCXYHeez/ytJpdJCYW6fMq1e0Rf4368LozlzBs/WHNs4Yb1NV?=
 =?us-ascii?Q?0FB4Sv47i94kzQ15vs4QRxMTjZ5VhkN4PQ5fi8XJVMVO6Sxtk80SJlDN8eLq?=
 =?us-ascii?Q?rFpivjTGmsjXmk72NqyYojn/rQm7zUzDbZcXQT2j/NZ2dvFaLow84Br9kkql?=
 =?us-ascii?Q?qPfr6bh9hSWQqFnqlHVvaTlEurcJ/xXnk1kQyCLTePH+vr/x7Nbe+JLA3G01?=
 =?us-ascii?Q?Sok88loRnSGXZAZzDnRCOvGKNu1vDaL348Bqkl8GgIf3rJx0Ok5/kyHEDhAj?=
 =?us-ascii?Q?RbH8M7J9+5oalFfFtdyklpEhF3FocdqUu7cPpyKqNM4sV/ciZP3HGLW57+IH?=
 =?us-ascii?Q?+5KmGzJ3xQvwwcqB+xMrZra07tU8NR6tOd3L66VLCZOg4IPfYRjpIwehKzrQ?=
 =?us-ascii?Q?35J9A55mIiFO0WiBTdhX9Hc5TgiKRNr5X17xMS+3l4ZE5x6SLn0QQRio2P39?=
 =?us-ascii?Q?hqqH4/fB7QVC73dG8atIgpAsboN2gFwKm9+wC1CX5angNmXuYquyGAy3kwzA?=
 =?us-ascii?Q?hGRRldygZEf21e3N0ltefT5xW3bHmYt8TjwzdQiKOy6RIN54Zhw8HTV8XJuY?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe31df3-aeb0-4d14-9c2e-08dadda5cd0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 07:35:42.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyjlP9fxVaTH9wUV2belSyfZM2fe3MsBt/vkCCPN4MwkM4v0JrtOF2Z/sCzFyVwRUZ1YNw2SlLJPDxQWnArX6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and memory expert,

It's a soft remind.
There is "copy_page_range WARNING" in v6.1-rc8 and v6.1.
[   28.138268] ------------[ cut here ]------------
[   28.138277] WARNING: CPU: 1 PID: 568 at mm/memory.c:874 copy_page_range+0x1858/0x2960
[   28.139002] Modules linked in:
[   28.139219] CPU: 1 PID: 568 Comm: repro Not tainted 5.19.0-rc1-6ff40f00e5a4+ #1
[   28.139706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   28.140306] RIP: 0010:copy_page_range+0x1858/0x2960
[   28.140584] Code: 5b e2 ff 41 83 fc 1e 0f 85 b1 fe ff ff e8 00 5a e2 ff 31 ff 4c 89 ee e8 26 5b e2 ff 4d 85 ed 0f 85 b6 fe ff ff e8 e8 59 e2 ff <0f> 0b e9 aa 5
[   28.141550] RSP: 0018:ffffc90000c9baf0 EFLAGS: 00010246
[   28.141838] RAX: 0000000000000000 RBX: f7fffffffffffc00 RCX: ffffffff81415aba
[   28.142229] RDX: 0000000000000000 RSI: ffff888007e28000 RDI: 0000000000000002
[   28.142612] RBP: ffffc90000c9bc98 R08: 0000000000000040 R09: 0000000000000000
[   28.142996] R10: 0000000000000001 R11: ffffea00002ab580 R12: 000000000000001e
[   28.143405] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000000
[   28.143905] FS:  00007f5b23733740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   28.144335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.144648] CR2: 00000000200000c0 CR3: 0000000007d5c005 CR4: 0000000000770ee0
[   28.145032] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.145413] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   28.145791] PKRU: 55555554
[   28.145946] Call Trace:
[   28.146097]  <TASK>
[   28.146242]  dup_mm+0x689/0x900
[   28.146436]  copy_process+0x1ade/0x23e0
[   28.146656]  ? __sanitizer_cov_trace_pc+0x25/0x50
[   28.146928]  kernel_clone+0x90/0x670
[   28.147152]  ? userfaultfd_ioctl+0xd2/0x23c0
[   28.147491]  __do_sys_clone+0xa2/0xd0
[   28.147779]  __x64_sys_clone+0x2f/0x40
[   28.148023]  do_syscall_64+0x3b/0x90
[   28.148243]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   28.148538] RIP: 0033:0x7f5b2385859d
[   28.148749] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   28.149722] RSP: 002b:00007ffc5a2e6b58 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
[   28.150133] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5b2385859d
[   28.150555] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000001000
[   28.150938] RBP: 00007ffc5a2e6ba0 R08: 0000000000000000 R09: 0000000000000000
[   28.151340] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401060
[   28.151846] R13: 00007ffc5a2e6ca0 R14: 0000000000000000 R15: 0000000000000000
[   28.152230]  </TASK>
[   28.152363] ---[ end trace 0000000000000000 ]---

This issue could be reproduced in v6.1 kernel in guest also.

Bisected and found that bad commit was:
"
81e0f15f2ef6dad7ccb9c03d8e61ef7ded836b38
mm: enable PTE markers by default
"

After reverted above commit on top of v6.1-rc8 kernel, this issue was gone.

All detailed bisect info, reproduced code and kconfig are in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221208_115556_copy_page_range


If the info was helpful and it's fixed, please added the Reported tag from me.

Thanks!
BR.
