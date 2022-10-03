Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD75F31F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJCO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJCO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:28:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EF52807;
        Mon,  3 Oct 2022 07:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T95IDMv/VmzKrbu3xNDshXvJx83dZIr1Y/2PXjteVhjXXftixoAvCWQSu1vWhGh/IhH8uYVG5NNqJydByUvmKq+3riLAkfrinkYeEAJUl35aReMFVmntsnTWiG5GJSNBai54JC58IPQNspFzXNHDZrq5fvZw5AVOByGGByl+awzwomHGHmcULatxdr3f3l32HuYzx0NjlWaezZz8IRMdjr1bSwBdHiGgBhxYq8wS00t/Tji8E+FgA7k9GU/mZXv7yuEuX7QNQGlGhplmW7GwcBPuAlDE7Atb+1vW87Al/UqWOr9Bqm0+zzEsrs7agVjaNej/6fDe8FaRIRHRAlivWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDbUc9GbN5CMGk9D8ysKx6OYPRUducorXfPhzI1ZJ50=;
 b=CWdMXXnrPsRDmu4JUm7XYGlW2DBfzKync1uv/RWXDlms35uOwkbhAwDq269Ao+3sB2p8VVAmTW1kgx4DXWe4RkB/3LDTqukVVcNYrXJVJA0HFel5t1PKPKLaMZ6tPkcjbIngDWzQlaAmNaiB1AYD/q2TSpRVjVdRLn4pL1CDxH4oAYvkVjfaD9bRcPGdxhvSQUBJJ4gIKxneF00GyzlKu8X2SRzniZvuRnmSxCJIoDj3hCRuQ3vJH7RzwC6mU7WzLyZr2GJfy/OdVuK5c6fP1vRi0R7WWeygATHAaWnlEn8hcZ99ZcdOuEY8g00HWNaSFcwPjb1PXuh6qjEnCI/OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDbUc9GbN5CMGk9D8ysKx6OYPRUducorXfPhzI1ZJ50=;
 b=iCIs1oDIzlSLNu+7YlsB26ceqMxyrf6Re87900xkeZfIjQ6RokAlQHVGbwOVA2lTXKwt2ScEk7HUF9n/OYSbjhYxnfY7prVO6yOY7ud00s5SNcjoqAZWQjEGSvJaVbFjhq3xOboKtkX8qrbWRhvhcyU4tMMVdR2SlYX8HyVtlLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Mon, 3 Oct 2022 14:28:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 14:28:23 +0000
