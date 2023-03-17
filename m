Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AEE6BDE98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 03:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCQC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQC1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:27:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E936782A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 19:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679020025; x=1710556025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cx2QjPgIpvGkHjtu4jPlC9L/419NZHVImHyDeTvJMuA=;
  b=L/Nh9VVPaXERoxNa7xRLtYR7a8Ojb+rA52hO2a2PT1iE0vxVnnFsrGE3
   ZV2Bc/YVgcOuX5qg6h9QZ3G0uYVcn6gdiZdlrbaxFuFYf4ckxVTx1hha9
   oW2jaeZcvpLA5pyEstJOvUbM4/a8pMwBfs2RA/Cn4lQeCXlQDhPuni+j/
   x4p7uTdx5GgFR6UxnHUQgZ4Nk0Zkm7v98nmeAavYuBlWr/FFM2lIWWmew
   HNCD+WSfz4TuQZaktpWtX+7ZTfp9Sm/FmkbTVZrEkErMTFtVvBAzeWHeY
   FISApbNqZLdrnowkXENEgmTquaJENQSoxeswYPgaSqV7fA2HYGOAG1V2P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="335652258"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="335652258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 19:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="710355070"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="710355070"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2023 19:27:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 19:27:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 19:27:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 19:27:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 19:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZgl/zZB82G777B9GHRdUg71q0zGKcY+3YKi5j3+0d37eX3x6ULv96lbcjZWNXS0Xd4bMQc1u3XYX3hV+k1DJ+xYOV50k0kMu2eTPONv3QkKkHG3la5haiTmME4MxRLArEQ8v/z7zAOJ/TESVNRGcPBoRmS8HrzlkzBd7B4UjHCbG9gsiw0FUYv8T7x93ws7GPMZrGgJuUZV5yIgm8qK+ELflSdAY+w5rswL1cBB8FxHRIqjPGRUM7yNeNVLJSfap3IhBe/oXb6PNFsapoccEyAkGxqEg8bOl4zo6oM7NPkrhPem9HReZvyn4rDH+3OqJJFpfEaNOTVezVzc6mN+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hu8ny1W1S3leQPjxG5WtgDID82CarsI97WY22b1QeI=;
 b=W1Vo2yvFN1+HfA1poLJzFSVp3be9ZzNLxRJARnqO7wNPDK2lFfR+QycO7e1S2oPWfJTK1PmoFAgSpJ0mY1pFXKe5bTtelxi+9KE/NfefM+r7ux+Fy909ojJf6Q2EjqJsQ7yO8xrg2CR/FIWZdsYy+tBtzMmY3eIjF4etMXL0wfY1Cu3XUQxFcHNQBxGYm4aIgJ2tA7MQX1tGd0C8v0xWiGgLznbp0I+d5Cr0TLUwihsIfKXxtcrCH8fEDnGZEHQ8DeDAnUrW2FI0b9laQTOAdIODrauFMrLUvDkZrFjztw+l6Ri6h0AsJxCbHqwB01iQ47eyBkAoj/BuOxe7bItYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Fri, 17 Mar
 2023 02:26:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 02:26:54 +0000
