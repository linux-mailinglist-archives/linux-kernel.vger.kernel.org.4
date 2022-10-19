Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B866604C77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiJSP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiJSP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:56:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA36577
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666194862; x=1697730862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=izO7hz7YCk3YF+Kfs+TpuyZ0S8rbcH0qDYl+Q2tFQcw=;
  b=hDPbLz+gCkBiepYxPEUpiNFwta4kIJ2u/TXsopcCwH1pVizQGqBjN0Ej
   88dCxuTrD9Zh+U1dMjzh0VkKkwt/mN16Ilph0v9BacN9f5sfw5PoPZKIX
   DghUxgbkxGXEdm60SdcEHzP4nRnjbAuloOjBMYlE/vyWs8+vIXWat2kFq
   Gqcx4Fq/N6fnZwkhFyPZg1PCI/6FqsZQm4aqRINt9d0cPszWvmjsW6xiP
   LQZUtXufPL0XDo5O7A8Xae8sCEygklwrXMMLCRCkZGoxc3A9bvxxIjYlu
   SVDAbv4h3XgkYc/9fGoDvm0TZ3hENk5sjBk3chy8EkXTLkPKkNjxugXji
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370668208"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="370668208"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="804362553"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804362553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2022 08:51:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 08:51:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 08:51:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 08:51:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 08:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyT0EGdcUX5xfBUSVM/jhEvdpjGEJ1PUIuIege7FMCjteq9eoV6C9SpmYpoIq8sW4TnrMo5x96Wedj0iEpjUwUNciQLs8kkyA/2nQ3TCSFdB6NZ+1Ke/oj1x2+lrylTqV1qGzXdUZjakXLuck3i0CzPI8Yy6AsBBGBn0SkFfqTWMrP0msM/ePTL/kH5dfVSxV6sCY3RHBXE7oHnWrfQUtUxUUIqUu+8UElOBsEJlCA30QERc8tqMPm4wgAQWJjcEl3ndzW0OugJeC5h5t72ZgH1toNMtIFCM6mdA1Vl2OEP38j/6FwwyOw1XPvduNM6vWgpJ8lkp1QmTDIGSHC4Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8Pk9QJS4KmQ0YW/155701/Xr5ybyB11HoT1Hvz35js=;
 b=b1TZ4JG57kBtXXipxR8FZRAzmx6xrcAHXfT0tjyhInTyO2zwyU2Wocz8Zw+8SDbgXk71nuU51ualvtkxoVphyJ1I3oYt34R/Zo3k9MrXmuAu3QExUBEJDW8JuibL7pW2DxnJUOTCASEYM62msyeZ5YFySvp9zGGSS3Mqqic439CmvKidDexmpC2bsh0E7gzgsD4dIaPbW7ofkcN72eAzsDn0xBl3056u7d43KsS3NWo/Fqmhl3iUXF3nNh7LAqnNlN2VzbfP2g9eMGW4Hj6gfN+ST5DGBq/sbnRQ9D6jLr4hLX1rpURDnfhOt/JuEcf0v/uoed+dGPEFzb/pZHNlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 15:51:35 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 15:51:34 +0000
Date:   Wed, 19 Oct 2022 08:51:14 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH 13/13] x86/microcode/intel: Add ability to update
 microcode even if rev is unchanged
