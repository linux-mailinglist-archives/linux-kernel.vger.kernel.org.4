Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1186CD542
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjC2IxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjC2IxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:53:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69004F4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680079981; x=1711615981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1WX+kevUl5Og5Em02sr9tSseCQjYX8d0Z9a54uobwP0=;
  b=hZZal92x0+ej1sqv7QCP44s4P3QFopyRzrNUpeliuLsU08I/UZoublcP
   tEvQzR8SDFz3hm7AvZxM90trqeCmXp3vBuctwQfvswo0Fq3zF8PJGjcpF
   b1OfRbZ9HDUHjX4Gxn2FwOKri0rIHXk7bxU/owhzTaMMg2j3umdD6oeO1
   KkItxNsTUR98xdBhzwyQlD0Y9ATzmE5v8cqVaoEUYRcgd7nr3wg0ImJgz
   48O5TdP2Joqv+rJ1oXVjS6GQaaiKIF4m7IhzPlnMsP2NhQBcG6AVlPTKx
   ehT6t2vANzsQPBOev4tQzQ6uKnC6Qp/hT8jmdxr7eHM3d7MkqPvGwb7O6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="427094809"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="427094809"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 01:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773489502"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773489502"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2023 01:53:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 01:53:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 01:53:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 01:53:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 01:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUV+lnrnteYoUGWDHVkzM9FKcX2lnxwc92Yh89P/RzjrKlZT6BAkkJZxbeRnQxpN/0gsXMZj0V/xrSp1mFVSJdzPB2rUGspiMtojMiNN/Q3wNj+64qovpDDp9CqdsOB4TSkuSWPbH9eoBF/D11Jn4ucKH93IJkr8ecNpkY8J6RrsNDdc1YAx6QHSzkdou4j7mq1mII/T/ypkeR7COawLzXPwKCvB6LY365X6G+BKjc3GjuV+rZ0SHiUEwmx+VpT2KucoB3Dws0RDMw0a7imZQsA21xYFDa1I0RT7w5zEk16FzEKzsR+otrh7FM9DT3ugnjny5EvDUCN6yOv4LR6Idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieQLdeRlPyJaHKOsqPHS+/2icrTPoejSfQ2ZShSvQq0=;
 b=U3wr3KJqv6DhhEhLJqNARioBc9fFPsEy32fomV52kH7ZPAzpucEz1DoeiuBifxUBrbqyo6IQf83ZwHPhItquHhVURjTcHO6W542ibDSovaxajAS5TTnBNMq/X5Xy8sWOXP7QC8fMz4Zct+gNiUZ3zOsxCguZBkwYwTJsx2Y3/OTNSK52pS3SBjccXAszFwfIetsdgrSm7YQB8NFOZER6f1bwWU24AdWgs+wjA7u1uVjiHUinOVQafApFSvEppA4Au5SB2FgjOd9l3ydTYAYhBIfNM1X4wf+jUKo68C6285cB5cUJC0PiCL3Ko/WnEiCKp46aZxtHnP1CkAQoH6hEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 08:52:55 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 08:52:55 +0000
Date:   Wed, 29 Mar 2023 16:54:22 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <tglx@linutronix.de>, <songliubraving@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <frederic@kernel.org>,
        <heng.su@intel.com>, <peterz@infradead.org>, <lkp@intel.com>,
        <pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is "soft lockup in sys_perf_event_open"
 BUG in v6.3-rc4 kernel
