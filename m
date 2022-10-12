Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496485FC22F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJLIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJLIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:44:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21A5F18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665564276; x=1697100276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7kw+U2FDpw3L1mimHCiub/fY0xQPgHX8gqCeU2LnIdY=;
  b=jnRKOLXPEFnK2sc4Sg7jFPbeOhSCLpbCpDeeZn1NXzJDK5OV0d/P1E72
   nBxc9BrAjvP3aUbEME2w5Pf2HwnSF5Q5VuUZsRcLXNmM3Dbg78YlPE6xy
   IVDqbSsX94CWpvXy1FDu0oJAXBXKTYQSl4yyUL+PczSEiWRWrWdddUmfm
   5mlzbCqLNkwrm/5lIWH03eKLRp1y2sFhsIcPhrjRutInWX/np8ZgwgGDR
   nTuR1350mxgRR6pXSmCzJrdlUWRp1Ga3Nd7rue+ztxUQgmf0n59gOlx4V
   2/daHPMzJf8dNPplT26WrGiR+jVWmNAOg/mk1w5Lg9PeySZZ6QxUtlpSt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="304724948"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="304724948"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 01:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="801770286"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="801770286"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2022 01:44:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 01:44:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 01:44:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 01:44:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 01:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCR1kWIIElLYaTiAuWKy3WUKA0buTgvdGBGKP0aS0rpz1kMRwCGFm/ckJmGwSJWxYfpPPSQc1Ul6YRQwWcCsg6Fmp6HVtMBWuJc0XcL9PsJ2ffLObTFG5BrTkjtfP8Y/mdNcj5xICe0qHR/RlzlwG/zvGM617fStpaLz8KQxFwyYFB9GaA2ciTMBuN+Zrn+keiEL4cTHZKbiO4Z2fbaG9+sBg4UlskAsPhhiDKsCWyrZivnRtR/9n4akCSW/Aj57qLDxyQZnAKP/Sk71A6kPtn0TKovpf9a2bFmNF6FBcTqo3oOo95vKcs/TF3fh4IcKwwM2h2YzDGD6//xPvhLYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqYDDugVjLzZM9si3Hp15B0YimouQeYPkeVBes2mx4k=;
 b=LCiOc0XTG5GLPOW+ANNqisBiYMKGSfSB5oGGSrBfEUmdDUbdHaAcrsKPVtPHjkaAI/zkbZYr84QFf6Q3DJyYDr5FGTkSg9XxzJlH4BrkP64A32orSU5cKk/6pfvSjCw+R99PgMxxMY0QY14kJt4TvNTn2LMkRD5ArySYjv+QI+DwH6MS10PHObyTKOBZReQbV0VpCq/8nO5qcoz7UDnqXWD6Qp5qPbcVAJiY5etFfZpLypdO79X9TSuySmBi2kW9/lZnRB4l/VvH2Pc7oYHUk3t9Mwa7X+EWjPAAPzXbur1V90SjR3QqSPWZSZuVz67csjezBsh83XeDgmaL+d2qiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BL3PR11MB5699.namprd11.prod.outlook.com (2603:10b6:208:33e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 12 Oct
 2022 08:44:25 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 08:44:25 +0000
Date:   Wed, 12 Oct 2022 16:44:05 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0Z+VR9MnASeOA3S@feng-clx>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
 <Y0TCOKc7n38341eJ@feng-clx>
 <Y0UgeUIJSFNR4mQB@feng-clx>
 <Y0VpG8POb4AL1g33@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0VpG8POb4AL1g33@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BL3PR11MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f4382b-2d54-4092-e7fb-08daac2df79d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6i1XX4g5mMOAhYrSbAg0KOc/9zLcdNdAG+yeCPDjWi6gBSzW9cpzsoRkkOL5zxO1ooibSpE7+JICgC7O2+W2tJjgK7EFfOaGgZmk+pSA/rVdFJbnX6UBe1dezJTjvCIn0WHZSLZex/G+djxhizRSw8PAuuncyJydUZjwdYVUm2WS+VX8Ge9Gjyih+XUp7e5Q8s4hhI50SAOKYIflbsmqs50merP7BWo/yyyG727lt19jiaeezMjkcTfr1KjjBRz5Js4L06nyMC9UTDA8V6M8JZykH1swp3mY3JOAvGbXpm+2ECj97a95GFRQT/pFy7bAtq855V+4KDjbhD2f8tEr1zylDDZ7qcV6ln9AmIHOEZHQXGSfbReU3/Nt/WvYNWZqBrzxVeeeJL1Ik9tWL+z/6C1b4RzsCOsZwNZQ3H9zXekS8DPSBLlybIDcTNxRnsmIjS9TkPa+rgPkI8yzLo5Q2rmFKW1v/HCgpV7y078c6eIajJSprEFQb7Qwxr+M13yR65fPmFmp3trYKng7iMovATxrzaKPPtLmn2xgqY0DrYvqtyRA4Q3Pvq78wgC0lStUt+qZ0n9OuruJE1DuWYwdGFfTajU0YtsJ8Uwpewt+3sV+gBnus0EUQ/HKLQeqI1a9ROAw7Ae1XQ9xeB9cU7yuIWKjKVgcpEPUPF8YPaSlxY4xMJfijvZBxAOwqKg45xo1HJbfismn9xvYl80ZaQTkZOgRpnqhNxJbNOM+A5N0KIIngcjs/Zndi9MCaNUYIUcUDkvPwgHaXsd8+fSD+JpIUUjkJ+8pxX0yiE7eiOHzm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(6506007)(6512007)(86362001)(110136005)(186003)(44832011)(83380400001)(478600001)(82960400001)(38100700002)(966005)(316002)(4326008)(6486002)(66946007)(6636002)(66556008)(6666004)(2906002)(9686003)(33716001)(26005)(8936002)(8676002)(54906003)(41300700001)(66476007)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/S9dAg//ifCNMyZjnuJi0CUFDEq7YEmQZYmjsAsjFz5LBZ4f65ndKYeq1u4?=
 =?us-ascii?Q?iYxGDvQyCtZnW+zgH86W/xcy4Rublc/BSwXso8kiV9c6OdiZ1dMw4+hk7hTE?=
 =?us-ascii?Q?RkzhyCAaXrgeKutjIfP2GsBkxCLmwHlebgkxX9woSVgBs6/nRf6yCmQL4dcM?=
 =?us-ascii?Q?tVBtv3xicFkYW1gDTCW8aevKQGtE10uAib1Epq1Dru3+SCyIV9mJxv9/VEmO?=
 =?us-ascii?Q?RXwFuEsFY8MablxFWLTIkuTLjsB/YmaYkREeduXyAUIlRVrz3LLdvZ//g7dz?=
 =?us-ascii?Q?AoLv0sQDq/MB/+gWAALQ/jLcYa7SgO9qMCBw2sBxqqUrntEr6Ic63va3PvXc?=
 =?us-ascii?Q?p5FFwAcKdutmCYGxpaFBVQmKFJ+EjHkLBdEbfdvc1pWQVLmEvyDck4+IZ8gq?=
 =?us-ascii?Q?SA3wVze9a/GE9XgWEGVmYTNVoPalxkdO6viJWaRxi08Wc4k5u0FApKd5eOYm?=
 =?us-ascii?Q?fU58ECLCAd2ThpvMaCRT1TXPDnVV73ezR9TaDLVv0A8A7dSFp3O2AzWhniPB?=
 =?us-ascii?Q?bOmjEh5ORRITY83CKifxRRFWqo+BVW+6/BdfjX9ZOo3KZvwa841TYH7qOjwT?=
 =?us-ascii?Q?eTOSX6kQzyuYxSSRU4/mj348qKaZxQ25BGBEil/Gga0+s5QAutSt7dxEmbco?=
 =?us-ascii?Q?jtG6KFCWCK//NbilaMH+j61UHdAllS8sXMpuQLpPksNR/9SU6+xDGDzWOoy5?=
 =?us-ascii?Q?Uyqhvs9fMRJaJmBdBL0d01DSF53sBJgJe/gsBUQu2kelrirI/TVCNGDmFh26?=
 =?us-ascii?Q?YUuLXBVrBykhQveUv6fmjtYtLI4WAzyB8/QZbkN1mdjhG1Vab5TXJu6t6Jrd?=
 =?us-ascii?Q?vSlhfPPqJJB60pm9EtB5IEUg2eLN2Y1wqm6Z8YPZ1OrLdoSK4K26GzbOk5r/?=
 =?us-ascii?Q?pHObz2WrekmTUQDUpkWHKS0Gsz+wWCqhQ0mHqhgToeq18az6sGN35JVc8WTk?=
 =?us-ascii?Q?KsxVO7qLm+qMdbqlzutVqdC+nGcJ2Rqqs3CCmY0AhG3YSkiAW7m5cMRQmDaN?=
 =?us-ascii?Q?dzGzDZ5XGEhJSoYZdnFier4/Yq2J2hQGUSaM/clc5OrCp2ViyZWWDH2wgGXU?=
 =?us-ascii?Q?Km3+tFfDcS6BoBiRU42YdNhUy1Z9oziV9jlPn3/ccvOfIPVBjvI7erTJ1uGk?=
 =?us-ascii?Q?W/zcH+j2TZm8MGYYSTVV0BOlPXofBut1wW46dgj6GBi8F4KAR9yv+fr6yU83?=
 =?us-ascii?Q?VvOR87ASB5Al5HYxbOEw8DkQrv59pXckh6ZPWdgq7Wu+ZMclWP9x80hhNpUR?=
 =?us-ascii?Q?ueMttkWLNWgx2c4P5H6vlbMVdd4AAkThg4WqGZtOmfgMn5Op4dfNo4nI3+ZK?=
 =?us-ascii?Q?bDiEJa5uC0DssjSlS073KeYkP99EEjkBRedZfK/MLoXfMnI11Sk7Hc4InIhd?=
 =?us-ascii?Q?qlF1SjDNCp9/cB6Vun5HFjJQhCfpIqbN+3S1oalyKbPh7NZB3t4GwHhkDiho?=
 =?us-ascii?Q?t4aB9YUi3JAPubC1q+EYe7XZsU/XwgXIZ1eczacW2/JCQsijDudg61Nu3wFV?=
 =?us-ascii?Q?9tEnq0TWU4E7dtlKQbuwQaljSs6EAjDZNN08XkCbiCjxCqtwwLAaID/Z/8PM?=
 =?us-ascii?Q?dzEqoC8VnS/Hxa8owykxhZSoH+Qh+fLU5T8I8PRR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f4382b-2d54-4092-e7fb-08daac2df79d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 08:44:25.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC95vSVpKvN0gwriDXNuj4PUg9kllaDQcM24tSfEkP/N6q6k3xBQAqdQLqukUsRh62zNoZRI2vmYKTgrYq8Tdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:01:15PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 11, 2022 at 03:51:21PM +0800, Feng Tang wrote:
> > Th simple patch below is to have a dedicate CPU nodemask and set it in
> > early SRAT CPU parsing, still it has problem when sub-numa is enabled
> > in BIOS where there are more NUMA nodes in SRAT table. (also I'm
> > not sure the change to amdtopology.c is right)
> 
> No; none of this has anything to do with nodes. This is about sockets.

Exactly. All we try to do is to get a closer number to the socket
numbers (also stated in current code comments)

According to our discussion, we haven't found a way to get a very
accurate number of sockets, so I plan to (if no objection):

* Send a patch lifting the socket number check from 2 to 4, to fix
  the issue reported by Yu Liao.

* Send another RFC patch[1], which makes the socket number more
  accurate, as it solve the 2 problems mentioned by Dave:
  - fakenuma (numa=fake=4 etc)
  - system with CPU-DRAM nodes + HBM nodes + Persistent Memory nodes
  but it still can't cover the subnuma enabled case 

[1]. https://lore.kernel.org/lkml/Y0UgeUIJSFNR4mQB@feng-clx/

Thanks,
Feng
