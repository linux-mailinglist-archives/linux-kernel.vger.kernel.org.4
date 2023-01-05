Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29F65F073
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAEPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjAEPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:49:08 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16021559FA;
        Thu,  5 Jan 2023 07:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayWYD2rVjg0YjQmQNfD2YZieiO9+9R11eHexqBAqkZJKUt73694lKV6bgUuYxykVJpJesgA11mf4aIy5lwZE1BrQDHpjHg1SjCDkdPLLGIfH3tnMF32GZxkq9hB8axTmIGEdivA3G0EYhRzjcbdxV5Gw8nDwqtssI+3T4u8y6uTTWuxK8cycpkpCeRmPOBu91vkakrkytbzsOzRjf1jkIAXCQ/mUHeRjzKg0qcea6OQh5RCeD1TzZFBDYSU/WEil3R8MB2E471HKsut/eEdvhml+Oxq3n/h9XVZfs/gdPDLjQMUwRtGJtM9e9iIbhBGR2ER7dneCkj+AR/zV9pInvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoqG2qHvd5Dhiif9WtkTxDV38sNDPezOv4RM/3uX0ZY=;
 b=Ju+g0+ETzMuEZ2qn7i/1gZL1WHq7M6aIAGtuQuo7OapWgyz4Q2V9BPE6R/R4pAhjfyaohuql6MbyFQaWSLH7dz4tBip2ap7oO2MPOERs1ALDUthOx0C3qry3ekbszhOlihn7+BIJxODUT0SS6+lzBJpEpYty8T6z6SFlI+k3vTHyw6/mr1AAqlT0AXLUbTowadswe0FunIi3KSCVOnqO8XIsOipt7czstYHSyMk0uxhkeZl5qiTAYl0KCySZfozgHaDV22AqGZo+9exUkG474f7AscqCiAKeljLLZMO+aYjhSNjjvCq57ykyD5ooNp5tU5fA+U8rGmw6Umhx93r0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoqG2qHvd5Dhiif9WtkTxDV38sNDPezOv4RM/3uX0ZY=;
 b=kj5LJU85EDGG//5zHqa5rN4qZmXv/SPkdqd04ZB/3EwOicGJIvGR8P9zDzt3nbERWLILs09lmIvFGCl0sUdOx8IR4HQKCEb6cU3yWjfcM4ZA+YsNibEgms/SwXYH9ogDomU+K9IZZy8bs6CzlC93zD8vlEUmTCkjMYKOM92Vt2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:49:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:49:04 +0000
