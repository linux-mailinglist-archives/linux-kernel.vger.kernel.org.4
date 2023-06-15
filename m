Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D2C7322AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjFOWXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjFOWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:23:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258AD1FDD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867797; x=1718403797;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUGUvbQrODGHq+ropde1Q4JOIVa5rP96W4JAR8ok2oY=;
  b=e+Xz8Z09UDXa+KMWG6FJ5ULv9Pfupj0v2zRTSY6GIIeXQzEuUI1mQ0wk
   TuaitRdm8LGSK66dm5wvK5t9zIRUzpzUe3cjWJJTpYFBixbMGZmfEK0to
   0fSbzypYH/F5hiJOElxLQg4BIUhK5uJ+JJB0sbgFW92AEJ10owtjbxinU
   XiltoEc9gFGEsmhMmStgNJkaNBHpjNQmE2U004IVQBueZk5zg1X+n1dFr
   r6hCW1ASqsTaNCJTpF+KEuCBOmtI0Y0/5aSaQd8TzuF01SUNEP17f4Ny/
   XdcTOMY+6jxjxVcYFlKGxkXhCaX1jouEYbpQ2w98ZSBqYv6332XOs4y+p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356545606"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356545606"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:23:16 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745851686"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745851686"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 15:23:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:23:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:23:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:23:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvuo4a9j+IcN01RCLYnkQhFRhba5YlBUbxE/8XnCoWJKU3hYKr0LjMvukN9b/rFosXWkhfDWaR8L/mkX/naRG00TMnPKmcSSZ0Y+/OtZKNEFm/SKJmQr/yGchHQYXI0AAe8mjdi2hm65HXtCbsKodNFxqtuA86Ux7r3rTiHvNj339zV6rcx07yz9HfVJBju+I8r1eyDv/LmbdZd26Flo1/iD0VNkGnmu0ttLl0RLSdRhtJn4WRzZx2Pqw4HBgCC5tULxL+/8L2+FohSNtFTh4P9+bNkrEl/F7GBjLKLmDPjlBMNiakek9lxN1FlRIk+SfZAR9hrqKH8owAhdJa8WKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSQKg3oFOd5oSZVzCebh0CqYSkrY7lsiTHKqjud1CRw=;
 b=i9A4304txYvyjA7gnw+0Y+82sNYgj+s8O85h2569bPusTn6npftCdSyKvwuTpXpo+sqkBIfOG05GEIwfr+NsB4kQOzo4cxky9jFlsJy0aNBJ6A74ykSV64vQja+Y62HZVqeLvoXaFlTlMReBNcRPXb1p5pTamaI/0b/9LG2UXmviiBtcnZEroKesweEzipEz0ttt6mkPv5FhcPR0hgD0XXEUcgjeIiXerWJA4lCDXtUHg5dnezeg4xke9o33uIsz3iSIG8wKUZgOzuRu4yHV0C20N+6Fdf4TEDImTxRDusVIuq/kaMtUGmoioIjodsUg0P9qvSoT0dQ3U4TFxTQUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Thu, 15 Jun
 2023 22:23:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:23:12 +0000
