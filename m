Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129A65F0CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAEQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjAEQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:06:14 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE1018397;
        Thu,  5 Jan 2023 08:06:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC6mDsgHYDEApqDRX92jo6Lzwf/3xo+Awt3hrmtvgFBk2wZlONavC3UO+q8Os6SUgRttFCQ8uthsVPzKvRX0jBQX6FFZlO1oHhNkycjazpu4ADgmY6CnR66WlBiSQQ2yvWOBIiLMZuFwPdoTN5VL8w6cP48YVC2pvRP7N5cyeJEbZUE9E/Yqqarx/a85w6pmuqJsoQxU6UfV1DocXq4bo1ZH7vrdA0r3znIKAfl5DamG8xTPNvLz+geRVsKvLBvlS6hu32LFQmltMN6SgD+XeQmTHsXxV9i2L315qVUWI4XAoD9rV26Vek4hoclyDo6gP0royn5AC/2Qeo06XneDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBdGzICUi3/VPXmSEGltT+64IpsYa4MHghqnN3OTAcs=;
 b=Tx2wsteuwAr59U+TXkQRVRncya82KLq+NEEDey5Uj/7oLQumtGQK3cwqWGYd/+y8xZvrspgL16tiW5iuLNypPNCECMMogVFUljle/yDx1RbuPGYP29S2jZTruItmzeDMmUL6oaqoRpjIu9tZvC0w3AAbedW5gJFS3Epg7Wtc3Byidt90WiPBhVwnQDRZnHytrMuwWLuub/C8hmtYRyR0U3nkS8Ij5DbXXIatRMymve3Ue/gvC7xDJ9dTzhJdTuldpNwxhyXJ03D8/NckA6jLcwkdXd04bjBMgewbjM4yl25ORrAlTlB7I4i1//CD6POUT2CnNV+9yIXAJKNlgG1Rww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBdGzICUi3/VPXmSEGltT+64IpsYa4MHghqnN3OTAcs=;
 b=Ll5Z9PQhm5y1jYzX4+1wROQ1/45yiMVSFSnnoCVwXvv06RQsoNzmgKPD2JsfBYq+hOO5ypxTu/wMQjD1TznfhmUrdHALjmHycrM1XAhomyVmSvsqx/TTbZGSfflu8riezKlm23v2/aLImWFsYHBnupEL1HmQy3DpwZZBzv9iOcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:06:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:06:10 +0000
