Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3E6368A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiKWSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiKWSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:24:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3AD60693;
        Wed, 23 Nov 2022 10:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoVAgLPpfdtSeNjhQqwTnBsvmmgXNwbo7RjRf+hI3xOdSzFgQc7HoR22YGy3zzq4oy+BiS0qSkESIefarSC+vERBsV6v6SojP2YKUaOXTh+Alo92mnpoz+7qxCf/dpymQn1Rjnj+W/xlTdDeOvq36O5g9GSZ4imNCwCr/WubmctBZ3o2jVFuacqgnzejLSS9GOaqHaF4ZKXs77fyoBtJMMQ9P0X6VM9XC0MHeN+4+ke3vMCs4UiZSeVavrzSC3tTaEya/fxQe6AS6XuWtd4lph/CuxQpe4m0biljhal0KCNGILhW+6pQSYYaEYNN5d4FyhDSS1wA8KvafjtfCz9PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I71tz3MSDgQEUvb2sjJgnmw58cl3XS+NlAbEB3dqxM=;
 b=bINh8Mz3birHtI+Qiy+w1EEmg281M79Z04MMYQemLPRqiPei84H6wTvbk2E9r2OXJN9TE0SkAy3/B03Sw8cGZ+lcz1Dc4BFJlZsZt0c0zLDn9XT/H+gm15G+OSpzt+lPPShhNr4OCxdDolN8AmqK+Y9kFIWdALNBA/DDZ/hNEgaMxP6GVUSKpBt3puw7dQcDZhv8XV8GOYIHRTVgDqJhDaQ0RosuTXTU77QJRpcAk9ryhDbaZGNkRJNn4KLPBEX90080UJg/r9Ikww+eIoyYPxs0P8aRo9KNv1HAsLvPAdCTyPn8mYw80guc4V+yngMkCm/jOERtDSsDqlBKXN426g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I71tz3MSDgQEUvb2sjJgnmw58cl3XS+NlAbEB3dqxM=;
 b=N75ogEYvqbeWiNaNTdF6OEsw9kQOSBHWRG9Xf3f2AOfobNLaKFrGvD89vybJQRtRj7XQZcC9a5MlQ/BpOavQIt9yrQepgkMS8jaI025ycx4sjJpFDfYqN8uTv2r49/EqSZ42imLomvQ5FL8Av1xGKjnAH3RjTzcOorpqicc5dfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 18:23:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%4]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 18:23:59 +0000
