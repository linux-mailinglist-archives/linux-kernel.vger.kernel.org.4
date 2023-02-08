Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDF68EA6D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBHJDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBHJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:02:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CB658B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675846977; x=1707382977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AhVmqYBxg6SR2eQQUtuhqUQ1+KMxlPVkZSDckCCgcYA=;
  b=hQUbpUAqfC0dCCzh8Dcm3CEEgEpwh2GglyANQxLrkjhHj+g+B+OWYiSc
   lJcjeldh5iv8i7xLYkEQYH5sgxGeInGVulkrawAEe2pJge/91Otl9TwBl
   rfy/jmoDPWSsaSO/WM8w/Xzo2NSzgrelHzx4iKQaj1jWuHytF223kTFfc
   cDdFQ9X6+xdcAlcXLyNo6cxzstJvCbVaOUIjH651JnVqnGYpxwQT/Rfuo
   Cb106BOFoZjAei9XaQ1H2mS0TxxRYR29RUuZzC+t1dfmtdFD1aBdoYR8a
   9+ufHg64KxG/M5upVUgK3YnQLuO0W4+ionT2lrPwFAP0l51ggGHACmamy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327444535"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="c'?log'?scan'208";a="327444535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735862575"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="c'?log'?scan'208";a="735862575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 01:02:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 01:02:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 01:02:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 01:02:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 01:02:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgewmCX54TBOznKx/CIMdvbTiRwOOcIC7njz3Ivp+VNDfsKix6XhFeSCFaWiLa6no1YPmpPbOI9rw5TQZ3R8nWiXgfuwo+msnft3G0l0xqLe0gB2m9t0/9SJjVz+AhukMSG0qSzUlWLL+c1ufBs4qQyPt7DFj8NQyleM4Vjwcg7Pq8dQD0LSyGgEspKSvGWU9PpqAv9YpSXmzh0mr+sdJBonCQ0EJ5YtDR89671KsScX1jtHk9Vcyh6abZd4qeSznd6hsDjt/BzBTrs5QcdQeHj+JXmUCAqIBJiYCdAyJhPKvXdqXxoJM2pEnZNmO8ApjA1IlnE0Q2OhnnreGUSpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf6NvhCzMs4GjGrGEmCWZfANFsXuDmcQrLrCQV56wAc=;
 b=S+fD0IZkUBO8R/+rBG7yzG4E8E+lDrvTOZj174khnnIAo58+U2njxGzLF42WiRMK04VuMttmmCBm3g1VHYIjn3+5zUeURva5AtbxIjRbU6l7Gih205/Tb3PJVaXN2untokEPuUz8oyjcIvNTWK8KstOD2rnw7dVhCCnEE/8vRVHzqtA2GCtYjh+uOIzyhO3ZBMWOduLKFeUuBNODs/rzISzRUJ4BjN2sWjoHfGJxzdDI51Fd2uVzalogUt28FocxzvM/LY9YGc9dEM+tf4OrWOrBoJTdQbnnqbEj86nkPOMKsh6SaeQJIagZwZQV5UKA8775EeNYpeMVVh3Do3YKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6602.namprd11.prod.outlook.com (2603:10b6:806:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 09:02:49 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%4]) with mapi id 15.20.6064.029; Wed, 8 Feb 2023
 09:02:49 +0000
Date:   Wed, 8 Feb 2023 17:03:52 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <pengfei.xu@intel.com>,
        <heng.su@intel.com>
Subject: [Syzkaller & bisect] There is " __disarm_kprobe_ftrace" WARNING in
 v6.2-rc7 kernel
Message-ID: <Y+NleHouvZwDBiKY@xpf.sh.intel.com>
Content-Type: multipart/mixed; boundary="WLnuj2JREO5e8E+i"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 306e94de-0535-4d51-9d33-08db09b33fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAdt3rEPY1F6E08T+xqhJ2696KvLPhzz9tbDMnjGGhSgSAc6V5Qvb/lur0AdTXNusboxfLdbLE4LEnunzpF7QuYQ7ZUhsw28AVKyYHJ5ovG0+xv6f/tc2+UHFohVG65dwQAckS+xo1Jx45nEDxZYHee393nyIcv28V/uyiEXDqcHZtde/ZXQzCA8z5hLOPZRw9x9gl510kLDsx4zOenLx2OrQzDYynL8Pc5zknBa4SV/rROQPclnKRVH30oYNibSOpSPGH4tE8EDdpUs3hTpPlMcHltLJiEz4J9G6pUhuXdOrROHZXW71IbO57uFXsOU1fwmJLcQ7cwFoTrIClR48lQjqeB8bRvABPq8PLu82eAQlsD4lOmlchPZFHcO+MDyYhAWjHcQcCt54KhjCO5gleP6nlfev/X6Ue/xInpnh5IZZ7kjHc0shv84vXmcbYS5KeTAMatZVJXOy2zvaMgqlbZyqH0EiMpYjq1bzC2OfPWUWmitWSqmBaSKGgZmsbF3bTGa0NYm57NkTKhqI3LmTiL/qqFohcyXtWmA1ZavS4Pb42we85kSRr9aBn0A+OLqWGHg7vHbwuBv/j7ozyRTfAaTqpCF/jmZpmX79MXlLHDm5s17XixVRTt+L3wrK6mkOT2aCGr6qTlGVKawwJIXABAcTYB2SfF8y+AUt2CEjzS/JF13GW3TtzXiYhm5ZDiEfWoLTnLGzCyKV84CD5ZLxPc6t3+fskr9m0yBOWR6O6mlHw0ppG+AAZ+Tvh4Y2RY7SiGC1iY8jDRo493NRHClAk8dvPQvEY6NtBFI/ZtDMZLBssNzL4HpQTGHNwCZUBKv9CuVjTePKtuW0b5EAylELA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(6512007)(26005)(186003)(44144004)(6506007)(33964004)(44832011)(2906002)(107886003)(6666004)(966005)(235185007)(5660300002)(478600001)(6486002)(21480400003)(82960400001)(8936002)(41300700001)(8676002)(66946007)(4326008)(66476007)(83380400001)(66556008)(86362001)(45080400002)(316002)(38100700002)(21314003)(99710200001)(67856001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mC3mhMCtQ4UkrQvOyQvMNCNwGmxkfnLRkopPfE548ba2EDtrTJnrvNC8QZ5u?=
 =?us-ascii?Q?Pc5HIWUZX3GLntAIfILbivRVJh9LUOfbJTUDpR8SZK4jJfOAQhiUNdW4jc/f?=
 =?us-ascii?Q?2UdfCyYBz+JBNN6O1zPKRSMldk5fOP4el/OaVbgKdVagxM/8WhwYjGW1xLyy?=
 =?us-ascii?Q?TQ3TNUzU1W6jUIgAU+9EWKZWpzm8D93H2mQtWiy/rQOiNWDWoyIYRulGaIvg?=
 =?us-ascii?Q?0rZgL4L/EQVsNO/ExoWZWI1hMKgc4NxEnD762P/k8FA15/A4g/pq0G4wZEoL?=
 =?us-ascii?Q?1W35FP0fy0FBk3WKhPJmFSvdDF6M928CNVKWTVJa5gg9J8r+AuFU1+QeEzyV?=
 =?us-ascii?Q?EtmkPkaXgrXre69aTIenB2RCl0Lqx+RkgKZG3IwR93E+4Wddw/5HnTWAZpc+?=
 =?us-ascii?Q?3UzruR0TzV50U090qgTL7BY3QAM4hSOHMYj3VKyPMd2gdNyVSZ96scxNWe7p?=
 =?us-ascii?Q?gwYP821NtqeWvGUOynAWRXWSxHsfjFF0Rch6d7xW9MgOpnSgmcslW3TUKjBp?=
 =?us-ascii?Q?fPeAhnSccKf28BT/eYKS1IWr8o8ioJc0KiQjcZt4S50YPdEr1NA5NRYJWFNg?=
 =?us-ascii?Q?1+Td1fY9v1PGFE+wv1tbuwqcxJYKHmQ+vAEKkoUxJUc2Udut1J01fI/9CTWx?=
 =?us-ascii?Q?GRcSvbDdDPsRGPP7W0Q5xaOIx0iNJlKugtXJUpkx0hdnV5bByJJd3JMaA9Lk?=
 =?us-ascii?Q?iUGVPeRHhk1FfWvEh8Ug8aeZs1AOry5k2rtxEHNhanNmVBw9ZPMhDir6jSig?=
 =?us-ascii?Q?+BITPDgeVpEpuMRuFNMeZRdJU+Pw6QCpSgdQTgzmBCg4fz85sB3mY7XkVbnc?=
 =?us-ascii?Q?MIW/9O+dje8h6ltzezNfQDLecY90z8ivW+yC+SkEsPExtF7lpuxKJ3jgJxB4?=
 =?us-ascii?Q?1UkyFElgtWrcfh/0O7SdOe+++mjGVzODctOHPDdRPB+EGG3byOGElFDYcAsB?=
 =?us-ascii?Q?kcDaRttFpU/BcGqhcelUv3pRyVIb2zfHv7OhZjcyJMHd9F3LQfU5hqQuuiFH?=
 =?us-ascii?Q?a6CgG+TJqtpzbnWxPf36svck+V4dF6m+b6WerKjx/W4PpSWV8bcbdCgZy1/2?=
 =?us-ascii?Q?VXCPetflt5zs2rGdT1t+yOEwBfmxV4NGu2jTc3mSVteI5uVPpWNwADpmRTLg?=
 =?us-ascii?Q?eBDWFa23Gu2n9d/mCuSe2VZ6uAgXksWlMjaMfyTeLoPUsvKWz4YgXpM3pdyQ?=
 =?us-ascii?Q?wjtZ54Qilx+q22b1X3sd8xNz2kQE7BVks6bYuJClbh9VExYg6RUna7RBn9XK?=
 =?us-ascii?Q?sxPWqnDqtvGcrLyGx2e6I2W3TKrT530rNLm6iBRE/jFPBxxYF1MnWJiMksyH?=
 =?us-ascii?Q?1WyVifD7AtLJsMwPRMcHT6gUmGiKXZz8YWkqCGXa2Kgxmhj2CVvUgHJj4YIL?=
 =?us-ascii?Q?beU8AM+2fFnUkBvzw+vfue7PNqbUpiBHtSCJd+ObBb//JyPqBcggHXKcUKdn?=
 =?us-ascii?Q?VjpMwxgxb41L7gWPGMQhol0FCXpfC78VjByxi/aZsdUq3TtTgEiKa8DHGCGX?=
 =?us-ascii?Q?QA3V6QKDdMs7OGNfo9qOMWvPfc5hymLVPJ8d11x0+gt6+ttYq6Kg9QlNXIuB?=
 =?us-ascii?Q?0LevoHpBNUBTV2/YAWenqKOzE7NX06GCJ2++oBsDUHfEM9hGFJ9lKOhOxJ0l?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 306e94de-0535-4d51-9d33-08db09b33fdf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 09:02:49.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcE4nFI+x+KmgJR/WtoTqu0CktvscEp6Nu23IfLdYMKt1TeRodaFUGFFL3spR+WPyOuLNO/S8OWOgwdO6X2Myg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6602
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--WLnuj2JREO5e8E+i
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Greg KH and kernel expert,

Greeting!

There is " __disarm_kprobe_ftrace" WARNING in v6.2-rc7 kernel in fault
injection test by syzkaller:
[   30.404796] FAULT_INJECTION: forcing a failure.
[   30.404796] name failslab, interval 1, probability 0, space 0, times 1
[   30.405595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
[   30.406044] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   30.406724] Call Trace:
[   30.406890]  <TASK>
[   30.407032]  dump_stack_lvl+0xa7/0xdb
[   30.407310]  dump_stack+0x19/0x1f
[   30.407532]  should_fail_ex.cold.5+0x5/0xa
[   30.407820]  __should_failslab+0xca/0x120
[   30.408091]  should_failslab+0x12/0x30
[   30.408341]  __kmem_cache_alloc_node+0x62/0x280
[   30.408636]  ? alloc_ftrace_hash+0x4f/0x170
[   30.408916]  kmalloc_trace+0x2e/0x120
[   30.409161]  alloc_ftrace_hash+0x4f/0x170
[   30.409426]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310
[   30.409804]  ? write_comp_data+0x2f/0x90
[   30.410078]  ftrace_set_hash+0x445/0x590
[   30.410350]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.410671]  ftrace_set_filter_ip+0xcd/0x1a0
[   30.410967]  ? __pfx_ftrace_set_filter_ip+0x10/0x10
[   30.411295]  ? match_dev_by_uuid+0x4/0x100
[   30.411574]  ? unregister_ftrace_function+0x83/0x3c0
[   30.411906]  ? __this_cpu_preempt_check+0x20/0x30
[   30.412228]  ? write_comp_data+0x2f/0x90
[   30.412507]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250
[   30.412851]  disarm_kprobe+0x24a/0x2d0
[   30.413112]  __disable_kprobe+0x2de/0x4b0
[   30.413390]  disable_kprobe+0x31/0x80
[   30.413643]  __disable_trace_kprobe+0xfb/0x1c0
[   30.413965]  disable_trace_kprobe+0x1f0/0x300
[   30.414266]  kprobe_register+0x4e/0xf0
[   30.414528]  perf_trace_event_unreg.isra.3+0xb6/0x1f0
[   30.414870]  perf_kprobe_destroy+0xcb/0x200
[   30.415156]  ? __pfx_perf_kprobe_destroy+0x10/0x10
[   30.415482]  _free_event+0x220/0x11c0
[   30.415754]  put_event+0x4d/0x60
[   30.415993]  perf_event_release_kernel+0x5d9/0x860
[   30.416330]  ? __pfx_perf_event_release_kernel+0x10/0x10
[   30.416680]  ? write_comp_data+0x2f/0x90
[   30.416950]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.417292]  ? __pfx_perf_release+0x10/0x10
[   30.417579]  perf_release+0x40/0x50
[   30.417830]  __fput+0x26d/0xa40
[   30.418080]  ____fput+0x1e/0x30
[   30.418303]  task_work_run+0x1a4/0x2d0
[   30.418565]  ? write_comp_data+0x2f/0x90
[   30.418836]  ? __pfx_task_work_run+0x10/0x10
[   30.419138]  ? __this_cpu_preempt_check+0x20/0x30
[   30.419463]  ? lockdep_hardirqs_on+0x8a/0x110
[   30.419751]  ? exit_to_user_mode_prepare+0x100/0x210
[   30.420080]  exit_to_user_mode_prepare+0x200/0x210
[   30.420392]  syscall_exit_to_user_mode+0x2d/0x60
[   30.420698]  do_syscall_64+0x4a/0x90
[   30.420944]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   30.421282] RIP: 0033:0x7f3840f1059d
[   30.421537] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   30.422690] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   30.423179] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f1059d
[   30.423630] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 0000000000000003
[   30.424081] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19fb73c0
[   30.424531] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401180
[   30.424984] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 0000000000000000
[   30.425459]  </TASK>
[   30.425891] ------------[ cut here ]------------
[   30.426223] Failed to disarm kprobe-ftrace at match_dev_by_uuid+0x4/0x100 (error -12)
[   30.426785] WARNING: CPU: 1 PID: 510 at kernel/kprobes.c:1130 __disarm_kprobe_ftrace.isra.24+0x1ed/0x250
[   30.427381] Modules linked in:
[   30.427595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
[   30.428052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   30.428759] RIP: 0010:__disarm_kprobe_ftrace.isra.24+0x1ed/0x250
[   30.429156] Code: 37 f5 05 01 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 64 49 8b 75 00 89 da 48 c7 c7 80 67 6f 85 e8 12 72 bf 03 <0f> 0b e9 03 a
[   30.430300] RSP: 0018:ffff88800c387a90 EFLAGS: 00010282
[   30.430642] RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff813dde2e
[   30.431124] RDX: 0000000000000000 RSI: ffff8880125e0000 RDI: 0000000000000002
[   30.431575] RBP: ffff88800c387ab0 R08: ffffed1001870f0b R09: ffffed1001870f0b
[   30.432028] R10: ffff88800c387857 R11: ffffed1001870f0a R12: 0000000000000000
[   30.432483] R13: ffff88800a4a9040 R14: ffffffff875a0ea0 R15: ffff88800a4a9090
[   30.432940] FS:  00007f3840deb740(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
[   30.433467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.433847] CR2: 00007f3840e4d700 CR3: 0000000011a84001 CR4: 0000000000770ee0
[   30.434301] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   30.434782] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   30.435234] PKRU: 55555554
[   30.435418] Call Trace:
[   30.435588]  <TASK>
[   30.435743]  disarm_kprobe+0x24a/0x2d0
[   30.436011]  __disable_kprobe+0x2de/0x4b0
[   30.436295]  disable_kprobe+0x31/0x80
[   30.436552]  __disable_trace_kprobe+0xfb/0x1c0
[   30.436862]  disable_trace_kprobe+0x1f0/0x300
[   30.437165]  kprobe_register+0x4e/0xf0
[   30.437429]  perf_trace_event_unreg.isra.3+0xb6/0x1f0
[   30.437778]  perf_kprobe_destroy+0xcb/0x200
[   30.438077]  ? __pfx_perf_kprobe_destroy+0x10/0x10
[   30.438407]  _free_event+0x220/0x11c0
[   30.438707]  put_event+0x4d/0x60
[   30.438938]  perf_event_release_kernel+0x5d9/0x860
[   30.439275]  ? __pfx_perf_event_release_kernel+0x10/0x10
[   30.439633]  ? write_comp_data+0x2f/0x90
[   30.439913]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.440245]  ? __pfx_perf_release+0x10/0x10
[   30.440533]  perf_release+0x40/0x50
[   30.440780]  __fput+0x26d/0xa40
[   30.441020]  ____fput+0x1e/0x30
[   30.441246]  task_work_run+0x1a4/0x2d0
[   30.441509]  ? write_comp_data+0x2f/0x90
[   30.441794]  ? __pfx_task_work_run+0x10/0x10
[   30.442090]  ? __this_cpu_preempt_check+0x20/0x30
[   30.442389]  ? lockdep_hardirqs_on+0x8a/0x110
[   30.442705]  ? exit_to_user_mode_prepare+0x100/0x210
[   30.443042]  exit_to_user_mode_prepare+0x200/0x210
[   30.443366]  syscall_exit_to_user_mode+0x2d/0x60
[   30.443683]  do_syscall_64+0x4a/0x90
[   30.443937]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   30.444281] RIP: 0033:0x7f3840f1059d
[   30.444530] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   30.445701] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   30.446211] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f1059d
[   30.446716] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 0000000000000003
[   30.447193] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19fb73c0
[   30.447661] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401180
[   30.448128] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 0000000000000000
[   30.448618]  </TASK>
[   30.448787] irq event stamp: 2017
[   30.449020] hardirqs last  enabled at (2025): [<ffffffff813dd0a1>] __up_console_sem+0x91/0xb0
[   30.449594] hardirqs last disabled at (2032): [<ffffffff813dd086>] __up_console_sem+0x76/0xb0
[   30.450803] softirqs last  enabled at (1974): [<ffffffff8536af3f>] __do_softirq+0x53f/0x836
[   30.452095] softirqs last disabled at (1965): [<ffffffff812498b0>] irq_exit_rcu+0x100/0x140
[   30.453375] ---[ end trace 0000000000000000 ]---

Bisected and found the first bad commit is:
71a7507afbc3f27c346898f13ab9bfd918613c34
Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core

It's just a clue for this issue, because reverted above commit on top
of v6.2-rc7 kernel failed.

I didn't find this kind of info in syzbot:
https://syzkaller.appspot.com/upstream

Reproduced code from syzkaller, kconfig, bisect info and v6.2-rc7 failed log
are in attached.

More info like bzimage for v6.2-rc7, each time bisect dmesg detailes are in
link: https://github.com/xupengfe/syzkaller_logs/tree/main/230207_221438___disarm_kprobe_ftrace


If you need the reproduced virtual machine environment:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
In vm and login with root,  there is no password for root.

After login vm successfully, you could transfer reproduced binary to the VM by below way, and reproduce the problem:
scp -P 10023 reproduced_binary root@localhost:/root/

Get the bzImage for target kernel:
Please use the provided kconfig and copy it to kernel_src/.config
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

I hope it's helpful.

Thanks!
BR.

--WLnuj2JREO5e8E+i
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="repro.c"

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

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

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)               \
  *(type*)(addr) =                                                             \
      htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) |           \
            (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

static bool write_file(const char* file, const char* what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static int inject_fault(int nth)
{
  int fd;
  fd = open("/proc/thread-self/fail-nth", O_RDWR);
  if (fd == -1)
    exit(1);
  char buf[16];
  sprintf(buf, "%d", nth);
  if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
    exit(1);
  return fd;
}

static void kill_and_wait(int pid, int* status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void setup_fault()
{
  static struct {
    const char* file;
    const char* val;
    bool fatal;
  } files[] = {
      {"/sys/kernel/debug/failslab/ignore-gfp-wait", "N", true},
      {"/sys/kernel/debug/fail_futex/ignore-private", "N", false},
      {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},
      {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", false},
      {"/sys/kernel/debug/fail_page_alloc/min-order", "0", false},
  };
  unsigned i;
  for (i = 0; i < sizeof(files) / sizeof(files[0]); i++) {
    if (!write_file(files[i].file, files[i].val)) {
      if (files[i].fatal)
        exit(1);
    }
  }
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void)
{
  intptr_t res = 0;
  *(uint32_t*)0x20000100 = 6;
  *(uint32_t*)0x20000104 = 0x80;
  *(uint8_t*)0x20000108 = 0;
  *(uint8_t*)0x20000109 = 0;
  *(uint8_t*)0x2000010a = 0;
  *(uint8_t*)0x2000010b = 0;
  *(uint32_t*)0x2000010c = 0;
  *(uint64_t*)0x20000110 = 0;
  *(uint64_t*)0x20000118 = 0;
  *(uint64_t*)0x20000120 = 0;
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 0, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 1, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 2, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 3, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 4, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 5, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 6, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 7, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 8, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 9, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 10, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 11, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 12, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 13, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 14, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 15, 2);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 17, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 18, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 19, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 20, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 21, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 22, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 23, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 24, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 25, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 26, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 27, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 28, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 29, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 30, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 31, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 32, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 33, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 34, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 35, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 36, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 37, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 38, 26);
  *(uint32_t*)0x20000130 = 0;
  *(uint32_t*)0x20000134 = 0;
  *(uint64_t*)0x20000138 = 0;
  *(uint64_t*)0x20000140 = 0xffffffff81003694;
  *(uint64_t*)0x20000148 = 0;
  *(uint64_t*)0x20000150 = 0;
  *(uint32_t*)0x20000158 = 0;
  *(uint32_t*)0x2000015c = 0;
  *(uint64_t*)0x20000160 = 0;
  *(uint32_t*)0x20000168 = 0;
  *(uint16_t*)0x2000016c = 0;
  *(uint16_t*)0x2000016e = 0;
  *(uint32_t*)0x20000170 = 0;
  *(uint32_t*)0x20000174 = 0;
  *(uint64_t*)0x20000178 = 0;
  res = syscall(__NR_perf_event_open, 0x20000100ul, 0, 0ul, -1, 0ul);
  if (res != -1)
    r[0] = res;
  inject_fault(1);
  syscall(__NR_close, r[0]);
}
int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  setup_fault();
  loop();
  return 0;
}

--WLnuj2JREO5e8E+i
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="bisect_info.log"

git bisect start
# status: waiting for both good and bad commits
# bad: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect bad 4ec5183ec48656cec489c49f989c508b68b518e3
# status: waiting for good commit(s), bad commit known
# good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect good f40ddce88593482919761f74910f42f4b84c004b
# good: [3bad80dab94a16c9b7991105e3bffd5fe5957e9a] Merge tag 'char-misc-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 3bad80dab94a16c9b7991105e3bffd5fe5957e9a
# good: [c2e75634cbe368065f140dd30bf8b1a0355158fd] net: atm: bring back zatm uAPI
git bisect good c2e75634cbe368065f140dd30bf8b1a0355158fd
# good: [70442fc54e6889a2a77f0e9554e8188a1557f00e] Merge tag 'x86_mm_for_v6.1_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 70442fc54e6889a2a77f0e9554e8188a1557f00e
# good: [a594533df0f6ca391da003f43d53b336a2d23ffa] Merge tag 'drm-next-2022-12-13' of git://anongit.freedesktop.org/drm/drm
git bisect good a594533df0f6ca391da003f43d53b336a2d23ffa
# good: [0948a9ef1d59d1bc7fae29f32058e463bbff4a6c] Merge branches 'acpi-resource' and 'acpi-video'
git bisect good 0948a9ef1d59d1bc7fae29f32058e463bbff4a6c
# bad: [0bc1d0e2c16736a75f73a94d3a73370801a6ceb2] tools headers disabled-cpufeatures: Sync with the kernel sources
git bisect bad 0bc1d0e2c16736a75f73a94d3a73370801a6ceb2
# good: [ba54ff1fb662215de683777f815b9e96276d55cf] Merge tag 'char-misc-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good ba54ff1fb662215de683777f815b9e96276d55cf
# bad: [a6e3e6f138058ff184d8ef5064a033b3f5fee8f8] Merge tag 'mm-nonmm-stable-2022-12-17-20-32' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad a6e3e6f138058ff184d8ef5064a033b3f5fee8f8
# good: [e8478b84d6ba9ccfac15dfce103062c4fa7ded2f] perf test: add new task-analyzer tests
git bisect good e8478b84d6ba9ccfac15dfce103062c4fa7ded2f
# bad: [b611996ef270a88ebb350c82832c4d76913887e9] Merge tag 'linux-watchdog-6.2-rc1' of git://www.linux-watchdog.org/linux-watchdog
git bisect bad b611996ef270a88ebb350c82832c4d76913887e9
# bad: [dcde56bb37a9f900c11eec56b0ecaca5653cc829] Fix mismerge due to devnode now taking a 'const *' device
git bisect bad dcde56bb37a9f900c11eec56b0ecaca5653cc829
# good: [2a4e628570d42fcc13a94f1acf25e3cfeaec08f6] resource: Replace printk(KERN_WARNING) by pr_warn(), printk() by pr_info()
git bisect good 2a4e628570d42fcc13a94f1acf25e3cfeaec08f6
# good: [40eb28dc17f87cfac69d7755447039e92ac5fbda] device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
git bisect good 40eb28dc17f87cfac69d7755447039e92ac5fbda
# good: [69b14fde0b8dd159ba19d2b2083a0f2958a9130c] driver core: fix up missed scsi/cxlflash class.devnode() conversion.
git bisect good 69b14fde0b8dd159ba19d2b2083a0f2958a9130c
# good: [c3da679286bee1d897bb24a804cca4ff58781bec] usb.h: take advantage of container_of_const()
git bisect good c3da679286bee1d897bb24a804cca4ff58781bec
# good: [f18caf261398a7f2de4fa3f600deb87072fe7b8d] device property: Fix documentation for fwnode_get_next_parent()
git bisect good f18caf261398a7f2de4fa3f600deb87072fe7b8d
# bad: [71a7507afbc3f27c346898f13ab9bfd918613c34] Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect bad 71a7507afbc3f27c346898f13ab9bfd918613c34
# first bad commit: [71a7507afbc3f27c346898f13ab9bfd918613c34] Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
|0208_090424|/root/bzimage_bisect/make_bz.sh -k /root/linux -m 4ec5183ec48656cec489c49f989c508b68b518e3 -b 71a7507afbc3f27c346898f13ab9bfd918613c34 -d /home/bzimage -o /tmp/kernel -f /home/bzimage/bzImage_4ec5183ec48656cec489c49f989c508b68b518e3_71a7507afbc3f27c346898f13ab9bfd918613c34_revert|
|0208_090505|FAIL|bzImage:/home/bzimage/bzImage_4ec5183ec48656cec489c49f989c508b68b518e3_71a7507afbc3f27c346898f13ab9bfd918613c34_revert does not exist:|

--WLnuj2JREO5e8E+i
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kconfig"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 6.2.0-rc7 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-17)"
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
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=122
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
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
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
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
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
CONFIG_XEN_PV_MSR_SAFE=y
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
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_LATE_LOADING is not set
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
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
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

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
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
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
# CONFIG_CHTCRC_PMIC_OPREGION is not set
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_BXT_WC_PMIC_OPREGION=y
# CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
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
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_WERROR=y
CONFIG_KVM_INTEL=m
CONFIG_X86_SGX_KVM=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

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
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
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
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
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
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
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
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
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
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
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
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
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
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

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
CONFIG_INET_TABLE_PERTURB_ORDER=16
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
CONFIG_NFT_TUNNEL=m
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
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
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
CONFIG_NET_DSA_TAG_NONE=m
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
# CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set
CONFIG_NET_DSA_TAG_LAN9303=m
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=m
# CONFIG_NET_DSA_TAG_XRS700X is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
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
CONFIG_BT_LE_L2CAP_ECRED=y
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
CONFIG_BT_HCIBTUSB_POLL_SYNC=y
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
# CONFIG_BT_HCIBCM4377 is not set
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
# CONFIG_RXPERF is not set
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
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_XEN_PCIDEV_FRONTEND=m
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
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
# CONFIG_PCI_EPF_VNTB is not set
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
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
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
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
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
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=m
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
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
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_FD_RAWCMD is not set
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
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
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
# CONFIG_BLK_DEV_UBLK is not set

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
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=y
CONFIG_NVME_TARGET_TCP=y
# CONFIG_NVME_TARGET_AUTH is not set
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
# CONFIG_VCPU_STALL_DETECTOR is not set
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
# CONFIG_INTEL_MEI_GSC is not set
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_INTEL_MEI_PXP is not set
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
# CONFIG_AHCI_DWC is not set
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
CONFIG_ATM_NICSTAR=m
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
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
# CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON is not set
CONFIG_NET_DSA_MV88E6XXX=m
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_MSCC_SEVILLE is not set
# CONFIG_NET_DSA_AR9331 is not set
CONFIG_NET_DSA_QCA8K=m
# CONFIG_NET_DSA_SJA1105 is not set
# CONFIG_NET_DSA_XRS700X_I2C is not set
# CONFIG_NET_DSA_XRS700X_MDIO is not set
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
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
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
# CONFIG_MLX5_EN_MACSEC is not set
# CONFIG_MLX5_EN_IPSEC is not set
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
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=m
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
CONFIG_NFP_NET_IPSEC=y
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
# CONFIG_SFC_SIENA is not set
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
# CONFIG_ADIN1100_PHY is not set
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
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
CONFIG_MICREL_KS8995MA=m
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
CONFIG_CAN_JANZ_ICAN3=m
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
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
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
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
CONFIG_PCS_ALTERA_TSE=m
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
CONFIG_USB_RTL8153_ECM=m
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
# CONFIG_MT7996E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WILC1000=m
CONFIG_WILC1000_SDIO=m
CONFIG_WILC1000_SPI=m
CONFIG_WILC1000_HW_OOB_INTR=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
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
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
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
CONFIG_USB4_NET=y
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
# CONFIG_KEYBOARD_PINEPHONE is not set
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
# CONFIG_JOYSTICK_SENSEHAT is not set
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
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
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
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
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
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
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
# CONFIG_INPUT_IQS7222 is not set
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
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
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
# CONFIG_TCG_TIS_I2C is not set
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
# CONFIG_I2C_PCI1XXXX is not set
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
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=m
# CONFIG_SPI_PCI1XXXX is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_SN_F_OSPI is not set
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
# CONFIG_PINCTRL_CY8C95X0 is not set
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
CONFIG_GPIO_IDIO_16=m

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
CONFIG_GPIO_I8255=m
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
# CONFIG_GPIO_LATCH is not set
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
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
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
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
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
# CONFIG_SENSORS_LT7182S is not set
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
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
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
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC2305 is not set
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
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_EBC_C384_WDT=m
# CONFIG_EXAR_WDT is not set
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
# CONFIG_MFD_SMPRO is not set
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
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_OCELOT is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
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
# CONFIG_MFD_TPS65219 is not set
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
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6357 is not set
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
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
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
CONFIG_VIDEO_USBTV=m
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y

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
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=m
CONFIG_VIDEO_IVTV=m
CONFIG_VIDEO_IVTV_ALSA=m
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set

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
CONFIG_VIDEO_IPU3_CIO2=m
# CONFIG_CIO2_BRIDGE is not set
CONFIG_RADIO_ADAPTERS=m
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
# Microchip Technology, Inc. media platform drivers
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
# CONFIG_VIDEO_VISL is not set
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
# CONFIG_VIDEO_AR0521 is not set
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
# CONFIG_VIDEO_OV08X40 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
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
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_ST_VGXY61 is not set
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
# CONFIG_VIDEO_TC358746 is not set
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
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
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
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
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
CONFIG_DRM_AMD_DC_DCN=y
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DRM_AMD_DC_SI is not set
# CONFIG_DEBUG_KERNEL_DC is not set
# CONFIG_DRM_AMD_SECURE_DISPLAY is not set
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
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_USE_MIPI_DSI is not set
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
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
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
# CONFIG_DRM_PANEL_NEWVISION_NV3051D is not set
# CONFIG_DRM_PANEL_NEWVISION_NV3052C is not set
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
# CONFIG_DRM_LONTIUM_LT9211 is not set
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
# CONFIG_DRM_TI_DLPC3433 is not set
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
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_IMX_LCDIF is not set
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
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
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
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
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
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
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
# CONFIG_SND_SERIAL_GENERIC is not set
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
# CONFIG_SND_SOC_AMD_ST_ES8336_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
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
CONFIG_SND_SOC_FSL_UTILS=m
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
# CONFIG_SND_SOC_SOF_NOCODEC_DEBUG_SUPPORT is not set
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
CONFIG_SND_SOC_SOF_IPC3=y
CONFIG_SND_SOC_SOF_INTEL_IPC4=y
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_INTEL_SKL=m
CONFIG_SND_SOC_SOF_SKYLAKE=m
CONFIG_SND_SOC_SOF_KABYLAKE=m
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
CONFIG_SND_SOC_SOF_INTEL_MTL=m
CONFIG_SND_SOC_SOF_METEORLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=m
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
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS42L83 is not set
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
# CONFIG_SND_SOC_ES8326 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_HDA is not set
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
# CONFIG_SND_SOC_MAX98396 is not set
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
CONFIG_SND_SOC_RT1318_SDW=m
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
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
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
# CONFIG_SND_SOC_TAS2780 is not set
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
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8731_SPI is not set
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
# CONFIG_SND_SOC_WM8940 is not set
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8961 is not set
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_WSA883X is not set
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
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MEGAWORLD_FF is not set
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
# CONFIG_HID_PXRC is not set
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
# CONFIG_HID_TOPRE is not set
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
# CONFIG_I2C_HID_OF_ELAN is not set
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

#
# USB dual-mode controller drivers
#
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
# CONFIG_USB_ONBOARD_HUB is not set
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
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_WCOVE=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=m
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
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
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
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
# RGB LED drivers
#

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
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_CXGB4=m
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
# CONFIG_INFINIBAND_IRDMA is not set
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_QEDR=m
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
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
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
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
# CONFIG_RTC_DRV_NCT3018Y is not set
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
# CONFIG_VFIO_CONTAINER is not set
CONFIG_VFIO_VIRQFD=y
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
# CONFIG_EFI_SECRET is not set
CONFIG_SEV_GUEST=m
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
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
# CONFIG_XEN_VIRTIO is not set
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
# CONFIG_VIDEO_IPU3_IMGU is not set
# CONFIG_VIDEO_MAX96712 is not set
# CONFIG_STAGING_MEDIA_DEPRECATED is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_LTE_GDM724X=m
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
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
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
# CONFIG_CROS_HPS_I2C is not set
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_CROS_TYPEC_SWITCH=m
# CONFIG_WILCO_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE3_WMI=m
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
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
# CONFIG_AMD_PMF is not set
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
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
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

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TELEMETRY is not set
CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
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
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
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
# CONFIG_COMMON_CLK_VC7 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=m
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
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
CONFIG_IOMMUFD=y
CONFIG_IOMMUFD_VFIO_CONTAINER=y
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
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
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
# CONFIG_MSA311 is not set
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
# CONFIG_AD4130 is not set
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
# CONFIG_MAX11205 is not set
# CONFIG_MAX11410 is not set
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
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
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
# CONFIG_AD74115 is not set
# CONFIG_AD74413R is not set
CONFIG_STX104=m
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
CONFIG_AD7746=m
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
# CONFIG_ADF4377 is not set
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
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
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
# CONFIG_LTRF216A is not set
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
# CONFIG_MAX30208 is not set
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
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
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
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_TI_TPS380X is not set

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
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
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
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_NVMEM_U_BOOT_ENV is not set

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
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
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
# CONFIG_HTE is not set
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
# CONFIG_CACHEFILES_ONDEMAND is not set
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
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
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
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
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
# CONFIG_NFSD_V2 is not set
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
# CONFIG_DLM_DEPRECATED_API is not set
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
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=0
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
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
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
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

CONFIG_RANDSTRUCT_NONE=y
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
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

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
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
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
# CONFIG_CRYPTO_SM4_GENERIC is not set
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
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_CHACHA20POLY1305=m
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
CONFIG_CRYPTO_POLY1305=m
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
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
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
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

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
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

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
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
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
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
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
CONFIG_INTERVAL_TREE_SPAN_ITER=y
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
# CONFIG_FORCE_NR_CPUS is not set
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
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
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
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
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
CONFIG_OBJTOOL=y
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
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
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
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
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
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
# CONFIG_KASAN_VMALLOC is not set
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
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
CONFIG_DEBUG_PREEMPT=y

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
CONFIG_SCF_TORTURE_TEST=m
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
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
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=100
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
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
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
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
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
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
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
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
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--WLnuj2JREO5e8E+i
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment;
	filename="4ec5183ec48656cec489c49f989c508b68b518e3_dmesg.log"
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version rel-1.14.0-0-g155821a1990b-prebuilt=
.qemu.org)=0D


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+7FF8F030+7FEEF030 CA00=
=0D
Press Ctrl-B to configure iPXE (PCI 00:03.0)...=0D                         =
                                                      =0D


Booting from ROM...=0D
=1Bc=1B[?7l=1B[2J[    0.000000] Linux version 6.2.0-rc7-4ec5183ec486 (root@=
p-mtlp02) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18), GNU ld version 2.36=
.1-2.el8) #1 SMP PREEMPT_DYNAMIC Mon Feb  6 10:18:07 CST 2023=0D
[    0.000000] Command line: console=3DttyS0 root=3D/dev/sda earlyprintk=3D=
serial net.ifnames=3D0=0D
[    0.000000] KERNEL supported cpus:=0D
[    0.000000]   Intel GenuineIntel=0D
[    0.000000]   AMD AuthenticAMD=0D
[    0.000000]   Hygon HygonGenuine=0D
[    0.000000]   Centaur CentaurHauls=0D
[    0.000000]   zhaoxin   Shanghai  =0D
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_loc=
ks=0D
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
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0=
-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[    0.000000] Hypervisor detected: KVM=0D
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000011] kvm-clock: using sched offset of 874724882 cycles=0D
[    0.001043] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.004172] tsc: Detected 1190.400 MHz processor=0D
[    0.014139] last_pfn =3D 0x7ffe0 max_arch_pfn =3D 0x400000000=0D
[    0.014721] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =0D
[    0.026883] found SMP MP-table at [mem 0x000f5a90-0x000f5a9f]=0D
[    0.027590] Using GB pages for direct mapping=0D
[    0.029866] ACPI: Early table checksum verification disabled=0D
[    0.030438] ACPI: RSDP 0x00000000000F5870 000014 (v00 BOCHS )=0D
[    0.030997] ACPI: RSDT 0x000000007FFE1959 000034 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.031809] ACPI: FACP 0x000000007FFE1805 000074 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.032620] ACPI: DSDT 0x000000007FFE0040 0017C5 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.033418] ACPI: FACS 0x000000007FFE0000 000040=0D
[    0.033862] ACPI: APIC 0x000000007FFE1879 000080 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.034665] ACPI: HPET 0x000000007FFE18F9 000038 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.035459] ACPI: WAET 0x000000007FFE1931 000028 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.036250] ACPI: Reserving FACP table memory at [mem 0x7ffe1805-0x7ffe1=
878]=0D
[    0.036894] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe1=
804]=0D
[    0.037550] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe0=
03f]=0D
[    0.038215] ACPI: Reserving APIC table memory at [mem 0x7ffe1879-0x7ffe1=
8f8]=0D
[    0.038868] ACPI: Reserving HPET table memory at [mem 0x7ffe18f9-0x7ffe1=
930]=0D
[    0.039525] ACPI: Reserving WAET table memory at [mem 0x7ffe1931-0x7ffe1=
958]=0D
[    0.041261] No NUMA configuration found=0D
[    0.041631] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]=
=0D
[    0.042370] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]=0D
[    0.074683] Zone ranges:=0D
[    0.074975]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0D
[    0.075558]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]=0D
[    0.076135]   Normal   empty=0D
[    0.076409]   Device   empty=0D
[    0.076683] Movable zone start for each node=0D
[    0.077079] Early memory node ranges=0D
[    0.077411]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0D
[    0.077992]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]=0D
[    0.078583] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdf=
fff]=0D
[    0.079260] On node 0, zone DMA: 1 pages in unavailable ranges=0D
[    0.079367] On node 0, zone DMA: 97 pages in unavailable ranges=0D
[    0.091618] On node 0, zone DMA32: 32 pages in unavailable ranges=0D
[    0.384337] kasan: KernelAddressSanitizer initialized=0D
[    0.385781] ACPI: PM-Timer IO Port: 0x608=0D
[    0.386246] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])=0D
[    0.386927] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23=0D
[    0.387640] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0D
[    0.388268] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)=
=0D
[    0.388919] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=
=0D
[    0.389578] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level=
)=0D
[    0.390245] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level=
)=0D
[    0.390932] ACPI: Using ACPI (MADT) for SMP configuration information=0D
[    0.391568] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.392085] TSC deadline timer available=0D
[    0.392479] smpboot: Allowing 2 CPUs, 0 hotplug CPUs=0D
[    0.393107] kvm-guest: KVM setup pv remote TLB flush=0D
[    0.393599] kvm-guest: setup PV sched yield=0D
[    0.394178] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]=0D
[    0.394914] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]=0D
[    0.395638] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000effff]=0D
[    0.396369] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0=
x000fffff]=0D
[    0.397103] [mem 0x80000000-0xfeffbfff] available for PCI devices=0D
[    0.397694] Booting paravirtualized kernel on KVM=0D
[    0.398240] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns=0D
[    0.399273] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr=
_node_ids:1=0D
[    0.401976] percpu: Embedded 80 pages/cpu s290816 r8192 d28672 u1048576=
=0D
[    0.402977] kvm-guest: PV spinlocks enabled=0D
[    0.403400] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, =
linear)=0D
[    0.404184] Fallback order for Node 0: 0 =0D
[    0.404616] Built 1 zonelists, mobility grouping on.  Total pages: 51580=
8=0D
[    0.405278] Policy zone: DMA32=0D
[    0.405580] Kernel command line: net.ifnames=3D0 console=3DttyS0 root=3D=
/dev/sda earlyprintk=3Dserial net.ifnames=3D0=0D
[    0.407534] random: crng init done=0D
[    0.409752] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)=0D
[    0.411650] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)=0D
[    0.413161] mem auto-init: stack:off, heap alloc:off, heap free:off=0D
[    0.429278] stackdepot hash table entries: 1048576 (order: 11, 8388608 b=
ytes, linear)=0D
[    0.479570] Memory: 1631820K/2096632K available (71680K kernel code, 140=
07K rwdata, 16476K rodata, 14104K init, 20784K bss, 464556K reserved, 0K cm=
a-reserved)=0D
[    0.482002] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1=0D
[    0.482627] kmemleak: Kernel memory leak detector disabled=0D
[    0.483366] ftrace: allocating 68501 entries in 268 pages=0D
[    0.535878] ftrace: allocated 268 pages with 3 groups=0D
[    0.543358] Dynamic Preempt: voluntary=0D
[    0.544199] Running RCU self tests=0D
[    0.544540] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.545074] rcu: 	RCU lockdep checking is enabled.=0D
[    0.545518] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D2.=0D
[    0.546155] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.546633] 	Rude variant of Tasks RCU enabled.=0D
[    0.547063] 	Tracing variant of Tasks RCU enabled.=0D
[    0.547522] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.548224] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2=0D
[    0.602258] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16=0D
[    0.603409] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.612456] Console: colour VGA+ 80x25=0D
[    0.612902] printk: console [ttyS0] enabled=0D
[    0.612902] printk: console [ttyS0] enabled=0D
[    0.613684] printk: bootconsole [earlyser0] disabled=0D
[    0.613684] printk: bootconsole [earlyser0] disabled=0D
[    0.614616] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0D
[    0.615336] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.615723] ... MAX_LOCK_DEPTH:          48=0D
[    0.616109] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.616521] ... CLASSHASH_SIZE:          4096=0D
[    0.616932] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.617350] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.617769] ... CHAINHASH_SIZE:          32768=0D
[    0.618200]  memory used by lock dependency info: 6365 kB=0D
[    0.618715]  memory used for stack traces: 4224 kB=0D
[    0.619164]  per task-struct memory footprint: 1920 bytes=0D
[    0.619769] ACPI: Core revision 20221020=0D
[    0.620657] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns=0D
[    0.621734] APIC: Switch to symmetric I/O mode setup=0D
[    0.622418] x2apic enabled=0D
[    0.622893] Switched APIC routing to physical x2apic.=0D
[    0.623370] kvm-guest: setup PV IPIs=0D
[    0.624923] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1=0D
[    0.625534] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x1128af0325d, max_idle_ns: 440795261011 ns=0D
[    0.626680] Calibrating delay loop (skipped) preset value.. 2380.80 Bogo=
MIPS (lpj=3D4761600)=0D
[    0.627457] pid_max: default: 32768 minimum: 301=0D
[    0.628142] LSM: initializing lsm=3Dcapability,yama,integrity=0D
[    0.628693] Yama: becoming mindful.=0D
[    0.629449] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)=0D
[    0.630682] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)=0D
[    0.633748] CPU0: Thermal monitoring enabled (TM1)=0D
[    0.638716] x86/cpu: User Mode Instruction Prevention (UMIP) activated=
=0D
[    0.640102] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.640665] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=0D
[    0.641294] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization=0D
[    0.642066] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[    0.642687] Spectre V2 : Mitigation: Enhanced IBRS=0D
[    0.643111] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch=0D
[    0.643821] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT=0D
[    0.644494] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier=0D
[    0.645244] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl=0D
[    0.646657] MMIO Stale Data: Unknown: No mitigations=0D
[    0.835529] Freeing SMP alternatives memory: 56K=0D
[    0.836841] smpboot: CPU0: Genuine Intel(R) 0000 (family: 0x6, model: 0x=
aa, stepping: 0x1)=0D
[    0.839234] cblist_init_generic: Setting adjustable number of callback q=
ueues.=0D
[    0.839922] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.840556] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.841192] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.841831] Running RCU-tasks wait API self tests=0D
[    0.943018] Performance Events: generic architected perfmon, full-width =
counters, Intel PMU driver.=0D
[    0.944869] ... version:                2=0D
[    0.945546] ... bit width:              48=0D
[    0.945911] ... generic registers:      8=0D
[    0.946261] ... value mask:             0000ffffffffffff=0D
[    0.946668] ... max period:             00007fffffffffff=0D
[    0.947124] ... fixed-purpose events:   3=0D
[    0.947473] ... event mask:             00000007000000ff=0D
[    0.948772] rcu: Hierarchical SRCU implementation.=0D
[    0.949200] rcu: 	Max phase no-delay instances is 1000.=0D
[    0.954282] smp: Bringing up secondary CPUs ...=0D
[    0.954706] Callback from call_rcu_tasks_trace() invoked.=0D
[    0.956061] x86: Booting SMP configuration:=0D
[    0.956444] .... node  #0, CPUs:      #1=0D
[    0.018605] smpboot: CPU 1 Converting physical 0 to logical die 1=0D
[    0.963128] smp: Brought up 1 node, 2 CPUs=0D
[    0.963251] smpboot: Max logical packages: 2=0D
[    0.963637] smpboot: Total of 2 processors activated (4761.60 BogoMIPS)=
=0D
[    0.971129] devtmpfs: initialized=0D
[    0.971784] x86/mm: Memory block size: 128MB=0D
[    0.984172] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0D
[    0.984444] futex hash table entries: 512 (order: 4, 65536 bytes, linear=
)=0D
[    0.987245] pinctrl core: initialized pinctrl subsystem=0D
[    0.989191] =0D
[    0.989348] ************************************************************=
*=0D
[    0.989949] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.990548] **                                                         *=
*=0D
[    0.990662] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  *=
*=0D
[    0.991261] **                                                         *=
*=0D
[    0.991869] ** This means that this kernel is built to expose internal *=
*=0D
[    0.992471] ** IOMMU data structures, which may compromise security on *=
*=0D
[    0.993070] ** your system.                                            *=
*=0D
[    0.993677] **                                                         *=
*=0D
[    0.994273] ** If you see this message and you are not debugging the   *=
*=0D
[    0.994660] ** kernel, report this immediately to your vendor!         *=
*=0D
[    0.995267] **                                                         *=
*=0D
[    0.995871] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.996473] ************************************************************=
*=0D
[    0.997165] PM: RTC time: 14:15:02, date: 2023-02-07=0D
[    1.004505] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0D
[    1.006405] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions=0D
[    1.006711] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations=0D
[    1.007588] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations=0D
[    1.008567] audit: initializing netlink subsys (disabled)=0D
[    1.009335] audit: type=3D2000 audit(1675779303.842:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1=0D
[    1.012191] thermal_sys: Registered thermal governor 'fair_share'=0D
[    1.012202] thermal_sys: Registered thermal governor 'bang_bang'=0D
[    1.012878] thermal_sys: Registered thermal governor 'step_wise'=0D
[    1.013524] thermal_sys: Registered thermal governor 'user_space'=0D
[    1.014274] cpuidle: using governor ladder=0D
[    1.015123] cpuidle: using governor menu=0D
[    1.016121] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5=0D
[    1.017522] PCI: Using configuration type 1 for base access=0D
[    1.019622] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.=0D
[    1.390936] Callback from call_rcu_tasks_rude() invoked.=0D
[    1.439595] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s=0D
[    1.440253] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page=
=0D
[    1.440840] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s=0D
[    1.441439] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page=0D
[    1.449146] ACPI: Added _OSI(Module Device)=0D
[    1.449587] ACPI: Added _OSI(Processor Device)=0D
[    1.449990] ACPI: Added _OSI(3.0 _SCP Extensions)=0D
[    1.450414] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    1.470489] ACPI: 1 ACPI AML tables successfully acquired and loaded=0D
[    1.478595] ACPI: Interpreter enabled=0D
[    1.478876] ACPI: PM: (supports S0 S3 S4 S5)=0D
[    1.479293] ACPI: Using IOAPIC for interrupt routing=0D
[    1.479915] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug=0D
[    1.480772] PCI: Using E820 reservations for host bridge windows=0D
[    1.482993] ACPI: Enabled 2 GPEs in block 00 to 0F=0D
[    1.498772] Callback from call_rcu_tasks() invoked.=0D
[    1.528226] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])=0D
[    1.528919] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I EDR HPX-Type3]=0D
[    1.529687] acpi PNP0A03:00: _OSC: not requesting OS control; OS require=
s [ExtendedConfig ASPM ClockPM MSI]=0D
[    1.530819] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge=0D
[    1.538057] acpiphp: Slot [3] registered=0D
[    1.538635] acpiphp: Slot [4] registered=0D
[    1.538861] acpiphp: Slot [5] registered=0D
[    1.539450] acpiphp: Slot [6] registered=0D
[    1.540018] acpiphp: Slot [7] registered=0D
[    1.540582] acpiphp: Slot [8] registered=0D
[    1.541159] acpiphp: Slot [9] registered=0D
[    1.541748] acpiphp: Slot [10] registered=0D
[    1.542317] acpiphp: Slot [11] registered=0D
[    1.542839] acpiphp: Slot [12] registered=0D
[    1.543415] acpiphp: Slot [13] registered=0D
[    1.544036] acpiphp: Slot [14] registered=0D
[    1.544618] acpiphp: Slot [15] registered=0D
[    1.545209] acpiphp: Slot [16] registered=0D
[    1.545803] acpiphp: Slot [17] registered=0D
[    1.546703] acpiphp: Slot [18] registered=0D
[    1.547322] acpiphp: Slot [19] registered=0D
[    1.547933] acpiphp: Slot [20] registered=0D
[    1.548545] acpiphp: Slot [21] registered=0D
[    1.549175] acpiphp: Slot [22] registered=0D
[    1.549772] acpiphp: Slot [23] registered=0D
[    1.550383] acpiphp: Slot [24] registered=0D
[    1.550822] acpiphp: Slot [25] registered=0D
[    1.551447] acpiphp: Slot [26] registered=0D
[    1.552051] acpiphp: Slot [27] registered=0D
[    1.552673] acpiphp: Slot [28] registered=0D
[    1.553308] acpiphp: Slot [29] registered=0D
[    1.553956] acpiphp: Slot [30] registered=0D
[    1.554580] acpiphp: Slot [31] registered=0D
[    1.554758] PCI host bridge to bus 0000:00=0D
[    1.555246] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]=0D
[    1.556034] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]=0D
[    1.556808] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]=0D
[    1.557658] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f window]=0D
[    1.558513] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17ffff=
fff window]=0D
[    1.558670] pci_bus 0000:00: root bus resource [bus 00-ff]=0D
[    1.559575] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=0D
[    1.571540] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=0D
[    1.573814] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=0D
[    1.576080] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]=0D
[    1.577467] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]=0D
[    1.578282] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]=
=0D
[    1.578664] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]=0D
[    1.579475] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]=
=0D
[    1.580821] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=0D
[    1.581920] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI=0D
[    1.582670] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB=0D
[    1.584046] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=0D
[    1.587217] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]=
=0D
[    1.590785] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]=0D
[    1.598509] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]=
=0D
[    1.599179] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]=0D
[    1.622355] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000=0D
[    1.624108] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]=0D
[    1.626576] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]=0D
[    1.631897] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]=
=0D
[    1.682734] ACPI: PCI: Interrupt link LNKA configured for IRQ 10=0D
[    1.686310] ACPI: PCI: Interrupt link LNKB configured for IRQ 10=0D
[    1.688688] ACPI: PCI: Interrupt link LNKC configured for IRQ 11=0D
[    1.692102] ACPI: PCI: Interrupt link LNKD configured for IRQ 11=0D
[    1.694195] ACPI: PCI: Interrupt link LNKS configured for IRQ 9=0D
[    1.702509] iommu: Default domain type: Translated =0D
[    1.702705] iommu: DMA domain TLB invalidation policy: lazy mode =0D
[    1.713751] SCSI subsystem initialized=0D
[    1.716445] ACPI: bus type USB registered=0D
[    1.717744] usbcore: registered new interface driver usbfs=0D
[    1.718930] usbcore: registered new interface driver hub=0D
[    1.720202] usbcore: registered new device driver usb=0D
[    1.722104] pps_core: LinuxPPS API ver. 1 registered=0D
[    1.722677] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>=0D
[    1.724624] PTP clock support registered=0D
[    1.726384] EDAC MC: Ver: 3.0.0=0D
[    1.734904] NetLabel: Initializing=0D
[    1.735701] NetLabel:  domain hash size =3D 128=0D
[    1.736624] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0D
[    1.738351] NetLabel:  unlabeled traffic allowed by default=0D
[    1.775938] PCI: Using ACPI for IRQ routing=0D
[    1.777932] pci 0000:00:02.0: vgaarb: setting as boot VGA device=0D
[    1.778652] pci 0000:00:02.0: vgaarb: bridge control possible=0D
[    1.778652] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone=0D
[    1.778680] vgaarb: loaded=0D
[    1.781707] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0D
[    1.782685] hpet0: 3 comparators, 64-bit 100.000000 MHz counter=0D
[    5.186218] clocksource: Switched to clocksource kvm-clock=0D
[    5.192506] VFS: Disk quotas dquot_6.6.0=0D
[    5.193567] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0D
[    5.196527] pnp: PnP ACPI init=0D
[    5.205728] pnp: PnP ACPI: found 6 devices=0D
[    5.245240] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns=0D
[    5.248317] NET: Registered PF_INET protocol family=0D
[    5.250790] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)=0D
[    5.256334] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4,=
 73728 bytes, linear)=0D
[    5.258327] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)=0D
[    5.260152] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)=0D
[    5.263203] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes,=
 linear)=0D
[    5.270876] TCP: Hash tables configured (established 16384 bind 16384)=
=0D
[    5.273365] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear=
)=0D
[    5.275464] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, l=
inear)=0D
[    5.278293] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    5.281897] RPC: Registered named UNIX socket transport module.=0D
[    5.283282] RPC: Registered udp transport module.=0D
[    5.284268] RPC: Registered tcp transport module.=0D
[    5.285249] RPC: Registered tcp NFSv4.1 backchannel transport module.=0D
[    5.286647] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]=0D
[    5.287988] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]=0D
[    5.289290] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]=0D
[    5.290769] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff windo=
w]=0D
[    5.292213] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff win=
dow]=0D
[    5.294645] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    5.295932] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=0D
[    5.297432] PCI: CLS 0 bytes, default 64=0D
[    5.300166] ACPI: bus type thunderbolt registered=0D
[    5.302155] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x112=
8af0325d, max_idle_ns: 440795261011 ns=0D
[    5.523262] Initialise system trusted keyrings=0D
[    5.524121] Key type blacklist registered=0D
[    5.525270] workingset: timestamp_bits=3D36 max_order=3D19 bucket_order=
=3D0=0D
[    5.526776] zbud: loaded=0D
[    5.531097] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0D
[    5.535219] NFS: Registering the id_resolver key type=0D
[    5.536270] Key type id_resolver registered=0D
[    5.537119] Key type id_legacy registered=0D
[    5.538091] nfs4filelayout_init: NFSv4 File Layout Driver Registering...=
=0D
[    5.539653] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...=0D
[    5.541855] fuse: init (API version 7.38)=0D
[    5.543448] SGI XFS with ACLs, security attributes, realtime, quota, no =
debug enabled=0D
[    5.547543] 9p: Installing v9fs 9p2000 file system support=0D
[    5.560800] Key type asymmetric registered=0D
[    5.561775] Asymmetric key parser 'x509' registered=0D
[    5.563260] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)=0D
[    5.565422] io scheduler mq-deadline registered=0D
[    5.566639] io scheduler bfq registered=0D
[    5.569342] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=
=0D
[    5.572592] IPMI message handler: version 39.2=0D
[    5.573823] ipmi device interface=0D
[    5.579097] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0=0D
[    5.581642] ACPI: button: Power Button [PWRF]=0D
[    5.586110] ERST DBG: ERST support is disabled.=0D
[    5.591147] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled=0D
[    5.593883] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A=0D
[    5.623840] Linux agpgart interface v0.103=0D
[    5.626369] ACPI: bus type drm_connector registered=0D
[    5.651621] brd: module loaded=0D
[    5.666160] loop: module loaded=0D
[    5.677015] scsi host0: ata_piix=0D
[    5.679036] scsi host1: ata_piix=0D
[    5.679739] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 1=
4=0D
[    5.680371] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 1=
5=0D
[    5.683204] tun: Universal TUN/TAP device driver, 1.6=0D
[    5.684119] e100: Intel(R) PRO/100 Network Driver=0D
[    5.684573] e100: Copyright(c) 1999-2006 Intel Corporation=0D
[    5.685202] e1000: Intel(R) PRO/1000 Network Driver=0D
[    5.685705] e1000: Copyright (c) 1999-2006 Intel Corporation.=0D
[    5.838937] ata1: found unknown device (class 0)=0D
[    5.840529] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100=0D
[    5.841265] ata1.00: 16777216 sectors, multi 16: LBA48 =0D
[    5.842330] ata2: found unknown device (class 0)=0D
[    5.843489] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100=0D
[    5.846033] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    5.850469] sd 0:0:0:0: Attached scsi generic sg0 type 0=0D
[    5.850493] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB=
/8.00 GiB)=0D
[    5.852187] sd 0:0:0:0: [sda] Write Protect is off=0D
[    5.852951] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.=
5+ PQ: 0 ANSI: 5=0D
[    5.853015] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    5.857298] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes=0D
[    5.876631] scsi 1:0:0:0: Attached scsi generic sg1 type 5=0D
[    5.880336] sd 0:0:0:0: [sda] Attached SCSI disk=0D
[    6.575401] ACPI: \_SB_.LNKC: Enabled at IRQ 11=0D
[    6.919085] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:5=
6=0D
[    6.919779] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connectio=
n=0D
[    6.920605] e1000e: Intel(R) PRO/1000 Network Driver=0D
[    6.921056] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0D
[    6.921703] igb: Intel(R) Gigabit Ethernet Network Driver=0D
[    6.922189] igb: Copyright (c) 2007-2014 Intel Corporation.=0D
[    6.922952] PPP generic driver version 2.4.2=0D
[    6.924553] VFIO - User Level meta-driver version: 0.3=0D
[    6.926259] usbcore: registered new interface driver uas=0D
[    6.926844] usbcore: registered new interface driver usb-storage=0D
[    6.927714] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12=0D
[    6.929708] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    6.930258] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    6.932019] mousedev: PS/2 mouse device common for all mice=0D
[    6.933760] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1=0D
[    6.936086] rtc_cmos 00:05: RTC can wake from S4=0D
[    6.936602] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input4=0D
[    6.939188] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input3=0D
[    6.940532] rtc_cmos 00:05: registered as rtc0=0D
[    6.941639] rtc_cmos 00:05: setting system clock to 2023-02-07T14:15:08 =
UTC (1675779308)=0D
[    6.943925] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, =
hpet irqs=0D
[    6.945607] i2c_dev: i2c /dev entries driver=0D
[    6.946507] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.=0D
[    6.947648] device-mapper: uevent: version 1.0.3=0D
[    6.948546] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised:=
 dm-devel@redhat.com=0D
[    6.949298] intel_pstate: CPU model not supported=0D
[    6.950003] sdhci: Secure Digital Host Controller Interface driver=0D
[    6.950589] sdhci: Copyright(c) Pierre Ossman=0D
[    6.951215] sdhci-pltfm: SDHCI platform and OF driver helper=0D
[    6.951831] ledtrig-cpu: registered to indicate activity on CPUs=0D
[    6.953198] drop_monitor: Initializing network drop monitor service=0D
[    6.988098] NET: Registered PF_INET6 protocol family=0D
[    6.994286] Segment Routing with IPv6=0D
[    6.994792] In-situ OAM (IOAM) with IPv6=0D
[    6.995293] NET: Registered PF_PACKET protocol family=0D
[    6.996176] 9pnet: Installing 9P2000 support=0D
[    6.996747] Key type dns_resolver registered=0D
[    6.999360] IPI shorthand broadcast: enabled=0D
[    7.042778] sched_clock: Marking stable (7028063022, 14605865)->(7118898=
175, -76229288)=0D
[    7.045560] registered taskstats version 1=0D
[    7.046538] Loading compiled-in X.509 certificates=0D
[    7.047705] zswap: loaded using pool lzo/zbud=0D
[    7.102407] Key type .fscrypt registered=0D
[    7.103337] Key type fscrypt-provisioning registered=0D
[    7.107338] Key type encrypted registered=0D
[    7.107945] ima: No TPM chip found, activating TPM-bypass!=0D
[    7.108569] ima: Allocated hash algorithm: sha1=0D
[    7.109169] ima: No architecture policies found=0D
[    7.109791] evm: Initialising EVM extended attributes:=0D
[    7.110331] evm: security.selinux=0D
[    7.110723] evm: security.SMACK64=0D
[    7.111080] evm: security.SMACK64EXEC=0D
[    7.111471] evm: security.SMACK64TRANSMUTE=0D
[    7.111904] evm: security.SMACK64MMAP=0D
[    7.112328] evm: security.apparmor=0D
[    7.112691] evm: security.ima=0D
[    7.113011] evm: security.capability=0D
[    7.113393] evm: HMAC attrs: 0x1=0D
[    7.117077] PM:   Magic number: 11:703:282=0D
[    7.117649] tty tty19: hash matches=0D
[    7.119152] RAS: Correctable Errors collector initialized.=0D
[    7.121611] md: Waiting for all devices to be available before autodetec=
t=0D
[    7.122126] md: If you don't use raid, use raid=3Dnoautodetect=0D
[    7.122558] md: Autodetecting RAID arrays.=0D
[    7.122946] md: autorun ...=0D
[    7.123165] md: ... autorun DONE.=0D
[    7.134376] EXT4-fs (sda): mounted filesystem 23a53bb9-f815-47a5-b74c-5e=
08f7731193 with ordered data mode. Quota mode: none.=0D
[    7.135560] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.=
=0D
[    7.139091] devtmpfs: mounted=0D
[    7.160501] Freeing unused decrypted memory: 2036K=0D
[    7.169261] Freeing unused kernel image (initmem) memory: 14104K=0D
[    7.169859] Write protecting the kernel read-only data: 90112k=0D
[    7.174062] Freeing unused kernel image (rodata/data gap) memory: 1956K=
=0D
[    7.296978] x86/mm: Checked W+X mappings: passed, no W+X pages found.=0D
[    7.297629] Run /sbin/init as init process=0D
[    7.670880] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.=0D
[    7.748299] systemd[1]: systemd 239 (239-49.el8) running in system mode.=
 (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP=
 +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +=
PCRE2 default-hierarchy=3Dlegacy)=0D
[    7.751244] systemd[1]: Detected virtualization kvm.=0D
[    7.751734] systemd[1]: Detected architecture x86-64.=0D
=0D
Welcome to =1B[0;31mCentOS Stream 8=1B[0m!=0D
=0D
[    7.822338] systemd[1]: Set hostname to <test>.=0D
[    8.413627] systemd[1]: Created slice system-serial\x2dgetty.slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-serial\x2dgetty.slice.=0D
[    8.416971] systemd[1]: Created slice system-sshd\x2dkeygen.slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-sshd\x2dkeygen.slice.=0D
[    8.419907] systemd[1]: Created slice User and Session Slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice User and Session Slice.=0D
[    8.421993] systemd[1]: Listening on Journal Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket.=0D
[    8.447468] systemd[1]: Mounting Kernel Debug File System...=0D
         Mounting Kernel Debug File System...=0D
[    8.459841] systemd[1]: Starting Remount Root and Kernel File Systems...=
=0D
         Starting Remount Root and Kernel File Systems...=0D
         Starting Load Kernel Modules...=0D
[=1B[0;32m  OK  =1B[0m] Listening on RPCbind Server Activation Socket.=0D
         Starting Setup Virtual Console...=0D
         Mounting POSIX Message Queue File System...=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-getty.slice.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Process Core Dump Socket.=0D
[=1B[0;32m  OK  =1B[0m] Reached target RPC Port Mapper.=0D
[=1B[0;32m  OK  =1B[0m] Listening on initctl Compatibility Named Pipe.=0D
[=1B[0;32m  OK  =1B[0m] Reached target Swap.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket (/dev/log).=0D
         Starting Journal Service...=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Control Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Socket.=0D
[=1B[0;32m  OK  =1B[0m] Set up automount Arbitrary Executab=E2=80=A6rmats F=
ile System Automount Point.=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Wall Directory=
 Watch.=0D
[=1B[0;32m  OK  =1B[0m] Listening on LVM2 poll daemon socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on multipathd control socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Device-mapper event daemon FIFOs.=0D
[    8.843080] EXT4-fs (sda): re-mounted 23a53bb9-f815-47a5-b74c-5e08f77311=
93. Quota mode: none.=0D
         Starting Monitoring of LVM2 mirrors=E2=80=A6ng dmeventd or progres=
s polling...=0D
         Starting udev Coldplug all Devices...=0D
         Mounting Huge Pages File System...=0D
[=1B[0;32m  OK  =1B[0m] Reached target Slices.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Debug File System.=0D
[=1B[0;32m  OK  =1B[0m] Started Remount Root and Kernel File Systems.=0D
[=1B[0;1;31mFAILED=1B[0m] Failed to start Load Kernel Modules.=0D
See 'systemctl status systemd-modules-load.service' for details.=0D
[=1B[0;32m  OK  =1B[0m] Started Journal Service.=0D
[=1B[0;32m  OK  =1B[0m] Started Setup Virtual Console.=0D
[=1B[0;32m  OK  =1B[0m] Mounted POSIX Message Queue File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Huge Pages File System.=0D
         Starting Apply Kernel Variables...=0D
         Mounting Kernel Configuration File System...=0D
         Mounting FUSE Control File System...=0D
         Starting Flush Journal to Persistent Storage...=0D
         Starting Create Static Device Nodes in /dev...=0D
         Starting Load/Save Random Seed...=0D
[=1B[0;32m  OK  =1B[0m] Started Apply Kernel Variables.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Configuration File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted FUSE Control File System.=0D
[=1B[0;32m  OK  =1B[0m] Started Flush Journal to Persistent Storage.=0D
[=1B[0;32m  OK  =1B[0m] Started Load/Save Random Seed.=0D
[=1B[0;32m  OK  =1B[0m] Started Create Static Device Nodes in /dev.=0D
         Starting udev Kernel Device Manager...=0D
[=1B[0;32m  OK  =1B[0m] Started udev Kernel Device Manager.=0D
[=1B[0;32m  OK  =1B[0m] Started udev Coldplug all Devices.=0D
         Starting Show Plymouth Boot Screen...=0D
         Starting udev Wait for Complete Device Initialization...=0D
[=1B[0;32m  OK  =1B[0m] Started Show Plymouth Boot Screen.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Plymouth Direc=
tory Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local Encrypted Volumes.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Paths.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Monitoring of LVM2 mirrors,=E2=80=A6sing dm=
eventd or progress polling.=0D=0D
[=1B[0;32m  OK  =1B[0m] Found device /dev/ttyS0.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started udev Wait for Complete Device Initializatio=
n.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on Load/Save RF Kill Switch Status /dev/r=
fkill Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems.=0D=0D
         Starting Tell Plymouth To Write Out Runtime Data...=0D=0D
         Starting Restore /run/initramfs on shutdown...=0D=0D
         Starting Create Volatile Files and Directories...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Tell Plymouth To Write Out Runtime Data.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started Restore /run/initramfs on shutdown.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Create Volatile Files and Directories.=0D=
=0D
         Starting Security Auditing Service...=0D=0D
         Starting RPC Bind...=0D=0D
         Mounting RPC Pipe File System...=0D=0D
[=1B[0;32m  OK  =1B[0m] Mounted RPC Pipe File System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target rpc_pipefs.target.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started RPC Bind.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Security Auditing Service.=0D=0D
         Starting Update UTMP about System Boot/Shutdown...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Update UTMP about System Boot/Shutdown.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Reached target System Initialization.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started dnf makecache --timer.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on SSSD Kerberos Cache Manager responder =
socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Daily Cleanup of Temporary Directories.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Listening on D-Bus System Message Bus Socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Sockets.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started daily update of the root trust anchor for D=
NSSEC.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Timers.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Basic System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Machine Check Exception Logging Daemon.=0D=
=0D
         Starting Authorization Manager...=0D=0D
         Starting Auto-connect to subsystems=E2=80=A6-NVME devices found du=
ring boot...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started D-Bus System Message Bus.=0D=0D
         Starting Network Manager...=0D=0D
         Starting NTP client/server...=0D=0D
         Starting Login Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target sshd-keygen.target.=0D=0D
         Starting Self Monitoring and Reporting Technology (SMART) Daemon..=
.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started irqbalance daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Auto-connect to subsystems =E2=80=A6FC-NVME=
 devices found during boot.=0D=0D
         Starting update of the root trust a=E2=80=A6or DNSSEC validation i=
n unbound...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Self Monitoring and Reporting Technology (S=
MART) Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Login Service.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Network Manager.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Network.=0D=0D
         Starting GSSAPI Proxy Daemon...=0D=0D
         Starting OpenSSH server daemon...=0D=0D
         Starting Dynamic System Tuning Daemon...=0D=0D
         Starting Network Manager Wait Online...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started update of the root trust an=E2=80=A6 for DN=
SSEC validation in unbound.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started NTP client/server.=0D=0D
         Starting Hostname Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started OpenSSH server daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Authorization Manager.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started GSSAPI Proxy Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target NFS client services.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems.=0D=0D
         Starting Permit User Sessions...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Permit User Sessions.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Command Scheduler.=0D=0D
         Starting Hold until boot process finishes up...=0D=0D
         Starting Terminate Plymouth Boot Screen...=0D=0D
[   16.647288] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX=0D
[   16.650373] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=0D
[   17.218584] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[   17.219794] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
=0D=0D
CentOS Stream 8=0D
Kernel 6.2.0-rc7-4ec5183ec486 on an x86_64=0D
=0D
test login: [   30.404796] FAULT_INJECTION: forcing a failure.=0D
[   30.404796] name failslab, interval 1, probability 0, space 0, times 1=
=0D
[   30.405595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec4=
86 #1=0D
[   30.406044] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.406724] Call Trace:=0D
[   30.406890]  <TASK>=0D
[   30.407032]  dump_stack_lvl+0xa7/0xdb=0D
[   30.407310]  dump_stack+0x19/0x1f=0D
[   30.407532]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.407820]  __should_failslab+0xca/0x120=0D
[   30.408091]  should_failslab+0x12/0x30=0D
[   30.408341]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.408636]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.408916]  kmalloc_trace+0x2e/0x120=0D
[   30.409161]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.409426]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.409804]  ? write_comp_data+0x2f/0x90=0D
[   30.410078]  ftrace_set_hash+0x445/0x590=0D
[   30.410350]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.410671]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.410967]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.411295]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.411574]  ? unregister_ftrace_function+0x83/0x3c0=0D
[   30.411906]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.412228]  ? write_comp_data+0x2f/0x90=0D
[   30.412507]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.412851]  disarm_kprobe+0x24a/0x2d0=0D
[   30.413112]  __disable_kprobe+0x2de/0x4b0=0D
[   30.413390]  disable_kprobe+0x31/0x80=0D
[   30.413643]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.413965]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.414266]  kprobe_register+0x4e/0xf0=0D
[   30.414528]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.414870]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.415156]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.415482]  _free_event+0x220/0x11c0=0D
[   30.415754]  put_event+0x4d/0x60=0D
[   30.415993]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.416330]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.416680]  ? write_comp_data+0x2f/0x90=0D
[   30.416950]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.417292]  ? __pfx_perf_release+0x10/0x10=0D
[   30.417579]  perf_release+0x40/0x50=0D
[   30.417830]  __fput+0x26d/0xa40=0D
[   30.418080]  ____fput+0x1e/0x30=0D
[   30.418303]  task_work_run+0x1a4/0x2d0=0D
[   30.418565]  ? write_comp_data+0x2f/0x90=0D
[   30.418836]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.419138]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.419463]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.419751]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.420080]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.420392]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.420698]  do_syscall_64+0x4a/0x90=0D
[   30.420944]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.421282] RIP: 0033:0x7f3840f1059d=0D
[   30.421537] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.422690] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.423179] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.423630] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.424081] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.424531] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.424984] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.425459]  </TASK>=0D
[   30.425891] ------------[ cut here ]------------=0D
[   30.426223] Failed to disarm kprobe-ftrace at match_dev_by_uuid+0x4/0x10=
0 (error -12)=0D
[   30.426785] WARNING: CPU: 1 PID: 510 at kernel/kprobes.c:1130 __disarm_k=
probe_ftrace.isra.24+0x1ed/0x250=0D
[   30.427381] Modules linked in:=0D
[   30.427595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec4=
86 #1=0D
[   30.428052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.428759] RIP: 0010:__disarm_kprobe_ftrace.isra.24+0x1ed/0x250=0D
[   30.429156] Code: 37 f5 05 01 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 =
80 3c 02 00 75 64 49 8b 75 00 89 da 48 c7 c7 80 67 6f 85 e8 12 72 bf 03 <0f=
> 0b e9 03 ff ff ff e8 a7 de 59 00 e9 51 fe ff ff 4c 89 e7 e8 9a=0D
[   30.430300] RSP: 0018:ffff88800c387a90 EFLAGS: 00010282=0D
[   30.430642] RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff813=
dde2e=0D
[   30.431124] RDX: 0000000000000000 RSI: ffff8880125e0000 RDI: 00000000000=
00002=0D
[   30.431575] RBP: ffff88800c387ab0 R08: ffffed1001870f0b R09: ffffed10018=
70f0b=0D
[   30.432028] R10: ffff88800c387857 R11: ffffed1001870f0a R12: 00000000000=
00000=0D
[   30.432483] R13: ffff88800a4a9040 R14: ffffffff875a0ea0 R15: ffff88800a4=
a9090=0D
[   30.432940] FS:  00007f3840deb740(0000) GS:ffff88806cd00000(0000) knlGS:=
0000000000000000=0D
[   30.433467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   30.433847] CR2: 00007f3840e4d700 CR3: 0000000011a84001 CR4: 00000000007=
70ee0=0D
[   30.434301] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=0D
[   30.434782] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00000000000=
00400=0D
[   30.435234] PKRU: 55555554=0D
[   30.435418] Call Trace:=0D
[   30.435588]  <TASK>=0D
[   30.435743]  disarm_kprobe+0x24a/0x2d0=0D
[   30.436011]  __disable_kprobe+0x2de/0x4b0=0D
[   30.436295]  disable_kprobe+0x31/0x80=0D
[   30.436552]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.436862]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.437165]  kprobe_register+0x4e/0xf0=0D
[   30.437429]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.437778]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.438077]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.438407]  _free_event+0x220/0x11c0=0D
[   30.438707]  put_event+0x4d/0x60=0D
[   30.438938]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.439275]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.439633]  ? write_comp_data+0x2f/0x90=0D
[   30.439913]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.440245]  ? __pfx_perf_release+0x10/0x10=0D
[   30.440533]  perf_release+0x40/0x50=0D
[   30.440780]  __fput+0x26d/0xa40=0D
[   30.441020]  ____fput+0x1e/0x30=0D
[   30.441246]  task_work_run+0x1a4/0x2d0=0D
[   30.441509]  ? write_comp_data+0x2f/0x90=0D
[   30.441794]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.442090]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.442389]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.442705]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.443042]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.443366]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.443683]  do_syscall_64+0x4a/0x90=0D
[   30.443937]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.444281] RIP: 0033:0x7f3840f1059d=0D
[   30.444530] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.445701] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.446211] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.446716] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.447193] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.447661] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.448128] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.448618]  </TASK>=0D
[   30.448787] irq event stamp: 2017=0D
[   30.449020] hardirqs last  enabled at (2025): [<ffffffff813dd0a1>] __up_=
console_sem+0x91/0xb0=0D
[   30.449594] hardirqs last disabled at (2032): [<ffffffff813dd086>] __up_=
console_sem+0x76/0xb0=0D
[   30.450803] softirqs last  enabled at (1974): [<ffffffff8536af3f>] __do_=
softirq+0x53f/0x836=0D
[   30.452095] softirqs last disabled at (1965): [<ffffffff812498b0>] irq_e=
xit_rcu+0x100/0x140=0D
[   30.453375] ---[ end trace 0000000000000000 ]---=0D
[   30.509711] FAULT_INJECTION: forcing a failure.=0D
[   30.509711] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.511375] CPU: 1 PID: 511 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.512607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.514222] Call Trace:=0D
[   30.514602]  <TASK>=0D
[   30.514937]  dump_stack_lvl+0xa7/0xdb=0D
[   30.515506]  dump_stack+0x19/0x1f=0D
[   30.516029]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.516678]  __should_failslab+0xca/0x120=0D
[   30.517304]  should_failslab+0x12/0x30=0D
[   30.517909]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.518587]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.519211]  kmalloc_trace+0x2e/0x120=0D
[   30.519757]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.520350]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.521188]  ? write_comp_data+0x2f/0x90=0D
[   30.521789]  ftrace_set_hash+0x445/0x590=0D
[   30.522390]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.523022]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.523728]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.524334]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.525022]  ? write_comp_data+0x2f/0x90=0D
[   30.525611]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.526363]  disarm_kprobe+0x24a/0x2d0=0D
[   30.526919]  __disable_kprobe+0x2de/0x4b0=0D
[   30.527508]  disable_kprobe+0x31/0x80=0D
[   30.528051]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.528708]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.529347]  kprobe_register+0x4e/0xf0=0D
[   30.529913]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.530648]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.531259]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.531956]  _free_event+0x220/0x11c0=0D
[   30.532520]  put_event+0x4d/0x60=0D
[   30.533021]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.533746]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.534539]  ? write_comp_data+0x2f/0x90=0D
[   30.535143]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.535860]  ? __pfx_perf_release+0x10/0x10=0D
[   30.536488]  perf_release+0x40/0x50=0D
[   30.537024]  __fput+0x26d/0xa40=0D
[   30.537540]  ____fput+0x1e/0x30=0D
[   30.538048]  task_work_run+0x1a4/0x2d0=0D
[   30.538622]  ? write_comp_data+0x2f/0x90=0D
[   30.539228]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.539913]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.540627]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.541284]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.541965]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.542296]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.542613]  do_syscall_64+0x4a/0x90=0D
[   30.542866]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.543201] RIP: 0033:0x7f3840f1059d=0D
[   30.543447] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.544585] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.545067] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.545515] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.545968] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.546416] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.546868] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.547341]  </TASK>=0D
[   30.601918] FAULT_INJECTION: forcing a failure.=0D
[   30.601918] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.602691] CPU: 1 PID: 512 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.603223] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.603905] Call Trace:=0D
[   30.604065]  <TASK>=0D
[   30.604211]  dump_stack_lvl+0xa7/0xdb=0D
[   30.604464]  dump_stack+0x19/0x1f=0D
[   30.604688]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.604969]  __should_failslab+0xca/0x120=0D
[   30.605238]  should_failslab+0x12/0x30=0D
[   30.605486]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.605789]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.606073]  kmalloc_trace+0x2e/0x120=0D
[   30.606319]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.606589]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.606971]  ? write_comp_data+0x2f/0x90=0D
[   30.607245]  ftrace_set_hash+0x445/0x590=0D
[   30.607527]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.607818]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.608141]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.608415]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.608725]  ? write_comp_data+0x2f/0x90=0D
[   30.608998]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.609332]  disarm_kprobe+0x24a/0x2d0=0D
[   30.609587]  __disable_kprobe+0x2de/0x4b0=0D
[   30.609860]  disable_kprobe+0x31/0x80=0D
[   30.610110]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.610410]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.610703]  kprobe_register+0x4e/0xf0=0D
[   30.610960]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.611295]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.611575]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.611895]  _free_event+0x220/0x11c0=0D
[   30.612155]  put_event+0x4d/0x60=0D
[   30.612380]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.612706]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.613106]  ? write_comp_data+0x2f/0x90=0D
[   30.613377]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.613707]  ? __pfx_perf_release+0x10/0x10=0D
[   30.613986]  perf_release+0x40/0x50=0D
[   30.614221]  __fput+0x26d/0xa40=0D
[   30.614450]  ____fput+0x1e/0x30=0D
[   30.614661]  task_work_run+0x1a4/0x2d0=0D
[   30.614916]  ? write_comp_data+0x2f/0x90=0D
[   30.615190]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.615478]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.615784]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.616068]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.616391]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.616694]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.616992]  do_syscall_64+0x4a/0x90=0D
[   30.617240]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.617560] RIP: 0033:0x7f3840f1059d=0D
[   30.617798] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.618919] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.619379] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.619813] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.620250] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.620696] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.621126] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.621627]  </TASK>=0D
[   30.663328] FAULT_INJECTION: forcing a failure.=0D
[   30.663328] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.664958] CPU: 0 PID: 513 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.666220] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.667849] Call Trace:=0D
[   30.668242]  <TASK>=0D
[   30.668585]  dump_stack_lvl+0xa7/0xdb=0D
[   30.669173]  dump_stack+0x19/0x1f=0D
[   30.669708]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.670180]  __should_failslab+0xca/0x120=0D
[   30.670544]  should_failslab+0x12/0x30=0D
[   30.670872]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.671263]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.671632]  kmalloc_trace+0x2e/0x120=0D
[   30.671956]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.672310]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.672809]  ? write_comp_data+0x2f/0x90=0D
[   30.673153]  ftrace_set_hash+0x445/0x590=0D
[   30.673504]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.673821]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.674163]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.674457]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.674791]  ? write_comp_data+0x2f/0x90=0D
[   30.675083]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.675437]  disarm_kprobe+0x24a/0x2d0=0D
[   30.675698]  __disable_kprobe+0x2de/0x4b0=0D
[   30.675987]  disable_kprobe+0x31/0x80=0D
[   30.676251]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.676574]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.676896]  kprobe_register+0x4e/0xf0=0D
[   30.677174]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.677532]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.677844]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.678191]  _free_event+0x220/0x11c0=0D
[   30.678465]  put_event+0x4d/0x60=0D
[   30.678701]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.679090]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.679556]  ? write_comp_data+0x2f/0x90=0D
[   30.679934]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.680300]  ? __pfx_perf_release+0x10/0x10=0D
[   30.680593]  perf_release+0x40/0x50=0D
[   30.680845]  __fput+0x26d/0xa40=0D
[   30.681092]  ____fput+0x1e/0x30=0D
[   30.681323]  task_work_run+0x1a4/0x2d0=0D
[   30.681592]  ? write_comp_data+0x2f/0x90=0D
[   30.681885]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.682186]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.682513]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.682815]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.683154]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.683480]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.683803]  do_syscall_64+0x4a/0x90=0D
[   30.684061]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.684403] RIP: 0033:0x7f3840f1059d=0D
[   30.684655] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.685816] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.686308] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.686769] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.687227] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.687685] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.688131] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.688606]  </TASK>=0D
[   30.736187] FAULT_INJECTION: forcing a failure.=0D
[   30.736187] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.736948] CPU: 0 PID: 514 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.737485] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.738193] Call Trace:=0D
[   30.738358]  <TASK>=0D
[   30.738508]  dump_stack_lvl+0xa7/0xdb=0D
[   30.738768]  dump_stack+0x19/0x1f=0D
[   30.738997]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.739287]  __should_failslab+0xca/0x120=0D
[   30.739561]  should_failslab+0x12/0x30=0D
[   30.739815]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.740121]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.740426]  kmalloc_trace+0x2e/0x120=0D
[   30.740679]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.740962]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.741350]  ? write_comp_data+0x2f/0x90=0D
[   30.741630]  ftrace_set_hash+0x445/0x590=0D
[   30.741921]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.742215]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.742544]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.742901]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.743309]  ? write_comp_data+0x2f/0x90=0D
[   30.743668]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.744009]  disarm_kprobe+0x24a/0x2d0=0D
[   30.744265]  __disable_kprobe+0x2de/0x4b0=0D
[   30.744539]  disable_kprobe+0x31/0x80=0D
[   30.744867]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.745254]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.745550]  kprobe_register+0x4e/0xf0=0D
[   30.745816]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.746166]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.746454]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.746777]  _free_event+0x220/0x11c0=0D
[   30.747057]  put_event+0x4d/0x60=0D
[   30.747283]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.747608]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.747953]  ? write_comp_data+0x2f/0x90=0D
[   30.748228]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.748560]  ? __pfx_perf_release+0x10/0x10=0D
[   30.748848]  perf_release+0x40/0x50=0D
[   30.749095]  __fput+0x26d/0xa40=0D
[   30.749337]  ____fput+0x1e/0x30=0D
[   30.749565]  task_work_run+0x1a4/0x2d0=0D
[   30.749838]  ? write_comp_data+0x2f/0x90=0D
[   30.750120]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.750417]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.750744]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.751045]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.751383]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.751705]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.752025]  do_syscall_64+0x4a/0x90=0D
[   30.752282]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.752620] RIP: 0033:0x7f3840f1059d=0D
[   30.752870] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.754021] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.754510] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.754968] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.755427] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.755882] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.756338] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.756817]  </TASK>=0D
[   30.796293] FAULT_INJECTION: forcing a failure.=0D
[   30.796293] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.797016] CPU: 0 PID: 515 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.797528] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.798194] Call Trace:=0D
[   30.798352]  <TASK>=0D
[   30.798492]  dump_stack_lvl+0xa7/0xdb=0D
[   30.798738]  dump_stack+0x19/0x1f=0D
[   30.798953]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.799224]  __should_failslab+0xca/0x120=0D
[   30.799484]  should_failslab+0x12/0x30=0D
[   30.799722]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.800003]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.800280]  kmalloc_trace+0x2e/0x120=0D
[   30.800515]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.800784]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.801165]  ? write_comp_data+0x2f/0x90=0D
[   30.801443]  ftrace_set_hash+0x445/0x590=0D
[   30.801725]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.802028]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.802349]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.802622]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.802936]  ? write_comp_data+0x2f/0x90=0D
[   30.803210]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.803544]  disarm_kprobe+0x24a/0x2d0=0D
[   30.803798]  __disable_kprobe+0x2de/0x4b0=0D
[   30.804070]  disable_kprobe+0x31/0x80=0D
[   30.804319]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.804620]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.804914]  kprobe_register+0x4e/0xf0=0D
[   30.805170]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.805512]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.805798]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.806119]  _free_event+0x220/0x11c0=0D
[   30.806381]  put_event+0x4d/0x60=0D
[   30.806606]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.806945]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.807295]  ? write_comp_data+0x2f/0x90=0D
[   30.807567]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.807893]  ? __pfx_perf_release+0x10/0x10=0D
[   30.808171]  perf_release+0x40/0x50=0D
[   30.808413]  __fput+0x26d/0xa40=0D
[   30.808648]  ____fput+0x1e/0x30=0D
[   30.808865]  task_work_run+0x1a4/0x2d0=0D
[   30.809124]  ? write_comp_data+0x2f/0x90=0D
[   30.809396]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.809680]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.809999]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.810290]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.810619]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.810939]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.811256]  do_syscall_64+0x4a/0x90=0D
[   30.811511]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.811855] RIP: 0033:0x7f3840f1059d=0D
[   30.812120] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.813256] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.813734] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.814187] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.814633] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.815082] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.815529] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.816004]  </TASK>=0D
[   30.853103] FAULT_INJECTION: forcing a failure.=0D
[   30.853103] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.853977] CPU: 1 PID: 516 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.854496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.855172] Call Trace:=0D
[   30.855338]  <TASK>=0D
[   30.855482]  dump_stack_lvl+0xa7/0xdb=0D
[   30.855731]  dump_stack+0x19/0x1f=0D
[   30.855946]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.856217]  __should_failslab+0xca/0x120=0D
[   30.856475]  should_failslab+0x12/0x30=0D
[   30.856712]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.856996]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.857268]  kmalloc_trace+0x2e/0x120=0D
[   30.857503]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.857762]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.858133]  ? write_comp_data+0x2f/0x90=0D
[   30.858397]  ftrace_set_hash+0x445/0x590=0D
[   30.858666]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.858948]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.859257]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.859523]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.859821]  ? write_comp_data+0x2f/0x90=0D
[   30.860084]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.860408]  disarm_kprobe+0x24a/0x2d0=0D
[   30.860653]  __disable_kprobe+0x2de/0x4b0=0D
[   30.860914]  disable_kprobe+0x31/0x80=0D
[   30.861154]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.861696]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.862079]  kprobe_register+0x4e/0xf0=0D
[   30.862392]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.862788]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.863130]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.863474]  _free_event+0x220/0x11c0=0D
[   30.863739]  put_event+0x4d/0x60=0D
[   30.863968]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.864295]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.864645]  ? write_comp_data+0x2f/0x90=0D
[   30.864921]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.865247]  ? __pfx_perf_release+0x10/0x10=0D
[   30.865532]  perf_release+0x40/0x50=0D
[   30.865791]  __fput+0x26d/0xa40=0D
[   30.866057]  ____fput+0x1e/0x30=0D
[   30.866270]  task_work_run+0x1a4/0x2d0=0D
[   30.866522]  ? write_comp_data+0x2f/0x90=0D
[   30.866796]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.867084]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.867405]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.867694]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.868029]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.868342]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.868652]  do_syscall_64+0x4a/0x90=0D
[   30.868902]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.869243] RIP: 0033:0x7f3840f1059d=0D
[   30.869491] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.870729] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.871220] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.871675] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.872132] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.872592] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.873050] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.873527]  </TASK>=0D
[   30.927984] FAULT_INJECTION: forcing a failure.=0D
[   30.927984] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   30.928908] CPU: 0 PID: 517 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   30.929599] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.930485] Call Trace:=0D
[   30.930706]  <TASK>=0D
[   30.930901]  dump_stack_lvl+0xa7/0xdb=0D
[   30.931240]  dump_stack+0x19/0x1f=0D
[   30.931542]  should_fail_ex.cold.5+0x5/0xa=0D
[   30.931926]  __should_failslab+0xca/0x120=0D
[   30.932283]  should_failslab+0x12/0x30=0D
[   30.932604]  __kmem_cache_alloc_node+0x62/0x280=0D
[   30.932994]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   30.933378]  kmalloc_trace+0x2e/0x120=0D
[   30.933724]  alloc_ftrace_hash+0x4f/0x170=0D
[   30.934114]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   30.934641]  ? write_comp_data+0x2f/0x90=0D
[   30.935031]  ftrace_set_hash+0x445/0x590=0D
[   30.935435]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   30.935849]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   30.936296]  ? match_dev_by_uuid+0x4/0x100=0D
[   30.936684]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.937135]  ? write_comp_data+0x2f/0x90=0D
[   30.937523]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   30.938000]  disarm_kprobe+0x24a/0x2d0=0D
[   30.938359]  __disable_kprobe+0x2de/0x4b0=0D
[   30.938743]  disable_kprobe+0x31/0x80=0D
[   30.939094]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   30.939519]  disable_trace_kprobe+0x1f0/0x300=0D
[   30.939934]  kprobe_register+0x4e/0xf0=0D
[   30.940295]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   30.940769]  perf_kprobe_destroy+0xcb/0x200=0D
[   30.941164]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   30.941608]  _free_event+0x220/0x11c0=0D
[   30.941971]  put_event+0x4d/0x60=0D
[   30.942279]  perf_event_release_kernel+0x5d9/0x860=0D
[   30.942721]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   30.943184]  ? write_comp_data+0x2f/0x90=0D
[   30.943554]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.943994]  ? __pfx_perf_release+0x10/0x10=0D
[   30.944370]  perf_release+0x40/0x50=0D
[   30.944684]  __fput+0x26d/0xa40=0D
[   30.944986]  ____fput+0x1e/0x30=0D
[   30.945280]  task_work_run+0x1a4/0x2d0=0D
[   30.945627]  ? write_comp_data+0x2f/0x90=0D
[   30.945998]  ? __pfx_task_work_run+0x10/0x10=0D
[   30.946390]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.946819]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.947212]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   30.947656]  exit_to_user_mode_prepare+0x200/0x210=0D
[   30.948081]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   30.948493]  do_syscall_64+0x4a/0x90=0D
[   30.948828]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.949269] RIP: 0033:0x7f3840f1059d=0D
[   30.949588] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.951030] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   30.951640] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   30.952204] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   30.952773] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   30.953347] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   30.953921] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.954374]  </TASK>=0D
[   30.999500] FAULT_INJECTION: forcing a failure.=0D
[   30.999500] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.000216] CPU: 0 PID: 518 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.000737] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.001395] Call Trace:=0D
[   31.001551]  <TASK>=0D
[   31.001689]  dump_stack_lvl+0xa7/0xdb=0D
[   31.001940]  dump_stack+0x19/0x1f=0D
[   31.002155]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.002424]  __should_failslab+0xca/0x120=0D
[   31.002682]  should_failslab+0x12/0x30=0D
[   31.002922]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.003205]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.003475]  kmalloc_trace+0x2e/0x120=0D
[   31.003711]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.003969]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.004332]  ? write_comp_data+0x2f/0x90=0D
[   31.004594]  ftrace_set_hash+0x445/0x590=0D
[   31.004863]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.005144]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.005459]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.005731]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.006033]  ? write_comp_data+0x2f/0x90=0D
[   31.006294]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.006616]  disarm_kprobe+0x24a/0x2d0=0D
[   31.006861]  __disable_kprobe+0x2de/0x4b0=0D
[   31.007122]  disable_kprobe+0x31/0x80=0D
[   31.007360]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.007650]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.007931]  kprobe_register+0x4e/0xf0=0D
[   31.008177]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.008499]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.008768]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.009073]  _free_event+0x220/0x11c0=0D
[   31.009320]  put_event+0x4d/0x60=0D
[   31.009537]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.009851]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.010179]  ? write_comp_data+0x2f/0x90=0D
[   31.010435]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.010741]  ? __pfx_perf_release+0x10/0x10=0D
[   31.011005]  perf_release+0x40/0x50=0D
[   31.011233]  __fput+0x26d/0xa40=0D
[   31.011456]  ____fput+0x1e/0x30=0D
[   31.011665]  task_work_run+0x1a4/0x2d0=0D
[   31.011910]  ? write_comp_data+0x2f/0x90=0D
[   31.012169]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.012443]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.012741]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.013016]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.013329]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.013625]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.013920]  do_syscall_64+0x4a/0x90=0D
[   31.014154]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.014467] RIP: 0033:0x7f3840f1059d=0D
[   31.014695] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.015752] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.016200] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.016624] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.017054] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.017483] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.017920] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.018375]  </TASK>=0D
[   31.071104] FAULT_INJECTION: forcing a failure.=0D
[   31.071104] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.071883] CPU: 0 PID: 519 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.072461] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.073185] Call Trace:=0D
[   31.073369]  <TASK>=0D
[   31.073521]  dump_stack_lvl+0xa7/0xdb=0D
[   31.073794]  dump_stack+0x19/0x1f=0D
[   31.074030]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.074323]  __should_failslab+0xca/0x120=0D
[   31.074613]  should_failslab+0x12/0x30=0D
[   31.074884]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.075194]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.075503]  kmalloc_trace+0x2e/0x120=0D
[   31.075759]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.076040]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.076438]  ? write_comp_data+0x2f/0x90=0D
[   31.076740]  ftrace_set_hash+0x445/0x590=0D
[   31.077034]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.077338]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.077688]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.077988]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.078315]  ? write_comp_data+0x2f/0x90=0D
[   31.078600]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.078975]  disarm_kprobe+0x24a/0x2d0=0D
[   31.079242]  __disable_kprobe+0x2de/0x4b0=0D
[   31.079526]  disable_kprobe+0x31/0x80=0D
[   31.079779]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.080107]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.080405]  kprobe_register+0x4e/0xf0=0D
[   31.080663]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.081015]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.081296]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.081620]  _free_event+0x220/0x11c0=0D
[   31.081890]  put_event+0x4d/0x60=0D
[   31.082127]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.082455]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.082813]  ? write_comp_data+0x2f/0x90=0D
[   31.083098]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.083422]  ? __pfx_perf_release+0x10/0x10=0D
[   31.083718]  perf_release+0x40/0x50=0D
[   31.083962]  __fput+0x26d/0xa40=0D
[   31.084211]  ____fput+0x1e/0x30=0D
[   31.084432]  task_work_run+0x1a4/0x2d0=0D
[   31.084687]  ? write_comp_data+0x2f/0x90=0D
[   31.084959]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.085257]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.085575]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.085877]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.086208]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.086532]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.086853]  do_syscall_64+0x4a/0x90=0D
[   31.087098]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.087443] RIP: 0033:0x7f3840f1059d=0D
[   31.087682] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.088817] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.089322] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.089786] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.090253] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.090720] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.091167] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.091636]  </TASK>=0D
[   31.138850] FAULT_INJECTION: forcing a failure.=0D
[   31.138850] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.139549] CPU: 1 PID: 520 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.140058] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.140704] Call Trace:=0D
[   31.140876]  <TASK>=0D
[   31.141039]  dump_stack_lvl+0xa7/0xdb=0D
[   31.141643]  dump_stack+0x19/0x1f=0D
[   31.142138]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.142752]  __should_failslab+0xca/0x120=0D
[   31.143319]  should_failslab+0x12/0x30=0D
[   31.143846]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.144475]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.145065]  kmalloc_trace+0x2e/0x120=0D
[   31.145587]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.146058]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.146505]  ? write_comp_data+0x2f/0x90=0D
[   31.146866]  ftrace_set_hash+0x445/0x590=0D
[   31.147145]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.147500]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.147870]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.148218]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.148578]  ? write_comp_data+0x2f/0x90=0D
[   31.148923]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.149328]  disarm_kprobe+0x24a/0x2d0=0D
[   31.149638]  __disable_kprobe+0x2de/0x4b0=0D
[   31.149912]  disable_kprobe+0x31/0x80=0D
[   31.150209]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.150571]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.150970]  kprobe_register+0x4e/0xf0=0D
[   31.151280]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.151719]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.152034]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.152421]  _free_event+0x220/0x11c0=0D
[   31.152739]  put_event+0x4d/0x60=0D
[   31.153012]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.153433]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.153831]  ? write_comp_data+0x2f/0x90=0D
[   31.154178]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.154587]  ? __pfx_perf_release+0x10/0x10=0D
[   31.154930]  perf_release+0x40/0x50=0D
[   31.155236]  __fput+0x26d/0xa40=0D
[   31.155527]  ____fput+0x1e/0x30=0D
[   31.155752]  task_work_run+0x1a4/0x2d0=0D
[   31.156081]  ? write_comp_data+0x2f/0x90=0D
[   31.156422]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.156793]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.157153]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.157491]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.157980]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.158383]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.158774]  do_syscall_64+0x4a/0x90=0D
[   31.159108]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.159566] RIP: 0033:0x7f3840f1059d=0D
[   31.159901] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.161346] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.161879] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.162411] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.163014] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.163612] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.164187] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.164769]  </TASK>=0D
[   31.209250] FAULT_INJECTION: forcing a failure.=0D
[   31.209250] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.210268] CPU: 1 PID: 521 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.211010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.211958] Call Trace:=0D
[   31.212181]  <TASK>=0D
[   31.212383]  dump_stack_lvl+0xa7/0xdb=0D
[   31.212735]  dump_stack+0x19/0x1f=0D
[   31.213046]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.213444]  __should_failslab+0xca/0x120=0D
[   31.213832]  should_failslab+0x12/0x30=0D
[   31.214100]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.214403]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.214688]  kmalloc_trace+0x2e/0x120=0D
[   31.214936]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.215211]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.215594]  ? write_comp_data+0x2f/0x90=0D
[   31.215870]  ftrace_set_hash+0x445/0x590=0D
[   31.216158]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.216462]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.216797]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.217083]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.217406]  ? write_comp_data+0x2f/0x90=0D
[   31.217690]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.218045]  disarm_kprobe+0x24a/0x2d0=0D
[   31.218311]  __disable_kprobe+0x2de/0x4b0=0D
[   31.218592]  disable_kprobe+0x31/0x80=0D
[   31.218852]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.219165]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.219470]  kprobe_register+0x4e/0xf0=0D
[   31.219737]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.220088]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.220379]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.220711]  _free_event+0x220/0x11c0=0D
[   31.220980]  put_event+0x4d/0x60=0D
[   31.221221]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.221559]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.221973]  ? write_comp_data+0x2f/0x90=0D
[   31.222253]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.222585]  ? __pfx_perf_release+0x10/0x10=0D
[   31.222872]  perf_release+0x40/0x50=0D
[   31.223121]  __fput+0x26d/0xa40=0D
[   31.223376]  ____fput+0x1e/0x30=0D
[   31.223604]  task_work_run+0x1a4/0x2d0=0D
[   31.223868]  ? write_comp_data+0x2f/0x90=0D
[   31.224150]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.224446]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.224771]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.225070]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.225410]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.225734]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.226060]  do_syscall_64+0x4a/0x90=0D
[   31.226311]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.226650] RIP: 0033:0x7f3840f1059d=0D
[   31.226898] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.228051] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.228543] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.228999] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.229453] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.229912] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.230366] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.230845]  </TASK>=0D
[   31.269388] FAULT_INJECTION: forcing a failure.=0D
[   31.269388] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.270222] CPU: 1 PID: 522 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.270803] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.271493] Call Trace:=0D
[   31.271654]  <TASK>=0D
[   31.271798]  dump_stack_lvl+0xa7/0xdb=0D
[   31.272056]  dump_stack+0x19/0x1f=0D
[   31.272278]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.272554]  __should_failslab+0xca/0x120=0D
[   31.272819]  should_failslab+0x12/0x30=0D
[   31.273062]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.273356]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.273633]  kmalloc_trace+0x2e/0x120=0D
[   31.273882]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.274145]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.274516]  ? write_comp_data+0x2f/0x90=0D
[   31.274785]  ftrace_set_hash+0x445/0x590=0D
[   31.275060]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.275348]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.275663]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.275933]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.276238]  ? write_comp_data+0x2f/0x90=0D
[   31.276506]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.276836]  disarm_kprobe+0x24a/0x2d0=0D
[   31.277085]  __disable_kprobe+0x2de/0x4b0=0D
[   31.277353]  disable_kprobe+0x31/0x80=0D
[   31.277597]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.277905]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.278203]  kprobe_register+0x4e/0xf0=0D
[   31.278464]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.278803]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.279086]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.279409]  _free_event+0x220/0x11c0=0D
[   31.279671]  put_event+0x4d/0x60=0D
[   31.279899]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.280226]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.280572]  ? write_comp_data+0x2f/0x90=0D
[   31.280846]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.281169]  ? __pfx_perf_release+0x10/0x10=0D
[   31.281450]  perf_release+0x40/0x50=0D
[   31.281694]  __fput+0x26d/0xa40=0D
[   31.281938]  ____fput+0x1e/0x30=0D
[   31.282159]  task_work_run+0x1a4/0x2d0=0D
[   31.282418]  ? write_comp_data+0x2f/0x90=0D
[   31.282693]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.282982]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.283299]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.283592]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.283924]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.284249]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.284634]  do_syscall_64+0x4a/0x90=0D
[   31.284929]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.285272] RIP: 0033:0x7f3840f1059d=0D
[   31.285522] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.286677] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.287168] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.287626] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.288090] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.288583] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.289037] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.289518]  </TASK>=0D
[   31.332205] FAULT_INJECTION: forcing a failure.=0D
[   31.332205] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.332963] CPU: 1 PID: 523 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.333524] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.334260] Call Trace:=0D
[   31.334431]  <TASK>=0D
[   31.334584]  dump_stack_lvl+0xa7/0xdb=0D
[   31.334858]  dump_stack+0x19/0x1f=0D
[   31.335096]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.335398]  __should_failslab+0xca/0x120=0D
[   31.335682]  should_failslab+0x12/0x30=0D
[   31.335946]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.336263]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.336562]  kmalloc_trace+0x2e/0x120=0D
[   31.336822]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.337108]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.337510]  ? write_comp_data+0x2f/0x90=0D
[   31.337803]  ftrace_set_hash+0x445/0x590=0D
[   31.338101]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.338410]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.338752]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.339044]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.339378]  ? write_comp_data+0x2f/0x90=0D
[   31.339668]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.340038]  disarm_kprobe+0x24a/0x2d0=0D
[   31.340309]  __disable_kprobe+0x2de/0x4b0=0D
[   31.340601]  disable_kprobe+0x31/0x80=0D
[   31.340865]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.341185]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.341497]  kprobe_register+0x4e/0xf0=0D
[   31.341770]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.342130]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.342426]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.342764]  _free_event+0x220/0x11c0=0D
[   31.343039]  put_event+0x4d/0x60=0D
[   31.343276]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.343618]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.343980]  ? write_comp_data+0x2f/0x90=0D
[   31.344264]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.344602]  ? __pfx_perf_release+0x10/0x10=0D
[   31.344897]  perf_release+0x40/0x50=0D
[   31.345152]  __fput+0x26d/0xa40=0D
[   31.345400]  ____fput+0x1e/0x30=0D
[   31.345631]  task_work_run+0x1a4/0x2d0=0D
[   31.345906]  ? write_comp_data+0x2f/0x90=0D
[   31.346193]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.346496]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.346828]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.347134]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.347479]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.347810]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.348135]  do_syscall_64+0x4a/0x90=0D
[   31.348388]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.348721] RIP: 0033:0x7f3840f1059d=0D
[   31.348964] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.350088] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.350569] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.351016] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.351461] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.351907] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.352353] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.352824]  </TASK>=0D
[   31.388413] FAULT_INJECTION: forcing a failure.=0D
[   31.388413] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.389449] CPU: 0 PID: 524 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.390188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.391168] Call Trace:=0D
[   31.391400]  <TASK>=0D
[   31.391601]  dump_stack_lvl+0xa7/0xdb=0D
[   31.391952]  dump_stack+0x19/0x1f=0D
[   31.392254]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.392584]  __should_failslab+0xca/0x120=0D
[   31.392856]  should_failslab+0x12/0x30=0D
[   31.393105]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.393416]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.393700]  kmalloc_trace+0x2e/0x120=0D
[   31.393962]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.394232]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.394624]  ? write_comp_data+0x2f/0x90=0D
[   31.394911]  ftrace_set_hash+0x445/0x590=0D
[   31.395195]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.395509]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.395842]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.396126]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.396452]  ? write_comp_data+0x2f/0x90=0D
[   31.396748]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.397096]  disarm_kprobe+0x24a/0x2d0=0D
[   31.397361]  __disable_kprobe+0x2de/0x4b0=0D
[   31.397655]  disable_kprobe+0x31/0x80=0D
[   31.397922]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.398240]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.398546]  kprobe_register+0x4e/0xf0=0D
[   31.398838]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.399191]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.399482]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.399829]  _free_event+0x220/0x11c0=0D
[   31.400098]  put_event+0x4d/0x60=0D
[   31.400331]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.400666]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.401032]  ? write_comp_data+0x2f/0x90=0D
[   31.401316]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.401646]  ? __pfx_perf_release+0x10/0x10=0D
[   31.401953]  perf_release+0x40/0x50=0D
[   31.402202]  __fput+0x26d/0xa40=0D
[   31.402444]  ____fput+0x1e/0x30=0D
[   31.402677]  task_work_run+0x1a4/0x2d0=0D
[   31.402954]  ? write_comp_data+0x2f/0x90=0D
[   31.403248]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.403544]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.403868]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.404180]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.404518]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.404840]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.405170]  do_syscall_64+0x4a/0x90=0D
[   31.405425]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.405763] RIP: 0033:0x7f3840f1059d=0D
[   31.406018] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.407354] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.407930] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.408464] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.408994] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.409521] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.410062] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.410638]  </TASK>=0D
[   31.479302] FAULT_INJECTION: forcing a failure.=0D
[   31.479302] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.480110] CPU: 0 PID: 525 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.480607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.481248] Call Trace:=0D
[   31.481403]  <TASK>=0D
[   31.481540]  dump_stack_lvl+0xa7/0xdb=0D
[   31.481792]  dump_stack+0x19/0x1f=0D
[   31.482008]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.482271]  __should_failslab+0xca/0x120=0D
[   31.482523]  should_failslab+0x12/0x30=0D
[   31.482760]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.483043]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.483317]  kmalloc_trace+0x2e/0x120=0D
[   31.483557]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.483819]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.484186]  ? write_comp_data+0x2f/0x90=0D
[   31.484452]  ftrace_set_hash+0x445/0x590=0D
[   31.484724]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.485009]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.485320]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.485591]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.485907]  ? write_comp_data+0x2f/0x90=0D
[   31.486175]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.486499]  disarm_kprobe+0x24a/0x2d0=0D
[   31.486746]  __disable_kprobe+0x2de/0x4b0=0D
[   31.487010]  disable_kprobe+0x31/0x80=0D
[   31.487251]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.487544]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.487828]  kprobe_register+0x4e/0xf0=0D
[   31.488079]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.488405]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.488678]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.488985]  _free_event+0x220/0x11c0=0D
[   31.489237]  put_event+0x4d/0x60=0D
[   31.489456]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.489771]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.490107]  ? write_comp_data+0x2f/0x90=0D
[   31.490371]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.490682]  ? __pfx_perf_release+0x10/0x10=0D
[   31.490952]  perf_release+0x40/0x50=0D
[   31.491186]  __fput+0x26d/0xa40=0D
[   31.491413]  ____fput+0x1e/0x30=0D
[   31.491626]  task_work_run+0x1a4/0x2d0=0D
[   31.491874]  ? write_comp_data+0x2f/0x90=0D
[   31.492141]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.492437]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.492751]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.493042]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.493370]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.493681]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.493999]  do_syscall_64+0x4a/0x90=0D
[   31.494250]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.494580] RIP: 0033:0x7f3840f1059d=0D
[   31.494823] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.495945] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.496421] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.496871] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.497314] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.497758] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.498208] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.498678]  </TASK>=0D
[   31.541428] FAULT_INJECTION: forcing a failure.=0D
[   31.541428] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.543053] CPU: 0 PID: 526 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.544254] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.545820] Call Trace:=0D
[   31.546194]  <TASK>=0D
[   31.546521]  dump_stack_lvl+0xa7/0xdb=0D
[   31.547084]  dump_stack+0x19/0x1f=0D
[   31.547581]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.548195]  __should_failslab+0xca/0x120=0D
[   31.548789]  should_failslab+0x12/0x30=0D
[   31.549343]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.550011]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.550642]  kmalloc_trace+0x2e/0x120=0D
[   31.551210]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.551833]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.552714]  ? write_comp_data+0x2f/0x90=0D
[   31.553332]  ftrace_set_hash+0x445/0x590=0D
[   31.553977]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.554646]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.555387]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.556019]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.556734]  ? write_comp_data+0x2f/0x90=0D
[   31.557348]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.558122]  disarm_kprobe+0x24a/0x2d0=0D
[   31.558701]  __disable_kprobe+0x2de/0x4b0=0D
[   31.559314]  disable_kprobe+0x31/0x80=0D
[   31.559877]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.560555]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.561226]  kprobe_register+0x4e/0xf0=0D
[   31.561830]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.562586]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.563218]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.563944]  _free_event+0x220/0x11c0=0D
[   31.564523]  put_event+0x4d/0x60=0D
[   31.565037]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.565774]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.566574]  ? write_comp_data+0x2f/0x90=0D
[   31.567181]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.567907]  ? __pfx_perf_release+0x10/0x10=0D
[   31.568545]  perf_release+0x40/0x50=0D
[   31.569091]  __fput+0x26d/0xa40=0D
[   31.569607]  ____fput+0x1e/0x30=0D
[   31.570116]  task_work_run+0x1a4/0x2d0=0D
[   31.570694]  ? write_comp_data+0x2f/0x90=0D
[   31.571313]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.571978]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.572702]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.573374]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.574143]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.574872]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.575560]  do_syscall_64+0x4a/0x90=0D
[   31.576103]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.576830] RIP: 0033:0x7f3840f1059d=0D
[   31.577361] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.579848] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.580891] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.581915] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.582930] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.583948] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.584969] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.586029]  </TASK>=0D
[   31.637671] FAULT_INJECTION: forcing a failure.=0D
[   31.637671] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.638701] CPU: 1 PID: 527 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.639425] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.640355] Call Trace:=0D
[   31.640577]  <TASK>=0D
[   31.640773]  dump_stack_lvl+0xa7/0xdb=0D
[   31.641114]  dump_stack+0x19/0x1f=0D
[   31.641419]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.641819]  __should_failslab+0xca/0x120=0D
[   31.642175]  should_failslab+0x12/0x30=0D
[   31.642494]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.642919]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.643325]  kmalloc_trace+0x2e/0x120=0D
[   31.643655]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.644044]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.644578]  ? write_comp_data+0x2f/0x90=0D
[   31.644963]  ftrace_set_hash+0x445/0x590=0D
[   31.645360]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.645768]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.646134]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.646406]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.646725]  ? write_comp_data+0x2f/0x90=0D
[   31.646993]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.647334]  disarm_kprobe+0x24a/0x2d0=0D
[   31.647587]  __disable_kprobe+0x2de/0x4b0=0D
[   31.647854]  disable_kprobe+0x31/0x80=0D
[   31.648097]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.648406]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.648695]  kprobe_register+0x4e/0xf0=0D
[   31.648945]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.649273]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.649561]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.649877]  _free_event+0x220/0x11c0=0D
[   31.650131]  put_event+0x4d/0x60=0D
[   31.650353]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.650690]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.651039]  ? write_comp_data+0x2f/0x90=0D
[   31.651302]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.651631]  ? __pfx_perf_release+0x10/0x10=0D
[   31.651902]  perf_release+0x40/0x50=0D
[   31.652136]  __fput+0x26d/0xa40=0D
[   31.652366]  ____fput+0x1e/0x30=0D
[   31.652584]  task_work_run+0x1a4/0x2d0=0D
[   31.652843]  ? write_comp_data+0x2f/0x90=0D
[   31.653112]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.653390]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.653702]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.654021]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.654353]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.654673]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.655003]  do_syscall_64+0x4a/0x90=0D
[   31.655250]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.655587] RIP: 0033:0x7f3840f1059d=0D
[   31.655830] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.656960] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.657433] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.657884] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.658336] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.658785] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.659240] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.659714]  </TASK>=0D
[   31.703058] FAULT_INJECTION: forcing a failure.=0D
[   31.703058] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.703811] CPU: 0 PID: 528 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.704375] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.705088] Call Trace:=0D
[   31.705270]  <TASK>=0D
[   31.705420]  dump_stack_lvl+0xa7/0xdb=0D
[   31.705682]  dump_stack+0x19/0x1f=0D
[   31.705929]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.706225]  __should_failslab+0xca/0x120=0D
[   31.706522]  should_failslab+0x12/0x30=0D
[   31.706795]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.707109]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.707416]  kmalloc_trace+0x2e/0x120=0D
[   31.707670]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.707943]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.708330]  ? write_comp_data+0x2f/0x90=0D
[   31.708622]  ftrace_set_hash+0x445/0x590=0D
[   31.708910]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.709205]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.709544]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.709833]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.710153]  ? write_comp_data+0x2f/0x90=0D
[   31.710429]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.710793]  disarm_kprobe+0x24a/0x2d0=0D
[   31.711055]  __disable_kprobe+0x2de/0x4b0=0D
[   31.711333]  disable_kprobe+0x31/0x80=0D
[   31.711587]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.711919]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.712217]  kprobe_register+0x4e/0xf0=0D
[   31.712476]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.712828]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.713111]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.713437]  _free_event+0x220/0x11c0=0D
[   31.713702]  put_event+0x4d/0x60=0D
[   31.713949]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.714274]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.714617]  ? write_comp_data+0x2f/0x90=0D
[   31.714905]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.715226]  ? __pfx_perf_release+0x10/0x10=0D
[   31.715506]  perf_release+0x40/0x50=0D
[   31.715748]  __fput+0x26d/0xa40=0D
[   31.715993]  ____fput+0x1e/0x30=0D
[   31.716213]  task_work_run+0x1a4/0x2d0=0D
[   31.716471]  ? write_comp_data+0x2f/0x90=0D
[   31.716744]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.717044]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.717361]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.717654]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.717990]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.718315]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.718623]  do_syscall_64+0x4a/0x90=0D
[   31.718876]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.719215] RIP: 0033:0x7f3840f1059d=0D
[   31.719456] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.720579] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.721048] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.721503] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.721951] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.722402] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.722894] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.723363]  </TASK>=0D
[   31.762100] FAULT_INJECTION: forcing a failure.=0D
[   31.762100] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.763764] CPU: 0 PID: 529 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.765010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.766629] Call Trace:=0D
[   31.767026]  <TASK>=0D
[   31.767368]  dump_stack_lvl+0xa7/0xdb=0D
[   31.767953]  dump_stack+0x19/0x1f=0D
[   31.768481]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.769120]  __should_failslab+0xca/0x120=0D
[   31.769742]  should_failslab+0x12/0x30=0D
[   31.770332]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.771028]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.771657]  kmalloc_trace+0x2e/0x120=0D
[   31.772209]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.772801]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.773646]  ? write_comp_data+0x2f/0x90=0D
[   31.774092]  ftrace_set_hash+0x445/0x590=0D
[   31.774397]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.774708]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.775043]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.775343]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.775664]  ? write_comp_data+0x2f/0x90=0D
[   31.775940]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.776290]  disarm_kprobe+0x24a/0x2d0=0D
[   31.776548]  __disable_kprobe+0x2de/0x4b0=0D
[   31.776823]  disable_kprobe+0x31/0x80=0D
[   31.777073]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.777391]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.777690]  kprobe_register+0x4e/0xf0=0D
[   31.777959]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.778301]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.778598]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.778929]  _free_event+0x220/0x11c0=0D
[   31.779193]  put_event+0x4d/0x60=0D
[   31.779422]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.779760]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.780108]  ? write_comp_data+0x2f/0x90=0D
[   31.780382]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.780721]  ? __pfx_perf_release+0x10/0x10=0D
[   31.781003]  perf_release+0x40/0x50=0D
[   31.781244]  __fput+0x26d/0xa40=0D
[   31.781482]  ____fput+0x1e/0x30=0D
[   31.781713]  task_work_run+0x1a4/0x2d0=0D
[   31.781979]  ? write_comp_data+0x2f/0x90=0D
[   31.782256]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.782547]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.782899]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.783194]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.783528]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.783855]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.784167]  do_syscall_64+0x4a/0x90=0D
[   31.784416]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.784746] RIP: 0033:0x7f3840f1059d=0D
[   31.785010] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.786179] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.786676] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.787158] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.787612] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.788080] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.788537] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.789019]  </TASK>=0D
[   31.828500] FAULT_INJECTION: forcing a failure.=0D
[   31.828500] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.829256] CPU: 0 PID: 530 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.829826] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.830537] Call Trace:=0D
[   31.830730]  <TASK>=0D
[   31.830881]  dump_stack_lvl+0xa7/0xdb=0D
[   31.831145]  dump_stack+0x19/0x1f=0D
[   31.831380]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.831673]  __should_failslab+0xca/0x120=0D
[   31.831965]  should_failslab+0x12/0x30=0D
[   31.832223]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.832535]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.832844]  kmalloc_trace+0x2e/0x120=0D
[   31.833098]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.833378]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.833771]  ? write_comp_data+0x2f/0x90=0D
[   31.834078]  ftrace_set_hash+0x445/0x590=0D
[   31.834369]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.834680]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.835028]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.835314]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.835638]  ? write_comp_data+0x2f/0x90=0D
[   31.835922]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.836283]  disarm_kprobe+0x24a/0x2d0=0D
[   31.836548]  __disable_kprobe+0x2de/0x4b0=0D
[   31.836830]  disable_kprobe+0x31/0x80=0D
[   31.837088]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.837412]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.837716]  kprobe_register+0x4e/0xf0=0D
[   31.837989]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.838349]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.838641]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.838981]  _free_event+0x220/0x11c0=0D
[   31.839251]  put_event+0x4d/0x60=0D
[   31.839495]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.839832]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.840186]  ? write_comp_data+0x2f/0x90=0D
[   31.840480]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.840811]  ? __pfx_perf_release+0x10/0x10=0D
[   31.841098]  perf_release+0x40/0x50=0D
[   31.841346]  __fput+0x26d/0xa40=0D
[   31.841601]  ____fput+0x1e/0x30=0D
[   31.841837]  task_work_run+0x1a4/0x2d0=0D
[   31.842101]  ? write_comp_data+0x2f/0x90=0D
[   31.842381]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.842700]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.843024]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.843325]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.843676]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.843997]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.844314]  do_syscall_64+0x4a/0x90=0D
[   31.844567]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.844917] RIP: 0033:0x7f3840f1059d=0D
[   31.845164] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.846326] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.846826] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.847288] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.847738] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.848221] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.848672] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.849161]  </TASK>=0D
[   31.888190] FAULT_INJECTION: forcing a failure.=0D
[   31.888190] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.888936] CPU: 0 PID: 531 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.889485] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.890179] Call Trace:=0D
[   31.890342]  <TASK>=0D
[   31.890499]  dump_stack_lvl+0xa7/0xdb=0D
[   31.890764]  dump_stack+0x19/0x1f=0D
[   31.890991]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.891277]  __should_failslab+0xca/0x120=0D
[   31.891561]  should_failslab+0x12/0x30=0D
[   31.891811]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.892119]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.892412]  kmalloc_trace+0x2e/0x120=0D
[   31.892682]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.892960]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.893354]  ? write_comp_data+0x2f/0x90=0D
[   31.893653]  ftrace_set_hash+0x445/0x590=0D
[   31.893951]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.894255]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.894589]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.894900]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.895226]  ? write_comp_data+0x2f/0x90=0D
[   31.895511]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.895877]  disarm_kprobe+0x24a/0x2d0=0D
[   31.896143]  __disable_kprobe+0x2de/0x4b0=0D
[   31.896428]  disable_kprobe+0x31/0x80=0D
[   31.896686]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.897013]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.897318]  kprobe_register+0x4e/0xf0=0D
[   31.897584]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.897947]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.898242]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.898575]  _free_event+0x220/0x11c0=0D
[   31.898850]  put_event+0x4d/0x60=0D
[   31.899096]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.899432]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.899788]  ? write_comp_data+0x2f/0x90=0D
[   31.900071]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.900413]  ? __pfx_perf_release+0x10/0x10=0D
[   31.900701]  perf_release+0x40/0x50=0D
[   31.900949]  __fput+0x26d/0xa40=0D
[   31.901203]  ____fput+0x1e/0x30=0D
[   31.901431]  task_work_run+0x1a4/0x2d0=0D
[   31.901698]  ? write_comp_data+0x2f/0x90=0D
[   31.901991]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.902299]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.902622]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.902930]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.903268]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.903595]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.903904]  do_syscall_64+0x4a/0x90=0D
[   31.904150]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.904491] RIP: 0033:0x7f3840f1059d=0D
[   31.904731] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.905858] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.906330] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.906791] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.907233] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.907671] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.908113] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.908577]  </TASK>=0D
[   31.954181] FAULT_INJECTION: forcing a failure.=0D
[   31.954181] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   31.955800] CPU: 0 PID: 532 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   31.956991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   31.958170] Call Trace:=0D
[   31.958347]  <TASK>=0D
[   31.958504]  dump_stack_lvl+0xa7/0xdb=0D
[   31.958795]  dump_stack+0x19/0x1f=0D
[   31.959028]  should_fail_ex.cold.5+0x5/0xa=0D
[   31.959312]  __should_failslab+0xca/0x120=0D
[   31.959600]  should_failslab+0x12/0x30=0D
[   31.959850]  __kmem_cache_alloc_node+0x62/0x280=0D
[   31.960163]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   31.960451]  kmalloc_trace+0x2e/0x120=0D
[   31.960712]  alloc_ftrace_hash+0x4f/0x170=0D
[   31.960984]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   31.961366]  ? write_comp_data+0x2f/0x90=0D
[   31.961656]  ftrace_set_hash+0x445/0x590=0D
[   31.961948]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   31.962243]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   31.962569]  ? match_dev_by_uuid+0x4/0x100=0D
[   31.962865]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.963183]  ? write_comp_data+0x2f/0x90=0D
[   31.963467]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   31.963832]  disarm_kprobe+0x24a/0x2d0=0D
[   31.964101]  __disable_kprobe+0x2de/0x4b0=0D
[   31.964388]  disable_kprobe+0x31/0x80=0D
[   31.964650]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   31.964978]  disable_trace_kprobe+0x1f0/0x300=0D
[   31.965283]  kprobe_register+0x4e/0xf0=0D
[   31.965551]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   31.965910]  perf_kprobe_destroy+0xcb/0x200=0D
[   31.966216]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   31.966551]  _free_event+0x220/0x11c0=0D
[   31.966829]  put_event+0x4d/0x60=0D
[   31.967076]  perf_event_release_kernel+0x5d9/0x860=0D
[   31.967416]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   31.967773]  ? write_comp_data+0x2f/0x90=0D
[   31.968055]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.968401]  ? __pfx_perf_release+0x10/0x10=0D
[   31.968691]  perf_release+0x40/0x50=0D
[   31.968941]  __fput+0x26d/0xa40=0D
[   31.969199]  ____fput+0x1e/0x30=0D
[   31.969429]  task_work_run+0x1a4/0x2d0=0D
[   31.969695]  ? write_comp_data+0x2f/0x90=0D
[   31.969988]  ? __pfx_task_work_run+0x10/0x10=0D
[   31.970294]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.970619]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   31.970927]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   31.971268]  exit_to_user_mode_prepare+0x200/0x210=0D
[   31.971605]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   31.971926]  do_syscall_64+0x4a/0x90=0D
[   31.972181]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.972533] RIP: 0033:0x7f3840f1059d=0D
[   31.972782] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.973949] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   31.974440] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   31.974924] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   31.975387] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   31.975860] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   31.976322] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   31.976817]  </TASK>=0D
[   32.015682] FAULT_INJECTION: forcing a failure.=0D
[   32.015682] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.016799] CPU: 1 PID: 533 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.017623] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.018660] Call Trace:=0D
[   32.018903]  <TASK>=0D
[   32.019138]  dump_stack_lvl+0xa7/0xdb=0D
[   32.019504]  dump_stack+0x19/0x1f=0D
[   32.019843]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.020262]  __should_failslab+0xca/0x120=0D
[   32.020692]  should_failslab+0x12/0x30=0D
[   32.021057]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.021453]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.021831]  kmalloc_trace+0x2e/0x120=0D
[   32.022147]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.022473]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.022890]  ? write_comp_data+0x2f/0x90=0D
[   32.023183]  ftrace_set_hash+0x445/0x590=0D
[   32.023499]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.023807]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.024140]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.024435]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.024764]  ? write_comp_data+0x2f/0x90=0D
[   32.025048]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.025397]  disarm_kprobe+0x24a/0x2d0=0D
[   32.025673]  __disable_kprobe+0x2de/0x4b0=0D
[   32.025963]  disable_kprobe+0x31/0x80=0D
[   32.026224]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.026534]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.026862]  kprobe_register+0x4e/0xf0=0D
[   32.027127]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.027496]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.027799]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.028133]  _free_event+0x220/0x11c0=0D
[   32.028407]  put_event+0x4d/0x60=0D
[   32.028638]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.028985]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.029338]  ? write_comp_data+0x2f/0x90=0D
[   32.029617]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.030212]  ? __pfx_perf_release+0x10/0x10=0D
[   32.030856]  perf_release+0x40/0x50=0D
[   32.031428]  __fput+0x26d/0xa40=0D
[   32.032021]  ____fput+0x1e/0x30=0D
[   32.032588]  task_work_run+0x1a4/0x2d0=0D
[   32.033239]  ? write_comp_data+0x2f/0x90=0D
[   32.033935]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.034673]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.035483]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.036214]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.037058]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.037878]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.038664]  do_syscall_64+0x4a/0x90=0D
[   32.039294]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.040151] RIP: 0033:0x7f3840f1059d=0D
[   32.040769] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.043773] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.045018] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.046206] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.047349] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.048472] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.049591] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.050752]  </TASK>=0D
[   32.098145] FAULT_INJECTION: forcing a failure.=0D
[   32.098145] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.099759] CPU: 1 PID: 534 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.100937] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.102470] Call Trace:=0D
[   32.102841]  <TASK>=0D
[   32.103161]  dump_stack_lvl+0xa7/0xdb=0D
[   32.103707]  dump_stack+0x19/0x1f=0D
[   32.104200]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.104837]  __should_failslab+0xca/0x120=0D
[   32.105427]  should_failslab+0x12/0x30=0D
[   32.105997]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.106658]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.107273]  kmalloc_trace+0x2e/0x120=0D
[   32.107817]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.108426]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.109295]  ? write_comp_data+0x2f/0x90=0D
[   32.109919]  ftrace_set_hash+0x445/0x590=0D
[   32.110541]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.111198]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.111930]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.112554]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.113269]  ? write_comp_data+0x2f/0x90=0D
[   32.113893]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.114685]  disarm_kprobe+0x24a/0x2d0=0D
[   32.115289]  __disable_kprobe+0x2de/0x4b0=0D
[   32.115933]  disable_kprobe+0x31/0x80=0D
[   32.116530]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.117249]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.117971]  kprobe_register+0x4e/0xf0=0D
[   32.118573]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.119333]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.119962]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.120673]  _free_event+0x220/0x11c0=0D
[   32.121249]  put_event+0x4d/0x60=0D
[   32.121764]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.122499]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.123275]  ? write_comp_data+0x2f/0x90=0D
[   32.123864]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.124565]  ? __pfx_perf_release+0x10/0x10=0D
[   32.125179]  perf_release+0x40/0x50=0D
[   32.125706]  __fput+0x26d/0xa40=0D
[   32.126226]  ____fput+0x1e/0x30=0D
[   32.126715]  task_work_run+0x1a4/0x2d0=0D
[   32.127279]  ? write_comp_data+0x2f/0x90=0D
[   32.127870]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.128505]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.129186]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.129833]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.130563]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.131285]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.131970]  do_syscall_64+0x4a/0x90=0D
[   32.132516]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.133246] RIP: 0033:0x7f3840f1059d=0D
[   32.133777] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.136629] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.137976] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.139089] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.140201] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.141308] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.142445] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.143623]  </TASK>=0D
[   32.186163] FAULT_INJECTION: forcing a failure.=0D
[   32.186163] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.187206] CPU: 1 PID: 535 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.187933] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.188858] Call Trace:=0D
[   32.189082]  <TASK>=0D
[   32.189280]  dump_stack_lvl+0xa7/0xdb=0D
[   32.189630]  dump_stack+0x19/0x1f=0D
[   32.189942]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.190327]  __should_failslab+0xca/0x120=0D
[   32.190667]  should_failslab+0x12/0x30=0D
[   32.190981]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.191364]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.191745]  kmalloc_trace+0x2e/0x120=0D
[   32.192070]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.192426]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.192936]  ? write_comp_data+0x2f/0x90=0D
[   32.193303]  ftrace_set_hash+0x445/0x590=0D
[   32.193688]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.194096]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.194525]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.194886]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.195307]  ? write_comp_data+0x2f/0x90=0D
[   32.195677]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.196125]  disarm_kprobe+0x24a/0x2d0=0D
[   32.196459]  __disable_kprobe+0x2de/0x4b0=0D
[   32.196808]  disable_kprobe+0x31/0x80=0D
[   32.197159]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.197598]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.198248]  kprobe_register+0x4e/0xf0=0D
[   32.198818]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.199548]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.200161]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.200865]  _free_event+0x220/0x11c0=0D
[   32.201419]  put_event+0x4d/0x60=0D
[   32.201923]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.202657]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.203418]  ? write_comp_data+0x2f/0x90=0D
[   32.204000]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.204699]  ? __pfx_perf_release+0x10/0x10=0D
[   32.205306]  perf_release+0x40/0x50=0D
[   32.205834]  __fput+0x26d/0xa40=0D
[   32.206328]  ____fput+0x1e/0x30=0D
[   32.206807]  task_work_run+0x1a4/0x2d0=0D
[   32.207362]  ? write_comp_data+0x2f/0x90=0D
[   32.207944]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.208570]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.209260]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.209919]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.210629]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.211269]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.211922]  do_syscall_64+0x4a/0x90=0D
[   32.212460]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.213182] RIP: 0033:0x7f3840f1059d=0D
[   32.213732] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.216304] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.217391] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.218415] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.219433] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.220457] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.221482] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.222546]  </TASK>=0D
[   32.265326] FAULT_INJECTION: forcing a failure.=0D
[   32.265326] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.266990] CPU: 1 PID: 536 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.268234] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.269818] Call Trace:=0D
[   32.270198]  <TASK>=0D
[   32.270530]  dump_stack_lvl+0xa7/0xdb=0D
[   32.271115]  dump_stack+0x19/0x1f=0D
[   32.271627]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.272274]  __should_failslab+0xca/0x120=0D
[   32.272904]  should_failslab+0x12/0x30=0D
[   32.273578]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.274389]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.275142]  kmalloc_trace+0x2e/0x120=0D
[   32.275806]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.276527]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.277555]  ? write_comp_data+0x2f/0x90=0D
[   32.278296]  ftrace_set_hash+0x445/0x590=0D
[   32.278941]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.279623]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.280459]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.281167]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.281973]  ? write_comp_data+0x2f/0x90=0D
[   32.282268]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.282608]  disarm_kprobe+0x24a/0x2d0=0D
[   32.282891]  __disable_kprobe+0x2de/0x4b0=0D
[   32.283167]  disable_kprobe+0x31/0x80=0D
[   32.283419]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.283724]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.284032]  kprobe_register+0x4e/0xf0=0D
[   32.284290]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.284630]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.284922]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.285255]  _free_event+0x220/0x11c0=0D
[   32.285518]  put_event+0x4d/0x60=0D
[   32.285747]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.286094]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.286444]  ? write_comp_data+0x2f/0x90=0D
[   32.286728]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.287058]  ? __pfx_perf_release+0x10/0x10=0D
[   32.287367]  perf_release+0x40/0x50=0D
[   32.287610]  __fput+0x26d/0xa40=0D
[   32.287851]  ____fput+0x1e/0x30=0D
[   32.288075]  task_work_run+0x1a4/0x2d0=0D
[   32.288349]  ? write_comp_data+0x2f/0x90=0D
[   32.288623]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.288914]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.289232]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.289537]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.289876]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.290193]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.290529]  do_syscall_64+0x4a/0x90=0D
[   32.290788]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.291117] RIP: 0033:0x7f3840f1059d=0D
[   32.291357] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.292472] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.292955] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.293409] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.293882] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.294334] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.294810] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.295290]  </TASK>=0D
[   32.337671] FAULT_INJECTION: forcing a failure.=0D
[   32.337671] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.338714] CPU: 1 PID: 537 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.339473] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.340472] Call Trace:=0D
[   32.340701]  <TASK>=0D
[   32.340906]  dump_stack_lvl+0xa7/0xdb=0D
[   32.341272]  dump_stack+0x19/0x1f=0D
[   32.341591]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.341992]  __should_failslab+0xca/0x120=0D
[   32.342417]  should_failslab+0x12/0x30=0D
[   32.342762]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.343200]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.343614]  kmalloc_trace+0x2e/0x120=0D
[   32.343967]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.344409]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.344931]  ? write_comp_data+0x2f/0x90=0D
[   32.345215]  ftrace_set_hash+0x445/0x590=0D
[   32.345503]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.345813]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.346188]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.346473]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.346807]  ? write_comp_data+0x2f/0x90=0D
[   32.347099]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.347446]  disarm_kprobe+0x24a/0x2d0=0D
[   32.347706]  __disable_kprobe+0x2de/0x4b0=0D
[   32.347985]  disable_kprobe+0x31/0x80=0D
[   32.348251]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.348558]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.348859]  kprobe_register+0x4e/0xf0=0D
[   32.349126]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.349480]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.349766]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.350099]  _free_event+0x220/0x11c0=0D
[   32.350375]  put_event+0x4d/0x60=0D
[   32.350605]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.350947]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.351314]  ? write_comp_data+0x2f/0x90=0D
[   32.351593]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.351919]  ? __pfx_perf_release+0x10/0x10=0D
[   32.352204]  perf_release+0x40/0x50=0D
[   32.352448]  __fput+0x26d/0xa40=0D
[   32.352689]  ____fput+0x1e/0x30=0D
[   32.352913]  task_work_run+0x1a4/0x2d0=0D
[   32.353172]  ? write_comp_data+0x2f/0x90=0D
[   32.353450]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.353745]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.354068]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.354364]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.354697]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.355014]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.355328]  do_syscall_64+0x4a/0x90=0D
[   32.355579]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.355911] RIP: 0033:0x7f3840f1059d=0D
[   32.356157] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.357281] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.357760] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.358212] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.358658] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.359103] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.359548] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.360018]  </TASK>=0D
[   32.401473] FAULT_INJECTION: forcing a failure.=0D
[   32.401473] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.402409] CPU: 1 PID: 538 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.402942] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.403622] Call Trace:=0D
[   32.403786]  <TASK>=0D
[   32.403935]  dump_stack_lvl+0xa7/0xdb=0D
[   32.404194]  dump_stack+0x19/0x1f=0D
[   32.404420]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.404703]  __should_failslab+0xca/0x120=0D
[   32.404974]  should_failslab+0x12/0x30=0D
[   32.405223]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.405521]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.405816]  kmalloc_trace+0x2e/0x120=0D
[   32.406067]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.406338]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.406718]  ? write_comp_data+0x2f/0x90=0D
[   32.406994]  ftrace_set_hash+0x445/0x590=0D
[   32.407281]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.407576]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.407900]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.408179]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.408493]  ? write_comp_data+0x2f/0x90=0D
[   32.408770]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.409111]  disarm_kprobe+0x24a/0x2d0=0D
[   32.409382]  __disable_kprobe+0x2de/0x4b0=0D
[   32.409654]  disable_kprobe+0x31/0x80=0D
[   32.409909]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.410218]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.410512]  kprobe_register+0x4e/0xf0=0D
[   32.410770]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.411105]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.411384]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.411702]  _free_event+0x220/0x11c0=0D
[   32.411973]  put_event+0x4d/0x60=0D
[   32.412198]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.412519]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.412863]  ? write_comp_data+0x2f/0x90=0D
[   32.413133]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.413452]  ? __pfx_perf_release+0x10/0x10=0D
[   32.413729]  perf_release+0x40/0x50=0D
[   32.413982]  __fput+0x26d/0xa40=0D
[   32.414214]  ____fput+0x1e/0x30=0D
[   32.414430]  task_work_run+0x1a4/0x2d0=0D
[   32.414683]  ? write_comp_data+0x2f/0x90=0D
[   32.414953]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.415226]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.415528]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.415807]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.416121]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.416421]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.416715]  do_syscall_64+0x4a/0x90=0D
[   32.416951]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.417268] RIP: 0033:0x7f3840f1059d=0D
[   32.417499] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.418565] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.419021] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.419441] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.419864] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.420287] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.420712] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.421159]  </TASK>=0D
[   32.457632] FAULT_INJECTION: forcing a failure.=0D
[   32.457632] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.458528] CPU: 1 PID: 539 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.459202] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.460088] Call Trace:=0D
[   32.460302]  <TASK>=0D
[   32.460490]  dump_stack_lvl+0xa7/0xdb=0D
[   32.460827]  dump_stack+0x19/0x1f=0D
[   32.461112]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.461481]  __should_failslab+0xca/0x120=0D
[   32.461864]  should_failslab+0x12/0x30=0D
[   32.462183]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.462560]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.462934]  kmalloc_trace+0x2e/0x120=0D
[   32.463239]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.463590]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.464072]  ? write_comp_data+0x2f/0x90=0D
[   32.464409]  ftrace_set_hash+0x445/0x590=0D
[   32.464757]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.465110]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.465500]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.465848]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.466230]  ? write_comp_data+0x2f/0x90=0D
[   32.466563]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.466986]  disarm_kprobe+0x24a/0x2d0=0D
[   32.467323]  __disable_kprobe+0x2de/0x4b0=0D
[   32.467689]  disable_kprobe+0x31/0x80=0D
[   32.468018]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.468415]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.468804]  kprobe_register+0x4e/0xf0=0D
[   32.469119]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.469560]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.469941]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.470367]  _free_event+0x220/0x11c0=0D
[   32.470715]  put_event+0x4d/0x60=0D
[   32.471013]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.471426]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.471858]  ? write_comp_data+0x2f/0x90=0D
[   32.472212]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.472624]  ? __pfx_perf_release+0x10/0x10=0D
[   32.472973]  perf_release+0x40/0x50=0D
[   32.473281]  __fput+0x26d/0xa40=0D
[   32.473584]  ____fput+0x1e/0x30=0D
[   32.473868]  task_work_run+0x1a4/0x2d0=0D
[   32.474205]  ? write_comp_data+0x2f/0x90=0D
[   32.474587]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.474967]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.475386]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.475769]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.476191]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.476598]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.476995]  do_syscall_64+0x4a/0x90=0D
[   32.477312]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.477742] RIP: 0033:0x7f3840f1059d=0D
[   32.478062] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.479503] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.480133] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.480708] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.481270] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.481844] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.482412] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.483045]  </TASK>=0D
[   32.539322] FAULT_INJECTION: forcing a failure.=0D
[   32.539322] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.540270] CPU: 1 PID: 540 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.540979] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.541911] Call Trace:=0D
[   32.542081]  <TASK>=0D
[   32.542232]  dump_stack_lvl+0xa7/0xdb=0D
[   32.542497]  dump_stack+0x19/0x1f=0D
[   32.542731]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.543022]  __should_failslab+0xca/0x120=0D
[   32.543300]  should_failslab+0x12/0x30=0D
[   32.543556]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.543863]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.544157]  kmalloc_trace+0x2e/0x120=0D
[   32.544420]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.544699]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.545091]  ? write_comp_data+0x2f/0x90=0D
[   32.545376]  ftrace_set_hash+0x445/0x590=0D
[   32.545664]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.545975]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.546308]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.546593]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.546916]  ? write_comp_data+0x2f/0x90=0D
[   32.547198]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.547546]  disarm_kprobe+0x24a/0x2d0=0D
[   32.547809]  __disable_kprobe+0x2de/0x4b0=0D
[   32.548089]  disable_kprobe+0x31/0x80=0D
[   32.548346]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.548660]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.548958]  kprobe_register+0x4e/0xf0=0D
[   32.549221]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.549564]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.549861]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.550188]  _free_event+0x220/0x11c0=0D
[   32.550453]  put_event+0x4d/0x60=0D
[   32.550681]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.551012]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.551364]  ? write_comp_data+0x2f/0x90=0D
[   32.551638]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.551968]  ? __pfx_perf_release+0x10/0x10=0D
[   32.552254]  perf_release+0x40/0x50=0D
[   32.552500]  __fput+0x26d/0xa40=0D
[   32.552740]  ____fput+0x1e/0x30=0D
[   32.552965]  task_work_run+0x1a4/0x2d0=0D
[   32.553228]  ? write_comp_data+0x2f/0x90=0D
[   32.553507]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.553806]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.554122]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.554419]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.554748]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.555069]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.555391]  do_syscall_64+0x4a/0x90=0D
[   32.555651]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.555996] RIP: 0033:0x7f3840f1059d=0D
[   32.556252] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.557419] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.557927] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.558389] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.558851] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.559311] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.559775] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.560260]  </TASK>=0D
[   32.596473] FAULT_INJECTION: forcing a failure.=0D
[   32.596473] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.597205] CPU: 1 PID: 541 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.597709] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.598388] Call Trace:=0D
[   32.598550]  <TASK>=0D
[   32.598697]  dump_stack_lvl+0xa7/0xdb=0D
[   32.598948]  dump_stack+0x19/0x1f=0D
[   32.599169]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.599454]  __should_failslab+0xca/0x120=0D
[   32.599726]  should_failslab+0x12/0x30=0D
[   32.599973]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.600270]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.600549]  kmalloc_trace+0x2e/0x120=0D
[   32.600795]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.601062]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.601437]  ? write_comp_data+0x2f/0x90=0D
[   32.601707]  ftrace_set_hash+0x445/0x590=0D
[   32.601994]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.602287]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.602608]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.602878]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.603188]  ? write_comp_data+0x2f/0x90=0D
[   32.603459]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.603792]  disarm_kprobe+0x24a/0x2d0=0D
[   32.604047]  __disable_kprobe+0x2de/0x4b0=0D
[   32.604330]  disable_kprobe+0x31/0x80=0D
[   32.604584]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.604891]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.605188]  kprobe_register+0x4e/0xf0=0D
[   32.605446]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.605792]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.606135]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.606524]  _free_event+0x220/0x11c0=0D
[   32.606789]  put_event+0x4d/0x60=0D
[   32.607017]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.607342]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.607711]  ? write_comp_data+0x2f/0x90=0D
[   32.607989]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.608380]  ? __pfx_perf_release+0x10/0x10=0D
[   32.608674]  perf_release+0x40/0x50=0D
[   32.608954]  __fput+0x26d/0xa40=0D
[   32.609248]  ____fput+0x1e/0x30=0D
[   32.609476]  task_work_run+0x1a4/0x2d0=0D
[   32.609745]  ? write_comp_data+0x2f/0x90=0D
[   32.610069]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.610420]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.610755]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.611091]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.611501]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.611836]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.612157]  do_syscall_64+0x4a/0x90=0D
[   32.612446]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.612835] RIP: 0033:0x7f3840f1059d=0D
[   32.613086] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.614337] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.614923] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.615384] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.615833] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.616279] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.616726] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.617203]  </TASK>=0D
[   32.652490] FAULT_INJECTION: forcing a failure.=0D
[   32.652490] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.653191] CPU: 0 PID: 542 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.653723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.655328] Call Trace:=0D
[   32.655727]  <TASK>=0D
[   32.656070]  dump_stack_lvl+0xa7/0xdb=0D
[   32.656660]  dump_stack+0x19/0x1f=0D
[   32.657183]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.657827]  __should_failslab+0xca/0x120=0D
[   32.658439]  should_failslab+0x12/0x30=0D
[   32.659008]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.659699]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.660349]  kmalloc_trace+0x2e/0x120=0D
[   32.660920]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.661544]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.662133]  ? write_comp_data+0x2f/0x90=0D
[   32.662425]  ftrace_set_hash+0x445/0x590=0D
[   32.662718]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.663038]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.663391]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.663752]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.664161]  ? write_comp_data+0x2f/0x90=0D
[   32.664502]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.664852]  disarm_kprobe+0x24a/0x2d0=0D
[   32.665122]  __disable_kprobe+0x2de/0x4b0=0D
[   32.665406]  disable_kprobe+0x31/0x80=0D
[   32.665664]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.665988]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.666293]  kprobe_register+0x4e/0xf0=0D
[   32.666560]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.666910]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.667203]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.667541]  _free_event+0x220/0x11c0=0D
[   32.667811]  put_event+0x4d/0x60=0D
[   32.668045]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.668385]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.668744]  ? write_comp_data+0x2f/0x90=0D
[   32.669042]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.669391]  ? __pfx_perf_release+0x10/0x10=0D
[   32.669685]  perf_release+0x40/0x50=0D
[   32.669940]  __fput+0x26d/0xa40=0D
[   32.670184]  ____fput+0x1e/0x30=0D
[   32.670412]  task_work_run+0x1a4/0x2d0=0D
[   32.670676]  ? write_comp_data+0x2f/0x90=0D
[   32.670960]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.671259]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.671590]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.671894]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.672235]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.672560]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.672882]  do_syscall_64+0x4a/0x90=0D
[   32.673139]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.673479] RIP: 0033:0x7f3840f1059d=0D
[   32.673730] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.674899] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.675394] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.675853] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.676310] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.676761] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.677239] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.677703]  </TASK>=0D
[   32.735832] FAULT_INJECTION: forcing a failure.=0D
[   32.735832] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.736509] CPU: 0 PID: 543 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.737014] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.737664] Call Trace:=0D
[   32.737829]  <TASK>=0D
[   32.737966]  dump_stack_lvl+0xa7/0xdb=0D
[   32.738204]  dump_stack+0x19/0x1f=0D
[   32.738415]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.738685]  __should_failslab+0xca/0x120=0D
[   32.738940]  should_failslab+0x12/0x30=0D
[   32.739182]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.739475]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.739751]  kmalloc_trace+0x2e/0x120=0D
[   32.739992]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.740255]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.740625]  ? write_comp_data+0x2f/0x90=0D
[   32.740896]  ftrace_set_hash+0x445/0x590=0D
[   32.741171]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.741456]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.741771]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.742049]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.742359]  ? write_comp_data+0x2f/0x90=0D
[   32.742625]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.742958]  disarm_kprobe+0x24a/0x2d0=0D
[   32.743211]  __disable_kprobe+0x2de/0x4b0=0D
[   32.743477]  disable_kprobe+0x31/0x80=0D
[   32.743719]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.744014]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.744305]  kprobe_register+0x4e/0xf0=0D
[   32.744557]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.744890]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.745166]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.745482]  _free_event+0x220/0x11c0=0D
[   32.745733]  put_event+0x4d/0x60=0D
[   32.745960]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.746278]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.746636]  ? write_comp_data+0x2f/0x90=0D
[   32.746897]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.747213]  ? __pfx_perf_release+0x10/0x10=0D
[   32.747486]  perf_release+0x40/0x50=0D
[   32.747721]  __fput+0x26d/0xa40=0D
[   32.747952]  ____fput+0x1e/0x30=0D
[   32.748170]  task_work_run+0x1a4/0x2d0=0D
[   32.748420]  ? write_comp_data+0x2f/0x90=0D
[   32.748685]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.748963]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.749274]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.749561]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.749898]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.750212]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.750524]  do_syscall_64+0x4a/0x90=0D
[   32.750769]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.751100] RIP: 0033:0x7f3840f1059d=0D
[   32.751339] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.752473] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.752949] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.753389] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.753839] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.754283] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.754722] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.755190]  </TASK>=0D
[   32.804540] FAULT_INJECTION: forcing a failure.=0D
[   32.804540] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.805261] CPU: 0 PID: 544 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.805777] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.806461] Call Trace:=0D
[   32.806621]  <TASK>=0D
[   32.806764]  dump_stack_lvl+0xa7/0xdb=0D
[   32.807012]  dump_stack+0x19/0x1f=0D
[   32.807232]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.807508]  __should_failslab+0xca/0x120=0D
[   32.807772]  should_failslab+0x12/0x30=0D
[   32.808014]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.808307]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.808585]  kmalloc_trace+0x2e/0x120=0D
[   32.808828]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.809093]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.809464]  ? write_comp_data+0x2f/0x90=0D
[   32.809732]  ftrace_set_hash+0x445/0x590=0D
[   32.810016]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.810304]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.810621]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.810890]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.811198]  ? write_comp_data+0x2f/0x90=0D
[   32.811467]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.811806]  disarm_kprobe+0x24a/0x2d0=0D
[   32.812063]  __disable_kprobe+0x2de/0x4b0=0D
[   32.812338]  disable_kprobe+0x31/0x80=0D
[   32.812591]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.812896]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.813192]  kprobe_register+0x4e/0xf0=0D
[   32.813452]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.813799]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.814083]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.814405]  _free_event+0x220/0x11c0=0D
[   32.814668]  put_event+0x4d/0x60=0D
[   32.814895]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.815222]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.815567]  ? write_comp_data+0x2f/0x90=0D
[   32.815840]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.816161]  ? __pfx_perf_release+0x10/0x10=0D
[   32.816443]  perf_release+0x40/0x50=0D
[   32.816683]  __fput+0x26d/0xa40=0D
[   32.816921]  ____fput+0x1e/0x30=0D
[   32.817142]  task_work_run+0x1a4/0x2d0=0D
[   32.817399]  ? write_comp_data+0x2f/0x90=0D
[   32.817672]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.817968]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.818288]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.818578]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.818917]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.819239]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.819558]  do_syscall_64+0x4a/0x90=0D
[   32.819813]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.820163] RIP: 0033:0x7f3840f1059d=0D
[   32.820415] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.821576] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.822072] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.822527] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.822980] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.823432] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.823885] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.824364]  </TASK>=0D
[   32.865841] FAULT_INJECTION: forcing a failure.=0D
[   32.865841] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.866820] CPU: 1 PID: 545 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.867499] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.868381] Call Trace:=0D
[   32.868589]  <TASK>=0D
[   32.868779]  dump_stack_lvl+0xa7/0xdb=0D
[   32.869108]  dump_stack+0x19/0x1f=0D
[   32.869408]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.869793]  __should_failslab+0xca/0x120=0D
[   32.870096]  should_failslab+0x12/0x30=0D
[   32.870354]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.870665]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.870963]  kmalloc_trace+0x2e/0x120=0D
[   32.871226]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.871516]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.871922]  ? write_comp_data+0x2f/0x90=0D
[   32.872209]  ftrace_set_hash+0x445/0x590=0D
[   32.872508]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.872816]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.873170]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.873455]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.873786]  ? write_comp_data+0x2f/0x90=0D
[   32.874072]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.874420]  disarm_kprobe+0x24a/0x2d0=0D
[   32.874686]  __disable_kprobe+0x2de/0x4b0=0D
[   32.874970]  disable_kprobe+0x31/0x80=0D
[   32.875227]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.875542]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.875846]  kprobe_register+0x4e/0xf0=0D
[   32.876114]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.876460]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.876751]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.877085]  _free_event+0x220/0x11c0=0D
[   32.877353]  put_event+0x4d/0x60=0D
[   32.877586]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.877931]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.878287]  ? write_comp_data+0x2f/0x90=0D
[   32.878568]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.878901]  ? __pfx_perf_release+0x10/0x10=0D
[   32.879189]  perf_release+0x40/0x50=0D
[   32.879439]  __fput+0x26d/0xa40=0D
[   32.879682]  ____fput+0x1e/0x30=0D
[   32.879908]  task_work_run+0x1a4/0x2d0=0D
[   32.880175]  ? write_comp_data+0x2f/0x90=0D
[   32.880456]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.880753]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.881077]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.881379]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.881720]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.882049]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.882366]  do_syscall_64+0x4a/0x90=0D
[   32.882621]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.882961] RIP: 0033:0x7f3840f1059d=0D
[   32.883209] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.884338] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.884810] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.885248] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.885687] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.886158] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.886612] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.887102]  </TASK>=0D
[   32.922839] FAULT_INJECTION: forcing a failure.=0D
[   32.922839] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   32.923532] CPU: 0 PID: 546 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   32.924044] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   32.924686] Call Trace:=0D
[   32.924839]  <TASK>=0D
[   32.924980]  dump_stack_lvl+0xa7/0xdb=0D
[   32.925234]  dump_stack+0x19/0x1f=0D
[   32.925448]  should_fail_ex.cold.5+0x5/0xa=0D
[   32.925716]  __should_failslab+0xca/0x120=0D
[   32.925984]  should_failslab+0x12/0x30=0D
[   32.926231]  __kmem_cache_alloc_node+0x62/0x280=0D
[   32.926514]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   32.926796]  kmalloc_trace+0x2e/0x120=0D
[   32.927033]  alloc_ftrace_hash+0x4f/0x170=0D
[   32.927303]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   32.927668]  ? write_comp_data+0x2f/0x90=0D
[   32.927929]  ftrace_set_hash+0x445/0x590=0D
[   32.928196]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   32.928488]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   32.928796]  ? match_dev_by_uuid+0x4/0x100=0D
[   32.929059]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.929356]  ? write_comp_data+0x2f/0x90=0D
[   32.929628]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   32.929955]  disarm_kprobe+0x24a/0x2d0=0D
[   32.930199]  __disable_kprobe+0x2de/0x4b0=0D
[   32.930460]  disable_kprobe+0x31/0x80=0D
[   32.930726]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   32.931015]  disable_trace_kprobe+0x1f0/0x300=0D
[   32.931296]  kprobe_register+0x4e/0xf0=0D
[   32.931540]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   32.931873]  perf_kprobe_destroy+0xcb/0x200=0D
[   32.932140]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   32.932445]  _free_event+0x220/0x11c0=0D
[   32.932702]  put_event+0x4d/0x60=0D
[   32.932918]  perf_event_release_kernel+0x5d9/0x860=0D
[   32.933226]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   32.933553]  ? write_comp_data+0x2f/0x90=0D
[   32.933831]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   32.934137]  ? __pfx_perf_release+0x10/0x10=0D
[   32.934422]  perf_release+0x40/0x50=0D
[   32.934738]  __fput+0x26d/0xa40=0D
[   32.935025]  ____fput+0x1e/0x30=0D
[   32.935282]  task_work_run+0x1a4/0x2d0=0D
[   32.935606]  ? write_comp_data+0x2f/0x90=0D
[   32.935954]  ? __pfx_task_work_run+0x10/0x10=0D
[   32.936289]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   32.936625]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   32.936941]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   32.937324]  exit_to_user_mode_prepare+0x200/0x210=0D
[   32.937654]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   32.938006]  do_syscall_64+0x4a/0x90=0D
[   32.938305]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   32.938680] RIP: 0033:0x7f3840f1059d=0D
[   32.938982] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   32.940267] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   32.940835] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   32.941398] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   32.941952] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   32.942492] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   32.943024] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   32.943592]  </TASK>=0D
[   33.010189] FAULT_INJECTION: forcing a failure.=0D
[   33.010189] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.010978] CPU: 0 PID: 547 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.011524] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.012213] Call Trace:=0D
[   33.012375]  <TASK>=0D
[   33.012528]  dump_stack_lvl+0xa7/0xdb=0D
[   33.012788]  dump_stack+0x19/0x1f=0D
[   33.013013]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.013294]  __should_failslab+0xca/0x120=0D
[   33.013567]  should_failslab+0x12/0x30=0D
[   33.013840]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.014149]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.014439]  kmalloc_trace+0x2e/0x120=0D
[   33.014710]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.014995]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.015386]  ? write_comp_data+0x2f/0x90=0D
[   33.015670]  ftrace_set_hash+0x445/0x590=0D
[   33.015973]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.016275]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.016607]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.016903]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.017247]  ? write_comp_data+0x2f/0x90=0D
[   33.017530]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.017907]  disarm_kprobe+0x24a/0x2d0=0D
[   33.018186]  __disable_kprobe+0x2de/0x4b0=0D
[   33.018469]  disable_kprobe+0x31/0x80=0D
[   33.018741]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.019082]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.019388]  kprobe_register+0x4e/0xf0=0D
[   33.019654]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.020017]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.020322]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.020655]  _free_event+0x220/0x11c0=0D
[   33.020923]  put_event+0x4d/0x60=0D
[   33.021156]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.021506]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.021870]  ? write_comp_data+0x2f/0x90=0D
[   33.022150]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.022493]  ? __pfx_perf_release+0x10/0x10=0D
[   33.022791]  perf_release+0x40/0x50=0D
[   33.023040]  __fput+0x26d/0xa40=0D
[   33.023281]  ____fput+0x1e/0x30=0D
[   33.023519]  task_work_run+0x1a4/0x2d0=0D
[   33.023784]  ? write_comp_data+0x2f/0x90=0D
[   33.024063]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.024359]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.024694]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.024994]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.025333]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.025668]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.026044]  do_syscall_64+0x4a/0x90=0D
[   33.026356]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.026755] RIP: 0033:0x7f3840f1059d=0D
[   33.027004] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.028161] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.028646] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.029108] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.029565] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.030036] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.030489] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.030993]  </TASK>=0D
[   33.077036] FAULT_INJECTION: forcing a failure.=0D
[   33.077036] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.078634] CPU: 0 PID: 548 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.079834] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.081430] Call Trace:=0D
[   33.081824]  <TASK>=0D
[   33.082171]  dump_stack_lvl+0xa7/0xdb=0D
[   33.082754]  dump_stack+0x19/0x1f=0D
[   33.083297]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.083929]  __should_failslab+0xca/0x120=0D
[   33.084596]  should_failslab+0x12/0x30=0D
[   33.085216]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.086042]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.086801]  kmalloc_trace+0x2e/0x120=0D
[   33.087467]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.088197]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.089226]  ? write_comp_data+0x2f/0x90=0D
[   33.089961]  ftrace_set_hash+0x445/0x590=0D
[   33.090704]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.091491]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.092366]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.093105]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.093955]  ? write_comp_data+0x2f/0x90=0D
[   33.094671]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.095576]  disarm_kprobe+0x24a/0x2d0=0D
[   33.096255]  __disable_kprobe+0x2de/0x4b0=0D
[   33.096982]  disable_kprobe+0x31/0x80=0D
[   33.097653]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.098468]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.099257]  kprobe_register+0x4e/0xf0=0D
[   33.099937]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.100845]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.101595]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.102456]  _free_event+0x220/0x11c0=0D
[   33.103131]  put_event+0x4d/0x60=0D
[   33.103734]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.104597]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.105525]  ? write_comp_data+0x2f/0x90=0D
[   33.106256]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.107103]  ? __pfx_perf_release+0x10/0x10=0D
[   33.107873]  perf_release+0x40/0x50=0D
[   33.108510]  __fput+0x26d/0xa40=0D
[   33.109118]  ____fput+0x1e/0x30=0D
[   33.109699]  task_work_run+0x1a4/0x2d0=0D
[   33.110386]  ? write_comp_data+0x2f/0x90=0D
[   33.111086]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.111828]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.112635]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.113382]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.114236]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.115048]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.115839]  do_syscall_64+0x4a/0x90=0D
[   33.116469]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.117323] RIP: 0033:0x7f3840f1059d=0D
[   33.117952] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.120921] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.122146] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.122644] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.123090] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.123537] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.123981] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.124451]  </TASK>=0D
[   33.177169] FAULT_INJECTION: forcing a failure.=0D
[   33.177169] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.178789] CPU: 0 PID: 549 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.179983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.181548] Call Trace:=0D
[   33.181941]  <TASK>=0D
[   33.182278]  dump_stack_lvl+0xa7/0xdb=0D
[   33.182871]  dump_stack+0x19/0x1f=0D
[   33.183399]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.184040]  __should_failslab+0xca/0x120=0D
[   33.184653]  should_failslab+0x12/0x30=0D
[   33.185223]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.185914]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.186556]  kmalloc_trace+0x2e/0x120=0D
[   33.187119]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.187731]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.188599]  ? write_comp_data+0x2f/0x90=0D
[   33.189212]  ftrace_set_hash+0x445/0x590=0D
[   33.189844]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.190510]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.191249]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.191879]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.192593]  ? write_comp_data+0x2f/0x90=0D
[   33.193209]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.193983]  disarm_kprobe+0x24a/0x2d0=0D
[   33.194564]  __disable_kprobe+0x2de/0x4b0=0D
[   33.195183]  disable_kprobe+0x31/0x80=0D
[   33.195749]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.196433]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.197098]  kprobe_register+0x4e/0xf0=0D
[   33.197679]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.198447]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.199079]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.199808]  _free_event+0x220/0x11c0=0D
[   33.200401]  put_event+0x4d/0x60=0D
[   33.200920]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.201657]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.202455]  ? write_comp_data+0x2f/0x90=0D
[   33.203072]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.203799]  ? __pfx_perf_release+0x10/0x10=0D
[   33.204445]  perf_release+0x40/0x50=0D
[   33.205005]  __fput+0x26d/0xa40=0D
[   33.205528]  ____fput+0x1e/0x30=0D
[   33.206039]  task_work_run+0x1a4/0x2d0=0D
[   33.206626]  ? write_comp_data+0x2f/0x90=0D
[   33.207242]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.207903]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.208625]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.209295]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.210054]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.210776]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.211479]  do_syscall_64+0x4a/0x90=0D
[   33.212040]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.212795] RIP: 0033:0x7f3840f1059d=0D
[   33.213346] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.216002] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.217321] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.218543] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.219718] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.220887] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.222068] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.223269]  </TASK>=0D
[   33.272820] FAULT_INJECTION: forcing a failure.=0D
[   33.272820] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.274337] CPU: 0 PID: 550 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.275402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.276883] Call Trace:=0D
[   33.277246]  <TASK>=0D
[   33.277564]  dump_stack_lvl+0xa7/0xdb=0D
[   33.278109]  dump_stack+0x19/0x1f=0D
[   33.278599]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.279199]  __should_failslab+0xca/0x120=0D
[   33.279781]  should_failslab+0x12/0x30=0D
[   33.280319]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.280956]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.281561]  kmalloc_trace+0x2e/0x120=0D
[   33.282112]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.282710]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.283669]  ? write_comp_data+0x2f/0x90=0D
[   33.284337]  ftrace_set_hash+0x445/0x590=0D
[   33.285024]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.285773]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.286628]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.287348]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.288169]  ? write_comp_data+0x2f/0x90=0D
[   33.288876]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.289760]  disarm_kprobe+0x24a/0x2d0=0D
[   33.290431]  __disable_kprobe+0x2de/0x4b0=0D
[   33.291134]  disable_kprobe+0x31/0x80=0D
[   33.291780]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.292556]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.293323]  kprobe_register+0x4e/0xf0=0D
[   33.294007]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.294884]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.295620]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.296453]  _free_event+0x220/0x11c0=0D
[   33.297115]  put_event+0x4d/0x60=0D
[   33.297696]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.298534]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.299443]  ? write_comp_data+0x2f/0x90=0D
[   33.300137]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.300966]  ? __pfx_perf_release+0x10/0x10=0D
[   33.301694]  perf_release+0x40/0x50=0D
[   33.302333]  __fput+0x26d/0xa40=0D
[   33.302917]  ____fput+0x1e/0x30=0D
[   33.303493]  task_work_run+0x1a4/0x2d0=0D
[   33.304172]  ? write_comp_data+0x2f/0x90=0D
[   33.304874]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.305617]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.306430]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.307188]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.308044]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.308869]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.309680]  do_syscall_64+0x4a/0x90=0D
[   33.310321]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.311184] RIP: 0033:0x7f3840f1059d=0D
[   33.311802] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.314216] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.314704] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.315192] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.315636] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.316092] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.316534] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.317012]  </TASK>=0D
[   33.361216] FAULT_INJECTION: forcing a failure.=0D
[   33.361216] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.362165] CPU: 0 PID: 551 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.362873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.363762] Call Trace:=0D
[   33.364007]  <TASK>=0D
[   33.364202]  dump_stack_lvl+0xa7/0xdb=0D
[   33.364540]  dump_stack+0x19/0x1f=0D
[   33.364855]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.365250]  __should_failslab+0xca/0x120=0D
[   33.365623]  should_failslab+0x12/0x30=0D
[   33.366012]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.366421]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.366805]  kmalloc_trace+0x2e/0x120=0D
[   33.367136]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.367489]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.367979]  ? write_comp_data+0x2f/0x90=0D
[   33.368344]  ftrace_set_hash+0x445/0x590=0D
[   33.368722]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.369114]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.369527]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.369940]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.370611]  ? write_comp_data+0x2f/0x90=0D
[   33.371183]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.371896]  disarm_kprobe+0x24a/0x2d0=0D
[   33.372432]  __disable_kprobe+0x2de/0x4b0=0D
[   33.373005]  disable_kprobe+0x31/0x80=0D
[   33.373529]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.374175]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.374796]  kprobe_register+0x4e/0xf0=0D
[   33.375337]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.376045]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.376637]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.377322]  _free_event+0x220/0x11c0=0D
[   33.377893]  put_event+0x4d/0x60=0D
[   33.378117]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.378424]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.378751]  ? write_comp_data+0x2f/0x90=0D
[   33.379009]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.379314]  ? __pfx_perf_release+0x10/0x10=0D
[   33.379578]  perf_release+0x40/0x50=0D
[   33.379807]  __fput+0x26d/0xa40=0D
[   33.380030]  ____fput+0x1e/0x30=0D
[   33.380241]  task_work_run+0x1a4/0x2d0=0D
[   33.380487]  ? write_comp_data+0x2f/0x90=0D
[   33.380747]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.381031]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.381353]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.381634]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.381958]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.382257]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.382552]  do_syscall_64+0x4a/0x90=0D
[   33.382792]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.383105] RIP: 0033:0x7f3840f1059d=0D
[   33.383337] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.384390] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.384840] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.385257] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.385672] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.386098] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.386514] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.386953]  </TASK>=0D
[   33.437165] FAULT_INJECTION: forcing a failure.=0D
[   33.437165] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.438096] CPU: 0 PID: 552 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.438792] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.439685] Call Trace:=0D
[   33.439894]  <TASK>=0D
[   33.440084]  dump_stack_lvl+0xa7/0xdb=0D
[   33.440418]  dump_stack+0x19/0x1f=0D
[   33.440713]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.441087]  __should_failslab+0xca/0x120=0D
[   33.441441]  should_failslab+0x12/0x30=0D
[   33.441765]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.442159]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.442544]  kmalloc_trace+0x2e/0x120=0D
[   33.442863]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.443221]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.443722]  ? write_comp_data+0x2f/0x90=0D
[   33.444123]  ftrace_set_hash+0x445/0x590=0D
[   33.444523]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.444956]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.445394]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.445762]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.446498]  ? write_comp_data+0x2f/0x90=0D
[   33.447096]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.447829]  disarm_kprobe+0x24a/0x2d0=0D
[   33.448404]  __disable_kprobe+0x2de/0x4b0=0D
[   33.448996]  disable_kprobe+0x31/0x80=0D
[   33.449541]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.450208]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.450847]  kprobe_register+0x4e/0xf0=0D
[   33.451403]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.452127]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.452735]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.453431]  _free_event+0x220/0x11c0=0D
[   33.453948]  put_event+0x4d/0x60=0D
[   33.454191]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.454540]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.454921]  ? write_comp_data+0x2f/0x90=0D
[   33.455198]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.455539]  ? __pfx_perf_release+0x10/0x10=0D
[   33.455824]  perf_release+0x40/0x50=0D
[   33.456073]  __fput+0x26d/0xa40=0D
[   33.456314]  ____fput+0x1e/0x30=0D
[   33.456555]  task_work_run+0x1a4/0x2d0=0D
[   33.456820]  ? write_comp_data+0x2f/0x90=0D
[   33.457100]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.457396]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.457735]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.458046]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.458384]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.458720]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.459036]  do_syscall_64+0x4a/0x90=0D
[   33.459290]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.459627] RIP: 0033:0x7f3840f1059d=0D
[   33.459885] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.461041] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.461528] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.461988] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.462422] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.462896] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.463375] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.463862]  </TASK>=0D
[   33.500984] FAULT_INJECTION: forcing a failure.=0D
[   33.500984] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.501957] CPU: 1 PID: 553 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.502654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.503559] Call Trace:=0D
[   33.503777]  <TASK>=0D
[   33.503968]  dump_stack_lvl+0xa7/0xdb=0D
[   33.504309]  dump_stack+0x19/0x1f=0D
[   33.504614]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.504992]  __should_failslab+0xca/0x120=0D
[   33.505348]  should_failslab+0x12/0x30=0D
[   33.505690]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.506100]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.506482]  kmalloc_trace+0x2e/0x120=0D
[   33.506820]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.507172]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.507689]  ? write_comp_data+0x2f/0x90=0D
[   33.508077]  ftrace_set_hash+0x445/0x590=0D
[   33.508478]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.508917]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.509368]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.509745]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.510313]  ? write_comp_data+0x2f/0x90=0D
[   33.510597]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.510932]  disarm_kprobe+0x24a/0x2d0=0D
[   33.511181]  __disable_kprobe+0x2de/0x4b0=0D
[   33.511446]  disable_kprobe+0x31/0x80=0D
[   33.511688]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.511981]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.512266]  kprobe_register+0x4e/0xf0=0D
[   33.512516]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.512843]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.513119]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.513486]  _free_event+0x220/0x11c0=0D
[   33.513794]  put_event+0x4d/0x60=0D
[   33.514064]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.514421]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.514758]  ? write_comp_data+0x2f/0x90=0D
[   33.515022]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.515341]  ? __pfx_perf_release+0x10/0x10=0D
[   33.515692]  perf_release+0x40/0x50=0D
[   33.515932]  __fput+0x26d/0xa40=0D
[   33.516162]  ____fput+0x1e/0x30=0D
[   33.516375]  task_work_run+0x1a4/0x2d0=0D
[   33.516647]  ? write_comp_data+0x2f/0x90=0D
[   33.516913]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.517193]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.517504]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.517799]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.518125]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.518444]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.518758]  do_syscall_64+0x4a/0x90=0D
[   33.519009]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.519342] RIP: 0033:0x7f3840f1059d=0D
[   33.519587] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.520700] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.521178] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.521618] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.522067] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.522508] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.522950] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.523438]  </TASK>=0D
[   33.583477] FAULT_INJECTION: forcing a failure.=0D
[   33.583477] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.585102] CPU: 1 PID: 554 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.586341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.587931] Call Trace:=0D
[   33.588309]  <TASK>=0D
[   33.588643]  dump_stack_lvl+0xa7/0xdb=0D
[   33.589197]  dump_stack+0x19/0x1f=0D
[   33.589704]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.590333]  __should_failslab+0xca/0x120=0D
[   33.590930]  should_failslab+0x12/0x30=0D
[   33.591486]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.592146]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.592765]  kmalloc_trace+0x2e/0x120=0D
[   33.593311]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.593981]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.594438]  ? write_comp_data+0x2f/0x90=0D
[   33.594803]  ftrace_set_hash+0x445/0x590=0D
[   33.595123]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.595434]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.595757]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.596035]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.596348]  ? write_comp_data+0x2f/0x90=0D
[   33.596623]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.596959]  disarm_kprobe+0x24a/0x2d0=0D
[   33.597214]  __disable_kprobe+0x2de/0x4b0=0D
[   33.597495]  disable_kprobe+0x31/0x80=0D
[   33.597744]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.598051]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.598345]  kprobe_register+0x4e/0xf0=0D
[   33.598604]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.598939]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.599220]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.599541]  _free_event+0x220/0x11c0=0D
[   33.599804]  put_event+0x4d/0x60=0D
[   33.600041]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.600400]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.600849]  ? write_comp_data+0x2f/0x90=0D
[   33.601175]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.601499]  ? __pfx_perf_release+0x10/0x10=0D
[   33.601834]  perf_release+0x40/0x50=0D
[   33.602233]  __fput+0x26d/0xa40=0D
[   33.602569]  ____fput+0x1e/0x30=0D
[   33.602851]  task_work_run+0x1a4/0x2d0=0D
[   33.603180]  ? write_comp_data+0x2f/0x90=0D
[   33.603526]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.603863]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.604212]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.604577]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.604995]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.605384]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.605763]  do_syscall_64+0x4a/0x90=0D
[   33.606082]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.606488] RIP: 0033:0x7f3840f1059d=0D
[   33.606785] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.608182] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.608770] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.609329] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.609883] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.610432] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.610965] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.611498]  </TASK>=0D
[   33.656615] FAULT_INJECTION: forcing a failure.=0D
[   33.656615] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.657464] CPU: 0 PID: 555 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.658091] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.658878] Call Trace:=0D
[   33.659067]  <TASK>=0D
[   33.659223]  dump_stack_lvl+0xa7/0xdb=0D
[   33.659533]  dump_stack+0x19/0x1f=0D
[   33.659815]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.660177]  __should_failslab+0xca/0x120=0D
[   33.660516]  should_failslab+0x12/0x30=0D
[   33.660824]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.661198]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.661555]  kmalloc_trace+0x2e/0x120=0D
[   33.661881]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.662222]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.662697]  ? write_comp_data+0x2f/0x90=0D
[   33.663050]  ftrace_set_hash+0x445/0x590=0D
[   33.663411]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.663779]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.664168]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.664447]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.664764]  ? write_comp_data+0x2f/0x90=0D
[   33.665041]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.665382]  disarm_kprobe+0x24a/0x2d0=0D
[   33.665641]  __disable_kprobe+0x2de/0x4b0=0D
[   33.665976]  disable_kprobe+0x31/0x80=0D
[   33.666291]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.666672]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.667020]  kprobe_register+0x4e/0xf0=0D
[   33.667370]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.667801]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.668158]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.668618]  _free_event+0x220/0x11c0=0D
[   33.668936]  put_event+0x4d/0x60=0D
[   33.669203]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.669531]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.669905]  ? write_comp_data+0x2f/0x90=0D
[   33.670253]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.670587]  ? __pfx_perf_release+0x10/0x10=0D
[   33.670877]  perf_release+0x40/0x50=0D
[   33.671124]  __fput+0x26d/0xa40=0D
[   33.671418]  ____fput+0x1e/0x30=0D
[   33.671658]  task_work_run+0x1a4/0x2d0=0D
[   33.671938]  ? write_comp_data+0x2f/0x90=0D
[   33.672221]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.672513]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.672831]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.673125]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.673480]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.673839]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.674172]  do_syscall_64+0x4a/0x90=0D
[   33.674488]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.674867] RIP: 0033:0x7f3840f1059d=0D
[   33.675109] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.676330] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.676813] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.677272] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.677725] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.678272] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.678747] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.679243]  </TASK>=0D
[   33.731792] FAULT_INJECTION: forcing a failure.=0D
[   33.731792] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.732548] CPU: 1 PID: 556 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.733123] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.733884] Call Trace:=0D
[   33.734055]  <TASK>=0D
[   33.734206]  dump_stack_lvl+0xa7/0xdb=0D
[   33.734502]  dump_stack+0x19/0x1f=0D
[   33.734751]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.735089]  __should_failslab+0xca/0x120=0D
[   33.735375]  should_failslab+0x12/0x30=0D
[   33.735637]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.735950]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.736299]  kmalloc_trace+0x2e/0x120=0D
[   33.736563]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.736842]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.737257]  ? write_comp_data+0x2f/0x90=0D
[   33.737541]  ftrace_set_hash+0x445/0x590=0D
[   33.737841]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.738181]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.738523]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.738830]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.739156]  ? write_comp_data+0x2f/0x90=0D
[   33.739454]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.739804]  disarm_kprobe+0x24a/0x2d0=0D
[   33.740070]  __disable_kprobe+0x2de/0x4b0=0D
[   33.740364]  disable_kprobe+0x31/0x80=0D
[   33.740628]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.740942]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.741247]  kprobe_register+0x4e/0xf0=0D
[   33.741528]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.741898]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.742216]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.742578]  _free_event+0x220/0x11c0=0D
[   33.742870]  put_event+0x4d/0x60=0D
[   33.743113]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.743467]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.743854]  ? write_comp_data+0x2f/0x90=0D
[   33.744145]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.744491]  ? __pfx_perf_release+0x10/0x10=0D
[   33.744806]  perf_release+0x40/0x50=0D
[   33.745065]  __fput+0x26d/0xa40=0D
[   33.745318]  ____fput+0x1e/0x30=0D
[   33.745551]  task_work_run+0x1a4/0x2d0=0D
[   33.745841]  ? write_comp_data+0x2f/0x90=0D
[   33.746137]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.746450]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.746798]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.747124]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.747480]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.747818]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.748162]  do_syscall_64+0x4a/0x90=0D
[   33.748430]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.748782] RIP: 0033:0x7f3840f1059d=0D
[   33.749052] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.750266] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.750764] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.751232] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.751691] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.752153] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.752621] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.753103]  </TASK>=0D
[   33.788071] FAULT_INJECTION: forcing a failure.=0D
[   33.788071] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.788793] CPU: 0 PID: 557 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.789322] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.790017] Call Trace:=0D
[   33.790179]  <TASK>=0D
[   33.790325]  dump_stack_lvl+0xa7/0xdb=0D
[   33.790579]  dump_stack+0x19/0x1f=0D
[   33.790807]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.791090]  __should_failslab+0xca/0x120=0D
[   33.791359]  should_failslab+0x12/0x30=0D
[   33.791608]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.791907]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.792189]  kmalloc_trace+0x2e/0x120=0D
[   33.792437]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.792698]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.793065]  ? write_comp_data+0x2f/0x90=0D
[   33.793331]  ftrace_set_hash+0x445/0x590=0D
[   33.793603]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.793892]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.794202]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.794469]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.794771]  ? write_comp_data+0x2f/0x90=0D
[   33.795036]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.795361]  disarm_kprobe+0x24a/0x2d0=0D
[   33.795608]  __disable_kprobe+0x2de/0x4b0=0D
[   33.795871]  disable_kprobe+0x31/0x80=0D
[   33.796111]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.796416]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.796702]  kprobe_register+0x4e/0xf0=0D
[   33.796950]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.797278]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.797549]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.797859]  _free_event+0x220/0x11c0=0D
[   33.798111]  put_event+0x4d/0x60=0D
[   33.798329]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.798642]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.798973]  ? write_comp_data+0x2f/0x90=0D
[   33.799246]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.799580]  ? __pfx_perf_release+0x10/0x10=0D
[   33.799893]  perf_release+0x40/0x50=0D
[   33.800125]  __fput+0x26d/0xa40=0D
[   33.800352]  ____fput+0x1e/0x30=0D
[   33.800565]  task_work_run+0x1a4/0x2d0=0D
[   33.800812]  ? write_comp_data+0x2f/0x90=0D
[   33.801075]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.801351]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.801653]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.801933]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.802249]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.802550]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.802847]  do_syscall_64+0x4a/0x90=0D
[   33.803083]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.803407] RIP: 0033:0x7f3840f1059d=0D
[   33.803645] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.804744] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.805212] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.805648] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.806094] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.806532] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.806972] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.807434]  </TASK>=0D
[   33.868197] FAULT_INJECTION: forcing a failure.=0D
[   33.868197] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.869243] CPU: 0 PID: 558 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.869950] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.870870] Call Trace:=0D
[   33.871097]  <TASK>=0D
[   33.871290]  dump_stack_lvl+0xa7/0xdb=0D
[   33.871654]  dump_stack+0x19/0x1f=0D
[   33.871969]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.872367]  __should_failslab+0xca/0x120=0D
[   33.872744]  should_failslab+0x12/0x30=0D
[   33.873091]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.873508]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.873967]  kmalloc_trace+0x2e/0x120=0D
[   33.874234]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.874511]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.874897]  ? write_comp_data+0x2f/0x90=0D
[   33.875176]  ftrace_set_hash+0x445/0x590=0D
[   33.875441]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.875744]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.876071]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.876350]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.876669]  ? write_comp_data+0x2f/0x90=0D
[   33.876946]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.877288]  disarm_kprobe+0x24a/0x2d0=0D
[   33.877532]  __disable_kprobe+0x2de/0x4b0=0D
[   33.877815]  disable_kprobe+0x31/0x80=0D
[   33.878070]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.878358]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.878656]  kprobe_register+0x4e/0xf0=0D
[   33.878916]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.879257]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.879543]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.879865]  _free_event+0x220/0x11c0=0D
[   33.880130]  put_event+0x4d/0x60=0D
[   33.880360]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.880690]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.881039]  ? write_comp_data+0x2f/0x90=0D
[   33.881314]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.881640]  ? __pfx_perf_release+0x10/0x10=0D
[   33.881926]  perf_release+0x40/0x50=0D
[   33.882151]  __fput+0x26d/0xa40=0D
[   33.882389]  ____fput+0x1e/0x30=0D
[   33.882612]  task_work_run+0x1a4/0x2d0=0D
[   33.882875]  ? write_comp_data+0x2f/0x90=0D
[   33.883153]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.883446]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.883764]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.884053]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.884381]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.884692]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.885006]  do_syscall_64+0x4a/0x90=0D
[   33.885257]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.885593] RIP: 0033:0x7f3840f1059d=0D
[   33.885848] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.887002] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.887494] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.887952] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.888411] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.888867] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.889325] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.889830]  </TASK>=0D
[   33.932288] FAULT_INJECTION: forcing a failure.=0D
[   33.932288] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   33.933034] CPU: 0 PID: 559 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   33.933572] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   33.934275] Call Trace:=0D
[   33.934440]  <TASK>=0D
[   33.934587]  dump_stack_lvl+0xa7/0xdb=0D
[   33.934846]  dump_stack+0x19/0x1f=0D
[   33.935073]  should_fail_ex.cold.5+0x5/0xa=0D
[   33.935359]  __should_failslab+0xca/0x120=0D
[   33.935631]  should_failslab+0x12/0x30=0D
[   33.935882]  __kmem_cache_alloc_node+0x62/0x280=0D
[   33.936186]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   33.936472]  kmalloc_trace+0x2e/0x120=0D
[   33.936715]  alloc_ftrace_hash+0x4f/0x170=0D
[   33.936981]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   33.937354]  ? write_comp_data+0x2f/0x90=0D
[   33.937622]  ftrace_set_hash+0x445/0x590=0D
[   33.937905]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   33.938175]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   33.938478]  ? match_dev_by_uuid+0x4/0x100=0D
[   33.938726]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.939007]  ? write_comp_data+0x2f/0x90=0D
[   33.939255]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   33.939557]  disarm_kprobe+0x24a/0x2d0=0D
[   33.939789]  __disable_kprobe+0x2de/0x4b0=0D
[   33.940035]  disable_kprobe+0x31/0x80=0D
[   33.940259]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   33.940533]  disable_trace_kprobe+0x1f0/0x300=0D
[   33.940799]  kprobe_register+0x4e/0xf0=0D
[   33.941032]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   33.941345]  perf_kprobe_destroy+0xcb/0x200=0D
[   33.941599]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   33.941947]  _free_event+0x220/0x11c0=0D
[   33.942182]  put_event+0x4d/0x60=0D
[   33.942386]  perf_event_release_kernel+0x5d9/0x860=0D
[   33.942679]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   33.942988]  ? write_comp_data+0x2f/0x90=0D
[   33.943232]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   33.943525]  ? __pfx_perf_release+0x10/0x10=0D
[   33.943778]  perf_release+0x40/0x50=0D
[   33.943998]  __fput+0x26d/0xa40=0D
[   33.944218]  ____fput+0x1e/0x30=0D
[   33.944422]  task_work_run+0x1a4/0x2d0=0D
[   33.944658]  ? write_comp_data+0x2f/0x90=0D
[   33.944909]  ? __pfx_task_work_run+0x10/0x10=0D
[   33.945165]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   33.945445]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   33.945701]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   33.946016]  exit_to_user_mode_prepare+0x200/0x210=0D
[   33.946319]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   33.946618]  do_syscall_64+0x4a/0x90=0D
[   33.946857]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   33.947182] RIP: 0033:0x7f3840f1059d=0D
[   33.947421] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   33.948529] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   33.949003] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   33.949442] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   33.949892] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   33.950345] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   33.950784] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   33.951251]  </TASK>=0D
[   34.009495] FAULT_INJECTION: forcing a failure.=0D
[   34.009495] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.010456] CPU: 1 PID: 560 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.011164] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.012074] Call Trace:=0D
[   34.012295]  <TASK>=0D
[   34.012495]  dump_stack_lvl+0xa7/0xdb=0D
[   34.012843]  dump_stack+0x19/0x1f=0D
[   34.013150]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.013535]  __should_failslab+0xca/0x120=0D
[   34.013911]  should_failslab+0x12/0x30=0D
[   34.014240]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.014646]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.015031]  kmalloc_trace+0x2e/0x120=0D
[   34.015356]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.015721]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.016221]  ? write_comp_data+0x2f/0x90=0D
[   34.016608]  ftrace_set_hash+0x445/0x590=0D
[   34.017000]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.017393]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.017836]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.018203]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.018634]  ? write_comp_data+0x2f/0x90=0D
[   34.019009]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.019459]  disarm_kprobe+0x24a/0x2d0=0D
[   34.019815]  __disable_kprobe+0x2de/0x4b0=0D
[   34.020197]  disable_kprobe+0x31/0x80=0D
[   34.020535]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.020946]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.021343]  kprobe_register+0x4e/0xf0=0D
[   34.021692]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.022168]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.022552]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.022972]  _free_event+0x220/0x11c0=0D
[   34.023313]  put_event+0x4d/0x60=0D
[   34.023606]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.024037]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.024479]  ? write_comp_data+0x2f/0x90=0D
[   34.024846]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.025271]  ? __pfx_perf_release+0x10/0x10=0D
[   34.025632]  perf_release+0x40/0x50=0D
[   34.025955]  __fput+0x26d/0xa40=0D
[   34.026273]  ____fput+0x1e/0x30=0D
[   34.026560]  task_work_run+0x1a4/0x2d0=0D
[   34.026880]  ? write_comp_data+0x2f/0x90=0D
[   34.027222]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.027588]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.028003]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.028383]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.028808]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.029208]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.029604]  do_syscall_64+0x4a/0x90=0D
[   34.029904]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.030225] RIP: 0033:0x7f3840f1059d=0D
[   34.030460] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.031541] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.031995] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.032420] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.032846] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.033271] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.033694] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.034155]  </TASK>=0D
[   34.064624] FAULT_INJECTION: forcing a failure.=0D
[   34.064624] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.065483] CPU: 0 PID: 561 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.066069] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.066794] Call Trace:=0D
[   34.066969]  <TASK>=0D
[   34.067126]  dump_stack_lvl+0xa7/0xdb=0D
[   34.067394]  dump_stack+0x19/0x1f=0D
[   34.067633]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.067932]  __should_failslab+0xca/0x120=0D
[   34.068249]  should_failslab+0x12/0x30=0D
[   34.068562]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.068860]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.069165]  kmalloc_trace+0x2e/0x120=0D
[   34.069422]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.069704]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.070244]  ? write_comp_data+0x2f/0x90=0D
[   34.070532]  ftrace_set_hash+0x445/0x590=0D
[   34.070828]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.071138]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.071477]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.071767]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.072100]  ? write_comp_data+0x2f/0x90=0D
[   34.072388]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.072742]  disarm_kprobe+0x24a/0x2d0=0D
[   34.073013]  __disable_kprobe+0x2de/0x4b0=0D
[   34.073301]  disable_kprobe+0x31/0x80=0D
[   34.073563]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.073886]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.074199]  kprobe_register+0x4e/0xf0=0D
[   34.074471]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.074830]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.075131]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.075475]  _free_event+0x220/0x11c0=0D
[   34.075752]  put_event+0x4d/0x60=0D
[   34.075991]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.076337]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.076705]  ? write_comp_data+0x2f/0x90=0D
[   34.076992]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.077335]  ? __pfx_perf_release+0x10/0x10=0D
[   34.077630]  perf_release+0x40/0x50=0D
[   34.077891]  __fput+0x26d/0xa40=0D
[   34.078138]  ____fput+0x1e/0x30=0D
[   34.078368]  task_work_run+0x1a4/0x2d0=0D
[   34.078642]  ? write_comp_data+0x2f/0x90=0D
[   34.078931]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.079233]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.079566]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.079873]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.080222]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.080558]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.080887]  do_syscall_64+0x4a/0x90=0D
[   34.081146]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.081493] RIP: 0033:0x7f3840f1059d=0D
[   34.081745] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.082934] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.083440] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.083909] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.084375] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.084852] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.085322] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.085822]  </TASK>=0D
[   34.136521] FAULT_INJECTION: forcing a failure.=0D
[   34.136521] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.137443] CPU: 0 PID: 562 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.138052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.138750] Call Trace:=0D
[   34.138908]  <TASK>=0D
[   34.139048]  dump_stack_lvl+0xa7/0xdb=0D
[   34.139315]  dump_stack+0x19/0x1f=0D
[   34.139533]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.139807]  __should_failslab+0xca/0x120=0D
[   34.140068]  should_failslab+0x12/0x30=0D
[   34.140310]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.140599]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.140874]  kmalloc_trace+0x2e/0x120=0D
[   34.141113]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.141373]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.141741]  ? write_comp_data+0x2f/0x90=0D
[   34.142012]  ftrace_set_hash+0x445/0x590=0D
[   34.142286]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.142570]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.142883]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.143153]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.143455]  ? write_comp_data+0x2f/0x90=0D
[   34.143720]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.144044]  disarm_kprobe+0x24a/0x2d0=0D
[   34.144291]  __disable_kprobe+0x2de/0x4b0=0D
[   34.144553]  disable_kprobe+0x31/0x80=0D
[   34.144794]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.145086]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.145370]  kprobe_register+0x4e/0xf0=0D
[   34.145620]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.145956]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.146228]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.146536]  _free_event+0x220/0x11c0=0D
[   34.146791]  put_event+0x4d/0x60=0D
[   34.147009]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.147320]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.147656]  ? write_comp_data+0x2f/0x90=0D
[   34.147920]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.148233]  ? __pfx_perf_release+0x10/0x10=0D
[   34.148506]  perf_release+0x40/0x50=0D
[   34.148748]  __fput+0x26d/0xa40=0D
[   34.148978]  ____fput+0x1e/0x30=0D
[   34.149194]  task_work_run+0x1a4/0x2d0=0D
[   34.149445]  ? write_comp_data+0x2f/0x90=0D
[   34.149714]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.150013]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.150329]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.150621]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.150948]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.151263]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.151568]  do_syscall_64+0x4a/0x90=0D
[   34.151814]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.152142] RIP: 0033:0x7f3840f1059d=0D
[   34.152383] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.153491] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.153970] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.154410] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.154845] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.155280] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.155718] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.156180]  </TASK>=0D
[   34.204084] FAULT_INJECTION: forcing a failure.=0D
[   34.204084] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.204802] CPU: 0 PID: 563 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.205322] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.206009] Call Trace:=0D
[   34.206171]  <TASK>=0D
[   34.206314]  dump_stack_lvl+0xa7/0xdb=0D
[   34.206577]  dump_stack+0x19/0x1f=0D
[   34.206850]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.207190]  __should_failslab+0xca/0x120=0D
[   34.207517]  should_failslab+0x12/0x30=0D
[   34.207821]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.208183]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.208523]  kmalloc_trace+0x2e/0x120=0D
[   34.208822]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.209144]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.209608]  ? write_comp_data+0x2f/0x90=0D
[   34.209946]  ftrace_set_hash+0x445/0x590=0D
[   34.210283]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.210636]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.211023]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.211358]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.211736]  ? write_comp_data+0x2f/0x90=0D
[   34.212073]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.212495]  disarm_kprobe+0x24a/0x2d0=0D
[   34.212804]  __disable_kprobe+0x2de/0x4b0=0D
[   34.213143]  disable_kprobe+0x31/0x80=0D
[   34.213454]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.213839]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.214203]  kprobe_register+0x4e/0xf0=0D
[   34.214525]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.214877]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.215180]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.215502]  _free_event+0x220/0x11c0=0D
[   34.215762]  put_event+0x4d/0x60=0D
[   34.215987]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.216312]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.216655]  ? write_comp_data+0x2f/0x90=0D
[   34.216926]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.217248]  ? __pfx_perf_release+0x10/0x10=0D
[   34.217527]  perf_release+0x40/0x50=0D
[   34.217768]  __fput+0x26d/0xa40=0D
[   34.218024]  ____fput+0x1e/0x30=0D
[   34.218254]  task_work_run+0x1a4/0x2d0=0D
[   34.218520]  ? write_comp_data+0x2f/0x90=0D
[   34.218802]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.219098]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.219422]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.219723]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.220059]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.220398]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.220731]  do_syscall_64+0x4a/0x90=0D
[   34.220986]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.221326] RIP: 0033:0x7f3840f1059d=0D
[   34.221574] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.222726] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.223321] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.223775] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.224247] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.224735] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.225183] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.225657]  </TASK>=0D
[   34.273469] FAULT_INJECTION: forcing a failure.=0D
[   34.273469] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.274485] CPU: 0 PID: 564 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.275233] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.276193] Call Trace:=0D
[   34.276422]  <TASK>=0D
[   34.276627]  dump_stack_lvl+0xa7/0xdb=0D
[   34.276978]  dump_stack+0x19/0x1f=0D
[   34.277300]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.277700]  __should_failslab+0xca/0x120=0D
[   34.278049]  should_failslab+0x12/0x30=0D
[   34.278363]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.278754]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.279126]  kmalloc_trace+0x2e/0x120=0D
[   34.279451]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.279828]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.280383]  ? write_comp_data+0x2f/0x90=0D
[   34.280792]  ftrace_set_hash+0x445/0x590=0D
[   34.281212]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.281649]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.282124]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.282525]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.282980]  ? write_comp_data+0x2f/0x90=0D
[   34.283376]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.283850]  disarm_kprobe+0x24a/0x2d0=0D
[   34.284215]  __disable_kprobe+0x2de/0x4b0=0D
[   34.284621]  disable_kprobe+0x31/0x80=0D
[   34.284973]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.285398]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.285813]  kprobe_register+0x4e/0xf0=0D
[   34.286091]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.286486]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.286788]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.287224]  _free_event+0x220/0x11c0=0D
[   34.287572]  put_event+0x4d/0x60=0D
[   34.287874]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.288327]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.288783]  ? write_comp_data+0x2f/0x90=0D
[   34.289153]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.289591]  ? __pfx_perf_release+0x10/0x10=0D
[   34.290024]  perf_release+0x40/0x50=0D
[   34.290332]  __fput+0x26d/0xa40=0D
[   34.290636]  ____fput+0x1e/0x30=0D
[   34.290907]  task_work_run+0x1a4/0x2d0=0D
[   34.291241]  ? write_comp_data+0x2f/0x90=0D
[   34.291586]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.291879]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.292205]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.292503]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.292842]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.293165]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.293565]  do_syscall_64+0x4a/0x90=0D
[   34.293887]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.294309] RIP: 0033:0x7f3840f1059d=0D
[   34.294617] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.296066] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.296694] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.297259] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.297835] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.298403] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.298970] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.299567]  </TASK>=0D
[   34.345550] FAULT_INJECTION: forcing a failure.=0D
[   34.345550] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.346370] CPU: 0 PID: 565 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.347020] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.347914] Call Trace:=0D
[   34.348122]  <TASK>=0D
[   34.348308]  dump_stack_lvl+0xa7/0xdb=0D
[   34.348635]  dump_stack+0x19/0x1f=0D
[   34.348922]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.349282]  __should_failslab+0xca/0x120=0D
[   34.349625]  should_failslab+0x12/0x30=0D
[   34.349950]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.350333]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.350694]  kmalloc_trace+0x2e/0x120=0D
[   34.351010]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.351354]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.351843]  ? write_comp_data+0x2f/0x90=0D
[   34.352190]  ftrace_set_hash+0x445/0x590=0D
[   34.352546]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.352919]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.353332]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.353687]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.354090]  ? write_comp_data+0x2f/0x90=0D
[   34.354440]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.354872]  disarm_kprobe+0x24a/0x2d0=0D
[   34.355199]  __disable_kprobe+0x2de/0x4b0=0D
[   34.355548]  disable_kprobe+0x31/0x80=0D
[   34.355866]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.356253]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.356630]  kprobe_register+0x4e/0xf0=0D
[   34.356957]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.357389]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.357749]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.358150]  _free_event+0x220/0x11c0=0D
[   34.358420]  put_event+0x4d/0x60=0D
[   34.358651]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.358986]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.359341]  ? write_comp_data+0x2f/0x90=0D
[   34.359621]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.359956]  ? __pfx_perf_release+0x10/0x10=0D
[   34.360242]  perf_release+0x40/0x50=0D
[   34.360488]  __fput+0x26d/0xa40=0D
[   34.360730]  ____fput+0x1e/0x30=0D
[   34.360955]  task_work_run+0x1a4/0x2d0=0D
[   34.361217]  ? write_comp_data+0x2f/0x90=0D
[   34.361496]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.361797]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.362118]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.362417]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.362754]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.363075]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.363392]  do_syscall_64+0x4a/0x90=0D
[   34.363645]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.363980] RIP: 0033:0x7f3840f1059d=0D
[   34.364227] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.365368] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.365857] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.366308] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.366760] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.367210] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.367661] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.368140]  </TASK>=0D
[   34.406567] FAULT_INJECTION: forcing a failure.=0D
[   34.406567] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.407494] CPU: 1 PID: 566 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.408043] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.408751] Call Trace:=0D
[   34.408919]  <TASK>=0D
[   34.409069]  dump_stack_lvl+0xa7/0xdb=0D
[   34.409334]  dump_stack+0x19/0x1f=0D
[   34.409565]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.409872]  __should_failslab+0xca/0x120=0D
[   34.410155]  should_failslab+0x12/0x30=0D
[   34.410411]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.410731]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.411024]  kmalloc_trace+0x2e/0x120=0D
[   34.411280]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.411559]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.411962]  ? write_comp_data+0x2f/0x90=0D
[   34.412247]  ftrace_set_hash+0x445/0x590=0D
[   34.412538]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.412839]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.413173]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.413461]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.413792]  ? write_comp_data+0x2f/0x90=0D
[   34.414075]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.414422]  disarm_kprobe+0x24a/0x2d0=0D
[   34.414686]  __disable_kprobe+0x2de/0x4b0=0D
[   34.414968]  disable_kprobe+0x31/0x80=0D
[   34.415226]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.415537]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.415839]  kprobe_register+0x4e/0xf0=0D
[   34.416105]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.416452]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.416744]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.417086]  _free_event+0x220/0x11c0=0D
[   34.417360]  put_event+0x4d/0x60=0D
[   34.417593]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.417934]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.418290]  ? write_comp_data+0x2f/0x90=0D
[   34.418569]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.418902]  ? __pfx_perf_release+0x10/0x10=0D
[   34.419185]  perf_release+0x40/0x50=0D
[   34.419426]  __fput+0x26d/0xa40=0D
[   34.419661]  ____fput+0x1e/0x30=0D
[   34.419880]  task_work_run+0x1a4/0x2d0=0D
[   34.420138]  ? write_comp_data+0x2f/0x90=0D
[   34.420413]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.420705]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.421017]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.421305]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.421632]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.421958]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.422267]  do_syscall_64+0x4a/0x90=0D
[   34.422515]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.422850] RIP: 0033:0x7f3840f1059d=0D
[   34.423111] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.424251] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.424722] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.425158] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.425598] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.426046] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.426483] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.426946]  </TASK>=0D
[   34.476893] FAULT_INJECTION: forcing a failure.=0D
[   34.476893] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.477845] CPU: 0 PID: 567 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.478549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.479497] Call Trace:=0D
[   34.479723]  <TASK>=0D
[   34.479920]  dump_stack_lvl+0xa7/0xdb=0D
[   34.480261]  dump_stack+0x19/0x1f=0D
[   34.480568]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.480957]  __should_failslab+0xca/0x120=0D
[   34.481330]  should_failslab+0x12/0x30=0D
[   34.481672]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.482078]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.482475]  kmalloc_trace+0x2e/0x120=0D
[   34.482821]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.483203]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.483733]  ? write_comp_data+0x2f/0x90=0D
[   34.484119]  ftrace_set_hash+0x445/0x590=0D
[   34.484497]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.484923]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.485374]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.485761]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.486679]  ? write_comp_data+0x2f/0x90=0D
[   34.487299]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.488071]  disarm_kprobe+0x24a/0x2d0=0D
[   34.488654]  __disable_kprobe+0x2de/0x4b0=0D
[   34.489270]  disable_kprobe+0x31/0x80=0D
[   34.489849]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.490537]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.491181]  kprobe_register+0x4e/0xf0=0D
[   34.491747]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.492493]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.493113]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.493818]  _free_event+0x220/0x11c0=0D
[   34.494407]  put_event+0x4d/0x60=0D
[   34.494902]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.495611]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.496372]  ? write_comp_data+0x2f/0x90=0D
[   34.496967]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.497673]  ? __pfx_perf_release+0x10/0x10=0D
[   34.498304]  perf_release+0x40/0x50=0D
[   34.498834]  __fput+0x26d/0xa40=0D
[   34.499333]  ____fput+0x1e/0x30=0D
[   34.499820]  task_work_run+0x1a4/0x2d0=0D
[   34.500392]  ? write_comp_data+0x2f/0x90=0D
[   34.500980]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.501609]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.502310]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.502975]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.503726]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.504457]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.505164]  do_syscall_64+0x4a/0x90=0D
[   34.505721]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.506445] RIP: 0033:0x7f3840f1059d=0D
[   34.506991] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.509491] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.510552] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.511543] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.512524] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.513507] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.514501] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.515514]  </TASK>=0D
[   34.561071] FAULT_INJECTION: forcing a failure.=0D
[   34.561071] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.562703] CPU: 0 PID: 568 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.563885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.565423] Call Trace:=0D
[   34.565807]  <TASK>=0D
[   34.566140]  dump_stack_lvl+0xa7/0xdb=0D
[   34.566713]  dump_stack+0x19/0x1f=0D
[   34.567223]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.567850]  __should_failslab+0xca/0x120=0D
[   34.568459]  should_failslab+0x12/0x30=0D
[   34.569026]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.569706]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.570351]  kmalloc_trace+0x2e/0x120=0D
[   34.570917]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.571535]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.572404]  ? write_comp_data+0x2f/0x90=0D
[   34.573018]  ftrace_set_hash+0x445/0x590=0D
[   34.573639]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.574307]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.575037]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.575664]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.576374]  ? write_comp_data+0x2f/0x90=0D
[   34.577027]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.577905]  disarm_kprobe+0x24a/0x2d0=0D
[   34.578555]  __disable_kprobe+0x2de/0x4b0=0D
[   34.579247]  disable_kprobe+0x31/0x80=0D
[   34.579891]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.580667]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.581426]  kprobe_register+0x4e/0xf0=0D
[   34.582094]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.582954]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.583675]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.584498]  _free_event+0x220/0x11c0=0D
[   34.585155]  put_event+0x4d/0x60=0D
[   34.585726]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.586230]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.586669]  ? write_comp_data+0x2f/0x90=0D
[   34.587003]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.587401]  ? __pfx_perf_release+0x10/0x10=0D
[   34.587745]  perf_release+0x40/0x50=0D
[   34.588042]  __fput+0x26d/0xa40=0D
[   34.588327]  ____fput+0x1e/0x30=0D
[   34.588599]  task_work_run+0x1a4/0x2d0=0D
[   34.588916]  ? write_comp_data+0x2f/0x90=0D
[   34.589253]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.589610]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.590007]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.590369]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.590776]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.591168]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.591555]  do_syscall_64+0x4a/0x90=0D
[   34.591862]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.592294] RIP: 0033:0x7f3840f1059d=0D
[   34.592593] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.594060] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.594692] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.595264] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.595835] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.596405] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.596976] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.597574]  </TASK>=0D
[   34.675472] FAULT_INJECTION: forcing a failure.=0D
[   34.675472] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.677055] CPU: 0 PID: 569 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.678057] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.678772] Call Trace:=0D
[   34.678938]  <TASK>=0D
[   34.679088]  dump_stack_lvl+0xa7/0xdb=0D
[   34.679349]  dump_stack+0x19/0x1f=0D
[   34.679578]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.679864]  __should_failslab+0xca/0x120=0D
[   34.680138]  should_failslab+0x12/0x30=0D
[   34.680392]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.680697]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.680989]  kmalloc_trace+0x2e/0x120=0D
[   34.681255]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.681547]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.681953]  ? write_comp_data+0x2f/0x90=0D
[   34.682241]  ftrace_set_hash+0x445/0x590=0D
[   34.682536]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.682846]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.683186]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.683484]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.683818]  ? write_comp_data+0x2f/0x90=0D
[   34.684111]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.684467]  disarm_kprobe+0x24a/0x2d0=0D
[   34.684739]  __disable_kprobe+0x2de/0x4b0=0D
[   34.685028]  disable_kprobe+0x31/0x80=0D
[   34.685293]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.685613]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.685935]  kprobe_register+0x4e/0xf0=0D
[   34.686205]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.686561]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.686860]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.687198]  _free_event+0x220/0x11c0=0D
[   34.687471]  put_event+0x4d/0x60=0D
[   34.687709]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.688049]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.688412]  ? write_comp_data+0x2f/0x90=0D
[   34.688698]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.689035]  ? __pfx_perf_release+0x10/0x10=0D
[   34.689328]  perf_release+0x40/0x50=0D
[   34.689579]  __fput+0x26d/0xa40=0D
[   34.689831]  ____fput+0x1e/0x30=0D
[   34.690064]  task_work_run+0x1a4/0x2d0=0D
[   34.690337]  ? write_comp_data+0x2f/0x90=0D
[   34.690632]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.690943]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.691284]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.691590]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.691940]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.692275]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.692606]  do_syscall_64+0x4a/0x90=0D
[   34.692879]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.693241] RIP: 0033:0x7f3840f1059d=0D
[   34.693493] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.694646] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.695131] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.695583] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.696035] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.696486] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.696940] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.697417]  </TASK>=0D
[   34.737752] FAULT_INJECTION: forcing a failure.=0D
[   34.737752] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.738492] CPU: 0 PID: 570 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.739031] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.739722] Call Trace:=0D
[   34.739886]  <TASK>=0D
[   34.740034]  dump_stack_lvl+0xa7/0xdb=0D
[   34.740298]  dump_stack+0x19/0x1f=0D
[   34.740526]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.740810]  __should_failslab+0xca/0x120=0D
[   34.741083]  should_failslab+0x12/0x30=0D
[   34.741335]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.741637]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.741929]  kmalloc_trace+0x2e/0x120=0D
[   34.742179]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.742451]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.742834]  ? write_comp_data+0x2f/0x90=0D
[   34.743111]  ftrace_set_hash+0x445/0x590=0D
[   34.743397]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.743692]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.744016]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.744293]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.744608]  ? write_comp_data+0x2f/0x90=0D
[   34.744883]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.745222]  disarm_kprobe+0x24a/0x2d0=0D
[   34.745480]  __disable_kprobe+0x2de/0x4b0=0D
[   34.745755]  disable_kprobe+0x31/0x80=0D
[   34.746013]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.746315]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.746609]  kprobe_register+0x4e/0xf0=0D
[   34.746867]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.747211]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.747497]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.747816]  _free_event+0x220/0x11c0=0D
[   34.748078]  put_event+0x4d/0x60=0D
[   34.748305]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.748631]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.748975]  ? write_comp_data+0x2f/0x90=0D
[   34.749247]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.749566]  ? __pfx_perf_release+0x10/0x10=0D
[   34.749850]  perf_release+0x40/0x50=0D
[   34.750096]  __fput+0x26d/0xa40=0D
[   34.750336]  ____fput+0x1e/0x30=0D
[   34.750558]  task_work_run+0x1a4/0x2d0=0D
[   34.750819]  ? write_comp_data+0x2f/0x90=0D
[   34.751092]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.751383]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.751702]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.751998]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.752332]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.752650]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.752963]  do_syscall_64+0x4a/0x90=0D
[   34.753212]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.753543] RIP: 0033:0x7f3840f1059d=0D
[   34.753788] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.755040] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.755520] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.755967] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.756414] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.756860] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.757304] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.757774]  </TASK>=0D
[   34.813214] FAULT_INJECTION: forcing a failure.=0D
[   34.813214] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.814072] CPU: 0 PID: 571 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.814582] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.815242] Call Trace:=0D
[   34.815399]  <TASK>=0D
[   34.815540]  dump_stack_lvl+0xa7/0xdb=0D
[   34.815785]  dump_stack+0x19/0x1f=0D
[   34.816003]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.816276]  __should_failslab+0xca/0x120=0D
[   34.816533]  should_failslab+0x12/0x30=0D
[   34.816773]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.817065]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.817337]  kmalloc_trace+0x2e/0x120=0D
[   34.817575]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.817883]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.818314]  ? write_comp_data+0x2f/0x90=0D
[   34.818578]  ftrace_set_hash+0x445/0x590=0D
[   34.818851]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.819178]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.819547]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.819809]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.820126]  ? write_comp_data+0x2f/0x90=0D
[   34.820399]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.820734]  disarm_kprobe+0x24a/0x2d0=0D
[   34.820988]  __disable_kprobe+0x2de/0x4b0=0D
[   34.821254]  disable_kprobe+0x31/0x80=0D
[   34.821498]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.821803]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.822088]  kprobe_register+0x4e/0xf0=0D
[   34.822339]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.822668]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.822941]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.823250]  _free_event+0x220/0x11c0=0D
[   34.823503]  put_event+0x4d/0x60=0D
[   34.823722]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.824035]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.824368]  ? write_comp_data+0x2f/0x90=0D
[   34.824630]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.824941]  ? __pfx_perf_release+0x10/0x10=0D
[   34.825211]  perf_release+0x40/0x50=0D
[   34.825443]  __fput+0x26d/0xa40=0D
[   34.825671]  ____fput+0x1e/0x30=0D
[   34.825894]  task_work_run+0x1a4/0x2d0=0D
[   34.826141]  ? write_comp_data+0x2f/0x90=0D
[   34.826404]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.826682]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.826990]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.827270]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.827590]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.827894]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.828193]  do_syscall_64+0x4a/0x90=0D
[   34.828432]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.828751] RIP: 0033:0x7f3840f1059d=0D
[   34.828985] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.830092] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.830569] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.831009] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.831447] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.831886] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.832325] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.832791]  </TASK>=0D
[   34.877795] FAULT_INJECTION: forcing a failure.=0D
[   34.877795] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.878850] CPU: 0 PID: 572 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.879591] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.880517] Call Trace:=0D
[   34.880744]  <TASK>=0D
[   34.880943]  dump_stack_lvl+0xa7/0xdb=0D
[   34.881287]  dump_stack+0x19/0x1f=0D
[   34.881592]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.882000]  __should_failslab+0xca/0x120=0D
[   34.882375]  should_failslab+0x12/0x30=0D
[   34.882718]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.883139]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.883535]  kmalloc_trace+0x2e/0x120=0D
[   34.883886]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.884273]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.884829]  ? write_comp_data+0x2f/0x90=0D
[   34.885233]  ftrace_set_hash+0x445/0x590=0D
[   34.885633]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.886002]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.886338]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.886627]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.886955]  ? write_comp_data+0x2f/0x90=0D
[   34.887239]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.887592]  disarm_kprobe+0x24a/0x2d0=0D
[   34.887860]  __disable_kprobe+0x2de/0x4b0=0D
[   34.888143]  disable_kprobe+0x31/0x80=0D
[   34.888404]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.888721]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.889026]  kprobe_register+0x4e/0xf0=0D
[   34.889294]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.889642]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.889941]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.890274]  _free_event+0x220/0x11c0=0D
[   34.890543]  put_event+0x4d/0x60=0D
[   34.890778]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.891115]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.891470]  ? write_comp_data+0x2f/0x90=0D
[   34.891771]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.892110]  ? __pfx_perf_release+0x10/0x10=0D
[   34.892465]  perf_release+0x40/0x50=0D
[   34.892799]  __fput+0x26d/0xa40=0D
[   34.893143]  ____fput+0x1e/0x30=0D
[   34.893463]  task_work_run+0x1a4/0x2d0=0D
[   34.893843]  ? write_comp_data+0x2f/0x90=0D
[   34.894240]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.894656]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.895111]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.895528]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.895995]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.896443]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.896890]  do_syscall_64+0x4a/0x90=0D
[   34.897246]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.897692] RIP: 0033:0x7f3840f1059d=0D
[   34.898038] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.899597] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.900262] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.900881] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.901501] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.902127] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.902746] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.903405]  </TASK>=0D
[   34.947925] FAULT_INJECTION: forcing a failure.=0D
[   34.947925] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   34.948648] CPU: 0 PID: 573 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   34.949173] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   34.949862] Call Trace:=0D
[   34.950023]  <TASK>=0D
[   34.950168]  dump_stack_lvl+0xa7/0xdb=0D
[   34.950423]  dump_stack+0x19/0x1f=0D
[   34.950646]  should_fail_ex.cold.5+0x5/0xa=0D
[   34.950931]  __should_failslab+0xca/0x120=0D
[   34.951200]  should_failslab+0x12/0x30=0D
[   34.951449]  __kmem_cache_alloc_node+0x62/0x280=0D
[   34.951746]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   34.952030]  kmalloc_trace+0x2e/0x120=0D
[   34.952276]  alloc_ftrace_hash+0x4f/0x170=0D
[   34.952545]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   34.952920]  ? write_comp_data+0x2f/0x90=0D
[   34.953192]  ftrace_set_hash+0x445/0x590=0D
[   34.953470]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   34.953777]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   34.954099]  ? match_dev_by_uuid+0x4/0x100=0D
[   34.954368]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.954677]  ? write_comp_data+0x2f/0x90=0D
[   34.954950]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   34.955284]  disarm_kprobe+0x24a/0x2d0=0D
[   34.955536]  __disable_kprobe+0x2de/0x4b0=0D
[   34.955804]  disable_kprobe+0x31/0x80=0D
[   34.956054]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   34.956353]  disable_trace_kprobe+0x1f0/0x300=0D
[   34.956644]  kprobe_register+0x4e/0xf0=0D
[   34.956899]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   34.957237]  perf_kprobe_destroy+0xcb/0x200=0D
[   34.957517]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   34.957849]  _free_event+0x220/0x11c0=0D
[   34.958117]  put_event+0x4d/0x60=0D
[   34.958350]  perf_event_release_kernel+0x5d9/0x860=0D
[   34.958685]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   34.959042]  ? write_comp_data+0x2f/0x90=0D
[   34.959319]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   34.959649]  ? __pfx_perf_release+0x10/0x10=0D
[   34.959935]  perf_release+0x40/0x50=0D
[   34.960183]  __fput+0x26d/0xa40=0D
[   34.960424]  ____fput+0x1e/0x30=0D
[   34.960654]  task_work_run+0x1a4/0x2d0=0D
[   34.960916]  ? write_comp_data+0x2f/0x90=0D
[   34.961195]  ? __pfx_task_work_run+0x10/0x10=0D
[   34.961491]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   34.961846]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   34.962148]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   34.962484]  exit_to_user_mode_prepare+0x200/0x210=0D
[   34.962805]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   34.963120]  do_syscall_64+0x4a/0x90=0D
[   34.963372]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   34.963705] RIP: 0033:0x7f3840f1059d=0D
[   34.963950] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   34.965098] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   34.965582] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   34.966041] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   34.966494] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   34.966946] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   34.967395] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   34.967869]  </TASK>=0D
[   35.017254] FAULT_INJECTION: forcing a failure.=0D
[   35.017254] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.017974] CPU: 1 PID: 574 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.018502] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.019185] Call Trace:=0D
[   35.019347]  <TASK>=0D
[   35.019494]  dump_stack_lvl+0xa7/0xdb=0D
[   35.019745]  dump_stack+0x19/0x1f=0D
[   35.019971]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.020265]  __should_failslab+0xca/0x120=0D
[   35.020526]  should_failslab+0x12/0x30=0D
[   35.020766]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.021057]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.021333]  kmalloc_trace+0x2e/0x120=0D
[   35.021572]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.021846]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.022214]  ? write_comp_data+0x2f/0x90=0D
[   35.022484]  ftrace_set_hash+0x445/0x590=0D
[   35.022773]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.023076]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.023405]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.023674]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.024060]  ? write_comp_data+0x2f/0x90=0D
[   35.024410]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.024790]  disarm_kprobe+0x24a/0x2d0=0D
[   35.025057]  __disable_kprobe+0x2de/0x4b0=0D
[   35.025323]  disable_kprobe+0x31/0x80=0D
[   35.025564]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.025868]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.026152]  kprobe_register+0x4e/0xf0=0D
[   35.026402]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.026729]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.027001]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.027314]  _free_event+0x220/0x11c0=0D
[   35.027566]  put_event+0x4d/0x60=0D
[   35.027784]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.028106]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.028450]  ? write_comp_data+0x2f/0x90=0D
[   35.028720]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.029041]  ? __pfx_perf_release+0x10/0x10=0D
[   35.029319]  perf_release+0x40/0x50=0D
[   35.029612]  __fput+0x26d/0xa40=0D
[   35.029905]  ____fput+0x1e/0x30=0D
[   35.030125]  task_work_run+0x1a4/0x2d0=0D
[   35.030381]  ? write_comp_data+0x2f/0x90=0D
[   35.030653]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.030940]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.031258]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.031557]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.031885]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.032196]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.032501]  do_syscall_64+0x4a/0x90=0D
[   35.032748]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.033098] RIP: 0033:0x7f3840f1059d=0D
[   35.033380] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.034655] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.035208] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.035729] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.036212] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.036661] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.037109] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.037584]  </TASK>=0D
[   35.078256] FAULT_INJECTION: forcing a failure.=0D
[   35.078256] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.080135] CPU: 0 PID: 575 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.081217] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.082334] Call Trace:=0D
[   35.082514]  <TASK>=0D
[   35.082671]  dump_stack_lvl+0xa7/0xdb=0D
[   35.082940]  dump_stack+0x19/0x1f=0D
[   35.083177]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.083475]  __should_failslab+0xca/0x120=0D
[   35.083760]  should_failslab+0x12/0x30=0D
[   35.084022]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.084340]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.084639]  kmalloc_trace+0x2e/0x120=0D
[   35.084900]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.085184]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.085585]  ? write_comp_data+0x2f/0x90=0D
[   35.085886]  ftrace_set_hash+0x445/0x590=0D
[   35.086186]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.086500]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.086842]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.087135]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.087471]  ? write_comp_data+0x2f/0x90=0D
[   35.087763]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.088118]  disarm_kprobe+0x24a/0x2d0=0D
[   35.088388]  __disable_kprobe+0x2de/0x4b0=0D
[   35.088667]  disable_kprobe+0x31/0x80=0D
[   35.088920]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.089229]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.089598]  kprobe_register+0x4e/0xf0=0D
[   35.089927]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.090354]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.090707]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.091106]  _free_event+0x220/0x11c0=0D
[   35.091426]  put_event+0x4d/0x60=0D
[   35.091707]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.092113]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.092543]  ? write_comp_data+0x2f/0x90=0D
[   35.092880]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.093283]  ? __pfx_perf_release+0x10/0x10=0D
[   35.093635]  perf_release+0x40/0x50=0D
[   35.093937]  __fput+0x26d/0xa40=0D
[   35.094226]  ____fput+0x1e/0x30=0D
[   35.094499]  task_work_run+0x1a4/0x2d0=0D
[   35.094817]  ? write_comp_data+0x2f/0x90=0D
[   35.095155]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.095515]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.095906]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.096206]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.096535]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.096850]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.097159]  do_syscall_64+0x4a/0x90=0D
[   35.097405]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.097734] RIP: 0033:0x7f3840f1059d=0D
[   35.097985] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.099130] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.099621] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.100078] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.100543] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.100999] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.101452] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.101936]  </TASK>=0D
[   35.153536] FAULT_INJECTION: forcing a failure.=0D
[   35.153536] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.154527] CPU: 0 PID: 576 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.155232] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.156109] Call Trace:=0D
[   35.156324]  <TASK>=0D
[   35.156523]  dump_stack_lvl+0xa7/0xdb=0D
[   35.156889]  dump_stack+0x19/0x1f=0D
[   35.157181]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.157551]  __should_failslab+0xca/0x120=0D
[   35.157905]  should_failslab+0x12/0x30=0D
[   35.158189]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.158501]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.158797]  kmalloc_trace+0x2e/0x120=0D
[   35.159053]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.159337]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.159736]  ? write_comp_data+0x2f/0x90=0D
[   35.160018]  ftrace_set_hash+0x445/0x590=0D
[   35.160310]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.160616]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.160951]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.161236]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.161570]  ? write_comp_data+0x2f/0x90=0D
[   35.161876]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.162256]  disarm_kprobe+0x24a/0x2d0=0D
[   35.162520]  __disable_kprobe+0x2de/0x4b0=0D
[   35.162800]  disable_kprobe+0x31/0x80=0D
[   35.163056]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.163367]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.163671]  kprobe_register+0x4e/0xf0=0D
[   35.163935]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.164283]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.164573]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.164903]  _free_event+0x220/0x11c0=0D
[   35.165173]  put_event+0x4d/0x60=0D
[   35.165403]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.165738]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.166098]  ? write_comp_data+0x2f/0x90=0D
[   35.166380]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.166711]  ? __pfx_perf_release+0x10/0x10=0D
[   35.167001]  perf_release+0x40/0x50=0D
[   35.167249]  __fput+0x26d/0xa40=0D
[   35.167491]  ____fput+0x1e/0x30=0D
[   35.167716]  task_work_run+0x1a4/0x2d0=0D
[   35.167980]  ? write_comp_data+0x2f/0x90=0D
[   35.168262]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.168557]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.168880]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.169177]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.169515]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.169845]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.170165]  do_syscall_64+0x4a/0x90=0D
[   35.170419]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.170755] RIP: 0033:0x7f3840f1059d=0D
[   35.171004] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.172149] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.172642] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.173103] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.173556] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.174013] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.174465] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.174944]  </TASK>=0D
[   35.226048] FAULT_INJECTION: forcing a failure.=0D
[   35.226048] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.227027] CPU: 0 PID: 577 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.227729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.228629] Call Trace:=0D
[   35.228853]  <TASK>=0D
[   35.229053]  dump_stack_lvl+0xa7/0xdb=0D
[   35.229393]  dump_stack+0x19/0x1f=0D
[   35.229698]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.230090]  __should_failslab+0xca/0x120=0D
[   35.230455]  should_failslab+0x12/0x30=0D
[   35.230796]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.231204]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.231588]  kmalloc_trace+0x2e/0x120=0D
[   35.231929]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.232303]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.232818]  ? write_comp_data+0x2f/0x90=0D
[   35.233201]  ftrace_set_hash+0x445/0x590=0D
[   35.233596]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.234004]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.234441]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.234811]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.235247]  ? write_comp_data+0x2f/0x90=0D
[   35.235637]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.236110]  disarm_kprobe+0x24a/0x2d0=0D
[   35.236474]  __disable_kprobe+0x2de/0x4b0=0D
[   35.236861]  disable_kprobe+0x31/0x80=0D
[   35.237197]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.237602]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.238034]  kprobe_register+0x4e/0xf0=0D
[   35.238401]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.238864]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.239243]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.239677]  _free_event+0x220/0x11c0=0D
[   35.240041]  put_event+0x4d/0x60=0D
[   35.240359]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.240815]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.241295]  ? write_comp_data+0x2f/0x90=0D
[   35.241682]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.242147]  ? __pfx_perf_release+0x10/0x10=0D
[   35.242535]  perf_release+0x40/0x50=0D
[   35.242896]  __fput+0x26d/0xa40=0D
[   35.243230]  ____fput+0x1e/0x30=0D
[   35.243534]  task_work_run+0x1a4/0x2d0=0D
[   35.243911]  ? write_comp_data+0x2f/0x90=0D
[   35.244307]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.244722]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.245171]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.245588]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.246070]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.246511]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.246949]  do_syscall_64+0x4a/0x90=0D
[   35.247309]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.247786] RIP: 0033:0x7f3840f1059d=0D
[   35.248137] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.249711] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.250249] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.250703] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.251155] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.251636] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.252091] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.252578]  </TASK>=0D
[   35.297768] FAULT_INJECTION: forcing a failure.=0D
[   35.297768] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.299525] CPU: 0 PID: 578 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.300757] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.302363] Call Trace:=0D
[   35.302745]  <TASK>=0D
[   35.303075]  dump_stack_lvl+0xa7/0xdb=0D
[   35.303643]  dump_stack+0x19/0x1f=0D
[   35.304151]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.304778]  __should_failslab+0xca/0x120=0D
[   35.305386]  should_failslab+0x12/0x30=0D
[   35.305956]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.306631]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.307266]  kmalloc_trace+0x2e/0x120=0D
[   35.307822]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.308432]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.309298]  ? write_comp_data+0x2f/0x90=0D
[   35.309932]  ftrace_set_hash+0x445/0x590=0D
[   35.310551]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.311209]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.311936]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.312564]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.313276]  ? write_comp_data+0x2f/0x90=0D
[   35.313901]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.314668]  disarm_kprobe+0x24a/0x2d0=0D
[   35.315240]  __disable_kprobe+0x2de/0x4b0=0D
[   35.315858]  disable_kprobe+0x31/0x80=0D
[   35.316430]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.317109]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.317766]  kprobe_register+0x4e/0xf0=0D
[   35.318352]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.319106]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.319737]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.320457]  _free_event+0x220/0x11c0=0D
[   35.321032]  put_event+0x4d/0x60=0D
[   35.321536]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.322136]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.322592]  ? write_comp_data+0x2f/0x90=0D
[   35.322940]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.323313]  ? __pfx_perf_release+0x10/0x10=0D
[   35.323599]  perf_release+0x40/0x50=0D
[   35.323849]  __fput+0x26d/0xa40=0D
[   35.324094]  ____fput+0x1e/0x30=0D
[   35.324320]  task_work_run+0x1a4/0x2d0=0D
[   35.324583]  ? write_comp_data+0x2f/0x90=0D
[   35.324864]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.325165]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.325494]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.325801]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.326141]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.326470]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.326794]  do_syscall_64+0x4a/0x90=0D
[   35.327049]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.327393] RIP: 0033:0x7f3840f1059d=0D
[   35.327644] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.328830] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.329317] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.329765] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.330223] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.330663] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.331104] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.331574]  </TASK>=0D
[   35.381049] FAULT_INJECTION: forcing a failure.=0D
[   35.381049] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.382715] CPU: 0 PID: 579 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.383906] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.385575] Call Trace:=0D
[   35.386021]  <TASK>=0D
[   35.386402]  dump_stack_lvl+0xa7/0xdb=0D
[   35.387052]  dump_stack+0x19/0x1f=0D
[   35.387635]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.388351]  __should_failslab+0xca/0x120=0D
[   35.389040]  should_failslab+0x12/0x30=0D
[   35.389680]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.390453]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.391175]  kmalloc_trace+0x2e/0x120=0D
[   35.391813]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.392504]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.393488]  ? write_comp_data+0x2f/0x90=0D
[   35.394240]  ftrace_set_hash+0x445/0x590=0D
[   35.394533]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.394827]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.395149]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.395420]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.395725]  ? write_comp_data+0x2f/0x90=0D
[   35.395992]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.396346]  disarm_kprobe+0x24a/0x2d0=0D
[   35.396602]  __disable_kprobe+0x2de/0x4b0=0D
[   35.396866]  disable_kprobe+0x31/0x80=0D
[   35.397110]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.397411]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.397706]  kprobe_register+0x4e/0xf0=0D
[   35.397965]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.398296]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.398582]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.398912]  _free_event+0x220/0x11c0=0D
[   35.399171]  put_event+0x4d/0x60=0D
[   35.399395]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.399724]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.400058]  ? write_comp_data+0x2f/0x90=0D
[   35.400321]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.400641]  ? __pfx_perf_release+0x10/0x10=0D
[   35.400920]  perf_release+0x40/0x50=0D
[   35.401157]  __fput+0x26d/0xa40=0D
[   35.401388]  ____fput+0x1e/0x30=0D
[   35.401602]  task_work_run+0x1a4/0x2d0=0D
[   35.401875]  ? write_comp_data+0x2f/0x90=0D
[   35.402142]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.402431]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.402764]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.403070]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.403401]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.403715]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.404038]  do_syscall_64+0x4a/0x90=0D
[   35.404284]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.404613] RIP: 0033:0x7f3840f1059d=0D
[   35.404854] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.405979] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.406460] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.406912] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.407366] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.407806] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.408259] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.408723]  </TASK>=0D
[   35.452415] FAULT_INJECTION: forcing a failure.=0D
[   35.452415] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.453169] CPU: 1 PID: 580 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.453724] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.454435] Call Trace:=0D
[   35.454602]  <TASK>=0D
[   35.454772]  dump_stack_lvl+0xa7/0xdb=0D
[   35.455032]  dump_stack+0x19/0x1f=0D
[   35.455264]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.455553]  __should_failslab+0xca/0x120=0D
[   35.455841]  should_failslab+0x12/0x30=0D
[   35.456095]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.456400]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.456695]  kmalloc_trace+0x2e/0x120=0D
[   35.456965]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.457246]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.457639]  ? write_comp_data+0x2f/0x90=0D
[   35.457940]  ftrace_set_hash+0x445/0x590=0D
[   35.458233]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.458543]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.458887]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.459185]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.459509]  ? write_comp_data+0x2f/0x90=0D
[   35.459794]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.460155]  disarm_kprobe+0x24a/0x2d0=0D
[   35.460420]  __disable_kprobe+0x2de/0x4b0=0D
[   35.460698]  disable_kprobe+0x31/0x80=0D
[   35.460957]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.461283]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.461587]  kprobe_register+0x4e/0xf0=0D
[   35.461863]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.462224]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.462530]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.462872]  _free_event+0x220/0x11c0=0D
[   35.463142]  put_event+0x4d/0x60=0D
[   35.463389]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.463729]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.464097]  ? write_comp_data+0x2f/0x90=0D
[   35.464386]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.464734]  ? __pfx_perf_release+0x10/0x10=0D
[   35.465026]  perf_release+0x40/0x50=0D
[   35.465276]  __fput+0x26d/0xa40=0D
[   35.465535]  ____fput+0x1e/0x30=0D
[   35.465764]  task_work_run+0x1a4/0x2d0=0D
[   35.466040]  ? write_comp_data+0x2f/0x90=0D
[   35.466323]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.466633]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.466971]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.467271]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.467650]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.467986]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.468307]  do_syscall_64+0x4a/0x90=0D
[   35.468566]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.468922] RIP: 0033:0x7f3840f1059d=0D
[   35.469173] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.471034] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.472085] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.473067] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.474058] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.475046] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.476037] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.477058]  </TASK>=0D
[   35.511323] FAULT_INJECTION: forcing a failure.=0D
[   35.511323] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.512219] CPU: 0 PID: 581 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.512878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.513732] Call Trace:=0D
[   35.513941]  <TASK>=0D
[   35.514118]  dump_stack_lvl+0xa7/0xdb=0D
[   35.514427]  dump_stack+0x19/0x1f=0D
[   35.514702]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.515045]  __should_failslab+0xca/0x120=0D
[   35.515375]  should_failslab+0x12/0x30=0D
[   35.515679]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.516045]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.516392]  kmalloc_trace+0x2e/0x120=0D
[   35.516692]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.517021]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.517488]  ? write_comp_data+0x2f/0x90=0D
[   35.517830]  ftrace_set_hash+0x445/0x590=0D
[   35.518170]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.518528]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.518923]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.519261]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.519642]  ? write_comp_data+0x2f/0x90=0D
[   35.519981]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.520410]  disarm_kprobe+0x24a/0x2d0=0D
[   35.520731]  __disable_kprobe+0x2de/0x4b0=0D
[   35.521074]  disable_kprobe+0x31/0x80=0D
[   35.521386]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.521696]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.522009]  kprobe_register+0x4e/0xf0=0D
[   35.522273]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.522616]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.522902]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.523229]  _free_event+0x220/0x11c0=0D
[   35.523496]  put_event+0x4d/0x60=0D
[   35.523726]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.524056]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.524407]  ? write_comp_data+0x2f/0x90=0D
[   35.524684]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.525010]  ? __pfx_perf_release+0x10/0x10=0D
[   35.525293]  perf_release+0x40/0x50=0D
[   35.525538]  __fput+0x26d/0xa40=0D
[   35.525777]  ____fput+0x1e/0x30=0D
[   35.526026]  task_work_run+0x1a4/0x2d0=0D
[   35.526294]  ? write_comp_data+0x2f/0x90=0D
[   35.526580]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.526880]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.527214]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.527519]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.527863]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.528190]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.528515]  do_syscall_64+0x4a/0x90=0D
[   35.528774]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.529117] RIP: 0033:0x7f3840f1059d=0D
[   35.529368] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.530545] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.531076] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.531544] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.532004] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.532456] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.532911] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.533393]  </TASK>=0D
[   35.576800] FAULT_INJECTION: forcing a failure.=0D
[   35.576800] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.577724] CPU: 0 PID: 582 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.578408] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.579347] Call Trace:=0D
[   35.579573]  <TASK>=0D
[   35.579774]  dump_stack_lvl+0xa7/0xdb=0D
[   35.580137]  dump_stack+0x19/0x1f=0D
[   35.580447]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.580840]  __should_failslab+0xca/0x120=0D
[   35.581208]  should_failslab+0x12/0x30=0D
[   35.581554]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.581972]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.582365]  kmalloc_trace+0x2e/0x120=0D
[   35.582715]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.583095]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.583629]  ? write_comp_data+0x2f/0x90=0D
[   35.584013]  ftrace_set_hash+0x445/0x590=0D
[   35.584417]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.584846]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.585312]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.585707]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.586161]  ? write_comp_data+0x2f/0x90=0D
[   35.586557]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.587046]  disarm_kprobe+0x24a/0x2d0=0D
[   35.587423]  __disable_kprobe+0x2de/0x4b0=0D
[   35.587805]  disable_kprobe+0x31/0x80=0D
[   35.588170]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.588600]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.589024]  kprobe_register+0x4e/0xf0=0D
[   35.589396]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.589887]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.590292]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.590758]  _free_event+0x220/0x11c0=0D
[   35.591132]  put_event+0x4d/0x60=0D
[   35.591443]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.591919]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.592403]  ? write_comp_data+0x2f/0x90=0D
[   35.592800]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.593272]  ? __pfx_perf_release+0x10/0x10=0D
[   35.593676]  perf_release+0x40/0x50=0D
[   35.594038]  __fput+0x26d/0xa40=0D
[   35.594389]  ____fput+0x1e/0x30=0D
[   35.594713]  task_work_run+0x1a4/0x2d0=0D
[   35.595064]  ? write_comp_data+0x2f/0x90=0D
[   35.595466]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.595887]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.596338]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.596764]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.597240]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.597698]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.598064]  do_syscall_64+0x4a/0x90=0D
[   35.598322]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.598660] RIP: 0033:0x7f3840f1059d=0D
[   35.598912] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.600062] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.600551] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.601006] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.601458] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.601924] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.602378] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.602858]  </TASK>=0D
[   35.652864] FAULT_INJECTION: forcing a failure.=0D
[   35.652864] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.653837] CPU: 0 PID: 583 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.654530] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.655463] Call Trace:=0D
[   35.655693]  <TASK>=0D
[   35.655896]  dump_stack_lvl+0xa7/0xdb=0D
[   35.656247]  dump_stack+0x19/0x1f=0D
[   35.656558]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.656956]  __should_failslab+0xca/0x120=0D
[   35.657342]  should_failslab+0x12/0x30=0D
[   35.657684]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.658033]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.658319]  kmalloc_trace+0x2e/0x120=0D
[   35.658569]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.658839]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.659219]  ? write_comp_data+0x2f/0x90=0D
[   35.659493]  ftrace_set_hash+0x445/0x590=0D
[   35.659774]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.660066]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.660387]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.660666]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.660990]  ? write_comp_data+0x2f/0x90=0D
[   35.661273]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.661646]  disarm_kprobe+0x24a/0x2d0=0D
[   35.661933]  __disable_kprobe+0x2de/0x4b0=0D
[   35.662222]  disable_kprobe+0x31/0x80=0D
[   35.662482]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.662828]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.663136]  kprobe_register+0x4e/0xf0=0D
[   35.663402]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.663754]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.664063]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.664397]  _free_event+0x220/0x11c0=0D
[   35.664665]  put_event+0x4d/0x60=0D
[   35.664905]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.665253]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.665610]  ? write_comp_data+0x2f/0x90=0D
[   35.665898]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.666243]  ? __pfx_perf_release+0x10/0x10=0D
[   35.666534]  perf_release+0x40/0x50=0D
[   35.666801]  __fput+0x26d/0xa40=0D
[   35.667045]  ____fput+0x1e/0x30=0D
[   35.667285]  task_work_run+0x1a4/0x2d0=0D
[   35.667549]  ? write_comp_data+0x2f/0x90=0D
[   35.667830]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.668129]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.668468]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.668768]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.669108]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.669443]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.669762]  do_syscall_64+0x4a/0x90=0D
[   35.670025]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.670380] RIP: 0033:0x7f3840f1059d=0D
[   35.670650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.671816] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.672302] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.672755] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.673194] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.673646] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.674095] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.674560]  </TASK>=0D
[   35.735325] FAULT_INJECTION: forcing a failure.=0D
[   35.735325] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.736289] CPU: 0 PID: 584 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.736997] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.737944] Call Trace:=0D
[   35.738159]  <TASK>=0D
[   35.738308]  dump_stack_lvl+0xa7/0xdb=0D
[   35.738562]  dump_stack+0x19/0x1f=0D
[   35.738791]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.739077]  __should_failslab+0xca/0x120=0D
[   35.739391]  should_failslab+0x12/0x30=0D
[   35.739649]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.739951]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.740239]  kmalloc_trace+0x2e/0x120=0D
[   35.740488]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.740760]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.741141]  ? write_comp_data+0x2f/0x90=0D
[   35.741417]  ftrace_set_hash+0x445/0x590=0D
[   35.741701]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.742004]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.742328]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.742605]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.742919]  ? write_comp_data+0x2f/0x90=0D
[   35.743195]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.743531]  disarm_kprobe+0x24a/0x2d0=0D
[   35.743788]  __disable_kprobe+0x2de/0x4b0=0D
[   35.744064]  disable_kprobe+0x31/0x80=0D
[   35.744314]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.744618]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.744922]  kprobe_register+0x4e/0xf0=0D
[   35.745190]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.745557]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.745860]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.746219]  _free_event+0x220/0x11c0=0D
[   35.746512]  put_event+0x4d/0x60=0D
[   35.746750]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.747090]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.747445]  ? write_comp_data+0x2f/0x90=0D
[   35.747723]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.748058]  ? __pfx_perf_release+0x10/0x10=0D
[   35.748349]  perf_release+0x40/0x50=0D
[   35.748600]  __fput+0x26d/0xa40=0D
[   35.748845]  ____fput+0x1e/0x30=0D
[   35.749074]  task_work_run+0x1a4/0x2d0=0D
[   35.749339]  ? write_comp_data+0x2f/0x90=0D
[   35.749624]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.749935]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.750264]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.750570]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.750910]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.751233]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.751556]  do_syscall_64+0x4a/0x90=0D
[   35.751812]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.752154] RIP: 0033:0x7f3840f1059d=0D
[   35.752405] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.753567] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.754064] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.754522] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.755014] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.755503] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.755965] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.756435]  </TASK>=0D
[   35.799443] FAULT_INJECTION: forcing a failure.=0D
[   35.799443] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.801071] CPU: 1 PID: 585 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.802419] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.804172] Call Trace:=0D
[   35.804552]  <TASK>=0D
[   35.804888]  dump_stack_lvl+0xa7/0xdb=0D
[   35.805652]  dump_stack+0x19/0x1f=0D
[   35.806175]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.806972]  __should_failslab+0xca/0x120=0D
[   35.807584]  should_failslab+0x12/0x30=0D
[   35.808151]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.808728]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.809142]  kmalloc_trace+0x2e/0x120=0D
[   35.809508]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.809900]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.810486]  ? write_comp_data+0x2f/0x90=0D
[   35.810867]  ftrace_set_hash+0x445/0x590=0D
[   35.811274]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.811708]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.812167]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.812607]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.813062]  ? write_comp_data+0x2f/0x90=0D
[   35.813473]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.813967]  disarm_kprobe+0x24a/0x2d0=0D
[   35.814381]  __disable_kprobe+0x2de/0x4b0=0D
[   35.814774]  disable_kprobe+0x31/0x80=0D
[   35.815144]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.815546]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.815858]  kprobe_register+0x4e/0xf0=0D
[   35.816136]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.816507]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.816866]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.817249]  _free_event+0x220/0x11c0=0D
[   35.817546]  put_event+0x4d/0x60=0D
[   35.817828]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.818179]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.818547]  ? write_comp_data+0x2f/0x90=0D
[   35.818835]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.819184]  ? __pfx_perf_release+0x10/0x10=0D
[   35.819485]  perf_release+0x40/0x50=0D
[   35.819743]  __fput+0x26d/0xa40=0D
[   35.820027]  ____fput+0x1e/0x30=0D
[   35.820316]  task_work_run+0x1a4/0x2d0=0D
[   35.820657]  ? write_comp_data+0x2f/0x90=0D
[   35.821018]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.821397]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.821826]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.822191]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.822536]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.822882]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.823212]  do_syscall_64+0x4a/0x90=0D
[   35.823466]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.823807] RIP: 0033:0x7f3840f1059d=0D
[   35.824056] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.825235] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.825741] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.826206] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.826685] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.827142] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.827615] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.828098]  </TASK>=0D
[   35.881303] FAULT_INJECTION: forcing a failure.=0D
[   35.881303] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.882321] CPU: 0 PID: 586 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.883060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.884024] Call Trace:=0D
[   35.884248]  <TASK>=0D
[   35.884452]  dump_stack_lvl+0xa7/0xdb=0D
[   35.884821]  dump_stack+0x19/0x1f=0D
[   35.885059]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.885347]  __should_failslab+0xca/0x120=0D
[   35.885632]  should_failslab+0x12/0x30=0D
[   35.885902]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.886238]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.886538]  kmalloc_trace+0x2e/0x120=0D
[   35.886824]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.887110]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.887523]  ? write_comp_data+0x2f/0x90=0D
[   35.887813]  ftrace_set_hash+0x445/0x590=0D
[   35.888111]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.888428]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.888760]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.889047]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.889382]  ? write_comp_data+0x2f/0x90=0D
[   35.889665]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.890019]  disarm_kprobe+0x24a/0x2d0=0D
[   35.890285]  __disable_kprobe+0x2de/0x4b0=0D
[   35.890581]  disable_kprobe+0x31/0x80=0D
[   35.890851]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.891167]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.891474]  kprobe_register+0x4e/0xf0=0D
[   35.891754]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.892102]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.892396]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.892742]  _free_event+0x220/0x11c0=0D
[   35.893012]  put_event+0x4d/0x60=0D
[   35.893247]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.893584]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.893962]  ? write_comp_data+0x2f/0x90=0D
[   35.894242]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.894572]  ? __pfx_perf_release+0x10/0x10=0D
[   35.894893]  perf_release+0x40/0x50=0D
[   35.895142]  __fput+0x26d/0xa40=0D
[   35.895384]  ____fput+0x1e/0x30=0D
[   35.895610]  task_work_run+0x1a4/0x2d0=0D
[   35.895886]  ? write_comp_data+0x2f/0x90=0D
[   35.896168]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.896462]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.896783]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.897095]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.897432]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.897754]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.898093]  do_syscall_64+0x4a/0x90=0D
[   35.898362]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.898708] RIP: 0033:0x7f3840f1059d=0D
[   35.898954] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.900097] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.900593] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.901042] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.901507] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.901966] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.902432] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.902925]  </TASK>=0D
[   35.939206] FAULT_INJECTION: forcing a failure.=0D
[   35.939206] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.939920] CPU: 1 PID: 587 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.940476] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.941141] Call Trace:=0D
[   35.941299]  <TASK>=0D
[   35.941449]  dump_stack_lvl+0xa7/0xdb=0D
[   35.941699]  dump_stack+0x19/0x1f=0D
[   35.941923]  should_fail_ex.cold.5+0x5/0xa=0D
[   35.942195]  __should_failslab+0xca/0x120=0D
[   35.942456]  should_failslab+0x12/0x30=0D
[   35.942721]  __kmem_cache_alloc_node+0x62/0x280=0D
[   35.943012]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   35.943287]  kmalloc_trace+0x2e/0x120=0D
[   35.943527]  alloc_ftrace_hash+0x4f/0x170=0D
[   35.943798]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   35.944167]  ? write_comp_data+0x2f/0x90=0D
[   35.944433]  ftrace_set_hash+0x445/0x590=0D
[   35.944733]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   35.945019]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   35.945332]  ? match_dev_by_uuid+0x4/0x100=0D
[   35.945600]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.945921]  ? write_comp_data+0x2f/0x90=0D
[   35.946186]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   35.946512]  disarm_kprobe+0x24a/0x2d0=0D
[   35.946774]  __disable_kprobe+0x2de/0x4b0=0D
[   35.947054]  disable_kprobe+0x31/0x80=0D
[   35.947295]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   35.947587]  disable_trace_kprobe+0x1f0/0x300=0D
[   35.947882]  kprobe_register+0x4e/0xf0=0D
[   35.948133]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   35.948457]  perf_kprobe_destroy+0xcb/0x200=0D
[   35.948728]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   35.949049]  _free_event+0x220/0x11c0=0D
[   35.949307]  put_event+0x4d/0x60=0D
[   35.949534]  perf_event_release_kernel+0x5d9/0x860=0D
[   35.949871]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   35.950226]  ? write_comp_data+0x2f/0x90=0D
[   35.950504]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   35.950834]  ? __pfx_perf_release+0x10/0x10=0D
[   35.951110]  perf_release+0x40/0x50=0D
[   35.951357]  __fput+0x26d/0xa40=0D
[   35.951622]  ____fput+0x1e/0x30=0D
[   35.951875]  task_work_run+0x1a4/0x2d0=0D
[   35.952267]  ? write_comp_data+0x2f/0x90=0D
[   35.952544]  ? __pfx_task_work_run+0x10/0x10=0D
[   35.952827]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   35.953200]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   35.953556]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   35.953944]  exit_to_user_mode_prepare+0x200/0x210=0D
[   35.954266]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   35.954576]  do_syscall_64+0x4a/0x90=0D
[   35.954825]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   35.955152] RIP: 0033:0x7f3840f1059d=0D
[   35.955393] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   35.956501] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   35.956973] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   35.957427] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   35.957894] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   35.958348] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   35.958809] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   35.959284]  </TASK>=0D
[   35.997930] FAULT_INJECTION: forcing a failure.=0D
[   35.997930] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   35.998695] CPU: 1 PID: 588 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   35.999229] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   35.999932] Call Trace:=0D
[   36.000100]  <TASK>=0D
[   36.000248]  dump_stack_lvl+0xa7/0xdb=0D
[   36.000511]  dump_stack+0x19/0x1f=0D
[   36.000745]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.001036]  __should_failslab+0xca/0x120=0D
[   36.001318]  should_failslab+0x12/0x30=0D
[   36.001579]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.001947]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.002305]  kmalloc_trace+0x2e/0x120=0D
[   36.002619]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.002965]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.003454]  ? write_comp_data+0x2f/0x90=0D
[   36.003802]  ftrace_set_hash+0x445/0x590=0D
[   36.004157]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.004529]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.004945]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.005297]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.005700]  ? write_comp_data+0x2f/0x90=0D
[   36.006056]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.006490]  disarm_kprobe+0x24a/0x2d0=0D
[   36.006813]  __disable_kprobe+0x2de/0x4b0=0D
[   36.007161]  disable_kprobe+0x31/0x80=0D
[   36.007480]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.007869]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.008244]  kprobe_register+0x4e/0xf0=0D
[   36.008570]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.009001]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.009359]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.009765]  _free_event+0x220/0x11c0=0D
[   36.010099]  put_event+0x4d/0x60=0D
[   36.010385]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.010795]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.011234]  ? write_comp_data+0x2f/0x90=0D
[   36.011578]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.011988]  ? __pfx_perf_release+0x10/0x10=0D
[   36.012326]  perf_release+0x40/0x50=0D
[   36.012622]  __fput+0x26d/0xa40=0D
[   36.012906]  ____fput+0x1e/0x30=0D
[   36.013174]  task_work_run+0x1a4/0x2d0=0D
[   36.013488]  ? write_comp_data+0x2f/0x90=0D
[   36.013984]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.014609]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.015280]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.015906]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.016618]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.017307]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.018017]  do_syscall_64+0x4a/0x90=0D
[   36.018553]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.019271] RIP: 0033:0x7f3840f1059d=0D
[   36.019796] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.022262] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.023303] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.024274] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.025250] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.026236] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.027221] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.028229]  </TASK>=0D
[   36.068393] FAULT_INJECTION: forcing a failure.=0D
[   36.068393] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.069138] CPU: 1 PID: 589 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.069666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.070362] Call Trace:=0D
[   36.070528]  <TASK>=0D
[   36.070678]  dump_stack_lvl+0xa7/0xdb=0D
[   36.070935]  dump_stack+0x19/0x1f=0D
[   36.071169]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.071454]  __should_failslab+0xca/0x120=0D
[   36.071730]  should_failslab+0x12/0x30=0D
[   36.071987]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.072297]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.072591]  kmalloc_trace+0x2e/0x120=0D
[   36.072854]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.073134]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.073528]  ? write_comp_data+0x2f/0x90=0D
[   36.073822]  ftrace_set_hash+0x445/0x590=0D
[   36.074115]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.074420]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.074752]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.075037]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.075360]  ? write_comp_data+0x2f/0x90=0D
[   36.075643]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.075991]  disarm_kprobe+0x24a/0x2d0=0D
[   36.076256]  __disable_kprobe+0x2de/0x4b0=0D
[   36.076537]  disable_kprobe+0x31/0x80=0D
[   36.076795]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.077108]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.077408]  kprobe_register+0x4e/0xf0=0D
[   36.077669]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.078022]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.078314]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.078647]  _free_event+0x220/0x11c0=0D
[   36.078916]  put_event+0x4d/0x60=0D
[   36.079149]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.079487]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.079844]  ? write_comp_data+0x2f/0x90=0D
[   36.080125]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.080459]  ? __pfx_perf_release+0x10/0x10=0D
[   36.080747]  perf_release+0x40/0x50=0D
[   36.080998]  __fput+0x26d/0xa40=0D
[   36.081241]  ____fput+0x1e/0x30=0D
[   36.081489]  task_work_run+0x1a4/0x2d0=0D
[   36.081778]  ? write_comp_data+0x2f/0x90=0D
[   36.082067]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.082364]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.082689]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.082989]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.083323]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.083636]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.083946]  do_syscall_64+0x4a/0x90=0D
[   36.084194]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.084521] RIP: 0033:0x7f3840f1059d=0D
[   36.084760] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.085937] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.086410] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.086849] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.087293] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.087730] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.088166] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.088628]  </TASK>=0D
[   36.126026] FAULT_INJECTION: forcing a failure.=0D
[   36.126026] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.127834] CPU: 1 PID: 590 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.129106] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.130709] Call Trace:=0D
[   36.131121]  <TASK>=0D
[   36.131469]  dump_stack_lvl+0xa7/0xdb=0D
[   36.132080]  dump_stack+0x19/0x1f=0D
[   36.132583]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.133258]  __should_failslab+0xca/0x120=0D
[   36.133864]  should_failslab+0x12/0x30=0D
[   36.134410]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.135136]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.135761]  kmalloc_trace+0x2e/0x120=0D
[   36.136310]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.136971]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.137811]  ? write_comp_data+0x2f/0x90=0D
[   36.138453]  ftrace_set_hash+0x445/0x590=0D
[   36.139105]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.139767]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.140494]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.141115]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.141890]  ? write_comp_data+0x2f/0x90=0D
[   36.142186]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.142534]  disarm_kprobe+0x24a/0x2d0=0D
[   36.142825]  __disable_kprobe+0x2de/0x4b0=0D
[   36.143111]  disable_kprobe+0x31/0x80=0D
[   36.143370]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.143683]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.144002]  kprobe_register+0x4e/0xf0=0D
[   36.144270]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.144621]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.144921]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.145268]  _free_event+0x220/0x11c0=0D
[   36.145540]  put_event+0x4d/0x60=0D
[   36.145775]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.146136]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.146495]  ? write_comp_data+0x2f/0x90=0D
[   36.146793]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.147140]  ? __pfx_perf_release+0x10/0x10=0D
[   36.147431]  perf_release+0x40/0x50=0D
[   36.147681]  __fput+0x26d/0xa40=0D
[   36.147924]  ____fput+0x1e/0x30=0D
[   36.148152]  task_work_run+0x1a4/0x2d0=0D
[   36.148429]  ? write_comp_data+0x2f/0x90=0D
[   36.148710]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.149007]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.149345]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.149639]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.149980]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.150297]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.150618]  do_syscall_64+0x4a/0x90=0D
[   36.150877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.151210] RIP: 0033:0x7f3840f1059d=0D
[   36.151469] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.152601] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.153076] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.153518] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.153984] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.154425] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.154894] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.155364]  </TASK>=0D
[   36.197646] FAULT_INJECTION: forcing a failure.=0D
[   36.197646] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.198592] CPU: 1 PID: 591 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.199284] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.200156] Call Trace:=0D
[   36.200370]  <TASK>=0D
[   36.200568]  dump_stack_lvl+0xa7/0xdb=0D
[   36.200908]  dump_stack+0x19/0x1f=0D
[   36.201210]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.201580]  __should_failslab+0xca/0x120=0D
[   36.201956]  should_failslab+0x12/0x30=0D
[   36.202272]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.202660]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.203036]  kmalloc_trace+0x2e/0x120=0D
[   36.203368]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.203735]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.204231]  ? write_comp_data+0x2f/0x90=0D
[   36.204597]  ftrace_set_hash+0x445/0x590=0D
[   36.204985]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.205373]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.205816]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.206191]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.206611]  ? write_comp_data+0x2f/0x90=0D
[   36.206978]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.207444]  disarm_kprobe+0x24a/0x2d0=0D
[   36.207776]  __disable_kprobe+0x2de/0x4b0=0D
[   36.208141]  disable_kprobe+0x31/0x80=0D
[   36.208484]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.208909]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.209320]  kprobe_register+0x4e/0xf0=0D
[   36.209682]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.210077]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.210366]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.210695]  _free_event+0x220/0x11c0=0D
[   36.211004]  put_event+0x4d/0x60=0D
[   36.211304]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.211713]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.212162]  ? write_comp_data+0x2f/0x90=0D
[   36.212526]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.212959]  ? __pfx_perf_release+0x10/0x10=0D
[   36.213331]  perf_release+0x40/0x50=0D
[   36.213656]  __fput+0x26d/0xa40=0D
[   36.214174]  ____fput+0x1e/0x30=0D
[   36.214660]  task_work_run+0x1a4/0x2d0=0D
[   36.215210]  ? write_comp_data+0x2f/0x90=0D
[   36.215787]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.216403]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.217074]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.217702]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.218429]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.219113]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.219775]  do_syscall_64+0x4a/0x90=0D
[   36.220305]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.221025] RIP: 0033:0x7f3840f1059d=0D
[   36.221566] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.224112] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.225204] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.226222] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.227203] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.228174] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.229149] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.230164]  </TASK>=0D
[   36.273246] FAULT_INJECTION: forcing a failure.=0D
[   36.273246] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.274259] CPU: 1 PID: 592 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.274974] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.275899] Call Trace:=0D
[   36.276119]  <TASK>=0D
[   36.276315]  dump_stack_lvl+0xa7/0xdb=0D
[   36.276667]  dump_stack+0x19/0x1f=0D
[   36.276976]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.277370]  __should_failslab+0xca/0x120=0D
[   36.277734]  should_failslab+0x12/0x30=0D
[   36.278091]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.278506]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.278908]  kmalloc_trace+0x2e/0x120=0D
[   36.279259]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.279651]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.280178]  ? write_comp_data+0x2f/0x90=0D
[   36.280570]  ftrace_set_hash+0x445/0x590=0D
[   36.280977]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.281404]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.281868]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.282263]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.282664]  ? write_comp_data+0x2f/0x90=0D
[   36.283055]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.283530]  disarm_kprobe+0x24a/0x2d0=0D
[   36.283897]  __disable_kprobe+0x2de/0x4b0=0D
[   36.284285]  disable_kprobe+0x31/0x80=0D
[   36.284640]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.285073]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.285452]  kprobe_register+0x4e/0xf0=0D
[   36.285789]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.286258]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.286669]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.287138]  _free_event+0x220/0x11c0=0D
[   36.287496]  put_event+0x4d/0x60=0D
[   36.287785]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.288204]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.288645]  ? write_comp_data+0x2f/0x90=0D
[   36.288998]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.289429]  ? __pfx_perf_release+0x10/0x10=0D
[   36.289794]  perf_release+0x40/0x50=0D
[   36.290103]  __fput+0x26d/0xa40=0D
[   36.290416]  ____fput+0x1e/0x30=0D
[   36.290692]  task_work_run+0x1a4/0x2d0=0D
[   36.291018]  ? write_comp_data+0x2f/0x90=0D
[   36.291369]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.291740]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.292142]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.292506]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.292928]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.293326]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.293728]  do_syscall_64+0x4a/0x90=0D
[   36.294058]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.294477] RIP: 0033:0x7f3840f1059d=0D
[   36.294785] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.296358] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.297029] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.297650] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.298282] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.298895] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.299521] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.300189]  </TASK>=0D
[   36.343856] FAULT_INJECTION: forcing a failure.=0D
[   36.343856] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.344602] CPU: 1 PID: 593 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.345142] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.345852] Call Trace:=0D
[   36.346023]  <TASK>=0D
[   36.346172]  dump_stack_lvl+0xa7/0xdb=0D
[   36.346475]  dump_stack+0x19/0x1f=0D
[   36.346759]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.347091]  __should_failslab+0xca/0x120=0D
[   36.347364]  should_failslab+0x12/0x30=0D
[   36.347611]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.347910]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.348190]  kmalloc_trace+0x2e/0x120=0D
[   36.348439]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.348710]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.349092]  ? write_comp_data+0x2f/0x90=0D
[   36.349368]  ftrace_set_hash+0x445/0x590=0D
[   36.349648]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.349950]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.350271]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.350545]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.350859]  ? write_comp_data+0x2f/0x90=0D
[   36.351143]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.351489]  disarm_kprobe+0x24a/0x2d0=0D
[   36.351751]  __disable_kprobe+0x2de/0x4b0=0D
[   36.352034]  disable_kprobe+0x31/0x80=0D
[   36.352294]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.352606]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.352911]  kprobe_register+0x4e/0xf0=0D
[   36.353175]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.353523]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.353822]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.354153]  _free_event+0x220/0x11c0=0D
[   36.354420]  put_event+0x4d/0x60=0D
[   36.354652]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.354985]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.355338]  ? write_comp_data+0x2f/0x90=0D
[   36.355617]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.355946]  ? __pfx_perf_release+0x10/0x10=0D
[   36.356233]  perf_release+0x40/0x50=0D
[   36.356487]  __fput+0x26d/0xa40=0D
[   36.356731]  ____fput+0x1e/0x30=0D
[   36.356958]  task_work_run+0x1a4/0x2d0=0D
[   36.357222]  ? write_comp_data+0x2f/0x90=0D
[   36.357511]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.357813]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.358135]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.358433]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.358767]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.359088]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.359405]  do_syscall_64+0x4a/0x90=0D
[   36.359658]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.359993] RIP: 0033:0x7f3840f1059d=0D
[   36.360238] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.361378] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.361869] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.362318] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.362766] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.363214] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.363648] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.364107]  </TASK>=0D
[   36.401082] FAULT_INJECTION: forcing a failure.=0D
[   36.401082] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.402078] CPU: 1 PID: 594 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.402812] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.403758] Call Trace:=0D
[   36.403979]  <TASK>=0D
[   36.404171]  dump_stack_lvl+0xa7/0xdb=0D
[   36.404506]  dump_stack+0x19/0x1f=0D
[   36.404825]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.405233]  __should_failslab+0xca/0x120=0D
[   36.405608]  should_failslab+0x12/0x30=0D
[   36.406009]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.406422]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.406834]  kmalloc_trace+0x2e/0x120=0D
[   36.407180]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.407566]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.408110]  ? write_comp_data+0x2f/0x90=0D
[   36.408481]  ftrace_set_hash+0x445/0x590=0D
[   36.408880]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.409303]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.409764]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.410085]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.410415]  ? write_comp_data+0x2f/0x90=0D
[   36.410701]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.411050]  disarm_kprobe+0x24a/0x2d0=0D
[   36.411320]  __disable_kprobe+0x2de/0x4b0=0D
[   36.411609]  disable_kprobe+0x31/0x80=0D
[   36.411871]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.412188]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.412493]  kprobe_register+0x4e/0xf0=0D
[   36.412758]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.413107]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.413398]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.413729]  _free_event+0x220/0x11c0=0D
[   36.414005]  put_event+0x4d/0x60=0D
[   36.414240]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.414574]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.414929]  ? write_comp_data+0x2f/0x90=0D
[   36.415211]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.415553]  ? __pfx_perf_release+0x10/0x10=0D
[   36.415847]  perf_release+0x40/0x50=0D
[   36.416098]  __fput+0x26d/0xa40=0D
[   36.416341]  ____fput+0x1e/0x30=0D
[   36.416568]  task_work_run+0x1a4/0x2d0=0D
[   36.416834]  ? write_comp_data+0x2f/0x90=0D
[   36.417114]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.417410]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.417733]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.418039]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.418376]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.418697]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.419011]  do_syscall_64+0x4a/0x90=0D
[   36.419265]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.419602] RIP: 0033:0x7f3840f1059d=0D
[   36.419849] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.420995] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.421479] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.421955] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.422406] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.422855] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.423305] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.423780]  </TASK>=0D
[   36.455943] FAULT_INJECTION: forcing a failure.=0D
[   36.455943] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.456913] CPU: 1 PID: 595 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.457462] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.458234] Call Trace:=0D
[   36.458509]  <TASK>=0D
[   36.458669]  dump_stack_lvl+0xa7/0xdb=0D
[   36.458937]  dump_stack+0x19/0x1f=0D
[   36.459171]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.459466]  __should_failslab+0xca/0x120=0D
[   36.459748]  should_failslab+0x12/0x30=0D
[   36.460150]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.460465]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.460765]  kmalloc_trace+0x2e/0x120=0D
[   36.461025]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.461308]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.461799]  ? write_comp_data+0x2f/0x90=0D
[   36.462087]  ftrace_set_hash+0x445/0x590=0D
[   36.462383]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.462691]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.463055]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.463399]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.463732]  ? write_comp_data+0x2f/0x90=0D
[   36.464016]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.464366]  disarm_kprobe+0x24a/0x2d0=0D
[   36.464715]  __disable_kprobe+0x2de/0x4b0=0D
[   36.465005]  disable_kprobe+0x31/0x80=0D
[   36.465266]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.465580]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.465920]  kprobe_register+0x4e/0xf0=0D
[   36.466221]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.466576]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.466871]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.467209]  _free_event+0x220/0x11c0=0D
[   36.467486]  put_event+0x4d/0x60=0D
[   36.467788]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.468129]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.468489]  ? write_comp_data+0x2f/0x90=0D
[   36.468775]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.469143]  ? __pfx_perf_release+0x10/0x10=0D
[   36.469458]  perf_release+0x40/0x50=0D
[   36.469713]  __fput+0x26d/0xa40=0D
[   36.469987]  ____fput+0x1e/0x30=0D
[   36.470221]  task_work_run+0x1a4/0x2d0=0D
[   36.470492]  ? write_comp_data+0x2f/0x90=0D
[   36.470848]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.471153]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.471484]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.471793]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.472137]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.472613]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.472940]  do_syscall_64+0x4a/0x90=0D
[   36.473196]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.473537] RIP: 0033:0x7f3840f1059d=0D
[   36.473902] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.475048] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.475699] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.476156] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.476612] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.477156] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.477607] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.478097]  </TASK>=0D
[   36.530643] FAULT_INJECTION: forcing a failure.=0D
[   36.530643] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.532232] CPU: 1 PID: 596 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.533409] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.534969] Call Trace:=0D
[   36.535343]  <TASK>=0D
[   36.535674]  dump_stack_lvl+0xa7/0xdb=0D
[   36.536232]  dump_stack+0x19/0x1f=0D
[   36.536733]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.537345]  __should_failslab+0xca/0x120=0D
[   36.537949]  should_failslab+0x12/0x30=0D
[   36.538493]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.539150]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.539767]  kmalloc_trace+0x2e/0x120=0D
[   36.540318]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.540915]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.541755]  ? write_comp_data+0x2f/0x90=0D
[   36.542361]  ftrace_set_hash+0x445/0x590=0D
[   36.542964]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.543600]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.544301]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.544902]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.545611]  ? write_comp_data+0x2f/0x90=0D
[   36.546237]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.547019]  disarm_kprobe+0x24a/0x2d0=0D
[   36.547608]  __disable_kprobe+0x2de/0x4b0=0D
[   36.548226]  disable_kprobe+0x31/0x80=0D
[   36.548795]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.549487]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.550174]  kprobe_register+0x4e/0xf0=0D
[   36.550759]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.551497]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.552106]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.552798]  _free_event+0x220/0x11c0=0D
[   36.553360]  put_event+0x4d/0x60=0D
[   36.553900]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.554326]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.554766]  ? write_comp_data+0x2f/0x90=0D
[   36.555111]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.555513]  ? __pfx_perf_release+0x10/0x10=0D
[   36.555859]  perf_release+0x40/0x50=0D
[   36.556153]  __fput+0x26d/0xa40=0D
[   36.556436]  ____fput+0x1e/0x30=0D
[   36.556707]  task_work_run+0x1a4/0x2d0=0D
[   36.557024]  ? write_comp_data+0x2f/0x90=0D
[   36.557358]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.557716]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.558117]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.558476]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.558884]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.559277]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.559660]  do_syscall_64+0x4a/0x90=0D
[   36.559963]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.560369] RIP: 0033:0x7f3840f1059d=0D
[   36.560665] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.562065] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.562652] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.563203] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.563756] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.564306] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.564872] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.565385]  </TASK>=0D
[   36.604566] FAULT_INJECTION: forcing a failure.=0D
[   36.604566] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.606100] CPU: 1 PID: 597 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.607242] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.608738] Call Trace:=0D
[   36.609089]  <TASK>=0D
[   36.609402]  dump_stack_lvl+0xa7/0xdb=0D
[   36.609956]  dump_stack+0x19/0x1f=0D
[   36.610449]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.611046]  __should_failslab+0xca/0x120=0D
[   36.611616]  should_failslab+0x12/0x30=0D
[   36.612237]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.612979]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.613684]  kmalloc_trace+0x2e/0x120=0D
[   36.614312]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.614992]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.615978]  ? write_comp_data+0x2f/0x90=0D
[   36.616683]  ftrace_set_hash+0x445/0x590=0D
[   36.617383]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.618149]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.618933]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.619644]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.620466]  ? write_comp_data+0x2f/0x90=0D
[   36.621167]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.622062]  disarm_kprobe+0x24a/0x2d0=0D
[   36.622720]  __disable_kprobe+0x2de/0x4b0=0D
[   36.623423]  disable_kprobe+0x31/0x80=0D
[   36.624065]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.624842]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.625602]  kprobe_register+0x4e/0xf0=0D
[   36.626275]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.627162]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.628003]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.628749]  _free_event+0x220/0x11c0=0D
[   36.629340]  put_event+0x4d/0x60=0D
[   36.629874]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.630658]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.631464]  ? write_comp_data+0x2f/0x90=0D
[   36.632090]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.632900]  ? __pfx_perf_release+0x10/0x10=0D
[   36.633674]  perf_release+0x40/0x50=0D
[   36.634339]  __fput+0x26d/0xa40=0D
[   36.634955]  ____fput+0x1e/0x30=0D
[   36.635551]  task_work_run+0x1a4/0x2d0=0D
[   36.636244]  ? write_comp_data+0x2f/0x90=0D
[   36.636971]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.637748]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.638619]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.639351]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.639815]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.640233]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.640584]  do_syscall_64+0x4a/0x90=0D
[   36.640849]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.641211] RIP: 0033:0x7f3840f1059d=0D
[   36.641530] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.642828] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.643325] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.643809] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.644393] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.644943] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.645459] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.645995]  </TASK>=0D
[   36.697579] FAULT_INJECTION: forcing a failure.=0D
[   36.697579] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.698581] CPU: 1 PID: 598 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.699329] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.700112] Call Trace:=0D
[   36.700290]  <TASK>=0D
[   36.700448]  dump_stack_lvl+0xa7/0xdb=0D
[   36.700726]  dump_stack+0x19/0x1f=0D
[   36.700969]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.701276]  __should_failslab+0xca/0x120=0D
[   36.701566]  should_failslab+0x12/0x30=0D
[   36.701848]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.702173]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.702479]  kmalloc_trace+0x2e/0x120=0D
[   36.702746]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.703040]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.703472]  ? write_comp_data+0x2f/0x90=0D
[   36.703767]  ftrace_set_hash+0x445/0x590=0D
[   36.704064]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.704363]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.704693]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.704977]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.705298]  ? write_comp_data+0x2f/0x90=0D
[   36.705578]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.705932]  disarm_kprobe+0x24a/0x2d0=0D
[   36.706195]  __disable_kprobe+0x2de/0x4b0=0D
[   36.706481]  disable_kprobe+0x31/0x80=0D
[   36.706738]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.707046]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.707350]  kprobe_register+0x4e/0xf0=0D
[   36.707627]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.707982]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.708269]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.708596]  _free_event+0x220/0x11c0=0D
[   36.708861]  put_event+0x4d/0x60=0D
[   36.709092]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.709466]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.709909]  ? write_comp_data+0x2f/0x90=0D
[   36.710208]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.710555]  ? __pfx_perf_release+0x10/0x10=0D
[   36.710840]  perf_release+0x40/0x50=0D
[   36.711086]  __fput+0x26d/0xa40=0D
[   36.711328]  ____fput+0x1e/0x30=0D
[   36.711551]  task_work_run+0x1a4/0x2d0=0D
[   36.711813]  ? write_comp_data+0x2f/0x90=0D
[   36.712091]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.712384]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.712702]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.712997]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.713415]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.713748]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.714066]  do_syscall_64+0x4a/0x90=0D
[   36.714329]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.714678] RIP: 0033:0x7f3840f1059d=0D
[   36.714920] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.716044] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.716523] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.716966] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.717411] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.717865] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.718307] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.718774]  </TASK>=0D
[   36.775290] FAULT_INJECTION: forcing a failure.=0D
[   36.775290] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.776233] CPU: 1 PID: 599 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.776934] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.777839] Call Trace:=0D
[   36.778006]  <TASK>=0D
[   36.778152]  dump_stack_lvl+0xa7/0xdb=0D
[   36.778409]  dump_stack+0x19/0x1f=0D
[   36.778634]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.778923]  __should_failslab+0xca/0x120=0D
[   36.779196]  should_failslab+0x12/0x30=0D
[   36.779448]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.779748]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.780032]  kmalloc_trace+0x2e/0x120=0D
[   36.780281]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.780552]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.780936]  ? write_comp_data+0x2f/0x90=0D
[   36.781214]  ftrace_set_hash+0x445/0x590=0D
[   36.781496]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.781795]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.782123]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.782402]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.782717]  ? write_comp_data+0x2f/0x90=0D
[   36.782992]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.783330]  disarm_kprobe+0x24a/0x2d0=0D
[   36.783589]  __disable_kprobe+0x2de/0x4b0=0D
[   36.783863]  disable_kprobe+0x31/0x80=0D
[   36.784115]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.784423]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.784720]  kprobe_register+0x4e/0xf0=0D
[   36.784980]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.785321]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.785604]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.785934]  _free_event+0x220/0x11c0=0D
[   36.786196]  put_event+0x4d/0x60=0D
[   36.786425]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.786752]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.787098]  ? write_comp_data+0x2f/0x90=0D
[   36.787371]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.787694]  ? __pfx_perf_release+0x10/0x10=0D
[   36.787974]  perf_release+0x40/0x50=0D
[   36.788216]  __fput+0x26d/0xa40=0D
[   36.788453]  ____fput+0x1e/0x30=0D
[   36.788674]  task_work_run+0x1a4/0x2d0=0D
[   36.788930]  ? write_comp_data+0x2f/0x90=0D
[   36.789203]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.789490]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.789814]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.790107]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.790440]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.790779]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.791115]  do_syscall_64+0x4a/0x90=0D
[   36.791370]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.791708] RIP: 0033:0x7f3840f1059d=0D
[   36.791955] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.793119] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.793615] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.794081] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.794547] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.795021] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.795488] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.795964]  </TASK>=0D
[   36.836743] FAULT_INJECTION: forcing a failure.=0D
[   36.836743] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.838379] CPU: 1 PID: 600 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.839608] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.841176] Call Trace:=0D
[   36.841554]  <TASK>=0D
[   36.841894]  dump_stack_lvl+0xa7/0xdb=0D
[   36.842465]  dump_stack+0x19/0x1f=0D
[   36.842981]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.843594]  __should_failslab+0xca/0x120=0D
[   36.844177]  should_failslab+0x12/0x30=0D
[   36.844719]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.845367]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.845988]  kmalloc_trace+0x2e/0x120=0D
[   36.846529]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.847118]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.847951]  ? write_comp_data+0x2f/0x90=0D
[   36.848537]  ftrace_set_hash+0x445/0x590=0D
[   36.849127]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.849751]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.850453]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.851043]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.851714]  ? write_comp_data+0x2f/0x90=0D
[   36.852295]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.853020]  disarm_kprobe+0x24a/0x2d0=0D
[   36.853569]  __disable_kprobe+0x2de/0x4b0=0D
[   36.854172]  disable_kprobe+0x31/0x80=0D
[   36.854709]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.855358]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.855991]  kprobe_register+0x4e/0xf0=0D
[   36.856548]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.857250]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.857850]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.858310]  _free_event+0x220/0x11c0=0D
[   36.858573]  put_event+0x4d/0x60=0D
[   36.858793]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.859108]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.859447]  ? write_comp_data+0x2f/0x90=0D
[   36.859709]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.860020]  ? __pfx_perf_release+0x10/0x10=0D
[   36.860290]  perf_release+0x40/0x50=0D
[   36.860524]  __fput+0x26d/0xa40=0D
[   36.860753]  ____fput+0x1e/0x30=0D
[   36.860966]  task_work_run+0x1a4/0x2d0=0D
[   36.861215]  ? write_comp_data+0x2f/0x90=0D
[   36.861479]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.861758]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.862076]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.862356]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.862676]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.862982]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.863280]  do_syscall_64+0x4a/0x90=0D
[   36.863520]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.863837] RIP: 0033:0x7f3840f1059d=0D
[   36.864112] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.865208] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.865672] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.866126] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.866563] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.867015] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.867441] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.867890]  </TASK>=0D
[   36.909952] FAULT_INJECTION: forcing a failure.=0D
[   36.909952] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.911569] CPU: 1 PID: 601 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.912794] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.914349] Call Trace:=0D
[   36.914719]  <TASK>=0D
[   36.915063]  dump_stack_lvl+0xa7/0xdb=0D
[   36.915694]  dump_stack+0x19/0x1f=0D
[   36.916258]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.916949]  __should_failslab+0xca/0x120=0D
[   36.917622]  should_failslab+0x12/0x30=0D
[   36.918261]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.919009]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.919709]  kmalloc_trace+0x2e/0x120=0D
[   36.920327]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.920994]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.921962]  ? write_comp_data+0x2f/0x90=0D
[   36.922638]  ftrace_set_hash+0x445/0x590=0D
[   36.923340]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.924059]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.924858]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.925537]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.926340]  ? write_comp_data+0x2f/0x90=0D
[   36.927008]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   36.927847]  disarm_kprobe+0x24a/0x2d0=0D
[   36.928478]  __disable_kprobe+0x2de/0x4b0=0D
[   36.929146]  disable_kprobe+0x31/0x80=0D
[   36.929724]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   36.930014]  disable_trace_kprobe+0x1f0/0x300=0D
[   36.930314]  kprobe_register+0x4e/0xf0=0D
[   36.930563]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   36.930901]  perf_kprobe_destroy+0xcb/0x200=0D
[   36.931167]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   36.931484]  _free_event+0x220/0x11c0=0D
[   36.931737]  put_event+0x4d/0x60=0D
[   36.931954]  perf_event_release_kernel+0x5d9/0x860=0D
[   36.932267]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   36.932611]  ? write_comp_data+0x2f/0x90=0D
[   36.932876]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   36.933186]  ? __pfx_perf_release+0x10/0x10=0D
[   36.933461]  perf_release+0x40/0x50=0D
[   36.933698]  __fput+0x26d/0xa40=0D
[   36.933937]  ____fput+0x1e/0x30=0D
[   36.934151]  task_work_run+0x1a4/0x2d0=0D
[   36.934398]  ? write_comp_data+0x2f/0x90=0D
[   36.934675]  ? __pfx_task_work_run+0x10/0x10=0D
[   36.934955]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.935259]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   36.935540]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   36.935866]  exit_to_user_mode_prepare+0x200/0x210=0D
[   36.936166]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   36.936471]  do_syscall_64+0x4a/0x90=0D
[   36.936723]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   36.937058] RIP: 0033:0x7f3840f1059d=0D
[   36.937294] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   36.938403] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   36.938879] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   36.939324] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   36.939778] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   36.940223] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   36.940653] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   36.941133]  </TASK>=0D
[   36.992818] FAULT_INJECTION: forcing a failure.=0D
[   36.992818] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   36.993551] CPU: 1 PID: 602 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   36.994094] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   36.994779] Call Trace:=0D
[   36.994939]  <TASK>=0D
[   36.995081]  dump_stack_lvl+0xa7/0xdb=0D
[   36.995352]  dump_stack+0x19/0x1f=0D
[   36.995583]  should_fail_ex.cold.5+0x5/0xa=0D
[   36.995871]  __should_failslab+0xca/0x120=0D
[   36.996147]  should_failslab+0x12/0x30=0D
[   36.996412]  __kmem_cache_alloc_node+0x62/0x280=0D
[   36.996717]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   36.997008]  kmalloc_trace+0x2e/0x120=0D
[   36.997268]  alloc_ftrace_hash+0x4f/0x170=0D
[   36.997556]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   36.997959]  ? write_comp_data+0x2f/0x90=0D
[   36.998239]  ftrace_set_hash+0x445/0x590=0D
[   36.998539]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   36.998861]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   36.999204]  ? match_dev_by_uuid+0x4/0x100=0D
[   36.999504]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   36.999828]  ? write_comp_data+0x2f/0x90=0D
[   37.000104]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.000444]  disarm_kprobe+0x24a/0x2d0=0D
[   37.000715]  __disable_kprobe+0x2de/0x4b0=0D
[   37.000989]  disable_kprobe+0x31/0x80=0D
[   37.001241]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.001545]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.001861]  kprobe_register+0x4e/0xf0=0D
[   37.002127]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.002468]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.002780]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.003102]  _free_event+0x220/0x11c0=0D
[   37.003364]  put_event+0x4d/0x60=0D
[   37.003591]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.003919]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.004266]  ? write_comp_data+0x2f/0x90=0D
[   37.004538]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.004861]  ? __pfx_perf_release+0x10/0x10=0D
[   37.005146]  perf_release+0x40/0x50=0D
[   37.005389]  __fput+0x26d/0xa40=0D
[   37.005625]  ____fput+0x1e/0x30=0D
[   37.005855]  task_work_run+0x1a4/0x2d0=0D
[   37.006121]  ? write_comp_data+0x2f/0x90=0D
[   37.006426]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.006715]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.007029]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.007322]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.007651]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.007964]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.008273]  do_syscall_64+0x4a/0x90=0D
[   37.008519]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.008858] RIP: 0033:0x7f3840f1059d=0D
[   37.009100] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.010235] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.010724] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.011166] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.011604] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.012054] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.012494] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.012973]  </TASK>=0D
[   37.048651] FAULT_INJECTION: forcing a failure.=0D
[   37.048651] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.049520] CPU: 1 PID: 603 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.050163] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.050993] Call Trace:=0D
[   37.051189]  <TASK>=0D
[   37.051367]  dump_stack_lvl+0xa7/0xdb=0D
[   37.051676]  dump_stack+0x19/0x1f=0D
[   37.051948]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.052304]  __should_failslab+0xca/0x120=0D
[   37.052580]  should_failslab+0x12/0x30=0D
[   37.052861]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.053173]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.053461]  kmalloc_trace+0x2e/0x120=0D
[   37.053717]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.054082]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.054573]  ? write_comp_data+0x2f/0x90=0D
[   37.054892]  ftrace_set_hash+0x445/0x590=0D
[   37.055202]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.055501]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.055838]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.056118]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.056436]  ? write_comp_data+0x2f/0x90=0D
[   37.056713]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.057055]  disarm_kprobe+0x24a/0x2d0=0D
[   37.057310]  __disable_kprobe+0x2de/0x4b0=0D
[   37.057590]  disable_kprobe+0x31/0x80=0D
[   37.057851]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.058162]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.058457]  kprobe_register+0x4e/0xf0=0D
[   37.058716]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.059058]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.059345]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.059674]  _free_event+0x220/0x11c0=0D
[   37.059937]  put_event+0x4d/0x60=0D
[   37.060164]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.060494]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.060843]  ? write_comp_data+0x2f/0x90=0D
[   37.061113]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.061437]  ? __pfx_perf_release+0x10/0x10=0D
[   37.061713]  perf_release+0x40/0x50=0D
[   37.062023]  __fput+0x26d/0xa40=0D
[   37.062257]  ____fput+0x1e/0x30=0D
[   37.062481]  task_work_run+0x1a4/0x2d0=0D
[   37.062737]  ? write_comp_data+0x2f/0x90=0D
[   37.063012]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.063301]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.063630]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.063932]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.064275]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.064599]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.064916]  do_syscall_64+0x4a/0x90=0D
[   37.065167]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.065525] RIP: 0033:0x7f3840f1059d=0D
[   37.065776] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.066986] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.067489] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.067959] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.068421] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.068898] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.069366] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.069852]  </TASK>=0D
[   37.112815] FAULT_INJECTION: forcing a failure.=0D
[   37.112815] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.113799] CPU: 1 PID: 604 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.114353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.115039] Call Trace:=0D
[   37.115218]  <TASK>=0D
[   37.115366]  dump_stack_lvl+0xa7/0xdb=0D
[   37.115621]  dump_stack+0x19/0x1f=0D
[   37.115846]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.116129]  __should_failslab+0xca/0x120=0D
[   37.116399]  should_failslab+0x12/0x30=0D
[   37.116648]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.116948]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.117232]  kmalloc_trace+0x2e/0x120=0D
[   37.117481]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.117753]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.118148]  ? write_comp_data+0x2f/0x90=0D
[   37.118424]  ftrace_set_hash+0x445/0x590=0D
[   37.118710]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.119003]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.119326]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.119605]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.119925]  ? write_comp_data+0x2f/0x90=0D
[   37.120200]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.120537]  disarm_kprobe+0x24a/0x2d0=0D
[   37.120796]  __disable_kprobe+0x2de/0x4b0=0D
[   37.121068]  disable_kprobe+0x31/0x80=0D
[   37.121319]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.121621]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.121944]  kprobe_register+0x4e/0xf0=0D
[   37.122212]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.122553]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.122853]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.123185]  _free_event+0x220/0x11c0=0D
[   37.123444]  put_event+0x4d/0x60=0D
[   37.123674]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.124015]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.124360]  ? write_comp_data+0x2f/0x90=0D
[   37.124635]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.124961]  ? __pfx_perf_release+0x10/0x10=0D
[   37.125261]  perf_release+0x40/0x50=0D
[   37.125507]  __fput+0x26d/0xa40=0D
[   37.125748]  ____fput+0x1e/0x30=0D
[   37.125981]  task_work_run+0x1a4/0x2d0=0D
[   37.126254]  ? write_comp_data+0x2f/0x90=0D
[   37.126533]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.126845]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.127164]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.127479]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.127806]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.128126]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.128451]  do_syscall_64+0x4a/0x90=0D
[   37.128700]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.129028] RIP: 0033:0x7f3840f1059d=0D
[   37.129267] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.130404] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.130903] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.131348] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.131803] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.132254] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.132714] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.133187]  </TASK>=0D
[   37.178353] FAULT_INJECTION: forcing a failure.=0D
[   37.178353] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.179964] CPU: 1 PID: 605 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.181178] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.182426] Call Trace:=0D
[   37.182653]  <TASK>=0D
[   37.182838]  dump_stack_lvl+0xa7/0xdb=0D
[   37.183164]  dump_stack+0x19/0x1f=0D
[   37.183451]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.183810]  __should_failslab+0xca/0x120=0D
[   37.184154]  should_failslab+0x12/0x30=0D
[   37.184472]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.184853]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.185212]  kmalloc_trace+0x2e/0x120=0D
[   37.185526]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.185875]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.186363]  ? write_comp_data+0x2f/0x90=0D
[   37.186711]  ftrace_set_hash+0x445/0x590=0D
[   37.187066]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.187440]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.187851]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.188205]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.188632]  ? write_comp_data+0x2f/0x90=0D
[   37.188981]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.189416]  disarm_kprobe+0x24a/0x2d0=0D
[   37.189741]  __disable_kprobe+0x2de/0x4b0=0D
[   37.190098]  disable_kprobe+0x31/0x80=0D
[   37.190413]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.190797]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.191171]  kprobe_register+0x4e/0xf0=0D
[   37.191496]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.191926]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.192283]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.192690]  _free_event+0x220/0x11c0=0D
[   37.193018]  put_event+0x4d/0x60=0D
[   37.193303]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.193714]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.194155]  ? write_comp_data+0x2f/0x90=0D
[   37.194497]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.194904]  ? __pfx_perf_release+0x10/0x10=0D
[   37.195258]  perf_release+0x40/0x50=0D
[   37.195563]  __fput+0x26d/0xa40=0D
[   37.195854]  ____fput+0x1e/0x30=0D
[   37.196133]  task_work_run+0x1a4/0x2d0=0D
[   37.196456]  ? write_comp_data+0x2f/0x90=0D
[   37.196799]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.197163]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.197563]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.197938]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.198355]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.198753]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.199142]  do_syscall_64+0x4a/0x90=0D
[   37.199452]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.199870] RIP: 0033:0x7f3840f1059d=0D
[   37.200173] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.201612] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.202600] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.203607] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.204599] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.205591] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.206236] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.206720]  </TASK>=0D
[   37.257921] FAULT_INJECTION: forcing a failure.=0D
[   37.257921] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.258912] CPU: 1 PID: 606 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.259619] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.260505] Call Trace:=0D
[   37.260717]  <TASK>=0D
[   37.260914]  dump_stack_lvl+0xa7/0xdb=0D
[   37.261256]  dump_stack+0x19/0x1f=0D
[   37.261553]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.261931]  __should_failslab+0xca/0x120=0D
[   37.262282]  should_failslab+0x12/0x30=0D
[   37.262609]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.263005]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.263393]  kmalloc_trace+0x2e/0x120=0D
[   37.263732]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.264101]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.264624]  ? write_comp_data+0x2f/0x90=0D
[   37.264995]  ftrace_set_hash+0x445/0x590=0D
[   37.265392]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.265813]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.266140]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.266421]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.266739]  ? write_comp_data+0x2f/0x90=0D
[   37.267016]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.267357]  disarm_kprobe+0x24a/0x2d0=0D
[   37.267618]  __disable_kprobe+0x2de/0x4b0=0D
[   37.267896]  disable_kprobe+0x31/0x80=0D
[   37.268149]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.268456]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.268791]  kprobe_register+0x4e/0xf0=0D
[   37.269073]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.269415]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.269702]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.270114]  _free_event+0x220/0x11c0=0D
[   37.270452]  put_event+0x4d/0x60=0D
[   37.270685]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.271015]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.271362]  ? write_comp_data+0x2f/0x90=0D
[   37.271636]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.271961]  ? __pfx_perf_release+0x10/0x10=0D
[   37.272251]  perf_release+0x40/0x50=0D
[   37.272495]  __fput+0x26d/0xa40=0D
[   37.272746]  ____fput+0x1e/0x30=0D
[   37.272970]  task_work_run+0x1a4/0x2d0=0D
[   37.273232]  ? write_comp_data+0x2f/0x90=0D
[   37.273513]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.273817]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.274138]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.274433]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.274764]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.275081]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.275391]  do_syscall_64+0x4a/0x90=0D
[   37.275641]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.275973] RIP: 0033:0x7f3840f1059d=0D
[   37.276231] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.277347] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.277831] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.278274] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.278716] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.279161] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.279601] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.280068]  </TASK>=0D
[   37.321129] FAULT_INJECTION: forcing a failure.=0D
[   37.321129] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.322058] CPU: 1 PID: 607 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.322718] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.323597] Call Trace:=0D
[   37.323811]  <TASK>=0D
[   37.324006]  dump_stack_lvl+0xa7/0xdb=0D
[   37.324348]  dump_stack+0x19/0x1f=0D
[   37.324651]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.325065]  __should_failslab+0xca/0x120=0D
[   37.325427]  should_failslab+0x12/0x30=0D
[   37.325757]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.326156]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.326526]  kmalloc_trace+0x2e/0x120=0D
[   37.326847]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.327201]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.327693]  ? write_comp_data+0x2f/0x90=0D
[   37.328057]  ftrace_set_hash+0x445/0x590=0D
[   37.328434]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.328822]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.329249]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.329629]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.330048]  ? write_comp_data+0x2f/0x90=0D
[   37.330421]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.330877]  disarm_kprobe+0x24a/0x2d0=0D
[   37.331224]  __disable_kprobe+0x2de/0x4b0=0D
[   37.331605]  disable_kprobe+0x31/0x80=0D
[   37.331942]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.332347]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.332755]  kprobe_register+0x4e/0xf0=0D
[   37.333098]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.333562]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.333968]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.334408]  _free_event+0x220/0x11c0=0D
[   37.334766]  put_event+0x4d/0x60=0D
[   37.335073]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.335510]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.335984]  ? write_comp_data+0x2f/0x90=0D
[   37.336369]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.336826]  ? __pfx_perf_release+0x10/0x10=0D
[   37.337219]  perf_release+0x40/0x50=0D
[   37.337558]  __fput+0x26d/0xa40=0D
[   37.337898]  ____fput+0x1e/0x30=0D
[   37.338202]  task_work_run+0x1a4/0x2d0=0D
[   37.338559]  ? write_comp_data+0x2f/0x90=0D
[   37.338933]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.339326]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.339768]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.340178]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.340643]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.341082]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.341506]  do_syscall_64+0x4a/0x90=0D
[   37.341852]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.342191] RIP: 0033:0x7f3840f1059d=0D
[   37.342444] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.343573] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.344051] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.344494] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.344937] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.345380] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.345841] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.346312]  </TASK>=0D
[   37.388878] FAULT_INJECTION: forcing a failure.=0D
[   37.388878] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.389800] CPU: 1 PID: 608 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.390460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.391311] Call Trace:=0D
[   37.391517]  <TASK>=0D
[   37.391705]  dump_stack_lvl+0xa7/0xdb=0D
[   37.392034]  dump_stack+0x19/0x1f=0D
[   37.392327]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.392701]  __should_failslab+0xca/0x120=0D
[   37.393049]  should_failslab+0x12/0x30=0D
[   37.393369]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.393757]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.394067]  kmalloc_trace+0x2e/0x120=0D
[   37.394316]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.394588]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.394969]  ? write_comp_data+0x2f/0x90=0D
[   37.395246]  ftrace_set_hash+0x445/0x590=0D
[   37.395538]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.395840]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.396175]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.396458]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.396781]  ? write_comp_data+0x2f/0x90=0D
[   37.397065]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.397413]  disarm_kprobe+0x24a/0x2d0=0D
[   37.397680]  __disable_kprobe+0x2de/0x4b0=0D
[   37.397970]  disable_kprobe+0x31/0x80=0D
[   37.398235]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.398551]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.398855]  kprobe_register+0x4e/0xf0=0D
[   37.399120]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.399471]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.399762]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.400091]  _free_event+0x220/0x11c0=0D
[   37.400360]  put_event+0x4d/0x60=0D
[   37.400603]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.400944]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.401303]  ? write_comp_data+0x2f/0x90=0D
[   37.401587]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.401921]  ? __pfx_perf_release+0x10/0x10=0D
[   37.402204]  perf_release+0x40/0x50=0D
[   37.402452]  __fput+0x26d/0xa40=0D
[   37.402732]  ____fput+0x1e/0x30=0D
[   37.402958]  task_work_run+0x1a4/0x2d0=0D
[   37.403217]  ? write_comp_data+0x2f/0x90=0D
[   37.403493]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.403797]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.404120]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.404417]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.404745]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.405066]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.405367]  do_syscall_64+0x4a/0x90=0D
[   37.405609]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.405954] RIP: 0033:0x7f3840f1059d=0D
[   37.406190] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.407295] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.407759] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.408202] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.408639] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.409077] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.409515] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.409980]  </TASK>=0D
[   37.465007] FAULT_INJECTION: forcing a failure.=0D
[   37.465007] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.465950] CPU: 0 PID: 609 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.466635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.467554] Call Trace:=0D
[   37.467777]  <TASK>=0D
[   37.467974]  dump_stack_lvl+0xa7/0xdb=0D
[   37.468324]  dump_stack+0x19/0x1f=0D
[   37.468637]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.469032]  __should_failslab+0xca/0x120=0D
[   37.469405]  should_failslab+0x12/0x30=0D
[   37.469746]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.470072]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.470351]  kmalloc_trace+0x2e/0x120=0D
[   37.470595]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.470861]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.471235]  ? write_comp_data+0x2f/0x90=0D
[   37.471506]  ftrace_set_hash+0x445/0x590=0D
[   37.471783]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.472070]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.472388]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.472658]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.472973]  ? write_comp_data+0x2f/0x90=0D
[   37.473250]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.473591]  disarm_kprobe+0x24a/0x2d0=0D
[   37.473863]  __disable_kprobe+0x2de/0x4b0=0D
[   37.474141]  disable_kprobe+0x31/0x80=0D
[   37.474393]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.474709]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.475007]  kprobe_register+0x4e/0xf0=0D
[   37.475267]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.475605]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.475890]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.476215]  _free_event+0x220/0x11c0=0D
[   37.476482]  put_event+0x4d/0x60=0D
[   37.476711]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.477040]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.477395]  ? write_comp_data+0x2f/0x90=0D
[   37.477671]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.478006]  ? __pfx_perf_release+0x10/0x10=0D
[   37.478297]  perf_release+0x40/0x50=0D
[   37.478541]  __fput+0x26d/0xa40=0D
[   37.478796]  ____fput+0x1e/0x30=0D
[   37.479018]  task_work_run+0x1a4/0x2d0=0D
[   37.479283]  ? write_comp_data+0x2f/0x90=0D
[   37.479559]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.479848]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.480165]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.480459]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.480790]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.481106]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.481416]  do_syscall_64+0x4a/0x90=0D
[   37.481663]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.481997] RIP: 0033:0x7f3840f1059d=0D
[   37.482237] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.483351] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.483826] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.484268] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.484709] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.485160] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.485600] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.486076]  </TASK>=0D
[   37.530981] FAULT_INJECTION: forcing a failure.=0D
[   37.530981] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.531901] CPU: 1 PID: 610 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.532411] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.533093] Call Trace:=0D
[   37.533254]  <TASK>=0D
[   37.533399]  dump_stack_lvl+0xa7/0xdb=0D
[   37.533653]  dump_stack+0x19/0x1f=0D
[   37.533913]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.534201]  __should_failslab+0xca/0x120=0D
[   37.534472]  should_failslab+0x12/0x30=0D
[   37.534716]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.535012]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.535299]  kmalloc_trace+0x2e/0x120=0D
[   37.535546]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.535821]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.536202]  ? write_comp_data+0x2f/0x90=0D
[   37.536482]  ftrace_set_hash+0x445/0x590=0D
[   37.536765]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.537061]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.537393]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.537678]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.538007]  ? write_comp_data+0x2f/0x90=0D
[   37.538289]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.538634]  disarm_kprobe+0x24a/0x2d0=0D
[   37.538899]  __disable_kprobe+0x2de/0x4b0=0D
[   37.539179]  disable_kprobe+0x31/0x80=0D
[   37.539436]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.539746]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.540047]  kprobe_register+0x4e/0xf0=0D
[   37.540299]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.540649]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.540941]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.541272]  _free_event+0x220/0x11c0=0D
[   37.541541]  put_event+0x4d/0x60=0D
[   37.541772]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.542113]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.542468]  ? write_comp_data+0x2f/0x90=0D
[   37.542745]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.543077]  ? __pfx_perf_release+0x10/0x10=0D
[   37.543372]  perf_release+0x40/0x50=0D
[   37.543620]  __fput+0x26d/0xa40=0D
[   37.543862]  ____fput+0x1e/0x30=0D
[   37.544088]  task_work_run+0x1a4/0x2d0=0D
[   37.544350]  ? write_comp_data+0x2f/0x90=0D
[   37.544630]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.544924]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.545246]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.545553]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.545904]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.546238]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.546576]  do_syscall_64+0x4a/0x90=0D
[   37.546838]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.547188] RIP: 0033:0x7f3840f1059d=0D
[   37.547443] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.548624] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.549127] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.549604] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.550078] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.550550] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.551001] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.551484]  </TASK>=0D
[   37.609261] FAULT_INJECTION: forcing a failure.=0D
[   37.609261] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.610255] CPU: 1 PID: 611 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.610999] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.611949] Call Trace:=0D
[   37.612185]  <TASK>=0D
[   37.612382]  dump_stack_lvl+0xa7/0xdb=0D
[   37.612723]  dump_stack+0x19/0x1f=0D
[   37.613025]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.613411]  __should_failslab+0xca/0x120=0D
[   37.613796]  should_failslab+0x12/0x30=0D
[   37.614137]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.614552]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.614948]  kmalloc_trace+0x2e/0x120=0D
[   37.615278]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.615639]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.616144]  ? write_comp_data+0x2f/0x90=0D
[   37.616528]  ftrace_set_hash+0x445/0x590=0D
[   37.616934]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.617352]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.617807]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.618067]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.618350]  ? write_comp_data+0x2f/0x90=0D
[   37.618597]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.618897]  disarm_kprobe+0x24a/0x2d0=0D
[   37.619131]  __disable_kprobe+0x2de/0x4b0=0D
[   37.619376]  disable_kprobe+0x31/0x80=0D
[   37.619599]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.619870]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.620145]  kprobe_register+0x4e/0xf0=0D
[   37.620403]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.620736]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.621019]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.621334]  _free_event+0x220/0x11c0=0D
[   37.621591]  put_event+0x4d/0x60=0D
[   37.621827]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.622141]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.622472]  ? write_comp_data+0x2f/0x90=0D
[   37.622767]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.623082]  ? __pfx_perf_release+0x10/0x10=0D
[   37.623356]  perf_release+0x40/0x50=0D
[   37.623594]  __fput+0x26d/0xa40=0D
[   37.623825]  ____fput+0x1e/0x30=0D
[   37.624039]  task_work_run+0x1a4/0x2d0=0D
[   37.624297]  ? write_comp_data+0x2f/0x90=0D
[   37.624592]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.624873]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.625191]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.625501]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.625831]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.626138]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.626442]  do_syscall_64+0x4a/0x90=0D
[   37.626684]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.627041] RIP: 0033:0x7f3840f1059d=0D
[   37.627277] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.628412] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.628877] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.629310] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.629774] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.630246] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.630706] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.631163]  </TASK>=0D
[   37.669648] FAULT_INJECTION: forcing a failure.=0D
[   37.669648] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.670599] CPU: 1 PID: 612 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.671305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.672210] Call Trace:=0D
[   37.672428]  <TASK>=0D
[   37.672630]  dump_stack_lvl+0xa7/0xdb=0D
[   37.672990]  dump_stack+0x19/0x1f=0D
[   37.673308]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.673712]  __should_failslab+0xca/0x120=0D
[   37.674106]  should_failslab+0x12/0x30=0D
[   37.674446]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.674856]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.675256]  kmalloc_trace+0x2e/0x120=0D
[   37.675598]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.675967]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.676480]  ? write_comp_data+0x2f/0x90=0D
[   37.676869]  ftrace_set_hash+0x445/0x590=0D
[   37.677269]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.677693]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.678164]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.678544]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.678965]  ? write_comp_data+0x2f/0x90=0D
[   37.679355]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.679819]  disarm_kprobe+0x24a/0x2d0=0D
[   37.680175]  __disable_kprobe+0x2de/0x4b0=0D
[   37.680558]  disable_kprobe+0x31/0x80=0D
[   37.680902]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.681332]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.681771]  kprobe_register+0x4e/0xf0=0D
[   37.682146]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.682629]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.683028]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.683484]  _free_event+0x220/0x11c0=0D
[   37.683853]  put_event+0x4d/0x60=0D
[   37.684173]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.684624]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.685101]  ? write_comp_data+0x2f/0x90=0D
[   37.685482]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.685929]  ? __pfx_perf_release+0x10/0x10=0D
[   37.686216]  perf_release+0x40/0x50=0D
[   37.686463]  __fput+0x26d/0xa40=0D
[   37.686700]  ____fput+0x1e/0x30=0D
[   37.686926]  task_work_run+0x1a4/0x2d0=0D
[   37.687186]  ? write_comp_data+0x2f/0x90=0D
[   37.687464]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.687758]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.688078]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.688373]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.688708]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.689024]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.689335]  do_syscall_64+0x4a/0x90=0D
[   37.689585]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.689974] RIP: 0033:0x7f3840f1059d=0D
[   37.690265] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.691681] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.692276] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.692834] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.693390] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.693959] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.694516] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.695098]  </TASK>=0D
[   37.733080] FAULT_INJECTION: forcing a failure.=0D
[   37.733080] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.734009] CPU: 1 PID: 613 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.734702] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.735574] Call Trace:=0D
[   37.735778]  <TASK>=0D
[   37.735962]  dump_stack_lvl+0xa7/0xdb=0D
[   37.736285]  dump_stack+0x19/0x1f=0D
[   37.736587]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.736974]  __should_failslab+0xca/0x120=0D
[   37.737338]  should_failslab+0x12/0x30=0D
[   37.737671]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.738083]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.738467]  kmalloc_trace+0x2e/0x120=0D
[   37.738803]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.739189]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.739696]  ? write_comp_data+0x2f/0x90=0D
[   37.740072]  ftrace_set_hash+0x445/0x590=0D
[   37.740461]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.740861]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.741293]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.741667]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.742030]  ? write_comp_data+0x2f/0x90=0D
[   37.742301]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.742634]  disarm_kprobe+0x24a/0x2d0=0D
[   37.742888]  __disable_kprobe+0x2de/0x4b0=0D
[   37.743156]  disable_kprobe+0x31/0x80=0D
[   37.743404]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.743704]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.743993]  kprobe_register+0x4e/0xf0=0D
[   37.744247]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.744596]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.744876]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.745195]  _free_event+0x220/0x11c0=0D
[   37.745452]  put_event+0x4d/0x60=0D
[   37.745676]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.746005]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.746347]  ? write_comp_data+0x2f/0x90=0D
[   37.746616]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.746938]  ? __pfx_perf_release+0x10/0x10=0D
[   37.747213]  perf_release+0x40/0x50=0D
[   37.747452]  __fput+0x26d/0xa40=0D
[   37.747685]  ____fput+0x1e/0x30=0D
[   37.747898]  task_work_run+0x1a4/0x2d0=0D
[   37.748152]  ? write_comp_data+0x2f/0x90=0D
[   37.748420]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.748700]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.749007]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.749295]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.749620]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.749937]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.750244]  do_syscall_64+0x4a/0x90=0D
[   37.750489]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.750814] RIP: 0033:0x7f3840f1059d=0D
[   37.751052] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.752158] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.752633] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.753072] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.753511] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.753949] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.754382] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.754866]  </TASK>=0D
[   37.819302] FAULT_INJECTION: forcing a failure.=0D
[   37.819302] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.820177] CPU: 0 PID: 614 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.820853] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.821733] Call Trace:=0D
[   37.821942]  <TASK>=0D
[   37.822124]  dump_stack_lvl+0xa7/0xdb=0D
[   37.822451]  dump_stack+0x19/0x1f=0D
[   37.822737]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.823114]  __should_failslab+0xca/0x120=0D
[   37.823458]  should_failslab+0x12/0x30=0D
[   37.823782]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.824160]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.824536]  kmalloc_trace+0x2e/0x120=0D
[   37.824866]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.825218]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.825708]  ? write_comp_data+0x2f/0x90=0D
[   37.826084]  ftrace_set_hash+0x445/0x590=0D
[   37.826475]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.826866]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.827303]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.827664]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.828098]  ? write_comp_data+0x2f/0x90=0D
[   37.828476]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.828935]  disarm_kprobe+0x24a/0x2d0=0D
[   37.829288]  __disable_kprobe+0x2de/0x4b0=0D
[   37.829666]  disable_kprobe+0x31/0x80=0D
[   37.830015]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.830436]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.830844]  kprobe_register+0x4e/0xf0=0D
[   37.831199]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.831664]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.832054]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.832503]  _free_event+0x220/0x11c0=0D
[   37.832858]  put_event+0x4d/0x60=0D
[   37.833154]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.833602]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.834072]  ? write_comp_data+0x2f/0x90=0D
[   37.834446]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.834897]  ? __pfx_perf_release+0x10/0x10=0D
[   37.835294]  perf_release+0x40/0x50=0D
[   37.835639]  __fput+0x26d/0xa40=0D
[   37.835972]  ____fput+0x1e/0x30=0D
[   37.836274]  task_work_run+0x1a4/0x2d0=0D
[   37.836630]  ? write_comp_data+0x2f/0x90=0D
[   37.837002]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.837387]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.837826]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.838214]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.838656]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.839075]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.839493]  do_syscall_64+0x4a/0x90=0D
[   37.839843]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.840297] RIP: 0033:0x7f3840f1059d=0D
[   37.840619] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.842125] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.842788] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.843395] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.844000] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.844604] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.845209] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.845873]  </TASK>=0D
[   37.908525] FAULT_INJECTION: forcing a failure.=0D
[   37.908525] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.909400] CPU: 1 PID: 615 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.910065] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.910917] Call Trace:=0D
[   37.911113]  <TASK>=0D
[   37.911262]  dump_stack_lvl+0xa7/0xdb=0D
[   37.911514]  dump_stack+0x19/0x1f=0D
[   37.911738]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.912018]  __should_failslab+0xca/0x120=0D
[   37.912285]  should_failslab+0x12/0x30=0D
[   37.912531]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.912825]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.913106]  kmalloc_trace+0x2e/0x120=0D
[   37.913352]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.913619]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.914002]  ? write_comp_data+0x2f/0x90=0D
[   37.914288]  ftrace_set_hash+0x445/0x590=0D
[   37.914570]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.914861]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.915183]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.915503]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.915899]  ? write_comp_data+0x2f/0x90=0D
[   37.916241]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.916675]  disarm_kprobe+0x24a/0x2d0=0D
[   37.916994]  __disable_kprobe+0x2de/0x4b0=0D
[   37.917336]  disable_kprobe+0x31/0x80=0D
[   37.917648]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.918034]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.918403]  kprobe_register+0x4e/0xf0=0D
[   37.918724]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.919148]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.919503]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.919907]  _free_event+0x220/0x11c0=0D
[   37.920234]  put_event+0x4d/0x60=0D
[   37.920515]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.920923]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.921356]  ? write_comp_data+0x2f/0x90=0D
[   37.921695]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.922103]  ? __pfx_perf_release+0x10/0x10=0D
[   37.922453]  perf_release+0x40/0x50=0D
[   37.922755]  __fput+0x26d/0xa40=0D
[   37.923045]  ____fput+0x1e/0x30=0D
[   37.923317]  task_work_run+0x1a4/0x2d0=0D
[   37.923637]  ? write_comp_data+0x2f/0x90=0D
[   37.923977]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.924337]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.924729]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.925093]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.925503]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.925904]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.926291]  do_syscall_64+0x4a/0x90=0D
[   37.926597]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.927009] RIP: 0033:0x7f3840f1059d=0D
[   37.927307] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.928727] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   37.929322] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   37.929881] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   37.930441] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   37.930998] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   37.931555] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   37.932140]  </TASK>=0D
[   37.977726] FAULT_INJECTION: forcing a failure.=0D
[   37.977726] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   37.978774] CPU: 1 PID: 616 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   37.979529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   37.980510] Call Trace:=0D
[   37.980746]  <TASK>=0D
[   37.980957]  dump_stack_lvl+0xa7/0xdb=0D
[   37.981324]  dump_stack+0x19/0x1f=0D
[   37.981648]  should_fail_ex.cold.5+0x5/0xa=0D
[   37.982066]  __should_failslab+0xca/0x120=0D
[   37.982449]  should_failslab+0x12/0x30=0D
[   37.982809]  __kmem_cache_alloc_node+0x62/0x280=0D
[   37.983250]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   37.983658]  kmalloc_trace+0x2e/0x120=0D
[   37.984017]  alloc_ftrace_hash+0x4f/0x170=0D
[   37.984415]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   37.984956]  ? write_comp_data+0x2f/0x90=0D
[   37.985350]  ftrace_set_hash+0x445/0x590=0D
[   37.985752]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   37.986455]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   37.987167]  ? match_dev_by_uuid+0x4/0x100=0D
[   37.987763]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.988442]  ? write_comp_data+0x2f/0x90=0D
[   37.989021]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   37.989750]  disarm_kprobe+0x24a/0x2d0=0D
[   37.990076]  __disable_kprobe+0x2de/0x4b0=0D
[   37.990359]  disable_kprobe+0x31/0x80=0D
[   37.990611]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   37.990916]  disable_trace_kprobe+0x1f0/0x300=0D
[   37.991209]  kprobe_register+0x4e/0xf0=0D
[   37.991467]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   37.991806]  perf_kprobe_destroy+0xcb/0x200=0D
[   37.992088]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   37.992411]  _free_event+0x220/0x11c0=0D
[   37.992673]  put_event+0x4d/0x60=0D
[   37.992901]  perf_event_release_kernel+0x5d9/0x860=0D
[   37.993229]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   37.993577]  ? write_comp_data+0x2f/0x90=0D
[   37.993921]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   37.994247]  ? __pfx_perf_release+0x10/0x10=0D
[   37.994535]  perf_release+0x40/0x50=0D
[   37.994789]  __fput+0x26d/0xa40=0D
[   37.995037]  ____fput+0x1e/0x30=0D
[   37.995266]  task_work_run+0x1a4/0x2d0=0D
[   37.995535]  ? write_comp_data+0x2f/0x90=0D
[   37.995822]  ? __pfx_task_work_run+0x10/0x10=0D
[   37.996122]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   37.996456]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   37.996762]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   37.997105]  exit_to_user_mode_prepare+0x200/0x210=0D
[   37.997435]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   37.997756]  do_syscall_64+0x4a/0x90=0D
[   37.998023]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   37.998364] RIP: 0033:0x7f3840f1059d=0D
[   37.998614] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   37.999757] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.000248] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.000709] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.001168] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.001624] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.002087] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.002572]  </TASK>=0D
[   38.042922] FAULT_INJECTION: forcing a failure.=0D
[   38.042922] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.043628] CPU: 1 PID: 617 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.044143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.044792] Call Trace:=0D
[   38.044946]  <TASK>=0D
[   38.045083]  dump_stack_lvl+0xa7/0xdb=0D
[   38.045337]  dump_stack+0x19/0x1f=0D
[   38.045550]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.045825]  __should_failslab+0xca/0x120=0D
[   38.046081]  should_failslab+0x12/0x30=0D
[   38.046329]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.046612]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.046893]  kmalloc_trace+0x2e/0x120=0D
[   38.047127]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.047395]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.047756]  ? write_comp_data+0x2f/0x90=0D
[   38.048019]  ftrace_set_hash+0x445/0x590=0D
[   38.048289]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.048581]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.048887]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.049149]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.049444]  ? write_comp_data+0x2f/0x90=0D
[   38.049717]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.050048]  disarm_kprobe+0x24a/0x2d0=0D
[   38.050292]  __disable_kprobe+0x2de/0x4b0=0D
[   38.050550]  disable_kprobe+0x31/0x80=0D
[   38.050815]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.051103]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.051381]  kprobe_register+0x4e/0xf0=0D
[   38.051626]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.051958]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.052226]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.052532]  _free_event+0x220/0x11c0=0D
[   38.052792]  put_event+0x4d/0x60=0D
[   38.053009]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.053318]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.053644]  ? write_comp_data+0x2f/0x90=0D
[   38.053919]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.054234]  ? __pfx_perf_release+0x10/0x10=0D
[   38.054506]  perf_release+0x40/0x50=0D
[   38.054752]  __fput+0x26d/0xa40=0D
[   38.054994]  ____fput+0x1e/0x30=0D
[   38.055208]  task_work_run+0x1a4/0x2d0=0D
[   38.055458]  ? write_comp_data+0x2f/0x90=0D
[   38.055724]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.056011]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.056326]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.056609]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.056929]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.057249]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.057551]  do_syscall_64+0x4a/0x90=0D
[   38.057794]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.058114] RIP: 0033:0x7f3840f1059d=0D
[   38.058359] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.059464] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.059923] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.060361] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.060788] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.061215] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.061656] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.062114]  </TASK>=0D
[   38.105074] FAULT_INJECTION: forcing a failure.=0D
[   38.105074] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.105967] CPU: 1 PID: 618 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.106531] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.107208] Call Trace:=0D
[   38.107381]  <TASK>=0D
[   38.107521]  dump_stack_lvl+0xa7/0xdb=0D
[   38.107769]  dump_stack+0x19/0x1f=0D
[   38.107989]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.108266]  __should_failslab+0xca/0x120=0D
[   38.108528]  should_failslab+0x12/0x30=0D
[   38.108770]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.109060]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.109336]  kmalloc_trace+0x2e/0x120=0D
[   38.109579]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.109860]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.110230]  ? write_comp_data+0x2f/0x90=0D
[   38.110495]  ftrace_set_hash+0x445/0x590=0D
[   38.110783]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.111078]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.111388]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.111652]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.111962]  ? write_comp_data+0x2f/0x90=0D
[   38.112246]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.112577]  disarm_kprobe+0x24a/0x2d0=0D
[   38.112830]  __disable_kprobe+0x2de/0x4b0=0D
[   38.113133]  disable_kprobe+0x31/0x80=0D
[   38.113378]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.113678]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.113989]  kprobe_register+0x4e/0xf0=0D
[   38.114255]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.114596]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.114883]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.115285]  _free_event+0x220/0x11c0=0D
[   38.115560]  put_event+0x4d/0x60=0D
[   38.115785]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.116109]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.116449]  ? write_comp_data+0x2f/0x90=0D
[   38.116717]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.117040]  ? __pfx_perf_release+0x10/0x10=0D
[   38.117316]  perf_release+0x40/0x50=0D
[   38.117567]  __fput+0x26d/0xa40=0D
[   38.117830]  ____fput+0x1e/0x30=0D
[   38.118053]  task_work_run+0x1a4/0x2d0=0D
[   38.118313]  ? write_comp_data+0x2f/0x90=0D
[   38.118603]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.118930]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.119274]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.119652]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.120053]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.120436]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.120815]  do_syscall_64+0x4a/0x90=0D
[   38.121071]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.121392] RIP: 0033:0x7f3840f1059d=0D
[   38.121627] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.122955] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.123449] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.123876] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.124319] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.124744] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.125278] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.125735]  </TASK>=0D
[   38.168694] FAULT_INJECTION: forcing a failure.=0D
[   38.168694] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.169400] CPU: 1 PID: 619 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.169923] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.170587] Call Trace:=0D
[   38.170750]  <TASK>=0D
[   38.170891]  dump_stack_lvl+0xa7/0xdb=0D
[   38.171139]  dump_stack+0x19/0x1f=0D
[   38.171358]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.171633]  __should_failslab+0xca/0x120=0D
[   38.171893]  should_failslab+0x12/0x30=0D
[   38.172133]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.172423]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.172696]  kmalloc_trace+0x2e/0x120=0D
[   38.172937]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.173208]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.173575]  ? write_comp_data+0x2f/0x90=0D
[   38.173851]  ftrace_set_hash+0x445/0x590=0D
[   38.174128]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.174412]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.174730]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.174999]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.175319]  ? write_comp_data+0x2f/0x90=0D
[   38.175584]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.175910]  disarm_kprobe+0x24a/0x2d0=0D
[   38.176161]  __disable_kprobe+0x2de/0x4b0=0D
[   38.176427]  disable_kprobe+0x31/0x80=0D
[   38.176671]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.176967]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.177257]  kprobe_register+0x4e/0xf0=0D
[   38.177521]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.177857]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.178132]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.178481]  _free_event+0x220/0x11c0=0D
[   38.178764]  put_event+0x4d/0x60=0D
[   38.178990]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.179309]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.179649]  ? write_comp_data+0x2f/0x90=0D
[   38.179915]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.180232]  ? __pfx_perf_release+0x10/0x10=0D
[   38.180581]  perf_release+0x40/0x50=0D
[   38.180891]  __fput+0x26d/0xa40=0D
[   38.181133]  ____fput+0x1e/0x30=0D
[   38.181354]  task_work_run+0x1a4/0x2d0=0D
[   38.181609]  ? write_comp_data+0x2f/0x90=0D
[   38.181881]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.182136]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.182418]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.182676]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.182983]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.183344]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.183630]  do_syscall_64+0x4a/0x90=0D
[   38.183864]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.184156] RIP: 0033:0x7f3840f1059d=0D
[   38.184368] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.185519] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.186096] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.186614] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.187048] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.187501] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.187988] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.188603]  </TASK>=0D
[   38.224040] FAULT_INJECTION: forcing a failure.=0D
[   38.224040] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.224991] CPU: 0 PID: 620 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.225565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.226268] Call Trace:=0D
[   38.226461]  <TASK>=0D
[   38.226633]  dump_stack_lvl+0xa7/0xdb=0D
[   38.226935]  dump_stack+0x19/0x1f=0D
[   38.227165]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.227614]  __should_failslab+0xca/0x120=0D
[   38.227886]  should_failslab+0x12/0x30=0D
[   38.228141]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.228452]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.228746]  kmalloc_trace+0x2e/0x120=0D
[   38.229003]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.229282]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.229681]  ? write_comp_data+0x2f/0x90=0D
[   38.230099]  ftrace_set_hash+0x445/0x590=0D
[   38.230391]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.230700]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.231035]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.231324]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.231651]  ? write_comp_data+0x2f/0x90=0D
[   38.231938]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.232291]  disarm_kprobe+0x24a/0x2d0=0D
[   38.232557]  __disable_kprobe+0x2de/0x4b0=0D
[   38.232840]  disable_kprobe+0x31/0x80=0D
[   38.233097]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.233411]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.233716]  kprobe_register+0x4e/0xf0=0D
[   38.234001]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.234391]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.234684]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.235018]  _free_event+0x220/0x11c0=0D
[   38.235289]  put_event+0x4d/0x60=0D
[   38.235554]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.235906]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.236269]  ? write_comp_data+0x2f/0x90=0D
[   38.236550]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.236909]  ? __pfx_perf_release+0x10/0x10=0D
[   38.237197]  perf_release+0x40/0x50=0D
[   38.237445]  __fput+0x26d/0xa40=0D
[   38.237690]  ____fput+0x1e/0x30=0D
[   38.237926]  task_work_run+0x1a4/0x2d0=0D
[   38.238234]  ? write_comp_data+0x2f/0x90=0D
[   38.238522]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.238866]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.239194]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.239497]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.239838]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.240167]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.240483]  do_syscall_64+0x4a/0x90=0D
[   38.240738]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.241090] RIP: 0033:0x7f3840f1059d=0D
[   38.241341] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.242508] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.242990] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.243428] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.243929] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.244377] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.244813] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.245294]  </TASK>=0D
[   38.285416] FAULT_INJECTION: forcing a failure.=0D
[   38.285416] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.286431] CPU: 0 PID: 621 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.287188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.288135] Call Trace:=0D
[   38.288341]  <TASK>=0D
[   38.288527]  dump_stack_lvl+0xa7/0xdb=0D
[   38.288842]  dump_stack+0x19/0x1f=0D
[   38.289130]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.289496]  __should_failslab+0xca/0x120=0D
[   38.289845]  should_failslab+0x12/0x30=0D
[   38.290115]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.290429]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.290724]  kmalloc_trace+0x2e/0x120=0D
[   38.290982]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.291264]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.291659]  ? write_comp_data+0x2f/0x90=0D
[   38.291944]  ftrace_set_hash+0x445/0x590=0D
[   38.292235]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.292539]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.292876]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.293163]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.293489]  ? write_comp_data+0x2f/0x90=0D
[   38.293798]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.294168]  disarm_kprobe+0x24a/0x2d0=0D
[   38.294448]  __disable_kprobe+0x2de/0x4b0=0D
[   38.294748]  disable_kprobe+0x31/0x80=0D
[   38.295028]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.295346]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.295653]  kprobe_register+0x4e/0xf0=0D
[   38.295933]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.296284]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.296576]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.296924]  _free_event+0x220/0x11c0=0D
[   38.297196]  put_event+0x4d/0x60=0D
[   38.297433]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.297772]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.298154]  ? write_comp_data+0x2f/0x90=0D
[   38.298438]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.298802]  ? __pfx_perf_release+0x10/0x10=0D
[   38.299110]  perf_release+0x40/0x50=0D
[   38.299363]  __fput+0x26d/0xa40=0D
[   38.299609]  ____fput+0x1e/0x30=0D
[   38.299837]  task_work_run+0x1a4/0x2d0=0D
[   38.300108]  ? write_comp_data+0x2f/0x90=0D
[   38.300399]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.300697]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.301026]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.301344]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.301685]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.302016]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.302350]  do_syscall_64+0x4a/0x90=0D
[   38.302605]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.302968] RIP: 0033:0x7f3840f1059d=0D
[   38.303220] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.304565] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.305074] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.305530] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.305984] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.306477] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.306932] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.307415]  </TASK>=0D
[   38.361905] FAULT_INJECTION: forcing a failure.=0D
[   38.361905] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.362909] CPU: 0 PID: 622 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.363594] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.364430] Call Trace:=0D
[   38.364643]  <TASK>=0D
[   38.364818]  dump_stack_lvl+0xa7/0xdb=0D
[   38.365129]  dump_stack+0x19/0x1f=0D
[   38.365410]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.365772]  __should_failslab+0xca/0x120=0D
[   38.366131]  should_failslab+0x12/0x30=0D
[   38.366442]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.366835]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.367217]  kmalloc_trace+0x2e/0x120=0D
[   38.367555]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.367918]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.368440]  ? write_comp_data+0x2f/0x90=0D
[   38.368817]  ftrace_set_hash+0x445/0x590=0D
[   38.369210]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.369608]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.370054]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.370400]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.370828]  ? write_comp_data+0x2f/0x90=0D
[   38.371212]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.371677]  disarm_kprobe+0x24a/0x2d0=0D
[   38.372052]  __disable_kprobe+0x2de/0x4b0=0D
[   38.372426]  disable_kprobe+0x31/0x80=0D
[   38.372778]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.373211]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.373621]  kprobe_register+0x4e/0xf0=0D
[   38.373989]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.374455]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.374856]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.375309]  _free_event+0x220/0x11c0=0D
[   38.375679]  put_event+0x4d/0x60=0D
[   38.376005]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.376471]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.376945]  ? write_comp_data+0x2f/0x90=0D
[   38.377325]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.377770]  ? __pfx_perf_release+0x10/0x10=0D
[   38.378164]  perf_release+0x40/0x50=0D
[   38.378510]  __fput+0x26d/0xa40=0D
[   38.378848]  ____fput+0x1e/0x30=0D
[   38.379155]  task_work_run+0x1a4/0x2d0=0D
[   38.379509]  ? write_comp_data+0x2f/0x90=0D
[   38.379892]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.380279]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.380722]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.381126]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.381599]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.381998]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.382319]  do_syscall_64+0x4a/0x90=0D
[   38.382574]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.382915] RIP: 0033:0x7f3840f1059d=0D
[   38.383171] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.384357] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.384858] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.385324] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.385804] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.386275] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.386742] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.387238]  </TASK>=0D
[   38.432258] FAULT_INJECTION: forcing a failure.=0D
[   38.432258] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.432965] CPU: 0 PID: 623 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.433492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.434170] Call Trace:=0D
[   38.434334]  <TASK>=0D
[   38.434483]  dump_stack_lvl+0xa7/0xdb=0D
[   38.434745]  dump_stack+0x19/0x1f=0D
[   38.434966]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.435244]  __should_failslab+0xca/0x120=0D
[   38.435521]  should_failslab+0x12/0x30=0D
[   38.435779]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.436070]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.436343]  kmalloc_trace+0x2e/0x120=0D
[   38.436598]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.436871]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.437259]  ? write_comp_data+0x2f/0x90=0D
[   38.437530]  ftrace_set_hash+0x445/0x590=0D
[   38.437824]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.438160]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.438546]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.438826]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.439130]  ? write_comp_data+0x2f/0x90=0D
[   38.439400]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.439726]  disarm_kprobe+0x24a/0x2d0=0D
[   38.439986]  __disable_kprobe+0x2de/0x4b0=0D
[   38.440252]  disable_kprobe+0x31/0x80=0D
[   38.440497]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.440799]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.441105]  kprobe_register+0x4e/0xf0=0D
[   38.441420]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.441832]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.442126]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.442447]  _free_event+0x220/0x11c0=0D
[   38.442713]  put_event+0x4d/0x60=0D
[   38.442939]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.443277]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.443622]  ? write_comp_data+0x2f/0x90=0D
[   38.443894]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.444219]  ? __pfx_perf_release+0x10/0x10=0D
[   38.444498]  perf_release+0x40/0x50=0D
[   38.444744]  __fput+0x26d/0xa40=0D
[   38.445010]  ____fput+0x1e/0x30=0D
[   38.445295]  task_work_run+0x1a4/0x2d0=0D
[   38.445613]  ? write_comp_data+0x2f/0x90=0D
[   38.445892]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.446215]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.446619]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.446910]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.447239]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.447589]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.447900]  do_syscall_64+0x4a/0x90=0D
[   38.448147]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.448482] RIP: 0033:0x7f3840f1059d=0D
[   38.448732] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.449863] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.450336] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.450822] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.451272] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.451732] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.452190] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.452669]  </TASK>=0D
[   38.493380] FAULT_INJECTION: forcing a failure.=0D
[   38.493380] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.494740] CPU: 0 PID: 624 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.495924] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.497450] Call Trace:=0D
[   38.497826]  <TASK>=0D
[   38.498147]  dump_stack_lvl+0xa7/0xdb=0D
[   38.498696]  dump_stack+0x19/0x1f=0D
[   38.499178]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.499778]  __should_failslab+0xca/0x120=0D
[   38.500371]  should_failslab+0x12/0x30=0D
[   38.500918]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.501572]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.502194]  kmalloc_trace+0x2e/0x120=0D
[   38.502736]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.503317]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.504140]  ? write_comp_data+0x2f/0x90=0D
[   38.504723]  ftrace_set_hash+0x445/0x590=0D
[   38.505317]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.505975]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.506698]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.507314]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.508016]  ? write_comp_data+0x2f/0x90=0D
[   38.508635]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.509402]  disarm_kprobe+0x24a/0x2d0=0D
[   38.509979]  __disable_kprobe+0x2de/0x4b0=0D
[   38.510588]  disable_kprobe+0x31/0x80=0D
[   38.511144]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.511826]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.512493]  kprobe_register+0x4e/0xf0=0D
[   38.513076]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.513852]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.514482]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.515202]  _free_event+0x220/0x11c0=0D
[   38.515793]  put_event+0x4d/0x60=0D
[   38.516288]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.516987]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.517737]  ? write_comp_data+0x2f/0x90=0D
[   38.518321]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.519002]  ? __pfx_perf_release+0x10/0x10=0D
[   38.519598]  perf_release+0x40/0x50=0D
[   38.520112]  __fput+0x26d/0xa40=0D
[   38.520601]  ____fput+0x1e/0x30=0D
[   38.521108]  task_work_run+0x1a4/0x2d0=0D
[   38.521672]  ? write_comp_data+0x2f/0x90=0D
[   38.522269]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.522888]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.523569]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.524200]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.524904]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.525587]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.526256]  do_syscall_64+0x4a/0x90=0D
[   38.526787]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.527501] RIP: 0033:0x7f3840f1059d=0D
[   38.528013] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.530492] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.531533] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.532501] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.533483] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.534495] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.535506] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.536554]  </TASK>=0D
[   38.585741] FAULT_INJECTION: forcing a failure.=0D
[   38.585741] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.586721] CPU: 1 PID: 625 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.587514] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.588398] Call Trace:=0D
[   38.588610]  <TASK>=0D
[   38.588794]  dump_stack_lvl+0xa7/0xdb=0D
[   38.589121]  dump_stack+0x19/0x1f=0D
[   38.589406]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.589770]  __should_failslab+0xca/0x120=0D
[   38.590131]  should_failslab+0x12/0x30=0D
[   38.590567]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.590979]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.591365]  kmalloc_trace+0x2e/0x120=0D
[   38.591699]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.592065]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.592572]  ? write_comp_data+0x2f/0x90=0D
[   38.592954]  ftrace_set_hash+0x445/0x590=0D
[   38.593448]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.593854]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.594206]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.594499]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.594823]  ? write_comp_data+0x2f/0x90=0D
[   38.595108]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.595458]  disarm_kprobe+0x24a/0x2d0=0D
[   38.595724]  __disable_kprobe+0x2de/0x4b0=0D
[   38.596005]  disable_kprobe+0x31/0x80=0D
[   38.596425]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.596754]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.597057]  kprobe_register+0x4e/0xf0=0D
[   38.597320]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.597666]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.597959]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.598290]  _free_event+0x220/0x11c0=0D
[   38.598561]  put_event+0x4d/0x60=0D
[   38.598803]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.599297]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.599666]  ? write_comp_data+0x2f/0x90=0D
[   38.599953]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.600294]  ? __pfx_perf_release+0x10/0x10=0D
[   38.600588]  perf_release+0x40/0x50=0D
[   38.600843]  __fput+0x26d/0xa40=0D
[   38.601089]  ____fput+0x1e/0x30=0D
[   38.601320]  task_work_run+0x1a4/0x2d0=0D
[   38.601590]  ? write_comp_data+0x2f/0x90=0D
[   38.601948]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.602376]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.602706]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.603010]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.603355]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.603689]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.604016]  do_syscall_64+0x4a/0x90=0D
[   38.604282]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.604636] RIP: 0033:0x7f3840f1059d=0D
[   38.604970] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.606239] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.606737] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.607200] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.607660] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.608122] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.608583] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.609069]  </TASK>=0D
[   38.645826] FAULT_INJECTION: forcing a failure.=0D
[   38.645826] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.646854] CPU: 0 PID: 626 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.647569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.648495] Call Trace:=0D
[   38.648724]  <TASK>=0D
[   38.648924]  dump_stack_lvl+0xa7/0xdb=0D
[   38.649279]  dump_stack+0x19/0x1f=0D
[   38.649590]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.650236]  __should_failslab+0xca/0x120=0D
[   38.650831]  should_failslab+0x12/0x30=0D
[   38.651369]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.652011]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.652618]  kmalloc_trace+0x2e/0x120=0D
[   38.653201]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.653821]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.654690]  ? write_comp_data+0x2f/0x90=0D
[   38.655301]  ftrace_set_hash+0x445/0x590=0D
[   38.655920]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.656577]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.657304]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.657933]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.658634]  ? write_comp_data+0x2f/0x90=0D
[   38.659239]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.659998]  disarm_kprobe+0x24a/0x2d0=0D
[   38.660569]  __disable_kprobe+0x2de/0x4b0=0D
[   38.661187]  disable_kprobe+0x31/0x80=0D
[   38.661743]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.662425]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.663101]  kprobe_register+0x4e/0xf0=0D
[   38.663674]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.664427]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.665058]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.665774]  _free_event+0x220/0x11c0=0D
[   38.666340]  put_event+0x4d/0x60=0D
[   38.666826]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.667530]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.668279]  ? write_comp_data+0x2f/0x90=0D
[   38.668859]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.669547]  ? __pfx_perf_release+0x10/0x10=0D
[   38.670155]  perf_release+0x40/0x50=0D
[   38.670670]  __fput+0x26d/0xa40=0D
[   38.671161]  ____fput+0x1e/0x30=0D
[   38.671633]  task_work_run+0x1a4/0x2d0=0D
[   38.672190]  ? write_comp_data+0x2f/0x90=0D
[   38.672772]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.673392]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.674074]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.674798]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.675635]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.676436]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.677219]  do_syscall_64+0x4a/0x90=0D
[   38.677854]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.678711] RIP: 0033:0x7f3840f1059d=0D
[   38.679330] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.682295] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.683524] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.684686] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.685857] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.687010] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.688184] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.689362]  </TASK>=0D
[   38.725752] FAULT_INJECTION: forcing a failure.=0D
[   38.725752] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.727411] CPU: 0 PID: 627 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.728625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.730207] Call Trace:=0D
[   38.730579]  <TASK>=0D
[   38.730913]  dump_stack_lvl+0xa7/0xdb=0D
[   38.731479]  dump_stack+0x19/0x1f=0D
[   38.731986]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.732611]  __should_failslab+0xca/0x120=0D
[   38.733218]  should_failslab+0x12/0x30=0D
[   38.733778]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.734462]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.735096]  kmalloc_trace+0x2e/0x120=0D
[   38.735662]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.736277]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.737142]  ? write_comp_data+0x2f/0x90=0D
[   38.737751]  ftrace_set_hash+0x445/0x590=0D
[   38.738374]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.739027]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.739751]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.740370]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.741072]  ? write_comp_data+0x2f/0x90=0D
[   38.741675]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.742430]  disarm_kprobe+0x24a/0x2d0=0D
[   38.742998]  __disable_kprobe+0x2de/0x4b0=0D
[   38.743607]  disable_kprobe+0x31/0x80=0D
[   38.744165]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.744840]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.745496]  kprobe_register+0x4e/0xf0=0D
[   38.746083]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.746843]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.747476]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.748199]  _free_event+0x220/0x11c0=0D
[   38.748785]  put_event+0x4d/0x60=0D
[   38.749297]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.750041]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.750830]  ? write_comp_data+0x2f/0x90=0D
[   38.751439]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.752156]  ? __pfx_perf_release+0x10/0x10=0D
[   38.752781]  perf_release+0x40/0x50=0D
[   38.753316]  __fput+0x26d/0xa40=0D
[   38.753846]  ____fput+0x1e/0x30=0D
[   38.754345]  task_work_run+0x1a4/0x2d0=0D
[   38.754924]  ? write_comp_data+0x2f/0x90=0D
[   38.755529]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.756199]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.756906]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.757565]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.758322]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.759060]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.759790]  do_syscall_64+0x4a/0x90=0D
[   38.760362]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.761127] RIP: 0033:0x7f3840f1059d=0D
[   38.761696] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.764301] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.765383] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.766413] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.767397] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.768374] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.769349] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.770367]  </TASK>=0D
[   38.817651] FAULT_INJECTION: forcing a failure.=0D
[   38.817651] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.819268] CPU: 0 PID: 628 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.820450] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.821993] Call Trace:=0D
[   38.822360]  <TASK>=0D
[   38.822687]  dump_stack_lvl+0xa7/0xdb=0D
[   38.823251]  dump_stack+0x19/0x1f=0D
[   38.823747]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.824354]  __should_failslab+0xca/0x120=0D
[   38.824939]  should_failslab+0x12/0x30=0D
[   38.825501]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.826195]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.826830]  kmalloc_trace+0x2e/0x120=0D
[   38.827389]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.828006]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.828878]  ? write_comp_data+0x2f/0x90=0D
[   38.829493]  ftrace_set_hash+0x445/0x590=0D
[   38.830125]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.830785]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.831525]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.832153]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.832859]  ? write_comp_data+0x2f/0x90=0D
[   38.833465]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.834235]  disarm_kprobe+0x24a/0x2d0=0D
[   38.834811]  __disable_kprobe+0x2de/0x4b0=0D
[   38.835434]  disable_kprobe+0x31/0x80=0D
[   38.836006]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.836694]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.837375]  kprobe_register+0x4e/0xf0=0D
[   38.837957]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.838741]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.839378]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.840103]  _free_event+0x220/0x11c0=0D
[   38.840681]  put_event+0x4d/0x60=0D
[   38.841195]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.841939]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.842728]  ? write_comp_data+0x2f/0x90=0D
[   38.843344]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.844063]  ? __pfx_perf_release+0x10/0x10=0D
[   38.844693]  perf_release+0x40/0x50=0D
[   38.845231]  __fput+0x26d/0xa40=0D
[   38.845747]  ____fput+0x1e/0x30=0D
[   38.846249]  task_work_run+0x1a4/0x2d0=0D
[   38.846824]  ? write_comp_data+0x2f/0x90=0D
[   38.847435]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.848085]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.848794]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.849444]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.850202]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.850916]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.851619]  do_syscall_64+0x4a/0x90=0D
[   38.852179]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.852911] RIP: 0033:0x7f3840f1059d=0D
[   38.853436] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.855932] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.856970] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.857955] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.858929] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.859903] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.860881] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.861911]  </TASK>=0D
[   38.927304] FAULT_INJECTION: forcing a failure.=0D
[   38.927304] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   38.928878] CPU: 1 PID: 629 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   38.930078] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   38.931621] Call Trace:=0D
[   38.931990]  <TASK>=0D
[   38.932318]  dump_stack_lvl+0xa7/0xdb=0D
[   38.932875]  dump_stack+0x19/0x1f=0D
[   38.933376]  should_fail_ex.cold.5+0x5/0xa=0D
[   38.934003]  __should_failslab+0xca/0x120=0D
[   38.934598]  should_failslab+0x12/0x30=0D
[   38.935149]  __kmem_cache_alloc_node+0x62/0x280=0D
[   38.935814]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   38.936444]  kmalloc_trace+0x2e/0x120=0D
[   38.936986]  alloc_ftrace_hash+0x4f/0x170=0D
[   38.937580]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   38.938459]  ? write_comp_data+0x2f/0x90=0D
[   38.939059]  ftrace_set_hash+0x445/0x590=0D
[   38.939656]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   38.940292]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   38.941009]  ? match_dev_by_uuid+0x4/0x100=0D
[   38.941629]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.942358]  ? write_comp_data+0x2f/0x90=0D
[   38.942973]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   38.943753]  disarm_kprobe+0x24a/0x2d0=0D
[   38.944339]  __disable_kprobe+0x2de/0x4b0=0D
[   38.944949]  disable_kprobe+0x31/0x80=0D
[   38.945506]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   38.946188]  disable_trace_kprobe+0x1f0/0x300=0D
[   38.946846]  kprobe_register+0x4e/0xf0=0D
[   38.947402]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   38.948123]  perf_kprobe_destroy+0xcb/0x200=0D
[   38.948725]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   38.949451]  _free_event+0x220/0x11c0=0D
[   38.950112]  put_event+0x4d/0x60=0D
[   38.950688]  perf_event_release_kernel+0x5d9/0x860=0D
[   38.951514]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   38.952408]  ? write_comp_data+0x2f/0x90=0D
[   38.953094]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   38.953928]  ? __pfx_perf_release+0x10/0x10=0D
[   38.954650]  perf_release+0x40/0x50=0D
[   38.955268]  __fput+0x26d/0xa40=0D
[   38.955849]  ____fput+0x1e/0x30=0D
[   38.956407]  task_work_run+0x1a4/0x2d0=0D
[   38.957055]  ? write_comp_data+0x2f/0x90=0D
[   38.957741]  ? __pfx_task_work_run+0x10/0x10=0D
[   38.958481]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   38.959284]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   38.960032]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   38.960879]  exit_to_user_mode_prepare+0x200/0x210=0D
[   38.961690]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   38.962123]  do_syscall_64+0x4a/0x90=0D
[   38.962380]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   38.962710] RIP: 0033:0x7f3840f1059d=0D
[   38.962951] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   38.964064] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   38.964536] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   38.964974] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   38.965413] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   38.965859] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   38.966301] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   38.966767]  </TASK>=0D
[   39.009876] FAULT_INJECTION: forcing a failure.=0D
[   39.009876] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   39.011519] CPU: 1 PID: 630 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   39.012719] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   39.014319] Call Trace:=0D
[   39.014701]  <TASK>=0D
[   39.015035]  dump_stack_lvl+0xa7/0xdb=0D
[   39.015604]  dump_stack+0x19/0x1f=0D
[   39.016117]  should_fail_ex.cold.5+0x5/0xa=0D
[   39.016746]  __should_failslab+0xca/0x120=0D
[   39.017352]  should_failslab+0x12/0x30=0D
[   39.017916]  __kmem_cache_alloc_node+0x62/0x280=0D
[   39.018246]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   39.018541]  kmalloc_trace+0x2e/0x120=0D
[   39.018814]  alloc_ftrace_hash+0x4f/0x170=0D
[   39.019092]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   39.019517]  ? write_comp_data+0x2f/0x90=0D
[   39.019802]  ftrace_set_hash+0x445/0x590=0D
[   39.020093]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   39.020423]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   39.020756]  ? match_dev_by_uuid+0x4/0x100=0D
[   39.021050]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.021379]  ? write_comp_data+0x2f/0x90=0D
[   39.021696]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   39.022120]  disarm_kprobe+0x24a/0x2d0=0D
[   39.022447]  __disable_kprobe+0x2de/0x4b0=0D
[   39.022795]  disable_kprobe+0x31/0x80=0D
[   39.023116]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   39.023504]  disable_trace_kprobe+0x1f0/0x300=0D
[   39.023884]  kprobe_register+0x4e/0xf0=0D
[   39.024214]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   39.024645]  perf_kprobe_destroy+0xcb/0x200=0D
[   39.025003]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   39.025412]  _free_event+0x220/0x11c0=0D
[   39.025741]  put_event+0x4d/0x60=0D
[   39.026035]  perf_event_release_kernel+0x5d9/0x860=0D
[   39.026446]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   39.026885]  ? write_comp_data+0x2f/0x90=0D
[   39.027227]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   39.027637]  ? __pfx_perf_release+0x10/0x10=0D
[   39.027994]  perf_release+0x40/0x50=0D
[   39.028299]  __fput+0x26d/0xa40=0D
[   39.028595]  ____fput+0x1e/0x30=0D
[   39.028873]  task_work_run+0x1a4/0x2d0=0D
[   39.029198]  ? write_comp_data+0x2f/0x90=0D
[   39.029544]  ? __pfx_task_work_run+0x10/0x10=0D
[   39.029912]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.030315]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   39.030688]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   39.031124]  exit_to_user_mode_prepare+0x200/0x210=0D
[   39.031524]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   39.031916]  do_syscall_64+0x4a/0x90=0D
[   39.032227]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   39.032646] RIP: 0033:0x7f3840f1059d=0D
[   39.032947] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   39.034391] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   39.034996] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   39.035563] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   39.036133] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   39.036702] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   39.037273] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   39.037862]  </TASK>=0D
[   39.085074] FAULT_INJECTION: forcing a failure.=0D
[   39.085074] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   39.085999] CPU: 1 PID: 631 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   39.086674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   39.087622] Call Trace:=0D
[   39.087861]  <TASK>=0D
[   39.088069]  dump_stack_lvl+0xa7/0xdb=0D
[   39.088435]  dump_stack+0x19/0x1f=0D
[   39.088751]  should_fail_ex.cold.5+0x5/0xa=0D
[   39.089162]  __should_failslab+0xca/0x120=0D
[   39.089556]  should_failslab+0x12/0x30=0D
[   39.089915]  __kmem_cache_alloc_node+0x62/0x280=0D
[   39.090345]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   39.090758]  kmalloc_trace+0x2e/0x120=0D
[   39.091117]  alloc_ftrace_hash+0x4f/0x170=0D
[   39.091508]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   39.092054]  ? write_comp_data+0x2f/0x90=0D
[   39.092457]  ftrace_set_hash+0x445/0x590=0D
[   39.092868]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   39.093298]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   39.093765]  ? match_dev_by_uuid+0x4/0x100=0D
[   39.094166]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.094619]  ? write_comp_data+0x2f/0x90=0D
[   39.095019]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   39.095504]  disarm_kprobe+0x24a/0x2d0=0D
[   39.095876]  __disable_kprobe+0x2de/0x4b0=0D
[   39.096273]  disable_kprobe+0x31/0x80=0D
[   39.096633]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   39.097071]  disable_trace_kprobe+0x1f0/0x300=0D
[   39.097495]  kprobe_register+0x4e/0xf0=0D
[   39.097859]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   39.098214]  perf_kprobe_destroy+0xcb/0x200=0D
[   39.098507]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   39.098853]  _free_event+0x220/0x11c0=0D
[   39.099123]  put_event+0x4d/0x60=0D
[   39.099365]  perf_event_release_kernel+0x5d9/0x860=0D
[   39.099689]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   39.100033]  ? write_comp_data+0x2f/0x90=0D
[   39.100302]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   39.100624]  ? __pfx_perf_release+0x10/0x10=0D
[   39.100903]  perf_release+0x40/0x50=0D
[   39.101146]  __fput+0x26d/0xa40=0D
[   39.101383]  ____fput+0x1e/0x30=0D
[   39.101602]  task_work_run+0x1a4/0x2d0=0D
[   39.101869]  ? write_comp_data+0x2f/0x90=0D
[   39.102142]  ? __pfx_task_work_run+0x10/0x10=0D
[   39.102429]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.102746]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   39.103038]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   39.103369]  exit_to_user_mode_prepare+0x200/0x210=0D
[   39.103685]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   39.103997]  do_syscall_64+0x4a/0x90=0D
[   39.104247]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   39.104576] RIP: 0033:0x7f3840f1059d=0D
[   39.104818] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   39.105930] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   39.106401] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   39.106838] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   39.107275] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   39.107718] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   39.108158] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   39.108618]  </TASK>=0D
[   39.140064] FAULT_INJECTION: forcing a failure.=0D
[   39.140064] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   39.140804] CPU: 1 PID: 632 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   39.141326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   39.142020] Call Trace:=0D
[   39.142182]  <TASK>=0D
[   39.142325]  dump_stack_lvl+0xa7/0xdb=0D
[   39.142577]  dump_stack+0x19/0x1f=0D
[   39.142802]  should_fail_ex.cold.5+0x5/0xa=0D
[   39.143083]  __should_failslab+0xca/0x120=0D
[   39.143351]  should_failslab+0x12/0x30=0D
[   39.143597]  __kmem_cache_alloc_node+0x62/0x280=0D
[   39.143892]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   39.144172]  kmalloc_trace+0x2e/0x120=0D
[   39.144422]  alloc_ftrace_hash+0x4f/0x170=0D
[   39.144689]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   39.145069]  ? write_comp_data+0x2f/0x90=0D
[   39.145353]  ftrace_set_hash+0x445/0x590=0D
[   39.145629]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   39.145939]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   39.146268]  ? match_dev_by_uuid+0x4/0x100=0D
[   39.146536]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.146845]  ? write_comp_data+0x2f/0x90=0D
[   39.147127]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   39.147459]  disarm_kprobe+0x24a/0x2d0=0D
[   39.147724]  __disable_kprobe+0x2de/0x4b0=0D
[   39.148010]  disable_kprobe+0x31/0x80=0D
[   39.148328]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   39.148701]  disable_trace_kprobe+0x1f0/0x300=0D
[   39.149063]  kprobe_register+0x4e/0xf0=0D
[   39.149381]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   39.149760]  perf_kprobe_destroy+0xcb/0x200=0D
[   39.150052]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   39.150375]  _free_event+0x220/0x11c0=0D
[   39.150644]  put_event+0x4d/0x60=0D
[   39.150895]  perf_event_release_kernel+0x5d9/0x860=0D
[   39.151226]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   39.151576]  ? write_comp_data+0x2f/0x90=0D
[   39.151846]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   39.152167]  ? __pfx_perf_release+0x10/0x10=0D
[   39.152446]  perf_release+0x40/0x50=0D
[   39.152685]  __fput+0x26d/0xa40=0D
[   39.152920]  ____fput+0x1e/0x30=0D
[   39.153139]  task_work_run+0x1a4/0x2d0=0D
[   39.153394]  ? write_comp_data+0x2f/0x90=0D
[   39.153666]  ? __pfx_task_work_run+0x10/0x10=0D
[   39.153981]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.154308]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   39.154596]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   39.154925]  exit_to_user_mode_prepare+0x200/0x210=0D
[   39.155245]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   39.155564]  do_syscall_64+0x4a/0x90=0D
[   39.155819]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   39.156157] RIP: 0033:0x7f3840f1059d=0D
[   39.156405] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   39.157543] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   39.158033] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   39.158487] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   39.158940] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   39.159392] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   39.159843] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   39.160320]  </TASK>=0D
[   39.197520] FAULT_INJECTION: forcing a failure.=0D
[   39.197520] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   39.199190] CPU: 0 PID: 633 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   39.200417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   39.202020] Call Trace:=0D
[   39.202398]  <TASK>=0D
[   39.202765]  dump_stack_lvl+0xa7/0xdb=0D
[   39.203345]  dump_stack+0x19/0x1f=0D
[   39.203877]  should_fail_ex.cold.5+0x5/0xa=0D
[   39.204511]  __should_failslab+0xca/0x120=0D
[   39.205117]  should_failslab+0x12/0x30=0D
[   39.205679]  __kmem_cache_alloc_node+0x62/0x280=0D
[   39.206377]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   39.207021]  kmalloc_trace+0x2e/0x120=0D
[   39.207589]  alloc_ftrace_hash+0x4f/0x170=0D
[   39.208203]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   39.209066]  ? write_comp_data+0x2f/0x90=0D
[   39.209654]  ftrace_set_hash+0x445/0x590=0D
[   39.210258]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   39.210885]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   39.211591]  ? match_dev_by_uuid+0x4/0x100=0D
[   39.212191]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.212875]  ? write_comp_data+0x2f/0x90=0D
[   39.213450]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   39.214214]  disarm_kprobe+0x24a/0x2d0=0D
[   39.214789]  __disable_kprobe+0x2de/0x4b0=0D
[   39.215404]  disable_kprobe+0x31/0x80=0D
[   39.215966]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   39.216643]  disable_trace_kprobe+0x1f0/0x300=0D
[   39.217309]  kprobe_register+0x4e/0xf0=0D
[   39.217876]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   39.218618]  perf_kprobe_destroy+0xcb/0x200=0D
[   39.219240]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   39.219959]  _free_event+0x220/0x11c0=0D
[   39.220526]  put_event+0x4d/0x60=0D
[   39.221021]  perf_event_release_kernel+0x5d9/0x860=0D
[   39.221742]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   39.222524]  ? write_comp_data+0x2f/0x90=0D
[   39.223118]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   39.223820]  ? __pfx_perf_release+0x10/0x10=0D
[   39.224434]  perf_release+0x40/0x50=0D
[   39.224960]  __fput+0x26d/0xa40=0D
[   39.225462]  ____fput+0x1e/0x30=0D
[   39.225953]  task_work_run+0x1a4/0x2d0=0D
[   39.226521]  ? write_comp_data+0x2f/0x90=0D
[   39.227125]  ? __pfx_task_work_run+0x10/0x10=0D
[   39.227772]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.228485]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   39.229141]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   39.229891]  exit_to_user_mode_prepare+0x200/0x210=0D
[   39.230601]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   39.231294]  do_syscall_64+0x4a/0x90=0D
[   39.231835]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   39.232554] RIP: 0033:0x7f3840f1059d=0D
[   39.233072] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   39.235534] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   39.236598] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   39.237610] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   39.238622] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   39.239619] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   39.240623] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   39.241661]  </TASK>=0D
[   39.278725] FAULT_INJECTION: forcing a failure.=0D
[   39.278725] name failslab, interval 1, probability 0, space 0, times 0=
=0D
[   39.279811] CPU: 1 PID: 634 Comm: repro Tainted: G        W          6.2=
.0-rc7-4ec5183ec486 #1=0D
[   39.280622] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   39.281587] Call Trace:=0D
[   39.281879]  <TASK>=0D
[   39.282083]  dump_stack_lvl+0xa7/0xdb=0D
[   39.282449]  dump_stack+0x19/0x1f=0D
[   39.282771]  should_fail_ex.cold.5+0x5/0xa=0D
[   39.283203]  __should_failslab+0xca/0x120=0D
[   39.283592]  should_failslab+0x12/0x30=0D
[   39.283963]  __kmem_cache_alloc_node+0x62/0x280=0D
[   39.284427]  ? alloc_ftrace_hash+0x4f/0x170=0D
[   39.284893]  kmalloc_trace+0x2e/0x120=0D
[   39.285252]  alloc_ftrace_hash+0x4f/0x170=0D
[   39.285565]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310=0D
[   39.286019]  ? write_comp_data+0x2f/0x90=0D
[   39.286372]  ftrace_set_hash+0x445/0x590=0D
[   39.286696]  ftrace_set_filter_ip+0xcd/0x1a0=0D
[   39.287012]  ? __pfx_ftrace_set_filter_ip+0x10/0x10=0D
[   39.287360]  ? match_dev_by_uuid+0x4/0x100=0D
[   39.287669]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.288004]  ? write_comp_data+0x2f/0x90=0D
[   39.288297]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250=0D
[   39.288668]  disarm_kprobe+0x24a/0x2d0=0D
[   39.288942]  __disable_kprobe+0x2de/0x4b0=0D
[   39.289235]  disable_kprobe+0x31/0x80=0D
[   39.289501]  __disable_trace_kprobe+0xfb/0x1c0=0D
[   39.289844]  disable_trace_kprobe+0x1f0/0x300=0D
[   39.290161]  kprobe_register+0x4e/0xf0=0D
[   39.290436]  perf_trace_event_unreg.isra.3+0xb6/0x1f0=0D
[   39.290817]  perf_kprobe_destroy+0xcb/0x200=0D
[   39.291120]  ? __pfx_perf_kprobe_destroy+0x10/0x10=0D
[   39.291465]  _free_event+0x220/0x11c0=0D
[   39.291751]  put_event+0x4d/0x60=0D
[   39.292003]  perf_event_release_kernel+0x5d9/0x860=0D
[   39.292341]  ? __pfx_perf_event_release_kernel+0x10/0x10=0D
[   39.292692]  ? write_comp_data+0x2f/0x90=0D
[   39.292974]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   39.293308]  ? __pfx_perf_release+0x10/0x10=0D
[   39.293596]  perf_release+0x40/0x50=0D
[   39.293850]  __fput+0x26d/0xa40=0D
[   39.294103]  ____fput+0x1e/0x30=0D
[   39.294330]  task_work_run+0x1a4/0x2d0=0D
[   39.294599]  ? write_comp_data+0x2f/0x90=0D
[   39.294892]  ? __pfx_task_work_run+0x10/0x10=0D
[   39.295199]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   39.295523]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   39.295824]  ? exit_to_user_mode_prepare+0x100/0x210=0D
[   39.296201]  exit_to_user_mode_prepare+0x200/0x210=0D
[   39.296527]  syscall_exit_to_user_mode+0x2d/0x60=0D
[   39.296921]  do_syscall_64+0x4a/0x90=0D
[   39.297245]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   39.297587] RIP: 0033:0x7f3840f1059d=0D
[   39.297847] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   39.299056] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003=0D
[   39.299607] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f=
1059d=0D
[   39.300091] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 00000000000=
00003=0D
[   39.300564] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19f=
b73c0=0D
[   39.301060] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000004=
01180=0D
[   39.301518] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   39.302015]  </TASK>=0D

--WLnuj2JREO5e8E+i--