Message-ID: <05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com>
Date:   Mon, 3 Oct 2022 09:28:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
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
        bagasdotme@gmail.com, eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:610:e7::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: b3417646-f9fb-41a5-3fd8-08daa54b86a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAWBWXbNTqa7S9cnA7T5pNF0qafHrX+tNGgvjw2NmGd28i5bZufxOP24AGmOkAiHqRaSkGXl2lt+Pz+nIy7H7qg3vxn2OQgWD+rIE6Avj/8icxaHfy9aEw6+S22dgaBpJ1nMEiykX7VKgO0+yGSty5M1fzTa0a5fxkEVZm9m9SgkMYoGtmkt89+LxmsbHMnVBducsbI1cI2eyoUWODVBSYlIoq0VtU9qIWrWzKTC1DkNpiWlQ6dtOr7Id9QU+lavzu5HfPJW8geegrzVG1qYGVjGld41pTUOovVrnQW+y6PKYhiiGGV9aleT5CrDWL0Cl3lV527tbg13VMf904XemFBl1/1vRxuLw+Rq8PZ8s6rF/XYS7yP8gvCYPWAAFEy9PXzmjB8NdaShvmUbS5jZJlMhZCS5o7L1k+621Vvaa0VpSB75w6quSidzHuIWEKlAkyZLHZdPVXqWWI1wGAFAOx2j8Lsns17WFnv85uUZdr+22pVA7IMjyverPwK1628yatGVHT1CHCM3q1S0fSOIHV6HXQCehXbDqWTTzlDz2SeWL3go61B6rKW8eMnPC0NyuLDpr3/J3YAvky+G/6wuzFzPgT7oIs5bYOlGiZ1MF/ejFEGak9cYzvNpQG5X30mgN5POh5rvMZ/qIDV07WiTQzkK0wne1/eLylQQC2gUG7vUoiv+qIMkw9O7s+GyyWX+samrPshUYcn9kaFZMQQuC8R3EX/xImlZeO8nKUow+rEFAi4FKhmGcN4KcpZryt+Xpono4Vl95P2RmAUuiyzH1X8ClZwg23GPWmiG0FLbjv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(31686004)(86362001)(66556008)(8676002)(5660300002)(36756003)(8936002)(2906002)(15650500001)(66946007)(7416002)(3450700001)(66476007)(41300700001)(4326008)(26005)(316002)(6666004)(31696002)(6512007)(6486002)(53546011)(2616005)(6506007)(478600001)(83380400001)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxLNkYwNjlLWFUyYUpTSTk2bjhwYU93WE0wSGxaNUJDYjFibW9YS09WYmtJ?=
 =?utf-8?B?M3dsdlNQSlhiQkNZZ1AxNUI0U1ZHTjFlT2EvM1J2YVJWV29Yckd4aktvU0dI?=
 =?utf-8?B?dGZZajJ1RFVoR1dSdEtKQytQcFE3ZTdFcUhwY3dCTHYvc2JCdUplVDNseXZI?=
 =?utf-8?B?bTR0MkY3eENUNXRRMzR3a2k4WnJuemNQaW5WOFBBcGMrM1UyQXR0NDVRMUFq?=
 =?utf-8?B?QjlJbGRlOE5tc2dyYSswdG5LR3Bic2NMRW9Eak1qRURLZC9EY3lGMkpjMUMv?=
 =?utf-8?B?N1ZPWDVVTUFGenRHVzFIcEtybklpUzUxTmVwWVdjUFFlRnE4bFhueTJaRmZG?=
 =?utf-8?B?K0xySVZqa1AybGlOUGQ4bGF4YTl5SWhjWGJZS2xoZUwveTUraEtZWUo5c0lL?=
 =?utf-8?B?d2tBY2ZsT2xCWjBUTkFjcWNmTUY2Y00wT3FjNEhyZEwrNWtJSDRzUExTd3lZ?=
 =?utf-8?B?WHdEWkI2Q29tU3FOMitVb0h3RVBMdjFNMit6Sy9zRFdRR0RlVHpiNVhUMFAy?=
 =?utf-8?B?bGd6TkVoYk1UM2w4VWU5eWN0djdYZzQ4Ty9pNG5PNjlqc0RFRXFHUklRdklR?=
 =?utf-8?B?TTlGYkJPSE5Qb2I1WmJIU2t5WjJoU0Q2NzNPOXIzbVJQUHdhM0hmYnpiNzJl?=
 =?utf-8?B?bWl6R0hNR3hJRmpYaTA2VE0vTGxacGt6RFg0V2t5czZ6NWlRQVFkMjErQnFJ?=
 =?utf-8?B?Y0lwbHRsZ01rUXBsNzdoRW1QYmpTQTM1QlBTbmJQcWYvNGVkWmJGMENhc2w3?=
 =?utf-8?B?M1grVkNSWmRtU3ZlTlJkdUhLSFVoTit1RnBlOUp4cm5WU0FtVjF3OU8vcnh0?=
 =?utf-8?B?UnI0Lys3YWxtNC92dTlJeHo5b3JmNkoxa29Sc1E4VmxhaWJwb3hscGhtVnM4?=
 =?utf-8?B?UXR5ZGplOElTcVcrTmFFUktROTZLTDZOUXFka05IWVhYVGJNa3JpdHZ3L3ZW?=
 =?utf-8?B?S2ZWcHpLcHV5OVhVK2wxUlo4Y09qaVZQYVEwaU5DSUJkZnZGczhMTml1WUEy?=
 =?utf-8?B?NVIzcElLbEVHYys3SFBGUXM1Mk9SNGhPNW1WRGRrcWIxUW1IWG1nV3ZuakJJ?=
 =?utf-8?B?aUhLaWcvWXZyT1dFamRyWlZjRmp3L3VScW4vQTFLVm5IVjR6SHZWUWJtQmF6?=
 =?utf-8?B?bEExTGFyK1hVTmt1Q0YzMm02azFaeTdEeXlxTXJSYUpCYTlFcW12SExLNkVj?=
 =?utf-8?B?TWxaVitnaWxmVFhmTnZPWFZzOEVCOVYyZDRKL0g1TDJuM01aaHIyV1VOQUtO?=
 =?utf-8?B?OG5JM3RGK3FpLzVLVDIvbEZXV0xxZXUrSm1HejRWVCtWdVlQVmVTWGFVZnp0?=
 =?utf-8?B?ZzhmNDJLWWpERGpveHM3MXBTZFJQWnVHTHpad2IzemZTcTVyekM4ak5qQmFX?=
 =?utf-8?B?T0N1ZE9MN2FnOGdTSkV6SkFaTi9mYndPd0k1SlQvVnVwdTN0OXliRVB4WjRP?=
 =?utf-8?B?LzRPOGZ1ZVU5cXB2Qi9tQ0xMa3VGUmNhWXlMRUlpOHVmSVdBK3A2S21RNkJU?=
 =?utf-8?B?a2E4dGowNmlzNnFIU1Z0Vlpja3hHTVZkTzVmZGFNeTNQK0Q2c2drMnVDR2Ri?=
 =?utf-8?B?SWhCa2FtaTdrL292K0tPZzVmcktLaVV3L05ZTUVSK09FUEFGV3ovVEJKREZY?=
 =?utf-8?B?OXU2QWlmdTRmeFFsR2NlTTVnTjJGY2Fscm1NSm40anVRbHlZSGI1MW1OVGNZ?=
 =?utf-8?B?cFZVWkJQYkVaeE9KaFhzYVN4RStxUFlxb0xTTzdzOGZpOXBxQStCSW11Z3ds?=
 =?utf-8?B?RzNXOTNvZGlJL3E1TnNLT202UW5yOUg1dHNKUW5HOFYzc3p1WUQ1a2Q1VWIz?=
 =?utf-8?B?UVB3SGQ5WEIwaGhJM2t2NkVlcFlrb2tJVDdBZUVBOFpxdW9GOGpGY0xLVk9D?=
 =?utf-8?B?N1JKK1RFRVhnRHpoTkpNeXJId0V5WWZML0NHd01iUzZLK1NnREQxOURHTkpl?=
 =?utf-8?B?RCtkYnJsWnlrL2VFSTJib2xIa1VJS3Z6QzlLY21ydDMvV2Rtc3pVUjdGRHVW?=
 =?utf-8?B?bURIUThIWUc2M05kNDFVcDhRNHpUSHA2a2trdDZvNXlQWDBkaGVYQksvT2Nr?=
 =?utf-8?B?UHR4M0tWVG0wRnE4ekRCRFhaREhNR1p3ZHdTY2l1KzZUY0FDSExRREdmRHRn?=
 =?utf-8?Q?e2x4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3417646-f9fb-41a5-3fd8-08daa54b86a4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 14:28:22.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJIbmunEg1oM9fFCBdZVzD3QOVfgQGn97kzK1YbtlOU5RdhJxODPIvB59yFfyD6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/29/22 17:10, Reinette Chatre wrote:
> Hi Babu,
>
> In subject: resctrl_ui.rst -> resctrl.rst
>
> On 9/27/2022 1:27 PM, Babu Moger wrote:
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
>>    enough to count all the different types are memory events. With the
> types are memory events -> types of memory events?
Ok Sure
>
>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>    and mbm_local_bytes to count the specific type of events.
>>
>> Also add configuration instructions with examples.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>
>> +
>> +"mbm_total_config", "mbm_local_config":
>> +        These files contain the current event configuration for the events
>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>> +        The event configuration settings are domain specific. Changing the
>> +        configuration on one CPU in a domain would affect the whole domain.
> This contradicts the implementation done in this series where the
> configuration is changed on every CPU in the domain.

How about this?

The event configuration settings are domain specific and will affect all the CPUs in the domain.

Thanks

Babu