Message-ID: <ZCP8vkW6xeQJIMLs@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BL1PR11MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc35e72-22fa-4b4d-d63f-08db3032fcc9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iIaMhC6NR1ELm9vbakO/NCHfjQyM9LjVMAM0QI0u1r+LxqTRA0qhg9o1W1ri4LNfRS5Hx9e09wXn5dNAaEsMROoYX3lr881cIafgcKtsqHj6RFWkqsxecoirUa6PzvNUIXdlhRfOFoOHQASkJ1e57hE1wDoTd5LCB38vf0a5awuP45Xky/6OTsvRZMqA+ifETWuwg7G6HV50PLbKq7UE5GsDzHaJC28/ksYQ4wK17IlViqDgWqgm1mIVcHkEr0JPYEzcZDu7ByIZ89BxCD2poqPP4Amx+NEVvFr8G3BTWJRNLiKOKwnv3MAelmGFtUmRM966Pb875xS9m6iasiqfuxawVtvk+TUBrk8yxDvLS7Ixv8sup8CnmGGKsfhf/pyaV+ZxCCy9vcDXtgJC7fD0udaHHTVAfjPhT/hRUFN5lzyHzp+8WAj+EJIWCduBBK3+MCHEqwqBBWPkSepn0XvGOHJ/7v4xRaoxmgUwUDcfK2UoK9qwTLDTZwqac1fOOiJiIfwdGP+ehRgaMsryDbYYV57Bac8pNo78FzSiJDD7M4qB7+ue6leR9kLTKj0q48ZnEAel/EP+3vSrwuvYo0aBLVkw/GTCExqPxsVpkaFmuvKSEGiUXMp6NnL15h9vqlt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(82960400001)(6666004)(107886003)(26005)(6486002)(38100700002)(966005)(186003)(4001150100001)(44832011)(30864003)(2906002)(5660300002)(8936002)(6506007)(45080400002)(6512007)(478600001)(316002)(86362001)(41300700001)(4326008)(8676002)(66556008)(66476007)(66946007)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JNLQb0F8HaWPd65Q+LphauNbnrXV1XsuyFYL7JTZ3WVHJgbycozX7xMsiu+m?=
 =?us-ascii?Q?WwZaqaSNGBSjtarqXMzy/ZRq1krsF6VNHWoRhFUShW0/CS8V8BvAuWLJP7I+?=
 =?us-ascii?Q?9CDYme075esCB+QJ7VLQxpeT/IWHBf+ZcPcx7B0QArnwlAI9tPNXgiSU9+tW?=
 =?us-ascii?Q?DsBHtbV28i0N5PJ/5sYxsRLggtbEeKR+GOoX4Kd6oW7Z4JCkci/4XdMHRonS?=
 =?us-ascii?Q?bjUXDxoop4SihvRZaD3fgwZ5fYdG0kaSH1c2YdJNbPw5NwSX2j+dF6+OkvJp?=
 =?us-ascii?Q?Q0gG4DJ+XoglKBy8IgFjzI+gtlamZL87Pgmi3WVKH+2IhZSVXogYRW1JuH68?=
 =?us-ascii?Q?RuIbB4hHZoPXdBuEues1ez6FRwoXoHv26+UPioNcmt669Q6lq2KF5WkqHhNz?=
 =?us-ascii?Q?exfQ5oj4+6OGCCpMjZHp2cxQUz/ayY36+PxtAn9aVpSQI7g5xJZ2nqo6U93W?=
 =?us-ascii?Q?en1YwZj59bb3aQ6JQcJN1TvZgrAzZkzV0gaF5xgNyA+ms9cBYDki6Z/20w1n?=
 =?us-ascii?Q?j4sbz+BBtTbw590i0ew/E8HR5M0hLoM1DQrF47jCuK1OY5HL7ckxEg6Mrkcp?=
 =?us-ascii?Q?YPM6O2gn3t71enA/uwBtCTXSEkW+C3QcGgLR7CLdnU/QkQbkjbawe0NVMCOp?=
 =?us-ascii?Q?GuonyN5ZmyC6E+gOvp5WGyDv4Fh2xBK+unuEzAp7yj01r5x+5Q3wNTSMsLWq?=
 =?us-ascii?Q?wXHZT9El2DnykfDjsvi3BTTA67PNvHkO585HZywl7KJGX0OxqYEIyYm9eJun?=
 =?us-ascii?Q?MYwXQRlGXvB7O/0VZVIXyS9d8TTNSqxtJO03ePhsWiiKlvyO1+Txb4HT6TG9?=
 =?us-ascii?Q?Evuudh36igjQ0dbWC4OWbe/oXuXjjpuiScBummom65LSunRldasUMIN3iUuv?=
 =?us-ascii?Q?yNN61cxYi0gE1/ouYBGnXkDkRFymaZ83xnPq/rPHx4cOLqXr/40mm8C/HLF+?=
 =?us-ascii?Q?j+dPwYoW6AhmwVc7HHJ0kpd2iQOL5zlaVkUoCQCMzj0L7YI5YuRg+5gBxaj7?=
 =?us-ascii?Q?koRiPTSGmtgSXY1UPV/JpZTTL/2Hx9VLpnz+kwUTHUcP83zxFCbxyw1NfvM+?=
 =?us-ascii?Q?F4pamn1Td8ViaoLum3mrW/qregYkoZah5+gzCm0vzf6F4DxZ6UtfaMU+t1Hc?=
 =?us-ascii?Q?pTgLNEMUi9xA5RO7nS8v9P8bXxbJOKxCCfs521KIz1H9kRpB4Qs0kn5TUbw5?=
 =?us-ascii?Q?Ik04ODXtL3xop9sUjRVYMMaPuJXRBOl1AaCzLbFnfRivLXe1oVwHgN7ku+8a?=
 =?us-ascii?Q?hKiua5BNmLtsqxGxgevzU1zwZEWguBE8QGEO3I64TlbgWKMNh1ta23h3/rnU?=
 =?us-ascii?Q?y/QQAauyt1xpfaaASWQBaGGxUvVQk2DIccB+lu8aA1c792+u6nyCHF5UpJ+F?=
 =?us-ascii?Q?xvVZsFKOKU03Sfnrv8Gvhl6D3NIUYXtvMMfkolL4eoHPPx5RcgO5U+yDcfQI?=
 =?us-ascii?Q?yStrBy04yE5ZrQXGL1WgHDfF3HTAnlJv0gmVhwHTS3uB/ksNdGggkXpZnk++?=
 =?us-ascii?Q?+rTpc3MHxl7p7Bw3JqcIPCWIf4tQfBS48n7LDxWYJdUgOcP3X00XH4dkPxWt?=
 =?us-ascii?Q?pxYwNRLsZ/ggmxodOiNf4tm77h4SGiWwyFhFVJ2lJpAsCjHiEMED9tR7H8El?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc35e72-22fa-4b4d-d63f-08db3032fcc9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 08:52:55.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFXbGcTmB2KCsN5cAARY/TmZGuGgE+A0VvFE+q+lw9u+KelaNpxFQhRvPlB3y9EXqFfOooVyDm4UvAQvV/X3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Song Liu and kernel/perf experts,

Greeting!
It's one special BUG and found on ADL-N intel x86 platform.
This issue manifests differently on ADL-S platform.

So do follow narrow down job on ADL-N.
ADL-N cpu info: Intel(R) Core(TM) i3-N305
"
cpu family      : 6
model           : 190
model name      : Intel(R) Core(TM) i3-N305
stepping        : 0
microcode       : 0xc
"

There is "soft lockup in sys_perf_event_open" BUG in v6.3-rc4 kernel in guest
on ADL-N platform.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230329_020715_sys_perf_event_open
VM machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/machineInfo0
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/repro.c
Syzkaller analysis repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/repro.report
Syzkaller analysis repro.stats: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230329_020715_sys_perf_event_open/repro.stats
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/kconfig_origin
v6.3-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/197b6b60ae7bc51dd0814953c562833143b292aa_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230329_020715_sys_perf_event_open/bisect_info.log

It could be reproduced in 180s.
Bisected and found the first bad commit:
"
91e1c99e175ae6bb6be765c6fcd40e869f8f6aee
Merge tag 'perf-core-2021-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
"


It's from tip kernel, so do the advanced bisect between tip repo tag
"perf-core-2021-10-31" and "perf-core-2021-08-30".
All tip bisect info: https://github.com/xupengfe/syzkaller_logs/tree/main/dev_branch/230329_140445_sys_perf_event_open
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/dev_branch/230329_140445_sys_perf_event_open/bisect_info.log