Message-ID: <0c8e83e6-c299-fdf3-1528-b97d578438b2@amd.com>
Date:   Thu, 5 Jan 2023 09:48:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 07/13] x86/resctrl: Add __init attribute to
 rdt_get_mon_l3_config()
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
 <20221222233127.910538-8-babu.moger@amd.com>
 <6597dab2-db66-e4c1-e8e2-b18b2a0bc9e3@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6597dab2-db66-e4c1-e8e2-b18b2a0bc9e3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 5944fba4-a745-463f-27ce-08daef345f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZBcRBdsLpSZ7/kDi6dW9uqIURZwisdSGADfBocrKV7wXeUox3H29OKA22DPGwpijDqOK0uHC5qBkwCQ6KVjzMK14+/bEkhVFpJCbegFpZj1sifbO053gMsOjhYjs7ooyJaSie0z107P4i++Mp6MovNhY7ovGmaM1HSNCj1WVbD72YVc5b56oLoJo5evFkY55c0Rwa3U/W8mQMUh29NscnExcGd96Y2tfUkn06Xwy88duuvk8p+DIrqA32PD9uLTsXC6CjTvOsdBg55Izh+OpespTI954ROcsRjGJ3f8pU9qAr9/PlgHot+/OpFZV5Kadz0uL56ABYA9S8ib0kofOXfwsoDQqlWQJhb2AesuRHEtdonSKu5nrKY7gECGwVH9+v4byyKEOkHpPqGNiA/y/Ov6chv51wFAqK/WT/dcCA1alzdlnKR88YxPtoz69xtTKWr+7QaZVt+xyB/GnsSgswR/H3/K82kgWLmmNckTjCHsX/7maJLaGbAMMgRdStRqIqyUB6gwnrL3v2o/4LTJN7F8IisIZL4/111hfHSw5Ml1dPp674F6a+doKTtJ97vAmZD4PjaM4Xr5Z7TA1N42lL0nkTbwqJmVQG/ZS7UAURpVMRVmjknQMwq/bHWlFHLLVv/yVHEYdSttNYRghpq8/r4nc8cXwqPO9QwY8TjBulVZ6OOn7YVTsKrxAT+tFzYJ/WA7+EowPPrVHvzujkoEEhC8kPdqs2asImNUGXgoVSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(2616005)(66476007)(4326008)(66946007)(8676002)(36756003)(41300700001)(66556008)(316002)(31696002)(2906002)(86362001)(3450700001)(5660300002)(4744005)(38100700002)(8936002)(6506007)(478600001)(53546011)(26005)(7406005)(6666004)(6512007)(186003)(6486002)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVViUGRlb2Z2allEdCtNQkJEVTB0Uml4MmxwQkxPc01ZdnFzREViTTdJV3BC?=
 =?utf-8?B?NlRjVDcvQ3ppQnlJUVpFaUQ1UzBCcDFxZWR6L2dmOENJZUQ3clhaeXBTTXNR?=
 =?utf-8?B?Vm10eTFFVjVyVWhBNS9OdWxkZW8xMUN6dVJxRjJSbkx0Yzl2L20rSEhzRXlC?=
 =?utf-8?B?Yi9rNElsWkR6YmJPaVl5QVZBWkQra29sSTI1SGJhZk1ZMW9VeXhGeDZ0ZWkz?=
 =?utf-8?B?ODhRR2IrUzYxaDNybUVFNktCTG43cDVrTnFZemQza01oVUFhWExQRE9IRFVY?=
 =?utf-8?B?Q283d2MrMTBwSCtidDdFTHdxaTYwejVCenhwVkoyckRGWld6M3RvVUgxSlUx?=
 =?utf-8?B?VUlzTFQ0ekVDSWNZeUR0MllNY2lWZW5Tdko1NlQ0T1pJZllzZFgybU9QMTVF?=
 =?utf-8?B?MktsS3QyYjBsSlZYOGN3NHNVMXpJZ3RYSVpJWHkrak13WTF1dVQvdmtXSHdD?=
 =?utf-8?B?d1dsUzdXcXJ3UlZpaW1sUGlyRFZ0RTR6RzRuNGc3N2lWUSszUmo2OUdoYjJu?=
 =?utf-8?B?T3BWRDgzdGFuWHlwMytqRlNyRXpxV1NpTTRRa21uclUxWlJBU3IvdktOVHR3?=
 =?utf-8?B?MVV4QmlGNmIza2dBaGVRTityNlZJWTFSdGhSU3c3ZjNLb2pyVGZJZmM5SUNU?=
 =?utf-8?B?WW54ZS9qMjJuOE00RjIyeVZFRkFrbW9uV3Q2RUdDMzBaV0tvWjR5WDdNZXBm?=
 =?utf-8?B?L1A1emdRQ1ZVUVY2L0duaE5KQ2Q0LzVqeWp6RkpraHQyWG5wcmo1bkcyWEoy?=
 =?utf-8?B?K2lHNXFIQUdTZG5JNHRiQWhrWS8wc1lUYk5QazNIN04ySmNYY214Sm1xRCtG?=
 =?utf-8?B?THlYU3BQOEVVN2dKaW82NnNWWXRReGxueTczdHJBSGRyampGQVBXMU1wdllF?=
 =?utf-8?B?aFdlL3h2UGE4S1hCTDgwZGMrQnBOcFhmd09UcDA0VENSUklqREVJQzRnclll?=
 =?utf-8?B?ajJUUERqOXhXbDZUSFI4WnFMdVEwRHEzN2VjbURLcTVpRU1pSFVocjYydzlW?=
 =?utf-8?B?WTY1dksxaTRTTmhMdkNnTFlYTkJ3UG5HaEZzYzhRYkpHbVk1dTZ5TUhXM01N?=
 =?utf-8?B?THZjVEFDS0c4V0xkNzZvSGtKa0s1OGcycXBtSllLSmpITWF5S1dPbVpnRnFX?=
 =?utf-8?B?REdtRlhJVzFvRVdVd0pRWmsyYXgrSmR2M1BQeEVQR01RWExkbnc0TnUzU3B2?=
 =?utf-8?B?UHNXaHdHZWJGZVoweEtCOGwwNEtsc2NsZG5nMGhWMGw3Uk1tRFJBSHVGdkdV?=
 =?utf-8?B?UlRMaTNDdmhhY2w0NWdlU0kwSDdxdU9OQ1FLSXpJSFc3M0NkcUF1VWlMQmk2?=
 =?utf-8?B?Y0duQUdUSWJkWXVhN1dWY0c0NVJGM1NmQjdxN0RZYVFTUnlKWGVsUWgyVFNM?=
 =?utf-8?B?RmNRbE15eEFSVHM4OTRQSkRvTjNoVWZYZEoyeEVseFUwV1gvRk9OWGRDblht?=
 =?utf-8?B?bW9tUEdiUTRicDVOeTF3RHFvVUxSbWZCWGVUckNrSXAyT1dLUTZJWS9xaEVO?=
 =?utf-8?B?K1NzQ0k2WTJyUHJ4SGtRc0h3L3B5aXRoVFJTV1hGVVlwSjJJbVVpc242bzVs?=
 =?utf-8?B?Q2JhUFo5djlnc3kvcXlTWk5wTVFGakRycUNoMWQwWWl3enVtNEt0SkY4OXkx?=
 =?utf-8?B?UXpQazJqVm5mMnlSMHNmbTBRNm5PWjMrbnFLSTJxQlljekRRK0RnWEVpYUZO?=
 =?utf-8?B?R1E3cFVwamhnRk0ralVQU1pIdjhVVk5GeTJtRm9sYThnUkczL3FxYldDYXlM?=
 =?utf-8?B?RUZuZktzb0k3a0NQR3NuVGcyeHdrdGhQQkJxL0ZuOHU5OXJQdnhYcU4rdTJZ?=
 =?utf-8?B?eTBMTExqSU8vMVNCOXlQejhMa1gzRkdOYXVDQkpGNExaYUE5aWlXNjA2RUd4?=
 =?utf-8?B?MFBBbFNoemV4azBpWDRuNnlTcCtzNS9WeUhqWEN3WWFJandkcjlMSmgxcEZi?=
 =?utf-8?B?VFM3SndOSlhOalZWYXVKOHQrckZKcDEzYWE5UngzMXVQZXBYYmg1ZlBlSWNW?=
 =?utf-8?B?eGNKU3MrZmF3WEYwbzdZZGlXQWZIME1GWVFJZ0N0c2NqaWpES0FvTWxkaFlu?=
 =?utf-8?B?dFQzenBXdzhnVUE0YnRtNThvNE5ZcGcrVW5aNjZyMEVsd0MyU0VIbUJ4T0Uv?=
 =?utf-8?Q?B+t5nxIiIWnT/o0fapGn1KBDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5944fba4-a745-463f-27ce-08daef345f5b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:49:04.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi/qzrAV0Z6dzqVZrq12Y7U907jQXtMyOIV8WIS+YQfXUZhfrHkeuMmcNaHk5Xf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/23 18:28, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/22/2022 3:31 PM, Babu Moger wrote:
>> In an upcoming change rdt_get_mon_l3_config() needs to call
>> rdt_cpu_has() to query the monitor related features. It cannot be
>> called right now because rdt_cpu_has() has the __init attribute but
>> rdt_get_mon_l3_config() doesn't.
>>
>> Add the __init attribute to rdt_get_mon_l3_config() that is only called
>> by get_rdt_mon_resources() that already has the __init attribute. Also
>> make rdt_cpu_has() available to by rdt_get_mon_l3_config() via
>> the internal header file.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Thank you.
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank You

Babu

>
> Reinette

-- 
Thanks
Babu Moger

