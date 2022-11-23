Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70235634B70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiKWAF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWAFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:05:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EFACB6A5;
        Tue, 22 Nov 2022 16:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669161923; x=1700697923;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XO94CfXrDHodFpoS4maEUqwCpgUqBKTzcBdR9X/t6Pc=;
  b=mNoZ4LgWQbFD9XHpaRXGab/arjDg6YFLAdeRbmFSDwtTHIdc10dbdvBA
   nRX0gizdH5337n4aM1ucDAsOItH8rGHF1rR+XWHOhRDnqjuS11CwWrV6Q
   WMFvTXBK5FUgqG88nBccb8oh9HXM0hpKrTVaLlzzreNMgdH/gNoLFm5E4
   BUtkUDMcCFg/bhAIKKVv0P4JXfzIO9ITVOSgO0aOq0L+Lo/ceL3hY1OUv
   loCpbSIoGkIDIO1gy0wpO4RmE8/JQ7Ru3EneQX6sc314dQZ+US5OiHNZo
   8T+avyhkB2bOGlUPhsuUkz8lgd5twB1DqdwPvV9sYRGyDplEMxmZgGqrf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400234520"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="400234520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="710383610"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="710383610"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2022 16:05:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 22 Nov 2022 16:05:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:05:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:05:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:05:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0C94Poqj+Z3GPveK38OYA1rFAffJqI0QU3tLy73b72SBXHBtaqEwwMKuQsm34/Sj5Xbg4yxoxICBWW4VRl0lanLLIQz2gfzp8FnzogSahqNZmj5F+ZJcjhPCAqz/HUzM8PQZfPyVDh8IcOofJBl8Gfi2qLgiXbAmaf4YfiFpzddkdb3v+Rul44SJmXmwbtG6kpVlyBcN705Sheq9nUAIzspJ5689TPfpZaeR421agfcGOQIOXfquV1cYZ5VayKf6Bs8zN8VApjQs5btQxRkrsVjSUXlqz6Us49E6zbfcKcPoFlwv5GRgAXqksuLWYFt4yQlSiaYtdxMHc73hOEU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVe88MMJvdbuBtD2DSRZpqW+gGmeGcUq0RpVYjHpMzY=;
 b=TeLwovmxILedmTdoObdquFU+jiSo5+fTdtack7XnNeckTMdIFo/8v4N9u473ymcPHWSeWaJzFYZILnHvFoUgxRKxgyymNe06S3V71bRaLU9eoINKRIhJsev4eAi6P5l9oNoidTuuoz2qePQuDHy0acoP83x33uOQjX8FWjB8pwwTdHVywRJvUFMK35QaqRFfDlVmxd5ti6w4GhRyA9CUHlwfYhD+ct2Twko/cbjZmLGpCaYND/fAQlEGZYyAt4qCHaV62wWFsZqQ1bh80y+ahN5EMccgVzM+bmBSiQaEzPCokfx6L3akV9fnnqhsdk513DbEnP8iY2h7cFUsCchXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:04:44 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:04:44 +0000
