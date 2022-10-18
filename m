Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596B6033C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJRUIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJRUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:08:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36238ACA30
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666123691; x=1697659691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ewL2y6xUnvnxsKT8SFI35xeFhJILtLCP43JODMAw5vc=;
  b=Ewre5Dze287Pql0BX4480NXb02iDgvCX6sVUGtBylW2oGv22/wNCneDQ
   8LBz+ZCXPAer/6U75ANvjGJi2V1ATk2tS/y91hiVDEPZ7Xf4RwoDN0nE4
   WkUIrekeImRtugwnA7OFRdZGYS/X976Yzd5HiZd6Fg9+BbDVU/jcVyjIE
   EZLNEtoqybpjFjtv+t0Ws+fHTV01WD2tQrJYaXXu6vRmyttcngSIHSZ08
   qZQlwxOHii8uw8qgf0qtWAIbouUj6pSVng43lq+j+JuJymYFhhtAKYBWn
   E0s6luzIBqGGvKm5pHTwXn0sAx/NM0GuYwnIzGZDJAOi3UlLaGsC3p9q0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293617849"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="293617849"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="659975001"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="659975001"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 13:08:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:08:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:08:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 13:08:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 13:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaG2x695kI4lL8f5h+fCK5vMg0c+Ht8TirMH9JaOgqgYns+1FL1BBzhWX+X3vNnKM9dZAOLhYOoWjzhmaqtfGp8tAIlJZeH8zgBbXzMoNFphqnGWnjGepx52CsngbSY9fGKkMKDwpWvh+ffV/VzN0JEU5rguSk7N23fdtXmZGniQc7Zmn8+k41aHTFa0oX4FYmEq3PbK7ED+KGzs3Wp4/Xa6hq8JrpCWtqg4d8B4vO8AAWiHg7qa5q6LJpMcgSU3AbzFf0ZhntW/xot4w7N6nL4ltZ/wjS6uySU3zRcB4yACl6JMeYlhDlFj7BBxJH7qjALYXDUkAO8NxdSdjwg8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XneHoxhqe60Js0tLjjORjKRLqOOuP6Ukd80V0EPFwaM=;
 b=KZmxbIklxr9eQxQ4/yr+46gHAUjXvEwgkbjGKwilPmcPWMD8RaSxc3pBLWxJimJaPEpoTmjGJObLl4so2vL6do2qOZFj0c3Vms63hRcFjFFPkjQB2+dX21FU27gmCPzNMTqPPj8WJVhzAdEFvmcUD8Jendbc866RyVPHn8tXr9Vn4mhgZKhSVOKfEm/7KO7eqpbP5l5853FvOyEHbzqzGraCQ39N/7QSKNIAGy5cwI9zL+YkuzuLV/au3YT7R1OVtf6hc995IMQ8TCgE6AsSKAIMFmKcLwPRm2hRMJAhGlskErMZLp9fFpAu+vjFJEhSbgDsDlDaiGvslyixtiJLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5610.namprd11.prod.outlook.com (2603:10b6:510:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 20:08:03 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 20:08:03 +0000
Date:   Tue, 18 Oct 2022 13:07:29 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Bharata B Rao" <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Message-ID: <Y08HgXqvNSpTUgWe@a4bf019067fa.jf.intel.com>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8c9c36-0df1-4e79-d7dd-08dab14476d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUAh0usLrouYygipKepfoA/ri4Va0Jc0qKZ3F2SVgHfhShs60sxm/Jmxu+EfLaGVVkM+YHlKXUshGbmsGYc0HlscONYj1+XOuhK/ScXjbZDRZwg/0uFKd2/bNGTIT0n0sw6E/xnp1MgaBT2W74NOYtbokcOlPUlo3fT3GVzW0zC2nnYE/VOb+2Y2DKL4NE9e1xFC+S4c3HrVGZbJlhYbe9vb511zHPNmvwGl60GpdqAfFGw1iCOJ65AYhLSeE/lHgXVHRMfbTLLvMXMh4MeHYlD9uGpyNvWoeKgA/12eU+QcTog/et6heOcL3O13mDu/siOq0J0IAWVqR08v2seDZnovcbt/4GDE7hu/T33Zhz+hMlQuHYY1O7AO5mWxN+c1q+cgnKAHb34/WCZBROIAmHBFAO6zN5nh9TTNnOamEVu6HjGWedNzJa0IPJN2xlpVpTHGw9MTTTVjVQxkQ7NCngvHCi8AkExhS6es0jrRgXpWGuhiqngKahW6R1FSaDxSUpxN4wMSYZnTOvfNjDnxvBFVg9cQsyTQIYBDjd/Um1H/R8NyHWp2no+1Qbh/pltqhSO8aRdxNF+hoqVUJscQB9EGxVhFEZOaTla6lTxVcMWylLpahezZiGsHmx9puZBKt4eFWu5hE1s4Jp70xM6cjHRak72XWv6ZeETibxapWiydTVF7BRt1SHzw9Ym2TLv/lBfTxhitwPyRYBBzD6VQeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(186003)(6512007)(6666004)(26005)(6506007)(83380400001)(7416002)(2906002)(5660300002)(44832011)(54906003)(8936002)(478600001)(6486002)(316002)(41300700001)(66946007)(4326008)(8676002)(66476007)(66556008)(6916009)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQXM8qKqkweVlYtHceOu+hkM77sZ4zr860SAiclfJzEN1LHPEKXoFHHfTvJB?=
 =?us-ascii?Q?XzHZFn5mlWeIL82qIm9cVG1eotpIhUo+owm6BS5IVxU4KSBChZ3171eIHmZt?=
 =?us-ascii?Q?/F8d0xhmjTDWlcAed0Mq/Jtwkwmf0EegAmh1WTvMjYpFhV9fo324zz/Nw4DL?=
 =?us-ascii?Q?4kCAyNH+XZmaoKuiYeSrg516JodcRx6hXrSCboNRfml3yEhcSGbsR046OBjw?=
 =?us-ascii?Q?oFJ8l3Lm+mlDilXYwj92PUDx0OxmXEy8IbAhg9BYSgFZxwJecOQS+fUinfrq?=
 =?us-ascii?Q?N1JSF3qCs2s/Aor8gonzxnqcDjQUuYuzYSBfkrWLwpIdDF4Qbxg5TLZjl2uv?=
 =?us-ascii?Q?TY2S4rWENFCnKyOTTdh3ZPxkJjHN3LGNym67d8rCejxTk0JFwSgHOxuMy8Dm?=
 =?us-ascii?Q?8UOFQuTxgoOAgM+o8xwCQSeNedTCZmWnTXbMWLe81Rl/fJW/DA8FOtx6+2qO?=
 =?us-ascii?Q?+rXwcnSflwlhPQQavphRK7vEeuO3ejTOQEZfcW38tHPyXburiXERgaLtFs/p?=
 =?us-ascii?Q?phN7y6REjQ2aNzIHOYOb3RlAbwaLlH9EvmWZjEShJH/0YZyDsmeAlz+IZiZn?=
 =?us-ascii?Q?FX1SciERhf372YQNs3+2/IBop8ZBXv9UaFdaMbdVTT73uRS+0NxNoo9L/Aea?=
 =?us-ascii?Q?sciyjmX9jkhJ3R4BMUNBUhBxiTQI6r/aFmGBLiZ1DW64SLezqoYYisLy5OqG?=
 =?us-ascii?Q?/RGTkqElBqE1wnVmU6mPd057uLS/fY1Uq7ZB+9eawrp0DJiERj/qkamZHtwc?=
 =?us-ascii?Q?ti7oZ/OsYh3XbkmRImBN0VSPlmcLN85DaDlK0Lcbh8XeujrKWhC0DjJ5fprD?=
 =?us-ascii?Q?Ex06ov1r84hMXu7p0jDbc98qWVsufuaT4ju4+G4XPauT75h+u9HV3tCFdXEc?=
 =?us-ascii?Q?AdySJrk5yxH8+eTnJuEN8UIrYRUT4ZC22dU0/NkTkzBGvTYe9N7U3px7D/F5?=
 =?us-ascii?Q?XDIlXew4w7jORqAVY1AvyMCHv1c6RtKieFe7SD+OG4bJLli0AxjXNNef+8z9?=
 =?us-ascii?Q?2ZuEqBiyqyAiBkGu7UbzoQFsFkjAwglSFiorQMX3I/XAtaeo4nbtg7PzO+iM?=
 =?us-ascii?Q?DkXJ9FDvFhK5aBgFEX4J9vveVlzuOOcaWqFZK3r0MWCo4ZFGvpqgovYob/0G?=
 =?us-ascii?Q?QwoFtDzPvvHca3PP9VszjVzGdD6fynZtFFfTQ+3SJZaGA5m3JK3J8OHVDJq8?=
 =?us-ascii?Q?pFJwkSU3GBXfaBdOSCfIknYPyiaHFVNsvzIvzJzhxOomd5ZI/Deiv4jXKn67?=
 =?us-ascii?Q?Z4RAyNIvHuLQw0RU6EvaAjYMwFpcoYW2Chqegf+dvZqJsw0bvEl4NEtdlcUv?=
 =?us-ascii?Q?oqd0W2Z3gRaCoowiOFbXucJTgmfc326UIhRfbAFr4Is9IbPg69oBVWaDj+dB?=
 =?us-ascii?Q?pSNRbuRZbs9+8Ff+2PIsXpYr7ta+ayx7SBWaOVJsF34gkU8rx4fERsLJja7A?=
 =?us-ascii?Q?4jpgTexfYyPBzEwkiVDa+/8+VQqlhu8jo6u/sfZUyk3fUWnRE0BabfQXVqxA?=
 =?us-ascii?Q?sKy9wcGsZZi8hFFthFkNGLFwrnniTN4n3isn90ShfK2WD3P9JM4Ideb9MKhq?=
 =?us-ascii?Q?P22jhBsMsMR+IIxD9V16cD8c/lULnuVyuoMvkDLkThSwtAF0ms/u9+weveTn?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8c9c36-0df1-4e79-d7dd-08dab14476d2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 20:08:03.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9asnlw1h6w7Fmuh8u0dtkjMLBaxHF98U4dPPDyKcZDTrZSe9eVkbt1ZXDY5dTdh6UM9/jEyN9SRnYbeXIE0wUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5610
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:33:53PM +0300, Kirill A. Shutemov wrote:
> IOMMU and SVM-capable devices know nothing about LAM and only expect
> canonical addresses. Attempt to pass down tagged pointer will lead to
> address translation failure.
> 
> By default do not allow to enable both LAM and use SVM in the same
> process.
> 
> The new ARCH_FORCE_TAGGED_SVM arch_prctl() overrides the limitation.
> By using the arch_prctl() userspace takes responsibility to never pass
> tagged address to the device.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/mmu.h         |  6 ++++--
>  arch/x86/include/asm/mmu_context.h |  2 ++
>  arch/x86/include/uapi/asm/prctl.h  |  1 +
>  arch/x86/kernel/process_64.c       | 13 +++++++++++++
>  drivers/iommu/iommu-sva-lib.c      | 12 ++++++++++++
>  include/linux/mmu_context.h        |  4 ++++
>  6 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 2fdb390040b5..cce9b32b0d6d 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -9,9 +9,11 @@
>  #include <linux/bits.h>
>  
>  /* Uprobes on this MM assume 32-bit code */
> -#define MM_CONTEXT_UPROBE_IA32	BIT(0)
> +#define MM_CONTEXT_UPROBE_IA32		BIT(0)
>  /* vsyscall page is accessible on this MM */
> -#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
> +#define MM_CONTEXT_HAS_VSYSCALL		BIT(1)

Nit: Looks like the two above format changes got in here :-)

Cheers,
Ashok