Message-ID: <Y1AciYej2eQ/nNQA@a4bf019067fa.jf.intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
 <20221014200913.14644-14-ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221014200913.14644-14-ashok.raj@intel.com>
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8425d6a8-69f1-4d59-7b85-08dab1e9cc95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3+GiA7ynf7LFQB/qvZNQSB2qYpzhhe5ixRuLayIqPTUDpEqAqYjzEPMas8O9lwaXO8ic4CXdRaOr3gzzjLNbhnAAheOiP2mIpr8RXXjeM3/mOq2Hn6gijQQdaHHLM7skS0XJ7RpuENxyaIx6bwIw7U+Xrv55wwKCyLISFZZHEyA5P2pJCN3ESskoHc9nwwZI5MSMJiIK5TklyH4ntzkCojiWXsPG6YGNzbz3FBThAykVpB09vN4tP3LoSPqFVLNkUDmOKnCQFdYV/KKCwQMapFP/URNJQWdQV39CgfF8+4uKZ9jIVgOXYtUXHCgY6m+IGvyGrDjHOKWZFk4fImeep8671G/6oNRnBW9ZU9bpQ7DFk4+oCigCS5aqdT/8W6vQNuvhHpK02MhxtR7b/RwF/fKWxBZrOANQUJPzkENRwbFDJ2cAjU57xnjxgbKz6fnSmOwhGAWYQaO/L87Nzyij1U7TC1YVUksyGYa6rk7GejQ/Z9gpAqKTgOcy8cGVsKJACYCg6AngQYTi4dbMdyleSc7NKXvxNCrFuyoaZcTNYfvX8kdAyPywXgXjCGH81gJYzaEKbcuYX1joaLRhk35Wv6C1E+Am6egH8BRtewpiA4pFScvUYwA/xzkn5XWYr3N/rWOsFfSsOY3yrSMNaMviS6BsfHJSMMdx6AbxskO5+atFAxSAbXfIKHhJiznkh+HYu+URyl7Xq33XAyqrA6Tqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(107886003)(41300700001)(6666004)(478600001)(6486002)(6506007)(8936002)(66946007)(66556008)(8676002)(110136005)(316002)(186003)(4326008)(38100700002)(86362001)(82960400001)(26005)(54906003)(44832011)(83380400001)(6512007)(66476007)(2906002)(15650500001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhLQMGqW2ynDeKXZGQf75z4wY0EbLhxesTNAVezvy8ppZSb2Y+Kaot1bYE6w?=
 =?us-ascii?Q?KRgmWgzXlZpfsDD6UCBNCMWofIyo1wv3PFOCiPY1jMnwy/TD5+HavQteVjcP?=
 =?us-ascii?Q?iovccpbeJR2RtMe01HYI8cENlkqLR0YNQWTYjzHojKIBoIYTp9KpUgzm7Y+2?=
 =?us-ascii?Q?RZCPglvFTflbC43rAYZNB4g+VKV2qjA2b8F5rBcV9pWsw1VrPt3sKMfM5KYq?=
 =?us-ascii?Q?qQFqSV/3GNYlUXm9KeP7x7NpTpPGhvlruwQU/epGfgoUdp7mu2y8DS1qjhSV?=
 =?us-ascii?Q?ZfCiK+gg4phyBjTq8mYPw9OmZ15pdbsKUXiaGNz2lKeiZGCQE/eRZEyciRMN?=
 =?us-ascii?Q?keWtunX2WYSa+cU8ipN5xGxH+4757HN1r6GFl9ByzVSulSm6/SRR838UGCGP?=
 =?us-ascii?Q?uwgTILFG7ZUfHOBNoUk+mp1gu4Bk2r0w3Nqvxgl2EBFU0QQT2sXdbx0UuGRB?=
 =?us-ascii?Q?RLftJPpDz6YNuQCOXZeRJg45XWZTaAPwjs03j11uk82FO4WN9Os/xxxmXi/j?=
 =?us-ascii?Q?B4qj6+8Bv/LfLzv1rSw4JDXTEvznzosqWvo6lFJmVN9L6+Wfnr4k+sieup32?=
 =?us-ascii?Q?OgxucZo4ySFMgsDe9j2Fux75hfnvMuHXOsYe/UYN1mjohZpGfLf8jltGoDgk?=
 =?us-ascii?Q?MCihzwTOCHEqCAjG2v2SenzbFl+m4LPlw80DzYZJVVf9VkN4qHfPputZDNlT?=
 =?us-ascii?Q?Q2w4/loe5lOzmzHYdlEziWqfsNlFR94I/kKzg6Qvc6l1XcrAxLXphG4hkWC7?=
 =?us-ascii?Q?WA40ZJdhStbMGx+80Fed0HRxFm53jX5LCkT6gVrfTHmUZiiz4s5msAFasb6F?=
 =?us-ascii?Q?5CmoVOI5LQ0WnaZZIZ/pApD04ax/V1rsLVGL/lrAlrNCURXzVpswsQXqpMj6?=
 =?us-ascii?Q?OV4GqLl5UFo94VIDA17S1f58mwiljiSn+jJ3wZzb0FEl2eehA/zNTWD7e7Zt?=
 =?us-ascii?Q?ZG3jk+TRcCB8W85Wzy7c8xAp62Nx6QQaa/z7mWvUPQI/fEV03Tp7tqceOkQE?=
 =?us-ascii?Q?5bqj0s+EpI1Xacy8m8zxROtd8G19zofBgyBpgKH9Ts3EOiiW1dcVtnf9eco+?=
 =?us-ascii?Q?znMAdXopRZm723Q3WqDdfe92yC6JAThmkMkhIXoXPC2/NNP8aJFsIsVwLmGh?=
 =?us-ascii?Q?Tl/nAr9rm1aGblkcjah5MuxJCUa0/3E2C4vMNOeIlDgous7VA4YoIAH/SmGX?=
 =?us-ascii?Q?4PRAoOprgq0jZXpnCeFjsdvaaZH8yhTXqnh0tBTJjR1sHxHyfa/grtg1Lo4a?=
 =?us-ascii?Q?4BB0POj7+VH7vYCMa+0owt9lXkLmNyuSrCJZpvUYIZHM95lCkjjteIsJqZGp?=
 =?us-ascii?Q?wmqFb8hS3YpTvu1+CqE0aNwoo0jNiL0G9IUsffSA5rVDsDhD0IlbxYP2Ry/G?=
 =?us-ascii?Q?q6GCu6VLrIXv7MhUuEayd6fFKy0Zyca9cKGjX3sQE82hv8iYovLkeg11znBC?=
 =?us-ascii?Q?84NK/KYxdVhzPK/EVIagaphcJ7LRZG3GLslzYWtZ7zcpPQVscH+pFUMOpoOu?=
 =?us-ascii?Q?e4Ifc36GWQljwSKarkstLnDa42Tgqz/FrdtQsUt3GuWdF+kUZxP05Kbs6+Fl?=
 =?us-ascii?Q?UVEt9YOXKcWnynyUYeCx8c5SwnPiOWKlXdxUfQOB7LzK1wrRmQ9xxCV6o2LS?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8425d6a8-69f1-4d59-7b85-08dab1e9cc95
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 15:51:34.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Km21Ukm3Ut08AKwXUZ9UPmlratGI3vhsN5+bQRtHhF8tBeRPxrOYvouF10Ck1XphDSCqdZBtaqPyVDEBeGPaQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

There is a minor bug in this force reload option I added for testing.

See below:

On Fri, Oct 14, 2022 at 01:09:13PM -0700, Ashok Raj wrote:

[snip]

> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index eb2caa74de01..632c7a1fcffb 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/miscdevice.h>
>  #include <linux/capability.h>
>  #include <linux/firmware.h>
> +#include <linux/debugfs.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> @@ -46,6 +47,7 @@
>  
>  static struct microcode_ops	*microcode_ops;
>  static bool dis_ucode_ldr = true;
> +bool ucode_load_same;
>  
>  bool initrd_gone;
>  
> @@ -542,11 +544,12 @@ static int __reload_late(void *info)
>  		goto wait_for_siblings;
>  	}
>  
> -	if (err >= UCODE_NFOUND) {
> -		if (err == UCODE_ERROR)
> +	if (ret || err >= UCODE_NFOUND) {
> +		if (err == UCODE_ERROR ||
> +		    (err == UCODE_NFOUND && !ucode_load_same)) {
>  			pr_warn("Error reloading microcode on CPU %d\n", cpu);
> -
> -		ret = -1;
> +			ret = -1;
> +		}
>  	}
>  
>  wait_for_siblings:
> @@ -636,9 +639,12 @@ static ssize_t reload_store(struct device *dev,
>  	}
>  
>  	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
> -	if (tmp_ret != UCODE_NEW)
> +	if (tmp_ret != UCODE_NEW && !ucode_load_same)
>  		goto put;
>  
> +	if (tmp_ret != UCODE_NEW)
> +		pr_info("Force loading ucode\n");
> +

The above needs additional check for UCODE_ERROR. If you are testing with
old microcode with minrev=0, noticed this went and tried to perform an
update without the UCODE_ERROR check. 

I've queued for the next update.


-       if (tmp_ret != UCODE_NEW)
+       if (tmp_ret == UCODE_ERROR ||
+           (tmp_ret != UCODE_NEW && !ucode_load_same))
                goto put;

+       if (tmp_ret != UCODE_NEW)
+               pr_info("Force loading ucode\n");
+

>  	mutex_lock(&microcode_mutex);
>  	ret = microcode_reload_late();
>  	mutex_unlock(&microcode_mutex);
> @@ -841,6 +847,7 @@ static const struct attribute_group cpu_root_microcode_group = {
>  static int __init microcode_init(void)
>  {
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	static struct dentry *dentry_ucode;
>  	int error;
>  
>  	if (dis_ucode_ldr)
> @@ -884,7 +891,12 @@ static int __init microcode_init(void)
>  	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
>  				  mc_cpu_online, mc_cpu_down_prep);
>  
> +	dentry_ucode = debugfs_create_dir("microcode", NULL);
> +	debugfs_create_bool("load_same", 0644, dentry_ucode, &ucode_load_same);
> +
>  	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
> +	pr_info("ucode_load_same is %s\n",
> +		ucode_load_same ? "enabled" : "disabled");
>  
>  	return 0;
>  
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index c61aa661ac2f..c9f1e6f5e53b 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -763,7 +763,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  	 * already.
>  	 */
>  	rev = intel_get_microcode_revision();
> -	if (rev >= mc->hdr.rev) {
> +	if (rev >= mc->hdr.rev && !ucode_load_same) {
>  		ret = UCODE_OK;
>  		goto out;
>  	}
> @@ -779,7 +779,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  		return UCODE_ERROR;
>  	}
>  
> -	if (bsp && rev != prev_rev) {
> +	if (bsp && (rev != prev_rev || ucode_load_same)) {
>  		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
>  			rev,
>  			mc->hdr.date & 0xffff,
> -- 
> 2.34.1
> 
