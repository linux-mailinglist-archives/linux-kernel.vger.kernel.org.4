Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F586AE43B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCGPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCGPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:15:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C138C82C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678201874; x=1709737874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A8DOomOslIqDM3xKCh7amKNFwlb7O3CGNuiuxHVz2Cg=;
  b=nrYgx8lR27qjXMDEPP5swnLZo3R939rEpnUmQvOBnNbVV7thPiJWWp1/
   WfUvFd8+yMmZrCxKwOgvJv9dFTMvzI1xELlPAbFWPt5Z5BpclKPW9cum9
   iboeoLS4/thjgj1ONsVJvyJrq6u0sGOrbP4CaNBSRMGb8PDbtNog+e5K4
   3vwbI0NXe1FVCHx+PNqYaIu+Px1MsiT4yOZUtAUCs/jYzavtum5tMvhG1
   95b4QzT5bV3JHzpQdnl5prT8a+anVYkPkdFfYKomIKXTFAPD+A82b1ONt
   7Dh6lJTSkUFxVSbO2j3MAQ5G7D+wWKR3lbM9Nn+gQdbOScC0a+Ct8KrOI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363502463"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="363502463"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 07:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850736199"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="850736199"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 07:11:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 07:11:12 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 07:11:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 07:11:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 07:11:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YySTKFpwwKRwoy73yA0/Vz2C44jkE2c+cA+qLzt5kXDWPi1Eo+2JzpHA4Z3I4IcIfjEMa2k2vSKTAtIHLmMv4D7GCktlUN7ocCN2MRy+Wh6rPfiNbAAFVUtGtAkbAL7kU5VjdyE4CNaX3EN2QmKzCqa+wEzJqWzSH0qkSVLt8wH8DkpN1iJUxXjActLlAFIs4nQpqk+i/ZbFYRccZoGClLFTix/MR5vF2/jL+M/SPXmV6LPfT9hh6hOebSPaKthxojekLPkIJAjocnTiI8EYmBaXoLb1Ed2y06L9ibfIIMs8twcrU3LguYSMSWIZ9pFjlwvNbMCIXTwUEjXDmekkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9A7JKqZAIGYwF11FjCZ2Cvwpc+xeX5xxV4ItfTlIsE=;
 b=FovbmWtfk9o0mQznjBrny9CwLyLgsQrO55NEDEIz3OIcp11YUa+/YAT8SBjATeQ0Phyh46iO5me6HgBv4fSGsbP5G+XfaiKBsDfzy0lhYbzcpdQWTtnjR8znn94Ns7T5o0/h+FAl4/923bhBZCOoP3Ud7EB9DJFRAg3eoM7k4HkCHAOGY1Oou0iWbCJFvHqlWvBEChwE/yiJqFUzpP8OwLta1h7RV0dfpDcq5r42akEMPJzdkeC4KL2y763GK1IbzfS6iJorIR+9LiN6izUgASm+Dcha1odwxlvmE/l0FH2iZ2GmOun96xiLWEWpdmEssjYpH7xtSR1Mc/5IHIeTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 15:11:10 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%5]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 15:11:10 +0000
Date:   Tue, 7 Mar 2023 23:12:18 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <dave@stgolabs.net>,
        <akpm@linux-foundation.org>, <Liam.Howlett@oracle.com>,
        <heng.su@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is WARNING: suspicious RCU usage in
 mas_walk in v6.3-rc1
