Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC44C665068
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjAKAeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjAKAeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:34:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936055370C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673397264; x=1704933264;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=E9+Nmdi0FzfxG8quA6ss1QaSkLXZmDd3Xs3L3NlheL0=;
  b=JD/UuqBmZ7sTIHbTtu80014aFyDfnAsCM7HmHpH2rGnGiA7X/loBGOwj
   jIUvlP1kxVFBX7utHFsSzVF4OgILBkXKDhrmnVFpgZvY0mBIi8AmFfuX6
   S79qFlVYqZaFpB8YzgbaEFCkcsAegMhwXT228RcRsPHBjfZ69VR4Y3STI
   bkjEe4otLf+6PSjckM2xrVxtYAfvcOsAtLKhNlZY+Rril9/RIbqgofesp
   65uVJmZJKMig1CBnoygKE9SoDTNYeBY7UWTxujTZlyM6J9NFAR/Dz5xLT
   hUkosnAX0UtBu0GAmmhhqnGeFSVE9bfHdAbMg1Fa2QimPK1mTeD2SVUAA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323355942"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="323355942"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 16:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650544511"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="650544511"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2023 16:34:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 16:34:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 16:34:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 16:34:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 16:34:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2mI4DM7fWxUlq8BEXt2oQJRmUaqn+KW/2w8adMNWH8Ns4FZ6NzUrjK8svmFG7RPIscD5MVYbZi7jL9mU4SlbEOWHK2ZkGx00uX6MHGtm9W7qRgvRG+WRpyxGN1RS78vDcih8s6+kUBJWHNoJt7UdfP9HFVrlo2wOA8HsGdxBiuob+EWrg8LGO1vbtI5sIM88FgD9u7SsiGqe3giqR2vXIM+bJOPOs5sPTBFA33aNXSecllOPHK9JqAew8SI98eenqegX9vjwfg0KV7+U6CEaG0aaJTzHMWlU+aIVByPCmNdC4W/j7TB4YTdRefCX8VLmbiFSxwILSXN6Pfpo2PGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGspS5VTn5AaydFPLIQtMWQSfap0VbqUHIWQKfUFKhw=;
 b=og5fpnVxlz+2F5ZNHd0/091iKQvNfKIJ+JD8Ok1O5bmE8wlvZAYwroULEqHsa4O3kCHL7IOeYRoJugMJz76Cmmv6DgaHISU8dQBlp5DRKqV38Iw1t891n0h1UL5Yx/qj2UHnybfLBe4ZWac7KUWrTYTfycKCscIVdv1v9I0n+gHsygNpHqWV2ATGhvlCk05MpeThHM+sAB0j5xJoZCw2pXMt88bQPId8Te1l6eEZLbzgrId+gXS4o6dLpyF34LARvT/DwLpNHPanjYsAlZXB/CC36ikfEeXAV/qkzG3D+SP80tkGh3fG2lkSyG33OHqu5lehhRYjGW9To554ORQ1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 11 Jan
 2023 00:34:20 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 00:34:20 +0000