Message-ID: <9ecad0af-c801-1638-c658-6823e4ddf483@intel.com>
Date:   Tue, 22 Nov 2022 16:04:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 02/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759200326.3281208.5387897092180999498.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759200326.3281208.5387897092180999498.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: c3be4fbb-57f6-42c4-9b41-08dacce6528f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: te9D6AI56U2oNcb/j0fywZ3sUCP1aaE9wLQUbeJWmt4QRDtzjsYKuWXgHQFKsVTTLSkkZo2Kac6aGHENQz/6OxucAtgiHtWUTnt4lpuXIbWwlnF3YCwtZDC8TYFY+sBD4TTeQhuRBK5vSwNMlUa5p3tfsrYu/pHX8sBwP9m19LcRSsUuhrY8pNUhyocHubdcUuqc7q5HX5pw0iq5lZFOB7dc6ZcPklayY7u4Lxsx/CMpDdbpTK4P/hSkGPB662j24qpDgJkkeZ4hgnV8+pccY4oYX3JMSZSIHWaEipgDjTz/n7QMeVczrhKk/TpTyxfO3NkzqM7Y6wNnIQbBPTNODdERtKJjl+/hWRylrmh4fmkZCZB+AFN4842kW/UPU5rqyn2na0OTvWh++EJK7Crc2EGGpj3qxYdg9u4iBGPQiaTECF3yNmlVJmOXLazUL9k9ns7wVKcrIs4DTn7PyknDTe3E+Bqg4I+AVfr/yXYHKBl3oW1cWfncSB+7NyFf1MOHwY/5XziydnknrBUF834NQIQeut5fN5F3a6vledJdQ6NE6OUeDweji0x3gjdQh9RT78DBhr26DmDZdG6Ed1r0p57o4KGuJHWBxUVfy8FQJyBSa/aFMqtN4krpDioAJYOn4ZFgvqCyf3nCzUJ1T043cIFyfG6ykmw7oG+goyncQABbToMYwfWTY/Y873FP9t2S+hxWpxWvHFrjTb6xKqlHkleb1TQGZ9/Po965yqHgHA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(6486002)(6666004)(6506007)(6512007)(53546011)(26005)(186003)(36756003)(2906002)(478600001)(38100700002)(82960400001)(86362001)(31696002)(83380400001)(2616005)(8936002)(7416002)(41300700001)(31686004)(66556008)(66946007)(66476007)(44832011)(8676002)(4326008)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxVTjg5dktTVzg2bFc0cm1DWmlMaXRQRlNMMnZLZUFPN3E5WG1FOThjMXBM?=
 =?utf-8?B?S2hwSUtTZ0t2eFNyRWpta3RkZURaWm5OajY2Myt4NHBSRmZ1QmoyZ2h5YzA5?=
 =?utf-8?B?ZFR2dHlNNmRGdytDQWlaTTJwbTNRT1YrVUwxMTJlVXNVMjBhMExHK3A4ZURh?=
 =?utf-8?B?TzhxY1cwdFNTU3g0TnBkbDI0bUpVTllOTlBIcXhaRmVkTEJ0SkdiMlg2R0Fw?=
 =?utf-8?B?TlhpVm9abjF4YUs0Mk5qcU9vby9wQWp5SXRpZklnYTlTUHl5ZHdXdVY1NmZz?=
 =?utf-8?B?Q1E3SUNIa2NXdnNBQUpKZWJ0YXlTSWU3Wm9QeHN3eEx6Mm9Nb2lwc3ZUL0dD?=
 =?utf-8?B?aVZ3RVcxNlY4MnNkNjl6K2cwVEtOVnNXUlRGdllRbmNrUkJGRVdDdjMvQThX?=
 =?utf-8?B?SVhubXNhaENlajVKMlJ6R1RSSFJiNnF0TFhpdHJHYlhVRW84TXVOL3VsYnF0?=
 =?utf-8?B?SlBaWWtTaUE3U0VQZitDbWoxc1hYR2JWN2ZmOWY5K3NVeENDMk1QUnZhQWM2?=
 =?utf-8?B?SkV0L1dlMExBZGQ3aHcrTmswbmhORGRIemRyeS9ITThsanBjcm9KVFNRRjkv?=
 =?utf-8?B?RS9hRFBJWWk0ZnNuUnhPb0VqWjN1cDBIQUJUay9JNlg4OXhadkhwTElMSmpa?=
 =?utf-8?B?TjNVdTRQNGpUSURidnFaeit2UE5jdEYxeER2MDQ2N2dMUHBGeU8xR1dNT2Fs?=
 =?utf-8?B?TWNvMHl1bEV3ajBUdy9iVENNdVF2MXF5RzdoRDBsTjVXQlpMSGowY0kvUGQ2?=
 =?utf-8?B?Zjh0dTZ4RXVIdGhHdlpCMmk1YUpDZnZHVkRIQjdZVUo0ZGVOMWUxQ3ZrYUV4?=
 =?utf-8?B?RGRLVmNJdldkNFFlNElacVhWbkk2MjFVOHIyNVpuSWNHdjV6S0s2VCtXNllD?=
 =?utf-8?B?NzNTUDkyTzEybUo4MEljei9tTy9wOENaRVg1VjY2aVc1cmROUTA4ejdJMDcz?=
 =?utf-8?B?aUdIaGlmM0Y3SUd2dHlrRnV2YW1CWnFYNWU5NGc1QUxHU1lqb21zMTBRM3Er?=
 =?utf-8?B?R2RGYkkxMzFuVVA2UEROczRiM3hsV2k0dlJQZkc5b3ZsY1kvL01xNEdNaFlQ?=
 =?utf-8?B?RGdLNEpxYklOYURHb051bU1WK2l2QnZ4MXpQUUZyajJwSWh2b1dsWmpFdTR5?=
 =?utf-8?B?eWE2UGo3OUlOZTJyckhuUXJsYk5MRGNFMzZLR1JhU3oySnh6KzBUbWxHTm1W?=
 =?utf-8?B?cVRCS09nUTlGZG0vWnY2bXIweG1EbU9EWGtUdTh6c3AvVng4UWNpZGJkNnpm?=
 =?utf-8?B?b0tvUktiSENYdGNOQlRXWW9ENTdicDlYWStJc1Y2K0crWjcvUHNaNnlDTTFU?=
 =?utf-8?B?cC9qMkNDYzN1Zi9wQW1wVEtLMTNIV05UcXBHRVBkQkIxTjNvMW5aTmNzRGxZ?=
 =?utf-8?B?d1JXUUMvVnV5N3NyRGFIZmorQnlEdlVyTzV2N00zbGZkMGVDTHlDdmVQampq?=
 =?utf-8?B?Y0IvQjNCKzVrblo5Y1VHNkt2VlU3NjVDaFRuc05nRjhZT2p3QlRoV05EaWZx?=
 =?utf-8?B?WXU4K091bjY2SlhqUnZxYjJaUHBiNWNTNzVmZDg5ZVU1MGN0MnVQRXdnaUpS?=
 =?utf-8?B?dHp1YklUQXJvemxIbEE4Nm8wRVEyRytabk0wanltSjMyeDhKU01GQUxuWWpP?=
 =?utf-8?B?b3JhTzBzc3J4MVBLeThHSjZraDVsYnlWY01CRk5zV0xoQU5jeTljcmxjY3BL?=
 =?utf-8?B?RjBWRmZVZmp3SFpKbzE0bHpVRkU3RDR2N2VSMXBiMnlsb2paR1dlUUVrNUd6?=
 =?utf-8?B?Z2M3MDR5SUV1WXpEbDBVLzFkMWpRaUpTZVBnNkROUTNOS0pCNjdDcWtZUHpO?=
 =?utf-8?B?c0Qyd0RvbTNMbDh1RXZ1ZmswM2lDdlRQZXJUS0QxZGdySEpGR2p0QVh4dHMy?=
 =?utf-8?B?TnlrQnR1UkJoSEVvcllOcStwbUlramUzTDNBdW04aFQ0anQ2NXFxTHRIaDZj?=
 =?utf-8?B?aVI3Um1IVnMwWHJzdlBxb0FNaUdCL1RDT3ZyMWZzaE9CQkpjTWppOVN0d1d3?=
 =?utf-8?B?bVp2NEtBSk05dmVkQXZJWDdHN0lVOXVSMUZ3VkxkSTl5UklrRVgvMkp6L3Jk?=
 =?utf-8?B?TnI1NUtvSFBHTEk4RlkzT2FmdEpyNTNGeEE5RTN2OEZBOUd1eVI2R3MvUVE1?=
 =?utf-8?B?RTVaY2x2aERHL29uK0E0TnU3TEZZQXZEVktkVmE1S0dFMStTeUl1V3JuZThL?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3be4fbb-57f6-42c4-9b41-08dacce6528f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:04:44.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb22WvODuPwAwc2HgNHXaYsfGXcBhzn8dvZwyB+itti8Bs2OJur9VgK5Cy9qjYdQKSKprQgbHta2TR2wtizDh57rMXAA0fexl0NhOHhHHDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
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

Hi Babu,

On 11/4/2022 1:00 PM, Babu Moger wrote:
> Add a new resource type RDT_RESOURCE_SMBA to handle the QoS
> enforcement policies on the external slow memory.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 03cfbf0fe000..4b970e7192e8 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.fflags			= RFTYPE_RES_MB,
>  		},
>  	},
> +	[RDT_RESOURCE_SMBA] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_SMBA,
> +			.name			= "SMBA",
> +			.cache_level		= 3,
> +			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.parse_ctrlval		= parse_bw,
> +			.format_str		= "%d=%*u",
> +			.fflags			= RFTYPE_RES_MB,
> +		},
> +	},
>  };
>  

Looking ahead at patch #5, I think that the initialization of
msr_base and msr_update (in rdt_init_res_defs_amd()) can be moved
here also.

>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5f7128686cfd..43d9f6f5a931 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -419,6 +419,7 @@ enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
>  	RDT_RESOURCE_MBA,
> +	RDT_RESOURCE_SMBA,
>  
>  	/* Must be the last */
>  	RDT_NUM_RESOURCES,
> 
> 

Reinette
