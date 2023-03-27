Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C26CA105
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjC0KOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjC0KOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:14:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924212F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679912057; x=1711448057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qYhFkT9/3EqOPfcu/S0sAWi1my0oqYiN+BpZWp41ovQ=;
  b=NqrJMMDRGefWs8G49LsVhVqsrp/encT//rbVBgAGX6Tsw7fvvOkvY2Qk
   58TZX8F53i1QF9VjdPEDazFIJBXywvNBa8rYWIny7HFii5E+cIipaIUtv
   PGnvlzgpchiYScT0Rl7cb0c/DVuw2Vxwk+fQ26iLzzBfVzGBu25IcNdIX
   q6ilI3NCIF8XhGcaNnODc6AiEiXKi4loWMgX+xIpqQuMpRPFW8WZkCvZ/
   u0WXO5g5IcRAMZ48gUoeKQ4eLn/JoJsoEtXA23bgCDqNa5pUqKWUBP0to
   Tl1QgUFiuFsGXTHpo4Ys5QrttkYRCJ14YXpUlItVf5xbHD50yL6QTDTKr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="402825289"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="402825289"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="929413123"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="929413123"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 03:14:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 03:14:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 03:14:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 03:14:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 03:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjV9u71xSDpS65NKSmGjizTZNYiHZBo5GYWluHKMYWlN3VXmr7bTInymFA5E0VnOz0VDweCzqRDL5wm8ED95FQJuYSMlJQbec7lEGFafIkW80eih6pvTYD/H0UCJSSZI0JXqjRvClygkiA6z50QMsKbWCmiZ8yVL0nNOKbdu35whyYC2FZe+9fsgJvGvF2VW2eyDabJEXa0aqUy3U7orDk7wWGWVTF5+VOMlX6Wm94qaoR0zEpJWEgG8oAP2EKsS/ANX/4RwQYaIFc5fg596S/IQ6QPhxP3DGTDRQ+cGSKS2JAGLScK6+v7cvHX/mSAbdzoRlTY7yFbh1DDXfxm22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sa71AINZ4y42EhdaacQLQ9xhj61+FzlZFyPrWBfQDR4=;
 b=Pm2L6efWG3YQu5BHtW9RiCAZr2xnziR9N0G7G8kFNvXg1kPXEtayP+zClc8eXHmxD8W/E+ynMikKs5LQVkXmWZA+cr2iWoBxs24yVKEvyUrQ1jarM8mGv0qFfTMPdvrFxX+PutT64qg5A8l/siDDZWWYV4lmGZAOHVu3oie6mO4YzyvjvgQkyRNqJD8253+lbUxDXG1lD2xK9KIZOVSbM2jUYVWauuImu16OulV/mSOmo5/JRlCCnWyw4PbwobMnvbOKmX03DcNfFQOZH3pVEwY3B/ofeKjyomdi87JXXzVg/gN+PYAPpmbWt80BpUr6Bb04h4hcFCUFnJtdFFiftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 10:14:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 10:14:08 +0000
