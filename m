Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662E68CDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBGDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBGDyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492332E7F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675742055; x=1707278055;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9M63RgLVMNCOLvwB3KmSlMDgGUqpyPW9lIKb2rTRdmc=;
  b=DkLS0ZJZRsLFxxyub8rULaVz00uJL9aS6qalohDj7jpGPkl4lQhVji0l
   i+WdDeabh/ZTHUJIo1+PYEbdZY97lSCzko1v6X3VpBVSd8QHI4+tDPlMI
   yc8oAYB3l6w2NmRCP6UJ9Pfu/bJaCQsa0QT6V4ctEcaDnIrFjpVWoi8wB
   jrHrZY/z0DgVrY8Yw0T2wNNDlJiy6twSIfQZ/GxCDiOnF8fvDQ+g+0lDt
   Py1gV8c2Ll2V/mVOSeaN3zlBBGXB93mJ8y0ude32LbprAMV6fgYSidR0k
   1exARFfUmoRjcVPw+VOSIuy9+0rNCBPFgcrGA3dWdaXTfrULi6yF18zSW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="331531064"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331531064"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 19:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="912175423"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="912175423"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2023 19:54:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 19:54:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 19:54:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 19:54:07 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 19:54:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSR1kNdvZFpHy8x4HLFYVQ1ZFa+NiUv8CIAe4QWu8Mcp7orsXK5Dq+0+HmVaO2KMi2UAraryUaUpK+WAfZKkWXg+w2hyC20JJSzrF/p6Bhpr4WDlD2adL6456Pn4LsYCsYjo81vxqasBcu4FHTw0DJK/75uV4rXoKQwp1+DMhxCUMijW1v7HjBTT1KjrUICRBsbB8mKYIWXEPAk8wIbub7N/+7dh7TsD52xMxIYnEM+L8VBYotvTDxl27Qjv7qAelhgpbZ5EN0zDXdqmbuiNFsUoqCyq7gY4GUZnVy61mI9N4QU4NGK8/gxcl5qTqLRB4gdfaDlAf5PpXtALmyylAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlnRxFi9K0Vlh9gJEW7G5MUMIAUvdtO1Rko0Dud1Idk=;
 b=W9zRoMqYWWVF8PjmLcF007g7wYMTcDSw/haKGqpcX+AWnv8rDg12g0UnNexhcEJYMZ6GCXi0UoBnyR0+yYOwytYD9IT1RyjH0scQoIgYAb9qCiMKxcrMKlL6PQcPbXJHIdVgNl4NtfxHO+yccqC9M3Rn/cHsIXsjpNLg1/1RYqIfcYQoMh0JD2VPDt+/LSPx9v5kRb6B7i3rHq31U1dWX3TGzbGNlATznibEpo2l7vSlwGbKV8bJq8h5f9uQerR5lVRvFixsHGkMqKPH1PW1d8ZXZaDlzORAVcH4BTX2y/FhCAR743TuIKYr+ZjqKN/fCr4z1lc5lMYMuWdAIMjosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4851.namprd11.prod.outlook.com (2603:10b6:303:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 03:54:05 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 03:54:04 +0000
Date:   Tue, 7 Feb 2023 11:49:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bp@suse.de>, <x86@kernel.org>
Subject: Re: [PATCH 2/3] tools/x86/kcpuid: Update AMD leaf Fn80000001
Message-ID: <Y+HKRLN//GnP0c5r@feng-clx>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206141832.4162264-3-terry.bowman@amd.com>
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b09d0bc-5754-436e-db35-08db08bef4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqPDhnm8i0YdzlemZbC042zJQhajCBSY6MM4ULUWFQvCzWXazUfrIanyyVELHMzMVCBLVgDiu4uyfIisZfpOuGV/yTZ/klX+pT6+FXo04qzU8asZDVojlQqAeaGU4KuMrejcpbOgweCfuAqCUtbimMBR9iUW+VGCDIiPluKjz6kz93RRTIMdKb5/2oUJ5WsehYPUB/q28Bxon8IS9qsm/TMCmQW8TF9k4NGAguK37uevIJ7SZbNqLwuPivVk7aEyy6ZPZ6GXnjalrQByT0+b1X+dEULSz+YvlNzVxAWQstQuZo2nBe7DEWF/Hqf5lhEP2NPilNGRD3aYeBr2MUHiGQspBmqytxUc2vl/jBKcfogh9fs8ye8b+TV6r3uPH/OORpLiIpQTDM3XUpHMEYvu3A23KdzYRV8VekYwEmqSNJyhRwWOFS81PxmDuE408zPBnFL5cVvaEPRPhy3ONKj/6fMD+/l6G37rylarDx2Jjqb4tUz+M84n2T2ikqtXL4XjG+tiVGs0mhBISn4Z25bG+NdOJiDtYr+fKqRCoIu+MN1m4fMQgbK8P2ZwpWzItpav2A1KBzocB3XJngXCR1kvWn9jzxfuJGXwLsTDD0ekNW1XE+0SqrC3JHLSgXEmbKtZTae4QJs/neyLJBpYSa1zAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(2906002)(6666004)(6486002)(478600001)(6512007)(9686003)(186003)(26005)(6506007)(83380400001)(66556008)(8676002)(66476007)(66946007)(6916009)(4326008)(86362001)(5660300002)(44832011)(316002)(8936002)(82960400001)(41300700001)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQ4/trRhzB1b+N6nBaieSR9la681lXy3jcN/8gt9xoldXmOi6KxjChowl8+X?=
 =?us-ascii?Q?amQLwhMFceOnuVEDEcfNtXldDFuG2ZHWYsSDMNXq76KVOMXkoMcDmvCo8yfO?=
 =?us-ascii?Q?tYuYdC0avpC2QerNYV0n53UIFk4cKfbvlKBN5FOdgWgK49vOslX7ix3olgY1?=
 =?us-ascii?Q?/cVkJta2uUeFeJjt4MhkwfioxPI/HN0CyELPjyaTUpJ7X2UF+mb7qw+Rs/B3?=
 =?us-ascii?Q?5GDlqE7QqPImLm243uRoBMUoBJoYJ1C18dGuLvAjzSQtUy+iJQUR3KLexpdU?=
 =?us-ascii?Q?burwOzbRCBrd59+JUO3EotvWOb5UJALmY9gwJSYJI1+B9j2LcKTz9OzZOsEd?=
 =?us-ascii?Q?IMx9pGBjNJMzQnqZAuowIaJTbXDNitHB9WN+7sDs8mQTYIhZ1S/sAKvqszx2?=
 =?us-ascii?Q?sJVqWQMB6szzPbZiOvKLuHuGvlMT673XY8Bqz6yrnWOrc2FqNa7GbgicVvl0?=
 =?us-ascii?Q?jJPWHQ8gVrrOV1CJCRAVj5ISz4Lcn+6QqCrn9kegdB2471TOmiwZEtLw3C/R?=
 =?us-ascii?Q?CtD6Ej/Q3HqKoQNeV7pJiBHzdbyXm/ZgpkJ/hCNXhGrMn6RxC0prgbTcRr3F?=
 =?us-ascii?Q?7ZsX+twJfFpM+rlYuHShKp7EObGqIeofDs3sjD87iNZg4PKA8QP2fwWJo5PA?=
 =?us-ascii?Q?egdwMsOWubO7ER81Z548bBqJNbLD0VeyDy4XYGyuuSzCLQpl2au2qSaeRIRO?=
 =?us-ascii?Q?rCeZPH++G1g6Eidro6CSbdDFbK0gYNy2zuY9TfyjOaZ3a5Ku6F4aDWmJPZDd?=
 =?us-ascii?Q?+2sAjxGuqleias/+g7MA2jLRjefiLHNdDWtFEch2dHgjO/ZbJ3GHXtJ5JfQ2?=
 =?us-ascii?Q?x+ulIO2nCFiq+Jqan0VpUSAClTG6cVQqUPnxrstytnSRqoWkATJJtim1dEID?=
 =?us-ascii?Q?65VSZSgupqD97+8NRayrPLGpoHUnJD6CfWLh86W9l4Xv+sOWvU4It+9APXTO?=
 =?us-ascii?Q?+bCBDlor+kqBB72q1+qgyFOcyZ/Q72UyiBHO6wild2FlSHL8MHbH1sf1b5OK?=
 =?us-ascii?Q?XGCca5jzeR0Pz+1ZWF6tWOsSt4K0WUq/D5IJI45qAXVykP+PvyJI5lkFzVNP?=
 =?us-ascii?Q?/4JR2PfBX8wghHjX2gp2nqAuD3Aa7sHvxqX3N9KvkO1jAcaUHBS0X7KXKXCf?=
 =?us-ascii?Q?QusjpRHIO74JLZKHbFo1t0Wh2LhVjch0eTQbli+vI4zxOYOcGlRPGc120iZy?=
 =?us-ascii?Q?G4RoNol8Utc4CYHpx9lW86Iuj6davWkkcpF3VMlfeRpfJVBVoiXp3GWv+Lpn?=
 =?us-ascii?Q?IxOcXNONpP7wBJD4fb05XbKr7szkAt6fEpBL8idf1WDEgUupXTZui0Ntpozo?=
 =?us-ascii?Q?MZ/cVhgGuPP4bODEXmngjCPAccji91xtIZ5IwCpkuAWzLSd0dyYDtQ1IoSyf?=
 =?us-ascii?Q?6RGcZTcGgm+1h6EuamuNQAw75WvGR2V4ymDEd43cSpwuKZNWPBNW0HG/kZYY?=
 =?us-ascii?Q?qiZK/nZtoGHu4Iu6qKVJrPNUIqlsgO6YWkZE+NA7ERqsrsWn8DEgA5kJ62Ja?=
 =?us-ascii?Q?9sWn7PF5NnbTqDZYzYmHDO7YGhdxmH2TLNDeWj01U4ILDvM6DfcIw38M3WXf?=
 =?us-ascii?Q?JT5O0t10xgfQM7C/2LWtoQ9PK6Pe26mKkcCadEMH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b09d0bc-5754-436e-db35-08db08bef4cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:54:04.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGR0CnRRgTDY5BT+TCq0IQeOeqOLtttKU2VxQerh+qsgseln0W27uUuza2byZGnaGvd1ok+f3sClBLzDpu2pMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:18:31AM -0600, Terry Bowman wrote:
> Add missing features to sub-leafs EAX, ECX, and EDX of 'Extended
> Processor Signature and Feature Bits' leaf Fn80000001.

Looks good to me, with some nits, that we were trying to make
the abbreviation short and clear, and some below could be shorter? 

Reviewed-by: Feng Tang <feng.tang@intel.com>

> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  tools/arch/x86/kcpuid/cpuid.csv | 57 +++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
> index 9914bdf4fc9e..e0c25b75327e 100644
> --- a/tools/arch/x86/kcpuid/cpuid.csv
> +++ b/tools/arch/x86/kcpuid/cpuid.csv
> @@ -340,19 +340,70 @@
>  # According to SDM
>  # 40000000H - 4FFFFFFFH is invalid range
>  
> -
>  # Leaf 80000001H
>  # Extended Processor Signature and Feature Bits
>  
> +0x80000001,    0,  EAX,  27:20, extfamily, Extended family
> +0x80000001,    0,  EAX,  19:16, extmodel, Extended model
> +0x80000001,    0,  EAX,   11:8, basefamily, Description of Family
> +0x80000001,    0,  EAX,   11:8, basemodel, Model numbers vary with product
> +0x80000001,    0,  EAX,    3:0, stepping, Processor stepping (revision) for a specific model
> +
> +0x80000001,    0,  EBX,  31:28, pkgtype, Specifies the package type
> +
>  0x80000001,    0,  ECX,      0, lahf_lm, LAHF/SAHF available in 64-bit mode
> +0x80000001,    0,  ECX,      1, cmplegacy, Core multi-processing legacy mode
> +0x80000001,    0,  ECX,      2, svm, Indicates support for: VMRUN, VMLOAD, VMSAVE, CLGI, VMMCALL, and INVLPGA
> +0x80000001,    0,  ECX,      3, extapicspace, Extended APIC register space
> +0x80000001,    0,  ECX,      4, altmovecr8, Indicates support for LOCK MOV CR0 means MOV CR8
>  0x80000001,    0,  ECX,      5, lzcnt, LZCNT
> +0x80000001,    0,  ECX,      6, sse4a, EXTRQ, INSERTQ, MOVNTSS, and MOVNTSD instruction support
> +0x80000001,    0,  ECX,      7, misalignsse, Misaligned SSE Mode
>  0x80000001,    0,  ECX,      8, prefetchw, PREFETCHW
> -
> +0x80000001,    0,  ECX,      9, osvw, OS Visible Work-around support
> +0x80000001,    0,  ECX,     10, ibs, Instruction Based Sampling
> +0x80000001,    0,  ECX,     11, xop, Extended operation support
> +0x80000001,    0,  ECX,     12, skinit, SKINIT and STGI support
> +0x80000001,    0,  ECX,     13, wdt, Watchdog timer support
> +0x80000001,    0,  ECX,     15, lwp, Lightweight profiling support
> +0x80000001,    0,  ECX,     16, fma4, Four-operand FMA instruction support
> +0x80000001,    0,  ECX,     17, tce, Translation cache extension
> +0x80000001,    0,  ECX,     22, TopologyExtensions, Indicates support for Core::X86::Cpuid::CachePropEax0 and Core::X86::Cpuid::ExtApicId
				topoext or TopoExt?

> +0x80000001,    0,  ECX,     23, perfctrextcore, Indicates support for Core::X86::Msr::PERF_CTL0 - 5 and Core::X86::Msr::PERF_CTR
> +0x80000001,    0,  ECX,     24, perfctrextdf, Indicates support for Core::X86::Msr::DF_PERF_CTL and Core::X86::Msr::DF_PERF_CTR
> +0x80000001,    0,  ECX,     26, databreakpointextension, Indicates data breakpoint support for Core::X86::Msr::DR0_ADDR_MASK, Core::X86::Msr::DR1_ADDR_MASK, Core::X86::Msr::DR2_ADDR_MASK and Core::X86::Msr::DR3_ADDR_MASK
> +0x80000001,    0,  ECX,     27, perftsc, Performance time-stamp counter supported
> +0x80000001,    0,  ECX,     28, perfctrextllc, Indicates support for L3 performance counter extensions
> +0x80000001,    0,  ECX,     29, mwaitextended, MWAITX and MONITORX capability is supported

				mwaitext?
				
> +0x80000001,    0,  ECX,     30, admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
> +
> +0x80000001,    0,  EDX,      0, fpu, x87 floating point unit on-chip
> +0x80000001,    0,  EDX,      1, vme, Virtual-mode enhancements
> +0x80000001,    0,  EDX,      2, de, Debugging extensions, IO breakpoints, CR4.DE
> +0x80000001,    0,  EDX,      3, pse, Page-size extensions (4 MB pages)
> +0x80000001,    0,  EDX,      4, tsc, Time stamp counter, RDTSC/RDTSCP instructions, CR4.TSD
> +0x80000001,    0,  EDX,      5, msr, Model-specific registers (MSRs), with RDMSR and WRMSR instructions
> +0x80000001,    0,  EDX,      6, pae, Physical-address extensions (PAE)
> +0x80000001,    0,  EDX,      7, mce, Machine Check Exception, CR4.MCE
> +0x80000001,    0,  EDX,      8, cmpxchg8b, CMPXCHG8B instruction
> +0x80000001,    0,  EDX,      9, apic, advanced programmable interrupt controller (APIC) exists and is enabled
>  0x80000001,    0,  EDX,     11, sysret, SYSCALL/SYSRET supported
> +0x80000001,    0,  EDX,     12, mtrr, Memory-type range registers
> +0x80000001,    0,  EDX,     13, pge, Page global extension, CR4.PGE
> +0x80000001,    0,  EDX,     14, mca, Machine check architecture, MCG_CAP
> +0x80000001,    0,  EDX,     15, cmov, Conditional move instructions, CMOV, FCOMI, FCMOV
> +0x80000001,    0,  EDX,     16, pat, Page attribute table
> +0x80000001,    0,  EDX,     17, pse36, Page-size extensions
>  0x80000001,    0,  EDX,     20, exec_dis, Execute Disable Bit available
> +0x80000001,    0,  EDX,     22, mmxext, AMD extensions to MMX instructions
> +0x80000001,    0,  EDX,     23, mmx, MMX instructions
> +0x80000001,    0,  EDX,     24, fxsr, FXSAVE and FXRSTOR instructions
> +0x80000001,    0,  EDX,     25, ffxsr, FXSAVE and FXRSTOR instruction optimizations
>  0x80000001,    0,  EDX,     26, 1gb_page, 1GB page supported
>  0x80000001,    0,  EDX,     27, rdtscp, RDTSCP and IA32_TSC_AUX are available
> -#0x80000001,    0,  EDX,     29, 64b, 64b Architecture supported
> +0x80000001,    0,  EDX,     29, lm, 64b Architecture supported
> +0x80000001,    0,  EDX,     30, threednowext, AMD extensions to 3DNow! instructions
> +0x80000001,    0,  EDX,     31, threednow, 3DNow! instructions
				3dnowext
				3dnow

I'm not good at naming :) and you may find better names.

Thanks,
Feng

>  
>  # Leaf 80000002H/80000003H/80000004H
>  # Processor Brand String
> -- 
> 2.34.1
> 
