Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03BD68E81C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBHGSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHGSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:18:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758C3C2AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675837116; x=1707373116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YVvunuJD2GSxYgeYfSrnx80HSLQ1Y7Q0tqGUuZ2ppDw=;
  b=CCa7Ti57Wa0n9ms59l2grZMHMm68UXTbjlDg+Kh7N0LeOSg2b5Kgk+Y9
   yAR9Xj0+CPibjN8eJ0yJKVF4FtxWJ7hSbZ4rJHIWkxX2psSoSBN33AsIu
   1HvvjWwnNmCJwedyCQ/xjwGMCMp//AT79kg5DSjJxABqtwLqdwNpcqYom
   Ljd4hG+RjdYCNH49bp/XPD+Egw9UtvJyRTWEye+IkztK8O/Vinf1PE54G
   w4nPoJSJ1NI/I6awnYO4PLFoc+lUaoYiAkamoTFY6QmZdKotzgc7rXzOL
   QTB5l8e1TPV9ALHxlILw6xua6PLUUmSm1cNxDC8hVVoT1AJvfDyz1dRDU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328377310"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="328377310"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 22:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755923152"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="755923152"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2023 22:18:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 22:18:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 22:18:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 22:18:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 22:18:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spg9/HbZUefFM0c5p6WRt/RZTohjp05mMSJppiQnvY+Gjw9vwF4HRoYoxkUVifycUNj8iBW3AkormoAZOffsmwuNUBtKpC9mtHOfFs813TyHnWb/5bnQPJzfsuKNNAorRH4DwyjFUOkaBPQ16X6G0i+EiM453r1nc+vblouxvikWHzWncgrql/1NmiDg9VKqobhK6WO0fbEvI2WmRIyCksrvnJV8KTW9qUr6OaZombgZVqV8YDt2Wf+Sm8yKuu7jD2vTFB0umVQS/T3BHV3K6YGoMHnvAaP1BRo4Q/XOPQCm+df9JA+yn5JWAsUymIO0qv7IDY0VmbiRtjbUiwpwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Du6zgIRoAAkoFj39o5X5px8aaHKT5c5/4i2vYy+L8=;
 b=K9yeeTpfCP2b3oGirZEft+kk9V910rfOW4ka0ncVMroxZpfQK4y+1WDuW7AB07pdWNbhZXYA6iYfmLSPB8SDbQaub1GY/RJFgdpXGTQKOc7x3YL5i8MjB8Malzctl8sfFVM15PS+S8GvA5jsKH5hxZxtvQ1bj50/u25J1+vyKXPgd3Di7SwX/8Y97hE4JRV7WFzZniZt5HonSgFH/2aZkr/XPIagWW44M0bD8IIhPuv6eghRwrxRfaM+dGJpgXCGo8HNIKa1AsT+pnfL/MF3X+eBWQq10+2ui+9K3+DnzedQEXtevYtb/GvT7n9nGSAt8anC9a4/g1srwVKsS4C5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6884.namprd11.prod.outlook.com (2603:10b6:510:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 06:18:32 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%8]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 06:18:31 +0000
Date:   Wed, 8 Feb 2023 14:13:51 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Terry Bowman <terry.bowman@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH 3/3] tools/x86/kcpuid: Dump the CPUID function in
 detailed view