Message-ID: <ZAdUUhSbaa6fHS36@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::31) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 120ec931-c75b-411c-3035-08db1f1e2eb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUbK/iKZQ0TxY1gBY3CfDLzmMWsRup75kri6ir4wJ8nGP6wk5CsjFMLQS54RNdEVnV8ebV7IlT13VXf/8HmFCKe/O/wgJMb2GkIJYYw3Nhu0EzDUoaoFI/hANiX9LLPU5BvgZCM97i+g43SOkW7SOjnGTjD9weVgypBSrr8vS7F66DhTOMazJSQB3z7yXxA57mJWltGjROmFUeZIau1YmWl3aTjkvgKsck8+kYHoza1wR6Lc6u1CAAvXfpfnaIre5y84hI9ZiNq0gqbSWBiXDo5RbyLNcp4BABY3oRzWMFNkmyQqMOXDQg4edl4VQPe4CgN6CU+QmJLm0tin4BDGshnAvydRXnF0nbhHRdoxa8DkJsaQ2m33tm2GcgtaPh43DfL1TOEr0q1hyXQ99Gc6Dl0DQog3yBNXrQDa7OiqAmbOkJRIwpQSL1ROOyHwGrgb36cvlSDzPJztoavY/EeWlhGlIDBhc6/yPj9AidLMelfvw/oOjJ6UGgov25K6BIdw1RHNN8BBKe5qencjdOMi7Co3t1xTjokv7lmQcvjkg9T0Z5/HG4hdo6v/eohnL2CkEDRTsJDG0KUmbiEqt0vXg0NGY8Cbao7Iec4or87Ny7YU/8CQecJr127FUxd5JpuN/0JTd0KWIfx2zziJnrfJTNins4lZSkPhjRxMaFwFh52Cp6D5DF8+V5SQe2pIQBvYIk/FIvZef1vdjv9LXzPya1UVtarwJ40aeC/RwYkTW5/ha/2W92jG9DhWJu3zLNBC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(41300700001)(4326008)(8676002)(66556008)(8936002)(6916009)(44832011)(2906002)(5660300002)(66946007)(86362001)(82960400001)(66476007)(38100700002)(107886003)(26005)(966005)(478600001)(6486002)(316002)(6506007)(83380400001)(6512007)(186003)(21314003)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y4OyZGGSmIpRRRZYMpx0msqij0XXFg2qcyre2wOd8rBhdvh0cvVBKfhYZr0w?=
 =?us-ascii?Q?SwgENf6zt4m1uccURtYYX+2/BDhmYNjKvIJtDmfAVFWW8h9Jk2qIGMj0MqN2?=
 =?us-ascii?Q?BHUD+/Hn/YRVvHJqoWEX4nKntxGXlfEY3kJ8tiIh/Ooxh3GMnRnWNPZAvAiq?=
 =?us-ascii?Q?/fxrd0eHD/lIaI+iYTLyPDYh9rD9ib6A0p/D0mQYAtWgjl6N4k59eXGqsoML?=
 =?us-ascii?Q?hcUGX6xHp6Cb4Chhd4h8g8x2aNowig7h36vvs85N0wQbJ0OLxZu6NGRQk0sU?=
 =?us-ascii?Q?sJO5dkZlXUf80UZAyov0rmiXhehNAJPNV02o6lMpbytLUkd1Pe6Vd0SwBM/2?=
 =?us-ascii?Q?u9GOXIq2qpnHMxwSQoMSbs2LJ2fPFf8yKmtFW7f5JPPYoUyDiS1yhfy1gwDP?=
 =?us-ascii?Q?TQj+hLRvWZWAEn5nuNx0zi5Ts7l06vgS/7gQ2ueH/IVWjsMar2Tgu/sQMKMd?=
 =?us-ascii?Q?cCyPirngUf0mrwQhvK8UZkokhe03DQGm59Z1P0+WJN9qF+kc/cghO3RtDiD3?=
 =?us-ascii?Q?Xgy+CGZvqg1VyRlQzRywOyd3LacEeA8k9PMaO9ebJs8Li6OaDldqTNnsQdDy?=
 =?us-ascii?Q?/pMhRqRXaRHlXbO0DLUDAt9L7Plc6KAWDgbXgGcqLI7IJ1Qzzbal4ZOw/8VP?=
 =?us-ascii?Q?9y8UBEtoEmvBy8Bf3c383RwIygIpNRBLq9G9tK3UaqBtARC8KGSS+yvQ1+8o?=
 =?us-ascii?Q?OpnkYdfMBmCb/wBKwDd1ybEfqc60SpOxBQLEBbVcdEF0yQiEy7UBgOZRTUAj?=
 =?us-ascii?Q?8TaMCgrI24XDIYaqEAu2Llfo3/J1QX4Ccknnr2riW0BBPbrt8NB78fov+jhL?=
 =?us-ascii?Q?xxO5kJ3DNh4pqS79lm83Lr3HJtoe4UHwIst9Eu90MzEMCt+ksV7mqoKuPXYT?=
 =?us-ascii?Q?xHy9IgHIAbwwUEH8s7blVYn/M1Rjmn7GwUaJBouS5Bcbmo7vCmXGn09Xvsgi?=
 =?us-ascii?Q?+OiWc6qr6AEFpArUE+M2ruMcuVCVbeQXlIpT+ptA7dhbFFENp3fC/gAbSw7r?=
 =?us-ascii?Q?y+OTzmYmsppaUBTYFgS3Z7M21BMbGOvpEFfycltriMKll88XJXK2NDAjxBac?=
 =?us-ascii?Q?PiXzbesjW/Q8fmigAckXspQ0nmyEigpicHXPT9vTp2iU2mrR4m5QubLxwmzN?=
 =?us-ascii?Q?Ar3gg30AHn/AppZLmX9KZwJOqYxhKXKXC2rZZf0Jw2xcZABNMzbdvhTK9Td2?=
 =?us-ascii?Q?ie7P7AWS6Ucvuqco5mS+7q7cvb/e2NtiAAGSai1oUWaXUvrlyKFrfDp4770V?=
 =?us-ascii?Q?LER3ep00zRyY9D0NfEeavoCl9jkpzVe0Atp5l+1AYeyxp/HZZemx6UA+bu/t?=
 =?us-ascii?Q?nA97k6voYRFtyfdYm1QPPCxMkvUwcAjkbbiS31XZHt8JssaHSEPaFkNCEKV7?=
 =?us-ascii?Q?1xWfi40H/qJJ5X2VhqDCdK+9oEmyq/nCSIf0UgA5hZbslkG1eMQD5lGGtnvp?=
 =?us-ascii?Q?+/LVU+jqQk2HC2MTdgJmnfgwJkAO+QqGpn3TDYUGw1nLqC3988oH35v/aWk1?=
 =?us-ascii?Q?E+1l2b3pkz3rKfs/ufZ5Gjo0+e7RIAm1C3d4aWlPuh2Q4lSkdGM2S1Wu3zUS?=
 =?us-ascii?Q?nV8/IBfZwZ1hLOalJ79WfpWdLOgNmeoNcIjlIynwFBueiT773dS034VUma5t?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 120ec931-c75b-411c-3035-08db1f1e2eb4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 15:11:09.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9jpQRNalYhaC8pWL8nDZg0Nk918Re7+j6EgmRrN43jiUjU9zdvZP9mLLcdXlf5+2x3JlWYPntY7Q7faNCufTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew Wilcox,

Platform: x86 platforms

There is WARNING: suspicious RCU usage in mas_walk in v6.3-rc1.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230306_221524_mas_walk
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_221524_mas_walk/repro.c
v6.3-rc1 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_221524_mas_walk/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_221524_mas_walk/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_221524_mas_walk/bisect_info.log

"
[   62.854989] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=337 'systemd'

[   87.245186] =============================
[   87.245689] WARNING: suspicious RCU usage
[   87.246234] 6.3.0-rc1-fe15c26ee26e+ #1 Not tainted
[   87.246824] -----------------------------
[   87.247319] lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!
[   87.248149] 
               other info that might help us debug this:

[   87.249112] 
               rcu_scheduler_active = 2, debug_locks = 1
[   87.249983] 5 locks held by repro/3075:
[   87.250463]  #0: ffff88800a984448 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x9f/0x170
[   87.251461]  #1: ffff88800de3ca88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x190/0x290
[   87.252549]  #2: ffff888007bce938 (kn->active#79){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x199/0x290
[   87.253674]  #3: ffffffff840425a8 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0x88/0x4d0
[   87.254718]  #4: ffff88800dc61b18 (&mm->mmap_lock){++++}-{3:3}, at: run_store+0x1b9/0x4d0
[   87.255722] 
               stack backtrace:
[   87.256259] CPU: 1 PID: 3075 Comm: repro Not tainted 6.3.0-rc1-fe15c26ee26e+ #1
[   87.257150] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   87.258514] Call Trace:
[   87.258828]  <TASK>
[   87.259105]  dump_stack_lvl+0xe0/0x110
[   87.259598]  dump_stack+0x19/0x20
[   87.260023]  lockdep_rcu_suspicious+0x122/0x1a0
[   87.260598]  mas_walk+0x27a/0x340
[   87.261038]  mas_find+0xe2/0x140
[   87.261460]  run_store+0x1d3/0x4d0
[   87.261905]  ? __pfx_run_store+0x10/0x10
[   87.262404]  kobj_attr_store+0x3f/0x70
[   87.262886]  sysfs_kf_write+0x69/0x90
[   87.263356]  ? __pfx_sysfs_kf_write+0x10/0x10
[   87.263908]  kernfs_fop_write_iter+0x1ce/0x290
[   87.264473]  vfs_write+0x577/0x7c0
[   87.264927]  ksys_write+0x9f/0x170
[   87.265371]  __x64_sys_write+0x27/0x30
[   87.265851]  do_syscall_64+0x3b/0x90
[   87.266309]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   87.266935] RIP: 0033:0x7f1eae54759d
[   87.267389] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   87.269603] RSP: 002b:00007ffd266b4618 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   87.270519] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1eae54759d
[   87.271378] RDX: 0000000000000002 RSI: 0000000020000140 RDI: 0000000000000003
[   87.272229] RBP: 00007ffd266b4630 R08: 00007ffd266b4630 R09: 00007ffd266b4630
[   87.273084] R10: 00007ffd266b4630 R11: 0000000000000202 R12: 0000000000401190
[   87.273935] R13: 00007ffd266b4750 R14: 0000000000000000 R15: 0000000000000000
[   87.274802]  </TASK>
"
Found this issue existed in v6.2 kernel also.
And bisected between v6.2 and v5.11 and found first bad commit:
"
a5f18ba0727656bd1fe3bcdb0d563f81790f9a04
mm/ksm: use vma iterators instead of vma linked list
"

And it's suspected problem commit, because reverted the bad commit on top
of v6.2 failed and could not double confirm.


syzbot dashboard link found the similar issue but didn't provide the bad commit.
https://syzkaller.appspot.com/bug?id=64a3e95957cd3deab99df7cd7b5a9475af92c93e


And I hope it's useful.

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

---

Thanks!
BR.
-Pengfei (Intel)