Date:   Mon, 27 Mar 2023 18:14:01 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230327101401.GA571475@ziqianlu-desk2>
References: <20230327080502.GA570847@ziqianlu-desk2>
 <20230327090951.GA4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230327090951.GA4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: b485e0e4-eb47-45b1-757a-08db2eac00d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVCP0j4tDb6O6cBrlWyaBBEykF8HGjDXz/3TK7QTkl2PDHbSbn1JtB2Gm1agKxH2jhkFgBEEb2NU8R5nsCqvYSHkpV/pMvl63gPkQodoI8wlaqCDDJ3DpnODfVL3CCoKesOjy66zWykbpcYFP8L+waiWwtm9cOl3lz6BY/u66D2+Veg9UYa3W2Z/JuHP6kA/3G/u+T/LCpsiiNiSGIo7pKT2a9h/HFy94pDK6Pqcqyj7hyNRvmheVkz7Dm088pApzMXGAYpTg9jxcVRiZbmKD8uQZIsiHitGdlFAZRc+l0lOHkcexySyIWlE0WULtDIlvvLol/8kHnBhzsUPV66e5BxWqY+h6WMBQrTNaU9TN4IeFm6mdA/B63ZeK35xjlKZApW6KbNy5+jBn6RZczonuD5G5JCfXD26LKWABd5TPPnf/6LDk61qyrHEPYnCarXU26r1ov9Q7JgBdcgEm3bGaHf9k1Vij0pAdm+Rh6CWRQAVXUMC5NB6fWdmete0OTqFXs7e8U+YISgkKi8DBnYtzsefwkbTOACzvyxOnQ7PDPDn/XEpquXxrRi71go/BfgEj6iZ62x5q8knQhDix9TEqVuvVXamXYSY211AW8AEmE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(41300700001)(33716001)(44832011)(33656002)(86362001)(5660300002)(38100700002)(8936002)(82960400001)(6486002)(478600001)(6916009)(8676002)(66946007)(66556008)(4326008)(66476007)(2906002)(6666004)(186003)(6506007)(26005)(9686003)(6512007)(1076003)(316002)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKqlghg17UXe592891QQhCj56AfqCMr+c8b4Jxi3xJHg8hctNUQLXqnDqFXB?=
 =?us-ascii?Q?dg6upOBwUCQuruRxIrfwy0FEX9cHaMOc1j67at81C4be2zRDCT56X8pgJ20D?=
 =?us-ascii?Q?AH3wCXURXVA47aP6ycPLstOsEnZEgHE5FYjUBwJHuLxHWzD3xrC56lumWYp6?=
 =?us-ascii?Q?FzvByCGrws0RfEaH7GNIRrkjArklaWQEJOibKUI5Pma6CvY3Ynr0/LrfRGDs?=
 =?us-ascii?Q?SKXqblWb44cOTHm7b2CdOyPvMs9nW4ZCRodGDBtijaPbKnNWC6KJ/3Ov7iiB?=
 =?us-ascii?Q?CTmcqUznHEWuFi8aWhJeyEFzD58zBqnH6d7Gklc2Y51HhpFYmsQcxil3+419?=
 =?us-ascii?Q?V5wzOveCktNGOfEogfia5VFWBKkMKL3WlgPMCUngdQq4K+oVgz8ZNx5vM8vo?=
 =?us-ascii?Q?w5o5K5g471qgdUOhQxFV5BNgs+tlj3RfOh5ZScfGlfCWnhc4mCUAwFxVWHwC?=
 =?us-ascii?Q?vya5shkrI/Jad5DrIX3XlXN/I59T+LQtZ5UzEnXtLoClFsNhV3zKAWAu4RaY?=
 =?us-ascii?Q?XtryI0dfxzk0EkxDz9etqUaoCaNUuE1c/kJ9iqVuVIIX0ElEp2Rg1u8pUoqx?=
 =?us-ascii?Q?u9/zNjBclRZR52VVc4sj1EyvmazOpTfoCHXZXb551olYBKe5Eqm8UUZulNDB?=
 =?us-ascii?Q?R6vcdheBSFXMirO7MB8cTtv1vNaE3nnrc96iAEEsQRsxLcVt4w4V17KbrXTe?=
 =?us-ascii?Q?OPnKDVVSE4U79iG3H08okLb/gJiLTUhgqh5J5WtgZtjmMkbL8qYvOgna+A//?=
 =?us-ascii?Q?6TY7lkg616xxVeXyhSGKGq2CRnsACFZrAO1idWbs4lLGGHqdvM1q/IjypPC1?=
 =?us-ascii?Q?C0CwmyfJMFwDB37C7fXmc6No5AXdjlpoTvUBtHX9+eUjqvIn8nh/L6FGDNZM?=
 =?us-ascii?Q?obRpihn3BTsA2ZsRdZf3f9qZYAPpQ1Th4ZZGm07M+uC4IU/sHzucIEKKK6oe?=
 =?us-ascii?Q?nVtt0+H+r7jYum5k77rFYWNvgrJPsl0e0txQhPOIpBC81Jhm1LFxOuQgKPqf?=
 =?us-ascii?Q?C6YwADL72npCEJWWnkjkl//8YRtn/btcl7856gBTr6jpbtkuz14toQ775wG9?=
 =?us-ascii?Q?44Tv2XOQPzfhBUOto6UqqCnwcWrrJj6Nn5OgTT5SJw9uoTqZ7x/2C8cK/ZwW?=
 =?us-ascii?Q?cC7bHYbLuX70llVtTeNyNniz39wC9phwV1jgn71rldeTLAVMtGHGPNoB89ij?=
 =?us-ascii?Q?FZUTs2KVXk2OxjYcKKFYgBcIqHnuWoNAkuf8fufk8+C/rHUIuHWW/lBelsH2?=
 =?us-ascii?Q?YS5r5OTNgdz4GoPy4t6V1LY9s4ZCHZlOEHiyUEnggXdwBx5DPpGko+/lrj4a?=
 =?us-ascii?Q?SJNt1N5a+belpVDOrEyuaz6qjVOSbUomoDDmd/rIAsIMxA62ld0HFbo1KaU/?=
 =?us-ascii?Q?5fjGectZuu2WEnEokuQZPrORImnEtRLZYLDiuTV2ddXussNLS4p3nuVX4z3M?=
 =?us-ascii?Q?HJWNXr7wKf0/fhKdVjvBuGFYq5Iqeb2Et35gPjFddLYYJAQlgaaZTbbfMpI6?=
 =?us-ascii?Q?Gf12SPcU7MXsrm4jqGnC34pkMtW6kks1aEkIM4Pf9dU4k3tGIk0rSfNhlAkb?=
 =?us-ascii?Q?Pn+veG8petWi6vytJK8EaZtf13F4USsZpHFj0HoL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b485e0e4-eb47-45b1-757a-08db2eac00d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 10:14:08.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g2PW9rhY/EEDtLXfuC/hg9NoCUWIG5TknDb/QuIw0j3qp9NwM2GLFoLNhnp/17q5RhczAiG+vKXeQ9Y1Q6L7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:09:51AM +0200, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 04:05:02PM +0800, Aaron Lu wrote:
> > Hi Mathieu,
> > 
> > I was doing some optimization work[1] for kernel scheduler using a
> > database workload: sysbench+postgres and before I submit my work, I
> > rebased my patch on top of latest v6.3-rc kernels to see if everything
> > still works expected and then I found rq's lock became very heavily
> > contended as compared to v6.2 based kernels.
> > 
> > Using the above mentioned workload, before commit af7f588d8f73("sched:
> > Introduce per-memory-map concurrency ID"), the profile looked like:
> > 
> >      7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
> >      0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> > 
> > After that commit:
> > 
> >     49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
> >     43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> 
> Unlike what the subject says, if it is due to that commit, then it's not
> rq lock but that new cid_lock thing.

Ah my mistake. I didn't take a closer look at the commit and seeing
__schedule path has lock contention made me think it is rq->lock.

> 
> Can you frob init/Kconfig and make SCHED_MM_CID user configurable and
> disable it to confirm?

Sure thing, compiling now and will let you know the result once done.

> 
> (also, mathieu, when you do the below, you'll see it is in a weird spot)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 1fb5f313d18f..f2661f73f3dd 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1042,7 +1042,8 @@ config RT_GROUP_SCHED
>  endif #CGROUP_SCHED
>  
>  config SCHED_MM_CID
> -	def_bool y
> +	bool "RSEQ Concurrency ID"
> +	default y
>  	depends on SMP && RSEQ
>  
>  config UCLAMP_TASK_GROUP