Date:   Thu, 16 Mar 2023 19:26:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Message-ID: <6413cfec1b2ed_26992949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6c72e2-3de6-4ffb-c29a-08db268f12cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cA36aAmcHGSmTFKgNYLrZjHMGIoNtECPjDeIIHsZs2ciElFVZyjOI/XgUDEcU9ffSL7ph2msulCeSouOpwpLcVQhM0a4PJFtPD2+/81B9zxrePa9t1J+06EIonwKo/XjaqPITWPSPsfVsZ8NHGAgQA7bQCGRzT91peeDukhY78yJ0RACPXK5UGtwL9DqikeckOaP5qJuSvWT8TkOGv6BJgPEehvB5CqlT/e1IkYKHRQnB/rqZeXAQ1E3r9k7GOCCw6Vo8yXbgZL77aUjnUT0kcEcdowbaRcIN4GjZkDKGmtCb/d3kGGU3QCcSi+3rbe769Sg53l8kb3xdY1bHEchUREYUIsmBBJJh9anR335VZibBJqdExWoM7tWVMS8Gya/8PitzM2MKqAob6kk6wMKgRUNGh7K+/IYxK28jeBsbhXMe1BYU6cL/hWC2bWRg+WegVpepVs7EkQIFTPYsStru8SPNNzwCzge+xNNWSqo9UI+wdaPcylQKDUMICwru+kgXHuuTyJAi6zh4ptuZUXgUEm2WuXXdEA02Sj2XL7CuKddLWC7/DSctsjVD5y/UgL4NCEpZ2h3d78uzWb2qNmqtUa10wCYY+A/n5YGaBw3avGIhuAGsuTvRUTZGF/lESj63PeM3vLK3u3vVupJ15EMCsGn+hACB+6gdoWM5dyEkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(6486002)(9686003)(186003)(6506007)(26005)(6512007)(53546011)(8936002)(83380400001)(82960400001)(966005)(5660300002)(66556008)(41300700001)(4326008)(38100700002)(66476007)(66946007)(2906002)(86362001)(110136005)(478600001)(8676002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrF1mNnrmI91i+CFsx6lhAT4jKO6oLGSPGdPXk8iuaSrQKzTtkhNH/UyMB0z?=
 =?us-ascii?Q?0rVlO3Y9sLQT7+fJeP/E25L8CvyyLm8DGOvvc4CZxPV/lVGfd0e/Icecol8V?=
 =?us-ascii?Q?plQXQsa+fOU6iSpW+sPlF0kAkB4UyrYdZk+v4LDsrG7svrbQqVz0azQwJ1og?=
 =?us-ascii?Q?ShoHrqE8u8pEY8WCwRmI9KWtJghsMtO5YHdgrVXFPBtA0BcLpALPwRzhRZEo?=
 =?us-ascii?Q?BSbaLFIE5LNFGmsNeAQ1M2YWAM9Px4NJDR+D1zEfVgMCmXdypM2wtI3NpH3q?=
 =?us-ascii?Q?Z1uPPLVIkxhJLuBNvgD3fCNrRiT87KmrQWChVk2c49iT3KJhkPsdbawLCCI5?=
 =?us-ascii?Q?Uqh9gcJJeq/jZQpU3cKfiUR0FBdXoIN+f4spZ8/ARgPnHc06Z2ApviDNdrx2?=
 =?us-ascii?Q?8XfxPCegdQWmg+5WJ2l2V31HDtzW8nYpy483ZQRthQKCWH/ex7GNPYswXb62?=
 =?us-ascii?Q?FXZgE8TE35nTu1SW5716n0tBByUPgKaOteflYIu5QA+ws/IN8MjibxzZhLX8?=
 =?us-ascii?Q?aenV1w3WMO1g25JeJHhhCSJBVWtLkjEgT7bdXUmkxcUoq7t9e7mDdlPSMLuk?=
 =?us-ascii?Q?VDSnzny0rIRvBBFGHHdrKmduG0MlAW1ye7HkrCDL1e8QoJpeiNejqPHNxdIs?=
 =?us-ascii?Q?cg2Ey+UpxKDV/qqwcVdv0yT7G6m8l838ChRmOu1ceoT9N6qkLAq8sNd06JwD?=
 =?us-ascii?Q?vJKndSL6lqh9Wm2U+IPTeDEfnS0pJzBcbYSlIM2IVbRN/xsVve2L2tYD22Vq?=
 =?us-ascii?Q?eWaGNyGLaOD+JzS4bAWxNgJjU0hCJdL1QWsHX1sG9DnC1bjY8rRf5cqwZJ+N?=
 =?us-ascii?Q?QmZpkaaa+Rx3ZBt/xgy0jIuF8gLQv+0/kI6xUYHEo1JhVj3Fwf3c0k29jzhZ?=
 =?us-ascii?Q?Q/pmdzmQDNLlhxyh0KWb41VsEJFvHsqhRwsHEkaCZUbihpWSZTJCO/XvgC7E?=
 =?us-ascii?Q?vIvax8nyIxw/V87a+0kpfCMKODUO0yYZ0W7om3g3fWfaxj552PyIzlnbcEYZ?=
 =?us-ascii?Q?9NoAeTCIrrWavExWHvtIJS3q2VyEXxvvaoGYA5kILxBG8/fUNSnsI4S70tC0?=
 =?us-ascii?Q?ov76n+RA2+t3nHj6hgkPriF1Sq51KsnYYKY03XXa3587DR+rOtmNrDNfWy4V?=
 =?us-ascii?Q?v4Ykjf+3oU6TqOxgyfzZx0DvgFLtPN2VRI+lLneFpyUyoFGRCSjmyOCj3mz/?=
 =?us-ascii?Q?sI/EzaEiK0kQ8T/vHKCFk6b2dBN4kJFOaCArDzS83viylJ7xBMBSkIAa7ch4?=
 =?us-ascii?Q?7YdnaGVc3joio5xkwhUQk/wPzuVk4QxTM+GZqsUvJ98VrAMrRz22TqroEILT?=
 =?us-ascii?Q?/MyiDBkkK8+bXNsvslMoMmZqFUPfWnJIM02jNiGDvllkOx2Sjqpkd+mULV5R?=
 =?us-ascii?Q?ZkvcuytoyIsetbbzTNmA2oEcm6gME067rHGojDJWbDAncNvDcyeV0mOQWtzY?=
 =?us-ascii?Q?RPS3N2FJGXGhUAk36csAwvURnsin40RGbH1Z/eL20lVX6JpCQHvCZtNFkNk0?=
 =?us-ascii?Q?UQ5uAbsmH4ktk+CUQeFtH9RCuiqyTxybG2IPJmY/H8c7dMFsTyXbSfS+PCFc?=
 =?us-ascii?Q?vHuVlEgJw6suh0K3Do14uOtKtpdLq3JMqMcJuhRJcc4a2Mxi7YCP1t3+0uBu?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6c72e2-3de6-4ffb-c29a-08db268f12cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 02:26:54.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTTzvMcQ8qFd98Pv1YvgmfkpaEHJgv74E0NWDWj1i3PaxCDzzB+2WIuKratcsNuwOILaM294Uo3tRIs8QFyD2uhtOaByFOd+wbcs/LxtWc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
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

lizhijian@fujitsu.com wrote:
> 
> 
> On 16/03/2023 23:54, Dan Williams wrote:
> > Li Zhijian wrote:
> >> nvdimm_bus_register() could be called from other modules, such as nfit,
> >> but it can only be called after the nvdimm_bus_type is registered.
> >>
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000098
> >>   #PF: supervisor read access in kernel mode
> >>   #PF: error_code(0x0000) - not-present page
> >>   PGD 0 P4D 0
> >>   Oops: 0000 [#1] PREEMPT SMP PTI
> >>   CPU: 0 PID: 117 Comm: systemd-udevd Not tainted 6.2.0-rc6-pmem+ #97
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >>   RIP: 0010:bus_add_device+0x58/0x150
> >>   Call Trace:
> >>    <TASK>
> >>    device_add+0x3ac/0x980
> >>    nvdimm_bus_register+0x16d/0x1d0
> >>    acpi_nfit_init+0xb72/0x1f90 [nfit]
> >>    acpi_nfit_add+0x1d5/0x200 [nfit]
> >>    acpi_device_probe+0x45/0x160
> > 
> > Can you explain a bit more how to hit this crash? This has not been a
> > problem historically and the explanation above makes it sound like this
> > is a theoretical issue.
> > 
> 
> Dan,
> 
> Configure the kconfig with ACPI_NFIT [=m] && LIBNVDIMM [=y], and add extra kernel booting parameter
> 'initcall_blacklist=libnvdimm_init'. Then kernel panic!
> Theoretically, it will also happen if nvdimm_bus_register() failed.
> 
> 
> For kdump purpose[1], we need to disable libnvdimm driver to ensure metadata in pmem will not be updated again in kdump kernel
> [1]https://lore.kernel.org/linux-mm/3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com/T/

Ah, great write up! Let me give that some thought. Apologies for missing
it earlier.

This would have been a good use for:

Link: https://lore.kernel.org/linux-mm/3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com

...in the above changelog.