Message-ID: <c2012105-0af6-6720-5a24-719dec775fed@intel.com>
Date:   Tue, 10 Jan 2023 16:34:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/7] x86/vsyscall: Setup vsyscall to compromise LASS
 protection
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-5-yian.chen@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230110055204.3227669-5-yian.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d59a71-74dd-420f-4bf8-08daf36b9447
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JC3ne71ugiAA7yY1xZyhZG/e52QQz10lQlNwntMgYXXSa+mCOYZP0crLsGhMXR+7NVudsmTYr7Sht5gDpt2KgdF1BXhUWdIkhk1QqZSCUtnjNq3HK/TbsVbGRVqbyzu1N94/h2w5iWiIf8QvfSb1xFn2SsEs6silgAk+1pFAh3t/IJIdrD1DgPSpe95pqgIEeDphgHxC/hqdhEmuFk+OJyfLPTUUo9FVY3vGUy0rHgIGKs7qQ7fwQWvOIvFYg4lobbk6Jrkx8c8Doh1Px1k7S+X/aTS3mog38BZIbjE6hiwLWi6ehQ1zbozRL201rE1JuBGDGuVGnrtvB+RlTq9etAFeNs5Sfvpz5csLaDZGKgxW6zVgrVo7FIL62PNabblDUyUJ5QHYe+eJPV1zuAjldHWeU+Dolt/rEL3j1pl9RyN0ULyLvVuSPc2JhwQYLUJOaiwK+LcRDDOyA78UduGhy3tF9YIVN3ejw+875Hto5US9gFEZB+U3ry9frvXNmAUqpx7qx93FUjIA3wVBN6veLDu8Bs/myxCSOPWKNJlRKsVdq4/Wnv9DJWSzvbr7f9YZ66l42yBlBsW5S5Q2Y00GkRSmALindIq+RPz5xR6X4jLX5R3rfN70G4bjlpW4M6OisnuJZdRqHRGtOTPiHVAXJEOJF8biFVlBeDRFoy4xXds7RaIgB3gkMpEfg8sFaLG+R0WOI/3lo97PiZuY6/LV1hzfvLf2xO/cY9nv17wZkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(110136005)(6506007)(31686004)(36756003)(86362001)(41300700001)(6636002)(66946007)(31696002)(8676002)(38100700002)(66556008)(66476007)(82960400001)(6486002)(478600001)(26005)(53546011)(8936002)(5660300002)(6512007)(83380400001)(2906002)(186003)(2616005)(44832011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtmQ3RSZXZveXhCTzhPcHhXOWUwaTNkYllYZVNnWWtVSE81Yzh0TDliaERU?=
 =?utf-8?B?RGNsL01CbDdFOUpZMmtyN044WVhXTkg4Nk9iVXlpcFl6SUFoZEhaUCtwOEV2?=
 =?utf-8?B?S1dFMGJhd2VGOGFYdm4yaTJCTWp1YmVycGZnOXBIS0x0MzV4ZDFYSmpPZFpG?=
 =?utf-8?B?NmlQSmZZZEZLNGR1cDk3VGh0ZHJmejNtNnc5MkhXWDVGeWVpNE5XRjh2UlhI?=
 =?utf-8?B?WjhmMkhjMU8wazEyelBRM1l5WXZrNjZSK3gzaU4xWG9LdnVDVEtKOWV0d0Zn?=
 =?utf-8?B?dzNvcTgwcnJiaXlPZzZJM3RGaWtsNE1uQXp4aEFidjc0QXVZU0Q2eUVRSW1X?=
 =?utf-8?B?SGdvc3ZrcWRtVGo2MUl4TlhRUlZqSFVrcHp4VDZTWGFjbm1ka2d2MDNXV0tL?=
 =?utf-8?B?eGdLZGw1OUhGZnJNOFo2U1ZrQzRSbC94MkdwZ3hSS1lqWkMrQ1BzeERHR1dx?=
 =?utf-8?B?Z1haWGVya3NFcWVCVE9sdnVkODFFbStvb2dHM2ZBUTBuZlNsNjBxZjZldU1X?=
 =?utf-8?B?V3NUK3VJNjB5RDUycjFmZGNNbHhQWFBFMWNUSXlDRmZuVnA4QmxPdjllMmFr?=
 =?utf-8?B?RWw0aHZaSUljdFlQZFBZejNaOE9LSFl1R2Znc3BSN0RLdjdBalAwbTRmbnBN?=
 =?utf-8?B?a1VBOHF5WEErN3AwM0J5VnlqOCtZWE5yWUZwTUYvMFFvejZVd0ZlN3UwUENh?=
 =?utf-8?B?TW1CM1lSQlhUQkhQMjQ3WWw4STZicnV1WldMSHd3Y21XeEpFQnlKVWl6U2RL?=
 =?utf-8?B?Sk5WQ3VlOFl0TlY5RURBMHFBK3l4blNHMHVtRDBlSFQvdGs4TjhHdFBGZ0xh?=
 =?utf-8?B?V2Vmb3dEOXZmSG5lS2lrWjJjYktTZkxhMkI0WVhMaWJzdGl2MXg5eFQvd1dq?=
 =?utf-8?B?TDRXN2grdDN0eUpLMFNvOVlPMUNDa0xJemt2WDBhY1dPb0NONm9ZSkJmbUha?=
 =?utf-8?B?U1BOK1VjbXkxUTAvV2NOanh6anRNRXVFQlJnK0gxek05SkNFRWx6RzNDaDd3?=
 =?utf-8?B?VUFueGtJMm1sUnFHUlEzaUh1VDJkYnkvbEI4WjJxemdWWnlxR3BpTEZmTE1M?=
 =?utf-8?B?YU1oc1VTUGxKMTJibjlDcERBUzVYZ0YzaGVSSGdVYXFJRTVTV0w1cTVITnlL?=
 =?utf-8?B?VzdSbDZOc3pMUnpuL2xxbkd5UmszYi82UGI1RzhQWDIza1hSRlo0ai9DdWZD?=
 =?utf-8?B?ZC9TSVI3UWZDZm0za3UzZ0Ntd09iNmlyUmI4VTg1NC9EN2FBc2t0VXpwemJH?=
 =?utf-8?B?VTNVclVmbTQ4UThtVm5GSDZwVXlZcytSZk02dE1pM1lnSExab1d1Z3Q3SjRm?=
 =?utf-8?B?VVJwUFJ0WFBIZFA4VnluYldyVTcwcnpseURmSjlvTTgza3drWDUxZXVqbzJo?=
 =?utf-8?B?NjJ0dDJSempac1k3b3NsMXp2T2JCV0RpN2JuMTA1VEI1SENhRzdxZmtOQVhw?=
 =?utf-8?B?SGlFZXZ4SkE0WUhGWjdkU243N1M3VEZWYnIzRW05eTR1cXBmTTNFdXpjalZL?=
 =?utf-8?B?ZVpmR0I1Z012eDRCZk8zcXhtcUdvZURVN0Z1YmY2dzA4aGRXcTFQR2tVMjdn?=
 =?utf-8?B?VGxkVm10Mk1ZMXoxcGpvRkdKeWdPK0RRNWQwcTl1bFRVUEJacFNFVnpMMjkv?=
 =?utf-8?B?QUhDT0kxbEgzeTNWYnpVdFYrYXg4cGxLcXY2bWl4c2UvYXdsajg0ZGMrL1cr?=
 =?utf-8?B?SXF2eEl3NlVZemtrK1ZLM05QZkMvbWFNVlBuNUI2NmJ1ZCtPV05yS2tOdXpm?=
 =?utf-8?B?eWhhV2tTVmx1QzVuVThwTDgrTmg5TGhML255YmZXWTVUQnByaHhBVzN5UXhR?=
 =?utf-8?B?SnNDRUFKUjZ2VU1yRWQ4Nkp2cmhZcDdDOUR5WWZHckgxb09LblF6WlNLcHps?=
 =?utf-8?B?Q1NvQ3R2dTBKOXVzVEo5NGszcGpnOFIvZ2kzeHExK2lUTVFHNXJxaFdacnNT?=
 =?utf-8?B?Z3JuUnJOV3lxa1M3Y2xDNHZjTm9jM2dOQ0tRQithcFhCOHdXTmhva3o3VXRU?=
 =?utf-8?B?V0w4K1g3THFMYzQ2MTdHNHVadmdZUnJ3QXVWTEI1N1d1S2N3YXFNK1RJSENx?=
 =?utf-8?B?RC9YMXFHYktuQlVhQ0piZHMzeWFvNXJnWUY2WVFsWXlXMmJ1RTh6UWhnTklX?=
 =?utf-8?Q?OorvurM08T2qUXkWvC0MFL/IZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d59a71-74dd-420f-4bf8-08daf36b9447
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 00:34:20.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phXHPKyfe1+bT61egFC9joFH7MNCxO8Bo+hbMLhEJ7sU5xijkdPH9hbGerCxlVxojkGplESJ+lI0k2QOeIpCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2023 9:52 PM, Yian Chen wrote:

> The user can also opt-out LASS in config file to build kernel
> binary.

This line is unnecessary.

> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++----
>   arch/x86/entry/vsyscall/vsyscall_64.c           | 14 ++++++++++++++
>   2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..3988e0c8c175 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6755,10 +6755,14 @@
>   			versions of glibc use these calls.  Because these
>   			functions are at fixed addresses, they make nice
>   			targets for exploits that can control RIP.
> -
> -			emulate     [default] Vsyscalls turn into traps and are
> -			            emulated reasonably safely.  The vsyscall
> -				    page is readable.

The existing documentation here is incorrect. The default vsyscall mode 
is actually xonly. This has been so since:
commit 625b7b7f79c6 (x86/vsyscall: Change the default vsyscall mode to 
xonly)

> +			In newer versions of Intel platforms that come with

Words such as "newer" in the kernel start losing meaning very quickly. 
Also, this comment looks out of place in between the vsyscall sub-options.

> +			LASS(Linear Address Space separation) protection,
> +			vsyscall is disabled by default. Enabling vsyscall
> +			via the parameter overrides LASS protection.
> +


IIUC, you are making the default mode somewhat dynamic.

vsyscall = xonly (if LASS is not enabled)
vsyscall = none (if LASS is enabled)

The decision to disable vsyscall doesn't happen at compile time but it 
is taken at runtime when the LASS feature is detected. This would make 
the system behavior highly platform dependent.

Instead of doing this dance, can we provide a simplified behavior to the 
user/admin and move the decision making to compile time?

Option 1: A bigger hammer
Set the default vsyscall option as CONFIG_LEGACY_VSYSCALL_NONE. 
CONFIG_X86_LASS is set by default. Changing the compile time VSYSCALL 
option would disable LASS.

Option 2: A smaller hammer
CONFIG_X86_LASS is off by default. Vsyscall default stays as 
CONFIG_LEGACY_VSYSCALL_XONLY. Selecting LASS automatically chooses 
CONFIG_LEGACY_VSYSCALL_NONE. In this case, even if the hardware doesn't 
support LASS, vsyscall would still remain disabled.

In both of these cases, any command line input to override the vsyscall 
behavior can disable LASS as well.


> +			emulate     [default if not LASS capable] Vsyscalls
> +				    turn into traps and are emulated reasonably
> +				    safely.  The vsyscall page is readable.
>   
>   			xonly       Vsyscalls turn into traps and are
>   			            emulated reasonably safely.  The vsyscall
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 4af81df133ee..2691f26835d1 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -63,6 +63,12 @@ static int __init vsyscall_setup(char *str)
>   		else
>   			return -EINVAL;
>   
> +		if (cpu_feature_enabled(X86_FEATURE_LASS) &&
> +		    vsyscall_mode != NONE) {
> +			setup_clear_cpu_cap(X86_FEATURE_LASS);
> +			pr_warn("LASS disabled by command line enabling vsyscall\n");

A warning seems too drastic here. A pr_info() should probably suffice.

> +		}
> +
>   		return 0;
>   	}
>   
> @@ -379,6 +385,14 @@ void __init map_vsyscall(void)
>   	extern char __vsyscall_page;
>   	unsigned long physaddr_vsyscall = __pa_symbol(&__vsyscall_page);
>   
> +	/*
> +	 * When LASS is on, vsyscall triggers a #GP fault,
> +	 * so that force vsyscall_mode to NONE.
> +	 */

This comment doesn't make much sense nor does it provide the full 
picture. Some of the reasoning from the cover letter/commit log can be 
duplicated here.

> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		vsyscall_mode = NONE;
> +		return;
> +	}
>   	/*
>   	 * For full emulation, the page needs to exist for real.  In
>   	 * execute-only mode, there is no PTE at all backing the vsyscall