Message-ID: <50e99ce9-40d4-5806-f2e0-57a685db36ea@amd.com>
Date:   Thu, 5 Jan 2023 10:06:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 13/13] Documentation/x86: Update resctrl.rst for new
 features
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
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-14-babu.moger@amd.com>
 <ea72280d-cf15-b1e4-17d2-966de7f6394e@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ea72280d-cf15-b1e4-17d2-966de7f6394e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0029.prod.exchangelabs.com
 (2603:10b6:207:18::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a99bd4-1fb4-488c-f38b-08daef36c2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11dVsLH3SJOnsLQ1RRB1ueRNKzVd+tdRMBnI2rF7CsAtp4mfOBW4XFhNtYcs1+gn06qsHro2PX+lBSf9j3hOin5jpJfOubNI/9vujpRKk8euSM8U5Ouabe4ZssR5ZmPiTCDX91F+PFUhB66ZET0gkjO5ZxX46rc7ROsUUvebhstzgORzagTNpQW3itB3C8+MYgv13lVOyLJqnAloQbOxpLKuHlzh3p2f/mXTTTVoWS71XJ3MoEcwdyrxYuhQpO+FOHZ/vSTKyKHJctMEJoSOTMzZYDyfkxU8Srjg2PoqsvS9DqErvBT9sbHL65iqwU/NWu3ayvAUT9egM495uTtGKpoOE1rvVJ92estRol8eg98F82uM/KQSfm0dvjDitiUU7kYEsfjV/i1kE9wXjqspLnSmxZahE4ZS0fGZp+gN7J6meYZCwaShgvUzKrX1B1umgvOEHH+FZXbAkm2USndtmkgUcZfeP8Q+aTgAfFCBVX0PqW5w5CvLyp5hXyQ4CJ2W/BCfGzZLjFvagXr4gyOcS4cGpqy5WPLqz7ppKaffl93oLN1hvJwqUv7pBWgw1paDsWmSb6/YWO3w0tBiUviaDDOJI3lskD0kciz+nhrMwT5i5P0niZBHcMUrPQvnnkvqobS2ffErAMdGJK+bnrEVs5U0ua+ulS8j5ivegmTMblIicUVhmoxXPykJFAgkHOozbrL0kh8jpIxayL+x+d176Pd9nREgeCNb6r/aHe/AULc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(6512007)(6666004)(66556008)(316002)(186003)(26005)(31686004)(4326008)(66476007)(2616005)(66946007)(6486002)(53546011)(478600001)(6506007)(8676002)(83380400001)(7416002)(41300700001)(7406005)(5660300002)(8936002)(2906002)(3450700001)(15650500001)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBlSEprRkxuazkwUFZMWE5xNGwrZkhOakgzTUFnajhuQkpCTGRmWS95Zk9r?=
 =?utf-8?B?Z2VneDZmcmJ4OUpCdHMyNTdGc2RoNG52R2xraGxSUUxRaUJDa3ZyUGttY1Q0?=
 =?utf-8?B?VE9UNnhlaDhaYk9vS3V1UDZJTnlJRzBGTE5ORlJsRm9xNUVXbnh0K3AraXdV?=
 =?utf-8?B?N3Brc1dXSjNDZ2JGV202eEFLcXZsK1RjSThXWTZIcWZqa2s0VkxOSU0zcU5C?=
 =?utf-8?B?WE9xcjd0a2hVb3E1Z1NHT0lFcFBWV1pYTVlhaVQwR25ZRm9md0pRZmVncm1t?=
 =?utf-8?B?VjJpc0gzMjRkdmVHc3gyTms2ZkpaS1A1ZXU3a09XWUVpVEorRXRXVVgwbDA5?=
 =?utf-8?B?d2N6L1hFTzA5dWY5MWNCbUpDc0pSYlNzZjhpeWdQQ2p0K0gxUjBLcVhUcFhQ?=
 =?utf-8?B?LzNvYjB4eVhJVG9hWmlPSk1hdTJyWkxrcmZUYVRIc2NoUGxHNkl2OUZhS3J4?=
 =?utf-8?B?KzJ1QTl6NXRweC92RDFSQnNWSUNwMno2NU1UWklUczhVOFB5NUpubFBhWGU5?=
 =?utf-8?B?UmhGQ2dmdktHcmhlRFJzNndjUitmZVRZMlIvUXMzVjdiczl6TXBxVkMxM1FT?=
 =?utf-8?B?M2doL0oyRWZCc0FZUHB0UnBtTzZ6SnJYUFllaUJRczY3RVFtMGYrYXk0dkFY?=
 =?utf-8?B?dGZVNGRvVnBIY0VrVEdIU2R6NnRCUUp2R2hDZDJHOHZFSjVneXgxNVlTTnpt?=
 =?utf-8?B?MHcybS9kc1M2RzYxaUJjSEtqRXMxMnNkTjFkM3BPWlQ2NVlTb25Eb0JzbVpG?=
 =?utf-8?B?YlRlN0V2TXVlSVJ1WnBoRHhqWUlsK0xGZXludzJ0V1BldmZvRWdtd3pFODFP?=
 =?utf-8?B?UzU3UnZQZXNlWlgvRms2c0h1TW9kdE5TTklXWndqbFYwc2VDZkk3cHkxSW5l?=
 =?utf-8?B?VDVaUU5GR1lTWFdqOTRpZWRoZFpHY05DSk1rU3M3ZFdMaEU5M2NJeHc4cGRY?=
 =?utf-8?B?V1R6cDMxU0hBV2Z2T2hRSmkzQnBJUE16Wk0wblJmYmZSSU8rcTljbjJyeTdm?=
 =?utf-8?B?NnUxKzRGSzYwcG1VYTh4bzE3ZzBLdnhNcVplbEVwV1ZReFZhT1VidERaTjE3?=
 =?utf-8?B?WGdhUmtFTDNHNEhUamc0LzJqZGtUZjRlbmpsNXdCMUgwN3RYbWxRMVFZaG94?=
 =?utf-8?B?ZWNKK0FwVVJoYWRZRVhVdnp3Q3A2WWtXKzk0bmR6NjBIT0dwNVAzdllSVlgz?=
 =?utf-8?B?bWZPREVaZzZRNnJjcnJYYVJzQjNJeVlUeGhEQUE5RFdBeVFISnhRWEVUdndF?=
 =?utf-8?B?WmJ2YVQ1S2c3RlJGUW9ia3pGci96Rkg2aXVnaGcvR0hLQmhCV0tmSXlxeUNp?=
 =?utf-8?B?Njc5bGFsekxiMWdNbFQ3SkQzWERhNnlZcmJxd2NNL251YWtMTFhja0wwRGhk?=
 =?utf-8?B?VXRwZEwvVUpjWHhDU2ZPT2xzUlRjSVppZW45NDdOTDZVSGVWY1BQZFNqVzNZ?=
 =?utf-8?B?dGFWOUl0R0pWYkJ1d3RVUEp4UVdGRlhoV2hNV1REK3N5bVk3Ujc4aVVSQ2Vt?=
 =?utf-8?B?ckgvVy9kL0c0SXA5ZTZmQURjSnZOZ2VQRkV2RTJhWERuMGFTdmxGQzF3Qy8y?=
 =?utf-8?B?MVlwd0ZESDZrL0xUSXFHQ2NSQjB1ell2RTIzNzk0OW00WFpaeFRHNHZTNEdD?=
 =?utf-8?B?V0dkZGcvUlFUNzhTT3FKNjY2N1Fwdzl0alBqL0pWcHFuTEhmZkF4Zlc2T2o1?=
 =?utf-8?B?YkpmU2s1ZjZrUE0xWU5ZaUtRZ0Z4K1hQZldDM0ZRb0ZXRkgxUmlMUURlTm8y?=
 =?utf-8?B?Mnl2VXIvQUpMdGFaYU51aml5REhYR2d1K003RGxiSDRTbmltcnAzOUEwRmlF?=
 =?utf-8?B?SVZyK3RidGdpZGEyTHB3NXpoWWg1Vlo0L0U0YXlrWTR6MDM2Q2FLZHNtMGhX?=
 =?utf-8?B?L2VnbUhJY1l3bWxtSEFZdnF3R2VURTNBdjRxd2FuTzhOVllwUGk2VDlGZ2l2?=
 =?utf-8?B?Zkl5Zk92TjRlUm5raHc5dHZ6bWR5ek5TMnlOS0x5Ynkwd2VXMTU1WUEyd0dn?=
 =?utf-8?B?dlJ1SUNlNFBOdHB3cnozamNDZFJBK29PS0J2QUlMU0NGcjlaa05rRzlETGMz?=
 =?utf-8?B?WVhTc096b2twMDUyVUlLYkJ4dDBpOGpHUzBpYnNxbi9DMzNSNHViT1Q5dVRJ?=
 =?utf-8?Q?GurI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a99bd4-1fb4-488c-f38b-08daef36c2df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:06:10.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3AgBBY3dEu6PcjtXJudH/zg6Jpm2r6ue64yWiEPIOKQacXqNe56ufvtaoz6YwAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/4/23 18:30, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/22/2022 3:31 PM, Babu Moger wrote:
>> Update the documentation for the new features:
>> 1. Slow Memory Bandwidth allocation (SMBA).
>>    With this feature, the QOS  enforcement policies can be applied
>>    to the external slow memory connected to the host. QOS enforcement
>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>    and specifying allocations or limits for that COS for each resource
>>    to be allocated.
>>
>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>    are set to count all the total and local reads/writes respectively.
>>    With the introduction of slow memory, the two counters are not
>>    enough to count all the different types of memory events. With the
>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>    and mbm_local_bytes to count the specific type of events.
>>
>> Also add configuration instructions with examples.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst | 141 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 139 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 71a531061e4e..bea6cab06873 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
>>  flag bits:
>>  
>> -=============================================	================================
>> +===============================================	================================
>>  RDT (Resource Director Technology) Allocation	"rdt_a"
>>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>>  CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>>  MBA (Memory Bandwidth Allocation)		"mba"
>> -=============================================	================================
>> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
>> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
>> +===============================================	================================
>>  
>>  To use the feature mount the file system::
>>  
>> @@ -161,6 +163,82 @@ with the following files:
>>  "mon_features":
>>  		Lists the monitoring events if
>>  		monitoring is enabled for the resource.
>> +		Example::
>> +
>> +			# cat /sys/fs/resctrl/info/L3_MON/mon_features
>> +			llc_occupancy
>> +			mbm_total_bytes
>> +			mbm_local_bytes
>> +
>> +		If the system supports Bandwidth Monitoring Event
>> +		Configuration (BMEC), then the bandwidth events will
>> +		be configurable. The output will be::
>> +
>> +			# cat /sys/fs/resctrl/info/L3_MON/mon_features
>> +			llc_occupancy
>> +			mbm_total_bytes
>> +			mbm_total_bytes_config
>> +			mbm_local_bytes
>> +			mbm_local_bytes_config
>> +
>> +"mbm_total_bytes_config", "mbm_local_bytes_config":
>> +	Read/write files containing the configuration for the mbm_total_bytes
>> +	and mbm_local_bytes events, respectively, when the Bandwidth
>> +	Monitoring Event Configuration (BMEC) feature is supported.
>> +	The event configuration settings are domain specific and affect
>> +	all the CPUs in the domain. When an event configuration is changed,
>> +	the bandwidth counters for all the RMIDs and the events will be
>> +	cleared for that domain. The next read for every RMID will report
> I think it needs to be emphasized that configuring one event impacts
> all events. How about (please feel free to change): "When either event
> configuration is changed, the bandwidth counters for all RMIDs of both
> events (mbm_total_bytes as well as mbm_local_bytes) are cleared for that
> domain. The next read ..."

Sure. will change it.

Thanks

Babu

>
>> +	"Unavailable" and subsequent reads will report the valid value.
>> +
>
> Reinette

-- 
Thanks
Babu Moger