Message-ID: <Y+M9n8MUd60Wc6S7@feng-clx>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-4-terry.bowman@amd.com>
 <Y+HIkTzNh4SXgVEc@feng-clx>
 <Y+J5jDfO4PMujuXD@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+J5jDfO4PMujuXD@zn.tnic>
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: a4803802-ded3-47ac-92ca-08db099c4ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO0amJU68fDYRFbgauosR8Sa63kVEiSR0dOCuu/fRJsWKydZiIC8Fv2VI99+7yRlCMyF/LnibTkvyosw+ongrixsstHB/ktKP8R7oOYQyHKEILsY4uMrDCqkHdlSE2Ds7Mk661S3NdPBJh3YMvC364KIXWuL87uXAhE5sSoipuwDM8aFoLCjqkWP2ZXQBQAXQnUUPElMWRTSfDZk6pgU1lyyEEdbx6Ggt5oeoakE6WuxSFZaldewuCsnV5zOWvIFouGWWFdyXULirk++Pyel5p/8UvZRgDu3jLgUI79SE8p1aYikaMz8TYIfU+sF8GkndDyzlY1obTya+XATope3/WMUFx2LTsQcCNW2Quodid+M07odwcS2/16j/AAtZlvGNMLzJzttvec5+errX1l3XqKLvVkQJp30XXCVDuYC3Y5ohnkdsOPinp7WKt7fCqC8M6USrGD2y0anQU0tpGoVRXj+qipN4HEEmToP2jhtQmBRHnQhPEQCoTdn1DznjLR94Y9jZq+ZWPWd13isucT7/1aWz7XTHHpL/O4dQ1+waebdqPDKZ/EJxJVypRW4KXQwk0NGLahD0+S/JD6tQS2EMmrDc6mllIK4Kw5xBBwegyGj2ZILkUtgyG2qrZW/+iTfTKNnGGy2v+gTmrYYcIGx9E3F6LofKaeemwwiWMF9xMh4LuoNYJsjaZW7WDKYnBTX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(44832011)(6506007)(8676002)(186003)(9686003)(316002)(6512007)(86362001)(38100700002)(82960400001)(6666004)(6486002)(26005)(478600001)(41300700001)(8936002)(5660300002)(4326008)(33716001)(66946007)(66476007)(6916009)(66556008)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twcMh5zlXM38pDlvKFJ7CkgazKVxBRhBTYsxFCrttx0ySCrG8UZdH4W2uFta?=
 =?us-ascii?Q?xwZDTVv6I6y3/c2odYm0yvcrMkcgZjllLin6zAI97qrShqjJkGK+1TAb01uC?=
 =?us-ascii?Q?hqYvn/lOLcKjRdoBVNGf7jqqB7K1TSbWYm06/QmroqoN4ABBlzG2py+1LUXJ?=
 =?us-ascii?Q?XDVq15jZUL8ov176pctTLihbxlqTuqrabekw/+OktWfjTr2BtCaNz3gL/kAq?=
 =?us-ascii?Q?6u+Z/4hXUDm0gkf/d1wgtXZhZ9pMEUDK4jEEL3MK76zQ97F+GStSJgNwOpLj?=
 =?us-ascii?Q?JdPES43BCQYgz6K6IFsKdK6QFe9yBt+aTGwErArPnzYOuvimnWe6mTNXbqdN?=
 =?us-ascii?Q?kLR8fc4IM2LsPMwGtuwpTL+MY4vAfe5m6lSWQrd1+ZI8fgMo0hugvh9XDK7y?=
 =?us-ascii?Q?55c7iMmxdlKiecnO+z8IoUzc/GPbsPsXifizi9UP79U4UdX55rtgKZ6yPEZe?=
 =?us-ascii?Q?Fjz8ytNjj27iY+0dl+PTRWO+kp2WKG/CmZm0BmfKxfBWdhXK34T0Tkt6oay/?=
 =?us-ascii?Q?asXXW8Cylj+GWj/ogKhvFPV9nvCxCH4sqQwTsFxZzTv5ZIKDyIAKDYED57ub?=
 =?us-ascii?Q?QROQC0h+f5+WqPEIxmlkiu7Fs6LJQ35Lq+46NsMt5lVGorhSmPJTMYjjg7FJ?=
 =?us-ascii?Q?YgDYBHdPLtiEKiyYNh5tQiHrPBy2NberGs4mvVLA46zjNAv7Syv5YKb59WLA?=
 =?us-ascii?Q?gzh8w9A450cQOqFOBPMKfueaxFeyHP4m6EISX+1EmZs0mIXIayrjhDnkRnFZ?=
 =?us-ascii?Q?851qjIqV2WERRgxX+rKwhgDhwr/thdM/2GXg20BSaT32psoW4prHb6QDGwOA?=
 =?us-ascii?Q?IFiVSIrF33GI5o1hSQwTiG8YV2BKHL3ChWUlwbGcDAc6DjnHNQpSyMLzO41X?=
 =?us-ascii?Q?hA2V3zF4c6k8+ZymM5wxqZYcttPAcIVBtHB2TkI/bYcsLt5PTc4ZYfvTSGJ6?=
 =?us-ascii?Q?gjdiDsyQF9mRnpnwr8R8k33m5L45272dYaJTB3kodk3pxy7Q0YA02SwXtZUD?=
 =?us-ascii?Q?JcjwamYp+25v4rxMX7bmgxLDd/UaBr4fRlojdpfKx2N778/+TYgOrwWIXaaa?=
 =?us-ascii?Q?w24s4FkjrEJqEnL21YDvSTVtWwpcFUA+sxQjFQ4DBe4gdxK2RRyT33deVs/2?=
 =?us-ascii?Q?XmOHtT08IJo1fOwgmGdfBh+owwOUx1fNuESCL3d6t4rAUstSler6QGOHovg+?=
 =?us-ascii?Q?HOXtQz1e6LTKWDDjayIFggTUNMlMHYMv9c8rqapsBTTGRfxwub86jImh+Wnq?=
 =?us-ascii?Q?S9rB0xBl5rx0XPGSICcF0V5UjbLYu3vWxE2I0AXuvkgKDA5FnNihobR7gL/R?=
 =?us-ascii?Q?+86TpBPWVwobWT6jiiD+dahy/iyILr8c9OHRzuLm3HdTLQNXGpLMr3A7yRFQ?=
 =?us-ascii?Q?NWDclVkOB9Tds89BoGlSU/QvoNNCkOlo/qpkVSsDYQdhoUFZ2hK+ni82/cqH?=
 =?us-ascii?Q?FAHyH2nT9sj7gUPfFmF78yNwevap92xdMyvb0eyLW0ZtablqQvDwySrWnj5J?=
 =?us-ascii?Q?hZJJXU1WDPWjykWd/bQOAywMqL8mqX8FtonD8fW9F5z5cWbvkwyx5F9kBgj1?=
 =?us-ascii?Q?Xd6vW/EDrKfKnKmiZU9936kh1XiHspj6Lc51z+j8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4803802-ded3-47ac-92ca-08db099c4ce6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 06:18:31.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWBpwQZztgwQE62CCDJbwNOirAFM4KcH5uoSf1vOO9eSujMK0OsBlcT2j6fcIpL/KCUhAaY5UhLIq5Iz6WOGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:17:33PM +0100, Borislav Petkov wrote:
> On Tue, Feb 07, 2023 at 11:42:09AM +0800, Feng Tang wrote:
> > Maybe we can check the sum of subleaf->info.nr[EAX/EBX/ECX/EDX],
> > and only print it out when it is not zero.
> 
> Considering how this is only a --detail output and I kinda find the
> default output a bit too terse, yeah, I think we should dump all the
> values with -d. Something like the below diff ontop.
> 
> I've added the output at the end and I think it makes perfect sense to
> dump those raw values with -d. In time, we will start decoding them too
> so that we can have a full, human readable dump of the CPUID leafs and
> all the data needed.
> 
> ---
> 
> diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
> index 59ee3b53309a..baadf2cdd1c6 100644
> --- a/tools/arch/x86/kcpuid/cpuid.csv
> +++ b/tools/arch/x86/kcpuid/cpuid.csv
> @@ -375,7 +375,7 @@
>  0x80000001,    0,  ECX,     27, perftsc, Performance time-stamp counter supported
>  0x80000001,    0,  ECX,     28, perfctrextllc, Indicates support for L3 performance counter extensions
>  0x80000001,    0,  ECX,     29, mwaitextended, MWAITX and MONITORX capability is supported
> -0x80000001,    0,  ECX,     30. admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
> +0x80000001,    0,  ECX,     30, admskextn, Indicates support for address mask extension (to 32 bits and to all 4 DRs) for instruction breakpoints
>  
>  0x80000001,    0,  EDX,      0, fpu, x87 floating point unit on-chip
>  0x80000001,    0,  EDX,      1, vme, Virtual-mode enhancements
> diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> index 26fa5255c42b..1b1fa13a9921 100644
> --- a/tools/arch/x86/kcpuid/kcpuid.c
> +++ b/tools/arch/x86/kcpuid/kcpuid.c
> @@ -33,7 +33,7 @@ struct reg_desc {
>  	struct bits_desc descs[32];
>  };
>  
> -enum {
> +enum cpuid_reg {
>  	R_EAX = 0,
>  	R_EBX,
>  	R_ECX,
> @@ -41,6 +41,10 @@ enum {
>  	NR_REGS
>  };
>  
> +static const char * const reg_names[] = {
> +	"EAX", "EBX", "ECX", "EDX",
> +};
> +
>  struct subleaf {
>  	u32 index;
>  	u32 sub;
> @@ -445,12 +449,18 @@ static void parse_text(void)
>  
>  
>  /* Decode every eax/ebx/ecx/edx */
> -static void decode_bits(u32 value, struct reg_desc *rdesc)
> +static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
>  {
>  	struct bits_desc *bdesc;
>  	int start, end, i;
>  	u32 mask;
>  
> +	if (!rdesc->nr) {
> +		if (show_details)
> +			printf("\t %s: 0x%08x\n", reg_names[reg], value);
> +		return;
> +	}
> +
>  	for (i = 0; i < rdesc->nr; i++) {
>  		bdesc = &rdesc->descs[i];
>  
> @@ -493,10 +503,10 @@ static void show_leaf(struct subleaf *leaf)
>  				leaf->index, leaf->sub);
>  	}
>  
> -	decode_bits(leaf->eax, &leaf->info[R_EAX]);
> -	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
> -	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
> -	decode_bits(leaf->edx, &leaf->info[R_EDX]);
> +	decode_bits(leaf->eax, &leaf->info[R_EAX], R_EAX);
> +	decode_bits(leaf->ebx, &leaf->info[R_EBX], R_EBX);
> +	decode_bits(leaf->ecx, &leaf->info[R_ECX], R_ECX);
> +	decode_bits(leaf->edx, &leaf->info[R_EDX], R_EDX);
>  
>  	if (!show_raw && show_details)
>  		printf("\n");

I also gave it a run, and all looks great to me, thanks!

Reviewed-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng
