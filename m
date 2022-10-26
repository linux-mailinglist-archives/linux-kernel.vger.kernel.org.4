Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD460E8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiJZT0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiJZT0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:26:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091244C006;
        Wed, 26 Oct 2022 12:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwtNBvNw7afASUklGuvL7iigE5BsXi9HsyEitNXPrc/u4pxmsYTuri5CAw8snropbWKkdDGMYnU5mlCIDBrlqC+5dW8IokilwH9Vl6SDgjslvQirRUY6h7pRcS9K8QHBD8LXAmW4hAHWoRBzEvPQTnHkVnh7PmpQEuuJzGrhLrMoB2ZUTonz5btPyUEWuj+BxhEBFi1s+Ty07x8Ij+Ziz68yS2g2cjYEGt4oVqea7H9akDavB++k7w5W1HaaGD9tp5fezYl679sa8qv3nWzPLzOe4jOMYDPiw4RpMUFgmjoQ9t8f6PML1B06MEq/VUvNrL+Q8vIF+F/4mhs1p8A4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tg7R0ejhvwRH/Rw/iGt5IVJQmgoLF4zxOxMR+qanFQ=;
 b=BlH2DtAMGLF2FECIMK/EPB7z8QmK4D8xlxPZsRNxWt+nibYx6jumdznLOQ8rbPT+Gd+4uIiLfZGXGVvaK7+8KulvoyHAqsR9mzYB2Dn8KokZya+W8ND0xTFg9X7sBPWNaHSFHre3vFip4dkmKFZqkwvRU3wNQgaA4bZaTsx6sSfC2SfbDkMh7iAuevIECRNePMra3Gao5jxwXvKf6R3WeyfDipB6kkzk8jFMFaYu0rDSKVBI3rdp5bqGG0bOKdUSYAIrL5x3H8OSzhhyqy57No69v/PqELPG8mWI93eMOHO6Fq9WWFhH20DesP9b6P9eT8TvW30QX4DAOOf40bxtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tg7R0ejhvwRH/Rw/iGt5IVJQmgoLF4zxOxMR+qanFQ=;
 b=wgWlqECdhIDiXooELq71Fd6K6vfuvExG1qMVk0vZhzpLJ0+V/OR+L5suuGohsnRcSz1IQcMlY1zzSGEbMopZg2yc3WKgfP5dpMb4lngvwOmz9+iJ97YktoO7MFfHCOi45UlJP5HAhr5g7g8t1MmbPc4oOy9qsJ/BbQbYSYHpw9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Wed, 26 Oct
 2022 19:25:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:25:51 +0000
Message-ID: <bdf90b2a-7f92-8f82-f1a6-225d7938cfb9@amd.com>
Date:   Wed, 26 Oct 2022 14:25:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 06/12] x86/resctrl: Introduce data structure to support
 monitor configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604560666.5345.17936133716540279017.stgit@bmoger-ubuntu>
 <8cb913f4-feee-de7d-60d0-055e234c6501@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8cb913f4-feee-de7d-60d0-055e234c6501@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:610:b2::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f9e297-d108-4485-8a38-08dab787e493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Rk9Rk0z0gWGCnpNKZmmTP5DlWvX7A6qndL9+ctpCYUGD/DSoAjmOXk6dT/Aiwi0Q4iR9nufB17ZvHQgw/2iuTpFQTJ45CdTbFvaaF2d567qwBK7XHfyRKMUqm0QWOzxyCjyez3RDrs1UzyFjTkgdDg9qZ9woe5nkvih7mbF28MVPJRL3k245FUH/KggzHHPuVWXyUFuK1ro8NLrODAO2NE+wnHWQuKLeYxRaYnvP2py8tab2JTGuoX9H1JQ8lWKfXcKnbl59+A8Yha79oBqDNLlBTxTihHZCzXrcinuyBIE57r+2NPKV+YIFov6fYBP3gD9OlTwJVr7TCzTo+LoahK3Y8vuLcV1pGHAtWKSf+B2EBiV/xbsVgPVlS+jmW68vmIghbH8tPB0QfrKZQvkcomdRg0aJJlUlw0ON7Q0pQN3q9E747hyA0xpWjiIG49mApOVe78x10FhOfT1pdiKBKpYL23r/5S9S/KHrd94LBzaBTNyAScTn8QQMw90HKyM92MSq8VRRF0ao9Ye33AJjRe5lBOMgc3I2InzrS8XfzzbrHCuvcOImdvDk1t5qZduvZPHYRzTN1W0O5dwSzFlwMYwms973hyqa7zoq1oPyVrC1RnGp3PowhlxOnDLsdDgSErNfs26vN6RPpR2HiIOy9Lh4H+G5V0V3SXvqgdEQSSP2K/OfdXu2iMCT1A6tyEyc1RlUXYpACjTVPm95qiPGIcFootYe1v0VVp02OrtRnYTgRrBk47vHzXYUlWu4x/pv9np7m5dDjYmgm02XkKqk0K2K3rjz6r2du6WmBOMNOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(66556008)(2906002)(5660300002)(3450700001)(8936002)(31696002)(8676002)(41300700001)(4326008)(26005)(66946007)(86362001)(7416002)(316002)(36756003)(53546011)(6512007)(66476007)(6506007)(38100700002)(2616005)(186003)(83380400001)(478600001)(6666004)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnQ5RTVDNmtiNVBDcWFHSTMrOWloL2V6OTFva29qNW9VVWQwcFV4djlUbFhE?=
 =?utf-8?B?aFRHeElLNGtkNmFyU0tEb0RtcjlYb0IxekRnQXl3RTJoK1Z6amptaERlZFVC?=
 =?utf-8?B?N204cWZBeXEwOXFmbXR0UlV6eVZBd3lSdlo5bUFCdEc3T1V6ejFvM2d3OHc3?=
 =?utf-8?B?TTRuM3JvZXYwRHVGcmlqOHBIY0VTeXJnVXFMd2pMK2RVTE81b2FrUTdZejJh?=
 =?utf-8?B?UWt1akNIY08yTUMvZG5ETkdjNmJYaDJwRGlNUGlFaC8wZU9MRmxmZlVST2pX?=
 =?utf-8?B?YU5OUStmWFd6Zlg4QVdtMEdOWTFJWHNWMlhlRVJzVytRLzk4TGNmUzhkU0NL?=
 =?utf-8?B?ZytpcDl4cVhLUGIrb3lTd3VSQzk0aVBQR2x1RUJWR1JUZ05MYzIvT1hHMmEy?=
 =?utf-8?B?a09rcUt4YTliUitNc3BmQVJVY0ZCWVJLVXdrcC9YNmNWSzlRcXlIVWI4RTZr?=
 =?utf-8?B?WUZyU2hrL3poM0lzNXNjVUgvRkpkRlpNZTlEMXNYYWE3VDk5T3NITjY4NzJX?=
 =?utf-8?B?QmVSWmdOdWpoMEdCR09ZUERGOFc1WGRvOUtsSEFIbjUrN21wK0Y3bE5aa2dT?=
 =?utf-8?B?VDBhSzFQVHdPMUkrUlBVMUxVNEo4UjYrNHg5ckMwU0p1aHN0azlyYmlBR2Y2?=
 =?utf-8?B?bi9XMVhub3JUcWJ0UmJTL3gwdnRsaFBUVmNGbHR5ZS9uRHdsKzhQSWY5RUt5?=
 =?utf-8?B?NmNTcG9EVFlhVWNadXZNcTdyd2lKWlM4ZVZJTVkrNVhrdGNiTU1SaEpkODg0?=
 =?utf-8?B?Y29SdW03eXNmLzB0akkycmwrN1h1SWVHK2pkU2dvelhrTjJyZklpTVJIM1JG?=
 =?utf-8?B?KzF4YXJ4VEdabXA1eUZ5WS8xc1ZXdW5tNUliVVd0ZEF0bFU4WFJmSGJPa3px?=
 =?utf-8?B?SndKT3JxY3lDemVWMENaazB4VVEyeGNNNkZjWEw3SlozTzZUK0lXRThsYVht?=
 =?utf-8?B?WVZ2Zkp1UEhOYlNIR0NzSlh4K3gxbGlOZkl6UXlIbkhUeVM5NkR0cGRuUldI?=
 =?utf-8?B?VVdsRFdTalRzVDU1RHVCVHAydWp5K3grc3A5bTNFTlZVOThtUDN0c3FIWjdK?=
 =?utf-8?B?alFhejNxQUNjWjhOWGtSMzRpakVlQ3U5aEVnLzlXK055RjNvWkdKUVcxdXpo?=
 =?utf-8?B?KzgxbUZ5VkJYd0hKQlRwZWk5S1NrS0VCNkc1akdlRzJiL0x2MGJwWUI1VFhZ?=
 =?utf-8?B?OW14UFpUeHJyK0IrL2U1RW5xVWJWd2VqVFZRUUFzWDFialZaMDE2bEh4VENq?=
 =?utf-8?B?QmNZOUd3TUk1N1hPOW1wSCtXQ2t2Vmpua3R5eUl1V3hORHNHK09XZ2E2Smds?=
 =?utf-8?B?TlBMeTlqbzVpdDBqTkVPa2hieEc2czhHTTY1Wk9FY01RdjRPbHdZWUNNdnl0?=
 =?utf-8?B?cFRCLzh2TUN1OENWUWZTR09yWmZFajFDZDBKLzM4Z0cxSHVSNnpzZjJaK3RY?=
 =?utf-8?B?OS9CNFFZMnp4NkVJQ1kwZUNTS0NuV2FNNUpDOUhGRkhGaEl0dmtNUUZMbG5N?=
 =?utf-8?B?MUtDa3NRVjVEUUJVaTVkRkxGUllncmJETVdTT1lTZHB1dm1KeDRDT29RUHZP?=
 =?utf-8?B?WHpOd0lOS3R5OFlJVHQzYWUwU29QYjNidmZFaHo3QmNpQzFxbzdZajgwVERY?=
 =?utf-8?B?UnRsME1wbFk4T3Z4RTIrZGRqVUVnVkJVVW0wdHh0Tmlxb0hOcFkvdnhrOUZY?=
 =?utf-8?B?bzhJVU5Pa1Axb3Ava3JIVTdkSzlIU2NGOG9sWERvbHhQY1NkdGt2SE1Yb2hU?=
 =?utf-8?B?blF2TDgyOEpxWWdjemVTZ3AzZThQemowaDE1RzJpU2l5L281NmxTVm0vMGV0?=
 =?utf-8?B?OVlMUXBwd3ZkWXg0ZDlVUm9HcXJLSkN6U0l4dlBhR0cxOGJsSERzRWtzRERC?=
 =?utf-8?B?cWlQakdNdW0zNTM3M2EybG9WSkdHYUNBNGpZUlZhRTVQTEtFamh3L2hxazZw?=
 =?utf-8?B?bHpOVGZ5bGZ1MVE2THBtemVYU1ZzVUNUYWFoNFFrTmR2N3htQkw0bStqcDRy?=
 =?utf-8?B?dHViV09BWURyUWZzNm5PNzIySUdTZ2F6c1lHTUNOVC9MNGx2YXdhYk9ZZ0wv?=
 =?utf-8?B?S2NUVWZYWjN4Yll0dGFubG9Pb1hVaS9GQ0dSWmhKSFR4RXdycXVlQU5tYW5K?=
 =?utf-8?Q?q6SbnN3ogWY/c26fAttjlCb1z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f9e297-d108-4485-8a38-08dab787e493
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:25:51.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmWAjsa6dCneXZBi/y3cwCg7FFoCgbSA8VsjtnwMqpA5cdHzGq6yjf9/fXmL9q9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/25/22 18:45, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/17/2022 3:26 PM, Babu Moger wrote:
>> Add a new field in mon_evt to support Bandwidth Monitoring Event
>> Configuration(BMEC) and also update the "mon_features" display.
>>
>> The sysfs file "mon_features" will display the monitor configuration
>> if supported.
>>
>> Before the change.
>> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_local_bytes
>>
>> After the change if BMEC is supported.
>> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_total_config
>> 	mbm_local_bytes
>> 	mbm_local_config
> This does not seem to be what the code in this patch does.

You are right. it is

# cat /sys/fs/resctrl/info/L3_MON/mon_features
llc_occupancy
mbm_total_bytes
mbm_total_bytes_config
mbm_local_bytes
mbm_local_bytes_config

>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     |    3 ++-
>>  arch/x86/kernel/cpu/resctrl/internal.h |    4 +++-
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |    7 ++++++-
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-
>>  4 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index d79f494a4e91..46813b1c50c2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -814,6 +814,7 @@ static __init bool get_rdt_alloc_resources(void)
>>  static __init bool get_rdt_mon_resources(void)
>>  {
>>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	bool mon_configurable = rdt_cpu_has(X86_FEATURE_BMEC);
>>  
>>  	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
>>  		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
>> @@ -825,7 +826,7 @@ static __init bool get_rdt_mon_resources(void)
>>  	if (!rdt_mon_features)
>>  		return false;
>>  
>> -	return !rdt_get_mon_l3_config(r);
>> +	return !rdt_get_mon_l3_config(r, mon_configurable);
>>  }
> This seems to do a portion of configuration in the calling function, pass the
> results of to the actual configuration function where the rest of the configuration is
> done. Determining "mon_configurable" really looks like it belongs in 
> rdt_get_mon_l3_config(). Is it availability of rdt_cpu_has() that prevented
> that change? Why not make it available internally to all resctrl code?

Yes. It is because of rdt_cpu_has availability. Also, it is __init routine.

Yes. I can make it available.

>
> Patch 7's mbm_config_rftype_init() can also be moved to rdt_get_mon_l3_config()
> to match how other related configs (thread_throttle_mode_init()) are done.
Sure. Will do.
>
>>  
>>  static __init void __check_quirks_intel(void)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 16e3c6e03c79..b458f768f30c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -63,11 +63,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>>   * struct mon_evt - Entry in the event list of a resource
>>   * @evtid:		event id
>>   * @name:		name of the event
>> + * @configurable:	true if the event is configurable
>>   * @list:		entry in &rdt_resource->evt_list
>>   */
>>  struct mon_evt {
>>  	enum resctrl_event_id	evtid;
>>  	char			*name;
>> +	bool			configurable;
>>  	struct list_head	list;
>>  };
>>  
>> @@ -522,7 +524,7 @@ int closids_supported(void);
>>  void closid_free(int closid);
>>  int alloc_rmid(void);
>>  void free_rmid(u32 rmid);
>> -int rdt_get_mon_l3_config(struct rdt_resource *r);
>> +int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable);
>>  void mon_event_count(void *info);
>>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index efe0c30d3a12..4b8adb7f1c5c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -746,7 +746,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
>>  }
>>  
>> -int rdt_get_mon_l3_config(struct rdt_resource *r)
>> +int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable)
>>  {
>>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> @@ -783,6 +783,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (configurable) {
>> +		mbm_total_event.configurable = true;
>> +		mbm_local_event.configurable = true;
>> +	}
>> +
>>  	l3_mon_evt_init(r);
>>  
>>  	r->mon_capable = true;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1271fd1ae2f3..5f0ef1bf4c78 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1001,8 +1001,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
>>  	struct rdt_resource *r = of->kn->parent->priv;
>>  	struct mon_evt *mevt;
>>  
>> -	list_for_each_entry(mevt, &r->evt_list, list)
>> +	list_for_each_entry(mevt, &r->evt_list, list) {
>>  		seq_printf(seq, "%s\n", mevt->name);
>> +		if (mevt->configurable)
>> +			seq_printf(seq, "%s_config\n", mevt->name);
>> +	}
>>  
>>  	return 0;
>>  }
>>
> If mevt->name is "mbm_total_bytes", then would this not
> print "mbm_total_bytes_config"? This is different from "mbm_total_config"
> in the changelog and does not match the actual files created in later
> patches..

Sure. Will update the changelog,

Thanks

Babu