Message-ID: <06ca0226-687e-c123-4132-b8aa2ae76439@amd.com>
Date:   Wed, 23 Nov 2022 12:23:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 07/13] x86/resctrl: Introduce data structure to support
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
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759204323.3281208.9744810874584175730.stgit@bmoger-ubuntu>
 <74fc09e7-3a75-2c62-d505-244a12b6190f@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <74fc09e7-3a75-2c62-d505-244a12b6190f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:610:119::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b49eae-b6ed-4324-0b1d-08dacd7fe3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Q4wvNNq1WhRNjGjSQTNoinCSATOzBC6n9pBDp05K3LNFLwZbK1J/616c4vQWrwThJf07Q2LtTAZX1S3X/uFlqlyq96wpWgt9//c67rxSXV6NH+1HXVBVIa+Dt0fU7m2ZvRvNZoyYX3PWxdm4nJcN/+NlQp+TJsSyVDMYlu0IPTBRedulf80TWbhTpbE5np1P7k3gCUbZLkH4JSjmTQatkPaAsoZWZs3qJYpy85K4GhIxpeNnu6Eso+xWxB0UrzyuY0BAJSCPfu/EZx66nMyhmC+BST7oT0fKS8ZGVUPS0JlbWNuPloQ4LUTCWeh71kb1CUpysgBo1Y+YUUPsrYkIEYAQt10H7oJ29nPNki2PYL+b6Zi2EqGDWrwj4/7FUlgeNK7EQubpnF5Z4UEFzjMYupYf2+IBVV08xN79zJlDVBagZXltsMY5Nxor4o4NAXIAVpQJN4qr/EDULSpWppYckv/QmyQLeLE3rSHIeGbsiJ7mAahvdqS+AwZ0rMYFe5m9ZJRTevtJLzGbPH816SEZCg/Q0Mf17Fh3IaT6jMZ1C2kz71Qwdf2oruG7Nbuwbui8+RiGgY8xswVZXfB+J7sSRWl8FtmxXICAq1HvAeYtDJGLabhq7Z/AP+aHOYLpass5ard7+sl9ywhshQijH/FQCOSr2gBC1SjjlXkS9F5KyRo67HFO3PM+UA4L/UUcoIT5uRbhES0Wq1/YKsojd9YvKC9oSOqqiI7vBpfUV20PBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(8676002)(66946007)(4326008)(41300700001)(38100700002)(66476007)(2906002)(31696002)(6512007)(86362001)(316002)(83380400001)(66556008)(3450700001)(8936002)(2616005)(186003)(36756003)(26005)(5660300002)(7416002)(478600001)(6666004)(31686004)(6486002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdPKzNuakgyK3J3R2Jzb05KZlI2REJlNHZDSDZLdndsSklHVDgzbCtxeXlP?=
 =?utf-8?B?MzFVcFJPY1Uwck91bXg0NXhmK3VEVFhwU0lCRWxJUnI2Q25rUXpkRkQvM1pp?=
 =?utf-8?B?NWFlaWphU0VzcWNLRC81K2xqaDNIKzZ2Lzd6RXlQekVmb1VWMURTanBaTlBC?=
 =?utf-8?B?eVIyUXd3bkhINUNZRVhwYldjUkcrWm9iMy81R1lvaEhlMnFKcTdyazVEL1E2?=
 =?utf-8?B?V2VrbDROU3l4bFBjVHVqNGlGZGZSK0RlYThiSjJBWG1NeVVqeVI0VlIyakxI?=
 =?utf-8?B?bGoyLzI0ZlpBU25LMjlBNWNrbUFyMXlobytZRXk4dit0WkNGTnk5dGJNZVBm?=
 =?utf-8?B?TDV4MTl4a3V6MUoydXFVU0tWRzl6UEZtZUJHRTM1SmJ4d1crZlhyWHNJQWd2?=
 =?utf-8?B?cWRiZXNKaDZLNVdlS1Q1UXJJMGhzYTNnWDAwRi9CKzVCeVBMNkhHaXJwWGVG?=
 =?utf-8?B?dTVnSUJpcVFhamx3VHJZeW4xeHNsVkxuN2lZSkUxdEswRlFLVFh5a3ZHOU51?=
 =?utf-8?B?VWJsa1kzZW5qeS9vaW1UTU5ZUGVpcWdJaW9BSVloUjhkOHBRSDZmRWszeWlN?=
 =?utf-8?B?VHY4cmlaa3c1b3NTVHAwa29TNXloTitIVW03Szd6ZVcvR0x2QzhOU3Q3Ujd3?=
 =?utf-8?B?ZENBZXdXQmRIM0FuWTBPTndLanpHMndJUnVPcVY5RDUwYTU0U1ZQRDlxVnE4?=
 =?utf-8?B?T01VUmJPcnEza3ZYb1pwT2tNaGo1c2xtOE5aTzJVWTBwL2EraHBYNXZXUG4y?=
 =?utf-8?B?OVJDWVVINE1FRzRqYnRkSFFKcDNTY2tjcytUNkRYZmt4elZiZzk0aWMzYmNR?=
 =?utf-8?B?Z2VqTExEK2J6STYxU2xUem9iNVlWZmFyNUFacDVyUExCcnBtYUh4VURBM1JG?=
 =?utf-8?B?eDBncDNGdll1eEl3bTZlSGMxazdCQTNERVlnWUtjUXJTU0ZUcFdWZVFPWUN1?=
 =?utf-8?B?RmcyY2R2cXhwYzlxa0l1Smxac3dpMWNwSXQ2ZEJHaFZ0L2V0alBnd01vNFUz?=
 =?utf-8?B?dVVBeWFHTG1EZi9ybk9COUVFQlI0Nm1WWVZBdkswTThNbmpiTnB0c0w2TFVj?=
 =?utf-8?B?dFA1ZWNVUm1HNkJiVVFPU25NWkFMQ1p4NmNBNGZ2NzFIcEZiL3A3VnI2b3Rp?=
 =?utf-8?B?ZGt5d1BqZjJiQURBMVRXQzFIdTdScEFBL0tZTmJaeFd2Sk4wNGtscUFQYmVN?=
 =?utf-8?B?R1V2OGRmUHNNdnplR0p4cVZTNGdrN2VEeXEvVlcxT0dONWFCS01NWlNQRlRK?=
 =?utf-8?B?MEdsdlJZMXJ1cGdMa2tJb21PSjlqRkIxdTF5WWl2MGZSbmtWd3lDK3hXb2xH?=
 =?utf-8?B?bWtEOGRoVTgzcmx1QlhjdGQzMnIwNGZMMTM1WjlvUVBpRDQ5cTBQNjlFQ2tS?=
 =?utf-8?B?UnovVmp4U3BFNzYvYU51aFh1RmhKN0Q1b09jMW5mQVRxUGZaaWNwU2RnZVFs?=
 =?utf-8?B?QW5pRVZOeXlMNFVuNUcyL2lINUtZc0RNMldob0JXMnNLMjR1bGFJaW5yQUV5?=
 =?utf-8?B?UzVuR3N2cDByc2ZhQ3V4ekRDVTRrazFLR3c0VDhIYjdoMHdRM205SDlHZ0xt?=
 =?utf-8?B?SDJoRWVzMXdsbW1OT096M0Q3Zlcvc25XMkhpTk9OMVd2Q1JtdXNpZUFyMDZX?=
 =?utf-8?B?WVdZVkJZelZQcFBta1A1UXlESmZlL1ZpdzgrMENxOGFPVHNqelhONDg1enZQ?=
 =?utf-8?B?SHZJOEM0RTZrTittUytMWllWWWluMVpCSE1ZUDIrM2IrMVVTTVN0VGlqNks4?=
 =?utf-8?B?Sk80M25idFEzeTI4eHdQTU1Vakw1VlpOVGVOcXhZYzR0eSt3RHFtWHJMRUk3?=
 =?utf-8?B?Q0xpYWU3eVVuc0IyWmMzblNNa3ovSDBaU3ROZ1VrcFMvQm5keWFDTDc2eGUy?=
 =?utf-8?B?am1mdzhvZkxWTEc4ekJSQVIzbXpwMldsUDZtWXk0aDRRMXpPSzVzSlZwTmpL?=
 =?utf-8?B?a0JqdjVpWGdJN0o0SmhwTDN0Wm9teWtiZWVCMldLbUwxNW52cmVUVnUybUZW?=
 =?utf-8?B?NkdyWlI3WTNUUWJNTGJCa1pXU2dDbURPRnJ5MWY5NkxOV1BaaHFLazY3eEVR?=
 =?utf-8?B?OGlkQXI3YkFibDBZTVVxdFRFOGdPb0hPK3M0Vm9hRlc4NHdSb1A3UlUrbHM2?=
 =?utf-8?Q?nOWc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b49eae-b6ed-4324-0b1d-08dacd7fe3ce
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 18:23:59.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/VuRT3eRMXRncZP7ehVAfneuQlmPkU/ievDKb93UBpnLrIbhcHDcazymnOdFIGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 11/22/22 18:14, Reinette Chatre wrote:
> Hi Babu,
>
> On 11/4/2022 1:00 PM, Babu Moger wrote:
>> Add a new field in mon_evt to support Bandwidth Monitoring Event
>> Configuration(BMEC) and also update the "mon_features" display.
>>
>> The sysfs file "mon_features" will display the monitor configuration
> sysfs -> resctrl ?
Sure.
>
>> if supported.
> This is not clear. "mon_features" does not display the monitor
> configuration, it displays the name of the file that can be used to 
> see the monitor configuration.

Will change it to:

The sysfs -> resctrl file "mon_features" will display the supported events
and files that can be used to configure those events if monitor
configuration is supported.


>
>> Before the change.
>> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_local_bytes
>>
>> After the change when BMEC is supported.
>> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_total_bytes_config
>> 	mbm_local_bytes
>> 	mbm_local_bytes_config
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    2 ++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |    6 ++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-
>>  3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index e30e8b23f6b5..5459b5022760 100644
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
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index efe0c30d3a12..06c2dc980855 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -750,6 +750,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  {
>>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +	bool mon_configurable = rdt_cpu_has(X86_FEATURE_BMEC);
>>  	unsigned int threshold;
>>  	int ret;
>>  
>> @@ -783,6 +784,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (mon_configurable) {
>> +		mbm_total_event.configurable = true;
>> +		mbm_local_event.configurable = true;
>> +	}
>> +
> Is the local variable needed? Why not just:
> 	if (rdt_cpu_has(X86_FEATURE_BMEC))


Local variable not requited. Will change it.

Thanks

Babu

>
>
> Reinette

-- 
Thanks
Babu Moger