And bisected found that the first bad commit in tip repo was:
"
79df45731da68772d2285265864a52c900b8c65f
perf/core: Allow ftrace for functions in kernel/event/core.c
"
After reverted above commit on top of tip tag perf-core-2021-10-31, this issue
was gone.

I hope all the info is helpful.

v6.3-rc4 issue dmesg info is as follow:
"
[   24.618533] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
[   56.504281] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [repro:516]
[   56.507013] Modules linked in:
[   56.507699] irq event stamp: 684720
[   56.508318] hardirqs last  enabled at (684719): [<ffffffff8107247c>] __text_poke+0x2ec/0x4e0
[   56.509577] hardirqs last disabled at (684720): [<ffffffff82f937a3>] sysvec_apic_timer_interrupt+0x13/0xe0
[   56.510993] softirqs last  enabled at (472178): [<ffffffff82fb71a9>] __do_softirq+0x2d9/0x3c3
[   56.512283] softirqs last disabled at (472151): [<ffffffff811266f4>] irq_exit_rcu+0xc4/0x100
[   56.513543] CPU: 0 PID: 516 Comm: repro Not tainted 6.3.0-rc4-197b6b60ae7b+ #1
[   56.514647] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.516213] RIP: 0010:debug_lockdep_rcu_enabled+0x0/0x40
[   56.517098] Code: c7 c7 a3 d6 96 83 e8 4f 0e 00 00 65 c7 05 e4 c3 08 7d 00 00 00 00 eb ba 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 8b 05 be 65 0d 01 85 c0 74 2b 8b 05 4c cd 0d 01 85 c0
[   56.519522] RSP: 0018:ffffc90000fbb260 EFLAGS: 00000246
[   56.520439] RAX: 0000000000000000 RBX: ffff888014599aa8 RCX: ffffffff81353c4d
[   56.521513] RDX: 0000000000000000 RSI: ffff888013bc4680 RDI: 0000000000000002
[   56.522585] RBP: ffffc90000fbb2a8 R08: ffffc90000fbb820 R09: ffffc90000fbb818
[   56.523683] R10: ffffc90000fbb7f0 R11: 0000000000000000 R12: ffffc90000fbb2b8
[   56.524766] R13: fffffffffffffdff R14: 0000000000000000 R15: ffffffff81353960
[   56.525841] FS:  00007fe17f501740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   56.527044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.527977] CR2: 00007ffd57376000 CR3: 000000000af0a003 CR4: 0000000000770ef0
[   56.529038] PKRU: 55555554
[   56.529543] Call Trace:
[   56.530040]  <TASK>
[   56.530496]  ? arch_ftrace_ops_list_func+0x1b6/0x360
[   56.531339]  ? perf_trace_buf_alloc+0x41/0x110
[   56.532148]  ? perf_swevent_get_recursion_context+0x4/0xe0
[   56.533132]  ? perf_tp_event+0x164/0x880
[   56.533853]  ftrace_call+0x5/0x44
[   56.534612]  ? write_comp_data+0x2f/0x90
[   56.535444]  ? perf_trace_buf_alloc+0x2a/0x110
[   56.536301]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.537201]  ? write_comp_data+0x2f/0x90
[   56.537958]  perf_swevent_get_recursion_context+0x9/0xe0
[   56.538848]  perf_trace_buf_alloc+0x41/0x110
[   56.539644]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.540564]  ? perf_trace_buf_alloc+0x41/0x110
[   56.541415]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.542233]  perf_ftrace_function_call+0x28f/0x340
[   56.543070]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.544273]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.545328]  ? __pfx_perf_ftrace_function_call+0x10/0x10
[   56.546221]  arch_ftrace_ops_list_func+0x2c6/0x360
[   56.547029]  ? perf_tp_event+0x164/0x880
[   56.547774]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.548730]  ftrace_call+0x5/0x44
[   56.549407]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.550239]  ? write_comp_data+0x2f/0x90
[   56.551228]  ? perf_swevent_event+0x5/0x170
[   56.552001]  ? write_comp_data+0x2f/0x90
[   56.552767]  perf_swevent_event+0x5/0x170
[   56.553500]  perf_tp_event+0x164/0x880
[   56.554219]  ? perf_swevent_event+0x5/0x170
[   56.554959]  ? perf_tp_event+0x164/0x880
[   56.555959]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.556843]  ? write_comp_data+0x2f/0x90
[   56.557646]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.558541]  ? arch_ftrace_ops_list_func+0x207/0x360
[   56.559393]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.560256]  ? perf_tp_event+0x4/0x880
[   56.561026]  ? _raw_spin_lock+0x4/0x50
[   56.561723]  ? __get_locked_pte+0x96/0xe0
[   56.562493]  ? ftrace_call+0x5/0x44
[   56.563335]  ? write_comp_data+0x2f/0x90
[   56.564308]  ? _raw_spin_lock+0x4/0x50
[   56.564988]  ? __get_locked_pte+0x96/0xe0
[   56.565708]  perf_ftrace_function_call+0x2d2/0x340
[   56.566516]  ? perf_tp_event+0x9/0x880
[   56.567223]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.568079]  ? perf_tp_event+0x9/0x880
[   56.568741]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.570049]  ? 0xffffffffa02010b1
[   56.570919]  0xffffffffa02010b1
[   56.571678]  ? ftrace_call+0x5/0x44
[   56.572420]  ? pmd_page_vaddr+0x2b/0x80
[   56.573193]  ? _raw_spin_lock+0x9/0x50
[   56.573987]  _raw_spin_lock+0x9/0x50
[   56.574672]  __get_locked_pte+0x96/0xe0
[   56.575411]  ? _raw_spin_lock+0x9/0x50
[   56.576100]  ? __get_locked_pte+0x96/0xe0
[   56.576924]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.577816]  __text_poke+0xf4/0x4e0
[   56.578489]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.579399]  ? __pfx_text_poke_memcpy+0x10/0x10
[   56.580134]  ? lock_is_held_type+0xe6/0x140
[   56.580902]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.581822]  text_poke+0x3a/0x60
[   56.582538]  text_poke_bp_batch+0x94/0x310
[   56.583263]  ? text_poke_bp_batch+0x5/0x310
[   56.584081]  ? __pfx_virtblk_update_cache_mode+0x10/0x10
[   56.585069]  text_poke_queue+0x93/0xb0
[   56.585874]  ftrace_replace_code+0x12a/0x1b0
[   56.586789]  ftrace_modify_all_code+0x1b9/0x2a0
[   56.587701]  arch_ftrace_update_code+0xd/0x20
[   56.588468]  ftrace_startup_enable+0x67/0xa0
[   56.589291]  ftrace_startup+0x124/0x200
[   56.590082]  register_ftrace_function_nolock+0x43/0x90
[   56.590991]  register_ftrace_function+0x1eb/0x280
[   56.591873]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[   56.592835]  perf_ftrace_event_register+0xcd/0xf0
[   56.593735]  perf_trace_event_init+0x98/0x4b0
[   56.594639]  perf_trace_init+0xde/0x170
[   56.595449]  perf_tp_event_init+0x60/0xa0
[   56.596216]  perf_try_init_event+0x88/0x280
[   56.597094]  perf_event_alloc+0xe25/0x1c00
[   56.597900]  ? perf_event_alloc+0x5/0x1c00
[   56.598846]  __do_sys_perf_event_open+0x3b6/0x1910
[   56.600490]  __x64_sys_perf_event_open+0x2f/0x40
[   56.601330]  do_syscall_64+0x3b/0x90
[   56.602067]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   56.602902] RIP: 0033:0x7fe17f62659d
[   56.603610] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
[   56.606099] RSP: 002b:00007ffd572b7f58 EFLAGS: 00000206 ORIG_RAX: 000000000000012a
[   56.607348] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe17f62659d
[   56.608429] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000100
[   56.609512] RBP: 00007ffd572b7f70 R08: 0000000000000000 R09: 00007ffd572b7f70
[   56.610604] R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000401180
[   56.611719] R13: 00007ffd572b8090 R14: 0000000000000000 R15: 0000000000000000
[   56.613326]  </TASK>
[   56.613804] Kernel panic - not syncing: softlockup: hung tasks
[   56.614714] CPU: 0 PID: 516 Comm: repro Tainted: G             L     6.3.0-rc4-197b6b60ae7b+ #1
[   56.616000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.617629] Call Trace:
[   56.618142]  <IRQ>
[   56.618614]  dump_stack_lvl+0xa9/0x110
[   56.619442]  dump_stack+0x19/0x20
[   56.620120]  panic+0x4fd/0x520
[   56.620904]  ? watchdog_timer_fn+0x31e/0x390
[   56.621845]  watchdog_timer_fn+0x337/0x390
[   56.622694]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   56.623512]  __hrtimer_run_queues+0x2ed/0x5d0
[   56.624636]  hrtimer_interrupt+0x134/0x2d0
[   56.625643]  __sysvec_apic_timer_interrupt+0x9c/0x1d0
[   56.626550]  sysvec_apic_timer_interrupt+0xab/0xe0
[   56.627400]  </IRQ>
[   56.627866]  <TASK>
[   56.628392]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   56.629248] RIP: 0010:debug_lockdep_rcu_enabled+0x0/0x40
[   56.630109] Code: c7 c7 a3 d6 96 83 e8 4f 0e 00 00 65 c7 05 e4 c3 08 7d 00 00 00 00 eb ba 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 8b 05 be 65 0d 01 85 c0 74 2b 8b 05 4c cd 0d 01 85 c0
[   56.632509] RSP: 0018:ffffc90000fbb260 EFLAGS: 00000246
[   56.633423] RAX: 0000000000000000 RBX: ffff888014599aa8 RCX: ffffffff81353c4d
[   56.634486] RDX: 0000000000000000 RSI: ffff888013bc4680 RDI: 0000000000000002
[   56.635563] RBP: ffffc90000fbb2a8 R08: ffffc90000fbb820 R09: ffffc90000fbb818
[   56.636613] R10: ffffc90000fbb7f0 R11: 0000000000000000 R12: ffffc90000fbb2b8
[   56.637633] R13: fffffffffffffdff R14: 0000000000000000 R15: ffffffff81353960
[   56.638668]  ? __pfx_perf_ftrace_function_call+0x10/0x10
[   56.639765]  ? perf_ftrace_function_call+0x2ed/0x340
[   56.640788]  ? arch_ftrace_ops_list_func+0x1b6/0x360
[   56.641593]  ? perf_trace_buf_alloc+0x41/0x110
[   56.642383]  ? perf_swevent_get_recursion_context+0x4/0xe0
[   56.643378]  ? perf_tp_event+0x164/0x880
[   56.644134]  ftrace_call+0x5/0x44
[   56.644938]  ? write_comp_data+0x2f/0x90
[   56.645777]  ? perf_trace_buf_alloc+0x2a/0x110
[   56.646658]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.647599]  ? write_comp_data+0x2f/0x90
[   56.648412]  perf_swevent_get_recursion_context+0x9/0xe0
[   56.649291]  perf_trace_buf_alloc+0x41/0x110
[   56.650080]  ? perf_swevent_get_recursion_context+0x9/0xe0
[   56.650960]  ? perf_trace_buf_alloc+0x41/0x110
[   56.651792]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.652589]  perf_ftrace_function_call+0x28f/0x340
[   56.653430]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.654585]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.655609]  ? __pfx_perf_ftrace_function_call+0x10/0x10
[   56.656506]  arch_ftrace_ops_list_func+0x2c6/0x360
[   56.657304]  ? perf_tp_event+0x164/0x880
[   56.658034]  ? __pfx_perf_swevent_event+0x10/0x10
[   56.658973]  ftrace_call+0x5/0x44
[   56.659637]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.660535]  ? write_comp_data+0x2f/0x90
[   56.661489]  ? perf_swevent_event+0x5/0x170
[   56.662242]  ? write_comp_data+0x2f/0x90
[   56.662981]  perf_swevent_event+0x5/0x170
[   56.663723]  perf_tp_event+0x164/0x880
[   56.664440]  ? perf_swevent_event+0x5/0x170
[   56.665136]  ? perf_tp_event+0x164/0x880
[   56.666067]  ? arch_ftrace_ops_list_func+0x2c6/0x360
[   56.666911]  ? write_comp_data+0x2f/0x90
[   56.667709]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   56.668575]  ? arch_ftrace_ops_list_func+0x207/0x360
[   56.669367]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.670190]  ? perf_tp_event+0x4/0x880
[   56.670928]  ? _raw_spin_lock+0x4/0x50
[   56.671607]  ? __get_locked_pte+0x96/0xe0
[   56.672320]  ? ftrace_call+0x5/0x44
[   56.673117]  ? write_comp_data+0x2f/0x90
[   56.674022]  ? _raw_spin_lock+0x4/0x50
[   56.674679]  ? __get_locked_pte+0x96/0xe0
[   56.675416]  perf_ftrace_function_call+0x2d2/0x340
[   56.676199]  ? perf_tp_event+0x9/0x880
[   56.676894]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.677706]  ? perf_tp_event+0x9/0x880
[   56.678367]  ? perf_ftrace_function_call+0x2d2/0x340
[   56.679685]  ? 0xffffffffa02010b1
[   56.680585]  0xffffffffa02010b1
[   56.681346]  ? ftrace_call+0x5/0x44
[   56.682076]  ? pmd_page_vaddr+0x2b/0x80
[   56.682839]  ? _raw_spin_lock+0x9/0x50
[   56.683633]  _raw_spin_lock+0x9/0x50
[   56.684306]  __get_locked_pte+0x96/0xe0
[   56.684996]  ? _raw_spin_lock+0x9/0x50
[   56.685658]  ? __get_locked_pte+0x96/0xe0
[   56.686425]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.687307]  __text_poke+0xf4/0x4e0
[   56.688004]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.688907]  ? __pfx_text_poke_memcpy+0x10/0x10
[   56.689682]  ? lock_is_held_type+0xe6/0x140
[   56.690451]  ? __pfx__regmap_raw_write_impl+0x10/0x10
[   56.691405]  text_poke+0x3a/0x60
[   56.692123]  text_poke_bp_batch+0x94/0x310
[   56.692847]  ? text_poke_bp_batch+0x5/0x310
[   56.693658]  ? __pfx_virtblk_update_cache_mode+0x10/0x10
[   56.694652]  text_poke_queue+0x93/0xb0
[   56.695469]  ftrace_replace_code+0x12a/0x1b0
[   56.696419]  ftrace_modify_all_code+0x1b9/0x2a0
[   56.697311]  arch_ftrace_update_code+0xd/0x20
[   56.698106]  ftrace_startup_enable+0x67/0xa0
[   56.698937]  ftrace_startup+0x124/0x200
[   56.699752]  register_ftrace_function_nolock+0x43/0x90
[   56.700664]  register_ftrace_function+0x1eb/0x280
[   56.701540]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[   56.702553]  perf_ftrace_event_register+0xcd/0xf0
[   56.703427]  perf_trace_event_init+0x98/0x4b0
"

Thanks!
BR.
-Pengfei

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

Fill the bzImage file into above start3.sh to load the target kernel in vm.


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

Thanks!
BR.