Message-ID: <9994b40f-1640-0b5e-119e-0084b60c7262@intel.com>
Date:   Thu, 15 Jun 2023 15:23:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 16/24] x86/resctrl: Make resctrl_mounted checks
 explicit
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-17-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c76fe0-4246-4d32-6313-08db6def1b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si4URKCIK/K+2ec09Syp49CIk+j8xw9lFzG/3aN8Xh2LxzaHW/MXW2iuDk/l9m+XKmDn2g3xrz8LcY54998CO0GMTVZ0+mTPOt0I6OWwo2RCsMwz9RE14UJhqmx+zXPS1sYLm3CIhxrC5qyJBtygIfTxcchOztqeqTU+CJ+7zrNNzZYl4//pA/8anuPjvXpsqmYxpvp76PER12Tqu8MXM2iU+BsyTaFNp7I2wIMMvcQb1bqx2PeMtvNMM59pke4K5IB7zstGv8h4NRWFYbtUaXkmyhs6KXwKkNH2Uxa424VMEIhU/boKskHrBEE3TfpTTgL4AhIfboW/yKlPqeFSbdiDsoxS23jWP+GaHdxuDOMVp0SorXKGjzNfNPtPG8c2EJyNSoH2lVkuKPzDep1meRi9ka5zX+857WyTlgfDl/ZEqq9YHMZi67F/oVPftbU8uW4ZIs8X9xzDooH5FHOqeCXIaDGHjjWOnr1nOLWWEpcwlCP6GhBwPJkEa8qTgQ6LLb7nS7j4lGTfxPS3A8ZhE2idBGRIH8JSC2yRP5MTXjo4msf5r/q38ppKB3bggH5/pdSiORusL+kvGIGGsjrNI/HbZKgIhz6yBRaiwXhwiHzfFv+Ydu/exXsln66mtNX+Dm8MaKliAk2682zSJnNDRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(26005)(186003)(7416002)(6506007)(478600001)(53546011)(6512007)(44832011)(31696002)(86362001)(6486002)(4326008)(31686004)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(8676002)(5660300002)(82960400001)(38100700002)(2616005)(41300700001)(54906003)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk0wZDJ6bDc5cDhrZDRLSFkrVnB4RlM4N2g0S2syaUpTekoyVVd1MHdkbjJz?=
 =?utf-8?B?WkVFMzAwMEFrblJuUDFzRUtYMEkxaERhckJ4SmFtZ245Z0srMjZMZWZhMEdY?=
 =?utf-8?B?MFlOQmNlcllKaHF3czV1cWJKbFgwNGJrYTZSY2JFMkwxdk1WdjM3dFFIM0R3?=
 =?utf-8?B?aGdsUWNBSzNFK3lPUnFQa1hxZytKOEc3UGUrL3ZPQldjaVVYOTF5VHp4WXNP?=
 =?utf-8?B?UzkvMCtVTjFNL0M5U2FUbTB6V1hYZlNjaWwycGNDaUVzY1RXNzcwYkQ4YXRX?=
 =?utf-8?B?VkN6YjU4NkNGNnVjQVJmSnRKOUJTMG5oNHViTDdYMHUzQ3BQaGRnT2k1alM5?=
 =?utf-8?B?bmJudFhMendqY3FNS0Rhdkw1WGZFQlExMkdqZERpL1FXNC9VdlJRYXBUbXgx?=
 =?utf-8?B?SkN1cXQ0S3FyeThZR2N5VGRZcWlnZ2QvV1NRZHdOb3EraWdpenV6c2dkejdO?=
 =?utf-8?B?dUlZK2FJajVtaG9Kc25keWw3RDdRVllVdEc2aFhDY3NNNitRQlNLR0t1WldZ?=
 =?utf-8?B?MXpGRSsxRnUvZDg4UGRsUzRDcHJnYjk0U1VBRGdnTDNWTi9xSXJza2RBb1Nh?=
 =?utf-8?B?ZmRxdzdxWGF6NXc4R2htNHFoVlFhbWF4VHJzL2N0QW9PMDVNM2xhWGVJUlRY?=
 =?utf-8?B?Rk1ZeHVPTDlvWlJ5bUNtc1hCbGh1TkNjNFY2dGMvcGdqdC9rTTgyQ1A4Yml4?=
 =?utf-8?B?U1BTU2lWRUlYT3BORUtYTHNtMERwRnl2c2VQSGQ1dThreldUcHlPZEVvaVdl?=
 =?utf-8?B?d3JRWGN1NGZNK3U1Uk9oUFdIeHR1dzViWGVFSHVodGc1Q3M1U1BydG5lZmlt?=
 =?utf-8?B?cjJhUE5xWllGSVI0RlVlSDEzQURZbjltbHd2MDNNOUtWL1Q3enZqQkp1bHdG?=
 =?utf-8?B?WnFocVg3OWNQNEF3dWdld25XZ0syd0sxeHBCRGNTdUYxZElrR0lzNlpFWmFM?=
 =?utf-8?B?d2ZyWm1OLzd4TlFOQkhBQnlqZElIdmNVOVJlLzZnUlJtK1Vsb3czRml5UzUw?=
 =?utf-8?B?U3ByakRIclp3SFRqVXY1SUZFUWIxcFZIeVhuVWhqcjZWQUVzc2M0ZGpCbEZM?=
 =?utf-8?B?bDF4ayt2a1Y3amtlUjk3MDZES3BaQjhucVlQcjhra1V6a3FUQUdLTk9mdy9C?=
 =?utf-8?B?V1dHYWZtNjc4UkVEL1V5ZTFvRVJudVZaUVFaQmdJNEtPRjREK1A2ZFdHR2w1?=
 =?utf-8?B?ek85TW0zY0tvQ2xDaTZueWpEV2Nac3BVT0JWZHlmZytmY01nR2swSnpnSW1X?=
 =?utf-8?B?SnU1WWFlMXg3UkgxQ3pxcTdMSXluRXV1aHljb1p0R2lnWCtDYnhYNDgwdkRX?=
 =?utf-8?B?V2c3YlNiOXMwN0FTNnI4NEN0UVBJcG9QWUdpLzFUQXMxOTIySDJuNWNseXBw?=
 =?utf-8?B?MVhxREdFQnZ5UTFoU0l1TWY4OVZick9xSjhWWkJYUnVOTU9vV0REMDUzTXBn?=
 =?utf-8?B?Mk9pd3BBd0VqRXBuQ1ovMFRKdG1nR2htais1ZTViMVFjcDhQeWhkZFJCbmIr?=
 =?utf-8?B?Q09jclNuV1k5YVlxeHA1UmpoNjhzWlQ5R3diT1U4djBNRCt2WWQwZ2J0YWN5?=
 =?utf-8?B?UHViK2xOR09vLy9pTG9HTXZ2OHpiYkVzb3NuKy81SHVSR05HTWNUUGhiSlBK?=
 =?utf-8?B?M1FPZGlVdVFaRURrbUgxZzFSNExJcVEvZU9ncWZ6S1g1dzZnVWxoNXpKTHNn?=
 =?utf-8?B?UzlQcmhFSGk1aHAwY1V3VGMzSFBxNGhkYnc3ejR1WVV5QVcveXNqc2g0VnlH?=
 =?utf-8?B?blBoVkxVM1RYZC8rMjFHMVl1clR0NHZ6Qk5UUzY0c1NSRUplWVM2S3FxVndt?=
 =?utf-8?B?eUZWTmw5SzFWUnN6eW82eGE5ZGwrN3pieGE4L2pvRGgvU211ZXg3dkpmQVNX?=
 =?utf-8?B?N3JXcEtueGJJUUhWWHZXZm1RWmtLVFVrUlM4YnZqTlM4NGxGRWxXSTZwd0xW?=
 =?utf-8?B?d0RzS2RIc1loVmh6SUt1U0JWM2ViU0JjT1ZRRGVXUDBCS1Z3eUU3bXFiUjVh?=
 =?utf-8?B?V09zY1dhWE9sY3hOOE5WMXoxNXlSTGMwL20xZWVWaXBsT2QvQzI2ZDNxUmdn?=
 =?utf-8?B?QTZSY21OakJ6cXVYbE9PMzQ2ZEZOZ0szZzV5dGJIOEozVFNTeUZMMjlJaDBI?=
 =?utf-8?B?dGdzNUZEQkFpNkNncFJ0K1NjcGxtTlo4WGdRNWFPWVZuQW55eURhUHdRTnFp?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c76fe0-4246-4d32-6313-08db6def1b3e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:23:12.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydg1lO6qM9Uxvxdhn1U14pWbihajiyqIOgPpQLR3fM1pPnRn6r8X3sQ1dzb6YLU2cI8213yopv7RJIq7XHwR3/gd25rC9XJ8ZgYeyfQii5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:02 AM, James Morse wrote:

...

> @@ -3710,8 +3716,11 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	if (is_llc_occupancy_enabled())
>  		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>  
> -	/* If resctrl is mounted, add per domain monitor data directories. */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> +	/*
> +	 * If the filesystem is not mounted, creating directories is deferred
> +	 * until mount time by rdt_get_tree() calling mkdir_mondata_all().
> +	 */

I do not think that this new comment captures this work. This code is when a new
domain comes online and directories need to be created in all the existing
resource groups. This includes the default resource group as well as those created
after resctrl was mounted. The new comment states that this is "deferred until mount
time by rdt_get_tree() calling mkdir_mondata_all()" - but I do not think that is 
accurate since the reader is point to the directories created just for the default
resource group.
Perhaps something like:

	/*
	 * If the filesystem is not mounted then only the default resource group
	 * exists. Creation of its directories is deferred until mount time
	 * by rdt_get_tree() calling mkdir_mondata_all().
	 */

I do think that the comment explaining what the code does is helpful though.
Can you please also keep the comment about what is done in the case when resctrl
is indeed mounted?


> +	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>  
>  	return 0;


Reinette
